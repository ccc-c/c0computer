# 5. 開發工具安裝與設定

## 5.1 必要的軟體

### 5.1.1 RISC-V cross-compiler

RISC-V 的 C 編譯器，用於編譯 xv6 核心和使用者程式：

```bash
# Ubuntu/Debian
sudo apt-get install gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu
```

### 5.1.2 QEMU

QEMU 模擬器，執行 xv6-ext：

```bash
# Ubuntu/Debian
sudo apt-get install qemu-system-misc
```

### 5.1.3 其他工具

```bash
# 必要工具
sudo apt-get install make git gcc

# 測試工具
sudo apt-get install tmux netcat-openbsd curl
```

## 5.2 編譯環境變數

### 5.2.1 TOOLPREFIX

指定編譯器前綴：

```bash
export TOOLPREFIX=riscv64-linux-gnu-
```

完整編譯指令：

```bash
make TOOLPREFIX=riscv64-linux-gnu-
```

### 5.2.2 Makefile 說明

```makefile
# 工具鏈前綴
TOOLPREFIX = riscv64-linux-gnu-

# 編譯器
CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gas
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump
```

## 5.3 取得程式碼

### 5.3.1 Git clone

```bash
# Clone xv6-ext
git clone https://github.com/pandax381/xv6-ext

# 進入目錄
cd xv6-ext
```

## 5.4 編譯 xv6

### 5.4.1 完整編譯

```bash
make clean
make TOOLPREFIX=riscv64-linux-gnu-
```

### 5.4.2 只編譯核心

```bash
make TOOLPREFIX=riscv64-linux-gnu- kernel
```

### 5.4.3 只編譯使用者程式

```bash
make TOOLPREFIX=riscv64-linux-gnu- fs.img
```

### 5.4.4 編譯選項

| 選項 | 說明 |
|------|------|
| `-j N` | 使用 N 個平列編譯 |
| `clean` | 清理編譯產物 |
| `V=1` | 顯示詳細編譯過程 |

## 5.5 專案目錄結構

```
xv6-ext/
├── kernel/              # 核心程式碼
│   ├── Makefile        # 核心 Makefile
│   ├── *.c, *.h        # C 原始碼
│   ├── *.S             # 組合語言
│   ├── net/            # 網路程式碼
│   │   └── platform/  # VirtIO 平台特定
│   └── kernel.ld       # 連結腳本
├── user/               # 使用者程式
│   ├── *.c             # C 原始碼
│   ├── *.S             # 組合語言
│   └── *.pl            # Perl 脚本
├── mkfs/               # 檔案系統工具
├── Makefile            # 頂層 Makefile
└── README              # 說明文件
```

## 5.6 常見編譯錯誤

### 5.6.1 找不到編譯器

```
*** Error: Couldn't find a riscv64 version of GCC/binutils.
```

解決：確認已安裝 `gcc-riscv64-linux-gnu`

### 5.6.2 權限不足

```
Permission denied
```

解決：確保目錄可寫入，或使用sudo

### 5.6.3 缺少函式庫

解決：安裝必要套件

## 5.7 開發建議

### 5.7.1 使用 tmux

tmux 可以讓我們在單一終端機中管理多個會話：

```bash
# 啟動新會話
tmux new -s xv6

# 分割視窗
tmux split

# 切換視窗
tmux select-pane -U
```

### 5.7.2 自動化腳本

編寫測試腳本减少重複工作：

```bash
#!/bin/bash
make clean
make TOOLPREFIX=riscv64-linux-gnu-
make qemu
```

## 5.8 小結

本章節介紹了：
- 必要軟體的安裝
- 編譯環境的設定
- 程式碼的取得與編譯
- 常見問題的解決

下一章將介紹如何實際執行 QEMU。