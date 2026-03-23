# 4. RISC-V 架構與 VirtIO 裝置

## 4.1 RISC-V 架構概述

RISC-V (Reduced Instruction Set Computer - Version 5) 是一個開放源碼的指令集架構 (ISA)。xv6-ext 運行在 64 位元 RISC-V (RV64) 架構上。

### 4.1.1 RISC-V 特點
- 開放標準，無授權費用
- 模組化設計 (base + extensions)
- 簡化的指令集
- 適合嵌入式和高效能運算

### 4.1.2 特权等级 (Privilege Levels)

RISC-V 定義了三個特權等級：

| 等級 | 名稱 | 用途 |
|------|------|------|
| 0 (U) | User | 使用者態應用程式 |
| 1 (S) | Supervisor | 作業系統核心 |
| 3 (M) | Machine | 硬體/韌體 |

xv6-riscv 執行在 S (Supervisor) 模式下。

## 4.2 QEMU 虛擬機

### 4.2.1 QEMU 支援
QEMU 提供完整的 RISC-V 虛擬機支援：
- **virt** 機器類型：通用的 RISC-V virt 平台
- **virtio** 裝置：高效能的半虛擬化裝置

### 4.2.2 啟動指令
```bash
qemu-system-riscv64 \
    -machine virt \
    -kernel kernel/kernel \
    -m 128M \
    -smp 3 \
    -nographic
```

參數說明：
- `-machine virt`: 使用 virt 機器類型
- `-kernel`: 指定核心映像檔
- `-m 128M`: 分配 128MB 記憶體
- `-smp 3`: 3 個 CPU 核心
- `-nographic`: 不使用圖形界面

## 4.3 VirtIO 簡介

VirtIO 是一種半虛擬化 (para-virtualization) 技術，讓客作業系統能高效地與Hypervisor 通訊。

### 4.3.1 VirtIO 優點
1. **高效能**：比完全模擬快很多
2. **標準化**：跨 Hypervisor 相容
3. **簡單實作**：只需實作驅動程式

### 4.3.2 VirtIO 區塊圖

```
xv6 Kernel              QEMU
┌──────────────┐        ┌──────────────┐
│ virtio_net   │   ←→   │ 網路模擬器   │
│ 驅動程式     │        │              │
└──────────────┘        └──────────────┘
       ↓                       ↓
┌──────────────┐        ┌──────────────┐
│ VirtIO queues│        │ VirtIO queues│
└──────────────┘        └──────────────┘
```

## 4.4 VirtIO 網路驅動

### 4.4.1 驅動程式架構

VirtIO 網路驅動位於 `kernel/net/platform/xv6-riscv/virtio_net.c`

核心功能：
1. **初始化**：探測 VirtIO 網路卡
2. **傳輸**：透過 virtqueue 收發封包
3. **中斷處理**：處理網路事件

### 4.4.2 關鍵結構

```c
// VirtIO 網路卡結構
struct virtio_net_config {
    uint16_t mac[6];    // MAC 位址
    uint16_t status;   // 連線狀態
    uint16_t max_virtqueue_pairs;
};

// 封包緩衝區
struct virtio_net_hdr {
    uint8_t flags;
    uint8_t gso_type;
    uint16_t hdr_len;
    uint16_t grad_sum;
    uint16_t num_buffers;
};
```

### 4.4.3 封包傳輸流程

```
1. 配置緩衝區 (virtqueue)
2. 填充封包資料
3. 通知 QEMU (kick)
4. QEMU 處理並傳送
5. 收到完成中斷
6. 回收緩衝區
```

## 4.5 網路設定

### 4.5.1 TAP 裝置

Linux 主機使用 TAP 裝置建立虛擬網路：

```bash
# 建立 TAP 介面
sudo ip tuntap add mode tap user $USER name tap0

# 設定 IP
sudo ip addr add 192.0.2.1/24 dev tap0

# 啟動介面
sudo ip link set tap0 up
```

### 4.5.2 QEMU 網路連線

```bash
# 啟動 QEMU 並連接 TAP
qemu-system-riscv64 \
    -netdev tap,ifname=tap0,id=en0 \
    -device virtio-net-device,netdev=en0
```

### 4.5.3 網路拓撲

```
┌─────────────┐     eth0      ┌─────────────┐
│  Linux 主機 │ ───────────────│   Router    │
│             │   192.0.2.1   │             │
└─────────────┘               └─────────────┘
        │ tap0
        │ 192.0.2.1/24
        ↓
┌─────────────┐
│  QEMU       │
│  xv6        │  virtio-net
│  192.0.2.2  │
└─────────────┘
```

## 4.6 記憶體對應 I/O (MMIO)

VirtIO 裝置使用 MMIO 進行通訊：

### 4.6.1 MMIO 暫存器

```c
// VirtIO MMIO 暫存器
#define VIRTIO_MMIO_MAGIC_VALUE     0x000
#define VIRTIO_MMIO_VERSION          0x004
#define VIRTIO_MMIO_DEVICE_ID         0x008
#define VIRTIO_MMIO_VENDOR_ID         0x00c
#define VIRTIO_MMIO_DEVICE_FEATURES   0x010
#define VIRTIO_MMIO_DRIVER_FEATURES   0x020
#define ...
```

### 4.6.2 存取方式

VirtIO 記憶體對應到 `0x10001000`：

```c
// MMIO 讀取
uint32_t read32(uint64_t addr) {
    return *(volatile uint32_t *)addr;
}

// MMIO 寫入
void write32(uint64_t addr, uint32_t val) {
    *(volatile uint32_t *)addr = val;
}
```

## 4.7 小結

本節介紹了：
- RISC-V 架構基礎
- QEMU 虛擬機環境
- VirtIO 半虛擬化技術
- 網路驅動程式運作原理
- 主機與 QEMU 的網路連接方式

這些知識對於理解 xv6-ext 的網路功能運作非常重要。