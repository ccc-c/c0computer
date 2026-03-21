.PHONY: all clean mnist train test

all: libnn0.so test_mnist

libnn0.so: cnn0.c cnn0.h nn0.c nn0.h
	gcc -shared -fPIC -O3 -o libnn0.so cnn0.c nn0.c -lm

test_mnist: test_mnist.c cnn0.c cnn0.h nn0.c nn0.h
	gcc -O3 -o test_mnist test_mnist.c cnn0.c nn0.c -lm -lz

mnist: test_mnist
	@echo "=== Training MNIST CNN ==="
	./test_mnist -train -n 1000 -e 1
	@echo ""
	@echo "=== Testing MNIST CNN ==="
	./test_mnist -test

train:
	./test_mnist -train -n 1000 -e 1

test:
	./test_mnist -test

clean:
	rm -f libnn0.so test_mnist mnist_cnn.bin test_hello minimal.c a.out
