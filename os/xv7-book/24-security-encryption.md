# 24. 安全傳輸與加密

## 24.1 SSH vs Telnet

### 24.1.1 為什麼需要加密？

Telnet 傳送明文，包括密碼。SSH 提供：
- 加密傳輸
- 伺服器身份驗證
- 客戶端身份驗證

### 24.1.2 SSH 協定的複雜度

SSH 需要：
1. 金鑰交換 (Diffie-Hellman)
2. 對稱加密 (AES)
3. 非對稱加密 (RSA/Ed25519)
4. 雜湊函數 (SHA-256)
5. 完整性驗證 (HMAC)

## 24.2 在 xv7 中實現 SSH

### 24.2.1 需要的元件

```c
// 密碼學基礎需要：
struct ssh_key {
    uint8_t type;      // RSA, Ed25519
    uint8_t *data;     // 金鑰資料
    uint32_t len;      // 長度
};

// 加密需要：
int encrypt(uint8_t *input, uint32_t len, struct ssh_key *key);
int decrypt(uint8_t *input, uint32_t len, struct ssh_key *key);
```

### 24.2.2 挑戰

- 需要移植密碼學庫（如 libssh、OpenSSL）
- 計算資源有限
- 程式碼複雜度大幅增加

## 24.3 替代方案

###  stunnel

在主機端使用 stunnel 加密：

```bash
# 主機端
stunnel -d 2222 -r 192.0.2.2:23
# 客戶端連線到 localhost:2222
```

## 24.4 小結

真正的 SSH 需要完整的密碼學實現，超出本章節範圍。可使用 stunnel 作為替代方案。