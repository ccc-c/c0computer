# vi0 移植到 os0 計劃

## 問題分析

vi0.c 使用以下 POSIX 標準庫，xv6-riscv (os0) 不支援：

| 原始標頭 | 功能說明 | os0 替代方案 |
|----------|----------|--------------|
| `termios.h` | 終端機 raw mode 控制 | 需實作 kernel 支援或模擬 |
| `unistd.h` | `read()`, `STDIN_FILENO` | os0 已有 `read(0, buf, n)` |
| `sys/select.h` | `select()` 非同步輸入檢查 | 需用輪詢或中斷方式 |

## 主要挑戰

### 1. Raw Mode 輸入
- xv6 主控台輸入是 **行緩衝** (line-buffered)，必須等到使用者按下 Enter 才會返回
- vi 需要 **字元模式** (character-at-a-time) 輸入
- **解決方案**：
  - 選項 A：在 kernel 加入 console 的 raw mode 支援（需要修改 console.c）
  - 選項 B：使用 polling 迴圈不斷嘗試讀取（效能較差）
  - 選項 C：實作簡化版 vi，僅支援 line-based 編輯

### 2. Terminal Control
- `tcgetattr()` / `tcsetattr()` 在 xv6 中不存在
- 需模擬或移除終端控制功能

### 3. 鍵盤偵測 (kbhit)
- `select()` 用於檢查 stdin 是否有資料
- xv6 無此機制，需改用其他方式

## 移植策略

### Phase 1: 基礎移植
1. 移除 `termios.h`, `unistd.h`, `sys/select.h`
2. 加入 os0 標頭：
   ```c
   #include "user/user.h"
   #include "kernel/types.h"
   ```
3. 定義常數：
   ```c
   #define STDIN_FILENO 0
   #define ICANON 0
   #define ECHO 0
   #define TCSAFLUSH 0
   ```
4. 將 `enable_raw_mode()` 和 `disable_raw_mode()` 改為空函式
5. 將 `kbhit()` 改為永遠回傳 1（假裝有鍵盤輸入可用）

### Phase 2: 輸入機制改造
**選項：實作簡易 raw mode**

在 `console.c` 中加入：
- 新增 system call 如 `enable_raw_mode()` / `disable_raw_mode()`
- 或修改 `consoleread()` 支援非行緩衝模式

**簡化方案：使用輪詢讀取**
```c
int readkey() {
    char c;
    // 在此模擬，每次 read() 嘗試讀取
    // 若無資料則返回 -1
    // 注意：xv6 預設會阻塞直到換行
}
```

### Phase 3: 功能調整
1. **ANSI escape sequences** - 需驗證 os0 是否支援
   - `\033[2J\033[H` - 清除螢幕
   - `\033[%d;%dH` - 移動游標
2. **檔案操作** - os0 支援 `open()`, `read()`, `write()`，可保持不變
3. **記憶體配置** - 使用 `malloc()` / `free()` (ulib.c 已實作)

## 實作建議

### 最小可行版本 (MVP)
1. 編譯 vi0.c 為 vi
2. 移除所有 terminal control 函式
3. 使用 `read(0, &c, 1)` 讀取（會 blocking 直到 Enter）
4. 這會使 vi 變成 "每按一次鍵要按 Enter" 的模式

### 完整版本
需要 kernel 修改以支援 raw mode input。

## 需修改的檔案

| 檔案 | 修改內容 |
|------|----------|
| `user/vi.c` | 主要程式碼移植 |
| `kernel/console.c` | 新增 raw mode 支援（可選） |
| `kernel/syscall.c` | 新增 system call（可選） |
| `user/user.h` | 宣告新 system call（可選） |

## 預期結果

- MVP 版本可編譯執行，但體驗類似 line-based editor
- 完整版本需要較多 kernel 修改，但可實現真正 vi 功能
