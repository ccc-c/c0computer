set -x

make clean
make

./c0c -c main.c -o main.ll
./c0c -c macro.c -o macro.ll
./c0c -c parser.c -o parser.ll
./c0c -c codegen.c -o codegen.ll
./c0c -c lexer.c -o lexer.ll

clang lexer.ll codegen.ll parser.ll macro.ll main.ll -o c0c2
