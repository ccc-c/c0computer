"""
test_nn.py — 完整測試 nn.py 的各項神經網路功能與記憶體安全性
"""
import sys
from nn0 import Tensor
from nn import Module, Linear, ReLU, MSELoss, SGD

def test_linear():
    layer = Linear(3, 2)
    x = Tensor([[1.0, 2.0, 3.0]])
    out = layer(x)
    assert out.shape == (1, 2)
    print("test_linear passed")

def test_relu():
    relu = ReLU()
    x = Tensor([[-1.0, 2.0, -3.0]])
    out = relu(x)
    assert out.data == [[0.0, 2.0, 0.0]]
    print("test_relu passed")

def test_mseloss():
    loss_fn = MSELoss()
    pred = Tensor([[1.0, 2.0]])
    target = Tensor([[1.0, 3.0]])
    loss = loss_fn(pred, target)
    # 計算公式: ((0^2) + (-1)^2) / 2 = 0.5
    assert abs(loss.item() - 0.5) < 1e-6
    print("test_mseloss passed")

def test_backward_flow():
    layer = Linear(2, 1)
    x = Tensor([[1.0, 1.0]])
    target = Tensor([[0.0]])
    
    loss_fn = MSELoss()
    
    out = layer(x)
    loss = loss_fn(out, target)
    loss.backward()
    
    # 確認反向傳播後，權重的梯度是否有更新
    has_grad = any(g != 0.0 for row in layer.weight.grad for g in row)
    assert has_grad, "反向傳播失敗，權重梯度皆為 0"
    print("test_backward_flow passed")

def test_sgd_step():
    layer = Linear(1, 1)
    optimizer = SGD(layer.parameters(), lr=0.1)
    
    x = Tensor([[1.0]])
    target = Tensor([[0.0]])
    loss_fn = MSELoss()
    
    out1 = layer(x)
    loss1 = loss_fn(out1, target)
    loss1.backward()
    optimizer.step()  # 執行權重更新
    
    # 確認第二次預測是否有變化
    out2 = layer(x)
    assert out1.data != out2.data, "SGD 優化器沒有改變權重！"
    print("test_sgd_step passed")

def test_memory_safety():
    # 專門測試引發 Epoch 0200 Segfault 的情境
    layer = Linear(2, 2)
    loss_fn = MSELoss()
    x = Tensor([[1.0, 0.0]])
    y = Tensor([[1.0, 1.0]])
    
    try:
        # 連續跑 300 次，若記憶體安全機制 (self._bias_ones) 生效，絕不會 Crash
        for i in range(300):
            out = layer(x)
            loss = loss_fn(out, y)
            loss.backward()
        print("test_memory_safety passed (連續 300 次迴圈，無 Segmentation Fault！)")
    except Exception as e:
        print(f"記憶體崩潰：{e}")
        sys.exit(1)

if __name__ == "__main__":
    funcs =[
        test_linear, 
        test_relu, 
        test_mseloss, 
        test_backward_flow, 
        test_sgd_step, 
        test_memory_safety
    ]
    
    for f in funcs:
        try:
            f()
            sys.stdout.flush()
        except Exception as e:
            print(f"測試失敗: {e}")
            sys.exit(1)
            
    print("\nAll nn.py tests passed safely!")