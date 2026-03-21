import ctypes
import sys
import os

# 1. 載入編譯好的 C 共享函式庫
lib_name = 'nn0.dll' if sys.platform == 'win32' else 'libnn0.so'
lib_path = os.path.join(os.path.dirname(__file__), lib_name)

# 如果找不到檔案加上 ./ 尋找
if not os.path.exists(lib_path):
    lib_path = f"./{lib_name}"

lib = ctypes.CDLL(lib_path)

# 2. 宣告 C 語言中的 struct Value
class Value(ctypes.Structure):
    pass

Value._fields_ =[
        ("data", ctypes.c_double),
        ("grad", ctypes.c_double),
        ("child1", ctypes.POINTER(Value)),
        ("child2", ctypes.POINTER(Value)),
        ("local_grad1", ctypes.c_double),
        ("local_grad2", ctypes.c_double),
        ("visited", ctypes.c_int)
    ]

# 3. 定義 C 函式的參數型別 (argtypes) 與回傳型別 (restype)
lib.init_nn.restype = None
lib.arena_reset.restype = None

lib.new_value.argtypes = [ctypes.c_double]
lib.new_value.restype = ctypes.POINTER(Value)

lib.new_param.argtypes =[ctypes.c_double]
lib.new_param.restype = ctypes.POINTER(Value)

lib.add.argtypes = [ctypes.POINTER(Value), ctypes.POINTER(Value)]
lib.add.restype = ctypes.POINTER(Value)

lib.mul.argtypes =[ctypes.POINTER(Value), ctypes.POINTER(Value)]
lib.mul.restype = ctypes.POINTER(Value)

lib.neg.argtypes = [ctypes.POINTER(Value)]
lib.neg.restype = ctypes.POINTER(Value)

lib.power.argtypes =[ctypes.POINTER(Value), ctypes.c_double]
lib.power.restype = ctypes.POINTER(Value)

lib.backward.argtypes = [ctypes.POINTER(Value)]
lib.backward.restype = None

lib.zero_grad.restype = None
lib.init_optimizer.restype = None

lib.step_adam.argtypes =[ctypes.c_int, ctypes.c_int, ctypes.c_double]
lib.step_adam.restype = None

lib.init_nn()
lib.arena_reset()

nn0 = lib