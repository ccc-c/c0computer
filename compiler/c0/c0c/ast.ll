; ModuleID = 'ast.c'
source_filename = "ast.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@node_new = dso_local global ptr zeroinitializer
@node_free = dso_local global ptr zeroinitializer
@node_add_child = dso_local global ptr zeroinitializer
@type_new = dso_local global ptr zeroinitializer
@type_ptr = dso_local global ptr zeroinitializer
@type_array = dso_local global ptr zeroinitializer
@type_free = dso_local global ptr zeroinitializer
@type_is_integer = dso_local global ptr zeroinitializer
@type_is_float = dso_local global ptr zeroinitializer
@type_is_pointer = dso_local global ptr zeroinitializer
@type_size = dso_local global ptr zeroinitializer

define dso_local ptr @node_new(i64 %0, i32 %2) {
entry:
  %4 = alloca ptr
  %6 = call i32 @calloc(i32 1, i32 8)
  store ptr %6, ptr %4
  %7 = load ptr, ptr %4
  %9 = icmp eq i64 %7, 0
  %8 = zext i1 %9 to i64
  %10 = icmp ne i64 %8, 0
  br i1 %10, label %L0, label %L2
L0:
  %11 = getelementptr [7 x i8], ptr @.str0, i64 0, i64 0
  %12 = call i32 @perror(ptr %11)
  %13 = call i32 @exit(i32 1)
  br label %L2
L2:
  %14 = load ptr, ptr %4
  store i64 %0, ptr %14
  %15 = load ptr, ptr %4
  store i32 %2, ptr %15
  %16 = load ptr, ptr %4
  ret ptr %16
L3:
  ret ptr 0
}

define dso_local void @node_add_child(ptr %0, ptr %2) {
entry:
  %4 = load i64, ptr %0
  %5 = load i64, ptr %0
  %7 = sext i32 %5 to i64
  %8 = sext i32 1 to i64
  %6 = add i64 %7, %8
  %10 = sext i32 %6 to i64
  %11 = sext i32 8 to i64
  %9 = mul i64 %10, %11
  %12 = call i32 @realloc(i32 %4, i32 %9)
  store i32 %12, ptr %0
  %13 = load i64, ptr %0
  %15 = icmp eq i64 %13, 0
  %14 = zext i1 %15 to i64
  %16 = icmp ne i64 %14, 0
  br i1 %16, label %L0, label %L2
L0:
  %17 = getelementptr [8 x i8], ptr @.str1, i64 0, i64 0
  %18 = call i32 @perror(ptr %17)
  %19 = call i32 @exit(i32 1)
  br label %L2
L2:
  %20 = load i64, ptr %0
  %21 = load i64, ptr %0
  %23 = sext i32 %21 to i64
  %22 = add i64 %23, 1
  store i64 %22, ptr %0
  %24 = getelementptr i8, ptr %20, i64 %21
  store ptr %2, ptr %24
  ret void
}

define dso_local void @node_free(ptr %0) {
entry:
  %3 = icmp eq i64 %0, 0
  %2 = zext i1 %3 to i64
  %4 = icmp ne i64 %2, 0
  br i1 %4, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %5 = alloca i32
  store i32 0, ptr %5
  br label %L4
L4:
  %7 = load i32, ptr %5
  %8 = load i64, ptr %0
  %10 = sext i32 %7 to i64
  %11 = sext i32 %8 to i64
  %9 = icmp slt i64 %10, %11
  %12 = zext i1 %9 to i64
  %13 = icmp ne i64 %12, 0
  br i1 %13, label %L5, label %L7
L5:
  %14 = load i64, ptr %0
  %15 = load i32, ptr %5
  %16 = getelementptr i32, ptr %14, i64 %15
  %17 = load i32, ptr %16
  call void @node_free(i32 %17)
  br label %L6
L6:
  %19 = load i32, ptr %5
  %21 = sext i32 %19 to i64
  %20 = add i64 %21, 1
  store i64 %20, ptr %5
  br label %L4
L7:
  %22 = load i64, ptr %0
  %23 = call i32 @free(i32 %22)
  %24 = load i64, ptr %0
  %25 = call i32 @free(i32 %24)
  %26 = load i64, ptr %0
  %27 = call i32 @free(i32 %26)
  %28 = load i64, ptr %0
  %29 = call i32 @free(i32 %28)
  %30 = load i64, ptr %0
  %31 = call i32 @free(i32 %30)
  %32 = call i32 @free(ptr %0)
  ret void
}

define dso_local ptr @type_new(i64 %0) {
entry:
  %2 = alloca ptr
  %4 = call i32 @calloc(i32 1, i32 8)
  store ptr %4, ptr %2
  %5 = load ptr, ptr %2
  %7 = icmp eq i64 %5, 0
  %6 = zext i1 %7 to i64
  %8 = icmp ne i64 %6, 0
  br i1 %8, label %L0, label %L2
L0:
  %9 = getelementptr [7 x i8], ptr @.str2, i64 0, i64 0
  %10 = call i32 @perror(ptr %9)
  %11 = call i32 @exit(i32 1)
  br label %L2
L2:
  %12 = load ptr, ptr %2
  store i64 %0, ptr %12
  %13 = sub i64 0, 1
  %14 = load ptr, ptr %2
  store i32 %13, ptr %14
  %15 = load ptr, ptr %2
  ret ptr %15
L3:
  ret ptr 0
}

define dso_local ptr @type_ptr(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @type_new(ptr @TY_PTR)
  store ptr %4, ptr %2
  %5 = load ptr, ptr %2
  store ptr %0, ptr %5
  %6 = load ptr, ptr %2
  ret ptr %6
L0:
  ret ptr 0
}

define dso_local ptr @type_array(ptr %0, i64 %2) {
entry:
  %4 = alloca ptr
  %6 = call ptr @type_new(ptr @TY_ARRAY)
  store ptr %6, ptr %4
  %7 = load ptr, ptr %4
  store ptr %0, ptr %7
  %8 = load ptr, ptr %4
  store i64 %2, ptr %8
  %9 = load ptr, ptr %4
  ret ptr %9
L0:
  ret ptr 0
}

define dso_local void @type_free(ptr %0) {
entry:
  %3 = icmp eq i64 %0, 0
  %2 = zext i1 %3 to i64
  %4 = icmp ne i64 %2, 0
  br i1 %4, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %5 = load i64, ptr %0
  %6 = call i32 @free(i32 %5)
  %7 = load i64, ptr %0
  %8 = call i32 @free(i32 %7)
  %9 = load i64, ptr %0
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %L4, label %L6
L4:
  %11 = alloca i32
  store i32 0, ptr %11
  br label %L7
L7:
  %13 = load i32, ptr %11
  %14 = load i64, ptr %0
  %16 = sext i32 %13 to i64
  %17 = sext i32 %14 to i64
  %15 = icmp slt i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L8, label %L10
L8:
  %20 = load i64, ptr %0
  %21 = load i32, ptr %11
  %22 = getelementptr i8, ptr %20, i64 %21
  %23 = load i64, ptr %22
  %24 = call i32 @free(i32 %23)
  br label %L9
L9:
  %25 = load i32, ptr %11
  %27 = sext i32 %25 to i64
  %26 = add i64 %27, 1
  store i64 %26, ptr %11
  br label %L7
L10:
  %28 = load i64, ptr %0
  %29 = call i32 @free(i32 %28)
  br label %L6
L6:
  %30 = call i32 @free(ptr %0)
  ret void
}

define dso_local i32 @type_is_integer(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %3 = sext i32 %2 to i64
  switch i64 %3, label %L14 [
    i64 0, label %L1
    i64 0, label %L2
    i64 0, label %L3
    i64 0, label %L4
    i64 0, label %L5
    i64 0, label %L6
    i64 0, label %L7
    i64 0, label %L8
    i64 0, label %L9
    i64 0, label %L10
    i64 0, label %L11
    i64 0, label %L12
    i64 0, label %L13
  ]
L1:
  br label %L2
L2:
  br label %L3
L3:
  br label %L4
L4:
  br label %L5
L5:
  br label %L6
L6:
  br label %L7
L7:
  br label %L8
L8:
  br label %L9
L9:
  br label %L10
L10:
  br label %L11
L11:
  br label %L12
L12:
  br label %L13
L13:
  ret i32 1
L15:
  br label %L0
L14:
  ret i32 0
L16:
  br label %L0
L0:
  ret i32 0
}

define dso_local i32 @type_is_float(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %4 = sext i32 %2 to i64
  %5 = sext i32 @TY_FLOAT to i64
  %3 = icmp eq i64 %4, %5
  %6 = zext i1 %3 to i64
  %7 = load i64, ptr %0
  %9 = sext i32 %7 to i64
  %10 = sext i32 @TY_DOUBLE to i64
  %8 = icmp eq i64 %9, %10
  %11 = zext i1 %8 to i64
  %13 = sext i32 %6 to i64
  %14 = sext i32 %11 to i64
  %15 = icmp ne i64 %13, 0
  %16 = icmp ne i64 %14, 0
  %17 = or i1 %15, %16
  %18 = zext i1 %17 to i64
  ret i32 %18
L0:
  ret i32 0
}

define dso_local i32 @type_is_pointer(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %4 = sext i32 %2 to i64
  %5 = sext i32 @TY_PTR to i64
  %3 = icmp eq i64 %4, %5
  %6 = zext i1 %3 to i64
  %7 = load i64, ptr %0
  %9 = sext i32 %7 to i64
  %10 = sext i32 @TY_ARRAY to i64
  %8 = icmp eq i64 %9, %10
  %11 = zext i1 %8 to i64
  %13 = sext i32 %6 to i64
  %14 = sext i32 %11 to i64
  %15 = icmp ne i64 %13, 0
  %16 = icmp ne i64 %14, 0
  %17 = or i1 %15, %16
  %18 = zext i1 %17 to i64
  ret i32 %18
L0:
  ret i32 0
}

define dso_local i32 @type_size(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %3 = sext i32 %2 to i64
  switch i64 %3, label %L19 [
    i64 0, label %L1
    i64 0, label %L2
    i64 0, label %L3
    i64 0, label %L4
    i64 0, label %L5
    i64 0, label %L6
    i64 0, label %L7
    i64 0, label %L8
    i64 0, label %L9
    i64 0, label %L10
    i64 0, label %L11
    i64 0, label %L12
    i64 0, label %L13
    i64 0, label %L14
    i64 0, label %L15
    i64 0, label %L16
    i64 0, label %L17
    i64 0, label %L18
  ]
L1:
  ret i32 0
L20:
  br label %L2
L2:
  br label %L3
L3:
  br label %L4
L4:
  br label %L5
L5:
  ret i32 1
L21:
  br label %L6
L6:
  br label %L7
L7:
  ret i32 2
L22:
  br label %L8
L8:
  br label %L9
L9:
  br label %L10
L10:
  br label %L11
L11:
  ret i32 4
L23:
  br label %L12
L12:
  br label %L13
L13:
  br label %L14
L14:
  br label %L15
L15:
  br label %L16
L16:
  br label %L17
L17:
  ret i32 8
L24:
  br label %L18
L18:
  %4 = load i64, ptr %0
  %6 = sext i32 %4 to i64
  %7 = sext i32 0 to i64
  %5 = icmp slt i64 %6, %7
  %8 = zext i1 %5 to i64
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %L25, label %L27
L25:
  ret i32 0
L28:
  br label %L27
L27:
  %10 = load i64, ptr %0
  %11 = load i64, ptr %0
  %12 = call i32 @type_size(i32 %11)
  %14 = sext i32 %10 to i64
  %15 = sext i32 %12 to i64
  %13 = mul i64 %14, %15
  %16 = bitcast i32 %13 to i32
  ret i32 %16
L29:
  br label %L0
L19:
  ret i32 0
L30:
  br label %L0
L0:
  ret i32 0
}

@.str0 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str1 = private unnamed_addr constant [8 x i8] c"realloc\00"
@.str2 = private unnamed_addr constant [7 x i8] c"calloc\00"
