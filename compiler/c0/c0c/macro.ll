; ModuleID = 'macro.c'
source_filename = "macro.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@macro_preprocess = dso_local global ptr zeroinitializer
@macros = internal global ptr zeroinitializer
@n_macros = internal global i32 zeroinitializer
@expand_text = internal global ptr zeroinitializer
@INCLUDE_PATHS = internal global ptr zeroinitializer
@preprocess_into = internal global ptr zeroinitializer

define internal void @buf_init(ptr %0) {
entry:
  %2 = call i32 @malloc(i32 65536)
  store i32 %2, ptr %0
  %3 = load i64, ptr %0
  %5 = icmp eq i64 %3, 0
  %4 = zext i1 %5 to i64
  %6 = icmp ne i64 %4, 0
  br i1 %6, label %L0, label %L2
L0:
  %7 = getelementptr [7 x i8], ptr @.str0, i64 0, i64 0
  %8 = call i32 @perror(ptr %7)
  %9 = call i32 @exit(i32 1)
  br label %L2
L2:
  %10 = load i64, ptr %0
  %11 = getelementptr i8, ptr %10, i64 0
  store i8 0, ptr %11
  store i32 0, ptr %0
  store i32 65536, ptr %0
  ret void
}

define internal void @buf_grow(ptr %0, i64 %2) {
entry:
  br label %L0
L0:
  %4 = load i64, ptr %0
  %6 = sext i32 %4 to i64
  %7 = sext i32 %2 to i64
  %5 = add i64 %6, %7
  %9 = sext i32 %5 to i64
  %10 = sext i32 1 to i64
  %8 = add i64 %9, %10
  %11 = load i64, ptr %0
  %13 = sext i32 %8 to i64
  %14 = sext i32 %11 to i64
  %12 = icmp sgt i64 %13, %14
  %15 = zext i1 %12 to i64
  %16 = icmp ne i64 %15, 0
  br i1 %16, label %L1, label %L2
L1:
  %17 = load i64, ptr %0
  %19 = sext i32 %17 to i64
  %20 = sext i32 2 to i64
  %18 = mul i64 %19, %20
  store i64 %18, ptr %0
  %21 = load i64, ptr %0
  %22 = load i64, ptr %0
  %23 = call i32 @realloc(i32 %21, i32 %22)
  store i32 %23, ptr %0
  %24 = load i64, ptr %0
  %26 = icmp eq i64 %24, 0
  %25 = zext i1 %26 to i64
  %27 = icmp ne i64 %25, 0
  br i1 %27, label %L3, label %L5
L3:
  %28 = getelementptr [8 x i8], ptr @.str1, i64 0, i64 0
  %29 = call i32 @perror(ptr %28)
  %30 = call i32 @exit(i32 1)
  br label %L5
L5:
  br label %L0
L2:
  ret void
}

define internal void @buf_append(ptr %0, ptr %2, i64 %4) {
entry:
  call void @buf_grow(ptr %0, i64 %4)
  %7 = load i64, ptr %0
  %8 = load i64, ptr %0
  %10 = sext i32 %7 to i64
  %11 = sext i32 %8 to i64
  %9 = add i64 %10, %11
  %12 = call i32 @memcpy(i32 %9, ptr %2, i64 %4)
  %13 = load i64, ptr %0
  %15 = sext i32 %13 to i64
  %16 = sext i32 %4 to i64
  %14 = add i64 %15, %16
  store i64 %14, ptr %0
  %17 = load i64, ptr %0
  %18 = load i64, ptr %0
  %19 = getelementptr i8, ptr %17, i64 %18
  store i8 0, ptr %19
  ret void
}

define internal void @buf_putc(ptr %0, i8 %2) {
entry:
  call void @buf_grow(ptr %0, i32 1)
  %5 = load i64, ptr %0
  %6 = load i64, ptr %0
  %8 = sext i32 %6 to i64
  %7 = add i64 %8, 1
  store i64 %7, ptr %0
  %9 = getelementptr i8, ptr %5, i64 %6
  store i8 %2, ptr %9
  %10 = load i64, ptr %0
  %11 = load i64, ptr %0
  %12 = getelementptr i8, ptr %10, i64 %11
  store i8 0, ptr %12
  ret void
}

define internal ptr @macro_find(ptr %0) {
entry:
  %2 = alloca i32
  store i32 0, ptr %2
  br label %L0
L0:
  %4 = load i32, ptr %2
  %5 = load i32, ptr @n_macros
  %7 = sext i32 %4 to i64
  %8 = sext i32 %5 to i64
  %6 = icmp slt i64 %7, %8
  %9 = zext i1 %6 to i64
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %L1, label %L3
L1:
  %11 = load ptr, ptr @macros
  %12 = load i32, ptr %2
  %13 = getelementptr i8, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %15 = load ptr, ptr @macros
  %16 = load i32, ptr %2
  %17 = getelementptr i8, ptr %15, i64 %16
  %18 = load i64, ptr %17
  %19 = call i32 @strcmp(i32 %18, ptr %0)
  %21 = sext i32 %19 to i64
  %22 = sext i32 0 to i64
  %20 = icmp eq i64 %21, %22
  %23 = zext i1 %20 to i64
  %25 = sext i32 %14 to i64
  %26 = sext i32 %23 to i64
  %27 = icmp ne i64 %25, 0
  %28 = icmp ne i64 %26, 0
  %29 = and i1 %27, %28
  %30 = zext i1 %29 to i64
  %31 = icmp ne i64 %30, 0
  br i1 %31, label %L4, label %L6
L4:
  %32 = load ptr, ptr @macros
  %33 = load i32, ptr %2
  %34 = getelementptr i8, ptr %32, i64 %33
  ret ptr %34
L7:
  br label %L6
L6:
  br label %L2
L2:
  %35 = load i32, ptr %2
  %37 = sext i32 %35 to i64
  %36 = add i64 %37, 1
  store i64 %36, ptr %2
  br label %L0
L3:
  %38 = inttoptr i64 0 to ptr
  ret ptr %38
L8:
  ret ptr 0
}

define internal void @macro_define(ptr %0, ptr %2, ptr %4, i32 %6, i32 %8) {
entry:
  %10 = alloca i32
  store i32 0, ptr %10
  br label %L0
L0:
  %12 = load i32, ptr %10
  %13 = load i32, ptr @n_macros
  %15 = sext i32 %12 to i64
  %16 = sext i32 %13 to i64
  %14 = icmp slt i64 %15, %16
  %17 = zext i1 %14 to i64
  %18 = icmp ne i64 %17, 0
  br i1 %18, label %L1, label %L3
L1:
  %19 = load ptr, ptr @macros
  %20 = load i32, ptr %10
  %21 = getelementptr i8, ptr %19, i64 %20
  %22 = load i64, ptr %21
  %23 = call i32 @strcmp(i32 %22, ptr %0)
  %25 = sext i32 %23 to i64
  %26 = sext i32 0 to i64
  %24 = icmp eq i64 %25, %26
  %27 = zext i1 %24 to i64
  %28 = icmp ne i64 %27, 0
  br i1 %28, label %L4, label %L6
L4:
  %29 = load ptr, ptr @macros
  %30 = load i32, ptr %10
  %31 = getelementptr i8, ptr %29, i64 %30
  %32 = load i64, ptr %31
  %33 = call i32 @free(i32 %32)
  %34 = call i32 @strdup(ptr %2)
  %35 = load ptr, ptr @macros
  %36 = load i32, ptr %10
  %37 = getelementptr i8, ptr %35, i64 %36
  store i32 %34, ptr %37
  %38 = load ptr, ptr @macros
  %39 = load i32, ptr %10
  %40 = getelementptr i8, ptr %38, i64 %39
  store i32 1, ptr %40
  ret void
L7:
  br label %L6
L6:
  br label %L2
L2:
  %41 = load i32, ptr %10
  %43 = sext i32 %41 to i64
  %42 = add i64 %43, 1
  store i64 %42, ptr %10
  br label %L0
L3:
  %44 = load i32, ptr @n_macros
  %46 = sext i32 %44 to i64
  %47 = sext i32 512 to i64
  %45 = icmp sge i64 %46, %47
  %48 = zext i1 %45 to i64
  %49 = icmp ne i64 %48, 0
  br i1 %49, label %L8, label %L10
L8:
  %50 = getelementptr [18 x i8], ptr @.str2, i64 0, i64 0
  %51 = call i32 @fprintf(ptr @stderr, ptr %50)
  ret void
L11:
  br label %L10
L10:
  %52 = alloca ptr
  %54 = load ptr, ptr @macros
  %55 = load i32, ptr @n_macros
  %57 = sext i32 %55 to i64
  %56 = add i64 %57, 1
  store i64 %56, ptr @n_macros
  %58 = getelementptr i8, ptr %54, i64 %55
  store ptr %58, ptr %52
  %59 = call i32 @strdup(ptr %0)
  %60 = load ptr, ptr %52
  store i32 %59, ptr %60
  %61 = call i32 @strdup(ptr %2)
  %62 = load ptr, ptr %52
  store i32 %61, ptr %62
  %63 = load ptr, ptr %52
  store i32 %6, ptr %63
  %64 = load ptr, ptr %52
  store i32 %8, ptr %64
  %65 = load ptr, ptr %52
  store i32 1, ptr %65
  %66 = alloca i32
  store i32 0, ptr %66
  br label %L12
L12:
  %68 = load i32, ptr %66
  %70 = sext i32 %68 to i64
  %71 = sext i32 %6 to i64
  %69 = icmp slt i64 %70, %71
  %72 = zext i1 %69 to i64
  %73 = load i32, ptr %66
  %75 = sext i32 %73 to i64
  %76 = sext i32 16 to i64
  %74 = icmp slt i64 %75, %76
  %77 = zext i1 %74 to i64
  %79 = sext i32 %72 to i64
  %80 = sext i32 %77 to i64
  %81 = icmp ne i64 %79, 0
  %82 = icmp ne i64 %80, 0
  %83 = and i1 %81, %82
  %84 = zext i1 %83 to i64
  %85 = icmp ne i64 %84, 0
  br i1 %85, label %L13, label %L15
L13:
  %86 = load i32, ptr %66
  %87 = getelementptr ptr, ptr %4, i64 %86
  %88 = load ptr, ptr %87
  %89 = icmp ne i64 %88, 0
  br i1 %89, label %L16, label %L17
L16:
  %90 = load i32, ptr %66
  %91 = getelementptr ptr, ptr %4, i64 %90
  %92 = load ptr, ptr %91
  %93 = call i32 @strdup(ptr %92)
  br label %L18
L17:
  %94 = inttoptr i64 0 to ptr
  br label %L18
L18:
  %95 = phi i64 [ %93, %L16 ], [ %94, %L17 ]
  %96 = load ptr, ptr %52
  %97 = load i64, ptr %96
  %98 = load i32, ptr %66
  %99 = getelementptr i8, ptr %97, i64 %98
  store i32 %95, ptr %99
  br label %L14
L14:
  %100 = load i32, ptr %66
  %102 = sext i32 %100 to i64
  %101 = add i64 %102, 1
  store i64 %101, ptr %66
  br label %L12
L15:
  ret void
}

define internal void @macro_undef(ptr %0) {
entry:
  %2 = alloca i32
  store i32 0, ptr %2
  br label %L0
L0:
  %4 = load i32, ptr %2
  %5 = load i32, ptr @n_macros
  %7 = sext i32 %4 to i64
  %8 = sext i32 %5 to i64
  %6 = icmp slt i64 %7, %8
  %9 = zext i1 %6 to i64
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %L1, label %L3
L1:
  %11 = load ptr, ptr @macros
  %12 = load i32, ptr %2
  %13 = getelementptr i8, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %15 = call i32 @strcmp(i32 %14, ptr %0)
  %17 = sext i32 %15 to i64
  %18 = sext i32 0 to i64
  %16 = icmp eq i64 %17, %18
  %19 = zext i1 %16 to i64
  %20 = icmp ne i64 %19, 0
  br i1 %20, label %L4, label %L6
L4:
  %21 = load ptr, ptr @macros
  %22 = load i32, ptr %2
  %23 = getelementptr i8, ptr %21, i64 %22
  store i32 0, ptr %23
  ret void
L7:
  br label %L6
L6:
  br label %L2
L2:
  %24 = load i32, ptr %2
  %26 = sext i32 %24 to i64
  %25 = add i64 %26, 1
  store i64 %25, ptr %2
  br label %L0
L3:
  ret void
}

define internal ptr @skip_ws(ptr %0) {
entry:
  br label %L0
L0:
  %2 = load i8, ptr %0
  %4 = sext i32 %2 to i64
  %5 = sext i32 32 to i64
  %3 = icmp eq i64 %4, %5
  %6 = zext i1 %3 to i64
  %7 = load i8, ptr %0
  %9 = sext i32 %7 to i64
  %10 = sext i32 9 to i64
  %8 = icmp eq i64 %9, %10
  %11 = zext i1 %8 to i64
  %13 = sext i32 %6 to i64
  %14 = sext i32 %11 to i64
  %15 = icmp ne i64 %13, 0
  %16 = icmp ne i64 %14, 0
  %17 = or i1 %15, %16
  %18 = zext i1 %17 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L1, label %L2
L1:
  %21 = sext i32 %0 to i64
  %20 = add i64 %21, 1
  store i64 %20, ptr %0
  br label %L0
L2:
  ret ptr %0
L3:
  ret ptr 0
}

define internal ptr @skip_to_eol(ptr %0) {
entry:
  br label %L0
L0:
  %2 = load i8, ptr %0
  %3 = load i8, ptr %0
  %5 = sext i32 %3 to i64
  %6 = sext i32 10 to i64
  %4 = icmp ne i64 %5, %6
  %7 = zext i1 %4 to i64
  %9 = sext i32 %2 to i64
  %10 = sext i32 %7 to i64
  %11 = icmp ne i64 %9, 0
  %12 = icmp ne i64 %10, 0
  %13 = and i1 %11, %12
  %14 = zext i1 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %L1, label %L2
L1:
  %17 = sext i32 %0 to i64
  %16 = add i64 %17, 1
  store i64 %16, ptr %0
  br label %L0
L2:
  ret ptr %0
L3:
  ret ptr 0
}

define internal ptr @read_ident(ptr %0, ptr %2, i64 %4) {
entry:
  %6 = alloca i64
  store i64 0, ptr %6
  br label %L0
L0:
  %8 = load i8, ptr %0
  %9 = load i8, ptr %0
  %10 = bitcast i8 %9 to i8
  %11 = call i32 @isalnum(i8 %10)
  %12 = load i8, ptr %0
  %14 = sext i32 %12 to i64
  %15 = sext i32 95 to i64
  %13 = icmp eq i64 %14, %15
  %16 = zext i1 %13 to i64
  %18 = sext i32 %11 to i64
  %19 = sext i32 %16 to i64
  %20 = icmp ne i64 %18, 0
  %21 = icmp ne i64 %19, 0
  %22 = or i1 %20, %21
  %23 = zext i1 %22 to i64
  %25 = sext i32 %8 to i64
  %26 = sext i32 %23 to i64
  %27 = icmp ne i64 %25, 0
  %28 = icmp ne i64 %26, 0
  %29 = and i1 %27, %28
  %30 = zext i1 %29 to i64
  %31 = load i64, ptr %6
  %33 = sext i32 %4 to i64
  %34 = sext i32 1 to i64
  %32 = sub i64 %33, %34
  %36 = sext i32 %31 to i64
  %37 = sext i32 %32 to i64
  %35 = icmp slt i64 %36, %37
  %38 = zext i1 %35 to i64
  %40 = sext i32 %30 to i64
  %41 = sext i32 %38 to i64
  %42 = icmp ne i64 %40, 0
  %43 = icmp ne i64 %41, 0
  %44 = and i1 %42, %43
  %45 = zext i1 %44 to i64
  %46 = icmp ne i64 %45, 0
  br i1 %46, label %L1, label %L2
L1:
  %48 = sext i32 %0 to i64
  %47 = add i64 %48, 1
  store i64 %47, ptr %0
  %49 = load i8, ptr %0
  %50 = load i64, ptr %6
  %52 = sext i32 %50 to i64
  %51 = add i64 %52, 1
  store i64 %51, ptr %6
  %53 = getelementptr i8, ptr %2, i64 %50
  store i8 %49, ptr %53
  br label %L0
L2:
  %54 = load i64, ptr %6
  %55 = getelementptr i8, ptr %2, i64 %54
  store i8 0, ptr %55
  ret ptr %0
L3:
  ret ptr 0
}

define internal void @expand_func_macro(ptr %0, ptr %2, ptr %4, i32 %6) {
entry:
  %8 = alloca ptr
  %10 = load ptr, ptr %2
  store ptr %10, ptr %8
  %11 = load ptr, ptr %8
  %12 = call ptr @skip_ws(ptr %11)
  store ptr %12, ptr %8
  %13 = load ptr, ptr %8
  %14 = load i8, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 40 to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L0, label %L2
L0:
  %20 = load i64, ptr %0
  %21 = load i64, ptr %0
  %22 = call i32 @strlen(i32 %21)
  call void @buf_append(ptr %4, i32 %20, i32 %22)
  ret void
L3:
  br label %L2
L2:
  %24 = load ptr, ptr %8
  %26 = sext i32 %24 to i64
  %25 = add i64 %26, 1
  store i64 %25, ptr %8
  %27 = alloca ptr
  store ptr 0, ptr %27
  %29 = alloca i32
  store i32 0, ptr %29
  %31 = alloca i32
  store i32 0, ptr %31
  %33 = alloca i64
  call void @buf_init(ptr %33)
  br label %L4
L4:
  %36 = load ptr, ptr %8
  %37 = load i8, ptr %36
  %38 = load i32, ptr %31
  %40 = sext i32 %38 to i64
  %41 = sext i32 0 to i64
  %39 = icmp eq i64 %40, %41
  %42 = zext i1 %39 to i64
  %43 = load ptr, ptr %8
  %44 = load i8, ptr %43
  %46 = sext i32 %44 to i64
  %47 = sext i32 41 to i64
  %45 = icmp eq i64 %46, %47
  %48 = zext i1 %45 to i64
  %50 = sext i32 %42 to i64
  %51 = sext i32 %48 to i64
  %52 = icmp ne i64 %50, 0
  %53 = icmp ne i64 %51, 0
  %54 = and i1 %52, %53
  %55 = zext i1 %54 to i64
  %57 = icmp eq i64 %55, 0
  %56 = zext i1 %57 to i64
  %59 = sext i32 %37 to i64
  %60 = sext i32 %56 to i64
  %61 = icmp ne i64 %59, 0
  %62 = icmp ne i64 %60, 0
  %63 = and i1 %61, %62
  %64 = zext i1 %63 to i64
  %65 = icmp ne i64 %64, 0
  br i1 %65, label %L5, label %L6
L5:
  %66 = load ptr, ptr %8
  %67 = load i8, ptr %66
  %69 = sext i32 %67 to i64
  %70 = sext i32 44 to i64
  %68 = icmp eq i64 %69, %70
  %71 = zext i1 %68 to i64
  %72 = load i32, ptr %31
  %74 = sext i32 %72 to i64
  %75 = sext i32 0 to i64
  %73 = icmp eq i64 %74, %75
  %76 = zext i1 %73 to i64
  %78 = sext i32 %71 to i64
  %79 = sext i32 %76 to i64
  %80 = icmp ne i64 %78, 0
  %81 = icmp ne i64 %79, 0
  %82 = and i1 %80, %81
  %83 = zext i1 %82 to i64
  %84 = icmp ne i64 %83, 0
  br i1 %84, label %L7, label %L8
L7:
  %85 = load i32, ptr %29
  %87 = sext i32 %85 to i64
  %88 = sext i32 16 to i64
  %86 = icmp slt i64 %87, %88
  %89 = zext i1 %86 to i64
  %90 = icmp ne i64 %89, 0
  br i1 %90, label %L10, label %L12
L10:
  %91 = load i64, ptr %33
  %92 = call i32 @strdup(i32 %91)
  %93 = load ptr, ptr %27
  %94 = load i32, ptr %29
  %96 = sext i32 %94 to i64
  %95 = add i64 %96, 1
  store i64 %95, ptr %29
  %97 = getelementptr i8, ptr %93, i64 %94
  store i32 %92, ptr %97
  br label %L12
L12:
  store i32 0, ptr %33
  %98 = load i64, ptr %33
  %99 = getelementptr i8, ptr %98, i64 0
  store i8 0, ptr %99
  %100 = load ptr, ptr %8
  %102 = sext i32 %100 to i64
  %101 = add i64 %102, 1
  store i64 %101, ptr %8
  br label %L9
L8:
  %103 = load ptr, ptr %8
  %104 = load i8, ptr %103
  %106 = sext i32 %104 to i64
  %107 = sext i32 34 to i64
  %105 = icmp eq i64 %106, %107
  %108 = zext i1 %105 to i64
  %109 = icmp ne i64 %108, 0
  br i1 %109, label %L13, label %L14
L13:
  %110 = load ptr, ptr %8
  %112 = sext i32 %110 to i64
  %111 = add i64 %112, 1
  store i64 %111, ptr %8
  %113 = load i8, ptr %110
  call void @buf_putc(ptr %33, i8 %113)
  br label %L16
L16:
  %115 = load ptr, ptr %8
  %116 = load i8, ptr %115
  %117 = load ptr, ptr %8
  %118 = load i8, ptr %117
  %120 = sext i32 %118 to i64
  %121 = sext i32 34 to i64
  %119 = icmp ne i64 %120, %121
  %122 = zext i1 %119 to i64
  %124 = sext i32 %116 to i64
  %125 = sext i32 %122 to i64
  %126 = icmp ne i64 %124, 0
  %127 = icmp ne i64 %125, 0
  %128 = and i1 %126, %127
  %129 = zext i1 %128 to i64
  %130 = icmp ne i64 %129, 0
  br i1 %130, label %L17, label %L18
L17:
  %131 = load ptr, ptr %8
  %132 = load i8, ptr %131
  %134 = sext i32 %132 to i64
  %135 = sext i32 92 to i64
  %133 = icmp eq i64 %134, %135
  %136 = zext i1 %133 to i64
  %137 = load ptr, ptr %8
  %138 = getelementptr i8, ptr %137, i64 1
  %139 = load i8, ptr %138
  %141 = sext i32 %136 to i64
  %142 = sext i32 %139 to i64
  %143 = icmp ne i64 %141, 0
  %144 = icmp ne i64 %142, 0
  %145 = and i1 %143, %144
  %146 = zext i1 %145 to i64
  %147 = icmp ne i64 %146, 0
  br i1 %147, label %L19, label %L21
L19:
  %148 = load ptr, ptr %8
  %150 = sext i32 %148 to i64
  %149 = add i64 %150, 1
  store i64 %149, ptr %8
  %151 = load i8, ptr %148
  call void @buf_putc(ptr %33, i8 %151)
  br label %L21
L21:
  %153 = load ptr, ptr %8
  %155 = sext i32 %153 to i64
  %154 = add i64 %155, 1
  store i64 %154, ptr %8
  %156 = load i8, ptr %153
  call void @buf_putc(ptr %33, i8 %156)
  br label %L16
L18:
  %158 = load ptr, ptr %8
  %159 = load i8, ptr %158
  %160 = icmp ne i64 %159, 0
  br i1 %160, label %L22, label %L24
L22:
  %161 = load ptr, ptr %8
  %163 = sext i32 %161 to i64
  %162 = add i64 %163, 1
  store i64 %162, ptr %8
  %164 = load i8, ptr %161
  call void @buf_putc(ptr %33, i8 %164)
  br label %L24
L24:
  br label %L15
L14:
  %166 = load ptr, ptr %8
  %167 = load i8, ptr %166
  %169 = sext i32 %167 to i64
  %170 = sext i32 39 to i64
  %168 = icmp eq i64 %169, %170
  %171 = zext i1 %168 to i64
  %172 = icmp ne i64 %171, 0
  br i1 %172, label %L25, label %L26
L25:
  %173 = load ptr, ptr %8
  %175 = sext i32 %173 to i64
  %174 = add i64 %175, 1
  store i64 %174, ptr %8
  %176 = load i8, ptr %173
  call void @buf_putc(ptr %33, i8 %176)
  %178 = load ptr, ptr %8
  %179 = load i8, ptr %178
  %181 = sext i32 %179 to i64
  %182 = sext i32 92 to i64
  %180 = icmp eq i64 %181, %182
  %183 = zext i1 %180 to i64
  %184 = load ptr, ptr %8
  %185 = getelementptr i8, ptr %184, i64 1
  %186 = load i8, ptr %185
  %188 = sext i32 %183 to i64
  %189 = sext i32 %186 to i64
  %190 = icmp ne i64 %188, 0
  %191 = icmp ne i64 %189, 0
  %192 = and i1 %190, %191
  %193 = zext i1 %192 to i64
  %194 = icmp ne i64 %193, 0
  br i1 %194, label %L28, label %L30
L28:
  %195 = load ptr, ptr %8
  %197 = sext i32 %195 to i64
  %196 = add i64 %197, 1
  store i64 %196, ptr %8
  %198 = load i8, ptr %195
  call void @buf_putc(ptr %33, i8 %198)
  br label %L30
L30:
  %200 = load ptr, ptr %8
  %201 = load i8, ptr %200
  %202 = icmp ne i64 %201, 0
  br i1 %202, label %L31, label %L33
L31:
  %203 = load ptr, ptr %8
  %205 = sext i32 %203 to i64
  %204 = add i64 %205, 1
  store i64 %204, ptr %8
  %206 = load i8, ptr %203
  call void @buf_putc(ptr %33, i8 %206)
  br label %L33
L33:
  %208 = load ptr, ptr %8
  %209 = load i8, ptr %208
  %211 = sext i32 %209 to i64
  %212 = sext i32 39 to i64
  %210 = icmp eq i64 %211, %212
  %213 = zext i1 %210 to i64
  %214 = icmp ne i64 %213, 0
  br i1 %214, label %L34, label %L36
L34:
  %215 = load ptr, ptr %8
  %217 = sext i32 %215 to i64
  %216 = add i64 %217, 1
  store i64 %216, ptr %8
  %218 = load i8, ptr %215
  call void @buf_putc(ptr %33, i8 %218)
  br label %L36
L36:
  br label %L27
L26:
  %220 = load ptr, ptr %8
  %221 = load i8, ptr %220
  %223 = sext i32 %221 to i64
  %224 = sext i32 40 to i64
  %222 = icmp eq i64 %223, %224
  %225 = zext i1 %222 to i64
  %226 = icmp ne i64 %225, 0
  br i1 %226, label %L37, label %L39
L37:
  %227 = load i32, ptr %31
  %229 = sext i32 %227 to i64
  %228 = add i64 %229, 1
  store i64 %228, ptr %31
  br label %L39
L39:
  %230 = load ptr, ptr %8
  %231 = load i8, ptr %230
  %233 = sext i32 %231 to i64
  %234 = sext i32 41 to i64
  %232 = icmp eq i64 %233, %234
  %235 = zext i1 %232 to i64
  %236 = icmp ne i64 %235, 0
  br i1 %236, label %L40, label %L42
L40:
  %237 = load i32, ptr %31
  %239 = sext i32 %237 to i64
  %238 = sub i64 %239, 1
  store i64 %238, ptr %31
  br label %L42
L42:
  %240 = load i32, ptr %31
  %242 = sext i32 %240 to i64
  %243 = sext i32 0 to i64
  %241 = icmp sge i64 %242, %243
  %244 = zext i1 %241 to i64
  %245 = icmp ne i64 %244, 0
  br i1 %245, label %L43, label %L44
L43:
  %246 = load ptr, ptr %8
  %248 = sext i32 %246 to i64
  %247 = add i64 %248, 1
  store i64 %247, ptr %8
  %249 = load i8, ptr %246
  call void @buf_putc(ptr %33, i8 %249)
  br label %L45
L44:
  br label %L6
L46:
  br label %L45
L45:
  br label %L27
L27:
  br label %L15
L15:
  br label %L9
L9:
  br label %L4
L6:
  %251 = load i64, ptr %33
  %253 = sext i32 %251 to i64
  %254 = sext i32 0 to i64
  %252 = icmp sgt i64 %253, %254
  %255 = zext i1 %252 to i64
  %256 = load i32, ptr %29
  %258 = sext i32 %256 to i64
  %259 = sext i32 0 to i64
  %257 = icmp sgt i64 %258, %259
  %260 = zext i1 %257 to i64
  %262 = sext i32 %255 to i64
  %263 = sext i32 %260 to i64
  %264 = icmp ne i64 %262, 0
  %265 = icmp ne i64 %263, 0
  %266 = or i1 %264, %265
  %267 = zext i1 %266 to i64
  %268 = icmp ne i64 %267, 0
  br i1 %268, label %L47, label %L49
L47:
  %269 = load i32, ptr %29
  %271 = sext i32 %269 to i64
  %272 = sext i32 16 to i64
  %270 = icmp slt i64 %271, %272
  %273 = zext i1 %270 to i64
  %274 = icmp ne i64 %273, 0
  br i1 %274, label %L50, label %L52
L50:
  %275 = load i64, ptr %33
  %276 = call i32 @strdup(i32 %275)
  %277 = load ptr, ptr %27
  %278 = load i32, ptr %29
  %280 = sext i32 %278 to i64
  %279 = add i64 %280, 1
  store i64 %279, ptr %29
  %281 = getelementptr i8, ptr %277, i64 %278
  store i32 %276, ptr %281
  br label %L52
L52:
  br label %L49
L49:
  %282 = load i64, ptr %33
  %283 = call i32 @free(i32 %282)
  %284 = load ptr, ptr %8
  %285 = load i8, ptr %284
  %287 = sext i32 %285 to i64
  %288 = sext i32 41 to i64
  %286 = icmp eq i64 %287, %288
  %289 = zext i1 %286 to i64
  %290 = icmp ne i64 %289, 0
  br i1 %290, label %L53, label %L55
L53:
  %291 = load ptr, ptr %8
  %293 = sext i32 %291 to i64
  %292 = add i64 %293, 1
  store i64 %292, ptr %8
  br label %L55
L55:
  %294 = load ptr, ptr %8
  store ptr %294, ptr %2
  %295 = alloca ptr
  %297 = load i64, ptr %0
  store ptr %297, ptr %295
  %298 = alloca i64
  call void @buf_init(ptr %298)
  br label %L56
L56:
  %301 = load ptr, ptr %295
  %302 = load i8, ptr %301
  %303 = icmp ne i64 %302, 0
  br i1 %303, label %L57, label %L58
L57:
  %304 = load ptr, ptr %295
  %305 = load i8, ptr %304
  %307 = sext i32 %305 to i64
  %308 = sext i32 35 to i64
  %306 = icmp eq i64 %307, %308
  %309 = zext i1 %306 to i64
  %310 = load ptr, ptr %295
  %311 = getelementptr i8, ptr %310, i64 1
  %312 = load i8, ptr %311
  %314 = sext i32 %312 to i64
  %315 = sext i32 35 to i64
  %313 = icmp ne i64 %314, %315
  %316 = zext i1 %313 to i64
  %318 = sext i32 %309 to i64
  %319 = sext i32 %316 to i64
  %320 = icmp ne i64 %318, 0
  %321 = icmp ne i64 %319, 0
  %322 = and i1 %320, %321
  %323 = zext i1 %322 to i64
  %324 = icmp ne i64 %323, 0
  br i1 %324, label %L59, label %L61
L59:
  %325 = load ptr, ptr %295
  %327 = sext i32 %325 to i64
  %326 = add i64 %327, 1
  store i64 %326, ptr %295
  br label %L62
L62:
  %328 = load ptr, ptr %295
  %329 = load i8, ptr %328
  %331 = sext i32 %329 to i64
  %332 = sext i32 32 to i64
  %330 = icmp eq i64 %331, %332
  %333 = zext i1 %330 to i64
  %334 = load ptr, ptr %295
  %335 = load i8, ptr %334
  %337 = sext i32 %335 to i64
  %338 = sext i32 9 to i64
  %336 = icmp eq i64 %337, %338
  %339 = zext i1 %336 to i64
  %341 = sext i32 %333 to i64
  %342 = sext i32 %339 to i64
  %343 = icmp ne i64 %341, 0
  %344 = icmp ne i64 %342, 0
  %345 = or i1 %343, %344
  %346 = zext i1 %345 to i64
  %347 = icmp ne i64 %346, 0
  br i1 %347, label %L63, label %L64
L63:
  %348 = load ptr, ptr %295
  %350 = sext i32 %348 to i64
  %349 = add i64 %350, 1
  store i64 %349, ptr %295
  br label %L62
L64:
  %351 = alloca ptr
  %353 = alloca ptr
  %355 = load ptr, ptr %295
  %356 = load ptr, ptr %351
  %357 = call ptr @read_ident(ptr %355, ptr %356, i32 8)
  store ptr %357, ptr %353
  %358 = alloca i32
  store i32 0, ptr %358
  %360 = alloca i32
  store i32 0, ptr %360
  br label %L65
L65:
  %362 = load i32, ptr %360
  %363 = load i64, ptr %0
  %365 = sext i32 %362 to i64
  %366 = sext i32 %363 to i64
  %364 = icmp slt i64 %365, %366
  %367 = zext i1 %364 to i64
  %368 = load i32, ptr %360
  %370 = sext i32 %368 to i64
  %371 = sext i32 16 to i64
  %369 = icmp slt i64 %370, %371
  %372 = zext i1 %369 to i64
  %374 = sext i32 %367 to i64
  %375 = sext i32 %372 to i64
  %376 = icmp ne i64 %374, 0
  %377 = icmp ne i64 %375, 0
  %378 = and i1 %376, %377
  %379 = zext i1 %378 to i64
  %380 = icmp ne i64 %379, 0
  br i1 %380, label %L66, label %L68
L66:
  %381 = load i64, ptr %0
  %382 = load i32, ptr %360
  %383 = getelementptr i32, ptr %381, i64 %382
  %384 = load i32, ptr %383
  %385 = load i64, ptr %0
  %386 = load i32, ptr %360
  %387 = getelementptr i32, ptr %385, i64 %386
  %388 = load i32, ptr %387
  %389 = load ptr, ptr %351
  %390 = call i32 @strcmp(i32 %388, ptr %389)
  %392 = sext i32 %390 to i64
  %393 = sext i32 0 to i64
  %391 = icmp eq i64 %392, %393
  %394 = zext i1 %391 to i64
  %396 = sext i32 %384 to i64
  %397 = sext i32 %394 to i64
  %398 = icmp ne i64 %396, 0
  %399 = icmp ne i64 %397, 0
  %400 = and i1 %398, %399
  %401 = zext i1 %400 to i64
  %402 = icmp ne i64 %401, 0
  br i1 %402, label %L69, label %L71
L69:
  call void @buf_putc(ptr %298, i8 34)
  %404 = load i32, ptr %360
  %405 = load i32, ptr %29
  %407 = sext i32 %404 to i64
  %408 = sext i32 %405 to i64
  %406 = icmp slt i64 %407, %408
  %409 = zext i1 %406 to i64
  %410 = load ptr, ptr %27
  %411 = load i32, ptr %360
  %412 = getelementptr ptr, ptr %410, i64 %411
  %413 = load ptr, ptr %412
  %415 = sext i32 %409 to i64
  %416 = sext i32 %413 to i64
  %417 = icmp ne i64 %415, 0
  %418 = icmp ne i64 %416, 0
  %419 = and i1 %417, %418
  %420 = zext i1 %419 to i64
  %421 = icmp ne i64 %420, 0
  br i1 %421, label %L72, label %L74
L72:
  %422 = alloca ptr
  %424 = load ptr, ptr %27
  %425 = load i32, ptr %360
  %426 = getelementptr ptr, ptr %424, i64 %425
  %427 = load ptr, ptr %426
  store ptr %427, ptr %422
  br label %L75
L75:
  %428 = load ptr, ptr %422
  %429 = load i8, ptr %428
  %430 = icmp ne i64 %429, 0
  br i1 %430, label %L76, label %L77
L76:
  %431 = load ptr, ptr %422
  %432 = load i8, ptr %431
  %434 = sext i32 %432 to i64
  %435 = sext i32 34 to i64
  %433 = icmp eq i64 %434, %435
  %436 = zext i1 %433 to i64
  %437 = load ptr, ptr %422
  %438 = load i8, ptr %437
  %440 = sext i32 %438 to i64
  %441 = sext i32 92 to i64
  %439 = icmp eq i64 %440, %441
  %442 = zext i1 %439 to i64
  %444 = sext i32 %436 to i64
  %445 = sext i32 %442 to i64
  %446 = icmp ne i64 %444, 0
  %447 = icmp ne i64 %445, 0
  %448 = or i1 %446, %447
  %449 = zext i1 %448 to i64
  %450 = icmp ne i64 %449, 0
  br i1 %450, label %L78, label %L80
L78:
  call void @buf_putc(ptr %298, i8 92)
  br label %L80
L80:
  %452 = load ptr, ptr %422
  %454 = sext i32 %452 to i64
  %453 = add i64 %454, 1
  store i64 %453, ptr %422
  %455 = load i8, ptr %452
  call void @buf_putc(ptr %298, i8 %455)
  br label %L75
L77:
  br label %L74
L74:
  call void @buf_putc(ptr %298, i8 34)
  store i32 1, ptr %358
  br label %L68
L81:
  br label %L71
L71:
  br label %L67
L67:
  %458 = load i32, ptr %360
  %460 = sext i32 %458 to i64
  %459 = add i64 %460, 1
  store i64 %459, ptr %360
  br label %L65
L68:
  %461 = load i32, ptr %358
  %463 = icmp eq i64 %461, 0
  %462 = zext i1 %463 to i64
  %464 = icmp ne i64 %462, 0
  br i1 %464, label %L82, label %L84
L82:
  call void @buf_putc(ptr %298, i8 34)
  call void @buf_putc(ptr %298, i8 34)
  br label %L84
L84:
  %467 = load ptr, ptr %353
  store ptr %467, ptr %295
  br label %L56
L85:
  br label %L61
L61:
  %468 = load ptr, ptr %295
  %469 = load i8, ptr %468
  %471 = sext i32 %469 to i64
  %472 = sext i32 35 to i64
  %470 = icmp eq i64 %471, %472
  %473 = zext i1 %470 to i64
  %474 = load ptr, ptr %295
  %475 = getelementptr i8, ptr %474, i64 1
  %476 = load i8, ptr %475
  %478 = sext i32 %476 to i64
  %479 = sext i32 35 to i64
  %477 = icmp eq i64 %478, %479
  %480 = zext i1 %477 to i64
  %482 = sext i32 %473 to i64
  %483 = sext i32 %480 to i64
  %484 = icmp ne i64 %482, 0
  %485 = icmp ne i64 %483, 0
  %486 = and i1 %484, %485
  %487 = zext i1 %486 to i64
  %488 = icmp ne i64 %487, 0
  br i1 %488, label %L86, label %L88
L86:
  %489 = load ptr, ptr %295
  %491 = sext i32 %489 to i64
  %492 = sext i32 2 to i64
  %490 = add i64 %491, %492
  store i64 %490, ptr %295
  br label %L89
L89:
  %493 = load ptr, ptr %295
  %494 = load i8, ptr %493
  %496 = sext i32 %494 to i64
  %497 = sext i32 32 to i64
  %495 = icmp eq i64 %496, %497
  %498 = zext i1 %495 to i64
  %499 = load ptr, ptr %295
  %500 = load i8, ptr %499
  %502 = sext i32 %500 to i64
  %503 = sext i32 9 to i64
  %501 = icmp eq i64 %502, %503
  %504 = zext i1 %501 to i64
  %506 = sext i32 %498 to i64
  %507 = sext i32 %504 to i64
  %508 = icmp ne i64 %506, 0
  %509 = icmp ne i64 %507, 0
  %510 = or i1 %508, %509
  %511 = zext i1 %510 to i64
  %512 = icmp ne i64 %511, 0
  br i1 %512, label %L90, label %L91
L90:
  %513 = load ptr, ptr %295
  %515 = sext i32 %513 to i64
  %514 = add i64 %515, 1
  store i64 %514, ptr %295
  br label %L89
L91:
  br label %L56
L92:
  br label %L88
L88:
  %516 = load ptr, ptr %295
  %517 = load i8, ptr %516
  %518 = bitcast i8 %517 to i8
  %519 = call i32 @isalpha(i8 %518)
  %520 = load ptr, ptr %295
  %521 = load i8, ptr %520
  %523 = sext i32 %521 to i64
  %524 = sext i32 95 to i64
  %522 = icmp eq i64 %523, %524
  %525 = zext i1 %522 to i64
  %527 = sext i32 %519 to i64
  %528 = sext i32 %525 to i64
  %529 = icmp ne i64 %527, 0
  %530 = icmp ne i64 %528, 0
  %531 = or i1 %529, %530
  %532 = zext i1 %531 to i64
  %533 = icmp ne i64 %532, 0
  br i1 %533, label %L93, label %L94
L93:
  %534 = alloca ptr
  %536 = alloca ptr
  %538 = load ptr, ptr %295
  %539 = load ptr, ptr %534
  %540 = call ptr @read_ident(ptr %538, ptr %539, i32 8)
  store ptr %540, ptr %536
  %541 = alloca i32
  store i32 0, ptr %541
  %543 = load ptr, ptr %534
  %544 = getelementptr [12 x i8], ptr @.str3, i64 0, i64 0
  %545 = call i32 @strcmp(ptr %543, ptr %544)
  %547 = sext i32 %545 to i64
  %548 = sext i32 0 to i64
  %546 = icmp eq i64 %547, %548
  %549 = zext i1 %546 to i64
  %550 = icmp ne i64 %549, 0
  br i1 %550, label %L96, label %L98
L96:
  %551 = alloca i32
  %553 = load i64, ptr %0
  store i32 %553, ptr %551
  br label %L99
L99:
  %554 = load i32, ptr %551
  %555 = load i32, ptr %29
  %557 = sext i32 %554 to i64
  %558 = sext i32 %555 to i64
  %556 = icmp slt i64 %557, %558
  %559 = zext i1 %556 to i64
  %560 = icmp ne i64 %559, 0
  br i1 %560, label %L100, label %L102
L100:
  %561 = load i32, ptr %551
  %562 = load i64, ptr %0
  %564 = sext i32 %561 to i64
  %565 = sext i32 %562 to i64
  %563 = icmp sgt i64 %564, %565
  %566 = zext i1 %563 to i64
  %567 = icmp ne i64 %566, 0
  br i1 %567, label %L103, label %L105
L103:
  call void @buf_putc(ptr %298, i8 44)
  br label %L105
L105:
  %569 = load ptr, ptr %27
  %570 = load i32, ptr %551
  %571 = getelementptr ptr, ptr %569, i64 %570
  %572 = load ptr, ptr %571
  %573 = icmp ne i64 %572, 0
  br i1 %573, label %L106, label %L108
L106:
  %574 = load ptr, ptr %27
  %575 = load i32, ptr %551
  %576 = getelementptr ptr, ptr %574, i64 %575
  %577 = load ptr, ptr %576
  %578 = load ptr, ptr %27
  %579 = load i32, ptr %551
  %580 = getelementptr ptr, ptr %578, i64 %579
  %581 = load ptr, ptr %580
  %582 = call i32 @strlen(ptr %581)
  call void @buf_append(ptr %298, ptr %577, i32 %582)
  br label %L108
L108:
  br label %L101
L101:
  %584 = load i32, ptr %551
  %586 = sext i32 %584 to i64
  %585 = add i64 %586, 1
  store i64 %585, ptr %551
  br label %L99
L102:
  store i32 1, ptr %541
  br label %L98
L98:
  %587 = load i32, ptr %541
  %589 = icmp eq i64 %587, 0
  %588 = zext i1 %589 to i64
  %590 = icmp ne i64 %588, 0
  br i1 %590, label %L109, label %L111
L109:
  %591 = alloca i32
  store i32 0, ptr %591
  br label %L112
L112:
  %593 = load i32, ptr %591
  %594 = load i64, ptr %0
  %596 = sext i32 %593 to i64
  %597 = sext i32 %594 to i64
  %595 = icmp slt i64 %596, %597
  %598 = zext i1 %595 to i64
  %599 = load i32, ptr %591
  %601 = sext i32 %599 to i64
  %602 = sext i32 16 to i64
  %600 = icmp slt i64 %601, %602
  %603 = zext i1 %600 to i64
  %605 = sext i32 %598 to i64
  %606 = sext i32 %603 to i64
  %607 = icmp ne i64 %605, 0
  %608 = icmp ne i64 %606, 0
  %609 = and i1 %607, %608
  %610 = zext i1 %609 to i64
  %611 = icmp ne i64 %610, 0
  br i1 %611, label %L113, label %L115
L113:
  %612 = load i64, ptr %0
  %613 = load i32, ptr %591
  %614 = getelementptr i32, ptr %612, i64 %613
  %615 = load i32, ptr %614
  %616 = load i64, ptr %0
  %617 = load i32, ptr %591
  %618 = getelementptr i32, ptr %616, i64 %617
  %619 = load i32, ptr %618
  %620 = load ptr, ptr %534
  %621 = call i32 @strcmp(i32 %619, ptr %620)
  %623 = sext i32 %621 to i64
  %624 = sext i32 0 to i64
  %622 = icmp eq i64 %623, %624
  %625 = zext i1 %622 to i64
  %627 = sext i32 %615 to i64
  %628 = sext i32 %625 to i64
  %629 = icmp ne i64 %627, 0
  %630 = icmp ne i64 %628, 0
  %631 = and i1 %629, %630
  %632 = zext i1 %631 to i64
  %633 = icmp ne i64 %632, 0
  br i1 %633, label %L116, label %L118
L116:
  %634 = load i32, ptr %591
  %635 = load i32, ptr %29
  %637 = sext i32 %634 to i64
  %638 = sext i32 %635 to i64
  %636 = icmp slt i64 %637, %638
  %639 = zext i1 %636 to i64
  %640 = load ptr, ptr %27
  %641 = load i32, ptr %591
  %642 = getelementptr ptr, ptr %640, i64 %641
  %643 = load ptr, ptr %642
  %645 = sext i32 %639 to i64
  %646 = sext i32 %643 to i64
  %647 = icmp ne i64 %645, 0
  %648 = icmp ne i64 %646, 0
  %649 = and i1 %647, %648
  %650 = zext i1 %649 to i64
  %651 = icmp ne i64 %650, 0
  br i1 %651, label %L119, label %L121
L119:
  %652 = load ptr, ptr %27
  %653 = load i32, ptr %591
  %654 = getelementptr ptr, ptr %652, i64 %653
  %655 = load ptr, ptr %654
  %656 = load ptr, ptr %27
  %657 = load i32, ptr %591
  %658 = getelementptr ptr, ptr %656, i64 %657
  %659 = load ptr, ptr %658
  %660 = call i32 @strlen(ptr %659)
  call void @buf_append(ptr %298, ptr %655, i32 %660)
  br label %L121
L121:
  store i32 1, ptr %541
  br label %L115
L122:
  br label %L118
L118:
  br label %L114
L114:
  %662 = load i32, ptr %591
  %664 = sext i32 %662 to i64
  %663 = add i64 %664, 1
  store i64 %663, ptr %591
  br label %L112
L115:
  br label %L111
L111:
  %665 = load i32, ptr %541
  %667 = icmp eq i64 %665, 0
  %666 = zext i1 %667 to i64
  %668 = icmp ne i64 %666, 0
  br i1 %668, label %L123, label %L125
L123:
  %669 = load ptr, ptr %534
  %670 = load ptr, ptr %534
  %671 = call i32 @strlen(ptr %670)
  call void @buf_append(ptr %298, ptr %669, i32 %671)
  br label %L125
L125:
  %673 = load ptr, ptr %536
  store ptr %673, ptr %295
  br label %L95
L94:
  %674 = load ptr, ptr %295
  %676 = sext i32 %674 to i64
  %675 = add i64 %676, 1
  store i64 %675, ptr %295
  %677 = load i8, ptr %674
  call void @buf_putc(ptr %298, i8 %677)
  br label %L95
L95:
  br label %L56
L58:
  %679 = load i64, ptr %298
  %681 = sext i32 %6 to i64
  %682 = sext i32 1 to i64
  %680 = add i64 %681, %682
  call void @expand_text(i32 %679, ptr %4, i32 %680)
  %684 = load i64, ptr %298
  %685 = call i32 @free(i32 %684)
  %686 = alloca i32
  store i32 0, ptr %686
  br label %L126
L126:
  %688 = load i32, ptr %686
  %689 = load i32, ptr %29
  %691 = sext i32 %688 to i64
  %692 = sext i32 %689 to i64
  %690 = icmp slt i64 %691, %692
  %693 = zext i1 %690 to i64
  %694 = icmp ne i64 %693, 0
  br i1 %694, label %L127, label %L129
L127:
  %695 = load ptr, ptr %27
  %696 = load i32, ptr %686
  %697 = getelementptr ptr, ptr %695, i64 %696
  %698 = load ptr, ptr %697
  %699 = call i32 @free(ptr %698)
  br label %L128
L128:
  %700 = load i32, ptr %686
  %702 = sext i32 %700 to i64
  %701 = add i64 %702, 1
  store i64 %701, ptr %686
  br label %L126
L129:
  ret void
}

define internal void @expand_text(ptr %0, ptr %2, i32 %4) {
entry:
  %7 = sext i32 %4 to i64
  %8 = sext i32 64 to i64
  %6 = icmp sgt i64 %7, %8
  %9 = zext i1 %6 to i64
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %L0, label %L2
L0:
  %11 = call i32 @strlen(ptr %0)
  call void @buf_append(ptr %2, ptr %0, i32 %11)
  ret void
L3:
  br label %L2
L2:
  %13 = alloca ptr
  store ptr %0, ptr %13
  br label %L4
L4:
  %15 = load ptr, ptr %13
  %16 = load i8, ptr %15
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %L5, label %L6
L5:
  %18 = load ptr, ptr %13
  %19 = load i8, ptr %18
  %21 = sext i32 %19 to i64
  %22 = sext i32 34 to i64
  %20 = icmp eq i64 %21, %22
  %23 = zext i1 %20 to i64
  %24 = icmp ne i64 %23, 0
  br i1 %24, label %L7, label %L9
L7:
  %25 = load ptr, ptr %13
  %27 = sext i32 %25 to i64
  %26 = add i64 %27, 1
  store i64 %26, ptr %13
  %28 = load i8, ptr %25
  call void @buf_putc(ptr %2, i8 %28)
  br label %L10
L10:
  %30 = load ptr, ptr %13
  %31 = load i8, ptr %30
  %32 = load ptr, ptr %13
  %33 = load i8, ptr %32
  %35 = sext i32 %33 to i64
  %36 = sext i32 34 to i64
  %34 = icmp ne i64 %35, %36
  %37 = zext i1 %34 to i64
  %39 = sext i32 %31 to i64
  %40 = sext i32 %37 to i64
  %41 = icmp ne i64 %39, 0
  %42 = icmp ne i64 %40, 0
  %43 = and i1 %41, %42
  %44 = zext i1 %43 to i64
  %45 = icmp ne i64 %44, 0
  br i1 %45, label %L11, label %L12
L11:
  %46 = load ptr, ptr %13
  %47 = load i8, ptr %46
  %49 = sext i32 %47 to i64
  %50 = sext i32 92 to i64
  %48 = icmp eq i64 %49, %50
  %51 = zext i1 %48 to i64
  %52 = icmp ne i64 %51, 0
  br i1 %52, label %L13, label %L15
L13:
  %53 = load ptr, ptr %13
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %13
  %56 = load i8, ptr %53
  call void @buf_putc(ptr %2, i8 %56)
  br label %L15
L15:
  %58 = load ptr, ptr %13
  %59 = load i8, ptr %58
  %60 = icmp ne i64 %59, 0
  br i1 %60, label %L16, label %L18
L16:
  %61 = load ptr, ptr %13
  %63 = sext i32 %61 to i64
  %62 = add i64 %63, 1
  store i64 %62, ptr %13
  %64 = load i8, ptr %61
  call void @buf_putc(ptr %2, i8 %64)
  br label %L18
L18:
  br label %L10
L12:
  %66 = load ptr, ptr %13
  %67 = load i8, ptr %66
  %68 = icmp ne i64 %67, 0
  br i1 %68, label %L19, label %L21
L19:
  %69 = load ptr, ptr %13
  %71 = sext i32 %69 to i64
  %70 = add i64 %71, 1
  store i64 %70, ptr %13
  %72 = load i8, ptr %69
  call void @buf_putc(ptr %2, i8 %72)
  br label %L21
L21:
  br label %L4
L22:
  br label %L9
L9:
  %74 = load ptr, ptr %13
  %75 = load i8, ptr %74
  %77 = sext i32 %75 to i64
  %78 = sext i32 39 to i64
  %76 = icmp eq i64 %77, %78
  %79 = zext i1 %76 to i64
  %80 = icmp ne i64 %79, 0
  br i1 %80, label %L23, label %L25
L23:
  %81 = load ptr, ptr %13
  %83 = sext i32 %81 to i64
  %82 = add i64 %83, 1
  store i64 %82, ptr %13
  %84 = load i8, ptr %81
  call void @buf_putc(ptr %2, i8 %84)
  br label %L26
L26:
  %86 = load ptr, ptr %13
  %87 = load i8, ptr %86
  %88 = load ptr, ptr %13
  %89 = load i8, ptr %88
  %91 = sext i32 %89 to i64
  %92 = sext i32 39 to i64
  %90 = icmp ne i64 %91, %92
  %93 = zext i1 %90 to i64
  %95 = sext i32 %87 to i64
  %96 = sext i32 %93 to i64
  %97 = icmp ne i64 %95, 0
  %98 = icmp ne i64 %96, 0
  %99 = and i1 %97, %98
  %100 = zext i1 %99 to i64
  %101 = icmp ne i64 %100, 0
  br i1 %101, label %L27, label %L28
L27:
  %102 = load ptr, ptr %13
  %103 = load i8, ptr %102
  %105 = sext i32 %103 to i64
  %106 = sext i32 92 to i64
  %104 = icmp eq i64 %105, %106
  %107 = zext i1 %104 to i64
  %108 = icmp ne i64 %107, 0
  br i1 %108, label %L29, label %L31
L29:
  %109 = load ptr, ptr %13
  %111 = sext i32 %109 to i64
  %110 = add i64 %111, 1
  store i64 %110, ptr %13
  %112 = load i8, ptr %109
  call void @buf_putc(ptr %2, i8 %112)
  br label %L31
L31:
  %114 = load ptr, ptr %13
  %115 = load i8, ptr %114
  %116 = icmp ne i64 %115, 0
  br i1 %116, label %L32, label %L34
L32:
  %117 = load ptr, ptr %13
  %119 = sext i32 %117 to i64
  %118 = add i64 %119, 1
  store i64 %118, ptr %13
  %120 = load i8, ptr %117
  call void @buf_putc(ptr %2, i8 %120)
  br label %L34
L34:
  br label %L26
L28:
  %122 = load ptr, ptr %13
  %123 = load i8, ptr %122
  %124 = icmp ne i64 %123, 0
  br i1 %124, label %L35, label %L37
L35:
  %125 = load ptr, ptr %13
  %127 = sext i32 %125 to i64
  %126 = add i64 %127, 1
  store i64 %126, ptr %13
  %128 = load i8, ptr %125
  call void @buf_putc(ptr %2, i8 %128)
  br label %L37
L37:
  br label %L4
L38:
  br label %L25
L25:
  %130 = load ptr, ptr %13
  %131 = load i8, ptr %130
  %132 = bitcast i8 %131 to i8
  %133 = call i32 @isalpha(i8 %132)
  %134 = load ptr, ptr %13
  %135 = load i8, ptr %134
  %137 = sext i32 %135 to i64
  %138 = sext i32 95 to i64
  %136 = icmp eq i64 %137, %138
  %139 = zext i1 %136 to i64
  %141 = sext i32 %133 to i64
  %142 = sext i32 %139 to i64
  %143 = icmp ne i64 %141, 0
  %144 = icmp ne i64 %142, 0
  %145 = or i1 %143, %144
  %146 = zext i1 %145 to i64
  %147 = icmp ne i64 %146, 0
  br i1 %147, label %L39, label %L41
L39:
  %148 = alloca ptr
  %150 = alloca ptr
  %152 = load ptr, ptr %13
  %153 = load ptr, ptr %148
  %154 = call ptr @read_ident(ptr %152, ptr %153, i32 8)
  store ptr %154, ptr %150
  %155 = alloca ptr
  %157 = load ptr, ptr %148
  %158 = call ptr @macro_find(ptr %157)
  store ptr %158, ptr %155
  %159 = load ptr, ptr %155
  %160 = load ptr, ptr %155
  %161 = load i64, ptr %160
  %163 = icmp ne i64 %159, 0
  %164 = icmp ne i64 %161, 0
  %165 = and i1 %163, %164
  %166 = zext i1 %165 to i64
  %167 = icmp ne i64 %166, 0
  br i1 %167, label %L42, label %L44
L42:
  %168 = alloca ptr
  %170 = load ptr, ptr %150
  store ptr %170, ptr %168
  %171 = load ptr, ptr %168
  %172 = call ptr @skip_ws(ptr %171)
  store ptr %172, ptr %168
  %173 = load ptr, ptr %168
  %174 = load i8, ptr %173
  %176 = sext i32 %174 to i64
  %177 = sext i32 40 to i64
  %175 = icmp eq i64 %176, %177
  %178 = zext i1 %175 to i64
  %179 = icmp ne i64 %178, 0
  br i1 %179, label %L45, label %L47
L45:
  %180 = load ptr, ptr %150
  store ptr %180, ptr %13
  %181 = load ptr, ptr %155
  %183 = sext i32 %4 to i64
  %184 = sext i32 1 to i64
  %182 = add i64 %183, %184
  call void @expand_func_macro(ptr %181, ptr %13, ptr %2, i32 %182)
  br label %L4
L48:
  br label %L47
L47:
  br label %L44
L44:
  %186 = load ptr, ptr %155
  %187 = load ptr, ptr %155
  %188 = load i64, ptr %187
  %190 = icmp eq i64 %188, 0
  %189 = zext i1 %190 to i64
  %192 = icmp ne i64 %186, 0
  %193 = icmp ne i64 %189, 0
  %194 = and i1 %192, %193
  %195 = zext i1 %194 to i64
  %196 = icmp ne i64 %195, 0
  br i1 %196, label %L49, label %L51
L49:
  %197 = load ptr, ptr %155
  %198 = load i64, ptr %197
  %200 = sext i32 %4 to i64
  %201 = sext i32 1 to i64
  %199 = add i64 %200, %201
  call void @expand_text(i32 %198, ptr %2, i32 %199)
  %203 = load ptr, ptr %150
  store ptr %203, ptr %13
  br label %L4
L52:
  br label %L51
L51:
  %204 = load ptr, ptr %148
  %205 = load ptr, ptr %148
  %206 = call i32 @strlen(ptr %205)
  call void @buf_append(ptr %2, ptr %204, i32 %206)
  %208 = load ptr, ptr %150
  store ptr %208, ptr %13
  br label %L4
L53:
  br label %L41
L41:
  %209 = load ptr, ptr %13
  %211 = sext i32 %209 to i64
  %210 = add i64 %211, 1
  store i64 %210, ptr %13
  %212 = load i8, ptr %209
  call void @buf_putc(ptr %2, i8 %212)
  br label %L4
L6:
  ret void
}

define internal ptr @read_file(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = getelementptr [2 x i8], ptr @.str4, i64 0, i64 0
  %5 = call i32 @fopen(ptr %0, ptr %4)
  store ptr %5, ptr %2
  %6 = load ptr, ptr %2
  %8 = icmp eq i64 %6, 0
  %7 = zext i1 %8 to i64
  %9 = icmp ne i64 %7, 0
  br i1 %9, label %L0, label %L2
L0:
  %10 = inttoptr i64 0 to ptr
  ret ptr %10
L3:
  br label %L2
L2:
  %11 = load ptr, ptr %2
  %12 = call i32 @fseek(ptr %11, i32 0, ptr @SEEK_END)
  %13 = alloca i64
  %15 = load ptr, ptr %2
  %16 = call i32 @ftell(ptr %15)
  store i64 %16, ptr %13
  %17 = load ptr, ptr %2
  %18 = call i32 @fseek(ptr %17, i32 0, ptr @SEEK_SET)
  %19 = alloca ptr
  %21 = load i64, ptr %13
  %23 = sext i32 %21 to i64
  %24 = sext i32 1 to i64
  %22 = add i64 %23, %24
  %25 = call i32 @malloc(i64 %22)
  store ptr %25, ptr %19
  %26 = load ptr, ptr %19
  %28 = icmp eq i64 %26, 0
  %27 = zext i1 %28 to i64
  %29 = icmp ne i64 %27, 0
  br i1 %29, label %L4, label %L6
L4:
  %30 = load ptr, ptr %2
  %31 = call i32 @fclose(ptr %30)
  %32 = inttoptr i64 0 to ptr
  ret ptr %32
L7:
  br label %L6
L6:
  %33 = alloca i64
  %35 = load ptr, ptr %19
  %36 = load i64, ptr %13
  %37 = load ptr, ptr %2
  %38 = call i32 @fread(ptr %35, i32 1, i64 %36, ptr %37)
  store ptr %38, ptr %33
  %39 = load ptr, ptr %19
  %40 = load i64, ptr %33
  %41 = getelementptr i8, ptr %39, i64 %40
  store i8 0, ptr %41
  %42 = load ptr, ptr %2
  %43 = call i32 @fclose(ptr %42)
  %44 = load ptr, ptr %19
  ret ptr %44
L8:
  ret ptr 0
}

define internal ptr @find_include(ptr %0, i32 %2) {
entry:
  %5 = icmp eq i64 %2, 0
  %4 = zext i1 %5 to i64
  %6 = icmp ne i64 %4, 0
  br i1 %6, label %L0, label %L2
L0:
  %7 = alloca ptr
  %9 = call ptr @read_file(ptr %0)
  store ptr %9, ptr %7
  %10 = load ptr, ptr %7
  %11 = icmp ne i64 %10, 0
  br i1 %11, label %L3, label %L5
L3:
  %12 = load ptr, ptr %7
  ret ptr %12
L6:
  br label %L5
L5:
  br label %L2
L2:
  %13 = alloca i32
  store i32 0, ptr %13
  br label %L7
L7:
  %15 = load ptr, ptr @INCLUDE_PATHS
  %16 = load i32, ptr %13
  %17 = getelementptr ptr, ptr %15, i64 %16
  %18 = load ptr, ptr %17
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L8, label %L10
L8:
  %20 = alloca ptr
  %22 = load ptr, ptr %20
  %23 = getelementptr [6 x i8], ptr @.str5, i64 0, i64 0
  %24 = load ptr, ptr @INCLUDE_PATHS
  %25 = load i32, ptr %13
  %26 = getelementptr ptr, ptr %24, i64 %25
  %27 = load ptr, ptr %26
  %28 = call i32 @snprintf(ptr %22, i32 8, ptr %23, ptr %27, ptr %0)
  %29 = alloca ptr
  %31 = load ptr, ptr %20
  %32 = call ptr @read_file(ptr %31)
  store ptr %32, ptr %29
  %33 = load ptr, ptr %29
  %34 = icmp ne i64 %33, 0
  br i1 %34, label %L11, label %L13
L11:
  %35 = load ptr, ptr %29
  ret ptr %35
L14:
  br label %L13
L13:
  br label %L9
L9:
  %36 = load i32, ptr %13
  %38 = sext i32 %36 to i64
  %37 = add i64 %38, 1
  store i64 %37, ptr %13
  br label %L7
L10:
  %39 = inttoptr i64 0 to ptr
  ret ptr %39
L15:
  ret ptr 0
}

define internal void @process_directive(ptr %0, ptr %2, ptr %4, i32 %6, ptr %8, ptr %10) {
entry:
  %12 = alloca ptr
  %14 = getelementptr i8, ptr %0, i64 1
  %15 = call ptr @skip_ws(ptr %14)
  store ptr %15, ptr %12
  %16 = alloca ptr
  %18 = load ptr, ptr %12
  %19 = load ptr, ptr %16
  %20 = call ptr @read_ident(ptr %18, ptr %19, i32 8)
  store ptr %20, ptr %12
  %21 = load ptr, ptr %12
  %22 = call ptr @skip_ws(ptr %21)
  store ptr %22, ptr %12
  %23 = load ptr, ptr %16
  %24 = getelementptr [6 x i8], ptr @.str6, i64 0, i64 0
  %25 = call i32 @strcmp(ptr %23, ptr %24)
  %27 = sext i32 %25 to i64
  %28 = sext i32 0 to i64
  %26 = icmp eq i64 %27, %28
  %29 = zext i1 %26 to i64
  %30 = icmp ne i64 %29, 0
  br i1 %30, label %L0, label %L2
L0:
  %31 = alloca ptr
  %33 = load ptr, ptr %12
  %34 = load ptr, ptr %31
  %35 = call ptr @read_ident(ptr %33, ptr %34, i32 8)
  %36 = alloca i32
  %38 = load ptr, ptr %31
  %39 = call ptr @macro_find(ptr %38)
  %40 = inttoptr i64 0 to ptr
  %41 = icmp ne ptr %39, %40
  %42 = zext i1 %41 to i64
  store i32 %42, ptr %36
  %43 = load i32, ptr %10
  %45 = sext i32 %43 to i64
  %46 = sext i32 32 to i64
  %44 = icmp slt i64 %45, %46
  %47 = zext i1 %44 to i64
  %48 = icmp ne i64 %47, 0
  br i1 %48, label %L3, label %L5
L3:
  %49 = load i32, ptr %36
  %50 = load i32, ptr %10
  %52 = sext i32 %50 to i64
  %51 = add i64 %52, 1
  store i64 %51, ptr %10
  %53 = getelementptr i8, ptr %8, i64 %50
  store i32 %49, ptr %53
  br label %L5
L5:
  ret void
L6:
  br label %L2
L2:
  %54 = load ptr, ptr %16
  %55 = getelementptr [7 x i8], ptr @.str7, i64 0, i64 0
  %56 = call i32 @strcmp(ptr %54, ptr %55)
  %58 = sext i32 %56 to i64
  %59 = sext i32 0 to i64
  %57 = icmp eq i64 %58, %59
  %60 = zext i1 %57 to i64
  %61 = icmp ne i64 %60, 0
  br i1 %61, label %L7, label %L9
L7:
  %62 = alloca ptr
  %64 = load ptr, ptr %12
  %65 = load ptr, ptr %62
  %66 = call ptr @read_ident(ptr %64, ptr %65, i32 8)
  %67 = alloca i32
  %69 = load ptr, ptr %62
  %70 = call ptr @macro_find(ptr %69)
  %71 = inttoptr i64 0 to ptr
  %72 = icmp eq ptr %70, %71
  %73 = zext i1 %72 to i64
  store i32 %73, ptr %67
  %74 = load i32, ptr %10
  %76 = sext i32 %74 to i64
  %77 = sext i32 32 to i64
  %75 = icmp slt i64 %76, %77
  %78 = zext i1 %75 to i64
  %79 = icmp ne i64 %78, 0
  br i1 %79, label %L10, label %L12
L10:
  %80 = load i32, ptr %67
  %81 = load i32, ptr %10
  %83 = sext i32 %81 to i64
  %82 = add i64 %83, 1
  store i64 %82, ptr %10
  %84 = getelementptr i8, ptr %8, i64 %81
  store i32 %80, ptr %84
  br label %L12
L12:
  ret void
L13:
  br label %L9
L9:
  %85 = load ptr, ptr %16
  %86 = getelementptr [3 x i8], ptr @.str8, i64 0, i64 0
  %87 = call i32 @strcmp(ptr %85, ptr %86)
  %89 = sext i32 %87 to i64
  %90 = sext i32 0 to i64
  %88 = icmp eq i64 %89, %90
  %91 = zext i1 %88 to i64
  %92 = icmp ne i64 %91, 0
  br i1 %92, label %L14, label %L16
L14:
  %93 = alloca i32
  store i32 0, ptr %93
  %95 = load ptr, ptr %12
  %96 = getelementptr [8 x i8], ptr @.str9, i64 0, i64 0
  %97 = call i32 @strncmp(ptr %95, ptr %96, i32 7)
  %99 = sext i32 %97 to i64
  %100 = sext i32 0 to i64
  %98 = icmp eq i64 %99, %100
  %101 = zext i1 %98 to i64
  %102 = icmp ne i64 %101, 0
  br i1 %102, label %L17, label %L18
L17:
  %103 = load ptr, ptr %12
  %105 = sext i32 %103 to i64
  %106 = sext i32 7 to i64
  %104 = add i64 %105, %106
  store i64 %104, ptr %12
  %107 = load ptr, ptr %12
  %108 = call ptr @skip_ws(ptr %107)
  store ptr %108, ptr %12
  %109 = load ptr, ptr %12
  %110 = load i8, ptr %109
  %112 = sext i32 %110 to i64
  %113 = sext i32 40 to i64
  %111 = icmp eq i64 %112, %113
  %114 = zext i1 %111 to i64
  %115 = icmp ne i64 %114, 0
  br i1 %115, label %L20, label %L22
L20:
  %116 = load ptr, ptr %12
  %118 = sext i32 %116 to i64
  %117 = add i64 %118, 1
  store i64 %117, ptr %12
  br label %L22
L22:
  %119 = load ptr, ptr %12
  %120 = call ptr @skip_ws(ptr %119)
  store ptr %120, ptr %12
  %121 = alloca ptr
  %123 = alloca ptr
  %125 = load ptr, ptr %12
  %126 = load ptr, ptr %121
  %127 = call ptr @read_ident(ptr %125, ptr %126, i32 8)
  store ptr %127, ptr %123
  %128 = load ptr, ptr %123
  %129 = ptrtoint ptr %128 to i64
  %130 = load ptr, ptr %121
  %131 = call ptr @macro_find(ptr %130)
  %132 = inttoptr i64 0 to ptr
  %133 = icmp ne ptr %131, %132
  %134 = zext i1 %133 to i64
  store i32 %134, ptr %93
  br label %L19
L18:
  %135 = load ptr, ptr %12
  %136 = call i32 @atoi(ptr %135)
  %138 = sext i32 %136 to i64
  %139 = sext i32 0 to i64
  %137 = icmp ne i64 %138, %139
  %140 = zext i1 %137 to i64
  store i32 %140, ptr %93
  br label %L19
L19:
  %141 = load i32, ptr %10
  %143 = sext i32 %141 to i64
  %144 = sext i32 32 to i64
  %142 = icmp slt i64 %143, %144
  %145 = zext i1 %142 to i64
  %146 = icmp ne i64 %145, 0
  br i1 %146, label %L23, label %L25
L23:
  %147 = load i32, ptr %93
  %148 = load i32, ptr %10
  %150 = sext i32 %148 to i64
  %149 = add i64 %150, 1
  store i64 %149, ptr %10
  %151 = getelementptr i8, ptr %8, i64 %148
  store i32 %147, ptr %151
  br label %L25
L25:
  ret void
L26:
  br label %L16
L16:
  %152 = load ptr, ptr %16
  %153 = getelementptr [5 x i8], ptr @.str10, i64 0, i64 0
  %154 = call i32 @strcmp(ptr %152, ptr %153)
  %156 = sext i32 %154 to i64
  %157 = sext i32 0 to i64
  %155 = icmp eq i64 %156, %157
  %158 = zext i1 %155 to i64
  %159 = icmp ne i64 %158, 0
  br i1 %159, label %L27, label %L29
L27:
  %160 = load i32, ptr %10
  %162 = sext i32 %160 to i64
  %163 = sext i32 0 to i64
  %161 = icmp sgt i64 %162, %163
  %164 = zext i1 %161 to i64
  %165 = icmp ne i64 %164, 0
  br i1 %165, label %L30, label %L32
L30:
  %166 = alloca i32
  %168 = load ptr, ptr %12
  %169 = call i32 @atoi(ptr %168)
  %171 = sext i32 %169 to i64
  %172 = sext i32 0 to i64
  %170 = icmp ne i64 %171, %172
  %173 = zext i1 %170 to i64
  store i32 %173, ptr %166
  %174 = load i32, ptr %166
  %175 = load i32, ptr %10
  %177 = sext i32 %175 to i64
  %178 = sext i32 1 to i64
  %176 = sub i64 %177, %178
  %179 = getelementptr i8, ptr %8, i64 %176
  store i32 %174, ptr %179
  br label %L32
L32:
  ret void
L33:
  br label %L29
L29:
  %180 = load ptr, ptr %16
  %181 = getelementptr [5 x i8], ptr @.str11, i64 0, i64 0
  %182 = call i32 @strcmp(ptr %180, ptr %181)
  %184 = sext i32 %182 to i64
  %185 = sext i32 0 to i64
  %183 = icmp eq i64 %184, %185
  %186 = zext i1 %183 to i64
  %187 = icmp ne i64 %186, 0
  br i1 %187, label %L34, label %L36
L34:
  %188 = load i32, ptr %10
  %190 = sext i32 %188 to i64
  %191 = sext i32 0 to i64
  %189 = icmp sgt i64 %190, %191
  %192 = zext i1 %189 to i64
  %193 = icmp ne i64 %192, 0
  br i1 %193, label %L37, label %L39
L37:
  %194 = load i32, ptr %10
  %196 = sext i32 %194 to i64
  %197 = sext i32 1 to i64
  %195 = sub i64 %196, %197
  %198 = getelementptr i32, ptr %8, i64 %195
  %199 = load i32, ptr %198
  %201 = sext i32 %199 to i64
  %202 = sext i32 1 to i64
  %200 = xor i64 %201, %202
  %203 = load i32, ptr %10
  %205 = sext i32 %203 to i64
  %206 = sext i32 1 to i64
  %204 = sub i64 %205, %206
  %207 = getelementptr i8, ptr %8, i64 %204
  store i64 %200, ptr %207
  br label %L39
L39:
  ret void
L40:
  br label %L36
L36:
  %208 = load ptr, ptr %16
  %209 = getelementptr [6 x i8], ptr @.str12, i64 0, i64 0
  %210 = call i32 @strcmp(ptr %208, ptr %209)
  %212 = sext i32 %210 to i64
  %213 = sext i32 0 to i64
  %211 = icmp eq i64 %212, %213
  %214 = zext i1 %211 to i64
  %215 = icmp ne i64 %214, 0
  br i1 %215, label %L41, label %L43
L41:
  %216 = load i32, ptr %10
  %218 = sext i32 %216 to i64
  %219 = sext i32 0 to i64
  %217 = icmp sgt i64 %218, %219
  %220 = zext i1 %217 to i64
  %221 = icmp ne i64 %220, 0
  br i1 %221, label %L44, label %L46
L44:
  %222 = load i32, ptr %10
  %224 = sext i32 %222 to i64
  %223 = sub i64 %224, 1
  store i64 %223, ptr %10
  br label %L46
L46:
  ret void
L47:
  br label %L43
L43:
  %225 = alloca i32
  store i32 1, ptr %225
  %227 = alloca i32
  store i32 0, ptr %227
  br label %L48
L48:
  %229 = load i32, ptr %227
  %230 = load i32, ptr %10
  %232 = sext i32 %229 to i64
  %233 = sext i32 %230 to i64
  %231 = icmp slt i64 %232, %233
  %234 = zext i1 %231 to i64
  %235 = icmp ne i64 %234, 0
  br i1 %235, label %L49, label %L51
L49:
  %236 = load i32, ptr %227
  %237 = getelementptr i32, ptr %8, i64 %236
  %238 = load i32, ptr %237
  %240 = icmp eq i64 %238, 0
  %239 = zext i1 %240 to i64
  %241 = icmp ne i64 %239, 0
  br i1 %241, label %L52, label %L54
L52:
  store i32 0, ptr %225
  br label %L51
L55:
  br label %L54
L54:
  br label %L50
L50:
  %242 = load i32, ptr %227
  %244 = sext i32 %242 to i64
  %243 = add i64 %244, 1
  store i64 %243, ptr %227
  br label %L48
L51:
  %245 = load i32, ptr %225
  %247 = icmp eq i64 %245, 0
  %246 = zext i1 %247 to i64
  %248 = icmp ne i64 %246, 0
  br i1 %248, label %L56, label %L58
L56:
  ret void
L59:
  br label %L58
L58:
  %249 = load ptr, ptr %16
  %250 = getelementptr [7 x i8], ptr @.str13, i64 0, i64 0
  %251 = call i32 @strcmp(ptr %249, ptr %250)
  %253 = sext i32 %251 to i64
  %254 = sext i32 0 to i64
  %252 = icmp eq i64 %253, %254
  %255 = zext i1 %252 to i64
  %256 = icmp ne i64 %255, 0
  br i1 %256, label %L60, label %L62
L60:
  %257 = alloca ptr
  %259 = load ptr, ptr %12
  %260 = load ptr, ptr %257
  %261 = call ptr @read_ident(ptr %259, ptr %260, i32 8)
  store ptr %261, ptr %12
  %262 = load ptr, ptr %12
  %263 = load i8, ptr %262
  %265 = sext i32 %263 to i64
  %266 = sext i32 40 to i64
  %264 = icmp eq i64 %265, %266
  %267 = zext i1 %264 to i64
  %268 = icmp ne i64 %267, 0
  br i1 %268, label %L63, label %L64
L63:
  %269 = load ptr, ptr %12
  %271 = sext i32 %269 to i64
  %270 = add i64 %271, 1
  store i64 %270, ptr %12
  %272 = alloca ptr
  store ptr 0, ptr %272
  %274 = alloca i32
  store i32 0, ptr %274
  %276 = alloca i32
  store i32 0, ptr %276
  br label %L66
L66:
  %278 = load ptr, ptr %12
  %279 = load i8, ptr %278
  %280 = load ptr, ptr %12
  %281 = load i8, ptr %280
  %283 = sext i32 %281 to i64
  %284 = sext i32 41 to i64
  %282 = icmp ne i64 %283, %284
  %285 = zext i1 %282 to i64
  %287 = sext i32 %279 to i64
  %288 = sext i32 %285 to i64
  %289 = icmp ne i64 %287, 0
  %290 = icmp ne i64 %288, 0
  %291 = and i1 %289, %290
  %292 = zext i1 %291 to i64
  %293 = icmp ne i64 %292, 0
  br i1 %293, label %L67, label %L68
L67:
  %294 = load ptr, ptr %12
  %295 = call ptr @skip_ws(ptr %294)
  store ptr %295, ptr %12
  %296 = load ptr, ptr %12
  %297 = load i8, ptr %296
  %299 = sext i32 %297 to i64
  %300 = sext i32 41 to i64
  %298 = icmp eq i64 %299, %300
  %301 = zext i1 %298 to i64
  %302 = icmp ne i64 %301, 0
  br i1 %302, label %L69, label %L71
L69:
  br label %L68
L72:
  br label %L71
L71:
  %303 = load ptr, ptr %12
  %304 = load i8, ptr %303
  %306 = sext i32 %304 to i64
  %307 = sext i32 46 to i64
  %305 = icmp eq i64 %306, %307
  %308 = zext i1 %305 to i64
  %309 = load ptr, ptr %12
  %310 = getelementptr i8, ptr %309, i64 1
  %311 = load i8, ptr %310
  %313 = sext i32 %311 to i64
  %314 = sext i32 46 to i64
  %312 = icmp eq i64 %313, %314
  %315 = zext i1 %312 to i64
  %317 = sext i32 %308 to i64
  %318 = sext i32 %315 to i64
  %319 = icmp ne i64 %317, 0
  %320 = icmp ne i64 %318, 0
  %321 = and i1 %319, %320
  %322 = zext i1 %321 to i64
  %323 = load ptr, ptr %12
  %324 = getelementptr i8, ptr %323, i64 2
  %325 = load i8, ptr %324
  %327 = sext i32 %325 to i64
  %328 = sext i32 46 to i64
  %326 = icmp eq i64 %327, %328
  %329 = zext i1 %326 to i64
  %331 = sext i32 %322 to i64
  %332 = sext i32 %329 to i64
  %333 = icmp ne i64 %331, 0
  %334 = icmp ne i64 %332, 0
  %335 = and i1 %333, %334
  %336 = zext i1 %335 to i64
  %337 = icmp ne i64 %336, 0
  br i1 %337, label %L73, label %L75
L73:
  store i32 1, ptr %276
  %338 = load ptr, ptr %12
  %340 = sext i32 %338 to i64
  %341 = sext i32 3 to i64
  %339 = add i64 %340, %341
  store i64 %339, ptr %12
  %342 = load ptr, ptr %12
  %343 = call ptr @skip_ws(ptr %342)
  store ptr %343, ptr %12
  br label %L68
L76:
  br label %L75
L75:
  %344 = alloca ptr
  %346 = load ptr, ptr %12
  %347 = load ptr, ptr %344
  %348 = call ptr @read_ident(ptr %346, ptr %347, i32 8)
  store ptr %348, ptr %12
  %349 = load ptr, ptr %344
  %350 = load i8, ptr %349
  %351 = load i32, ptr %274
  %353 = sext i32 %351 to i64
  %354 = sext i32 16 to i64
  %352 = icmp slt i64 %353, %354
  %355 = zext i1 %352 to i64
  %357 = sext i32 %350 to i64
  %358 = sext i32 %355 to i64
  %359 = icmp ne i64 %357, 0
  %360 = icmp ne i64 %358, 0
  %361 = and i1 %359, %360
  %362 = zext i1 %361 to i64
  %363 = icmp ne i64 %362, 0
  br i1 %363, label %L77, label %L79
L77:
  %364 = load ptr, ptr %344
  %365 = call i32 @strdup(ptr %364)
  %366 = load ptr, ptr %272
  %367 = load i32, ptr %274
  %369 = sext i32 %367 to i64
  %368 = add i64 %369, 1
  store i64 %368, ptr %274
  %370 = getelementptr i8, ptr %366, i64 %367
  store i32 %365, ptr %370
  br label %L79
L79:
  %371 = load ptr, ptr %12
  %372 = call ptr @skip_ws(ptr %371)
  store ptr %372, ptr %12
  %373 = load ptr, ptr %12
  %374 = load i8, ptr %373
  %376 = sext i32 %374 to i64
  %377 = sext i32 44 to i64
  %375 = icmp eq i64 %376, %377
  %378 = zext i1 %375 to i64
  %379 = icmp ne i64 %378, 0
  br i1 %379, label %L80, label %L82
L80:
  %380 = load ptr, ptr %12
  %382 = sext i32 %380 to i64
  %381 = add i64 %382, 1
  store i64 %381, ptr %12
  br label %L82
L82:
  br label %L66
L68:
  %383 = load i32, ptr %276
  %384 = trunc i32 %383 to void
  %385 = load ptr, ptr %12
  %386 = load i8, ptr %385
  %388 = sext i32 %386 to i64
  %389 = sext i32 41 to i64
  %387 = icmp eq i64 %388, %389
  %390 = zext i1 %387 to i64
  %391 = icmp ne i64 %390, 0
  br i1 %391, label %L83, label %L85
L83:
  %392 = load ptr, ptr %12
  %394 = sext i32 %392 to i64
  %393 = add i64 %394, 1
  store i64 %393, ptr %12
  br label %L85
L85:
  %395 = load ptr, ptr %12
  %396 = call ptr @skip_ws(ptr %395)
  store ptr %396, ptr %12
  %397 = alloca ptr
  %399 = load ptr, ptr %12
  store ptr %399, ptr %397
  %400 = alloca ptr
  %402 = load ptr, ptr %12
  %403 = call ptr @skip_to_eol(ptr %402)
  store ptr %403, ptr %400
  %404 = alloca ptr
  %406 = load ptr, ptr %400
  %407 = load ptr, ptr %397
  %408 = sub ptr %406, %407
  %409 = getelementptr i8, ptr %408, i64 1
  %410 = call i32 @malloc(ptr %409)
  store ptr %410, ptr %404
  %411 = load ptr, ptr %404
  %412 = load ptr, ptr %397
  %413 = load ptr, ptr %400
  %414 = load ptr, ptr %397
  %415 = sub ptr %413, %414
  %416 = call i32 @memcpy(ptr %411, ptr %412, ptr %415)
  %417 = load ptr, ptr %404
  %418 = load ptr, ptr %400
  %419 = load ptr, ptr %397
  %420 = sub ptr %418, %419
  %421 = getelementptr i8, ptr %417, i64 %420
  store i8 0, ptr %421
  %422 = load ptr, ptr %257
  %423 = load ptr, ptr %404
  %424 = load ptr, ptr %272
  %425 = load i32, ptr %274
  call void @macro_define(ptr %422, ptr %423, ptr %424, i32 %425, i32 1)
  %427 = load ptr, ptr %404
  %428 = call i32 @free(ptr %427)
  %429 = alloca i32
  store i32 0, ptr %429
  br label %L86
L86:
  %431 = load i32, ptr %429
  %432 = load i32, ptr %274
  %434 = sext i32 %431 to i64
  %435 = sext i32 %432 to i64
  %433 = icmp slt i64 %434, %435
  %436 = zext i1 %433 to i64
  %437 = icmp ne i64 %436, 0
  br i1 %437, label %L87, label %L89
L87:
  %438 = load ptr, ptr %272
  %439 = load i32, ptr %429
  %440 = getelementptr ptr, ptr %438, i64 %439
  %441 = load ptr, ptr %440
  %442 = call i32 @free(ptr %441)
  br label %L88
L88:
  %443 = load i32, ptr %429
  %445 = sext i32 %443 to i64
  %444 = add i64 %445, 1
  store i64 %444, ptr %429
  br label %L86
L89:
  br label %L65
L64:
  %446 = load ptr, ptr %12
  %447 = load i8, ptr %446
  %449 = sext i32 %447 to i64
  %450 = sext i32 32 to i64
  %448 = icmp eq i64 %449, %450
  %451 = zext i1 %448 to i64
  %452 = load ptr, ptr %12
  %453 = load i8, ptr %452
  %455 = sext i32 %453 to i64
  %456 = sext i32 9 to i64
  %454 = icmp eq i64 %455, %456
  %457 = zext i1 %454 to i64
  %459 = sext i32 %451 to i64
  %460 = sext i32 %457 to i64
  %461 = icmp ne i64 %459, 0
  %462 = icmp ne i64 %460, 0
  %463 = or i1 %461, %462
  %464 = zext i1 %463 to i64
  %465 = icmp ne i64 %464, 0
  br i1 %465, label %L90, label %L92
L90:
  %466 = load ptr, ptr %12
  %468 = sext i32 %466 to i64
  %467 = add i64 %468, 1
  store i64 %467, ptr %12
  br label %L92
L92:
  %469 = alloca ptr
  %471 = load ptr, ptr %12
  store ptr %471, ptr %469
  %472 = alloca ptr
  %474 = load ptr, ptr %12
  %475 = call ptr @skip_to_eol(ptr %474)
  store ptr %475, ptr %472
  %476 = alloca ptr
  %478 = load ptr, ptr %472
  %479 = load ptr, ptr %469
  %480 = sub ptr %478, %479
  %481 = getelementptr i8, ptr %480, i64 1
  %482 = call i32 @malloc(ptr %481)
  store ptr %482, ptr %476
  %483 = load ptr, ptr %476
  %484 = load ptr, ptr %469
  %485 = load ptr, ptr %472
  %486 = load ptr, ptr %469
  %487 = sub ptr %485, %486
  %488 = call i32 @memcpy(ptr %483, ptr %484, ptr %487)
  %489 = load ptr, ptr %476
  %490 = load ptr, ptr %472
  %491 = load ptr, ptr %469
  %492 = sub ptr %490, %491
  %493 = getelementptr i8, ptr %489, i64 %492
  store i8 0, ptr %493
  %494 = load ptr, ptr %257
  %495 = load ptr, ptr %476
  %496 = inttoptr i64 0 to ptr
  call void @macro_define(ptr %494, ptr %495, ptr %496, i32 0, i32 0)
  %498 = load ptr, ptr %476
  %499 = call i32 @free(ptr %498)
  br label %L65
L65:
  ret void
L93:
  br label %L62
L62:
  %500 = load ptr, ptr %16
  %501 = getelementptr [6 x i8], ptr @.str14, i64 0, i64 0
  %502 = call i32 @strcmp(ptr %500, ptr %501)
  %504 = sext i32 %502 to i64
  %505 = sext i32 0 to i64
  %503 = icmp eq i64 %504, %505
  %506 = zext i1 %503 to i64
  %507 = icmp ne i64 %506, 0
  br i1 %507, label %L94, label %L96
L94:
  %508 = alloca ptr
  %510 = load ptr, ptr %12
  %511 = load ptr, ptr %508
  %512 = call ptr @read_ident(ptr %510, ptr %511, i32 8)
  %513 = load ptr, ptr %508
  call void @macro_undef(ptr %513)
  ret void
L97:
  br label %L96
L96:
  %515 = load ptr, ptr %16
  %516 = getelementptr [8 x i8], ptr @.str15, i64 0, i64 0
  %517 = call i32 @strcmp(ptr %515, ptr %516)
  %519 = sext i32 %517 to i64
  %520 = sext i32 0 to i64
  %518 = icmp eq i64 %519, %520
  %521 = zext i1 %518 to i64
  %522 = icmp ne i64 %521, 0
  br i1 %522, label %L98, label %L100
L98:
  %524 = sext i32 %6 to i64
  %525 = sext i32 32 to i64
  %523 = icmp sgt i64 %524, %525
  %526 = zext i1 %523 to i64
  %527 = icmp ne i64 %526, 0
  br i1 %527, label %L101, label %L103
L101:
  %528 = getelementptr [36 x i8], ptr @.str16, i64 0, i64 0
  %529 = call i32 @fprintf(ptr @stderr, ptr %528)
  ret void
L104:
  br label %L103
L103:
  %530 = alloca i32
  store i32 0, ptr %530
  %532 = alloca ptr
  %534 = load ptr, ptr %12
  %535 = load i8, ptr %534
  %537 = sext i32 %535 to i64
  %538 = sext i32 34 to i64
  %536 = icmp eq i64 %537, %538
  %539 = zext i1 %536 to i64
  %540 = icmp ne i64 %539, 0
  br i1 %540, label %L105, label %L106
L105:
  %541 = load ptr, ptr %12
  %543 = sext i32 %541 to i64
  %542 = add i64 %543, 1
  store i64 %542, ptr %12
  %544 = alloca ptr
  %546 = load ptr, ptr %12
  %547 = call i32 @strchr(ptr %546, i8 34)
  store ptr %547, ptr %544
  %548 = load ptr, ptr %544
  %550 = icmp eq i64 %548, 0
  %549 = zext i1 %550 to i64
  %551 = icmp ne i64 %549, 0
  br i1 %551, label %L108, label %L110
L108:
  ret void
L111:
  br label %L110
L110:
  %552 = alloca i64
  %554 = load ptr, ptr %544
  %555 = load ptr, ptr %12
  %556 = sub ptr %554, %555
  %557 = ptrtoint ptr %556 to i64
  store i64 %557, ptr %552
  %558 = load ptr, ptr %532
  %559 = load ptr, ptr %12
  %560 = load i64, ptr %552
  %561 = call i32 @memcpy(ptr %558, ptr %559, i64 %560)
  %562 = load ptr, ptr %532
  %563 = load i64, ptr %552
  %564 = getelementptr i8, ptr %562, i64 %563
  store i8 0, ptr %564
  br label %L107
L106:
  %565 = load ptr, ptr %12
  %566 = load i8, ptr %565
  %568 = sext i32 %566 to i64
  %569 = sext i32 60 to i64
  %567 = icmp eq i64 %568, %569
  %570 = zext i1 %567 to i64
  %571 = icmp ne i64 %570, 0
  br i1 %571, label %L112, label %L113
L112:
  %572 = load ptr, ptr %12
  %574 = sext i32 %572 to i64
  %573 = add i64 %574, 1
  store i64 %573, ptr %12
  %575 = alloca ptr
  %577 = load ptr, ptr %12
  %578 = call i32 @strchr(ptr %577, i8 62)
  store ptr %578, ptr %575
  %579 = load ptr, ptr %575
  %581 = icmp eq i64 %579, 0
  %580 = zext i1 %581 to i64
  %582 = icmp ne i64 %580, 0
  br i1 %582, label %L115, label %L117
L115:
  ret void
L118:
  br label %L117
L117:
  %583 = alloca i64
  %585 = load ptr, ptr %575
  %586 = load ptr, ptr %12
  %587 = sub ptr %585, %586
  %588 = ptrtoint ptr %587 to i64
  store i64 %588, ptr %583
  %589 = load ptr, ptr %532
  %590 = load ptr, ptr %12
  %591 = load i64, ptr %583
  %592 = call i32 @memcpy(ptr %589, ptr %590, i64 %591)
  %593 = load ptr, ptr %532
  %594 = load i64, ptr %583
  %595 = getelementptr i8, ptr %593, i64 %594
  store i8 0, ptr %595
  store i32 1, ptr %530
  br label %L114
L113:
  ret void
L119:
  br label %L114
L114:
  br label %L107
L107:
  %596 = alloca ptr
  %598 = load ptr, ptr %532
  %599 = load i32, ptr %530
  %600 = call ptr @find_include(ptr %598, i32 %599)
  store ptr %600, ptr %596
  %601 = load ptr, ptr %596
  %603 = icmp eq i64 %601, 0
  %602 = zext i1 %603 to i64
  %604 = icmp ne i64 %602, 0
  br i1 %604, label %L120, label %L122
L120:
  %605 = getelementptr [2 x i8], ptr @.str17, i64 0, i64 0
  call void @buf_append(ptr %4, ptr %605, i32 1)
  ret void
L123:
  br label %L122
L122:
  %607 = load i32, ptr %530
  %608 = icmp ne i64 %607, 0
  br i1 %608, label %L124, label %L126
L124:
  %609 = load ptr, ptr %596
  %610 = call i32 @free(ptr %609)
  %611 = getelementptr [2 x i8], ptr @.str18, i64 0, i64 0
  call void @buf_append(ptr %4, ptr %611, i32 1)
  ret void
L127:
  br label %L126
L126:
  %613 = alloca ptr
  %615 = load ptr, ptr %596
  %616 = load ptr, ptr %532
  %618 = sext i32 %6 to i64
  %619 = sext i32 1 to i64
  %617 = add i64 %618, %619
  %620 = call ptr @macro_preprocess(ptr %615, ptr %616, i32 %617)
  store ptr %620, ptr %613
  %621 = load ptr, ptr %596
  %622 = call i32 @free(ptr %621)
  %623 = load ptr, ptr %613
  %624 = load ptr, ptr %613
  %625 = call i32 @strlen(ptr %624)
  call void @buf_append(ptr %4, ptr %623, i32 %625)
  call void @buf_putc(ptr %4, i8 10)
  %628 = load ptr, ptr %613
  %629 = call i32 @free(ptr %628)
  ret void
L128:
  br label %L100
L100:
  ret void
}

define internal void @preprocess_into(ptr %0, ptr %2, ptr %4, i32 %6, ptr %8, ptr %10) {
entry:
  %12 = alloca ptr
  store ptr %0, ptr %12
  br label %L0
L0:
  %14 = load ptr, ptr %12
  %15 = load i8, ptr %14
  %16 = icmp ne i64 %15, 0
  br i1 %16, label %L1, label %L2
L1:
  %17 = load ptr, ptr %12
  %18 = load i8, ptr %17
  %20 = sext i32 %18 to i64
  %21 = sext i32 92 to i64
  %19 = icmp eq i64 %20, %21
  %22 = zext i1 %19 to i64
  %23 = load ptr, ptr %12
  %24 = getelementptr i8, ptr %23, i64 1
  %25 = load i8, ptr %24
  %27 = sext i32 %25 to i64
  %28 = sext i32 10 to i64
  %26 = icmp eq i64 %27, %28
  %29 = zext i1 %26 to i64
  %31 = sext i32 %22 to i64
  %32 = sext i32 %29 to i64
  %33 = icmp ne i64 %31, 0
  %34 = icmp ne i64 %32, 0
  %35 = and i1 %33, %34
  %36 = zext i1 %35 to i64
  %37 = icmp ne i64 %36, 0
  br i1 %37, label %L3, label %L5
L3:
  %38 = load ptr, ptr %12
  %40 = sext i32 %38 to i64
  %41 = sext i32 2 to i64
  %39 = add i64 %40, %41
  store i64 %39, ptr %12
  br label %L0
L6:
  br label %L5
L5:
  %42 = alloca i64
  call void @buf_init(ptr %42)
  br label %L7
L7:
  %45 = load ptr, ptr %12
  %46 = load i8, ptr %45
  %47 = load ptr, ptr %12
  %48 = load i8, ptr %47
  %50 = sext i32 %48 to i64
  %51 = sext i32 10 to i64
  %49 = icmp ne i64 %50, %51
  %52 = zext i1 %49 to i64
  %54 = sext i32 %46 to i64
  %55 = sext i32 %52 to i64
  %56 = icmp ne i64 %54, 0
  %57 = icmp ne i64 %55, 0
  %58 = and i1 %56, %57
  %59 = zext i1 %58 to i64
  %60 = icmp ne i64 %59, 0
  br i1 %60, label %L8, label %L9
L8:
  %61 = load ptr, ptr %12
  %62 = load i8, ptr %61
  %64 = sext i32 %62 to i64
  %65 = sext i32 92 to i64
  %63 = icmp eq i64 %64, %65
  %66 = zext i1 %63 to i64
  %67 = load ptr, ptr %12
  %68 = getelementptr i8, ptr %67, i64 1
  %69 = load i8, ptr %68
  %71 = sext i32 %69 to i64
  %72 = sext i32 10 to i64
  %70 = icmp eq i64 %71, %72
  %73 = zext i1 %70 to i64
  %75 = sext i32 %66 to i64
  %76 = sext i32 %73 to i64
  %77 = icmp ne i64 %75, 0
  %78 = icmp ne i64 %76, 0
  %79 = and i1 %77, %78
  %80 = zext i1 %79 to i64
  %81 = icmp ne i64 %80, 0
  br i1 %81, label %L10, label %L12
L10:
  %82 = load ptr, ptr %12
  %84 = sext i32 %82 to i64
  %85 = sext i32 2 to i64
  %83 = add i64 %84, %85
  store i64 %83, ptr %12
  br label %L7
L13:
  br label %L12
L12:
  %86 = load ptr, ptr %12
  %87 = load i8, ptr %86
  %89 = sext i32 %87 to i64
  %90 = sext i32 39 to i64
  %88 = icmp eq i64 %89, %90
  %91 = zext i1 %88 to i64
  %92 = icmp ne i64 %91, 0
  br i1 %92, label %L14, label %L16
L14:
  %93 = load ptr, ptr %12
  %95 = sext i32 %93 to i64
  %94 = add i64 %95, 1
  store i64 %94, ptr %12
  %96 = load i8, ptr %93
  call void @buf_putc(ptr %42, i8 %96)
  %98 = load ptr, ptr %12
  %99 = load i8, ptr %98
  %101 = sext i32 %99 to i64
  %102 = sext i32 92 to i64
  %100 = icmp eq i64 %101, %102
  %103 = zext i1 %100 to i64
  %104 = load ptr, ptr %12
  %105 = getelementptr i8, ptr %104, i64 1
  %106 = load i8, ptr %105
  %108 = sext i32 %103 to i64
  %109 = sext i32 %106 to i64
  %110 = icmp ne i64 %108, 0
  %111 = icmp ne i64 %109, 0
  %112 = and i1 %110, %111
  %113 = zext i1 %112 to i64
  %114 = load ptr, ptr %12
  %115 = getelementptr i8, ptr %114, i64 1
  %116 = load i8, ptr %115
  %118 = sext i32 %116 to i64
  %119 = sext i32 10 to i64
  %117 = icmp ne i64 %118, %119
  %120 = zext i1 %117 to i64
  %122 = sext i32 %113 to i64
  %123 = sext i32 %120 to i64
  %124 = icmp ne i64 %122, 0
  %125 = icmp ne i64 %123, 0
  %126 = and i1 %124, %125
  %127 = zext i1 %126 to i64
  %128 = icmp ne i64 %127, 0
  br i1 %128, label %L17, label %L19
L17:
  %129 = load ptr, ptr %12
  %131 = sext i32 %129 to i64
  %130 = add i64 %131, 1
  store i64 %130, ptr %12
  %132 = load i8, ptr %129
  call void @buf_putc(ptr %42, i8 %132)
  br label %L19
L19:
  %134 = load ptr, ptr %12
  %135 = load i8, ptr %134
  %136 = load ptr, ptr %12
  %137 = load i8, ptr %136
  %139 = sext i32 %137 to i64
  %140 = sext i32 10 to i64
  %138 = icmp ne i64 %139, %140
  %141 = zext i1 %138 to i64
  %143 = sext i32 %135 to i64
  %144 = sext i32 %141 to i64
  %145 = icmp ne i64 %143, 0
  %146 = icmp ne i64 %144, 0
  %147 = and i1 %145, %146
  %148 = zext i1 %147 to i64
  %149 = icmp ne i64 %148, 0
  br i1 %149, label %L20, label %L22
L20:
  %150 = load ptr, ptr %12
  %152 = sext i32 %150 to i64
  %151 = add i64 %152, 1
  store i64 %151, ptr %12
  %153 = load i8, ptr %150
  call void @buf_putc(ptr %42, i8 %153)
  br label %L22
L22:
  %155 = load ptr, ptr %12
  %156 = load i8, ptr %155
  %158 = sext i32 %156 to i64
  %159 = sext i32 39 to i64
  %157 = icmp eq i64 %158, %159
  %160 = zext i1 %157 to i64
  %161 = icmp ne i64 %160, 0
  br i1 %161, label %L23, label %L25
L23:
  %162 = load ptr, ptr %12
  %164 = sext i32 %162 to i64
  %163 = add i64 %164, 1
  store i64 %163, ptr %12
  %165 = load i8, ptr %162
  call void @buf_putc(ptr %42, i8 %165)
  br label %L25
L25:
  br label %L7
L26:
  br label %L16
L16:
  %167 = load ptr, ptr %12
  %168 = load i8, ptr %167
  %170 = sext i32 %168 to i64
  %171 = sext i32 34 to i64
  %169 = icmp eq i64 %170, %171
  %172 = zext i1 %169 to i64
  %173 = icmp ne i64 %172, 0
  br i1 %173, label %L27, label %L29
L27:
  %174 = load ptr, ptr %12
  %176 = sext i32 %174 to i64
  %175 = add i64 %176, 1
  store i64 %175, ptr %12
  %177 = load i8, ptr %174
  call void @buf_putc(ptr %42, i8 %177)
  br label %L30
L30:
  %179 = load ptr, ptr %12
  %180 = load i8, ptr %179
  %181 = load ptr, ptr %12
  %182 = load i8, ptr %181
  %184 = sext i32 %182 to i64
  %185 = sext i32 34 to i64
  %183 = icmp ne i64 %184, %185
  %186 = zext i1 %183 to i64
  %188 = sext i32 %180 to i64
  %189 = sext i32 %186 to i64
  %190 = icmp ne i64 %188, 0
  %191 = icmp ne i64 %189, 0
  %192 = and i1 %190, %191
  %193 = zext i1 %192 to i64
  %194 = load ptr, ptr %12
  %195 = load i8, ptr %194
  %197 = sext i32 %195 to i64
  %198 = sext i32 10 to i64
  %196 = icmp ne i64 %197, %198
  %199 = zext i1 %196 to i64
  %201 = sext i32 %193 to i64
  %202 = sext i32 %199 to i64
  %203 = icmp ne i64 %201, 0
  %204 = icmp ne i64 %202, 0
  %205 = and i1 %203, %204
  %206 = zext i1 %205 to i64
  %207 = icmp ne i64 %206, 0
  br i1 %207, label %L31, label %L32
L31:
  %208 = load ptr, ptr %12
  %209 = load i8, ptr %208
  %211 = sext i32 %209 to i64
  %212 = sext i32 92 to i64
  %210 = icmp eq i64 %211, %212
  %213 = zext i1 %210 to i64
  %214 = load ptr, ptr %12
  %215 = getelementptr i8, ptr %214, i64 1
  %216 = load i8, ptr %215
  %218 = sext i32 %213 to i64
  %219 = sext i32 %216 to i64
  %220 = icmp ne i64 %218, 0
  %221 = icmp ne i64 %219, 0
  %222 = and i1 %220, %221
  %223 = zext i1 %222 to i64
  %224 = icmp ne i64 %223, 0
  br i1 %224, label %L33, label %L35
L33:
  %225 = load ptr, ptr %12
  %227 = sext i32 %225 to i64
  %226 = add i64 %227, 1
  store i64 %226, ptr %12
  %228 = load i8, ptr %225
  call void @buf_putc(ptr %42, i8 %228)
  br label %L35
L35:
  %230 = load ptr, ptr %12
  %232 = sext i32 %230 to i64
  %231 = add i64 %232, 1
  store i64 %231, ptr %12
  %233 = load i8, ptr %230
  call void @buf_putc(ptr %42, i8 %233)
  br label %L30
L32:
  %235 = load ptr, ptr %12
  %236 = load i8, ptr %235
  %238 = sext i32 %236 to i64
  %239 = sext i32 34 to i64
  %237 = icmp eq i64 %238, %239
  %240 = zext i1 %237 to i64
  %241 = icmp ne i64 %240, 0
  br i1 %241, label %L36, label %L38
L36:
  %242 = load ptr, ptr %12
  %244 = sext i32 %242 to i64
  %243 = add i64 %244, 1
  store i64 %243, ptr %12
  %245 = load i8, ptr %242
  call void @buf_putc(ptr %42, i8 %245)
  br label %L38
L38:
  br label %L7
L39:
  br label %L29
L29:
  %247 = load ptr, ptr %12
  %248 = load i8, ptr %247
  %250 = sext i32 %248 to i64
  %251 = sext i32 47 to i64
  %249 = icmp eq i64 %250, %251
  %252 = zext i1 %249 to i64
  %253 = load ptr, ptr %12
  %254 = getelementptr i8, ptr %253, i64 1
  %255 = load i8, ptr %254
  %257 = sext i32 %255 to i64
  %258 = sext i32 47 to i64
  %256 = icmp eq i64 %257, %258
  %259 = zext i1 %256 to i64
  %261 = sext i32 %252 to i64
  %262 = sext i32 %259 to i64
  %263 = icmp ne i64 %261, 0
  %264 = icmp ne i64 %262, 0
  %265 = and i1 %263, %264
  %266 = zext i1 %265 to i64
  %267 = icmp ne i64 %266, 0
  br i1 %267, label %L40, label %L42
L40:
  br label %L43
L43:
  %268 = load ptr, ptr %12
  %269 = load i8, ptr %268
  %270 = load ptr, ptr %12
  %271 = load i8, ptr %270
  %273 = sext i32 %271 to i64
  %274 = sext i32 10 to i64
  %272 = icmp ne i64 %273, %274
  %275 = zext i1 %272 to i64
  %277 = sext i32 %269 to i64
  %278 = sext i32 %275 to i64
  %279 = icmp ne i64 %277, 0
  %280 = icmp ne i64 %278, 0
  %281 = and i1 %279, %280
  %282 = zext i1 %281 to i64
  %283 = icmp ne i64 %282, 0
  br i1 %283, label %L44, label %L45
L44:
  %284 = load ptr, ptr %12
  %286 = sext i32 %284 to i64
  %285 = add i64 %286, 1
  store i64 %285, ptr %12
  br label %L43
L45:
  br label %L9
L46:
  br label %L42
L42:
  %287 = load ptr, ptr %12
  %288 = load i8, ptr %287
  %290 = sext i32 %288 to i64
  %291 = sext i32 47 to i64
  %289 = icmp eq i64 %290, %291
  %292 = zext i1 %289 to i64
  %293 = load ptr, ptr %12
  %294 = getelementptr i8, ptr %293, i64 1
  %295 = load i8, ptr %294
  %297 = sext i32 %295 to i64
  %298 = sext i32 42 to i64
  %296 = icmp eq i64 %297, %298
  %299 = zext i1 %296 to i64
  %301 = sext i32 %292 to i64
  %302 = sext i32 %299 to i64
  %303 = icmp ne i64 %301, 0
  %304 = icmp ne i64 %302, 0
  %305 = and i1 %303, %304
  %306 = zext i1 %305 to i64
  %307 = icmp ne i64 %306, 0
  br i1 %307, label %L47, label %L49
L47:
  %308 = load ptr, ptr %12
  %310 = sext i32 %308 to i64
  %311 = sext i32 2 to i64
  %309 = add i64 %310, %311
  store i64 %309, ptr %12
  br label %L50
L50:
  %312 = load ptr, ptr %12
  %313 = load i8, ptr %312
  %314 = load ptr, ptr %12
  %315 = load i8, ptr %314
  %317 = sext i32 %315 to i64
  %318 = sext i32 42 to i64
  %316 = icmp eq i64 %317, %318
  %319 = zext i1 %316 to i64
  %320 = load ptr, ptr %12
  %321 = getelementptr i8, ptr %320, i64 1
  %322 = load i8, ptr %321
  %324 = sext i32 %322 to i64
  %325 = sext i32 47 to i64
  %323 = icmp eq i64 %324, %325
  %326 = zext i1 %323 to i64
  %328 = sext i32 %319 to i64
  %329 = sext i32 %326 to i64
  %330 = icmp ne i64 %328, 0
  %331 = icmp ne i64 %329, 0
  %332 = and i1 %330, %331
  %333 = zext i1 %332 to i64
  %335 = icmp eq i64 %333, 0
  %334 = zext i1 %335 to i64
  %337 = sext i32 %313 to i64
  %338 = sext i32 %334 to i64
  %339 = icmp ne i64 %337, 0
  %340 = icmp ne i64 %338, 0
  %341 = and i1 %339, %340
  %342 = zext i1 %341 to i64
  %343 = icmp ne i64 %342, 0
  br i1 %343, label %L51, label %L52
L51:
  %344 = load ptr, ptr %12
  %345 = load i8, ptr %344
  %347 = sext i32 %345 to i64
  %348 = sext i32 10 to i64
  %346 = icmp eq i64 %347, %348
  %349 = zext i1 %346 to i64
  %350 = icmp ne i64 %349, 0
  br i1 %350, label %L53, label %L55
L53:
  call void @buf_putc(ptr %42, i8 32)
  br label %L55
L55:
  %352 = load ptr, ptr %12
  %354 = sext i32 %352 to i64
  %353 = add i64 %354, 1
  store i64 %353, ptr %12
  br label %L50
L52:
  %355 = load ptr, ptr %12
  %356 = load i8, ptr %355
  %357 = icmp ne i64 %356, 0
  br i1 %357, label %L56, label %L58
L56:
  %358 = load ptr, ptr %12
  %360 = sext i32 %358 to i64
  %361 = sext i32 2 to i64
  %359 = add i64 %360, %361
  store i64 %359, ptr %12
  br label %L58
L58:
  br label %L7
L59:
  br label %L49
L49:
  %362 = load ptr, ptr %12
  %364 = sext i32 %362 to i64
  %363 = add i64 %364, 1
  store i64 %363, ptr %12
  %365 = load i8, ptr %362
  call void @buf_putc(ptr %42, i8 %365)
  br label %L7
L9:
  %367 = alloca ptr
  %369 = load i64, ptr %42
  store ptr %369, ptr %367
  %370 = load ptr, ptr %12
  %371 = load i8, ptr %370
  %373 = sext i32 %371 to i64
  %374 = sext i32 10 to i64
  %372 = icmp eq i64 %373, %374
  %375 = zext i1 %372 to i64
  %376 = icmp ne i64 %375, 0
  br i1 %376, label %L60, label %L62
L60:
  %377 = load ptr, ptr %12
  %379 = sext i32 %377 to i64
  %378 = add i64 %379, 1
  store i64 %378, ptr %12
  br label %L62
L62:
  %380 = alloca ptr
  %382 = load ptr, ptr %367
  %383 = call ptr @skip_ws(ptr %382)
  store ptr %383, ptr %380
  %384 = load ptr, ptr %380
  %385 = load i8, ptr %384
  %387 = sext i32 %385 to i64
  %388 = sext i32 35 to i64
  %386 = icmp eq i64 %387, %388
  %389 = zext i1 %386 to i64
  %390 = icmp ne i64 %389, 0
  br i1 %390, label %L63, label %L64
L63:
  %391 = load ptr, ptr %380
  call void @process_directive(ptr %391, ptr %2, ptr %4, i32 %6, ptr %8, ptr %10)
  br label %L65
L64:
  %393 = alloca i32
  store i32 1, ptr %393
  %395 = alloca i32
  store i32 0, ptr %395
  br label %L66
L66:
  %397 = load i32, ptr %395
  %398 = load i32, ptr %10
  %400 = sext i32 %397 to i64
  %401 = sext i32 %398 to i64
  %399 = icmp slt i64 %400, %401
  %402 = zext i1 %399 to i64
  %403 = icmp ne i64 %402, 0
  br i1 %403, label %L67, label %L69
L67:
  %404 = load i32, ptr %395
  %405 = getelementptr i32, ptr %8, i64 %404
  %406 = load i32, ptr %405
  %408 = icmp eq i64 %406, 0
  %407 = zext i1 %408 to i64
  %409 = icmp ne i64 %407, 0
  br i1 %409, label %L70, label %L72
L70:
  store i32 0, ptr %393
  br label %L69
L73:
  br label %L72
L72:
  br label %L68
L68:
  %410 = load i32, ptr %395
  %412 = sext i32 %410 to i64
  %411 = add i64 %412, 1
  store i64 %411, ptr %395
  br label %L66
L69:
  %413 = load i32, ptr %393
  %414 = icmp ne i64 %413, 0
  br i1 %414, label %L74, label %L75
L74:
  %415 = load ptr, ptr %367
  call void @expand_text(ptr %415, ptr %4, i32 0)
  call void @buf_putc(ptr %4, i8 10)
  br label %L76
L75:
  call void @buf_putc(ptr %4, i8 10)
  br label %L76
L76:
  br label %L65
L65:
  %419 = load ptr, ptr %367
  %420 = call i32 @free(ptr %419)
  br label %L0
L2:
  ret void
}

define dso_local ptr @macro_preprocess(ptr %0, ptr %2, i32 %4) {
entry:
  %6 = alloca i64
  call void @buf_init(ptr %6)
  %9 = alloca ptr
  store ptr 0, ptr %9
  %11 = alloca i32
  store i32 0, ptr %11
  %14 = sext i32 %4 to i64
  %15 = sext i32 0 to i64
  %13 = icmp eq i64 %14, %15
  %16 = zext i1 %13 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %L0, label %L2
L0:
  %18 = getelementptr [8 x i8], ptr @.str19, i64 0, i64 0
  %19 = getelementptr [2 x i8], ptr @.str20, i64 0, i64 0
  %20 = inttoptr i64 0 to ptr
  call void @macro_define(ptr %18, ptr %19, ptr %20, i32 0, i32 0)
  %22 = getelementptr [9 x i8], ptr @.str21, i64 0, i64 0
  %23 = getelementptr [2 x i8], ptr @.str22, i64 0, i64 0
  %24 = inttoptr i64 0 to ptr
  call void @macro_define(ptr %22, ptr %23, ptr %24, i32 0, i32 0)
  %26 = getelementptr [5 x i8], ptr @.str23, i64 0, i64 0
  %27 = getelementptr [11 x i8], ptr @.str24, i64 0, i64 0
  %28 = inttoptr i64 0 to ptr
  call void @macro_define(ptr %26, ptr %27, ptr %28, i32 0, i32 0)
  %30 = getelementptr [9 x i8], ptr @.str25, i64 0, i64 0
  %31 = getelementptr [2 x i8], ptr @.str26, i64 0, i64 0
  %32 = inttoptr i64 0 to ptr
  call void @macro_define(ptr %30, ptr %31, ptr %32, i32 0, i32 0)
  br label %L2
L2:
  %34 = load ptr, ptr %9
  call void @preprocess_into(ptr %0, ptr %2, ptr %6, i32 %4, ptr %34, ptr %11)
  %36 = load i64, ptr %6
  ret ptr %36
L3:
  ret ptr 0
}

@.str0 = private unnamed_addr constant [7 x i8] c"malloc\00"
@.str1 = private unnamed_addr constant [8 x i8] c"realloc\00"
@.str2 = private unnamed_addr constant [18 x i8] c"macro table full\0A\00"
@.str3 = private unnamed_addr constant [12 x i8] c"__VA_ARGS__\00"
@.str4 = private unnamed_addr constant [2 x i8] c"r\00"
@.str5 = private unnamed_addr constant [6 x i8] c"%s/%s\00"
@.str6 = private unnamed_addr constant [6 x i8] c"ifdef\00"
@.str7 = private unnamed_addr constant [7 x i8] c"ifndef\00"
@.str8 = private unnamed_addr constant [3 x i8] c"if\00"
@.str9 = private unnamed_addr constant [8 x i8] c"defined\00"
@.str10 = private unnamed_addr constant [5 x i8] c"elif\00"
@.str11 = private unnamed_addr constant [5 x i8] c"else\00"
@.str12 = private unnamed_addr constant [6 x i8] c"endif\00"
@.str13 = private unnamed_addr constant [7 x i8] c"define\00"
@.str14 = private unnamed_addr constant [6 x i8] c"undef\00"
@.str15 = private unnamed_addr constant [8 x i8] c"include\00"
@.str16 = private unnamed_addr constant [36 x i8] c"warning: max include depth reached\0A\00"
@.str17 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str18 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str19 = private unnamed_addr constant [8 x i8] c"__C0C__\00"
@.str20 = private unnamed_addr constant [2 x i8] c"1\00"
@.str21 = private unnamed_addr constant [9 x i8] c"__STDC__\00"
@.str22 = private unnamed_addr constant [2 x i8] c"1\00"
@.str23 = private unnamed_addr constant [5 x i8] c"NULL\00"
@.str24 = private unnamed_addr constant [11 x i8] c"((void*)0)\00"
@.str25 = private unnamed_addr constant [9 x i8] c"__LP64__\00"
@.str26 = private unnamed_addr constant [2 x i8] c"1\00"
