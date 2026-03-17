# c0computer -- 用 C + Python 打造簡易電腦工業

> 包含：編譯器 (C) + 解譯器 (Python) + 作業系統 + 網路 Web + 人工智慧

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
    * nn0.c 神經網路後端，gpt0.c 語言模型
2. 用 py0 寫的應用程式
    * py0i 解譯器
    * fastapi0 框架
    * nn0.py, gpt0.py 神經網路前端 (會呼叫 nn0.c, gpt0.c)
    * agent0 代理人（類似 openclaw)

## 語言與格式

* c0 -- 簡化後的 C 語言，副檔名為 .c
* py0 -- 簡化後的 Python 語言，副檔名為 .py
* ll0 -- 簡化後的 LLVM IR 文字格式，副檔名為 .ll
* qd0 -- 動態語言虛擬機，採用 quadruple 四元組格式，副檔名為 .qd
* rv0 -- RISCV 指令集簡化版

## 實作工具

[c0]:compiler/c0/
[py0]:compiler/py0/
[qd0]:compiler/qd0/
[ll0]:compiler/ll0/
[rv0]:compiler/rv0/

[c0c]:compiler/c0/c0c/
[py0c]:compiler/py0/py0c/
[py0i]:compiler/py0/py0i/
[qd0c]:compiler/qd0/qd0c/
[qd0lib]:compiler/qd0/qd0c/qd0lib.c
[ll0i]:compiler/ll0/ll0i/
[ll0c]:compiler/ll0/ll0c/
[rv0as]:compiler/rv0as/

* compiler -- 編譯器
    * [x] [pcmake] -- 專案建置工具，採用 python 語法寫 Pcmakefile 建置檔 (ccc 用 AI 建構)
    * [x] [c0c] -- c0 之編譯器，類似 gcc (C 語言:ccc 用 AI 建構)
    * [x] [py0c] -- py0 之編譯器，輸出 qd 檔案 (C 語言:ccc 用 AI 建構)
    * [x] [py0i] -- py0 的解譯器，可以直接執行 .py 的檔案 (Python: ccc 用 AI 建構，但先用 [py0c] 編譯為 py0c.o ，交由 [rv0vm] 執行)
    * [x] [qd0c] -- qd0 轉為 ll0 的編譯器 (C 語言:ccc 用 AI 建構)
    * [x] [qd0lib] -- qd0 的指令呼叫與函式庫 (C 語言:ccc 用 AI 建構)
    * [x] [ll0i] -- ll0 中間碼虛擬機，類似 lli (C 語言:ccc 用 AI 建構)
    * [x] [ll0c] -- 簡化後的 LLVM IR 中間碼組譯器，類似 llc (C 語言:ccc 用 AI 建構)
    * [x] [rv0] 工具鏈 -- 包含 [rv0as.c], [rv0vm.c], [rv0objdump.c] (C語言:ccc 用 AI 建構)

[xv6]:os/xv6
[xv6-riscv]:https://github.com/mit-pdos/xv6-riscv
[os0]:os/os0
[nstack]:https://github.com/jserv/nstack
[tcpip0]:os/os0/tcpip0/

* os -- 作業系統
    * [x] [xv6] -- 在 RISC-V 上移植自 UNIXv6 的作業系統 (C語言：來自 MIT [xv6-riscv] )
    * [ ] [os0] -- 擴充 [xv6] 的作業系統，支援 [tcpip0] (C語言:融合 jserv [nstack] 專案) 

[pcmake]:compiler/pcmake/

* tool -- 專案工具
    * [x] [pcmake] --  (Python:類似 c 工具鏈中的 make，但是用 Python 的想法設計) 
    * [ ] [git0] -- (C語言：構想中)
    * [ ] [docker0] -- (C語言：構想中)

[nn0]:ai/nn0/
[gpt0]:ai/gpt0/
[agent0]:ai/agent0/
[nn0.py]:ai/nn0/nn0.py
[gpt0.py]:ai/gpt0/gpt0.py
[nn0.c]:ai/nn0/nn0.c
[gpt0.c]:ai/gpt0/gpt0.c
[agent0.py]:ai/agent0/agent0.py

[microgpt]:https://gist.github.com/karpathy/8627fe009c40f57531cb18360106ce95
[mini-openclaw]:https://gist.github.com/dabit3/86ee04a1c02c839409a02b20fe99a492

* ai -- 人工智慧
    * [x] [nn0] -- 神經網路套件，類似 pytorch.
        * [nn0.py] + [nn0.c] :取自 kaparthy [microgpt] 重新模組化，然後用 AI 重寫為 C
    * [x] [gpt0] -- 語言模型
        * [gpt0.py] + [gpt0.c] : 取自 kaparthy [microgpt] 重新模組化，然後用 AI 重寫為 C)
    * [x] [agent0] -- 代理人，類似 OpenClaw
        * [agent0.py] :取自 dabit3 [mini-openclaw]

[telnet0]:web/telnet0/
[webserver0]:web/webserver0/
[fastapi0]:web/fastapi0/
[browser0]:web/browser0/

* web -- 網路相關
    * [x] [telnet0] -- 重新實作 telnet (C語言:ccc 用 AI 建構)
    * [x] [webserver0] -- 簡易 web server (C語言:ccc 用 AI 建構)
    * [x] [fastapi0] -- 簡易版網站框架，類似 fastapi (Python:ccc 用 AI 建構)
    * [ ] [browser0] -- (C 語言：構想中 ...)

