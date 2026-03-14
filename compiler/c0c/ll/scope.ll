; ModuleID = 'c0c'
define i32 @main() {
entry:
  %v0 = alloca i32
  store i32 1, ptr %v0
  %v1 = alloca i32
  store i32 2, ptr %v1
  %0 = load i32, ptr %v1
  %1 = call i32 (ptr, ...) @printf(ptr @.str.0, i32 %0)
  %2 = load i32, ptr %v0
  %3 = call i32 (ptr, ...) @printf(ptr @.str.1, i32 %2)
  ret i32 0
}

@.str.0 = private unnamed_addr constant [10 x i8] c"inner=%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"outer=%d\0A\00", align 1
declare i32 @printf(ptr, ...)
