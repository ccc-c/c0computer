"""
cnn0.py — 基於 nn0 Tensor 的卷積神經網路

提供：
  class Conv2d      — 2D 卷積層
  class MaxPool2d   — 2D 最大池化層
  class Flatten     — 展平層
  class SimpleCNN   — 簡單 CNN 模型
"""

import numpy as np
from nn0 import Tensor, Adam


def im2col(x, kernel_size, stride, pad):
    N, C, H, W = x.shape
    kH, kW = kernel_size
    sH, sW = stride
    
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
    grad_x = np.zeros((N, C, H + 2 * pad, W + 2 * pad))
    
    idx = 0
    for n in range(N):
        for i in range(out_H):
            for j in range(out_W):
                h_start = i * stride
                w_start = j * stride
                grad_x[n, :, h_start:h_start+kH, w_start:w_start+kW] += grad_cols[idx].reshape(C, kH, kW)
                idx += 1
    
    if pad > 0:
        grad_x = grad_x[:, :, pad:-pad, pad:-pad] if H > pad else grad_x
    
    return grad_x


class Linear:
    """全連接層"""
    
    def __init__(self, in_features, out_features):
        self.in_features = in_features
        self.out_features = out_features
        scale = np.sqrt(2.0 / in_features)
        self.weight = Tensor(np.random.randn(out_features, in_features) * scale)
        self.bias = Tensor(np.zeros(out_features))
    
    def __call__(self, x):
        return self.forward(x)
    
    def forward(self, x):
        x_data = x.data if isinstance(x, Tensor) else np.array(x)
        if x_data.ndim == 1:
            x_data = x_data.reshape(1, -1)
        
        w_data = self.weight.data
        b_data = self.bias.data
        
        out = x_data @ w_data.T + b_data
        
        result = Tensor(out, (x, self.weight, self.bias), (w_data, x_data))
        return result
    
    def parameters(self):
        return [self.weight, self.bias]


class Conv2d:
    """2D 卷積層"""
    
    def __init__(self, in_channels, out_channels, kernel_size, stride=1, pad=0):
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size if isinstance(kernel_size, tuple) else (kernel_size, kernel_size)
        self.stride = stride if isinstance(stride, tuple) else (stride, stride)
        self.pad = pad
        
        scale = np.sqrt(2.0 / (in_channels * self.kernel_size[0] * self.kernel_size[1]))
        self.weight = Tensor(np.random.randn(out_channels, in_channels, *self.kernel_size) * scale)
        self.bias = Tensor(np.zeros(out_channels))
    
    def __call__(self, x):
        return self.forward(x)
    
    def forward(self, x):
        x_data = x.data if isinstance(x, Tensor) else x
        N, C, H, W = x_data.shape
        
        kH, kW = self.kernel_size
        sH, sW = self.stride
        
        out_H = (H + 2 * self.pad - kH) // sH + 1
        out_W = (W + 2 * self.pad - kW) // sW + 1
        
        cols, info = im2col(x_data, self.kernel_size, self.stride, self.pad)
        
        w_data = self.weight.data.reshape(self.out_channels, -1)
        
        out_flat = w_data @ cols.T
        out_flat = out_flat + self.bias.data.reshape(-1, 1)
        
        out = out_flat.reshape(self.out_channels, N, out_H, out_W).transpose(1, 0, 2, 3)
        
        result = Tensor(out, (x, self.weight, self.bias), (cols, info, w_data, H, W))
        result._ctx = {'layer': self}
        return result
    
    def backward(self, grad_output):
        grad_output_data = grad_output.grad if isinstance(grad_output, Tensor) else grad_output
        
        N, out_ch, out_H, out_W = grad_output_data.shape
        C, kH, kW = self.in_channels, self.kernel_size[0], self.kernel_size[1]
        
        grad_output_flat = grad_output_data.transpose(1, 2, 3, 0).reshape(self.out_channels, -1)
        
        cols = grad_output._local_grads[0]
        w_data = grad_output._local_grads[2]
        H, W = grad_output._local_grads[3], grad_output._local_grads[4]
        
        grad_w = (grad_output_flat @ cols).reshape(self.out_channels, self.in_channels, kH, kW)
        grad_bias = grad_output_flat.sum(axis=1)
        
        grad_cols = w_data.T @ grad_output_flat
        grad_x = col2im(grad_cols.T, N, out_H, out_W, C, kH, kW, 
                        H, W, self.stride, self.pad)
        
        return Tensor(grad_x), Tensor(grad_w), Tensor(grad_bias)


class MaxPool2d:
    """2D 最大池化層"""
    
    def __init__(self, kernel_size, stride=None):
        self.kernel_size = kernel_size if isinstance(kernel_size, tuple) else (kernel_size, kernel_size)
        self.stride = kernel_size if stride is None else stride
    
    def __call__(self, x):
        return self.forward(x)
    
    def forward(self, x):
        x_data = x.data if isinstance(x, Tensor) else x
        N, C, H, W = x_data.shape
        kH, kW = self.kernel_size
        sH, sW = self.stride if isinstance(self.stride, tuple) else (self.stride, self.stride)
        
        out_H = (H - kH) // sH + 1
        out_W = (W - kW) // sW + 1
        
        output = np.zeros((N, C, out_H, out_W))
        mask = np.zeros_like(x_data)
        
        for n in range(N):
            for c in range(C):
                for i in range(out_H):
                    for j in range(out_W):
                        h_start, w_start = i * sH, j * sW
                        patch = x_data[n, c, h_start:h_start+kH, w_start:w_start+kW]
                        max_val = np.max(patch)
                        output[n, c, i, j] = max_val
                        
                        max_idx = np.unravel_index(np.argmax(patch), patch.shape)
                        mask[n, c, h_start + max_idx[0], w_start + max_idx[1]] = 1
        
        result = Tensor(output)
        result._ctx = {'mask': mask, 'stride': (sH, sW), 'input_shape': (H, W)}
        return result


class Flatten:
    """展平層"""
    
    def __call__(self, x):
        return self.forward(x)
    
    def forward(self, x):
        x_data = x.data if isinstance(x, Tensor) else x
        original_shape = x_data.shape
        flat = x_data.reshape(x_data.shape[0], -1)
        result = Tensor(flat)
        result._ctx = {'original_shape': original_shape}
        return result


class SimpleCNN:
    """簡單的 CNN 模型"""
    
    def __init__(self, in_channels=1, num_classes=10):
        self.conv1 = Conv2d(in_channels, 8, kernel_size=3, stride=1, pad=1)
        self.pool1 = MaxPool2d(kernel_size=2)
        self.conv2 = Conv2d(8, 16, kernel_size=3, stride=1, pad=1)
        self.pool2 = MaxPool2d(kernel_size=2)
        self.flatten = Flatten()
        self.fc = None
        self.num_classes = num_classes
    
    def _init_fc(self, x_data):
        if self.fc is None:
            flat = self.flatten(Tensor(x_data.data if isinstance(x_data, Tensor) else x_data))
            flat_len = flat.data.shape[1]
            self.fc = Linear(flat_len, self.num_classes)
    
    def __call__(self, x):
        x = self.conv1(x)
        x = x.relu()
        x = self.pool1(x)
        x = self.conv2(x)
        x = x.relu()
        x = self.pool2(x)
        x = self.flatten(x)
        self._init_fc(x)
        assert self.fc is not None, "FC layer not initialized"
        x = self.fc(x)
        return x
    
    def parameters(self):
        params = []
        for layer in [self.conv1, self.conv2]:
            params.extend([layer.weight, layer.bias])
        if self.fc:
            params.extend([self.fc.weight, self.fc.bias])
        return params


class Sequential:
    """Sequential 容器"""
    
    def __init__(self, *layers):
        self.layers = layers
    
    def __call__(self, x):
        for layer in self.layers:
            x = layer(x)
        return x
    
    def parameters(self):
        params = []
        for layer in self.layers:
            if hasattr(layer, 'weight'):
                params.append(layer.weight)
            if hasattr(layer, 'bias'):
                params.append(layer.bias)
        return params


def conv2d(x, weight, bias=None, stride=1, pad=0):
    """手動實現的卷積運算"""
    x_data = x.data if isinstance(x, Tensor) else np.array(x)
    w_data = weight.data if isinstance(weight, Tensor) else np.array(weight)
    
    if bias is not None:
        b_data = bias.data if isinstance(bias, Tensor) else np.array(bias)
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
    
    return Tensor(output)


def maxpool2d(x, kernel_size, stride=None):
    """手動實現的最大池化"""
    x_data = x.data if isinstance(x, Tensor) else np.array(x)
    
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
    
    return Tensor(output)


def cross_entropy_loss(logits, targets):
    """計算 cross-entropy loss"""
    logits_data = logits.data if isinstance(logits, Tensor) else logits
    max_val = np.max(logits_data, axis=1, keepdims=True)
    exps = np.exp(logits_data - max_val)
    probs = exps / np.sum(exps, axis=1, keepdims=True)
    
    N = logits_data.shape[0]
    loss = 0
    for n in range(N):
        t = targets[n] if isinstance(targets, (list, np.ndarray)) else targets
        loss -= np.log(probs[n, t] + 1e-8)
    
    return Tensor(loss / N)


def accuracy(logits, targets):
    """計算準確率"""
    logits_data = logits.data if isinstance(logits, Tensor) else logits
    preds = np.argmax(logits_data, axis=1)
    targets_arr = np.array(targets) if isinstance(targets, (list, tuple)) else targets
    return np.mean(preds == targets_arr)
