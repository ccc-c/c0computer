#!/bin/sh
set -x

make clean
make   # produces c0c from host C compiler

# Compile the compatibility shim with the system C compiler
cc -O2 -c c0c_compat.c -o c0c_compat.o

# Stage 1: use c0c to compile itself to LLVM IR
./c0c -c main.c    -o main.ll
./c0c -c macro.c   -o macro.ll
./c0c -c parser.c  -o parser.ll
./c0c -c codegen.c -o codegen.ll
./c0c -c lexer.c   -o lexer.ll
./c0c -c ast.c     -o ast.ll

# Link all LLVM IR files + compat shim to produce c0c2
clang lexer.ll ast.ll codegen.ll parser.ll macro.ll main.ll c0c_compat.o -o c0c2

echo "=== Stage 2: c0c2 compiles itself ==="

./c0c2 -c main.c    -o main2.ll
./c0c2 -c macro.c   -o macro2.ll
./c0c2 -c parser.c  -o parser2.ll
./c0c2 -c codegen.c -o codegen2.ll
./c0c2 -c lexer.c   -o lexer2.ll
./c0c2 -c ast.c     -o ast2.ll

clang lexer2.ll ast2.ll codegen2.ll parser2.ll macro2.ll main2.ll c0c_compat.o -o c0c3

echo "=== Self-hosting test passed if c0c3 exists and runs ==="
./c0c3 -v
