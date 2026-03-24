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
static SDL_Rect edit_btn = {75, 5, 40, 20};
SDL_Rect done_btn = {WINDOW_WIDTH - 60, 5, 50, 20};

void draw_nav_bar(App* app) {
    SDL_SetRenderDrawColor(app->ren, 220, 220, 220, 255);
    SDL_Rect nav_bg = {0, 0, WINDOW_WIDTH, NAV_BAR_HEIGHT};
    SDL_RenderFillRect(app->ren, &nav_bg);
    
    SDL_SetRenderDrawColor(app->ren, 180, 180, 180, 255);
    SDL_RenderDrawRect(app->ren, &back_btn);
    SDL_RenderDrawRect(app->ren, &forward_btn);
    SDL_RenderDrawRect(app->ren, &edit_btn);
    
    SDL_Color gray = {100, 100, 100, 255};
    
    SDL_Surface* back_surf = TTF_RenderUTF8_Blended(app->font, "<", gray);
    SDL_Texture* back_tex = SDL_CreateTextureFromSurface(app->ren, back_surf);
    SDL_Rect back_dst = {back_btn.x + 8, back_btn.y + 2, back_surf->w, back_surf->h};
    SDL_RenderCopy(app->ren, back_tex, NULL, &back_dst);
    SDL_FreeSurface(back_surf);
    SDL_DestroyTexture(back_tex);
    
    SDL_Surface* fwd_surf = TTF_RenderUTF8_Blended(app->font, ">", gray);
    SDL_Texture* fwd_tex = SDL_CreateTextureFromSurface(app->ren, fwd_surf);
    SDL_Rect fwd_dst = {forward_btn.x + 8, forward_btn.y + 2, fwd_surf->w, fwd_surf->h};
    SDL_RenderCopy(app->ren, fwd_tex, NULL, &fwd_dst);
    SDL_FreeSurface(fwd_surf);
    SDL_DestroyTexture(fwd_tex);
    
    SDL_Surface* edit_surf = TTF_RenderUTF8_Blended(app->font, "Edit", gray);
    SDL_Texture* edit_tex = SDL_CreateTextureFromSurface(app->ren, edit_surf);
    SDL_Rect edit_dst = {edit_btn.x + 4, edit_btn.y + 2, edit_surf->w, edit_surf->h};
    SDL_RenderCopy(app->ren, edit_tex, NULL, &edit_dst);
    SDL_FreeSurface(edit_surf);
    SDL_DestroyTexture(edit_tex);
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

int is_edit_button_click(App* app, int x, int y) {
    if (x >= edit_btn.x && x <= edit_btn.x + edit_btn.w &&
        y >= edit_btn.y && y <= edit_btn.y + edit_btn.h) {
        return 1;
    }
    return 0;
}

int is_done_button_click(int x, int y) {
    if (x >= done_btn.x && x <= done_btn.x + done_btn.w &&
        y >= done_btn.y && y <= done_btn.y + done_btn.h) {
        return 1;
    }
    return 0;
}

void enter_edit_mode(App* app, int type) {
    app->edit_mode = 1;
    app->edit_type = type;
    app->edit_buf[0] = '\0';
    app->edit_cursor = 0;
    app->edit_scroll_y = 0;
    
    SDL_StartTextInput();
    
    if (type == 0 && app->content) {
        strncpy(app->edit_buf, app->content, MAX_EDIT_BUF - 1);
        app->edit_buf[MAX_EDIT_BUF - 1] = '\0';
        app->edit_cursor = strlen(app->edit_buf);
    }
}

void exit_edit_mode(App* app) {
    SDL_StopTextInput();
    app->edit_mode = 0;
}

void save_current_file(App* app) {
    if (app->is_url) return;
    
    FILE* f = fopen(app->current_file, "w");
    if (f) {
        fwrite(app->edit_buf, 1, strlen(app->edit_buf), f);
        fclose(f);
    }
}

void draw_edit_mode(App* app) {
    SDL_SetRenderDrawColor(app->ren, 255, 255, 255, 255);
    SDL_RenderClear(app->ren);
    
    int top_margin = NAV_BAR_HEIGHT + 10;
    int left_margin = app->margin;
    int right_margin = WINDOW_WIDTH - app->margin;
    int bottom_margin = WINDOW_HEIGHT - app->margin;
    
    SDL_SetRenderDrawColor(app->ren, 220, 220, 220, 255);
    SDL_Rect nav_bg = {0, 0, WINDOW_WIDTH, NAV_BAR_HEIGHT};
    SDL_RenderFillRect(app->ren, &nav_bg);
    
    done_btn = (SDL_Rect){WINDOW_WIDTH - 60, 5, 50, 20};
    SDL_SetRenderDrawColor(app->ren, 100, 200, 100, 255);
    SDL_RenderFillRect(app->ren, &done_btn);
    SDL_SetRenderDrawColor(app->ren, 50, 150, 50, 255);
    SDL_RenderDrawRect(app->ren, &done_btn);
    
    SDL_Color white = {255, 255, 255, 255};
    SDL_Surface* done_surf = TTF_RenderUTF8_Blended(app->font, "Done", white);
    SDL_Texture* done_tex = SDL_CreateTextureFromSurface(app->ren, done_surf);
    SDL_Rect done_dst = {done_btn.x + 8, done_btn.y + 2, done_surf->w, done_surf->h};
    SDL_RenderCopy(app->ren, done_tex, NULL, &done_dst);
    SDL_FreeSurface(done_surf);
    SDL_DestroyTexture(done_tex);
    
    SDL_SetRenderDrawColor(app->ren, 240, 240, 240, 255);
    SDL_Rect edit_area = {left_margin, top_margin, right_margin - left_margin, bottom_margin - top_margin};
    SDL_RenderFillRect(app->ren, &edit_area);
    
    SDL_SetRenderDrawColor(app->ren, 180, 180, 180, 255);
    SDL_RenderDrawRect(app->ren, &edit_area);
    
    if (app->edit_type == 1) {
        int url_y = top_margin + 5;
        SDL_Color blue = {0, 0, 200, 255};
        SDL_Surface* label_surf = TTF_RenderUTF8_Blended(app->font, "URL:", blue);
        SDL_Texture* label_tex = SDL_CreateTextureFromSurface(app->ren, label_surf);
        SDL_Rect label_dst = {left_margin + 5, url_y, label_surf->w, label_surf->h};
        SDL_RenderCopy(app->ren, label_tex, NULL, &label_dst);
        SDL_FreeSurface(label_surf);
        SDL_DestroyTexture(label_tex);
        
        int text_y = url_y + 25;
        SDL_SetRenderDrawColor(app->ren, 255, 255, 255, 255);
        SDL_Rect url_box = {left_margin, text_y, edit_area.w - 10, 25};
        SDL_RenderFillRect(app->ren, &url_box);
        SDL_SetRenderDrawColor(app->ren, 150, 150, 150, 255);
        SDL_RenderDrawRect(app->ren, &url_box);
        
        if (app->edit_buf[0] != '\0') {
            SDL_Surface* url_surf = TTF_RenderUTF8_Blended(app->font, app->edit_buf, (SDL_Color){0, 0, 0, 255});
            SDL_Texture* url_tex = SDL_CreateTextureFromSurface(app->ren, url_surf);
            SDL_Rect url_dst = {left_margin + 5, text_y + 3, url_surf->w, url_surf->h};
            if (url_dst.w > url_box.w - 10) url_dst.w = url_box.w - 10;
            SDL_RenderCopy(app->ren, url_tex, NULL, &url_dst);
            SDL_FreeSurface(url_surf);
            SDL_DestroyTexture(url_tex);
        }
        
        int cursor_x = left_margin + 5;
        if (app->edit_buf[0] != '\0') {
            int w, h;
            TTF_SizeUTF8(app->font, app->edit_buf, &w, &h);
            cursor_x += w;
        }
        SDL_SetRenderDrawColor(app->ren, 0, 0, 0, 255);
        SDL_RenderDrawLine(app->ren, cursor_x, text_y + 2, cursor_x, text_y + 23);
    }
    
    SDL_RenderPresent(app->ren);
}

void edit_mode_key(App* app, SDL_Event* e) {
    if (e->type == SDL_KEYDOWN) {
        if (e->key.keysym.sym == SDLK_ESCAPE) {
            exit_edit_mode(app);
            rerender(app);
        }
        else if (e->key.keysym.sym == SDLK_RETURN) {
            if (app->edit_type == 0) {
                save_current_file(app);
            } else {
                if (is_url(app->edit_buf)) {
                    load_url(app, app->edit_buf);
                    history_push(app, app->edit_buf, 1);
                }
            }
            exit_edit_mode(app);
            rerender(app);
        }
        else if (e->key.keysym.sym == SDLK_BACKSPACE) {
            if (app->edit_cursor > 0) {
                app->edit_cursor--;
                app->edit_buf[app->edit_cursor] = '\0';
            }
        }
        else if (e->key.keysym.sym == SDLK_v && (e->key.keysym.mod & KMOD_CTRL)) {
            char* clipboard = SDL_GetClipboardText();
            if (clipboard) {
                int len = strlen(clipboard);
                for (int i = 0; i < len && app->edit_cursor < MAX_EDIT_BUF - 1; i++) {
                    app->edit_buf[app->edit_cursor++] = clipboard[i];
                }
                app->edit_buf[app->edit_cursor] = '\0';
                SDL_free(clipboard);
            }
        }
        else {
            Uint32 unicode = e->key.keysym.sym;
            if (unicode >= 32 && unicode < 127) {
                if (app->edit_cursor < MAX_EDIT_BUF - 1) {
                    app->edit_buf[app->edit_cursor++] = (char)unicode;
                    app->edit_buf[app->edit_cursor] = '\0';
                }
            } else if (unicode >= 0x80 && unicode <= 0xFFFF) {
                if (app->edit_cursor < MAX_EDIT_BUF - 4) {
                    char utf8[5] = {0};
                    if (unicode <= 0x7FF) {
                        utf8[0] = 0xC0 | (unicode >> 6);
                        utf8[1] = 0x80 | (unicode & 0x3F);
                    } else if (unicode <= 0xFFFF) {
                        utf8[0] = 0xE0 | (unicode >> 12);
                        utf8[1] = 0x80 | ((unicode >> 6) & 0x3F);
                        utf8[2] = 0x80 | (unicode & 0x3F);
                    }
                    int u8len = strlen(utf8);
                    for (int i = 0; i < u8len; i++) {
                        app->edit_buf[app->edit_cursor++] = utf8[i];
                    }
                    app->edit_buf[app->edit_cursor] = '\0';
                }
            }
        }
    }
    else if (e->type == SDL_TEXTINPUT) {
        int len = strlen(e->text.text);
        for (int i = 0; i < len && app->edit_cursor < MAX_EDIT_BUF - 1; i++) {
            app->edit_buf[app->edit_cursor++] = e->text.text[i];
        }
        app->edit_buf[app->edit_cursor] = '\0';
    }
}
