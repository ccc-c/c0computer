"""
gpt.py — GPT 模型與訓練 / 推理函式

提供：
  class Gpt    — GPT 模型（embedding + transformer layers + lm_head）
  gd()         — 一步梯度下降
  train()      — 訓練迴圈
  inference()  — 生成文字
"""

import os
import sys
import random

# 讓 import 能找到 nn.py（位於 ../nn/）
# sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'nn'))
from nn0 import Value, Adam, linear, softmax, rmsnorm, gd


class Gpt:
    """
    GPT 模型：embedding → transformer layers → lm_head。
    結構類似 GPT-2，但用 RMSNorm 取代 LayerNorm、ReLU 取代 GeLU、無 bias。
    """

    def __init__(self, vocab_size, n_embd=16, n_layer=1, n_head=4, block_size=16):
        self.vocab_size = vocab_size
        self.n_embd = n_embd
        self.n_layer = n_layer
        self.n_head = n_head
        self.block_size = block_size
        self.head_dim = n_embd // n_head

        self.state_dict = self._init_params()
        self.params = [p for mat in self.state_dict.values()
                       for row in mat for p in row]

    def _init_params(self, std=0.08):
        """隨機初始化所有權重矩陣。"""
        def matrix(nout, nin):
            return [[Value(random.gauss(0, std)) for _ in range(nin)]
                    for _ in range(nout)]

        sd = {
            'wte':     matrix(self.vocab_size, self.n_embd),
            'wpe':     matrix(self.block_size, self.n_embd),
            'lm_head': matrix(self.vocab_size, self.n_embd),
        }
        for i in range(self.n_layer):
            sd[f'layer{i}.attn_wq'] = matrix(self.n_embd, self.n_embd)
            sd[f'layer{i}.attn_wk'] = matrix(self.n_embd, self.n_embd)
            sd[f'layer{i}.attn_wv'] = matrix(self.n_embd, self.n_embd)
            sd[f'layer{i}.attn_wo'] = matrix(self.n_embd, self.n_embd)
            sd[f'layer{i}.mlp_fc1'] = matrix(4 * self.n_embd, self.n_embd)
            sd[f'layer{i}.mlp_fc2'] = matrix(self.n_embd, 4 * self.n_embd)
        return sd

    def forward(self, token_id, pos_id, keys, values):
        """單步前向傳播：給定一個 token 和位置，回傳 logits。"""
        sd = self.state_dict

        tok_emb = sd['wte'][token_id]
        pos_emb = sd['wpe'][pos_id]
        x = [t + p for t, p in zip(tok_emb, pos_emb)]
        x = rmsnorm(x)

        for li in range(self.n_layer):
            # --- Multi-head Attention ---
            x_residual = x
            x = rmsnorm(x)
            q = linear(x, sd[f'layer{li}.attn_wq'])
            k = linear(x, sd[f'layer{li}.attn_wk'])
            v = linear(x, sd[f'layer{li}.attn_wv'])
            keys[li].append(k)
            values[li].append(v)

            x_attn = []
            for h in range(self.n_head):
                hs = h * self.head_dim
                q_h = q[hs:hs + self.head_dim]
                k_h = [ki[hs:hs + self.head_dim] for ki in keys[li]]
                v_h = [vi[hs:hs + self.head_dim] for vi in values[li]]
                attn_logits = [
                    sum(q_h[j] * k_h[t][j] for j in range(self.head_dim)) / self.head_dim**0.5
                    for t in range(len(k_h))
                ]
                attn_weights = softmax(attn_logits)
                head_out = [
                    sum(attn_weights[t] * v_h[t][j] for t in range(len(v_h)))
                    for j in range(self.head_dim)
                ]
                x_attn.extend(head_out)

            x = linear(x_attn, sd[f'layer{li}.attn_wo'])
            x = [a + b for a, b in zip(x, x_residual)]

            # --- MLP ---
            x_residual = x
            x = rmsnorm(x)
            x = linear(x, sd[f'layer{li}.mlp_fc1'])
            x = [xi.relu() for xi in x]
            x = linear(x, sd[f'layer{li}.mlp_fc2'])
            x = [a + b for a, b in zip(x, x_residual)]

        logits = linear(x, sd['lm_head'])
        return logits

    def __call__(self, token_id, pos_id, keys, values):
        return self.forward(token_id, pos_id, keys, values)


def train(model, optimizer, docs, uchars, BOS, num_steps=1000):
    """訓練迴圈：對每個文件做一步梯度下降。"""
    print(f"Training for {num_steps} steps ...")
    for step in range(num_steps):
        doc = docs[step % len(docs)]
        tokens = [BOS] + [uchars.index(ch) for ch in doc] + [BOS]
        loss_val = gd(model, optimizer, tokens, step, num_steps)
        print(f"step {step+1:4d} / {num_steps:4d} | loss {loss_val:.4f}", end='\r')
    print()


def inference(model, uchars, BOS, num_samples=20, temperature=0.5):
    """生成文字：從 BOS 開始，逐 token 取樣直到再次產生 BOS。"""
    vocab_size = model.vocab_size
    print(f"--- inference ({num_samples} samples, temperature={temperature}) ---")
    for sample_idx in range(num_samples):
        keys   = [[] for _ in range(model.n_layer)]
        values = [[] for _ in range(model.n_layer)]
        token_id = BOS
        sample = []
        for pos_id in range(model.block_size):
            logits = model(token_id, pos_id, keys, values)
            probs = softmax([l / temperature for l in logits])
            token_id = random.choices(range(vocab_size),
                                      weights=[p.data for p in probs])[0]
            if token_id == BOS:
                break
            sample.append(uchars[token_id])
        print(f"sample {sample_idx+1:2d}: {''.join(sample)}")
