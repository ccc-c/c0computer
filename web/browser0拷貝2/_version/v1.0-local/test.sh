set -x

# 使用 sdl2-config 自動抓取標頭檔和函式庫路徑並編譯
clang -I md0render/ md0render/md0render.c browser0.c -o browser0 `sdl2-config --cflags --libs`  -lSDL2_ttf

./browser0 md/index.md
