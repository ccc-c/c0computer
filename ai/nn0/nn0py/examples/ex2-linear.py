from nn0 import Value, Adam

print("\n=== 2. 線性回歸訓練 ===")

# 1. 準備訓練數據 (目標函數 y = 2x + 1)
X = [1.0, 2.0, 3.0, 4.0]
Y = [3.0, 5.0, 7.0, 9.0]

# 2. 初始化模型參數 (權重與偏差)
w = Value(0.0)
b = Value(0.0)

# 3. 實例化 Adam 優化器
optimizer = Adam([w, b], lr=0.1)

# 4. 進行 50 次訓練迭代
for epoch in range(51):
    # 前向傳播：預測值與計算 Mean Squared Error (MSE) Loss
    preds = [w * x + b for x in X]
    losses = [(pred - y) ** 2 for pred, y in zip(preds, Y)]
    loss = sum(losses) / len(losses)
    
    # 反向傳播與參數更新
    loss.backward()
    optimizer.step()
    
    if epoch % 10 == 0:
        print(f"Epoch {epoch:2d} | Loss: {loss.data:.4f} | w: {w.data:.4f}, b: {b.data:.4f}")