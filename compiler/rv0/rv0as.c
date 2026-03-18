#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <ctype.h>
#include <elf.h>

#ifndef EM_RISCV
#define EM_RISCV 243
#endif

#define MAX_LINES 2000
#define MAX_LABELS 100
#define MAX_TEXT_SIZE 4096

// Tokenizer & structures
typedef struct {
    char name[64];
    uint32_t address;
} Label;

Label labels[MAX_LABELS];
int label_count = 0;

uint8_t text_section[MAX_TEXT_SIZE];
uint32_t text_size = 0;

// RISC-V Registers map
const char* reg_names[32] = {
    "zero", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
    "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
    "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
    "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

int get_reg(const char *name) {
    for (int i = 0; i < 32; i++) {
        if (strcmp(name, reg_names[i]) == 0) return i;
    }
    return 0; // fallback to zero
}

uint32_t resolve_label(const char *name) {
    for (int i = 0; i < label_count; i++) {
        if (strcmp(labels[i].name, name) == 0) return labels[i].address;
    }
    return 0;
}

// RISC-V Instruction Encoders
uint32_t enc_R(int op, int f3, int f7, int rd, int rs1, int rs2) {
    return (f7 << 25) | (rs2 << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | op;
}
uint32_t enc_I(int op, int f3, int rd, int rs1, int imm) {
    return ((imm & 0xFFF) << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | op;
}
uint32_t enc_S(int op, int f3, int rs1, int rs2, int imm) {
    return (((imm >> 5) & 0x7F) << 25) | (rs2 << 20) | (rs1 << 15) | (f3 << 12) | ((imm & 0x1F) << 7) | op;
}
uint32_t enc_B(int op, int f3, int rs1, int rs2, int imm) {
    return (((imm >> 12) & 1) << 31) | (((imm >> 5) & 0x3F) << 25) | (rs2 << 20) | (rs1 << 15) | (f3 << 12) | (((imm >> 1) & 0xF) << 8) | (((imm >> 11) & 1) << 7) | op;
}
uint32_t enc_J(int op, int rd, int imm) {
    return (((imm >> 20) & 1) << 31) | (((imm >> 1) & 0x3FF) << 21) | (((imm >> 11) & 1) << 20) | (((imm >> 12) & 0xFF) << 12) | (rd << 7) | op;
}
uint32_t enc_U(int op, int rd, int imm) {
    return ((imm & 0xFFFFF) << 12) | (rd << 7) | op;
}

// Helper to strip commas and whitespace
void clean_operand(char *op) {
    char *p = op;
    while (*p) {
        if (*p == ',' || *p == '\n' || *p == '\r') *p = '\0';
        p++;
    }
}

// Two-pass assemble function
void assemble(char lines[][256], int line_count) {
    // Pass 1: Compute addresses for labels
    uint32_t pc = 0;
    for (int i = 0; i < line_count; i++) {
        char *line = lines[i];
        if (strchr(line, ':')) {
            char name[64];
            sscanf(line, "%[^:]", name);
            strcpy(labels[label_count].name, name);
            labels[label_count].address = pc;
            label_count++;
            continue;
        }
        if (line[0] == '.' || strlen(line) < 2) continue; // Skip directives
        
        char mnemonic[32];
        sscanf(line, "%s", mnemonic);
        if (strcmp(mnemonic, "call") == 0) pc += 8; // auipc + jalr
        else if (strcmp(mnemonic, "li") == 0) pc += 4; // Simplified li (1 inst)
        else if (strcmp(mnemonic, "mv") == 0 || strcmp(mnemonic, "ret") == 0) pc += 4;
        else pc += 4;
    }

    // Pass 2: Emit Machine Code
    pc = 0;
    for (int i = 0; i < line_count; i++) {
        char *line = lines[i];
        if (strchr(line, ':') || line[0] == '.' || strlen(line) < 2) continue;
        
        char mnem[32] = {0}, op1[32] = {0}, op2[32] = {0}, op3[32] = {0};
        sscanf(line, "%s %s %s %s", mnem, op1, op2, op3);
        clean_operand(op1); clean_operand(op2); clean_operand(op3);
        
        uint32_t inst = 0;

        // Parse format like offset(reg) => e.g., 40(sp)
        int mem_imm = 0;
        char mem_reg[32] = {0};
        if (strchr(op2, '(')) {
            sscanf(op2, "%d(%[^)])", &mem_imm, mem_reg);
            strcpy(op2, mem_reg);
        }

        if (strcmp(mnem, "addi") == 0) inst = enc_I(0x13, 0, get_reg(op1), get_reg(op2), atoi(op3));
        else if (strcmp(mnem, "addiw") == 0) inst = enc_I(0x1b, 0, get_reg(op1), get_reg(op2), atoi(op3));
        else if (strcmp(mnem, "slli") == 0) inst = enc_I(0x13, 1, get_reg(op1), get_reg(op2), atoi(op3));  // slli
        else if (strcmp(mnem, "srli") == 0) inst = enc_I(0x13, 5, get_reg(op1), get_reg(op2), atoi(op3));  // srli
        else if (strcmp(mnem, "srai") == 0) inst = enc_I(0x13, 5, get_reg(op1), get_reg(op2), atoi(op3) | 0x1000);  // srai
        else if (strcmp(mnem, "slliw") == 0) inst = enc_I(0x1b, 1, get_reg(op1), get_reg(op2), atoi(op3));  // slliw
        else if (strcmp(mnem, "srliw") == 0) inst = enc_I(0x1b, 5, get_reg(op1), get_reg(op2), atoi(op3));  // srliw
        else if (strcmp(mnem, "sraiw") == 0) inst = enc_I(0x1b, 5, get_reg(op1), get_reg(op2), atoi(op3) | 0x1000);  // sraiw
        else if (strcmp(mnem, "lw") == 0) inst = enc_I(0x03, 2, get_reg(op1), get_reg(op2), mem_imm);
        else if (strcmp(mnem, "ld") == 0) inst = enc_I(0x03, 3, get_reg(op1), get_reg(op2), mem_imm);
        else if (strcmp(mnem, "sw") == 0) inst = enc_S(0x23, 2, get_reg(op2), get_reg(op1), mem_imm);
        else if (strcmp(mnem, "sd") == 0) inst = enc_S(0x23, 3, get_reg(op2), get_reg(op1), mem_imm);
        else if (strcmp(mnem, "add") == 0) inst = enc_R(0x33, 0, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "sub") == 0) inst = enc_R(0x33, 0, 0x20, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "mul") == 0) inst = enc_R(0x33, 0, 1, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "sll") == 0) inst = enc_R(0x33, 1, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "srl") == 0) inst = enc_R(0x33, 5, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "sra") == 0) inst = enc_R(0x33, 5, 0x20, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "addw") == 0) inst = enc_R(0x3b, 0, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "subw") == 0) inst = enc_R(0x3b, 0, 0x20, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "sllw") == 0) inst = enc_R(0x3b, 1, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "srlw") == 0) inst = enc_R(0x3b, 5, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "sraw") == 0) inst = enc_R(0x3b, 5, 0x20, get_reg(op1), get_reg(op2), get_reg(op3));
        
        // RV64I 乘法指令
        else if (strcmp(mnem, "mul") == 0) inst = enc_R(0x33, 0, 1, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "mulh") == 0) inst = enc_R(0x33, 0, 2, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "mulhsu") == 0) inst = enc_R(0x33, 0, 3, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "mulhu") == 0) inst = enc_R(0x33, 0, 4, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "mulw") == 0) inst = enc_R(0x3b, 0, 1, get_reg(op1), get_reg(op2), get_reg(op3));
        
        // RV64I 除法指令
        else if (strcmp(mnem, "div") == 0) inst = enc_R(0x33, 0, 5, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "divu") == 0) inst = enc_R(0x33, 0, 6, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "divw") == 0) inst = enc_R(0x3b, 0, 5, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "divuw") == 0) inst = enc_R(0x3b, 0, 6, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "rem") == 0) inst = enc_R(0x33, 0, 7, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "remu") == 0) inst = enc_R(0x33, 0, 8, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "remw") == 0) inst = enc_R(0x3b, 0, 7, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "remuw") == 0) inst = enc_R(0x3b, 0, 8, get_reg(op1), get_reg(op2), get_reg(op3));
        
        // RV64I 邏輯指令
        else if (strcmp(mnem, "and") == 0) inst = enc_R(0x33, 7, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "or") == 0) inst = enc_R(0x33, 6, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "xor") == 0) inst = enc_R(0x33, 4, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        
        // RV64I 比較指令
        else if (strcmp(mnem, "slt") == 0) inst = enc_R(0x33, 2, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        else if (strcmp(mnem, "sltu") == 0) inst = enc_R(0x33, 3, 0, get_reg(op1), get_reg(op2), get_reg(op3));
        
        // RV64I I-type 立即數版本
        else if (strcmp(mnem, "andi") == 0) inst = enc_I(0x13, 7, get_reg(op1), get_reg(op2), atoi(op3));
        else if (strcmp(mnem, "ori") == 0) inst = enc_I(0x13, 6, get_reg(op1), get_reg(op2), atoi(op3));
        else if (strcmp(mnem, "xori") == 0) inst = enc_I(0x13, 4, get_reg(op1), get_reg(op2), atoi(op3));
        else if (strcmp(mnem, "slti") == 0) inst = enc_I(0x13, 2, get_reg(op1), get_reg(op2), atoi(op3));
        else if (strcmp(mnem, "sltiu") == 0) inst = enc_I(0x13, 3, get_reg(op1), get_reg(op2), atoi(op3));
        
        // RV64I 載入指令 (lb, lbu, lh, lhu)
        else if (strcmp(mnem, "lb") == 0) inst = enc_I(0x03, 0, get_reg(op1), get_reg(op2), mem_imm);
        else if (strcmp(mnem, "lbu") == 0) inst = enc_I(0x03, 4, get_reg(op1), get_reg(op2), mem_imm);
        else if (strcmp(mnem, "lh") == 0) inst = enc_I(0x03, 1, get_reg(op1), get_reg(op2), mem_imm);
        else if (strcmp(mnem, "lhu") == 0) inst = enc_I(0x03, 5, get_reg(op1), get_reg(op2), mem_imm);
        
        // RV64I 儲存指令 (sb, sh)
        else if (strcmp(mnem, "sb") == 0) inst = enc_S(0x23, 0, get_reg(op2), get_reg(op1), mem_imm);
        else if (strcmp(mnem, "sh") == 0) inst = enc_S(0x23, 1, get_reg(op2), get_reg(op1), mem_imm);
        
        // LUI 和 AUIPC
        else if (strcmp(mnem, "lui") == 0) inst = enc_U(0x37, get_reg(op1), atoi(op2));
        
        // ... 前面的 addi, lw, sw, mul 等等保留 ...
        else if (strcmp(mnem, "beq") == 0) inst = enc_B(0x63, 0, get_reg(op1), get_reg(op2), resolve_label(op3) - pc);
        else if (strcmp(mnem, "bne") == 0) inst = enc_B(0x63, 1, get_reg(op1), get_reg(op2), resolve_label(op3) - pc);
        else if (strcmp(mnem, "blt") == 0) inst = enc_B(0x63, 4, get_reg(op1), get_reg(op2), resolve_label(op3) - pc);
        else if (strcmp(mnem, "bge") == 0) inst = enc_B(0x63, 5, get_reg(op1), get_reg(op2), resolve_label(op3) - pc);
        
        // 支援編譯器常用的 Pseudo-instructions (偽指令)
        else if (strcmp(mnem, "ble") == 0) inst = enc_B(0x63, 5, get_reg(op2), get_reg(op1), resolve_label(op3) - pc); // ble 是顛倒的 bge
        else if (strcmp(mnem, "bgt") == 0) inst = enc_B(0x63, 4, get_reg(op2), get_reg(op1), resolve_label(op3) - pc); // bgt 是顛倒的 blt
        else if (strcmp(mnem, "beqz") == 0) inst = enc_B(0x63, 0, get_reg(op1), 0, resolve_label(op2) - pc);
        else if (strcmp(mnem, "bnez") == 0) inst = enc_B(0x63, 1, get_reg(op1), 0, resolve_label(op2) - pc);
        else if (strcmp(mnem, "sext.w")== 0) inst = enc_I(0x1B, 0, get_reg(op1), get_reg(op2), 0); // int 常見的 sign-extend
        // ... 下面保持原樣 ...
        else if (strcmp(mnem, "j") == 0) {
            int offset = resolve_label(op1) - pc;
            inst = enc_J(0x6f, 0, offset); // jal zero, offset
        }
        // Pseudo-instructions handling
        else if (strcmp(mnem, "li") == 0) inst = enc_I(0x13, 0, get_reg(op1), 0, atoi(op2)); // addi rd, zero, imm
        else if (strcmp(mnem, "mv") == 0) inst = enc_I(0x13, 0, get_reg(op1), get_reg(op2), 0); // addi rd, rs, 0
        else if (strcmp(mnem, "ret") == 0) inst = enc_I(0x67, 0, 0, get_reg("ra"), 0); // jalr zero, 0(ra)
        else if (strcmp(mnem, "call") == 0) {
            // call label -> auipc ra, hi20 ; jalr ra, lo12(ra)
            int offset = resolve_label(op1) - pc;
            int hi20 = (offset + 0x800) >> 12;
            int lo12 = offset - (hi20 << 12);
            uint32_t auipc = enc_U(0x17, get_reg("ra"), hi20);
            uint32_t jalr = enc_I(0x67, 0, get_reg("ra"), get_reg("ra"), lo12);
            memcpy(&text_section[pc], &auipc, 4);
            pc += 4;
            inst = jalr;
        }

        if (inst != 0) {
            memcpy(&text_section[pc], &inst, 4);
            pc += 4;
        }
    }
    text_size = pc;
}

// Function to write a basic ELF file containing our .text code
void write_elf(const char *filename) {
    FILE *f = fopen(filename, "wb");
    
    // Construct .strtab (String Table for Symbols)
    char strtab[4096];
    memset(strtab, 0, sizeof(strtab));
    int strtab_size = 1; // index 0 is always null byte
    
    // Construct .symtab (Symbol Table)
    Elf64_Sym syms[MAX_LABELS + 1];
    memset(syms, 0, sizeof(syms));
    int sym_count = 1; // index 0 is undefined symbol
    
    for (int i = 0; i < label_count; i++) {
        // Only emit symbols that don't start with '.' (ignore local compiler labels)
        if (labels[i].name[0] == '.') continue;
        
        int name_offset = strtab_size;
        strcpy(strtab + strtab_size, labels[i].name);
        strtab_size += strlen(labels[i].name) + 1;
        
        syms[sym_count].st_name = name_offset;
        syms[sym_count].st_info = ELF64_ST_INFO(STB_GLOBAL, STT_FUNC);
        syms[sym_count].st_shndx = 1; // .text section index
        syms[sym_count].st_value = labels[i].address;
        syms[sym_count].st_size = 0; // Don't care for now
        sym_count++;
    }
    
    int symtab_size = sym_count * sizeof(Elf64_Sym);
    
    Elf64_Ehdr ehdr;
    memset(&ehdr, 0, sizeof(ehdr));
    ehdr.e_ident[EI_MAG0] = ELFMAG0; ehdr.e_ident[EI_MAG1] = ELFMAG1;
    ehdr.e_ident[EI_MAG2] = ELFMAG2; ehdr.e_ident[EI_MAG3] = ELFMAG3;
    ehdr.e_ident[EI_CLASS] = ELFCLASS64;
    ehdr.e_ident[EI_DATA] = ELFDATA2LSB;
    ehdr.e_ident[EI_VERSION] = EV_CURRENT;
    ehdr.e_type = ET_REL;
    ehdr.e_machine = EM_RISCV;
    ehdr.e_version = EV_CURRENT;
    ehdr.e_ehsize = sizeof(Elf64_Ehdr);
    ehdr.e_shentsize = sizeof(Elf64_Shdr);
    ehdr.e_shnum = 5; // Null, .text, .shstrtab, .symtab, .strtab
    ehdr.e_shstrndx = 2;

    const char shstrtab[] = "\0.text\0.shstrtab\0.symtab\0.strtab\0";
    
    Elf64_Shdr shdrs[5];
    memset(shdrs, 0, sizeof(shdrs));
    
    // .text section
    shdrs[1].sh_name = 1; // ".text"
    shdrs[1].sh_type = SHT_PROGBITS;
    shdrs[1].sh_flags = SHF_ALLOC | SHF_EXECINSTR;
    shdrs[1].sh_offset = sizeof(Elf64_Ehdr);
    shdrs[1].sh_size = text_size;
    shdrs[1].sh_addralign = 4;
    
    // .shstrtab section
    shdrs[2].sh_name = 7; // ".shstrtab"
    shdrs[2].sh_type = SHT_STRTAB;
    shdrs[2].sh_offset = sizeof(Elf64_Ehdr) + text_size;
    shdrs[2].sh_size = sizeof(shstrtab);
    shdrs[2].sh_addralign = 1;

    // .symtab section
    shdrs[3].sh_name = 17; // ".symtab"
    shdrs[3].sh_type = SHT_SYMTAB;
    shdrs[3].sh_link = 4; // points to .strtab
    shdrs[3].sh_info = sym_count; // one greater than the symbol table index of the last local symbol
    shdrs[3].sh_entsize = sizeof(Elf64_Sym);
    shdrs[3].sh_offset = shdrs[2].sh_offset + shdrs[2].sh_size;
    shdrs[3].sh_size = symtab_size;
    shdrs[3].sh_addralign = 8;
    
    // .strtab section
    shdrs[4].sh_name = 25; // ".strtab"
    shdrs[4].sh_type = SHT_STRTAB;
    shdrs[4].sh_offset = shdrs[3].sh_offset + shdrs[3].sh_size;
    shdrs[4].sh_size = strtab_size;
    shdrs[4].sh_addralign = 1;

    ehdr.e_shoff = shdrs[4].sh_offset + shdrs[4].sh_size;

    fwrite(&ehdr, 1, sizeof(ehdr), f);
    fwrite(text_section, 1, text_size, f);
    fwrite(shstrtab, 1, sizeof(shstrtab), f);
    fwrite(syms, 1, symtab_size, f);
    fwrite(strtab, 1, strtab_size, f);
    fwrite(shdrs, 1, sizeof(shdrs), f);
    
    fclose(f);
}

int main(int argc, char **argv) {
    if (argc == 4 && strcmp(argv[2], "-o")==1) {
        printf("Usage: %s <input.s> -o <output.o>\n", argv[0]);
        return 1;
    }

    FILE *f = fopen(argv[1], "r");
    if (!f) return 1;

    static char lines[MAX_LINES][256];
    int line_count = 0;

    char buffer[256];
    while (fgets(buffer, sizeof(buffer), f)) {
        // Strip comments and leading spaces
        char *p = buffer;
        while (isspace(*p)) p++;
        char *hash = strchr(p, '#');
        if (hash) *hash = '\0';
        if (strlen(p) > 0) {
            strcpy(lines[line_count++], p);
        }
    }
    fclose(f);

    assemble(lines, line_count);
    write_elf(argv[3]);
    printf("Successfully assembled %s into %s\n", argv[1], argv[3]);

    return 0;
}