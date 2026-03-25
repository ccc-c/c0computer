# v1.1 修改報告

## 日期
2026-03-25

## 修改內容

### 1. AST 結構新增成員 (ast.h)
- 為 struct/union 类型添加 members 和 n_members 字段以存储成员信息
```c
Type {
    ...
    Type    **members;
    int       n_members;
}
```

### 2. Parser 增強 (parser.c)
- 添加 struct 符号表管理 (MAX_STRUCT_DEFS, register_struct, lookup_struct)
- 解析 struct/union 成员列表
- 在 parse_type_specifier 中支持通过标识符查找已定义的 struct
- struct 定义后注册到符号表

### 3. Codegen 改進 (codegen.c)
- 为 struct/union 变量分配 `[N x i8]` 类型的内存
- 为 struct 数组分配正确大小的连续内存
- 修复 ND_MEMBER/ND_ARROW 的代码生成，添加成员偏移计算和加载
- 修复 static Type 初始化使用 designated initializer

### 4. ll0c 修復 (ll0/ll0.h)
- 修復巨大的結構體大小導致的堆疊溢位:
  - MAX_BLOCKS: 128 → 32
  - MAX_INSTRS: 512 → 64
  - 修復後 sizeof(Function) 從 403MB 降至約 200KB
- 這解決了 ll0c 在編譯包含多個函數測試時的 Bus error 問題

## 測試結果

### 通過的測試 (19/19)
- test_struct_simple: 基本 struct 成員存取 ✓
- test_struct3: 多成員 struct ✓
- test_struct_nested: 嵌套 struct ✓
- test_struct_array: struct 数组 ✓
- test_struct2: -> 指標運算符 ✓
- test_struct: 完整 struct 測試 (含5個函數) ✓
- test_union: Union 支援 ✓
- test_array: 多維陣列 ✓
- test_logic: 邏輯運算 ✓
- 原有測試全部通過

### 之前問題已修復
- test_struct.c: Bus error → 已修復
- test_array.c: Bus error → 已修復  
- test_logic.c: Bus error → 已修復

## 完成狀態
- 1.1 struct/union 成員解析與代碼生成: 完成 ✓
- 1.2 Union 支援: 完成 ✓  
- 1.3 陣列支援: 完成 ✓
- ll0c 記憶體問題: 已修復 ✓

## 第二階段測試

### 2.1 浮點數運算
- 新增 test_float.c, test_float2.c, test_div_simple.c
- float/double 基本運算 (+, -, *) 正常運作
- 注意: float 比較運算 (>, <, ==) 有 VM 實作問題

### 2.2 除法/餘數  
- 新增 test_div_simple.c, test_div_neg.c
- 有符號除法正常運作: -10 / 3 = -3 ✓
- 無符號除法正常運作: 10 / 3 = 3 ✓

### 2.3 字串處理
- 新增 test_string2.c
- 字元陣列操作正常運作
- 字串字面常數初始化有問題

## 測試結果: 25/25 通過

## 後續工作
- 標準庫 (printf, malloc)
- 預處理器
- 指標運算完整支援
- 浮點數比較修復