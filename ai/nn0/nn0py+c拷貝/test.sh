#!/bin/bash
set -x

gcc -shared -fPIC -O2 -o libnum0ad.so num0ad.c -lm
gcc -o test/test_num0ad test/test_num0ad.c num0ad.c -lm -O2

./test/test_num0ad

PYTHONPATH=. python3 test/test_num0ad.py
PYTHONPATH=. python3 test/test_nn0.py
PYTHONPATH=. python3 test/test_nn.py

