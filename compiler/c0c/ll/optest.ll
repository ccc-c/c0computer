; ModuleID = 'c0c'
define i32 @main() {
entry:
  %i = alloca i32
  store i32 0, ptr %i
  %sum = alloca i32
  store i32 0, ptr %sum
  br label %L0
L0:
  %0 = alloca i1
  %1 = load i32, ptr %i
  %2 = icmp slt i32 %1, 5
  br i1 %2, label %L3, label %L4
L3:
  %3 = load i32, ptr %sum
  %4 = icmp slt i32 %3, 10
  store i1 %4, ptr %0
  br label %L5
L4:
  store i1 0, ptr %0
  br label %L5
L5:
  %5 = load i1, ptr %0
  br i1 %5, label %L1, label %L2
L1:
  %6 = load i32, ptr %i
  %7 = load i32, ptr %sum
  %8 = add i32 %7, %6
  store i32 %8, ptr %sum
  %9 = load i32, ptr %i
  %10 = add i32 %9, 1
  store i32 %10, ptr %i
  br label %L0
L2:
  %j = alloca i32
  store i32 3, ptr %j
  store i32 3, ptr %j
  br label %L6
L6:
  %11 = load i32, ptr %j
  %12 = icmp sgt i32 %11, 0
  br i1 %12, label %L7, label %L9
L7:
  %13 = load i32, ptr %sum
  %14 = load i32, ptr %j
  %15 = add i32 %13, %14
  store i32 %15, ptr %sum
  br label %L8
L8:
  %16 = load i32, ptr %j
  %17 = sub i32 %16, 1
  store i32 %17, ptr %j
  br label %L6
L9:
  %18 = alloca i1
  %19 = load i32, ptr %sum
  %20 = srem i32 %19, 2
  %21 = icmp eq i32 %20, 0
  %22 = xor i1 %21, 1
  br i1 %22, label %L11, label %L10
L10:
  %23 = load i32, ptr %sum
  %24 = icmp eq i32 %23, 0
  store i1 %24, ptr %18
  br label %L12
L11:
  store i1 1, ptr %18
  br label %L12
L12:
  %25 = load i1, ptr %18
  br i1 %25, label %L13, label %L15
L13:
  %26 = load i32, ptr %sum
  %27 = call i32 (ptr, ...) @printf(ptr @.str.0, i32 %26)
  br label %L15
L15:
  ret i32 0
}

@.str.0 = private unnamed_addr constant [8 x i8] c"sum=%d\0A\00", align 1
declare i32 @printf(ptr, ...)
