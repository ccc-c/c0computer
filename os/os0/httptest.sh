#!/bin/bash

xv6_DIR="/mnt/macos/debian/xv6-riscv-net"
TMUX_SESSION="xv6-http-test"

echo "=== xv6-riscv-net HTTP 測試 ==="

echo "[1/4] 設定 tap0 網路..."
ip link show tap0 | grep -q "UP" || echo "警告: tap0 未啟動，請先執行: sudo ip link set tap0 up"

echo "[2/4] 清理舊的 session..."
tmux kill-session -t $TMUX_SESSION 2>/dev/null || true
sleep 1

echo "[3/4] 啟動 xv6 qemu..."
tmux new-session -d -s $TMUX_SESSION
tmux send-keys -t $TMUX_SESSION "cd $xv6_DIR && make qemu" C-m

echo "[4/4] 等待開機並執行測試..."
sleep 10

tmux send-keys -t $TMUX_SESSION "ifconfig net0 192.0.2.2/24" C-m
sleep 1

tmux send-keys -t $TMUX_SESSION "httpd" C-m
sleep 2

echo ""
echo "=== 啟動 HTTP 測試 ==="
tmux send-keys -t $TMUX_SESSION "curl" C-m
sleep 5

echo ""
echo "=== 測試結果 ==="
tmux capture-pane -t $TMUX_SESSION -p | grep -E "(Starting HTTP|curl:|socket|connect|received)" | head -20

echo ""
echo "=== 外部 curl 測試 (從主機) ==="
curl -s 192.0.2.2:8080

echo ""
echo "=== 清理 ==="
echo "完成後執行以下指令關閉:"
echo "  tmux kill-session -t $TMUX_SESSION"

trap "tmux kill-session -t $TMUX_SESSION 2>/dev/null; exit 0" INT
wait