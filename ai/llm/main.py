"""
main.py — 載入資料、建立模型、訓練、推理

執行方式: python main.py
"""

import os
import sys
import random

# 讓 import 能找到 nn.py（位於 ../nn/）
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'nn'))

from nn import Adam
from gpt import Gpt, train, inference

random.seed(42)

# --- 載入資料集 ---
data_file = 'input.txt'
docs = [line.strip() for line in open(data_file) if line.strip()]
random.shuffle(docs)
print(f"num docs: {len(docs)}")

# --- Tokenizer ---
uchars = sorted(set(''.join(docs)))
BOS = len(uchars)
vocab_size = len(uchars) + 1
print(f"vocab size: {vocab_size}")

# --- 建立模型 ---
model = Gpt(vocab_size, n_embd=16, n_layer=1, n_head=4, block_size=16)
print(f"num params: {len(model.params)}")

# --- 建立優化器 ---
optimizer = Adam(model.params, lr=0.01)

# --- 訓練 ---
train(model, optimizer, docs, uchars, BOS, num_steps=1000)

# --- 推理 ---
inference(model, uchars, BOS, num_samples=20, temperature=0.5)
