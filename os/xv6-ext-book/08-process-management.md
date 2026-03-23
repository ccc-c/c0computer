# 8. 行程管理與系統呼叫

## 8.1 行程概念與理論

### 8.1.1 什麼是行程？

行程是作業系統進行資源分配和排程的基本單位。在 Unix 系統中，行程是一個執實中的程式，它拥有：
- **獨立的位址空間**（虛擬記憶體）
- **執行上下文**（暫存器、程式計數器）
- **系統資源**（開啟的檔案、訊號處理器）

### 8.1.2 行程與執行緒的區別

| 特性 | 行程 | 執行緒 |
|------|------|--------|
| 位址空間 | 獨立 | 共享 |
| 資源 | 獨立 | 共享 |
| 創建成本 | 高 | 低 |
| 通訊方式 | IPC | 直接共享記憶體 |

xv6 中每個行程只有一個執行緒，沒有執行緒的區別。

## 8.2 xv6 行程結構 - 原始碼分析

### 8.2.1 proc 結構定義

這是 xv6 核心的行程控制塊結構，位於 `kernel/proc.h`：

```c
// kernel/proc.h:16-35
struct proc {
  uint64_t sz;                     // 行程擁有的記憶體大小 (位元組)
  pagetable_t pagetable;           // 頁表指標，用於虛擬記憶體翻譯
  struct trapframe *trapframe;    // 陷阱框架，保存使用者態暫存器
  char *kstack;                    // 核心堆疊底部指標 (每個行程有獨立核心堆疊)
  enum procstate state;            // 行程狀態
  int pid;                         // 行程 ID (唯一識別符)
  struct proc *parent;             // 指向父行程的指標
  struct trapframe cpu;            // 暫存器上下文，用於 context switch
  pde_t *pgdir;                    // 頁目錄指標 (等於pagetable)
  struct file *ofile[NOFILE];      // 開啟的檔案描述符表 (最多 NOFILE 個)
  struct inode *cwd;                // current working directory
  char name[16];                   // 行程名稱
};
```

**重要欄位說明：**
- `sz`: 行程的虛擬記憶體大小
- `pagetable`: 每個行程獨立的頁表，實現虛擬記憶體隔離
- `kstack`: 核心堆疊用於執行核心程式碼，確保核心不會被使用者程式錯誤覆蓋
- `trapframe`: 當發生系統呼叫或中斷時，保存使用者態的暫存器

### 8.2.2 行程狀態機

```c
// kernel/proc.h:6-12
enum procstate {
  UNUSED,    // 空閒槽，可被回收用於新行程
  EMBRYO,    // 初始中，行程結構已分配但尚未完全初始化
  SLEEPING,  // 睡眠中，等待某事件發生（如 I/O 完成）
  RUNNABLE,  // 可執行，已準備好但等待 CPU
  RUNNING,   // 執行中，正在 CPU 上執行
  ZOMBIE     // 僵屍，行程已結束但父行程尚未回收
};
```

**狀態轉換流程：**
```
UNUSED → EMBRYO (allocproc) 
  ↓
EMBRYO → SLEEPING (sleep) 或 → RUNNABLE (wakeup)
  ↓
RUNNABLE → RUNNING (scheduler 調度)
  ↓
RUNNING → RUNNABLE (時間片用完) 或 → SLEEPING (系統呼叫)
  ↓
RUNNING → ZOMBIE (exit)
  ↓
ZOMBIE → UNUSED (parent 呼叫 wait)
```

### 8.2.3 xv6 行程排程器原始碼

```c
// kernel/proc.c:372-385
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  
  c->proc = 0;
  for(;;){
    // 關閉中斷，確保原子性
    intr_on();
    for(p = proc; p < &proc[NPROC]; p++){
      // 只有 RUNNABLE 狀態的行程會被調度
      if(p->state == RUNNABLE){
        // 切換到該行程
        p->state = RUNNING;
        c->proc = p;
        swtch(&c->scheduler, &p->context);
        
        // 行程執行完畢後回來這裡
        c->proc = 0;
      }
    }
  }
}
```

**排程器原理分析：**
1. 使用無優先权的 Round-Robin 演算法
2. 每次遍尋所有行程，找到第一個 RUNNABLE 的
3. 透過 `swtch()` 進行 context switch
4. 每次只調度一個時間片

## 8.3 系統呼叫詳解

### 8.3.1 fork() 系統呼叫 - 原始碼

fork 是 Unix 最基本的行程創建機制：

```c
// kernel/sysproc.c:51-64
uint64
sys_fork(void)
{
  int pid;
  struct proc *np;
  
  // 配置新的行程結構
  if((np = allocproc()) == 0){
    return -1;
  }
  
  // 複製父行程的記憶體
  if(copyout(np->pagetable, 0, parent->pagetable, parent->sz) < 0){
    freeproc(np);
    release(&proc_lock);
    return -1;
  }
  
  np->sz = parent->sz;
  
  // 複製使用者堆疊
  // ... (省略部分程式碼)
  
  // 返回子行程 PID
  return pid;
}
```

**fork 的核心概念：**
1. **複製而非共享**：子行程獲得父行程記憶體的副本
2. **寫時複製 (Copy-on-Write)**：實際實現中，剛開始父子共享記憶體，只有在寫入時才真正複製
3. **返回值不同**：父行程收到子行程 PID，子行程收到 0

### 8.3.2 exec() 系統呼叫 - 原始碼

exec 用於執行新的程式：

```c
// kernel/exec.c:12-64
int
exec(char *path, char **argv)
{
  char *s, *last;
  int i, off;
  uint64 argc, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();

  // 讀取執行檔
  begin_op();
  ip = namei(path);
  if(ip == 0 || eload(ip, &elf) != 0){
    return -1;
  }

  // 分配新的頁表
  pagetable = uvmcreate();
  
  // 載入程式段
  for(i=0; i<elf.phnum; i++){
    if(elf.ph[i].type == ELF_PROG_LOAD){
      off = elf.ph[i].off;
      sz = uvmalloc(pagetable, sz, elf.ph[i].memsz);
      // 複製程式碼和資料
      if(readi(ip, 0, off, elf.ph[i].filesz) < 0)
        return -1;
    }
  }
  
  // 配置使用者堆疊
  sp = sz;
  stackbase = PGROUNDDOWN(sp - 1);
  sp = stackbase;
  
  // 設定 argv 指向新堆疊
  // ... (省略)
  
  // 更新行程
  oldpagetable = p->pagetable;
  p->pagetable = pagetable;
  p->sz = sz;
  p->tf->epc = elf.entry;  // 設定程式計數器為程式入口點
  
  return 0;
}
```

**exec 的核心概念：**
1. 完全替換當前行程的形象（記憶體、頁表）
2. 保留開啟的檔案描述符（除非標記為 close-on-exec）
3. 程式計數器指向新程式的入口點

### 8.3.3 wait() 和 exit() - 原始碼

```c
// kernel/sysproc.c:95-140
uint64
sys_wait(void)
{
  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
  
  for(;;){
    // 尋找子行程
    havekids = 0;
    for(np = proc; np < &proc[NPROC]; np++){
      if(np->parent == p){
        havekids = 1;
        if(np->state == ZOMBIE){
          // 找到僵屍行程，回收資源
          pid = np->pid;
          freeproc(np);
          return pid;
        }
      }
    }
    
    if(!havekids || p->killed){
      return -1;
    }
    
    // 睡眠等待子行程結束
    sleep(p, &proc_lock);
  }
}
```

## 8.4 排程與 Context Switch

### 8.4.1 Context Switch 原始碼

Context switch 是 CPU 從一個行程切換到另一個行程的過程：

```c
// kernel/swtch.S:1-16
.text

# swtch function - 儲存目前上下文並載入新上下文
.globl swtch
swtch:
  # 保存Caller的暫存器
  sd ra, 0(a0)
  sd sp, 8(a0)
  sd s0, 16(a0)
  sd s1, 24(a0)
  sd s2, 32(a0)
  sd s3, 40(a0)
  sd s4, 48(a0)
  sd s5, 56(a0)
  sd s6, 64(a0)
  sd s7, 72(a0)
  sd s8, 80(a0)
  sd s9, 88(a0)
  sd s10, 96(a0)
  sd s11, 104(a0)
  
  # 載入新行程的上下文
  ld ra, 0(a1)
  ld sp, 8(a1)
  ld s0, 16(a1)
  ld s1, 24(a1)
  # ... (其餘暫存器)
  
  ret
```

### 8.4.2 排程延遲與效能

xv6 的排程器簡單但有效：
- **優點**：程式碼簡單，容易理解
- **缺點**：沒有優先權、沒有公平性保障

每次 context switch 的開銷：
1. 儲存 13 個暫存器 (透過 swtch)
2. 更新 CPU 指針
3. 刷新 TLB (Translation Lookaside Buffer)

## 8.5 小結

本章深入解析了 xv6-ext 行程管理的核心機制：

1. **行程控制塊 (proc)**：儲存行程的所有狀態
2. **狀態機**：行程生命週期的管理
3. **fork()**：透過記憶體複製創建新行程
4. **exec()**：用新程式完全替換行程形象
5. **排程器**：Round-Robin 實現簡單的時間片輪詢

**關鍵概念回顧：**
- 行程是資源分配的基本單位
- fork-exec 是 Unix 行程創建的經典模式
- context switch 是多工的核心機制
- 排程器決定 CPU 時間如何分配

下一章將介紹檔案系統。