clang c0c.c -o c0c.o
./c0c.o c/$1.c -o ll/$1.ll
clang ll/$1.ll -Wno-override-module -o out/$1.o
./out/$1.o
echo $?
