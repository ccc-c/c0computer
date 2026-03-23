# 18. 自動化測試脚本

## 18.1 nettest.sh - 網路測試

### 功能
- 自動啟動 xv6 qemu
- 設定網路 IP
- 測試 UDP Echo

### 使用方式

```bash
./nettest.sh
```

### 腳本內容

```bash
#!/bin/bash
xv6_DIR="/mnt/macos/debian/xv6-ext"
TMUX_SESSION="xv6-net-test"

# 清理舊程序
pkill -9 -f "qemu-system-riscv64" 2>/dev/null || true

# 啟動 xv6
tmux new-session -d -s $TMUX_SESSION
tmux send-keys -t $TMUX_SESSION "cd $xv6_DIR && make qemu" C-m
sleep 10

# 設定網路
tmux send-keys -t $TMUX_SESSION "ifconfig net0 192.0.2.2/24" C-m

# 啟動 udpecho
tmux send-keys -t $TMUX_SESSION "udpecho" C-m

# 測試
echo "測試訊息" | nc -u -w 3 192.0.2.2 7

# 顯示結果
tmux capture-pane -t $TMUX_SESSION -p | tail -10
```

## 18.2 httptest.sh - HTTP 測試

### 功能
- 自動啟動 xv6 qemu
- 啟動 httpd 伺服器
- 測試 HTTP 連線

### 使用方式

```bash
./httptest.sh
```

## 18.3 執行結果

```
=== xv6-ext HTTP 測試 ===
[1/4] 設定 tap0 網路...
[2/4] 清理舊的 session...
[3/4] 啟動 xv6 qemu...
[4/4] 等待開機並執行測試...

=== 啟動 HTTP 測試 ===

=== 測試結果 ===
Starting HTTP Server on port 8080
socket: success, soc=3
waiting for connection...

=== 外部 curl 測試 (從主機) ===
<h1>Hello!</h1>
```

## 18.4 小結

本章介紹了自動化測試腳本，簡化開發和測試流程。