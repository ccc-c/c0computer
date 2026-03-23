# 7. tap0 網路設定與橋接

## 7.1 為什麼需要 TAP？

TAP (Terminal Access Point) 是一種虛擬網路裝置，允許使用者空間程式模擬網路卡的行為。在 xv6-ext 中，我們使用 TAP 來建立：

```
主機 Linux <----> TAP (tap0) <----> QEMU <----> xv6
```

## 7.2 建立 TAP 裝置

### 7.2.1 手動建立

```bash
# 建立 TAP 介面 (需要 root)
sudo ip tuntap add mode tap user $USER name tap0

# 啟動介面
sudo ip link set tap0 up

# 設定 IP
sudo ip addr add 192.0.2.1/24 dev tap0
```

### 7.2.2 自動建立 (Makefile)

xv6-ext 的 Makefile 包含自動建立腳本：

```bash
make tap
```

會執行：
```bash
sudo ip tuntap add mode tap user $USER name tap0
sudo ip addr add 192.0.2.1/24 dev tap0
sudo ip link set tap0 up
```

## 7.3 網路拓撲

### 7.3.1 IP 配置

| 設備 | IP | 角色 |
|------|-----|------|
| tap0 (主機) | 192.0.2.1/24 | 閘道 |
| net0 (xv6) | 192.0.2.2/24 | 用戶端 |

### 7.3.2 通訊流程

```
主機端                          QEMU/xv6
192.0.2.1                      192.0.2.2
   |                               |
   | 乙太框架 (ethernet frame)    |
   +------------->+---------------+
                    |
              virtio-net
              驅動程式
```

## 7.4 測試網路連線

### 7.4.1 Ping 測試

從主機 ping xv6：
```bash
ping 192.0.2.2
```

從 xv6 ping 主機：
```bash
ping 192.0.2.1
```

### 7.4.2 TCP/UDP 測試

```bash
# 啟動 UDP Echo (xv6)
udpecho &

# 測試 (主機)
nc -u 192.0.2.2 7
```

## 7.5 自動化測試腳本

### 7.5.1 nettest.sh

```bash
#!/bin/bash
xv6_DIR="/mnt/macos/xv6-ext"
TMUX_SESSION="xv6-test"

# 設定 TAP
sudo ip link set tap0 up
sudo ip addr add 192.0.2.1/24 dev tap0

# 啟動 xv6
tmux new-session -d -s $TMUX_SESSION
tmux send-keys -t $TMUX_SESSION "cd $xv6_DIR && make qemu" C-m
sleep 10

# 設定網路
tmux send-keys -t $TMUX_SESSION "ifconfig net0 192.0.2.2/24" C-m

# 啟動伺服器
tmux send-keys -t $TMUX_SESSION "udpecho" C-m
```

## 7.6 常見問題

### 7.6.1 TAP 裝置不存在

```bash
# 建立 TAP
sudo ip tuntap add mode tap name tap0
```

### 7.6.2 權限不足

使用者需要加入 `dialout` 群組：
```bash
sudo usermod -a -G dialout $USER
```

### 7.6.3 IP 衝突

確保不同裝置使用不同 IP：
- tap0: 192.0.2.1
- xv6 net0: 192.0.2.2

## 7.7 小結

本章介紹了：
- TAP 虛擬網路的概念
- 建立和管理 TAP 裝置
- 網路配置和測試
- 自動化測試腳本

下一章將介紹 xv6 的核心元件：行程管理。