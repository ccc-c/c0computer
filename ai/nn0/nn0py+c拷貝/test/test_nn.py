"""
test_nn.py — 測試神經網路層
"""
import math
import sys
import random
sys.path.insert(0, '..')

from nn0 import Tensor
from nn import (
    Module, Linear, ReLU, Sigmoid, Tanh, LeakyReLU, Softmax,
    MSELoss, CrossEntropyLoss, BCELoss, L1Loss,
    SGD, Adam,
    no_grad, manual_seed, clone
)


def test_relu():
    """測試 ReLU 激勵函數"""
    layer = ReLU()
    
    x = Tensor([[-1.0, 0.0, 1.0], [-5.0, 2.0, -0.5]])
    y = layer(x)
    
    expected = [[0.0, 0.0, 1.0], [0.0, 2.0, 0.0]]
    for i in range(len(expected)):
        for j in range(len(expected[0])):
            assert abs(y.data[i][j] - expected[i][j]) < 1e-9, f"ReLU failed at [{i}][{j}]"
    print("test_relu passed")


def test_sigmoid():
    """測試 Sigmoid 激勵函數"""
    layer = Sigmoid()
    
    x = Tensor([[0.0]])
    y = layer(x)
    assert abs(y.data[0][0] - 0.5) < 1e-9, "Sigmoid(0) should be 0.5"
    
    x = Tensor([[100.0]])
    y = layer(x)
    assert abs(y.data[0][0] - 1.0) < 1e-9, "Sigmoid(100) should be ~1.0"
    
    x = Tensor([[-100.0]])
    y = layer(x)
    assert abs(y.data[0][0] - 0.0) < 1e-9, "Sigmoid(-100) should be ~0.0"
    
    x = Tensor([[1.0]])
    y = layer(x)
    expected = 1 / (1 + math.exp(-1))
    assert abs(y.data[0][0] - expected) < 1e-9, f"Sigmoid(1) should be {expected}"
    
    x = Tensor([[-2.0, 0.0, 2.0]])
    y = layer(x)
    expected_vals = [1 / (1 + math.exp(-v)) for v in [-2.0, 0.0, 2.0]]
    for i, expected in enumerate(expected_vals):
        assert abs(y.data[0][i] - expected) < 1e-9, f"Sigmoid failed at [{i}]"
    
    print("test_sigmoid passed")


def test_tanh():
    """測試 Tanh 激勵函數"""
    layer = Tanh()
    
    x = Tensor([[0.0]])
    y = layer(x)
    assert abs(y.data[0][0] - 0.0) < 1e-9, "Tanh(0) should be 0"
    
    x = Tensor([[1.0]])
    y = layer(x)
    expected = math.tanh(1.0)
    assert abs(y.data[0][0] - expected) < 1e-9, f"Tanh(1) should be {expected}"
    
    x = Tensor([[-1.0]])
    y = layer(x)
    expected = math.tanh(-1.0)
    assert abs(y.data[0][0] - expected) < 1e-9, f"Tanh(-1) should be {expected}"
    
    x = Tensor([[100.0]])
    y = layer(x)
    assert abs(y.data[0][0] - 1.0) < 1e-6, "Tanh(100) should be ~1.0"
    
    x = Tensor([[-100.0]])
    y = layer(x)
    assert abs(y.data[0][0] - (-1.0)) < 1e-6, "Tanh(-100) should be ~-1.0"
    
    x = Tensor([[-3.0, 0.0, 3.0]])
    y = layer(x)
    expected_vals = [math.tanh(v) for v in [-3.0, 0.0, 3.0]]
    for i, expected in enumerate(expected_vals):
        assert abs(y.data[0][i] - expected) < 1e-9, f"Tanh failed at [{i}]"
    
    print("test_tanh passed")


def test_leaky_relu():
    """測試 LeakyReLU 激勵函數"""
    layer = LeakyReLU(alpha=0.01)
    
    x = Tensor([[-1.0, 0.0, 1.0]])
    y = layer(x)
    assert abs(y.data[0][0] - (-0.01)) < 1e-9, "LeakyReLU(-1) should be -0.01"
    assert abs(y.data[0][1] - 0.0) < 1e-9, "LeakyReLU(0) should be 0"
    assert abs(y.data[0][2] - 1.0) < 1e-9, "LeakyReLU(1) should be 1"
    
    layer2 = LeakyReLU(alpha=0.1)
    x = Tensor([[-5.0]])
    y = layer2(x)
    assert abs(y.data[0][0] - (-0.5)) < 1e-9, "LeakyReLU(alpha=0.1)(-5) should be -0.5"
    
    layer3 = LeakyReLU(alpha=0.2)
    x = Tensor([[2.0, -2.0, 0.0]])
    y = layer3(x)
    assert abs(y.data[0][0] - 2.0) < 1e-9
    assert abs(y.data[0][1] - (-0.4)) < 1e-9
    assert abs(y.data[0][2] - 0.0) < 1e-9
    
    print("test_leaky_relu passed")


def test_softmax():
    """測試 Softmax 激勵函數"""
    layer = Softmax()
    
    x = Tensor([[1.0, 2.0, 3.0]])
    y = layer(x)
    total = sum(y.data[0])
    assert abs(total - 1.0) < 1e-9, f"Softmax sum should be 1.0, got {total}"
    
    exp_1, exp_2, exp_3 = math.exp(1), math.exp(2), math.exp(3)
    expected = [exp_1 / (exp_1 + exp_2 + exp_3),
               exp_2 / (exp_1 + exp_2 + exp_3),
               exp_3 / (exp_1 + exp_2 + exp_3)]
    for i, exp in enumerate(expected):
        assert abs(y.data[0][i] - exp) < 1e-9, f"Softmax failed at [{i}]"
    
    x = Tensor([[0.0, 0.0, 0.0]])
    y = layer(x)
    for val in y.data[0]:
        assert abs(val - 1/3) < 1e-9, "Softmax([0,0,0]) should be [1/3, 1/3, 1/3]"
    
    x = Tensor([[1000.0, 1001.0, 1002.0]])
    y = layer(x)
    total = sum(y.data[0])
    assert abs(total - 1.0) < 1e-9, "Softmax with large values sum should be 1.0"
    assert y.data[0][2] > y.data[0][1] > y.data[0][0], "Largest input should have largest probability"
    
    print("test_softmax passed")


def test_softmax_backward():
    """測試 Softmax 反向傳播"""
    layer = Softmax()
    
    x = Tensor([[1.0, 2.0]])
    y = layer(x)
    loss = y.sum()
    loss.backward()
    
    assert x.grad is not None, "Gradient should be computed"
    assert len(x.grad) == 1, "Gradient should have 1 row"
    assert len(x.grad[0]) == 2, "Gradient should have 2 columns"
    
    print("test_softmax_backward passed")


def test_activation_in_sequence():
    """測試激勵函數在 Sequential 組合中的使用"""
    x = Tensor([[1.0, -2.0, 3.0, -4.0]])
    
    relu = ReLU()
    sigmoid = Sigmoid()
    tanh = Tanh()
    leaky_relu = LeakyReLU(alpha=0.1)
    softmax = Softmax()
    
    y_relu = relu(x)
    assert y_relu.data[0] == [1.0, 0.0, 3.0, 0.0]
    
    y_sigmoid = sigmoid(x)
    for i, val in enumerate(y_sigmoid.data[0]):
        expected = 1 / (1 + math.exp(-x.data[0][i]))
        assert abs(val - expected) < 1e-9, f"Sigmoid at [{i}] mismatch"
    
    y_tanh = tanh(x)
    assert abs(y_tanh.data[0][0] - math.tanh(1.0)) < 1e-9
    assert abs(y_tanh.data[0][1] - math.tanh(-2.0)) < 1e-9
    
    y_leaky = leaky_relu(x)
    assert abs(y_leaky.data[0][0] - 1.0) < 1e-9
    assert abs(y_leaky.data[0][1] - (-0.2)) < 1e-9
    
    y_softmax = softmax(x)
    assert abs(sum(y_softmax.data[0]) - 1.0) < 1e-9
    
    print("test_activation_in_sequence passed")


def test_linear_with_activations():
    """測試 Linear 層搭配不同激勵函數"""
    random.seed(42)
    
    linear = Linear(3, 2)
    relu = ReLU()
    sigmoid = Sigmoid()
    
    x = Tensor([[1.0, 2.0, 3.0]])
    
    out = linear(x)
    assert out.shape == (1, 2), f"Expected shape (1, 2), got {out.shape}"
    
    out_relu = relu(out)
    assert out_relu.shape == (1, 2)
    
    out_sigmoid = sigmoid(out)
    assert out_sigmoid.shape == (1, 2)
    
    print("test_linear_with_activations passed")


def test_module_parameters():
    """測試 Module.parameters() 方法"""
    class SimpleNet(Module):
        def __init__(self):
            super().__init__()
            self.fc1 = Linear(2, 4)
            self.fc2 = Linear(4, 2)
            self.relu = ReLU()
            self.sigmoid = Sigmoid()
        
        def forward(self, x):
            x = self.fc1(x)
            x = self.relu(x)
            x = self.fc2(x)
            x = self.sigmoid(x)
            return x
    
    net = SimpleNet()
    params = net.parameters()
    
    assert len(params) == 4, f"Expected 4 parameters, got {len(params)}"
    
    shapes = [p.shape for p in params]
    assert (2, 4) in shapes, "Should have weight (2, 4)"
    assert (1, 4) in shapes, "Should have bias (1, 4)"
    assert (4, 2) in shapes, "Should have weight (4, 2)"
    assert (1, 2) in shapes, "Should have bias (1, 2)"
    
    print("test_module_parameters passed")


def test_activation_backward():
    """測試激勵函數的反向傳播"""
    random.seed(42)
    
    sigmoid = Sigmoid()
    tanh = Tanh()
    leaky_relu = LeakyReLU(alpha=0.1)
    
    x = Tensor([[1.0, -1.0]])
    x_sigmoid = sigmoid(x)
    loss = x_sigmoid.sum()
    loss.backward()
    assert x.grad is not None
    print("test_activation_backward passed")


def test_mse_loss():
    """測試 MSE 損失函數"""
    criterion = MSELoss()
    
    pred = Tensor([[1.0, 2.0, 3.0]])
    target = Tensor([[1.0, 2.0, 3.0]])
    loss = criterion(pred, target)
    assert abs(loss.item() - 0.0) < 1e-9, "MSE should be 0 for identical tensors"
    
    pred = Tensor([[1.0]])
    target = Tensor([[3.0]])
    loss = criterion(pred, target)
    assert abs(loss.item() - 4.0) < 1e-9, f"MSE should be 4.0, got {loss.item()}"
    
    pred = Tensor([[0.0, 0.0], [0.0, 0.0]])
    target = Tensor([[1.0, 1.0], [1.0, 1.0]])
    loss = criterion(pred, target)
    assert abs(loss.item() - 1.0) < 1e-9, "MSE should be 1.0"
    
    print("test_mse_loss passed")


def test_l1_loss():
    """測試 L1 損失函數"""
    criterion = L1Loss()
    
    pred = Tensor([[1.0, 2.0, 3.0]])
    target = Tensor([[1.0, 2.0, 3.0]])
    loss = criterion(pred, target)
    assert abs(loss.item() - 0.0) < 1e-9, "L1 should be 0 for identical tensors"
    
    pred = Tensor([[1.0]])
    target = Tensor([[4.0]])
    loss = criterion(pred, target)
    assert abs(loss.item() - 3.0) < 1e-9, f"L1 should be 3.0, got {loss.item()}"
    
    print("test_l1_loss passed")


def test_bce_loss():
    """測試 BCE 損失函數"""
    criterion = BCELoss()
    
    pred = Tensor([[1.0]])
    target = Tensor([[1.0]])
    loss = criterion(pred, target)
    assert abs(loss.item()) < 1e-6, "BCE should be ~0 for identical values"
    
    pred = Tensor([[0.0]])
    target = Tensor([[0.0]])
    loss = criterion(pred, target)
    assert abs(loss.item()) < 1e-6, "BCE should be ~0 for identical values"
    
    pred = Tensor([[0.5]])
    target = Tensor([[0.5]])
    loss = criterion(pred, target)
    expected = -(0.5 * math.log(0.5) + 0.5 * math.log(0.5))
    assert abs(loss.item() - expected) < 1e-6, f"BCE(0.5) should be ~{expected}, got {loss.item()}"
    
    print("test_bce_loss passed")


def test_cross_entropy_loss():
    """測試 CrossEntropy 損失函數"""
    criterion = CrossEntropyLoss()
    
    pred = Tensor([[2.0, 1.0, 0.0]])
    target = Tensor([[1.0, 0.0, 0.0]])
    loss = criterion(pred, target)
    assert loss.item() > 0, "CrossEntropy should be positive"
    
    print("test_cross_entropy_loss passed")


def test_sgd_optimizer():
    """測試 SGD 優化器"""
    random.seed(42)
    
    x = Tensor([[1.0, 2.0]])
    weight = Tensor([[0.5, 0.3]])
    
    params = [weight]
    opt = SGD(params, lr=0.1)
    
    initial = weight.data[0][0]
    
    for _ in range(100):
        opt.zero_grad()
        out = weight * x
        loss = out.sum()
        loss.backward()
        opt.step()
    
    final = weight.data[0][0]
    assert abs(final - initial + 0.1 * 100) < 0.1, "SGD should update weights"
    
    print("test_sgd_optimizer passed")


def test_sgd_with_momentum():
    """測試帶動量的 SGD"""
    random.seed(42)
    
    weight = Tensor([[1.0]])
    
    params = [weight]
    opt = SGD(params, lr=0.1, momentum=0.9)
    
    opt.zero_grad()
    loss = weight.sum()
    loss.backward()
    opt.step()
    
    assert weight.data[0][0] == 0.9, "SGD momentum should accumulate"
    
    print("test_sgd_with_momentum passed")


def test_adam_optimizer():
    """測試 Adam 優化器"""
    random.seed(42)
    
    x = Tensor([[1.0, 2.0]])
    weight = Tensor([[0.5, 0.3]])
    
    params = [weight]
    opt = Adam(params, lr=0.1)
    
    initial = weight.data[0][0]
    
    for _ in range(100):
        opt.zero_grad()
        out = weight * x
        loss = out.sum()
        loss.backward()
        opt.step()
    
    final = weight.data[0][0]
    assert abs(final - initial) > 0, "Adam should update weights"
    
    print("test_adam_optimizer passed")


def test_no_grad():
    """測試 no_grad 上下文管理器"""
    x = Tensor([[1.0, 2.0]])
    
    with no_grad():
        y = x * 2
        loss = y.sum()
        loss.backward()
    
    print("test_no_grad passed")


def test_manual_seed():
    """測試 manual_seed 函數"""
    manual_seed(42)
    a = random.random()
    
    manual_seed(42)
    b = random.random()
    
    assert abs(a - b) < 1e-9, "Same seed should produce same random numbers"
    
    print("test_manual_seed passed")


def test_clone():
    """測試 clone 函數"""
    x = Tensor([[1.0, 2.0, 3.0]])
    y = clone(x)
    
    assert y.data == x.data, "Clone should have same data"
    assert y is not x, "Clone should be a different object"
    
    print("test_clone passed")


def test_tolist():
    """測試 Tensor.tolist() 方法"""
    x = Tensor([[1.0, 2.0, 3.0]])
    lst = x.tolist()
    assert isinstance(lst, list), "tolist() should return list"
    assert lst == [1.0, 2.0, 3.0], f"tolist() should return [1.0, 2.0, 3.0], got {lst}"
    
    x2 = Tensor([[[1.0, 2.0], [3.0, 4.0]]])
    lst2 = x2.tolist()
    assert isinstance(lst2, list), "tolist() for 3D should return list"
    
    print("test_tolist passed")


def test_loss_backward():
    """測試損失函數的反向傳播"""
    criterion = L1Loss()
    
    pred = Tensor([[2.0, 3.0]])
    target = Tensor([[1.0, 2.0]])
    
    loss = criterion(pred, target)
    loss.backward()
    
    assert pred.grad is not None, "Gradient should be computed"
    
    print("test_loss_backward passed")


def run_all_tests():
    print("Running nn module tests...\n")
    
    test_relu()
    test_sigmoid()
    test_tanh()
    test_leaky_relu()
    test_softmax()
    test_softmax_backward()
    test_activation_in_sequence()
    test_linear_with_activations()
    test_module_parameters()
    test_activation_backward()
    test_mse_loss()
    test_l1_loss()
    test_bce_loss()
    test_cross_entropy_loss()
    test_sgd_optimizer()
    test_sgd_with_momentum()
    test_adam_optimizer()
    test_no_grad()
    test_manual_seed()
    test_clone()
    test_tolist()
    test_loss_backward()
    
    print("\nAll tests passed!")


if __name__ == "__main__":
    run_all_tests()
