# 6. QEMU 虛擬機執行

## 6.1 啟動 xv6

### 6.1.1 基本啟動

```bash
make qemu
```

這會啟動 QEMU 並載入 xv6-ext核心。

### 6.1.2 完整指令

```bash
qemu-system-riscv64 \
    -machine virt \
    -bios none \
    -kernel kernel/kernel \
    -m 128M \
    -smp 3 \
    -nographic \
    -global virtio-mmio.force-legacy=false \
    -drive file=fs.img,if=none,format=raw,id=x0 \
    -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 \
    -netdev tap,ifname=tap0,id=en0 \
    -device virtio-net-device,netdev=en0
```

## 6.2 QEMU 選項說明

| 選項 | 說明 |
|------|------|
| `-machine virt` | RISC-V virt 機器 |
| `-bios none` | 不使用 BIOS |
| `-kernel` | 指定核心映像 |
| `-m 128M` | 記憶體大小 |
| `-smp 3` | CPU 核心數 |
| `-nographic` | 不使用圖形 |
| `-netdev tap` | TAP 網路裝置 |

## 6.3 與 QEMU 互動

### 6.3.1 退出 QEMU

按 `Ctrl+a` 然後按 `x` 退出。

### 6.3.2 發送特殊按鍵

- `Ctrl+a c`: 切換到 QEMU monitor
- `Ctrl+a x`: 退出 QEMU

## 6.4 使用 GDB 除錯

### 6.4.1 啟動 GDB

```bash
make qemu-gdb
```

這會啟動 QEMU 並等待 GDB 連接。

### 6.4.2 連線 GDB

```bash
riscv64-linux-gnu-gdb kernel/kernel
(gdb) target remote localhost:25000
```

## 6.5 開機流程

### 6.5.1 系統日誌

xv6 開機時會顯示詳細的初始化訊息：

```
xv6 kernel is booting
2026/03/22 12:00:00
[I] net_protocol_register: registered, type=0x0800
[I] net_init: initialized
[D] virtio_net_init: device found
[I] virtio_net_init: initialized, addr=52:54:00:12:34:56
[I] net_device_open: dev=net0, state=up
hart 1 starting
hart 2 starting
init: starting sh
$
```

### 6.5.2 核心初始化

1. **硬體初始化**： UART、PLIC、VirtIO
2. **記憶體配置**：頁表、實體記憶體
3. **行程系統**：建立第一個行程
4. **網路初始化**：網路驅動程式、協定註冊

## 6.6 基本的 xv6 指令

### 6.6.1 檔案操作

```bash
ls          # 列出檔案
cat <file>  # 顯示檔案內容
echo <text> # 輸出文字
mkdir <dir> # 建立目錄
rm <file>   # 刪除檔案
```

### 6.6.2 程序操作

```bash
ps          # 顯示程序
kill <pid> # 終止程序
```

### 6.6.3 網路操作

```bash
ifconfig    # 網路介面設定
udpecho     # UDP Echo 伺服器
tcpecho     # TCP Echo 伺服器
httpd       # HTTP 伺服器
curl        # HTTP 客戶端
```

## 6.7 疑難排解

### 6.7.1 QEMU 無法啟動

檢查：
- QEMU 是否正確安裝
- 核心映像是否存在

### 6.7.2 網路無法運作

確認：
- tap0 是否正確設定
- IP 是否正確配置

### 6.7.3 效能問題

調整：
- 增加記憶體：`-m 256M`
- 增加 CPU：`-smp 4`

## 6.8 小結

本章介紹了：
- QEMU 啟動方式
- 與 QEMU 互動方法
- 開機流程和日誌解讀
- 基本的 xv6 指令
- 常見問題的解決

下一章將介紹如何設定 TAP 網路。