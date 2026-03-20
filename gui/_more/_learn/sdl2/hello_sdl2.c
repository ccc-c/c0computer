#include <SDL.h>
#include <stdbool.h>
#include <stdio.h>

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;

int main(int argc, char* argv[]) {
    // 1. 初始化 SDL
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("SDL 初始化失敗: %s\n", SDL_GetError());
        return 1;
    }

    // 2. 建立視窗
    SDL_Window* window = SDL_CreateWindow(
        "SDL2 簡易繪圖範例",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
        SCREEN_WIDTH, SCREEN_HEIGHT,
        SDL_WINDOW_SHOWN
    );

    if (!window) {
        printf("視窗建立失敗: %s\n", SDL_GetError());
        return 1;
    }

    // 3. 建立渲染器 (硬體加速)
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);

    bool quit = false;
    SDL_Event e;
    SDL_Rect rect = { .x = 50, .y = 50, .w = 100, .h = 100 };

    // 4. 主迴圈
    while (!quit) {
        // 處理事件
        while (SDL_PollEvent(&e) != 0) {
            if (e.type == SDL_QUIT) {
                quit = true;
            }
        }

        // 更新邏輯：讓方塊慢慢往右下移動
        rect.x += 1;
        rect.y += 1;
        if (rect.x > SCREEN_WIDTH) rect.x = -rect.w;
        if (rect.y > SCREEN_HEIGHT) rect.y = -rect.h;

        // --- 開始繪圖 ---
        
        // 設定背景顏色為深灰色並清空畫面 (R, G, B, A)
        SDL_SetRenderDrawColor(renderer, 45, 45, 45, 255);
        SDL_RenderClear(renderer);

        // 設定畫筆為紅色並畫出方塊
        SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
        SDL_RenderFillRect(renderer, &rect);

        // 將緩衝區的內容更新到螢幕上
        SDL_RenderPresent(renderer);

        // 稍微延遲，控制幀率在大約 60 FPS
        SDL_Delay(16);
    }

    // 5. 釋放資源
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}