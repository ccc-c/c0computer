# 17. HTTP 協定與請求處理

## 17.1 HTTP 協定概述

HTTP (HyperText Transfer Protocol) 是網頁應用的基礎協定。

## 17.2 HTTP 請求格式

### 17.2.1 Request Line

```
GET / HTTP/1.1
^^^ ^  ^^^^^^^
|  |   └────── HTTP 版本
|  └────────── 請求路徑
└───────────── HTTP 方法
```

常見方法：
- **GET**: 請求資料
- **POST**: 提交資料
- **PUT**: 更新資源
- **DELETE**: 刪除資源

### 17.2.2 Headers

```
Host: example.com
User-Agent: curl/xv6
Accept: */*
```

### 17.2.3 完整請求範例

```
GET /index.html HTTP/1.1
Host: www.example.com
User-Agent: curl/7.88.1
Accept: */*

```

## 17.3 HTTP 回應格式

### 17.3.1 Status Line

```
HTTP/1.1 200 OK
^^^^^^^^ ^   ^^
|        |   └─ 原因片語
|        └───── 狀態碼
└───────────── HTTP 版本
```

常見狀態碼：
- **200 OK**: 成功
- **404 Not Found**: 找不到資源
- **500 Internal Server Error**: 伺服器錯誤

### 17.3.2 Response Headers

```
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 123
Server: xv6-httpd

```

### 17.3.3 Response Body

```
<html>
<body>
<h1>Hello!</h1>
</body>
</html>
```

## 17.4 xv6 中 HTTP 處理

### 17.4.1 請求解析

```c
// 簡化的 GET 檢查
if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ') {
    // 是 GET 請求
}
```

### 17.4.2 回應組裝

```c
// HTTP 1.1 200 OK 回應
static char HTTP_RESPONSE[] = 
    "HTTP/1.1 200 OK\r\n"
    "Content-Type: text/html\r\n"
    "Content-Length: 13\r\n"
    "\r\n"
    "<h1>Hello!</h1>";
```

## 17.5 HTTP 1.1 特性

### 17.5.1 Keep-Alive

預設保持連線：
```
Connection: keep-alive
```

### 17.5.2 Chunked Transfer

分塊傳輸：
```
Transfer-Encoding: chunked
```

## 17.6 小結

本章介紹了：
- HTTP 請求/回應格式
- 狀態碼和 Headers
- xv6 中的 HTTP 處理方式

下一章將介紹自動化測試腳本。