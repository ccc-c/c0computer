#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <elf.h>

#ifndef EM_RISCV
#define EM_RISCV 243
#endif

#define RAM_SIZE (1024 * 1024) // 1MB 虛擬記憶體

uint8_t RAM[RAM_SIZE];
int64_t X[32] = {0}; // 32 個 64-bit 暫存器
uint64_t PC = 0;

const char* reg_names[32] = {
    "zero", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
    "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
    "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
    "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

void print_registers() {
    printf("\n--- Execution Halted. Register State ---\n");
    for (int i = 0; i < 32; i++) {
        printf("%-4s: %-10ld ", reg_names[i], X[i]);
        if ((i + 1) % 4 == 0) printf("\n");
    }
    printf("----------------------------------------\n");
}

int main(int argc, char **argv) {
    // 預設從 offset 108 (0x6C) 啟動，因為在你的 fact.s 中，
    // factorial 佔了前 108 bytes，接著才是 main 函數。
    uint64_t entry_point = 108; 

    int opt;
    while ((opt = getopt(argc, argv, "e:")) != -1) {
        if (opt == 'e') entry_point = strtol(optarg, NULL, 0);
    }

    if (optind >= argc) {
        fprintf(stderr, "Usage: %s [-e entry_pc] <file.o>\n", argv[0]);
        return 1;
    }

    int fd = open(argv[optind], O_RDONLY);
    if (fd < 0) { perror("open"); return 1; }

    struct stat st;
    fstat(fd, &st);
    uint8_t *map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    
    // 簡單的 ELF 讀取，找出 .text 區段並載入記憶體 0x0 處
    Elf64_Ehdr *ehdr = (Elf64_Ehdr*)map;
    Elf64_Shdr *shdrs = (Elf64_Shdr*)(map + ehdr->e_shoff);
    char *shstrtab = (char*)(map + shdrs[ehdr->e_shstrndx].sh_offset);
    
    for (int i = 0; i < ehdr->e_shnum; i++) {
        if (strcmp(shstrtab + shdrs[i].sh_name, ".text") == 0) {
            memcpy(RAM, map + shdrs[i].sh_offset, shdrs[i].sh_size);
            break;
        }
    }
    munmap(map, st.st_size);
    close(fd);

    // 初始化虛擬機狀態
    PC = entry_point;
    X[2] = RAM_SIZE;      // sp: 堆疊指標設在記憶體最底部 (1MB 處)
    X[1] = 0xFFFFFFFE;    // ra: 當 main 結束執行 ret (jalr ra) 時跳至此，作為結束標記

    printf("Starting VM at PC = 0x%lx\n", PC);

    int steps = 0;
    // 執行迴圈：直到跳回我們設定的 MAGIC EXIT ADDRESS (0xFFFFFFFE) 為止
    while (PC != 0xFFFFFFFE && steps < 100000) {
        X[0] = 0; // x0 永遠為 0

        if (PC >= RAM_SIZE || PC < 0) {
            printf("Exception: PC out of bounds (0x%lx)\n", PC);
            break;
        }

        uint32_t inst = *(uint32_t*)(RAM + PC);
        uint32_t opcode = inst & 0x7F;
        uint32_t rd     = (inst >> 7) & 0x1F;
        uint32_t f3     = (inst >> 12) & 0x7;
        uint32_t rs1    = (inst >> 15) & 0x1F;
        uint32_t rs2    = (inst >> 20) & 0x1F;
        uint32_t f7     = (inst >> 25) & 0x7F;
        
        // 提取各種格式的 Immediate (並做 32-bit Sign-Extension)
        int32_t imm_i = ((int32_t)inst) >> 20;
        
        uint64_t next_pc = PC + 4;
        
        switch (opcode) {
            case 0x13: // OP-IMM (addi)
                if (f3 == 0) X[rd] = X[rs1] + imm_i;
                break;
            case 0x1B: // OP-IMM-32 (addiw)
                if (f3 == 0) X[rd] = (int32_t)(X[rs1] + imm_i);
                break;
            case 0x33: // OP (add, mul)
                if (f3 == 0 && f7 == 0) X[rd] = X[rs1] + X[rs2];
                else if (f3 == 0 && f7 == 1) X[rd] = X[rs1] * X[rs2]; // mul
                break;
            case 0x67: // JALR (ret)
                PC = (X[rs1] + imm_i) & ~1ULL;
                X[rd] = next_pc;
                continue;
            case 0x6F: // JAL (j)
                {
                    int32_t imm_j = (((inst >> 31) & 1) << 20) | (((inst >> 12) & 0xFF) << 12) |
                                    (((inst >> 20) & 1) << 11) | (((inst >> 21) & 0x3FF) << 1);
                    imm_j = (imm_j << 11) >> 11;
                    PC = PC + imm_j;
                    X[rd] = next_pc;
                    continue;
                }
case 0x63: // BRANCH 完整版
                {
                    int32_t imm_b = (((inst >> 31) & 1) << 12) | (((inst >> 7) & 1) << 11) |
                                    (((inst >> 25) & 0x3F) << 5) | (((inst >> 8) & 0xF) << 1);
                    imm_b = (imm_b << 19) >> 19;
                    
                    int take = 0;
                    if (f3 == 0) take = (X[rs1] == X[rs2]);                       // beq
                    else if (f3 == 1) take = (X[rs1] != X[rs2]);                  // bne
                    else if (f3 == 4) take = ((int64_t)X[rs1] < (int64_t)X[rs2]); // blt
                    else if (f3 == 5) take = ((int64_t)X[rs1] >= (int64_t)X[rs2]);// bge
                    else if (f3 == 6) take = ((uint64_t)X[rs1] < (uint64_t)X[rs2]);// bltu
                    else if (f3 == 7) take = ((uint64_t)X[rs1] >= (uint64_t)X[rs2]);// bgeu
                    
                    if (take) {
                        PC = PC + imm_b;
                        continue;
                    }
                }
                break;
            case 0x17: // AUIPC (call)
                X[rd] = PC + (int32_t)(inst & 0xFFFFF000);
                break;
            case 0x03: // LOAD (lw, ld)
                {
                    uint64_t addr = X[rs1] + imm_i;
                    if (addr >= RAM_SIZE) { printf("Memory Read Fault\n"); goto end; }
                    if (f3 == 2) X[rd] = (int32_t)(*(uint32_t*)(RAM + addr)); // lw
                    else if (f3 == 3) X[rd] = *(int64_t*)(RAM + addr);        // ld
                }
                break;
            case 0x23: // STORE (sw, sd)
                {
                    int32_t imm_s = ((inst >> 25) << 5) | ((inst >> 7) & 0x1F);
                    imm_s = (imm_s << 20) >> 20;
                    uint64_t addr = X[rs1] + imm_s;
                    if (addr >= RAM_SIZE) { printf("Memory Write Fault\n"); goto end; }
                    if (f3 == 2) *(uint32_t*)(RAM + addr) = (uint32_t)X[rs2]; // sw
                    else if (f3 == 3) *(uint64_t*)(RAM + addr) = X[rs2];      // sd
                }
                break;
            default:
                printf("Fault: Unknown Opcode 0x%x at PC=0x%lx\n", opcode, PC);
                goto end;
        }
        PC = next_pc;
        steps++;
    }

end:
    print_registers();
    printf("Executed %d instructions.\n", steps);
    return 0;
}