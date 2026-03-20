#include <SDL.h>
#include <SDL_ttf.h>
#include "md0render/md0render.h"

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s file.md\n", argv[0]);
        return 1;
    }

    App app = {0};
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS) < 0) {
        printf("SDL init failed: %s\n", SDL_GetError());
        return 1;
    }
    if (TTF_Init() < 0) {
        printf("TTF init failed: %s\n", TTF_GetError());
        SDL_Quit();
        return 1;
    }

    // 【修复】设置渲染缩放质量为线性（文字更清晰）
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");

    // 创建窗口：开启高DPI + 可调整大小（方便测试）
    Uint32 window_flags = SDL_WINDOW_ALLOW_HIGHDPI | SDL_WINDOW_RESIZABLE;
    app.win = SDL_CreateWindow(
        "md0r", 
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 
        WINDOW_WIDTH, WINDOW_HEIGHT, 
        window_flags
    );
    if (!app.win) {
        printf("Window create failed: %s\n", SDL_GetError());
        TTF_Quit();
        SDL_Quit();
        return 1;
    }

    // 创建渲染器（硬件加速+垂直同步）
    Uint32 render_flags = SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC;
    app.ren = SDL_CreateRenderer(app.win, -1, render_flags);
    if (!app.ren) {
        printf("Renderer create failed: %s\n", SDL_GetError());
        SDL_DestroyWindow(app.win);
        TTF_Quit();
        SDL_Quit();
        return 1;
    }

    // 初始化缩放比例（关键！Retina屏设为2.0）
    app.scale = get_window_scale(app.win);
    // 设置渲染器混合模式
    SDL_SetRenderDrawBlendMode(app.ren, SDL_BLENDMODE_BLEND);
    // 适配渲染器缩放（匹配窗口缩放比例）
    SDL_RenderSetScale(app.ren, app.scale, app.scale);

    // 计算逻辑边距
    app.margin = get_margin_px(&app);

    // 加载中文字体（增大字体尺寸后更清晰）
    app.font = TTF_OpenFont("/System/Library/Fonts/PingFang.ttc", FONT_SIZE);
    if (!app.font) app.font = TTF_OpenFont("/System/Library/Fonts/STHeiti Light.ttc", FONT_SIZE);
    if (!app.font) app.font = TTF_OpenFont("/System/Library/Fonts/Helvetica.ttc", FONT_SIZE);
    if (!app.font) {
        printf("Font load failed! %s\n", TTF_GetError());
        SDL_DestroyRenderer(app.ren);
        SDL_DestroyWindow(app.win);
        TTF_Quit();
        SDL_Quit();
        return 1;
    }

    // 字体优化（提升锐度）
    TTF_SetFontHinting(app.font, TTF_HINTING_NORMAL);
    TTF_SetFontKerning(app.font, 1);

    // 加载MD文件
    load_file(&app, argv[1]);

    // 事件循环（新增窗口大小改变处理）
    SDL_Event e;
    int running = 1;
    while (running) {
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) {
                running = 0;
            }
            // 新增：窗口大小改变时重新计算边距+渲染
            else if (e.type == SDL_WINDOWEVENT && e.window.event == SDL_WINDOWEVENT_RESIZED) {
                app.margin = get_margin_px(&app);
                rerender(&app);
            }
            else if (e.type == SDL_MOUSEWHEEL) {
                app.scroll_y -= e.wheel.y * 30;
                if (app.scroll_y < 0) app.scroll_y = 0;
                int max_scroll = app.content_total_height - (WINDOW_HEIGHT - app.margin);
                if (max_scroll < 0) max_scroll = 0;
                if (app.scroll_y > max_scroll) app.scroll_y = max_scroll;
                rerender(&app);
            }
            else if (e.type == SDL_MOUSEBUTTONDOWN) {
                int mx = e.button.x / app.scale; // 物理坐标→逻辑坐标
                int my = e.button.y / app.scale;
                for (int i = 0; i < app.link_count; i++) {
                    SDL_Rect r = app.links[i].rect;
                    if (mx >= r.x && mx <= r.x + r.w && my >= r.y && my <= r.y + r.h) {
                        char full_path[MAX_PATH];
                        join_path(full_path, app.current_dir, app.links[i].url);
                        printf("Loading: %s\n", full_path);
                        load_file(&app, full_path);
                        break;
                    }
                }
            }
        }
    }

    // 清理资源
    free_links(&app);
    if (app.content) free(app.content);
    if (app.font) TTF_CloseFont(app.font);
    SDL_DestroyRenderer(app.ren);
    SDL_DestroyWindow(app.win);
    TTF_Quit();
    SDL_Quit();

    return 0;
}