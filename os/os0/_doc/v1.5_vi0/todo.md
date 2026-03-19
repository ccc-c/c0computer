## ccc問：

/Users/Shared/ccc/c0computer/tool/vi0/vi0.c 這個程式，有可能加到 os0 作業系統當中嗎？
vi0.c 有用到

#include <termios.h>
#include <unistd.h>
#include <sys/select.h>

 xv6 和延伸後的 os0 應該沒有這些套件，要怎麼修改才行呢？請先提出計劃，寫在

 /Users/Shared/ccc/c0computer/os/os0/_doc/v1.5_vi0/plan.md 中


...

## ccc: 

好，那就開始支援 raw mode，然後把 vi0.c 加進去

最後在 compiler/_doc/test_report.md 寫下完整的修改說明文件，以及測試結果報告。

不需要再問我，持續修改直到完成 raw mode 和 vi0.c 這些任務
