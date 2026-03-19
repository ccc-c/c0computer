; ModuleID = 'codegen.c'
source_filename = "codegen.c"
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
@codegen_new = dso_local global ptr zeroinitializer
@codegen_free = dso_local global ptr zeroinitializer
@codegen_emit = dso_local global ptr zeroinitializer
@lexer_new = dso_local global ptr zeroinitializer
@lexer_free = dso_local global ptr zeroinitializer
@lexer_next = dso_local global ptr zeroinitializer
@lexer_peek = dso_local global ptr zeroinitializer
@token_free = dso_local global ptr zeroinitializer
@token_type_name = dso_local global ptr zeroinitializer
@tbufs = internal global ptr zeroinitializer
@tbuf_idx = internal global i32 zeroinitializer
@emit_expr = internal global ptr zeroinitializer
@emit_stmt = internal global ptr zeroinitializer
@emit_func_def = internal global ptr zeroinitializer
@emit_global_var = internal global ptr zeroinitializer

define internal i32 @new_reg(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %4 = sext i32 %2 to i64
  %3 = add i64 %4, 1
  store i64 %3, ptr %0
  ret i32 %2
L0:
  ret i32 0
}

define internal i32 @new_label(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %4 = sext i32 %2 to i64
  %3 = add i64 %4, 1
  store i64 %3, ptr %0
  ret i32 %2
L0:
  ret i32 0
}

define internal void @emit(ptr %0, ptr %2, ...) {
entry:
  %4 = alloca i64
  %6 = load i64, ptr %4
  %7 = call i32 @va_start(i64 %6, ptr %2)
  %8 = load i64, ptr %0
  %9 = load i64, ptr %4
  %10 = call i32 @vfprintf(i32 %8, ptr %2, i64 %9)
  %11 = load i64, ptr %4
  %12 = call i32 @va_end(i64 %11)
  ret void
}

define internal ptr @llvm_type(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = load ptr, ptr @tbufs
  %5 = load i32, ptr @tbuf_idx
  %7 = sext i32 %5 to i64
  %6 = add i64 %7, 1
  store i64 %6, ptr @tbuf_idx
  %9 = sext i32 %5 to i64
  %10 = sext i32 8 to i64
  %8 = srem i64 %9, %10
  %11 = getelementptr ptr, ptr %4, i64 %8
  %12 = load ptr, ptr %11
  store ptr %12, ptr %2
  %14 = icmp eq i64 %0, 0
  %13 = zext i1 %14 to i64
  %15 = icmp ne i64 %13, 0
  br i1 %15, label %L0, label %L2
L0:
  %16 = load ptr, ptr %2
  %17 = getelementptr [4 x i8], ptr @.str0, i64 0, i64 0
  %18 = call i32 @strcpy(ptr %16, ptr %17)
  %19 = load ptr, ptr %2
  ret ptr %19
L3:
  br label %L2
L2:
  %20 = load i64, ptr %0
  %21 = sext i32 %20 to i64
  switch i64 %21, label %L27 [
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
    i64 0, label %L19
    i64 0, label %L20
    i64 0, label %L21
    i64 0, label %L22
    i64 0, label %L23
    i64 0, label %L24
    i64 0, label %L25
    i64 0, label %L26
  ]
L5:
  %22 = load ptr, ptr %2
  %23 = getelementptr [5 x i8], ptr @.str1, i64 0, i64 0
  %24 = call i32 @strcpy(ptr %22, ptr %23)
  br label %L4
L28:
  br label %L6
L6:
  %25 = load ptr, ptr %2
  %26 = getelementptr [3 x i8], ptr @.str2, i64 0, i64 0
  %27 = call i32 @strcpy(ptr %25, ptr %26)
  br label %L4
L29:
  br label %L7
L7:
  br label %L8
L8:
  br label %L9
L9:
  %28 = load ptr, ptr %2
  %29 = getelementptr [3 x i8], ptr @.str3, i64 0, i64 0
  %30 = call i32 @strcpy(ptr %28, ptr %29)
  br label %L4
L30:
  br label %L10
L10:
  br label %L11
L11:
  %31 = load ptr, ptr %2
  %32 = getelementptr [4 x i8], ptr @.str4, i64 0, i64 0
  %33 = call i32 @strcpy(ptr %31, ptr %32)
  br label %L4
L31:
  br label %L12
L12:
  br label %L13
L13:
  br label %L14
L14:
  %34 = load ptr, ptr %2
  %35 = getelementptr [4 x i8], ptr @.str5, i64 0, i64 0
  %36 = call i32 @strcpy(ptr %34, ptr %35)
  br label %L4
L32:
  br label %L15
L15:
  br label %L16
L16:
  br label %L17
L17:
  br label %L18
L18:
  %37 = load ptr, ptr %2
  %38 = getelementptr [4 x i8], ptr @.str6, i64 0, i64 0
  %39 = call i32 @strcpy(ptr %37, ptr %38)
  br label %L4
L33:
  br label %L19
L19:
  %40 = load ptr, ptr %2
  %41 = getelementptr [6 x i8], ptr @.str7, i64 0, i64 0
  %42 = call i32 @strcpy(ptr %40, ptr %41)
  br label %L4
L34:
  br label %L20
L20:
  %43 = load ptr, ptr %2
  %44 = getelementptr [7 x i8], ptr @.str8, i64 0, i64 0
  %45 = call i32 @strcpy(ptr %43, ptr %44)
  br label %L4
L35:
  br label %L21
L21:
  %46 = load ptr, ptr %2
  %47 = getelementptr [4 x i8], ptr @.str9, i64 0, i64 0
  %48 = call i32 @strcpy(ptr %46, ptr %47)
  br label %L4
L36:
  br label %L22
L22:
  %49 = load ptr, ptr %2
  %50 = getelementptr [4 x i8], ptr @.str10, i64 0, i64 0
  %51 = call i32 @strcpy(ptr %49, ptr %50)
  br label %L4
L37:
  br label %L23
L23:
  %52 = load ptr, ptr %2
  %53 = getelementptr [4 x i8], ptr @.str11, i64 0, i64 0
  %54 = call i32 @strcpy(ptr %52, ptr %53)
  br label %L4
L38:
  br label %L24
L24:
  br label %L25
L25:
  %55 = load i64, ptr %0
  %56 = icmp ne i64 %55, 0
  br i1 %56, label %L39, label %L40
L39:
  %57 = load ptr, ptr %2
  %58 = getelementptr [12 x i8], ptr @.str12, i64 0, i64 0
  %59 = load i64, ptr %0
  %60 = call i32 @snprintf(ptr %57, i32 256, ptr %58, i32 %59)
  br label %L41
L40:
  %61 = load ptr, ptr %2
  %62 = getelementptr [4 x i8], ptr @.str13, i64 0, i64 0
  %63 = call i32 @strcpy(ptr %61, ptr %62)
  br label %L41
L41:
  br label %L4
L42:
  br label %L26
L26:
  %64 = load ptr, ptr %2
  %65 = getelementptr [4 x i8], ptr @.str14, i64 0, i64 0
  %66 = call i32 @strcpy(ptr %64, ptr %65)
  br label %L4
L43:
  br label %L4
L27:
  %67 = load ptr, ptr %2
  %68 = getelementptr [4 x i8], ptr @.str15, i64 0, i64 0
  %69 = call i32 @strcpy(ptr %67, ptr %68)
  br label %L4
L44:
  br label %L4
L4:
  %70 = load ptr, ptr %2
  ret ptr %70
L45:
  ret ptr 0
}

define internal ptr @llvm_ret_type(ptr %0) {
entry:
  %3 = icmp eq i64 %0, 0
  %2 = zext i1 %3 to i64
  %4 = load i64, ptr %0
  %6 = sext i32 %4 to i64
  %7 = sext i32 @TY_FUNC to i64
  %5 = icmp ne i64 %6, %7
  %8 = zext i1 %5 to i64
  %10 = icmp ne i64 %2, 0
  %11 = icmp ne i64 %8, 0
  %12 = or i1 %10, %11
  %13 = zext i1 %12 to i64
  %14 = icmp ne i64 %13, 0
  br i1 %14, label %L0, label %L2
L0:
  %15 = getelementptr [4 x i8], ptr @.str16, i64 0, i64 0
  ret ptr %15
L3:
  br label %L2
L2:
  %16 = load i64, ptr %0
  %17 = call ptr @llvm_type(i32 %16)
  ret ptr %17
L4:
  ret ptr 0
}

define internal i32 @type_is_fp(ptr %0) {
entry:
  %3 = icmp eq i64 %0, 0
  %2 = zext i1 %3 to i64
  %4 = icmp ne i64 %2, 0
  br i1 %4, label %L0, label %L2
L0:
  ret i32 0
L3:
  br label %L2
L2:
  %5 = load i64, ptr %0
  %7 = sext i32 %5 to i64
  %8 = sext i32 @TY_FLOAT to i64
  %6 = icmp eq i64 %7, %8
  %9 = zext i1 %6 to i64
  %10 = load i64, ptr %0
  %12 = sext i32 %10 to i64
  %13 = sext i32 @TY_DOUBLE to i64
  %11 = icmp eq i64 %12, %13
  %14 = zext i1 %11 to i64
  %16 = sext i32 %9 to i64
  %17 = sext i32 %14 to i64
  %18 = icmp ne i64 %16, 0
  %19 = icmp ne i64 %17, 0
  %20 = or i1 %18, %19
  %21 = zext i1 %20 to i64
  ret i32 %21
L4:
  ret i32 0
}

define internal void @scope_push(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %3 = load i64, ptr %0
  %4 = load i64, ptr %0
  %6 = sext i32 %4 to i64
  %5 = add i64 %6, 1
  store i64 %5, ptr %0
  %7 = getelementptr i8, ptr %3, i64 %4
  store i32 %2, ptr %7
  ret void
}

define internal void @scope_pop(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  %5 = load i64, ptr %0
  %7 = sext i32 %5 to i64
  %6 = sub i64 %7, 1
  store i64 %6, ptr %0
  %8 = getelementptr i32, ptr %4, i64 %6
  %9 = load i32, ptr %8
  store i32 %9, ptr %2
  %10 = alloca i32
  %12 = load i32, ptr %2
  store i32 %12, ptr %10
  br label %L0
L0:
  %13 = load i32, ptr %10
  %14 = load i64, ptr %0
  %16 = sext i32 %13 to i64
  %17 = sext i32 %14 to i64
  %15 = icmp slt i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L1, label %L3
L1:
  %20 = load i64, ptr %0
  %21 = load i32, ptr %10
  %22 = getelementptr i8, ptr %20, i64 %21
  %23 = load i64, ptr %22
  %24 = call i32 @free(i32 %23)
  %25 = load i64, ptr %0
  %26 = load i32, ptr %10
  %27 = getelementptr i8, ptr %25, i64 %26
  %28 = load i64, ptr %27
  %29 = call i32 @free(i32 %28)
  br label %L2
L2:
  %30 = load i32, ptr %10
  %32 = sext i32 %30 to i64
  %31 = add i64 %32, 1
  store i64 %31, ptr %10
  br label %L0
L3:
  %33 = load i32, ptr %2
  store i32 %33, ptr %0
  ret void
}

define internal ptr @find_local(ptr %0, ptr %2) {
entry:
  %4 = alloca i32
  %6 = load i64, ptr %0
  %8 = sext i32 %6 to i64
  %9 = sext i32 1 to i64
  %7 = sub i64 %8, %9
  store i32 %7, ptr %4
  br label %L0
L0:
  %10 = load i32, ptr %4
  %12 = sext i32 %10 to i64
  %13 = sext i32 0 to i64
  %11 = icmp sge i64 %12, %13
  %14 = zext i1 %11 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %L1, label %L3
L1:
  %16 = load i64, ptr %0
  %17 = load i32, ptr %4
  %18 = getelementptr i8, ptr %16, i64 %17
  %19 = load i64, ptr %18
  %20 = call i32 @strcmp(i32 %19, ptr %2)
  %22 = sext i32 %20 to i64
  %23 = sext i32 0 to i64
  %21 = icmp eq i64 %22, %23
  %24 = zext i1 %21 to i64
  %25 = icmp ne i64 %24, 0
  br i1 %25, label %L4, label %L6
L4:
  %26 = load i64, ptr %0
  %27 = load i32, ptr %4
  %28 = getelementptr i8, ptr %26, i64 %27
  ret ptr %28
L7:
  br label %L6
L6:
  br label %L2
L2:
  %29 = load i32, ptr %4
  %31 = sext i32 %29 to i64
  %30 = sub i64 %31, 1
  store i64 %30, ptr %4
  br label %L0
L3:
  %32 = inttoptr i64 0 to ptr
  ret ptr %32
L8:
  ret ptr 0
}

define internal ptr @find_global(ptr %0, ptr %2) {
entry:
  %4 = alloca i32
  store i32 0, ptr %4
  br label %L0
L0:
  %6 = load i32, ptr %4
  %7 = load i64, ptr %0
  %9 = sext i32 %6 to i64
  %10 = sext i32 %7 to i64
  %8 = icmp slt i64 %9, %10
  %11 = zext i1 %8 to i64
  %12 = icmp ne i64 %11, 0
  br i1 %12, label %L1, label %L3
L1:
  %13 = load i64, ptr %0
  %14 = load i32, ptr %4
  %15 = getelementptr i8, ptr %13, i64 %14
  %16 = load i64, ptr %15
  %17 = call i32 @strcmp(i32 %16, ptr %2)
  %19 = sext i32 %17 to i64
  %20 = sext i32 0 to i64
  %18 = icmp eq i64 %19, %20
  %21 = zext i1 %18 to i64
  %22 = icmp ne i64 %21, 0
  br i1 %22, label %L4, label %L6
L4:
  %23 = load i64, ptr %0
  %24 = load i32, ptr %4
  %25 = getelementptr i8, ptr %23, i64 %24
  ret ptr %25
L7:
  br label %L6
L6:
  br label %L2
L2:
  %26 = load i32, ptr %4
  %28 = sext i32 %26 to i64
  %27 = add i64 %28, 1
  store i64 %27, ptr %4
  br label %L0
L3:
  %29 = inttoptr i64 0 to ptr
  ret ptr %29
L8:
  ret ptr 0
}

define internal ptr @add_local(ptr %0, ptr %2, ptr %4, i32 %6) {
entry:
  %8 = load i64, ptr %0
  %10 = sext i32 %8 to i64
  %11 = sext i32 1024 to i64
  %9 = icmp slt i64 %10, %11
  %12 = zext i1 %9 to i64
  %13 = call i32 @assert(i32 %12)
  %14 = alloca ptr
  %16 = load i64, ptr %0
  %17 = load i64, ptr %0
  %19 = sext i32 %17 to i64
  %18 = add i64 %19, 1
  store i64 %18, ptr %0
  %20 = getelementptr i8, ptr %16, i64 %17
  store ptr %20, ptr %14
  %21 = call i32 @strdup(ptr %2)
  %22 = load ptr, ptr %14
  store i32 %21, ptr %22
  %23 = alloca i32
  %25 = call i32 @new_reg(ptr %0)
  store i32 %25, ptr %23
  %26 = call i32 @malloc(i32 32)
  %27 = load ptr, ptr %14
  store i32 %26, ptr %27
  %28 = load ptr, ptr %14
  %29 = load i64, ptr %28
  %30 = getelementptr [5 x i8], ptr @.str17, i64 0, i64 0
  %31 = load i32, ptr %23
  %32 = call i32 @snprintf(i32 %29, i32 32, ptr %30, i32 %31)
  %33 = load ptr, ptr %14
  store ptr %4, ptr %33
  %34 = load ptr, ptr %14
  store i32 %6, ptr %34
  %35 = load ptr, ptr %14
  ret ptr %35
L0:
  ret ptr 0
}

define internal i32 @intern_string(ptr %0, ptr %2) {
entry:
  %4 = alloca i32
  %6 = load i64, ptr %0
  %8 = sext i32 %6 to i64
  %7 = add i64 %8, 1
  store i64 %7, ptr %0
  store i32 %6, ptr %4
  %9 = call i32 @strdup(ptr %2)
  %10 = load i64, ptr %0
  %11 = load i64, ptr %0
  %12 = getelementptr i8, ptr %10, i64 %11
  store i32 %9, ptr %12
  %13 = load i32, ptr %4
  %14 = load i64, ptr %0
  %15 = load i64, ptr %0
  %16 = getelementptr i8, ptr %14, i64 %15
  store i32 %13, ptr %16
  %17 = load i64, ptr %0
  %19 = sext i32 %17 to i64
  %18 = add i64 %19, 1
  store i64 %18, ptr %0
  %20 = load i32, ptr %4
  ret i32 %20
L0:
  ret i32 0
}

define internal i32 @str_literal_len(ptr %0) {
entry:
  %2 = alloca i32
  store i32 0, ptr %2
  %4 = alloca ptr
  %6 = getelementptr i8, ptr %0, i64 1
  store ptr %6, ptr %4
  br label %L0
L0:
  %7 = load ptr, ptr %4
  %8 = load i8, ptr %7
  %9 = load ptr, ptr %4
  %10 = load i8, ptr %9
  %12 = sext i32 %10 to i64
  %13 = sext i32 34 to i64
  %11 = icmp ne i64 %12, %13
  %14 = zext i1 %11 to i64
  %16 = sext i32 %8 to i64
  %17 = sext i32 %14 to i64
  %18 = icmp ne i64 %16, 0
  %19 = icmp ne i64 %17, 0
  %20 = and i1 %18, %19
  %21 = zext i1 %20 to i64
  %22 = icmp ne i64 %21, 0
  br i1 %22, label %L1, label %L2
L1:
  %23 = load ptr, ptr %4
  %24 = load i8, ptr %23
  %26 = sext i32 %24 to i64
  %27 = sext i32 92 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L3, label %L4
L3:
  %30 = load ptr, ptr %4
  %32 = sext i32 %30 to i64
  %31 = add i64 %32, 1
  store i64 %31, ptr %4
  %33 = load ptr, ptr %4
  %34 = load i8, ptr %33
  %35 = icmp ne i64 %34, 0
  br i1 %35, label %L6, label %L8
L6:
  %36 = load ptr, ptr %4
  %38 = sext i32 %36 to i64
  %37 = add i64 %38, 1
  store i64 %37, ptr %4
  br label %L8
L8:
  br label %L5
L4:
  %39 = load ptr, ptr %4
  %41 = sext i32 %39 to i64
  %40 = add i64 %41, 1
  store i64 %40, ptr %4
  br label %L5
L5:
  %42 = load i32, ptr %2
  %44 = sext i32 %42 to i64
  %43 = add i64 %44, 1
  store i64 %43, ptr %2
  br label %L0
L2:
  %45 = load i32, ptr %2
  %47 = sext i32 %45 to i64
  %48 = sext i32 1 to i64
  %46 = add i64 %47, %48
  ret i32 %46
L9:
  ret i32 0
}

define internal void @emit_str_content(ptr %0, ptr %2) {
entry:
  %4 = alloca ptr
  %6 = getelementptr i8, ptr %2, i64 1
  store ptr %6, ptr %4
  br label %L0
L0:
  %7 = load ptr, ptr %4
  %8 = load i8, ptr %7
  %9 = load ptr, ptr %4
  %10 = load i8, ptr %9
  %12 = sext i32 %10 to i64
  %13 = sext i32 34 to i64
  %11 = icmp ne i64 %12, %13
  %14 = zext i1 %11 to i64
  %16 = sext i32 %8 to i64
  %17 = sext i32 %14 to i64
  %18 = icmp ne i64 %16, 0
  %19 = icmp ne i64 %17, 0
  %20 = and i1 %18, %19
  %21 = zext i1 %20 to i64
  %22 = icmp ne i64 %21, 0
  br i1 %22, label %L1, label %L2
L1:
  %23 = load ptr, ptr %4
  %24 = load i8, ptr %23
  %26 = sext i32 %24 to i64
  %27 = sext i32 92 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = load ptr, ptr %4
  %30 = getelementptr i8, ptr %29, i64 1
  %31 = load i8, ptr %30
  %33 = sext i32 %28 to i64
  %34 = sext i32 %31 to i64
  %35 = icmp ne i64 %33, 0
  %36 = icmp ne i64 %34, 0
  %37 = and i1 %35, %36
  %38 = zext i1 %37 to i64
  %39 = icmp ne i64 %38, 0
  br i1 %39, label %L3, label %L4
L3:
  %40 = load ptr, ptr %4
  %42 = sext i32 %40 to i64
  %41 = add i64 %42, 1
  store i64 %41, ptr %4
  %43 = load ptr, ptr %4
  %44 = load i8, ptr %43
  %45 = sext i32 %44 to i64
  switch i64 %45, label %L13 [
    i64 110, label %L7
    i64 116, label %L8
    i64 114, label %L9
    i64 48, label %L10
    i64 34, label %L11
    i64 92, label %L12
  ]
L7:
  %46 = getelementptr [4 x i8], ptr @.str18, i64 0, i64 0
  call void @emit(ptr %0, ptr %46)
  br label %L6
L14:
  br label %L8
L8:
  %48 = getelementptr [4 x i8], ptr @.str19, i64 0, i64 0
  call void @emit(ptr %0, ptr %48)
  br label %L6
L15:
  br label %L9
L9:
  %50 = getelementptr [4 x i8], ptr @.str20, i64 0, i64 0
  call void @emit(ptr %0, ptr %50)
  br label %L6
L16:
  br label %L10
L10:
  %52 = getelementptr [4 x i8], ptr @.str21, i64 0, i64 0
  call void @emit(ptr %0, ptr %52)
  br label %L6
L17:
  br label %L11
L11:
  %54 = getelementptr [4 x i8], ptr @.str22, i64 0, i64 0
  call void @emit(ptr %0, ptr %54)
  br label %L6
L18:
  br label %L12
L12:
  %56 = getelementptr [4 x i8], ptr @.str23, i64 0, i64 0
  call void @emit(ptr %0, ptr %56)
  br label %L6
L19:
  br label %L6
L13:
  %58 = getelementptr [6 x i8], ptr @.str24, i64 0, i64 0
  %59 = load ptr, ptr %4
  %60 = load i8, ptr %59
  %61 = bitcast i8 %60 to i8
  call void @emit(ptr %0, ptr %58, i8 %61)
  br label %L6
L20:
  br label %L6
L6:
  %63 = load ptr, ptr %4
  %65 = sext i32 %63 to i64
  %64 = add i64 %65, 1
  store i64 %64, ptr %4
  br label %L5
L4:
  %66 = load ptr, ptr %4
  %67 = load i8, ptr %66
  %69 = sext i32 %67 to i64
  %70 = sext i32 34 to i64
  %68 = icmp eq i64 %69, %70
  %71 = zext i1 %68 to i64
  %72 = icmp ne i64 %71, 0
  br i1 %72, label %L21, label %L23
L21:
  br label %L2
L24:
  br label %L23
L23:
  %73 = getelementptr [3 x i8], ptr @.str25, i64 0, i64 0
  %74 = load ptr, ptr %4
  %76 = sext i32 %74 to i64
  %75 = add i64 %76, 1
  store i64 %75, ptr %4
  %77 = load i8, ptr %74
  call void @emit(ptr %0, ptr %73, i8 %77)
  br label %L5
L5:
  br label %L0
L2:
  %79 = getelementptr [4 x i8], ptr @.str26, i64 0, i64 0
  call void @emit(ptr %0, ptr %79)
  ret void
}

define internal i64 @make_val(ptr %0, ptr %2) {
entry:
  %4 = alloca i64
  %6 = load i64, ptr %4
  %7 = call i32 @strncpy(i32 %6, ptr %0, i32 63)
  %8 = load i64, ptr %4
  %9 = getelementptr i8, ptr %8, i64 63
  store i8 0, ptr %9
  store ptr %2, ptr %4
  %10 = load i64, ptr %4
  ret i64 %10
L0:
  ret i64 0
}

define internal ptr @emit_lvalue_addr(ptr %0, ptr %2) {
entry:
  %4 = load i64, ptr %2
  %6 = sext i32 %4 to i64
  %7 = sext i32 @ND_IDENT to i64
  %5 = icmp eq i64 %6, %7
  %8 = zext i1 %5 to i64
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %L0, label %L2
L0:
  %10 = alloca ptr
  %12 = load i64, ptr %2
  %13 = call ptr @find_local(ptr %0, i32 %12)
  store ptr %13, ptr %10
  %14 = load ptr, ptr %10
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %L3, label %L5
L3:
  %16 = load ptr, ptr %10
  %17 = load i64, ptr %16
  %18 = call i32 @strdup(i32 %17)
  ret ptr %18
L6:
  br label %L5
L5:
  %19 = alloca ptr
  %21 = load i64, ptr %2
  %22 = call ptr @find_global(ptr %0, i32 %21)
  store ptr %22, ptr %19
  %23 = load ptr, ptr %19
  %24 = icmp ne i64 %23, 0
  br i1 %24, label %L7, label %L9
L7:
  %25 = alloca ptr
  %27 = call i32 @malloc(i32 128)
  store ptr %27, ptr %25
  %28 = load ptr, ptr %25
  %29 = getelementptr [4 x i8], ptr @.str27, i64 0, i64 0
  %30 = load i64, ptr %2
  %31 = call i32 @snprintf(ptr %28, i32 128, ptr %29, i32 %30)
  %32 = load ptr, ptr %25
  ret ptr %32
L10:
  br label %L9
L9:
  %33 = alloca ptr
  %35 = call i32 @malloc(i32 128)
  store ptr %35, ptr %33
  %36 = load ptr, ptr %33
  %37 = getelementptr [4 x i8], ptr @.str28, i64 0, i64 0
  %38 = load i64, ptr %2
  %39 = call i32 @snprintf(ptr %36, i32 128, ptr %37, i32 %38)
  %40 = load ptr, ptr %33
  ret ptr %40
L11:
  br label %L2
L2:
  %41 = load i64, ptr %2
  %43 = sext i32 %41 to i64
  %44 = sext i32 @ND_DEREF to i64
  %42 = icmp eq i64 %43, %44
  %45 = zext i1 %42 to i64
  %46 = icmp ne i64 %45, 0
  br i1 %46, label %L12, label %L14
L12:
  %47 = alloca i64
  %49 = load i64, ptr %2
  %50 = getelementptr i32, ptr %49, i64 0
  %51 = load i32, ptr %50
  %52 = call i64 @emit_expr(ptr %0, i32 %51)
  store i64 %52, ptr %47
  %53 = load i64, ptr %47
  %54 = call i32 @strdup(i32 %53)
  ret ptr %54
L15:
  br label %L14
L14:
  %55 = load i64, ptr %2
  %57 = sext i32 %55 to i64
  %58 = sext i32 @ND_INDEX to i64
  %56 = icmp eq i64 %57, %58
  %59 = zext i1 %56 to i64
  %60 = icmp ne i64 %59, 0
  br i1 %60, label %L16, label %L18
L16:
  %61 = alloca i64
  %63 = load i64, ptr %2
  %64 = getelementptr i32, ptr %63, i64 0
  %65 = load i32, ptr %64
  %66 = call i64 @emit_expr(ptr %0, i32 %65)
  store i64 %66, ptr %61
  %67 = alloca i64
  %69 = load i64, ptr %2
  %70 = getelementptr i32, ptr %69, i64 1
  %71 = load i32, ptr %70
  %72 = call i64 @emit_expr(ptr %0, i32 %71)
  store i64 %72, ptr %67
  %73 = alloca i32
  %75 = call i32 @new_reg(ptr %0)
  store i32 %75, ptr %73
  %76 = alloca ptr
  %78 = load i64, ptr %2
  %79 = getelementptr i32, ptr %78, i64 0
  %80 = load i32, ptr %79
  %81 = load i64, ptr %80
  %82 = load i64, ptr %2
  %83 = getelementptr i32, ptr %82, i64 0
  %84 = load i32, ptr %83
  %85 = load i64, ptr %84
  %86 = load i64, ptr %85
  %88 = sext i32 %81 to i64
  %89 = sext i32 %86 to i64
  %90 = icmp ne i64 %88, 0
  %91 = icmp ne i64 %89, 0
  %92 = and i1 %90, %91
  %93 = zext i1 %92 to i64
  %94 = icmp ne i64 %93, 0
  br i1 %94, label %L19, label %L20
L19:
  %95 = load i64, ptr %2
  %96 = getelementptr i32, ptr %95, i64 0
  %97 = load i32, ptr %96
  %98 = load i64, ptr %97
  %99 = load i64, ptr %98
  br label %L21
L20:
  %100 = inttoptr i64 0 to ptr
  br label %L21
L21:
  %101 = phi i64 [ %99, %L19 ], [ %100, %L20 ]
  store ptr %101, ptr %76
  %102 = alloca ptr
  %104 = load ptr, ptr %76
  %105 = icmp ne i64 %104, 0
  br i1 %105, label %L22, label %L23
L22:
  %106 = load ptr, ptr %76
  %107 = call ptr @llvm_type(ptr %106)
  br label %L24
L23:
  %108 = getelementptr [3 x i8], ptr @.str29, i64 0, i64 0
  br label %L24
L24:
  %109 = phi i64 [ %107, %L22 ], [ %108, %L23 ]
  store ptr %109, ptr %102
  %110 = getelementptr [43 x i8], ptr @.str30, i64 0, i64 0
  %111 = load i32, ptr %73
  %112 = load ptr, ptr %102
  %113 = load i64, ptr %61
  %114 = load i64, ptr %67
  call void @emit(ptr %0, ptr %110, i32 %111, ptr %112, i32 %113, i32 %114)
  %116 = alloca ptr
  %118 = call i32 @malloc(i32 32)
  store ptr %118, ptr %116
  %119 = load ptr, ptr %116
  %120 = getelementptr [5 x i8], ptr @.str31, i64 0, i64 0
  %121 = load i32, ptr %73
  %122 = call i32 @snprintf(ptr %119, i32 32, ptr %120, i32 %121)
  %123 = load ptr, ptr %116
  ret ptr %123
L25:
  br label %L18
L18:
  %124 = load i64, ptr %2
  %126 = sext i32 %124 to i64
  %127 = sext i32 @ND_MEMBER to i64
  %125 = icmp eq i64 %126, %127
  %128 = zext i1 %125 to i64
  %129 = load i64, ptr %2
  %131 = sext i32 %129 to i64
  %132 = sext i32 @ND_ARROW to i64
  %130 = icmp eq i64 %131, %132
  %133 = zext i1 %130 to i64
  %135 = sext i32 %128 to i64
  %136 = sext i32 %133 to i64
  %137 = icmp ne i64 %135, 0
  %138 = icmp ne i64 %136, 0
  %139 = or i1 %137, %138
  %140 = zext i1 %139 to i64
  %141 = icmp ne i64 %140, 0
  br i1 %141, label %L26, label %L28
L26:
  %142 = alloca i64
  %144 = load i64, ptr %2
  %146 = sext i32 %144 to i64
  %147 = sext i32 @ND_ARROW to i64
  %145 = icmp eq i64 %146, %147
  %148 = zext i1 %145 to i64
  %149 = icmp ne i64 %148, 0
  br i1 %149, label %L29, label %L30
L29:
  %150 = load i64, ptr %2
  %151 = getelementptr i32, ptr %150, i64 0
  %152 = load i32, ptr %151
  %153 = call i64 @emit_expr(ptr %0, i32 %152)
  store i64 %153, ptr %142
  br label %L31
L30:
  %154 = alloca ptr
  %156 = load i64, ptr %2
  %157 = getelementptr i32, ptr %156, i64 0
  %158 = load i32, ptr %157
  %159 = call ptr @emit_lvalue_addr(ptr %0, i32 %158)
  store ptr %159, ptr %154
  %160 = load ptr, ptr %154
  %161 = inttoptr i64 0 to ptr
  %162 = call i64 @make_val(ptr %160, ptr %161)
  store i64 %162, ptr %142
  %163 = load ptr, ptr %154
  %164 = call i32 @free(ptr %163)
  br label %L31
L31:
  %165 = alloca ptr
  %167 = call i32 @malloc(i32 64)
  store ptr %167, ptr %165
  %168 = load ptr, ptr %165
  %169 = getelementptr [3 x i8], ptr @.str32, i64 0, i64 0
  %170 = load i64, ptr %142
  %171 = call i32 @snprintf(ptr %168, i32 64, ptr %169, i32 %170)
  %172 = load ptr, ptr %165
  ret ptr %172
L32:
  br label %L28
L28:
  %173 = inttoptr i64 0 to ptr
  ret ptr %173
L33:
  ret ptr 0
}

define internal ptr @default_int_type(void %0) {
entry:
  %1 = alloca i64
  store i64 0, ptr %1
  ret ptr %1
L0:
  ret ptr 0
}

define internal ptr @default_ptr_type(void %0) {
entry:
  %1 = alloca i64
  store i64 0, ptr %1
  ret ptr %1
L0:
  ret ptr 0
}

define internal i64 @emit_expr(ptr %0, ptr %2) {
entry:
  %5 = icmp eq i64 %2, 0
  %4 = zext i1 %5 to i64
  %6 = icmp ne i64 %4, 0
  br i1 %6, label %L0, label %L2
L0:
  %7 = getelementptr [2 x i8], ptr @.str33, i64 0, i64 0
  %8 = call ptr @default_int_type()
  %9 = call i64 @make_val(ptr %7, ptr %8)
  ret i64 %9
L3:
  br label %L2
L2:
  %10 = alloca i32
  %12 = load i64, ptr %2
  store i32 %12, ptr %10
  %13 = load i32, ptr %10
  %14 = trunc i32 %13 to void
  %15 = load i64, ptr %2
  %16 = sext i32 %15 to i64
  switch i64 %16, label %L29 [
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
    i64 0, label %L19
    i64 0, label %L20
    i64 0, label %L21
    i64 0, label %L22
    i64 0, label %L23
    i64 0, label %L24
    i64 0, label %L25
    i64 0, label %L26
    i64 0, label %L27
    i64 0, label %L28
  ]
L5:
  %17 = alloca ptr
  %19 = load ptr, ptr %17
  %20 = getelementptr [5 x i8], ptr @.str34, i64 0, i64 0
  %21 = load i64, ptr %2
  %22 = call i32 @snprintf(ptr %19, i32 8, ptr %20, i32 %21)
  %23 = load ptr, ptr %17
  %24 = call ptr @default_int_type()
  %25 = call i64 @make_val(ptr %23, ptr %24)
  ret i64 %25
L30:
  br label %L6
L6:
  %26 = alloca i32
  %28 = call i32 @new_reg(ptr %0)
  store i32 %28, ptr %26
  %29 = getelementptr [30 x i8], ptr @.str35, i64 0, i64 0
  %30 = load i32, ptr %26
  %31 = load i64, ptr %2
  call void @emit(ptr %0, ptr %29, i32 %30, i32 %31)
  %33 = alloca ptr
  %35 = load ptr, ptr %33
  %36 = getelementptr [5 x i8], ptr @.str36, i64 0, i64 0
  %37 = load i32, ptr %26
  %38 = call i32 @snprintf(ptr %35, i32 8, ptr %36, i32 %37)
  %39 = alloca i64
  store i64 0, ptr %39
  %41 = load ptr, ptr %33
  %42 = call i64 @make_val(ptr %41, ptr %39)
  ret i64 %42
L31:
  br label %L7
L7:
  %43 = alloca ptr
  %45 = load ptr, ptr %43
  %46 = getelementptr [5 x i8], ptr @.str37, i64 0, i64 0
  %47 = load i64, ptr %2
  %48 = call i32 @snprintf(ptr %45, i32 8, ptr %46, i32 %47)
  %49 = alloca i64
  store i64 0, ptr %49
  %51 = load ptr, ptr %43
  %52 = call i64 @make_val(ptr %51, ptr %49)
  ret i64 %52
L32:
  br label %L8
L8:
  %53 = alloca i32
  %55 = load i64, ptr %2
  %56 = call i32 @intern_string(ptr %0, i32 %55)
  store i32 %56, ptr %53
  %57 = alloca i32
  %59 = call i32 @new_reg(ptr %0)
  store i32 %59, ptr %57
  %60 = alloca i32
  %62 = load i64, ptr %2
  %63 = call i32 @str_literal_len(i32 %62)
  store i32 %63, ptr %60
  %64 = getelementptr [61 x i8], ptr @.str38, i64 0, i64 0
  %65 = load i32, ptr %57
  %66 = load i32, ptr %60
  %67 = load i32, ptr %53
  call void @emit(ptr %0, ptr %64, i32 %65, i32 %66, i32 %67)
  %69 = alloca ptr
  %71 = load ptr, ptr %69
  %72 = getelementptr [5 x i8], ptr @.str39, i64 0, i64 0
  %73 = load i32, ptr %57
  %74 = call i32 @snprintf(ptr %71, i32 8, ptr %72, i32 %73)
  %75 = load ptr, ptr %69
  %76 = call ptr @default_ptr_type()
  %77 = call i64 @make_val(ptr %75, ptr %76)
  ret i64 %77
L33:
  br label %L9
L9:
  %78 = alloca ptr
  %80 = load i64, ptr %2
  %81 = call ptr @find_local(ptr %0, i32 %80)
  store ptr %81, ptr %78
  %82 = load ptr, ptr %78
  %83 = icmp ne i64 %82, 0
  br i1 %83, label %L34, label %L36
L34:
  %84 = load ptr, ptr %78
  %85 = load i64, ptr %84
  %86 = icmp ne i64 %85, 0
  br i1 %86, label %L37, label %L39
L37:
  %87 = load ptr, ptr %78
  %88 = load i64, ptr %87
  %89 = load ptr, ptr %78
  %90 = load i64, ptr %89
  %91 = call i64 @make_val(i32 %88, i32 %90)
  ret i64 %91
L40:
  br label %L39
L39:
  %92 = alloca i32
  %94 = call i32 @new_reg(ptr %0)
  store i32 %94, ptr %92
  %95 = getelementptr [26 x i8], ptr @.str40, i64 0, i64 0
  %96 = load i32, ptr %92
  %97 = load ptr, ptr %78
  %98 = load i64, ptr %97
  %99 = call ptr @llvm_type(i32 %98)
  %100 = load ptr, ptr %78
  %101 = load i64, ptr %100
  call void @emit(ptr %0, ptr %95, i32 %96, ptr %99, i32 %101)
  %103 = alloca ptr
  %105 = load ptr, ptr %103
  %106 = getelementptr [5 x i8], ptr @.str41, i64 0, i64 0
  %107 = load i32, ptr %92
  %108 = call i32 @snprintf(ptr %105, i32 8, ptr %106, i32 %107)
  %109 = load ptr, ptr %103
  %110 = load ptr, ptr %78
  %111 = load i64, ptr %110
  %112 = call i64 @make_val(ptr %109, i32 %111)
  ret i64 %112
L41:
  br label %L36
L36:
  %113 = alloca ptr
  %115 = load i64, ptr %2
  %116 = call ptr @find_global(ptr %0, i32 %115)
  store ptr %116, ptr %113
  %117 = load ptr, ptr %113
  %118 = load ptr, ptr %113
  %119 = load i64, ptr %118
  %121 = icmp ne i64 %117, 0
  %122 = icmp ne i64 %119, 0
  %123 = and i1 %121, %122
  %124 = zext i1 %123 to i64
  %125 = load ptr, ptr %113
  %126 = load i64, ptr %125
  %127 = load i64, ptr %126
  %129 = sext i32 %127 to i64
  %130 = sext i32 @TY_FUNC to i64
  %128 = icmp ne i64 %129, %130
  %131 = zext i1 %128 to i64
  %133 = sext i32 %124 to i64
  %134 = sext i32 %131 to i64
  %135 = icmp ne i64 %133, 0
  %136 = icmp ne i64 %134, 0
  %137 = and i1 %135, %136
  %138 = zext i1 %137 to i64
  %139 = icmp ne i64 %138, 0
  br i1 %139, label %L42, label %L44
L42:
  %140 = alloca i32
  %142 = call i32 @new_reg(ptr %0)
  store i32 %142, ptr %140
  %143 = getelementptr [27 x i8], ptr @.str42, i64 0, i64 0
  %144 = load i32, ptr %140
  %145 = load ptr, ptr %113
  %146 = load i64, ptr %145
  %147 = call ptr @llvm_type(i32 %146)
  %148 = load i64, ptr %2
  call void @emit(ptr %0, ptr %143, i32 %144, ptr %147, i32 %148)
  %150 = alloca ptr
  %152 = load ptr, ptr %150
  %153 = getelementptr [5 x i8], ptr @.str43, i64 0, i64 0
  %154 = load i32, ptr %140
  %155 = call i32 @snprintf(ptr %152, i32 8, ptr %153, i32 %154)
  %156 = load ptr, ptr %150
  %157 = load ptr, ptr %113
  %158 = load i64, ptr %157
  %159 = call i64 @make_val(ptr %156, i32 %158)
  ret i64 %159
L45:
  br label %L44
L44:
  %160 = alloca ptr
  %162 = load ptr, ptr %160
  %163 = getelementptr [4 x i8], ptr @.str44, i64 0, i64 0
  %164 = load i64, ptr %2
  %165 = call i32 @snprintf(ptr %162, i32 8, ptr %163, i32 %164)
  %166 = load ptr, ptr %160
  %167 = call ptr @default_ptr_type()
  %168 = call i64 @make_val(ptr %166, ptr %167)
  ret i64 %168
L46:
  br label %L10
L10:
  %169 = alloca ptr
  %171 = load i64, ptr %2
  %172 = getelementptr i32, ptr %171, i64 0
  %173 = load i32, ptr %172
  store ptr %173, ptr %169
  %174 = alloca ptr
  %176 = call ptr @default_int_type()
  store ptr %176, ptr %174
  %177 = alloca ptr
  %179 = load i64, ptr %2
  %181 = sext i32 %179 to i64
  %182 = sext i32 8 to i64
  %180 = mul i64 %181, %182
  %183 = call i32 @malloc(i32 %180)
  store ptr %183, ptr %177
  %184 = alloca ptr
  %186 = load i64, ptr %2
  %188 = sext i32 %186 to i64
  %189 = sext i32 8 to i64
  %187 = mul i64 %188, %189
  %190 = call i32 @malloc(i32 %187)
  store ptr %190, ptr %184
  %191 = alloca i32
  store i32 1, ptr %191
  br label %L47
L47:
  %193 = load i32, ptr %191
  %194 = load i64, ptr %2
  %196 = sext i32 %193 to i64
  %197 = sext i32 %194 to i64
  %195 = icmp slt i64 %196, %197
  %198 = zext i1 %195 to i64
  %199 = icmp ne i64 %198, 0
  br i1 %199, label %L48, label %L50
L48:
  %200 = alloca i64
  %202 = load i64, ptr %2
  %203 = load i32, ptr %191
  %204 = getelementptr i32, ptr %202, i64 %203
  %205 = load i32, ptr %204
  %206 = call i64 @emit_expr(ptr %0, i32 %205)
  store i64 %206, ptr %200
  %207 = load i64, ptr %200
  %208 = call i32 @strdup(i32 %207)
  %209 = load ptr, ptr %177
  %210 = load i32, ptr %191
  %211 = getelementptr i8, ptr %209, i64 %210
  store i32 %208, ptr %211
  %212 = load i64, ptr %200
  %213 = load ptr, ptr %184
  %214 = load i32, ptr %191
  %215 = getelementptr i8, ptr %213, i64 %214
  store i32 %212, ptr %215
  br label %L49
L49:
  %216 = load i32, ptr %191
  %218 = sext i32 %216 to i64
  %217 = add i64 %218, 1
  store i64 %217, ptr %191
  br label %L47
L50:
  %219 = alloca ptr
  store ptr 0, ptr %219
  %221 = load ptr, ptr %169
  %222 = load i64, ptr %221
  %224 = sext i32 %222 to i64
  %225 = sext i32 @ND_IDENT to i64
  %223 = icmp eq i64 %224, %225
  %226 = zext i1 %223 to i64
  %227 = icmp ne i64 %226, 0
  br i1 %227, label %L51, label %L52
L51:
  %228 = load ptr, ptr %219
  %229 = getelementptr [4 x i8], ptr @.str45, i64 0, i64 0
  %230 = load ptr, ptr %169
  %231 = load i64, ptr %230
  %232 = call i32 @snprintf(ptr %228, i32 8, ptr %229, i32 %231)
  %233 = alloca ptr
  %235 = load ptr, ptr %169
  %236 = load i64, ptr %235
  %237 = call ptr @find_global(ptr %0, i32 %236)
  store ptr %237, ptr %233
  %238 = load ptr, ptr %233
  %239 = load ptr, ptr %233
  %240 = load i64, ptr %239
  %242 = icmp ne i64 %238, 0
  %243 = icmp ne i64 %240, 0
  %244 = and i1 %242, %243
  %245 = zext i1 %244 to i64
  %246 = load ptr, ptr %233
  %247 = load i64, ptr %246
  %248 = load i64, ptr %247
  %250 = sext i32 %248 to i64
  %251 = sext i32 @TY_FUNC to i64
  %249 = icmp eq i64 %250, %251
  %252 = zext i1 %249 to i64
  %254 = sext i32 %245 to i64
  %255 = sext i32 %252 to i64
  %256 = icmp ne i64 %254, 0
  %257 = icmp ne i64 %255, 0
  %258 = and i1 %256, %257
  %259 = zext i1 %258 to i64
  %260 = icmp ne i64 %259, 0
  br i1 %260, label %L54, label %L56
L54:
  %261 = load ptr, ptr %233
  %262 = load i64, ptr %261
  %263 = load i64, ptr %262
  store i32 %263, ptr %174
  br label %L56
L56:
  br label %L53
L52:
  %264 = alloca i64
  %266 = load ptr, ptr %169
  %267 = call i64 @emit_expr(ptr %0, ptr %266)
  store i64 %267, ptr %264
  %268 = load ptr, ptr %219
  %269 = load i64, ptr %264
  %271 = sext i32 8 to i64
  %272 = sext i32 1 to i64
  %270 = sub i64 %271, %272
  %273 = call i32 @strncpy(ptr %268, i32 %269, i32 %270)
  br label %L53
L53:
  %274 = alloca i32
  %276 = call i32 @new_reg(ptr %0)
  store i32 %276, ptr %274
  %277 = alloca ptr
  %279 = load ptr, ptr %174
  %280 = call ptr @llvm_type(ptr %279)
  store ptr %280, ptr %277
  %281 = alloca i32
  %283 = load ptr, ptr %174
  %284 = load i64, ptr %283
  %286 = sext i32 %284 to i64
  %287 = sext i32 @TY_VOID to i64
  %285 = icmp eq i64 %286, %287
  %288 = zext i1 %285 to i64
  store i32 %288, ptr %281
  %289 = load i32, ptr %281
  %290 = icmp ne i64 %289, 0
  br i1 %290, label %L57, label %L58
L57:
  %291 = getelementptr [16 x i8], ptr @.str46, i64 0, i64 0
  %292 = load ptr, ptr %219
  call void @emit(ptr %0, ptr %291, ptr %292)
  br label %L59
L58:
  %294 = getelementptr [21 x i8], ptr @.str47, i64 0, i64 0
  %295 = load i32, ptr %274
  %296 = load ptr, ptr %277
  %297 = load ptr, ptr %219
  call void @emit(ptr %0, ptr %294, i32 %295, ptr %296, ptr %297)
  br label %L59
L59:
  %299 = alloca i32
  store i32 1, ptr %299
  br label %L60
L60:
  %301 = load i32, ptr %299
  %302 = load i64, ptr %2
  %304 = sext i32 %301 to i64
  %305 = sext i32 %302 to i64
  %303 = icmp slt i64 %304, %305
  %306 = zext i1 %303 to i64
  %307 = icmp ne i64 %306, 0
  br i1 %307, label %L61, label %L63
L61:
  %308 = load i32, ptr %299
  %310 = sext i32 %308 to i64
  %311 = sext i32 1 to i64
  %309 = icmp sgt i64 %310, %311
  %312 = zext i1 %309 to i64
  %313 = icmp ne i64 %312, 0
  br i1 %313, label %L64, label %L66
L64:
  %314 = getelementptr [3 x i8], ptr @.str48, i64 0, i64 0
  call void @emit(ptr %0, ptr %314)
  br label %L66
L66:
  %316 = getelementptr [6 x i8], ptr @.str49, i64 0, i64 0
  %317 = load ptr, ptr %184
  %318 = load i32, ptr %299
  %319 = getelementptr ptr, ptr %317, i64 %318
  %320 = load ptr, ptr %319
  %321 = icmp ne i64 %320, 0
  br i1 %321, label %L67, label %L68
L67:
  %322 = load ptr, ptr %184
  %323 = load i32, ptr %299
  %324 = getelementptr ptr, ptr %322, i64 %323
  %325 = load ptr, ptr %324
  %326 = call ptr @llvm_type(ptr %325)
  br label %L69
L68:
  %327 = getelementptr [4 x i8], ptr @.str50, i64 0, i64 0
  br label %L69
L69:
  %328 = phi i64 [ %326, %L67 ], [ %327, %L68 ]
  %329 = load ptr, ptr %177
  %330 = load i32, ptr %299
  %331 = getelementptr ptr, ptr %329, i64 %330
  %332 = load ptr, ptr %331
  call void @emit(ptr %0, ptr %316, ptr %328, ptr %332)
  br label %L62
L62:
  %334 = load i32, ptr %299
  %336 = sext i32 %334 to i64
  %335 = add i64 %336, 1
  store i64 %335, ptr %299
  br label %L60
L63:
  %337 = getelementptr [3 x i8], ptr @.str51, i64 0, i64 0
  call void @emit(ptr %0, ptr %337)
  %339 = alloca i32
  store i32 1, ptr %339
  br label %L70
L70:
  %341 = load i32, ptr %339
  %342 = load i64, ptr %2
  %344 = sext i32 %341 to i64
  %345 = sext i32 %342 to i64
  %343 = icmp slt i64 %344, %345
  %346 = zext i1 %343 to i64
  %347 = icmp ne i64 %346, 0
  br i1 %347, label %L71, label %L73
L71:
  %348 = load ptr, ptr %177
  %349 = load i32, ptr %339
  %350 = getelementptr ptr, ptr %348, i64 %349
  %351 = load ptr, ptr %350
  %352 = call i32 @free(ptr %351)
  br label %L72
L72:
  %353 = load i32, ptr %339
  %355 = sext i32 %353 to i64
  %354 = add i64 %355, 1
  store i64 %354, ptr %339
  br label %L70
L73:
  %356 = load ptr, ptr %177
  %357 = call i32 @free(ptr %356)
  %358 = load ptr, ptr %184
  %359 = call i32 @free(ptr %358)
  %360 = load i32, ptr %281
  %361 = icmp ne i64 %360, 0
  br i1 %361, label %L74, label %L76
L74:
  %362 = getelementptr [2 x i8], ptr @.str52, i64 0, i64 0
  %363 = load ptr, ptr %174
  %364 = call i64 @make_val(ptr %362, ptr %363)
  ret i64 %364
L77:
  br label %L76
L76:
  %365 = alloca ptr
  %367 = load ptr, ptr %365
  %368 = getelementptr [5 x i8], ptr @.str53, i64 0, i64 0
  %369 = load i32, ptr %274
  %370 = call i32 @snprintf(ptr %367, i32 8, ptr %368, i32 %369)
  %371 = load ptr, ptr %365
  %372 = load ptr, ptr %174
  %373 = call i64 @make_val(ptr %371, ptr %372)
  ret i64 %373
L78:
  br label %L11
L11:
  %374 = alloca i64
  %376 = load i64, ptr %2
  %377 = getelementptr i32, ptr %376, i64 0
  %378 = load i32, ptr %377
  %379 = call i64 @emit_expr(ptr %0, i32 %378)
  store i64 %379, ptr %374
  %380 = alloca i64
  %382 = load i64, ptr %2
  %383 = getelementptr i32, ptr %382, i64 1
  %384 = load i32, ptr %383
  %385 = call i64 @emit_expr(ptr %0, i32 %384)
  store i64 %385, ptr %380
  %386 = alloca i32
  %388 = call i32 @new_reg(ptr %0)
  store i32 %388, ptr %386
  %389 = alloca i32
  %391 = load i64, ptr %374
  %392 = call i32 @type_is_fp(i32 %391)
  %393 = load i64, ptr %380
  %394 = call i32 @type_is_fp(i32 %393)
  %396 = sext i32 %392 to i64
  %397 = sext i32 %394 to i64
  %398 = icmp ne i64 %396, 0
  %399 = icmp ne i64 %397, 0
  %400 = or i1 %398, %399
  %401 = zext i1 %400 to i64
  store i32 %401, ptr %389
  %402 = alloca i32
  %404 = load i64, ptr %374
  %405 = load i64, ptr %374
  %406 = load i64, ptr %405
  %408 = sext i32 %406 to i64
  %409 = sext i32 @TY_PTR to i64
  %407 = icmp eq i64 %408, %409
  %410 = zext i1 %407 to i64
  %411 = load i64, ptr %374
  %412 = load i64, ptr %411
  %414 = sext i32 %412 to i64
  %415 = sext i32 @TY_ARRAY to i64
  %413 = icmp eq i64 %414, %415
  %416 = zext i1 %413 to i64
  %418 = sext i32 %410 to i64
  %419 = sext i32 %416 to i64
  %420 = icmp ne i64 %418, 0
  %421 = icmp ne i64 %419, 0
  %422 = or i1 %420, %421
  %423 = zext i1 %422 to i64
  %425 = sext i32 %404 to i64
  %426 = sext i32 %423 to i64
  %427 = icmp ne i64 %425, 0
  %428 = icmp ne i64 %426, 0
  %429 = and i1 %427, %428
  %430 = zext i1 %429 to i64
  store i32 %430, ptr %402
  %431 = alloca ptr
  %433 = load i32, ptr %389
  %434 = icmp ne i64 %433, 0
  br i1 %434, label %L79, label %L80
L79:
  %435 = load i64, ptr %374
  %436 = call ptr @llvm_type(i32 %435)
  br label %L81
L80:
  %437 = load i32, ptr %402
  %438 = icmp ne i64 %437, 0
  br i1 %438, label %L82, label %L83
L82:
  %439 = getelementptr [4 x i8], ptr @.str54, i64 0, i64 0
  br label %L84
L83:
  %440 = getelementptr [4 x i8], ptr @.str55, i64 0, i64 0
  br label %L84
L84:
  %441 = phi i64 [ %439, %L82 ], [ %440, %L83 ]
  br label %L81
L81:
  %442 = phi i64 [ %436, %L79 ], [ %441, %L80 ]
  store ptr %442, ptr %431
  %443 = alloca ptr
  %445 = alloca ptr
  %447 = load i64, ptr %374
  %448 = call i32 @strncpy(ptr @lreg, i32 %447, i32 63)
  %449 = load i64, ptr %380
  %450 = call i32 @strncpy(ptr @rreg, i32 %449, i32 63)
  %451 = load i32, ptr %389
  %453 = icmp eq i64 %451, 0
  %452 = zext i1 %453 to i64
  %454 = load i32, ptr %402
  %456 = icmp eq i64 %454, 0
  %455 = zext i1 %456 to i64
  %458 = sext i32 %452 to i64
  %459 = sext i32 %455 to i64
  %460 = icmp ne i64 %458, 0
  %461 = icmp ne i64 %459, 0
  %462 = and i1 %460, %461
  %463 = zext i1 %462 to i64
  %464 = icmp ne i64 %463, 0
  br i1 %464, label %L85, label %L87
L85:
  %465 = alloca i32
  %467 = call i32 @new_reg(ptr %0)
  store i32 %467, ptr %465
  %468 = alloca i32
  %470 = call i32 @new_reg(ptr %0)
  store i32 %470, ptr %468
  %471 = getelementptr [29 x i8], ptr @.str56, i64 0, i64 0
  %472 = load i64, ptr %374
  call void @emit(ptr %0, ptr %471, ptr @rL, i32 %472)
  %474 = getelementptr [29 x i8], ptr @.str57, i64 0, i64 0
  %475 = load i64, ptr %380
  call void @emit(ptr %0, ptr %474, ptr @rR, i32 %475)
  %477 = getelementptr [5 x i8], ptr @.str58, i64 0, i64 0
  %478 = call i32 @snprintf(ptr @lreg, i32 64, ptr %477, ptr @rL)
  %479 = getelementptr [5 x i8], ptr @.str59, i64 0, i64 0
  %480 = call i32 @snprintf(ptr @rreg, i32 64, ptr %479, ptr @rR)
  %481 = getelementptr [4 x i8], ptr @.str60, i64 0, i64 0
  store ptr %481, ptr %431
  br label %L87
L87:
  %482 = alloca ptr
  %484 = inttoptr i64 0 to ptr
  store ptr %484, ptr %482
  %485 = alloca i32
  store i32 0, ptr %485
  %487 = load i64, ptr %2
  %488 = sext i32 %487 to i64
  switch i64 %488, label %L107 [
    i64 0, label %L89
    i64 0, label %L90
    i64 0, label %L91
    i64 0, label %L92
    i64 0, label %L93
    i64 0, label %L94
    i64 0, label %L95
    i64 0, label %L96
    i64 0, label %L97
    i64 0, label %L98
    i64 0, label %L99
    i64 0, label %L100
    i64 0, label %L101
    i64 0, label %L102
    i64 0, label %L103
    i64 0, label %L104
    i64 0, label %L105
    i64 0, label %L106
  ]
L89:
  %489 = load i32, ptr %389
  %490 = icmp ne i64 %489, 0
  br i1 %490, label %L108, label %L109
L108:
  %491 = getelementptr [5 x i8], ptr @.str61, i64 0, i64 0
  br label %L110
L109:
  %492 = load i32, ptr %402
  %493 = icmp ne i64 %492, 0
  br i1 %493, label %L111, label %L112
L111:
  %494 = getelementptr [14 x i8], ptr @.str62, i64 0, i64 0
  br label %L113
L112:
  %495 = getelementptr [4 x i8], ptr @.str63, i64 0, i64 0
  br label %L113
L113:
  %496 = phi i64 [ %494, %L111 ], [ %495, %L112 ]
  br label %L110
L110:
  %497 = phi i64 [ %491, %L108 ], [ %496, %L109 ]
  store ptr %497, ptr %482
  br label %L88
L114:
  br label %L90
L90:
  %498 = load i32, ptr %389
  %499 = icmp ne i64 %498, 0
  br i1 %499, label %L115, label %L116
L115:
  %500 = getelementptr [5 x i8], ptr @.str64, i64 0, i64 0
  br label %L117
L116:
  %501 = getelementptr [4 x i8], ptr @.str65, i64 0, i64 0
  br label %L117
L117:
  %502 = phi i64 [ %500, %L115 ], [ %501, %L116 ]
  store ptr %502, ptr %482
  br label %L88
L118:
  br label %L91
L91:
  %503 = load i32, ptr %389
  %504 = icmp ne i64 %503, 0
  br i1 %504, label %L119, label %L120
L119:
  %505 = getelementptr [5 x i8], ptr @.str66, i64 0, i64 0
  br label %L121
L120:
  %506 = getelementptr [4 x i8], ptr @.str67, i64 0, i64 0
  br label %L121
L121:
  %507 = phi i64 [ %505, %L119 ], [ %506, %L120 ]
  store ptr %507, ptr %482
  br label %L88
L122:
  br label %L92
L92:
  %508 = load i32, ptr %389
  %509 = icmp ne i64 %508, 0
  br i1 %509, label %L123, label %L124
L123:
  %510 = getelementptr [5 x i8], ptr @.str68, i64 0, i64 0
  br label %L125
L124:
  %511 = getelementptr [5 x i8], ptr @.str69, i64 0, i64 0
  br label %L125
L125:
  %512 = phi i64 [ %510, %L123 ], [ %511, %L124 ]
  store ptr %512, ptr %482
  br label %L88
L126:
  br label %L93
L93:
  %513 = load i32, ptr %389
  %514 = icmp ne i64 %513, 0
  br i1 %514, label %L127, label %L128
L127:
  %515 = getelementptr [5 x i8], ptr @.str70, i64 0, i64 0
  br label %L129
L128:
  %516 = getelementptr [5 x i8], ptr @.str71, i64 0, i64 0
  br label %L129
L129:
  %517 = phi i64 [ %515, %L127 ], [ %516, %L128 ]
  store ptr %517, ptr %482
  br label %L88
L130:
  br label %L94
L94:
  %518 = getelementptr [4 x i8], ptr @.str72, i64 0, i64 0
  store ptr %518, ptr %482
  br label %L88
L131:
  br label %L95
L95:
  %519 = getelementptr [3 x i8], ptr @.str73, i64 0, i64 0
  store ptr %519, ptr %482
  br label %L88
L132:
  br label %L96
L96:
  %520 = getelementptr [4 x i8], ptr @.str74, i64 0, i64 0
  store ptr %520, ptr %482
  br label %L88
L133:
  br label %L97
L97:
  %521 = getelementptr [4 x i8], ptr @.str75, i64 0, i64 0
  store ptr %521, ptr %482
  br label %L88
L134:
  br label %L98
L98:
  %522 = getelementptr [5 x i8], ptr @.str76, i64 0, i64 0
  store ptr %522, ptr %482
  br label %L88
L135:
  br label %L99
L99:
  %523 = load i32, ptr %389
  %524 = icmp ne i64 %523, 0
  br i1 %524, label %L136, label %L137
L136:
  %525 = getelementptr [9 x i8], ptr @.str77, i64 0, i64 0
  br label %L138
L137:
  %526 = getelementptr [8 x i8], ptr @.str78, i64 0, i64 0
  br label %L138
L138:
  %527 = phi i64 [ %525, %L136 ], [ %526, %L137 ]
  store ptr %527, ptr %482
  store i32 1, ptr %485
  br label %L88
L139:
  br label %L100
L100:
  %528 = load i32, ptr %389
  %529 = icmp ne i64 %528, 0
  br i1 %529, label %L140, label %L141
L140:
  %530 = getelementptr [9 x i8], ptr @.str79, i64 0, i64 0
  br label %L142
L141:
  %531 = getelementptr [8 x i8], ptr @.str80, i64 0, i64 0
  br label %L142
L142:
  %532 = phi i64 [ %530, %L140 ], [ %531, %L141 ]
  store ptr %532, ptr %482
  store i32 1, ptr %485
  br label %L88
L143:
  br label %L101
L101:
  %533 = load i32, ptr %389
  %534 = icmp ne i64 %533, 0
  br i1 %534, label %L144, label %L145
L144:
  %535 = getelementptr [9 x i8], ptr @.str81, i64 0, i64 0
  br label %L146
L145:
  %536 = getelementptr [9 x i8], ptr @.str82, i64 0, i64 0
  br label %L146
L146:
  %537 = phi i64 [ %535, %L144 ], [ %536, %L145 ]
  store ptr %537, ptr %482
  store i32 1, ptr %485
  br label %L88
L147:
  br label %L102
L102:
  %538 = load i32, ptr %389
  %539 = icmp ne i64 %538, 0
  br i1 %539, label %L148, label %L149
L148:
  %540 = getelementptr [9 x i8], ptr @.str83, i64 0, i64 0
  br label %L150
L149:
  %541 = getelementptr [9 x i8], ptr @.str84, i64 0, i64 0
  br label %L150
L150:
  %542 = phi i64 [ %540, %L148 ], [ %541, %L149 ]
  store ptr %542, ptr %482
  store i32 1, ptr %485
  br label %L88
L151:
  br label %L103
L103:
  %543 = load i32, ptr %389
  %544 = icmp ne i64 %543, 0
  br i1 %544, label %L152, label %L153
L152:
  %545 = getelementptr [9 x i8], ptr @.str85, i64 0, i64 0
  br label %L154
L153:
  %546 = getelementptr [9 x i8], ptr @.str86, i64 0, i64 0
  br label %L154
L154:
  %547 = phi i64 [ %545, %L152 ], [ %546, %L153 ]
  store ptr %547, ptr %482
  store i32 1, ptr %485
  br label %L88
L155:
  br label %L104
L104:
  %548 = load i32, ptr %389
  %549 = icmp ne i64 %548, 0
  br i1 %549, label %L156, label %L157
L156:
  %550 = getelementptr [9 x i8], ptr @.str87, i64 0, i64 0
  br label %L158
L157:
  %551 = getelementptr [9 x i8], ptr @.str88, i64 0, i64 0
  br label %L158
L158:
  %552 = phi i64 [ %550, %L156 ], [ %551, %L157 ]
  store ptr %552, ptr %482
  store i32 1, ptr %485
  br label %L88
L159:
  br label %L105
L105:
  %553 = alloca i32
  %555 = call i32 @new_reg(ptr %0)
  store i32 %555, ptr %553
  %556 = alloca i32
  %558 = call i32 @new_reg(ptr %0)
  store i32 %558, ptr %556
  %559 = alloca i32
  %561 = call i32 @new_reg(ptr %0)
  store i32 %561, ptr %559
  %562 = getelementptr [28 x i8], ptr @.str89, i64 0, i64 0
  call void @emit(ptr %0, ptr %562, ptr @rA, ptr @lreg)
  %564 = getelementptr [28 x i8], ptr @.str90, i64 0, i64 0
  call void @emit(ptr %0, ptr %564, ptr @rB, ptr @rreg)
  %566 = getelementptr [28 x i8], ptr @.str91, i64 0, i64 0
  call void @emit(ptr %0, ptr %566, ptr @rC, ptr @rA, ptr @rB)
  %568 = alloca i32
  %570 = call i32 @new_reg(ptr %0)
  store i32 %570, ptr %568
  %571 = getelementptr [30 x i8], ptr @.str92, i64 0, i64 0
  %572 = load i32, ptr %568
  call void @emit(ptr %0, ptr %571, i32 %572, ptr @rC)
  %574 = alloca ptr
  %576 = load ptr, ptr %574
  %577 = getelementptr [5 x i8], ptr @.str93, i64 0, i64 0
  %578 = load i32, ptr %568
  %579 = call i32 @snprintf(ptr %576, i32 8, ptr %577, i32 %578)
  %580 = load ptr, ptr %574
  %581 = call ptr @default_int_type()
  %582 = call i64 @make_val(ptr %580, ptr %581)
  ret i64 %582
L160:
  br label %L106
L106:
  %583 = alloca i32
  %585 = call i32 @new_reg(ptr %0)
  store i32 %585, ptr %583
  %586 = alloca i32
  %588 = call i32 @new_reg(ptr %0)
  store i32 %588, ptr %586
  %589 = alloca i32
  %591 = call i32 @new_reg(ptr %0)
  store i32 %591, ptr %589
  %592 = getelementptr [28 x i8], ptr @.str94, i64 0, i64 0
  call void @emit(ptr %0, ptr %592, ptr @rA, ptr @lreg)
  %594 = getelementptr [28 x i8], ptr @.str95, i64 0, i64 0
  call void @emit(ptr %0, ptr %594, ptr @rB, ptr @rreg)
  %596 = getelementptr [27 x i8], ptr @.str96, i64 0, i64 0
  call void @emit(ptr %0, ptr %596, ptr @rC, ptr @rA, ptr @rB)
  %598 = alloca i32
  %600 = call i32 @new_reg(ptr %0)
  store i32 %600, ptr %598
  %601 = getelementptr [30 x i8], ptr @.str97, i64 0, i64 0
  %602 = load i32, ptr %598
  call void @emit(ptr %0, ptr %601, i32 %602, ptr @rC)
  %604 = alloca ptr
  %606 = load ptr, ptr %604
  %607 = getelementptr [5 x i8], ptr @.str98, i64 0, i64 0
  %608 = load i32, ptr %598
  %609 = call i32 @snprintf(ptr %606, i32 8, ptr %607, i32 %608)
  %610 = load ptr, ptr %604
  %611 = call ptr @default_int_type()
  %612 = call i64 @make_val(ptr %610, ptr %611)
  ret i64 %612
L161:
  br label %L88
L107:
  %613 = getelementptr [4 x i8], ptr @.str99, i64 0, i64 0
  store ptr %613, ptr %482
  br label %L88
L88:
  %614 = load i64, ptr %2
  %616 = sext i32 %614 to i64
  %617 = sext i32 @TOK_PLUS to i64
  %615 = icmp eq i64 %616, %617
  %618 = zext i1 %615 to i64
  %619 = load i32, ptr %402
  %621 = sext i32 %618 to i64
  %622 = sext i32 %619 to i64
  %623 = icmp ne i64 %621, 0
  %624 = icmp ne i64 %622, 0
  %625 = and i1 %623, %624
  %626 = zext i1 %625 to i64
  %627 = icmp ne i64 %626, 0
  br i1 %627, label %L162, label %L163
L162:
  %628 = getelementptr [43 x i8], ptr @.str100, i64 0, i64 0
  %629 = load i32, ptr %386
  call void @emit(ptr %0, ptr %628, i32 %629, ptr @lreg, ptr @rreg)
  br label %L164
L163:
  %631 = load i32, ptr %485
  %632 = icmp ne i64 %631, 0
  br i1 %632, label %L165, label %L166
L165:
  %633 = getelementptr [23 x i8], ptr @.str101, i64 0, i64 0
  %634 = load i32, ptr %386
  %635 = load ptr, ptr %482
  %636 = load ptr, ptr %431
  call void @emit(ptr %0, ptr %633, i32 %634, ptr %635, ptr %636, ptr @lreg, ptr @rreg)
  %638 = alloca i32
  %640 = call i32 @new_reg(ptr %0)
  store i32 %640, ptr %638
  %641 = getelementptr [30 x i8], ptr @.str102, i64 0, i64 0
  %642 = load i32, ptr %638
  %643 = load i32, ptr %386
  call void @emit(ptr %0, ptr %641, i32 %642, i32 %643)
  %645 = alloca ptr
  %647 = load ptr, ptr %645
  %648 = getelementptr [5 x i8], ptr @.str103, i64 0, i64 0
  %649 = load i32, ptr %638
  %650 = call i32 @snprintf(ptr %647, i32 8, ptr %648, i32 %649)
  %651 = load ptr, ptr %645
  %652 = call ptr @default_int_type()
  %653 = call i64 @make_val(ptr %651, ptr %652)
  ret i64 %653
L168:
  br label %L167
L166:
  %654 = getelementptr [23 x i8], ptr @.str104, i64 0, i64 0
  %655 = load i32, ptr %386
  %656 = load ptr, ptr %482
  %657 = load ptr, ptr %431
  call void @emit(ptr %0, ptr %654, i32 %655, ptr %656, ptr %657, ptr @lreg, ptr @rreg)
  br label %L167
L167:
  br label %L164
L164:
  %659 = alloca ptr
  %661 = load ptr, ptr %659
  %662 = getelementptr [5 x i8], ptr @.str105, i64 0, i64 0
  %663 = load i32, ptr %386
  %664 = call i32 @snprintf(ptr %661, i32 8, ptr %662, i32 %663)
  %665 = load ptr, ptr %659
  %666 = load i64, ptr %374
  %667 = icmp ne i64 %666, 0
  br i1 %667, label %L169, label %L170
L169:
  %668 = load i64, ptr %374
  br label %L171
L170:
  %669 = call ptr @default_int_type()
  br label %L171
L171:
  %670 = phi i64 [ %668, %L169 ], [ %669, %L170 ]
  %671 = call i64 @make_val(ptr %665, i32 %670)
  ret i64 %671
L172:
  br label %L12
L12:
  %672 = alloca i64
  %674 = load i64, ptr %2
  %675 = getelementptr i32, ptr %674, i64 0
  %676 = load i32, ptr %675
  %677 = call i64 @emit_expr(ptr %0, i32 %676)
  store i64 %677, ptr %672
  %678 = alloca i32
  %680 = call i32 @new_reg(ptr %0)
  store i32 %680, ptr %678
  %681 = alloca i32
  %683 = load i64, ptr %672
  %684 = call i32 @type_is_fp(i32 %683)
  store i32 %684, ptr %681
  %685 = load i64, ptr %2
  %686 = sext i32 %685 to i64
  switch i64 %686, label %L178 [
    i64 0, label %L174
    i64 0, label %L175
    i64 0, label %L176
    i64 0, label %L177
  ]
L174:
  %687 = load i32, ptr %681
  %688 = icmp ne i64 %687, 0
  br i1 %688, label %L179, label %L180
L179:
  %689 = getelementptr [25 x i8], ptr @.str106, i64 0, i64 0
  %690 = load i32, ptr %678
  %691 = load i64, ptr %672
  call void @emit(ptr %0, ptr %689, i32 %690, i32 %691)
  br label %L181
L180:
  %693 = getelementptr [24 x i8], ptr @.str107, i64 0, i64 0
  %694 = load i32, ptr %678
  %695 = load i64, ptr %672
  call void @emit(ptr %0, ptr %693, i32 %694, i32 %695)
  br label %L181
L181:
  br label %L173
L182:
  br label %L175
L175:
  %697 = alloca i32
  %699 = call i32 @new_reg(ptr %0)
  store i32 %699, ptr %697
  %700 = getelementptr [28 x i8], ptr @.str108, i64 0, i64 0
  %701 = load i32, ptr %697
  %702 = load i64, ptr %672
  call void @emit(ptr %0, ptr %700, i32 %701, i32 %702)
  %704 = getelementptr [30 x i8], ptr @.str109, i64 0, i64 0
  %705 = load i32, ptr %678
  %706 = load i32, ptr %697
  call void @emit(ptr %0, ptr %704, i32 %705, i32 %706)
  br label %L173
L183:
  br label %L176
L176:
  %708 = getelementptr [25 x i8], ptr @.str110, i64 0, i64 0
  %709 = load i32, ptr %678
  %710 = load i64, ptr %672
  call void @emit(ptr %0, ptr %708, i32 %709, i32 %710)
  br label %L173
L184:
  br label %L177
L177:
  %712 = load i64, ptr %672
  ret i64 %712
L185:
  br label %L173
L178:
  %713 = getelementptr [24 x i8], ptr @.str111, i64 0, i64 0
  %714 = load i32, ptr %678
  %715 = load i64, ptr %672
  call void @emit(ptr %0, ptr %713, i32 %714, i32 %715)
  br label %L173
L173:
  %717 = alloca ptr
  %719 = load ptr, ptr %717
  %720 = getelementptr [5 x i8], ptr @.str112, i64 0, i64 0
  %721 = load i32, ptr %678
  %722 = call i32 @snprintf(ptr %719, i32 8, ptr %720, i32 %721)
  %723 = load ptr, ptr %717
  %724 = load i64, ptr %672
  %725 = call i64 @make_val(ptr %723, i32 %724)
  ret i64 %725
L186:
  br label %L13
L13:
  %726 = alloca i64
  %728 = load i64, ptr %2
  %729 = getelementptr i32, ptr %728, i64 1
  %730 = load i32, ptr %729
  %731 = call i64 @emit_expr(ptr %0, i32 %730)
  store i64 %731, ptr %726
  %732 = alloca ptr
  %734 = load i64, ptr %2
  %735 = getelementptr i32, ptr %734, i64 0
  %736 = load i32, ptr %735
  %737 = call ptr @emit_lvalue_addr(ptr %0, i32 %736)
  store ptr %737, ptr %732
  %738 = load ptr, ptr %732
  %739 = icmp ne i64 %738, 0
  br i1 %739, label %L187, label %L189
L187:
  %740 = alloca ptr
  %742 = load i64, ptr %726
  %743 = icmp ne i64 %742, 0
  br i1 %743, label %L190, label %L191
L190:
  %744 = load i64, ptr %726
  br label %L192
L191:
  %745 = call ptr @default_int_type()
  br label %L192
L192:
  %746 = phi i64 [ %744, %L190 ], [ %745, %L191 ]
  store ptr %746, ptr %740
  %747 = getelementptr [23 x i8], ptr @.str113, i64 0, i64 0
  %748 = load ptr, ptr %740
  %749 = call ptr @llvm_type(ptr %748)
  %750 = load i64, ptr %726
  %751 = load ptr, ptr %732
  call void @emit(ptr %0, ptr %747, ptr %749, i32 %750, ptr %751)
  %753 = load ptr, ptr %732
  %754 = call i32 @free(ptr %753)
  br label %L189
L189:
  %755 = load i64, ptr %726
  ret i64 %755
L193:
  br label %L14
L14:
  %756 = alloca i64
  %758 = load i64, ptr %2
  %759 = getelementptr i32, ptr %758, i64 0
  %760 = load i32, ptr %759
  %761 = call i64 @emit_expr(ptr %0, i32 %760)
  store i64 %761, ptr %756
  %762 = alloca i64
  %764 = load i64, ptr %2
  %765 = getelementptr i32, ptr %764, i64 1
  %766 = load i32, ptr %765
  %767 = call i64 @emit_expr(ptr %0, i32 %766)
  store i64 %767, ptr %762
  %768 = alloca i32
  %770 = call i32 @new_reg(ptr %0)
  store i32 %770, ptr %768
  %771 = alloca i32
  %773 = load i64, ptr %756
  %774 = call i32 @type_is_fp(i32 %773)
  %775 = load i64, ptr %762
  %776 = call i32 @type_is_fp(i32 %775)
  %778 = sext i32 %774 to i64
  %779 = sext i32 %776 to i64
  %780 = icmp ne i64 %778, 0
  %781 = icmp ne i64 %779, 0
  %782 = or i1 %780, %781
  %783 = zext i1 %782 to i64
  store i32 %783, ptr %771
  %784 = alloca ptr
  %786 = load i32, ptr %771
  %787 = icmp ne i64 %786, 0
  br i1 %787, label %L194, label %L195
L194:
  %788 = getelementptr [7 x i8], ptr @.str114, i64 0, i64 0
  br label %L196
L195:
  %789 = getelementptr [4 x i8], ptr @.str115, i64 0, i64 0
  br label %L196
L196:
  %790 = phi i64 [ %788, %L194 ], [ %789, %L195 ]
  store ptr %790, ptr %784
  %791 = alloca ptr
  %793 = alloca ptr
  %795 = load i64, ptr %756
  %796 = call i32 @strncpy(ptr @lr, i32 %795, i32 63)
  %797 = load i64, ptr %762
  %798 = call i32 @strncpy(ptr @rr, i32 %797, i32 63)
  %799 = load i32, ptr %771
  %801 = icmp eq i64 %799, 0
  %800 = zext i1 %801 to i64
  %802 = icmp ne i64 %800, 0
  br i1 %802, label %L197, label %L199
L197:
  %803 = alloca i32
  %805 = call i32 @new_reg(ptr %0)
  store i32 %805, ptr %803
  %806 = alloca i32
  %808 = call i32 @new_reg(ptr %0)
  store i32 %808, ptr %806
  %809 = getelementptr [29 x i8], ptr @.str116, i64 0, i64 0
  %810 = load i64, ptr %756
  call void @emit(ptr %0, ptr %809, ptr @rL, i32 %810)
  %812 = getelementptr [29 x i8], ptr @.str117, i64 0, i64 0
  %813 = load i64, ptr %762
  call void @emit(ptr %0, ptr %812, ptr @rR, i32 %813)
  %815 = getelementptr [5 x i8], ptr @.str118, i64 0, i64 0
  %816 = call i32 @snprintf(ptr @lr, i32 64, ptr %815, ptr @rL)
  %817 = getelementptr [5 x i8], ptr @.str119, i64 0, i64 0
  %818 = call i32 @snprintf(ptr @rr, i32 64, ptr %817, ptr @rR)
  br label %L199
L199:
  %819 = alloca ptr
  %821 = load i64, ptr %2
  %822 = sext i32 %821 to i64
  switch i64 %822, label %L211 [
    i64 0, label %L201
    i64 0, label %L202
    i64 0, label %L203
    i64 0, label %L204
    i64 0, label %L205
    i64 0, label %L206
    i64 0, label %L207
    i64 0, label %L208
    i64 0, label %L209
    i64 0, label %L210
  ]
L201:
  %823 = load i32, ptr %771
  %824 = icmp ne i64 %823, 0
  br i1 %824, label %L212, label %L213
L212:
  %825 = getelementptr [5 x i8], ptr @.str120, i64 0, i64 0
  br label %L214
L213:
  %826 = getelementptr [4 x i8], ptr @.str121, i64 0, i64 0
  br label %L214
L214:
  %827 = phi i64 [ %825, %L212 ], [ %826, %L213 ]
  store ptr %827, ptr %819
  br label %L200
L215:
  br label %L202
L202:
  %828 = load i32, ptr %771
  %829 = icmp ne i64 %828, 0
  br i1 %829, label %L216, label %L217
L216:
  %830 = getelementptr [5 x i8], ptr @.str122, i64 0, i64 0
  br label %L218
L217:
  %831 = getelementptr [4 x i8], ptr @.str123, i64 0, i64 0
  br label %L218
L218:
  %832 = phi i64 [ %830, %L216 ], [ %831, %L217 ]
  store ptr %832, ptr %819
  br label %L200
L219:
  br label %L203
L203:
  %833 = load i32, ptr %771
  %834 = icmp ne i64 %833, 0
  br i1 %834, label %L220, label %L221
L220:
  %835 = getelementptr [5 x i8], ptr @.str124, i64 0, i64 0
  br label %L222
L221:
  %836 = getelementptr [4 x i8], ptr @.str125, i64 0, i64 0
  br label %L222
L222:
  %837 = phi i64 [ %835, %L220 ], [ %836, %L221 ]
  store ptr %837, ptr %819
  br label %L200
L223:
  br label %L204
L204:
  %838 = load i32, ptr %771
  %839 = icmp ne i64 %838, 0
  br i1 %839, label %L224, label %L225
L224:
  %840 = getelementptr [5 x i8], ptr @.str126, i64 0, i64 0
  br label %L226
L225:
  %841 = getelementptr [5 x i8], ptr @.str127, i64 0, i64 0
  br label %L226
L226:
  %842 = phi i64 [ %840, %L224 ], [ %841, %L225 ]
  store ptr %842, ptr %819
  br label %L200
L227:
  br label %L205
L205:
  %843 = getelementptr [5 x i8], ptr @.str128, i64 0, i64 0
  store ptr %843, ptr %819
  br label %L200
L228:
  br label %L206
L206:
  %844 = getelementptr [4 x i8], ptr @.str129, i64 0, i64 0
  store ptr %844, ptr %819
  br label %L200
L229:
  br label %L207
L207:
  %845 = getelementptr [3 x i8], ptr @.str130, i64 0, i64 0
  store ptr %845, ptr %819
  br label %L200
L230:
  br label %L208
L208:
  %846 = getelementptr [4 x i8], ptr @.str131, i64 0, i64 0
  store ptr %846, ptr %819
  br label %L200
L231:
  br label %L209
L209:
  %847 = getelementptr [4 x i8], ptr @.str132, i64 0, i64 0
  store ptr %847, ptr %819
  br label %L200
L232:
  br label %L210
L210:
  %848 = getelementptr [5 x i8], ptr @.str133, i64 0, i64 0
  store ptr %848, ptr %819
  br label %L200
L233:
  br label %L200
L211:
  %849 = getelementptr [4 x i8], ptr @.str134, i64 0, i64 0
  store ptr %849, ptr %819
  br label %L200
L200:
  %850 = getelementptr [23 x i8], ptr @.str135, i64 0, i64 0
  %851 = load i32, ptr %768
  %852 = load ptr, ptr %819
  %853 = load ptr, ptr %784
  call void @emit(ptr %0, ptr %850, i32 %851, ptr %852, ptr %853, ptr @lr, ptr @rr)
  %855 = alloca ptr
  %857 = load i64, ptr %2
  %858 = getelementptr i32, ptr %857, i64 0
  %859 = load i32, ptr %858
  %860 = call ptr @emit_lvalue_addr(ptr %0, i32 %859)
  store ptr %860, ptr %855
  %861 = load ptr, ptr %855
  %862 = icmp ne i64 %861, 0
  br i1 %862, label %L234, label %L236
L234:
  %863 = getelementptr [25 x i8], ptr @.str136, i64 0, i64 0
  %864 = load ptr, ptr %784
  %865 = load i32, ptr %768
  %866 = load ptr, ptr %855
  call void @emit(ptr %0, ptr %863, ptr %864, i32 %865, ptr %866)
  %868 = load ptr, ptr %855
  %869 = call i32 @free(ptr %868)
  br label %L236
L236:
  %870 = alloca ptr
  %872 = load ptr, ptr %870
  %873 = getelementptr [5 x i8], ptr @.str137, i64 0, i64 0
  %874 = load i32, ptr %768
  %875 = call i32 @snprintf(ptr %872, i32 8, ptr %873, i32 %874)
  %876 = load ptr, ptr %870
  %877 = load i64, ptr %756
  %878 = call i64 @make_val(ptr %876, i32 %877)
  ret i64 %878
L237:
  br label %L15
L15:
  br label %L16
L16:
  %879 = alloca i64
  %881 = load i64, ptr %2
  %882 = getelementptr i32, ptr %881, i64 0
  %883 = load i32, ptr %882
  %884 = call i64 @emit_expr(ptr %0, i32 %883)
  store i64 %884, ptr %879
  %885 = alloca i32
  %887 = call i32 @new_reg(ptr %0)
  store i32 %887, ptr %885
  %888 = alloca ptr
  %890 = load i64, ptr %2
  %892 = sext i32 %890 to i64
  %893 = sext i32 @ND_PRE_INC to i64
  %891 = icmp eq i64 %892, %893
  %894 = zext i1 %891 to i64
  %895 = icmp ne i64 %894, 0
  br i1 %895, label %L238, label %L239
L238:
  %896 = getelementptr [4 x i8], ptr @.str138, i64 0, i64 0
  br label %L240
L239:
  %897 = getelementptr [4 x i8], ptr @.str139, i64 0, i64 0
  br label %L240
L240:
  %898 = phi i64 [ %896, %L238 ], [ %897, %L239 ]
  store ptr %898, ptr %888
  %899 = alloca i32
  %901 = call i32 @new_reg(ptr %0)
  store i32 %901, ptr %899
  %902 = getelementptr [29 x i8], ptr @.str140, i64 0, i64 0
  %903 = load i32, ptr %899
  %904 = load i64, ptr %879
  call void @emit(ptr %0, ptr %902, i32 %903, i32 %904)
  %906 = getelementptr [25 x i8], ptr @.str141, i64 0, i64 0
  %907 = load i32, ptr %885
  %908 = load ptr, ptr %888
  %909 = load i32, ptr %899
  call void @emit(ptr %0, ptr %906, i32 %907, ptr %908, i32 %909)
  %911 = alloca ptr
  %913 = load i64, ptr %2
  %914 = getelementptr i32, ptr %913, i64 0
  %915 = load i32, ptr %914
  %916 = call ptr @emit_lvalue_addr(ptr %0, i32 %915)
  store ptr %916, ptr %911
  %917 = load ptr, ptr %911
  %918 = icmp ne i64 %917, 0
  br i1 %918, label %L241, label %L243
L241:
  %919 = getelementptr [26 x i8], ptr @.str142, i64 0, i64 0
  %920 = load i32, ptr %885
  %921 = load ptr, ptr %911
  call void @emit(ptr %0, ptr %919, i32 %920, ptr %921)
  %923 = load ptr, ptr %911
  %924 = call i32 @free(ptr %923)
  br label %L243
L243:
  %925 = alloca ptr
  %927 = load ptr, ptr %925
  %928 = getelementptr [5 x i8], ptr @.str143, i64 0, i64 0
  %929 = load i32, ptr %885
  %930 = call i32 @snprintf(ptr %927, i32 8, ptr %928, i32 %929)
  %931 = load ptr, ptr %925
  %932 = load i64, ptr %879
  %933 = call i64 @make_val(ptr %931, i32 %932)
  ret i64 %933
L244:
  br label %L17
L17:
  br label %L18
L18:
  %934 = alloca i64
  %936 = load i64, ptr %2
  %937 = getelementptr i32, ptr %936, i64 0
  %938 = load i32, ptr %937
  %939 = call i64 @emit_expr(ptr %0, i32 %938)
  store i64 %939, ptr %934
  %940 = alloca i32
  %942 = call i32 @new_reg(ptr %0)
  store i32 %942, ptr %940
  %943 = alloca ptr
  %945 = load i64, ptr %2
  %947 = sext i32 %945 to i64
  %948 = sext i32 @ND_POST_INC to i64
  %946 = icmp eq i64 %947, %948
  %949 = zext i1 %946 to i64
  %950 = icmp ne i64 %949, 0
  br i1 %950, label %L245, label %L246
L245:
  %951 = getelementptr [4 x i8], ptr @.str144, i64 0, i64 0
  br label %L247
L246:
  %952 = getelementptr [4 x i8], ptr @.str145, i64 0, i64 0
  br label %L247
L247:
  %953 = phi i64 [ %951, %L245 ], [ %952, %L246 ]
  store ptr %953, ptr %943
  %954 = alloca i32
  %956 = call i32 @new_reg(ptr %0)
  store i32 %956, ptr %954
  %957 = getelementptr [29 x i8], ptr @.str146, i64 0, i64 0
  %958 = load i32, ptr %954
  %959 = load i64, ptr %934
  call void @emit(ptr %0, ptr %957, i32 %958, i32 %959)
  %961 = getelementptr [25 x i8], ptr @.str147, i64 0, i64 0
  %962 = load i32, ptr %940
  %963 = load ptr, ptr %943
  %964 = load i32, ptr %954
  call void @emit(ptr %0, ptr %961, i32 %962, ptr %963, i32 %964)
  %966 = alloca ptr
  %968 = load i64, ptr %2
  %969 = getelementptr i32, ptr %968, i64 0
  %970 = load i32, ptr %969
  %971 = call ptr @emit_lvalue_addr(ptr %0, i32 %970)
  store ptr %971, ptr %966
  %972 = load ptr, ptr %966
  %973 = icmp ne i64 %972, 0
  br i1 %973, label %L248, label %L250
L248:
  %974 = getelementptr [26 x i8], ptr @.str148, i64 0, i64 0
  %975 = load i32, ptr %940
  %976 = load ptr, ptr %966
  call void @emit(ptr %0, ptr %974, i32 %975, ptr %976)
  %978 = load ptr, ptr %966
  %979 = call i32 @free(ptr %978)
  br label %L250
L250:
  %980 = load i64, ptr %934
  ret i64 %980
L251:
  br label %L19
L19:
  %981 = alloca ptr
  %983 = load i64, ptr %2
  %984 = getelementptr i32, ptr %983, i64 0
  %985 = load i32, ptr %984
  %986 = call ptr @emit_lvalue_addr(ptr %0, i32 %985)
  store ptr %986, ptr %981
  %987 = load ptr, ptr %981
  %989 = icmp eq i64 %987, 0
  %988 = zext i1 %989 to i64
  %990 = icmp ne i64 %988, 0
  br i1 %990, label %L252, label %L254
L252:
  %991 = getelementptr [5 x i8], ptr @.str149, i64 0, i64 0
  %992 = call ptr @default_ptr_type()
  %993 = call i64 @make_val(ptr %991, ptr %992)
  ret i64 %993
L255:
  br label %L254
L254:
  %994 = alloca i64
  %996 = load ptr, ptr %981
  %997 = call ptr @default_ptr_type()
  %998 = call i64 @make_val(ptr %996, ptr %997)
  store i64 %998, ptr %994
  %999 = load ptr, ptr %981
  %1000 = call i32 @free(ptr %999)
  %1001 = load i64, ptr %994
  ret i64 %1001
L256:
  br label %L20
L20:
  %1002 = alloca i64
  %1004 = load i64, ptr %2
  %1005 = getelementptr i32, ptr %1004, i64 0
  %1006 = load i32, ptr %1005
  %1007 = call i64 @emit_expr(ptr %0, i32 %1006)
  store i64 %1007, ptr %1002
  %1008 = alloca i32
  %1010 = call i32 @new_reg(ptr %0)
  store i32 %1010, ptr %1008
  %1011 = alloca ptr
  %1013 = load i64, ptr %1002
  %1014 = load i64, ptr %1002
  %1015 = load i64, ptr %1014
  %1017 = sext i32 %1013 to i64
  %1018 = sext i32 %1015 to i64
  %1019 = icmp ne i64 %1017, 0
  %1020 = icmp ne i64 %1018, 0
  %1021 = and i1 %1019, %1020
  %1022 = zext i1 %1021 to i64
  %1023 = icmp ne i64 %1022, 0
  br i1 %1023, label %L257, label %L258
L257:
  %1024 = load i64, ptr %1002
  %1025 = load i64, ptr %1024
  br label %L259
L258:
  %1026 = call ptr @default_int_type()
  br label %L259
L259:
  %1027 = phi i64 [ %1025, %L257 ], [ %1026, %L258 ]
  store ptr %1027, ptr %1011
  %1028 = getelementptr [26 x i8], ptr @.str150, i64 0, i64 0
  %1029 = load i32, ptr %1008
  %1030 = load ptr, ptr %1011
  %1031 = call ptr @llvm_type(ptr %1030)
  %1032 = load i64, ptr %1002
  call void @emit(ptr %0, ptr %1028, i32 %1029, ptr %1031, i32 %1032)
  %1034 = alloca ptr
  %1036 = load ptr, ptr %1034
  %1037 = getelementptr [5 x i8], ptr @.str151, i64 0, i64 0
  %1038 = load i32, ptr %1008
  %1039 = call i32 @snprintf(ptr %1036, i32 8, ptr %1037, i32 %1038)
  %1040 = load ptr, ptr %1034
  %1041 = load ptr, ptr %1011
  %1042 = call i64 @make_val(ptr %1040, ptr %1041)
  ret i64 %1042
L260:
  br label %L21
L21:
  %1043 = alloca i64
  %1045 = load i64, ptr %2
  %1046 = getelementptr i32, ptr %1045, i64 0
  %1047 = load i32, ptr %1046
  %1048 = call i64 @emit_expr(ptr %0, i32 %1047)
  store i64 %1048, ptr %1043
  %1049 = alloca i64
  %1051 = load i64, ptr %2
  %1052 = getelementptr i32, ptr %1051, i64 1
  %1053 = load i32, ptr %1052
  %1054 = call i64 @emit_expr(ptr %0, i32 %1053)
  store i64 %1054, ptr %1049
  %1055 = alloca ptr
  %1057 = load i64, ptr %1043
  %1058 = load i64, ptr %1043
  %1059 = load i64, ptr %1058
  %1061 = sext i32 %1057 to i64
  %1062 = sext i32 %1059 to i64
  %1063 = icmp ne i64 %1061, 0
  %1064 = icmp ne i64 %1062, 0
  %1065 = and i1 %1063, %1064
  %1066 = zext i1 %1065 to i64
  %1067 = icmp ne i64 %1066, 0
  br i1 %1067, label %L261, label %L262
L261:
  %1068 = load i64, ptr %1043
  %1069 = load i64, ptr %1068
  br label %L263
L262:
  %1070 = call ptr @default_int_type()
  br label %L263
L263:
  %1071 = phi i64 [ %1069, %L261 ], [ %1070, %L262 ]
  store ptr %1071, ptr %1055
  %1072 = alloca i32
  %1074 = call i32 @new_reg(ptr %0)
  store i32 %1074, ptr %1072
  %1075 = getelementptr [43 x i8], ptr @.str152, i64 0, i64 0
  %1076 = load i32, ptr %1072
  %1077 = load ptr, ptr %1055
  %1078 = call ptr @llvm_type(ptr %1077)
  %1079 = load i64, ptr %1043
  %1080 = load i64, ptr %1049
  call void @emit(ptr %0, ptr %1075, i32 %1076, ptr %1078, i32 %1079, i32 %1080)
  %1082 = alloca i32
  %1084 = call i32 @new_reg(ptr %0)
  store i32 %1084, ptr %1082
  %1085 = getelementptr [28 x i8], ptr @.str153, i64 0, i64 0
  %1086 = load i32, ptr %1082
  %1087 = load ptr, ptr %1055
  %1088 = call ptr @llvm_type(ptr %1087)
  %1089 = load i32, ptr %1072
  call void @emit(ptr %0, ptr %1085, i32 %1086, ptr %1088, i32 %1089)
  %1091 = alloca ptr
  %1093 = load ptr, ptr %1091
  %1094 = getelementptr [5 x i8], ptr @.str154, i64 0, i64 0
  %1095 = load i32, ptr %1082
  %1096 = call i32 @snprintf(ptr %1093, i32 8, ptr %1094, i32 %1095)
  %1097 = load ptr, ptr %1091
  %1098 = load ptr, ptr %1055
  %1099 = call i64 @make_val(ptr %1097, ptr %1098)
  ret i64 %1099
L264:
  br label %L22
L22:
  %1100 = alloca i64
  %1102 = load i64, ptr %2
  %1103 = call i64 @emit_expr(ptr %0, i32 %1102)
  store i64 %1103, ptr %1100
  %1104 = alloca ptr
  %1106 = load i64, ptr %2
  store ptr %1106, ptr %1104
  %1107 = load ptr, ptr %1104
  %1109 = icmp eq i64 %1107, 0
  %1108 = zext i1 %1109 to i64
  %1110 = icmp ne i64 %1108, 0
  br i1 %1110, label %L265, label %L267
L265:
  %1111 = load i64, ptr %1100
  ret i64 %1111
L268:
  br label %L267
L267:
  %1112 = alloca i32
  %1114 = call i32 @new_reg(ptr %0)
  store i32 %1114, ptr %1112
  %1115 = alloca i32
  %1117 = load i64, ptr %1100
  %1118 = call i32 @type_is_fp(i32 %1117)
  store i32 %1118, ptr %1115
  %1119 = alloca i32
  %1121 = load ptr, ptr %1104
  %1122 = call i32 @type_is_fp(ptr %1121)
  store i32 %1122, ptr %1119
  %1123 = alloca i32
  %1125 = load i64, ptr %1100
  %1126 = icmp ne i64 %1125, 0
  br i1 %1126, label %L269, label %L270
L269:
  %1127 = load i64, ptr %1100
  br label %L271
L270:
  %1128 = call ptr @default_int_type()
  br label %L271
L271:
  %1129 = phi i64 [ %1127, %L269 ], [ %1128, %L270 ]
  %1130 = call i32 @type_size(i32 %1129)
  store i32 %1130, ptr %1123
  %1131 = alloca i32
  %1133 = load ptr, ptr %1104
  %1134 = call i32 @type_size(ptr %1133)
  store i32 %1134, ptr %1131
  %1135 = load i32, ptr %1115
  %1136 = load i32, ptr %1119
  %1138 = sext i32 %1135 to i64
  %1139 = sext i32 %1136 to i64
  %1140 = icmp ne i64 %1138, 0
  %1141 = icmp ne i64 %1139, 0
  %1142 = and i1 %1140, %1141
  %1143 = zext i1 %1142 to i64
  %1144 = icmp ne i64 %1143, 0
  br i1 %1144, label %L272, label %L273
L272:
  %1145 = load i32, ptr %1131
  %1146 = load i32, ptr %1123
  %1148 = sext i32 %1145 to i64
  %1149 = sext i32 %1146 to i64
  %1147 = icmp sgt i64 %1148, %1149
  %1150 = zext i1 %1147 to i64
  %1151 = icmp ne i64 %1150, 0
  br i1 %1151, label %L275, label %L276
L275:
  %1152 = getelementptr [35 x i8], ptr @.str155, i64 0, i64 0
  %1153 = load i32, ptr %1112
  %1154 = load i64, ptr %1100
  call void @emit(ptr %0, ptr %1152, i32 %1153, i32 %1154)
  br label %L277
L276:
  %1156 = getelementptr [37 x i8], ptr @.str156, i64 0, i64 0
  %1157 = load i32, ptr %1112
  %1158 = load i64, ptr %1100
  call void @emit(ptr %0, ptr %1156, i32 %1157, i32 %1158)
  br label %L277
L277:
  br label %L274
L273:
  %1160 = load i32, ptr %1115
  %1161 = icmp ne i64 %1160, 0
  br i1 %1161, label %L278, label %L279
L278:
  %1162 = getelementptr [29 x i8], ptr @.str157, i64 0, i64 0
  %1163 = load i32, ptr %1112
  %1164 = load i64, ptr %1100
  %1165 = call ptr @llvm_type(i32 %1164)
  %1166 = load i64, ptr %1100
  %1167 = load ptr, ptr %1104
  %1168 = call ptr @llvm_type(ptr %1167)
  call void @emit(ptr %0, ptr %1162, i32 %1163, ptr %1165, i32 %1166, ptr %1168)
  br label %L280
L279:
  %1170 = load i32, ptr %1119
  %1171 = icmp ne i64 %1170, 0
  br i1 %1171, label %L281, label %L282
L281:
  %1172 = getelementptr [29 x i8], ptr @.str158, i64 0, i64 0
  %1173 = load i32, ptr %1112
  %1174 = load i64, ptr %1100
  %1175 = call ptr @llvm_type(i32 %1174)
  %1176 = load i64, ptr %1100
  %1177 = load ptr, ptr %1104
  %1178 = call ptr @llvm_type(ptr %1177)
  call void @emit(ptr %0, ptr %1172, i32 %1173, ptr %1175, i32 %1176, ptr %1178)
  br label %L283
L282:
  %1180 = load ptr, ptr %1104
  %1181 = load i64, ptr %1180
  %1183 = sext i32 %1181 to i64
  %1184 = sext i32 @TY_PTR to i64
  %1182 = icmp eq i64 %1183, %1184
  %1185 = zext i1 %1182 to i64
  %1186 = load ptr, ptr %1104
  %1187 = load i64, ptr %1186
  %1189 = sext i32 %1187 to i64
  %1190 = sext i32 @TY_ARRAY to i64
  %1188 = icmp eq i64 %1189, %1190
  %1191 = zext i1 %1188 to i64
  %1193 = sext i32 %1185 to i64
  %1194 = sext i32 %1191 to i64
  %1195 = icmp ne i64 %1193, 0
  %1196 = icmp ne i64 %1194, 0
  %1197 = or i1 %1195, %1196
  %1198 = zext i1 %1197 to i64
  %1199 = icmp ne i64 %1198, 0
  br i1 %1199, label %L284, label %L285
L284:
  %1200 = getelementptr [33 x i8], ptr @.str159, i64 0, i64 0
  %1201 = load i32, ptr %1112
  %1202 = load i64, ptr %1100
  call void @emit(ptr %0, ptr %1200, i32 %1201, i32 %1202)
  br label %L286
L285:
  %1204 = load i64, ptr %1100
  %1205 = load i64, ptr %1100
  %1206 = load i64, ptr %1205
  %1208 = sext i32 %1206 to i64
  %1209 = sext i32 @TY_PTR to i64
  %1207 = icmp eq i64 %1208, %1209
  %1210 = zext i1 %1207 to i64
  %1211 = load i64, ptr %1100
  %1212 = load i64, ptr %1211
  %1214 = sext i32 %1212 to i64
  %1215 = sext i32 @TY_ARRAY to i64
  %1213 = icmp eq i64 %1214, %1215
  %1216 = zext i1 %1213 to i64
  %1218 = sext i32 %1210 to i64
  %1219 = sext i32 %1216 to i64
  %1220 = icmp ne i64 %1218, 0
  %1221 = icmp ne i64 %1219, 0
  %1222 = or i1 %1220, %1221
  %1223 = zext i1 %1222 to i64
  %1225 = sext i32 %1204 to i64
  %1226 = sext i32 %1223 to i64
  %1227 = icmp ne i64 %1225, 0
  %1228 = icmp ne i64 %1226, 0
  %1229 = and i1 %1227, %1228
  %1230 = zext i1 %1229 to i64
  %1231 = icmp ne i64 %1230, 0
  br i1 %1231, label %L287, label %L288
L287:
  %1232 = getelementptr [33 x i8], ptr @.str160, i64 0, i64 0
  %1233 = load i32, ptr %1112
  %1234 = load i64, ptr %1100
  call void @emit(ptr %0, ptr %1232, i32 %1233, i32 %1234)
  br label %L289
L288:
  %1236 = load i32, ptr %1131
  %1237 = load i32, ptr %1123
  %1239 = sext i32 %1236 to i64
  %1240 = sext i32 %1237 to i64
  %1238 = icmp sgt i64 %1239, %1240
  %1241 = zext i1 %1238 to i64
  %1242 = icmp ne i64 %1241, 0
  br i1 %1242, label %L290, label %L291
L290:
  %1243 = getelementptr [27 x i8], ptr @.str161, i64 0, i64 0
  %1244 = load i32, ptr %1112
  %1245 = load i64, ptr %1100
  %1246 = call ptr @llvm_type(i32 %1245)
  %1247 = load i64, ptr %1100
  %1248 = load ptr, ptr %1104
  %1249 = call ptr @llvm_type(ptr %1248)
  call void @emit(ptr %0, ptr %1243, i32 %1244, ptr %1246, i32 %1247, ptr %1249)
  br label %L292
L291:
  %1251 = load i32, ptr %1131
  %1252 = load i32, ptr %1123
  %1254 = sext i32 %1251 to i64
  %1255 = sext i32 %1252 to i64
  %1253 = icmp slt i64 %1254, %1255
  %1256 = zext i1 %1253 to i64
  %1257 = icmp ne i64 %1256, 0
  br i1 %1257, label %L293, label %L294
L293:
  %1258 = getelementptr [28 x i8], ptr @.str162, i64 0, i64 0
  %1259 = load i32, ptr %1112
  %1260 = load i64, ptr %1100
  %1261 = call ptr @llvm_type(i32 %1260)
  %1262 = load i64, ptr %1100
  %1263 = load ptr, ptr %1104
  %1264 = call ptr @llvm_type(ptr %1263)
  call void @emit(ptr %0, ptr %1258, i32 %1259, ptr %1261, i32 %1262, ptr %1264)
  br label %L295
L294:
  %1266 = getelementptr [30 x i8], ptr @.str163, i64 0, i64 0
  %1267 = load i32, ptr %1112
  %1268 = load i64, ptr %1100
  %1269 = call ptr @llvm_type(i32 %1268)
  %1270 = load i64, ptr %1100
  %1271 = load ptr, ptr %1104
  %1272 = call ptr @llvm_type(ptr %1271)
  call void @emit(ptr %0, ptr %1266, i32 %1267, ptr %1269, i32 %1270, ptr %1272)
  br label %L295
L295:
  br label %L292
L292:
  br label %L289
L289:
  br label %L286
L286:
  br label %L283
L283:
  br label %L280
L280:
  br label %L274
L274:
  %1274 = alloca ptr
  %1276 = load ptr, ptr %1274
  %1277 = getelementptr [5 x i8], ptr @.str164, i64 0, i64 0
  %1278 = load i32, ptr %1112
  %1279 = call i32 @snprintf(ptr %1276, i32 8, ptr %1277, i32 %1278)
  %1280 = load ptr, ptr %1274
  %1281 = load ptr, ptr %1104
  %1282 = call i64 @make_val(ptr %1280, ptr %1281)
  ret i64 %1282
L296:
  br label %L23
L23:
  %1283 = alloca i64
  %1285 = load i64, ptr %2
  %1286 = call i64 @emit_expr(ptr %0, i32 %1285)
  store i64 %1286, ptr %1283
  %1287 = alloca i32
  %1289 = call i32 @new_label(ptr %0)
  store i32 %1289, ptr %1287
  %1290 = alloca i32
  %1292 = call i32 @new_label(ptr %0)
  store i32 %1292, ptr %1290
  %1293 = alloca i32
  %1295 = call i32 @new_label(ptr %0)
  store i32 %1295, ptr %1293
  %1296 = alloca i32
  %1298 = call i32 @new_reg(ptr %0)
  store i32 %1298, ptr %1296
  %1299 = getelementptr [28 x i8], ptr @.str165, i64 0, i64 0
  %1300 = load i32, ptr %1296
  %1301 = load i64, ptr %1283
  call void @emit(ptr %0, ptr %1299, i32 %1300, i32 %1301)
  %1303 = getelementptr [40 x i8], ptr @.str166, i64 0, i64 0
  %1304 = load i32, ptr %1296
  %1305 = load i32, ptr %1287
  %1306 = load i32, ptr %1290
  call void @emit(ptr %0, ptr %1303, i32 %1304, i32 %1305, i32 %1306)
  %1308 = getelementptr [6 x i8], ptr @.str167, i64 0, i64 0
  %1309 = load i32, ptr %1287
  call void @emit(ptr %0, ptr %1308, i32 %1309)
  %1311 = alloca i64
  %1313 = load i64, ptr %2
  %1314 = getelementptr i32, ptr %1313, i64 0
  %1315 = load i32, ptr %1314
  %1316 = call i64 @emit_expr(ptr %0, i32 %1315)
  store i64 %1316, ptr %1311
  %1317 = getelementptr [18 x i8], ptr @.str168, i64 0, i64 0
  %1318 = load i32, ptr %1293
  call void @emit(ptr %0, ptr %1317, i32 %1318)
  %1320 = getelementptr [6 x i8], ptr @.str169, i64 0, i64 0
  %1321 = load i32, ptr %1290
  call void @emit(ptr %0, ptr %1320, i32 %1321)
  %1323 = alloca i64
  %1325 = load i64, ptr %2
  %1326 = getelementptr i32, ptr %1325, i64 1
  %1327 = load i32, ptr %1326
  %1328 = call i64 @emit_expr(ptr %0, i32 %1327)
  store i64 %1328, ptr %1323
  %1329 = getelementptr [18 x i8], ptr @.str170, i64 0, i64 0
  %1330 = load i32, ptr %1293
  call void @emit(ptr %0, ptr %1329, i32 %1330)
  %1332 = getelementptr [6 x i8], ptr @.str171, i64 0, i64 0
  %1333 = load i32, ptr %1293
  call void @emit(ptr %0, ptr %1332, i32 %1333)
  %1335 = alloca i32
  %1337 = call i32 @new_reg(ptr %0)
  store i32 %1337, ptr %1335
  %1338 = getelementptr [47 x i8], ptr @.str172, i64 0, i64 0
  %1339 = load i32, ptr %1335
  %1340 = load i64, ptr %1311
  %1341 = load i32, ptr %1287
  %1342 = load i64, ptr %1323
  %1343 = load i32, ptr %1290
  call void @emit(ptr %0, ptr %1338, i32 %1339, i32 %1340, i32 %1341, i32 %1342, i32 %1343)
  %1345 = alloca ptr
  %1347 = load ptr, ptr %1345
  %1348 = getelementptr [5 x i8], ptr @.str173, i64 0, i64 0
  %1349 = load i32, ptr %1335
  %1350 = call i32 @snprintf(ptr %1347, i32 8, ptr %1348, i32 %1349)
  %1351 = load ptr, ptr %1345
  %1352 = load i64, ptr %1311
  %1353 = call i64 @make_val(ptr %1351, i32 %1352)
  ret i64 %1353
L297:
  br label %L24
L24:
  %1354 = alloca i32
  %1356 = load i64, ptr %2
  %1357 = icmp ne i64 %1356, 0
  br i1 %1357, label %L298, label %L299
L298:
  %1358 = load i64, ptr %2
  %1359 = call i32 @type_size(i32 %1358)
  br label %L300
L299:
  br label %L300
L300:
  %1360 = phi i64 [ %1359, %L298 ], [ 0, %L299 ]
  store i32 %1360, ptr %1354
  %1361 = alloca ptr
  %1363 = load ptr, ptr %1361
  %1364 = getelementptr [3 x i8], ptr @.str174, i64 0, i64 0
  %1365 = load i32, ptr %1354
  %1366 = call i32 @snprintf(ptr %1363, i32 8, ptr %1364, i32 %1365)
  %1367 = load ptr, ptr %1361
  %1368 = call ptr @default_int_type()
  %1369 = call i64 @make_val(ptr %1367, ptr %1368)
  ret i64 %1369
L301:
  br label %L25
L25:
  %1370 = alloca i32
  %1372 = load i64, ptr %2
  %1373 = getelementptr i32, ptr %1372, i64 0
  %1374 = load i32, ptr %1373
  %1375 = load i64, ptr %1374
  %1376 = icmp ne i64 %1375, 0
  br i1 %1376, label %L302, label %L303
L302:
  %1377 = load i64, ptr %2
  %1378 = getelementptr i32, ptr %1377, i64 0
  %1379 = load i32, ptr %1378
  %1380 = load i64, ptr %1379
  %1381 = call i32 @type_size(i32 %1380)
  br label %L304
L303:
  br label %L304
L304:
  %1382 = phi i64 [ %1381, %L302 ], [ 8, %L303 ]
  store i32 %1382, ptr %1370
  %1383 = alloca ptr
  %1385 = load ptr, ptr %1383
  %1386 = getelementptr [3 x i8], ptr @.str175, i64 0, i64 0
  %1387 = load i32, ptr %1370
  %1388 = call i32 @snprintf(ptr %1385, i32 8, ptr %1386, i32 %1387)
  %1389 = load ptr, ptr %1383
  %1390 = call ptr @default_int_type()
  %1391 = call i64 @make_val(ptr %1389, ptr %1390)
  ret i64 %1391
L305:
  br label %L26
L26:
  %1392 = alloca i64
  %1394 = getelementptr [2 x i8], ptr @.str176, i64 0, i64 0
  %1395 = call ptr @default_int_type()
  %1396 = call i64 @make_val(ptr %1394, ptr %1395)
  store i64 %1396, ptr %1392
  %1397 = alloca i32
  store i32 0, ptr %1397
  br label %L306
L306:
  %1399 = load i32, ptr %1397
  %1400 = load i64, ptr %2
  %1402 = sext i32 %1399 to i64
  %1403 = sext i32 %1400 to i64
  %1401 = icmp slt i64 %1402, %1403
  %1404 = zext i1 %1401 to i64
  %1405 = icmp ne i64 %1404, 0
  br i1 %1405, label %L307, label %L309
L307:
  %1406 = load i64, ptr %2
  %1407 = load i32, ptr %1397
  %1408 = getelementptr i32, ptr %1406, i64 %1407
  %1409 = load i32, ptr %1408
  %1410 = call i64 @emit_expr(ptr %0, i32 %1409)
  store i64 %1410, ptr %1392
  br label %L308
L308:
  %1411 = load i32, ptr %1397
  %1413 = sext i32 %1411 to i64
  %1412 = add i64 %1413, 1
  store i64 %1412, ptr %1397
  br label %L306
L309:
  %1414 = load i64, ptr %1392
  ret i64 %1414
L310:
  br label %L27
L27:
  br label %L28
L28:
  %1415 = alloca i64
  %1417 = load i64, ptr %2
  %1419 = sext i32 %1417 to i64
  %1420 = sext i32 @ND_ARROW to i64
  %1418 = icmp eq i64 %1419, %1420
  %1421 = zext i1 %1418 to i64
  %1422 = icmp ne i64 %1421, 0
  br i1 %1422, label %L311, label %L312
L311:
  %1423 = load i64, ptr %2
  %1424 = getelementptr i32, ptr %1423, i64 0
  %1425 = load i32, ptr %1424
  %1426 = call i64 @emit_expr(ptr %0, i32 %1425)
  store i64 %1426, ptr %1415
  br label %L313
L312:
  %1427 = alloca ptr
  %1429 = load i64, ptr %2
  %1430 = getelementptr i32, ptr %1429, i64 0
  %1431 = load i32, ptr %1430
  %1432 = call ptr @emit_lvalue_addr(ptr %0, i32 %1431)
  store ptr %1432, ptr %1427
  %1433 = load ptr, ptr %1427
  %1434 = icmp ne i64 %1433, 0
  br i1 %1434, label %L314, label %L315
L314:
  %1435 = load ptr, ptr %1427
  br label %L316
L315:
  %1436 = getelementptr [5 x i8], ptr @.str177, i64 0, i64 0
  br label %L316
L316:
  %1437 = phi i64 [ %1435, %L314 ], [ %1436, %L315 ]
  %1438 = inttoptr i64 0 to ptr
  %1439 = call i64 @make_val(ptr %1437, ptr %1438)
  store i64 %1439, ptr %1415
  %1440 = load ptr, ptr %1427
  %1441 = call i32 @free(ptr %1440)
  br label %L313
L313:
  %1442 = alloca i32
  %1444 = call i32 @new_reg(ptr %0)
  store i32 %1444, ptr %1442
  %1445 = getelementptr [27 x i8], ptr @.str178, i64 0, i64 0
  %1446 = load i32, ptr %1442
  %1447 = load i64, ptr %1415
  call void @emit(ptr %0, ptr %1445, i32 %1446, i32 %1447)
  %1449 = alloca ptr
  %1451 = load ptr, ptr %1449
  %1452 = getelementptr [5 x i8], ptr @.str179, i64 0, i64 0
  %1453 = load i32, ptr %1442
  %1454 = call i32 @snprintf(ptr %1451, i32 8, ptr %1452, i32 %1453)
  %1455 = load ptr, ptr %1449
  %1456 = call ptr @default_int_type()
  %1457 = call i64 @make_val(ptr %1455, ptr %1456)
  ret i64 %1457
L317:
  br label %L4
L29:
  %1458 = getelementptr [28 x i8], ptr @.str180, i64 0, i64 0
  %1459 = load i64, ptr %2
  call void @emit(ptr %0, ptr %1458, i32 %1459)
  %1461 = getelementptr [2 x i8], ptr @.str181, i64 0, i64 0
  %1462 = call ptr @default_int_type()
  %1463 = call i64 @make_val(ptr %1461, ptr %1462)
  ret i64 %1463
L318:
  br label %L4
L4:
  ret i64 0
}

define internal void @emit_stmt(ptr %0, ptr %2) {
entry:
  %5 = icmp eq i64 %2, 0
  %4 = zext i1 %5 to i64
  %6 = icmp ne i64 %4, 0
  br i1 %6, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %7 = load i64, ptr %2
  %8 = sext i32 %7 to i64
  switch i64 %8, label %L21 [
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
    i64 0, label %L19
    i64 0, label %L20
  ]
L5:
  call void @scope_push(ptr %0)
  %10 = alloca i32
  store i32 0, ptr %10
  br label %L22
L22:
  %12 = load i32, ptr %10
  %13 = load i64, ptr %2
  %15 = sext i32 %12 to i64
  %16 = sext i32 %13 to i64
  %14 = icmp slt i64 %15, %16
  %17 = zext i1 %14 to i64
  %18 = icmp ne i64 %17, 0
  br i1 %18, label %L23, label %L25
L23:
  %19 = load i64, ptr %2
  %20 = load i32, ptr %10
  %21 = getelementptr i32, ptr %19, i64 %20
  %22 = load i32, ptr %21
  call void @emit_stmt(ptr %0, i32 %22)
  br label %L24
L24:
  %24 = load i32, ptr %10
  %26 = sext i32 %24 to i64
  %25 = add i64 %26, 1
  store i64 %25, ptr %10
  br label %L22
L25:
  call void @scope_pop(ptr %0)
  br label %L4
L26:
  br label %L6
L6:
  %28 = alloca ptr
  %30 = load i64, ptr %2
  %31 = icmp ne i64 %30, 0
  br i1 %31, label %L27, label %L28
L27:
  %32 = load i64, ptr %2
  br label %L29
L28:
  %33 = call ptr @default_int_type()
  br label %L29
L29:
  %34 = phi i64 [ %32, %L27 ], [ %33, %L28 ]
  store ptr %34, ptr %28
  %35 = alloca ptr
  %37 = load ptr, ptr %28
  %38 = call ptr @llvm_type(ptr %37)
  store ptr %38, ptr %35
  %39 = alloca i32
  %41 = call i32 @new_reg(ptr %0)
  store i32 %41, ptr %39
  %42 = getelementptr [20 x i8], ptr @.str182, i64 0, i64 0
  %43 = load i32, ptr %39
  %44 = load ptr, ptr %35
  call void @emit(ptr %0, ptr %42, i32 %43, ptr %44)
  %46 = alloca ptr
  %48 = load i64, ptr %2
  %49 = icmp ne i64 %48, 0
  br i1 %49, label %L30, label %L31
L30:
  %50 = load i64, ptr %2
  br label %L32
L31:
  %51 = getelementptr [7 x i8], ptr @.str183, i64 0, i64 0
  br label %L32
L32:
  %52 = phi i64 [ %50, %L30 ], [ %51, %L31 ]
  %53 = load ptr, ptr %28
  %54 = call ptr @add_local(ptr %0, i32 %52, ptr %53, i32 0)
  store ptr %54, ptr %46
  %55 = load ptr, ptr %46
  %56 = load i64, ptr %55
  %57 = call i32 @free(i32 %56)
  %58 = call i32 @malloc(i32 32)
  %59 = load ptr, ptr %46
  store i32 %58, ptr %59
  %60 = load ptr, ptr %46
  %61 = load i64, ptr %60
  %62 = getelementptr [5 x i8], ptr @.str184, i64 0, i64 0
  %63 = load i32, ptr %39
  %64 = call i32 @snprintf(i32 %61, i32 32, ptr %62, i32 %63)
  %65 = load i64, ptr %2
  %67 = sext i32 %65 to i64
  %68 = sext i32 0 to i64
  %66 = icmp sgt i64 %67, %68
  %69 = zext i1 %66 to i64
  %70 = icmp ne i64 %69, 0
  br i1 %70, label %L33, label %L35
L33:
  %71 = alloca i64
  %73 = load i64, ptr %2
  %74 = getelementptr i32, ptr %73, i64 0
  %75 = load i32, ptr %74
  %76 = call i64 @emit_expr(ptr %0, i32 %75)
  store i64 %76, ptr %71
  %77 = getelementptr [25 x i8], ptr @.str185, i64 0, i64 0
  %78 = load ptr, ptr %35
  %79 = load i64, ptr %71
  %80 = load i32, ptr %39
  call void @emit(ptr %0, ptr %77, ptr %78, i32 %79, i32 %80)
  br label %L35
L35:
  %82 = alloca i32
  store i32 1, ptr %82
  br label %L36
L36:
  %84 = load i32, ptr %82
  %85 = load i64, ptr %2
  %87 = sext i32 %84 to i64
  %88 = sext i32 %85 to i64
  %86 = icmp slt i64 %87, %88
  %89 = zext i1 %86 to i64
  %90 = icmp ne i64 %89, 0
  br i1 %90, label %L37, label %L39
L37:
  %91 = load i64, ptr %2
  %92 = load i32, ptr %82
  %93 = getelementptr i32, ptr %91, i64 %92
  %94 = load i32, ptr %93
  call void @emit_stmt(ptr %0, i32 %94)
  br label %L38
L38:
  %96 = load i32, ptr %82
  %98 = sext i32 %96 to i64
  %97 = add i64 %98, 1
  store i64 %97, ptr %82
  br label %L36
L39:
  br label %L4
L40:
  br label %L7
L7:
  %99 = load i64, ptr %2
  %101 = sext i32 %99 to i64
  %102 = sext i32 0 to i64
  %100 = icmp sgt i64 %101, %102
  %103 = zext i1 %100 to i64
  %104 = icmp ne i64 %103, 0
  br i1 %104, label %L41, label %L43
L41:
  %105 = load i64, ptr %2
  %106 = getelementptr i32, ptr %105, i64 0
  %107 = load i32, ptr %106
  %108 = call i64 @emit_expr(ptr %0, i32 %107)
  br label %L43
L43:
  br label %L4
L44:
  br label %L8
L8:
  %109 = load i64, ptr %2
  %110 = icmp ne i64 %109, 0
  br i1 %110, label %L45, label %L46
L45:
  %111 = alloca i64
  %113 = load i64, ptr %2
  %114 = call i64 @emit_expr(ptr %0, i32 %113)
  store i64 %114, ptr %111
  %115 = getelementptr [13 x i8], ptr @.str186, i64 0, i64 0
  %116 = load i64, ptr %0
  %117 = call ptr @llvm_type(i32 %116)
  %118 = load i64, ptr %111
  call void @emit(ptr %0, ptr %115, ptr %117, i32 %118)
  br label %L47
L46:
  %120 = getelementptr [12 x i8], ptr @.str187, i64 0, i64 0
  call void @emit(ptr %0, ptr %120)
  br label %L47
L47:
  %122 = alloca i32
  %124 = call i32 @new_label(ptr %0)
  store i32 %124, ptr %122
  %125 = getelementptr [6 x i8], ptr @.str188, i64 0, i64 0
  %126 = load i32, ptr %122
  call void @emit(ptr %0, ptr %125, i32 %126)
  br label %L4
L48:
  br label %L9
L9:
  %128 = alloca i64
  %130 = load i64, ptr %2
  %131 = call i64 @emit_expr(ptr %0, i32 %130)
  store i64 %131, ptr %128
  %132 = alloca i32
  %134 = call i32 @new_reg(ptr %0)
  store i32 %134, ptr %132
  %135 = getelementptr [28 x i8], ptr @.str189, i64 0, i64 0
  %136 = load i32, ptr %132
  %137 = load i64, ptr %128
  call void @emit(ptr %0, ptr %135, i32 %136, i32 %137)
  %139 = alloca i32
  %141 = call i32 @new_label(ptr %0)
  store i32 %141, ptr %139
  %142 = alloca i32
  %144 = call i32 @new_label(ptr %0)
  store i32 %144, ptr %142
  %145 = alloca i32
  %147 = call i32 @new_label(ptr %0)
  store i32 %147, ptr %145
  %148 = getelementptr [40 x i8], ptr @.str190, i64 0, i64 0
  %149 = load i32, ptr %132
  %150 = load i32, ptr %139
  %151 = load i64, ptr %2
  %152 = icmp ne i64 %151, 0
  br i1 %152, label %L49, label %L50
L49:
  %153 = load i32, ptr %142
  br label %L51
L50:
  %154 = load i32, ptr %145
  br label %L51
L51:
  %155 = phi i64 [ %153, %L49 ], [ %154, %L50 ]
  call void @emit(ptr %0, ptr %148, i32 %149, i32 %150, i32 %155)
  %157 = getelementptr [6 x i8], ptr @.str191, i64 0, i64 0
  %158 = load i32, ptr %139
  call void @emit(ptr %0, ptr %157, i32 %158)
  %160 = load i64, ptr %2
  call void @emit_stmt(ptr %0, i32 %160)
  %162 = getelementptr [18 x i8], ptr @.str192, i64 0, i64 0
  %163 = load i32, ptr %145
  call void @emit(ptr %0, ptr %162, i32 %163)
  %165 = load i64, ptr %2
  %166 = icmp ne i64 %165, 0
  br i1 %166, label %L52, label %L54
L52:
  %167 = getelementptr [6 x i8], ptr @.str193, i64 0, i64 0
  %168 = load i32, ptr %142
  call void @emit(ptr %0, ptr %167, i32 %168)
  %170 = load i64, ptr %2
  call void @emit_stmt(ptr %0, i32 %170)
  %172 = getelementptr [18 x i8], ptr @.str194, i64 0, i64 0
  %173 = load i32, ptr %145
  call void @emit(ptr %0, ptr %172, i32 %173)
  br label %L54
L54:
  %175 = getelementptr [6 x i8], ptr @.str195, i64 0, i64 0
  %176 = load i32, ptr %145
  call void @emit(ptr %0, ptr %175, i32 %176)
  br label %L4
L55:
  br label %L10
L10:
  %178 = alloca i32
  %180 = call i32 @new_label(ptr %0)
  store i32 %180, ptr %178
  %181 = alloca i32
  %183 = call i32 @new_label(ptr %0)
  store i32 %183, ptr %181
  %184 = alloca i32
  %186 = call i32 @new_label(ptr %0)
  store i32 %186, ptr %184
  %187 = alloca ptr
  %189 = alloca ptr
  %191 = load i64, ptr %0
  %192 = call i32 @strcpy(ptr @old_break, i32 %191)
  %193 = load i64, ptr %0
  %194 = call i32 @strcpy(ptr @old_cont, i32 %193)
  %195 = load i64, ptr %0
  %196 = getelementptr [4 x i8], ptr @.str196, i64 0, i64 0
  %197 = load i32, ptr %184
  %198 = call i32 @snprintf(i32 %195, i32 64, ptr %196, i32 %197)
  %199 = load i64, ptr %0
  %200 = getelementptr [4 x i8], ptr @.str197, i64 0, i64 0
  %201 = load i32, ptr %178
  %202 = call i32 @snprintf(i32 %199, i32 64, ptr %200, i32 %201)
  %203 = getelementptr [18 x i8], ptr @.str198, i64 0, i64 0
  %204 = load i32, ptr %178
  call void @emit(ptr %0, ptr %203, i32 %204)
  %206 = getelementptr [6 x i8], ptr @.str199, i64 0, i64 0
  %207 = load i32, ptr %178
  call void @emit(ptr %0, ptr %206, i32 %207)
  %209 = alloca i64
  %211 = load i64, ptr %2
  %212 = call i64 @emit_expr(ptr %0, i32 %211)
  store i64 %212, ptr %209
  %213 = alloca i32
  %215 = call i32 @new_reg(ptr %0)
  store i32 %215, ptr %213
  %216 = getelementptr [28 x i8], ptr @.str200, i64 0, i64 0
  %217 = load i32, ptr %213
  %218 = load i64, ptr %209
  call void @emit(ptr %0, ptr %216, i32 %217, i32 %218)
  %220 = getelementptr [40 x i8], ptr @.str201, i64 0, i64 0
  %221 = load i32, ptr %213
  %222 = load i32, ptr %181
  %223 = load i32, ptr %184
  call void @emit(ptr %0, ptr %220, i32 %221, i32 %222, i32 %223)
  %225 = getelementptr [6 x i8], ptr @.str202, i64 0, i64 0
  %226 = load i32, ptr %181
  call void @emit(ptr %0, ptr %225, i32 %226)
  %228 = load i64, ptr %2
  call void @emit_stmt(ptr %0, i32 %228)
  %230 = getelementptr [18 x i8], ptr @.str203, i64 0, i64 0
  %231 = load i32, ptr %178
  call void @emit(ptr %0, ptr %230, i32 %231)
  %233 = getelementptr [6 x i8], ptr @.str204, i64 0, i64 0
  %234 = load i32, ptr %184
  call void @emit(ptr %0, ptr %233, i32 %234)
  %236 = load i64, ptr %0
  %237 = call i32 @strcpy(i32 %236, ptr @old_break)
  %238 = load i64, ptr %0
  %239 = call i32 @strcpy(i32 %238, ptr @old_cont)
  br label %L4
L56:
  br label %L11
L11:
  %240 = alloca i32
  %242 = call i32 @new_label(ptr %0)
  store i32 %242, ptr %240
  %243 = alloca i32
  %245 = call i32 @new_label(ptr %0)
  store i32 %245, ptr %243
  %246 = alloca i32
  %248 = call i32 @new_label(ptr %0)
  store i32 %248, ptr %246
  %249 = alloca ptr
  %251 = alloca ptr
  %253 = load i64, ptr %0
  %254 = call i32 @strcpy(ptr @old_break, i32 %253)
  %255 = load i64, ptr %0
  %256 = call i32 @strcpy(ptr @old_cont, i32 %255)
  %257 = load i64, ptr %0
  %258 = getelementptr [4 x i8], ptr @.str205, i64 0, i64 0
  %259 = load i32, ptr %246
  %260 = call i32 @snprintf(i32 %257, i32 64, ptr %258, i32 %259)
  %261 = load i64, ptr %0
  %262 = getelementptr [4 x i8], ptr @.str206, i64 0, i64 0
  %263 = load i32, ptr %243
  %264 = call i32 @snprintf(i32 %261, i32 64, ptr %262, i32 %263)
  %265 = getelementptr [18 x i8], ptr @.str207, i64 0, i64 0
  %266 = load i32, ptr %240
  call void @emit(ptr %0, ptr %265, i32 %266)
  %268 = getelementptr [6 x i8], ptr @.str208, i64 0, i64 0
  %269 = load i32, ptr %240
  call void @emit(ptr %0, ptr %268, i32 %269)
  %271 = load i64, ptr %2
  call void @emit_stmt(ptr %0, i32 %271)
  %273 = getelementptr [18 x i8], ptr @.str209, i64 0, i64 0
  %274 = load i32, ptr %243
  call void @emit(ptr %0, ptr %273, i32 %274)
  %276 = getelementptr [6 x i8], ptr @.str210, i64 0, i64 0
  %277 = load i32, ptr %243
  call void @emit(ptr %0, ptr %276, i32 %277)
  %279 = alloca i64
  %281 = load i64, ptr %2
  %282 = call i64 @emit_expr(ptr %0, i32 %281)
  store i64 %282, ptr %279
  %283 = alloca i32
  %285 = call i32 @new_reg(ptr %0)
  store i32 %285, ptr %283
  %286 = getelementptr [28 x i8], ptr @.str211, i64 0, i64 0
  %287 = load i32, ptr %283
  %288 = load i64, ptr %279
  call void @emit(ptr %0, ptr %286, i32 %287, i32 %288)
  %290 = getelementptr [40 x i8], ptr @.str212, i64 0, i64 0
  %291 = load i32, ptr %283
  %292 = load i32, ptr %240
  %293 = load i32, ptr %246
  call void @emit(ptr %0, ptr %290, i32 %291, i32 %292, i32 %293)
  %295 = getelementptr [6 x i8], ptr @.str213, i64 0, i64 0
  %296 = load i32, ptr %246
  call void @emit(ptr %0, ptr %295, i32 %296)
  %298 = load i64, ptr %0
  %299 = call i32 @strcpy(i32 %298, ptr @old_break)
  %300 = load i64, ptr %0
  %301 = call i32 @strcpy(i32 %300, ptr @old_cont)
  br label %L4
L57:
  br label %L12
L12:
  %302 = alloca i32
  %304 = call i32 @new_label(ptr %0)
  store i32 %304, ptr %302
  %305 = alloca i32
  %307 = call i32 @new_label(ptr %0)
  store i32 %307, ptr %305
  %308 = alloca i32
  %310 = call i32 @new_label(ptr %0)
  store i32 %310, ptr %308
  %311 = alloca i32
  %313 = call i32 @new_label(ptr %0)
  store i32 %313, ptr %311
  %314 = alloca ptr
  %316 = alloca ptr
  %318 = load i64, ptr %0
  %319 = call i32 @strcpy(ptr @old_break, i32 %318)
  %320 = load i64, ptr %0
  %321 = call i32 @strcpy(ptr @old_cont, i32 %320)
  %322 = load i64, ptr %0
  %323 = getelementptr [4 x i8], ptr @.str214, i64 0, i64 0
  %324 = load i32, ptr %311
  %325 = call i32 @snprintf(i32 %322, i32 64, ptr %323, i32 %324)
  %326 = load i64, ptr %0
  %327 = getelementptr [4 x i8], ptr @.str215, i64 0, i64 0
  %328 = load i32, ptr %308
  %329 = call i32 @snprintf(i32 %326, i32 64, ptr %327, i32 %328)
  call void @scope_push(ptr %0)
  %331 = load i64, ptr %2
  %332 = icmp ne i64 %331, 0
  br i1 %332, label %L58, label %L60
L58:
  %333 = load i64, ptr %2
  call void @emit_stmt(ptr %0, i32 %333)
  br label %L60
L60:
  %335 = getelementptr [18 x i8], ptr @.str216, i64 0, i64 0
  %336 = load i32, ptr %302
  call void @emit(ptr %0, ptr %335, i32 %336)
  %338 = getelementptr [6 x i8], ptr @.str217, i64 0, i64 0
  %339 = load i32, ptr %302
  call void @emit(ptr %0, ptr %338, i32 %339)
  %341 = load i64, ptr %2
  %342 = icmp ne i64 %341, 0
  br i1 %342, label %L61, label %L62
L61:
  %343 = alloca i64
  %345 = load i64, ptr %2
  %346 = call i64 @emit_expr(ptr %0, i32 %345)
  store i64 %346, ptr %343
  %347 = alloca i32
  %349 = call i32 @new_reg(ptr %0)
  store i32 %349, ptr %347
  %350 = getelementptr [28 x i8], ptr @.str218, i64 0, i64 0
  %351 = load i32, ptr %347
  %352 = load i64, ptr %343
  call void @emit(ptr %0, ptr %350, i32 %351, i32 %352)
  %354 = getelementptr [40 x i8], ptr @.str219, i64 0, i64 0
  %355 = load i32, ptr %347
  %356 = load i32, ptr %305
  %357 = load i32, ptr %311
  call void @emit(ptr %0, ptr %354, i32 %355, i32 %356, i32 %357)
  br label %L63
L62:
  %359 = getelementptr [18 x i8], ptr @.str220, i64 0, i64 0
  %360 = load i32, ptr %305
  call void @emit(ptr %0, ptr %359, i32 %360)
  br label %L63
L63:
  %362 = getelementptr [6 x i8], ptr @.str221, i64 0, i64 0
  %363 = load i32, ptr %305
  call void @emit(ptr %0, ptr %362, i32 %363)
  %365 = load i64, ptr %2
  call void @emit_stmt(ptr %0, i32 %365)
  %367 = getelementptr [18 x i8], ptr @.str222, i64 0, i64 0
  %368 = load i32, ptr %308
  call void @emit(ptr %0, ptr %367, i32 %368)
  %370 = getelementptr [6 x i8], ptr @.str223, i64 0, i64 0
  %371 = load i32, ptr %308
  call void @emit(ptr %0, ptr %370, i32 %371)
  %373 = load i64, ptr %2
  %374 = icmp ne i64 %373, 0
  br i1 %374, label %L64, label %L66
L64:
  %375 = load i64, ptr %2
  %376 = call i64 @emit_expr(ptr %0, i32 %375)
  br label %L66
L66:
  %377 = getelementptr [18 x i8], ptr @.str224, i64 0, i64 0
  %378 = load i32, ptr %302
  call void @emit(ptr %0, ptr %377, i32 %378)
  %380 = getelementptr [6 x i8], ptr @.str225, i64 0, i64 0
  %381 = load i32, ptr %311
  call void @emit(ptr %0, ptr %380, i32 %381)
  call void @scope_pop(ptr %0)
  %384 = load i64, ptr %0
  %385 = call i32 @strcpy(i32 %384, ptr @old_break)
  %386 = load i64, ptr %0
  %387 = call i32 @strcpy(i32 %386, ptr @old_cont)
  br label %L4
L67:
  br label %L13
L13:
  %388 = getelementptr [17 x i8], ptr @.str226, i64 0, i64 0
  %389 = load i64, ptr %0
  call void @emit(ptr %0, ptr %388, i32 %389)
  %391 = alloca i32
  %393 = call i32 @new_label(ptr %0)
  store i32 %393, ptr %391
  %394 = getelementptr [6 x i8], ptr @.str227, i64 0, i64 0
  %395 = load i32, ptr %391
  call void @emit(ptr %0, ptr %394, i32 %395)
  br label %L4
L68:
  br label %L14
L14:
  %397 = getelementptr [17 x i8], ptr @.str228, i64 0, i64 0
  %398 = load i64, ptr %0
  call void @emit(ptr %0, ptr %397, i32 %398)
  %400 = alloca i32
  %402 = call i32 @new_label(ptr %0)
  store i32 %402, ptr %400
  %403 = getelementptr [6 x i8], ptr @.str229, i64 0, i64 0
  %404 = load i32, ptr %400
  call void @emit(ptr %0, ptr %403, i32 %404)
  br label %L4
L69:
  br label %L15
L15:
  %406 = alloca i64
  %408 = load i64, ptr %2
  %409 = call i64 @emit_expr(ptr %0, i32 %408)
  store i64 %409, ptr %406
  %410 = alloca i32
  %412 = call i32 @new_label(ptr %0)
  store i32 %412, ptr %410
  %413 = alloca ptr
  %415 = load ptr, ptr %413
  %416 = load i64, ptr %0
  %417 = call i32 @strcpy(ptr %415, i32 %416)
  %418 = load i64, ptr %0
  %419 = getelementptr [4 x i8], ptr @.str230, i64 0, i64 0
  %420 = load i32, ptr %410
  %421 = call i32 @snprintf(i32 %418, i32 64, ptr %419, i32 %420)
  %422 = alloca ptr
  %424 = load i64, ptr %2
  store ptr %424, ptr %422
  %425 = alloca i32
  store i32 0, ptr %425
  %427 = alloca ptr
  %429 = alloca ptr
  %431 = alloca i32
  %433 = load i32, ptr %410
  store i32 %433, ptr %431
  %434 = alloca i32
  store i32 0, ptr %434
  br label %L70
L70:
  %436 = load i32, ptr %434
  %437 = load ptr, ptr %422
  %438 = load i64, ptr %437
  %440 = sext i32 %436 to i64
  %441 = sext i32 %438 to i64
  %439 = icmp slt i64 %440, %441
  %442 = zext i1 %439 to i64
  %443 = load i32, ptr %425
  %445 = sext i32 %443 to i64
  %446 = sext i32 256 to i64
  %444 = icmp slt i64 %445, %446
  %447 = zext i1 %444 to i64
  %449 = sext i32 %442 to i64
  %450 = sext i32 %447 to i64
  %451 = icmp ne i64 %449, 0
  %452 = icmp ne i64 %450, 0
  %453 = and i1 %451, %452
  %454 = zext i1 %453 to i64
  %455 = icmp ne i64 %454, 0
  br i1 %455, label %L71, label %L73
L71:
  %456 = alloca ptr
  %458 = load ptr, ptr %422
  %459 = load i64, ptr %458
  %460 = load i32, ptr %434
  %461 = getelementptr i32, ptr %459, i64 %460
  %462 = load i32, ptr %461
  store ptr %462, ptr %456
  %463 = load ptr, ptr %456
  %464 = load i64, ptr %463
  %466 = sext i32 %464 to i64
  %467 = sext i32 @ND_CASE to i64
  %465 = icmp eq i64 %466, %467
  %468 = zext i1 %465 to i64
  %469 = icmp ne i64 %468, 0
  br i1 %469, label %L74, label %L75
L74:
  %470 = call i32 @new_label(ptr %0)
  %471 = load ptr, ptr %427
  %472 = load i32, ptr %425
  %473 = getelementptr i8, ptr %471, i64 %472
  store i32 %470, ptr %473
  %474 = load ptr, ptr %456
  %475 = load i64, ptr %474
  %476 = icmp ne i64 %475, 0
  br i1 %476, label %L77, label %L78
L77:
  %477 = load ptr, ptr %456
  %478 = load i64, ptr %477
  %479 = load i64, ptr %478
  br label %L79
L78:
  br label %L79
L79:
  %480 = phi i64 [ %479, %L77 ], [ 0, %L78 ]
  %481 = load ptr, ptr %429
  %482 = load i32, ptr %425
  %483 = getelementptr i8, ptr %481, i64 %482
  store i32 %480, ptr %483
  %484 = load i32, ptr %425
  %486 = sext i32 %484 to i64
  %485 = add i64 %486, 1
  store i64 %485, ptr %425
  br label %L76
L75:
  %487 = load ptr, ptr %456
  %488 = load i64, ptr %487
  %490 = sext i32 %488 to i64
  %491 = sext i32 @ND_DEFAULT to i64
  %489 = icmp eq i64 %490, %491
  %492 = zext i1 %489 to i64
  %493 = icmp ne i64 %492, 0
  br i1 %493, label %L80, label %L82
L80:
  %494 = call i32 @new_label(ptr %0)
  store i32 %494, ptr %431
  br label %L82
L82:
  br label %L76
L76:
  br label %L72
L72:
  %495 = load i32, ptr %434
  %497 = sext i32 %495 to i64
  %496 = add i64 %497, 1
  store i64 %496, ptr %434
  br label %L70
L73:
  %498 = alloca i32
  %500 = call i32 @new_reg(ptr %0)
  store i32 %500, ptr %498
  %501 = getelementptr [29 x i8], ptr @.str231, i64 0, i64 0
  %502 = load i32, ptr %498
  %503 = load i64, ptr %406
  call void @emit(ptr %0, ptr %501, i32 %502, i32 %503)
  %505 = getelementptr [34 x i8], ptr @.str232, i64 0, i64 0
  %506 = load i32, ptr %498
  %507 = load i32, ptr %431
  call void @emit(ptr %0, ptr %505, i32 %506, i32 %507)
  %509 = alloca i32
  store i32 0, ptr %509
  %511 = alloca i32
  store i32 0, ptr %511
  br label %L83
L83:
  %513 = load i32, ptr %511
  %514 = load ptr, ptr %422
  %515 = load i64, ptr %514
  %517 = sext i32 %513 to i64
  %518 = sext i32 %515 to i64
  %516 = icmp slt i64 %517, %518
  %519 = zext i1 %516 to i64
  %520 = icmp ne i64 %519, 0
  br i1 %520, label %L84, label %L86
L84:
  %521 = alloca ptr
  %523 = load ptr, ptr %422
  %524 = load i64, ptr %523
  %525 = load i32, ptr %511
  %526 = getelementptr i32, ptr %524, i64 %525
  %527 = load i32, ptr %526
  store ptr %527, ptr %521
  %528 = load ptr, ptr %521
  %529 = load i64, ptr %528
  %531 = sext i32 %529 to i64
  %532 = sext i32 @ND_CASE to i64
  %530 = icmp eq i64 %531, %532
  %533 = zext i1 %530 to i64
  %534 = load i32, ptr %509
  %535 = load i32, ptr %425
  %537 = sext i32 %534 to i64
  %538 = sext i32 %535 to i64
  %536 = icmp slt i64 %537, %538
  %539 = zext i1 %536 to i64
  %541 = sext i32 %533 to i64
  %542 = sext i32 %539 to i64
  %543 = icmp ne i64 %541, 0
  %544 = icmp ne i64 %542, 0
  %545 = and i1 %543, %544
  %546 = zext i1 %545 to i64
  %547 = icmp ne i64 %546, 0
  br i1 %547, label %L87, label %L89
L87:
  %548 = getelementptr [27 x i8], ptr @.str233, i64 0, i64 0
  %549 = load ptr, ptr %429
  %550 = load i32, ptr %509
  %551 = getelementptr i64, ptr %549, i64 %550
  %552 = load i64, ptr %551
  %553 = load ptr, ptr %427
  %554 = load i32, ptr %509
  %555 = getelementptr i32, ptr %553, i64 %554
  %556 = load i32, ptr %555
  call void @emit(ptr %0, ptr %548, i64 %552, i32 %556)
  %558 = load i32, ptr %509
  %560 = sext i32 %558 to i64
  %559 = add i64 %560, 1
  store i64 %559, ptr %509
  br label %L89
L89:
  br label %L85
L85:
  %561 = load i32, ptr %511
  %563 = sext i32 %561 to i64
  %562 = add i64 %563, 1
  store i64 %562, ptr %511
  br label %L83
L86:
  %564 = getelementptr [5 x i8], ptr @.str234, i64 0, i64 0
  call void @emit(ptr %0, ptr %564)
  store i32 0, ptr %509
  %566 = alloca i32
  store i32 0, ptr %566
  %568 = alloca i32
  store i32 0, ptr %568
  br label %L90
L90:
  %570 = load i32, ptr %568
  %571 = load ptr, ptr %422
  %572 = load i64, ptr %571
  %574 = sext i32 %570 to i64
  %575 = sext i32 %572 to i64
  %573 = icmp slt i64 %574, %575
  %576 = zext i1 %573 to i64
  %577 = icmp ne i64 %576, 0
  br i1 %577, label %L91, label %L93
L91:
  %578 = alloca ptr
  %580 = load ptr, ptr %422
  %581 = load i64, ptr %580
  %582 = load i32, ptr %568
  %583 = getelementptr i32, ptr %581, i64 %582
  %584 = load i32, ptr %583
  store ptr %584, ptr %578
  %585 = load ptr, ptr %578
  %586 = load i64, ptr %585
  %588 = sext i32 %586 to i64
  %589 = sext i32 @ND_CASE to i64
  %587 = icmp eq i64 %588, %589
  %590 = zext i1 %587 to i64
  %591 = load i32, ptr %509
  %592 = load i32, ptr %425
  %594 = sext i32 %591 to i64
  %595 = sext i32 %592 to i64
  %593 = icmp slt i64 %594, %595
  %596 = zext i1 %593 to i64
  %598 = sext i32 %590 to i64
  %599 = sext i32 %596 to i64
  %600 = icmp ne i64 %598, 0
  %601 = icmp ne i64 %599, 0
  %602 = and i1 %600, %601
  %603 = zext i1 %602 to i64
  %604 = icmp ne i64 %603, 0
  br i1 %604, label %L94, label %L95
L94:
  %605 = getelementptr [6 x i8], ptr @.str235, i64 0, i64 0
  %606 = load ptr, ptr %427
  %607 = load i32, ptr %509
  %609 = sext i32 %607 to i64
  %608 = add i64 %609, 1
  store i64 %608, ptr %509
  %610 = getelementptr i32, ptr %606, i64 %607
  %611 = load i32, ptr %610
  call void @emit(ptr %0, ptr %605, i32 %611)
  %613 = load ptr, ptr %578
  %614 = load i64, ptr %613
  %616 = sext i32 %614 to i64
  %617 = sext i32 0 to i64
  %615 = icmp sgt i64 %616, %617
  %618 = zext i1 %615 to i64
  %619 = icmp ne i64 %618, 0
  br i1 %619, label %L97, label %L99
L97:
  %620 = load ptr, ptr %578
  %621 = load i64, ptr %620
  %622 = getelementptr i32, ptr %621, i64 0
  %623 = load i32, ptr %622
  call void @emit_stmt(ptr %0, i32 %623)
  br label %L99
L99:
  %625 = alloca i32
  %627 = load i32, ptr %509
  %628 = load i32, ptr %425
  %630 = sext i32 %627 to i64
  %631 = sext i32 %628 to i64
  %629 = icmp slt i64 %630, %631
  %632 = zext i1 %629 to i64
  %633 = icmp ne i64 %632, 0
  br i1 %633, label %L100, label %L101
L100:
  %634 = load ptr, ptr %427
  %635 = load i32, ptr %509
  %636 = getelementptr i32, ptr %634, i64 %635
  %637 = load i32, ptr %636
  br label %L102
L101:
  %638 = load i32, ptr %410
  br label %L102
L102:
  %639 = phi i64 [ %637, %L100 ], [ %638, %L101 ]
  store i32 %639, ptr %625
  %640 = getelementptr [18 x i8], ptr @.str236, i64 0, i64 0
  %641 = load i32, ptr %625
  call void @emit(ptr %0, ptr %640, i32 %641)
  br label %L96
L95:
  %643 = load ptr, ptr %578
  %644 = load i64, ptr %643
  %646 = sext i32 %644 to i64
  %647 = sext i32 @ND_DEFAULT to i64
  %645 = icmp eq i64 %646, %647
  %648 = zext i1 %645 to i64
  %649 = icmp ne i64 %648, 0
  br i1 %649, label %L103, label %L104
L103:
  %650 = getelementptr [6 x i8], ptr @.str237, i64 0, i64 0
  %651 = load i32, ptr %431
  call void @emit(ptr %0, ptr %650, i32 %651)
  %653 = load ptr, ptr %578
  %654 = load i64, ptr %653
  %656 = sext i32 %654 to i64
  %657 = sext i32 0 to i64
  %655 = icmp sgt i64 %656, %657
  %658 = zext i1 %655 to i64
  %659 = icmp ne i64 %658, 0
  br i1 %659, label %L106, label %L108
L106:
  %660 = load ptr, ptr %578
  %661 = load i64, ptr %660
  %662 = getelementptr i32, ptr %661, i64 0
  %663 = load i32, ptr %662
  call void @emit_stmt(ptr %0, i32 %663)
  br label %L108
L108:
  %665 = getelementptr [18 x i8], ptr @.str238, i64 0, i64 0
  %666 = load i32, ptr %410
  call void @emit(ptr %0, ptr %665, i32 %666)
  %668 = load i32, ptr %566
  %670 = sext i32 %668 to i64
  %669 = add i64 %670, 1
  store i64 %669, ptr %566
  br label %L105
L104:
  %671 = load ptr, ptr %578
  call void @emit_stmt(ptr %0, ptr %671)
  br label %L105
L105:
  br label %L96
L96:
  br label %L92
L92:
  %673 = load i32, ptr %568
  %675 = sext i32 %673 to i64
  %674 = add i64 %675, 1
  store i64 %674, ptr %568
  br label %L90
L93:
  %676 = getelementptr [6 x i8], ptr @.str239, i64 0, i64 0
  %677 = load i32, ptr %410
  call void @emit(ptr %0, ptr %676, i32 %677)
  %679 = load i64, ptr %0
  %680 = load ptr, ptr %413
  %681 = call i32 @strcpy(i32 %679, ptr %680)
  br label %L4
L109:
  br label %L16
L16:
  %682 = load i64, ptr %2
  %684 = sext i32 %682 to i64
  %685 = sext i32 0 to i64
  %683 = icmp sgt i64 %684, %685
  %686 = zext i1 %683 to i64
  %687 = icmp ne i64 %686, 0
  br i1 %687, label %L110, label %L112
L110:
  %688 = load i64, ptr %2
  %689 = getelementptr i32, ptr %688, i64 0
  %690 = load i32, ptr %689
  call void @emit_stmt(ptr %0, i32 %690)
  br label %L112
L112:
  br label %L4
L113:
  br label %L17
L17:
  %692 = load i64, ptr %2
  %694 = sext i32 %692 to i64
  %695 = sext i32 0 to i64
  %693 = icmp sgt i64 %694, %695
  %696 = zext i1 %693 to i64
  %697 = icmp ne i64 %696, 0
  br i1 %697, label %L114, label %L116
L114:
  %698 = load i64, ptr %2
  %699 = getelementptr i32, ptr %698, i64 0
  %700 = load i32, ptr %699
  call void @emit_stmt(ptr %0, i32 %700)
  br label %L116
L116:
  br label %L4
L117:
  br label %L18
L18:
  %702 = getelementptr [5 x i8], ptr @.str240, i64 0, i64 0
  %703 = load i64, ptr %2
  call void @emit(ptr %0, ptr %702, i32 %703)
  %705 = load i64, ptr %2
  %707 = sext i32 %705 to i64
  %708 = sext i32 0 to i64
  %706 = icmp sgt i64 %707, %708
  %709 = zext i1 %706 to i64
  %710 = icmp ne i64 %709, 0
  br i1 %710, label %L118, label %L120
L118:
  %711 = load i64, ptr %2
  %712 = getelementptr i32, ptr %711, i64 0
  %713 = load i32, ptr %712
  call void @emit_stmt(ptr %0, i32 %713)
  br label %L120
L120:
  br label %L4
L121:
  br label %L19
L19:
  %715 = getelementptr [17 x i8], ptr @.str241, i64 0, i64 0
  %716 = load i64, ptr %2
  call void @emit(ptr %0, ptr %715, i32 %716)
  %718 = alloca i32
  %720 = call i32 @new_label(ptr %0)
  store i32 %720, ptr %718
  %721 = getelementptr [6 x i8], ptr @.str242, i64 0, i64 0
  %722 = load i32, ptr %718
  call void @emit(ptr %0, ptr %721, i32 %722)
  br label %L4
L122:
  br label %L20
L20:
  br label %L4
L123:
  br label %L4
L21:
  %724 = call i64 @emit_expr(ptr %0, ptr %2)
  br label %L4
L124:
  br label %L4
L4:
  ret void
}

define internal void @emit_func_def(ptr %0, ptr %2) {
entry:
  %4 = alloca ptr
  %6 = load i64, ptr %2
  store ptr %6, ptr %4
  %7 = load ptr, ptr %4
  %9 = icmp eq i64 %7, 0
  %8 = zext i1 %9 to i64
  %10 = load ptr, ptr %4
  %11 = load i64, ptr %10
  %13 = sext i32 %11 to i64
  %14 = sext i32 @TY_FUNC to i64
  %12 = icmp ne i64 %13, %14
  %15 = zext i1 %12 to i64
  %17 = icmp ne i64 %8, 0
  %18 = icmp ne i64 %15, 0
  %19 = or i1 %17, %18
  %20 = zext i1 %19 to i64
  %21 = icmp ne i64 %20, 0
  br i1 %21, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  store i32 0, ptr %0
  store i32 0, ptr %0
  store i32 0, ptr %0
  %22 = load ptr, ptr %4
  %23 = load i64, ptr %22
  %24 = icmp ne i64 %23, 0
  br i1 %24, label %L4, label %L5
L4:
  %25 = load ptr, ptr %4
  %26 = load i64, ptr %25
  br label %L6
L5:
  %27 = call ptr @default_int_type()
  br label %L6
L6:
  %28 = phi i64 [ %26, %L4 ], [ %27, %L5 ]
  store i32 %28, ptr %0
  %29 = load i64, ptr %0
  %30 = load i64, ptr %2
  %31 = icmp ne i64 %30, 0
  br i1 %31, label %L7, label %L8
L7:
  %32 = load i64, ptr %2
  br label %L9
L8:
  %33 = getelementptr [5 x i8], ptr @.str243, i64 0, i64 0
  br label %L9
L9:
  %34 = phi i64 [ %32, %L7 ], [ %33, %L8 ]
  %35 = call i32 @strncpy(i32 %29, i32 %34, i32 127)
  %36 = alloca ptr
  %38 = load i64, ptr %2
  %39 = icmp ne i64 %38, 0
  br i1 %39, label %L10, label %L11
L10:
  %40 = getelementptr [9 x i8], ptr @.str244, i64 0, i64 0
  br label %L12
L11:
  %41 = getelementptr [10 x i8], ptr @.str245, i64 0, i64 0
  br label %L12
L12:
  %42 = phi i64 [ %40, %L10 ], [ %41, %L11 ]
  store ptr %42, ptr %36
  %43 = getelementptr [18 x i8], ptr @.str246, i64 0, i64 0
  %44 = load ptr, ptr %36
  %45 = load ptr, ptr %4
  %46 = call ptr @llvm_ret_type(ptr %45)
  %47 = load i64, ptr %2
  %48 = icmp ne i64 %47, 0
  br i1 %48, label %L13, label %L14
L13:
  %49 = load i64, ptr %2
  br label %L15
L14:
  %50 = getelementptr [5 x i8], ptr @.str247, i64 0, i64 0
  br label %L15
L15:
  %51 = phi i64 [ %49, %L13 ], [ %50, %L14 ]
  call void @emit(ptr %0, ptr %43, ptr %44, ptr %46, i32 %51)
  call void @scope_push(ptr %0)
  %54 = alloca i32
  store i32 0, ptr %54
  br label %L16
L16:
  %56 = load i32, ptr %54
  %57 = load ptr, ptr %4
  %58 = load i64, ptr %57
  %60 = sext i32 %56 to i64
  %61 = sext i32 %58 to i64
  %59 = icmp slt i64 %60, %61
  %62 = zext i1 %59 to i64
  %63 = icmp ne i64 %62, 0
  br i1 %63, label %L17, label %L19
L17:
  %64 = load i32, ptr %54
  %65 = icmp ne i64 %64, 0
  br i1 %65, label %L20, label %L22
L20:
  %66 = getelementptr [3 x i8], ptr @.str248, i64 0, i64 0
  call void @emit(ptr %0, ptr %66)
  br label %L22
L22:
  %68 = alloca ptr
  %70 = load ptr, ptr %4
  %71 = load i64, ptr %70
  %72 = load i32, ptr %54
  %73 = getelementptr i8, ptr %71, i64 %72
  %74 = load i64, ptr %73
  %75 = call ptr @llvm_type(i32 %74)
  store ptr %75, ptr %68
  %76 = alloca i32
  %78 = call i32 @new_reg(ptr %0)
  store i32 %78, ptr %76
  %79 = getelementptr [8 x i8], ptr @.str249, i64 0, i64 0
  %80 = load ptr, ptr %68
  %81 = load i32, ptr %76
  call void @emit(ptr %0, ptr %79, ptr %80, i32 %81)
  %83 = load i64, ptr %2
  %84 = load i64, ptr %2
  %85 = load i32, ptr %54
  %86 = getelementptr i32, ptr %84, i64 %85
  %87 = load i32, ptr %86
  %89 = sext i32 %83 to i64
  %90 = sext i32 %87 to i64
  %91 = icmp ne i64 %89, 0
  %92 = icmp ne i64 %90, 0
  %93 = and i1 %91, %92
  %94 = zext i1 %93 to i64
  %95 = icmp ne i64 %94, 0
  br i1 %95, label %L23, label %L25
L23:
  %96 = alloca ptr
  %98 = load i64, ptr %2
  %99 = load i32, ptr %54
  %100 = getelementptr i32, ptr %98, i64 %99
  %101 = load i32, ptr %100
  %102 = load ptr, ptr %4
  %103 = load i64, ptr %102
  %104 = load i32, ptr %54
  %105 = getelementptr i8, ptr %103, i64 %104
  %106 = load i64, ptr %105
  %107 = call ptr @add_local(ptr %0, i32 %101, i32 %106, i32 1)
  store i32 %107, ptr %96
  %108 = load ptr, ptr %96
  %109 = load i64, ptr %108
  %110 = call i32 @free(i32 %109)
  %111 = call i32 @malloc(i32 32)
  %112 = load ptr, ptr %96
  store i32 %111, ptr %112
  %113 = load ptr, ptr %96
  %114 = load i64, ptr %113
  %115 = getelementptr [5 x i8], ptr @.str250, i64 0, i64 0
  %116 = load i32, ptr %76
  %117 = call i32 @snprintf(i32 %114, i32 32, ptr %115, i32 %116)
  br label %L25
L25:
  br label %L18
L18:
  %118 = load i32, ptr %54
  %120 = sext i32 %118 to i64
  %119 = add i64 %120, 1
  store i64 %119, ptr %54
  br label %L16
L19:
  %121 = load ptr, ptr %4
  %122 = load i64, ptr %121
  %123 = icmp ne i64 %122, 0
  br i1 %123, label %L26, label %L28
L26:
  %124 = load ptr, ptr %4
  %125 = load i64, ptr %124
  %126 = icmp ne i64 %125, 0
  br i1 %126, label %L29, label %L31
L29:
  %127 = getelementptr [3 x i8], ptr @.str251, i64 0, i64 0
  call void @emit(ptr %0, ptr %127)
  br label %L31
L31:
  %129 = getelementptr [4 x i8], ptr @.str252, i64 0, i64 0
  call void @emit(ptr %0, ptr %129)
  br label %L28
L28:
  %131 = getelementptr [5 x i8], ptr @.str253, i64 0, i64 0
  call void @emit(ptr %0, ptr %131)
  %133 = getelementptr [8 x i8], ptr @.str254, i64 0, i64 0
  call void @emit(ptr %0, ptr %133)
  %135 = load i64, ptr %2
  call void @emit_stmt(ptr %0, i32 %135)
  %137 = load ptr, ptr %4
  %138 = load i64, ptr %137
  %139 = load ptr, ptr %4
  %140 = load i64, ptr %139
  %141 = load i64, ptr %140
  %143 = sext i32 %141 to i64
  %144 = sext i32 @TY_VOID to i64
  %142 = icmp eq i64 %143, %144
  %145 = zext i1 %142 to i64
  %147 = sext i32 %138 to i64
  %148 = sext i32 %145 to i64
  %149 = icmp ne i64 %147, 0
  %150 = icmp ne i64 %148, 0
  %151 = and i1 %149, %150
  %152 = zext i1 %151 to i64
  %153 = icmp ne i64 %152, 0
  br i1 %153, label %L32, label %L33
L32:
  %154 = getelementptr [12 x i8], ptr @.str255, i64 0, i64 0
  call void @emit(ptr %0, ptr %154)
  br label %L34
L33:
  %156 = getelementptr [12 x i8], ptr @.str256, i64 0, i64 0
  %157 = load ptr, ptr %4
  %158 = call ptr @llvm_ret_type(ptr %157)
  call void @emit(ptr %0, ptr %156, ptr %158)
  br label %L34
L34:
  %160 = getelementptr [4 x i8], ptr @.str257, i64 0, i64 0
  call void @emit(ptr %0, ptr %160)
  call void @scope_pop(ptr %0)
  ret void
}

define internal void @emit_global_var(ptr %0, ptr %2) {
entry:
  %4 = load i64, ptr %2
  %6 = icmp eq i64 %4, 0
  %5 = zext i1 %6 to i64
  %7 = icmp ne i64 %5, 0
  br i1 %7, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %8 = alloca i32
  store i32 0, ptr %8
  %10 = alloca i32
  store i32 0, ptr %10
  br label %L4
L4:
  %12 = load i32, ptr %10
  %13 = load i64, ptr %0
  %15 = sext i32 %12 to i64
  %16 = sext i32 %13 to i64
  %14 = icmp slt i64 %15, %16
  %17 = zext i1 %14 to i64
  %18 = icmp ne i64 %17, 0
  br i1 %18, label %L5, label %L7
L5:
  %19 = load i64, ptr %0
  %20 = load i32, ptr %10
  %21 = getelementptr i8, ptr %19, i64 %20
  %22 = load i64, ptr %21
  %23 = load i64, ptr %2
  %24 = call i32 @strcmp(i32 %22, i32 %23)
  %26 = sext i32 %24 to i64
  %27 = sext i32 0 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  store i32 1, ptr %8
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %30 = load i32, ptr %10
  %32 = sext i32 %30 to i64
  %31 = add i64 %32, 1
  store i64 %31, ptr %10
  br label %L4
L7:
  %33 = load i32, ptr %8
  %35 = icmp eq i64 %33, 0
  %34 = zext i1 %35 to i64
  %36 = load i64, ptr %0
  %38 = sext i32 %36 to i64
  %39 = sext i32 1024 to i64
  %37 = icmp slt i64 %38, %39
  %40 = zext i1 %37 to i64
  %42 = sext i32 %34 to i64
  %43 = sext i32 %40 to i64
  %44 = icmp ne i64 %42, 0
  %45 = icmp ne i64 %43, 0
  %46 = and i1 %44, %45
  %47 = zext i1 %46 to i64
  %48 = icmp ne i64 %47, 0
  br i1 %48, label %L12, label %L14
L12:
  %49 = load i64, ptr %2
  %50 = call i32 @strdup(i32 %49)
  %51 = load i64, ptr %0
  %52 = load i64, ptr %0
  %53 = getelementptr i8, ptr %51, i64 %52
  store i32 %50, ptr %53
  %54 = load i64, ptr %2
  %55 = load i64, ptr %0
  %56 = load i64, ptr %0
  %57 = getelementptr i8, ptr %55, i64 %56
  store i32 %54, ptr %57
  %58 = load i64, ptr %2
  %59 = load i64, ptr %0
  %60 = load i64, ptr %0
  %61 = getelementptr i8, ptr %59, i64 %60
  store i32 %58, ptr %61
  %62 = load i64, ptr %0
  %64 = sext i32 %62 to i64
  %63 = add i64 %64, 1
  store i64 %63, ptr %0
  br label %L14
L14:
  %65 = load i64, ptr %2
  %66 = icmp ne i64 %65, 0
  br i1 %66, label %L15, label %L17
L15:
  %67 = getelementptr [26 x i8], ptr @.str258, i64 0, i64 0
  %68 = load i64, ptr %2
  %69 = load i64, ptr %2
  %70 = call ptr @llvm_type(i32 %69)
  call void @emit(ptr %0, ptr %67, i32 %68, ptr %70)
  ret void
L18:
  br label %L17
L17:
  %72 = alloca ptr
  %74 = load i64, ptr %2
  %75 = icmp ne i64 %74, 0
  br i1 %75, label %L19, label %L20
L19:
  %76 = getelementptr [9 x i8], ptr @.str259, i64 0, i64 0
  br label %L21
L20:
  %77 = getelementptr [10 x i8], ptr @.str260, i64 0, i64 0
  br label %L21
L21:
  %78 = phi i64 [ %76, %L19 ], [ %77, %L20 ]
  store ptr %78, ptr %72
  %79 = alloca ptr
  %81 = load i64, ptr %2
  %82 = call ptr @llvm_type(i32 %81)
  store ptr %82, ptr %79
  %83 = getelementptr [36 x i8], ptr @.str261, i64 0, i64 0
  %84 = load i64, ptr %2
  %85 = load ptr, ptr %72
  %86 = load ptr, ptr %79
  call void @emit(ptr %0, ptr %83, i32 %84, ptr %85, ptr %86)
  ret void
}

define dso_local ptr @codegen_new(ptr %0, ptr %2) {
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
  %11 = getelementptr [7 x i8], ptr @.str262, i64 0, i64 0
  %12 = call i32 @perror(ptr %11)
  %13 = call i32 @exit(i32 1)
  br label %L2
L2:
  %14 = load ptr, ptr %4
  store ptr %0, ptr %14
  %15 = load ptr, ptr %4
  store ptr %2, ptr %15
  %16 = load ptr, ptr %4
  ret ptr %16
L3:
  ret ptr 0
}

define dso_local void @codegen_free(ptr %0) {
entry:
  %2 = alloca i32
  store i32 0, ptr %2
  br label %L0
L0:
  %4 = load i32, ptr %2
  %5 = load i64, ptr %0
  %7 = sext i32 %4 to i64
  %8 = sext i32 %5 to i64
  %6 = icmp slt i64 %7, %8
  %9 = zext i1 %6 to i64
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %L1, label %L3
L1:
  %11 = load i64, ptr %0
  %12 = load i32, ptr %2
  %13 = getelementptr i8, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %15 = call i32 @free(i32 %14)
  br label %L2
L2:
  %16 = load i32, ptr %2
  %18 = sext i32 %16 to i64
  %17 = add i64 %18, 1
  store i64 %17, ptr %2
  br label %L0
L3:
  %19 = alloca i32
  store i32 0, ptr %19
  br label %L4
L4:
  %21 = load i32, ptr %19
  %22 = load i64, ptr %0
  %24 = sext i32 %21 to i64
  %25 = sext i32 %22 to i64
  %23 = icmp slt i64 %24, %25
  %26 = zext i1 %23 to i64
  %27 = icmp ne i64 %26, 0
  br i1 %27, label %L5, label %L7
L5:
  %28 = load i64, ptr %0
  %29 = load i32, ptr %19
  %30 = getelementptr i32, ptr %28, i64 %29
  %31 = load i32, ptr %30
  %32 = call i32 @free(i32 %31)
  br label %L6
L6:
  %33 = load i32, ptr %19
  %35 = sext i32 %33 to i64
  %34 = add i64 %35, 1
  store i64 %34, ptr %19
  br label %L4
L7:
  %36 = call i32 @free(ptr %0)
  ret void
}

define dso_local void @codegen_emit(ptr %0, ptr %2) {
entry:
  %5 = icmp eq i64 %2, 0
  %4 = zext i1 %5 to i64
  %6 = icmp ne i64 %4, 0
  br i1 %6, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %7 = getelementptr [19 x i8], ptr @.str263, i64 0, i64 0
  %8 = load i64, ptr %0
  call void @emit(ptr %0, ptr %7, i32 %8)
  %10 = getelementptr [24 x i8], ptr @.str264, i64 0, i64 0
  %11 = load i64, ptr %0
  call void @emit(ptr %0, ptr %10, i32 %11)
  %13 = getelementptr [94 x i8], ptr @.str265, i64 0, i64 0
  call void @emit(ptr %0, ptr %13)
  %15 = getelementptr [45 x i8], ptr @.str266, i64 0, i64 0
  call void @emit(ptr %0, ptr %15)
  %17 = alloca i32
  store i32 0, ptr %17
  br label %L4
L4:
  %19 = load i32, ptr %17
  %20 = load i64, ptr %2
  %22 = sext i32 %19 to i64
  %23 = sext i32 %20 to i64
  %21 = icmp slt i64 %22, %23
  %24 = zext i1 %21 to i64
  %25 = icmp ne i64 %24, 0
  br i1 %25, label %L5, label %L7
L5:
  %26 = alloca ptr
  %28 = load i64, ptr %2
  %29 = load i32, ptr %17
  %30 = getelementptr i32, ptr %28, i64 %29
  %31 = load i32, ptr %30
  store ptr %31, ptr %26
  %32 = load ptr, ptr %26
  %34 = icmp eq i64 %32, 0
  %33 = zext i1 %34 to i64
  %35 = icmp ne i64 %33, 0
  br i1 %35, label %L8, label %L10
L8:
  br label %L6
L11:
  br label %L10
L10:
  %36 = load ptr, ptr %26
  %37 = load i64, ptr %36
  %39 = sext i32 %37 to i64
  %40 = sext i32 @ND_FUNC_DEF to i64
  %38 = icmp eq i64 %39, %40
  %41 = zext i1 %38 to i64
  %42 = icmp ne i64 %41, 0
  br i1 %42, label %L12, label %L14
L12:
  %43 = alloca i32
  store i32 0, ptr %43
  %45 = alloca i32
  store i32 0, ptr %45
  br label %L15
L15:
  %47 = load i32, ptr %45
  %48 = load i64, ptr %0
  %50 = sext i32 %47 to i64
  %51 = sext i32 %48 to i64
  %49 = icmp slt i64 %50, %51
  %52 = zext i1 %49 to i64
  %53 = icmp ne i64 %52, 0
  br i1 %53, label %L16, label %L18
L16:
  %54 = load i64, ptr %0
  %55 = load i32, ptr %45
  %56 = getelementptr i8, ptr %54, i64 %55
  %57 = load i64, ptr %56
  %58 = load ptr, ptr %26
  %59 = load i64, ptr %58
  %60 = icmp ne i64 %59, 0
  br i1 %60, label %L19, label %L20
L19:
  %61 = load ptr, ptr %26
  %62 = load i64, ptr %61
  br label %L21
L20:
  %63 = getelementptr [1 x i8], ptr @.str267, i64 0, i64 0
  br label %L21
L21:
  %64 = phi i64 [ %62, %L19 ], [ %63, %L20 ]
  %65 = call i32 @strcmp(i32 %57, i32 %64)
  %67 = sext i32 %65 to i64
  %68 = sext i32 0 to i64
  %66 = icmp eq i64 %67, %68
  %69 = zext i1 %66 to i64
  %70 = icmp ne i64 %69, 0
  br i1 %70, label %L22, label %L24
L22:
  store i32 1, ptr %43
  br label %L18
L25:
  br label %L24
L24:
  br label %L17
L17:
  %71 = load i32, ptr %45
  %73 = sext i32 %71 to i64
  %72 = add i64 %73, 1
  store i64 %72, ptr %45
  br label %L15
L18:
  %74 = load i32, ptr %43
  %76 = icmp eq i64 %74, 0
  %75 = zext i1 %76 to i64
  %77 = load i64, ptr %0
  %79 = sext i32 %77 to i64
  %80 = sext i32 1024 to i64
  %78 = icmp slt i64 %79, %80
  %81 = zext i1 %78 to i64
  %83 = sext i32 %75 to i64
  %84 = sext i32 %81 to i64
  %85 = icmp ne i64 %83, 0
  %86 = icmp ne i64 %84, 0
  %87 = and i1 %85, %86
  %88 = zext i1 %87 to i64
  %89 = icmp ne i64 %88, 0
  br i1 %89, label %L26, label %L28
L26:
  %90 = load ptr, ptr %26
  %91 = load i64, ptr %90
  %92 = icmp ne i64 %91, 0
  br i1 %92, label %L29, label %L30
L29:
  %93 = load ptr, ptr %26
  %94 = load i64, ptr %93
  br label %L31
L30:
  %95 = getelementptr [7 x i8], ptr @.str268, i64 0, i64 0
  br label %L31
L31:
  %96 = phi i64 [ %94, %L29 ], [ %95, %L30 ]
  %97 = call i32 @strdup(i32 %96)
  %98 = load i64, ptr %0
  %99 = load i64, ptr %0
  %100 = getelementptr i8, ptr %98, i64 %99
  store i32 %97, ptr %100
  %101 = load ptr, ptr %26
  %102 = load i64, ptr %101
  %103 = load i64, ptr %0
  %104 = load i64, ptr %0
  %105 = getelementptr i8, ptr %103, i64 %104
  store i32 %102, ptr %105
  %106 = load i64, ptr %0
  %107 = load i64, ptr %0
  %108 = getelementptr i8, ptr %106, i64 %107
  store i32 0, ptr %108
  %109 = load i64, ptr %0
  %111 = sext i32 %109 to i64
  %110 = add i64 %111, 1
  store i64 %110, ptr %0
  br label %L28
L28:
  br label %L14
L14:
  br label %L6
L6:
  %112 = load i32, ptr %17
  %114 = sext i32 %112 to i64
  %113 = add i64 %114, 1
  store i64 %113, ptr %17
  br label %L4
L7:
  %115 = alloca i32
  store i32 0, ptr %115
  br label %L32
L32:
  %117 = load i32, ptr %115
  %118 = load i64, ptr %2
  %120 = sext i32 %117 to i64
  %121 = sext i32 %118 to i64
  %119 = icmp slt i64 %120, %121
  %122 = zext i1 %119 to i64
  %123 = icmp ne i64 %122, 0
  br i1 %123, label %L33, label %L35
L33:
  %124 = alloca ptr
  %126 = load i64, ptr %2
  %127 = load i32, ptr %115
  %128 = getelementptr i32, ptr %126, i64 %127
  %129 = load i32, ptr %128
  store ptr %129, ptr %124
  %130 = load ptr, ptr %124
  %132 = icmp eq i64 %130, 0
  %131 = zext i1 %132 to i64
  %133 = icmp ne i64 %131, 0
  br i1 %133, label %L36, label %L38
L36:
  br label %L34
L39:
  br label %L38
L38:
  %134 = load ptr, ptr %124
  %135 = load i64, ptr %134
  %137 = sext i32 %135 to i64
  %138 = sext i32 @ND_VAR_DECL to i64
  %136 = icmp eq i64 %137, %138
  %139 = zext i1 %136 to i64
  %140 = icmp ne i64 %139, 0
  br i1 %140, label %L40, label %L42
L40:
  %141 = load ptr, ptr %124
  call void @emit_global_var(ptr %0, ptr %141)
  br label %L42
L42:
  br label %L34
L34:
  %143 = load i32, ptr %115
  %145 = sext i32 %143 to i64
  %144 = add i64 %145, 1
  store i64 %144, ptr %115
  br label %L32
L35:
  %146 = getelementptr [2 x i8], ptr @.str269, i64 0, i64 0
  call void @emit(ptr %0, ptr %146)
  %148 = alloca i32
  store i32 0, ptr %148
  br label %L43
L43:
  %150 = load i32, ptr %148
  %151 = load i64, ptr %2
  %153 = sext i32 %150 to i64
  %154 = sext i32 %151 to i64
  %152 = icmp slt i64 %153, %154
  %155 = zext i1 %152 to i64
  %156 = icmp ne i64 %155, 0
  br i1 %156, label %L44, label %L46
L44:
  %157 = alloca ptr
  %159 = load i64, ptr %2
  %160 = load i32, ptr %148
  %161 = getelementptr i32, ptr %159, i64 %160
  %162 = load i32, ptr %161
  store ptr %162, ptr %157
  %163 = load ptr, ptr %157
  %165 = icmp eq i64 %163, 0
  %164 = zext i1 %165 to i64
  %166 = icmp ne i64 %164, 0
  br i1 %166, label %L47, label %L49
L47:
  br label %L45
L50:
  br label %L49
L49:
  %167 = load ptr, ptr %157
  %168 = load i64, ptr %167
  %170 = sext i32 %168 to i64
  %171 = sext i32 @ND_FUNC_DEF to i64
  %169 = icmp eq i64 %170, %171
  %172 = zext i1 %169 to i64
  %173 = icmp ne i64 %172, 0
  br i1 %173, label %L51, label %L53
L51:
  %174 = load ptr, ptr %157
  call void @emit_func_def(ptr %0, ptr %174)
  br label %L53
L53:
  br label %L45
L45:
  %176 = load i32, ptr %148
  %178 = sext i32 %176 to i64
  %177 = add i64 %178, 1
  store i64 %177, ptr %148
  br label %L43
L46:
  %179 = alloca i32
  store i32 0, ptr %179
  br label %L54
L54:
  %181 = load i32, ptr %179
  %182 = load i64, ptr %0
  %184 = sext i32 %181 to i64
  %185 = sext i32 %182 to i64
  %183 = icmp slt i64 %184, %185
  %186 = zext i1 %183 to i64
  %187 = icmp ne i64 %186, 0
  br i1 %187, label %L55, label %L57
L55:
  %188 = alloca i32
  %190 = load i64, ptr %0
  %191 = load i32, ptr %179
  %192 = getelementptr i32, ptr %190, i64 %191
  %193 = load i32, ptr %192
  %194 = call i32 @str_literal_len(i32 %193)
  store i32 %194, ptr %188
  %195 = getelementptr [53 x i8], ptr @.str270, i64 0, i64 0
  %196 = load i64, ptr %0
  %197 = load i32, ptr %179
  %198 = getelementptr i32, ptr %196, i64 %197
  %199 = load i32, ptr %198
  %200 = load i32, ptr %188
  call void @emit(ptr %0, ptr %195, i32 %199, i32 %200)
  %202 = load i64, ptr %0
  %203 = load i32, ptr %179
  %204 = getelementptr i32, ptr %202, i64 %203
  %205 = load i32, ptr %204
  call void @emit_str_content(ptr %0, i32 %205)
  %207 = getelementptr [3 x i8], ptr @.str271, i64 0, i64 0
  call void @emit(ptr %0, ptr %207)
  br label %L56
L56:
  %209 = load i32, ptr %179
  %211 = sext i32 %209 to i64
  %210 = add i64 %211, 1
  store i64 %210, ptr %179
  br label %L54
L57:
  ret void
}

@.str1239689648 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str1 = private unnamed_addr constant [5 x i8] c"void\00"
@.str1239689664 = private unnamed_addr constant [3 x i8] c"i1\00"
@.str1 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str1239689824 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str1 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str1239688848 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str1 = private unnamed_addr constant [6 x i8] c"float\00"
@.str1239689680 = private unnamed_addr constant [7 x i8] c"double\00"
@.str1 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str1239689392 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str1 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str1239688208 = private unnamed_addr constant [12 x i8] c"%%struct.%s\00"
@.str1 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str1240482480 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str1 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str1240482080 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str1 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str1240482832 = private unnamed_addr constant [4 x i8] c"\5C0A\00"
@.str1 = private unnamed_addr constant [4 x i8] c"\5C09\00"
@.str1240482944 = private unnamed_addr constant [4 x i8] c"\5C0D\00"
@.str1 = private unnamed_addr constant [4 x i8] c"\5C00\00"
@.str1240483104 = private unnamed_addr constant [4 x i8] c"\5C22\00"
@.str1 = private unnamed_addr constant [4 x i8] c"\5C5C\00"
@.str1240482032 = private unnamed_addr constant [6 x i8] c"\5C%02X\00"
@.str1 = private unnamed_addr constant [3 x i8] c"%c\00"
@.str1240482512 = private unnamed_addr constant [4 x i8] c"\5C00\00"
@.str1 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str1240483136 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str1 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str1240483088 = private unnamed_addr constant [43 x i8] c"  %%%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str1 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str32 = private unnamed_addr constant [3 x i8] c"%s\00"
@.str33 = private unnamed_addr constant [2 x i8] c"0\00"
@.str34 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.str35 = private unnamed_addr constant [30 x i8] c"  %%%d = fadd double 0.0, %g\0A\00"
@.str36 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str37 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.str38 = private unnamed_addr constant [61 x i8] c"  %%%d = getelementptr [%d x i8], ptr @.str%d, i64 0, i64 0\0A\00"
@.str39 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str40 = private unnamed_addr constant [26 x i8] c"  %%%d = load %s, ptr %s\0A\00"
@.str41 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str42 = private unnamed_addr constant [27 x i8] c"  %%%d = load %s, ptr @%s\0A\00"
@.str43 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str44 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str45 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str46 = private unnamed_addr constant [16 x i8] c"  call void %s(\00"
@.str47 = private unnamed_addr constant [21 x i8] c"  %%%d = call %s %s(\00"
@.str48 = private unnamed_addr constant [3 x i8] c", \00"
@.str49 = private unnamed_addr constant [6 x i8] c"%s %s\00"
@.str50 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str51 = private unnamed_addr constant [3 x i8] c")\0A\00"
@.str52 = private unnamed_addr constant [2 x i8] c"0\00"
@.str53 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str54 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str55 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str56 = private unnamed_addr constant [29 x i8] c"  %%%d = sext i32 %s to i64\0A\00"
@.str57 = private unnamed_addr constant [29 x i8] c"  %%%d = sext i32 %s to i64\0A\00"
@.str58 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str59 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str60 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str61 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str62 = private unnamed_addr constant [14 x i8] c"getelementptr\00"
@.str63 = private unnamed_addr constant [4 x i8] c"add\00"
@.str64 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str65 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str66 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str67 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str68 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str69 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str70 = private unnamed_addr constant [5 x i8] c"frem\00"
@.str71 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str72 = private unnamed_addr constant [4 x i8] c"and\00"
@.str73 = private unnamed_addr constant [3 x i8] c"or\00"
@.str74 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str75 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str76 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str77 = private unnamed_addr constant [9 x i8] c"fcmp oeq\00"
@.str78 = private unnamed_addr constant [8 x i8] c"icmp eq\00"
@.str79 = private unnamed_addr constant [9 x i8] c"fcmp one\00"
@.str80 = private unnamed_addr constant [8 x i8] c"icmp ne\00"
@.str81 = private unnamed_addr constant [9 x i8] c"fcmp olt\00"
@.str82 = private unnamed_addr constant [9 x i8] c"icmp slt\00"
@.str83 = private unnamed_addr constant [9 x i8] c"fcmp ogt\00"
@.str84 = private unnamed_addr constant [9 x i8] c"icmp sgt\00"
@.str85 = private unnamed_addr constant [9 x i8] c"fcmp ole\00"
@.str86 = private unnamed_addr constant [9 x i8] c"icmp sle\00"
@.str87 = private unnamed_addr constant [9 x i8] c"fcmp oge\00"
@.str88 = private unnamed_addr constant [9 x i8] c"icmp sge\00"
@.str89 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str90 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str91 = private unnamed_addr constant [28 x i8] c"  %%%d = and i1 %%%d, %%%d\0A\00"
@.str92 = private unnamed_addr constant [30 x i8] c"  %%%d = zext i1 %%%d to i64\0A\00"
@.str93 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str94 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str95 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str96 = private unnamed_addr constant [27 x i8] c"  %%%d = or i1 %%%d, %%%d\0A\00"
@.str97 = private unnamed_addr constant [30 x i8] c"  %%%d = zext i1 %%%d to i64\0A\00"
@.str98 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str99 = private unnamed_addr constant [4 x i8] c"add\00"
@.str100 = private unnamed_addr constant [43 x i8] c"  %%%d = getelementptr i8, ptr %s, i64 %s\0A\00"
@.str101 = private unnamed_addr constant [23 x i8] c"  %%%d = %s %s %s, %s\0A\00"
@.str102 = private unnamed_addr constant [30 x i8] c"  %%%d = zext i1 %%%d to i64\0A\00"
@.str103 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str104 = private unnamed_addr constant [23 x i8] c"  %%%d = %s %s %s, %s\0A\00"
@.str105 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str106 = private unnamed_addr constant [25 x i8] c"  %%%d = fneg double %s\0A\00"
@.str107 = private unnamed_addr constant [24 x i8] c"  %%%d = sub i64 0, %s\0A\00"
@.str108 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp eq i64 %s, 0\0A\00"
@.str109 = private unnamed_addr constant [30 x i8] c"  %%%d = zext i1 %%%d to i64\0A\00"
@.str110 = private unnamed_addr constant [25 x i8] c"  %%%d = xor i64 %s, -1\0A\00"
@.str111 = private unnamed_addr constant [24 x i8] c"  %%%d = add i64 %s, 0\0A\00"
@.str112 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str113 = private unnamed_addr constant [23 x i8] c"  store %s %s, ptr %s\0A\00"
@.str114 = private unnamed_addr constant [7 x i8] c"double\00"
@.str115 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str116 = private unnamed_addr constant [29 x i8] c"  %%%d = sext i32 %s to i64\0A\00"
@.str117 = private unnamed_addr constant [29 x i8] c"  %%%d = sext i32 %s to i64\0A\00"
@.str118 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str119 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str120 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str121 = private unnamed_addr constant [4 x i8] c"add\00"
@.str122 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str123 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str124 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str125 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str126 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str127 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str128 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str129 = private unnamed_addr constant [4 x i8] c"and\00"
@.str130 = private unnamed_addr constant [3 x i8] c"or\00"
@.str131 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str132 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str133 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str134 = private unnamed_addr constant [4 x i8] c"add\00"
@.str135 = private unnamed_addr constant [23 x i8] c"  %%%d = %s %s %s, %s\0A\00"
@.str136 = private unnamed_addr constant [25 x i8] c"  store %s %%%d, ptr %s\0A\00"
@.str137 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str138 = private unnamed_addr constant [4 x i8] c"add\00"
@.str139 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str140 = private unnamed_addr constant [29 x i8] c"  %%%d = sext i32 %s to i64\0A\00"
@.str141 = private unnamed_addr constant [25 x i8] c"  %%%d = %s i64 %%%d, 1\0A\00"
@.str142 = private unnamed_addr constant [26 x i8] c"  store i64 %%%d, ptr %s\0A\00"
@.str143 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str144 = private unnamed_addr constant [4 x i8] c"add\00"
@.str145 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str146 = private unnamed_addr constant [29 x i8] c"  %%%d = sext i32 %s to i64\0A\00"
@.str147 = private unnamed_addr constant [25 x i8] c"  %%%d = %s i64 %%%d, 1\0A\00"
@.str148 = private unnamed_addr constant [26 x i8] c"  store i64 %%%d, ptr %s\0A\00"
@.str149 = private unnamed_addr constant [5 x i8] c"null\00"
@.str150 = private unnamed_addr constant [26 x i8] c"  %%%d = load %s, ptr %s\0A\00"
@.str151 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str152 = private unnamed_addr constant [43 x i8] c"  %%%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str153 = private unnamed_addr constant [28 x i8] c"  %%%d = load %s, ptr %%%d\0A\00"
@.str154 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str155 = private unnamed_addr constant [35 x i8] c"  %%%d = fpext float %s to double\0A\00"
@.str156 = private unnamed_addr constant [37 x i8] c"  %%%d = fptrunc double %s to float\0A\00"
@.str157 = private unnamed_addr constant [29 x i8] c"  %%%d = fptosi %s %s to %s\0A\00"
@.str158 = private unnamed_addr constant [29 x i8] c"  %%%d = sitofp %s %s to %s\0A\00"
@.str159 = private unnamed_addr constant [33 x i8] c"  %%%d = inttoptr i64 %s to ptr\0A\00"
@.str160 = private unnamed_addr constant [33 x i8] c"  %%%d = ptrtoint ptr %s to i64\0A\00"
@.str161 = private unnamed_addr constant [27 x i8] c"  %%%d = sext %s %s to %s\0A\00"
@.str162 = private unnamed_addr constant [28 x i8] c"  %%%d = trunc %s %s to %s\0A\00"
@.str163 = private unnamed_addr constant [30 x i8] c"  %%%d = bitcast %s %s to %s\0A\00"
@.str164 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str165 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str166 = private unnamed_addr constant [40 x i8] c"  br i1 %%%d, label %%L%d, label %%L%d\0A\00"
@.str167 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str168 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str169 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str170 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str171 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str172 = private unnamed_addr constant [47 x i8] c"  %%%d = phi i64 [ %s, %%L%d ], [ %s, %%L%d ]\0A\00"
@.str173 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str174 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str175 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str176 = private unnamed_addr constant [2 x i8] c"0\00"
@.str177 = private unnamed_addr constant [5 x i8] c"null\00"
@.str178 = private unnamed_addr constant [27 x i8] c"  %%%d = load i64, ptr %s\0A\00"
@.str179 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str180 = private unnamed_addr constant [28 x i8] c"  ; unhandled expr node %d\0A\00"
@.str181 = private unnamed_addr constant [2 x i8] c"0\00"
@.str182 = private unnamed_addr constant [20 x i8] c"  %%%d = alloca %s\0A\00"
@.str183 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str184 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str185 = private unnamed_addr constant [25 x i8] c"  store %s %s, ptr %%%d\0A\00"
@.str186 = private unnamed_addr constant [13 x i8] c"  ret %s %s\0A\00"
@.str187 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str188 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str189 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str190 = private unnamed_addr constant [40 x i8] c"  br i1 %%%d, label %%L%d, label %%L%d\0A\00"
@.str191 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str192 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str193 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str194 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str195 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str196 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str197 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str198 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str199 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str200 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str201 = private unnamed_addr constant [40 x i8] c"  br i1 %%%d, label %%L%d, label %%L%d\0A\00"
@.str202 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str203 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str204 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str205 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str206 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str207 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str208 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str209 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str210 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str211 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str212 = private unnamed_addr constant [40 x i8] c"  br i1 %%%d, label %%L%d, label %%L%d\0A\00"
@.str213 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str214 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str215 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str216 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str217 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str218 = private unnamed_addr constant [28 x i8] c"  %%%d = icmp ne i64 %s, 0\0A\00"
@.str219 = private unnamed_addr constant [40 x i8] c"  br i1 %%%d, label %%L%d, label %%L%d\0A\00"
@.str220 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str221 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str222 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str223 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str224 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str225 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str226 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str227 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str228 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str229 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str230 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str231 = private unnamed_addr constant [29 x i8] c"  %%%d = sext i32 %s to i64\0A\00"
@.str232 = private unnamed_addr constant [34 x i8] c"  switch i64 %%%d, label %%L%d [\0A\00"
@.str233 = private unnamed_addr constant [27 x i8] c"    i64 %lld, label %%L%d\0A\00"
@.str234 = private unnamed_addr constant [5 x i8] c"  ]\0A\00"
@.str235 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str236 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str237 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str238 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str239 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str240 = private unnamed_addr constant [5 x i8] c"%s:\0A\00"
@.str241 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str242 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str243 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str244 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str245 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str246 = private unnamed_addr constant [18 x i8] c"define %s %s @%s(\00"
@.str247 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str248 = private unnamed_addr constant [3 x i8] c", \00"
@.str249 = private unnamed_addr constant [8 x i8] c"%s %%%d\00"
@.str250 = private unnamed_addr constant [5 x i8] c"%%%d\00"
@.str251 = private unnamed_addr constant [3 x i8] c", \00"
@.str252 = private unnamed_addr constant [4 x i8] c"...\00"
@.str253 = private unnamed_addr constant [5 x i8] c") {\0A\00"
@.str254 = private unnamed_addr constant [8 x i8] c"entry:\0A\00"
@.str255 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str272 = private unnamed_addr constant [12 x i8] c"  ret %s 0\0A\00"
@.str257 = private unnamed_addr constant [4 x i8] c"}\0A\0A\00"
@.str258 = private unnamed_addr constant [26 x i8] c"@%s = external global %s\0A\00"
@.str259 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str260 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str261 = private unnamed_addr constant [36 x i8] c"@%s = %s global %s zeroinitializer\0A\00"
@.str262 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str263 = private unnamed_addr constant [19 x i8] c"; ModuleID = '%s'\0A\00"
@.str264 = private unnamed_addr constant [24 x i8] c"source_filename = \22%s\22\0A\00"
@.str265 = private unnamed_addr constant [94 x i8] c"target datalayout = \22e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128\22\0A\00"
@.str266 = private unnamed_addr constant [45 x i8] c"target triple = \22x86_64-unknown-linux-gnu\22\0A\0A\00"
@.str267 = private unnamed_addr constant [1 x i8] c"\00"
@.str268 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str269 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str270 = private unnamed_addr constant [53 x i8] c"@.str%d = private unnamed_addr constant [%d x i8] c\22\00"
@.str271 = private unnamed_addr constant [3 x i8] c"\22\0A\00"
