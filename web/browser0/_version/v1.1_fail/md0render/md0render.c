#include "md0render.h"
// 获取窗口缩放比例（macOS 兼容版：Retina屏返回2.0，普通屏返回1.0）
float get_window_scale(SDL_Window *win) {
    // 方案1：macOS 下强制适配 Retina 屏（最简单，99%场景适用）
    (void)win; // 消除未使用参数警告
    return 2.0f; // Retina屏固定2倍缩放，普通屏可改为1.0f

    // 方案2（可选）：通过DPI计算（兼容所有系统，无需高版本SDL）
    // int display_idx = SDL_GetWindowDisplayIndex(win);
    // float ddpi, hdpi, vdpi;
    // if (SDL_GetDisplayDPI(display_idx, &ddpi, &hdpi, &vdpi) == 0) {
    //     return (ddpi >= 192) ? 2.0f : 1.0f; // 192DPI以上为Retina屏
    // }
    // return 1.0f;
}

// 【修复】基于缩放比例计算逻辑边距（避免边距过大）
int get_margin_px(App *app) {
    int win_w, win_h;
    SDL_GetWindowSize(app->win, &win_w, &win_h); // 获取逻辑窗口宽度
    // 边距为逻辑宽度的3%，最小20（逻辑像素），再乘以缩放比例适配物理尺寸
    int margin = (int)(win_w * 0.03);
    margin = margin < 20 ? 20 : margin;
    return margin;
}

// 拼接路径
void join_path(char *out, const char *dir, const char *file) {
    if (!dir || !file) {
        strcpy(out, file ? file : dir);
        return;
    }
    strcpy(out, dir);
    if (out[strlen(out)-1] != '/') {
        strcat(out, "/");
    }
    char *p = (char*)file;
    while (*p == '.' && *(p+1) == '/') {
        p += 2;
        char *last = strrchr(out, '/');
        if (last && last != out) {
            *last = '\0';
        }
    }
    strcat(out, p);
}

// 【核心修复】文字渲染：按缩放比例放大文字，适配高DPI
void render_text(App *app, const char *text, int x, int y, SDL_Color color) {
    if (!app || !text || !app->font || !app->ren) return;

    int win_w, win_h;
    SDL_GetWindowSize(app->win, &win_w, &win_h); // 逻辑窗口尺寸
    int max_width = win_w - 2 * app->margin;     // 逻辑最大宽度

    char line[1024] = {0};
    int line_len = 0;
    const char *p = text;
    int current_y = y - app->scroll_y; // 逻辑Y坐标

    if (current_y > win_h) return;

    while (*p) {
        if (*p == '\n' || line_len >= 1023) {
            line[line_len] = '\0';
            if (line_len > 0) {
                // 1. 渲染文字表面（按逻辑尺寸）
                SDL_Surface *surf = TTF_RenderUTF8_Blended(app->font, line, color);
                if (surf) {
                    // 2. 创建纹理（SDL自动处理高DPI）
                    SDL_Texture *tex = SDL_CreateTextureFromSurface(app->ren, surf);
                    if (tex) {
                        // 3. 计算物理渲染坐标（逻辑坐标 × 缩放比例）
                        SDL_Rect dst = {
                            (int)(x * app->scale),          // X：逻辑→物理
                            (int)(current_y * app->scale),  // Y：逻辑→物理
                            (int)(surf->w * app->scale),    // 宽度：放大到物理尺寸
                            (int)(surf->h * app->scale)     // 高度：放大到物理尺寸
                        };
                        // 仅渲染屏幕内的内容
                        if (current_y + surf->h > 0) {
                            SDL_RenderCopy(app->ren, tex, NULL, &dst);
                        }
                        SDL_DestroyTexture(tex);
                    }
                    SDL_FreeSurface(surf);
                }
                // 逻辑行高（适配字体）
                current_y += TTF_FontLineSkip(app->font);
                app->content_total_height += TTF_FontLineSkip(app->font);
            }
            line_len = 0;
            if (*p == '\n') p++;
            continue;
        }

        // 检查单行宽度是否超出逻辑最大宽度
        line[line_len++] = *p++;
        line[line_len] = '\0';
        int text_w, text_h;
        TTF_SizeUTF8(app->font, line, &text_w, &text_h);
        if (text_w > max_width && line_len > 1) {
            p--;
            line_len--;
            line[line_len] = '\0';
            while (line_len > 0 && line[line_len-1] != ' ') {
                line_len--;
                p--;
            }
            if (line_len == 0) line_len = 1;
        }
    }

    // 渲染最后一行
    if (line_len > 0) {
        line[line_len] = '\0';
        SDL_Surface *surf = TTF_RenderUTF8_Blended(app->font, line, color);
        if (surf) {
            SDL_Texture *tex = SDL_CreateTextureFromSurface(app->ren, surf);
            if (tex) {
                SDL_Rect dst = {
                    (int)(x * app->scale),
                    (int)(current_y * app->scale),
                    (int)(surf->w * app->scale),
                    (int)(surf->h * app->scale)
                };
                if (current_y + surf->h > 0) {
                    SDL_RenderCopy(app->ren, tex, NULL, &dst);
                }
                SDL_DestroyTexture(tex);
            }
            SDL_FreeSurface(surf);
        }
        app->content_total_height += TTF_FontLineSkip(app->font);
    }
}

// 重新渲染界面
void rerender(App *app) {
    if (!app || !app->ren) return;

    // 清空渲染器（白色背景）
    SDL_SetRenderDrawColor(app->ren, 255, 255, 255, 255);
    SDL_RenderClear(app->ren);

    // 渲染MD内容（黑色文本）
    SDL_Color text_color = {0, 0, 0, 255};
    render_text(app, app->content, app->margin, app->margin, text_color);

    // 渲染链接下划线（蓝色）
    SDL_SetRenderDrawColor(app->ren, 0, 0, 255, 255);
    for (int i = 0; i < app->link_count; i++) {
        SDL_Rect r = app->links[i].rect;
        r.y -= app->scroll_y;
        // 下划线坐标转换为物理尺寸
        int x1 = (int)(r.x * app->scale);
        int y1 = (int)((r.y + r.h) * app->scale);
        int x2 = (int)((r.x + r.w) * app->scale);
        if (r.y + r.h > 0 && r.y < WINDOW_HEIGHT) {
            SDL_RenderDrawLine(app->ren, x1, y1, x2, y1);
        }
    }

    SDL_RenderPresent(app->ren);
}

// 释放链接列表
void free_links(App *app) {
    if (!app) return;
    app->link_count = 0;
    memset(app->links, 0, sizeof(app->links));
}

// 加载MD文件
void load_file(App *app, const char *path) {
    if (!app || !path) return;

    if (app->content) free(app->content);
    app->content = NULL;
    app->content_total_height = 0;
    app->scroll_y = 0;
    free_links(app);

    FILE *fp = fopen(path, "r");
    if (!fp) {
        printf("Failed to open file: %s (%s)\n", path, strerror(errno));
        app->content = strdup("File not found!");
        return;
    }

    // 获取文件目录
    char *last_slash = strrchr(path, '/');
    if (last_slash) {
        strncpy(app->current_dir, path, last_slash - path + 1);
        app->current_dir[last_slash - path + 1] = '\0';
    } else {
        strcpy(app->current_dir, ".");
    }

    // 读取文件内容
    fseek(fp, 0, SEEK_END);
    long file_size = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    if (file_size > MAX_CONTENT || file_size < 0) {
        printf("File too large or invalid: %s\n", path);
        fclose(fp);
        app->content = strdup("File too large!");
        return;
    }

    app->content = (char*)malloc(file_size + 1);
    if (!app->content) {
        printf("Malloc failed for file content\n");
        fclose(fp);
        app->content = strdup("Memory error!");
        return;
    }
    fread(app->content, 1, file_size, fp);
    app->content[file_size] = '\0';
    fclose(fp);

    // 解析链接（简化版）
    char *p = app->content;
    while (*p && app->link_count < MAX_LINKS) {
        if (*p == '[' && strstr(p, "](")) {
            char *text_start = p + 1;
            char *text_end = strchr(text_start, ']');
            char *url_start = strchr(text_end, '(') + 1;
            char *url_end = strchr(url_start, ')');
            if (text_end && url_start && url_end) {
                int text_len = text_end - text_start;
                int url_len = url_end - url_start;
                if (text_len > 0 && url_len > 0 && url_len < MAX_PATH) {
                    Link link = {0};
                    strncpy(link.url, url_start, url_len);
                    link.url[url_len] = '\0';

                    // 计算链接逻辑位置
                    int y = app->content_total_height + app->margin;
                    TTF_SizeUTF8(app->font, text_start, &link.rect.w, &link.rect.h);
                    link.rect.x = app->margin;
                    link.rect.y = y;

                    app->links[app->link_count++] = link;

                    memmove(text_start, url_start, url_len);
                    memmove(text_start + url_len, url_end + 1, strlen(url_end + 1) + 1);
                    p = text_start + url_len;
                    continue;
                }
            }
        }
        p++;
    }

    rerender(app);
}