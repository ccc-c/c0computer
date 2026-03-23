# 13. UDP 與 TCP 傳輸層

## 13.1 UDP (User Datagram Protocol)

UDP 是簡單的無連線傳輸協定，適合即時性要求高的應用。

### 13.1.1 UDP Header

```c
struct udphdr {
    uint16_t source;    // 來源連接埠
    uint16_t dest;      // 目標連接埠
    uint16_t len;       // 資料長度
    uint16_t check;     // 校驗和 (可選)
};
```

### 13.1.2 UDP 特色

- **無連線**：不需要建立連線
- **不可靠**：可能遺失封包
- **最小的協定開銷**
- **適合**：DNS、VoIP、串流

### 13.1.3 UDP 處理

```c
void udp_input(struct net_device *dev, char *packet, int len) {
    struct udphdr *udp = (struct udphdr*)packet;
    char *data = packet + sizeof(struct udphdr);
    int data_len = udp->len - sizeof(struct udphdr);
    
    // 查找對應的 socket
    struct socket *s = socket_lookup(udp->dest);
    if (s) {
        socket_recv(s, data, data_len, udp->source, udp->dest);
    }
}
```

## 13.2 TCP (Transmission Control Protocol)

TCP 是連線導向的可靠傳輸協定。

### 13.2.1 TCP Header

```c
struct tcphdr {
    uint16_t source;    // 來源連接埠
    uint16_t dest;      // 目標連接埠
    uint32_t seq;       // 序列號
    uint32_t ack;       // 確認號
    uint8_t  data_off;  // 資料偏移
    uint8_t  flags;     // 控制標誌
    uint16_t window;    // 視窗大小
    uint16_t check;     // 校驗和
    uint16_t urgent;    // 緊急指標
};
```

### 13.2.2 TCP 狀態機

```
CLOSED → LISTEN → SYN_RCVD → ESTABLISHED
             ↓                         ↓
        SYN_SENT ←──────────── FIN_WAIT
             ↓                         ↓
         CLOSING ←──────────── TIME_WAIT
             ↓                         ↓
           LAST_ACK ←──────────── CLOSED
```

### 13.2.3 TCP 連線管理

```c
// 伺服器聆聽
int listen(int sockfd, int backlog) {
    struct socket *s = socket_get(sockfd);
    s->state = TCP_LISTEN;
    return 0;
}

// 接受連線
int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen) {
    struct socket *s = socket_get(sockfd);
    
    // 等待連線
    while (s->conn == 0) {
        sleep(s->conn_sem);
    }
    
    return s->conn->fd;
}
```

## 13.3 TCP 重傳機制

TCP 確保可靠傳輸的機制：

### 13.3.1 確認 ACK

```c
void tcp_send_ack(struct tcp_stream *s) {
    struct tcphdr tcph;
    tcph.seq = s->snd_nxt;
    tcph.ack = s->rcv_nxt;
    tcph.flags = TCP_ACK;
    tcp_output(s->dev, &tcph, sizeof(tcph), s->daddr, s->sport);
}
```

### 13.3.2 重傳計時器

```c
void tcp_timer(void) {
    for (each tcp_stream) {
        if (timeout && now - sent_time > RTO) {
            // 重傳
            tcp_retransmit(s);
            s->rto *= 2;  // 指數退避
        }
    }
}
```

## 13.4 流量控制

### 13.4.1 滑動視窗

```c
// 發送端視窗
s->snd_wnd = rcv_window;  // 根據對端通知

// 傳送檢查
if (s->snd_nxt - s->snd_una < s->snd_wnd) {
    // 可以發送
    tcp_send(s, data, len);
}
```

## 13.5 擁塞控制

```c
void tcpCongestioncontrol(struct tcp_stream *s, int ack) {
    if (ack > s->ssthresh) {
        // 慢啟動之後進入擁塞避免
        s->cwnd += s->mss;
    } else {
        // 快速重傳/快速恢復
        s->cwnd = s->ssthresh;
    }
}
```

## 13.6 小結

本章介紹了傳輸層的內容：
- UDP：簡單的無連線傳輸
- TCP：可靠的連線導向傳輸
- 狀態機、ACK、重傳、流量控制、擁塞控制

下一章將介紹 Socket API 與系統呼叫。