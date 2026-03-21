import struct
import gzip
import numpy as np
import ctypes
import nn0

def load_mnist_images(filepath):
    with gzip.open(filepath, 'rb') as f:
        magic, num, rows, cols = struct.unpack('>IIII', f.read(16))
        images = np.frombuffer(f.read(), dtype=np.uint8)
        images = images.reshape(num, rows, cols)
        images = images.astype(np.float64) / 255.0
    return images

def load_mnist_labels(filepath):
    with gzip.open(filepath, 'rb') as f:
        magic, num = struct.unpack('>II', f.read(8))
        labels = np.frombuffer(f.read(), dtype=np.uint8)
    return labels

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
    
    def load(self, filename):
        nn0.nn0.load_cnn(ctypes.byref(self.cnn), filename.encode())
        print(f"Model loaded from {filename}")
    
    def predict(self, images):
        predictions = []
        for i, img in enumerate(images):
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
            
            if (i + 1) % 1000 == 0:
                print(f"Processed {i+1}/{len(images)} images")
        
        return predictions
    
    def evaluate(self, images, labels):
        print("Making predictions...")
        predictions = self.predict(images)
        
        correct = sum(p == l for p, l in zip(predictions, labels))
        accuracy = correct / len(labels) * 100
        
        print(f"\nResults:")
        print(f"Total images: {len(labels)}")
        print(f"Correct: {correct}")
        print(f"Accuracy: {accuracy:.2f}%")
        
        return accuracy, predictions

def main():
    print("Loading MNIST test dataset...")
    test_images = load_mnist_images("/Users/Shared/ccc/c0computer/ai/_data/MNIST/t10k-images-idx3-ubyte.gz")
    test_labels = load_mnist_labels("/Users/Shared/ccc/c0computer/ai/_data/MNIST/t10k-labels-idx1-ubyte.gz")
    print(f"Loaded {len(test_images)} test images")
    
    model = MNIST_CNN()
    
    print("\nLoading trained model...")
    model.load("mnist_cnn.bin")
    
    print("\nEvaluating on test set...")
    accuracy, predictions = model.evaluate(test_images, test_labels)
    
    print("\nSample predictions (first 20):")
    for i in range(min(20, len(predictions))):
        status = "✓" if predictions[i] == test_labels[i] else "✗"
        print(f"  Image {i}: Predicted={predictions[i]}, Actual={test_labels[i]} {status}")

if __name__ == "__main__":
    main()
