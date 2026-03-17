set -x

clang git0.c -o git0

# 1. 初始化仓库
./git0 init

# 2. 创建测试文件
echo "hello git0" > test.txt

# 3. 暂存文件
./git0 add test.txt

# 4. 提交版本（带提交信息）
./git0 commit "first commit: add test.txt"

# 5. 查看提交日志
./git0 log

# 6. 修改文件后再次提交
echo "update content" >> test.txt
./git0 add test.txt
./git0 commit "second commit: update test.txt"

# 7. 再次查看日志
./git0 log
