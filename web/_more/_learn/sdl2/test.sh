#!/bin/bash

set -x

# 使用 sdl2-config 自動抓取標頭檔和函式庫路徑並編譯
gcc hello_sdl2.c -o hello_sdl2 `sdl2-config --cflags --libs`

# 執行編譯出的程式
./hello_sdl2
