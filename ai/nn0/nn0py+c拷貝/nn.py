"""
nn.py — 基於 nn0 的神經網路層與優化器 (PyTorch 風格)
"""
import math
import random
import ctypes
from nn0 import Tensor, matmul, ones


class Module:
    """所有神經網路層的基底類別"""
    def __call__(self, *args, **kwargs):
        return self.forward(*args, **kwargs)

    def forward(self, *args, **kwargs):
        raise NotImplementedError

    def parameters(self):
        """自動遞迴尋找並收集網路中所有的權重張量"""
        params = []
        for k, v in self.__dict__.items():
            if isinstance(v, Tensor):
                params.append(v)
            elif isinstance(v, Module):
                params.extend(v.parameters())
            elif isinstance(v, (list, tuple)):
                for item in v:
                    if isinstance(item, Module):
                        params.extend(item.parameters())
        return params


class Linear(Module):
    """全連接層 (Fully Connected Layer)"""
    def __init__(self, in_features, out_features):
        stdv = 1.0 / math.sqrt(in_features)
        w_data = [[random.uniform(-stdv, stdv) for _ in range(out_features)] for _ in range(in_features)]
        b_data = [[random.uniform(-stdv, stdv) for _ in range(out_features)]]
        
        self.weight = Tensor(w_data)
        self.bias = Tensor(b_data)

    def forward(self, x):
        out = matmul(x, self.weight)
        B = x.shape[0]
        bias_broadcasted = matmul(ones(B, 1), self.bias)
        return out + bias_broadcasted


class ReLU(Module):
    """ReLU 激勵函數"""
    def forward(self, x):
        return x.relu()


class Sigmoid(Module):
    """Sigmoid 激勵函數: σ(x) = 1 / (1 + exp(-x))"""
    def forward(self, x):
        exp_x = x.exp()
        return exp_x / (1.0 + exp_x)


class Tanh(Module):
    """Tanh 激勵函數: tanh(x) = (exp(x) - exp(-x)) / (exp(x) + exp(-x))"""
    def forward(self, x):
        exp_x = x.exp()
        exp_neg_x = (-x).exp()
        return (exp_x - exp_neg_x) / (exp_x + exp_neg_x)


class LeakyReLU(Module):
    """LeakyReLU 激勵函數: f(x) = x if x > 0 else α*x"""
    def __init__(self, alpha=0.01):
        super().__init__()
        self.alpha = alpha

    def forward(self, x):
        return x.relu() - self.alpha * ((-x).relu())


class Softmax(Module):
    """Softmax 激勵函數: softmax(x_i) = exp(x_i) / Σexp(x_j)"""
    def forward(self, x):
        maxval = x.max()
        shifted = x - maxval
        exp_shifted = shifted.exp()
        sum_exp = exp_shifted.sum()
        return exp_shifted / sum_exp


class MSELoss(Module):
    """均方誤差損失函數"""
    def forward(self, pred, target):
        diff = pred - target
        return (diff ** 2).mean()


class CrossEntropyLoss(Module):
    """交叉熵損失函數 (整合 Softmax + NLL)"""
    def forward(self, pred, target):
        softmax = Softmax()
        prob = softmax(pred)
        log_prob = (prob + 1e-8).log()
        loss = -(log_prob * target).sum()
        return loss


class BCELoss(Module):
    """二元交叉熵損失函數"""
    def forward(self, pred, target):
        eps = 1e-8
        pred_clipped = pred * (1 - 2 * eps) + eps
        loss = -(target * pred_clipped.log() + (1 - target) * (1 - pred_clipped).log())
        return loss.mean()


class L1Loss(Module):
    """L1 損失函數 (平均絕對誤差)"""
    def forward(self, pred, target):
        diff = pred - target
        return diff.abs().mean()


class SGD:
    """隨機梯度下降優化器"""
    def __init__(self, parameters, lr=0.01, momentum=0.0):
        self.parameters = parameters
        self.lr = lr
        self.momentum = momentum
        self.momentums = {}
        for p in parameters:
            size = 1
            for s in p.shape:
                size *= s
            self.momentums[id(p)] = [0.0] * size

    def step(self):
        for p in self.parameters:
            size = 1
            for s in p.shape:
                size *= s
            
            ptr = p._ensure_ptr()
            data_ptr = ctypes.c_void_p.from_address(ptr).value
            grad_ptr = ctypes.c_void_p.from_address(ptr + 8).value
            
            c_data = (ctypes.c_double * size).from_address(data_ptr)
            c_grad = (ctypes.c_double * size).from_address(grad_ptr)
            
            key = id(p)
            if self.momentum > 0:
                for i in range(size):
                    self.momentums[key][i] = self.momentum * self.momentums[key][i] + c_grad[i]
                    c_data[i] -= self.lr * self.momentums[key][i]
            else:
                for i in range(size):
                    c_data[i] -= self.lr * c_grad[i]

    def zero_grad(self):
        for p in self.parameters:
            p.zero_grad()


class Adam:
    """Adam 自適應學習率優化器"""
    def __init__(self, parameters, lr=0.001, betas=(0.9, 0.999), eps=1e-8):
        self.parameters = parameters
        self.lr = lr
        self.beta1, self.beta2 = betas
        self.eps = eps
        self.m = {}
        self.v = {}
        self.t = 0
        for p in parameters:
            size = 1
            for s in p.shape:
                size *= s
            self.m[id(p)] = [0.0] * size
            self.v[id(p)] = [0.0] * size

    def step(self):
        self.t += 1
        for p in self.parameters:
            size = 1
            for s in p.shape:
                size *= s
            
            ptr = p._ensure_ptr()
            data_ptr = ctypes.c_void_p.from_address(ptr).value
            grad_ptr = ctypes.c_void_p.from_address(ptr + 8).value
            
            c_data = (ctypes.c_double * size).from_address(data_ptr)
            c_grad = (ctypes.c_double * size).from_address(grad_ptr)
            
            key = id(p)
            lr_t = self.lr * math.sqrt(1 - self.beta2 ** self.t) / (1 - self.beta1 ** self.t)
            
            for i in range(size):
                self.m[key][i] = self.beta1 * self.m[key][i] + (1 - self.beta1) * c_grad[i]
                self.v[key][i] = self.beta2 * self.v[key][i] + (1 - self.beta2) * c_grad[i] ** 2
                c_data[i] -= lr_t * self.m[key][i] / (math.sqrt(self.v[key][i]) + self.eps)

    def zero_grad(self):
        for p in self.parameters:
            p.zero_grad()


_no_grad_mode = False

def no_grad():
    """上下文管理器，停用梯度計算"""
    return _NoGradContext()

class _NoGradContext:
    def __enter__(self):
        global _no_grad_mode
        self.prev = _no_grad_mode
        _no_grad_mode = True
        return self
    
    def __exit__(self, *args):
        global _no_grad_mode
        _no_grad_mode = self.prev
        return False


def manual_seed(seed):
    """設定亂數種子"""
    random.seed(seed)


def clone(tensor):
    """複製張量"""
    return Tensor(tensor.data, _managed=True)
