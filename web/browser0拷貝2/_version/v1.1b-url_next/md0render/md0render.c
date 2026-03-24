#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include "md0render.h"
#include "../net/http.h"

static int utf8_char_len(const char c) {
    if ((c & 0x80) == 0) return 1;
    if ((c & 0xE0) == 0xC0) return 2;
    if ((c & 0xF0) == 0xE0) return 3;
    if ((c & 0xF8) == 0xF0) return 4;
    return 1;
}

void join_path(char* result, const char* root, const char* dir, const char* filename) {
    if (is_url(filename)) {
        strncpy(result, filename, MAX_PATH - 1);
        result[MAX_PATH - 1] = '\0';
    } else if (filename[0] == '/') {
        strncpy(result, filename, MAX_PATH - 1);
        result[MAX_PATH - 1] = '\0';
    } else {
        if (dir && dir[0]) {
            snprintf(result, MAX_PATH, "%s/%s/%s", root, dir, filename);
        } else {
            snprintf(result, MAX_PATH, "%s/%s", root, filename);
        }
    }
}

static char* read_file(const char* path) {
    FILE* f = fopen(path, "rb");
    if (!f) return NULL;
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    char* buf = malloc(size + 1);
    fread(buf, 1, size, f);
    buf[size] = '\0';
    fclose(f);
    return buf;
}

int get_margin_px(SDL_Window* win) {
    int idx = SDL_GetWindowDisplayIndex(win);
    float ddpi, hdpi, vdpi;
    if (SDL_GetDisplayDPI(idx, &ddpi, &hdpi, &vdpi) == 0) {
        return (int)((hdpi / 2.54f) * MARGIN_CM);
    }
    return (int)((96.0f / 2.54f) * MARGIN_CM);
}

static void draw_text_segment(App* app, int* x, int* y, const char* text, int len, SDL_Color color, const char* url) {
    if (len <= 0) return;

    int line_height = TTF_FontHeight(app->font);
    int max_content_width = WINDOW_WIDTH - 2 * app->margin;
    
    int ptr = 0;
    while (ptr < len) {
        char line_buf[MAX_LINE_BUF] = {0};
        int line_len = 0;
        int line_w = 0;
        
        while (ptr < len) {
            int char_len = utf8_char_len(text[ptr]);
            if (ptr + char_len > len) char_len = len - ptr;
            
            char tmp_char[5] = {0};
            strncpy(tmp_char, &text[ptr], char_len);
            
            int test_w, test_h;
            char test_buf[MAX_LINE_BUF] = {0};
            strncpy(test_buf, line_buf, line_len);
            strncat(test_buf, tmp_char, char_len);
            TTF_SizeUTF8(app->font, test_buf, &test_w, &test_h);
            
            if (*x + test_w > max_content_width) {
                if (line_len == 0) {
                    strncpy(line_buf, tmp_char, char_len);
                    line_len += char_len;
                    line_w = test_w;
                    ptr += char_len;
                }
                break;
            }
            
            strncpy(&line_buf[line_len], tmp_char, char_len);
            line_len += char_len;
            line_w = test_w;
            ptr += char_len;
        }
        
        if (line_len > 0) {
            SDL_Surface* surf = TTF_RenderUTF8_Blended(app->font, line_buf, color);
            SDL_Texture* tex = SDL_CreateTextureFromSurface(app->ren, surf);
            
            SDL_Rect dst = {*x, *y - app->scroll_y, surf->w, surf->h};
            SDL_RenderCopy(app->ren, tex, NULL, &dst);
            
            if (url && app->link_count < MAX_LINKS) {
                strncpy(app->links[app->link_count].url, url, MAX_PATH-1);
                app->links[app->link_count].rect = dst;
                app->link_count++;
            }
            
            SDL_FreeSurface(surf);
            SDL_DestroyTexture(tex);
            *x += line_w;
        }
        
        if (ptr < len) {
            *x = app->margin;
            *y += line_height + 4;
        }
    }
}

void rerender(App* app) {
    if (app->current_file[0] == '\0') return;
    
    app->link_count = 0;
    
    if (!app->is_url) {
        if (app->content) {
            free(app->content);
            app->content = NULL;
        }
        char tmp_path[MAX_PATH];
        strncpy(tmp_path, app->current_file, MAX_PATH);
        char* dir = dirname(tmp_path);
        strncpy(app->current_dir, dir, MAX_PATH);
        
        app->content = read_file(app->current_file);
        if (!app->content) {
            printf("Cannot open file: %s\n", app->current_file);
            return;
        }
    }
    
    SDL_SetRenderDrawColor(app->ren, 255, 255, 255, 255);
    SDL_RenderClear(app->ren);
    
    draw_nav_bar(app);
    
    int x = app->margin;
    int y = NAV_BAR_HEIGHT + 10;
    int i = 0;
    int len = strlen(app->content);
    int line_height = TTF_FontHeight(app->font);
    
    SDL_Color black = {0, 0, 0, 255};
    SDL_Color blue  = {0, 0, 255, 255};
    
    while (i < len) {
        if (app->content[i] == '\n') {
            x = app->margin;
            y += line_height + 8;
            i++;
            continue;
        }
        
        if (app->content[i] == '[') {
            i++;
            int start_text = i;
            while (i < len && app->content[i] != ']') i++;
            int text_len = i - start_text;
            
            i++;
            if (i < len && app->content[i] == '(') {
                i++;
                int start_url = i;
                while (i < len && app->content[i] != ')') i++;
                int url_len = i - start_url;
                
                char url[MAX_PATH];
                strncpy(url, &app->content[start_url], url_len);
                url[url_len] = '\0';
                
                draw_text_segment(app, &x, &y, &app->content[start_text], text_len, blue, url);
                
                i++;
                continue;
            }
        }
        
        int start = i;
        while (i < len && app->content[i] != '[' && app->content[i] != '\n') i++;
        draw_text_segment(app, &x, &y, &app->content[start], i - start, black, NULL);
    }
    
    app->content_total_height = y;
    
    SDL_RenderPresent(app->ren);
}

void load_url(App* app, const char* url) {
    printf("Fetching URL: %s\n", url);
    
    HttpResponse resp = http_get(url);
    
    if (resp.data && resp.size > 0) {
        if (app->content) free(app->content);
        app->content = strdup(resp.data);
        
        memset(app->current_file, 0, MAX_PATH);
        strcpy(app->current_file, url);
        
        app->scroll_y = 0;
        app->is_url = 1;
        strcpy(app->current_dir, "");
        
        rerender(app);
    } else {
        printf("Failed to fetch URL: %s\n", resp.error);
    }
    
    http_response_free(&resp);
}

void load_file(App* app, const char* filepath) {
    app->scroll_y = 0;
    app->is_url = 0;
    
    if (is_url(filepath)) {
        load_url(app, filepath);
        return;
    }
    
    if (filepath[0] == '/') {
        strncpy(app->current_file, filepath, MAX_PATH - 1);
        app->current_file[MAX_PATH - 1] = '\0';
    } else {
        char full_path[MAX_PATH];
        join_path(full_path, app->root_dir, "", filepath);
        strncpy(app->current_file, full_path, MAX_PATH - 1);
        app->current_file[MAX_PATH - 1] = '\0';
    }
    
    history_push(app, app->current_file, app->is_url);
    rerender(app);
}

void history_push(App* app, const char* path, int is_url) {
    if (app->history_pos < app->history_count - 1) {
        app->history_count = app->history_pos + 1;
    }
    
    if (app->history_count >= MAX_HISTORY) {
        for (int i = 0; i < MAX_HISTORY - 1; i++) {
            app->history[i] = app->history[i + 1];
        }
        app->history_count = MAX_HISTORY - 1;
        app->history_pos = app->history_count - 1;
    }
    
    strncpy(app->history[app->history_count].path, path, MAX_PATH - 1);
    app->history[app->history_count].path[MAX_PATH - 1] = '\0';
    app->history[app->history_count].is_url = is_url;
    app->history_count++;
    app->history_pos = app->history_count - 1;
}

void history_back(App* app) {
    if (app->history_pos > 0) {
        app->history_pos--;
        const char* path = app->history[app->history_pos].path;
        app->is_url = app->history[app->history_pos].is_url;
        strncpy(app->current_file, path, MAX_PATH - 1);
        app->current_file[MAX_PATH - 1] = '\0';
        app->scroll_y = 0;
        rerender(app);
    }
}

void history_forward(App* app) {
    if (app->history_pos < app->history_count - 1) {
        app->history_pos++;
        const char* path = app->history[app->history_pos].path;
        app->is_url = app->history[app->history_pos].is_url;
        strncpy(app->current_file, path, MAX_PATH - 1);
        app->current_file[MAX_PATH - 1] = '\0';
        app->scroll_y = 0;
        rerender(app);
    }
}

int history_can_back(App* app) {
    return app->history_pos > 0;
}

int history_can_forward(App* app) {
    return app->history_pos < app->history_count - 1;
}

static SDL_Rect back_btn = {5, 5, 30, 20};
static SDL_Rect forward_btn = {40, 5, 30, 20};

void draw_nav_bar(App* app) {
    SDL_SetRenderDrawColor(app->ren, 220, 220, 220, 255);
    SDL_Rect nav_bg = {0, 0, WINDOW_WIDTH, NAV_BAR_HEIGHT};
    SDL_RenderFillRect(app->ren, &nav_bg);
    
    SDL_SetRenderDrawColor(app->ren, 180, 180, 180, 255);
    SDL_RenderDrawRect(app->ren, &back_btn);
    SDL_RenderDrawRect(app->ren, &forward_btn);
    
    SDL_Color gray = {100, 100, 100, 255};
    SDL_Color blue = {0, 0, 255, 255};
    
    SDL_Surface* back_surf = TTF_RenderUTF8_Blended(app->font, "←", gray);
    SDL_Texture* back_tex = SDL_CreateTextureFromSurface(app->ren, back_surf);
    SDL_Rect back_dst = {back_btn.x + 7, back_btn.y + 2, back_surf->w, back_surf->h};
    SDL_RenderCopy(app->ren, back_tex, NULL, &back_dst);
    SDL_FreeSurface(back_surf);
    SDL_DestroyTexture(back_tex);
    
    SDL_Surface* fwd_surf = TTF_RenderUTF8_Blended(app->font, "→", gray);
    SDL_Texture* fwd_tex = SDL_CreateTextureFromSurface(app->ren, fwd_surf);
    SDL_Rect fwd_dst = {forward_btn.x + 7, forward_btn.y + 2, fwd_surf->w, fwd_surf->h};
    SDL_RenderCopy(app->ren, fwd_tex, NULL, &fwd_dst);
    SDL_FreeSurface(fwd_surf);
    SDL_DestroyTexture(fwd_tex);
}

int is_nav_button_click(App* app, int x, int y) {
    if (x >= back_btn.x && x <= back_btn.x + back_btn.w &&
        y >= back_btn.y && y <= back_btn.y + back_btn.h) {
        return 1;
    }
    if (x >= forward_btn.x && x <= forward_btn.x + forward_btn.w &&
        y >= forward_btn.y && y <= forward_btn.y + forward_btn.h) {
        return 2;
    }
    return 0;
}
