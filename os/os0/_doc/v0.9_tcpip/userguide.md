# os0 -- 衍生自 xv6-riscv（使用說明）

## 概述

本專案為 MIT xv6-riscv 作業系統新增了完整的 TCP/IP 網路功能，包括：
- Ethernet 驅動程式 (virtio-net)
- TCP/IP 網路堆疊
- BSD Socket API
- 多種網路應用程式

## 建置與執行

### 環境需求

- RISC-V 工具鏈 (`riscv64-unknown-elf-*`)
- QEMU (支援 RISC-V virt 機器)
- macOS 或 Linux 作業系統

### 建置步驟

```bash
cd /Users/Shared/ccc/c0computer/os/os0
make clean
make
```

### 執行 xv6

```bash
make qemu
```

系統啟動後會顯示：
```
xv6 kernel is booting
hart 1 starting
hart 2 starting
init: starting sh
$
```

按下 `Ctrl+A` 後再按 `x` 可退出 QEMU。

## 網路設定

### 自動網路設定 (QEMU 使用者模式)

系統預設使用 QEMU 的使用者模式網路，IP 位址為 `10.0.2.15`。

### 網路初始化

網路功能需要在系統啟動後手動初始化。請在 QEMU 中執行：

```bash
# 設定網路介面 IP（目前 ifconfig 正在開發中）
# 未來版本將支援自動網路設定
```

**注意：** 網路功能需要 QEMU 正確設定 TAP 設備或使用者模式網路。

## 內建指令

### ping - 網路連線測試

使用 UDP 協定測試網路連線（模擬 ping 功能）。

**用法：**
```bash
ping 10.0.2.2        # ping 閘道
```

**輸出範例：**
```
PING 10.0.2.2: 56 data bytes
64 bytes from 10.0.2.2: icmp_seq=0 time=1 ms
64 bytes from 10.0.2.2: icmp_seq=1 time=1 ms
```

### tcpecho - TCP Echo 伺服器

啟動 TCP Echo 伺服器，回傳收到的資料。

**用法：**
```bash
tcpecho              # 監聽所有介面的 port 7
```

**測試：**
```bash
# 從主機連線測試
nc -v 10.0.2.15 7
hello               # 輸入文字
hello               # 伺服器回傳相同文字
```

### udpecho - UDP Echo 伺服器

啟動 UDP Echo 伺服器。

**用法：**
```bash
udpecho             # 監聽所有介面的 port 7
```

### httpd - HTTP 伺服器

簡單的 HTTP 伺服器，提供靜態網頁服務。

**用法：**
```bash
httpd               # 啟動伺服器，監聽 port 80
httpd 8080          # 啟動伺服器，監聽 port 8080
```

**從主機存取：**
```bash
curl http://10.0.2.15/
# 或使用瀏覽器訪問 http://10.0.2.15:80
```

**回應範例：**
```
HTTP/1.0 200 OK
Content-Type: text/html

<html>
<body>
<h1>Welcome to xv6!</h1>
</body>
</html>
```

### curl - HTTP 客戶端

類似 wget/curl 的 HTTP 客戶端，用於下載網頁內容。

**用法：**
```bash
curl http://example.com
curl http://10.0.2.15/
```

**注意：** 目前版本僅支援連線到 127.0.0.1（本地端）

### telnetd - Telnet 伺服器

啟動 Telnet 伺服器，提供遠端終端機連線。

**用法：**
```bash
telnetd             # 監聽 port 23
telnetd 8023        # 監聽 port 8023
```

**從主機連線：**
```bash
telnet 10.0.2.15
```

### telnet - Telnet 客戶端

連線到遠端 Telnet 伺服器。

**用法：**
```bash
telnet <IP 位址> <連接埠>
telnet 10.0.2.2 23
```

## Socket API

本系統提供完整的 BSD Socket API，程式設計者可使用以下系統呼叫：

### 建立 Socket

```c
int sock = socket(PF_INET, SOCK_STREAM, 0);  // TCP
int sock = socket(PF_INET, SOCK_DGRAM, 0);   // UDP
```

### 綁定位址

```c
struct sockaddr_in addr;
addr.sin_family = AF_INET;
addr.sin_port = htons(8080);
addr.sin_addr.s_addr = INADDR_ANY;
bind(sock, (struct sockaddr *)&addr, sizeof(addr));
```

### 監聽連線 (伺服器)

```c
listen(sock, 5);
int client = accept(sock, NULL, NULL);
```

### 連線到伺服器 (客戶端)

```c
struct sockaddr_in server;
server.sin_family = AF_INET;
server.sin_port = htons(80);
server.sin_addr.s_addr = htonl(0x7F000001);  // 127.0.0.1
connect(sock, (struct sockaddr *)&server, sizeof(server));
```

### 傳送/接收資料

```c
send(sock, "Hello", 5, 0);
recv(sock, buffer, sizeof(buffer), 0);
```

### 關閉 Socket

```c
close(sock);
```

## 網路架構

### 通訊協定層級

```
┌─────────────────────────────────────┐
│     使用者程式 (httpd, ping...)     │
├─────────────────────────────────────┤
│         Socket API 層               │
│   (socket, bind, connect, send...)  │
├─────────────────────────────────────┤
│       傳輸層 (TCP/UDP)              │
│    kernel/net/tcp.c, udp.c          │
├─────────────────────────────────────┤
│         網路層 (IP/ICMP/ARP)        │
│   kernel/net/ip.c, icmp.c, arp.c    │
├─────────────────────────────────────┤
│       連結層 (Ethernet)             │
│      kernel/net/ether.c              │
├─────────────────────────────────────┤
│     驅動程式 (virtio-net)           │
│  kernel/net/platform/xv6-riscv/      │
└─────────────────────────────────────┘
```

### 網路模組說明

| 檔案 | 功能 |
|------|------|
| `kernel/net/net.c` | 網路初始化和管理 |
| `kernel/net/ether.c` | Ethernet 框架處理 |
| `kernel/net/arp.c` | ARP 位址解析 |
| `kernel/net/ip.c` | IP 封包處理 |
| `kernel/net/icmp.c` | ICMP 協定 (ping) |
| `kernel/net/udp.c` | UDP 協定 |
| `kernel/net/tcp.c` | TCP 協定 |
| `kernel/net/socket.c` | Socket 資料結構 |
| `kernel/net/platform/xv6-riscv/virtio_net.c` | virtio-net 驅動 |

## 可用的網路程式

| 程式 | 功能 | 狀態 |
|------|------|------|
| `ping` | 網路連線測試 | 可用 |
| `tcpecho` | TCP Echo 伺服器 | 可用 |
| `udpecho` | UDP Echo 伺服器 | 可用 |
| `httpd` | HTTP 伺服器 | 可用 |
| `curl` | HTTP 客戶端 | 可用（僅本地端）|
| `telnetd` | Telnet 伺服器 | 可用 |
| `telnet` | Telnet 客戶端 | 可用 |
| `ifconfig` | 網路介面設定 | 開發中 |

## 常見問題

### Q: 網路無法連線

**檢查項目：**
1. 確認 QEMU 已正確設定網路
2. 檢查 IP 位址設定是否正確
3. 確認閘道 IP (通常是 10.0.2.2)
4. 使用網路程式測試基本連線

### Q: 如何從主機存取 xv6 的服務？

xv6 的 IP 通常是 `10.0.2.15`，可使用：
```bash
curl http://10.0.2.15/
telnet 10.0.2.15
nc 10.0.2.15 80
```

### Q: 如何讓 xv6 存取外部網路？

使用 QEMU 使用者模式網路時，預設閘道是 `10.0.2.2`。

## 技術規格

- **虛擬網路設備**: virtio-net (QEMU)
- **IP 位址**: 10.0.2.15 (預設，使用 QEMU user network)
- **子網路遮罩**: 255.255.255.0
- **閘道**: 10.0.2.2
- **支援的協定**: IPv4, ICMP, ARP, UDP, TCP
- **Socket 類型**: Stream (TCP), Datagram (UDP)

## 退出 QEMU

在 QEMU 中：
1. 按下 `Ctrl+A` 放開
2. 按下 `x` 鍵

或者使用：
```bash
# 在另一個終端機
pkill -f qemu-system-riscv64
```

## 參考資源

- xv6-riscv-net 專案: https://github.com/pandax381/xv6-riscv-net
- MIT 6.S081 課程: https://pdos.csail.mit.edu/6.828/2020/
- QEMU 網路文件: https://wiki.qemu.org/Networking
