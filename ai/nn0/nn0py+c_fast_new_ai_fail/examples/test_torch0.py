"""
test_torch0.py — 測試 torch0.py 的 PyTorch-like API

測試內容：
  - Tensor 創建與基本操作
  - 反向傳播
  - 損失函數
  - 優化器
  - 模組與層
"""

import numpy as np
from torch0 import (Tensor, Parameter, Module, 
                    zeros, ones, randn, arange, tensor,
                    matmul, dot, softmax, cross_entropy, mse_loss,
                    relu, sigmoid,
                    Linear, Sequential, ReLU, Sigmoid, Tanh, Flatten,
                    Conv2d, MaxPool2d,
                    MSELoss, CrossEntropyLoss,
                    Adam, SGD)


def test_tensor_creation():
    t = tensor(3.0)
    assert t.item == 3.0
    print("test_tensor_creation passed")


def test_tensor_from_list():
    t = tensor([1.0, 2.0, 3.0])
    assert list(t.data) == [1.0, 2.0, 3.0]
    print("test_tensor_from_list passed")


def test_zeros():
    t = zeros(3, 4)
    assert t.shape == (3, 4)
    assert np.allclose(t.data, 0)
    print("test_zeros passed")


def test_ones():
    t = ones(2, 3)
    assert t.shape == (2, 3)
    assert np.allclose(t.data, 1)
    print("test_ones passed")


def test_arange():
    t = arange(10)
    assert t.shape == (10,)
    assert list(t.data) == list(range(10))
    print("test_arange passed")


def test_tensor_add():
    a = tensor([1.0, 2.0])
    b = tensor([3.0, 4.0])
    c = a + b
    assert list(c.data) == [4.0, 6.0]
    print("test_tensor_add passed")


def test_tensor_mul():
    a = tensor([2.0, 3.0])
    b = tensor([4.0, 5.0])
    c = a * b
    assert list(c.data) == [8.0, 15.0]
    print("test_tensor_mul passed")


def test_tensor_pow():
    a = tensor([2.0, 3.0])
    b = a ** 2
    assert list(b.data) == [4.0, 9.0]
    print("test_tensor_pow passed")


def test_tensor_neg():
    a = tensor([1.0, -2.0, 3.0])
    b = -a
    assert list(b.data) == [-1.0, 2.0, -3.0]
    print("test_tensor_neg passed")


def test_tensor_sub():
    a = tensor([5.0, 6.0])
    b = tensor([2.0, 3.0])
    c = a - b
    assert list(c.data) == [3.0, 3.0]
    print("test_tensor_sub passed")


def test_scalar_operations():
    a = tensor([1.0, 2.0, 3.0])
    b = a + 10
    assert list(b.data) == [11.0, 12.0, 13.0]
    c = a * 2
    assert list(c.data) == [2.0, 4.0, 6.0]
    d = 5 + a
    assert list(d.data) == [6.0, 7.0, 8.0]
    e = 2 * a
    assert list(e.data) == [2.0, 4.0, 6.0]
    print("test_scalar_operations passed")


def test_log():
    a = tensor([np.e])
    b = a.log()
    assert abs(b.item - 1.0) < 1e-6
    print("test_log passed")


def test_exp():
    a = tensor([0.0])
    b = a.exp()
    assert abs(b.item - 1.0) < 1e-6
    print("test_exp passed")


def test_relu():
    a = tensor([-2.0, 0.0, 3.0])
    b = a.relu()
    assert list(b.data) == [0.0, 0.0, 3.0]
    print("test_relu passed")


def test_sigmoid():
    a = tensor([0.0])
    b = a.sigmoid()
    assert abs(b.item - 0.5) < 1e-6
    print("test_sigmoid passed")


def test_tanh():
    a = tensor([0.0])
    b = a.tanh()
    assert abs(b.item - 0.0) < 1e-6
    print("test_tanh passed")


def test_sum():
    a = tensor([1.0, 2.0, 3.0])
    b = a.sum()
    assert abs(b.item - 6.0) < 1e-6
    print("test_sum passed")


def test_mean():
    a = tensor([1.0, 2.0, 3.0, 4.0])
    b = a.mean()
    assert abs(b.item - 2.5) < 1e-6
    print("test_mean passed")


def test_abs():
    a = tensor([-1.0, 2.0, -3.0])
    b = a.abs()
    assert list(b.data) == [1.0, 2.0, 3.0]
    print("test_abs passed")


def test_reshape():
    a = tensor([[1, 2, 3], [4, 5, 6]])
    b = a.reshape(6)
    assert b.shape == (6,)
    assert list(b.data) == [1, 2, 3, 4, 5, 6]
    print("test_reshape passed")


def test_flatten():
    a = tensor([[1, 2], [3, 4]])
    b = a.flatten()
    assert b.shape == (4,)
    print("test_flatten passed")


def test_transpose():
    a = tensor([[1, 2, 3], [4, 5, 6]])
    b = a.T
    assert b.shape == (3, 2)
    print("test_transpose passed")


def test_backward_add():
    a = tensor([1.0, 2.0])
    b = tensor([3.0, 4.0])
    c = a + b
    c.sum().backward()
    assert list(a.grad) == [1.0, 1.0]
    assert list(b.grad) == [1.0, 1.0]
    print("test_backward_add passed")


def test_backward_mul():
    a = tensor([2.0, 3.0])
    b = tensor([4.0, 5.0])
    c = a * b
    c.sum().backward()
    assert list(a.grad) == [4.0, 5.0]
    assert list(b.grad) == [2.0, 3.0]
    print("test_backward_mul passed")


def test_backward_pow():
    a = tensor([2.0, 3.0])
    b = a ** 2
    b.sum().backward()
    assert list(a.grad) == [4.0, 6.0]
    print("test_backward_pow passed")


def test_backward_relu():
    a = tensor([-1.0, 2.0, -3.0])
    b = a.relu()
    b.sum().backward()
    assert list(a.grad) == [0.0, 1.0, 0.0]
    print("test_backward_relu passed")


def test_backward_exp():
    a = tensor([0.0, 1.0])
    b = a.exp()
    b.sum().backward()
    assert np.allclose(a.grad, [1.0, np.e])
    print("test_backward_exp passed")


def test_backward_complex():
    a = tensor([2.0, 3.0])
    b = tensor([4.0, 5.0])
    c = (a * b) + (a ** 2)
    c.sum().backward()
    assert np.allclose(a.grad, [8.0, 11.0])
    assert list(b.grad) == [2.0, 3.0]
    print("test_backward_complex passed")


def test_matmul():
    a = tensor([[1.0, 2.0], [3.0, 4.0]])
    b = tensor([[5.0, 6.0], [7.0, 8.0]])
    c = matmul(a, b)
    expected = np.dot(a.data, b.data)
    assert np.allclose(c.data, expected)
    print("test_matmul passed")


def test_dot():
    a = tensor([1.0, 2.0, 3.0])
    b = tensor([4.0, 5.0, 6.0])
    c = dot(a, b)
    assert abs(c.item - 32.0) < 1e-6
    print("test_dot passed")


def test_softmax():
    a = tensor([1.0, 2.0, 3.0])
    s = softmax(a)
    total = np.sum(s.data)
    assert abs(total - 1.0) < 1e-6
    print("test_softmax passed")


def test_mse_loss():
    pred = tensor([1.0, 2.0, 3.0])
    target = tensor([1.5, 2.5, 3.5])
    loss = mse_loss(pred, target)
    expected = ((0.5**2 + 0.5**2 + 0.5**2) / 3)
    assert abs(loss.item - expected) < 1e-6
    print("test_mse_loss passed")


def test_cross_entropy():
    logits = tensor([1.0, 2.0, 3.0])
    target = 2
    loss = cross_entropy(logits, target)
    assert loss.item > 0
    print("test_cross_entropy passed")


def test_parameter():
    p = Parameter([1.0, 2.0, 3.0])
    assert p.requires_grad == True
    assert list(p.data) == [1.0, 2.0, 3.0]
    print("test_parameter passed")


def test_linear_layer():
    layer = Linear(4, 2)
    x = tensor([1.0, 2.0, 3.0, 4.0])
    y = layer(x)
    assert y.shape == (2,)
    print("test_linear_layer passed")


def test_sequential():
    model = Sequential(
        Linear(4, 8),
        ReLU(),
        Linear(8, 2)
    )
    x = tensor([1.0, 2.0, 3.0, 4.0])
    y = model(x)
    assert y.shape == (2,)
    print("test_sequential passed")


def test_conv2d():
    conv = Conv2d(1, 1, kernel_size=3, stride=1, padding=0)
    x = tensor([[[[1.0, 2.0, 3.0], 
                  [4.0, 5.0, 6.0], 
                  [7.0, 8.0, 9.0]]]])
    y = conv(x)
    assert y.shape == (1, 1, 1, 1)
    print("test_conv2d passed")


def test_maxpool2d():
    pool = MaxPool2d(kernel_size=2, stride=2)
    x = tensor([[[[1.0, 2.0, 3.0, 4.0],
                  [5.0, 6.0, 7.0, 8.0],
                  [9.0, 10.0, 11.0, 12.0],
                  [13.0, 14.0, 15.0, 16.0]]]])
    y = pool(x)
    assert y.shape == (1, 1, 2, 2)
    print("test_maxpool2d passed")


def test_flatten_layer():
    flatten = Flatten(start_dim=0)
    x = tensor([1.0, 2.0, 3.0, 4.0])
    y = flatten(x)
    assert y.shape == (4,)
    print("test_flatten_layer passed")


def test_adam_optimizer():
    w = Parameter([2.0])
    target = tensor([4.0])
    optimizer = Adam([w], lr=0.1)
    for _ in range(100):
        loss = ((w - target) ** 2).mean()
        loss.backward()
        optimizer.step()
        optimizer.zero_grad()
    assert abs(w.item - 4.0) < 0.1
    print("test_adam_optimizer passed")


def test_sgd_optimizer():
    w = Parameter([2.0])
    target = tensor([4.0])
    optimizer = SGD([w], lr=0.1, momentum=0.0)
    for _ in range(200):
        loss = ((w - target) ** 2).mean()
        loss.backward()
        optimizer.step()
        optimizer.zero_grad()
    assert abs(w.item - 4.0) < 0.1
    print("test_sgd_optimizer passed")


def test_module_parameters():
    model = Sequential(
        Linear(4, 8),
        ReLU(),
        Linear(8, 2)
    )
    params = model.parameters()
    assert len(params) == 4
    print("test_module_parameters passed")


def test_module_zero_grad():
    model = Sequential(Linear(4, 2))
    x = tensor([1.0, 2.0, 3.0, 4.0])
    y = model(x)
    loss = y.sum()
    loss.backward()
    model.zero_grad()
    for p in model.parameters():
        assert np.allclose(p.grad, 0)
    print("test_module_zero_grad passed")


def test_training_loop():
    model = Sequential(
        Linear(2, 4),
        ReLU(),
        Linear(4, 1)
    )
    optimizer = Adam(model.parameters(), lr=0.01)
    criterion = MSELoss()
    
    for _ in range(100):
        x = tensor([1.0, 2.0])
        target = tensor([3.0])
        
        pred = model(x)
        loss = criterion(pred, target)
        
        loss.backward()
        optimizer.step()
        optimizer.zero_grad()
    
    assert loss.item < 10.0
    print("test_training_loop passed")


if __name__ == "__main__":
    test_tensor_creation()
    test_tensor_from_list()
    test_zeros()
    test_ones()
    test_arange()
    test_tensor_add()
    test_tensor_mul()
    test_tensor_pow()
    test_tensor_neg()
    test_tensor_sub()
    test_scalar_operations()
    test_log()
    test_exp()
    test_relu()
    test_sigmoid()
    test_tanh()
    test_sum()
    test_mean()
    test_abs()
    test_reshape()
    test_flatten()
    test_transpose()
    test_backward_add()
    test_backward_mul()
    test_backward_pow()
    test_backward_relu()
    test_backward_exp()
    test_backward_complex()
    test_matmul()
    test_dot()
    test_softmax()
    test_mse_loss()
    test_cross_entropy()
    test_parameter()
    test_linear_layer()
    test_sequential()
    test_conv2d()
    test_maxpool2d()
    test_flatten_layer()
    test_adam_optimizer()
    test_sgd_optimizer()
    test_module_parameters()
    test_module_zero_grad()
    test_training_loop()
    
    print("\nAll tests passed!")
