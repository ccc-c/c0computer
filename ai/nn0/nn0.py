"""
nn.py — 自動微分引擎 (Value) 與 Adam 優化器

提供：
  class Value  — 純 Python autograd 節點
  class Adam   — Adam optimizer
  linear()     — 矩陣乘法
  softmax()    — 數值穩定 softmax
  rmsnorm()    — RMS Normalization
"""

import math

class Value:
    """純 Python 的自動微分節點，支援反向傳播。"""
    __slots__ = ('data', 'grad', '_children', '_local_grads')

    def __init__(self, data, children=(), local_grads=()):
        self.data = data
        self.grad = 0
        self._children = children
        self._local_grads = local_grads

    def __add__(self, other):
        other = other if isinstance(other, Value) else Value(other)
        return Value(self.data + other.data, (self, other), (1, 1))

    def __mul__(self, other):
        other = other if isinstance(other, Value) else Value(other)
        return Value(self.data * other.data, (self, other), (other.data, self.data))

    def __pow__(self, other):
        return Value(self.data**other, (self,), (other * self.data**(other - 1),))

    def log(self):
        return Value(math.log(self.data), (self,), (1 / self.data,))

    def exp(self):
        return Value(math.exp(self.data), (self,), (math.exp(self.data),))

    def relu(self):
        return Value(max(0, self.data), (self,), (float(self.data > 0),))

    def __neg__(self):         return self * -1
    def __radd__(self, other): return self + other
    def __sub__(self, other):  return self + (-other)
    def __rsub__(self, other): return other + (-self)
    def __rmul__(self, other): return self * other
    def __truediv__(self, other):  return self * other**-1
    def __rtruediv__(self, other): return other * self**-1

    def backward(self):
        """反向傳播：計算所有參數的梯度。"""
        topo = []
        visited = set()
        def build_topo(v):
            if v not in visited:
                visited.add(v)
                for child in v._children:
                    build_topo(child)
                topo.append(v)
        build_topo(self)
        self.grad = 1
        for v in reversed(topo):
            for child, local_grad in zip(v._children, v._local_grads):
                child.grad += local_grad * v.grad

    def __repr__(self):
        return f"Value({self.data:.4f})"


class Adam:
    """Adam optimizer，支援 learning rate 線性衰減。"""

    def __init__(self, params, lr=0.01, beta1=0.85, beta2=0.99, eps=1e-8):
        self.params = params
        self.lr = lr
        self.beta1 = beta1
        self.beta2 = beta2
        self.eps = eps
        self.m = [0.0] * len(params)
        self.v = [0.0] * len(params)
        self.step_count = 0

    def step(self, lr_override=None):
        """執行一步參數更新，並清除梯度。"""
        self.step_count += 1
        lr = lr_override if lr_override is not None else self.lr
        for i, p in enumerate(self.params):
            self.m[i] = self.beta1 * self.m[i] + (1 - self.beta1) * p.grad
            self.v[i] = self.beta2 * self.v[i] + (1 - self.beta2) * p.grad ** 2
            m_hat = self.m[i] / (1 - self.beta1 ** self.step_count)
            v_hat = self.v[i] / (1 - self.beta2 ** self.step_count)
            p.data -= lr * m_hat / (v_hat ** 0.5 + self.eps)
            p.grad = 0


def linear(x, w):
    """矩陣乘法：y = W @ x"""
    return [sum(wi * xi for wi, xi in zip(wo, x)) for wo in w]


def softmax(logits):
    """數值穩定的 softmax。"""
    max_val = max(val.data for val in logits)
    exps = [(val - max_val).exp() for val in logits]
    total = sum(exps)
    return [e / total for e in exps]


def rmsnorm(x):
    """RMS Normalization（取代 LayerNorm）。"""
    ms = sum(xi * xi for xi in x) / len(x)
    scale = (ms + 1e-5) ** -0.5
    return [xi * scale for xi in x]


def gd(model, optimizer, tokens, step, num_steps):
    """
    一步梯度下降：forward → loss → backward → Adam update。
    回傳 loss 值。
    """
    n = min(model.block_size, len(tokens) - 1)
    keys   = [[] for _ in range(model.n_layer)]
    values = [[] for _ in range(model.n_layer)]

    losses = []
    for pos_id in range(n):
        token_id, target_id = tokens[pos_id], tokens[pos_id + 1]
        logits = model(token_id, pos_id, keys, values)
        probs = softmax(logits)
        loss_t = -probs[target_id].log()
        losses.append(loss_t)
    loss = (1 / n) * sum(losses)

    loss.backward()

    lr_t = optimizer.lr * (1 - step / num_steps)
    optimizer.step(lr_override=lr_t)

    return loss.data

def cross_entropy_simple(logits, target_idx):
    """
    直觀版本的 Cross-Entropy，依賴現有的 softmax 函式。
    """
    probs = softmax(logits)
    # 提取目標類別的機率，並取負對數
    return -probs[target_idx].log()

"""
真實的深度學習框架（如 PyTorch 的 F.cross_entropy）中，通常不會「先算 Softmax 機率，再算 Log」，
因為機率值如果逼近 0，再取 .log() 時非常容易引發數值錯誤（例如出現 -inf 或 NaN）。

框架會利用數學對數律展開公式：

$$-\log\left(\frac{e^{x_t}}{\sum e^{x_i}}\right) = \log\left(\sum e^{x_i}\right) - x_t$$

結合 softmax 原本避免溢位的 max_val 減法技巧（即 Log-Sum-Exp trick），
我們可以寫出更穩定、計算圖也更短的版本：
"""
def cross_entropy(logits, target_idx):
    """
    融合 Log-Softmax 與 NLLLoss 的數值穩定版本。
    計算公式： log(sum(exp(x_i - max))) - (x_target - max)
    """
    # 1. 找出最大值以確保數值穩定 (純量)
    max_val = max(val.data for val in logits)
    
    # 2. 計算所有元素的 exp(x_i - max)
    exps = [(val - max_val).exp() for val in logits]
    
    # 3. 計算分母的總和，並建立 log 節點
    log_sum_exp = sum(exps).log()
    
    # 4. 計算最終 Loss，直接避開了除法運算與極小機率的 log 運算
    target_logit_shifted = logits[target_idx] - max_val
    return log_sum_exp - target_logit_shifted
