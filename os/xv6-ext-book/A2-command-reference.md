# A2. 指令與工具速查表

## A2.1 網路指令

| 指令 | 說明 |
|------|------|
| `ifconfig net0 192.0.2.2/24` | 設定 IP |
| `ping 192.0.2.1` | 測試連線 |
| `nc -u 192.0.2.2 7` | UDP 測試 |
| `nc 192.0.2.2 23` | TCP 測試 |
| `telnet 192.0.2.2 23` | Telnet 客戶端 |
| `curl http://192.0.2.2:8080` | HTTP 客戶端 |

## A2.2 xv6 指令

| 指令 | 說明 |
|------|------|
| `ls` | 列出檔案 |
| `cat <file>` | 顯示檔案 |
| `echo <text>` | 輸出文字 |
| `mkdir <dir>` | 建立目錄 |
| `rm <file>` | 刪除檔案 |
| `ps` | 顯示程序 |
| `kill <pid>` | 終止程序 |
| `httpd` | HTTP 伺服器 |
| `telnetd` | Telnet 伺服器 |
| `udpecho` | UDP Echo |
| `tcpecho` | TCP Echo |
| `curl` | HTTP 客戶端 |
| `ifconfig` | 網路設定 |

## A2.3 主機指令

```bash
# 網路設定
sudo ip link set tap0 up
sudo ip addr add 192.0.2.1/24 dev tap0

# QEMU
make qemu
pkill -9 qemu-system-riscv64

# tmux
tmux new -s xv6
tmux send-keys -t xv6 "command" C-m
tmux capture-pane -t xv6 -p
tmux kill-session -t xv6
```