# 22. 更完整的 HTTP 1.1 支援

## 22.1 HTTP 1.1 新特性

### 22.1.1 持續連線 (Keep-Alive)

HTTP 1.0 預設每個請求建立新連線，HTTP 1.1 預設使用持續連線：

```
Connection: keep-alive
```

**優點**：
- 減少 TCP 交握次數
- 降低延遲
- 節省資源

### 22.1.2 分塊傳輸編碼 (Chunked Transfer)

伺服器可以分塊傳送回應：

```
Transfer-Encoding: chunked

4\r\n
Wiki\r\n
5\r\n
pedia\r\n
0\r\n
\r\n
```

### 22.1.3 主機欄位 (Host Header)

HTTP 1.1 強制要求 Host 欄位：

```
GET / HTTP/1.1
Host: example.com
```

## 22.2 實作改進

### 22.2.1 增加 Keep-Alive 支援

```c
static char HTTP_RESPONSE_KEEPALIVE[] = 
    "HTTP/1.1 200 OK\r\n"
    "Content-Type: text/html\r\n"
    "Content-Length: 13\r\n"
    "Connection: keep-alive\r\n"
    "\r\n"
    "<h1>Hello!</h1>";
```

### 22.2.2 增加 POST 支援

```c
// 檢查 POST 請求
if (buf[0] == 'P' && buf[1] == 'O' && buf[2] == 'S' && buf[3] == 'T') {
    // 處理 POST 請求
    // 解析 Content-Length
    // 讀取 request body
}
```

## 22.3 小結

本章介紹了 HTTP 1.1 的進階功能，可作為後續開發的參考方向。