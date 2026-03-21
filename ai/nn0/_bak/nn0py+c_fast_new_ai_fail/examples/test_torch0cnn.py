"""
test_torch0cnn.py — 測試 torch0cnn.py

測試內容：
  - 卷積層 (Conv2d)
  - 池化層 (MaxPool2d)
  - 展平層 (Flatten)
  - CNN 模型 (SimpleCNN)
  - 損失函數 (cross_entropy_loss)
  - 訓練循環
"""

import numpy as np
from torch0cnn import (
    Conv2d, MaxPool2d, Flatten, Linear, SimpleCNN, Sequential,
    conv2d, maxpool2d, cross_entropy_loss, accuracy
)
from torch0 import Tensor, Parameter, Adam, tensor


def test_im2col():
    """測試 im2col 函數"""
    from torch0cnn import im2col
    
    x = np.random.randn(1, 1, 4, 4)
    kernel_size = (2, 2)
    stride = (1, 1)
    pad = 0
    
    cols, info = im2col(x, kernel_size, stride, pad)
    N, out_H, out_W, C, kH, kW = info
    
    assert cols.shape == (N * out_H * out_W, C * kH * kW)
    print("test_im2col passed")


def test_col2im():
    """測試 col2im 函數"""
    from torch0cnn import col2im
    
    grad_cols = np.random.randn(9, 4)
    N, out_H, out_W, C, kH, kW = 1, 3, 3, 1, 2, 2
    H, W, stride, pad = 4, 4, (1, 1), 0
    
    grad_x = col2im(grad_cols, N, out_H, out_W, C, kH, kW, H, W, stride, pad)
    
    assert grad_x.shape == (N, C, H, W)
    print("test_col2im passed")


def test_linear_layer():
    """測試線性層"""
    layer = Linear(4, 2)
    x = tensor([[1.0, 2.0, 3.0, 4.0]])
    y = layer(x)
    assert y.shape == (1, 2)
    print("test_linear_layer passed")


def test_conv2d_basic():
    """測試基本卷積層"""
    conv = Conv2d(1, 1, kernel_size=3, stride=1, pad=0)
    x = tensor([[[[1.0, 2.0, 3.0],
                  [4.0, 5.0, 6.0],
                  [7.0, 8.0, 9.0]]]])
    y = conv(x)
    assert y.shape == (1, 1, 1, 1)
    print("test_conv2d_basic passed")


def test_conv2d_with_padding():
    """測試帶填充的卷積層"""
    conv = Conv2d(1, 1, kernel_size=3, stride=1, pad=1)
    x = tensor([[[[1.0, 2.0],
                  [3.0, 4.0]]]])
    y = conv(x)
    assert y.shape == (1, 1, 2, 2)
    print("test_conv2d_with_padding passed")


def test_conv2d_multi_channel():
    """測試多通道卷積"""
    conv = Conv2d(3, 8, kernel_size=3, stride=1, pad=1)
    x = tensor([[[[1.0, 2.0, 3.0],
                  [4.0, 5.0, 6.0],
                  [7.0, 8.0, 9.0]],
                 [[1.0, 2.0, 3.0],
                  [4.0, 5.0, 6.0],
                  [7.0, 8.0, 9.0]],
                 [[1.0, 2.0, 3.0],
                  [4.0, 5.0, 6.0],
                  [7.0, 8.0, 9.0]]]])
    y = conv(x)
    assert y.shape == (1, 8, 3, 3)
    print("test_conv2d_multi_channel passed")


def test_conv2d_batch():
    """測試批次卷積"""
    conv = Conv2d(1, 1, kernel_size=2, stride=1, pad=0)
    x = tensor([[[[1.0, 2.0, 3.0],
                  [4.0, 5.0, 6.0],
                  [7.0, 8.0, 9.0]]],
                 [[[1.0, 2.0, 3.0],
                  [4.0, 5.0, 6.0],
                  [7.0, 8.0, 9.0]]]])
    y = conv(x)
    assert y.shape == (2, 1, 2, 2)
    print("test_conv2d_batch passed")


def test_maxpool2d_basic():
    """測試基本最大池化"""
    pool = MaxPool2d(kernel_size=2, stride=2)
    x = tensor([[[[1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0],
                  [9.0, 10.0, 11.0, 12.0],
                  [13.0, 14.0, 15.0, 16.0]]]])
    y = pool(x)
    assert y.shape == (1, 1, 2, 2)
    y_data = y._t._data
    assert y_data[0][0][0][0] == 6.0
    print("test_maxpool2d_basic passed")


def test_maxpool2d_stride():
    """測試帶步幅的最大池化"""
    pool = MaxPool2d(kernel_size=2, stride=1)
    x = tensor([[[[1.0, 2.0, 3.0],
                  [4.0, 5.0, 6.0],
                  [7.0, 8.0, 9.0]]]])
    y = pool(x)
    assert y.shape == (1, 1, 2, 2)
    print("test_maxpool2d_stride passed")


def test_maxpool2d_multi_channel():
    """測試多通道最大池化"""
    pool = MaxPool2d(kernel_size=2, stride=2)
    x = tensor([[[[1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0],
                  [9.0, 10.0, 11.0, 12.0],
                  [13.0, 14.0, 15.0, 16.0]]]*3])
    y = pool(x)
    assert y.shape == (1, 3, 2, 2)
    print("test_maxpool2d_multi_channel passed")


def test_flatten():
    """測試展平層"""
    flatten = Flatten()
    x = tensor([[[[1.0, 2.0],
                  [3.0, 4.0]]]])
    y = flatten(x)
    assert y.shape == (1, 4)
    print("test_flatten passed")


def test_flatten_batch():
    """測試批次展平"""
    flatten = Flatten()
    x = tensor([[[[1.0, 2.0],
                  [3.0, 4.0]]],
                [[[5.0, 6.0],
                  [7.0, 8.0]]]])
    y = flatten(x)
    assert y.shape == (2, 4)
    print("test_flatten_batch passed")


def test_conv2d_function():
    """測試 conv2d 函數"""
    x = tensor([[[[1.0, 2.0, 3.0],
                  [4.0, 5.0, 6.0],
                  [7.0, 8.0, 9.0]]]])
    w = Parameter([[[[1.0, 0.0, -1.0],
                     [2.0, 0.0, -2.0],
                     [1.0, 0.0, -1.0]]]])
    y = conv2d(x, w, pad=1)
    assert y.shape == (1, 1, 3, 3)
    print("test_conv2d_function passed")


def test_maxpool2d_function():
    """測試 maxpool2d 函數"""
    x = tensor([[[[1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0],
                  [9.0, 10.0, 11.0, 12.0],
                  [13.0, 14.0, 15.0, 16.0]]]])
    y = maxpool2d(x, kernel_size=2, stride=2)
    assert y.shape == (1, 1, 2, 2)
    print("test_maxpool2d_function passed")


def test_sequential():
    """測試 Sequential 容器"""
    model = Sequential(
        Conv2d(1, 4, kernel_size=3, stride=1, pad=1),
        MaxPool2d(kernel_size=2),
        Flatten(),
        Linear(8, 2)
    )
    x = tensor([[[[1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0]]]])
    y = model(x)
    assert y.shape == (1, 2)
    print("test_sequential passed")


def test_simple_cnn():
    """測試 SimpleCNN 模型"""
    cnn = SimpleCNN(in_channels=1, num_classes=10)
    x = tensor([[[[1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0],
                  [1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0]]]])
    y = cnn(x)
    assert y.shape == (1, 10)
    print("test_simple_cnn passed")


def test_cross_entropy_loss():
    """測試交叉熵損失"""
    logits = tensor([[2.0, 1.0, 0.0],
                      [0.0, 2.0, 1.0],
                      [1.0, 0.0, 2.0]])
    targets = [0, 1, 2]
    loss = cross_entropy_loss(logits, targets)
    assert loss.shape == (1,)
    assert loss.item > 0
    print("test_cross_entropy_loss passed")


def test_accuracy():
    """測試準確率計算"""
    logits = tensor([[2.0, 1.0, 0.0],
                      [0.0, 2.0, 1.0],
                      [1.0, 0.0, 2.0]])
    targets = [0, 1, 2]
    acc = accuracy(logits, targets)
    assert acc == 1.0
    print("test_accuracy passed")


def test_cnn_training_step():
    """測試 CNN 訓練步驟"""
    cnn = SimpleCNN(in_channels=1, num_classes=10)
    
    x = tensor([[[[1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0],
                  [1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0]]]])
    target = tensor([3])
    
    pred = cnn(x)
    loss = cross_entropy_loss(pred, 3)
    
    optimizer = Adam(cnn.parameters(), lr=0.01)
    
    loss.backward()
    optimizer.step()
    optimizer.zero_grad()
    
    print("test_cnn_training_step passed")


def test_cnn_parameters():
    """測試 CNN 參數"""
    cnn = SimpleCNN(in_channels=1, num_classes=10)
    params = cnn.parameters()
    assert len(params) >= 4
    for p in params:
        assert hasattr(p, 'data')
        assert hasattr(p, 'grad')
    print("test_cnn_parameters passed")


def test_conv_parameters():
    """測試卷積層參數"""
    conv = Conv2d(3, 16, kernel_size=3, stride=1, pad=1)
    params = conv.parameters()
    assert len(params) == 2
    assert params[0].shape == (16, 3, 3, 3)
    assert params[1].shape == (16,)
    print("test_conv_parameters passed")


if __name__ == "__main__":
    test_im2col()
    test_col2im()
    test_linear_layer()
    test_conv2d_basic()
    test_conv2d_with_padding()
    test_conv2d_multi_channel()
    test_conv2d_batch()
    test_maxpool2d_basic()
    test_maxpool2d_stride()
    test_maxpool2d_multi_channel()
    test_flatten()
    test_flatten_batch()
    test_conv2d_function()
    test_maxpool2d_function()
    test_sequential()
    test_simple_cnn()
    test_cross_entropy_loss()
    test_accuracy()
    test_cnn_training_step()
    test_cnn_parameters()
    test_conv_parameters()
    
    print("\nAll tests passed!")
