# xv6 網路功能建設計畫

## 目標
為 xv6-riscv (os0/) 加入 TCP/IP 網路功能，包含 Ethernet 驅動程式、TCP/IP 堆疊、以及 BSD Socket API。

## 工作目錄
- **主要修改**：`/Users/Shared/ccc/c0computer/os/os0/`
- **可執行版本參考**：`/Users/Shared/ccc/c0computer/os/xv6/`
- **網路實作參考**：`/Users/Shared/ccc/c0computer/os/xv6-riscv-net/`

## 基礎程式碼
- 位置：`/Users/Shared/ccc/c0computer/os/os0/`
- 來源：MIT xv6-riscv (新版，可正常編譯執行)
- 參考：xv6-riscv-net (https://github.com/pandax381/xv6-riscv-net)

## 實作項目

### 1. 網路驅動程式 (Ethernet Driver)
- **virtio-net**: QEMU 模擬的 virtio 網路設備
  - 參考 `kernel/net/platform/xv6-riscv/virtio_net.c`
  - 需要實作接收和傳送佇列 (RX/TX ring)
  - 使用 DMA 進行資料傳輸

### 2. 網路層 (Network Layer)
建立 `kernel/net/` 目錄：

| 檔案 | 功能 |
|------|------|
| `ether.c` | Ethernet 框架的組建和解析 |
| `arp.c` | ARP (Address Resolution Protocol) |
| `ip.c` | IP (Internet Protocol) |
| `icmp.c` | ICMP (for ping) |

### 3. 傳輸層 (Transport Layer)
| 檔案 | 功能 |
|------|------|
| `udp.c` | UDP (User Datagram Protocol) |
| `tcp.c` | TCP (Transmission Control Protocol) |

### 4. Socket API
| 檔案 | 功能 |
|------|------|
| `socket.c` | Socket 資料結構和管理 |
| `syssocket.c` | 系統呼叫層 (socket, bind, connect, listen, accept, send, recv) |

### 5. 系統呼叫
新增以下系統呼叫：
- `socket(domain, type, protocol)` - 建立 socket
- `bind(sockfd, addr, addrlen)` - 綁定位址
- `listen(sockfd, backlog)` - 監聽連線
- `accept(sockfd, addr, addrlen)` - 接受連線
- `connect(sockfd, addr, addrlen)` - 連線到遠端
- `send(sockfd, buf, len, flags)` - 傳送資料
- `recv(sockfd, buf, len, flags)` - 接收資料
- `setsockopt(sockfd, level, optname, optval, optlen)` - 設定選項
- `getsockopt(sockfd, level, optname, optval, optlen)` - 取得選項

### 6. 使用者工具
| 程式 | 功能 |
|------|------|
| `ifconfig` | 設定網路介面 IP |
| `ping` | 測試網路連線 (ICMP echo request/reply) |
| `tcpecho` | TCP Echo 伺服器 |
| `udpecho` | UDP Echo 伺服器 |
| `httpd` | 簡單靜態網頁伺服器 |
| `telnetd` | Telnet 伺服器 |
| `telnet` | Telnet 客戶端 |
| `curl` | HTTP 客戶端 (類似 wget) |
| `nc` | Netcat 工具 |

### 7. Makefile 修改
- 新增網路相關的 `.o` 檔案到 `OBJS`
- 新增網路使用者程式到 `UPROGS`
- 新增 QEMU 網路設定 (TAP 設備)

## 目錄結構

```
os0/
├── kernel/
│   ├── net/
│   │   ├── util.c          # 工具函數 (位址轉換等)
│   │   ├── net.c           # 網路初始化
│   │   ├── ether.c         # Ethernet 框架
│   │   ├── arp.c           # ARP
│   │   ├── ip.c            # IP
│   │   ├── icmp.c          # ICMP
│   │   ├── udp.c           # UDP
│   │   ├── tcp.c           # TCP
│   │   ├── socket.c        # Socket 管理
│   │   ├── if.h            # 網路介面定義
│   │   ├── socket.h        # Socket 結構定義
│   │   └── platform/
│   │       └── xv6-riscv/
│   │           └── virtio_net.c  # virtio-net 驅動
│   ├── syssocket.c         # Socket 系統呼叫
│   ├── syscall.h           # 新增系統呼叫編號
│   └── defs.h              # 新增函數宣告
└── user/
    ├── ifconfig.c
    ├── ping.c
    ├── tcpecho.c
    ├── udpecho.c
    ├── httpd.c             # 簡單靜態網頁伺服器
    ├── telnetd.c           # Telnet 伺服器
    ├── telnet.c            # Telnet 客戶端
    ├── curl.c              # HTTP 客戶端
    └── nc.c
```

## 範例程式說明

### 1. ping (user/ping.c)
- 傳送 ICMP Echo Request 並等待 Echo Reply
- 用法：`ping <IP address>`
- 顯示往返時間 (RTT)

### 2. httpd (user/httpd.c)
- 簡單靜態網頁伺服器
- 監聽 TCP 連接埠 80
- 支援 GET 請求
- 回傳簡單的 HTML 網頁
- 用法：`httpd`

### 3. telnetd (user/telnetd.c)
- Telnet 伺服器
- 提供互動式終端機連線
- 用法：`telnetd`

### 4. telnet (user/telnet.c)
- Telnet 客戶端
- 連線到遠端 Telnet 伺服器
- 用法：`telnet <IP address> <port>`

### 5. curl (user/curl.c)
- 簡易 HTTP 客戶端
- 支援 GET 請求
- 可指定 URL 下載內容
- 用法：`curl <URL>` 或 `curl http://<IP>/<path>`

## 測試方式

### 0. 確認基礎版本可執行
```bash
cd /Users/Shared/ccc/c0computer/os/os0
make
make qemu
```

### 1. 基本網路
```bash
# 設定 IP
ifconfig net0 10.0.2.15 netmask 255.255.255.0

# 從主機 ping
ping 10.0.2.15
```

### 2. Ping 測試
```bash
# xv6 中
ping 10.0.2.2

# 從主機 ping xv6
ping 10.0.2.15
```

### 3. TCP Echo 測試
```bash
# xv6 中
tcpecho

# 主機中
nc -v 10.0.2.15 7
```

### 4. HTTP 伺服器測試
```bash
# xv6 中啟動網頁伺服器
httpd

# 從主機存取
curl http://10.0.2.15/
# 或用瀏覽器訪問 http://10.0.2.15:80
```

### 5. HTTP 客戶端測試 (curl)
```bash
# 從 xv6 存取外部網頁
curl http://example.com

# 或存取本機或其他伺服器
curl http://10.0.2.2/
```

### 6. Telnet 測試
```bash
# xv6 中啟動 Telnet 伺服器
telnetd

# 從主機連線
telnet 10.0.2.15
```

### 7. UDP 測試
```bash
# xv6 中
udpecho
```

## 預期問題與解決方案

1. **TAP 設備在 macOS 上不可用**
   - 解決：使用 QEMU 的使用者模式網路 (-net user)
   - 或在 Linux 虛擬機中執行
   - 測試時可在 Linux 環境執行

2. **記憶體管理**
   - 需要為網路緩衝區分配連續記憶體
   - 使用 kmalloc 分配

3. **中斷處理**
   - 網路卡需要處理接收和傳送完成中斷

4. **TCP 複雜度**
   - TCP 需要狀態機、逾時、重傳機制
   - 初期可先實作 UDP，逐步加入 TCP

## 實作順序

1. virtio-net 驅動程式
2. Ethernet 和 ARP
3. IP 和 ICMP (ping)
4. UDP
5. Socket 系統呼叫
6. TCP (進階)
7. 使用者工具

## 參考資源
- Intel E1000 軟體開發手冊
- QEMU virtio-net 文件
- xv6-riscv-net GitHub: https://github.com/pandax381/xv6-riscv-net
- MIT 6.S081 Lab: networking
