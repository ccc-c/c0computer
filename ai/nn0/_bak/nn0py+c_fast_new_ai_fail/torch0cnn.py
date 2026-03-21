"""
torch0cnn.py — 基於 torch0 (num0ad) 的卷積神經網路

提供：
  class Conv2d      — 2D 卷積層
  class MaxPool2d   — 2D 最大池化層
  class Flatten     — 展平層
  class SimpleCNN   — 簡單 CNN 模型
"""

import numpy as np
from torch0 import Tensor, Parameter, Module, Adam, relu, Sequential


def _flatten_data(data):
    """Flatten nested lists/numpy arrays to 1D."""
    if isinstance(data, (list, tuple)):
        result = []
        for item in data:
            result.extend(_flatten_data(item))
        return result
    elif isinstance(data, np.ndarray):
        return data.flatten().tolist()
    return [float(data)]


def _to_numpy(data):
    """Convert tensor-like data to numpy array."""
    if isinstance(data, Tensor):
        shape = data._t.shape
        raw = data._t._data
        if isinstance(raw, np.ndarray):
            flat = raw.flatten()
        else:
            flat = np.array(_flatten_data(raw))
        return flat.reshape(shape)
    elif isinstance(data, Parameter):
        shape = data._t.shape
        raw = data._t._data
        if isinstance(raw, np.ndarray):
            flat = raw.flatten()
        else:
            flat = np.array(_flatten_data(raw))
        return flat.reshape(shape)
    elif isinstance(data, np.ndarray):
        return data
    else:
        return np.array(data)


def im2col(x, kernel_size, stride, pad):
    N, C, H, W = x.shape
    kH, kW = kernel_size
    sH, sW = stride if isinstance(stride, tuple) else (stride, stride)
    
    H_pad, W_pad = H + 2 * pad, W + 2 * pad
    x_padded = np.pad(x, ((0, 0), (0, 0), (pad, pad), (pad, pad)), mode='constant')
    
    out_H = (H_pad - kH) // sH + 1
    out_W = (W_pad - kW) // sW + 1
    
    cols = np.zeros((N * out_H * out_W, C * kH * kW))
    
    for n in range(N):
        for i in range(out_H):
            for j in range(out_W):
                row_idx = n * out_H * out_W + i * out_W + j
                h_start = i * sH
                w_start = j * sW
                cols[row_idx] = x_padded[n, :, h_start:h_start+kH, w_start:w_start+kW].flatten()
    
    return cols, (N, out_H, out_W, C, kH, kW)


def col2im(grad_cols, N, out_H, out_W, C, kH, kW, H, W, stride, pad):
    sH, sW = stride if isinstance(stride, tuple) else (stride, stride)
    grad_x = np.zeros((N, C, H + 2 * pad, W + 2 * pad))
    
    idx = 0
    for n in range(N):
        for i in range(out_H):
            for j in range(out_W):
                h_start = i * sH
                w_start = j * sW
                grad_x[n, :, h_start:h_start+kH, w_start:w_start+kW] += grad_cols[idx].reshape(C, kH, kW)
                idx += 1
    
    if pad > 0:
        grad_x = grad_x[:, :, pad:-pad, pad:-pad] if H > pad else grad_x
    
    return grad_x


class Linear(Module):
    """全連接層"""
    
    def __init__(self, in_features, out_features):
        super().__init__()
        self.in_features = in_features
        self.out_features = out_features
        scale = np.sqrt(2.0 / in_features)
        self.weight = Parameter(np.random.randn(out_features, in_features) * scale)
        self.bias = Parameter(np.zeros(out_features))
    
    def forward(self, x):
        x_data = _to_numpy(x)
        if x_data.ndim == 1:
            x_data = x_data.reshape(1, -1)
        
        w_raw = self.weight._t._data
        if isinstance(w_raw, np.ndarray):
            w_data = w_raw.reshape(self.out_features, -1)
        else:
            w_data = np.array(_flatten_data(w_raw)).reshape(self.out_features, -1)
        
        b_raw = self.bias._t._data
        if isinstance(b_raw, np.ndarray):
            b_data = b_raw.flatten()
        else:
            b_data = np.array(_flatten_data(b_raw))
        
        out = x_data @ w_data.T + b_data
        
        result = Tensor(out.tolist(), _ctx=self)
        result._cached = {'x_data': x_data, 'w_data': w_data}
        return result
    
    def backward(self, grad_output):
        upstream_grad = np.array(grad_output._t._grad) if grad_output._t._grad else np.ones_like(np.array(grad_output._t._data))
        x_data = grad_output._cached['x_data']
        w_data = grad_output._cached['w_data']
        
        grad_x = upstream_grad @ w_data
        grad_w = upstream_grad.T @ x_data
        grad_b = upstream_grad.sum(axis=0)
        
        existing_w = self.weight._t._grad
        if existing_w is None or len(_flatten_data(existing_w)) != np.prod(self.weight.shape):
            self.weight._t._grad = grad_w.tolist()
        else:
            existing = np.array(_flatten_data(existing_w))
            self.weight._t._grad = (existing + grad_w.flatten()).tolist()
        
        existing_b = self.bias._t._grad
        if existing_b is None or len(_flatten_data(existing_b)) != np.prod(self.bias.shape):
            self.bias._t._grad = grad_b.tolist()
        else:
            existing = np.array(_flatten_data(existing_b))
            self.bias._t._grad = (existing + grad_b).tolist()
        
        if grad_output._prev is not None:
            grad_output._prev._t._grad = grad_x.tolist()


def _to_nested_list(arr, shape):
    """Convert flat/numpy array to nested list with given shape."""
    if isinstance(arr, np.ndarray):
        arr = arr.flatten()
    result = []
    idx = 0
    for s in shape:
        if len(result) == 0:
            result = [[] for _ in range(s)]
            for i in range(s):
                result[i] = arr[idx:idx + np.prod(shape[1:] if len(shape) > 1 else ())].tolist()
                idx += np.prod(shape[1:] if len(shape) > 1 else ())
    return result


class Conv2d(Module):
    """2D 卷積層"""
    
    def __init__(self, in_channels, out_channels, kernel_size, stride=1, pad=0):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size if isinstance(kernel_size, tuple) else (kernel_size, kernel_size)
        self.stride = stride if isinstance(stride, tuple) else (stride, stride)
        self.pad = pad
        
        scale = np.sqrt(2.0 / (in_channels * self.kernel_size[0] * self.kernel_size[1]))
        self.weight = Parameter(np.random.randn(out_channels, in_channels, *self.kernel_size) * scale)
        self.bias = Parameter(np.zeros(out_channels))
    
    def forward(self, x):
        x_data = _to_numpy(x)
        N, C, H, W = x_data.shape
        
        kH, kW = self.kernel_size
        sH, sW = self.stride
        
        out_H = (H + 2 * self.pad - kH) // sH + 1
        out_W = (W + 2 * self.pad - kW) // sW + 1
        
        cols, info = im2col(x_data, self.kernel_size, self.stride, self.pad)
        
        w_raw = self.weight._t._data
        if isinstance(w_raw, np.ndarray):
            w_data = w_raw.flatten().reshape(self.out_channels, -1)
        else:
            w_data = np.array(_flatten_data(w_raw)).reshape(self.out_channels, -1)
        
        out_flat = w_data @ cols.T
        
        b_raw = self.bias._t._data
        if isinstance(b_raw, np.ndarray):
            b_data = b_raw.flatten()
        else:
            b_data = np.array(_flatten_data(b_raw))
        
        out_flat = out_flat + b_data.reshape(-1, 1)
        
        out = out_flat.reshape(self.out_channels, N, out_H, out_W).transpose(1, 0, 2, 3)
        
        result = Tensor(out.tolist(), _ctx=self)
        result._cached = {'cols': cols, 'w_data': w_data, 'H': H, 'W': W, 'N': N}
        return result
    
    def backward(self, grad_output):
        upstream_grad = np.array(grad_output._t._grad) if grad_output._t._grad else np.ones_like(np.array(grad_output._t._data))
        cols = grad_output._cached['cols']
        w_data = grad_output._cached['w_data']
        H, W = grad_output._cached['H'], grad_output._cached['W']
        N = grad_output._cached['N']
        
        kH, kW = self.kernel_size
        out_H = upstream_grad.shape[2]
        out_W = upstream_grad.shape[3]
        
        grad_output_flat = upstream_grad.transpose(1, 2, 3, 0).reshape(self.out_channels, -1)
        
        grad_w = (grad_output_flat @ cols).reshape(self.out_channels, self.in_channels, kH, kW)
        grad_b = grad_output_flat.sum(axis=1)
        
        grad_cols = w_data.T @ grad_output_flat
        grad_x = col2im(grad_cols.T, N, out_H, out_W, self.in_channels, kH, kW, 
                        H, W, self.stride, self.pad)
        
        existing_w = self.weight._t._grad
        if existing_w is None or len(_flatten_data(existing_w)) != np.prod(self.weight.shape):
            self.weight._t._grad = grad_w.tolist()
        else:
            existing = np.array(_flatten_data(existing_w))
            self.weight._t._grad = (existing + grad_w.flatten()).tolist()
        
        existing_b = self.bias._t._grad
        if existing_b is None or len(_flatten_data(existing_b)) != np.prod(self.bias.shape):
            self.bias._t._grad = grad_b.tolist()
        else:
            existing = np.array(_flatten_data(existing_b))
            self.bias._t._grad = (existing + grad_b).tolist()
        
        if grad_output._prev is not None:
            grad_output._prev._t._grad = grad_x.tolist()


class MaxPool2d(Module):
    """2D 最大池化層"""
    
    def __init__(self, kernel_size, stride=None):
        super().__init__()
        self.kernel_size = kernel_size if isinstance(kernel_size, tuple) else (kernel_size, kernel_size)
        self.stride = kernel_size if stride is None else stride
    
    def forward(self, x):
        x_data = _to_numpy(x)
        N, C, H, W = x_data.shape
        kH, kW = self.kernel_size
        sH, sW = self.stride if isinstance(self.stride, tuple) else (self.stride, self.stride)
        
        out_H = (H - kH) // sH + 1
        out_W = (W - kW) // sW + 1
        
        output = np.zeros((N, C, out_H, out_W))
        
        for n in range(N):
            for c in range(C):
                for i in range(out_H):
                    for j in range(out_W):
                        h_start, w_start = i * sH, j * sW
                        patch = x_data[n, c, h_start:h_start+kH, w_start:w_start+kW]
                        output[n, c, i, j] = np.max(patch)
        
        result = Tensor(output.tolist(), _ctx=self)
        result._cached = {'input_data': x_data, 'stride': (sH, sW)}
        return result
    
    def backward(self, grad_output):
        upstream_grad = np.array(grad_output._t._grad) if grad_output._t._grad else np.ones_like(np.array(grad_output._t._data))
        input_data = grad_output._cached['input_data']
        sH, sW = grad_output._cached['stride']
        
        N, C, H, W = input_data.shape
        kH, kW = self.kernel_size
        out_H, out_W = upstream_grad.shape[2], upstream_grad.shape[3]
        
        grad_x = np.zeros_like(input_data)
        
        for n in range(N):
            for c in range(C):
                for i in range(out_H):
                    for j in range(out_W):
                        h_start, w_start = i * sH, j * sW
                        patch = input_data[n, c, h_start:h_start+kH, w_start:w_start+kW]
                        max_idx = np.unravel_index(np.argmax(patch), patch.shape)
                        grad_x[n, c, h_start + max_idx[0], w_start + max_idx[1]] += upstream_grad[n, c, i, j]
        
        if grad_output._prev is not None:
            grad_output._prev._t._grad = grad_x.tolist()


class Flatten(Module):
    """展平層"""
    
    def __init__(self, start_dim=1):
        super().__init__()
        self.start_dim = start_dim
    
    def forward(self, x):
        x_data = _to_numpy(x)
        result = x_data.reshape(x_data.shape[0], -1)
        output = Tensor(result.tolist(), _ctx=self)
        output._cached = {'input_shape': x_data.shape}
        return output
    
    def backward(self, grad_output):
        upstream_grad = np.array(grad_output._t._grad) if grad_output._t._grad else np.ones_like(np.array(grad_output._t._data))
        input_shape = grad_output._cached['input_shape']
        grad_x = upstream_grad.reshape(input_shape)
        if grad_output._prev is not None:
            grad_output._prev._t._grad = grad_x.tolist()


class SimpleCNN(Module):
    """簡單的 CNN 模型"""
    
    def __init__(self, in_channels=1, num_classes=10):
        super().__init__()
        self.conv1 = Conv2d(in_channels, 8, kernel_size=3, stride=1, pad=1)
        self.pool1 = MaxPool2d(kernel_size=2)
        self.conv2 = Conv2d(8, 16, kernel_size=3, stride=1, pad=1)
        self.pool2 = MaxPool2d(kernel_size=2)
        self.flatten = Flatten()
        self.fc = None
        self.num_classes = num_classes
    
    def forward(self, x):
        x1 = self.conv1(x)
        x2 = x1.relu()
        x3 = self.pool1(x2)
        x4 = self.conv2(x3)
        x5 = x4.relu()
        x6 = self.pool2(x5)
        x7 = self.flatten(x6)
        
        if self.fc is None:
            flat_len = x7.shape[1]
            self.fc = Linear(flat_len, self.num_classes)
            self._modules['fc'] = self.fc
        
        x8 = self.fc(x7)
        
        x8._prev = x7
        x7._prev = x6
        x6._prev = x5
        x5._prev = x4
        x4._prev = x3
        x3._prev = x2
        x2._prev = x1
        x1._prev = x
        
        return x8


def conv2d(x, weight, bias=None, stride=1, pad=0):
    """手動實現的卷積運算"""
    x_data = _to_numpy(x)
    w_data = _to_numpy(weight)
    
    if bias is not None:
        b_data = _to_numpy(bias)
    else:
        b_data = None
    
    N, C, H, W = x_data.shape
    out_ch, _, kH, kW = w_data.shape
    
    out_H = (H + 2 * pad - kH) // stride + 1
    out_W = (W + 2 * pad - kW) // stride + 1
    
    output = np.zeros((N, out_ch, out_H, out_W))
    
    x_padded = np.pad(x_data, ((0, 0), (0, 0), (pad, pad), (pad, pad)), mode='constant')
    
    for n in range(N):
        for oc in range(out_ch):
            for i in range(out_H):
                for j in range(out_W):
                    h_start, w_start = i * stride, j * stride
                    patch = x_padded[n, :, h_start:h_start+kH, w_start:w_start+kW]
                    output[n, oc, i, j] = np.sum(patch * w_data[oc])
                    if b_data is not None:
                        output[n, oc, i, j] += b_data[oc]
    
    return Tensor(output.tolist())


def maxpool2d(x, kernel_size, stride=None):
    """手動實現的最大池化"""
    x_data = _to_numpy(x)
    
    if stride is None:
        stride = kernel_size
    
    N, C, H, W = x_data.shape
    kH = kW = kernel_size if isinstance(kernel_size, int) else kernel_size[0]
    sH = sW = stride if isinstance(stride, int) else stride[0]
    
    out_H = (H - kH) // sH + 1
    out_W = (W - kW) // sW + 1
    
    output = np.zeros((N, C, out_H, out_W))
    
    for n in range(N):
        for c in range(C):
            for i in range(out_H):
                for j in range(out_W):
                    h_start, w_start = i * sH, j * sW
                    patch = x_data[n, c, h_start:h_start+kH, w_start:w_start+kW]
                    output[n, c, i, j] = np.max(patch)
    
    return Tensor(output.tolist())


class _CrossEntropyLoss:
    def __init__(self, logits, targets):
        self.logits = logits
        self.targets = targets
    
    def backward(self, grad_output):
        upstream_grad = np.array(grad_output._t._grad) if grad_output._t._grad else np.array([1.0])
        if upstream_grad.size == 1:
            upstream_grad = float(upstream_grad.flatten()[0])
        else:
            upstream_grad = upstream_grad.flatten()[0] if upstream_grad.size > 0 else 1.0
        
        logits_data = np.array(self.logits._t._data)
        
        max_val = np.max(logits_data, axis=1, keepdims=True) if logits_data.ndim > 1 else np.max(logits_data)
        exps = np.exp(logits_data - max_val)
        probs = exps / np.sum(exps, axis=1, keepdims=True) if exps.ndim > 1 else exps / np.sum(exps)
        
        N = logits_data.shape[0] if logits_data.ndim > 1 else 1
        
        grad_logits = probs.copy()
        if isinstance(self.targets, (list, np.ndarray)):
            for n in range(N):
                t = self.targets[n]
                grad_logits[n, t] -= 1
        else:
            grad_logits[0, self.targets] -= 1
        
        grad_logits = grad_logits * upstream_grad / N
        
        if self.logits._t._grad is None:
            self.logits._t._grad = grad_logits.tolist()
        else:
            existing = np.array(_flatten_data(self.logits._t._grad))
            self.logits._t._grad = (existing + grad_logits.flatten()).tolist()


def cross_entropy_loss(logits, targets):
    """計算 cross-entropy loss"""
    logits_data = logits.data if isinstance(logits, Tensor) else logits
    
    if isinstance(logits_data, list):
        logits_data = np.array(logits_data)
    
    max_val = np.max(logits_data, axis=1, keepdims=True) if logits_data.ndim > 1 else np.max(logits_data)
    exps = np.exp(logits_data - max_val)
    probs = exps / np.sum(exps, axis=1, keepdims=True) if exps.ndim > 1 else exps / np.sum(exps)
    
    N = logits_data.shape[0] if logits_data.ndim > 1 else 1
    loss = 0
    
    if isinstance(targets, (list, np.ndarray)):
        for n in range(N):
            t = targets[n]
            loss -= np.log(probs[n, t] + 1e-8)
    else:
        loss = -np.log(probs[0, targets] + 1e-8)
    
    result = Tensor([loss / N], _ctx=_CrossEntropyLoss(logits, targets))
    return result


def accuracy(logits, targets):
    """計算準確率"""
    logits_data = logits.data if isinstance(logits, Tensor) else logits
    
    if isinstance(logits_data, list):
        logits_data = np.array(logits_data)
    
    preds = np.argmax(logits_data, axis=1) if logits_data.ndim > 1 else np.argmax(logits_data)
    targets_arr = np.array(targets) if isinstance(targets, (list, tuple)) else targets
    return np.mean(preds == targets_arr)
