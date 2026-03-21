set -x

gcc -shared -fPIC -O3 -o libnn0.so cnn0.c nn0.c -lm

gcc -O3 -o examples/test_cnn0 examples/test_cnn0.c cnn0.c nn0.c -lm -lz

# gcc cnn0.c nn0.c examples/test_cnn0.c -o examples/test_cnn0 -lm -lz

#echo "=== Training MNIST CNN ==="
#./test_cnn0 -train -n 1000 -e 1
#echo ""
#echo "=== Testing MNIST CNN ==="
#./test_cnn0 -test

gcc gpt0.c nn0.c examples/test_gpt0.c -o examples/test_gpt0
./test_gpt0 ../_data/corpus/chinese.txt

python test_nn0.py
