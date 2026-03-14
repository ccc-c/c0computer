; ModuleID = 'c0c'
define i32 @main() {
entry:
  %v0 = alloca i8
  %0 = trunc i32 65 to i8
  store i8 %0, ptr %v0
  %1 = load i8, ptr %v0
  %2 = sext i8 %1 to i32
  %3 = call i32 (ptr, ...) @printf(ptr @.str.0, i32 %2)
  ret i32 0
}

@.str.0 = private unnamed_addr constant [6 x i8] c"c=%d\0A\00", align 1
declare i32 @printf(ptr, ...)
