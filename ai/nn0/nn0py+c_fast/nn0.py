"""
nn0.py — NumPy 自動微分引擎 (Tensor) 與 Adam 優化器

提供：
  class Tensor — NumPy autograd 節點
  class Adam  — Adam optimizer
  linear()     — 矩陣乘法
  softmax()    — 數值穩定 softmax
  rmsnorm()    — RMS Normalization
"""

import numpy as np


class Tensor:
    """NumPy 的自動微分張量，支援反向傳播。"""
    __slots__ = ('data', 'grad', '_children', '_local_grads', '_ctx')

    def __init__(self, data, children=(), local_grads=(), ctx=None):
        self.data = np.array(data, dtype=np.float64)
        self.grad = np.zeros_like(self.data)
        self._children = children
        self._local_grads = local_grads
        self._ctx = ctx

    def backward(self):
        """反向傳播：計算所有參數的梯度。"""
        topo = []
        visited = set()
        def build_topo(v):
            if id(v) not in visited:
                visited.add(id(v))
                for child in v._children:
                    build_topo(child)
                topo.append(v)
        build_topo(self)
        self.grad = np.ones_like(self.data)
        for v in reversed(topo):
            for child, local_grad in zip(v._children, v._local_grads):
                if np.isscalar(local_grad):
                    child.grad += local_grad * v.grad
                else:
                    child.grad += local_grad * v.grad

    def __add__(self, other):
        other = other if isinstance(other, Tensor) else Tensor(other)
        return Tensor(self.data + other.data, (self, other), (1, 1))

    def __mul__(self, other):
        other = other if isinstance(other, Tensor) else Tensor(other)
        return Tensor(self.data * other.data, (self, other), (other.data, self.data))

    def __pow__(self, other):
        return Tensor(self.data**other, (self,), (other * self.data**(other - 1),))

    def log(self):
        return Tensor(np.log(self.data), (self,), (1 / self.data,))

    def exp(self):
        return Tensor(np.exp(self.data), (self,), (np.exp(self.data),))

    def relu(self):
        return Tensor(np.maximum(0, self.data), (self,), (self.data > 0,))

    def sum(self):
        return Tensor(np.sum(self.data), (self,), (np.ones_like(self.data),))

    def mean(self):
        n = np.size(self.data)
        return Tensor(np.mean(self.data), (self,), (np.full_like(self.data, 1/n),))

    def __neg__(self):         return self * -1
    def __radd__(self, other): return self + other
    def __sub__(self, other):  return self + (-other)
    def __rsub__(self, other): return other + (-self)
    def __rmul__(self, other): return self * other
    def __truediv__(self, other):  return self * other**-1
    def __rtruediv__(self, other): return other / self

    def __repr__(self):
        return f"Tensor({self.data})"

    @property
    def item(self):
        return self.data.item()


class Adam:
    """Adam optimizer，支援 learning rate 線性衰減。"""

    def __init__(self, params, lr=0.01, beta1=0.85, beta2=0.99, eps=1e-8):
        self.params = params
        self.lr = lr
        self.beta1 = beta1
        self.beta2 = beta2
        self.eps = eps
        self.m = [np.zeros_like(p.data) for p in params]
        self.v = [np.zeros_like(p.data) for p in params]
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
            p.data -= lr * m_hat / (np.sqrt(v_hat) + self.eps)
            p.grad = np.zeros_like(p.grad)


def linear(x, w):
    """矩陣乘法：y = W @ x"""
    x_data = x.data if isinstance(x, Tensor) else np.array(x)
    w_data = [wi.data if isinstance(wi, Tensor) else np.array(wi) for wi in w]
    result = np.dot(w_data, x_data)
    return Tensor(result, (x, w), (w_data, x_data))


def softmax(logits):
    """數值穩定的 softmax。"""
    logits_data = np.array([v.data if isinstance(v, Tensor) else v for v in logits])
    max_val = np.max(logits_data)
    exps = np.exp(logits_data - max_val)
    probs = exps / np.sum(exps)
    return [Tensor(p) for p in probs]


def rmsnorm(x):
    """RMS Normalization（取代 LayerNorm）。"""
    x_data = np.array([v.data if isinstance(v, Tensor) else v for v in x])
    ms = np.mean(x_data ** 2)
    scale = (ms + 1e-5) ** -0.5
    return [xi * scale for xi in x]


def cross_entropy(logits, target_id):
    """
    數值穩定的 Cross-Entropy Loss。
    直接接收 logits，避免先算 softmax 可能導致的 log(0) 錯誤。
    
    使用 Log-Sum-Exp 技巧：
    Loss = -log( e^{x_c} / sum(e^{x_i}) )
         = log(sum(e^{x_i - M})) - (x_c - M)  (其中 M 為 max(logits))
    """
    logits_data = np.array([v.data if isinstance(v, Tensor) else v for v in logits])
    max_val = np.max(logits_data)
    
    exps = np.exp(logits_data - max_val)
    total = np.sum(exps)
    
    return Tensor(np.log(total) - (logits_data[target_id] - max_val))


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
    if not isinstance(loss, Tensor):
        loss = Tensor(loss)

    loss.backward()

    lr_t = optimizer.lr * (1 - step / num_steps)
    optimizer.step(lr_override=lr_t)

    return loss.item
