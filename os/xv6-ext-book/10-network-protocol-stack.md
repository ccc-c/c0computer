# 10. 網路通訊協定疊層

## 10.1 TCP/IP 協定堆疊理論

### 10.1.1 什麼是協定堆疊？

網路通訊需要多個層次的配合，這就是 OSI 七層模型和 TCP/IP 四層模型：

| OSI 層 | TCP/IP 層 | xv6-ext 實作 | 說明 |
|--------|-----------|--------------|------|
| 7. Application | 應用層 | HTTP, curl, echo | 使用者程式介面 |
| 6. Presentation | - | - | 資料表示格式 |
| 5. Session | - | - | 對話控制 |
| 4. Transport | 傳輸層 | TCP, UDP | 可靠傳輸 |
| 3. Network | 網路層 | IP, ARP, ICMP | 路徑選擇 |
| 2. Data Link | 網路介面層 | Ethernet | 框架傳輸 |
| 1. Physical | 網路介面 | VirtIO | 實際傳輸 |

**協定堆疊的核心概念**：每一層只關心自己的職責，通過介面與上下層溝通。

### 10.1.2 為什麼要分層？

1. **模組化**：各層獨立開發和測試
2. **標準化**：同一層可以使用不同實現
3. **简化复杂度**：不需要了解所有細節
4. **可擴展性**：新增協定不影響其他層

## 10.2 xv6-ext 網路原始碼架構

### 10.2.1 原始碼組織

```
kernel/net/
    ├── net.c          # 網路核心：初始化、協定注册、softirq
    ├── ether.c        # 乙太網路層：frame 處理
    ├── ip.c           # IP 層：封包路由
    ├── arp.c          # ARP 協定：IP→MAC 解析
    ├── icmp.c         # ICMP 協定：ping
    ├── udp.c          # UDP：無連線傳輸
    ├── tcp.c          # TCP：可靠傳輸
    ├── socket.c       # Socket 介面：系統呼叫
    ├── util.c          # 工具函數
kernel/net/platform/xv6-riscv/
    ├── virtio_net.c   # VirtIO 網路驅動
    └── std.c           # 標準庫
```

### 10.2.2 核心資料結構

**net_device - 網路介面**

```c
// kernel/net/net.h:27-45
struct net_device {
    char name[16];              // 介面名稱 (如 "net0")
    uint8_t mac[6];             // MAC 位址
    uint32_t ip;                // IP 位址 (僅對應一個 IP)
    uint32_t mask;              // 網路遮罩
    uint16_t type;              // 裝置類型 (0x0002 = Ethernet)
    struct net_device_ops *ops; // 驅動操作函數指標
    void *priv;                 // 私有資料
    
    // 傳送/接收緩衝區
    struct {
        char *buf;
        int len;
    } rx, tx;
    
    enum {
        NET_DOWN,               // 關閉
        NET_UP                  // 開啟
    } state;
};
```

**封包處理**

```c
// kernel/net/net.h:60-80
struct net_packet {
    uint32_t dev;              // 來源/目的裝置
    uint16_t type;             // 乙太網類型 (0x0800=IP, 0x0806=ARP)
    uint32_t len;              // 封包長度
    char data[0];              // 靈活陣列，實際資料
};
```

**協定處理**

```c
// kernel/net/net.h:82-90
struct net_protocol {
    uint16_t type;                    // EtherType
    void (*input)(struct net_device*, void*, int);  // 接收處理函數
    char name[16];                     // 協定名稱
};
```

## 10.3 網路初始化流程

### 10.3.1 啟動追蹤

當 xv6-ext 開機時，網路初始化的順序：

```
kernel/main.c::main()
  ↓
net_init()           // kernel/net/net.c:380
  ↓
virtio_net_init()   // kernel/net/platform/xv6-riscv/virtio_net.c:280
  ↓
顯示網路介面資訊
```

### 10.3.2 原始碼分析 - net_init()

```c
// kernel/net/net.c:380-395
void
net_init(void)
{
    int i;
    
    // 1. 配置 SoftIRQ 框架
    net_softirq_init();
    
    // 2. 注册網路協定 (按順序)
    net_protocol_register(ETH_TYPE_IP, ip_input, "ipv4");
    net_protocol_register(ETH_TYPE_ARP, arp_input, "arp");
    
    // 3. 注册傳輸層協定
    ip_protocol_register(IPPROTO_ICMP, icmp_input, "icmp");
    ip_protocol_register(IPPROTO_UDP, udp_input, "udp");
    ip_protocol_register(IPPROTO_TCP, tcp_input, "tcp");
    
    // 4. 註冊定時器
    net_timer_register(1, 0);           // 每秒arp清理
    net_timer_register(0, 100000);    // 每100ms TCP處理
    
    printf("[I] net_init: initialized\n");
}
```

### 10.3.3 原始碼分析 - 協定注册

```c
// kernel/net/net.c:195-215
void
net_protocol_register(uint16_t type, 
                       void (*input)(struct net_device*, void*, int),
                       char *name)
{
    struct net_protocol *p = &protocols[nprotocols++];
    p->type = type;
    p->input = input;
    strncpy(p->name, name, sizeof(p->name) - 1);
    
    printf("[I] net_protocol_register: registered, type=0x%04x (%s)\n", 
           type, name);
}
```

## 10.4 封包處理流程

### 10.4.1 接收流程 - 原始碼追蹤

```
VirtIO 硬體中斷
    ↓
virtio_intr()        [kernel/net/platform/xv6-riscv/virtio_net.c]
    ↓
virtio_net_intr()   處理 received packet
    ↓
ether_input()       [kernel/net/ether.c:120]
    ↓
根據 EtherType 分發
    ├── 0x0800 → ip_input()    [kernel/net/ip.c]
    └── 0x0806 → arp_input()   [kernel/net/arp.c]
```

**ether_input 原始碼**

```c
// kernel/net/ether.c:120-160
void
ether_input(struct net_device *dev, void *data, int len)
{
    struct ether_frame *frame = data;
    uint16_t type = ntohs(frame->type);
    
    printf("[D] ether_input_helper: dev=%s, type=0x%04x, len=%d\n",
           dev->name, type, len);
    printf("        src: %x:%x:%x:%x:%x:%x\n",
           frame->src[0], frame->src[1], frame->src[2],
           frame->src[3], frame->src[4], frame->src[5]);
    printf("       type: 0x%04x\n", type);
    
    // 查找並調用對應的協定處理函數
    for (int i = 0; i < nprotocols; i++) {
        if (protocols[i].type == type) {
            protocols[i].input(dev, data + sizeof(struct ether_frame), 
                             len - sizeof(struct ether_frame));
            return;
        }
    }
}
```

### 10.4.2 傳送流程

```
應用程式 send()
    ↓
Socket 層
    ↓
TCP/UDP output()
    ↓
IP output()         [kernel/net/ip.c]
    ↓
ARP 解析 MAC
    ↓
ether_output()     [kernel/net/ether.c]
    ↓
virtio_net_transmit()  [VirtIO 驅動]
    ↓
VirtIO 硬體
```

**IP output 原始碼**

```c
// kernel/net/ip.c:430-480
int
ip_output(struct net_device *dev, void *data, int len,
          uint8_t protocol, uint32_t src, uint32_t dst)
{
    struct iphdr *ip;
    int total_len = sizeof(struct iphdr) + len;
    
    // 從里程池配置緩衝區
    char *buf = kalloc();
    if (!buf) return -1;
    
    ip = (struct iphdr *)buf;
    
    // 組裝 IP header
    ip->ver_ihl = 0x45;          // IPv4, Header length = 5*4 = 20 bytes
    ip->tos = 0;
    ip->tot_len = htons(total_len);
    ip->id = htons(ip_id++);
    ip->frag_off = 0;
    ip->ttl = 64;               // 預設 TTL
    ip->protocol = protocol;
    ip->saddr = src;
    ip->daddr = dst;
    ip->check = 0;
    ip->check = ip_check_sum((uint16_t *)ip, 20);
    
    // 複製資料
    memmove(buf + sizeof(struct iphdr), data, len);
    
    // 發送到乙太網路層
    return ether_output(dev, buf, total_len, ETH_TYPE_IP);
}
```

## 10.5 協定層的協調

### 10.5.1 SoftIRQ 機制

xv6-ext 使用 SoftIRQ 處理網路中斷，確保中斷處理不會阻塞太久：

```c
// kernel/net/net.c:250-280
void
net_softirq_handler(void)
{
    struct net_protocol *p;
    struct net_device *dev;
    
    while (net_queue_len > 0) {
        // 取出排隊的封包
        struct net_packet *pkt = net_queue[0];
        memmove(&net_queue[0], &net_queue[1], 
                (--net_queue_len) * sizeof(void*));
        net_queue_len--;
        
        // 找到對應的協定處理
        for (int i = 0; i < nprotocols; i++) {
            if (protocols[i].type == pkt->type) {
                protocols[i].input(pkt->dev, pkt->data, pkt->len);
                break;
            }
        }
        
        kfree((uint64_t)pkt);
    }
}
```

### 10.5.2 定時器處理

網路協定需要定時處理（如 ARP 緩存清理、TCP 超時）：

```c
// kernel/net/net.c:220-240
struct net_timer {
    struct net_timer *next;
    uint64_t expiram_time;
    void (*handler)(void);
    char name[16];
};

void
net_timer_handler(void)
{
    // 遍歷定時器鏈表
    for (struct net_timer **t = &timers; *t; t = &(*t)->next) {
        if ((*t)->expiram_time <= ticks) {
            struct net_timer *expired = *t;
            *t = (*t)->next;
            expired->handler();
            kfree((uint64_t)expired);
        }
    }
}
```

## 10.6 小結

本章深入分析了 xv6-ext 網路堆疊的原理與原始碼：

1. **分層架構**：理解為什麼需要分層
2. **資料結構**：net_device, net_protocol, net_packet
3. **初始化流程**：從開機到網路就緒
4. **封包處理**：接收與傳送的完整流程
5. **SoftIRQ**：如何在中斷環境中安全處理網路

**關鍵概念**：
- 每一層只知道相鄰的上下層
- 封包在各層之間傳遞時需要添加/移除 header
- SoftIRQ 確保即時性又不阻塞

下一章將介紹 VirtIO 網路驅動程式的實現。