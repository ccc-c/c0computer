"""
mnist.py — MNIST 手寫數字辨識 (真實資料訓練)
"""
import gzip
import os
import sys
import struct
import time
import random
sys.path.insert(0, '..')

from nn0 import Tensor
from nn import (
    Module, Conv2d, MaxPool2d, Linear, ReLU,
    Sequential, SGD, CrossEntropyLoss, no_grad
)


class SimpleMLP(Module):
    """MNIST 簡單 MLP 模型 (無卷積, 速度較快)"""
    def __init__(self):
        super().__init__()
        self.net = Sequential(
            Linear(28 * 28, 128),
            ReLU(),
            Linear(128, 64),
            ReLU(),
            Linear(64, 10),
        )
    
    def forward(self, x):
        x = x.reshape(x.shape[0], -1)
        return self.net(x)
    
    def train_mode(self):
        self._training = True
    
    def eval_mode(self):
        self._training = False


def download_file(url, filepath):
    """下載檔案"""
    if os.path.exists(filepath) and os.path.getsize(filepath) > 1000:
        print(f"已存在: {filepath}")
        return
    print(f"下載: {url}")
    import urllib.request
    import ssl
    ctx = ssl.create_default_context()
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_NONE
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req, context=ctx) as resp:
        with open(filepath, 'wb') as f:
            f.write(resp.read())
    print(f"下載完成: {filepath}")


def read_idx3(filepath):
    """讀取 IDX3 格式 (影像)"""
    with gzip.open(filepath, 'rb') as f:
        magic = int.from_bytes(f.read(4), 'big')
        num_images = int.from_bytes(f.read(4), 'big')
        rows = int.from_bytes(f.read(4), 'big')
        cols = int.from_bytes(f.read(4), 'big')
        buf = list(f.read())
        data = []
        for i in range(num_images):
            img = []
            for r in range(rows):
                row = []
                for c in range(cols):
                    idx = i * rows * cols + r * cols + c
                    row.append(buf[idx] / 255.0)
                img.append(row)
            data.append(img)
        return data, num_images


def read_idx1(filepath):
    """讀取 IDX1 格式 (標籤)"""
    with gzip.open(filepath, 'rb') as f:
        num_labels = int.from_bytes(f.read(4), 'big')
        buf = f.read()
        return list(buf), num_labels


def load_mnist(data_dir='./data/mnist'):
    """下載並載入 MNIST"""
    os.makedirs(data_dir, exist_ok=True)
    base_url = 'https://ossci-datasets.s3.amazonaws.com/mnist/'
    
    files = [
        ('train-images.gz', 'train-images-idx3-ubyte.gz'),
        ('train-labels.gz', 'train-labels-idx1-ubyte.gz'),
        ('test-images.gz', 't10k-images-idx3-ubyte.gz'),
        ('test-labels.gz', 't10k-labels-idx1-ubyte.gz'),
    ]
    
    for local, remote in files:
        download_file(base_url + remote, os.path.join(data_dir, local))
    
    print("\n解析資料...")
    train_x, n_train = read_idx3(os.path.join(data_dir, 'train-images.gz'))
    train_y, _ = read_idx1(os.path.join(data_dir, 'train-labels.gz'))
    test_x, n_test = read_idx3(os.path.join(data_dir, 'test-images.gz'))
    test_y, _ = read_idx1(os.path.join(data_dir, 'test-labels.gz'))
    
    print(f"訓練集: {n_train} 張, 測試集: {n_test} 張")
    return train_x, train_y, test_x, test_y


def create_batches(images, labels, batch_size, shuffle=True):
    """建立批次"""
    indices = list(range(len(images)))
    if shuffle:
        random.shuffle(indices)
    
    batches_x = []
    batches_y = []
    for i in range(0, len(indices), batch_size):
        batch_indices = indices[i:i + batch_size]
        batch_x = [images[idx] for idx in batch_indices]
        batch_y = [[labels[idx]] for idx in batch_indices]
        batches_x.append(Tensor(batch_x))
        batches_y.append(Tensor(batch_y))
    return batches_x, batches_y


def train_mnist():
    print("=" * 50)
    print("MNIST 手寫數字辨識訓練")
    print("=" * 50)
    
    print("\n[1] 載入資料...")
    train_x, train_y, test_x, test_y = load_mnist()
    
    train_x, train_y = train_x[:2000], train_y[:2000]
    test_x, test_y = test_x[:500], test_y[:500]
    print(f"  使用子集: 訓練 {len(train_x)} 張, 測試 {len(test_x)} 張")
    
    print("\n[2] 建立模型...")
    model = SimpleMLP()
    
    print("\n[3] 訓練設定...")
    criterion = CrossEntropyLoss()
    optimizer = SGD(model.parameters(), lr=0.01, momentum=0.9)
    
    epochs = 1
    batch_size = 64
    print(f"  - 優化器: SGD (lr=0.01, momentum=0.9)")
    print(f"  - 損失函數: CrossEntropyLoss")
    print(f"  - Epochs: {epochs}, Batch size: {batch_size}")
    
    print("\n[4] 開始訓練...")
    print("-" * 50)
    
    for epoch in range(epochs):
        model.train_mode()
        batches_x, batches_y = create_batches(train_x, train_y, batch_size, shuffle=True)
        
        total_loss = 0
        correct = 0
        total = 0
        
        start_time = time.time()
        
        for i, (batch_x, batch_y) in enumerate(zip(batches_x, batches_y)):
            optimizer.zero_grad()
            
            outputs = model(batch_x)
            loss = criterion(outputs, batch_y)
            
            loss.backward()
            optimizer.step()
            
            loss_val = loss.data[0][0] if isinstance(loss.data, list) else loss.data
            total_loss += loss_val
            
            preds = outputs._get_data_list()
            for j, pred in enumerate(preds):
                label = int(batch_y._get_data_list()[j][0])
                if pred.index(max(pred)) == label:
                    correct += 1
                total += 1
            
            if (i + 1) % 50 == 0:
                print(f"  Epoch {epoch+1}, Batch {i+1}/{len(batches_x)}, Loss: {total_loss/(i+1):.4f}")
        
        epoch_time = time.time() - start_time
        train_acc = 100.0 * correct / total
        avg_loss = total_loss / len(batches_x)
        
        print(f"  Epoch {epoch+1}/{epochs} - Loss: {avg_loss:.4f} - Acc: {train_acc:.2f}% - Time: {epoch_time:.1f}s")
        
        print("\n[5] 評估模型...")
        model.eval_mode()
        test_batches_x, test_batches_y = create_batches(test_x, test_y, batch_size, shuffle=False)
        
        test_correct = 0
        test_total = 0
        
        with no_grad():
            for batch_x, batch_y in zip(test_batches_x, test_batches_y):
                outputs = model(batch_x)
                preds = outputs._get_data_list()
                labels = batch_y._get_data_list()
                for j, pred in enumerate(preds):
                    label = int(labels[j][0])
                    if pred.index(max(pred)) == label:
                        test_correct += 1
                    test_total += 1
        
        test_acc = 100.0 * test_correct / test_total
        print(f"  測試準確率: {test_acc:.2f}%")
        print("-" * 50)
    
    print("\n訓練完成!")
    
    print("\n[6] 測試單筆推論...")
    with no_grad():
        test_input = Tensor([test_x[0]])
        output = model(test_input)
        pred_probs = output._get_data_list()[0]
        pred_label = pred_probs.index(max(pred_probs))
        print(f"  預測: {pred_label}, 實際: {test_y[0]}")
        print(f"  信心度: {max(pred_probs)*100:.1f}%")
    
    return model


if __name__ == "__main__":
    train_mnist()
