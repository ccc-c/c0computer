# v1.5 vi0 移植報告

## 概述

本專案將 vi0.c（基於 POSIX 的終端機文字編輯器）移植到 os0（基於 xv6-riscv 的作業系統）。

## 問題分析

vi0.c 使用以下 POSIX 標準庫，xv6-riscv (os0) 不支援：

| 原始標頭 | 功能說明 | os0 替代方案 |
|----------|----------|--------------|
| `termios.h` | 終端機 raw mode 控制 | 新增 kernel 支援 |
| `unistd.h` | `read()`, `STDIN_FILENO` | os0 已有 `read(0, buf, n)` |
| `sys/select.h` | `select()` 非同步輸入檢查 | 新增 `kbhit()` syscall |

## 修改的檔案

### 1. kernel/syscall.h
新增系統呼叫編號：
```c
#define SYS_enable_raw_mode 31
#define SYS_disable_raw_mode 32
#define SYS_kbhit 33
```

### 2. kernel/console.c
- 在 `cons` 結構中新增 `raw_mode` 標記
- 修改 `consoleread()` 支援 raw mode（每個字元立即返回）
- 修改 `consoleintr()` 在 raw mode 下立即 wakeup reader
- 新增三個系統呼叫：
  - `sys_enable_raw_mode()`: 啟用 raw mode
  - `sys_disable_raw_mode()`: 停用 raw mode
  - `sys_kbhit()`: 檢查是否有鍵盤輸入

### 3. kernel/syscall.c
- 新增外部函式宣告
- 在 syscalls 陣列中註冊新系統呼叫

### 4. kernel/defs.h
新增函式宣告：
```c
uint64 sys_enable_raw_mode(void);
uint64 sys_disable_raw_mode(void);
uint64 sys_kbhit(void);
```

### 5. user/usys.pl
新增系統呼叫條目：
```perl
entry("enable_raw_mode");
entry("disable_raw_mode");
entry("kbhit");
```

### 6. user/usys.S
自動生成，包含三個新系統呼叫的 assembly stub

### 7. user/user.h
新增函式宣告：
```c
int enable_raw_mode(void);
int disable_raw_mode(void);
int kbhit(void);
```

### 8. user/vi.c
移植後的 vi 編輯器，主要修改：
- 使用 `kernel/types.h` 和 `user/user.h`
- 替換 `snprintf()` 為自訂字串函式
- 替換 `putchar()` 為 `write(1, &c, 1)`
- 移除 `fflush()` 和 `sscanf()` 呼叫
- 使用 os0 的系統呼叫介面

### 9. Makefile
在 `UPROGS` 中新增 `$U/_vi`

## 編譯結果

```
riscv64-unknown-elf-gcc ... -c -o user/vi.o user/vi.c
riscv64-unknown-elf-ld ... -o user/_vi user/vi.o user/ulib.o user/usys.o user/printf.o user/umalloc.o
mkfs/mkfs fs.img README user/_cat ... user/_vi
```

編譯成功，生成 `user/_vi`（67,280 bytes）。

## Raw Mode 運作原理

### Cooked Mode（預設）
- 使用者輸入的字元先存到緩衝區
- 必須按下 Enter 才會送到程式
- Backspace、Ctrl+C 由 OS 處理

### Raw Mode
- 每按一個鍵就立即送到程式
- 不需要 Enter
- 程式自己處理所有鍵盤事件

## 測試方式

1. 啟動 QEMU：
   ```bash
   cd os0
   make qemu
   ```

2. 在 shell 中執行 vi：
   ```
   vi test.txt
   ```

3. 使用方式：
   - `i` - 進入插入模式
   - `Esc` - 離開插入模式
   - `h/j/k/l` - 左右上下移動
   - `:` - 進入命令列模式
   - `:w` - 儲存檔案
   - `:q` - 離開
   - `:wq` - 儲存並離開
   - `x` - 刪除字元
   - `Backspace` - 刪除前一個字元

## 結論

成功將 vi0.c 移植到 os0，並在 kernel 中新增 raw mode 支援。vi 編輯器現在可以在 os0 上執行，提供基本的文字編輯功能。
