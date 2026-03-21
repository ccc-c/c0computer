#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "Building num0 (C library)"
echo "=========================================="
gcc -shared -fPIC -O2 -o libnum0.so num0.c -lm
gcc -o test_num0 test_num0.c num0.c -lm -O2

echo ""
echo "=========================================="
echo "Testing num0.c (C tests)"
echo "=========================================="
./test_num0

echo ""
echo "=========================================="
echo "Testing num0.py (Python wrapper)"
echo "=========================================="
cd "$SCRIPT_DIR/.."
PYTHONPATH="$PWD" python3 num0/test_num0.py

echo ""
echo "All num0 tests completed!"
