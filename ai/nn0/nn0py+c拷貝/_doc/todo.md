# nn0 擴充计划

## 現有功能

### C 核心 (num0ad.c)
- 張量運算: add, sub, mul, div, neg, exp, log, relu, abs, sqrt, pow, sum, mean
- 矩陣運算: matmul, dot, reshape, flatten
- 純量運算: scalar_add, scalar_mul
- 反向傳播: backward (含 visited 機制避免重複釋放)

### Python 包裝層 (nn0.py, nn.py)
- Tensor 類別
- Module 基類、Linear、ReLU、Sigmoid、Tanh、LeakyReLU、Softmax、MSELoss、CrossEntropyLoss、BCELoss、L1Loss
- SGD (含 momentum)、Adam 優化器
- no_grad、manual_seed、clone、tolist 工具函數
- 範例: train_xor.py

---

## 短期目標 (1-2週)

### 1. 激勵函數增補
- [x] Sigmoid: `σ(x) = 1 / (1 + exp(-x))`
- [x] Tanh: `tanh(x) = (exp(x) - exp(-x)) / (exp(x) + exp(-x))`
- [x] LeakyReLU: `f(x) = x if x > 0 else α*x`
- [x] Softmax: 現有 softmax() 整合為 Module

### 2. 損失函數增補
- [x] CrossEntropyLoss (整合現有 cross_entropy)
- [x] BCELoss (Binary Cross Entropy)
- [x] L1Loss

### 3. 優化器增補
- [x] Adam: 自適應學習率
- [x] SGD with Momentum

### 4. 工具函數
- [x] `no_grad()` 上下文管理器 (推論時停用梯度)
- [x] `manual_seed()` 亂數種子控制
- [x] Tensor.clone()
- [x] Tensor.tolist()

---

## 中期目標 (1-2月)

### 1. 網路容器
- [ ] Sequential: 簡化模型堆疊
- [ ] ModuleList: 動態層列表
- [ ] ModuleDict: 動態層字典

### 2. 卷積層
- [ ] Conv1d (文字、訊號)
- [ ] Conv2d (影像)
- [ ] MaxPool1d, MaxPool2d
- [ ] AvgPool2d

### 3. 正規化層
- [ ] BatchNorm1d
- [ ] BatchNorm2d
- [ ] LayerNorm

### 4. 學習率排程
- [ ] StepLR
- [ ] CosineAnnealingLR
- [ ] ReduceLROnPlateau

### 5. 模型持久化
- [ ] model.save(path)
- [ ] model.load(path)

### 6. 資料處理
- [ ] Dataset 抽象類別
- [ ] DataLoader (batch, shuffle, num_workers)

### 7. 訓練工具
- [ ] train() 通用訓練迴圈
- [ ] evaluate() 評估函數

---

## 長期目標 (3-6月)

### 1. GPU 支援
- [ ] CUDA 張量封裝
- [ ] .to('cuda') / .to('cpu')
- [ ] 自動 GPU 偵測

### 2. RNN 層
- [ ] RNN
- [ ] LSTM
- [ ] GRU

### 3. 注意力機制
- [ ] MultiHeadAttention
- [ ] TransformerEncoderLayer

### 4. 進階優化器
- [ ] AdamW (weight decay)
- [ ] RMSprop
- [ ] Adagrad

### 5. 混合精度訓練
- [ ] FP16 支援
- [ ] GradScaler

### 6. 分散式訓練
- [ ] DataParallel
- [ ] 多卡訓練

### 7. 範例與基準
- [ ] MNIST 分類
- [ ] CIFAR-10 分類
- [ ] 簡單語言模型

---

## 技術債務
- [x] 統一 nn0.py 與 nn0clib.py (移除重複程式碼)
- [x] 加入型別提示 (type hints)
- [x] 完整單元測試覆蓋
- [x] 效能基準測試

---

## 備註
- 優先順序: 短期 > 中期 > 長期
- 每個功能需附帶單元測試
- 保持 API 與 PyTorch 相容性
