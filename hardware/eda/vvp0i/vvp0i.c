#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_NETS 100
#define MAX_FUNCTORS 100
#define MAX_INSTS 100

// --- 資料結構定義 ---

typedef struct {
    char id[32];
    char name[32];
    int value; // 儲存 0 或 1 (為簡化不處理 x, z)
} Net;

typedef struct {
    char type[16];   // 邏輯閘種類 (如 "and")
    char out_id[32]; // 輸出端 Net ID
    char in1_id[32]; // 輸入端 1 Net ID
    char in2_id[32]; // 輸入端 2 Net ID
} Functor;

typedef enum { CMD_DELAY, CMD_VPI_CALL, CMD_END } CmdType;

typedef struct {
    CmdType type;
    int delay_val;
    char vpi_func[32]; // 如 "$display"
    char vpi_fmt[32];  // 如 "y=%b"
    char net_id[32];   // 目標 Net ID
} Instruction;

// --- 全域變數狀態 ---

Net nets[MAX_NETS];
int net_count = 0;

Functor functors[MAX_FUNCTORS];
int functor_count = 0;

Instruction thread_insts[MAX_INSTS];
int inst_count = 0;

int sim_time = 0;

// --- 輔助函式 ---

// 根據 ID 找尋 Net
Net* find_net(const char* id) {
    for(int i = 0; i < net_count; i++) {
        if(strcmp(nets[i].id, id) == 0) return &nets[i];
    }
    return NULL;
}

// 消除字串前後空白
void trim(char *str) {
    char *p = str;
    int l = strlen(p);
    while(l > 0 && isspace(p[l - 1])) p[--l] = 0;
    while(*p && isspace(*p)) ++p;
    memmove(str, p, l + 1);
}

// 評估所有邏輯閘
void evaluate_logic() {
    for(int i = 0; i < functor_count; i++) {
        if(strcmp(functors[i].type, "and") == 0) {
            Net* out = find_net(functors[i].out_id);
            Net* in1 = find_net(functors[i].in1_id);
            Net* in2 = find_net(functors[i].in2_id);
            if(out && in1 && in2) {
                out->value = in1->value & in2->value; // AND 運算
            }
        }
    }
}

// --- Parser 解析器 ---

void parse_file(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (!file) {
        printf("無法開啟檔案: %s\n", filename);
        exit(1);
    }

    char line[256];
    while (fgets(line, sizeof(line), file)) {
        trim(line);
        if (strlen(line) == 0 || line[0] == '#' || line[0] == ':') {
            continue; // 忽略註解與宣告模組
        }

        if (strstr(line, ".net")) {
            // 解析: L_00x123456 .net "a", 0 0;
            char id[32], name[32];
            if (sscanf(line, "%s .net \"%[^\"]\"", id, name) >= 2) {
                strcpy(nets[net_count].id, id);
                strcpy(nets[net_count].name, name);
                
                // 為了展示結果，我們預設將輸入 a 和 b 的初始值設為 1
                if (strcmp(name, "a") == 0 || strcmp(name, "b") == 0) {
                    nets[net_count].value = 1; 
                } else {
                    nets[net_count].value = 0;
                }
                net_count++;
            }
        }
        else if (strstr(line, ".fun")) {
            // 解析: g_00x987654 .fun "and", L_00x123458, L_00x123456, L_00x123457;
            char *type_start = strchr(line, '"');
            char *type_end = type_start ? strchr(type_start + 1, '"') : NULL;
            if (type_end) {
                *type_end = '\0';
                strcpy(functors[functor_count].type, type_start + 1);
                
                char *args = type_end + 1;
                char *tok = strtok(args, ",; \t");
                if (tok) strcpy(functors[functor_count].out_id, tok);
                tok = strtok(NULL, ",; \t");
                if (tok) strcpy(functors[functor_count].in1_id, tok);
                tok = strtok(NULL, ",; \t");
                if (tok) strcpy(functors[functor_count].in2_id, tok);
                
                functor_count++;
            }
        }
        else if (strncmp(line, "%delay", 6) == 0) {
            // 解析: %delay 10;
            int delay;
            sscanf(line, "%%delay %d;", &delay);
            thread_insts[inst_count].type = CMD_DELAY;
            thread_insts[inst_count].delay_val = delay;
            inst_count++;
        }
        else if (strncmp(line, "%vpi_call", 9) == 0) {
            // 解析: %vpi_call "$display", "y=%b", L_00x123458;
            char *func_start = strchr(line, '"');
            char *func_end = func_start ? strchr(func_start + 1, '"') : NULL;
            char *fmt_start = func_end ? strchr(func_end + 1, '"') : NULL;
            char *fmt_end = fmt_start ? strchr(fmt_start + 1, '"') : NULL;
            if (fmt_end) {
                *func_end = '\0';
                *fmt_end = '\0';
                strcpy(thread_insts[inst_count].vpi_func, func_start + 1);
                strcpy(thread_insts[inst_count].vpi_fmt, fmt_start + 1);
                
                char *args = fmt_end + 1;
                char *tok = strtok(args, ",; \t");
                if (tok) strcpy(thread_insts[inst_count].net_id, tok);
                
                thread_insts[inst_count].type = CMD_VPI_CALL;
                inst_count++;
            }
        }
        else if (strncmp(line, "%end", 4) == 0) {
            // 解析: %end;
            thread_insts[inst_count].type = CMD_END;
            inst_count++;
        }
    }
    fclose(file);
}

// --- 虛擬機核心 (Simulation Engine) ---

void run_simulation() {
    int pc = 0; // 程式計數器 (Program Counter)
    
    // 初始化，傳遞一開始的邏輯狀態 (Time 0 狀態計算)
    evaluate_logic();

    // 執行執行緒
    while (pc < inst_count) {
        Instruction* inst = &thread_insts[pc];

        if (inst->type == CMD_DELAY) {
            sim_time += inst->delay_val;
            // 當時間推進時，可以重新結算訊號是否有變動
            evaluate_logic(); 
            pc++;
        } 
        else if (inst->type == CMD_VPI_CALL) {
            if (strcmp(inst->vpi_func, "$display") == 0) {
                Net* n = find_net(inst->net_id);
                if (n) {
                    // 極簡版字串取代，將 %b 換成位元數值
                    char output[128];
                    char* pct = strstr(inst->vpi_fmt, "%b");
                    if (pct) {
                        int prefix_len = pct - inst->vpi_fmt;
                        strncpy(output, inst->vpi_fmt, prefix_len);
                        output[prefix_len] = '\0';
                        sprintf(output + prefix_len, "%d%s", n->value, pct + 2);
                        printf("%s\n", output); // 正式輸出 "$display" 的內容
                    } else {
                        printf("%s\n", inst->vpi_fmt);
                    }
                } else {
                    printf("Error: Net %s not found.\n", inst->net_id);
                }
            }
            pc++;
        } 
        else if (inst->type == CMD_END) {
            break; // 模擬結束
        }
    }
}

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("用法: %s <vvp file>\n", argv[0]);
        return 1;
    }

    // 1. 讀取並解析
    parse_file(argv[1]);

    // 2. 啟動虛擬機運行
    run_simulation();

    return 0;
}