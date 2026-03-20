#ifndef MD0RENDER_H
#define MD0RENDER_H

#include <SDL.h>
#include <SDL_ttf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

// 【修复】缩小逻辑窗口尺寸（高DPI下物理尺寸会自动×2，避免窗口过大）
#define WINDOW_WIDTH 600
#define WINDOW_HEIGHT 450
// 【修复】增大默认字体尺寸（解决文字过小）
#define FONT_SIZE 24
#define MAX_PATH 1024
#define MAX_CONTENT 1024 * 1024
#define MAX_LINKS 1024

// 链接结构体
typedef struct {
    char url[MAX_PATH];
    SDL_Rect rect;
} Link;

// 主应用结构体
typedef struct {
    SDL_Window *win;
    SDL_Renderer *ren;
    TTF_Font *font;
    int margin;               // 逻辑边距（适配高DPI）
    int scroll_y;             // 逻辑滚动偏移
    char *content;
    int content_total_height; // 逻辑内容总高度
    char current_dir[MAX_PATH];
    Link links[MAX_LINKS];
    int link_count;
    float scale;              // 新增：窗口缩放比例（Retina屏为2.0）
} App;

// 显式extern声明
#ifdef __cplusplus
extern "C" {
#endif

extern int get_margin_px(App *app); // 修复：基于App的缩放计算边距
extern void join_path(char *out, const char *dir, const char *file);
extern void load_file(App *app, const char *path);
extern void rerender(App *app);
extern void render_text(App *app, const char *text, int x, int y, SDL_Color color);
extern void free_links(App *app);
extern float get_window_scale(SDL_Window *win);

#ifdef __cplusplus
}
#endif

#endif // MD0RENDER_H