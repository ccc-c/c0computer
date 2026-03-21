"""
nn.py — 基於 nn0 的神經網路層與優化器 (PyTorch 風格)
"""
import math
import random
import ctypes
from nn0 import Tensor, matmul, ones, zeros


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


class Sequential(Module):
    """順序容器，按順序執行每個層"""
    def __init__(self, *layers):
        super().__init__()
        self.layers = list(layers)
    
    def forward(self, x):
        for layer in self.layers:
            x = layer(x)
        return x
    
    def parameters(self):
        params = []
        for layer in self.layers:
            params.extend(layer.parameters())
        return params


class ModuleList(Module):
    """模組列表容器"""
    def __init__(self, layers=None):
        super().__init__()
        self.layers = []
        if layers:
            for layer in layers:
                self.append(layer)
    
    def append(self, layer):
        self.layers.append(layer)
    
    def __getitem__(self, idx):
        return self.layers[idx]
    
    def __len__(self):
        return len(self.layers)
    
    def forward(self, x):
        for layer in self.layers:
            x = layer(x)
        return x
    
    def parameters(self):
        params = []
        for layer in self.layers:
            params.extend(layer.parameters())
        return params


class ModuleDict(Module):
    """模組字典容器"""
    def __init__(self, layers=None):
        super().__init__()
        self.layers = {}
        if layers:
            for key, layer in layers.items():
                self.layers[key] = layer
    
    def __getitem__(self, key):
        return self.layers[key]
    
    def __setitem__(self, key, layer):
        self.layers[key] = layer
    
    def __contains__(self, key):
        return key in self.layers
    
    def keys(self):
        return self.layers.keys()
    
    def values(self):
        return self.layers.values()
    
    def items(self):
        return self.layers.items()
    
    def forward(self, x):
        for layer in self.layers.values():
            x = layer(x)
        return x
    
    def parameters(self):
        params = []
        for layer in self.layers.values():
            params.extend(layer.parameters())
        return params


class Conv1d(Module):
    """1D 卷積層"""
    def __init__(self, in_channels, out_channels, kernel_size, stride=1, padding=0):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        
        stdv = 1.0 / math.sqrt(in_channels * kernel_size)
        w_data = [[[random.uniform(-stdv, stdv) for _ in range(kernel_size)] for _ in range(in_channels)] for _ in range(out_channels)]
        b_data = [[random.uniform(-stdv, stdv) for _ in range(out_channels)]]
        
        self.weight = Tensor(w_data)
        self.bias = Tensor(b_data)
    
    def forward(self, x):
        return x


class Conv2d(Module):
    """2D 卷積層"""
    def __init__(self, in_channels, out_channels, kernel_size, stride=1, padding=0):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size if isinstance(kernel_size, tuple) else (kernel_size, kernel_size)
        self.stride = stride if isinstance(stride, tuple) else (stride, stride)
        self.padding = padding if isinstance(padding, tuple) else (padding, padding)
        
        stdv = 1.0 / math.sqrt(in_channels * self.kernel_size[0] * self.kernel_size[1])
        w_data = [[[[random.uniform(-stdv, stdv) for _ in range(self.kernel_size[1])] for _ in range(self.kernel_size[0])] for _ in range(in_channels)] for _ in range(out_channels)]
        b_data = [[random.uniform(-stdv, stdv) for _ in range(out_channels)]]
        
        self.weight = Tensor(w_data)
        self.bias = Tensor(b_data)
    
    def forward(self, x):
        return x


class MaxPool1d(Module):
    """1D 最大池化層"""
    def __init__(self, kernel_size, stride=None):
        super().__init__()
        self.kernel_size = kernel_size
        self.stride = stride if stride else kernel_size
    
    def forward(self, x):
        return x


class MaxPool2d(Module):
    """2D 最大池化層"""
    def __init__(self, kernel_size, stride=None):
        super().__init__()
        self.kernel_size = kernel_size if isinstance(kernel_size, tuple) else (kernel_size, kernel_size)
        self.stride = stride if stride else self.kernel_size
    
    def forward(self, x):
        return x


class AvgPool2d(Module):
    """2D 平均池化層"""
    def __init__(self, kernel_size, stride=None):
        super().__init__()
        self.kernel_size = kernel_size if isinstance(kernel_size, tuple) else (kernel_size, kernel_size)
        self.stride = stride if stride else self.kernel_size
    
    def forward(self, x):
        return x


class BatchNorm1d(Module):
    """1D 批次正規化層"""
    def __init__(self, num_features, eps=1e-5, momentum=0.1):
        super().__init__()
        self.num_features = num_features
        self.eps = eps
        self.momentum = momentum
        self.running_mean = [0.0] * num_features
        self.running_var = [1.0] * num_features
        self.weight = Tensor([[1.0] * num_features])
        self.bias = Tensor([[0.0] * num_features])
    
    def forward(self, x):
        return x


class BatchNorm2d(Module):
    """2D 批次正規化層"""
    def __init__(self, num_features, eps=1e-5, momentum=0.1):
        super().__init__()
        self.num_features = num_features
        self.eps = eps
        self.momentum = momentum
        self.running_mean = [0.0] * num_features
        self.running_var = [1.0] * num_features
        self.weight = Tensor([[[1.0] * num_features]])
        self.bias = Tensor([[[0.0] * num_features]])
    
    def forward(self, x):
        return x


class LayerNorm(Module):
    """層正規化"""
    def __init__(self, normalized_shape, eps=1e-5):
        super().__init__()
        self.normalized_shape = normalized_shape
        self.eps = eps
        self.weight = Tensor([[1.0] * normalized_shape])
        self.bias = Tensor([[0.0] * normalized_shape])
    
    def forward(self, x):
        return x


def concatenate(tensors, axis=0):
    """拼接張量"""
    if axis == 0:
        return Tensor([t.data[0] for t in tensors])
    elif axis == 2:
        result = []
        for i in range(tensors[0].shape[0]):
            row = []
            for t in tensors:
                row.extend(t.data[i])
            result.append(row)
        return Tensor(result)
    return tensors[0]


class StepLR:
    """學習率階梯衰減"""
    def __init__(self, optimizer, step_size, gamma=0.1):
        self.optimizer = optimizer
        self.step_size = step_size
        self.gamma = gamma
        self.current_step = 0
    
    def step(self):
        self.current_step += 1
        if self.current_step % self.step_size == 0:
            self.optimizer.lr *= self.gamma
    
    def get_lr(self):
        return self.optimizer.lr


class CosineAnnealingLR:
    """餘弦退火學習率"""
    def __init__(self, optimizer, T_max, eta_min=0):
        self.optimizer = optimizer
        self.T_max = T_max
        self.eta_min = eta_min
        self.current_step = 0
    
    def step(self):
        self.current_step += 1
        lr = self.eta_min + (self.optimizer.lr - self.eta_min) * (1 + math.cos(math.pi * self.current_step / self.T_max)) / 2
        self.optimizer.lr = lr
    
    def get_lr(self):
        return self.optimizer.lr


class ReduceLROnPlateau:
    """監控指標衰減學習率"""
    def __init__(self, optimizer, mode='min', factor=0.1, patience=10, threshold=1e-4):
        self.optimizer = optimizer
        self.mode = mode
        self.factor = factor
        self.patience = patience
        self.threshold = threshold
        self.best = float('inf') if mode == 'min' else float('-inf')
        self.num_bad_steps = 0
    
    def step(self, metric):
        if self.mode == 'min':
            if metric < self.best - self.threshold:
                self.best = metric
                self.num_bad_steps = 0
            else:
                self.num_bad_steps += 1
        else:
            if metric > self.best + self.threshold:
                self.best = metric
                self.num_bad_steps = 0
            else:
                self.num_bad_steps += 1
        
        if self.num_bad_steps >= self.patience:
            self.optimizer.lr *= self.factor
            self.num_bad_steps = 0
    
    def get_lr(self):
        return self.optimizer.lr


class Dataset:
    """資料集抽象類別"""
    def __getitem__(self, index):
        raise NotImplementedError
    
    def __len__(self):
        raise NotImplementedError


class TensorDataset(Dataset):
    """基於張量的資料集"""
    def __init__(self, *tensors):
        self.tensors = tensors
    
    def __getitem__(self, index):
        return tuple(t.data[index] for t in self.tensors)
    
    def __len__(self):
        return self.tensors[0].shape[0]


class DataLoader:
    """資料載入器"""
    def __init__(self, dataset, batch_size=1, shuffle=False, num_workers=0):
        self.dataset = dataset
        self.batch_size = batch_size
        self.shuffle = shuffle
        self.num_workers = num_workers
        self.indices = list(range(len(dataset)))
        if shuffle:
            random.shuffle(self.indices)
    
    def __iter__(self):
        self.current = 0
        if self.shuffle:
            random.shuffle(self.indices)
        return self
    
    def __next__(self):
        if self.current >= len(self.indices):
            raise StopIteration
        
        batch_indices = self.indices[self.current:self.current + self.batch_size]
        batch = [self.dataset[i] for i in batch_indices]
        self.current += self.batch_size
        return batch
    
    def __len__(self):
        return (len(self.dataset) + self.batch_size - 1) // self.batch_size


def train(model, dataloader, criterion, optimizer, num_epochs, device=None):
    """通用訓練函數"""
    model.train()
    for epoch in range(num_epochs):
        total_loss = 0.0
        for batch in dataloader:
            optimizer.zero_grad()
            inputs, targets = batch
            if isinstance(inputs[0], list):
                inputs = Tensor([inputs])
                targets = Tensor([targets])
            outputs = model(inputs)
            loss = criterion(outputs, targets)
            loss.backward()
            optimizer.step()
            total_loss += loss.item()
        print(f"Epoch {epoch+1}/{num_epochs}, Loss: {total_loss/len(dataloader):.4f}")
    return model


def evaluate(model, dataloader, criterion, device=None):
    """評估函數"""
    model.eval()
    total_loss = 0.0
    correct = 0
    total = 0
    
    with no_grad():
        for batch in dataloader:
            inputs, targets = batch
            if isinstance(inputs[0], list):
                inputs = Tensor([inputs])
                targets = Tensor([targets])
            outputs = model(inputs)
            loss = criterion(outputs, targets)
            total_loss += loss.item()
            
            if hasattr(outputs, 'argmax'):
                _, predicted = outputs.argmax()
                total += targets.shape[0]
                correct += (predicted == targets).sum().item()
    
    avg_loss = total_loss / len(dataloader)
    accuracy = 100 * correct / total if total > 0 else 0
    return avg_loss, accuracy


def save(model, path):
    """儲存模型"""
    params = {}
    for i, p in enumerate(model.parameters()):
        params[f'param_{i}'] = p.data
    import json
    with open(path, 'w') as f:
        json.dump(params, f)


def load(model, path):
    """載入模型"""
    import json
    with open(path, 'r') as f:
        params = json.load(f)
    for i, p in enumerate(model.parameters()):
        p._data = params[f'param_{i}']
        p._ptr = None
