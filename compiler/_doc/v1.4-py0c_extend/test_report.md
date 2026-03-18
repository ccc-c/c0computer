# py0c 擴充功能測試報告

## 擴充概述

本次擴充為 py0c 編譯器新增了以下基礎功能：
1. 比較運算子：`<`, `>`, `<=`, `>=`, `!=`
2. 布林運算子：`and`, `not`, `or`
3. while 迴圈
4. for 迴圈（`for i in range(n)` 語法）

---

## 修改的檔案

### 1. py0c/py0c.c
- **Lexer 擴充** (行 62-75)：新增 `!=`, `<`, `>`, `<=`, `>=` 運算子的詞法分析
- **Parser 擴充** (行 141-174)：更新 `parse_cmp()` 函數以處理所有比較運算子
- **布林運算** (行 176-208)：新增 `parse_or()`, `parse_and()`, `parse_not()` 函數
- **While 迴圈** (行 293-314)：新增 while 迴圈解析與 IR 生成
- **For 迴圈** (行 315-356)：新增 for...in range() 迴圈解析與 IR 生成

### 2. qd0/qd0c/qd0lib.c
- 新增 `qd_bitand()` 函數 (行 161-166)：處理 `and` 運算
- 新增 `qd_bitor()` 函數 (行 168-173)：處理 `or` 運算

### 3. qd0/qd0c/qd0lib.h
- 新增 `qd_bitand()` 與 `qd_bitor()` 函數宣告 (行 73-74)

### 4. qd0/qd0c/qd0c.c
- 新增 BITAND/BITOR IR 指令處理 (行 440-441)
- 新增 LLVM IR 宣告 (行 759-760)

---

## 測試結果

### 測試 1：比較運算子
**檔案**：test_compare.py
```python
x = 10
y = 5
if x > y: print("x > y")
if x >= 10: print("x >= 10")
if y <= 5: print("y <= 5")
if x != y: print("x != y")
if x == 10: print("x == 10")
```
**結果**：✓ PASS

### 測試 2：布林運算子
**檔案**：test_bool.py
```python
x = 10; y = 5; z = 3
if x > y and y > z: print("and test pass")
if not (x < y): print("not test pass")
if x > y or y > x: print("or test pass")
a = 1; b = 0
if a and not b: print("boolean and not pass")
```
**結果**：✓ PASS

### 測試 3：While 迴圈
**檔案**：test_while3.py
```python
i = 0
while i < 3:
    i = i + 1
print(i)
```
**輸出**：3
**結果**：✓ PASS

### 測試 4：For 迴圈
**檔案**：test_for.py
```python
sum = 0
for i in range(5):
    sum = sum + i
print(sum)
```
**輸出**：10
**結果**：✓ PASS

### 測試 5：綜合測試
**檔案**：test_comprehensive.py
```python
sum = 0
for i in range(10):
    if i > 5:
        sum = sum + i
    else:
        sum = sum + 1
print(sum)
```
**輸出**：36
**結果**：✓ PASS

---

## 已知限制

1. **多行區塊限制**：由於 py0c 採用簡單的行式解析，不支援 Python 的縮排語意。每個控制結構（if/while/for）只能包含**單一語句**作為主體。

2. **函數參數**：目前函數參數的實現較簡單，遞迴函數可能無法正確存取參數。

3. **運算子優先序**：
   - `not` > `and` > `or`
   - 比較運算 > `and` > `or`

---

## 使用方式

```bash
# 編譯 py0c
cd py0/py0c
gcc -o py0c py0c.c

# 編譯 Python 檔案
./py0c input.py -o output.qd

# 執行（需要 qd0c）
cd ../../qd0/qd0c
./qd0c ../../py0/py0c/output.qd
clang output.ll qd0lib.c -o program -lm
./program
```

---

## 日期
2026-03-18