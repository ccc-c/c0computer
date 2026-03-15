# pcmake

`pcmake` 是一個輕量級、跨平台的 C/C++ 專案建置工具。

## 安裝

```bash
pip install pcmake
```

## 使用方法

在專案目錄下建立 `Pcmakefile`：

```python
app = target("ssl_app")
app.set_kind("binary")
app.add_files("main.c", "math_utils.c")
app.add_packages("openssl")
```

然後執行建置：

```bash
pcmake build
```
