"""
test_mnist_cnn.py — MNIST CNN 分類範例 (使用合成資料)
"""
import random
import sys
sys.path.insert(0, '..')

from nn0 import Tensor
from nn import (
    Module, Conv2d, MaxPool2d, Linear, ReLU,
    Sequential
)


class CNN(Module):
    """MNIST CNN 模型"""
    def __init__(self):
        super().__init__()
        self.features = Sequential(
            Conv2d(1, 32, kernel_size=3, padding=1),
            ReLU(),
            MaxPool2d(kernel_size=2, stride=2),
            Conv2d(32, 64, kernel_size=3, padding=1),
            ReLU(),
            MaxPool2d(kernel_size=2, stride=2),
        )
        self.classifier = Sequential(
            Linear(64 * 7 * 7, 128),
            ReLU(),
            Linear(128, 10),
        )
    
    def forward(self, x):
        x = self.features(x)
        x = x.reshape(x.shape[0], -1)
        x = self.classifier(x)
        return x


def generate_synthetic_mnist(n_samples=10, img_size=28):
    """生成合成 MNIST 風格資料"""
    X = []
    y = []
    for i in range(n_samples):
        label = i % 10
        img = []
        for j in range(img_size):
            row = []
            for k in range(img_size):
                if (i + j + k) % 10 == label:
                    row.append(random.uniform(0.3, 0.7))
                else:
                    row.append(random.uniform(0.0, 0.2))
            img.append(row)
        X.append(img)
        y.append([1.0 if j == label else 0.0 for j in range(10)])
    return X, y


def test_mnist_cnn():
    print("=== MNIST CNN 測試範例 ===\n")
    
    random.seed(42)
    
    print("生成合成測試資料...")
    X_raw, y_raw = generate_synthetic_mnist(10)
    
    X = []
    for img in X_raw:
        X.append([img])
    X = Tensor(X)
    y = Tensor(y_raw)
    
    print(f"輸入: {X.shape}, 標籤: {y.shape}\n")
    
    print("建立 CNN 模型...")
    model = CNN()
    
    print("模型結構:")
    print("  - Conv2d(1, 32) + ReLU + MaxPool2d")
    print("  - Conv2d(32, 64) + ReLU + MaxPool2d")
    print("  - Linear(64*7*7, 128) + ReLU")
    print("  - Linear(128, 10)\n")
    
    print("測試前向傳播...")
    output = model(X)
    print(f"輸出形狀: {output.shape}\n")
    
    print("驗證輸出...")
    assert output.shape == (10, 10), f"Expected (10, 10), got {output.shape}"
    
    print("測試單筆推論...")
    test_input = Tensor([[X_raw[0]]])
    test_output = model(test_input)
    print(f"單筆輸出形狀: {test_output.shape}")
    
    pred_probs = test_output._get_data_list()[0]
    pred_label = pred_probs.index(max(pred_probs))
    print(f"預測類別: {pred_label}")
    print(f"預測機率: {pred_probs}\n")
    
    print("CNN 測試通過!")
    return model


if __name__ == "__main__":
    test_mnist_cnn()
