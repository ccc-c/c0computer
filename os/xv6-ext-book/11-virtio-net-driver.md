# 11. Virtio 網路驅動程式

## 11.1 VirtIO 概述

VirtIO 是一种半虛擬化 ()paravirtualization) 框架，讓客作業系統能以高效能的方式與 Hypervisor 通訊。

## 11.2 VirtIO 網路卡結構

### 11.2.1 virtio_net_config

```c
struct virtio_net_config {
    uint8_t  mac[6];              // MAC 位址
    uint16_t status;              // 連線狀態
    uint16_t max_virtqueue_pairs; // 最大佇列對數
};
```

### 11.2.2 virtio_net_hdr

用於封包傳輸的 header：

```c
struct virtio_net_hdr {
    uint8_t  flags;
    uint8_t  gso_type;
    uint16_t hdr_len;
    uint16_t gso_size;
    uint16_t csum_start;
    uint16_t csum_offset;
    uint16_t num_buffers;
};
```

## 11.3 Virtqueue

Virtqueue 是 VirtIO 核心的共享記憶體機制：

### 11.3.1 結構

```
┌──────────────┐
│ Descriptor  │ 描述符表 (array)
│ Table       │
├──────────────┤
│ Available   │ 可用環
│ Ring        │
├──────────────┤
│ Used Ring   │ 使用中環
└──────────────┘
```

### 11.3.2 運作原理

1. **可用環**：Guest 寫入，Host 讀取
2. **使用中環**：Host 寫入，Guest 讀取
3. ** Descriptor**：實際的資料緩衝區

## 11.4 驅動程式初始化

### 11.4.1 探測裝置

```c
// 讀取 VirtIO MMIO
uint32_t magic = read32(VIRTIO_MMIO_MAGIC_VALUE);
// 驗證是否為 VirtIO 裝置
if (magic == 0x74726976) { // "virt"
    // 找到 VirtIO 網路卡
}
```

### 11.4.2 配置 Virtqueue

```c
// 配置傳送和接收佇列
virtq_desc = kalloc();
avail = kalloc();
used = kalloc();

// 設定 MMIO 暫存器
write32(VIRTIO_MMIO_QUEUE_SEL, 0);       // 選擇 Queue 0
write32(VIRTIO_MMIO_QUEUE_DESC_LOW, desc);
write32(VIRTIO_MMIO_QUEUE_AVAIL_LOW, avail);
write32(VIRTIO_MMIO_QUEUE_USED_LOW, used);
write32(VIRTIO_MMIO_QUEUE_READY, 1);    // 啟用 Queue
```

## 11.5 封包傳送與接收

### 11.5.1 傳送封包

```c
void virtio_send(struct net_device *dev, void *buf, int len) {
    // 1. 配置 Descriptor
    int idx = alloc_desc();
    desc[idx].addr = buf;
    desc[idx].len = len;
    desc[idx].flags = 0;
    desc[idx].next = 0;

    // 2. 加入 Available Ring
    avail->ring[avail->idx % num] = idx;
    avail->idx++;

    // 3. 通知 Host
    write32(VIRTIO_MMIO_QUEUE_NOTIFY, 0);
}
```

### 11.5.2 接收封包

```c
void virtio_recv(struct net_device *dev) {
    // 1. 檢查 Used Ring
    if (used->idx != last_used_idx) {
        int idx = used->ring[last_used_idx % num];
        
        // 2. 處理封包
        struct virtio_net_hdr *hdr = desc[idx].addr;
        void *data = desc[idx].addr + sizeof(hdr);
        
        net_input_handler(dev, data, desc[idx].len);
        
        last_used_idx++;
    }
}
```

## 11.6 中斷處理

```c
void virtio_intr() {
    // 讀取中斷狀態
    uint32_t is = read32(VIRTIO_MMIO_INTERRUPT_STATUS);
    
    if (is & VIRTIO_IRQ_RING) {
        // 處理接收完成
        virtio_recv(dev);
    }
    
    // 清除中斷
    write32(VIRTIO_MMIO_INTERRUPT_ACK, is);
}
```

## 11.7 小結

本章介紹了 VirtIO 網路驅動的實作：
- VirtIO 架構和 Virtqueue
- 驅動初始化流程
- 封包的傳送與接收
- 中斷處理機制

下一章將介紹 ARP、IP、ICMP 協定的實作。