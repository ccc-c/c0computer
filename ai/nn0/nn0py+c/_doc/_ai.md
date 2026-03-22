## 接下來

Q: 為何 nn0.py 裡沒有 Tensor 等物件，nn 卻可以用下列指令引入呢？

from nn0 import Tensor, matmul, ones, zeros



1. 把 CNN 相關物件函數從 nn.py 中獨立出來，放在 cnn.py 中
2. 目前框架已經包含 Attention 和 Transformer 需要的 Block 了嗎？如果沒有，請先將這些模組加入，放到 transformer.py 中。
3. 寫一個 CharGPT 的示範程式，放在 examples/chargpt.py 裡面，輸入檔必須能用命令列參數指定，用 /Users/Shared/ccc/c0computer/ai/nn0/_data/corpus/chinese.txt 來做 CharGPT 的訓練 train 和預測 predict 之測試。(predict 就預測輸出 1000 字)