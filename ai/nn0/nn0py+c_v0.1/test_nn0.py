"""
test_nn0.py — Test nn0.py Python wrapper with autograd
"""

from nn0 import Tensor, zeros, ones, randn, arange, matmul, dot, softmax

def test_tensor_creation():
    t = Tensor([1, 2, 3])
    assert t.data == [1, 2, 3]
    print("test_tensor_creation passed")


def test_zeros():
    a = zeros(3, 4)
    assert a.shape == (3, 4)
    print("test_zeros passed")


def test_ones():
    a = ones(2, 3)
    assert a.shape == (2, 3)
    print("test_ones passed")


def test_arange():
    a = arange(10)
    assert len(a.data) == 10
    print("test_arange passed")


def test_add():
    a = Tensor([1, 2, 3])
    b = Tensor([4, 5, 6])
    c = a + b
    assert c.data == [5, 7, 9]
    print("test_add passed")


def test_sub():
    a = Tensor([5, 6, 7])
    b = Tensor([1, 2, 3])
    c = a - b
    assert c.data ==[4, 4, 4]
    print("test_sub passed")


def test_mul():
    a = Tensor([1, 2, 3])
    b = Tensor([4, 5, 6])
    c = a * b
    assert c.data ==[4, 10, 18]
    print("test_mul passed")


def test_neg():
    a = Tensor([1, -2, 3])
    b = -a
    assert b.data ==[-1, 2, -3]
    print("test_neg passed")


def test_pow():
    a = Tensor([2, 3, 4])
    b = a ** 2
    assert b.data == [4, 9, 16]
    print("test_pow passed")


def test_exp():
    a = Tensor([0])
    b = a.exp()
    assert abs(b.data[0] - 1.0) < 1e-6
    print("test_exp passed")


def test_log():
    a = Tensor([2.71828])
    b = a.log()
    assert abs(b.data[0] - 1.0) < 1e-4
    print("test_log passed")


def test_relu():
    a = Tensor([-3, -1, 0, 2, 5])
    b = a.relu()
    assert b.data == [0, 0, 0, 2, 5]
    print("test_relu passed")


def test_sum():
    a = Tensor([1, 2, 3, 4, 5])
    s = a.sum()
    assert abs(s.item() - 15) < 1e-9
    print("test_sum passed")


def test_mean():
    a = Tensor([1, 2, 3, 4])
    m = a.mean()
    assert abs(m.item() - 2.5) < 1e-9
    print("test_mean passed")


def test_backward_add():
    a = Tensor([1, 2])
    b = Tensor([3, 4])
    c = a + b
    c.sum().backward()
    assert a.grad == [1, 1]
    assert b.grad == [1, 1]
    print("test_backward_add passed")


def test_backward_mul():
    a = Tensor([2, 3])
    b = Tensor([4, 5])
    c = a * b
    c.sum().backward()
    assert a.grad == [4, 5]
    assert b.grad == [2, 3]
    print("test_backward_mul passed")


def test_backward_pow():
    a = Tensor([2])
    b = a ** 3
    b.backward()
    assert abs(a.grad[0] - 12) < 1e-6
    print("test_backward_pow passed")


def test_backward_exp():
    a = Tensor([0])
    b = a.exp()
    c = b.sum()
    c.backward()
    assert abs(a.grad[0] - 1.0) < 1e-6
    print("test_backward_exp passed")


def test_backward_relu():
    a = Tensor([-1, 2, -3])
    b = a.relu()
    c = b.sum()
    c.backward()
    assert a.grad == [0, 1, 0]
    print("test_backward_relu passed")


def test_backward_complex():
    a = Tensor([2, 3])
    b = Tensor([4, 5])
    c = (a * b) + (a ** 2)
    s = c.sum()
    s.backward()
    assert abs(a.grad[0] - 8) < 1e-6
    assert abs(a.grad[1] - 11) < 1e-6
    assert b.grad == [2, 3]
    print("test_backward_complex passed")


def test_matmul():
    a = Tensor([[1, 2],[3, 4]])
    b = Tensor([[5, 6], [7, 8]])
    c = matmul(a, b)
    assert c.data == [[19, 22],[43, 50]]
    print("test_matmul passed")


def test_dot():
    a = Tensor([1, 2, 3])
    b = Tensor([4, 5, 6])
    c = dot(a, b)
    assert abs(c.item() - 32) < 1e-9
    print("test_dot passed")


def test_scalar_add():
    a = Tensor([1, 2, 3])
    b = a + 10
    assert b.data == [11, 12, 13]
    print("test_scalar_add passed")


def test_scalar_mul():
    a = Tensor([1, 2, 3])
    b = a * 3
    assert b.data ==[3, 6, 9]
    print("test_scalar_mul passed")


def test_softmax():
    a = Tensor([1.0, 2.0, 3.0])
    s = softmax(a)
    total = sum(s.data)
    assert abs(total - 1.0) < 1e-6
    print("test_softmax passed")


def test_chain_operations():
    a = Tensor([1, 2, 3])
    b = (a ** 2).sum().exp()
    b.backward()
    print("test_chain_operations passed")


if __name__ == "__main__":
    import sys
    test_funcs =[
        test_tensor_creation, test_zeros, test_ones, test_arange,
        test_add, test_sub, test_mul, test_neg, test_pow,
        test_exp, test_log, test_relu, test_sum, test_mean,
        test_backward_add, test_backward_mul, test_backward_pow,
        test_backward_exp, test_backward_relu, test_backward_complex,
        test_matmul, test_dot, test_scalar_add, test_scalar_mul,
        test_softmax, test_chain_operations
    ]
    
    for i, func in enumerate(test_funcs):
        try:
            func()
            sys.stdout.flush()
        except Exception as e:
            print(f"Test {i+1} failed: {e}")
            sys.exit(1)
    
    print("\nAll tests passed!")