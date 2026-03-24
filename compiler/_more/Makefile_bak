# ==========================================
# 1. 定義變數與編譯器路徑
# ==========================================
# RISC-V 交叉編譯器設定
LLVM_BIN   = /opt/homebrew/opt/llvm/bin
RV_CC      = $(LLVM_BIN)/clang
RV_OBJDUMP = $(LLVM_BIN)/llvm-objdump
RV_CFLAGS  = --target=riscv64 -march=rv64g -mabi=lp64d -g

# 本機端 (Host) 工具的編譯器設定
HOST_CC    = clang
HOST_CFLAGS= -O2 -Wall

C0C = ./c0/c0c/c0c
LL0C = ./ll0/ll0c/ll0c
PY0C = ./py0/py0c/py0c
QD0C = ./qd0/qd0c/qd0c
RV0OBJDUMP = ./rv0/rv0objdump
RV0AS = ./rv0/rv0as
RV0VM = ./rv0/rv0vm

# ==========================================
# 2. 主要目標 (Targets)
# ==========================================

# 預設行為：編譯所有東西
all: 

fact_rv:
#	$(RV_CC) $(RV_CFLAGS) -S _data/fact.c -o _data/fact.s
#	$(RV_CC) $(RV_CFLAGS) -c _data/fact.s -o _data/fact.o
#	$(RV_OBJDUMP) -h -d _data/fact.o
#	$(C0C) _data/fact.c -o _data/fact0.ll # 是 c0c 和 ll0c 的問題
#	$(LL0C) _data/fact0.ll -o _data/fact0.s 
	$(RV_CC) $(RV_CFLAGS) -S _data/fact.c -o _data/fact1.s
	$(RV0AS) _data/fact1.s -o _data/fact0.o
#	$(RV0AS) _data/fact.s -o _data/fact0.o
	$(RV0OBJDUMP) _data/fact0.o
#	$(RV_OBJDUMP) -h -d _data/fact0.o
	$(RV0VM) _data/fact0.o

fact:
#	$(RV_CC) $(RV_CFLAGS) -S _data/fact.c -o _data/fact.s
#	$(RV_CC) $(RV_CFLAGS) -c _data/fact.s -o _data/fact.o
#	$(RV_OBJDUMP) -h -d _data/fact.o
	$(C0C) _data/fact.c -o _data/fact.ll # 是 c0c 和 ll0c 的問題
	$(HOST_CC) _data/fact.ll -o _data/fact.o
#	$(LL0C) _data/fact0.ll -o _data/fact0.s 
#	$(RV_CC) $(RV_CFLAGS) -S _data/fact.c -o _data/fact1.s
#	$(RV0AS) _data/fact1.s -o _data/fact0.o
#	$(RV0AS) _data/fact.s -o _data/fact0.o
#	$(RV0OBJDUMP) _data/fact0.o
#	$(RV_OBJDUMP) -h -d _data/fact0.o
#	$(RV0VM) _data/fact0.o

# ==========================================
# 5. 清理檔案 (Clean)
# ==========================================
clean:
	rm -f _data/*.o 