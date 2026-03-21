"""
num0ad.py — Python wrapper for num0ad C library with autograd
"""

import ctypes
import os
from pathlib import Path

_lib = None


def _load_lib():
    global _lib
    if _lib is not None:
        return _lib
    
    lib_dir = Path(__file__).parent
    lib_path = lib_dir / "libnum0ad.so"
    
    if not lib_path.exists():
        print(f"Building libnum0ad.so...")
        os.system(f"cd {lib_dir} && gcc -shared -fPIC -O2 -o libnum0ad.so num0ad.c -lm")
    
    _lib = ctypes.CDLL(str(lib_path))
    
    _lib.num0ad_create.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0ad_create.restype = ctypes.c_void_p
    
    _lib.num0ad_create_from_data.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_double)]
    _lib.num0ad_create_from_data.restype = ctypes.c_void_p
    
    _lib.num0ad_zeros.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0ad_zeros.restype = ctypes.c_void_p
    
    _lib.num0ad_ones.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0ad_ones.restype = ctypes.c_void_p
    
    _lib.num0ad_randn.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0ad_randn.restype = ctypes.c_void_p
    
    _lib.num0ad_arange.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_int]
    _lib.num0ad_arange.restype = ctypes.c_void_p
    
    _lib.num0ad_free.argtypes = [ctypes.c_void_p]
    
    _lib.num0ad_add.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0ad_add.restype = ctypes.c_void_p
    
    _lib.num0ad_sub.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0ad_sub.restype = ctypes.c_void_p
    
    _lib.num0ad_mul.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0ad_mul.restype = ctypes.c_void_p
    
    _lib.num0ad_div.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0ad_div.restype = ctypes.c_void_p
    
    _lib.num0ad_neg.argtypes = [ctypes.c_void_p]
    _lib.num0ad_neg.restype = ctypes.c_void_p
    
    _lib.num0ad_exp.argtypes = [ctypes.c_void_p]
    _lib.num0ad_exp.restype = ctypes.c_void_p
    
    _lib.num0ad_log.argtypes = [ctypes.c_void_p]
    _lib.num0ad_log.restype = ctypes.c_void_p
    
    _lib.num0ad_relu.argtypes = [ctypes.c_void_p]
    _lib.num0ad_relu.restype = ctypes.c_void_p
    
    _lib.num0ad_abs.argtypes = [ctypes.c_void_p]
    _lib.num0ad_abs.restype = ctypes.c_void_p
    
    _lib.num0ad_sqrt.argtypes = [ctypes.c_void_p]
    _lib.num0ad_sqrt.restype = ctypes.c_void_p
    
    _lib.num0ad_pow.argtypes = [ctypes.c_void_p, ctypes.c_double]
    _lib.num0ad_pow.restype = ctypes.c_void_p
    
    _lib.num0ad_sum.argtypes = [ctypes.c_void_p]
    _lib.num0ad_sum.restype = ctypes.c_void_p
    
    _lib.num0ad_mean.argtypes = [ctypes.c_void_p]
    _lib.num0ad_mean.restype = ctypes.c_void_p
    
    _lib.num0ad_matmul.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0ad_matmul.restype = ctypes.c_void_p
    
    _lib.num0ad_dot.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0ad_dot.restype = ctypes.c_void_p
    
    _lib.num0ad_reshape.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0ad_reshape.restype = ctypes.c_void_p
    
    _lib.num0ad_flatten.argtypes = [ctypes.c_void_p]
    _lib.num0ad_flatten.restype = ctypes.c_void_p
    
    _lib.num0ad_backward.argtypes = [ctypes.c_void_p]
    
    _lib.num0ad_zero_grad.argtypes = [ctypes.c_void_p]
    
    _lib.num0ad_total_size.argtypes = [ctypes.c_void_p]
    _lib.num0ad_total_size.restype = ctypes.c_int
    
    _lib.num0ad_maxval.argtypes = [ctypes.c_void_p]
    _lib.num0ad_maxval.restype = ctypes.c_double
    
    _lib.num0ad_argmax.argtypes = [ctypes.c_void_p]
    _lib.num0ad_argmax.restype = ctypes.c_int
    
    _lib.num0ad_max.argtypes = [ctypes.c_void_p]
    _lib.num0ad_max.restype = ctypes.c_void_p
    
    _lib.num0ad_scalar_add.argtypes = [ctypes.c_void_p, ctypes.c_double]
    _lib.num0ad_scalar_add.restype = ctypes.c_void_p
    
    _lib.num0ad_scalar_mul.argtypes = [ctypes.c_void_p, ctypes.c_double]
    _lib.num0ad_scalar_mul.restype = ctypes.c_void_p
    
    return _lib


def _to_c_arr(arr):
    if isinstance(arr, (list, tuple)):
        return (ctypes.c_double * len(arr))(*arr)
    elif hasattr(arr, 'ctypes'):
        return arr.astype(ctypes.c_double).ctypes.data_as(ctypes.POINTER(ctypes.c_double))
    return arr


def _to_shape(shape):
    if isinstance(shape, int):
        return (ctypes.c_int * 1)(shape)
    return (ctypes.c_int * len(shape))(*shape)


_NUM0AD_DATA_PTR_OFFSET = 0


def _ptr_to_array(ptr, ndim, shape, managed=True):
    size = 1
    for s in shape:
        size *= s
    data_ptr = ctypes.c_void_p.from_address(ptr + _NUM0AD_DATA_PTR_OFFSET).value
    buf = (ctypes.c_double * size).from_address(data_ptr)
    data = list(buf)
    
    grad_ptr = ctypes.c_void_p.from_address(ptr + 8).value
    buf_grad = (ctypes.c_double * size).from_address(grad_ptr)
    grad = list(buf_grad)
    
    result = Tensor(data, _ptr=ptr, _managed=managed)
    result._shape = list(shape)
    result._ndim = ndim
    result._grad = grad
    return result


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
            result = []
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
        return [result[i:i+self._shape[-1]] for i in range(0, len(result), self._shape[-1])]
    
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
