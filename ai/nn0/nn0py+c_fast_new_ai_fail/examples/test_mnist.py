"""
test_mnist.py — MNIST 訓練與預測程式
使用 cnn0.py 的 CNN 實現
"""

import numpy as np
import os
from cnn0 import Conv2d, MaxPool2d, Flatten, Linear, SimpleCNN
from nn0 import Tensor, Adam


def load_mnist_images(filepath):
    with open(filepath, 'rb') as f:
        magic, num, rows, cols = np.frombuffer(f.read(16), dtype='>i4')
        images = np.frombuffer(f.read(), dtype='>u1')
        images = images.reshape(num, rows, cols)
    return images


def load_mnist_labels(filepath):
    with open(filepath, 'rb') as f:
        magic, num = np.frombuffer(f.read(8), dtype='>i4')
        labels = np.frombuffer(f.read(), dtype='>u1')
    return labels


def download_mnist():
    data_dir = './data'
    os.makedirs(data_dir, exist_ok=True)
    
    base_url = 'https://ossci-datasets.s3.amazonaws.com/mnist/'
    files = [
        ('train-images-idx3-ubyte.gz', 'train-images-idx3-ubyte'),
        ('train-labels-idx1-ubyte.gz', 'train-labels-idx1-ubyte'),
        ('t10k-images-idx3-ubyte.gz', 't10k-images-idx3-ubyte'),
        ('t10k-labels-idx1-ubyte.gz', 't10k-labels-idx1-ubyte')
    ]
    
    try:
        import gzip
        import urllib.request
        
        for gz_name, out_name in files:
            gzpath = os.path.join(data_dir, gz_name)
            outpath = os.path.join(data_dir, out_name)
            if not os.path.exists(outpath):
                print(f"Downloading {gz_name}...")
                urllib.request.urlretrieve(base_url + gz_name, gzpath)
                with gzip.open(gzpath, 'rb') as f_in:
                    with open(outpath, 'wb') as f_out:
                        f_out.write(f_in.read())
                os.remove(gzpath)
                print(f"  Done: {out_name}")
        return True
    except Exception as e:
        print(f"Download failed: {e}")
        return False


def load_data():
    data_dir = './data'
    os.makedirs(data_dir, exist_ok=True)
    
    mnist_files = {
        'train-images': 'train-images-idx3-ubyte.gz',
        'train-labels': 'train-labels-idx1-ubyte.gz',
        't10k-images': 't10k-images-idx3-ubyte.gz',
        't10k-labels': 't10k-labels-idx1-ubyte.gz'
    }
    
    files_exist = all(
        os.path.exists(os.path.join(data_dir, f))
        for f in mnist_files.values()
    )
    
    if not files_exist:
        if not download_mnist():
            print("Using random data for testing...")
            X_train = np.random.randn(1000, 1, 28, 28).astype(np.float64) / 255.0
            y_train = np.random.randint(0, 10, 1000)
            X_test = np.random.randn(100, 1, 28, 28).astype(np.float64) / 255.0
            y_test = np.random.randint(0, 10, 100)
            return X_train, y_train, X_test, y_test
    
    X_train = load_mnist_images(os.path.join(data_dir, 'train-images-idx3-ubyte'))
    y_train = load_mnist_labels(os.path.join(data_dir, 'train-labels-idx1-ubyte'))
    X_test = load_mnist_images(os.path.join(data_dir, 't10k-images-idx3-ubyte'))
    y_test = load_mnist_labels(os.path.join(data_dir, 't10k-labels-idx1-ubyte'))
    
    X_train = X_train.astype(np.float64) / 255.0
    X_test = X_test.astype(np.float64) / 255.0
    
    X_train = X_train.reshape(-1, 1, 28, 28)
    X_test = X_test.reshape(-1, 1, 28, 28)
    
    return X_train, y_train, X_test, y_test


def cross_entropy_loss(logits, targets):
    logits_data = logits.data if isinstance(logits, Tensor) else logits
    max_val = np.max(logits_data, axis=1, keepdims=True)
    exps = np.exp(logits_data - max_val)
    probs = exps / np.sum(exps, axis=1, keepdims=True)
    N = logits_data.shape[0]
    targets_arr = np.array(targets)
    loss = -np.mean(np.log(probs[np.arange(N), targets_arr] + 1e-8))
    return Tensor(loss)


def accuracy(logits, targets):
    logits_data = logits.data if isinstance(logits, Tensor) else logits
    preds = np.argmax(logits_data, axis=1)
    targets_arr = np.array(targets)
    return np.mean(preds == targets_arr)


class MNISTNet:
    def __init__(self):
        self.conv1 = Conv2d(1, 8, kernel_size=3, stride=1, pad=1)
        self.pool1 = MaxPool2d(kernel_size=2, stride=2)
        self.flatten = Flatten()
        self.fc1 = Linear(8 * 14 * 14, 10)
    
    def __call__(self, x):
        x = self.conv1(x)
        x = x.relu()
        x = self.pool1(x)
        x = self.flatten(x)
        x = self.fc1(x)
        return x
    
    def parameters(self):
        return [
            self.conv1.weight, self.conv1.bias,
            self.fc1.weight, self.fc1.bias
        ]


def train_epoch(model, optimizer, X, y, batch_size=64):
    indices = np.random.permutation(len(X))
    total_loss = 0
    total_acc = 0
    num_batches = 0
    
    for start in range(0, len(X), batch_size):
        end = min(start + batch_size, len(X))
        batch_idx = indices[start:end]
        
        X_batch = X[batch_idx]
        y_batch = y[batch_idx]
        
        X_tensor = Tensor(X_batch)
        logits = model(X_tensor)
        
        loss = cross_entropy_loss(logits, y_batch)
        acc = accuracy(logits, y_batch)
        
        loss.backward()
        optimizer.step()
        
        total_loss += loss.item
        total_acc += acc
        num_batches += 1
    
    return total_loss / num_batches, total_acc / num_batches


def evaluate(model, X, y, batch_size=100):
    total_correct = 0
    total_samples = 0
    
    for start in range(0, len(X), batch_size):
        end = min(start + batch_size, len(X))
        X_batch = X[start:end]
        y_batch = y[start:end]
        
        X_tensor = Tensor(X_batch)
        logits = model(X_tensor)
        acc = accuracy(logits, y_batch)
        total_correct += acc * len(y_batch)
        total_samples += len(y_batch)
    
    return total_correct / total_samples


def predict(model, X):
    X_tensor = Tensor(X)
    logits = model(X_tensor)
    preds = np.argmax(logits.data, axis=1)
    probs = np.exp(logits.data - np.max(logits.data, axis=1, keepdims=True))
    probs = probs / np.sum(probs, axis=1, keepdims=True)
    return preds, probs


def main():
    print("Loading MNIST data...")
    X_train, y_train, X_test, y_test = load_data()
    
    X_train = X_train[:500]
    y_train = y_train[:500]
    X_test = X_test[:100]
    y_test = y_test[:100]
    
    print(f"Train: {X_train.shape}, Test: {X_test.shape}")
    
    print("\nCreating model...")
    model = MNISTNet()
    optimizer = Adam(model.parameters(), lr=0.001)
    
    print("\nTraining...")
    epochs = 3
    batch_size = 50
    
    for epoch in range(epochs):
        train_loss, train_acc = train_epoch(model, optimizer, X_train, y_train, batch_size)
        test_acc = evaluate(model, X_test, y_test)
        
        print(f"Epoch {epoch+1}/{epochs} - "
              f"Train Loss: {train_loss:.4f}, "
              f"Train Acc: {train_acc:.4f}, "
              f"Test Acc: {test_acc:.4f}")
    
    print("\nPredicting on test set...")
    preds, probs = predict(model, X_test[:10])
    
    print("\nSample predictions:")
    print("True:    ", y_test[:10])
    print("Pred:    ", preds)
    print("Conf:    ", [f"{p*100:.1f}%" for p in probs[np.arange(10), preds]])
    
    final_acc = evaluate(model, X_test, y_test)
    print(f"\nFinal test accuracy: {final_acc:.4f}")
    
    return model, final_acc


if __name__ == "__main__":
    model, acc = main()
