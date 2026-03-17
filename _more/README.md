# 本專案的擴展項目

> 解譯器 + 計算理論 + 硬體 + EDA + 經典工具

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

* tool -- 經典工具
    * [ ] [git0] / [docker0] / ....
    
    * [x] [telnet] -- 重新實作 telnet (C語言:ccc 用 AI 建構)
    * [x] [webserver] -- 簡易 web server (C語言:ccc 用 AI 建構)

