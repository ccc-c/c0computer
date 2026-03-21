"""
num0.py — Python wrapper for num0 C library
"""

import ctypes
import numpy as np
import os
import sys
from pathlib import Path

_lib = None


def _load_lib():
    global _lib
    if _lib is not None:
        return _lib
    
    lib_dir = Path(__file__).parent
    lib_path = lib_dir / "libnum0.so"
    
    if not lib_path.exists():
        print(f"Building libnum0.so...")
        os.system(f"cd {lib_dir} && gcc -shared -fPIC -O2 -o libnum0.so num0.c -lm")
    
    _lib = ctypes.CDLL(str(lib_path))
    
    _lib.num0_create.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0_create.restype = ctypes.c_void_p
    
    _lib.num0_create_from_data.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_double)]
    _lib.num0_create_from_data.restype = ctypes.c_void_p
    
    _lib.num0_free.argtypes = [ctypes.c_void_p]
    
    _lib.num0_zeros_ptr.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0_zeros_ptr.restype = ctypes.c_void_p
    
    _lib.num0_ones_ptr.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0_ones_ptr.restype = ctypes.c_void_p
    
    _lib.num0_randn_ptr.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0_randn_ptr.restype = ctypes.c_void_p
    
    _lib.num0_create_ptr.argtypes = [ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_double)]
    _lib.num0_create_ptr.restype = ctypes.c_void_p
    
    _lib.num0_arange.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_int]
    _lib.num0_arange.restype = ctypes.c_void_p
    
    _lib.num0_add.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0_add.restype = ctypes.c_void_p
    
    _lib.num0_sub.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0_sub.restype = ctypes.c_void_p
    
    _lib.num0_mul.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0_mul.restype = ctypes.c_void_p
    
    _lib.num0_div.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0_div.restype = ctypes.c_void_p
    
    _lib.num0_neg.argtypes = [ctypes.c_void_p]
    _lib.num0_neg.restype = ctypes.c_void_p
    
    _lib.num0_exp.argtypes = [ctypes.c_void_p]
    _lib.num0_exp.restype = ctypes.c_void_p
    
    _lib.num0_log.argtypes = [ctypes.c_void_p]
    _lib.num0_log.restype = ctypes.c_void_p
    
    _lib.num0_relu.argtypes = [ctypes.c_void_p]
    _lib.num0_relu.restype = ctypes.c_void_p
    
    _lib.num0_abs.argtypes = [ctypes.c_void_p]
    _lib.num0_abs.restype = ctypes.c_void_p
    
    _lib.num0_sqrt.argtypes = [ctypes.c_void_p]
    _lib.num0_sqrt.restype = ctypes.c_void_p
    
    _lib.num0_pow.argtypes = [ctypes.c_void_p, ctypes.c_double]
    _lib.num0_pow.restype = ctypes.c_void_p
    
    _lib.num0_sum.argtypes = [ctypes.c_void_p]
    _lib.num0_sum.restype = ctypes.c_void_p
    
    _lib.num0_mean.argtypes = [ctypes.c_void_p]
    _lib.num0_mean.restype = ctypes.c_void_p
    
    _lib.num0_max.argtypes = [ctypes.c_void_p]
    _lib.num0_max.restype = ctypes.c_void_p
    
    _lib.num0_maximum.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0_maximum.restype = ctypes.c_void_p
    
    _lib.num0_matmul.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0_matmul.restype = ctypes.c_void_p
    
    _lib.num0_dot.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    _lib.num0_dot.restype = ctypes.c_void_p
    
    _lib.num0_reshape.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.POINTER(ctypes.c_int)]
    _lib.num0_reshape.restype = ctypes.c_void_p
    
    _lib.num0_flatten.argtypes = [ctypes.c_void_p]
    _lib.num0_flatten.restype = ctypes.c_void_p
    
    _lib.num0_transpose.argtypes = [ctypes.c_void_p]
    _lib.num0_transpose.restype = ctypes.c_void_p
    
    _lib.num0_slice.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_int]
    _lib.num0_slice.restype = ctypes.c_void_p
    
    _lib.num0_argmax.argtypes = [ctypes.c_void_p]
    _lib.num0_argmax.restype = ctypes.c_int
    
    _lib.num0_total_size.argtypes = [ctypes.c_void_p]
    _lib.num0_total_size.restype = ctypes.c_int
    
    return _lib


def _to_c_arr(arr):
    if isinstance(arr, np.ndarray):
        return arr.astype(np.float64).ctypes.data_as(ctypes.POINTER(ctypes.c_double))
    elif isinstance(arr, (list, tuple)):
        return (ctypes.c_double * len(arr))(*arr)
    elif isinstance(arr, Array):
        return arr._ptr
    return arr


def _to_shape(shape):
    if isinstance(shape, int):
        return (ctypes.c_int * 1)(shape)
    return (ctypes.c_int * len(shape))(*shape)


# Num0 struct layout: double* data (offset 0, 8 bytes), int ndim (offset 8, 4 bytes), padding, int* shape (offset 16, 8 bytes)
_NUM0_DATA_PTR_OFFSET = 0

def _ptr_to_array(ptr, ndim, shape, managed=True):
    size = 1
    for s in shape:
        size *= s
    # Read the data pointer from the Num0 struct
    data_ptr = ctypes.c_void_p.from_address(ptr + _NUM0_DATA_PTR_OFFSET).value
    buf = (ctypes.c_double * size).from_address(data_ptr)
    data = np.copy(np.array(buf, dtype=np.float64).reshape(shape))
    result = Array(data, _ptr=ptr, _managed=managed)
    return result


class Array:
    def __init__(self, data=None, _ptr=None, _managed=True):
        if data is None:
            data = np.array([])
        self.data = np.array(data, dtype=np.float64)
        self._managed = _managed
        self._ptr = _ptr
        self._shape = list(self.data.shape)
        self._ndim = self.data.ndim
    
    def _ensure_ptr(self):
        if self._ptr is None:
            lib = _load_lib()
            flat_data = self.data.flatten()
            self._ptr = lib.num0_create_ptr(
                self._ndim,
                _to_shape(self._shape),
                _to_c_arr(flat_data)
            )
        return self._ptr
    
    def __del__(self):
        if self._managed and self._ptr is not None:
            _load_lib().num0_free(self._ptr)
    
    def __add__(self, other):
        if isinstance(other, (int, float)):
            other = Array(other)
        ptr = _load_lib().num0_add(self._ensure_ptr(), other._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def __radd__(self, other):
        return self + other
    
    def __sub__(self, other):
        if isinstance(other, (int, float)):
            other = Array(other)
        ptr = _load_lib().num0_sub(self._ensure_ptr(), other._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def __rsub__(self, other):
        if isinstance(other, (int, float)):
            return Array(other) - self
        return self - other
    
    def __mul__(self, other):
        if isinstance(other, (int, float)):
            other = Array(other)
        ptr = _load_lib().num0_mul(self._ensure_ptr(), other._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def __rmul__(self, other):
        return self * other
    
    def __truediv__(self, other):
        if isinstance(other, (int, float)):
            other = Array(other)
        ptr = _load_lib().num0_div(self._ensure_ptr(), other._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def __neg__(self):
        ptr = _load_lib().num0_neg(self._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def exp(self):
        ptr = _load_lib().num0_exp(self._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def log(self):
        ptr = _load_lib().num0_log(self._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def relu(self):
        ptr = _load_lib().num0_relu(self._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def abs(self):
        ptr = _load_lib().num0_abs(self._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def sqrt(self):
        ptr = _load_lib().num0_sqrt(self._ensure_ptr())
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def __pow__(self, p):
        ptr = _load_lib().num0_pow(self._ensure_ptr(), float(p))
        return _ptr_to_array(ptr, self._ndim, self._shape)
    
    def sum(self):
        ptr = _load_lib().num0_sum(self._ensure_ptr())
        return _ptr_to_array(ptr, 1, [1])
    
    def mean(self):
        ptr = _load_lib().num0_mean(self._ensure_ptr())
        return _ptr_to_array(ptr, 1, [1])
    
    def max(self):
        ptr = _load_lib().num0_max(self._ensure_ptr())
        return _ptr_to_array(ptr, 1, [1])
    
    def argmax(self):
        return _load_lib().num0_argmax(self._ensure_ptr())
    
    def reshape(self, *shape):
        if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
            shape = shape[0]
        elif len(shape) == 1 and isinstance(shape[0], int):
            shape = [shape[0]]
        else:
            shape = list(shape)
        ptr = _load_lib().num0_reshape(self._ensure_ptr(), len(shape), _to_shape(shape))
        return _ptr_to_array(ptr, len(shape), shape)
    
    def flatten(self):
        ptr = _load_lib().num0_flatten(self._ensure_ptr())
        total = self.data.size
        return _ptr_to_array(ptr, 1, [total])
    
    def T(self):
        ptr = _load_lib().num0_transpose(self._ensure_ptr())
        return _ptr_to_array(ptr, 2, [self._shape[1], self._shape[0]])
    
    @property
    def shape(self):
        return tuple(self._shape)
    
    @property
    def ndim(self):
        return self._ndim
    
    @property
    def size(self):
        return self.data.size
    
    def __getitem__(self, key):
        return self.data[key]
    
    def __repr__(self):
        return f"Array({self.data})"
    
    def item(self):
        return self.data.item()


def zeros(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    ptr = _load_lib().num0_zeros_ptr(len(shape), _to_shape(list(shape)))
    return _ptr_to_array(ptr, len(shape), list(shape))


def ones(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    ptr = _load_lib().num0_ones_ptr(len(shape), _to_shape(list(shape)))
    return _ptr_to_array(ptr, len(shape), list(shape))


def randn(*shape):
    if len(shape) == 1 and isinstance(shape[0], (list, tuple)):
        shape = shape[0]
    ptr = _load_lib().num0_randn_ptr(len(shape), _to_shape(list(shape)))
    return _ptr_to_array(ptr, len(shape), list(shape))


def arange(start, stop=None, step=1):
    if stop is None:
        start, stop = 0, start
    ptr = _load_lib().num0_arange(start, stop, step)
    count = (stop - start + step - 1) // step
    return _ptr_to_array(ptr, 1, [count])


def matmul(a, b):
    ptr = _load_lib().num0_matmul(a._ensure_ptr(), b._ensure_ptr())
    out_shape = [a._shape[0], b._shape[1]]
    return _ptr_to_array(ptr, 2, out_shape)


def dot(a, b):
    ptr = _load_lib().num0_dot(a._ensure_ptr(), b._ensure_ptr())
    if a._ndim == 1 and b._ndim == 1:
        return _ptr_to_array(ptr, 1, [1])
    return _ptr_to_array(ptr, 2, [a._shape[0], b._shape[1]])


def maximum(a, b):
    if isinstance(a, (int, float)):
        a = Array(a)
    if isinstance(b, (int, float)):
        b = Array(b)
    ptr = _load_lib().num0_maximum(a._ensure_ptr(), b._ensure_ptr())
    return _ptr_to_array(ptr, a._ndim, a._shape)


def slice_arr(a, start, stop):
    ptr = _load_lib().num0_slice(a._ensure_ptr(), start, stop)
    return _ptr_to_array(ptr, 1, [stop - start])


def softmax(a):
    maxval = a.max().item()
    shifted = a - maxval
    exps = shifted.exp()
    total = exps.sum().item()
    return exps / total
