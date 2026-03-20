#!/bin/bash
set -x

# 將當前目錄 (.) 加入 Python 的搜尋路徑，這樣子目錄的程式才能 import nn0
export PYTHONPATH=$PYTHONPATH:.

python examples/gpt_demo.py _data/chinese.txt
python examples/mnist_demo.py

# 執行位於 examples 資料夾下的腳本
python examples/ex1-grad.py
python examples/ex2-linear.py
python examples/ex3-xor.py
python examples/ex4-classify.py
python examples/ex5-charpredicate.py
python examples/ex5b.py

