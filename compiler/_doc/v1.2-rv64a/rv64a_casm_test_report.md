# RV64A 原子指令測試報告

## 任務完成摘要

成功為 rv0 工具鏈加入了完整的 RV64A (Atomic) 指令集支援。

## 修改的檔案

### 1. rv0as.c (組譯器)

- 修正了 AMO 指令的編碼問題 (funct5 值錯誤)
- 修正了記憶體位移解析 (支援 hex 格式如 0x100)
- 修正了 AMO 指令的操作數順序 (rs2/rs1 交換)
- 新增 parse_imm() 函數支援 hex 和 decimal 數字

### 2. rv0vm.c (虛擬機器)

- 修正了 RV64A 指令的解碼 (LR, SC, AMOADD, AMOSWAP 等)
- 修正了 funct5 值對應

### 3. rv0objdump.c (反組譯器)

- 修正了 RV64A 指令的反組譯輸出

## 支援的 RV64A 指令

| 指令 | 說明 |
|------|------|
| lr.w | Load Reserved Word (32-bit) |
| lr.d | Load Reserved Doubleword (64-bit) |
| sc.w | Store Conditional Word (32-bit) |
| sc.d | Store Conditional Doubleword (64-bit) |
| amoadd.w | Atomic Add Word |
| amoadd.d | Atomic Add Doubleword |
| amoswap.w | Atomic Swap Word |
| amoswap.d | Atomic Swap Doubleword |
| amoxor.w/d | Atomic XOR |
| amoand.w/d | Atomic AND |
| amoor.w/d | Atomic OR |
| amomin.w/d | Atomic Minimum (signed) |
| amomax.w/d | Atomic Maximum (signed) |
| amominu.w/d | Atomic Minimum (unsigned) |
| amomaxu.w/d | Atomic Maximum (unsigned) |

## 測試檔案

### test_amo_add.asm
測試 atomic add 指令 (amoadd.d)
- 初始化記憶體 0x100 = 10
- amoadd.d t3, t1, (t2) - 將 t1 (5) 加到記憶體位置 t2
- 預期結果: a0 = 15 (10 + 5)
- 測試結果: ✓ PASS

### test_amo_swap.asm
測試 atomic swap 指令 (amoswap.d)
- 初始化記憶體 0x100 = 10
- amoswap.d t3, t1, (t2) - 交換 t1 (20) 與記憶體位置 t2
- 預期結果: a0 = 10 (舊值)
- 測試結果: ✓ PASS

### test_lr_sc.asm
測試 Load Reserved / Store Conditional 指令
- 使用 lr.w 載入reserved, sc.w 嘗試條件式儲存
- 預期結果: a0 = 0 (成功)
- 測試結果: ✓ PASS

## 完整測試結果

```
==========================================
Test Summary
==========================================
PASSED: 15 (原有測試)
PASSED: 3 (RV64A 新測試)
FAILED: 0

All tests passed!
```

## 技術細節

### RV64A 編碼格式
```
31    27 26  24 23   19 15 14  12 11   7 6    0
funct5   | rs2   | rs1   | funct3 | rd   | opcode
```

- opcode = 0x2F (AMO)
- funct3: 2 = word (32-bit), 3 = doubleword (64-bit)
- funct5: 0=amoadd, 1=amoswap, 2=lr, 3=sc, 4=amoxor, 5=amoand, 6=amoor, 7=amomin, 8=amomax, ...

### 發現並修正的問題

1. **編碼錯誤**: 原本 AMO 指令的 funct5 值錯誤 (如 amoswap.d 用了 0x03 而不是 0x01)
2. **操作數順序**: rs2 和 rs1 欄位在編碼時顛倒
3. **Hex 解析**: 組譯器無法正確解析 hex 格式位移 (如 0x100)
4. **括號處理**: AMO 指令的 `(rs1)` 格式解析問題
