"""
train_xor.py — 使用自製的 nn 引擎訓練 XOR 邏輯閘
"""
import random
from nn0 import Tensor
from nn import Module, Linear, ReLU, MSELoss, SGD

# 固定亂數種子，確保每次訓練結果一致
random.seed(42)

# 1. 準備 XOR 訓練資料
# 輸入特徵: [0,0], [0,1], [1,0],[1,1]
X = Tensor([
    [0.0, 0.0],[0.0, 1.0],
    [1.0, 0.0],[1.0, 1.0]
])

# 目標輸出: XOR 真值表 (相同為0，相異為1)
y = Tensor([
    [0.0],
    [1.0],
    [1.0],
    [0.0]
])

# 2. 定義多層感知器 (MLP)
class MLP(Module):
    def __init__(self):
        super().__init__()
        self.fc1 = Linear(2, 4)   # 隱藏層 (2個輸入 -> 4個神經元)
        self.relu = ReLU()        # 激勵函數 (解決非線性問題的關鍵)
        self.fc2 = Linear(4, 1)   # 輸出層 (4個神經元 -> 1個輸出)
        
    def forward(self, x):
        x = self.fc1(x)
        x = self.relu(x)
        x = self.fc2(x)
        return x

# 初始化模型、優化器與損失函數
model = MLP()
optimizer = SGD(model.parameters(), lr=0.1)
criterion = MSELoss()

print("--- 啟動 Num0AD 神經網路訓練 (XOR 問題) ---")

# 3. 訓練迴圈 (Training Loop)
epochs = 1000
for epoch in range(epochs):
    # a. 梯度歸零
    optimizer.zero_grad()
    
    # b. 前向傳播
    pred = model(X)
    
    # c. 計算損失
    loss = criterion(pred, y)
    
    # d. 反向傳播 (自動計算梯度，呼叫底層 C 引擎)
    loss.backward()
    
    # e. 更新權重
    optimizer.step()
    
    # 每 100 次印出目前的 Loss
    if (epoch + 1) % 100 == 0:
        print(f"Epoch {epoch+1:04d}/{epochs} | Loss: {loss.item():.6f}")

# 4. 檢視最終預測結果
print("\n訓練完成！測試預測結果：")
final_pred = model(X)

for i, data_pt in enumerate(X.data):
    # 理想值應該要非常接近 y 的 [0, 1, 1, 0]
    print(f"輸入: {data_pt} -> 預測輸出: {final_pred.data[i][0]:.4f}")