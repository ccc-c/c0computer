export PYTHONPATH=$PYTHONPATH:.

set -x
python examples/test_nn0.py
python examples/test_cnn0.py
python examples/test_torch0.py
python examples/test_mnist.py
#python examples/test_torch0cnn.py
#python examples/test_mnist.py
