# RV64I + RV64IMFD 指令集支援修改說明與測試報告

## 修改概述

本次修改完成了以下工作：

### 1. rv0as.c (RISC-V 組譯器) 修改

**新增支援 RV64I+M 完整指令：**
- 乘法: mul, mulh, mulhsu, mulhu, mulw
- 除法: div, divu, divw, divuw, rem, remu, remw, remuw
- 邏輯: and, or, xor
- 比較: slt, sltu
- 立即數: andi, ori, xori, slti, sltiu
- 載入/儲存: lb, lbu, lh, lhu, sb, sh

**新增支援 RV64F/RV64D 浮點數指令：**
- 載入/儲存: flw, fsw, fld, fsd
- 算術: fadd.s, fsub.s, fmul.s, fdiv.s, fsqrt.s, fadd.d, fsub.d, fmul.d, fdiv.d, fsqrt.d
- 比較: feq.s, flt.s, fle.s, feq.d, flt.d, fle.d
- 轉換: fcvt.w.s, fcvt.wu.s, fcvt.s.w, fcvt.s.wu, fcvt.w.d, fcvt.wu.d, fcvt.d.w, fcvt.d.wu, fcvt.d.s, fcvt.s.d
- 移動: fmv.w.x, fmv.x.w, fmv.d.x, fmv.x.d

**修正問題：**
- 修正 flw/fsw/fld/fsd 的暫存器順序編碼
- 修正 fcvt 轉換指令的參數順序和 rounding mode 支援

### 2. rv0vm.c (RISC-V 虛擬機) 修改

**新增功能：**
- 浮點暫存器陣列 F[32] (64-bit double)
- 浮點數載入/儲存指令
- 浮點數算術運算
- 浮點數比較指令
- 浮點數與整數轉換
- .rodata 區段載入支援 (位址 0x10000000)
- LUI 重新定位支援

### 3. rv0objdump.c (反組譯器) 修改

**新增解碼支援：**
- 所有 RV64F/RV64D 指令解碼
- 浮點暫存器名稱顯示

### 4. 測試檔案

在 `compiler/_data/` 目錄下新增測試檔案：

| 檔案 | 說明 | 預期結果 | 實際結果 | 狀態 |
|------|------|----------|----------|------|
| test.c | 基本算術 | 30 | 30 | ✓ |
| fact.c | 遞迴階乘 | 120 | 120 | ✓ |
| test_arith.c | 算術運算 | 72 | 72 | ✓ |
| test_compare.c | 比較運算 | 6 | 6 | ✓ |
| test_bitwise.c | 位元運算 | 60 | 60 | ✓ |
| test_loop.c | for 迴圈 | 55 | 55 | ✓ |
| test_pointer.c | 指標測試 | 42 | 42 | ✓ |
| test_while.c | while 迴圈 | 21 | 21 | ✓ |
| test_ifelse.c | if-else | 3 | 3 | ✓ |
| test_incdec.c | 遞增遞減 | 24 | 24 | ✓ |
| test_switch.c | switch | 3 | 3 | ✓ |
| test_long.c | long 類型 | 100 | 100 | ✓ |
| test_array2d.c | 二維陣列 | 7 | 7 | ✓ |
| test_ptr_arith.c | 指標運算 | 3 | 3 | ✓ |
| test_float_simple.c | 浮點數簡單測試 | 8 | 8 | ✓ |

### 浮點數測試（部分運作）
| 檔案 | 說明 | 狀態 |
|------|------|------|
| test_float_arith.c | 浮點算術 | 實作中 |
| test_double_arith.c | 雙精度運算 | 實作中 |
| test_float_compare.c | 浮點比較 | 實作中 |
| test_float_conv.c | 浮點轉換 | 實作中 |
| test_sqrt.c | 平方根 | 實作中 |
| test_float_array.c | 浮點陣列 | 實作中 |

## 執行方式

```bash
# 執行所有測試
./test.sh
```

## RV64I + M + F + D 指令集狀態

### 已完成的指令類別

| 類別 | 狀態 | 說明 |
|------|------|------|
| I-type 立即數 | ✓ | addi, andi, ori, xori, slti, sltiu, slli, srli, srai |
| I-type 載入 | ✓ | lb, lbu, lh, lhu, lw, ld |
| S-type 儲存 | ✓ | sb, sh, sw, sd |
| R-type 運算 | ✓ | add, sub, mul, div, rem, and, or, xor, slt, sltu, sll, srl, sra |
| R-type 32-bit | ✓ | addw, subw, mulw, divw, remw, sllw, srlw, sraw |
| U-type | ✓ | lui |
| B-type 分支 | ✓ | beq, bne, blt, bge, bltu, bgeu |
| J-type 跳躍 | ✓ | jal, jalr |
| F-type 浮點 | 部分 | 基本算術完成，轉換部分完成 |
| D-type 雙精度 | 部分 | 實作中 |

### 待完成

- 浮點數常數載入優化
- 更多浮點轉換指令
- 浮點數比較優化

## 總結

本次修改成功為 rv0 工具鏈新增了：
1. 完整的 RV64I + RV64IM 指令集支援
2. 基礎的 RV64F/RV64D 浮點數指令集支援
3. 更多的測試案例

測試結果：15 個基礎測試全部通過。

---

*報告日期: 2026-03-18*
