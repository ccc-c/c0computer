"""
torch0.py — PyTorch-like API using num0ad C library

Provides:
  class Tensor  — Wrapper around num0ad.Tensor with PyTorch-like API
  class Parameter — Trainable parameter
  class Module  — Neural network module base class
  zeros, ones, randn, arange, tensor — Factory functions
  matmul, dot, softmax, cross_entropy, mse_loss — Operations
"""

import numpy as np
import sys
import ctypes
sys.path.insert(0, './num0ad')
from num0ad import Tensor as _Tensor, _load_lib, _to_shape, _ptr_to_array, matmul as _matmul, dot as _dot


def tensor(data):
    """Create a tensor from Python list or scalar."""
    return Tensor(data)


def _call_c_zeros(ndim, shape_list):
    lib = _load_lib()
    ptr = lib.num0ad_zeros(ndim, _to_shape(shape_list))
    return _ptr_to_array(ptr, ndim, shape_list)

def _call_c_ones(ndim, shape_list):
    lib = _load_lib()
    ptr = lib.num0ad_ones(ndim, _to_shape(shape_list))
    return _ptr_to_array(ptr, ndim, shape_list)

def _call_c_randn(ndim, shape_list):
    lib = _load_lib()
    ptr = lib.num0ad_randn(ndim, _to_shape(shape_list))
    return _ptr_to_array(ptr, ndim, shape_list)

def zeros(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    shape_list = list(shape)
    return Tensor(_call_c_zeros(len(shape_list), shape_list))

def ones(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    shape_list = list(shape)
    return Tensor(_call_c_ones(len(shape_list), shape_list))

def randn(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    shape_list = list(shape)
    return Tensor(_call_c_randn(len(shape_list), shape_list))

def arange(start, stop=None, step=1):
    if stop is None:
        start, stop = 0, start
    from num0ad import arange as _arange
    return Tensor(_arange(start, stop, step))


def _ensure_tensor(x):
    """Convert to tensor if needed."""
    if isinstance(x, _Tensor):
        return x
    if isinstance(x, Tensor):
        return x
    if isinstance(x, Parameter):
        return x
    return tensor(x)


class _ReLU:
    def __init__(self, input_tensor):
        self.input = input_tensor
    
    def backward(self, grad_output):
        upstream_grad = np.array(grad_output._t._grad) if grad_output._t._grad else np.ones_like(np.array(grad_output._t._data))
        input_data = np.array(self.input._t._data)
        grad_input = upstream_grad * (input_data > 0)
        self.input._t._grad = grad_input.tolist()


class Tensor:
    """PyTorch-like wrapper around num0ad.Tensor."""
    
    def __init__(self, data=None, _ptr=None, _managed=True, _ctx=None):
        if data is None:
            data = [0.0]
        if isinstance(data, _Tensor):
            self._t = data
        elif isinstance(data, (list, tuple)):
            self._t = _Tensor(data)
        elif isinstance(data, (int, float)):
            self._t = _Tensor([float(data)])
        elif isinstance(data, np.ndarray):
            self._t = _Tensor(data.tolist())
        else:
            self._t = _Tensor(list(data))
        self._is_wrapper = True
        self._ctx = _ctx
    
    @property
    def t(self):
        return self._t
    
    def backward(self):
        self._t.backward()
        if self._ctx is not None and callable(getattr(self._ctx, 'backward', None)):
            self._ctx.backward(self)
        if hasattr(self, '_prev') and self._prev is not None:
            self._prev.backward()
    
    def zero_grad(self):
        self._t.zero_grad()
    
    def __add__(self, other):
        if isinstance(other, (int, float)):
            return Tensor(self._t + other)
        other = _ensure_tensor(other)
        return Tensor(self._t + other._t)
    
    def __radd__(self, other):
        if isinstance(other, (int, float)):
            return Tensor(self._t + other)
        return self.__add__(other)
    
    def __mul__(self, other):
        other = _ensure_tensor(other)
        return Tensor(self._t * other._t)
    
    def __rmul__(self, other):
        return self.__mul__(other)
    
    def __neg__(self):
        return Tensor(self._t * -1)
    
    def __sub__(self, other):
        other = _ensure_tensor(other)
        return Tensor(self._t - other._t)
    
    def __rsub__(self, other):
        other = _ensure_tensor(other)
        return Tensor(other._t - self._t)
    
    def __pow__(self, p):
        return Tensor(self._t ** p)
    
    def __truediv__(self, other):
        other = _ensure_tensor(other)
        return Tensor(self._t / other._t)
    
    def __rtruediv__(self, other):
        other = _ensure_tensor(other)
        return Tensor(other._t / self._t)
    
    def relu(self):
        result = Tensor(self._t.relu())
        result._ctx = _ReLU(self)
        return result
    
    def sigmoid(self):
        one = tensor([1.0])
        exp_neg = (-self).exp()
        return one / (one + exp_neg)
    
    def tanh(self):
        e = self.exp()
        e_neg = (-self).exp()
        return (e - e_neg) / (e + e_neg)
    
    def exp(self):
        return Tensor(self._t.exp())
    
    def log(self):
        return Tensor(self._t.log())
    
    def abs(self):
        return Tensor(self._t.abs())
    
    def sqrt(self):
        return Tensor(self._t.sqrt())
    
    def sum(self):
        return Tensor(self._t.sum())
    
    def mean(self):
        return Tensor(self._t.mean())
    
    def _flatten(self, data):
        """Recursively flatten nested lists."""
        if isinstance(data, list):
            result = []
            for item in data:
                result.extend(self._flatten(item))
            return result
        return [data]
    
    def _get_flat_data(self):
        """Get flattened data from tensor."""
        return self._flatten(self._t._data)
    
    def reshape(self, *shape):
        if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
            shape = shape[0]
        flat = self._get_flat_data()
        total = 1
        for s in shape:
            total *= s
        if total != len(flat):
            raise ValueError(f"cannot reshape {len(flat)} elements into {shape}")
        return Tensor(_Tensor(flat).reshape(*shape))
    
    def flatten(self, start_dim=0):
        total = 1
        for s in self.shape[start_dim:]:
            total *= s
        shape = list(self.shape[:start_dim]) + [total]
        return self.reshape(shape)
    
    @property
    def T(self):
        if len(self.shape) != 2:
            raise ValueError("T requires 2D tensor")
        return self.reshape(self.shape[1], self.shape[0])
    
    @property
    def data(self):
        return self._t.data
    
    @property
    def grad(self):
        return self._t.grad
    
    @property
    def shape(self):
        return self._t.shape
    
    @property
    def ndim(self):
        return self._t.ndim
    
    @property
    def item(self):
        return self._t.item()
    
    def numpy(self):
        return np.array(self._t.data)
    
    def __repr__(self):
        return f"Tensor({self.data})"


class Parameter:
    """Trainable parameter."""
    def __init__(self, data):
        if isinstance(data, _Tensor):
            self._t = data
        elif isinstance(data, (list, tuple)):
            self._t = _Tensor(data)
        elif isinstance(data, (int, float)):
            self._t = _Tensor([float(data)])
        elif isinstance(data, np.ndarray):
            self._t = _Tensor(data.tolist())
        else:
            self._t = _Tensor(list(data))
        self.requires_grad = True
    
    @property
    def data(self):
        return self._t.data
    
    @property
    def grad(self):
        return self._t.grad
    
    @property
    def shape(self):
        return self._t.shape
    
    @property
    def item(self):
        return self._t.item()
    
    def _set_data(self, new_data):
        """Set the underlying tensor data."""
        self._t = _Tensor(new_data)
    
    def backward(self):
        self._t.backward()
    
    def zero_grad(self):
        self._t.zero_grad()


def matmul(a, b):
    """Matrix multiplication."""
    return Tensor(_matmul(a._t, b._t))


def dot(a, b):
    """Dot product."""
    return Tensor(_dot(a._t, b._t))


def softmax(x, dim=-1):
    """Numerically stable softmax."""
    x_data = x._t.data if isinstance(x, Tensor) else x
    max_val = max(x_data) if isinstance(x_data, list) else float(x._t.max())
    shifted = [xi - max_val for xi in x_data] if isinstance(x_data, list) else list((x._t - max_val)._t.data)
    exps = [np.exp(xi) for xi in shifted]
    total = sum(exps)
    return Tensor([xi / total for xi in exps])


def cross_entropy(logits, target):
    """Cross entropy loss."""
    logits_data = logits.data if isinstance(logits, Tensor) else list(logits)
    max_val = max(logits_data)
    exps = [np.exp(xi - max_val) for xi in logits_data]
    total = sum(exps)
    log_total = np.log(total)
    target_idx = int(target) if isinstance(target, (int, np.integer)) else int(target.item if hasattr(target, 'item') else target)
    loss = log_total - (logits_data[target_idx] - max_val)
    return Tensor([loss])


def mse_loss(pred, target):
    """Mean squared error loss."""
    diff = pred - target
    diff_sq = diff * diff
    return diff_sq.mean()


def relu(x):
    return x.relu()


def sigmoid(x):
    return x.sigmoid()


class Module:
    """Base class for neural network modules."""
    def __init__(self):
        object.__setattr__(self, '_parameters', {})
        object.__setattr__(self, '_modules', {})
    
    def parameters(self):
        params = []
        for p in self._parameters.values():
            params.append(p)
        for m in self._modules.values():
            params.extend(m.parameters())
        return params
    
    def named_parameters(self):
        result = []
        for name, p in self._parameters.items():
            result.append((name, p))
        for name, m in self._modules.items():
            for sub_name, p in m.named_parameters():
                result.append((f"{name}.{sub_name}", p))
        return result
    
    def add_module(self, name, module):
        self._modules[name] = module
    
    def __setattr__(self, name, value):
        if '_parameters' in self.__dict__ and isinstance(value, Parameter):
            self._parameters[name] = value
        elif '_modules' in self.__dict__ and isinstance(value, Module):
            self._modules[name] = value
        object.__setattr__(self, name, value)
    
    def forward(self, x):
        raise NotImplementedError
    
    def __call__(self, x):
        return self.forward(x)
    
    def zero_grad(self):
        for p in self.parameters():
            p.zero_grad()


class Linear(Module):
    """Fully connected linear layer."""
    def __init__(self, in_features, out_features):
        super().__init__()
        self.weight = Parameter(randn(in_features, out_features)._t)
        self.bias = Parameter(zeros(1, out_features)._t)
        self.in_features = in_features
        self.out_features = out_features
    
    def forward(self, x):
        x_t = x._t if isinstance(x, Tensor) else _Tensor(x)
        if len(x_t.shape) == 1:
            x_t = x_t.reshape(1, x_t.shape[0])
            is_1d = True
        else:
            is_1d = False
        w_t = self.weight._t
        b_t = self.bias._t
        result = _matmul(x_t, w_t)
        result_data = result.data
        if isinstance(result_data[0], list):
            result_list = [[result_data[i][j] + b_t.data[0][j] for j in range(len(result_data[0]))] for i in range(len(result_data))]
        else:
            result_list = [result_data[i] + b_t.data[0][i] for i in range(len(result_data))]
        if is_1d:
            return Tensor(result_list[0])
        return Tensor(result_list)


class Sequential(Module):
    """Sequential container."""
    def __init__(self, *layers):
        super().__init__()
        for i, layer in enumerate(layers):
            self.add_module(str(i), layer)
    
    def forward(self, x):
        for layer in self._modules.values():
            x = layer(x)
        return x


class ReLU(Module):
    def forward(self, x):
        return x.relu()


class Sigmoid(Module):
    def forward(self, x):
        return x.sigmoid()


class Tanh(Module):
    def forward(self, x):
        return x.tanh()


class Flatten(Module):
    def __init__(self, start_dim=1):
        super().__init__()
        self.start_dim = start_dim
    
    def forward(self, x):
        return x.flatten(self.start_dim)


class Conv2d(Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride=1, padding=0):
        super().__init__()
        if isinstance(kernel_size, int):
            kernel_size = (kernel_size, kernel_size)
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.weight = Parameter(randn(out_channels, in_channels, *kernel_size)._t)
        self.bias = Parameter(zeros(1, out_channels)._t)
        self._weight_data = None
        self._bias_data = None
    
    def _get_weight_data(self):
        if self._weight_data is None:
            w = self.weight._t._data
            if isinstance(w, list) and len(w) > 0 and isinstance(w[0], list):
                self._weight_data = self._flatten(w)
            else:
                self._weight_data = w if isinstance(w, list) else [w]
        return self._weight_data
    
    def _get_bias_data(self):
        if self._bias_data is None:
            b = self.bias._t._data
            if isinstance(b, list) and len(b) > 0 and isinstance(b[0], list):
                self._bias_data = b[0]
            else:
                self._bias_data = b if isinstance(b, list) else [b]
        return self._bias_data
    
    def _flatten(self, data):
        if isinstance(data, list):
            result = []
            for item in data:
                result.extend(self._flatten(item))
            return result
        return [data]
    
    def forward(self, x):
        x_data = self._get_input_data(x)
        
        if self.padding > 0:
            pad_data = np.pad(x_data, 
                             [(0, 0), (0, 0), (self.padding, self.padding), (self.padding, self.padding)],
                             mode='constant')
        else:
            pad_data = np.array(x_data)
        
        kh, kw = self.kernel_size
        sh = self.stride if isinstance(self.stride, int) else self.stride[0]
        sw = self.stride if isinstance(self.stride, int) else self.stride[1]
        
        batch, channels, h, w = pad_data.shape
        out_h = (h - kh) // sh + 1
        out_w = (w - kw) // sw + 1
        
        w_data = np.array(self._get_weight_data()).reshape(self.out_channels, self.in_channels, kh, kw)
        b_data = np.array(self._get_bias_data())
        
        out = np.zeros((batch, self.out_channels, out_h, out_w))
        for b in range(batch):
            for oc in range(self.out_channels):
                for ic in range(channels):
                    for i in range(out_h):
                        for j in range(out_w):
                            window = pad_data[b, ic, i*sh:i*sh+kh, j*sw:j*sw+kw]
                            kernel = w_data[oc, ic]
                            out[b, oc, i, j] += np.sum(window * kernel)
                out[b, oc] += b_data[oc]
        
        return Tensor(out.tolist())
    
    def _get_input_data(self, x):
        if isinstance(x, Tensor):
            return np.array(x._t._data)
        elif isinstance(x, list):
            return np.array(self._flatten(x))
        return np.array(x)


class MaxPool2d(Module):
    def __init__(self, kernel_size, stride=None, padding=0):
        super().__init__()
        if isinstance(kernel_size, int):
            kernel_size = (kernel_size, kernel_size)
        self.kernel_size = kernel_size
        self.stride = stride if stride is not None else kernel_size
        self.padding = padding
    
    def _flatten(self, data):
        if isinstance(data, list):
            result = []
            for item in data:
                result.extend(self._flatten(item))
            return result
        return [data]
    
    def forward(self, x):
        if isinstance(x, Tensor):
            x_data = np.array(x._t._data)
        elif isinstance(x, list):
            x_data = np.array(self._flatten(x))
        else:
            x_data = np.array(x)
        
        kh, kw = self.kernel_size
        sh = self.stride if isinstance(self.stride, tuple) else self.stride
        sw = self.stride if isinstance(self.stride, tuple) else self.stride
        
        batch, channels, h, w = x_data.shape
        out_h = (h - kh) // sh + 1
        out_w = (w - kw) // sw + 1
        
        out = np.zeros((batch, channels, out_h, out_w))
        for b in range(batch):
            for c in range(channels):
                for i in range(out_h):
                    for j in range(out_w):
                        window = x_data[b, c, i*sh:i*sh+kh, j*sw:j*sw+kw]
                        out[b, c, i, j] = np.max(window)
        
        return Tensor(out.tolist())


class MSELoss:
    def __init__(self):
        pass
    
    def __call__(self, pred, target):
        return mse_loss(pred, target)


class CrossEntropyLoss:
    def __init__(self):
        pass
    
    def __call__(self, logits, target):
        return cross_entropy(logits, target)


def _param_to_numpy(p):
    """Convert Parameter data to numpy array."""
    if isinstance(p, Parameter):
        raw = p._t._data
        if isinstance(raw, np.ndarray):
            return raw.flatten()
        return np.array(_flatten_list(raw))
    return np.array(p.data)

def _param_grad_to_numpy(p):
    """Convert Parameter grad to numpy array."""
    if isinstance(p, Parameter):
        raw = p._t._grad
        if isinstance(raw, np.ndarray):
            return raw.flatten()
        return np.array(_flatten_list(raw))
    return np.array(p.grad)

def _flatten_list(data):
    """Flatten nested lists."""
    if isinstance(data, list):
        result = []
        for item in data:
            result.extend(_flatten_list(item))
        return result
    return [data]


class Adam:
    def __init__(self, params, lr=0.001, betas=(0.9, 0.999), eps=1e-8):
        self.params = list(params)
        self.lr = lr
        self.beta1, self.beta2 = betas
        self.eps = eps
        self.m = [np.zeros_like(_param_to_numpy(p)) for p in self.params]
        self.v = [np.zeros_like(_param_to_numpy(p)) for p in self.params]
        self.t = 0
    
    def step(self):
        self.t += 1
        for i, p in enumerate(self.params):
            grad = _param_grad_to_numpy(p)
            self.m[i] = self.beta1 * self.m[i] + (1 - self.beta1) * grad
            self.v[i] = self.beta2 * self.v[i] + (1 - self.beta2) * grad ** 2
            m_hat = self.m[i] / (1 - self.beta1 ** self.t)
            v_hat = self.v[i] / (1 - self.beta2 ** self.t)
            update = self.lr * m_hat / (np.sqrt(v_hat) + self.eps)
            data = _param_to_numpy(p)
            new_data = (data - update).tolist()
            p._set_data(new_data)
    
    def zero_grad(self):
        for p in self.params:
            p.zero_grad()


class SGD:
    def __init__(self, params, lr=0.01, momentum=0.9):
        self.params = list(params)
        self.lr = lr
        self.momentum = momentum
        self.velocity = [np.zeros_like(_param_to_numpy(p)) for p in self.params]
    
    def step(self):
        for i, p in enumerate(self.params):
            grad = _param_grad_to_numpy(p)
            self.velocity[i] = self.momentum * self.velocity[i] + self.lr * grad
            data = _param_to_numpy(p)
            new_data = (data - self.velocity[i]).tolist()
            p._set_data(new_data)
    
    def zero_grad(self):
        for p in self.params:
            p.zero_grad()
