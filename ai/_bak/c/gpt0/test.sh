gcc -I . -I ../nn0 gpt0.c ../nn0/nn0.c test_gpt0.c -o test_gpt
./test_gpt ../data/corpus/chinese.txt
