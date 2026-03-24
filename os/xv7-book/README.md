# xv7 作業系統設計

---

## 目錄

### 第一部分：xv6 基礎介紹

* [1. xv6 作業系統概述](01-xv6-overview.md)
* [2. xv6-riscv-net 的擴充部分](02-xv6-riscv-net-extend.md)
* [3. xv7 的擴充部分](03-xv7.md)
* [4. RISC-V 架構與virtIO 裝置](04-riscv-virtio.md)

### 第二部分：開發環境建置

* [5. 開發工具安裝與設定](05-development-tools.md)
* [6. QEMU 虛擬機執行](06-running-qemu.md)
* [7. tap0 網路設定與橋接](07-tap-network-setup.md)

### 第三部分：xv6 核心元件

* [8. 行程管理與系統呼叫](08-process-management.md)
* [9. 檔案系統架構](09-filesystem.md)
* [10. 網路通訊協定疊層](10-network-protocol-stack.md)

### 第四部分：網路功能實作

* [11. Virtio 網路驅動程式](11-virtio-net-driver.md)
* [12. ARP、IP、ICMP 實作](12-arp-ip-icmp.md)
* [13. UDP 與 TCP 傳輸層](13-udp-tcp.md)
* [14. Socket API 與系統呼叫](14-socket-api.md)

### 第五部分：HTTP 伺服器與客戶端

* [15. httpd.c HTTP 伺服器實作](15-httpd-implementation.md)
* [16. curl.c HTTP 客戶端實作](16-curl-implementation.md)
* [17. HTTP 協定與請求處理](17-http-protocol.md)

### 第六部分：Telnet 伺服器

* [18. telnetd.c Telnet 伺服器實作](18-telnetd-implementation.md)

### 第七部分：測試與除錯

* [19. 自動化測試脚本](19-automated-testing.md)
* [20. 網路封包分析](20-packet-analysis.md)
* [21. 常見問題與解決方案](21-troubleshooting.md)

### 第八部分：進階話題

* [22. 更完整的 HTTP 1.1 支援](22-http11-support.md)
* [23. 檔案傳輸與網頁服務](23-ftp-web-service.md)
* [24. 安全傳輸與加密](24-security-encryption.md)
* [25. 效能優化與效能調校](25-performance-tuning.md)

### 附錄

* [A1. Makefile 編譯選項](A1-makefile-options.md)
* [A2. 指令與工具速查表](A2-command-reference.md)
* [A3. 程式碼結構圖](A3-code-structure.md)
* [A4. 參考資源與連結](A4-references.md)

---

*最後更新：2026-03-23*
*版本：xv7 1.0*