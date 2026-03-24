# A3. 程式碼結構圖

## A3.1 xv7 原始碼組織

```
xv7/
├── kernel/                    # 核心程式碼
│   ├── main.c                # 開機入口
│   ├── proc.c               # 程序管理
│   ├── vm.c                 # 虛擬記憶體
│   ├── fs.c                 # 檔案系統
│   ├── net/                  # 網路堆疊
│   │   ├── net.c           # 網路核心
│   │   ├── ether.c         # 乙太網路層
│   │   ├── ip.c            # IP 層
│   │   ├── arp.c           # ARP
│   │   ├── icmp.c          # ICMP
│   │   ├── udp.c           # UDP
│   │   ├── tcp.c           # TCP
│   │   └── socket.c        # Socket API
│   └── net/platform/xv6-riscv/
│       └── virtio_net.c    # VirtIO 驅動
├── user/                    # 使用者程式
│   ├── httpd.c             # HTTP 伺服器
│   ├── curl.c             # HTTP 客戶端
│   ├── telnetd.c          # Telnet 伺服器
│   ├── ifconfig.c         # 網路設定
│   └── ...
└── Makefile                # 編譯腳本
```

## A3.2 網路封包流程

```
應用層 (HTTP/Telnet)
    ↓
socket() → bind() → listen() → accept()
    ↓
傳輸層 (TCP/UDP)
    ↓
網路層 (IP)
    ↓
乙太網路層 (Ethernet)
    ↓
VirtIO 驅動 → QEMU → tap0 → 主機
```

## A3.3 程序狀態機

```
UNUSED → EMBRYO → SLEEPING → RUNNABLE → RUNNING → ZOMBIE → UNUSED
```