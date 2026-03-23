# 9. 檔案系統架構

## 9.1 xv6 檔案系統概述

xv6 使用 Unix v6 風格的檔案系統，支援：
- 檔案和目錄
- 硬連結 (hard link)
- 管道 (pipe)

## 9.2 磁碟布局

```
┌────────────┬────────────┬────────────┬────────────┐
│  Boot      │  Super     │  Inode     │  Data      │
│  block     │  block     │  blocks    │  blocks    │
└────────────┴────────────┴────────────┴────────────┘
```

- **Boot block**: 開機程式
- **Super block**: 檔案系統元資料
- **Inode blocks**: 檔案 inode 索引節點
- **Data blocks**: 實際資料儲存

## 9.3 Inode 結構

```c
struct dinode {
  short type;           // 檔案類型
  short major;          // 主設備號
  short minor;          // 副設備號
  short nlink;          // 連結數
  uint size;            // 檔案大小
  uint addrs[NDIRECT+1]; // 資料區塊指標
};
```

## 9.4 檔案描述符

每個行程有自己的檔案描述符表：

```c
struct file {
  struct inode *ip;      // 指向 inode
  int off;              // 讀寫位置
  int readable;         // 可讀
  int writable;        // 可寫
};
```

## 9.5 系統呼叫

### 9.5.1 基本操作

```c
int open(char *path, int mode);
int read(int fd, char *buf, int n);
int write(int fd, char *buf, int n);
int close(int fd);
```

### 9.5.2 目錄操作

```c
int mkdir(char *path);
int chdir(char *path);
struct dirent *readdir(int fd);
```

## 9.6 virtio 磁碟驅動

```c
// kernel/virtio_disk.c
// 使用 VirtIO 區塊裝置
struct virtio_blk_req {
  uint32_t type;
  uint32_t reserved;
  uint64_t sector;
  char data[512];
  uint32_t status;
};
```

## 9.7 小結

本章介紹了 xv6 檔案系統的基本概念：
- 磁碟布局
- inode 結構
- 檔案描述符
- 基本的檔案操作

下一章將介紹網路協定疊層。