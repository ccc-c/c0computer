#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#include <time.h>
// 新增：包含errno和EEXIST所需的头文件
#include <errno.h>

// 定义核心目录路径
#define GIT0_DIR ".git0"
#define OBJECTS_DIR ".git0/objects"
#define INDEX_FILE ".git0/index"
#define LOG_FILE ".git0/logs"

// 错误处理函数
void die(const char *msg) {
    perror(msg);
    exit(1);
}

// 创建目录（支持多级）
void create_dir(const char *path) {
    if (mkdir(path, 0755) == -1) {
        if (errno != EEXIST) die("mkdir failed");
    }
}

// 初始化仓库
void git0_init() {
    create_dir(GIT0_DIR);
    create_dir(OBJECTS_DIR);
    
    // 创建空的暂存区和日志文件
    FILE *index = fopen(INDEX_FILE, "w");
    if (!index) die("fopen index failed");
    fclose(index);

    FILE *log = fopen(LOG_FILE, "w");
    if (!log) die("fopen log failed");
    fclose(log);

    printf("Initialized empty git0 repository\n");
}

// 计算简单的文件内容哈希（简化版 SHA-1）
void simple_hash(const char *content, char *hash) {
    unsigned int sum = 0;
    for (int i = 0; content[i]; i++) {
        sum = sum * 31 + content[i];
    }
    sprintf(hash, "%08x", sum); // 8位十六进制哈希
}

// 读取文件内容
char* read_file(const char *filename, long *size) {
    FILE *f = fopen(filename, "r");
    if (!f) die("fopen read failed");

    fseek(f, 0, SEEK_END);
    *size = ftell(f);
    fseek(f, 0, SEEK_SET);

    char *content = malloc(*size + 1);
    if (!content) die("malloc failed");
    
    fread(content, 1, *size, f);
    content[*size] = '\0'; // 确保字符串结束
    fclose(f);
    return content;
}

// 暂存文件（add）
void git0_add(const char *filename) {
    // 检查文件是否存在
    if (access(filename, F_OK) == -1) {
        fprintf(stderr, "Error: %s does not exist\n", filename);
        exit(1);
    }

    // 读取文件内容
    long size;
    char *content = read_file(filename, &size);

    // 计算哈希值
    char hash[9];
    simple_hash(content, hash);

    // 将文件内容保存到 objects 目录
    char obj_path[256];
    snprintf(obj_path, sizeof(obj_path), "%s/%s", OBJECTS_DIR, hash);
    FILE *obj = fopen(obj_path, "w");
    if (!obj) die("fopen object failed");
    fwrite(content, 1, size, obj);
    fclose(obj);

    // 更新暂存区（index）
    FILE *index = fopen(INDEX_FILE, "a");
    if (!index) die("fopen index failed");
    fprintf(index, "%s %s\n", filename, hash);
    fclose(index);

    printf("Added %s to staging area (hash: %s)\n", filename, hash);
    free(content);
}

// 提交版本（commit）
void git0_commit(const char *msg) {
    // 检查暂存区是否为空
    FILE *index = fopen(INDEX_FILE, "r");
    if (!index) die("fopen index failed");
    
    fseek(index, 0, SEEK_END);
    if (ftell(index) == 0) {
        fprintf(stderr, "Error: Staging area is empty, nothing to commit\n");
        fclose(index);
        exit(1);
    }
    fseek(index, 0, SEEK_SET);

    // 生成提交ID（基于时间戳）
    time_t now = time(NULL);
    char commit_id[32];
    sprintf(commit_id, "%ld", now);

    // 记录提交信息到日志
    FILE *log = fopen(LOG_FILE, "a");
    if (!log) die("fopen log failed");
    
    fprintf(log, "Commit: %s\n", commit_id);
    fprintf(log, "Date: %s", ctime(&now));
    fprintf(log, "Message: %s\n", msg);
    
    // 写入暂存区内容到日志
    char line[256];
    fprintf(log, "Files:\n");
    while (fgets(line, sizeof(line), index)) {
        fprintf(log, "  %s", line);
    }
    fprintf(log, "-------------------------\n");
    
    fclose(log);
    fclose(index);

    // 清空暂存区
    FILE *new_index = fopen(INDEX_FILE, "w");
    if (!new_index) die("fopen index failed");
    fclose(new_index);

    printf("Committed successfully (commit ID: %s)\n", commit_id);
}

// 查看提交日志（log）
void git0_log() {
    FILE *log = fopen(LOG_FILE, "r");
    if (!log) die("fopen log failed");

    char line[256];
    printf("\n===== Git0 Commit Log =====\n");
    while (fgets(line, sizeof(line), log)) {
        printf("%s", line);
    }
    printf("===========================\n\n");

    fclose(log);
}

// 显示帮助信息
void show_help() {
    printf("git0 - Simple Git implementation in C\n");
    printf("Usage: ./git0 <command> [args]\n");
    printf("Commands:\n");
    printf("  init        Initialize a new git0 repository\n");
    printf("  add <file>  Add a file to the staging area\n");
    printf("  commit <msg> Commit changes with a message\n");
    printf("  log         Show commit history\n");
    printf("  help        Show this help message\n");
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        show_help();
        exit(1);
    }

    // 解析命令
    if (strcmp(argv[1], "init") == 0) {
        git0_init();
    } else if (strcmp(argv[1], "add") == 0) {
        if (argc < 3) {
            fprintf(stderr, "Error: 'add' requires a filename argument\n");
            exit(1);
        }
        git0_add(argv[2]);
    } else if (strcmp(argv[1], "commit") == 0) {
        if (argc < 3) {
            fprintf(stderr, "Error: 'commit' requires a message argument\n");
            exit(1);
        }
        // 修复：原代码错误使用argv[3]，应该是argv[2]
        git0_commit(argv[2]);
    } else if (strcmp(argv[1], "log") == 0) {
        git0_log();
    } else if (strcmp(argv[1], "help") == 0) {
        show_help();
    } else {
        fprintf(stderr, "Error: Unknown command '%s'\n", argv[1]);
        show_help();
        exit(1);
    }

    return 0;
}