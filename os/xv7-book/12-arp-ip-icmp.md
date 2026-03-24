# 12. ARP、IP、ICMP 實作

## 12.1 ARP 協定

ARP (Address Resolution Protocol) 負責將 IP 位址轉換為 MAC 位址。

### 12.1.1 ARP 表

```c
// kernel/net/arp.c
struct arp_entry {
    uint32_t ip;            // IP 位址
    uint8_t  mac[6];        // MAC 位址
    int     expire;         // 過期時間
};

struct {
    struct spinlock lock;
    struct arp_entry entry[8];
} arpcache;
```

### 12.1.2 ARP 請求處理

```c
// 收到 ARP 請求時
void arp_input(struct net_device *dev, struct arp_hdr *ah) {
    // 檢查是否在詢問我們的 IP
    if (ah->tpa == dev->ip) {
        // 發送 ARP 回應
        arp_reply(dev, ah);
    }
    
    // 更新 ARP 緩存
    arp_cache_insert(ah->spa, ah->sha);
}
```

### 12.1.3 ARP 回應

```c
void arp_reply(struct net_device *dev, struct arp_hdr *ah) {
    // 交換來源和目標
    ah->tha = ah->sha;
    ah->sha = dev->mac;
    ah->tpa = ah->spa;
    ah->spa = dev->ip;
    ah->oper = ARP_OP_REPLY;
    
    // 發送
    ether_output(dev, (char*)ah, sizeof(*ah), ETH_TYPE_ARP);
}
```

## 12.2 IP 協定

IP (Internet Protocol) 是網路層的核心協定，負責封包的路由。

### 12.2.1 IP Header

```c
struct iphdr {
    uint8_t  ver_ihl;      // 版本 + IHL
    uint8_t  tos;           // 服務類型
    uint16_t tot_len;      // 總長度
    uint16_t id;           // 識別
    uint16_t frag_off;    // 分片偏移
    uint8_t  ttl;          // 生命週期
    uint8_t  protocol;     // 上層協定
    uint16_t check;        // 校驗和
    uint32_t saddr;        // 來源 IP
    uint32_t daddr;        // 目標 IP
};
```

### 12.2.2 IP 接收

```c
void ip_input(struct net_device *dev, char *packet, int len) {
    struct iphdr *ip = (struct iphdr*)packet;
    
    // 驗證 IP 版本
    if (ip->ver_ihl != 0x45) return;
    
    // 驗證校驗和
    if (ip_check_sum((uint16_t*)ip, ip->ihl*4) != 0) return;
    
    // 轉發到上層協定
    switch (ip->protocol) {
        case IPPROTO_ICMP: icmp_input(dev, packet + 20, len - 20); break;
        case IPPROTO_UDP:  udp_input(dev, packet + 20, len - 20); break;
        case IPPROTO_TCP: tcp_input(dev, packet + 20, len - 20); break;
    }
}
```

## 12.3 ICMP 協定

ICMP (Internet Control Message Protocol) 用於錯誤報告和控制訊息，最常見的應用是 ping。

### 12.3.1 ICMP Header

```c
struct icmphdr {
    uint8_t  type;         // 類型
    uint8_t  code;         // 程式碼
    uint16_t checksum;     // 校驗和
    union {
        struct {
            uint16_t id;
            uint16_t sequence;
        } echo;
        uint32_t gateway;
    } un;
};
```

### 12.3.2 Echo Request/Reply (Ping)

```c
void icmp_input(struct net_device *dev, char *packet, int len) {
    struct icmphdr *icmp = (struct icmphdr*)packet;
    
    if (icmp->type == ICMP_ECHOREQUEST) {
        // 回應 Echo Request
        icmp->type = ICMP_ECHOREPLY;
        icmp->checksum = 0;
        icmp->checksum = ip_check_sum((uint16_t*)icmp, len);
        
        // 發送回應
        ip_output(dev, packet, len, IPPROTO_ICMP, dev->ip, ip->saddr);
    }
}
```

## 12.4 路由表

```c
// 簡化的路由表
struct route_entry {
    uint32_t network;      // 目的網路
    uint32_t netmask;      // 網路遮罩
    uint32_t gateway;      // 閘道器 (0 表示直接)
    struct net_device *dev;
};

struct route_entry routing_table[8];
```

## 12.5 小結

本章介紹了網路層的關鍵協定：
- ARP：IP 到 MAC 的轉換
- IP：封包路由
- ICMP：控制和錯誤訊息

下一章將介紹傳輸層：UDP 和 TCP。