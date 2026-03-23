# 25. 效能優化與效能調校

## 25.1 效能瓶頸分析

### 25.1.1 網路效能

**瓶頸**：
- Context switch 開銷
- 緩衝區配置
- 中斷處理

### 25.1.2 測量方法

```bash
# 使用 time 測量
time curl http://192.0.2.2:8080

# 使用 ping 測量延遲
ping 192.0.2.2
```

## 25.2 優化策略

### 25.2.1 減少記憶體配置

優化前：
```c
char buf[4096];
char cmd_buf[8192];
```

優化後：
```c
char buf[512];
char cmd_buf[256];
```

### 25.2.2 增加緩衝區重複使用

```c
static char recv_buf[2048];  // 重複使用
```

### 25.2.3 減少系統呼叫

合併多次 write：
```c
// 多次
send(sock, "HTTP/1.1 ", 9);
send(sock, "200 OK", 6);

// 合併
send(sock, "HTTP/1.1 200 OK\r\n", 18);
```

## 25.3 TCP 效能調校

### 25.3.1 Nagle 演算法

即時傳送小封包：
```c
// 在 TCP socket 設定
int flag = 1;
setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, &flag, sizeof(flag));
```

## 25.4 小結

本章介紹了基本的效能優化策略，實際優化需要根據測量結果進行調整。