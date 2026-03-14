; ModuleID = 'c0c'
define i32 @main() {
entry:
  %v0 = alloca [3 x i32]
  %0 = getelementptr [3 x i32], ptr %v0, i32 0, i32 0
  store i32 1, ptr %0
  %1 = getelementptr [3 x i32], ptr %v0, i32 0, i32 1
  store i32 2, ptr %1
  %2 = getelementptr [3 x i32], ptr %v0, i32 0, i32 2
  store i32 3, ptr %2
  %v1 = alloca [4 x i8]
  %3 = getelementptr [4 x i8], ptr %v1, i32 0, i32 0
  store i8 97, ptr %3
  %4 = getelementptr [4 x i8], ptr %v1, i32 0, i32 1
  store i8 98, ptr %4
  %5 = getelementptr [4 x i8], ptr %v1, i32 0, i32 2
  store i8 99, ptr %5
  %6 = getelementptr [4 x i8], ptr %v1, i32 0, i32 3
  store i8 0, ptr %6
  %7 = getelementptr [3 x i32], ptr %v0, i32 0, i32 1
  %8 = load i32, ptr %7
  %9 = getelementptr [4 x i8], ptr %v1, i32 0, i32 0
  %10 = load i8, ptr %9
  %11 = getelementptr [4 x i8], ptr %v1, i32 0, i32 2
  %12 = load i8, ptr %11
  %13 = sext i8 %10 to i32
  %14 = sext i8 %12 to i32
  %15 = call i32 (ptr, ...) @printf(ptr @.str.0, i32 %8, i32 %13, i32 %14)
  ret i32 0
}

@.str.0 = private unnamed_addr constant [19 x i8] c"a1=%d s0=%d s2=%d\0A\00", align 1
declare i32 @printf(ptr, ...)
