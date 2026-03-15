set -x
clang -Wall -Wno-unused-parameter -o qd0c qd0c.c
./qd0c fact.qd
clang fact.ll qd0lib.c -o fact.o -lm