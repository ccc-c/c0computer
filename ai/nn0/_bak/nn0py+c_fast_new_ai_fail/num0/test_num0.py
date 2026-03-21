"""
test_num0.py — Test num0.py Python wrapper for C library
"""

import numpy as np
from num0 import Array, zeros, ones, randn, arange, matmul, dot, maximum, slice_arr, softmax


def test_array_creation():
    a = Array([1, 2, 3])
    assert np.allclose(a.data, [1, 2, 3])
    print("test_array_creation passed")


def test_zeros():
    a = zeros(3, 4)
    assert a.shape == (3, 4)
    assert np.allclose(a.data, 0)
    print("test_zeros passed")


def test_ones():
    a = ones(2, 3)
    assert a.shape == (2, 3)
    assert np.allclose(a.data, 1)
    print("test_ones passed")


def test_randn():
    a = randn(10)
    assert a.shape == (10,)
    print("test_randn passed")


def test_arange():
    a = arange(10)
    assert np.allclose(a.data, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    a = arange(2, 8)
    assert np.allclose(a.data, [2, 3, 4, 5, 6, 7])
    print("test_arange passed")


def test_add():
    a = Array([1, 2, 3])
    b = Array([4, 5, 6])
    c = a + b
    assert np.allclose(c.data, [5, 7, 9])
    print("test_add passed")


def test_add_scalar():
    a = Array([1, 2, 3])
    c = a + 10
    assert np.allclose(c.data, [11, 12, 13])
    c = 10 + a
    assert np.allclose(c.data, [11, 12, 13])
    print("test_add_scalar passed")


def test_sub():
    a = Array([5, 6, 7])
    b = Array([1, 2, 3])
    c = a - b
    assert np.allclose(c.data, [4, 4, 4])
    print("test_sub passed")


def test_mul():
    a = Array([1, 2, 3])
    b = Array([4, 5, 6])
    c = a * b
    assert np.allclose(c.data, [4, 10, 18])
    print("test_mul passed")


def test_mul_scalar():
    a = Array([1, 2, 3])
    c = a * 3
    assert np.allclose(c.data, [3, 6, 9])
    c = 3 * a
    assert np.allclose(c.data, [3, 6, 9])
    print("test_mul_scalar passed")


def test_div():
    a = Array([6, 8, 10])
    b = Array([2, 4, 5])
    c = a / b
    assert np.allclose(c.data, [3, 2, 2])
    print("test_div passed")


def test_neg():
    a = Array([1, -2, 3])
    b = -a
    assert np.allclose(b.data, [-1, 2, -3])
    print("test_neg passed")


def test_exp():
    a = Array([0])
    b = a.exp()
    assert abs(b.data[0] - 1.0) < 1e-6
    print("test_exp passed")


def test_log():
    a = Array([2.718281828])
    b = a.log()
    assert abs(b.data[0] - 1.0) < 1e-4
    print("test_log passed")


def test_relu():
    a = Array([-3, -1, 0, 2, 5])
    b = a.relu()
    assert np.allclose(b.data, [0, 0, 0, 2, 5])
    print("test_relu passed")


def test_abs():
    a = Array([-1, -2, 3])
    b = a.abs()
    assert np.allclose(b.data, [1, 2, 3])
    print("test_abs passed")


def test_sqrt():
    a = Array([4, 9, 16])
    b = a.sqrt()
    assert np.allclose(b.data, [2, 3, 4])
    print("test_sqrt passed")


def test_pow():
    a = Array([2, 3, 4])
    b = a ** 2
    assert np.allclose(b.data, [4, 9, 16])
    b = a ** 0.5
    assert np.allclose(b.data, [np.sqrt(2), np.sqrt(3), 2])
    print("test_pow passed")


def test_sum():
    a = Array([1, 2, 3, 4, 5])
    s = a.sum()
    assert abs(s.item() - 15) < 1e-9
    print("test_sum passed")


def test_mean():
    a = Array([1, 2, 3, 4])
    m = a.mean()
    assert abs(m.item() - 2.5) < 1e-9
    print("test_mean passed")


def test_max():
    a = Array([1, 5, 3, 2, 4])
    m = a.max()
    assert abs(m.item() - 5) < 1e-9
    print("test_max passed")


def test_argmax():
    a = Array([1, 5, 3, 2, 4])
    idx = a.argmax()
    assert idx == 1
    print("test_argmax passed")


def test_matmul():
    a = Array([[1, 2], [3, 4]])
    b = Array([[5, 6], [7, 8]])
    c = matmul(a, b)
    expected = np.array([[19, 22], [43, 50]])
    assert np.allclose(c.data, expected)
    print("test_matmul passed")


def test_dot():
    a = Array([1, 2, 3])
    b = Array([4, 5, 6])
    c = dot(a, b)
    assert abs(c.item() - 32) < 1e-9
    print("test_dot passed")


def test_reshape():
    a = Array([1, 2, 3, 4, 5, 6])
    b = a.reshape(2, 3)
    assert b.shape == (2, 3)
    assert np.allclose(b.data[0], [1, 2, 3])
    print("test_reshape passed")


def test_flatten():
    a = Array([[1, 2], [3, 4]])
    b = a.flatten()
    assert np.allclose(b.data, [1, 2, 3, 4])
    print("test_flatten passed")


def test_transpose():
    a = Array([[1, 2, 3], [4, 5, 6]])
    b = a.T()
    assert b.shape == (3, 2)
    assert np.allclose(b.data[:, 0], [1, 2, 3])
    print("test_transpose passed")


def test_slice():
    a = Array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    b = slice_arr(a, 2, 5)
    assert np.allclose(b.data, [2, 3, 4])
    print("test_slice passed")


def test_maximum():
    a = Array([1, 5, 3])
    b = Array([2, 4, 6])
    c = maximum(a, b)
    assert np.allclose(c.data, [2, 5, 6])
    print("test_maximum passed")


def test_softmax():
    a = Array([1.0, 2.0, 3.0])
    s = softmax(a)
    total = s.data.sum()
    assert abs(total - 1.0) < 1e-6
    print("test_softmax passed")


def test_chain_operations():
    a = Array([1, 2, 3])
    b = (a ** 2).sum().exp().relu()
    expected = np.exp(14).item()
    assert abs(b.item() - expected) < 1e-6
    print("test_chain_operations passed")


def test_2d_operations():
    a = Array([[1, 2], [3, 4]])
    b = Array([[5, 6], [7, 8]])
    c = a + b
    assert c.shape == (2, 2)
    assert np.allclose(c.data, [[6, 8], [10, 12]])
    
    d = a * 2
    assert np.allclose(d.data, [[2, 4], [6, 8]])
    print("test_2d_operations passed")


def test_scalar_to_array():
    a = Array(5.0)
    assert a.item() == 5.0
    b = a + 3
    assert b.item() == 8.0
    print("test_scalar_to_array passed")


if __name__ == "__main__":
    test_array_creation()
    test_zeros()
    test_ones()
    test_randn()
    test_arange()
    test_add()
    test_add_scalar()
    test_sub()
    test_mul()
    test_mul_scalar()
    test_div()
    test_neg()
    test_exp()
    test_log()
    test_relu()
    test_abs()
    test_sqrt()
    test_pow()
    test_sum()
    test_mean()
    test_max()
    test_argmax()
    test_matmul()
    test_dot()
    test_reshape()
    test_flatten()
    test_transpose()
    test_slice()
    test_maximum()
    test_softmax()
    test_chain_operations()
    test_2d_operations()
    test_scalar_to_array()
    print("\nAll tests passed!")
