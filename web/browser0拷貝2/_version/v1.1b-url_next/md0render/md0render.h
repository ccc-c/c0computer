#ifndef MD_RENDER_H
#define MD_RENDER_H

#include <SDL.h>
#include <SDL_ttf.h>

// --- 配置 ---
#define WINDOW_WIDTH   360
#define WINDOW_HEIGHT  480
#define NAV_BAR_HEIGHT 30
#define FONT_SIZE      12
#define MARGIN_CM      0.5f
#define MAX_LINKS      64
#define MAX_PATH       512
#define MAX_LINE_BUF   1024
#define MAX_HISTORY    64

// --- 狀態結構 ---
typedef struct {
    char url[MAX_PATH];
    SDL_Rect rect;
} Link;

typedef struct {
    char path[MAX_PATH];
    int  is_url;
} HistoryEntry;

typedef struct {
    SDL_Window*   win;
    SDL_Renderer* ren;
    TTF_Font*     font;
    int           margin;
    
    char*         content;
    Link          links[MAX_LINKS];
    int           link_count;
    
    char          root_dir[MAX_PATH];
    char          current_file[MAX_PATH];
    char          current_dir[MAX_PATH];
    int           scroll_y;
    int           content_total_height;
    int           is_url;
    
    HistoryEntry  history[MAX_HISTORY];
    int           history_pos;
    int           history_count;
} App;

int   get_margin_px(SDL_Window* win);
void  load_file(App* app, const char* path);
void  load_url(App* app, const char* url);
void  rerender(App* app);
void  draw_nav_bar(App* app);
void  join_path(char* result, const char* root, const char* dir, const char* filename);
int   is_url(const char* str);
void  history_push(App* app, const char* path, int is_url);
void  history_back(App* app);
void  history_forward(App* app);
int   history_can_back(App* app);
int   history_can_forward(App* app);
int   is_nav_button_click(App* app, int x, int y);

#endif