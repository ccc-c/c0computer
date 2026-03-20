import random
from nn0 import Value, Adam

print("\n=== 3. 多層感知器 (XOR) ===")

# 1. XOR 訓練數據
X_data = [[0, 0], [0, 1], [1, 0], [1, 1]]
Y_data = [0, 1, 1, 0]

# 2. 初始化 2-4-1 網路參數
# Layer 1: 2 個輸入 -> 4 個神經元
w1 = [[Value(random.uniform(-1, 1)) for _ in range(2)] for _ in range(4)]
b1 = [Value(random.uniform(-1, 1)) for _ in range(4)]
# Layer 2: 4 個輸入 -> 1 個輸出
w2 = [[Value(random.uniform(-1, 1)) for _ in range(4)] for _ in range(1)]
b2 = [Value(random.uniform(-1, 1)) for _ in range(1)]

# 收集所有參數交給 Adam
params = [p for row in w1 for p in row] + b1 + [p for row in w2 for p in row] + b2
optimizer = Adam(params, lr=0.1)

# 3. 定義 MLP 前向傳播
def mlp(x):
    # Hidden Layer (搭配 ReLU)
    h = [sum(wi * xi for wi, xi in zip(w_row, x)) + bi for w_row, bi in zip(w1, b1)]
    h = [hi.relu() for hi in h]
    # Output Layer
    out = [sum(wi * hi for wi, hi in zip(w_row, h)) + bi for w_row, bi in zip(w2, b2)]
    return out[0]

# 4. 訓練迴圈
for epoch in range(101):
    total_loss = Value(0.0)
    for x, y in zip(X_data, Y_data):
        pred = mlp(x)
        total_loss += (pred - y) ** 2
    
    loss = total_loss / len(X_data)
    loss.backward()
    optimizer.step()
    
    if epoch % 20 == 0:
        print(f"Epoch {epoch:3d} | Loss: {loss.data:.4f}")

# 5. 測試訓練結果
print("預測結果:")
for x, y in zip(X_data, Y_data):
    print(f"輸入 {x} -> 預測: {mlp(x).data:.4f} (目標: {y})")