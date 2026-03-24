# 14. Socket API 與系統呼叫

## 14.1 Socket 概念

Socket 是網路通訊的端點，提供應用程式與網路堆疊之間的介面。

### 14.1.1 Socket 類型

```c
// IPv4 互聯網域
socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)  // TCP
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)   // UDP
socket(PF_INET, SOCK_RAW, protocol)         // 原始 Socket
```

## 14.2 文化點結構

```c
// kernel/net/socket.h
struct socket {
    int             fd;         // 檔案描述符
    int             family;    // PF_INET
    int             type;      // SOCK_STREAM/DGRAM
    int             protocol;  // TCP/UDP
    enum sock_state state;     // 連線狀態
    struct sockaddr_in local; // 本地位址
    struct sockaddr_in peer;   // 遠端位址
    
    struct tcp_stream *tp;     // TCP 控制塊 (TCP only)
    struct udp_stream *up;   // UDP 控制塊 (UDP only)
    
    char *recv_buf;           // 接收緩衝區
    int recv_len;
};
```

## 14.3 系統呼叫實作

### 14.3.1 socket()

```c
int sys_socket(int domain, int type, int protocol) {
    struct socket *s = kalloc(sizeof(struct socket));
    
    s->family = domain;
    s->type = type;
    s->protocol = protocol;
    s->state = SS_UNCONNECTED;
    
    // 根據協定初始化
    if (protocol == IPPROTO_TCP) {
        s->tp = tcp_stream_alloc();
    } else if (protocol == IPPROTO_UDP) {
        s->up = udp_stream_alloc();
    }
    
    return fd_install(s);
}
```

### 14.3.2 bind()

```c
int sys_bind(int sockfd, struct sockaddr *addr, socklen_t addrlen) {
    struct socket *s = socket_get(sockfd);
    struct sockaddr_in *in = (struct sockaddr_in*)addr;
    
    s->local.sin_family = in->sin_family;
    s->local.sin_port = in->sin_port;
    s->local.sin_addr = in->sin_addr;
    
    // 註冊到埠表
    return port_register(s->local.sin_port, s);
}
```

### 14.3.3 listen()

```c
int sys_listen(int sockfd, int backlog) {
    struct socket *s = socket_get(sockfd);
    
    if (s->type != SOCK_STREAM) {
        return -1;
    }
    
    s->state = SS_LISTEN;
    return 0;
}
```

### 14.3.4 accept()

```c
int sys_accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen) {
    struct socket *s = socket_get(sockfd);
    
    // 等待連線
    while (s->pending == 0) {
        sleep(s);
    }
    
    struct socket *new_s = s->pending;
    s->pending = new_s->next;
    
    // 返回新的 socket fd
    return fd_install(new_s);
}
```

### 14.3.5 connect()

```c
int sys_connect(int sockfd, struct sockaddr *addr, socklen_t addrlen) {
    struct socket *s = socket_get(sockfd);
    struct sockaddr_in *in = (struct sockaddr_in*)addr;
    
    s->peer.sin_family = in->sin_family;
    s->peer.sin_port = in->sin_port;
    s->peer.sin_addr = in->sin_addr;
    
    // TCP 三向交握
    if (s->type == SOCK_STREAM) {
        tcp_connect(s);
        while (s->state != SS_CONNECTED) {
            sleep(s);
        }
    }
    
    return 0;
}
```

### 14.3.6 send()/recv()

```c
int sys_send(int sockfd, void *buf, int len, int flags) {
    struct socket *s = socket_get(sockfd);
    
    if (s->type == SOCK_STREAM) {
        return tcp_send(s, buf, len);
    } else {
        return udp_send(s, buf, len, &s->peer);
    }
}

int sys_recv(int sockfd, void *buf, int len, int flags) {
    struct socket *s = socket_get(sockfd);
    
    while (s->recv_len == 0) {
        sleep(s);
    }
    
    int n = min(len, s->recv_len);
    memmove(buf, s->recv_buf, n);
    s->recv_len -= n;
    
    return n;
}
```

## 14.4 使用者程式介面

### 14.4.1 標準 API

```c
// 建立 socket
int s = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

// 綁定位址
bind(s, (struct sockaddr*)&addr, sizeof(addr));

// 聆聽
listen(s, 5);

// 接受連線
int c = accept(s, NULL, NULL);

// 傳送資料
send(c, "Hello", 5, 0);

// 關閉
close(c);
close(s);
```

## 14.5 小結

本章介紹了 Socket API：
- Socket 建立和初始化
- bind/listen/accept/connect
- send/recv 資料傳輸
- 系統呼叫與內部實作

下一章將介紹 HTTP 伺服器的實作。