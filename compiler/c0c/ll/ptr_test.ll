; ModuleID = 'c0c'
define i32 @main() {
entry:
  %v0 = alloca i32
  store i32 10, ptr %v0
  %v1 = alloca ptr
  store ptr %v0, ptr %v1
  %0 = load ptr, ptr %v1
  %1 = load ptr, ptr %v1
  %2 = load i32, ptr %1
  %3 = add i32 %2, 5
  store i32 %3, ptr %0
  %v2 = alloca [3 x i32]
  %4 = getelementptr [3 x i32], ptr %v2, i32 0, i32 0
  store i32 1, ptr %4
  %5 = getelementptr [3 x i32], ptr %v2, i32 0, i32 1
  store i32 2, ptr %5
  %6 = getelementptr [3 x i32], ptr %v2, i32 0, i32 2
  store i32 3, ptr %6
  %v3 = alloca i32
  %7 = getelementptr [3 x i32], ptr %v2, i32 0, i32 1
  %8 = load i32, ptr %7
  store i32 %8, ptr %v3
  %9 = load i32, ptr %v0
  %10 = load i32, ptr %v3
  %11 = call i32 (ptr, ...) @printf(ptr @.str.0, i32 %9, i32 %10)
  ret i32 0
}

@.str.0 = private unnamed_addr constant [11 x i8] c"x=%d y=%d\0A\00", align 1
declare i32 @printf(ptr, ...)
