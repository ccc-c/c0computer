#!/bin/bash
set -x

# 获取SDL2编译参数
SDL2_CFLAGS=$(sdl2-config --cflags)
SDL2_LIBS=$(sdl2-config --libs)

# 编译命令（兼容arm64，无高版本SDL函数）
clang -std=c99 -Wall -O2 \
  -I. -I md0render/ \
  md0render/md0render.c browser0.c \
  -o browser0 \
  ${SDL2_CFLAGS} ${SDL2_LIBS} -lSDL2_ttf

# 检查编译是否成功
if [ $? -eq 0 ]; then
    echo "Compile success! Run with: ./browser0 md/index.md"
else
    echo "Compile failed!"
    exit 1
fi

./browser0 md/index.md