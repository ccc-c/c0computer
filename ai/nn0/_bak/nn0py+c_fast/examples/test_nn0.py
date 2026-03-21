"""
test_nn0.py — 測試 nn0.py 的 Tensor 自動微分引擎
"""

import numpy as np
from nn0 import Tensor, Adam, linear, softmax, rmsnorm, cross_entropy


def test_tensor_creation():
    t = Tensor(3.0)
    assert t.item == 3.0
    print("test_tensor_creation passed")


def test_tensor_add():
    a = Tensor(2.0)
    b = Tensor(3.0)
    c = a + b
    assert c.item == 5.0
    print("test_tensor_add passed")


def test_tensor_mul():
    a = Tensor(2.0)
    b = Tensor(3.0)
    c = a * b
    assert c.item == 6.0
    print("test_tensor_mul passed")


def test_tensor_power():
    a = Tensor(2.0)
    b = a ** 3
    assert b.item == 8.0
    print("test_tensor_power passed")


def test_tensor_neg_sub():
    a = Tensor(5.0)
    b = Tensor(3.0)
    c = a - b
    assert c.item == 2.0
    d = -a
    assert d.item == -5.0
    print("test_tensor_neg_sub passed")


def test_tensor_log():
    a = Tensor(np.e)
    b = a.log()
    assert abs(b.item - 1.0) < 1e-6
    print("test_tensor_log passed")


def test_tensor_exp():
    a = Tensor(0.0)
    b = a.exp()
    assert abs(b.item - 1.0) < 1e-6
    print("test_tensor_exp passed")


def test_tensor_relu():
    a = Tensor(-2.0)
    b = a.relu()
    assert b.item == 0.0
    c = Tensor(3.0)
    d = c.relu()
    assert d.item == 3.0
    print("test_tensor_relu passed")


def test_tensor_sum():
    a = Tensor([1.0, 2.0, 3.0])
    b = a.sum()
    assert b.item == 6.0
    print("test_tensor_sum passed")


def test_tensor_mean():
    a = Tensor([1.0, 2.0, 3.0])
    b = a.mean()
    assert b.item == 2.0
    print("test_tensor_mean passed")


def test_backward_add():
    a = Tensor(2.0)
    b = Tensor(3.0)
    c = a + b
    c.backward()
    assert a.grad == 1.0
    assert b.grad == 1.0
    print("test_backward_add passed")


def test_backward_mul():
    a = Tensor(2.0)
    b = Tensor(3.0)
    c = a * b
    c.backward()
    assert a.grad == 3.0
    assert b.grad == 2.0
    print("test_backward_mul passed")


def test_backward_complex():
    a = Tensor(2.0)
    b = Tensor(3.0)
    c = a * b + a ** 2
    c.backward()
    assert abs(a.grad - (3.0 + 4.0)) < 1e-6
    assert b.grad == 2.0
    print("test_backward_complex passed")


def test_backward_relu():
    a = Tensor(-2.0)
    b = a.relu()
    b.backward()
    assert a.grad == 0.0

    c = Tensor(3.0)
    d = c.relu()
    d.backward()
    assert c.grad == 1.0
    print("test_backward_relu passed")


def test_backward_exp():
    a = Tensor(0.0)
    b = a.exp()
    c = b * 2
    c.backward()
    assert abs(a.grad - 2.0) < 1e-6
    print("test_backward_exp passed")


def test_adam_optimizer():
    w = Tensor(2.0)
    target = Tensor(4.0)
    optimizer = Adam([w], lr=0.1)
    for _ in range(100):
        loss = (w - target) ** 2
        loss.backward()
        optimizer.step()
    assert abs(w.item - 4.0) < 0.1
    print("test_adam_optimizer passed")


def test_softmax():
    logits = [Tensor(1.0), Tensor(2.0), Tensor(3.0)]
    probs = softmax(logits)
    total = sum(p.item for p in probs)
    assert abs(total - 1.0) < 1e-6
    print("test_softmax passed")


def test_rmsnorm():
    x = [Tensor(1.0), Tensor(2.0), Tensor(3.0)]
    normalized = rmsnorm(x)
    assert len(normalized) == 3
    print("test_rmsnorm passed")


def test_cross_entropy():
    logits = [Tensor(1.0), Tensor(2.0), Tensor(3.0)]
    loss = cross_entropy(logits, 2)
    loss.backward()
    assert loss.item > 0
    print("test_cross_entropy passed")


def test_linear():
    x = Tensor([1.0, 2.0])
    w = [Tensor([0.5, 0.1]), Tensor([0.2, 0.3])]
    y = linear(x, w)
    expected = 0.5 * 1.0 + 0.1 * 2.0
    assert abs(y.data[0] - expected) < 1e-6
    expected2 = 0.2 * 1.0 + 0.3 * 2.0
    assert abs(y.data[1] - expected2) < 1e-6
    print("test_linear passed")


def test_numpy_array():
    a = Tensor([1.0, 2.0, 3.0])
    b = Tensor([0.5, 1.0, 1.5])
    c = a * b
    assert np.allclose(c.data, [0.5, 2.0, 4.5])
    print("test_numpy_array passed")


def test_scalar_operations():
    a = Tensor(5.0)
    b = a + 3.0
    assert b.item == 8.0
    c = a * 2.0
    assert c.item == 10.0
    d = 3.0 + a
    assert d.item == 8.0
    e = 2.0 * a
    assert e.item == 10.0
    print("test_scalar_operations passed")


if __name__ == "__main__":
    test_tensor_creation()
    test_tensor_add()
    test_tensor_mul()
    test_tensor_power()
    test_tensor_neg_sub()
    test_tensor_log()
    test_tensor_exp()
    test_tensor_relu()
    test_tensor_sum()
    test_tensor_mean()
    test_backward_add()
    test_backward_mul()
    test_backward_complex()
    test_backward_relu()
    test_backward_exp()
    test_adam_optimizer()
    test_softmax()
    test_rmsnorm()
    test_cross_entropy()
    test_linear()
    test_numpy_array()
    test_scalar_operations()
    print("\nAll tests passed!")
