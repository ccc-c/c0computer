# c0computer -- 用 C 重建簡易電腦工業

## 語言與格式

* c0 -- 簡化後的 C 語言，副檔名為 .c
* py0 -- 簡化後的 Python 語言，副檔名為 .py
* ll0 -- 簡化後的 LLVM IR 文字格式，副檔名為 .ll
* qd0 -- 動態語言虛擬機，採用 quadruple 四元組格式，副檔名為 .qd

## 實作工具

* compiler -- 編譯器
    * [x] pcmake -- 專案建置工具，採用 python 語法寫 Pcmakefile 建置檔 (ccc 用 AI 建構)
    * [x] c0c -- c0 之編譯器，類似 gcc (ccc 用 AI 建構)
    * [x] py0c -- py0 之編譯器，輸出 qd 檔案 (ccc 用 AI 建構)
    * [x] qd0c -- qd0 轉為 ll0 的編譯器 (ccc 用 AI 建構)
    * [x] qd0lib -- qd0 的指令呼叫與函式庫 (ccc 用 AI 建構)
    * [ ] ll0i -- ll0 中間碼虛擬機，類似 lli (ccc 用 AI 建構)
    * [ ] ll0c -- 簡化後的 LLVM IR 中間碼組譯器，類似 llc (ccc 用 AI 建構)
* ai -- 人工智慧
    * [x] nn -- 神經網路套件，類似 pytorch. (取自 kaparthy microgpt 重新模組化)
    * [x] llm -- 語言模型，類似 GPT (取自 kaparthy microgpt 重新模組化)
    * [x] agent -- 代理人，類似 OpenClaw (取自 dabit3 mini-openclaw)
* os -- 作業系統
    * [x] 用 c 寫的 RISCV 處理器上之作業系統，來自 MIT xv6
* cpu -- 處理器
    * [ ] RISCV 處理器之 Verilog0 原始碼
* net -- 網路相關
    * [x] telnet -- 重新實作 telnet (ccc 用 AI 建構)
    * [x] browser -- 簡易瀏覽器 (ccc 用 AI 建構)
* hardware -- 硬體相關
    * [ ] cpu -- RISCV (未來可能會補上)
    * [ ] eda -- verilog 工具 (未來可能會補上)



