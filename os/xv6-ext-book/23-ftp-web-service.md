# 23. 檔案傳輸與網頁服務

## 23.1 靜態檔案服務

### 23.1.1 讀取檔案並傳送

```c
int fd = open("/index.html", O_RDONLY);
if (fd > 0) {
    read(fd, buf, sizeof(buf));
    send(sock, buf, strlen(buf));
    close(fd);
}
```

### 23.1.2 簡易 HTTP 檔案伺服器

```c
if (strncmp(buf, "GET /", 5) == 0) {
    char path[256];
    // 解析路徑
    // 讀取檔案
    // 傳送 HTTP 回應
}
```

## 23.2 目錄列表

### 23.2.1 ls 輸出轉 HTTP

```c
// 讀取目錄
// 產生 HTML 清單
// 傳送回應
```

## 23.3 小結

本章介紹了如何擴展 HTTP 伺服器支援靜態檔案傳輸。