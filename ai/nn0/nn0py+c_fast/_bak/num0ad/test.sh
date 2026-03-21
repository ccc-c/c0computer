#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "Building num0ad (C library)"
echo "=========================================="
gcc -shared -fPIC -O2 -o libnum0ad.so num0ad.c -lm
gcc -o test_num0ad test_num0ad.c num0ad.c -lm -O2

echo ""
echo "=========================================="
echo "Testing num0ad.c (C tests)"
echo "=========================================="
./test_num0ad

echo ""
echo "=========================================="
echo "Testing num0ad.py (Python wrapper)"
echo "=========================================="
cd "$SCRIPT_DIR/.."
PYTHONPATH="$PWD" python3 num0ad/test_num0ad.py

echo ""
echo "All num0ad tests completed!"
