#!/bin/sh
set -x

make clean
make

cc -O0 -g -c c0c_compat.c -o c0c_compat.o

./c0c -c main.c    -o main.ll
./c0c -c macro.c   -o macro.ll
./c0c -c parser.c  -o parser.ll
./c0c -c codegen.c -o codegen.ll
./c0c -c lexer.c   -o lexer.ll
./c0c -c ast.c     -o ast.ll

clang -g lexer.ll ast.ll codegen.ll parser.ll macro.ll main.ll \
    c0c_compat.o -o c0c2

echo "=== Stage 2: c0c2 compiles itself ==="
echo "--- ast.c (smallest) ---"

# lldb script file approach — more reliable than inline -o flags
cat > /tmp/lldb_cmds.txt << 'LLDBEOF'
run -c ast.c -o ast2.ll
bt all
frame select 1
register read x0 x1 x2 x3
quit
LLDBEOF

lldb --batch -s /tmp/lldb_cmds.txt ./c0c2 2>&1