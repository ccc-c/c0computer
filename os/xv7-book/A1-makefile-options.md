# A1. Makefile 編譯選項

## A1.1 常用選項

```bash
# 基礎編譯
make TOOLPREFIX=riscv64-linux-gnu-

# 平行編譯 (使用 4 核心)
make -j4 TOOLPREFIX=riscv64-linux-gnu-

# 清理後編譯
make clean && make TOOLPREFIX=riscv64-linux-gnu-

# 只編譯核心
make kernel TOOLPREFIX=riscv64-linux-gnu-

# 只編譯檔案系統
make fs.img TOOLPREFIX=riscv64-linux-gnu-

# 顯示詳細編譯過程
make V=1 TOOLPREFIX=riscv64-linux-gnu-
```

## A1.2 TOOLPREFIX 選項

| 工具鏈 | TOOLPREFIX |
|--------|------------|
| riscv64-linux-gnu | riscv64-linux-gnu- |
| riscv64-unknown-elf | riscv64-unknown-elf- |
| riscv64-elf | riscv64-elf- |

## A1.3 QEMU 選項

```bash
# 進入 QEMU
make qemu

# 進入 GDB 模式
make qemu-gdb

# 指定核心數
qemu-system-riscv64 -smp 3
```