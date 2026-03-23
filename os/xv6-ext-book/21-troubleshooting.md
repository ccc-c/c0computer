# 21. 常見問題與解決方案

## 21.1 編譯問題

### 21.1.1 找不到 RISC-V 編譯器

**問題**：
```
*** Error: Couldn't find a riscv64 version of GCC/binutils.
```

**解決**：
```bash
sudo apt-get install gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu
```

### 21.1.2 const 限定符錯誤

**問題**：
```
error: passing argument 2 of 'send' discards 'const' qualifier
```

**解決**：
```c
// 錯誤
static const char *RESPONSE = "HTTP/1.1 200 OK...";

// 正確
static char RESPONSE[] = "HTTP/1.1 200 OK...";
```

### 21.1.3 隱含函數宣告

**問題**：
```
error: implicit declaration of function 'strncmp'
```

**解決**：使用手動字元比對
```c
// 不要用 strncmp
if (strncmp(buf, "GET ", 4) == 0)

// 使用手動比對
if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ')
```

## 21.2 執行問題

### 21.2.1 QEMU 網路 tap0 忙碌

**問題**：
```
t/tun (tap0): Device or resource busy
make: *** [Makefile:209: qemu] Error 1
```

**解決**：
```bash
pkill -9 -f qemu-system-riscv64
tmux kill-session -t xv6-test 2>/dev/null
```

### 21.2.2 tap0 未啟動

**問題**：
```
RTNETLINK answers: Operation not permitted
```

**解決**：
```bash
sudo ip link set tap0 up
sudo ip addr add 192.0.2.1/24 dev tap0
```

### 21.2.3 無法連線到 xv6

**檢查清單**：
1. tap0 是否 UP？`ip addr show tap0`
2. xv6 IP 是否設定？`ifconfig net0 192.0.2.2/24`
3. 防火牆是否阻擋？`sudo iptables -L`

## 21.3 網路問題

### 21.3.1 UDP 測試失敗

**可能原因**：
- udpecho 程式未啟動
- 防火墙阻擋
- nc 參數錯誤

**解決**：
```bash
# 確認 udpecho 執行
nc -u 192.0.2.2 7
# 輸入文字後按 Enter
```

### 21.3.2 HTTP 測試連線被拒

**可能原因**：
- httpd 未啟動
- 端口錯誤
- IP 錯誤

**解決**：
```bash
# 確認 httpd 在執行
curl http://192.0.2.2:8080
```

### 21.3.3 TCP 連線逾時

**可能原因**：
- telnetd 崩潰
- 缓冲区過大

**解決**：减少 buffer 大小
```c
char buf[512];    // 從 2048 減至 512
char cmd_buf[256];  // 從 4096 減至 256
```

## 21.4 書籍問題

### 21.4.1 章節編號錯誤

**問題**：README 與實際檔案名稱不符

**解決**：
```bash
# 檢查實際檔案
ls *.md

# 對照 README 更新
```

## 21.5 小結

本章節整理了開發過程中常見的問題及其解決方案：- 編譯問題：工具鏈、語法限制
- 執行問題：QEMU、網路設定
- 網路問題：連線、除錯- 書籍問題：章節編號

遇到問題時，先檢查基本設定（網路、程序狀態），再查看日誌輸出。