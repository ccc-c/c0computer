# 15. httpd.c HTTP 伺服器實作

## 15.1 HTTP 伺服器概述

httpd.c 是一個簡化的 HTTP 伺服器，示範如何在 xv6 上實作網頁服務。

## 15.2 原始碼

```c
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

static char HTTP_RESPONSE[] = 
    "HTTP/1.1 200 OK\r\n"
    "Content-Type: text/html\r\n"
    "Content-Length: 13\r\n"
    "\r\n"
    "<h1>Hello!</h1>";

int main(int argc, char *argv[])
{
    int soc, acc, peerlen;
    struct sockaddr_in self, peer;
    char buf[2048];
    int port = 8080;

    if (argc > 1) {
        port = atoi(argv[1]);
    }

    printf("Starting HTTP Server on port %d\n", port);
    
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (soc == -1) {
        printf("socket: failure\n");
        exit(1);
    }
    
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
        if (acc == -1) continue;
        
        int ret = recv(acc, buf, sizeof(buf) - 1);
        if (ret > 0) {
            buf[ret] = '\0';
            
            // 簡單的 GET 請求檢查
            if (buf[0] == 'G' && buf[1] == 'E' && 
                buf[2] == 'T' && buf[3] == ' ') {
                send(acc, HTTP_RESPONSE, strlen(HTTP_RESPONSE));
            }
        }
        
        close(acc);
    }
    
    close(soc);
    exit(0);
}
```

## 15.3 程式碼解析

### 15.3.1 Socket 建立

```c
soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
```

建立 TCP socket 進行監聽。

### 15.3.2 bind() 綁定

```c
self.sin_family = AF_INET;
self.sin_addr.s_addr = INADDR_ANY;  // 接受任何 IP
self.sin_port = htons(port);       // 監聽 port 8080

bind(soc, (struct sockaddr *)&self, sizeof(self));
```

將 socket 綁定到所有網路介面的 port 8080。

### 15.3.3 listen() 聆聽

```c
listen(soc, 5);  // 最多 5 個連線排隊
```

開始聆聽連線請求。

### 15.3.4 accept() 接受

```c
acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
```

等待客戶端連線，返回新的連線 socket。

### 15.3.5 請求處理

```c
ret = recv(acc, buf, sizeof(buf) - 1);

// 檢查是否為 GET 請求
if (buf[0] == 'G' && buf[1] == 'E' && 
    buf[2] == 'T' && buf[3] == ' ') {
    send(acc, HTTP_RESPONSE, strlen(HTTP_RESPONSE));
}
```

接收客戶端請求並回應。

## 15.4 HTTP 回應格式

```http
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 13

<h1>Hello!</h1>
```

- **Status Line**: HTTP/1.1 200 OK
- **Headers**: Content-Type, Content-Length
- **Body**: 實際的 HTML 內容

## 15.5 編譯與執行

### 15.5.1  Makefile 修改

```makefile
UPROGS=\
    $U/_httpd\
    ...
```

### 15.5.2 編譯

```bash
make TOOLPREFIX=riscv64-linux-gnu-
```

### 15.5.3 在 xv6 中執行

```bash
httpd          # 使用預設 port 8080
httpd 9000    # 自訂 port
```

## 15.6 測試

### 15.6.1 從主機測試

```bash
curl http://192.0.2.2:8080
```

輸出：
```
<h1>Hello!</h1>
```

## 15.7 限制與改進

### 15.7.1 目前限制

- 只支援 GET 請求
- 固定的回應內容
- 單一執行緒
- 每次連線後關閉

### 15.7.2 可改進之處

- POST 請求處理
- 靜態檔案服務
- 多執行緒並發
- Keep-alive 支援
- HTTP/1.1 完整實作

## 15.8 小結

本章介紹了 HTTP 伺服器的基礎實作：
- TCP socket 編程
- HTTP 請求解析
- HTTP 回應封裝
- 伺服器的運作流程

下一章將介紹 HTTP 客戶端 curl.c 的實作。