"""
test_cnn0.py — 測試 cnn0.py 的 CNN 實現
"""

import numpy as np
from cnn0 import (
    Conv2d, MaxPool2d, Flatten, SimpleCNN, Sequential,
    conv2d, maxpool2d, cross_entropy_loss, accuracy
)
from nn0 import Tensor, Adam


def test_conv2d_forward():
    x = Tensor(np.random.randn(2, 3, 4, 4))
    conv = Conv2d(in_channels=3, out_channels=8, kernel_size=3, stride=1, pad=1)
    out = conv(x)
    assert out.data.shape == (2, 8, 4, 4)
    print("test_conv2d_forward passed")


def test_conv2d_output_shape():
    x = Tensor(np.random.randn(1, 1, 8, 8))
    conv = Conv2d(1, 4, kernel_size=3, stride=1, pad=0)
    out = conv(x)
    expected_H = (8 - 3) // 1 + 1
    expected_W = (8 - 3) // 1 + 1
    assert out.data.shape == (1, 4, expected_H, expected_W)
    print("test_conv2d_output_shape passed")


def test_conv2d_with_pad():
    x = Tensor(np.random.randn(1, 1, 4, 4))
    conv = Conv2d(1, 1, kernel_size=3, stride=1, pad=1)
    out = conv(x)
    assert out.data.shape == (1, 1, 4, 4)
    print("test_conv2d_with_pad passed")


def test_conv2d_stride():
    x = Tensor(np.random.randn(1, 1, 8, 8))
    conv = Conv2d(1, 1, kernel_size=2, stride=2, pad=0)
    out = conv(x)
    assert out.data.shape == (1, 1, 4, 4)
    print("test_conv2d_stride passed")


def test_maxpool2d_forward():
    x = Tensor(np.random.randn(2, 3, 4, 4))
    pool = MaxPool2d(kernel_size=2, stride=2)
    out = pool(x)
    assert out.data.shape == (2, 3, 2, 2)
    print("test_maxpool2d_forward passed")


def test_maxpool2d_larger_kernel():
    x = Tensor(np.random.randn(1, 1, 6, 6))
    pool = MaxPool2d(kernel_size=3, stride=1)
    out = pool(x)
    assert out.data.shape == (1, 1, 4, 4)
    print("test_maxpool2d_larger_kernel passed")


def test_flatten():
    x = Tensor(np.random.randn(2, 3, 4, 5))
    flat = Flatten()
    out = flat(x)
    assert out.data.shape == (2, 3 * 4 * 5)
    print("test_flatten passed")


def test_flatten_preserves_batch():
    x = Tensor(np.random.randn(5, 10, 3, 3))
    flat = Flatten()
    out = flat(x)
    assert out.data.shape[0] == 5
    print("test_flatten_preserves_batch passed")


def test_sequential():
    x = Tensor(np.random.randn(1, 1, 8, 8))
    model = Sequential(
        Conv2d(1, 4, 3, 1, 1),
        ReLU(),
        MaxPool2d(2),
        Flatten(),
    )
    out = model(x)
    assert out.data.shape[0] == 1
    print("test_sequential passed")


class ReLU:
    def __call__(self, x):
        x_data = x.data if isinstance(x, Tensor) else x
        return Tensor(np.maximum(0, x_data))


def test_simple_cnn_forward():
    model = SimpleCNN(in_channels=1, num_classes=10)
    x = Tensor(np.random.randn(4, 1, 8, 8))
    out = model(x)
    assert out.data.shape == (4, 10)
    print("test_simple_cnn_forward passed")


def test_simple_cnn_parameters():
    model = SimpleCNN(in_channels=1, num_classes=10)
    params = model.parameters()
    assert len(params) > 0
    for p in params:
        assert isinstance(p, Tensor)
    print("test_simple_cnn_parameters passed")


def test_conv2d_weight_shape():
    conv = Conv2d(in_channels=3, out_channels=16, kernel_size=5, stride=1, pad=2)
    assert conv.weight.data.shape == (16, 3, 5, 5)
    assert conv.bias.data.shape == (16,)
    print("test_conv2d_weight_shape passed")


def test_conv2d_bias():
    conv = Conv2d(1, 4, kernel_size=3)
    assert np.allclose(conv.bias.data, 0)
    print("test_conv2d_bias passed")


def test_manual_conv2d():
    x = Tensor(np.ones((1, 1, 3, 3)))
    weight = Tensor(np.ones((1, 1, 2, 2)))
    out = conv2d(x, weight)
    assert out.data.shape == (1, 1, 2, 2)
    print("test_manual_conv2d passed")


def test_manual_maxpool2d():
    x_data = np.array([[[[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]]])
    x = Tensor(x_data)
    out = maxpool2d(x, kernel_size=2, stride=2)
    assert out.data.shape == (1, 1, 2, 2)
    assert out.data[0, 0, 0, 0] == 6
    assert out.data[0, 0, 0, 1] == 8
    assert out.data[0, 0, 1, 0] == 14
    assert out.data[0, 0, 1, 1] == 16
    print("test_manual_maxpool2d passed")


def test_cross_entropy_loss():
    logits = Tensor(np.array([[2.0, 1.0, 0.1], [0.5, 2.5, 1.0]]))
    targets = [0, 1]
    loss = cross_entropy_loss(logits, targets)
    assert loss.data > 0
    print("test_cross_entropy_loss passed")


def test_accuracy():
    logits = Tensor(np.array([[2.0, 1.0, 0.1], [0.5, 2.5, 1.0], [1.0, 0.5, 2.0]]))
    targets = [0, 1, 2]
    acc = accuracy(logits, targets)
    assert acc == 1.0
    print("test_accuracy passed")


def test_accuracy_partial():
    logits = Tensor(np.array([[2.0, 1.0, 0.1], [0.5, 2.5, 1.0], [1.0, 0.5, 2.0]]))
    targets = [0, 2, 2]
    acc = accuracy(logits, targets)
    assert acc == 2/3
    print("test_accuracy_partial passed")


def test_conv2d_backward_shape():
    x = Tensor(np.random.randn(1, 1, 4, 4))
    conv = Conv2d(1, 1, kernel_size=2)
    out = conv(x)
    assert out.data.shape == (1, 1, 3, 3)
    print("test_conv2d_backward_shape passed")


def test_simple_cnn_training_step():
    model = SimpleCNN(in_channels=1, num_classes=3)
    optimizer = Adam(model.parameters(), lr=0.01)
    
    x = Tensor(np.random.randn(2, 1, 8, 8))
    targets = [0, 2]
    
    logits = model(x)
    loss = cross_entropy_loss(logits, targets)
    
    initial_loss = loss.item
    
    loss.backward()
    optimizer.step()
    
    logits_new = model(x)
    loss_new = cross_entropy_loss(logits_new, targets)
    
    assert loss_new.item < initial_loss + 0.5
    print("test_simple_cnn_training_step passed")


def test_conv2d_different_stride():
    x = Tensor(np.random.randn(1, 1, 6, 6))
    conv = Conv2d(1, 1, kernel_size=2, stride=2)
    out = conv(x)
    assert out.data.shape == (1, 1, 3, 3)
    print("test_conv2d_different_stride passed")


def test_multiple_conv_layers():
    x = Tensor(np.random.randn(1, 1, 8, 8))
    conv1 = Conv2d(1, 4, 3, 1, 1)
    conv2 = Conv2d(4, 8, 3, 1, 1)
    
    out = conv1(x)
    out = out.relu()
    out = conv2(out)
    
    assert out.data.shape[1] == 8
    print("test_multiple_conv_layers passed")


def test_batch_normalization_simple():
    x = Tensor(np.random.randn(8, 4, 8, 8))
    mean = x.data.mean(axis=(0, 2, 3), keepdims=True)
    std = x.data.std(axis=(0, 2, 3), keepdims=True)
    normalized = (x - mean) / (std + 1e-5)
    assert normalized.data.shape == x.data.shape
    print("test_batch_normalization_simple passed")


if __name__ == "__main__":
    test_conv2d_forward()
    test_conv2d_output_shape()
    test_conv2d_with_pad()
    test_conv2d_stride()
    test_maxpool2d_forward()
    test_maxpool2d_larger_kernel()
    test_flatten()
    test_flatten_preserves_batch()
    test_sequential()
    test_simple_cnn_forward()
    test_simple_cnn_parameters()
    test_conv2d_weight_shape()
    test_conv2d_bias()
    test_manual_conv2d()
    test_manual_maxpool2d()
    test_cross_entropy_loss()
    test_accuracy()
    test_accuracy_partial()
    test_conv2d_backward_shape()
    test_simple_cnn_training_step()
    test_conv2d_different_stride()
    test_multiple_conv_layers()
    test_batch_normalization_simple()
    print("\nAll tests passed!")
