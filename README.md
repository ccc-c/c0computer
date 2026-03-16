# c0computer -- 用 C 重建簡易電腦工業

## 語言與格式

* c0 -- 簡化後的 C 語言，副檔名為 .c
* py0 -- 簡化後的 Python 語言，副檔名為 .py
* ll0 -- 簡化後的 LLVM IR 文字格式，副檔名為 .ll
* qd0 -- 動態語言虛擬機，採用 quadruple 四元組格式，副檔名為 .qd
* rv0 -- RISCV 指令集簡化版

## 實作工具

[pcmake]:compiler/pcmake/
[c0c]:compiler/c0c/
[py0c]:compiler/py0c/
[qd0c]:compiler/qd0c/
[qd0lib]:compiler/qd0c/qd0lib.c
[ll0i]:compiler/ll0i/
[ll0c]:compiler/ll0c/
[rv0asm]:compiler/rv0asm/

* compiler -- 編譯器
    * [x] [pcmake] -- 專案建置工具，採用 python 語法寫 Pcmakefile 建置檔 (ccc 用 AI 建構)
    * [x] [c0c] -- c0 之編譯器，類似 gcc (C 語言:ccc 用 AI 建構)
    * [x] [py0c] -- py0 之編譯器，輸出 qd 檔案 (C 語言:ccc 用 AI 建構)
    * [x] [qd0c] -- qd0 轉為 ll0 的編譯器 (C 語言:ccc 用 AI 建構)
    * [x] [qd0lib] -- qd0 的指令呼叫與函式庫 (C 語言:ccc 用 AI 建構)
    * [x] [ll0i] -- ll0 中間碼虛擬機，類似 lli (C 語言:ccc 用 AI 建構)
    * [ ] [ll0c] -- 簡化後的 LLVM IR 中間碼組譯器，類似 llc (C 語言:ccc 用 AI 建構)
    * [x] [rv0asm] -- rv0 的組譯器 (Python:ccc 用 AI 建構)

[basic]:interpreter/basic/
[lisp]:interpreter/lisp/
[prolog]:interpreter/prolog

* interpreter -- 解譯器
    * [x] [basic] -- basic 語言解譯器 (Python:ccc 用 AI 建構)
    * [x] [lisp] -- lisp 語言解譯器 (Python:ccc 用 AI 建構)
    * [x] [prolog] -- prolog 語言解譯器 (Python:ccc 用 AI 建構)

[xv6]:os/xv6

* os -- 作業系統
    * [x] [xv6] -- 用 c 寫的 RISCV 處理器上之作業系統 (C語言：來自 MIT xv6-riscv)

[telnet]:net/telnet/
[webserver]:net/webserver/

* net -- 網路相關
    * [x] [telnet] -- 重新實作 telnet (C語言:ccc 用 AI 建構)
    * [x] [browser] -- 簡易瀏覽器 (C語言:ccc 用 AI 建構)

[picorv32]:hardware/cpu/picorv32/
[mcu0]:hardware/cpu/mcu0/
[cpu0]:hardware/cpu/cpu0/
[hackcpu]:hardware/cpu/hackcpu/
[vvpi]:hardware/eda/vvpi/

* hardware -- 硬體相關
    * [x] [picorv32] -- RISC-V picorv32 處理器 (來自 YosysHQ 的 picorv32 專案)
    * [x] [mcu0] -- 16位元簡易處理器 (verilog:ccc 自行撰寫)
    * [x] [cpu0] -- 32位元處理器 (verilog:ccc 自行撰寫)
    * [x] [hackcpu] -- 16位元處理器 (verilog: nand2terris 課程，ccc 自行撰寫)
    * [x] [vvp0i] -- verilog 中間碼虛擬機 (C語言:ccc 用 AI 建構)

[nn]:ai/nn/
[llm]:ai/llm/
[agent]:ai/agent/

* ai -- 人工智慧
    * [x] [nn] -- 神經網路套件，類似 pytorch. (Python:取自 kaparthy microgpt 重新模組化)
    * [x] [llm] -- 語言模型，類似 GPT (Python:取自 kaparthy microgpt 重新模組化)
    * [x] [agent] -- 代理人，類似 OpenClaw (Python:取自 dabit3 mini-openclaw)

[finiteStateMachine]:theory/finiteStateMachine/
[turingMachine]:theory/turingMachine/
[grammar]:theory/grammar/
[lambdaCalculus]:theory/lambdaCalculus/
[lambdaInterpreter]:theory/lambdaInterpreter/

* theory -- 計算理論
    * [x] [finiteStateMachine] -- 有限狀態機 (Python:ccc 自行撰寫)
    * [x] [turingMachine] -- 圖靈機 (Python:ccc 自行撰寫)
    * [x] [grammar] -- 生成語法 (Python:ccc 自行撰寫)
    * [x] [lambdaCalculus] -- lambda 函數編程 (Python:ccc 從 JavaScript 專案改過來的)
    * [x] [lambdaInterpreter] -- lambda 解譯器 (Python:ccc 用 AI 建構)
