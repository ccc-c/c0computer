# 18. telnetd.c Telnet 伺服器實作

## 18.1 Telnet 協定理論

### 18.1.1 什麼是 Telnet？

Telnet 是一種古老的遠端登入協定，允許使用者透過網路連線到遠端主機的文字介面。雖然現代已被 SSH 取代，但 Telnet 仍然用於：
- 網路設備管理
- 教學用途
- 簡單的客戶端/伺服器測試

### 18.1.2 Telnet 特點

| 特性 | 說明 |
|------|------|
| 傳輸 | 明文 TCP 連線 |
| 預設端口 | 23 |
| 認證 | 使用者名稱/密碼 |
| 介面 | 文字命令列 |

### 18.1.3 與 SSH 的比較

| 特性 | Telnet | SSH |
|------|--------|-----|
| 加密 | 無 | 有 (SSH-2) |
| 端口 | 23 | 22 |
| 安全性 | 不安全 | 安全 |
| 複雜度 | 簡單 | 複雜 |

## 18.2 telnetd.c 原始碼分析

### 18.2.1 完整原始碼

以下是 xv6-ext 中 telnetd.c 的完整程式碼：

```c
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

static char WELCOME_MSG[] = 
    "\r\nxv6-ext telnet server\r\n"
    "Type 'exit' to logout\r\n\r\n";

static char SHELL_PROMPT[] = "$ ";

int main(int argc, char *argv[])
{
    int soc, acc, peerlen;
    struct sockaddr_in self, peer;
    char buf[2048];
    char cmd_buf[4096];
    int cmd_len = 0;
    int port = 23;

    if (argc > 1) {
        port = atoi(argv[1]);
    }

    printf("Starting Telnet Server on port %d\n", port);
    
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (soc == -1) {
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
    
    self.sin_family = AF_INET;
    self.sin_addr.s_addr = INADDR_ANY;
    self.sin_port = htons(port);
    
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
        printf("bind: failure\n");
        close(soc);
        exit(1);
    }
    
    listen(soc, 5);
    printf("waiting for connection...\n");

    while (1) {
        peerlen = sizeof(peer);
        acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
        if (acc == -1) {
            printf("accept: failure\n");
            continue;
        }
        
        printf("connection from client\n");
        
        send(acc, WELCOME_MSG, strlen(WELCOME_MSG));
        send(acc, SHELL_PROMPT, 2);
        
        cmd_len = 0;
        
        while (1) {
            int ret = recv(acc, buf, sizeof(buf) - 1);
            if (ret <= 0) break;
            
            buf[ret] = '\0';
            
            int i;
            for (i = 0; i < ret; i++) {
                if (buf[i] == '\r' || buf[i] == '\n') {
                    cmd_buf[cmd_len] = '\0';
                    
                    if (cmd_len > 0) {
                        if (cmd_buf[0] == 'e' && cmd_buf[1] == 'x' && cmd_buf[2] == 'i' && cmd_buf[3] == 't') {
                            send(acc, "logout\r\n", 8);
                            break;
                        }
                        if (cmd_buf[0] == 'l' && cmd_buf[1] == 's') {
                            send(acc, "cat  echo  grep  ifconfig  ls  mkdir  rm  sh\r\n", 48);
                        } else if (cmd_buf[0] == 'h' && cmd_buf[1] == 'e' && cmd_buf[2] == 'l' && cmd_buf[3] == 'p') {
                            send(acc, "Available commands: ls, help, exit\r\n", 35);
                        } else {
                            send(acc, "xv6: command not found\r\n", 24);
                        }
                    }
                    
                    send(acc, SHELL_PROMPT, 2);
                    cmd_len = 0;
                } else if (cmd_len < (int)(sizeof(cmd_buf) - 1)) {
                    cmd_buf[cmd_len++] = buf[i];
                }
            }
        }
        
        close(acc);
        printf("client disconnected\n");
    }
    
    close(soc);
    exit(0);
}
```

### 18.2.2 程式碼解析

#### 1. 歡迎訊息

```c
static char WELCOME_MSG[] = 
    "\r\nxv6-ext telnet server\r\n"
    "Type 'exit' to logout\r\n\r\n";
```

客戶端連線後顯示的歡迎訊息。

#### 2. 命令提示符

```c
static char SHELL_PROMPT[] = "$ ";
```

每個命令執行後顯示的提示符。

#### 3. 主迴圈 - 監聽連線

```c
while (1) {
    acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
    // 處理連線...
}
```

監聽並接受客戶端連線。

#### 4. 命令處理

```c
// 檢查命令
if (cmd_buf[0] == 'e' && cmd_buf[1] == 'x' && cmd_buf[2] == 'i' && cmd_buf[3] == 't') {
    send(acc, "logout\r\n", 8);
    break;
}
if (cmd_buf[0] == 'l' && cmd_buf[1] == 's') {
    send(acc, "cat  echo  grep  ifconfig  ls  mkdir  rm  sh\r\n", 48);
}
```

簡單的命令比對和回應。

## 18.3 Telnet 客戶端

### 18.3.1 安裝 Telnet 客戶端

```bash
sudo apt-get install telnet
```

### 18.3.2 測試 telnetd

#### 方法一：使用 telnet 命令

```bash
telnet 192.0.2.2 23
```

連線後會看到：
```
xv6-ext telnet server
Type 'exit' to logout

$ 
```

#### 方法二：使用 nc (netcat)

```bash
nc 192.0.2.2 23
```

## 18.4 與 HTTP 伺服器的比較

| 特性 | httpd | telnetd |
|------|-------|---------|
| 端口 | 8080 | 23 |
| 協定 | HTTP | Telnet |
| 互動模式 | 請求-回應 | 持續對話 |
| 狀態 | 無狀態 | 有狀態 |

## 18.5 限制與改進

### 18.5.1 目前限制

1. **沒有真正的 shell**：只能回應固定訊息
2. **沒有命令執行**：無法真的執行 xv6 命令
3. **沒有使用者認證**：直接顯示提示符

### 18.5.2 可改進方向

1. **實現 exec()**：透過 fork/exec 執行真正的命令
2. **pty 控制**：需要 pseudo-terminal 支援
3. **命令歷史**：使用上下鍵瀏覽歷史
4. **補全功能**：Tab 鍵命令補全

## 18.6 小結

本章介紹了 Telnet 伺服器的理論與實作：

1. **Telnet 協定**：理解 Telnet 的原理
2. **原始碼分析**：telnetd.c 的實作細節
3. **測試方法**：如何使用 telnet/nc 測試

**關鍵概念**：
- Telnet 是簡單的 TCP 文字介面
- 適合教學和網路除錯
- 已被 SSH 取代（安全性原因）

---

**相關檔案**：
- `user/telnetd.c` - Telnet 伺服器原始碼
- `telnet_test.sh` - 測試腳本