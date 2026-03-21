from nn0 import Value

# 1. 建立具有初始值的參數與變數
a = Value(3.0)
b = Value(2.0)
x = Value(4.0)

# 2. 建立運算圖 (Forward pass)： y = a * x^2 + b
y = a * (x ** 2) + b

# 3. 顯示前向傳播結果
print("=== 1. 基礎自動微分運算 ===")
print(f"前向計算結果 y.data = {y.data:.4f}")  # 預期：3 * 16 + 2 = 50

# 4. 反向傳播計算梯度 (Backward pass)
y.backward()

# 5. 顯示梯度並與理論值比對
print(f"dy/da = {a.grad:.4f} (理論值 x^2 = 16)")
print(f"dy/db = {b.grad:.4f} (理論值 1)")
print(f"dy/dx = {x.grad:.4f} (理論值 2ax = 2*3*4 = 24)")