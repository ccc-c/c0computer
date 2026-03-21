#!/bin/bash

cd "$(dirname "$0")"

echo "=========================================="
echo "Testing nn0.py"
echo "=========================================="
python test_nn0.py

echo ""
echo "=========================================="
echo "Testing cnn0.py"
echo "=========================================="
python test_cnn0.py

echo ""
echo "=========================================="
echo "Testing num0/ (C + Python)"
echo "=========================================="
cd num0 && bash test.sh
cd ..

echo ""
echo "=========================================="
echo "All tests completed!"
echo "=========================================="
