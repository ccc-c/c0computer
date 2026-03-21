import ctypes
import sys
import os
import numpy as np

lib_name = 'nn0.dll' if sys.platform == 'win32' else 'libnn0.so'
lib_path = os.path.join(os.path.dirname(__file__), lib_name)
if not os.path.exists(lib_path):
    lib_path = f"./{lib_name}"

lib = ctypes.CDLL(lib_path)

class Value(ctypes.Structure):
    pass

Value._fields_ = [
    ("data", ctypes.c_double),
    ("grad", ctypes.c_double),
    ("child1", ctypes.POINTER(Value)),
    ("child2", ctypes.POINTER(Value)),
    ("local_grad1", ctypes.c_double),
    ("local_grad2", ctypes.c_double),
    ("visited", ctypes.c_int)
]

class CNN(ctypes.Structure):
    pass

class Conv2D(ctypes.Structure):
    pass

class MaxPool2D(ctypes.Structure):
    pass

class Linear(ctypes.Structure):
    pass

class Layer(ctypes.Structure):
    pass

Layer._fields_ = [
    ("type", ctypes.c_int),
    ("conv", ctypes.POINTER(Conv2D)),
    ("pool", ctypes.POINTER(MaxPool2D)),
    ("linear", ctypes.POINTER(Linear)),
]

CNN._fields_ = [
    ("num_layers", ctypes.c_int),
    ("layers", ctypes.POINTER(ctypes.POINTER(Layer))),
]

lib.init_nn.restype = None
lib.arena_reset.restype = None

lib.new_value.argtypes = [ctypes.c_double]
lib.new_value.restype = ctypes.POINTER(Value)

lib.new_param.argtypes = [ctypes.c_double]
lib.new_param.restype = ctypes.POINTER(Value)

lib.add.argtypes = [ctypes.POINTER(Value), ctypes.POINTER(Value)]
lib.add.restype = ctypes.POINTER(Value)

lib.mul.argtypes = [ctypes.POINTER(Value), ctypes.POINTER(Value)]
lib.mul.restype = ctypes.POINTER(Value)

lib.neg.argtypes = [ctypes.POINTER(Value)]
lib.neg.restype = ctypes.POINTER(Value)

lib.power.argtypes = [ctypes.POINTER(Value), ctypes.c_double]
lib.power.restype = ctypes.POINTER(Value)

lib.backward.argtypes = [ctypes.POINTER(Value)]
lib.backward.restype = None

lib.zero_grad.restype = None
lib.init_optimizer.restype = None

lib.step_adam.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_double]
lib.step_adam.restype = None

lib.init_cnn.argtypes = [ctypes.POINTER(CNN), ctypes.c_int]
lib.init_cnn.restype = None

lib.add_conv2d.argtypes = [ctypes.POINTER(CNN), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int]
lib.add_conv2d.restype = None

lib.add_maxpool2d.argtypes = [ctypes.POINTER(CNN), ctypes.c_int, ctypes.c_int]
lib.add_maxpool2d.restype = None

lib.add_flatten.argtypes = [ctypes.POINTER(CNN)]
lib.add_flatten.restype = None

lib.add_linear.argtypes = [ctypes.POINTER(CNN), ctypes.c_int, ctypes.c_int]
lib.add_linear.restype = None

lib.forward.argtypes = [ctypes.POINTER(CNN), ctypes.POINTER(ctypes.c_double), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int]
lib.forward.restype = ctypes.POINTER(Value)

lib.get_conv_out_size.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int]
lib.get_conv_out_size.restype = ctypes.c_int

lib.get_pool_out_size.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_int]
lib.get_pool_out_size.restype = ctypes.c_int

lib.save_cnn.argtypes = [ctypes.POINTER(CNN), ctypes.c_char_p]
lib.save_cnn.restype = None

lib.load_cnn.argtypes = [ctypes.POINTER(CNN), ctypes.c_char_p]
lib.load_cnn.restype = None

lib.free_cnn.argtypes = [ctypes.POINTER(CNN)]
lib.free_cnn.restype = None

lib.init_nn()
lib.arena_reset()

nn0 = lib
