; ModuleID = 'c0c'
target triple = "arm64-apple-macosx15.0.0"

define i32 @main() {
entry:
  %a = alloca i32
  %b = alloca i32
  %c = alloca i32
  store i32 10, ptr %a
  %0 = load i32, ptr %a
  %1 = add i32 %0, 2
  %2 = mul i32 5, %1
  store i32 %2, ptr %b
  %3 = load i32, ptr %b
  %4 = sdiv i32 %3, 2
  store i32 %4, ptr %c
  %5 = load i32, ptr %c
  ret i32 %5
}

declare i32 @printf(ptr, ...)
