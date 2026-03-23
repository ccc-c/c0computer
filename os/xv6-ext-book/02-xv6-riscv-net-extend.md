# 2. xv6-riscv-net 的擴充部分

## 2.1 專案簡介

xv6-riscv-net 是 pandax381 維護的 xv6-riscv 網路擴充版本。它在原本的 xv6 作業系統基礎上，新增了完整的 TCP/IP 網路堆疊，讓這個教學用的作業系統具備了網路功能。

## 2.2 原始碼架構

```
xv6-riscv-net/
├── kernel/          # 核心程式碼
│   ├── main.c       # 主程式入口
│   ├── proc.c       # 行程管理
│   ├── vm.c         # 虛擬記憶體
│   ├── net/         # 網路相關
│   │   ├── net.c    # 網路初始化
│   │   ├── ether.c  # 乙太網路層
│   │   ├── ip.c     # IP 協定
│   │   ├── arp.c    # ARP 協定
│   │   ├── icmp.c   # ICMP 協定
│   │   ├── udp.c    # UDP 協定
│   │   ├── tcp.c    # TCP 協定
│   │   └── socket.c # Socket 介面
│   └── net/platform/xv6-riscv/
│       └── virtio_net.c # VirtIO 網路驅動
├── user/            # 使用者程式
│   ├── ifconfig.c   # 網路設定工具
│   ├── udpecho.c    # UDP Echo 伺服器
│   └── tcpecho.c    # TCP Echo 伺服器
└── Makefile         # 建置系統
```

## 2.3 網路堆疊架構

xv6-riscv-net 實現了完整的網路協定堆疊：

### 2.3.1 實體層 (Physical Layer)
- VirtIO 網路卡驅動程式
- 支援 QEMU 中的 virtio-net-pci 裝置

### 2.3.2 乙太網路層 (Link Layer)
- Ethernet frame 封裝/解封裝
- ARP 協定解析 IP 與 MAC 位址對應

### 2.3.3 網路層 (Network Layer)
- IP (Internet Protocol) 路由
- ICMP (ping) 控制訊息

### 2.3.4 傳輸層 (Transport Layer)
- UDP (User Datagram Protocol)
- TCP (Transmission Control Protocol)

### 2.3.5 應用層 (Application Layer)
- Socket API 系統呼叫
- 使用者應用程式

## 2.4 核心改動

### 2.4.1 系統呼叫新增
xv6-riscv-net 新增了 Socket 相關系統呼叫：
- socket() - 建立 socket
- bind() - 綁定位址
- listen() - 聆聽連線
- accept() - 接受連線
- connect() - 連線到遠端
- send()/recv() - 傳送/接收資料
- close() - 關閉 socket

### 2.4.2 行程管理擴充
- 網路優先權排程
- 網路計時器支援

### 2.4.3 記憶體管理
- 網路緩衝區配置
- sk_buff 結構管理

## 2.5 網路設定工具

### ifconfig
```bash
# 設定 IP
ifconfig net0 192.0.2.2/24

# 查看所有介面
ifconfig -a
```

### 网络拓扑
```
主機 (192.0.2.1/24)  ←→  tap0  ←→  QEMU  ←→  xv6 (192.0.2.2/24)
```

## 2.6 測試工具

xv6-riscv-net 提供了多個測試工具：
- **udpecho**: UDP Echo 伺服器
- **tcpecho**: TCP Echo 伺服器
- **ifconfig**: 網路介面設定

## 2.7 特色總結

1. 完整的 TCP/IP 堆疊實現
2. 基於 VirtIO 的高效網路驅動
3. POSIX 相容的 Socket API
4. 適合學習網路協定運作原理

## 2.8 下一步

在下一章中，我們將介紹 xv6-ext 的擴充部分，包括 HTTP 伺服器和客戶端的實現。
