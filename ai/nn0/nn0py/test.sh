export PYTHONPATH=$PYTHONPATH:.

set -x
python examples/ex1-grad.py
python examples/ex2-linear.py
python examples/ex3-xor.py
python examples/ex4-classify.py
python examples/ex5-charpredicate.py
python examples/ex5b.py
# python examples/test_gpt0.py ../_data/corpus/chinese.txt
python examples/test_cnn0.py ../_data/corpus/chinese.txt
