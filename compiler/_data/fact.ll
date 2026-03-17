; ModuleID = 'c0c'
define i64 @factorial(i32 %n) {
entry:
  %v0 = alloca i32
  store i32 %n, ptr %v0
  %0 = load i32, ptr %v0
  %1 = icmp sle i32 %0, 1
  br i1 %1, label %L0, label %L2
L0:
  %2 = sext i32 1 to i64
  ret i64 %2
L2:
  %3 = load i32, ptr %v0
  %4 = sext i32 %3 to i64
  %5 = load i32, ptr %v0
  %6 = sub i32 %5, 1
  %7 = call i64 @factorial(i32 %6)
  %8 = mul i64 %4, %7
  ret i64 %8
}

define i32 @main() {
entry:
  %v0 = alloca i32
  store i32 5, ptr %v0
  %v1 = alloca i64
  %0 = load i32, ptr %v0
  %1 = call i64 @factorial(i32 %0)
  store i64 %1, ptr %v1
  %2 = load i64, ptr %v1
  %3 = trunc i64 %2 to i32
  ret i32 %3
}

declare i32 @printf(ptr, ...)
