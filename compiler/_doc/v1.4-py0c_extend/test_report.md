# C0C 巨集展開功能 (v1.3)

## 任務完成摘要

成功為 c0c 編譯器加入了 C 語言風格的巨集 (#define) 展開功能。

# v1.3-c_macro 待辦事項

## 已完成
- [x] 建立 c0macro.h header 檔案
- [x] 建立 c0macro.c 實作檔案
- [x] 修改 main.c 支援 -E 參數
- [x] 修改 Makefile 加入 c0macro.c
- [x] 測試簡單巨集展開
- [x] 測試函數巨集展開
- [x] 更新文件

## 功能限制
- 不支援 #ifdef/#ifndef/#else/#endif
- 不支援 #include
- 不支援多行巨集
- 函數巨集參數替換較簡單


## 修改的檔案

### 1. c0macro.h
巨集處理器的 header 檔案，定義了以下 API:
- `macro_init()` - 初始化巨集資料結構
- `macro_free()` - 釋放巨集資料結構
- `macro_define(name, replacement)` - 定義巨集
- `macro_undef(name)` - 取消巨集定義
- `macro_defined(name)` - 檢查巨集是否已定義
- `macro_expand(input)` - 展開輸入字串中的巨集
- `macro_expand_file(filename)` - 展開檔案中的巨集

### 2. c0macro.c
巨集處理器的實作，支援以下功能:
- 簡單巨集: `#define NAME value`
- 函數巨集: `#define NAME(a, b) expression`
- #undef 取消巨集定義

### 3. main.c
修改以支援 `-E` 參數:
- `c0c input.c -E` - 只展開巨集，不編譯
- `c0c input.c -o output.ll` - 正常編譯（自動展開巨集）

### 4. Makefile
新增 c0macro.c 到編譯目標

## 支援的功能

### 簡單巨集
```c
#define MAX 100
#define MIN 10
#define STR "Hello World"
#define CHAR 'A'
```

### 函數巨集
```c
#define SUM(a, b) ((a) + (b))
#define MULTI(a, b) ((a) * (b))
```

### 使用方式

```bash
# 只展開巨集
./c0c test.c -E -o test.i

# 正常編譯（會自動展開巨集）
./c0c test.c -o test.ll
```

## 測試範例

### 輸入 (test_macro2.c)
```c
#define MAX 100
#define MIN 10
#define SUM(a, b) ((a) + (b))
#define MULTI(a, b) ((a) * (b))
#define STR "Hello World"
#define CHAR 'A'

int main() {
    int x = MAX;
    int y = MIN;
    int z = SUM(x, y);
    int m = MULTI(x, y);
    char *s = STR;
    char c = CHAR;
    
    return z;
}
```

### 輸出 (巨集展開後)
```
int main() {
int x =  100;
int y =  10;
int z = ((x) + ( y));
int m = ((x) * ( y));
char *s =  "Hello World";
char c =  'A';
 
return z;
}
```

## 技術細節

### 巨集展開流程
1. 讀取輸入檔案，按行處理
2. 遇到 `#define` 時解析巨集名稱和替代文字
3. 對於函數巨集，將參數名稱替換為 `$1`, `$2` 等
4. 展開時將 `$1`, `$2` 替換為實際傳入的參數
5. 重複展開直到沒有新的巨集可展開

### 限制
- 不支援 #ifdef, #ifndef, #else, #endif
- 不支援 #include
- 不支援多行巨集
- 函數巨集的參數替換較簡單

## 測試結果

所有原有測試通過:
- char_literal: ✓
- factorial: ✓
- loop_break: ✓
- optest: ✓
- ptr_test: ✓
- char_test: ✓
- loop: ✓
- ptr_arith: ✓
- ptr_diff: ✓
- sizeof_test: ✓
- array_init: ✓
- array_init2: ✓
- scope: ✓

巨集展開功能測試:
- 簡單巨集 (#define MAX 100): ✓
- 函數巨集 (#define SUM(a,b) ((a)+(b))): ✓
- 字串巨集: ✓
- 字元巨集: ✓


