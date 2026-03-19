; ModuleID = 'macro.c'
source_filename = "macro.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@macro_preprocess = dso_local global ptr zeroinitializer
@macros = internal global ptr zeroinitializer
@n_macros = internal global i32 zeroinitializer
@expand_text = internal global ptr zeroinitializer
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
  ret ptr 0
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
  br label %L18
L18:
  %94 = phi i64 [ %93, %L16 ], [ 0, %L17 ]
  %95 = load ptr, ptr %52
  %96 = load i64, ptr %95
  %97 = load i32, ptr %66
  %98 = getelementptr i8, ptr %96, i64 %97
  store i32 %94, ptr %98
  br label %L14
L14:
  %99 = load i32, ptr %66
  %101 = sext i32 %99 to i64
  %100 = add i64 %101, 1
  store i64 %100, ptr %66
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
  %107 = sext i32 40 to i64
  %105 = icmp eq i64 %106, %107
  %108 = zext i1 %105 to i64
  %109 = icmp ne i64 %108, 0
  br i1 %109, label %L13, label %L15
L13:
  %110 = load i32, ptr %31
  %112 = sext i32 %110 to i64
  %111 = add i64 %112, 1
  store i64 %111, ptr %31
  br label %L15
L15:
  %113 = load ptr, ptr %8
  %114 = load i8, ptr %113
  %116 = sext i32 %114 to i64
  %117 = sext i32 41 to i64
  %115 = icmp eq i64 %116, %117
  %118 = zext i1 %115 to i64
  %119 = icmp ne i64 %118, 0
  br i1 %119, label %L16, label %L18
L16:
  %120 = load i32, ptr %31
  %122 = sext i32 %120 to i64
  %121 = sub i64 %122, 1
  store i64 %121, ptr %31
  br label %L18
L18:
  %123 = load ptr, ptr %8
  %125 = sext i32 %123 to i64
  %124 = add i64 %125, 1
  store i64 %124, ptr %8
  %126 = load i8, ptr %123
  call void @buf_putc(ptr %33, i8 %126)
  br label %L9
L9:
  br label %L4
L6:
  %128 = load i64, ptr %33
  %130 = sext i32 %128 to i64
  %131 = sext i32 0 to i64
  %129 = icmp sgt i64 %130, %131
  %132 = zext i1 %129 to i64
  %133 = load i32, ptr %29
  %135 = sext i32 %133 to i64
  %136 = sext i32 0 to i64
  %134 = icmp sgt i64 %135, %136
  %137 = zext i1 %134 to i64
  %139 = sext i32 %132 to i64
  %140 = sext i32 %137 to i64
  %141 = icmp ne i64 %139, 0
  %142 = icmp ne i64 %140, 0
  %143 = or i1 %141, %142
  %144 = zext i1 %143 to i64
  %145 = icmp ne i64 %144, 0
  br i1 %145, label %L19, label %L21
L19:
  %146 = load i32, ptr %29
  %148 = sext i32 %146 to i64
  %149 = sext i32 16 to i64
  %147 = icmp slt i64 %148, %149
  %150 = zext i1 %147 to i64
  %151 = icmp ne i64 %150, 0
  br i1 %151, label %L22, label %L24
L22:
  %152 = load i64, ptr %33
  %153 = call i32 @strdup(i32 %152)
  %154 = load ptr, ptr %27
  %155 = load i32, ptr %29
  %157 = sext i32 %155 to i64
  %156 = add i64 %157, 1
  store i64 %156, ptr %29
  %158 = getelementptr i8, ptr %154, i64 %155
  store i32 %153, ptr %158
  br label %L24
L24:
  br label %L21
L21:
  %159 = load i64, ptr %33
  %160 = call i32 @free(i32 %159)
  %161 = load ptr, ptr %8
  %162 = load i8, ptr %161
  %164 = sext i32 %162 to i64
  %165 = sext i32 41 to i64
  %163 = icmp eq i64 %164, %165
  %166 = zext i1 %163 to i64
  %167 = icmp ne i64 %166, 0
  br i1 %167, label %L25, label %L27
L25:
  %168 = load ptr, ptr %8
  %170 = sext i32 %168 to i64
  %169 = add i64 %170, 1
  store i64 %169, ptr %8
  br label %L27
L27:
  %171 = load ptr, ptr %8
  store ptr %171, ptr %2
  %172 = alloca ptr
  %174 = load i64, ptr %0
  store ptr %174, ptr %172
  %175 = alloca i64
  call void @buf_init(ptr %175)
  br label %L28
L28:
  %178 = load ptr, ptr %172
  %179 = load i8, ptr %178
  %180 = icmp ne i64 %179, 0
  br i1 %180, label %L29, label %L30
L29:
  %181 = load ptr, ptr %172
  %182 = load i8, ptr %181
  %183 = bitcast i8 %182 to i8
  %184 = call i32 @isalpha(i8 %183)
  %185 = load ptr, ptr %172
  %186 = load i8, ptr %185
  %188 = sext i32 %186 to i64
  %189 = sext i32 95 to i64
  %187 = icmp eq i64 %188, %189
  %190 = zext i1 %187 to i64
  %192 = sext i32 %184 to i64
  %193 = sext i32 %190 to i64
  %194 = icmp ne i64 %192, 0
  %195 = icmp ne i64 %193, 0
  %196 = or i1 %194, %195
  %197 = zext i1 %196 to i64
  %198 = icmp ne i64 %197, 0
  br i1 %198, label %L31, label %L32
L31:
  %199 = alloca ptr
  %201 = alloca ptr
  %203 = load ptr, ptr %172
  %204 = load ptr, ptr %199
  %205 = call ptr @read_ident(ptr %203, ptr %204, i32 8)
  store ptr %205, ptr %201
  %206 = alloca i32
  store i32 0, ptr %206
  %208 = alloca i32
  store i32 0, ptr %208
  br label %L34
L34:
  %210 = load i32, ptr %208
  %211 = load i64, ptr %0
  %213 = sext i32 %210 to i64
  %214 = sext i32 %211 to i64
  %212 = icmp slt i64 %213, %214
  %215 = zext i1 %212 to i64
  %216 = load i32, ptr %208
  %218 = sext i32 %216 to i64
  %219 = sext i32 16 to i64
  %217 = icmp slt i64 %218, %219
  %220 = zext i1 %217 to i64
  %222 = sext i32 %215 to i64
  %223 = sext i32 %220 to i64
  %224 = icmp ne i64 %222, 0
  %225 = icmp ne i64 %223, 0
  %226 = and i1 %224, %225
  %227 = zext i1 %226 to i64
  %228 = icmp ne i64 %227, 0
  br i1 %228, label %L35, label %L37
L35:
  %229 = load i64, ptr %0
  %230 = load i32, ptr %208
  %231 = getelementptr i32, ptr %229, i64 %230
  %232 = load i32, ptr %231
  %233 = load i64, ptr %0
  %234 = load i32, ptr %208
  %235 = getelementptr i32, ptr %233, i64 %234
  %236 = load i32, ptr %235
  %237 = load ptr, ptr %199
  %238 = call i32 @strcmp(i32 %236, ptr %237)
  %240 = sext i32 %238 to i64
  %241 = sext i32 0 to i64
  %239 = icmp eq i64 %240, %241
  %242 = zext i1 %239 to i64
  %244 = sext i32 %232 to i64
  %245 = sext i32 %242 to i64
  %246 = icmp ne i64 %244, 0
  %247 = icmp ne i64 %245, 0
  %248 = and i1 %246, %247
  %249 = zext i1 %248 to i64
  %250 = icmp ne i64 %249, 0
  br i1 %250, label %L38, label %L40
L38:
  %251 = load i32, ptr %208
  %252 = load i32, ptr %29
  %254 = sext i32 %251 to i64
  %255 = sext i32 %252 to i64
  %253 = icmp slt i64 %254, %255
  %256 = zext i1 %253 to i64
  %257 = load ptr, ptr %27
  %258 = load i32, ptr %208
  %259 = getelementptr ptr, ptr %257, i64 %258
  %260 = load ptr, ptr %259
  %262 = sext i32 %256 to i64
  %263 = sext i32 %260 to i64
  %264 = icmp ne i64 %262, 0
  %265 = icmp ne i64 %263, 0
  %266 = and i1 %264, %265
  %267 = zext i1 %266 to i64
  %268 = icmp ne i64 %267, 0
  br i1 %268, label %L41, label %L43
L41:
  %269 = load ptr, ptr %27
  %270 = load i32, ptr %208
  %271 = getelementptr ptr, ptr %269, i64 %270
  %272 = load ptr, ptr %271
  %273 = load ptr, ptr %27
  %274 = load i32, ptr %208
  %275 = getelementptr ptr, ptr %273, i64 %274
  %276 = load ptr, ptr %275
  %277 = call i32 @strlen(ptr %276)
  call void @buf_append(ptr %175, ptr %272, i32 %277)
  br label %L43
L43:
  store i32 1, ptr %206
  br label %L37
L44:
  br label %L40
L40:
  br label %L36
L36:
  %279 = load i32, ptr %208
  %281 = sext i32 %279 to i64
  %280 = add i64 %281, 1
  store i64 %280, ptr %208
  br label %L34
L37:
  %282 = load i32, ptr %206
  %284 = icmp eq i64 %282, 0
  %283 = zext i1 %284 to i64
  %285 = icmp ne i64 %283, 0
  br i1 %285, label %L45, label %L47
L45:
  %286 = load ptr, ptr %199
  %287 = load ptr, ptr %199
  %288 = call i32 @strlen(ptr %287)
  call void @buf_append(ptr %175, ptr %286, i32 %288)
  br label %L47
L47:
  %290 = load ptr, ptr %201
  store ptr %290, ptr %172
  br label %L33
L32:
  %291 = load ptr, ptr %172
  %293 = sext i32 %291 to i64
  %292 = add i64 %293, 1
  store i64 %292, ptr %172
  %294 = load i8, ptr %291
  call void @buf_putc(ptr %175, i8 %294)
  br label %L33
L33:
  br label %L28
L30:
  %296 = load i64, ptr %175
  %298 = sext i32 %6 to i64
  %299 = sext i32 1 to i64
  %297 = add i64 %298, %299
  call void @expand_text(i32 %296, ptr %4, i32 %297)
  %301 = load i64, ptr %175
  %302 = call i32 @free(i32 %301)
  %303 = alloca i32
  store i32 0, ptr %303
  br label %L48
L48:
  %305 = load i32, ptr %303
  %306 = load i32, ptr %29
  %308 = sext i32 %305 to i64
  %309 = sext i32 %306 to i64
  %307 = icmp slt i64 %308, %309
  %310 = zext i1 %307 to i64
  %311 = icmp ne i64 %310, 0
  br i1 %311, label %L49, label %L51
L49:
  %312 = load ptr, ptr %27
  %313 = load i32, ptr %303
  %314 = getelementptr ptr, ptr %312, i64 %313
  %315 = load ptr, ptr %314
  %316 = call i32 @free(ptr %315)
  br label %L50
L50:
  %317 = load i32, ptr %303
  %319 = sext i32 %317 to i64
  %318 = add i64 %319, 1
  store i64 %318, ptr %303
  br label %L48
L51:
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
  br label %L22
L22:
  %74 = load ptr, ptr %13
  %75 = load i8, ptr %74
  %77 = sext i32 %75 to i64
  %78 = sext i32 32 to i64
  %76 = icmp eq i64 %77, %78
  %79 = zext i1 %76 to i64
  %80 = load ptr, ptr %13
  %81 = load i8, ptr %80
  %83 = sext i32 %81 to i64
  %84 = sext i32 9 to i64
  %82 = icmp eq i64 %83, %84
  %85 = zext i1 %82 to i64
  %87 = sext i32 %79 to i64
  %88 = sext i32 %85 to i64
  %89 = icmp ne i64 %87, 0
  %90 = icmp ne i64 %88, 0
  %91 = or i1 %89, %90
  %92 = zext i1 %91 to i64
  %93 = load ptr, ptr %13
  %94 = load i8, ptr %93
  %96 = sext i32 %94 to i64
  %97 = sext i32 10 to i64
  %95 = icmp eq i64 %96, %97
  %98 = zext i1 %95 to i64
  %100 = sext i32 %92 to i64
  %101 = sext i32 %98 to i64
  %102 = icmp ne i64 %100, 0
  %103 = icmp ne i64 %101, 0
  %104 = or i1 %102, %103
  %105 = zext i1 %104 to i64
  %106 = load ptr, ptr %13
  %107 = load i8, ptr %106
  %109 = sext i32 %107 to i64
  %110 = sext i32 13 to i64
  %108 = icmp eq i64 %109, %110
  %111 = zext i1 %108 to i64
  %113 = sext i32 %105 to i64
  %114 = sext i32 %111 to i64
  %115 = icmp ne i64 %113, 0
  %116 = icmp ne i64 %114, 0
  %117 = or i1 %115, %116
  %118 = zext i1 %117 to i64
  %119 = icmp ne i64 %118, 0
  br i1 %119, label %L23, label %L24
L23:
  %120 = load ptr, ptr %13
  %122 = sext i32 %120 to i64
  %121 = add i64 %122, 1
  store i64 %121, ptr %13
  br label %L22
L24:
  br label %L25
L25:
  %123 = load ptr, ptr %13
  %124 = load i8, ptr %123
  %126 = sext i32 %124 to i64
  %127 = sext i32 34 to i64
  %125 = icmp eq i64 %126, %127
  %128 = zext i1 %125 to i64
  %129 = icmp ne i64 %128, 0
  br i1 %129, label %L26, label %L27
L26:
  %130 = load ptr, ptr %13
  %132 = sext i32 %130 to i64
  %131 = add i64 %132, 1
  store i64 %131, ptr %13
  br label %L28
L28:
  %133 = load ptr, ptr %13
  %134 = load i8, ptr %133
  %135 = load ptr, ptr %13
  %136 = load i8, ptr %135
  %138 = sext i32 %136 to i64
  %139 = sext i32 34 to i64
  %137 = icmp ne i64 %138, %139
  %140 = zext i1 %137 to i64
  %142 = sext i32 %134 to i64
  %143 = sext i32 %140 to i64
  %144 = icmp ne i64 %142, 0
  %145 = icmp ne i64 %143, 0
  %146 = and i1 %144, %145
  %147 = zext i1 %146 to i64
  %148 = icmp ne i64 %147, 0
  br i1 %148, label %L29, label %L30
L29:
  %149 = load ptr, ptr %13
  %150 = load i8, ptr %149
  %152 = sext i32 %150 to i64
  %153 = sext i32 92 to i64
  %151 = icmp eq i64 %152, %153
  %154 = zext i1 %151 to i64
  %155 = icmp ne i64 %154, 0
  br i1 %155, label %L31, label %L33
L31:
  %156 = load ptr, ptr %13
  %158 = sext i32 %156 to i64
  %157 = add i64 %158, 1
  store i64 %157, ptr %13
  %159 = load i8, ptr %156
  call void @buf_putc(ptr %2, i8 %159)
  br label %L33
L33:
  %161 = load ptr, ptr %13
  %162 = load i8, ptr %161
  %163 = icmp ne i64 %162, 0
  br i1 %163, label %L34, label %L36
L34:
  %164 = load ptr, ptr %13
  %166 = sext i32 %164 to i64
  %165 = add i64 %166, 1
  store i64 %165, ptr %13
  %167 = load i8, ptr %164
  call void @buf_putc(ptr %2, i8 %167)
  br label %L36
L36:
  br label %L28
L30:
  %169 = load ptr, ptr %13
  %170 = load i8, ptr %169
  %171 = icmp ne i64 %170, 0
  br i1 %171, label %L37, label %L39
L37:
  %172 = load ptr, ptr %13
  %174 = sext i32 %172 to i64
  %173 = add i64 %174, 1
  store i64 %173, ptr %13
  %175 = load i8, ptr %172
  call void @buf_putc(ptr %2, i8 %175)
  br label %L39
L39:
  br label %L40
L40:
  %177 = load ptr, ptr %13
  %178 = load i8, ptr %177
  %180 = sext i32 %178 to i64
  %181 = sext i32 32 to i64
  %179 = icmp eq i64 %180, %181
  %182 = zext i1 %179 to i64
  %183 = load ptr, ptr %13
  %184 = load i8, ptr %183
  %186 = sext i32 %184 to i64
  %187 = sext i32 9 to i64
  %185 = icmp eq i64 %186, %187
  %188 = zext i1 %185 to i64
  %190 = sext i32 %182 to i64
  %191 = sext i32 %188 to i64
  %192 = icmp ne i64 %190, 0
  %193 = icmp ne i64 %191, 0
  %194 = or i1 %192, %193
  %195 = zext i1 %194 to i64
  %196 = load ptr, ptr %13
  %197 = load i8, ptr %196
  %199 = sext i32 %197 to i64
  %200 = sext i32 10 to i64
  %198 = icmp eq i64 %199, %200
  %201 = zext i1 %198 to i64
  %203 = sext i32 %195 to i64
  %204 = sext i32 %201 to i64
  %205 = icmp ne i64 %203, 0
  %206 = icmp ne i64 %204, 0
  %207 = or i1 %205, %206
  %208 = zext i1 %207 to i64
  %209 = load ptr, ptr %13
  %210 = load i8, ptr %209
  %212 = sext i32 %210 to i64
  %213 = sext i32 13 to i64
  %211 = icmp eq i64 %212, %213
  %214 = zext i1 %211 to i64
  %216 = sext i32 %208 to i64
  %217 = sext i32 %214 to i64
  %218 = icmp ne i64 %216, 0
  %219 = icmp ne i64 %217, 0
  %220 = or i1 %218, %219
  %221 = zext i1 %220 to i64
  %222 = icmp ne i64 %221, 0
  br i1 %222, label %L41, label %L42
L41:
  %223 = load ptr, ptr %13
  %225 = sext i32 %223 to i64
  %224 = add i64 %225, 1
  store i64 %224, ptr %13
  br label %L40
L42:
  br label %L25
L27:
  br label %L4
L43:
  br label %L9
L9:
  %226 = load ptr, ptr %13
  %227 = load i8, ptr %226
  %229 = sext i32 %227 to i64
  %230 = sext i32 39 to i64
  %228 = icmp eq i64 %229, %230
  %231 = zext i1 %228 to i64
  %232 = icmp ne i64 %231, 0
  br i1 %232, label %L44, label %L46
L44:
  %233 = load ptr, ptr %13
  %235 = sext i32 %233 to i64
  %234 = add i64 %235, 1
  store i64 %234, ptr %13
  %236 = load i8, ptr %233
  call void @buf_putc(ptr %2, i8 %236)
  br label %L47
L47:
  %238 = load ptr, ptr %13
  %239 = load i8, ptr %238
  %240 = load ptr, ptr %13
  %241 = load i8, ptr %240
  %243 = sext i32 %241 to i64
  %244 = sext i32 39 to i64
  %242 = icmp ne i64 %243, %244
  %245 = zext i1 %242 to i64
  %247 = sext i32 %239 to i64
  %248 = sext i32 %245 to i64
  %249 = icmp ne i64 %247, 0
  %250 = icmp ne i64 %248, 0
  %251 = and i1 %249, %250
  %252 = zext i1 %251 to i64
  %253 = icmp ne i64 %252, 0
  br i1 %253, label %L48, label %L49
L48:
  %254 = load ptr, ptr %13
  %255 = load i8, ptr %254
  %257 = sext i32 %255 to i64
  %258 = sext i32 92 to i64
  %256 = icmp eq i64 %257, %258
  %259 = zext i1 %256 to i64
  %260 = icmp ne i64 %259, 0
  br i1 %260, label %L50, label %L52
L50:
  %261 = load ptr, ptr %13
  %263 = sext i32 %261 to i64
  %262 = add i64 %263, 1
  store i64 %262, ptr %13
  %264 = load i8, ptr %261
  call void @buf_putc(ptr %2, i8 %264)
  br label %L52
L52:
  %266 = load ptr, ptr %13
  %267 = load i8, ptr %266
  %268 = icmp ne i64 %267, 0
  br i1 %268, label %L53, label %L55
L53:
  %269 = load ptr, ptr %13
  %271 = sext i32 %269 to i64
  %270 = add i64 %271, 1
  store i64 %270, ptr %13
  %272 = load i8, ptr %269
  call void @buf_putc(ptr %2, i8 %272)
  br label %L55
L55:
  br label %L47
L49:
  %274 = load ptr, ptr %13
  %275 = load i8, ptr %274
  %276 = icmp ne i64 %275, 0
  br i1 %276, label %L56, label %L58
L56:
  %277 = load ptr, ptr %13
  %279 = sext i32 %277 to i64
  %278 = add i64 %279, 1
  store i64 %278, ptr %13
  %280 = load i8, ptr %277
  call void @buf_putc(ptr %2, i8 %280)
  br label %L58
L58:
  br label %L4
L59:
  br label %L46
L46:
  %282 = load ptr, ptr %13
  %283 = load i8, ptr %282
  %284 = bitcast i8 %283 to i8
  %285 = call i32 @isalpha(i8 %284)
  %286 = load ptr, ptr %13
  %287 = load i8, ptr %286
  %289 = sext i32 %287 to i64
  %290 = sext i32 95 to i64
  %288 = icmp eq i64 %289, %290
  %291 = zext i1 %288 to i64
  %293 = sext i32 %285 to i64
  %294 = sext i32 %291 to i64
  %295 = icmp ne i64 %293, 0
  %296 = icmp ne i64 %294, 0
  %297 = or i1 %295, %296
  %298 = zext i1 %297 to i64
  %299 = icmp ne i64 %298, 0
  br i1 %299, label %L60, label %L62
L60:
  %300 = alloca ptr
  %302 = alloca ptr
  %304 = load ptr, ptr %13
  %305 = load ptr, ptr %300
  %306 = call ptr @read_ident(ptr %304, ptr %305, i32 8)
  store ptr %306, ptr %302
  %307 = alloca ptr
  %309 = load ptr, ptr %300
  %310 = call ptr @macro_find(ptr %309)
  store ptr %310, ptr %307
  %311 = load ptr, ptr %307
  %312 = load ptr, ptr %307
  %313 = load i64, ptr %312
  %315 = icmp ne i64 %311, 0
  %316 = icmp ne i64 %313, 0
  %317 = and i1 %315, %316
  %318 = zext i1 %317 to i64
  %319 = icmp ne i64 %318, 0
  br i1 %319, label %L63, label %L65
L63:
  %320 = alloca ptr
  %322 = load ptr, ptr %302
  store ptr %322, ptr %320
  %323 = load ptr, ptr %320
  %324 = call ptr @skip_ws(ptr %323)
  store ptr %324, ptr %320
  %325 = load ptr, ptr %320
  %326 = load i8, ptr %325
  %328 = sext i32 %326 to i64
  %329 = sext i32 40 to i64
  %327 = icmp eq i64 %328, %329
  %330 = zext i1 %327 to i64
  %331 = icmp ne i64 %330, 0
  br i1 %331, label %L66, label %L68
L66:
  %332 = load ptr, ptr %302
  store ptr %332, ptr %13
  %333 = load ptr, ptr %307
  %335 = sext i32 %4 to i64
  %336 = sext i32 1 to i64
  %334 = add i64 %335, %336
  call void @expand_func_macro(ptr %333, ptr %13, ptr %2, i32 %334)
  br label %L4
L69:
  br label %L68
L68:
  br label %L65
L65:
  %338 = load ptr, ptr %307
  %339 = load ptr, ptr %307
  %340 = load i64, ptr %339
  %342 = icmp eq i64 %340, 0
  %341 = zext i1 %342 to i64
  %344 = icmp ne i64 %338, 0
  %345 = icmp ne i64 %341, 0
  %346 = and i1 %344, %345
  %347 = zext i1 %346 to i64
  %348 = icmp ne i64 %347, 0
  br i1 %348, label %L70, label %L72
L70:
  %349 = load ptr, ptr %307
  %350 = load i64, ptr %349
  %352 = sext i32 %4 to i64
  %353 = sext i32 1 to i64
  %351 = add i64 %352, %353
  call void @expand_text(i32 %350, ptr %2, i32 %351)
  %355 = load ptr, ptr %302
  store ptr %355, ptr %13
  br label %L4
L73:
  br label %L72
L72:
  %356 = load ptr, ptr %300
  %357 = load ptr, ptr %300
  %358 = call i32 @strlen(ptr %357)
  call void @buf_append(ptr %2, ptr %356, i32 %358)
  %360 = load ptr, ptr %302
  store ptr %360, ptr %13
  br label %L4
L74:
  br label %L62
L62:
  %361 = load ptr, ptr %13
  %363 = sext i32 %361 to i64
  %362 = add i64 %363, 1
  store i64 %362, ptr %13
  %364 = load i8, ptr %361
  call void @buf_putc(ptr %2, i8 %364)
  br label %L4
L6:
  ret void
}

define internal ptr @read_file(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = getelementptr [2 x i8], ptr @.str3, i64 0, i64 0
  %5 = call i32 @fopen(ptr %0, ptr %4)
  store ptr %5, ptr %2
  %6 = load ptr, ptr %2
  %8 = icmp eq i64 %6, 0
  %7 = zext i1 %8 to i64
  %9 = icmp ne i64 %7, 0
  br i1 %9, label %L0, label %L2
L0:
  ret ptr 0
L3:
  br label %L2
L2:
  %10 = load ptr, ptr %2
  %11 = call i32 @fseek(ptr %10, i32 0, ptr @SEEK_END)
  %12 = alloca i64
  %14 = load ptr, ptr %2
  %15 = call i32 @ftell(ptr %14)
  store i64 %15, ptr %12
  %16 = load ptr, ptr %2
  %17 = call i32 @fseek(ptr %16, i32 0, ptr @SEEK_SET)
  %18 = alloca ptr
  %20 = load i64, ptr %12
  %22 = sext i32 %20 to i64
  %23 = sext i32 1 to i64
  %21 = add i64 %22, %23
  %24 = call i32 @malloc(i64 %21)
  store ptr %24, ptr %18
  %25 = load ptr, ptr %18
  %27 = icmp eq i64 %25, 0
  %26 = zext i1 %27 to i64
  %28 = icmp ne i64 %26, 0
  br i1 %28, label %L4, label %L6
L4:
  %29 = load ptr, ptr %2
  %30 = call i32 @fclose(ptr %29)
  ret ptr 0
L7:
  br label %L6
L6:
  %31 = alloca i64
  %33 = load ptr, ptr %18
  %34 = load i64, ptr %12
  %35 = load ptr, ptr %2
  %36 = call i32 @fread(ptr %33, i32 1, i64 %34, ptr %35)
  store ptr %36, ptr %31
  %37 = load ptr, ptr %18
  %38 = load i64, ptr %31
  %39 = getelementptr i8, ptr %37, i64 %38
  store i8 0, ptr %39
  %40 = load ptr, ptr %2
  %41 = call i32 @fclose(ptr %40)
  %42 = load ptr, ptr %18
  ret ptr %42
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
  %13 = alloca ptr
  %15 = getelementptr [13 x i8], ptr @.str4, i64 0, i64 0
  %16 = load ptr, ptr %13
  %17 = getelementptr i8, ptr %16, i64 0
  store ptr %15, ptr %17
  %18 = getelementptr [19 x i8], ptr @.str5, i64 0, i64 0
  %19 = load ptr, ptr %13
  %20 = getelementptr i8, ptr %19, i64 1
  store ptr %18, ptr %20
  %21 = getelementptr [2 x i8], ptr @.str6, i64 0, i64 0
  %22 = load ptr, ptr %13
  %23 = getelementptr i8, ptr %22, i64 2
  store ptr %21, ptr %23
  %24 = alloca i32
  store i32 0, ptr %24
  br label %L7
L7:
  %26 = load i32, ptr %24
  %28 = sext i32 %26 to i64
  %29 = sext i32 3 to i64
  %27 = icmp slt i64 %28, %29
  %30 = zext i1 %27 to i64
  %31 = icmp ne i64 %30, 0
  br i1 %31, label %L8, label %L10
L8:
  %32 = alloca ptr
  %34 = load ptr, ptr %32
  %35 = getelementptr [6 x i8], ptr @.str7, i64 0, i64 0
  %36 = load ptr, ptr %13
  %37 = load i32, ptr %24
  %38 = getelementptr ptr, ptr %36, i64 %37
  %39 = load ptr, ptr %38
  %40 = call i32 @snprintf(ptr %34, i32 8, ptr %35, ptr %39, ptr %0)
  %41 = alloca ptr
  %43 = load ptr, ptr %32
  %44 = call ptr @read_file(ptr %43)
  store ptr %44, ptr %41
  %45 = load ptr, ptr %41
  %46 = icmp ne i64 %45, 0
  br i1 %46, label %L11, label %L13
L11:
  %47 = load ptr, ptr %41
  ret ptr %47
L14:
  br label %L13
L13:
  br label %L9
L9:
  %48 = load i32, ptr %24
  %50 = sext i32 %48 to i64
  %49 = add i64 %50, 1
  store i64 %49, ptr %24
  br label %L7
L10:
  ret ptr 0
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
  %24 = getelementptr [6 x i8], ptr @.str8, i64 0, i64 0
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
  %40 = icmp ne ptr %39, 0
  %41 = zext i1 %40 to i64
  store i32 %41, ptr %36
  %42 = load i32, ptr %10
  %44 = sext i32 %42 to i64
  %45 = sext i32 32 to i64
  %43 = icmp slt i64 %44, %45
  %46 = zext i1 %43 to i64
  %47 = icmp ne i64 %46, 0
  br i1 %47, label %L3, label %L5
L3:
  %48 = load i32, ptr %36
  %49 = load i32, ptr %10
  %51 = sext i32 %49 to i64
  %50 = add i64 %51, 1
  store i64 %50, ptr %10
  %52 = getelementptr i8, ptr %8, i64 %49
  store i32 %48, ptr %52
  br label %L5
L5:
  ret void
L6:
  br label %L2
L2:
  %53 = load ptr, ptr %16
  %54 = getelementptr [7 x i8], ptr @.str9, i64 0, i64 0
  %55 = call i32 @strcmp(ptr %53, ptr %54)
  %57 = sext i32 %55 to i64
  %58 = sext i32 0 to i64
  %56 = icmp eq i64 %57, %58
  %59 = zext i1 %56 to i64
  %60 = icmp ne i64 %59, 0
  br i1 %60, label %L7, label %L9
L7:
  %61 = alloca ptr
  %63 = load ptr, ptr %12
  %64 = load ptr, ptr %61
  %65 = call ptr @read_ident(ptr %63, ptr %64, i32 8)
  %66 = alloca i32
  %68 = load ptr, ptr %61
  %69 = call ptr @macro_find(ptr %68)
  %70 = icmp eq ptr %69, 0
  %71 = zext i1 %70 to i64
  store i32 %71, ptr %66
  %72 = load i32, ptr %10
  %74 = sext i32 %72 to i64
  %75 = sext i32 32 to i64
  %73 = icmp slt i64 %74, %75
  %76 = zext i1 %73 to i64
  %77 = icmp ne i64 %76, 0
  br i1 %77, label %L10, label %L12
L10:
  %78 = load i32, ptr %66
  %79 = load i32, ptr %10
  %81 = sext i32 %79 to i64
  %80 = add i64 %81, 1
  store i64 %80, ptr %10
  %82 = getelementptr i8, ptr %8, i64 %79
  store i32 %78, ptr %82
  br label %L12
L12:
  ret void
L13:
  br label %L9
L9:
  %83 = load ptr, ptr %16
  %84 = getelementptr [3 x i8], ptr @.str10, i64 0, i64 0
  %85 = call i32 @strcmp(ptr %83, ptr %84)
  %87 = sext i32 %85 to i64
  %88 = sext i32 0 to i64
  %86 = icmp eq i64 %87, %88
  %89 = zext i1 %86 to i64
  %90 = icmp ne i64 %89, 0
  br i1 %90, label %L14, label %L16
L14:
  %91 = alloca i32
  store i32 0, ptr %91
  %93 = load ptr, ptr %12
  %94 = getelementptr [8 x i8], ptr @.str11, i64 0, i64 0
  %95 = call i32 @strncmp(ptr %93, ptr %94, i32 7)
  %97 = sext i32 %95 to i64
  %98 = sext i32 0 to i64
  %96 = icmp eq i64 %97, %98
  %99 = zext i1 %96 to i64
  %100 = icmp ne i64 %99, 0
  br i1 %100, label %L17, label %L18
L17:
  %101 = load ptr, ptr %12
  %103 = sext i32 %101 to i64
  %104 = sext i32 7 to i64
  %102 = add i64 %103, %104
  store i64 %102, ptr %12
  %105 = load ptr, ptr %12
  %106 = call ptr @skip_ws(ptr %105)
  store ptr %106, ptr %12
  %107 = load ptr, ptr %12
  %108 = load i8, ptr %107
  %110 = sext i32 %108 to i64
  %111 = sext i32 40 to i64
  %109 = icmp eq i64 %110, %111
  %112 = zext i1 %109 to i64
  %113 = icmp ne i64 %112, 0
  br i1 %113, label %L20, label %L22
L20:
  %114 = load ptr, ptr %12
  %116 = sext i32 %114 to i64
  %115 = add i64 %116, 1
  store i64 %115, ptr %12
  br label %L22
L22:
  %117 = load ptr, ptr %12
  %118 = call ptr @skip_ws(ptr %117)
  store ptr %118, ptr %12
  %119 = alloca ptr
  %121 = alloca ptr
  %123 = load ptr, ptr %12
  %124 = load ptr, ptr %119
  %125 = call ptr @read_ident(ptr %123, ptr %124, i32 8)
  store ptr %125, ptr %121
  %126 = load ptr, ptr %121
  %127 = ptrtoint ptr %126 to i64
  %128 = load ptr, ptr %119
  %129 = call ptr @macro_find(ptr %128)
  %130 = icmp ne ptr %129, 0
  %131 = zext i1 %130 to i64
  store i32 %131, ptr %91
  br label %L19
L18:
  %132 = load ptr, ptr %12
  %133 = call i32 @atoi(ptr %132)
  %135 = sext i32 %133 to i64
  %136 = sext i32 0 to i64
  %134 = icmp ne i64 %135, %136
  %137 = zext i1 %134 to i64
  store i32 %137, ptr %91
  br label %L19
L19:
  %138 = load i32, ptr %10
  %140 = sext i32 %138 to i64
  %141 = sext i32 32 to i64
  %139 = icmp slt i64 %140, %141
  %142 = zext i1 %139 to i64
  %143 = icmp ne i64 %142, 0
  br i1 %143, label %L23, label %L25
L23:
  %144 = load i32, ptr %91
  %145 = load i32, ptr %10
  %147 = sext i32 %145 to i64
  %146 = add i64 %147, 1
  store i64 %146, ptr %10
  %148 = getelementptr i8, ptr %8, i64 %145
  store i32 %144, ptr %148
  br label %L25
L25:
  ret void
L26:
  br label %L16
L16:
  %149 = load ptr, ptr %16
  %150 = getelementptr [5 x i8], ptr @.str12, i64 0, i64 0
  %151 = call i32 @strcmp(ptr %149, ptr %150)
  %153 = sext i32 %151 to i64
  %154 = sext i32 0 to i64
  %152 = icmp eq i64 %153, %154
  %155 = zext i1 %152 to i64
  %156 = icmp ne i64 %155, 0
  br i1 %156, label %L27, label %L29
L27:
  %157 = load i32, ptr %10
  %159 = sext i32 %157 to i64
  %160 = sext i32 0 to i64
  %158 = icmp sgt i64 %159, %160
  %161 = zext i1 %158 to i64
  %162 = icmp ne i64 %161, 0
  br i1 %162, label %L30, label %L32
L30:
  %163 = alloca i32
  %165 = load ptr, ptr %12
  %166 = call i32 @atoi(ptr %165)
  %168 = sext i32 %166 to i64
  %169 = sext i32 0 to i64
  %167 = icmp ne i64 %168, %169
  %170 = zext i1 %167 to i64
  store i32 %170, ptr %163
  %171 = load i32, ptr %163
  %172 = load i32, ptr %10
  %174 = sext i32 %172 to i64
  %175 = sext i32 1 to i64
  %173 = sub i64 %174, %175
  %176 = getelementptr i8, ptr %8, i64 %173
  store i32 %171, ptr %176
  br label %L32
L32:
  ret void
L33:
  br label %L29
L29:
  %177 = load ptr, ptr %16
  %178 = getelementptr [5 x i8], ptr @.str13, i64 0, i64 0
  %179 = call i32 @strcmp(ptr %177, ptr %178)
  %181 = sext i32 %179 to i64
  %182 = sext i32 0 to i64
  %180 = icmp eq i64 %181, %182
  %183 = zext i1 %180 to i64
  %184 = icmp ne i64 %183, 0
  br i1 %184, label %L34, label %L36
L34:
  %185 = load i32, ptr %10
  %187 = sext i32 %185 to i64
  %188 = sext i32 0 to i64
  %186 = icmp sgt i64 %187, %188
  %189 = zext i1 %186 to i64
  %190 = icmp ne i64 %189, 0
  br i1 %190, label %L37, label %L39
L37:
  %191 = load i32, ptr %10
  %193 = sext i32 %191 to i64
  %194 = sext i32 1 to i64
  %192 = sub i64 %193, %194
  %195 = getelementptr i32, ptr %8, i64 %192
  %196 = load i32, ptr %195
  %198 = sext i32 %196 to i64
  %199 = sext i32 1 to i64
  %197 = xor i64 %198, %199
  %200 = load i32, ptr %10
  %202 = sext i32 %200 to i64
  %203 = sext i32 1 to i64
  %201 = sub i64 %202, %203
  %204 = getelementptr i8, ptr %8, i64 %201
  store i64 %197, ptr %204
  br label %L39
L39:
  ret void
L40:
  br label %L36
L36:
  %205 = load ptr, ptr %16
  %206 = getelementptr [6 x i8], ptr @.str14, i64 0, i64 0
  %207 = call i32 @strcmp(ptr %205, ptr %206)
  %209 = sext i32 %207 to i64
  %210 = sext i32 0 to i64
  %208 = icmp eq i64 %209, %210
  %211 = zext i1 %208 to i64
  %212 = icmp ne i64 %211, 0
  br i1 %212, label %L41, label %L43
L41:
  %213 = load i32, ptr %10
  %215 = sext i32 %213 to i64
  %216 = sext i32 0 to i64
  %214 = icmp sgt i64 %215, %216
  %217 = zext i1 %214 to i64
  %218 = icmp ne i64 %217, 0
  br i1 %218, label %L44, label %L46
L44:
  %219 = load i32, ptr %10
  %221 = sext i32 %219 to i64
  %220 = sub i64 %221, 1
  store i64 %220, ptr %10
  br label %L46
L46:
  ret void
L47:
  br label %L43
L43:
  %222 = alloca i32
  store i32 1, ptr %222
  %224 = alloca i32
  store i32 0, ptr %224
  br label %L48
L48:
  %226 = load i32, ptr %224
  %227 = load i32, ptr %10
  %229 = sext i32 %226 to i64
  %230 = sext i32 %227 to i64
  %228 = icmp slt i64 %229, %230
  %231 = zext i1 %228 to i64
  %232 = icmp ne i64 %231, 0
  br i1 %232, label %L49, label %L51
L49:
  %233 = load i32, ptr %224
  %234 = getelementptr i32, ptr %8, i64 %233
  %235 = load i32, ptr %234
  %237 = icmp eq i64 %235, 0
  %236 = zext i1 %237 to i64
  %238 = icmp ne i64 %236, 0
  br i1 %238, label %L52, label %L54
L52:
  store i32 0, ptr %222
  br label %L51
L55:
  br label %L54
L54:
  br label %L50
L50:
  %239 = load i32, ptr %224
  %241 = sext i32 %239 to i64
  %240 = add i64 %241, 1
  store i64 %240, ptr %224
  br label %L48
L51:
  %242 = load i32, ptr %222
  %244 = icmp eq i64 %242, 0
  %243 = zext i1 %244 to i64
  %245 = icmp ne i64 %243, 0
  br i1 %245, label %L56, label %L58
L56:
  ret void
L59:
  br label %L58
L58:
  %246 = load ptr, ptr %16
  %247 = getelementptr [7 x i8], ptr @.str15, i64 0, i64 0
  %248 = call i32 @strcmp(ptr %246, ptr %247)
  %250 = sext i32 %248 to i64
  %251 = sext i32 0 to i64
  %249 = icmp eq i64 %250, %251
  %252 = zext i1 %249 to i64
  %253 = icmp ne i64 %252, 0
  br i1 %253, label %L60, label %L62
L60:
  %254 = alloca ptr
  %256 = load ptr, ptr %12
  %257 = load ptr, ptr %254
  %258 = call ptr @read_ident(ptr %256, ptr %257, i32 8)
  store ptr %258, ptr %12
  %259 = load ptr, ptr %12
  %260 = load i8, ptr %259
  %262 = sext i32 %260 to i64
  %263 = sext i32 40 to i64
  %261 = icmp eq i64 %262, %263
  %264 = zext i1 %261 to i64
  %265 = icmp ne i64 %264, 0
  br i1 %265, label %L63, label %L64
L63:
  %266 = load ptr, ptr %12
  %268 = sext i32 %266 to i64
  %267 = add i64 %268, 1
  store i64 %267, ptr %12
  %269 = alloca ptr
  %271 = alloca i32
  store i32 0, ptr %271
  br label %L66
L66:
  %273 = load ptr, ptr %12
  %274 = load i8, ptr %273
  %275 = load ptr, ptr %12
  %276 = load i8, ptr %275
  %278 = sext i32 %276 to i64
  %279 = sext i32 41 to i64
  %277 = icmp ne i64 %278, %279
  %280 = zext i1 %277 to i64
  %282 = sext i32 %274 to i64
  %283 = sext i32 %280 to i64
  %284 = icmp ne i64 %282, 0
  %285 = icmp ne i64 %283, 0
  %286 = and i1 %284, %285
  %287 = zext i1 %286 to i64
  %288 = icmp ne i64 %287, 0
  br i1 %288, label %L67, label %L68
L67:
  %289 = load ptr, ptr %12
  %290 = call ptr @skip_ws(ptr %289)
  store ptr %290, ptr %12
  %291 = load ptr, ptr %12
  %292 = load i8, ptr %291
  %294 = sext i32 %292 to i64
  %295 = sext i32 41 to i64
  %293 = icmp eq i64 %294, %295
  %296 = zext i1 %293 to i64
  %297 = icmp ne i64 %296, 0
  br i1 %297, label %L69, label %L71
L69:
  br label %L68
L72:
  br label %L71
L71:
  %298 = alloca ptr
  %300 = load ptr, ptr %12
  %301 = load ptr, ptr %298
  %302 = call ptr @read_ident(ptr %300, ptr %301, i32 8)
  store ptr %302, ptr %12
  %303 = load ptr, ptr %298
  %304 = call i32 @strdup(ptr %303)
  %305 = load ptr, ptr %269
  %306 = load i32, ptr %271
  %308 = sext i32 %306 to i64
  %307 = add i64 %308, 1
  store i64 %307, ptr %271
  %309 = getelementptr i8, ptr %305, i64 %306
  store i32 %304, ptr %309
  %310 = load ptr, ptr %12
  %311 = call ptr @skip_ws(ptr %310)
  store ptr %311, ptr %12
  %312 = load ptr, ptr %12
  %313 = load i8, ptr %312
  %315 = sext i32 %313 to i64
  %316 = sext i32 44 to i64
  %314 = icmp eq i64 %315, %316
  %317 = zext i1 %314 to i64
  %318 = icmp ne i64 %317, 0
  br i1 %318, label %L73, label %L75
L73:
  %319 = load ptr, ptr %12
  %321 = sext i32 %319 to i64
  %320 = add i64 %321, 1
  store i64 %320, ptr %12
  br label %L75
L75:
  br label %L66
L68:
  %322 = load ptr, ptr %12
  %323 = load i8, ptr %322
  %325 = sext i32 %323 to i64
  %326 = sext i32 41 to i64
  %324 = icmp eq i64 %325, %326
  %327 = zext i1 %324 to i64
  %328 = icmp ne i64 %327, 0
  br i1 %328, label %L76, label %L78
L76:
  %329 = load ptr, ptr %12
  %331 = sext i32 %329 to i64
  %330 = add i64 %331, 1
  store i64 %330, ptr %12
  br label %L78
L78:
  %332 = load ptr, ptr %12
  %333 = call ptr @skip_ws(ptr %332)
  store ptr %333, ptr %12
  %334 = alloca ptr
  %336 = load ptr, ptr %12
  store ptr %336, ptr %334
  %337 = alloca ptr
  %339 = load ptr, ptr %12
  %340 = call ptr @skip_to_eol(ptr %339)
  store ptr %340, ptr %337
  %341 = alloca ptr
  %343 = load ptr, ptr %337
  %344 = load ptr, ptr %334
  %345 = sub ptr %343, %344
  %346 = getelementptr i8, ptr %345, i64 1
  %347 = call i32 @malloc(ptr %346)
  store ptr %347, ptr %341
  %348 = load ptr, ptr %341
  %349 = load ptr, ptr %334
  %350 = load ptr, ptr %337
  %351 = load ptr, ptr %334
  %352 = sub ptr %350, %351
  %353 = call i32 @memcpy(ptr %348, ptr %349, ptr %352)
  %354 = load ptr, ptr %341
  %355 = load ptr, ptr %337
  %356 = load ptr, ptr %334
  %357 = sub ptr %355, %356
  %358 = getelementptr i8, ptr %354, i64 %357
  store i8 0, ptr %358
  %359 = load ptr, ptr %254
  %360 = load ptr, ptr %341
  %361 = load ptr, ptr %269
  %362 = load i32, ptr %271
  call void @macro_define(ptr %359, ptr %360, ptr %361, i32 %362, i32 1)
  %364 = load ptr, ptr %341
  %365 = call i32 @free(ptr %364)
  %366 = alloca i32
  store i32 0, ptr %366
  br label %L79
L79:
  %368 = load i32, ptr %366
  %369 = load i32, ptr %271
  %371 = sext i32 %368 to i64
  %372 = sext i32 %369 to i64
  %370 = icmp slt i64 %371, %372
  %373 = zext i1 %370 to i64
  %374 = icmp ne i64 %373, 0
  br i1 %374, label %L80, label %L82
L80:
  %375 = load ptr, ptr %269
  %376 = load i32, ptr %366
  %377 = getelementptr ptr, ptr %375, i64 %376
  %378 = load ptr, ptr %377
  %379 = call i32 @free(ptr %378)
  br label %L81
L81:
  %380 = load i32, ptr %366
  %382 = sext i32 %380 to i64
  %381 = add i64 %382, 1
  store i64 %381, ptr %366
  br label %L79
L82:
  br label %L65
L64:
  %383 = load ptr, ptr %12
  %384 = load i8, ptr %383
  %386 = sext i32 %384 to i64
  %387 = sext i32 32 to i64
  %385 = icmp eq i64 %386, %387
  %388 = zext i1 %385 to i64
  %389 = load ptr, ptr %12
  %390 = load i8, ptr %389
  %392 = sext i32 %390 to i64
  %393 = sext i32 9 to i64
  %391 = icmp eq i64 %392, %393
  %394 = zext i1 %391 to i64
  %396 = sext i32 %388 to i64
  %397 = sext i32 %394 to i64
  %398 = icmp ne i64 %396, 0
  %399 = icmp ne i64 %397, 0
  %400 = or i1 %398, %399
  %401 = zext i1 %400 to i64
  %402 = icmp ne i64 %401, 0
  br i1 %402, label %L83, label %L85
L83:
  %403 = load ptr, ptr %12
  %405 = sext i32 %403 to i64
  %404 = add i64 %405, 1
  store i64 %404, ptr %12
  br label %L85
L85:
  %406 = alloca ptr
  %408 = load ptr, ptr %12
  store ptr %408, ptr %406
  %409 = alloca ptr
  %411 = load ptr, ptr %12
  %412 = call ptr @skip_to_eol(ptr %411)
  store ptr %412, ptr %409
  %413 = alloca ptr
  %415 = load ptr, ptr %409
  %416 = load ptr, ptr %406
  %417 = sub ptr %415, %416
  %418 = getelementptr i8, ptr %417, i64 1
  %419 = call i32 @malloc(ptr %418)
  store ptr %419, ptr %413
  %420 = load ptr, ptr %413
  %421 = load ptr, ptr %406
  %422 = load ptr, ptr %409
  %423 = load ptr, ptr %406
  %424 = sub ptr %422, %423
  %425 = call i32 @memcpy(ptr %420, ptr %421, ptr %424)
  %426 = load ptr, ptr %413
  %427 = load ptr, ptr %409
  %428 = load ptr, ptr %406
  %429 = sub ptr %427, %428
  %430 = getelementptr i8, ptr %426, i64 %429
  store i8 0, ptr %430
  %431 = load ptr, ptr %254
  %432 = load ptr, ptr %413
  call void @macro_define(ptr %431, ptr %432, i32 0, i32 0, i32 0)
  %434 = load ptr, ptr %413
  %435 = call i32 @free(ptr %434)
  br label %L65
L65:
  ret void
L86:
  br label %L62
L62:
  %436 = load ptr, ptr %16
  %437 = getelementptr [6 x i8], ptr @.str16, i64 0, i64 0
  %438 = call i32 @strcmp(ptr %436, ptr %437)
  %440 = sext i32 %438 to i64
  %441 = sext i32 0 to i64
  %439 = icmp eq i64 %440, %441
  %442 = zext i1 %439 to i64
  %443 = icmp ne i64 %442, 0
  br i1 %443, label %L87, label %L89
L87:
  %444 = alloca ptr
  %446 = load ptr, ptr %12
  %447 = load ptr, ptr %444
  %448 = call ptr @read_ident(ptr %446, ptr %447, i32 8)
  %449 = load ptr, ptr %444
  call void @macro_undef(ptr %449)
  ret void
L90:
  br label %L89
L89:
  %451 = load ptr, ptr %16
  %452 = getelementptr [8 x i8], ptr @.str17, i64 0, i64 0
  %453 = call i32 @strcmp(ptr %451, ptr %452)
  %455 = sext i32 %453 to i64
  %456 = sext i32 0 to i64
  %454 = icmp eq i64 %455, %456
  %457 = zext i1 %454 to i64
  %458 = icmp ne i64 %457, 0
  br i1 %458, label %L91, label %L93
L91:
  %460 = sext i32 %6 to i64
  %461 = sext i32 32 to i64
  %459 = icmp sgt i64 %460, %461
  %462 = zext i1 %459 to i64
  %463 = icmp ne i64 %462, 0
  br i1 %463, label %L94, label %L96
L94:
  %464 = getelementptr [36 x i8], ptr @.str18, i64 0, i64 0
  %465 = call i32 @fprintf(ptr @stderr, ptr %464)
  ret void
L97:
  br label %L96
L96:
  %466 = alloca i32
  store i32 0, ptr %466
  %468 = alloca ptr
  %470 = load ptr, ptr %12
  %471 = load i8, ptr %470
  %473 = sext i32 %471 to i64
  %474 = sext i32 34 to i64
  %472 = icmp eq i64 %473, %474
  %475 = zext i1 %472 to i64
  %476 = icmp ne i64 %475, 0
  br i1 %476, label %L98, label %L99
L98:
  %477 = load ptr, ptr %12
  %479 = sext i32 %477 to i64
  %478 = add i64 %479, 1
  store i64 %478, ptr %12
  %480 = alloca ptr
  %482 = load ptr, ptr %12
  %483 = call i32 @strchr(ptr %482, i8 34)
  store ptr %483, ptr %480
  %484 = load ptr, ptr %480
  %486 = icmp eq i64 %484, 0
  %485 = zext i1 %486 to i64
  %487 = icmp ne i64 %485, 0
  br i1 %487, label %L101, label %L103
L101:
  ret void
L104:
  br label %L103
L103:
  %488 = alloca i64
  %490 = load ptr, ptr %480
  %491 = load ptr, ptr %12
  %492 = sub ptr %490, %491
  %493 = ptrtoint ptr %492 to i64
  store i64 %493, ptr %488
  %494 = load ptr, ptr %468
  %495 = load ptr, ptr %12
  %496 = load i64, ptr %488
  %497 = call i32 @memcpy(ptr %494, ptr %495, i64 %496)
  %498 = load ptr, ptr %468
  %499 = load i64, ptr %488
  %500 = getelementptr i8, ptr %498, i64 %499
  store i8 0, ptr %500
  br label %L100
L99:
  %501 = load ptr, ptr %12
  %502 = load i8, ptr %501
  %504 = sext i32 %502 to i64
  %505 = sext i32 60 to i64
  %503 = icmp eq i64 %504, %505
  %506 = zext i1 %503 to i64
  %507 = icmp ne i64 %506, 0
  br i1 %507, label %L105, label %L106
L105:
  %508 = load ptr, ptr %12
  %510 = sext i32 %508 to i64
  %509 = add i64 %510, 1
  store i64 %509, ptr %12
  %511 = alloca ptr
  %513 = load ptr, ptr %12
  %514 = call i32 @strchr(ptr %513, i8 62)
  store ptr %514, ptr %511
  %515 = load ptr, ptr %511
  %517 = icmp eq i64 %515, 0
  %516 = zext i1 %517 to i64
  %518 = icmp ne i64 %516, 0
  br i1 %518, label %L108, label %L110
L108:
  ret void
L111:
  br label %L110
L110:
  %519 = alloca i64
  %521 = load ptr, ptr %511
  %522 = load ptr, ptr %12
  %523 = sub ptr %521, %522
  %524 = ptrtoint ptr %523 to i64
  store i64 %524, ptr %519
  %525 = load ptr, ptr %468
  %526 = load ptr, ptr %12
  %527 = load i64, ptr %519
  %528 = call i32 @memcpy(ptr %525, ptr %526, i64 %527)
  %529 = load ptr, ptr %468
  %530 = load i64, ptr %519
  %531 = getelementptr i8, ptr %529, i64 %530
  store i8 0, ptr %531
  store i32 1, ptr %466
  br label %L107
L106:
  ret void
L112:
  br label %L107
L107:
  br label %L100
L100:
  %532 = alloca ptr
  %534 = load ptr, ptr %468
  %535 = load i32, ptr %466
  %536 = call ptr @find_include(ptr %534, i32 %535)
  store ptr %536, ptr %532
  %537 = load ptr, ptr %532
  %539 = icmp eq i64 %537, 0
  %538 = zext i1 %539 to i64
  %540 = icmp ne i64 %538, 0
  br i1 %540, label %L113, label %L115
L113:
  %541 = getelementptr [2 x i8], ptr @.str19, i64 0, i64 0
  call void @buf_append(ptr %4, ptr %541, i32 1)
  ret void
L116:
  br label %L115
L115:
  %543 = alloca ptr
  %545 = load ptr, ptr %532
  %546 = load ptr, ptr %468
  %548 = sext i32 %6 to i64
  %549 = sext i32 1 to i64
  %547 = add i64 %548, %549
  %550 = call ptr @macro_preprocess(ptr %545, ptr %546, i32 %547)
  store ptr %550, ptr %543
  %551 = load ptr, ptr %532
  %552 = call i32 @free(ptr %551)
  %553 = load ptr, ptr %543
  %554 = load ptr, ptr %543
  %555 = call i32 @strlen(ptr %554)
  call void @buf_append(ptr %4, ptr %553, i32 %555)
  call void @buf_putc(ptr %4, i8 10)
  %558 = load ptr, ptr %543
  %559 = call i32 @free(ptr %558)
  ret void
L117:
  br label %L93
L93:
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
  %42 = alloca ptr
  %44 = load ptr, ptr %12
  store ptr %44, ptr %42
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
  %90 = sext i32 34 to i64
  %88 = icmp eq i64 %89, %90
  %91 = zext i1 %88 to i64
  %92 = icmp ne i64 %91, 0
  br i1 %92, label %L14, label %L16
L14:
  %93 = load ptr, ptr %12
  %95 = sext i32 %93 to i64
  %94 = add i64 %95, 1
  store i64 %94, ptr %12
  br label %L17
L17:
  %96 = load ptr, ptr %12
  %97 = load i8, ptr %96
  %98 = load ptr, ptr %12
  %99 = load i8, ptr %98
  %101 = sext i32 %99 to i64
  %102 = sext i32 34 to i64
  %100 = icmp ne i64 %101, %102
  %103 = zext i1 %100 to i64
  %105 = sext i32 %97 to i64
  %106 = sext i32 %103 to i64
  %107 = icmp ne i64 %105, 0
  %108 = icmp ne i64 %106, 0
  %109 = and i1 %107, %108
  %110 = zext i1 %109 to i64
  %111 = icmp ne i64 %110, 0
  br i1 %111, label %L18, label %L19
L18:
  %112 = load ptr, ptr %12
  %113 = load i8, ptr %112
  %115 = sext i32 %113 to i64
  %116 = sext i32 92 to i64
  %114 = icmp eq i64 %115, %116
  %117 = zext i1 %114 to i64
  %118 = load ptr, ptr %12
  %119 = getelementptr i8, ptr %118, i64 1
  %120 = load i8, ptr %119
  %122 = sext i32 %117 to i64
  %123 = sext i32 %120 to i64
  %124 = icmp ne i64 %122, 0
  %125 = icmp ne i64 %123, 0
  %126 = and i1 %124, %125
  %127 = zext i1 %126 to i64
  %128 = icmp ne i64 %127, 0
  br i1 %128, label %L20, label %L22
L20:
  %129 = load ptr, ptr %12
  %131 = sext i32 %129 to i64
  %130 = add i64 %131, 1
  store i64 %130, ptr %12
  br label %L22
L22:
  %132 = load ptr, ptr %12
  %134 = sext i32 %132 to i64
  %133 = add i64 %134, 1
  store i64 %133, ptr %12
  br label %L17
L19:
  %135 = load ptr, ptr %12
  %136 = load i8, ptr %135
  %137 = icmp ne i64 %136, 0
  br i1 %137, label %L23, label %L25
L23:
  %138 = load ptr, ptr %12
  %140 = sext i32 %138 to i64
  %139 = add i64 %140, 1
  store i64 %139, ptr %12
  br label %L25
L25:
  br label %L7
L26:
  br label %L16
L16:
  %141 = load ptr, ptr %12
  %143 = sext i32 %141 to i64
  %142 = add i64 %143, 1
  store i64 %142, ptr %12
  br label %L7
L9:
  %144 = alloca i64
  %146 = load ptr, ptr %12
  %147 = load ptr, ptr %42
  %148 = sub ptr %146, %147
  %149 = ptrtoint ptr %148 to i64
  store i64 %149, ptr %144
  %150 = alloca ptr
  %152 = load i64, ptr %144
  %154 = sext i32 %152 to i64
  %155 = sext i32 1 to i64
  %153 = add i64 %154, %155
  %156 = call i32 @malloc(i64 %153)
  store ptr %156, ptr %150
  %157 = load ptr, ptr %150
  %158 = load ptr, ptr %42
  %159 = load i64, ptr %144
  %160 = call i32 @memcpy(ptr %157, ptr %158, i64 %159)
  %161 = load ptr, ptr %150
  %162 = load i64, ptr %144
  %163 = getelementptr i8, ptr %161, i64 %162
  store i8 0, ptr %163
  %164 = load ptr, ptr %12
  %165 = load i8, ptr %164
  %167 = sext i32 %165 to i64
  %168 = sext i32 10 to i64
  %166 = icmp eq i64 %167, %168
  %169 = zext i1 %166 to i64
  %170 = icmp ne i64 %169, 0
  br i1 %170, label %L27, label %L29
L27:
  %171 = load ptr, ptr %12
  %173 = sext i32 %171 to i64
  %172 = add i64 %173, 1
  store i64 %172, ptr %12
  br label %L29
L29:
  %174 = alloca ptr
  %176 = load ptr, ptr %150
  %177 = call ptr @skip_ws(ptr %176)
  store ptr %177, ptr %174
  %178 = load ptr, ptr %174
  %179 = load i8, ptr %178
  %181 = sext i32 %179 to i64
  %182 = sext i32 35 to i64
  %180 = icmp eq i64 %181, %182
  %183 = zext i1 %180 to i64
  %184 = icmp ne i64 %183, 0
  br i1 %184, label %L30, label %L31
L30:
  %185 = load ptr, ptr %174
  call void @process_directive(ptr %185, ptr %2, ptr %4, i32 %6, ptr %8, ptr %10)
  br label %L32
L31:
  %187 = alloca i32
  store i32 1, ptr %187
  %189 = alloca i32
  store i32 0, ptr %189
  br label %L33
L33:
  %191 = load i32, ptr %189
  %192 = load i32, ptr %10
  %194 = sext i32 %191 to i64
  %195 = sext i32 %192 to i64
  %193 = icmp slt i64 %194, %195
  %196 = zext i1 %193 to i64
  %197 = icmp ne i64 %196, 0
  br i1 %197, label %L34, label %L36
L34:
  %198 = load i32, ptr %189
  %199 = getelementptr i32, ptr %8, i64 %198
  %200 = load i32, ptr %199
  %202 = icmp eq i64 %200, 0
  %201 = zext i1 %202 to i64
  %203 = icmp ne i64 %201, 0
  br i1 %203, label %L37, label %L39
L37:
  store i32 0, ptr %187
  br label %L36
L40:
  br label %L39
L39:
  br label %L35
L35:
  %204 = load i32, ptr %189
  %206 = sext i32 %204 to i64
  %205 = add i64 %206, 1
  store i64 %205, ptr %189
  br label %L33
L36:
  %207 = load i32, ptr %187
  %208 = icmp ne i64 %207, 0
  br i1 %208, label %L41, label %L42
L41:
  %209 = load ptr, ptr %150
  call void @expand_text(ptr %209, ptr %4, i32 0)
  call void @buf_putc(ptr %4, i8 10)
  br label %L43
L42:
  call void @buf_putc(ptr %4, i8 10)
  br label %L43
L43:
  br label %L32
L32:
  %213 = load ptr, ptr %150
  %214 = call i32 @free(ptr %213)
  br label %L0
L2:
  ret void
}

define dso_local ptr @macro_preprocess(ptr %0, ptr %2, i32 %4) {
entry:
  %6 = alloca i64
  call void @buf_init(ptr %6)
  %9 = alloca ptr
  %11 = alloca i32
  store i32 0, ptr %11
  br label %L0
L0:
  %13 = load i32, ptr %11
  %15 = sext i32 %13 to i64
  %16 = sext i32 64 to i64
  %14 = icmp slt i64 %15, %16
  %17 = zext i1 %14 to i64
  %18 = icmp ne i64 %17, 0
  br i1 %18, label %L1, label %L3
L1:
  %19 = load ptr, ptr %9
  %20 = load i32, ptr %11
  %21 = getelementptr i8, ptr %19, i64 %20
  store i32 0, ptr %21
  br label %L2
L2:
  %22 = load i32, ptr %11
  %24 = sext i32 %22 to i64
  %23 = add i64 %24, 1
  store i64 %23, ptr %11
  br label %L0
L3:
  %25 = alloca i32
  store i32 0, ptr %25
  %28 = sext i32 %4 to i64
  %29 = sext i32 0 to i64
  %27 = icmp eq i64 %28, %29
  %30 = zext i1 %27 to i64
  %31 = icmp ne i64 %30, 0
  br i1 %31, label %L4, label %L6
L4:
  %32 = getelementptr [8 x i8], ptr @.str20, i64 0, i64 0
  %33 = getelementptr [2 x i8], ptr @.str21, i64 0, i64 0
  call void @macro_define(ptr %32, ptr %33, i32 0, i32 0, i32 0)
  %35 = getelementptr [9 x i8], ptr @.str22, i64 0, i64 0
  %36 = getelementptr [2 x i8], ptr @.str23, i64 0, i64 0
  call void @macro_define(ptr %35, ptr %36, i32 0, i32 0, i32 0)
  %38 = getelementptr [5 x i8], ptr @.str24, i64 0, i64 0
  %39 = getelementptr [2 x i8], ptr @.str25, i64 0, i64 0
  call void @macro_define(ptr %38, ptr %39, i32 0, i32 0, i32 0)
  %41 = getelementptr [9 x i8], ptr @.str26, i64 0, i64 0
  %42 = getelementptr [2 x i8], ptr @.str27, i64 0, i64 0
  call void @macro_define(ptr %41, ptr %42, i32 0, i32 0, i32 0)
  br label %L6
L6:
  %44 = load ptr, ptr %9
  call void @preprocess_into(ptr %0, ptr %2, ptr %6, i32 %4, ptr %44, ptr %25)
  %46 = load i64, ptr %6
  ret ptr %46
L7:
  ret ptr 0
}

@.str0 = private unnamed_addr constant [7 x i8] c"malloc\00"
@.str1 = private unnamed_addr constant [8 x i8] c"realloc\00"
@.str2 = private unnamed_addr constant [18 x i8] c"macro table full\0A\00"
@.str3 = private unnamed_addr constant [2 x i8] c"r\00"
@.str4 = private unnamed_addr constant [13 x i8] c"/usr/include\00"
@.str5 = private unnamed_addr constant [19 x i8] c"/usr/local/include\00"
@.str6 = private unnamed_addr constant [2 x i8] c".\00"
@.str7 = private unnamed_addr constant [6 x i8] c"%s/%s\00"
@.str8 = private unnamed_addr constant [6 x i8] c"ifdef\00"
@.str9 = private unnamed_addr constant [7 x i8] c"ifndef\00"
@.str10 = private unnamed_addr constant [3 x i8] c"if\00"
@.str11 = private unnamed_addr constant [8 x i8] c"defined\00"
@.str12 = private unnamed_addr constant [5 x i8] c"elif\00"
@.str13 = private unnamed_addr constant [5 x i8] c"else\00"
@.str14 = private unnamed_addr constant [6 x i8] c"endif\00"
@.str15 = private unnamed_addr constant [7 x i8] c"define\00"
@.str16 = private unnamed_addr constant [6 x i8] c"undef\00"
@.str17 = private unnamed_addr constant [8 x i8] c"include\00"
@.str18 = private unnamed_addr constant [36 x i8] c"warning: max include depth reached\0A\00"
@.str19 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str20 = private unnamed_addr constant [8 x i8] c"__C0C__\00"
@.str21 = private unnamed_addr constant [2 x i8] c"1\00"
@.str22 = private unnamed_addr constant [9 x i8] c"__STDC__\00"
@.str23 = private unnamed_addr constant [2 x i8] c"1\00"
@.str24 = private unnamed_addr constant [5 x i8] c"NULL\00"
@.str25 = private unnamed_addr constant [2 x i8] c"0\00"
@.str26 = private unnamed_addr constant [9 x i8] c"__LP64__\00"
@.str27 = private unnamed_addr constant [2 x i8] c"1\00"
