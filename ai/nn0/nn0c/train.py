import struct
import gzip
import numpy as np
import ctypes
import nn0

def load_mnist_images(filepath):
    with gzip.open(filepath, 'rb') as f:
        magic, num, rows, cols = struct.unpack('>IIII', f.read(16))
        images = np.frombuffer(f.read(), dtype=np.uint8).reshape(num, rows, cols)
        images = images.astype(np.float64) / 255.0
    return images

def load_mnist_labels(filepath):
    with gzip.open(filepath, 'rb') as f:
        magic, num = struct.unpack('>II', f.read(8))
        labels = np.frombuffer(f.read(), dtype=np.uint8)
    return labels

def cross_entropy_loss(logits, target, num_classes):
    max_logit = max(v.data for v in logits[:num_classes])
    sum_exp = sum(np.exp(v.data - max_logit) for v in logits[:num_classes])
    log_sum_exp = max_logit + np.log(sum_exp)
    loss = log_sum_exp - logits[target].data
    return loss

def softmax(logits, num_classes):
    max_logit = max(v.data for v in logits[:num_classes])
    exps = [np.exp(v.data - max_logit) for v in logits[:num_classes]]
    sum_exp = sum(exps)
    return [e / sum_exp for e in exps]

class MNIST_CNN:
    def __init__(self):
        self.cnn = nn0.CNN()
        nn0.nn0.init_cnn(ctypes.byref(self.cnn), 64)
        
        nn0.nn0.add_conv2d(ctypes.byref(self.cnn), 1, 32, 3, 1, 1)
        nn0.nn0.add_maxpool2d(ctypes.byref(self.cnn), 2, 2)
        
        nn0.nn0.add_conv2d(ctypes.byref(self.cnn), 32, 64, 3, 1, 1)
        nn0.nn0.add_maxpool2d(ctypes.byref(self.cnn), 2, 2)
        
        nn0.nn0.add_flatten(ctypes.byref(self.cnn))
        nn0.nn0.add_linear(ctypes.byref(self.cnn), 64 * 7 * 7, 128)
        nn0.nn0.add_linear(ctypes.byref(self.cnn), 128, 10)
        
        nn0.nn0.init_optimizer()
        
    def train(self, images, labels, epochs=10, learning_rate=0.001):
        num_samples = len(images)
        
        for epoch in range(epochs):
            indices = np.random.permutation(num_samples)
            total_loss = 0.0
            correct = 0
            
            for i, idx in enumerate(indices):
                nn0.nn0.arena_reset()
                nn0.nn0.zero_grad()
                
                img = images[idx].flatten()
                input_ptr = img.ctypes.data_as(ctypes.POINTER(ctypes.c_double))
                
                logits = nn0.nn0.forward(
                    ctypes.byref(self.cnn),
                    input_ptr,
                    1, 28, 28, 1
                )
                
                probs = softmax(logits, 10)
                pred = np.argmax(probs)
                if pred == labels[idx]:
                    correct += 1
                
                sample_loss = cross_entropy_loss(logits, labels[idx], 10)
                total_loss += sample_loss
                
                nn0.nn0.backward(logits[labels[idx]])
                nn0.nn0.step_adam(i + epoch * num_samples, epochs * num_samples, learning_rate)
                
                if (i + 1) % 500 == 0:
                    acc = correct / (i + 1) * 100
                    avg_loss = total_loss / (i + 1)
                    print(f"Epoch {epoch+1}/{epochs}, Sample {i+1}/{num_samples}, "
                          f"Loss: {avg_loss:.4f}, Acc: {acc:.2f}%")
            
            acc = correct / num_samples * 100
            avg_loss = total_loss / num_samples
            print(f"Epoch {epoch+1}/{epochs}, Avg Loss: {avg_loss:.4f}, Acc: {acc:.2f}%")
            
            self.save("mnist_cnn.bin")
    
    def predict(self, images):
        predictions = []
        for img in images:
            nn0.nn0.arena_reset()
            input_data = img.flatten()
            input_ptr = input_data.ctypes.data_as(ctypes.POINTER(ctypes.c_double))
            
            logits = nn0.nn0.forward(
                ctypes.byref(self.cnn),
                input_ptr,
                1, 28, 28, 1
            )
            probs = softmax(logits, 10)
            pred = np.argmax(probs)
            predictions.append(pred)
        return predictions
    
    def save(self, filename):
        nn0.nn0.save_cnn(ctypes.byref(self.cnn), filename.encode())
        print(f"Model saved to {filename}")
    
    def load(self, filename):
        nn0.nn0.load_cnn(ctypes.byref(self.cnn), filename.encode())
        print(f"Model loaded from {filename}")

def main():
    print("Loading MNIST dataset...")
    train_images = load_mnist_images("/Users/Shared/ccc/c0computer/ai/_data/MNIST/train-images-idx3-ubyte.gz")[:1000]
    train_labels = load_mnist_labels("/Users/Shared/ccc/c0computer/ai/_data/MNIST/train-labels-idx1-ubyte.gz")[:1000]
    print(f"Loaded {len(train_images)} training images")
    
    model = MNIST_CNN()
    
    print("\nStarting training...")
    model.train(train_images, train_labels, epochs=1, learning_rate=0.001)
    
    model.save("mnist_cnn.bin")
    print("Training complete!")

if __name__ == "__main__":
    main()
