看到你把它推到這個成熟度真的很有成就感，這個小型教學編譯器已經很能打了。若還想做「重要但不爆量」的擴充，我會優先看這些方向：

?1. 多檔案與符號連結：支援多個 `.c` 編譯、簡單的全域符號表、與可重用的標準庫宣告。
+2. [x] 更完整的型別系統：`unsigned`、`short/long`、`const`，以及基本的型別提升規則。
+3. 結構體進階：struct 賦值、struct 參數與回傳、struct 陣列初始化與 `sizeof(struct)`.
?4. 指標更完整語義：指標與整數之間的顯式轉型、`void*`、函式指標（教學價值很高）。
_5. 陣列與字串更像 C：多維陣列、字串常量的 `const char*`、`"abc"[i]` 的型別推導。
+6. 診斷品質：錯誤訊息加上原始碼片段與游標標記，語意錯誤提示更精準。
-7. 最小優化與 IR 驗證：常數摺疊、死碼刪除、以及基本的 IR 形式檢查。

如果你想維持「教學型、可讀性高」的定位，我會建議先做 1、2、6，這三個最能提升完整度，又不會讓程式碼爆炸。

這個 c0c 專案的方向很有味道，我看完了核心原始碼後很想跟你一起把它一路擴大做扎實。以下是依目前實作脈絡（解析器與 codegen 分層清楚）整理的「下一步可擴充方向」，我會用優先順序與落點檔案來講，方便直接開工。

**近期高效擴充（不動架構，改動小、回饋大）**
1. 支援 `void` 參數列表與空參數差異  
目前 `int f(void)` 會失敗，因為參數解析只允許非 void。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/parser.c` 的 `parse_func()` 與參數解析。
2. 擴充賦值運算子與一元運算  
只支援 `=`、`+=`，可加 `-=` `*=` `/=` `%=`；一元 `+` 也可補上。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/parser.c`、`/Users/Shared/ccc/c0computer/compiler/c0c/codegen.c`。
3. 允許 `++/--` 用在更一般左值  
現在只允許變數本體（`AST_VAR`），可擴成 `*p`、`a[i]`、`s.x`。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/parser.c` 的 `parse_unary()`、`parse_postfix()`，以及 `/Users/Shared/ccc/c0computer/compiler/c0c/codegen.c` 的 `AST_INCDEC` 分支。
4. 更完整的字元/數字字面量  
目前不支援十六進位、八進位、`'\0'`、`\xNN` 等。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/lexer.c`。

**中期擴充（語言能力提升，開始動語義/IR）**
1. 全域變數與初始化  
目前 top-level 只有 function/typedef/struct，無法寫 `int g=3;`。  
落點：  
- `/Users/Shared/ccc/c0computer/compiler/c0c/parser.c` 的 `parse_program()` 新增全域宣告節點  
- `/Users/Shared/ccc/c0computer/compiler/c0c/codegen.c` 產生全域 `@g = global ...`  
2. 參數/呼叫型別與數量檢查  
現在沒有實際檢查參數數量、型別不匹配（除 `printf`）。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/parser.c` 的 `parse_primary()`（call）與 `func_add/func_find` 的資料結構。  
3. `sizeof` 對陣列的語義  
目前陣列一宣告就降成指標，`sizeof(a)` 變成指標大小。  
建議：在 AST 層保留「陣列型別」資訊或額外旗標，讓 `sizeof` 可依宣告決定。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/ast.h`、`/Users/Shared/ccc/c0computer/compiler/c0c/parser.c`、`/Users/Shared/ccc/c0computer/compiler/c0c/codegen.c`。

**進階擴充（接近 C ABI，後續工具鏈更順）**
1. `struct` 對齊與 padding  
目前 struct size/offset 是「緊密排列」，與 C ABI 不相容。  
建議：加上對齊規則（1/2/4/8），計算 padding，並修正 `sizeof(struct)` 與 field offset。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/parser.c` 的 `parse_struct_decl_or_def()`、`parse_typedef_stmt()`，以及 `/Users/Shared/ccc/c0computer/compiler/c0c/codegen.c` 的 `struct_size()` 和 field offset 用法。  
2. `struct` 傳遞/回傳與賦值  
目前完全不支援 `struct` 賦值、參數或回傳，會限制實作 libc 類功能。  
可用 LLVM IR `memcpy` 或以 `i8*` + size 模擬。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/parser.c`、`/Users/Shared/ccc/c0computer/compiler/c0c/codegen.c`。  
3. 更多運算子  
位元運算（`&|^~`）、shift、三元運算子 `?:`、逗號運算。  
落點：`/Users/Shared/ccc/c0computer/compiler/c0c/lexer.c`、`/Users/Shared/ccc/c0computer/compiler/c0c/parser.c`、`/Users/Shared/ccc/c0computer/compiler/c0c/codegen.c`。

**我建議的最小里程碑切法（每個可獨立驗證）**
1. 參數 `void` + `-=` `*=` `/=` + `++/--` 擴到一般左值  
2. 十六進位/八進位/`\xNN` 字面量  
3. 全域變數與初始化（含陣列）  
4. struct 對齊與 padding  
5. struct 傳遞/回傳與賦值  

如果你要，我可以直接幫你選定第一個里程碑，從 `parser.c`/`codegen.c` 實作起來。  
你想先做哪一個里程碑？如果你想快有成果，我會建議先做「參數 void + 擴充賦值/自增」這組。