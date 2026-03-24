#!/bin/bash
# py0c 擴充功能測試腳本

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "========================================"
echo "py0c 擴充功能測試"
echo "========================================"

# 編譯 py0c
echo ""
echo "1. 編譯 py0c..."
cd "$SCRIPT_DIR/py0/py0c"
gcc -o py0c py0c.c -Wall -Wextra
echo "py0c 編譯完成"

# 編譯 qd0c
echo ""
echo "2. 編譯 qd0c..."
cd "$SCRIPT_DIR/qd0/qd0c"
gcc -Wall -o qd0c qd0c.c
gcc -c -o qd0lib.o qd0lib.c
echo "qd0c 編譯完成"

# 測試目錄
DATA_DIR="$SCRIPT_DIR/_data"
PY0C_DIR="$SCRIPT_DIR/py0/py0c"

echo ""
echo "========================================"
echo "執行測試"
echo "========================================"

# 測試1: 比較運算子
echo ""
echo "測試1: 比較運算子"
cd "$PY0C_DIR"
./py0c "$SCRIPT_DIR/_data/test_compare.py" -o test_compare.qd
cd "$SCRIPT_DIR/qd0/qd0c"
./qd0c "$PY0C_DIR/test_compare.qd"
clang "$PY0C_DIR/test_compare.ll" qd0lib.o -o test_compare -lm
./test_compare

# 測試2: 布林運算子
echo ""
echo "測試2: 布林運算子"
cd "$PY0C_DIR"
./py0c "$SCRIPT_DIR/_data/test_bool.py" -o test_bool.qd
cd "$SCRIPT_DIR/qd0/qd0c"
./qd0c "$PY0C_DIR/test_bool.qd"
clang "$PY0C_DIR/test_bool.ll" qd0lib.o -o test_bool -lm
./test_bool

# 測試3: while 迴圈
echo ""
echo "測試3: while 迴圈"
cd "$PY0C_DIR"
./py0c "$SCRIPT_DIR/_data/test_while3.py" -o test_while3.qd
cd "$SCRIPT_DIR/qd0/qd0c"
./qd0c "$PY0C_DIR/test_while3.qd"
clang "$PY0C_DIR/test_while3.ll" qd0lib.o -o test_while3 -lm
./test_while3

# 測試4: for 迴圈
echo ""
echo "測試4: for 迴圈"
cd "$PY0C_DIR"
./py0c "$SCRIPT_DIR/_data/test_for.py" -o test_for.qd
cd "$SCRIPT_DIR/qd0/qd0c"
./qd0c "$PY0C_DIR/test_for.qd"
clang "$PY0C_DIR/test_for.ll" qd0lib.o -o test_for -lm
./test_for

# 測試5: 綜合測試
echo ""
echo "測試5: 綜合測試"
cd "$PY0C_DIR"
./py0c "$SCRIPT_DIR/_data/test_comprehensive.py" -o test_comprehensive.qd
cd "$SCRIPT_DIR/qd0/qd0c"
./qd0c "$PY0C_DIR/test_comprehensive.qd"
clang "$PY0C_DIR/test_comprehensive.ll" qd0lib.o -o test_comprehensive -lm
./test_comprehensive

echo ""
echo "========================================"
echo "所有測試完成!"
echo "========================================"