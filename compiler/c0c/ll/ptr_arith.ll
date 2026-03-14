; ModuleID = 'c0c'
define i32 @main() {
entry:
  %v0 = alloca [3 x i32]
  %0 = getelementptr [3 x i32], ptr %v0, i32 0, i32 0
  store i32 10, ptr %0
  %1 = getelementptr [3 x i32], ptr %v0, i32 0, i32 1
  store i32 20, ptr %1
  %2 = getelementptr [3 x i32], ptr %v0, i32 0, i32 2
  store i32 30, ptr %2
  %v1 = alloca ptr
  %3 = getelementptr [3 x i32], ptr %v0, i32 0, i32 0
  store ptr %3, ptr %v1
  %v2 = alloca i32
  %4 = load ptr, ptr %v1
  %5 = getelementptr i32, ptr %4, i32 1
  %6 = load i32, ptr %5
  store i32 %6, ptr %v2
  %v3 = alloca i32
  %7 = load ptr, ptr %v1
  %8 = getelementptr i32, ptr %7, i32 2
  %9 = load i32, ptr %8
  store i32 %9, ptr %v3
  %10 = load i32, ptr %v2
  %11 = load i32, ptr %v3
  %12 = call i32 (ptr, ...) @printf(ptr @.str.0, i32 %10, i32 %11)
  ret i32 0
}

@.str.0 = private unnamed_addr constant [11 x i8] c"x=%d y=%d\0A\00", align 1
declare i32 @printf(ptr, ...)
