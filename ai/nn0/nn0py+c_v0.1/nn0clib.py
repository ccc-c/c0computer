"""
nn.py — 基於 nn0 的神經網路層與優化器 (PyTorch 風格)
"""
import math
import random
import ctypes
from nn0clib import _load_lib

class Tensor:
    def __init__(self, data=None, _ptr=None, _managed=True):
        if data is None:
            data = [0.0]
        if not isinstance(data, (list, tuple)):
            data = [float(data)]
        
        self._data = list(data)
        self._shape = self._infer_shape(data)
        self._ndim = len(self._shape)
        self._managed = _managed
        self._ptr = _ptr
        self._grad = [0.0] * len(data)
    
    def _infer_shape(self, data):
        if not isinstance(data, (list, tuple)):
            return [1]
        if len(data) == 0:
            return [0]
        if isinstance(data[0], (list, tuple)):
            inner_shape = self._infer_shape(data[0])
            return [len(data)] + inner_shape
        return [len(data)]
    
    def _flatten(self, data):
        """Recursively flatten nested lists to 1D."""
        if isinstance(data, (list, tuple)):
            result =[]
            for item in data:
                result.extend(self._flatten(item))
            return result
        return [data]
    
    def _ensure_ptr(self):
        if self._ptr is None:
            lib = _load_lib()
            flat_data = self._flatten(self._data)
            self._ptr = lib.num0ad_create_from_data(
                self._ndim,
                _to_shape(self._shape),
                _to_c_arr(flat_data)
            )
        return self._ptr
    
    def __del__(self):
        if self._managed and self._ptr is not None:
            _load_lib().num0ad_free(self._ptr)
    
    def __add__(self, other):
        if isinstance(other, (int, float)):
            ptr = _load_lib().num0ad_scalar_add(self._ensure_ptr(), float(other))
            result = _ptr_to_array(ptr, self._ndim, self._shape)
            result._managed = False
            return result
        elif isinstance(other, Tensor):
            ptr = _load_lib().num0ad_add(self._ensure_ptr(), other._ensure_ptr())
            result = _ptr_to_array(ptr, self._ndim, self._shape)
            result._managed = False
            return result
    
    def __radd__(self, other):
        return self + other
    
    def __sub__(self, other):
        if isinstance(other, (int, float)):
            ptr = _load_lib().num0ad_scalar_add(
                _load_lib().num0ad_scalar_mul(self._ensure_ptr(), -1.0),
                float(other)
            )
            result = _ptr_to_array(ptr, self._ndim, self._shape)
            result._managed = False
            return result
        elif isinstance(other, Tensor):
            ptr = _load_lib().num0ad_sub(self._ensure_ptr(), other._ensure_ptr())
            result = _ptr_to_array(ptr, self._ndim, self._shape)
            result._managed = False
            return result
    
    def __rsub__(self, other):
        if isinstance(other, (int, float)):
            ptr = _load_lib().num0ad_scalar_add(
                _load_lib().num0ad_scalar_mul(self._ensure_ptr(), -1.0),
                float(other)
            )
            return _ptr_to_array(ptr, self._ndim, self._shape)
        return self - other
    
    def __mul__(self, other):
        if isinstance(other, (int, float)):
            ptr = _load_lib().num0ad_scalar_mul(self._ensure_ptr(), float(other))
            result = _ptr_to_array(ptr, self._ndim, self._shape)
            result._managed = False
            return result
        elif isinstance(other, Tensor):
            ptr = _load_lib().num0ad_mul(self._ensure_ptr(), other._ensure_ptr())
            result = _ptr_to_array(ptr, self._ndim, self._shape)
            result._managed = False
            return result
    
    def __rmul__(self, other):
        return self * other
    
    def __truediv__(self, other):
        if isinstance(other, (int, float)):
            ptr = _load_lib().num0ad_scalar_mul(self._ensure_ptr(), 1.0 / float(other))
            result = _ptr_to_array(ptr, self._ndim, self._shape)
            result._managed = False
            return result
        elif isinstance(other, Tensor):
            ptr = _load_lib().num0ad_div(self._ensure_ptr(), other._ensure_ptr())
            result = _ptr_to_array(ptr, self._ndim, self._shape)
            result._managed = False
            return result
    
    def __neg__(self):
        ptr = _load_lib().num0ad_scalar_mul(self._ensure_ptr(), -1.0)
        result = _ptr_to_array(ptr, self._ndim, self._shape)
        result._managed = False
        return result
    
    def __pow__(self, p):
        ptr = _load_lib().num0ad_pow(self._ensure_ptr(), float(p))
        result = _ptr_to_array(ptr, self._ndim, self._shape)
        result._managed = False
        return result
    
    def exp(self):
        ptr = _load_lib().num0ad_exp(self._ensure_ptr())
        result = _ptr_to_array(ptr, self._ndim, self._shape)
        result._managed = False
        return result
    
    def log(self):
        ptr = _load_lib().num0ad_log(self._ensure_ptr())
        result = _ptr_to_array(ptr, self._ndim, self._shape)
        result._managed = False
        return result
    
    def relu(self):
        ptr = _load_lib().num0ad_relu(self._ensure_ptr())
        result = _ptr_to_array(ptr, self._ndim, self._shape)
        result._managed = False
        return result
    
    def abs(self):
        ptr = _load_lib().num0ad_abs(self._ensure_ptr())
        result = _ptr_to_array(ptr, self._ndim, self._shape)
        result._managed = False
        return result
    
    def sqrt(self):
        ptr = _load_lib().num0ad_sqrt(self._ensure_ptr())
        result = _ptr_to_array(ptr, self._ndim, self._shape)
        result._managed = False
        return result
    
    def sum(self):
        ptr = _load_lib().num0ad_sum(self._ensure_ptr())
        result = _ptr_to_array(ptr, 1, [1])
        result._managed = False
        return result
    
    def mean(self):
        ptr = _load_lib().num0ad_mean(self._ensure_ptr())
        result = _ptr_to_array(ptr, 1, [1])
        result._managed = False
        return result
    
    def max(self):
        ptr = _load_lib().num0ad_max(self._ensure_ptr())
        result = _ptr_to_array(ptr, 1, [1])
        result._managed = False
        return result
    
    def argmax(self):
        return _load_lib().num0ad_argmax(self._ensure_ptr())
    
    def backward(self):
        ptr = self._ensure_ptr()
        lib = _load_lib()
        lib.num0ad_backward(ptr)
        
        size = 1
        for s in self._shape:
            size *= s
        grad_ptr = ctypes.c_void_p.from_address(ptr + 8).value
        buf_grad = (ctypes.c_double * size).from_address(grad_ptr)
        self._grad = list(buf_grad)
    
    def zero_grad(self):
        _load_lib().num0ad_zero_grad(self._ensure_ptr())
        self._grad = [0.0] * len(self._data)
    
    def reshape(self, *shape):
        if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
            shape = shape[0]
        elif len(shape) == 1 and isinstance(shape[0], int):
            shape = [shape[0]]
        else:
            shape = list(shape)
        ptr = _load_lib().num0ad_reshape(self._ensure_ptr(), len(shape), _to_shape(shape))
        result = _ptr_to_array(ptr, len(shape), shape)
        result._managed = False
        return result
    
    def flatten(self):
        ptr = _load_lib().num0ad_flatten(self._ensure_ptr())
        total = 1
        for s in self._shape:
            total *= s
        result = _ptr_to_array(ptr, 1, [total])
        result._managed = False
        return result
    
    @property
    def data(self):
        size = 1
        for s in self._shape:
            size *= s
        ptr = self._ensure_ptr()
        data_ptr = ctypes.c_void_p.from_address(ptr).value
        buf = (ctypes.c_double * size).from_address(data_ptr)
        result = list(buf)
        if len(self._shape) == 1:
            return result
        return[result[i:i+self._shape[-1]] for i in range(0, len(result), self._shape[-1])]
    
    @property
    def grad(self):
        size = 1
        for s in self._shape:
            size *= s
        ptr = self._ensure_ptr()
        grad_ptr = ctypes.c_void_p.from_address(ptr + 8).value
        buf = (ctypes.c_double * size).from_address(grad_ptr)
        result = list(buf)
        if len(self._shape) == 1:
            return result
        return [result[i:i+self._shape[-1]] for i in range(0, len(result), self._shape[-1])]
    
    @property
    def shape(self):
        return tuple(self._shape)
    
    @property
    def ndim(self):
        return self._ndim
    
    def item(self):
        return self._data[0]
    
    def __repr__(self):
        return f"Tensor({self.data})"


def zeros(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    ptr = _load_lib().num0ad_zeros(len(shape), _to_shape(list(shape)))
    return _ptr_to_array(ptr, len(shape), list(shape))


def ones(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    ptr = _load_lib().num0ad_ones(len(shape), _to_shape(list(shape)))
    return _ptr_to_array(ptr, len(shape), list(shape))


def randn(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    ptr = _load_lib().num0ad_randn(len(shape), _to_shape(list(shape)))
    return _ptr_to_array(ptr, len(shape), list(shape))


def arange(start, stop=None, step=1):
    if stop is None:
        start, stop = 0, start
    ptr = _load_lib().num0ad_arange(start, stop, step)
    count = (stop - start + step - 1) // step
    return _ptr_to_array(ptr, 1, [count])


def matmul(a, b):
    ptr = _load_lib().num0ad_matmul(a._ensure_ptr(), b._ensure_ptr())
    out_shape = [a._shape[0], b._shape[1]]
    result = _ptr_to_array(ptr, 2, out_shape)
    result._managed = False
    return result


def dot(a, b):
    ptr = _load_lib().num0ad_dot(a._ensure_ptr(), b._ensure_ptr())
    result = _ptr_to_array(ptr, 1, [1])
    result._managed = False
    return result


def softmax(a):
    maxval = a.max().item()
    shifted = a - maxval
    exps = shifted.exp()
    total = exps.sum().item()
    return exps / total


def cross_entropy(preds, target):
    log_preds = preds.log()
    loss = -(log_preds * target).sum()
    return loss

class Module:
    """所有神經網路層的基底類別"""
    def __call__(self, *args, **kwargs):
        return self.forward(*args, **kwargs)

    def forward(self, *args, **kwargs):
        raise NotImplementedError

    def parameters(self):
        """自動遞迴尋找並收集網路中所有的權重張量"""
        params =[]
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
        # 初始化權重 (Xavier/Kaiming 風格的均勻分佈)
        stdv = 1.0 / math.sqrt(in_features)
        w_data = [[random.uniform(-stdv, stdv) for _ in range(out_features)] for _ in range(in_features)]
        b_data = [[random.uniform(-stdv, stdv) for _ in range(out_features)]]
        
        self.weight = Tensor(w_data)
        self.bias = Tensor(b_data)

    def forward(self, x):
        # 1. 矩陣相乘: out = x @ weight
        out = matmul(x, self.weight)
        
        # 2. 廣播 Bias (Broadcasting Workaround)
        # 因為底層 C 引擎不支援高維度廣播，我們利用 [B, 1] 的全 1 矩陣乘上 bias [1, Out]
        # 巧妙展開成[B, Out] 矩陣，然後相加
        B = x.shape[0]
        bias_broadcasted = matmul(ones(B, 1), self.bias)
        
        return out + bias_broadcasted

class ReLU(Module):
    """ReLU 激勵函數"""
    def forward(self, x):
        return x.relu()

class MSELoss(Module):
    """均方誤差損失函數"""
    def forward(self, pred, target):
        diff = pred - target
        squared = diff ** 2.0
        return squared.mean()

class SGD:
    """隨機梯度下降優化器"""
    def __init__(self, parameters, lr=0.01):
        self.parameters = parameters
        self.lr = lr

    def step(self):
        """利用 CTypes 直接修改 C 語言底層記憶體來更新權重"""
        for p in self.parameters:
            # 計算張量總大小
            size = 1
            for s in p.shape: 
                size *= s
            
            # 使用我們測試成功的方式：位移 0 是 data，位移 8 是 grad
            ptr = p._ensure_ptr()
            data_ptr = ctypes.c_void_p.from_address(ptr).value
            grad_ptr = ctypes.c_void_p.from_address(ptr + 8).value
            
            # 映射成 C 陣列
            c_data = (ctypes.c_double * size).from_address(data_ptr)
            c_grad = (ctypes.c_double * size).from_address(grad_ptr)
            
            # 執行梯度下降: W = W - lr * dW
            for i in range(size):
                c_data[i] -= self.lr * c_grad[i]

    def zero_grad(self):
        """清空梯度"""
        for p in self.parameters:
            p.zero_grad()