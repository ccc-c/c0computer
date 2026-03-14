; ModuleID = 'c0c'
define i32 @main() {
entry:
  %i = alloca i32
  store i32 0, ptr %i
  %sum = alloca i32
  store i32 0, ptr %sum
  br label %L0
L0:
  %0 = load i32, ptr %i
  %1 = icmp slt i32 %0, 5
  br i1 %1, label %L1, label %L2
L1:
  %2 = load i32, ptr %sum
  %3 = load i32, ptr %i
  %4 = add i32 %2, %3
  store i32 %4, ptr %sum
  %5 = load i32, ptr %i
  %6 = add i32 %5, 1
  store i32 %6, ptr %i
  br label %L0
L2:
  %j = alloca i32
  %prod = alloca i32
  store i32 1, ptr %prod
  store i32 1, ptr %j
  br label %L3
L3:
  %7 = load i32, ptr %j
  %8 = icmp sle i32 %7, 4
  br i1 %8, label %L4, label %L6
L4:
  %9 = load i32, ptr %prod
  %10 = load i32, ptr %j
  %11 = mul i32 %9, %10
  store i32 %11, ptr %prod
  br label %L5
L5:
  %12 = load i32, ptr %j
  %13 = add i32 %12, 1
  store i32 %13, ptr %j
  br label %L3
L6:
  %14 = load i32, ptr %sum
  %15 = load i32, ptr %prod
  %16 = call i32 (ptr, ...) @printf(ptr @.str.0, i32 %14, i32 %15)
  ret i32 0
}

@.str.0 = private unnamed_addr constant [16 x i8] c"sum=%d prod=%d\0A\00", align 1
declare i32 @printf(ptr, ...)
