; ModuleID = 'c0c'
target triple = "arm64-apple-macosx15.0.0"

define i32 @fact(i32 %n) {
entry:
  %n.addr = alloca i32
  store i32 %n, ptr %n.addr
  %0 = load i32, ptr %n.addr
  %1 = icmp sle i32 %0, 1
  br i1 %1, label %L0, label %L1
L0:
  ret i32 1
L1:
  %2 = load i32, ptr %n.addr
  %3 = load i32, ptr %n.addr
  %4 = sub i32 %3, 1
  %5 = call i32 @fact(i32 %4)
  %6 = mul i32 %2, %5
  ret i32 %6
}

define i32 @main() {
entry:
  %0 = call i32 @fact(i32 5)
  ret i32 %0
}

declare i32 @printf(ptr, ...)
