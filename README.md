# c0computer -- 用 C + Python 打造簡易電腦工業

> 包含：編譯器/解譯器 + 作業系統 + 網路 + 人工智慧 + 計算理論 + 硬體與虛擬機

## 工具流程

自製 C 語言編譯器 c0c 的使用流程

    c0c fact.c -o fact.ll # 編譯 fact.c 為 fact.ll
    ll0c fact.ll -o fact.o # 將 fact.ll 轉換為 RISC-V 上的目的檔
    rv0vm fact.o # RISC-V 虛擬機 rv0vm 執行 fact.o 

自製 Python 語言編譯器 py0c 的使用流程

    py0c fact.py -o fact.qd # 編譯 fact.py 為 fact.qd
    qd0c fact.qd -o fact.ll # 轉換 fact.qd 為 fact.ll
    ll0c fact.ll qd0lib.o -o fact.o  # 將 fact.ll 轉換為 RISC-V 上的目的檔（連結 qd0lib.o)
    rv0vm fact.o  # RISC-V 虛擬機 rv0vm 執行 fact.o 

然後我們會將 xv6-riscv 作業系統，修改為 os0

有了上述兩個工具，以及 os0 之後，我們就可以在上面建構出

1. 用 c0 寫的系統程式，包含
    * tcpip0 堆疊：包含 socket 網路函式庫，接著建構應用 telnet/webserver/...
    * nn0.c 神經網路後端
2. 用 py0 寫的應用程式
    * py0i 解譯器
    * fastapi0 框架
    * torch0 神經網路前端

## 語言與格式

* c0 -- 簡化後的 C 語言，副檔名為 .c
* py0 -- 簡化後的 Python 語言，副檔名為 .py
* ll0 -- 簡化後的 LLVM IR 文字格式，副檔名為 .ll
* qd0 -- 動態語言虛擬機，採用 quadruple 四元組格式，副檔名為 .qd
* rv0 -- RISCV 指令集簡化版

## 實作工具

[pcmake]:compiler/pcmake/
[c0c]:compiler/c0/c0c/
[py0c]:compiler/py0/py0c/
[qd0c]:compiler/qd0/qd0c/
[qd0lib]:compiler/qd0/qd0c/qd0lib.c
[ll0i]:compiler/ll0/ll0i/
[ll0c]:compiler/ll0/ll0c/
[rv0as]:compiler/rv0as/

* compiler -- 編譯器
    * [x] [pcmake] -- 專案建置工具，採用 python 語法寫 Pcmakefile 建置檔 (ccc 用 AI 建構)
    * [x] [c0c] -- c0 之編譯器，類似 gcc (C 語言:ccc 用 AI 建構)
    * [x] [py0c] -- py0 之編譯器，輸出 qd 檔案 (C 語言:ccc 用 AI 建構)
    * [x] [qd0c] -- qd0 轉為 ll0 的編譯器 (C 語言:ccc 用 AI 建構)
    * [x] [qd0lib] -- qd0 的指令呼叫與函式庫 (C 語言:ccc 用 AI 建構)
    * [x] [ll0i] -- ll0 中間碼虛擬機，類似 lli (C 語言:ccc 用 AI 建構)
    * [ ] [ll0c] -- 簡化後的 LLVM IR 中間碼組譯器，類似 llc (C 語言:ccc 用 AI 建構)
    * [x] [rv0] 工具鏈 -- 包含 [rv0as.c], [rv0vm.c], [rv0objdump.c] (C語言:ccc 用 AI 建構)

[xv6]:os/xv6
[xv6-riscv]:https://github.com/mit-pdos/xv6-riscv

* os -- 作業系統
    * [x] [xv6] -- 用 c 寫的 RISCV 處理器上之作業系統 (C語言：來自 MIT [xv6-riscv] )
    * [ ] [os0] -- 擴充 [xv6] 的作業系統，支援 [tcpip0] (C語言:融合 jserv [nstack] 專案) 

[picorv32]:hardware/cpu/picorv32/
[mcu0]:hardware/cpu/mcu0/
[cpu0]:hardware/cpu/cpu0/
[hackcpu]:hardware/cpu/hackcpu/
[vvp0i]:hardware/eda/vvpi/
[picorv32]:https://github.com/YosysHQ/picorv32

* hardware -- 硬體相關
    * [x] [picorv32] -- RISC-V picorv32 處理器 (來自 YosysHQ 的 [picorv32] 專案)
    * [x] [mcu0] -- 16位元簡易處理器 (verilog:ccc 自行撰寫)
    * [x] [cpu0] -- 32位元處理器 (verilog:ccc 自行撰寫)
    * [x] [hackcpu] -- 16位元處理器 (verilog: nand2terris 課程，ccc 自行撰寫)
    * [x] [vvp0i] -- verilog 中間碼虛擬機 (C語言:ccc 用 AI 建構)

[nn]:ai/nn/
[llm]:ai/llm/
[agent]:ai/agent/
[microgpt]:https://gist.github.com/karpathy/8627fe009c40f57531cb18360106ce95
[mini-openclaw]:https://gist.github.com/dabit3/86ee04a1c02c839409a02b20fe99a492

* ai -- 人工智慧
    * [x] [nn] -- 神經網路套件，類似 pytorch.
        * [nn.py](ai/nn/nn.py) + [nn.c](ai/nn/nn.c) :取自 kaparthy [microgpt] 重新模組化，然後用 AI 重寫為 C
    * [x] [llm] -- 語言模型，類似 GPT 
        * [gpt.py](ai/llm/gpt.py) + [gpt.c](ai/llm/gpt.c) : 取自 kaparthy [microgpt] 重新模組化，然後用 AI 重寫為 C)
    * [x] [agent] -- 代理人，類似 OpenClaw
        * [mini-openclaw.c](ai/agent/mini-openclaw.py) :取自 dabit3 [mini-openclaw]

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


[basic]:interpreter/basic/
[lisp]:interpreter/lisp/
[prolog]:interpreter/prolog

* interpreter -- 解譯器
    * [x] [basic] -- basic 語言解譯器 (Python:ccc 用 AI 建構)
    * [x] [lisp] -- lisp 語言解譯器 (Python:ccc 用 AI 建構)
    * [x] [prolog] -- prolog 語言解譯器 (Python:ccc 用 AI 建構)

[telnet]:net/telnet/
[webserver]:net/webserver/
[tcp/ip stack]:net/tcpip_stack/README.md
[nstack]:https://github.com/jserv/nstack

* net -- 網路相關
    
    * [x] [telnet] -- 重新實作 telnet (C語言:ccc 用 AI 建構)
    * [x] [webserver] -- 簡易 web server (C語言:ccc 用 AI 建構)

