from nn0 import Value, softmax

print("\n=== 4. Softmax 與 Cross-Entropy Loss ===")

# 假設這是神經網路最後一層輸出的三個類別分數 (Logits)
logits = [Value(2.0), Value(1.0), Value(0.1)]
# 假設正確的類別索引是 0
target_idx = 0 

# 1. 計算 Softmax 機率
probs = softmax(logits)

# 2. 計算 Cross-Entropy Loss: -log(p_target)
loss = -probs[target_idx].log()

# 3. 反向傳播
loss.backward()

print("Logits    :", [round(l.data, 4) for l in logits])
print("Probs     :", [round(p.data, 4) for p in probs])
print(f"Loss      : {loss.data:.4f}")
print("Logits 梯度:", [round(l.grad, 4) for l in logits])