# 19. 網路封包分析

## 19.1 封包捕捉工具

### 19.1.1 tcpdump

```bash
# 捕捉所有封包
sudo tcpdump -i tap0

# 捕捉特定port
sudo tcpdump -i tap0 port 8080

# 捕捉UDP封包
sudo tcpdump -i tap0 proto UDP
```

### 19.1.2 ping

```bash
# Ping 測試
ping 192.0.2.2

# 結果範例
64 bytes from 192.0.2.2: icmp_seq=1 ttl=255 time=27.5 ms
```

## 19.2 日誌分析

xv6-ext 提供詳細的日誌輸出：

```
[I] - Info 資訊訊息
[D] - Debug 除錯訊息
[W] - Warning 警告訊息
[E] - Error 錯誤訊息
```

### 19.2.1 網路初始化日誌

```
13:00:00.123 [I] net_init: initialized
13:00:00.124 [D] virtio_net_init: initialized, addr=52:54:00:12:34:56
13:00:00.125 [I] net_device_open: dev=net0, state=up
```

### 19.2.2 連線處理日誌

```
13:00:01.234 [D] tcp_input: 192.0.2.1:12345 => 192.0.2.2:8080
```

## 19.3 常用診斷

### 19.3.1 網路狀態檢查

```bash
# 主機端
ip addr show tap0

# xv6 端
ifconfig
```

### 19.3.2 連線測試

```bash
# TCP 測試
nc 192.0.2.2 8080

# UDP 測試  
nc -u 192.0.2.2 7
```

## 19.4 小結

本章介紹了網路封包分析工具和除錯方法，幫助診斷網路問題。