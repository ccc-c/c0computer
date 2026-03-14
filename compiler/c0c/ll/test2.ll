; ModuleID = 'c0c'
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
  %5 = load i32, ptr %a
  %6 = call i32 (ptr, ...) @printf(ptr @.str.0, i32 %5)
  %7 = load i32, ptr %c
  %8 = call i32 (ptr, ...) @printf(ptr @.str.1, i32 %7)
  ret i32 0
}

@.str.0 = private unnamed_addr constant [23 x i8] c"The value of a is: %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [27 x i8] c"Result of calculation: %d\0A\00", align 1
declare i32 @printf(ptr, ...)
