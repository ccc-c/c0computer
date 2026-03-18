請先加入原子指令集 RV64A

但是目前 c0c 編譯器無法支援內崁組合語言

所以請用 compiler/_data/test_xxx.asm 的方式寫一些組合語言範例

然後用 rv0as 去組譯，用 rv0vm 去執行，用 rv0objdump 去檢視

修改 rv0as.c, rv0vm.c 與 rv0objdump.c 以完成這些測試

最後在 compiler/_doc/test_report.md 寫下完整的修改說明文件，以及測試結果報告。

不需要再問我，持續修改直到完成這個任務
