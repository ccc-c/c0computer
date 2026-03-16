# /// script
# requires-python = ">=3.10"
# dependencies = ["mlx>=0.24"]
# ///
"""
microgpt ported to MLX — the same algorithm, now vectorized on Apple Silicon.

Original: https://gist.github.com/karpathy/8627fe009c40f57531cb18360106ce95
This version: mlx.core arrays, mlx.nn modules, mlx.optimizers.Adam
"""

import os
import random
import mlx.core as mx
import mlx.nn as nn
import mlx.optimizers as optim

random.seed(42)
mx.random.seed(42)

# --- Data ---
if not os.path.exists('input.txt'):
    import urllib.request
    names_url = 'https://raw.githubusercontent.com/karpathy/makemore/refs/heads/master/names.txt'
    urllib.request.urlretrieve(names_url, 'input.txt')
docs = [l.strip() for l in open('input.txt').read().strip().split('\n') if l.strip()]
random.shuffle(docs)
print(f"num docs: {len(docs)}")

# --- Tokenizer ---
uchars = sorted(set(''.join(docs)))
BOS = len(uchars)
vocab_size = len(uchars) + 1
print(f"vocab size: {vocab_size}")

# --- Hyperparameters (original: n_embd=16, n_layer=1) ---
# Increased per FAQ (https://karpathy.github.io/2026/02/12/microgpt/) for better names.
n_embd = 48
n_head = 4
n_layer = 2
block_size = 16
head_dim = n_embd // n_head

# --- Model ---
class GPT(nn.Module):
    def __init__(self):
        super().__init__()
        self.wte = nn.Embedding(vocab_size, n_embd)
        self.wpe = nn.Embedding(block_size, n_embd)
        self.norm_emb = nn.RMSNorm(n_embd)
        self.layers = [TransformerBlock() for _ in range(n_layer)]
        self.lm_head = nn.Linear(n_embd, vocab_size, bias=False)

    def __call__(self, token_ids, pos_ids):
        x = self.wte(token_ids) + self.wpe(pos_ids)  # (T, n_embd)
        x = self.norm_emb(x)
        mask = nn.MultiHeadAttention.create_additive_causal_mask(x.shape[0])
        for layer in self.layers:
            x = layer(x, mask)
        return self.lm_head(x)  # (T, vocab_size)

    def generate_next(self, token_id, pos_id, kv_cache):  # MLX addition: KV cache avoids recomputing prior positions
        x = self.wte(token_id) + self.wpe(pos_id)  # (1, n_embd)
        x = self.norm_emb(x)
        for i, layer in enumerate(self.layers):
            x, kv_cache[i] = layer.forward_one(x, kv_cache[i])
        return self.lm_head(x)  # (1, vocab_size)


class TransformerBlock(nn.Module):
    def __init__(self):
        super().__init__()
        self.attn_norm = nn.RMSNorm(n_embd)
        self.wq = nn.Linear(n_embd, n_embd, bias=False)
        self.wk = nn.Linear(n_embd, n_embd, bias=False)
        self.wv = nn.Linear(n_embd, n_embd, bias=False)
        self.wo = nn.Linear(n_embd, n_embd, bias=False)
        self.mlp_norm = nn.RMSNorm(n_embd)
        self.mlp_fc1 = nn.Linear(n_embd, 4 * n_embd, bias=False)
        self.mlp_fc2 = nn.Linear(4 * n_embd, n_embd, bias=False)

    def __call__(self, x, mask):
        # Multi-head attention
        residual = x
        x = self.attn_norm(x)
        q = self.wq(x).reshape(-1, n_head, head_dim)  # (T, n_head, head_dim)
        k = self.wk(x).reshape(-1, n_head, head_dim)
        v = self.wv(x).reshape(-1, n_head, head_dim)
        # (n_head, T, head_dim)
        q = q.transpose(1, 0, 2)
        k = k.transpose(1, 0, 2)
        v = v.transpose(1, 0, 2)
        scale = head_dim ** -0.5
        attn = (q @ k.transpose(0, 2, 1)) * scale  # (n_head, T, T)
        attn = attn + mask
        attn = mx.softmax(attn, axis=-1)
        out = (attn @ v).transpose(1, 0, 2).reshape(-1, n_embd)  # (T, n_embd)
        x = self.wo(out) + residual
        # MLP
        residual = x
        x = self.mlp_norm(x)
        x = self.mlp_fc2(nn.relu(self.mlp_fc1(x)))
        return x + residual

    def forward_one(self, x, kv):
        residual = x
        x = self.attn_norm(x)
        q = self.wq(x).reshape(1, n_head, head_dim)
        k = self.wk(x).reshape(1, n_head, head_dim)
        v = self.wv(x).reshape(1, n_head, head_dim)
        if kv is None:
            keys, vals = k, v
        else:
            keys = mx.concatenate([kv[0], k], axis=0)
            vals = mx.concatenate([kv[1], v], axis=0)
        kv = (keys, vals)
        # q: (1, n_head, head_dim), keys: (S, n_head, head_dim)
        q = q.transpose(1, 0, 2)       # (n_head, 1, head_dim)
        kt = keys.transpose(1, 2, 0)   # (n_head, head_dim, S)
        vt = vals.transpose(1, 0, 2)   # (n_head, S, head_dim)
        scale = head_dim ** -0.5
        attn = (q @ kt) * scale        # (n_head, 1, S)
        attn = mx.softmax(attn, axis=-1)
        out = (attn @ vt).transpose(1, 0, 2).reshape(1, n_embd)  # (1, n_embd)
        x = self.wo(out) + residual
        residual = x
        x = self.mlp_norm(x)
        x = self.mlp_fc2(nn.relu(self.mlp_fc1(x)))
        return x + residual, kv


model = GPT()
mx.eval(model.parameters())
num_params = sum(v.size for _, v in nn.utils.tree_flatten(model.trainable_parameters()))
print(f"num params: {num_params}")

# --- Training ---
def loss_fn(model, token_ids, pos_ids, targets):
    logits = model(token_ids, pos_ids)  # (T, vocab_size)
    return mx.mean(nn.losses.cross_entropy(logits, targets))

loss_and_grad_fn = nn.value_and_grad(model, loss_fn)

learning_rate = 0.01
num_steps = 5000  # original: 1000, MLX is fast enough to benefit from more steps
optimizer = optim.Adam(learning_rate=learning_rate, betas=[0.85, 0.99], eps=1e-8)

for step in range(num_steps):
    doc = docs[step % len(docs)]
    tokens = [BOS] + [uchars.index(ch) for ch in doc] + [BOS]
    n = min(block_size, len(tokens) - 1)

    token_ids = mx.array(tokens[:n])
    pos_ids = mx.array(list(range(n)))
    targets = mx.array(tokens[1:n+1])

    loss, grads = loss_and_grad_fn(model, token_ids, pos_ids, targets)
    lr_t = learning_rate * (1 - step / num_steps)
    optimizer.learning_rate = mx.array(lr_t)
    optimizer.update(model, grads)
    mx.eval(model.parameters(), optimizer.state)

    if (step + 1) % 100 == 0 or step == 0:  # original prints every step, too noisy at 5000
        print(f"step {step+1:5d} / {num_steps:5d} | loss {loss.item():.4f}")

# --- Inference ---
temperature = 0.5
print("\n--- inference (new, hallucinated names) ---")
for sample_idx in range(20):
    kv_cache = [None] * n_layer
    token_id = mx.array([BOS])
    sample = []
    for pos_id in range(block_size):
        logits = model.generate_next(token_id, mx.array([pos_id]), kv_cache)
        logits = logits.squeeze(0) / temperature
        probs = mx.softmax(logits, axis=-1)
        token_id_int = mx.random.categorical(mx.log(probs)).item()
        if token_id_int == BOS:
            break
        sample.append(uchars[token_id_int])
        token_id = mx.array([token_id_int])
    print(f"sample {sample_idx+1:2d}: {''.join(sample)}")
