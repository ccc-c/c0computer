import random
from nn0 import Value, Adam, softmax, rmsnorm, linear

print("\n=== 5. 迷你字元預測器 ===")

# 1. 建立簡易詞彙表與資料
vocab = ['a', 'p', 'l', 'e']
token_to_id = {ch: i for i, ch in enumerate(vocab)}
text = "apple"
tokens = [token_to_id[c] for c in text]  # [0, 1, 1, 2, 3]

# 2. 模型參數設定 (Embedding 維度設為 4)
d_model = 4
vocab_size = len(vocab)

# Embedding 表與 Output Projection 權重
emb = [[Value(random.uniform(-0.1, 0.1)) for _ in range(d_model)] for _ in range(vocab_size)]
w_out = [[Value(random.uniform(-0.1, 0.1)) for _ in range(d_model)] for _ in range(vocab_size)]

params = [p for row in emb for p in row] + [p for row in w_out for p in row]
optimizer = Adam(params, lr=0.1)

# 3. 訓練迴圈
for epoch in range(101):
    total_loss = Value(0.0)
    
    # 給定前一個字元，預測下一個字元
    for i in range(len(tokens) - 1):
        x_id = tokens[i]
        y_id = tokens[i+1]
        
        # Forward pass
        x_emb = emb[x_id]             # 1. 取得 Embedding
        x_norm = rmsnorm(x_emb)       # 2. RMS Normalization
        logits = linear(x_norm, w_out)# 3. 輸出層 (對應各個字元的 logit)
        probs = softmax(logits)       # 4. 機率分佈
        
        # Loss 計算
        loss_t = -probs[y_id].log()
        total_loss += loss_t
        
    loss = total_loss / (len(tokens) - 1)
    
    # Backward pass & Update
    loss.backward()
    optimizer.step()
    
    if epoch % 20 == 0:
        print(f"Epoch {epoch:3d} | Loss: {loss.data:.4f}")

# 4. 簡易推論測試：輸入 'a' 預期會預測出 'p'
test_id = token_to_id['a']
logits = linear(rmsnorm(emb[test_id]), w_out)
probs = softmax(logits)
pred_id = probs.index(max(probs, key=lambda x: x.data))
print(f"測試輸入 'a' -> 預測下一個字元: '{vocab[pred_id]}'")