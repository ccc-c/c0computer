# 16. curl.c HTTP 客戶端實作

## 16.1 HTTP 客戶端概述

curl.c 是一個簡化的 HTTP 客戶端，示範如何從 xv6 發送 HTTP 請求到伺服器。

## 16.2 原始碼

```c
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

int main(int argc, char *argv[])
{
    int soc;
    struct sockaddr_in server;
    char buf[4096];
    char request[256];
    int i, port = 8080;
    char *host = "192.0.2.2";

    if (argc > 1) host = argv[1];
    if (argc > 2) port = atoi(argv[2]);

    printf("curl: connecting to %s:%d\n", host, port);

    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (soc == -1) {
        printf("curl: socket failed\n");
        exit(1);
    }

    server.sin_family = AF_INET;
    server.sin_port = htons(port);
    inet_pton(AF_INET, host, &server.sin_addr);

    if (connect(soc, (struct sockaddr *)&server, sizeof(server)) == -1) {
        printf("curl: connect failed\n");
        close(soc);
        exit(1);
    }
    printf("curl: connected!\n");

    // 手動組裝 HTTP 請求
    i = 0;
    request[i++] = 'G';
    request[i++] = 'E';
    request[i++] = 'T';
    request[i++] = ' ';
    request[i++] = '/';
    request[i++] = ' ';
    request[i++] = 'H';
    request[i++] = 'T';
    request[i++] = 'T';
    request[i++] = 'P';
    request[i++] = '/';
    request[i++] = '1';
    request[i++] = '.';
    request[i++] = '1';
    request[i++] = '\r';
    request[i++] = '\n';
    request[i++] = 'H';
    request[i++] = 'o';
    request[i++] = 's';
    request[i++] = 't';
    request[i++] = ':';
    request[i++] = ' ';
    {
        char *h = host;
        while (*h && i < 250) request[i++] = *h++;
    }
    request[i++] = '\r';
    request[i++] = '\n';
    request[i++] = '\r';
    request[i++] = '\n';
    
    send(soc, request, i);
    printf("curl: request sent\n");

    int n = recv(soc, buf, sizeof(buf) - 1);
    printf("curl: received %d bytes\n", n);
    if (n > 0) {
        buf[n] = '\0';
        printf("%s\n", buf);
    }

    close(soc);
    exit(0);
}
```

## 16.3 程式碼解析

### 16.3.1 命令列參數

```c
if (argc > 1) host = argv[1];  // 主機 IP
if (argc > 2) port = atoi(argv[2]);  // 連接埠
```

支援指定目標主機和連接埠。

### 16.3.2 socket() 建立連線

```c
soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
```

建立 TCP socket。

### 16.3.3 connect() 連線

```c
server.sin_family = AF_INET;
server.sin_port = htons(port);
inet_pton(AF_INET, host, &server.sin_addr);

connect(soc, (struct sockaddr *)&server, sizeof(server));
```

連線到 HTTP 伺服器。

## 16.4 HTTP 請求格式

```
GET / HTTP/1.1
Host: 192.0.2.2

```

手動組裝的 HTTP GET 請求：
- Request Line: `GET / HTTP/1.1`
- Header: `Host: <host>`
- 空行: (blank line)

## 16.5 接收回應

```c
int n = recv(soc, buf, sizeof(buf) - 1);
if (n > 0) {
    buf[n] = '\0';
    printf("%s\n", buf);
}
```

接收伺服器回應並顯示。

## 16.6 編譯與執行

### 16.6.1 Makefile 修改

```makefile
UPROGS=\
    $U/_curl\
    ...
```

### 16.6.2 在 xv6 中執行

```bash
# 連線到預設主機
curl

# 連線到指定主機
curl 192.0.2.2 8080
```

## 16.7 測試範例

### 16.7.1 伺服器端

先啟動 httpd：
```bash
httpd
```

### 16.7.2 客戶端

執行 curl：
```bash
$ curl 192.0.2.2 8080
curl: connecting to 192.0.2.2:8080
curl: socket created
curl: calling connect...
curl: connected!
curl: request sent
curl: received 86 bytes

HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 13

<h1>Hello!</h1>
```

## 16.8 xv6 環境限制

### 16.8.1 缺少標準函式庫

- 沒有 `strcpy`, `strcat`
- 必須手動組裝字串

### 16.8.2 避免使用標準函式

```c
// 錯誤
if (strncmp(buf, "GET ", 4) == 0)

// 正確
if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ')
```

## 16.9 小結

本章介紹了 HTTP 客戶端的實作：
- TCP 客戶端連線
- HTTP 請求構建
- 伺服器回應處理

下一章將介紹 HTTP 協定的詳細格式。