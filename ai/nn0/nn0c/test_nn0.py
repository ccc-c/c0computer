import sys
import os
from nn0 import nn0

# =====================================================================
# 4. 測試案例：簡單的參數優化 (找到 w 使得 w * 2.0 = 6.0)
# =====================================================================
def run_test():
    print("初始化神經網路與記憶體池...")

    # 初始化一個參數 w (初始值設為 1.0)
    # 注意：你的 C 程式碼中 new_param 是用 malloc 分配，不會被 arena_reset 清除
    w = nn0.new_param(1.0)
    
    # 初始化 Adam 優化器
    nn0.init_optimizer()

    epochs = 100
    learning_rate = 0.5

    print(f"初始權重 w = {w.contents.data:.4f}")
    print("開始訓練...\n")

    for epoch in range(epochs):
        # 每個 epoch 重置運算圖的記憶體池
        # 這會清理掉前一次的 x, target, pred, diff, loss 等 new_value 節點
        nn0.arena_reset()

        # 建立輸入資料與目標值
        x = nn0.new_value(2.0)
        target = nn0.new_value(6.0)

        # 前向傳播 (Forward pass): pred = w * x
        pred = nn0.mul(w, x)

        # 計算損失 Loss = (pred - target)^2
        neg_target = nn0.neg(target)
        diff = nn0.add(pred, neg_target)
        loss = nn0.power(diff, 2.0)

        # 反向傳播 (Backward pass)
        nn0.zero_grad()  # 清空參數的 visited 狀態
        nn0.backward(loss)

        # 使用 Adam 更新參數
        # C 函式簽名: step_adam(int step, int num_steps, double learning_rate)
        nn0.step_adam(epoch, epochs, learning_rate)

        # 每 10 個 Epoch 印出一次進度
        if epoch % 10 == 0 or epoch == epochs - 1:
            print(f"Epoch {epoch:3d}/{epochs}: Loss = {loss.contents.data:.6f}, w = {w.contents.data:.6f}")

    print("\n訓練結束！")
    print(f"最終權重 w = {w.contents.data:.4f} (預期應逼近 3.0000)")

if __name__ == "__main__":
    run_test()