; ModuleID = 'codegen.c'
source_filename = "codegen.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; stdlib declarations
declare ptr @malloc(i64)
declare ptr @calloc(i64, i64)
declare ptr @realloc(ptr, i64)
declare void @free(ptr)
declare i64 @strlen(ptr)
declare ptr @strdup(ptr)
declare ptr @strndup(ptr, i64)
declare ptr @strcpy(ptr, ptr)
declare ptr @strncpy(ptr, ptr, i64)
declare ptr @strcat(ptr, ptr)
declare ptr @strchr(ptr, i64)
declare ptr @strstr(ptr, ptr)
declare i32 @strcmp(ptr, ptr)
declare i32 @strncmp(ptr, ptr, i64)
declare ptr @memcpy(ptr, ptr, i64)
declare ptr @memset(ptr, i32, i64)
declare i32 @memcmp(ptr, ptr, i64)
declare i32 @printf(ptr, ...)
declare i32 @fprintf(ptr, ptr, ...)
declare i32 @sprintf(ptr, ptr, ...)
declare i32 @snprintf(ptr, i64, ptr, ...)
declare i32 @vfprintf(ptr, ptr, ptr)
declare void @llvm.va_start(ptr)
declare void @llvm.va_end(ptr)
declare void @llvm.va_copy(ptr, ptr)
declare i32 @va_start(...)
declare i32 @va_end(...)
declare i32 @va_copy(...)
declare ptr @fopen(ptr, ptr)
declare i32 @fclose(ptr)
declare i64 @fread(ptr, i64, i64, ptr)
declare i64 @fwrite(ptr, i64, i64, ptr)
declare i32 @fseek(ptr, i64, i32)
declare i64 @ftell(ptr)
declare void @perror(ptr)
declare void @exit(i32)
declare ptr @getenv(ptr)
declare i32 @atoi(ptr)
declare i64 @atol(ptr)
declare i64 @strtol(ptr, ptr, i32)
declare i64 @strtoll(ptr, ptr, i32)
declare double @atof(ptr)
declare i32 @isspace(i32)
declare i32 @isdigit(i32)
declare i32 @isalpha(i32)
declare i32 @isalnum(i32)
declare i32 @isxdigit(i32)
declare i32 @isupper(i32)
declare i32 @islower(i32)
declare i32 @toupper(i32)
declare i32 @tolower(i32)
declare i32 @assert(i32)
@stderr = external global ptr
@stdout = external global ptr
@stdin  = external global ptr

declare ptr @node_new(ptr, i64)
declare void @node_free(ptr)
declare void @node_add_child(ptr, ptr)
declare ptr @type_new(ptr)
declare ptr @type_ptr(ptr)
declare ptr @type_array(ptr, i64)
declare void @type_free(ptr)
declare i32 @type_is_integer(ptr)
declare i32 @type_is_float(ptr)
declare i32 @type_is_pointer(ptr)
declare i32 @type_size(ptr)
declare ptr @lexer_new(ptr, ptr)
declare void @lexer_free(ptr)
declare i64 @lexer_next(ptr)
declare i64 @lexer_peek(ptr)
declare void @token_free(ptr)
declare ptr @token_type_name(ptr)
@tbufs = internal global ptr zeroinitializer
@tbuf_idx = internal global i32 zeroinitializer

define internal i32 @new_reg(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t1 to i64
  %t2 = add i64 %t3, 1
  store i64 %t2, ptr %t0
  %t4 = ptrtoint ptr %t1 to i64
  %t5 = trunc i64 %t4 to i32
  ret i32 %t5
L0:
  ret i32 0
}

define internal i32 @new_label(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t1 to i64
  %t2 = add i64 %t3, 1
  store i64 %t2, ptr %t0
  %t4 = ptrtoint ptr %t1 to i64
  %t5 = trunc i64 %t4 to i32
  ret i32 %t5
L0:
  ret i32 0
}

define internal ptr @reg_name(i64 %t0, ptr %t1, ptr %t2) {
entry:
  %t3 = getelementptr [6 x i8], ptr @.str0, i64 0, i64 0
  %t4 = call i32 @snprintf(ptr %t1, ptr %t2, ptr %t3, i64 %t0)
  %t5 = sext i32 %t4 to i64
  ret ptr %t1
L0:
  ret ptr null
}

define internal void @emit(ptr %t0, ptr %t1, ...) {
entry:
  %t2 = alloca i64
  %t3 = load i64, ptr %t2
  %t4 = call i32 @va_start(i64 %t3, ptr %t1)
  %t5 = sext i32 %t4 to i64
  %t6 = load ptr, ptr %t0
  %t7 = load i64, ptr %t2
  %t8 = call i32 @vfprintf(ptr %t6, ptr %t1, i64 %t7)
  %t9 = sext i32 %t8 to i64
  %t10 = load i64, ptr %t2
  %t11 = call i32 @va_end(i64 %t10)
  %t12 = sext i32 %t11 to i64
  ret void
}

define internal ptr @llvm_type(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = load ptr, ptr @tbufs
  %t3 = load i64, ptr @tbuf_idx
  %t4 = add i64 %t3, 1
  store i64 %t4, ptr @tbuf_idx
  %t6 = sext i32 8 to i64
  %t5 = srem i64 %t3, %t6
  %t7 = getelementptr i32, ptr %t2, i64 %t5
  %t8 = load i64, ptr %t7
  store i64 %t8, ptr %t1
  %t10 = ptrtoint ptr %t0 to i64
  %t11 = icmp eq i64 %t10, 0
  %t9 = zext i1 %t11 to i64
  %t12 = icmp ne i64 %t9, 0
  br i1 %t12, label %L0, label %L2
L0:
  %t13 = load ptr, ptr %t1
  %t14 = getelementptr [4 x i8], ptr @.str1, i64 0, i64 0
  %t15 = call ptr @strcpy(ptr %t13, ptr %t14)
  %t16 = load ptr, ptr %t1
  ret ptr %t16
L3:
  br label %L2
L2:
  %t17 = load ptr, ptr %t0
  %t18 = ptrtoint ptr %t17 to i64
  %t19 = add i64 %t18, 0
  switch i64 %t19, label %L27 [
    i64 0, label %L5
    i64 1, label %L6
    i64 2, label %L7
    i64 3, label %L8
    i64 4, label %L9
    i64 5, label %L10
    i64 6, label %L11
    i64 7, label %L12
    i64 8, label %L13
    i64 20, label %L14
    i64 9, label %L15
    i64 10, label %L16
    i64 11, label %L17
    i64 12, label %L18
    i64 13, label %L19
    i64 14, label %L20
    i64 15, label %L21
    i64 16, label %L22
    i64 17, label %L23
    i64 18, label %L24
    i64 19, label %L25
    i64 21, label %L26
  ]
L5:
  %t20 = load ptr, ptr %t1
  %t21 = getelementptr [5 x i8], ptr @.str2, i64 0, i64 0
  %t22 = call ptr @strcpy(ptr %t20, ptr %t21)
  br label %L4
L28:
  br label %L6
L6:
  %t23 = load ptr, ptr %t1
  %t24 = getelementptr [3 x i8], ptr @.str3, i64 0, i64 0
  %t25 = call ptr @strcpy(ptr %t23, ptr %t24)
  br label %L4
L29:
  br label %L7
L7:
  br label %L8
L8:
  br label %L9
L9:
  %t26 = load ptr, ptr %t1
  %t27 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %t28 = call ptr @strcpy(ptr %t26, ptr %t27)
  br label %L4
L30:
  br label %L10
L10:
  br label %L11
L11:
  %t29 = load ptr, ptr %t1
  %t30 = getelementptr [4 x i8], ptr @.str5, i64 0, i64 0
  %t31 = call ptr @strcpy(ptr %t29, ptr %t30)
  br label %L4
L31:
  br label %L12
L12:
  br label %L13
L13:
  br label %L14
L14:
  %t32 = load ptr, ptr %t1
  %t33 = getelementptr [4 x i8], ptr @.str6, i64 0, i64 0
  %t34 = call ptr @strcpy(ptr %t32, ptr %t33)
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
  %t35 = load ptr, ptr %t1
  %t36 = getelementptr [4 x i8], ptr @.str7, i64 0, i64 0
  %t37 = call ptr @strcpy(ptr %t35, ptr %t36)
  br label %L4
L33:
  br label %L19
L19:
  %t38 = load ptr, ptr %t1
  %t39 = getelementptr [6 x i8], ptr @.str8, i64 0, i64 0
  %t40 = call ptr @strcpy(ptr %t38, ptr %t39)
  br label %L4
L34:
  br label %L20
L20:
  %t41 = load ptr, ptr %t1
  %t42 = getelementptr [7 x i8], ptr @.str9, i64 0, i64 0
  %t43 = call ptr @strcpy(ptr %t41, ptr %t42)
  br label %L4
L35:
  br label %L21
L21:
  %t44 = load ptr, ptr %t1
  %t45 = getelementptr [4 x i8], ptr @.str10, i64 0, i64 0
  %t46 = call ptr @strcpy(ptr %t44, ptr %t45)
  br label %L4
L36:
  br label %L22
L22:
  %t47 = load ptr, ptr %t1
  %t48 = getelementptr [4 x i8], ptr @.str11, i64 0, i64 0
  %t49 = call ptr @strcpy(ptr %t47, ptr %t48)
  br label %L4
L37:
  br label %L23
L23:
  %t50 = load ptr, ptr %t1
  %t51 = getelementptr [4 x i8], ptr @.str12, i64 0, i64 0
  %t52 = call ptr @strcpy(ptr %t50, ptr %t51)
  br label %L4
L38:
  br label %L24
L24:
  br label %L25
L25:
  %t53 = load ptr, ptr %t0
  %t54 = icmp ne ptr %t53, null
  br i1 %t54, label %L39, label %L40
L39:
  %t55 = load ptr, ptr %t1
  %t56 = getelementptr [12 x i8], ptr @.str13, i64 0, i64 0
  %t57 = load ptr, ptr %t0
  %t58 = call i32 @snprintf(ptr %t55, i64 256, ptr %t56, ptr %t57)
  %t59 = sext i32 %t58 to i64
  br label %L41
L40:
  %t60 = load ptr, ptr %t1
  %t61 = getelementptr [4 x i8], ptr @.str14, i64 0, i64 0
  %t62 = call ptr @strcpy(ptr %t60, ptr %t61)
  br label %L41
L41:
  br label %L4
L42:
  br label %L26
L26:
  %t63 = load ptr, ptr %t1
  %t64 = getelementptr [4 x i8], ptr @.str15, i64 0, i64 0
  %t65 = call ptr @strcpy(ptr %t63, ptr %t64)
  br label %L4
L43:
  br label %L4
L27:
  %t66 = load ptr, ptr %t1
  %t67 = getelementptr [4 x i8], ptr @.str16, i64 0, i64 0
  %t68 = call ptr @strcpy(ptr %t66, ptr %t67)
  br label %L4
L44:
  br label %L4
L4:
  %t69 = load ptr, ptr %t1
  ret ptr %t69
L45:
  ret ptr null
}

define internal ptr @llvm_ret_type(ptr %t0) {
entry:
  %t2 = ptrtoint ptr %t0 to i64
  %t3 = icmp eq i64 %t2, 0
  %t1 = zext i1 %t3 to i64
  %t4 = load ptr, ptr %t0
  %t6 = ptrtoint ptr %t4 to i64
  %t7 = sext i32 17 to i64
  %t5 = icmp ne i64 %t6, %t7
  %t8 = zext i1 %t5 to i64
  %t10 = icmp ne i64 %t1, 0
  %t11 = icmp ne i64 %t8, 0
  %t12 = or i1 %t10, %t11
  %t13 = zext i1 %t12 to i64
  %t14 = icmp ne i64 %t13, 0
  br i1 %t14, label %L0, label %L2
L0:
  %t15 = getelementptr [4 x i8], ptr @.str17, i64 0, i64 0
  ret ptr %t15
L3:
  br label %L2
L2:
  %t16 = load ptr, ptr %t0
  %t17 = call ptr @llvm_type(ptr %t16)
  ret ptr %t17
L4:
  ret ptr null
}

define internal i32 @type_is_fp(ptr %t0) {
entry:
  %t2 = ptrtoint ptr %t0 to i64
  %t3 = icmp eq i64 %t2, 0
  %t1 = zext i1 %t3 to i64
  %t4 = icmp ne i64 %t1, 0
  br i1 %t4, label %L0, label %L2
L0:
  %t5 = sext i32 0 to i64
  %t6 = trunc i64 %t5 to i32
  ret i32 %t6
L3:
  br label %L2
L2:
  %t7 = load ptr, ptr %t0
  %t9 = ptrtoint ptr %t7 to i64
  %t10 = sext i32 13 to i64
  %t8 = icmp eq i64 %t9, %t10
  %t11 = zext i1 %t8 to i64
  %t12 = load ptr, ptr %t0
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 14 to i64
  %t13 = icmp eq i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t18 = icmp ne i64 %t11, 0
  %t19 = icmp ne i64 %t16, 0
  %t20 = or i1 %t18, %t19
  %t21 = zext i1 %t20 to i64
  %t22 = trunc i64 %t21 to i32
  ret i32 %t22
L4:
  ret i32 0
}

define internal void @scope_push(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t3 to i64
  %t4 = add i64 %t5, 1
  store i64 %t4, ptr %t0
  %t7 = ptrtoint ptr %t3 to i64
  %t6 = getelementptr i8, ptr %t2, i64 %t7
  store ptr %t1, ptr %t6
  ret void
}

define internal void @scope_pop(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t3 to i64
  %t4 = sub i64 %t5, 1
  store i64 %t4, ptr %t0
  %t6 = getelementptr i32, ptr %t2, i64 %t4
  %t7 = load i64, ptr %t6
  store i64 %t7, ptr %t1
  %t8 = alloca i64
  %t9 = load i64, ptr %t1
  store i64 %t9, ptr %t8
  br label %L0
L0:
  %t10 = load i64, ptr %t8
  %t11 = load ptr, ptr %t0
  %t13 = ptrtoint ptr %t11 to i64
  %t12 = icmp slt i64 %t10, %t13
  %t14 = zext i1 %t12 to i64
  %t15 = icmp ne i64 %t14, 0
  br i1 %t15, label %L1, label %L3
L1:
  %t16 = load ptr, ptr %t0
  %t17 = load i64, ptr %t8
  %t18 = getelementptr i8, ptr %t16, i64 %t17
  %t19 = load ptr, ptr %t18
  %t20 = call i32 @free(ptr %t19)
  %t21 = sext i32 %t20 to i64
  %t22 = load ptr, ptr %t0
  %t23 = load i64, ptr %t8
  %t24 = getelementptr i8, ptr %t22, i64 %t23
  %t25 = load ptr, ptr %t24
  %t26 = call i32 @free(ptr %t25)
  %t27 = sext i32 %t26 to i64
  br label %L2
L2:
  %t28 = load i64, ptr %t8
  %t29 = add i64 %t28, 1
  store i64 %t29, ptr %t8
  br label %L0
L3:
  %t30 = load i64, ptr %t1
  store i64 %t30, ptr %t0
  ret void
}

define internal ptr @find_local(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca i64
  %t3 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t3 to i64
  %t6 = sext i32 1 to i64
  %t4 = sub i64 %t5, %t6
  store i64 %t4, ptr %t2
  br label %L0
L0:
  %t7 = load i64, ptr %t2
  %t9 = sext i32 0 to i64
  %t8 = icmp sge i64 %t7, %t9
  %t10 = zext i1 %t8 to i64
  %t11 = icmp ne i64 %t10, 0
  br i1 %t11, label %L1, label %L3
L1:
  %t12 = load ptr, ptr %t0
  %t13 = load i64, ptr %t2
  %t14 = getelementptr i8, ptr %t12, i64 %t13
  %t15 = load ptr, ptr %t14
  %t16 = call i32 @strcmp(ptr %t15, ptr %t1)
  %t17 = sext i32 %t16 to i64
  %t19 = sext i32 0 to i64
  %t18 = icmp eq i64 %t17, %t19
  %t20 = zext i1 %t18 to i64
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L4, label %L6
L4:
  %t22 = load ptr, ptr %t0
  %t23 = load i64, ptr %t2
  %t24 = getelementptr i8, ptr %t22, i64 %t23
  ret ptr %t24
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t25 = load i64, ptr %t2
  %t26 = sub i64 %t25, 1
  store i64 %t26, ptr %t2
  br label %L0
L3:
  %t28 = sext i32 0 to i64
  %t27 = inttoptr i64 %t28 to ptr
  ret ptr %t27
L8:
  ret ptr null
}

define internal ptr @find_global(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca i64
  %t3 = sext i32 0 to i64
  store i64 %t3, ptr %t2
  br label %L0
L0:
  %t4 = load i64, ptr %t2
  %t5 = load ptr, ptr %t0
  %t7 = ptrtoint ptr %t5 to i64
  %t6 = icmp slt i64 %t4, %t7
  %t8 = zext i1 %t6 to i64
  %t9 = icmp ne i64 %t8, 0
  br i1 %t9, label %L1, label %L3
L1:
  %t10 = load ptr, ptr %t0
  %t11 = load i64, ptr %t2
  %t12 = getelementptr i8, ptr %t10, i64 %t11
  %t13 = load ptr, ptr %t12
  %t14 = call i32 @strcmp(ptr %t13, ptr %t1)
  %t15 = sext i32 %t14 to i64
  %t17 = sext i32 0 to i64
  %t16 = icmp eq i64 %t15, %t17
  %t18 = zext i1 %t16 to i64
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L4, label %L6
L4:
  %t20 = load ptr, ptr %t0
  %t21 = load i64, ptr %t2
  %t22 = getelementptr i8, ptr %t20, i64 %t21
  ret ptr %t22
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t23 = load i64, ptr %t2
  %t24 = add i64 %t23, 1
  store i64 %t24, ptr %t2
  br label %L0
L3:
  %t26 = sext i32 0 to i64
  %t25 = inttoptr i64 %t26 to ptr
  ret ptr %t25
L8:
  ret ptr null
}

define internal ptr @add_local(ptr %t0, ptr %t1, ptr %t2, i64 %t3) {
entry:
  %t4 = load ptr, ptr %t0
  %t6 = ptrtoint ptr %t4 to i64
  %t7 = sext i32 2048 to i64
  %t5 = icmp slt i64 %t6, %t7
  %t8 = zext i1 %t5 to i64
  %t9 = call i32 @assert(i64 %t8)
  %t10 = sext i32 %t9 to i64
  %t11 = alloca ptr
  %t12 = load ptr, ptr %t0
  %t13 = load ptr, ptr %t0
  %t15 = ptrtoint ptr %t13 to i64
  %t14 = add i64 %t15, 1
  store i64 %t14, ptr %t0
  %t17 = ptrtoint ptr %t13 to i64
  %t16 = getelementptr i8, ptr %t12, i64 %t17
  store ptr %t16, ptr %t11
  %t18 = call ptr @strdup(ptr %t1)
  %t19 = load ptr, ptr %t11
  store ptr %t18, ptr %t19
  %t20 = alloca i64
  %t21 = call i32 @new_reg(ptr %t0)
  %t22 = sext i32 %t21 to i64
  store i64 %t22, ptr %t20
  %t23 = call ptr @malloc(i64 32)
  %t24 = load ptr, ptr %t11
  store ptr %t23, ptr %t24
  %t25 = load ptr, ptr %t11
  %t26 = load ptr, ptr %t25
  %t27 = getelementptr [6 x i8], ptr @.str18, i64 0, i64 0
  %t28 = load i64, ptr %t20
  %t29 = call i32 @snprintf(ptr %t26, i64 32, ptr %t27, i64 %t28)
  %t30 = sext i32 %t29 to i64
  %t31 = load ptr, ptr %t11
  store ptr %t2, ptr %t31
  %t32 = load ptr, ptr %t11
  store i64 %t3, ptr %t32
  %t33 = load ptr, ptr %t11
  ret ptr %t33
L0:
  ret ptr null
}

define internal i32 @intern_string(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca i64
  %t3 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t3 to i64
  %t4 = add i64 %t5, 1
  store i64 %t4, ptr %t0
  store ptr %t3, ptr %t2
  %t6 = call ptr @strdup(ptr %t1)
  %t7 = load ptr, ptr %t0
  %t8 = load ptr, ptr %t0
  %t10 = ptrtoint ptr %t8 to i64
  %t9 = getelementptr i8, ptr %t7, i64 %t10
  store ptr %t6, ptr %t9
  %t11 = load i64, ptr %t2
  %t12 = load ptr, ptr %t0
  %t13 = load ptr, ptr %t0
  %t15 = ptrtoint ptr %t13 to i64
  %t14 = getelementptr i8, ptr %t12, i64 %t15
  store i64 %t11, ptr %t14
  %t16 = load ptr, ptr %t0
  %t18 = ptrtoint ptr %t16 to i64
  %t17 = add i64 %t18, 1
  store i64 %t17, ptr %t0
  %t19 = load i64, ptr %t2
  %t20 = trunc i64 %t19 to i32
  ret i32 %t20
L0:
  ret i32 0
}

define internal i32 @str_literal_len(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = sext i32 0 to i64
  store i64 %t2, ptr %t1
  %t3 = alloca ptr
  %t5 = ptrtoint ptr %t0 to i64
  %t6 = sext i32 1 to i64
  %t7 = inttoptr i64 %t5 to ptr
  %t4 = getelementptr i8, ptr %t7, i64 %t6
  store ptr %t4, ptr %t3
  br label %L0
L0:
  %t8 = load ptr, ptr %t3
  %t9 = load i64, ptr %t8
  %t10 = load ptr, ptr %t3
  %t11 = load i64, ptr %t10
  %t13 = sext i32 34 to i64
  %t12 = icmp ne i64 %t11, %t13
  %t14 = zext i1 %t12 to i64
  %t16 = icmp ne i64 %t9, 0
  %t17 = icmp ne i64 %t14, 0
  %t18 = and i1 %t16, %t17
  %t19 = zext i1 %t18 to i64
  %t20 = icmp ne i64 %t19, 0
  br i1 %t20, label %L1, label %L2
L1:
  %t21 = load ptr, ptr %t3
  %t22 = load i64, ptr %t21
  %t24 = sext i32 92 to i64
  %t23 = icmp eq i64 %t22, %t24
  %t25 = zext i1 %t23 to i64
  %t26 = icmp ne i64 %t25, 0
  br i1 %t26, label %L3, label %L4
L3:
  %t27 = load ptr, ptr %t3
  %t29 = ptrtoint ptr %t27 to i64
  %t28 = add i64 %t29, 1
  store i64 %t28, ptr %t3
  %t30 = load ptr, ptr %t3
  %t31 = load i64, ptr %t30
  %t32 = icmp ne i64 %t31, 0
  br i1 %t32, label %L6, label %L8
L6:
  %t33 = load ptr, ptr %t3
  %t35 = ptrtoint ptr %t33 to i64
  %t34 = add i64 %t35, 1
  store i64 %t34, ptr %t3
  br label %L8
L8:
  br label %L5
L4:
  %t36 = load ptr, ptr %t3
  %t38 = ptrtoint ptr %t36 to i64
  %t37 = add i64 %t38, 1
  store i64 %t37, ptr %t3
  br label %L5
L5:
  %t39 = load i64, ptr %t1
  %t40 = add i64 %t39, 1
  store i64 %t40, ptr %t1
  br label %L0
L2:
  %t41 = load i64, ptr %t1
  %t43 = sext i32 1 to i64
  %t42 = add i64 %t41, %t43
  %t44 = trunc i64 %t42 to i32
  ret i32 %t44
L9:
  ret i32 0
}

define internal void @emit_str_content(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca ptr
  %t4 = ptrtoint ptr %t1 to i64
  %t5 = sext i32 1 to i64
  %t6 = inttoptr i64 %t4 to ptr
  %t3 = getelementptr i8, ptr %t6, i64 %t5
  store ptr %t3, ptr %t2
  br label %L0
L0:
  %t7 = load ptr, ptr %t2
  %t8 = load i64, ptr %t7
  %t9 = load ptr, ptr %t2
  %t10 = load i64, ptr %t9
  %t12 = sext i32 34 to i64
  %t11 = icmp ne i64 %t10, %t12
  %t13 = zext i1 %t11 to i64
  %t15 = icmp ne i64 %t8, 0
  %t16 = icmp ne i64 %t13, 0
  %t17 = and i1 %t15, %t16
  %t18 = zext i1 %t17 to i64
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L1, label %L2
L1:
  %t20 = load ptr, ptr %t2
  %t21 = load i64, ptr %t20
  %t23 = sext i32 92 to i64
  %t22 = icmp eq i64 %t21, %t23
  %t24 = zext i1 %t22 to i64
  %t25 = load ptr, ptr %t2
  %t27 = ptrtoint ptr %t25 to i64
  %t28 = sext i32 1 to i64
  %t29 = inttoptr i64 %t27 to ptr
  %t26 = getelementptr i8, ptr %t29, i64 %t28
  %t30 = load i64, ptr %t26
  %t32 = icmp ne i64 %t24, 0
  %t33 = icmp ne i64 %t30, 0
  %t34 = and i1 %t32, %t33
  %t35 = zext i1 %t34 to i64
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L3, label %L4
L3:
  %t37 = load ptr, ptr %t2
  %t39 = ptrtoint ptr %t37 to i64
  %t38 = add i64 %t39, 1
  store i64 %t38, ptr %t2
  %t40 = load ptr, ptr %t2
  %t41 = load i64, ptr %t40
  %t42 = add i64 %t41, 0
  switch i64 %t42, label %L13 [
    i64 110, label %L7
    i64 116, label %L8
    i64 114, label %L9
    i64 48, label %L10
    i64 34, label %L11
    i64 92, label %L12
  ]
L7:
  %t43 = getelementptr [4 x i8], ptr @.str19, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t43)
  br label %L6
L14:
  br label %L8
L8:
  %t45 = getelementptr [4 x i8], ptr @.str20, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t45)
  br label %L6
L15:
  br label %L9
L9:
  %t47 = getelementptr [4 x i8], ptr @.str21, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t47)
  br label %L6
L16:
  br label %L10
L10:
  %t49 = getelementptr [4 x i8], ptr @.str22, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t49)
  br label %L6
L17:
  br label %L11
L11:
  %t51 = getelementptr [4 x i8], ptr @.str23, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t51)
  br label %L6
L18:
  br label %L12
L12:
  %t53 = getelementptr [4 x i8], ptr @.str24, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t53)
  br label %L6
L19:
  br label %L6
L13:
  %t55 = getelementptr [6 x i8], ptr @.str25, i64 0, i64 0
  %t56 = load ptr, ptr %t2
  %t57 = load i64, ptr %t56
  %t58 = add i64 %t57, 0
  call void @emit(ptr %t0, ptr %t55, i64 %t58)
  br label %L6
L20:
  br label %L6
L6:
  %t60 = load ptr, ptr %t2
  %t62 = ptrtoint ptr %t60 to i64
  %t61 = add i64 %t62, 1
  store i64 %t61, ptr %t2
  br label %L5
L4:
  %t63 = load ptr, ptr %t2
  %t64 = load i64, ptr %t63
  %t66 = sext i32 34 to i64
  %t65 = icmp eq i64 %t64, %t66
  %t67 = zext i1 %t65 to i64
  %t68 = icmp ne i64 %t67, 0
  br i1 %t68, label %L21, label %L23
L21:
  br label %L2
L24:
  br label %L23
L23:
  %t69 = getelementptr [3 x i8], ptr @.str26, i64 0, i64 0
  %t70 = load ptr, ptr %t2
  %t72 = ptrtoint ptr %t70 to i64
  %t71 = add i64 %t72, 1
  store i64 %t71, ptr %t2
  %t73 = load i64, ptr %t70
  call void @emit(ptr %t0, ptr %t69, i64 %t73)
  br label %L5
L5:
  br label %L0
L2:
  %t75 = getelementptr [4 x i8], ptr @.str27, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t75)
  ret void
}

define internal i64 @make_val(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca i64
  %t3 = load ptr, ptr %t2
  %t4 = call ptr @strncpy(ptr %t3, ptr %t0, i64 63)
  %t5 = load ptr, ptr %t2
  %t7 = sext i32 63 to i64
  %t6 = getelementptr i8, ptr %t5, i64 %t7
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t6
  store ptr %t1, ptr %t2
  %t9 = load i64, ptr %t2
  ret i64 %t9
L0:
  ret i64 0
}

define internal ptr @emit_lvalue_addr(ptr %t0, ptr %t1) {
entry:
  %t2 = load ptr, ptr %t1
  %t4 = ptrtoint ptr %t2 to i64
  %t5 = sext i32 23 to i64
  %t3 = icmp eq i64 %t4, %t5
  %t6 = zext i1 %t3 to i64
  %t7 = icmp ne i64 %t6, 0
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = alloca ptr
  %t9 = load ptr, ptr %t1
  %t10 = call ptr @find_local(ptr %t0, ptr %t9)
  store ptr %t10, ptr %t8
  %t11 = load ptr, ptr %t8
  %t12 = icmp ne ptr %t11, null
  br i1 %t12, label %L3, label %L5
L3:
  %t13 = load ptr, ptr %t8
  %t14 = load ptr, ptr %t13
  %t15 = call ptr @strdup(ptr %t14)
  ret ptr %t15
L6:
  br label %L5
L5:
  %t16 = alloca ptr
  %t17 = load ptr, ptr %t1
  %t18 = call ptr @find_global(ptr %t0, ptr %t17)
  store ptr %t18, ptr %t16
  %t19 = load ptr, ptr %t16
  %t20 = icmp ne ptr %t19, null
  br i1 %t20, label %L7, label %L9
L7:
  %t21 = alloca ptr
  %t22 = call ptr @malloc(i64 128)
  store ptr %t22, ptr %t21
  %t23 = load ptr, ptr %t21
  %t24 = getelementptr [4 x i8], ptr @.str28, i64 0, i64 0
  %t25 = load ptr, ptr %t1
  %t26 = call i32 @snprintf(ptr %t23, i64 128, ptr %t24, ptr %t25)
  %t27 = sext i32 %t26 to i64
  %t28 = load ptr, ptr %t21
  ret ptr %t28
L10:
  br label %L9
L9:
  %t29 = alloca ptr
  %t30 = call ptr @malloc(i64 128)
  store ptr %t30, ptr %t29
  %t31 = load ptr, ptr %t29
  %t32 = getelementptr [4 x i8], ptr @.str29, i64 0, i64 0
  %t33 = load ptr, ptr %t1
  %t34 = call i32 @snprintf(ptr %t31, i64 128, ptr %t32, ptr %t33)
  %t35 = sext i32 %t34 to i64
  %t36 = load ptr, ptr %t29
  ret ptr %t36
L11:
  br label %L2
L2:
  %t37 = load ptr, ptr %t1
  %t39 = ptrtoint ptr %t37 to i64
  %t40 = sext i32 37 to i64
  %t38 = icmp eq i64 %t39, %t40
  %t41 = zext i1 %t38 to i64
  %t42 = icmp ne i64 %t41, 0
  br i1 %t42, label %L12, label %L14
L12:
  %t43 = alloca i64
  %t44 = load ptr, ptr %t1
  %t45 = sext i32 0 to i64
  %t46 = getelementptr i32, ptr %t44, i64 %t45
  %t47 = load i64, ptr %t46
  %t48 = call i64 @emit_expr(ptr %t0, i64 %t47)
  store i64 %t48, ptr %t43
  %t49 = load i64, ptr %t43
  %t50 = call i32 @val_is_ptr(i64 %t49)
  %t51 = sext i32 %t50 to i64
  %t52 = icmp ne i64 %t51, 0
  br i1 %t52, label %L15, label %L17
L15:
  %t53 = load ptr, ptr %t43
  %t54 = call ptr @strdup(ptr %t53)
  ret ptr %t54
L18:
  br label %L17
L17:
  %t55 = alloca i64
  %t56 = call i32 @new_reg(ptr %t0)
  %t57 = sext i32 %t56 to i64
  store i64 %t57, ptr %t55
  %t58 = getelementptr [34 x i8], ptr @.str30, i64 0, i64 0
  %t59 = load i64, ptr %t55
  %t60 = load ptr, ptr %t43
  call void @emit(ptr %t0, ptr %t58, i64 %t59, ptr %t60)
  %t62 = alloca ptr
  %t63 = call ptr @malloc(i64 32)
  store ptr %t63, ptr %t62
  %t64 = load ptr, ptr %t62
  %t65 = getelementptr [6 x i8], ptr @.str31, i64 0, i64 0
  %t66 = load i64, ptr %t55
  %t67 = call i32 @snprintf(ptr %t64, i64 32, ptr %t65, i64 %t66)
  %t68 = sext i32 %t67 to i64
  %t69 = load ptr, ptr %t62
  ret ptr %t69
L19:
  br label %L14
L14:
  %t70 = load ptr, ptr %t1
  %t72 = ptrtoint ptr %t70 to i64
  %t73 = sext i32 33 to i64
  %t71 = icmp eq i64 %t72, %t73
  %t74 = zext i1 %t71 to i64
  %t75 = icmp ne i64 %t74, 0
  br i1 %t75, label %L20, label %L22
L20:
  %t76 = alloca i64
  %t77 = load ptr, ptr %t1
  %t78 = sext i32 0 to i64
  %t79 = getelementptr i32, ptr %t77, i64 %t78
  %t80 = load i64, ptr %t79
  %t81 = call i64 @emit_expr(ptr %t0, i64 %t80)
  store i64 %t81, ptr %t76
  %t82 = alloca i64
  %t83 = load ptr, ptr %t1
  %t84 = sext i32 1 to i64
  %t85 = getelementptr i32, ptr %t83, i64 %t84
  %t86 = load i64, ptr %t85
  %t87 = call i64 @emit_expr(ptr %t0, i64 %t86)
  store i64 %t87, ptr %t82
  %t88 = alloca i64
  %t89 = call i32 @new_reg(ptr %t0)
  %t90 = sext i32 %t89 to i64
  store i64 %t90, ptr %t88
  %t91 = alloca ptr
  %t92 = load ptr, ptr %t1
  %t93 = sext i32 0 to i64
  %t94 = getelementptr i32, ptr %t92, i64 %t93
  %t95 = load i64, ptr %t94
  %t96 = inttoptr i64 %t95 to ptr
  %t97 = load ptr, ptr %t96
  %t98 = load ptr, ptr %t1
  %t99 = sext i32 0 to i64
  %t100 = getelementptr i32, ptr %t98, i64 %t99
  %t101 = load i64, ptr %t100
  %t102 = inttoptr i64 %t101 to ptr
  %t103 = load ptr, ptr %t102
  %t104 = load ptr, ptr %t103
  %t106 = ptrtoint ptr %t97 to i64
  %t107 = ptrtoint ptr %t104 to i64
  %t111 = ptrtoint ptr %t97 to i64
  %t112 = ptrtoint ptr %t104 to i64
  %t108 = icmp ne i64 %t111, 0
  %t109 = icmp ne i64 %t112, 0
  %t110 = and i1 %t108, %t109
  %t113 = zext i1 %t110 to i64
  %t114 = icmp ne i64 %t113, 0
  br i1 %t114, label %L23, label %L24
L23:
  %t115 = load ptr, ptr %t1
  %t116 = sext i32 0 to i64
  %t117 = getelementptr i32, ptr %t115, i64 %t116
  %t118 = load i64, ptr %t117
  %t119 = inttoptr i64 %t118 to ptr
  %t120 = load ptr, ptr %t119
  %t121 = load ptr, ptr %t120
  %t122 = ptrtoint ptr %t121 to i64
  br label %L25
L24:
  %t124 = sext i32 0 to i64
  %t123 = inttoptr i64 %t124 to ptr
  %t125 = ptrtoint ptr %t123 to i64
  br label %L25
L25:
  %t126 = phi i64 [ %t122, %L23 ], [ %t125, %L24 ]
  store i64 %t126, ptr %t91
  %t127 = alloca ptr
  %t128 = load ptr, ptr %t91
  %t129 = icmp ne ptr %t128, null
  br i1 %t129, label %L26, label %L27
L26:
  %t130 = load ptr, ptr %t91
  %t131 = call ptr @llvm_type(ptr %t130)
  %t132 = ptrtoint ptr %t131 to i64
  br label %L28
L27:
  %t133 = getelementptr [3 x i8], ptr @.str32, i64 0, i64 0
  %t134 = ptrtoint ptr %t133 to i64
  br label %L28
L28:
  %t135 = phi i64 [ %t132, %L26 ], [ %t134, %L27 ]
  store i64 %t135, ptr %t127
  %t136 = alloca ptr
  %t137 = load i64, ptr %t76
  %t138 = call i32 @val_is_ptr(i64 %t137)
  %t139 = sext i32 %t138 to i64
  %t140 = icmp ne i64 %t139, 0
  br i1 %t140, label %L29, label %L30
L29:
  %t141 = load ptr, ptr %t136
  %t142 = load ptr, ptr %t76
  %t143 = call ptr @strncpy(ptr %t141, ptr %t142, i64 63)
  %t144 = load ptr, ptr %t136
  %t146 = sext i32 63 to i64
  %t145 = getelementptr i8, ptr %t144, i64 %t146
  %t147 = sext i32 0 to i64
  store i64 %t147, ptr %t145
  br label %L31
L30:
  %t148 = alloca i64
  %t149 = call i32 @new_reg(ptr %t0)
  %t150 = sext i32 %t149 to i64
  store i64 %t150, ptr %t148
  %t151 = getelementptr [34 x i8], ptr @.str33, i64 0, i64 0
  %t152 = load i64, ptr %t148
  %t153 = load ptr, ptr %t76
  call void @emit(ptr %t0, ptr %t151, i64 %t152, ptr %t153)
  %t155 = load ptr, ptr %t136
  %t156 = getelementptr [6 x i8], ptr @.str34, i64 0, i64 0
  %t157 = load i64, ptr %t148
  %t158 = call i32 @snprintf(ptr %t155, i64 64, ptr %t156, i64 %t157)
  %t159 = sext i32 %t158 to i64
  br label %L31
L31:
  %t160 = alloca ptr
  %t161 = load i64, ptr %t82
  %t162 = load ptr, ptr %t160
  %t163 = call i32 @promote_to_i64(ptr %t0, i64 %t161, ptr %t162, i64 64)
  %t164 = sext i32 %t163 to i64
  %t165 = getelementptr [44 x i8], ptr @.str35, i64 0, i64 0
  %t166 = load i64, ptr %t88
  %t167 = load ptr, ptr %t127
  %t168 = load ptr, ptr %t136
  %t169 = load ptr, ptr %t160
  call void @emit(ptr %t0, ptr %t165, i64 %t166, ptr %t167, ptr %t168, ptr %t169)
  %t171 = alloca ptr
  %t172 = call ptr @malloc(i64 32)
  store ptr %t172, ptr %t171
  %t173 = load ptr, ptr %t171
  %t174 = getelementptr [6 x i8], ptr @.str36, i64 0, i64 0
  %t175 = load i64, ptr %t88
  %t176 = call i32 @snprintf(ptr %t173, i64 32, ptr %t174, i64 %t175)
  %t177 = sext i32 %t176 to i64
  %t178 = load ptr, ptr %t171
  ret ptr %t178
L32:
  br label %L22
L22:
  %t179 = load ptr, ptr %t1
  %t181 = ptrtoint ptr %t179 to i64
  %t182 = sext i32 34 to i64
  %t180 = icmp eq i64 %t181, %t182
  %t183 = zext i1 %t180 to i64
  %t184 = load ptr, ptr %t1
  %t186 = ptrtoint ptr %t184 to i64
  %t187 = sext i32 35 to i64
  %t185 = icmp eq i64 %t186, %t187
  %t188 = zext i1 %t185 to i64
  %t190 = icmp ne i64 %t183, 0
  %t191 = icmp ne i64 %t188, 0
  %t192 = or i1 %t190, %t191
  %t193 = zext i1 %t192 to i64
  %t194 = icmp ne i64 %t193, 0
  br i1 %t194, label %L33, label %L35
L33:
  %t195 = alloca i64
  %t196 = load ptr, ptr %t1
  %t198 = ptrtoint ptr %t196 to i64
  %t199 = sext i32 35 to i64
  %t197 = icmp eq i64 %t198, %t199
  %t200 = zext i1 %t197 to i64
  %t201 = icmp ne i64 %t200, 0
  br i1 %t201, label %L36, label %L37
L36:
  %t202 = load ptr, ptr %t1
  %t203 = sext i32 0 to i64
  %t204 = getelementptr i32, ptr %t202, i64 %t203
  %t205 = load i64, ptr %t204
  %t206 = call i64 @emit_expr(ptr %t0, i64 %t205)
  store i64 %t206, ptr %t195
  br label %L38
L37:
  %t207 = alloca ptr
  %t208 = load ptr, ptr %t1
  %t209 = sext i32 0 to i64
  %t210 = getelementptr i32, ptr %t208, i64 %t209
  %t211 = load i64, ptr %t210
  %t212 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t211)
  store ptr %t212, ptr %t207
  %t213 = load ptr, ptr %t207
  %t214 = call ptr @default_ptr_type()
  %t215 = call i64 @make_val(ptr %t213, ptr %t214)
  store i64 %t215, ptr %t195
  %t216 = load ptr, ptr %t207
  %t217 = call i32 @free(ptr %t216)
  %t218 = sext i32 %t217 to i64
  br label %L38
L38:
  %t219 = alloca ptr
  %t220 = call ptr @malloc(i64 64)
  store ptr %t220, ptr %t219
  %t221 = load ptr, ptr %t219
  %t222 = getelementptr [3 x i8], ptr @.str37, i64 0, i64 0
  %t223 = load ptr, ptr %t195
  %t224 = call i32 @snprintf(ptr %t221, i64 64, ptr %t222, ptr %t223)
  %t225 = sext i32 %t224 to i64
  %t226 = load ptr, ptr %t219
  ret ptr %t226
L39:
  br label %L35
L35:
  %t228 = sext i32 0 to i64
  %t227 = inttoptr i64 %t228 to ptr
  ret ptr %t227
L40:
  ret ptr null
}

define internal ptr @default_int_type() {
entry:
  %t0 = alloca i64
  %t1 = sext i32 0 to i64
  store i64 %t1, ptr %t0
  ret ptr %t0
L0:
  ret ptr null
}

define internal ptr @default_i64_type() {
entry:
  %t0 = alloca i64
  %t1 = sext i32 0 to i64
  store i64 %t1, ptr %t0
  ret ptr %t0
L0:
  ret ptr null
}

define internal ptr @default_ptr_type() {
entry:
  %t0 = alloca i64
  %t1 = sext i32 0 to i64
  store i64 %t1, ptr %t0
  ret ptr %t0
L0:
  ret ptr null
}

define internal i32 @val_is_64bit(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = icmp eq i64 %t3, 0
  %t2 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t2, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = sext i32 0 to i64
  %t7 = trunc i64 %t6 to i32
  ret i32 %t7
L3:
  br label %L2
L2:
  %t8 = load ptr, ptr %t0
  %t9 = load ptr, ptr %t8
  %t10 = ptrtoint ptr %t9 to i64
  %t11 = add i64 %t10, 0
  switch i64 %t11, label %L12 [
    i64 9, label %L5
    i64 10, label %L6
    i64 11, label %L7
    i64 12, label %L8
    i64 15, label %L9
    i64 16, label %L10
    i64 14, label %L11
  ]
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
  %t12 = sext i32 1 to i64
  %t13 = trunc i64 %t12 to i32
  ret i32 %t13
L13:
  br label %L4
L12:
  %t14 = sext i32 0 to i64
  %t15 = trunc i64 %t14 to i32
  ret i32 %t15
L14:
  br label %L4
L4:
  ret i32 0
}

define internal i32 @val_is_ptr(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = icmp eq i64 %t3, 0
  %t2 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t2, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = sext i32 0 to i64
  %t7 = trunc i64 %t6 to i32
  ret i32 %t7
L3:
  br label %L2
L2:
  %t8 = load ptr, ptr %t0
  %t9 = load ptr, ptr %t8
  %t11 = ptrtoint ptr %t9 to i64
  %t12 = sext i32 15 to i64
  %t10 = icmp eq i64 %t11, %t12
  %t13 = zext i1 %t10 to i64
  %t14 = load ptr, ptr %t0
  %t15 = load ptr, ptr %t14
  %t17 = ptrtoint ptr %t15 to i64
  %t18 = sext i32 16 to i64
  %t16 = icmp eq i64 %t17, %t18
  %t19 = zext i1 %t16 to i64
  %t21 = icmp ne i64 %t13, 0
  %t22 = icmp ne i64 %t19, 0
  %t23 = or i1 %t21, %t22
  %t24 = zext i1 %t23 to i64
  %t25 = trunc i64 %t24 to i32
  ret i32 %t25
L4:
  ret i32 0
}

define internal i32 @promote_to_i64(ptr %t0, ptr %t1, ptr %t2, ptr %t3) {
entry:
  %t4 = call i32 @val_is_ptr(ptr %t1)
  %t5 = sext i32 %t4 to i64
  %t6 = icmp ne i64 %t5, 0
  br i1 %t6, label %L0, label %L1
L0:
  %t7 = alloca i64
  %t8 = call i32 @new_reg(ptr %t0)
  %t9 = sext i32 %t8 to i64
  store i64 %t9, ptr %t7
  %t10 = getelementptr [34 x i8], ptr @.str38, i64 0, i64 0
  %t11 = load i64, ptr %t7
  %t12 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t10, i64 %t11, ptr %t12)
  %t14 = getelementptr [6 x i8], ptr @.str39, i64 0, i64 0
  %t15 = load i64, ptr %t7
  %t16 = call i32 @snprintf(ptr %t2, ptr %t3, ptr %t14, i64 %t15)
  %t17 = sext i32 %t16 to i64
  %t18 = load i64, ptr %t7
  %t19 = trunc i64 %t18 to i32
  ret i32 %t19
L3:
  br label %L2
L1:
  %t20 = call i32 @val_is_64bit(ptr %t1)
  %t21 = sext i32 %t20 to i64
  %t22 = icmp ne i64 %t21, 0
  br i1 %t22, label %L4, label %L5
L4:
  %t23 = load ptr, ptr %t1
  %t25 = ptrtoint ptr %t3 to i64
  %t26 = sext i32 1 to i64
  %t24 = sub i64 %t25, %t26
  %t27 = call ptr @strncpy(ptr %t2, ptr %t23, i64 %t24)
  %t29 = ptrtoint ptr %t3 to i64
  %t30 = sext i32 1 to i64
  %t28 = sub i64 %t29, %t30
  %t31 = getelementptr i8, ptr %t2, i64 %t28
  %t32 = sext i32 0 to i64
  store i64 %t32, ptr %t31
  %t34 = sext i32 1 to i64
  %t33 = sub i64 0, %t34
  %t35 = trunc i64 %t33 to i32
  ret i32 %t35
L7:
  br label %L6
L5:
  %t36 = alloca i64
  %t37 = call i32 @new_reg(ptr %t0)
  %t38 = sext i32 %t37 to i64
  store i64 %t38, ptr %t36
  %t39 = getelementptr [30 x i8], ptr @.str40, i64 0, i64 0
  %t40 = load i64, ptr %t36
  %t41 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t39, i64 %t40, ptr %t41)
  %t43 = getelementptr [6 x i8], ptr @.str41, i64 0, i64 0
  %t44 = load i64, ptr %t36
  %t45 = call i32 @snprintf(ptr %t2, ptr %t3, ptr %t43, i64 %t44)
  %t46 = sext i32 %t45 to i64
  %t47 = load i64, ptr %t36
  %t48 = trunc i64 %t47 to i32
  ret i32 %t48
L8:
  br label %L6
L6:
  br label %L2
L2:
  ret i32 0
}

define internal i32 @emit_cond(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca i64
  %t3 = call i32 @new_reg(ptr %t0)
  %t4 = sext i32 %t3 to i64
  store i64 %t4, ptr %t2
  %t5 = call i32 @val_is_ptr(ptr %t1)
  %t6 = sext i32 %t5 to i64
  %t7 = icmp ne i64 %t6, 0
  br i1 %t7, label %L0, label %L1
L0:
  %t8 = getelementptr [32 x i8], ptr @.str42, i64 0, i64 0
  %t9 = load i64, ptr %t2
  %t10 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t8, i64 %t9, ptr %t10)
  br label %L2
L1:
  %t12 = alloca ptr
  %t13 = load ptr, ptr %t12
  %t14 = call i32 @promote_to_i64(ptr %t0, ptr %t1, ptr %t13, i64 64)
  %t15 = sext i32 %t14 to i64
  %t16 = getelementptr [29 x i8], ptr @.str43, i64 0, i64 0
  %t17 = load i64, ptr %t2
  %t18 = load ptr, ptr %t12
  call void @emit(ptr %t0, ptr %t16, i64 %t17, ptr %t18)
  br label %L2
L2:
  %t20 = load i64, ptr %t2
  %t21 = trunc i64 %t20 to i32
  ret i32 %t21
L3:
  ret i32 0
}

define internal i64 @emit_expr(ptr %t0, ptr %t1) {
entry:
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = icmp eq i64 %t3, 0
  %t2 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t2, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = getelementptr [2 x i8], ptr @.str44, i64 0, i64 0
  %t7 = call ptr @default_int_type()
  %t8 = call i64 @make_val(ptr %t6, ptr %t7)
  ret i64 %t8
L3:
  br label %L2
L2:
  %t9 = alloca i64
  %t10 = load ptr, ptr %t1
  store ptr %t10, ptr %t9
  %t11 = load i64, ptr %t9
  %t12 = add i64 %t11, 0
  %t13 = load ptr, ptr %t1
  %t14 = ptrtoint ptr %t13 to i64
  %t15 = add i64 %t14, 0
  switch i64 %t15, label %L29 [
    i64 19, label %L5
    i64 20, label %L6
    i64 21, label %L7
    i64 22, label %L8
    i64 23, label %L9
    i64 24, label %L10
    i64 25, label %L11
    i64 26, label %L12
    i64 27, label %L13
    i64 28, label %L14
    i64 38, label %L15
    i64 39, label %L16
    i64 40, label %L17
    i64 41, label %L18
    i64 36, label %L19
    i64 37, label %L20
    i64 33, label %L21
    i64 29, label %L22
    i64 30, label %L23
    i64 31, label %L24
    i64 32, label %L25
    i64 43, label %L26
    i64 34, label %L27
    i64 35, label %L28
  ]
L5:
  %t16 = alloca ptr
  %t17 = load ptr, ptr %t16
  %t18 = getelementptr [5 x i8], ptr @.str45, i64 0, i64 0
  %t19 = load ptr, ptr %t1
  %t20 = call i32 @snprintf(ptr %t17, i64 8, ptr %t18, ptr %t19)
  %t21 = sext i32 %t20 to i64
  %t22 = load ptr, ptr %t16
  %t23 = call ptr @default_int_type()
  %t24 = call i64 @make_val(ptr %t22, ptr %t23)
  ret i64 %t24
L30:
  br label %L6
L6:
  %t25 = alloca i64
  %t26 = call i32 @new_reg(ptr %t0)
  %t27 = sext i32 %t26 to i64
  store i64 %t27, ptr %t25
  %t28 = getelementptr [31 x i8], ptr @.str46, i64 0, i64 0
  %t29 = load i64, ptr %t25
  %t30 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t28, i64 %t29, ptr %t30)
  %t32 = alloca ptr
  %t33 = load ptr, ptr %t32
  %t34 = getelementptr [6 x i8], ptr @.str47, i64 0, i64 0
  %t35 = load i64, ptr %t25
  %t36 = call i32 @snprintf(ptr %t33, i64 8, ptr %t34, i64 %t35)
  %t37 = sext i32 %t36 to i64
  %t38 = alloca i64
  %t39 = sext i32 0 to i64
  store i64 %t39, ptr %t38
  %t40 = load ptr, ptr %t32
  %t41 = call i64 @make_val(ptr %t40, ptr %t38)
  ret i64 %t41
L31:
  br label %L7
L7:
  %t42 = alloca ptr
  %t43 = load ptr, ptr %t42
  %t44 = getelementptr [5 x i8], ptr @.str48, i64 0, i64 0
  %t45 = load ptr, ptr %t1
  %t46 = call i32 @snprintf(ptr %t43, i64 8, ptr %t44, ptr %t45)
  %t47 = sext i32 %t46 to i64
  %t48 = alloca i64
  %t49 = sext i32 0 to i64
  store i64 %t49, ptr %t48
  %t50 = load ptr, ptr %t42
  %t51 = call i64 @make_val(ptr %t50, ptr %t48)
  ret i64 %t51
L32:
  br label %L8
L8:
  %t52 = alloca i64
  %t53 = load ptr, ptr %t1
  %t54 = call i32 @intern_string(ptr %t0, ptr %t53)
  %t55 = sext i32 %t54 to i64
  store i64 %t55, ptr %t52
  %t56 = alloca i64
  %t57 = call i32 @new_reg(ptr %t0)
  %t58 = sext i32 %t57 to i64
  store i64 %t58, ptr %t56
  %t59 = alloca i64
  %t60 = load ptr, ptr %t1
  %t61 = call i32 @str_literal_len(ptr %t60)
  %t62 = sext i32 %t61 to i64
  store i64 %t62, ptr %t59
  %t63 = getelementptr [62 x i8], ptr @.str49, i64 0, i64 0
  %t64 = load i64, ptr %t56
  %t65 = load i64, ptr %t59
  %t66 = load i64, ptr %t52
  call void @emit(ptr %t0, ptr %t63, i64 %t64, i64 %t65, i64 %t66)
  %t68 = alloca ptr
  %t69 = load ptr, ptr %t68
  %t70 = getelementptr [6 x i8], ptr @.str50, i64 0, i64 0
  %t71 = load i64, ptr %t56
  %t72 = call i32 @snprintf(ptr %t69, i64 8, ptr %t70, i64 %t71)
  %t73 = sext i32 %t72 to i64
  %t74 = load ptr, ptr %t68
  %t75 = call ptr @default_ptr_type()
  %t76 = call i64 @make_val(ptr %t74, ptr %t75)
  ret i64 %t76
L33:
  br label %L9
L9:
  %t77 = alloca ptr
  %t78 = load ptr, ptr %t1
  %t79 = call ptr @find_local(ptr %t0, ptr %t78)
  store ptr %t79, ptr %t77
  %t80 = load ptr, ptr %t77
  %t81 = icmp ne ptr %t80, null
  br i1 %t81, label %L34, label %L36
L34:
  %t82 = load ptr, ptr %t77
  %t83 = load ptr, ptr %t82
  %t84 = icmp ne ptr %t83, null
  br i1 %t84, label %L37, label %L39
L37:
  %t85 = load ptr, ptr %t77
  %t86 = load ptr, ptr %t85
  %t87 = load ptr, ptr %t77
  %t88 = load ptr, ptr %t87
  %t89 = call i64 @make_val(ptr %t86, ptr %t88)
  ret i64 %t89
L40:
  br label %L39
L39:
  %t90 = alloca i64
  %t91 = call i32 @new_reg(ptr %t0)
  %t92 = sext i32 %t91 to i64
  store i64 %t92, ptr %t90
  %t93 = alloca ptr
  %t94 = alloca ptr
  %t95 = load ptr, ptr %t77
  %t96 = load ptr, ptr %t95
  %t97 = load ptr, ptr %t77
  %t98 = load ptr, ptr %t97
  %t99 = load ptr, ptr %t98
  %t101 = ptrtoint ptr %t99 to i64
  %t102 = sext i32 15 to i64
  %t100 = icmp eq i64 %t101, %t102
  %t103 = zext i1 %t100 to i64
  %t104 = load ptr, ptr %t77
  %t105 = load ptr, ptr %t104
  %t106 = load ptr, ptr %t105
  %t108 = ptrtoint ptr %t106 to i64
  %t109 = sext i32 16 to i64
  %t107 = icmp eq i64 %t108, %t109
  %t110 = zext i1 %t107 to i64
  %t112 = icmp ne i64 %t103, 0
  %t113 = icmp ne i64 %t110, 0
  %t114 = or i1 %t112, %t113
  %t115 = zext i1 %t114 to i64
  %t117 = ptrtoint ptr %t96 to i64
  %t121 = ptrtoint ptr %t96 to i64
  %t118 = icmp ne i64 %t121, 0
  %t119 = icmp ne i64 %t115, 0
  %t120 = and i1 %t118, %t119
  %t122 = zext i1 %t120 to i64
  %t123 = icmp ne i64 %t122, 0
  br i1 %t123, label %L41, label %L42
L41:
  %t124 = getelementptr [4 x i8], ptr @.str51, i64 0, i64 0
  store ptr %t124, ptr %t93
  %t125 = call ptr @default_ptr_type()
  store ptr %t125, ptr %t94
  br label %L43
L42:
  %t126 = load ptr, ptr %t77
  %t127 = load ptr, ptr %t126
  %t128 = load ptr, ptr %t77
  %t129 = load ptr, ptr %t128
  %t130 = call i32 @type_is_fp(ptr %t129)
  %t131 = sext i32 %t130 to i64
  %t133 = ptrtoint ptr %t127 to i64
  %t137 = ptrtoint ptr %t127 to i64
  %t134 = icmp ne i64 %t137, 0
  %t135 = icmp ne i64 %t131, 0
  %t136 = and i1 %t134, %t135
  %t138 = zext i1 %t136 to i64
  %t139 = icmp ne i64 %t138, 0
  br i1 %t139, label %L44, label %L45
L44:
  %t140 = load ptr, ptr %t77
  %t141 = load ptr, ptr %t140
  %t142 = call ptr @llvm_type(ptr %t141)
  store ptr %t142, ptr %t93
  %t143 = load ptr, ptr %t77
  %t144 = load ptr, ptr %t143
  store ptr %t144, ptr %t94
  br label %L46
L45:
  %t145 = getelementptr [4 x i8], ptr @.str52, i64 0, i64 0
  store ptr %t145, ptr %t93
  %t146 = call ptr @default_i64_type()
  store ptr %t146, ptr %t94
  br label %L46
L46:
  br label %L43
L43:
  %t147 = getelementptr [27 x i8], ptr @.str53, i64 0, i64 0
  %t148 = load i64, ptr %t90
  %t149 = load ptr, ptr %t93
  %t150 = load ptr, ptr %t77
  %t151 = load ptr, ptr %t150
  call void @emit(ptr %t0, ptr %t147, i64 %t148, ptr %t149, ptr %t151)
  %t153 = alloca ptr
  %t154 = load ptr, ptr %t153
  %t155 = getelementptr [6 x i8], ptr @.str54, i64 0, i64 0
  %t156 = load i64, ptr %t90
  %t157 = call i32 @snprintf(ptr %t154, i64 8, ptr %t155, i64 %t156)
  %t158 = sext i32 %t157 to i64
  %t159 = load ptr, ptr %t153
  %t160 = load ptr, ptr %t94
  %t161 = call i64 @make_val(ptr %t159, ptr %t160)
  ret i64 %t161
L47:
  br label %L36
L36:
  %t162 = alloca ptr
  %t163 = load ptr, ptr %t1
  %t164 = call ptr @find_global(ptr %t0, ptr %t163)
  store ptr %t164, ptr %t162
  %t165 = load ptr, ptr %t162
  %t166 = load ptr, ptr %t162
  %t167 = load ptr, ptr %t166
  %t169 = ptrtoint ptr %t165 to i64
  %t170 = ptrtoint ptr %t167 to i64
  %t174 = ptrtoint ptr %t165 to i64
  %t175 = ptrtoint ptr %t167 to i64
  %t171 = icmp ne i64 %t174, 0
  %t172 = icmp ne i64 %t175, 0
  %t173 = and i1 %t171, %t172
  %t176 = zext i1 %t173 to i64
  %t177 = load ptr, ptr %t162
  %t178 = load ptr, ptr %t177
  %t179 = load ptr, ptr %t178
  %t181 = ptrtoint ptr %t179 to i64
  %t182 = sext i32 17 to i64
  %t180 = icmp ne i64 %t181, %t182
  %t183 = zext i1 %t180 to i64
  %t185 = icmp ne i64 %t176, 0
  %t186 = icmp ne i64 %t183, 0
  %t187 = and i1 %t185, %t186
  %t188 = zext i1 %t187 to i64
  %t189 = icmp ne i64 %t188, 0
  br i1 %t189, label %L48, label %L50
L48:
  %t190 = alloca i64
  %t191 = call i32 @new_reg(ptr %t0)
  %t192 = sext i32 %t191 to i64
  store i64 %t192, ptr %t190
  %t193 = alloca ptr
  %t194 = alloca ptr
  %t195 = load ptr, ptr %t162
  %t196 = load ptr, ptr %t195
  %t197 = load ptr, ptr %t196
  %t199 = ptrtoint ptr %t197 to i64
  %t200 = sext i32 15 to i64
  %t198 = icmp eq i64 %t199, %t200
  %t201 = zext i1 %t198 to i64
  %t202 = load ptr, ptr %t162
  %t203 = load ptr, ptr %t202
  %t204 = load ptr, ptr %t203
  %t206 = ptrtoint ptr %t204 to i64
  %t207 = sext i32 16 to i64
  %t205 = icmp eq i64 %t206, %t207
  %t208 = zext i1 %t205 to i64
  %t210 = icmp ne i64 %t201, 0
  %t211 = icmp ne i64 %t208, 0
  %t212 = or i1 %t210, %t211
  %t213 = zext i1 %t212 to i64
  %t214 = icmp ne i64 %t213, 0
  br i1 %t214, label %L51, label %L52
L51:
  %t215 = getelementptr [4 x i8], ptr @.str55, i64 0, i64 0
  store ptr %t215, ptr %t193
  %t216 = call ptr @default_ptr_type()
  store ptr %t216, ptr %t194
  br label %L53
L52:
  %t217 = load ptr, ptr %t162
  %t218 = load ptr, ptr %t217
  %t219 = call i32 @type_is_fp(ptr %t218)
  %t220 = sext i32 %t219 to i64
  %t221 = icmp ne i64 %t220, 0
  br i1 %t221, label %L54, label %L55
L54:
  %t222 = load ptr, ptr %t162
  %t223 = load ptr, ptr %t222
  %t224 = call ptr @llvm_type(ptr %t223)
  store ptr %t224, ptr %t193
  %t225 = load ptr, ptr %t162
  %t226 = load ptr, ptr %t225
  store ptr %t226, ptr %t194
  br label %L56
L55:
  %t227 = getelementptr [4 x i8], ptr @.str56, i64 0, i64 0
  store ptr %t227, ptr %t193
  %t228 = call ptr @default_i64_type()
  store ptr %t228, ptr %t194
  br label %L56
L56:
  br label %L53
L53:
  %t229 = getelementptr [28 x i8], ptr @.str57, i64 0, i64 0
  %t230 = load i64, ptr %t190
  %t231 = load ptr, ptr %t193
  %t232 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t229, i64 %t230, ptr %t231, ptr %t232)
  %t234 = alloca ptr
  %t235 = load ptr, ptr %t234
  %t236 = getelementptr [6 x i8], ptr @.str58, i64 0, i64 0
  %t237 = load i64, ptr %t190
  %t238 = call i32 @snprintf(ptr %t235, i64 8, ptr %t236, i64 %t237)
  %t239 = sext i32 %t238 to i64
  %t240 = load ptr, ptr %t234
  %t241 = load ptr, ptr %t194
  %t242 = call i64 @make_val(ptr %t240, ptr %t241)
  ret i64 %t242
L57:
  br label %L50
L50:
  %t243 = alloca ptr
  %t244 = load ptr, ptr %t243
  %t245 = getelementptr [4 x i8], ptr @.str59, i64 0, i64 0
  %t246 = load ptr, ptr %t1
  %t247 = call i32 @snprintf(ptr %t244, i64 8, ptr %t245, ptr %t246)
  %t248 = sext i32 %t247 to i64
  %t249 = load ptr, ptr %t243
  %t250 = call ptr @default_ptr_type()
  %t251 = call i64 @make_val(ptr %t249, ptr %t250)
  ret i64 %t251
L58:
  br label %L10
L10:
  %t252 = alloca ptr
  %t253 = load ptr, ptr %t1
  %t254 = sext i32 0 to i64
  %t255 = getelementptr i32, ptr %t253, i64 %t254
  %t256 = load i64, ptr %t255
  store i64 %t256, ptr %t252
  %t257 = alloca ptr
  %t258 = call ptr @default_int_type()
  store ptr %t258, ptr %t257
  %t259 = alloca ptr
  %t260 = load ptr, ptr %t1
  %t262 = ptrtoint ptr %t260 to i64
  %t263 = sext i32 8 to i64
  %t261 = mul i64 %t262, %t263
  %t264 = call ptr @malloc(i64 %t261)
  store ptr %t264, ptr %t259
  %t265 = alloca ptr
  %t266 = load ptr, ptr %t1
  %t268 = ptrtoint ptr %t266 to i64
  %t269 = sext i32 8 to i64
  %t267 = mul i64 %t268, %t269
  %t270 = call ptr @malloc(i64 %t267)
  store ptr %t270, ptr %t265
  %t271 = alloca i64
  %t272 = sext i32 1 to i64
  store i64 %t272, ptr %t271
  br label %L59
L59:
  %t273 = load i64, ptr %t271
  %t274 = load ptr, ptr %t1
  %t276 = ptrtoint ptr %t274 to i64
  %t275 = icmp slt i64 %t273, %t276
  %t277 = zext i1 %t275 to i64
  %t278 = icmp ne i64 %t277, 0
  br i1 %t278, label %L60, label %L62
L60:
  %t279 = alloca i64
  %t280 = load ptr, ptr %t1
  %t281 = load i64, ptr %t271
  %t282 = getelementptr i32, ptr %t280, i64 %t281
  %t283 = load i64, ptr %t282
  %t284 = call i64 @emit_expr(ptr %t0, i64 %t283)
  store i64 %t284, ptr %t279
  %t285 = load ptr, ptr %t279
  %t286 = call ptr @strdup(ptr %t285)
  %t287 = load ptr, ptr %t259
  %t288 = load i64, ptr %t271
  %t289 = getelementptr i8, ptr %t287, i64 %t288
  store ptr %t286, ptr %t289
  %t290 = load ptr, ptr %t279
  %t291 = load ptr, ptr %t265
  %t292 = load i64, ptr %t271
  %t293 = getelementptr i8, ptr %t291, i64 %t292
  store ptr %t290, ptr %t293
  br label %L61
L61:
  %t294 = load i64, ptr %t271
  %t295 = add i64 %t294, 1
  store i64 %t295, ptr %t271
  br label %L59
L62:
  %t296 = alloca ptr
  %t297 = sext i32 0 to i64
  store i64 %t297, ptr %t296
  %t298 = load ptr, ptr %t252
  %t299 = load ptr, ptr %t298
  %t301 = ptrtoint ptr %t299 to i64
  %t302 = sext i32 23 to i64
  %t300 = icmp eq i64 %t301, %t302
  %t303 = zext i1 %t300 to i64
  %t304 = icmp ne i64 %t303, 0
  br i1 %t304, label %L63, label %L64
L63:
  %t305 = load ptr, ptr %t296
  %t306 = getelementptr [4 x i8], ptr @.str60, i64 0, i64 0
  %t307 = load ptr, ptr %t252
  %t308 = load ptr, ptr %t307
  %t309 = call i32 @snprintf(ptr %t305, i64 8, ptr %t306, ptr %t308)
  %t310 = sext i32 %t309 to i64
  %t311 = alloca ptr
  %t312 = load ptr, ptr %t252
  %t313 = load ptr, ptr %t312
  %t314 = call ptr @find_global(ptr %t0, ptr %t313)
  store ptr %t314, ptr %t311
  %t315 = load ptr, ptr %t311
  %t316 = load ptr, ptr %t311
  %t317 = load ptr, ptr %t316
  %t319 = ptrtoint ptr %t315 to i64
  %t320 = ptrtoint ptr %t317 to i64
  %t324 = ptrtoint ptr %t315 to i64
  %t325 = ptrtoint ptr %t317 to i64
  %t321 = icmp ne i64 %t324, 0
  %t322 = icmp ne i64 %t325, 0
  %t323 = and i1 %t321, %t322
  %t326 = zext i1 %t323 to i64
  %t327 = load ptr, ptr %t311
  %t328 = load ptr, ptr %t327
  %t329 = load ptr, ptr %t328
  %t331 = ptrtoint ptr %t329 to i64
  %t332 = sext i32 17 to i64
  %t330 = icmp eq i64 %t331, %t332
  %t333 = zext i1 %t330 to i64
  %t335 = icmp ne i64 %t326, 0
  %t336 = icmp ne i64 %t333, 0
  %t337 = and i1 %t335, %t336
  %t338 = zext i1 %t337 to i64
  %t339 = icmp ne i64 %t338, 0
  br i1 %t339, label %L66, label %L67
L66:
  %t340 = load ptr, ptr %t311
  %t341 = load ptr, ptr %t340
  %t342 = load ptr, ptr %t341
  store ptr %t342, ptr %t257
  br label %L68
L67:
  %t343 = alloca ptr
  %t344 = sext i32 0 to i64
  store i64 %t344, ptr %t343
  %t345 = alloca i64
  %t346 = sext i32 0 to i64
  store i64 %t346, ptr %t345
  br label %L69
L69:
  %t347 = load ptr, ptr %t343
  %t348 = load i64, ptr %t345
  %t349 = getelementptr i32, ptr %t347, i64 %t348
  %t350 = load i64, ptr %t349
  %t351 = icmp ne i64 %t350, 0
  br i1 %t351, label %L70, label %L72
L70:
  %t352 = load ptr, ptr %t252
  %t353 = load ptr, ptr %t352
  %t354 = load ptr, ptr %t343
  %t355 = load i64, ptr %t345
  %t356 = getelementptr i32, ptr %t354, i64 %t355
  %t357 = load i64, ptr %t356
  %t358 = call i32 @strcmp(ptr %t353, i64 %t357)
  %t359 = sext i32 %t358 to i64
  %t361 = sext i32 0 to i64
  %t360 = icmp eq i64 %t359, %t361
  %t362 = zext i1 %t360 to i64
  %t363 = icmp ne i64 %t362, 0
  br i1 %t363, label %L73, label %L75
L73:
  %t364 = call ptr @default_ptr_type()
  store ptr %t364, ptr %t257
  br label %L72
L76:
  br label %L75
L75:
  br label %L71
L71:
  %t365 = load i64, ptr %t345
  %t366 = add i64 %t365, 1
  store i64 %t366, ptr %t345
  br label %L69
L72:
  %t367 = alloca ptr
  %t368 = sext i32 0 to i64
  store i64 %t368, ptr %t367
  %t369 = alloca i64
  %t370 = sext i32 0 to i64
  store i64 %t370, ptr %t369
  br label %L77
L77:
  %t371 = load ptr, ptr %t367
  %t372 = load i64, ptr %t369
  %t373 = getelementptr i32, ptr %t371, i64 %t372
  %t374 = load i64, ptr %t373
  %t375 = icmp ne i64 %t374, 0
  br i1 %t375, label %L78, label %L80
L78:
  %t376 = load ptr, ptr %t252
  %t377 = load ptr, ptr %t376
  %t378 = load ptr, ptr %t367
  %t379 = load i64, ptr %t369
  %t380 = getelementptr i32, ptr %t378, i64 %t379
  %t381 = load i64, ptr %t380
  %t382 = call i32 @strcmp(ptr %t377, i64 %t381)
  %t383 = sext i32 %t382 to i64
  %t385 = sext i32 0 to i64
  %t384 = icmp eq i64 %t383, %t385
  %t386 = zext i1 %t384 to i64
  %t387 = icmp ne i64 %t386, 0
  br i1 %t387, label %L81, label %L83
L81:
  %t388 = call ptr @default_i64_type()
  store ptr %t388, ptr %t257
  br label %L80
L84:
  br label %L83
L83:
  br label %L79
L79:
  %t389 = load i64, ptr %t369
  %t390 = add i64 %t389, 1
  store i64 %t390, ptr %t369
  br label %L77
L80:
  br label %L68
L68:
  br label %L65
L64:
  %t391 = alloca i64
  %t392 = load ptr, ptr %t252
  %t393 = call i64 @emit_expr(ptr %t0, ptr %t392)
  store i64 %t393, ptr %t391
  %t394 = load ptr, ptr %t296
  %t395 = load ptr, ptr %t391
  %t397 = sext i32 8 to i64
  %t398 = sext i32 1 to i64
  %t396 = sub i64 %t397, %t398
  %t399 = call ptr @strncpy(ptr %t394, ptr %t395, i64 %t396)
  br label %L65
L65:
  %t400 = alloca i64
  %t401 = call i32 @new_reg(ptr %t0)
  %t402 = sext i32 %t401 to i64
  store i64 %t402, ptr %t400
  %t403 = alloca ptr
  %t404 = load ptr, ptr %t257
  %t405 = call ptr @llvm_type(ptr %t404)
  store ptr %t405, ptr %t403
  %t406 = alloca i64
  %t407 = load ptr, ptr %t257
  %t408 = load ptr, ptr %t407
  %t410 = ptrtoint ptr %t408 to i64
  %t411 = sext i32 0 to i64
  %t409 = icmp eq i64 %t410, %t411
  %t412 = zext i1 %t409 to i64
  store i64 %t412, ptr %t406
  %t413 = load i64, ptr %t406
  %t414 = icmp ne i64 %t413, 0
  br i1 %t414, label %L85, label %L86
L85:
  %t415 = getelementptr [16 x i8], ptr @.str61, i64 0, i64 0
  %t416 = load ptr, ptr %t296
  call void @emit(ptr %t0, ptr %t415, ptr %t416)
  br label %L87
L86:
  %t418 = getelementptr [22 x i8], ptr @.str62, i64 0, i64 0
  %t419 = load i64, ptr %t400
  %t420 = load ptr, ptr %t403
  %t421 = load ptr, ptr %t296
  call void @emit(ptr %t0, ptr %t418, i64 %t419, ptr %t420, ptr %t421)
  br label %L87
L87:
  %t423 = alloca i64
  %t424 = sext i32 1 to i64
  store i64 %t424, ptr %t423
  br label %L88
L88:
  %t425 = load i64, ptr %t423
  %t426 = load ptr, ptr %t1
  %t428 = ptrtoint ptr %t426 to i64
  %t427 = icmp slt i64 %t425, %t428
  %t429 = zext i1 %t427 to i64
  %t430 = icmp ne i64 %t429, 0
  br i1 %t430, label %L89, label %L91
L89:
  %t431 = load i64, ptr %t423
  %t433 = sext i32 1 to i64
  %t432 = icmp sgt i64 %t431, %t433
  %t434 = zext i1 %t432 to i64
  %t435 = icmp ne i64 %t434, 0
  br i1 %t435, label %L92, label %L94
L92:
  %t436 = getelementptr [3 x i8], ptr @.str63, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t436)
  br label %L94
L94:
  %t438 = alloca ptr
  %t439 = load ptr, ptr %t265
  %t440 = load i64, ptr %t423
  %t441 = getelementptr i32, ptr %t439, i64 %t440
  %t442 = load i64, ptr %t441
  %t443 = load ptr, ptr %t265
  %t444 = load i64, ptr %t423
  %t445 = getelementptr i32, ptr %t443, i64 %t444
  %t446 = load i64, ptr %t445
  %t447 = inttoptr i64 %t446 to ptr
  %t448 = load ptr, ptr %t447
  %t450 = ptrtoint ptr %t448 to i64
  %t451 = sext i32 15 to i64
  %t449 = icmp eq i64 %t450, %t451
  %t452 = zext i1 %t449 to i64
  %t453 = load ptr, ptr %t265
  %t454 = load i64, ptr %t423
  %t455 = getelementptr i32, ptr %t453, i64 %t454
  %t456 = load i64, ptr %t455
  %t457 = inttoptr i64 %t456 to ptr
  %t458 = load ptr, ptr %t457
  %t460 = ptrtoint ptr %t458 to i64
  %t461 = sext i32 16 to i64
  %t459 = icmp eq i64 %t460, %t461
  %t462 = zext i1 %t459 to i64
  %t464 = icmp ne i64 %t452, 0
  %t465 = icmp ne i64 %t462, 0
  %t466 = or i1 %t464, %t465
  %t467 = zext i1 %t466 to i64
  %t469 = icmp ne i64 %t442, 0
  %t470 = icmp ne i64 %t467, 0
  %t471 = and i1 %t469, %t470
  %t472 = zext i1 %t471 to i64
  %t473 = icmp ne i64 %t472, 0
  br i1 %t473, label %L95, label %L96
L95:
  %t474 = getelementptr [4 x i8], ptr @.str64, i64 0, i64 0
  store ptr %t474, ptr %t438
  br label %L97
L96:
  %t475 = load ptr, ptr %t265
  %t476 = load i64, ptr %t423
  %t477 = getelementptr i32, ptr %t475, i64 %t476
  %t478 = load i64, ptr %t477
  %t479 = load ptr, ptr %t265
  %t480 = load i64, ptr %t423
  %t481 = getelementptr i32, ptr %t479, i64 %t480
  %t482 = load i64, ptr %t481
  %t483 = call i32 @type_is_fp(i64 %t482)
  %t484 = sext i32 %t483 to i64
  %t486 = icmp ne i64 %t478, 0
  %t487 = icmp ne i64 %t484, 0
  %t488 = and i1 %t486, %t487
  %t489 = zext i1 %t488 to i64
  %t490 = icmp ne i64 %t489, 0
  br i1 %t490, label %L98, label %L99
L98:
  %t491 = load ptr, ptr %t265
  %t492 = load i64, ptr %t423
  %t493 = getelementptr i32, ptr %t491, i64 %t492
  %t494 = load i64, ptr %t493
  %t495 = call ptr @llvm_type(i64 %t494)
  store ptr %t495, ptr %t438
  br label %L100
L99:
  %t496 = getelementptr [4 x i8], ptr @.str65, i64 0, i64 0
  store ptr %t496, ptr %t438
  br label %L100
L100:
  br label %L97
L97:
  %t497 = getelementptr [6 x i8], ptr @.str66, i64 0, i64 0
  %t498 = load ptr, ptr %t438
  %t499 = load ptr, ptr %t259
  %t500 = load i64, ptr %t423
  %t501 = getelementptr i32, ptr %t499, i64 %t500
  %t502 = load i64, ptr %t501
  call void @emit(ptr %t0, ptr %t497, ptr %t498, i64 %t502)
  br label %L90
L90:
  %t504 = load i64, ptr %t423
  %t505 = add i64 %t504, 1
  store i64 %t505, ptr %t423
  br label %L88
L91:
  %t506 = getelementptr [3 x i8], ptr @.str67, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t506)
  %t508 = alloca i64
  %t509 = sext i32 1 to i64
  store i64 %t509, ptr %t508
  br label %L101
L101:
  %t510 = load i64, ptr %t508
  %t511 = load ptr, ptr %t1
  %t513 = ptrtoint ptr %t511 to i64
  %t512 = icmp slt i64 %t510, %t513
  %t514 = zext i1 %t512 to i64
  %t515 = icmp ne i64 %t514, 0
  br i1 %t515, label %L102, label %L104
L102:
  %t516 = load ptr, ptr %t259
  %t517 = load i64, ptr %t508
  %t518 = getelementptr i32, ptr %t516, i64 %t517
  %t519 = load i64, ptr %t518
  %t520 = call i32 @free(i64 %t519)
  %t521 = sext i32 %t520 to i64
  br label %L103
L103:
  %t522 = load i64, ptr %t508
  %t523 = add i64 %t522, 1
  store i64 %t523, ptr %t508
  br label %L101
L104:
  %t524 = load ptr, ptr %t259
  %t525 = call i32 @free(ptr %t524)
  %t526 = sext i32 %t525 to i64
  %t527 = load ptr, ptr %t265
  %t528 = call i32 @free(ptr %t527)
  %t529 = sext i32 %t528 to i64
  %t530 = load i64, ptr %t406
  %t531 = icmp ne i64 %t530, 0
  br i1 %t531, label %L105, label %L107
L105:
  %t532 = getelementptr [2 x i8], ptr @.str68, i64 0, i64 0
  %t533 = load ptr, ptr %t257
  %t534 = call i64 @make_val(ptr %t532, ptr %t533)
  ret i64 %t534
L108:
  br label %L107
L107:
  %t535 = alloca ptr
  %t536 = load ptr, ptr %t535
  %t537 = getelementptr [6 x i8], ptr @.str69, i64 0, i64 0
  %t538 = load i64, ptr %t400
  %t539 = call i32 @snprintf(ptr %t536, i64 8, ptr %t537, i64 %t538)
  %t540 = sext i32 %t539 to i64
  %t541 = alloca ptr
  %t542 = load ptr, ptr %t257
  store ptr %t542, ptr %t541
  %t543 = load ptr, ptr %t257
  %t544 = call i32 @type_is_fp(ptr %t543)
  %t545 = sext i32 %t544 to i64
  %t547 = icmp eq i64 %t545, 0
  %t546 = zext i1 %t547 to i64
  %t548 = load ptr, ptr %t257
  %t549 = load ptr, ptr %t548
  %t551 = ptrtoint ptr %t549 to i64
  %t552 = sext i32 15 to i64
  %t550 = icmp ne i64 %t551, %t552
  %t553 = zext i1 %t550 to i64
  %t555 = icmp ne i64 %t546, 0
  %t556 = icmp ne i64 %t553, 0
  %t557 = and i1 %t555, %t556
  %t558 = zext i1 %t557 to i64
  %t559 = load ptr, ptr %t257
  %t560 = load ptr, ptr %t559
  %t562 = ptrtoint ptr %t560 to i64
  %t563 = sext i32 16 to i64
  %t561 = icmp ne i64 %t562, %t563
  %t564 = zext i1 %t561 to i64
  %t566 = icmp ne i64 %t558, 0
  %t567 = icmp ne i64 %t564, 0
  %t568 = and i1 %t566, %t567
  %t569 = zext i1 %t568 to i64
  %t570 = load ptr, ptr %t257
  %t571 = load ptr, ptr %t570
  %t573 = ptrtoint ptr %t571 to i64
  %t574 = sext i32 0 to i64
  %t572 = icmp ne i64 %t573, %t574
  %t575 = zext i1 %t572 to i64
  %t577 = icmp ne i64 %t569, 0
  %t578 = icmp ne i64 %t575, 0
  %t579 = and i1 %t577, %t578
  %t580 = zext i1 %t579 to i64
  %t581 = icmp ne i64 %t580, 0
  br i1 %t581, label %L109, label %L111
L109:
  %t582 = alloca i64
  %t583 = load ptr, ptr %t257
  %t584 = call i32 @type_size(ptr %t583)
  %t585 = sext i32 %t584 to i64
  store i64 %t585, ptr %t582
  %t586 = load i64, ptr %t582
  %t588 = sext i32 0 to i64
  %t587 = icmp sgt i64 %t586, %t588
  %t589 = zext i1 %t587 to i64
  %t590 = load i64, ptr %t582
  %t592 = sext i32 8 to i64
  %t591 = icmp slt i64 %t590, %t592
  %t593 = zext i1 %t591 to i64
  %t595 = icmp ne i64 %t589, 0
  %t596 = icmp ne i64 %t593, 0
  %t597 = and i1 %t595, %t596
  %t598 = zext i1 %t597 to i64
  %t599 = load ptr, ptr %t403
  %t600 = getelementptr [4 x i8], ptr @.str70, i64 0, i64 0
  %t601 = call i32 @strcmp(ptr %t599, ptr %t600)
  %t602 = sext i32 %t601 to i64
  %t604 = sext i32 0 to i64
  %t603 = icmp ne i64 %t602, %t604
  %t605 = zext i1 %t603 to i64
  %t607 = icmp ne i64 %t598, 0
  %t608 = icmp ne i64 %t605, 0
  %t609 = and i1 %t607, %t608
  %t610 = zext i1 %t609 to i64
  %t611 = icmp ne i64 %t610, 0
  br i1 %t611, label %L112, label %L114
L112:
  %t612 = alloca i64
  %t613 = call i32 @new_reg(ptr %t0)
  %t614 = sext i32 %t613 to i64
  store i64 %t614, ptr %t612
  %t615 = getelementptr [32 x i8], ptr @.str71, i64 0, i64 0
  %t616 = load i64, ptr %t612
  %t617 = load ptr, ptr %t403
  %t618 = load i64, ptr %t400
  call void @emit(ptr %t0, ptr %t615, i64 %t616, ptr %t617, i64 %t618)
  %t620 = load ptr, ptr %t535
  %t621 = getelementptr [6 x i8], ptr @.str72, i64 0, i64 0
  %t622 = load i64, ptr %t612
  %t623 = call i32 @snprintf(ptr %t620, i64 8, ptr %t621, i64 %t622)
  %t624 = sext i32 %t623 to i64
  br label %L114
L114:
  %t625 = call ptr @default_i64_type()
  store ptr %t625, ptr %t541
  br label %L111
L111:
  %t626 = load ptr, ptr %t535
  %t627 = load ptr, ptr %t541
  %t628 = call i64 @make_val(ptr %t626, ptr %t627)
  ret i64 %t628
L115:
  br label %L11
L11:
  %t629 = alloca i64
  %t630 = load ptr, ptr %t1
  %t631 = sext i32 0 to i64
  %t632 = getelementptr i32, ptr %t630, i64 %t631
  %t633 = load i64, ptr %t632
  %t634 = call i64 @emit_expr(ptr %t0, i64 %t633)
  store i64 %t634, ptr %t629
  %t635 = alloca i64
  %t636 = load ptr, ptr %t1
  %t637 = sext i32 1 to i64
  %t638 = getelementptr i32, ptr %t636, i64 %t637
  %t639 = load i64, ptr %t638
  %t640 = call i64 @emit_expr(ptr %t0, i64 %t639)
  store i64 %t640, ptr %t635
  %t641 = alloca i64
  %t642 = call i32 @new_reg(ptr %t0)
  %t643 = sext i32 %t642 to i64
  store i64 %t643, ptr %t641
  %t644 = alloca i64
  %t645 = load ptr, ptr %t629
  %t646 = call i32 @type_is_fp(ptr %t645)
  %t647 = sext i32 %t646 to i64
  %t648 = load ptr, ptr %t635
  %t649 = call i32 @type_is_fp(ptr %t648)
  %t650 = sext i32 %t649 to i64
  %t652 = icmp ne i64 %t647, 0
  %t653 = icmp ne i64 %t650, 0
  %t654 = or i1 %t652, %t653
  %t655 = zext i1 %t654 to i64
  store i64 %t655, ptr %t644
  %t656 = alloca i64
  %t657 = load i64, ptr %t629
  %t658 = call i32 @val_is_ptr(i64 %t657)
  %t659 = sext i32 %t658 to i64
  store i64 %t659, ptr %t656
  %t660 = alloca ptr
  %t661 = load i64, ptr %t644
  %t662 = icmp ne i64 %t661, 0
  br i1 %t662, label %L116, label %L117
L116:
  %t663 = load ptr, ptr %t629
  %t664 = call ptr @llvm_type(ptr %t663)
  %t665 = ptrtoint ptr %t664 to i64
  br label %L118
L117:
  %t666 = getelementptr [4 x i8], ptr @.str73, i64 0, i64 0
  %t667 = ptrtoint ptr %t666 to i64
  br label %L118
L118:
  %t668 = phi i64 [ %t665, %L116 ], [ %t667, %L117 ]
  store i64 %t668, ptr %t660
  %t669 = alloca ptr
  %t670 = alloca ptr
  %t671 = load ptr, ptr %t669
  %t673 = sext i32 0 to i64
  %t672 = getelementptr i8, ptr %t671, i64 %t673
  %t674 = sext i32 0 to i64
  store i64 %t674, ptr %t672
  %t675 = load ptr, ptr %t670
  %t677 = sext i32 0 to i64
  %t676 = getelementptr i8, ptr %t675, i64 %t677
  %t678 = sext i32 0 to i64
  store i64 %t678, ptr %t676
  %t679 = load i64, ptr %t644
  %t681 = icmp eq i64 %t679, 0
  %t680 = zext i1 %t681 to i64
  %t682 = icmp ne i64 %t680, 0
  br i1 %t682, label %L119, label %L120
L119:
  %t683 = load i64, ptr %t629
  %t684 = load ptr, ptr %t669
  %t685 = call i32 @promote_to_i64(ptr %t0, i64 %t683, ptr %t684, i64 64)
  %t686 = sext i32 %t685 to i64
  %t687 = load i64, ptr %t635
  %t688 = load ptr, ptr %t670
  %t689 = call i32 @promote_to_i64(ptr %t0, i64 %t687, ptr %t688, i64 64)
  %t690 = sext i32 %t689 to i64
  %t691 = getelementptr [4 x i8], ptr @.str74, i64 0, i64 0
  store ptr %t691, ptr %t660
  br label %L121
L120:
  %t692 = load ptr, ptr %t669
  %t693 = load ptr, ptr %t629
  %t694 = call ptr @strncpy(ptr %t692, ptr %t693, i64 63)
  %t695 = load ptr, ptr %t669
  %t697 = sext i32 63 to i64
  %t696 = getelementptr i8, ptr %t695, i64 %t697
  %t698 = sext i32 0 to i64
  store i64 %t698, ptr %t696
  %t699 = load ptr, ptr %t670
  %t700 = load ptr, ptr %t635
  %t701 = call ptr @strncpy(ptr %t699, ptr %t700, i64 63)
  %t702 = load ptr, ptr %t670
  %t704 = sext i32 63 to i64
  %t703 = getelementptr i8, ptr %t702, i64 %t704
  %t705 = sext i32 0 to i64
  store i64 %t705, ptr %t703
  br label %L121
L121:
  %t706 = alloca ptr
  %t708 = sext i32 0 to i64
  %t707 = inttoptr i64 %t708 to ptr
  store ptr %t707, ptr %t706
  %t709 = alloca i64
  %t710 = sext i32 0 to i64
  store i64 %t710, ptr %t709
  %t711 = load ptr, ptr %t1
  %t712 = ptrtoint ptr %t711 to i64
  %t713 = add i64 %t712, 0
  switch i64 %t713, label %L141 [
    i64 35, label %L123
    i64 36, label %L124
    i64 37, label %L125
    i64 38, label %L126
    i64 39, label %L127
    i64 40, label %L128
    i64 41, label %L129
    i64 42, label %L130
    i64 44, label %L131
    i64 45, label %L132
    i64 46, label %L133
    i64 47, label %L134
    i64 48, label %L135
    i64 49, label %L136
    i64 50, label %L137
    i64 51, label %L138
    i64 52, label %L139
    i64 53, label %L140
  ]
L123:
  %t714 = load i64, ptr %t644
  %t715 = icmp ne i64 %t714, 0
  br i1 %t715, label %L142, label %L143
L142:
  %t716 = getelementptr [5 x i8], ptr @.str75, i64 0, i64 0
  %t717 = ptrtoint ptr %t716 to i64
  br label %L144
L143:
  %t718 = load i64, ptr %t656
  %t719 = icmp ne i64 %t718, 0
  br i1 %t719, label %L145, label %L146
L145:
  %t720 = getelementptr [14 x i8], ptr @.str76, i64 0, i64 0
  %t721 = ptrtoint ptr %t720 to i64
  br label %L147
L146:
  %t722 = getelementptr [4 x i8], ptr @.str77, i64 0, i64 0
  %t723 = ptrtoint ptr %t722 to i64
  br label %L147
L147:
  %t724 = phi i64 [ %t721, %L145 ], [ %t723, %L146 ]
  br label %L144
L144:
  %t725 = phi i64 [ %t717, %L142 ], [ %t724, %L143 ]
  store i64 %t725, ptr %t706
  br label %L122
L148:
  br label %L124
L124:
  %t726 = load i64, ptr %t644
  %t727 = icmp ne i64 %t726, 0
  br i1 %t727, label %L149, label %L150
L149:
  %t728 = getelementptr [5 x i8], ptr @.str78, i64 0, i64 0
  %t729 = ptrtoint ptr %t728 to i64
  br label %L151
L150:
  %t730 = getelementptr [4 x i8], ptr @.str79, i64 0, i64 0
  %t731 = ptrtoint ptr %t730 to i64
  br label %L151
L151:
  %t732 = phi i64 [ %t729, %L149 ], [ %t731, %L150 ]
  store i64 %t732, ptr %t706
  br label %L122
L152:
  br label %L125
L125:
  %t733 = load i64, ptr %t644
  %t734 = icmp ne i64 %t733, 0
  br i1 %t734, label %L153, label %L154
L153:
  %t735 = getelementptr [5 x i8], ptr @.str80, i64 0, i64 0
  %t736 = ptrtoint ptr %t735 to i64
  br label %L155
L154:
  %t737 = getelementptr [4 x i8], ptr @.str81, i64 0, i64 0
  %t738 = ptrtoint ptr %t737 to i64
  br label %L155
L155:
  %t739 = phi i64 [ %t736, %L153 ], [ %t738, %L154 ]
  store i64 %t739, ptr %t706
  br label %L122
L156:
  br label %L126
L126:
  %t740 = load i64, ptr %t644
  %t741 = icmp ne i64 %t740, 0
  br i1 %t741, label %L157, label %L158
L157:
  %t742 = getelementptr [5 x i8], ptr @.str82, i64 0, i64 0
  %t743 = ptrtoint ptr %t742 to i64
  br label %L159
L158:
  %t744 = getelementptr [5 x i8], ptr @.str83, i64 0, i64 0
  %t745 = ptrtoint ptr %t744 to i64
  br label %L159
L159:
  %t746 = phi i64 [ %t743, %L157 ], [ %t745, %L158 ]
  store i64 %t746, ptr %t706
  br label %L122
L160:
  br label %L127
L127:
  %t747 = load i64, ptr %t644
  %t748 = icmp ne i64 %t747, 0
  br i1 %t748, label %L161, label %L162
L161:
  %t749 = getelementptr [5 x i8], ptr @.str84, i64 0, i64 0
  %t750 = ptrtoint ptr %t749 to i64
  br label %L163
L162:
  %t751 = getelementptr [5 x i8], ptr @.str85, i64 0, i64 0
  %t752 = ptrtoint ptr %t751 to i64
  br label %L163
L163:
  %t753 = phi i64 [ %t750, %L161 ], [ %t752, %L162 ]
  store i64 %t753, ptr %t706
  br label %L122
L164:
  br label %L128
L128:
  %t754 = getelementptr [4 x i8], ptr @.str86, i64 0, i64 0
  store ptr %t754, ptr %t706
  br label %L122
L165:
  br label %L129
L129:
  %t755 = getelementptr [3 x i8], ptr @.str87, i64 0, i64 0
  store ptr %t755, ptr %t706
  br label %L122
L166:
  br label %L130
L130:
  %t756 = getelementptr [4 x i8], ptr @.str88, i64 0, i64 0
  store ptr %t756, ptr %t706
  br label %L122
L167:
  br label %L131
L131:
  %t757 = getelementptr [4 x i8], ptr @.str89, i64 0, i64 0
  store ptr %t757, ptr %t706
  br label %L122
L168:
  br label %L132
L132:
  %t758 = getelementptr [5 x i8], ptr @.str90, i64 0, i64 0
  store ptr %t758, ptr %t706
  br label %L122
L169:
  br label %L133
L133:
  %t759 = load i64, ptr %t644
  %t760 = icmp ne i64 %t759, 0
  br i1 %t760, label %L170, label %L171
L170:
  %t761 = getelementptr [9 x i8], ptr @.str91, i64 0, i64 0
  %t762 = ptrtoint ptr %t761 to i64
  br label %L172
L171:
  %t763 = getelementptr [8 x i8], ptr @.str92, i64 0, i64 0
  %t764 = ptrtoint ptr %t763 to i64
  br label %L172
L172:
  %t765 = phi i64 [ %t762, %L170 ], [ %t764, %L171 ]
  store i64 %t765, ptr %t706
  %t766 = sext i32 1 to i64
  store i64 %t766, ptr %t709
  br label %L122
L173:
  br label %L134
L134:
  %t767 = load i64, ptr %t644
  %t768 = icmp ne i64 %t767, 0
  br i1 %t768, label %L174, label %L175
L174:
  %t769 = getelementptr [9 x i8], ptr @.str93, i64 0, i64 0
  %t770 = ptrtoint ptr %t769 to i64
  br label %L176
L175:
  %t771 = getelementptr [8 x i8], ptr @.str94, i64 0, i64 0
  %t772 = ptrtoint ptr %t771 to i64
  br label %L176
L176:
  %t773 = phi i64 [ %t770, %L174 ], [ %t772, %L175 ]
  store i64 %t773, ptr %t706
  %t774 = sext i32 1 to i64
  store i64 %t774, ptr %t709
  br label %L122
L177:
  br label %L135
L135:
  %t775 = load i64, ptr %t644
  %t776 = icmp ne i64 %t775, 0
  br i1 %t776, label %L178, label %L179
L178:
  %t777 = getelementptr [9 x i8], ptr @.str95, i64 0, i64 0
  %t778 = ptrtoint ptr %t777 to i64
  br label %L180
L179:
  %t779 = getelementptr [9 x i8], ptr @.str96, i64 0, i64 0
  %t780 = ptrtoint ptr %t779 to i64
  br label %L180
L180:
  %t781 = phi i64 [ %t778, %L178 ], [ %t780, %L179 ]
  store i64 %t781, ptr %t706
  %t782 = sext i32 1 to i64
  store i64 %t782, ptr %t709
  br label %L122
L181:
  br label %L136
L136:
  %t783 = load i64, ptr %t644
  %t784 = icmp ne i64 %t783, 0
  br i1 %t784, label %L182, label %L183
L182:
  %t785 = getelementptr [9 x i8], ptr @.str97, i64 0, i64 0
  %t786 = ptrtoint ptr %t785 to i64
  br label %L184
L183:
  %t787 = getelementptr [9 x i8], ptr @.str98, i64 0, i64 0
  %t788 = ptrtoint ptr %t787 to i64
  br label %L184
L184:
  %t789 = phi i64 [ %t786, %L182 ], [ %t788, %L183 ]
  store i64 %t789, ptr %t706
  %t790 = sext i32 1 to i64
  store i64 %t790, ptr %t709
  br label %L122
L185:
  br label %L137
L137:
  %t791 = load i64, ptr %t644
  %t792 = icmp ne i64 %t791, 0
  br i1 %t792, label %L186, label %L187
L186:
  %t793 = getelementptr [9 x i8], ptr @.str99, i64 0, i64 0
  %t794 = ptrtoint ptr %t793 to i64
  br label %L188
L187:
  %t795 = getelementptr [9 x i8], ptr @.str100, i64 0, i64 0
  %t796 = ptrtoint ptr %t795 to i64
  br label %L188
L188:
  %t797 = phi i64 [ %t794, %L186 ], [ %t796, %L187 ]
  store i64 %t797, ptr %t706
  %t798 = sext i32 1 to i64
  store i64 %t798, ptr %t709
  br label %L122
L189:
  br label %L138
L138:
  %t799 = load i64, ptr %t644
  %t800 = icmp ne i64 %t799, 0
  br i1 %t800, label %L190, label %L191
L190:
  %t801 = getelementptr [9 x i8], ptr @.str101, i64 0, i64 0
  %t802 = ptrtoint ptr %t801 to i64
  br label %L192
L191:
  %t803 = getelementptr [9 x i8], ptr @.str102, i64 0, i64 0
  %t804 = ptrtoint ptr %t803 to i64
  br label %L192
L192:
  %t805 = phi i64 [ %t802, %L190 ], [ %t804, %L191 ]
  store i64 %t805, ptr %t706
  %t806 = sext i32 1 to i64
  store i64 %t806, ptr %t709
  br label %L122
L193:
  br label %L139
L139:
  %t807 = alloca i64
  %t808 = call i32 @new_reg(ptr %t0)
  %t809 = sext i32 %t808 to i64
  store i64 %t809, ptr %t807
  %t810 = alloca i64
  %t811 = call i32 @new_reg(ptr %t0)
  %t812 = sext i32 %t811 to i64
  store i64 %t812, ptr %t810
  %t813 = alloca i64
  %t814 = call i32 @new_reg(ptr %t0)
  %t815 = sext i32 %t814 to i64
  store i64 %t815, ptr %t813
  %t816 = alloca ptr
  %t817 = alloca ptr
  %t818 = load i64, ptr %t629
  %t819 = load ptr, ptr %t816
  %t820 = call i32 @promote_to_i64(ptr %t0, i64 %t818, ptr %t819, i64 64)
  %t821 = sext i32 %t820 to i64
  %t822 = load i64, ptr %t635
  %t823 = load ptr, ptr %t817
  %t824 = call i32 @promote_to_i64(ptr %t0, i64 %t822, ptr %t823, i64 64)
  %t825 = sext i32 %t824 to i64
  %t826 = getelementptr [29 x i8], ptr @.str103, i64 0, i64 0
  %t827 = load i64, ptr %t807
  %t828 = load ptr, ptr %t816
  call void @emit(ptr %t0, ptr %t826, i64 %t827, ptr %t828)
  %t830 = getelementptr [29 x i8], ptr @.str104, i64 0, i64 0
  %t831 = load i64, ptr %t810
  %t832 = load ptr, ptr %t817
  call void @emit(ptr %t0, ptr %t830, i64 %t831, ptr %t832)
  %t834 = getelementptr [31 x i8], ptr @.str105, i64 0, i64 0
  %t835 = load i64, ptr %t813
  %t836 = load i64, ptr %t807
  %t837 = load i64, ptr %t810
  call void @emit(ptr %t0, ptr %t834, i64 %t835, i64 %t836, i64 %t837)
  %t839 = alloca i64
  %t840 = call i32 @new_reg(ptr %t0)
  %t841 = sext i32 %t840 to i64
  store i64 %t841, ptr %t839
  %t842 = getelementptr [32 x i8], ptr @.str106, i64 0, i64 0
  %t843 = load i64, ptr %t839
  %t844 = load i64, ptr %t813
  call void @emit(ptr %t0, ptr %t842, i64 %t843, i64 %t844)
  %t846 = alloca ptr
  %t847 = load ptr, ptr %t846
  %t848 = getelementptr [6 x i8], ptr @.str107, i64 0, i64 0
  %t849 = load i64, ptr %t839
  %t850 = call i32 @snprintf(ptr %t847, i64 8, ptr %t848, i64 %t849)
  %t851 = sext i32 %t850 to i64
  %t852 = load ptr, ptr %t846
  %t853 = call ptr @default_i64_type()
  %t854 = call i64 @make_val(ptr %t852, ptr %t853)
  ret i64 %t854
L194:
  br label %L140
L140:
  %t855 = alloca i64
  %t856 = call i32 @new_reg(ptr %t0)
  %t857 = sext i32 %t856 to i64
  store i64 %t857, ptr %t855
  %t858 = alloca i64
  %t859 = call i32 @new_reg(ptr %t0)
  %t860 = sext i32 %t859 to i64
  store i64 %t860, ptr %t858
  %t861 = alloca i64
  %t862 = call i32 @new_reg(ptr %t0)
  %t863 = sext i32 %t862 to i64
  store i64 %t863, ptr %t861
  %t864 = alloca ptr
  %t865 = alloca ptr
  %t866 = load i64, ptr %t629
  %t867 = load ptr, ptr %t864
  %t868 = call i32 @promote_to_i64(ptr %t0, i64 %t866, ptr %t867, i64 64)
  %t869 = sext i32 %t868 to i64
  %t870 = load i64, ptr %t635
  %t871 = load ptr, ptr %t865
  %t872 = call i32 @promote_to_i64(ptr %t0, i64 %t870, ptr %t871, i64 64)
  %t873 = sext i32 %t872 to i64
  %t874 = getelementptr [29 x i8], ptr @.str108, i64 0, i64 0
  %t875 = load i64, ptr %t855
  %t876 = load ptr, ptr %t864
  call void @emit(ptr %t0, ptr %t874, i64 %t875, ptr %t876)
  %t878 = getelementptr [29 x i8], ptr @.str109, i64 0, i64 0
  %t879 = load i64, ptr %t858
  %t880 = load ptr, ptr %t865
  call void @emit(ptr %t0, ptr %t878, i64 %t879, ptr %t880)
  %t882 = getelementptr [30 x i8], ptr @.str110, i64 0, i64 0
  %t883 = load i64, ptr %t861
  %t884 = load i64, ptr %t855
  %t885 = load i64, ptr %t858
  call void @emit(ptr %t0, ptr %t882, i64 %t883, i64 %t884, i64 %t885)
  %t887 = alloca i64
  %t888 = call i32 @new_reg(ptr %t0)
  %t889 = sext i32 %t888 to i64
  store i64 %t889, ptr %t887
  %t890 = getelementptr [32 x i8], ptr @.str111, i64 0, i64 0
  %t891 = load i64, ptr %t887
  %t892 = load i64, ptr %t861
  call void @emit(ptr %t0, ptr %t890, i64 %t891, i64 %t892)
  %t894 = alloca ptr
  %t895 = load ptr, ptr %t894
  %t896 = getelementptr [6 x i8], ptr @.str112, i64 0, i64 0
  %t897 = load i64, ptr %t887
  %t898 = call i32 @snprintf(ptr %t895, i64 8, ptr %t896, i64 %t897)
  %t899 = sext i32 %t898 to i64
  %t900 = load ptr, ptr %t894
  %t901 = call ptr @default_i64_type()
  %t902 = call i64 @make_val(ptr %t900, ptr %t901)
  ret i64 %t902
L195:
  br label %L122
L141:
  %t903 = getelementptr [4 x i8], ptr @.str113, i64 0, i64 0
  store ptr %t903, ptr %t706
  br label %L122
L122:
  %t904 = load ptr, ptr %t1
  %t906 = ptrtoint ptr %t904 to i64
  %t907 = sext i32 35 to i64
  %t905 = icmp eq i64 %t906, %t907
  %t908 = zext i1 %t905 to i64
  %t909 = load i64, ptr %t656
  %t911 = icmp ne i64 %t908, 0
  %t912 = icmp ne i64 %t909, 0
  %t913 = and i1 %t911, %t912
  %t914 = zext i1 %t913 to i64
  %t915 = icmp ne i64 %t914, 0
  br i1 %t915, label %L196, label %L197
L196:
  %t916 = alloca i64
  %t917 = call i32 @new_reg(ptr %t0)
  %t918 = sext i32 %t917 to i64
  store i64 %t918, ptr %t916
  %t919 = getelementptr [34 x i8], ptr @.str114, i64 0, i64 0
  %t920 = load i64, ptr %t916
  %t921 = load ptr, ptr %t669
  call void @emit(ptr %t0, ptr %t919, i64 %t920, ptr %t921)
  %t923 = getelementptr [47 x i8], ptr @.str115, i64 0, i64 0
  %t924 = load i64, ptr %t641
  %t925 = load i64, ptr %t916
  %t926 = load ptr, ptr %t670
  call void @emit(ptr %t0, ptr %t923, i64 %t924, i64 %t925, ptr %t926)
  br label %L198
L197:
  %t928 = load i64, ptr %t709
  %t929 = icmp ne i64 %t928, 0
  br i1 %t929, label %L199, label %L200
L199:
  %t930 = getelementptr [24 x i8], ptr @.str116, i64 0, i64 0
  %t931 = load i64, ptr %t641
  %t932 = load ptr, ptr %t706
  %t933 = load ptr, ptr %t660
  %t934 = load ptr, ptr %t669
  %t935 = load ptr, ptr %t670
  call void @emit(ptr %t0, ptr %t930, i64 %t931, ptr %t932, ptr %t933, ptr %t934, ptr %t935)
  %t937 = alloca i64
  %t938 = call i32 @new_reg(ptr %t0)
  %t939 = sext i32 %t938 to i64
  store i64 %t939, ptr %t937
  %t940 = getelementptr [32 x i8], ptr @.str117, i64 0, i64 0
  %t941 = load i64, ptr %t937
  %t942 = load i64, ptr %t641
  call void @emit(ptr %t0, ptr %t940, i64 %t941, i64 %t942)
  %t944 = alloca ptr
  %t945 = load ptr, ptr %t944
  %t946 = getelementptr [6 x i8], ptr @.str118, i64 0, i64 0
  %t947 = load i64, ptr %t937
  %t948 = call i32 @snprintf(ptr %t945, i64 8, ptr %t946, i64 %t947)
  %t949 = sext i32 %t948 to i64
  %t950 = load ptr, ptr %t944
  %t951 = call ptr @default_i64_type()
  %t952 = call i64 @make_val(ptr %t950, ptr %t951)
  ret i64 %t952
L202:
  br label %L201
L200:
  %t953 = getelementptr [24 x i8], ptr @.str119, i64 0, i64 0
  %t954 = load i64, ptr %t641
  %t955 = load ptr, ptr %t706
  %t956 = load ptr, ptr %t660
  %t957 = load ptr, ptr %t669
  %t958 = load ptr, ptr %t670
  call void @emit(ptr %t0, ptr %t953, i64 %t954, ptr %t955, ptr %t956, ptr %t957, ptr %t958)
  br label %L201
L201:
  br label %L198
L198:
  %t960 = alloca ptr
  %t961 = load ptr, ptr %t960
  %t962 = getelementptr [6 x i8], ptr @.str120, i64 0, i64 0
  %t963 = load i64, ptr %t641
  %t964 = call i32 @snprintf(ptr %t961, i64 8, ptr %t962, i64 %t963)
  %t965 = sext i32 %t964 to i64
  %t966 = load ptr, ptr %t1
  %t968 = ptrtoint ptr %t966 to i64
  %t969 = sext i32 35 to i64
  %t967 = icmp eq i64 %t968, %t969
  %t970 = zext i1 %t967 to i64
  %t971 = load i64, ptr %t656
  %t973 = icmp ne i64 %t970, 0
  %t974 = icmp ne i64 %t971, 0
  %t975 = and i1 %t973, %t974
  %t976 = zext i1 %t975 to i64
  %t977 = icmp ne i64 %t976, 0
  br i1 %t977, label %L203, label %L205
L203:
  %t978 = load ptr, ptr %t960
  %t979 = call ptr @default_ptr_type()
  %t980 = call i64 @make_val(ptr %t978, ptr %t979)
  ret i64 %t980
L206:
  br label %L205
L205:
  %t981 = load i64, ptr %t656
  %t982 = icmp ne i64 %t981, 0
  br i1 %t982, label %L207, label %L209
L207:
  %t983 = load ptr, ptr %t960
  %t984 = call ptr @default_i64_type()
  %t985 = call i64 @make_val(ptr %t983, ptr %t984)
  ret i64 %t985
L210:
  br label %L209
L209:
  %t986 = load ptr, ptr %t960
  %t987 = call ptr @default_i64_type()
  %t988 = call i64 @make_val(ptr %t986, ptr %t987)
  ret i64 %t988
L211:
  br label %L12
L12:
  %t989 = alloca i64
  %t990 = load ptr, ptr %t1
  %t991 = sext i32 0 to i64
  %t992 = getelementptr i32, ptr %t990, i64 %t991
  %t993 = load i64, ptr %t992
  %t994 = call i64 @emit_expr(ptr %t0, i64 %t993)
  store i64 %t994, ptr %t989
  %t995 = alloca i64
  %t996 = call i32 @new_reg(ptr %t0)
  %t997 = sext i32 %t996 to i64
  store i64 %t997, ptr %t995
  %t998 = alloca i64
  %t999 = load ptr, ptr %t989
  %t1000 = call i32 @type_is_fp(ptr %t999)
  %t1001 = sext i32 %t1000 to i64
  store i64 %t1001, ptr %t998
  %t1002 = alloca ptr
  %t1003 = load i64, ptr %t998
  %t1005 = icmp eq i64 %t1003, 0
  %t1004 = zext i1 %t1005 to i64
  %t1006 = icmp ne i64 %t1004, 0
  br i1 %t1006, label %L212, label %L214
L212:
  %t1007 = load i64, ptr %t989
  %t1008 = load ptr, ptr %t1002
  %t1009 = call i32 @promote_to_i64(ptr %t0, i64 %t1007, ptr %t1008, i64 64)
  %t1010 = sext i32 %t1009 to i64
  br label %L214
L214:
  %t1011 = load ptr, ptr %t1
  %t1012 = ptrtoint ptr %t1011 to i64
  %t1013 = add i64 %t1012, 0
  switch i64 %t1013, label %L220 [
    i64 36, label %L216
    i64 54, label %L217
    i64 43, label %L218
    i64 35, label %L219
  ]
L216:
  %t1014 = load i64, ptr %t998
  %t1015 = icmp ne i64 %t1014, 0
  br i1 %t1015, label %L221, label %L222
L221:
  %t1016 = getelementptr [26 x i8], ptr @.str121, i64 0, i64 0
  %t1017 = load i64, ptr %t995
  %t1018 = load ptr, ptr %t989
  call void @emit(ptr %t0, ptr %t1016, i64 %t1017, ptr %t1018)
  br label %L223
L222:
  %t1020 = getelementptr [25 x i8], ptr @.str122, i64 0, i64 0
  %t1021 = load i64, ptr %t995
  %t1022 = load ptr, ptr %t1002
  call void @emit(ptr %t0, ptr %t1020, i64 %t1021, ptr %t1022)
  br label %L223
L223:
  br label %L215
L224:
  br label %L217
L217:
  %t1024 = alloca i64
  %t1025 = call i32 @new_reg(ptr %t0)
  %t1026 = sext i32 %t1025 to i64
  store i64 %t1026, ptr %t1024
  %t1027 = getelementptr [29 x i8], ptr @.str123, i64 0, i64 0
  %t1028 = load i64, ptr %t1024
  %t1029 = load ptr, ptr %t1002
  call void @emit(ptr %t0, ptr %t1027, i64 %t1028, ptr %t1029)
  %t1031 = getelementptr [32 x i8], ptr @.str124, i64 0, i64 0
  %t1032 = load i64, ptr %t995
  %t1033 = load i64, ptr %t1024
  call void @emit(ptr %t0, ptr %t1031, i64 %t1032, i64 %t1033)
  br label %L215
L225:
  br label %L218
L218:
  %t1035 = getelementptr [26 x i8], ptr @.str125, i64 0, i64 0
  %t1036 = load i64, ptr %t995
  %t1037 = load ptr, ptr %t1002
  call void @emit(ptr %t0, ptr %t1035, i64 %t1036, ptr %t1037)
  br label %L215
L226:
  br label %L219
L219:
  %t1039 = load i64, ptr %t989
  ret i64 %t1039
L227:
  br label %L215
L220:
  %t1040 = getelementptr [25 x i8], ptr @.str126, i64 0, i64 0
  %t1041 = load i64, ptr %t995
  %t1042 = load ptr, ptr %t1002
  call void @emit(ptr %t0, ptr %t1040, i64 %t1041, ptr %t1042)
  br label %L215
L215:
  %t1044 = alloca ptr
  %t1045 = load ptr, ptr %t1044
  %t1046 = getelementptr [6 x i8], ptr @.str127, i64 0, i64 0
  %t1047 = load i64, ptr %t995
  %t1048 = call i32 @snprintf(ptr %t1045, i64 8, ptr %t1046, i64 %t1047)
  %t1049 = sext i32 %t1048 to i64
  %t1050 = load ptr, ptr %t1044
  %t1051 = load i64, ptr %t998
  %t1052 = icmp ne i64 %t1051, 0
  br i1 %t1052, label %L228, label %L229
L228:
  %t1053 = load ptr, ptr %t989
  %t1054 = ptrtoint ptr %t1053 to i64
  br label %L230
L229:
  %t1055 = call ptr @default_i64_type()
  %t1056 = ptrtoint ptr %t1055 to i64
  br label %L230
L230:
  %t1057 = phi i64 [ %t1054, %L228 ], [ %t1056, %L229 ]
  %t1058 = call i64 @make_val(ptr %t1050, i64 %t1057)
  ret i64 %t1058
L231:
  br label %L13
L13:
  %t1059 = alloca i64
  %t1060 = load ptr, ptr %t1
  %t1061 = sext i32 1 to i64
  %t1062 = getelementptr i32, ptr %t1060, i64 %t1061
  %t1063 = load i64, ptr %t1062
  %t1064 = call i64 @emit_expr(ptr %t0, i64 %t1063)
  store i64 %t1064, ptr %t1059
  %t1065 = alloca ptr
  %t1066 = load ptr, ptr %t1
  %t1067 = sext i32 0 to i64
  %t1068 = getelementptr i32, ptr %t1066, i64 %t1067
  %t1069 = load i64, ptr %t1068
  %t1070 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1069)
  store ptr %t1070, ptr %t1065
  %t1071 = load ptr, ptr %t1065
  %t1072 = icmp ne ptr %t1071, null
  br i1 %t1072, label %L232, label %L234
L232:
  %t1073 = alloca ptr
  %t1074 = load i64, ptr %t1059
  %t1075 = call i32 @val_is_ptr(i64 %t1074)
  %t1076 = sext i32 %t1075 to i64
  %t1077 = icmp ne i64 %t1076, 0
  br i1 %t1077, label %L235, label %L236
L235:
  %t1078 = getelementptr [4 x i8], ptr @.str128, i64 0, i64 0
  store ptr %t1078, ptr %t1073
  br label %L237
L236:
  %t1079 = load ptr, ptr %t1059
  %t1080 = call i32 @type_is_fp(ptr %t1079)
  %t1081 = sext i32 %t1080 to i64
  %t1082 = icmp ne i64 %t1081, 0
  br i1 %t1082, label %L238, label %L239
L238:
  %t1083 = load ptr, ptr %t1059
  %t1084 = call ptr @llvm_type(ptr %t1083)
  store ptr %t1084, ptr %t1073
  br label %L240
L239:
  %t1085 = getelementptr [4 x i8], ptr @.str129, i64 0, i64 0
  store ptr %t1085, ptr %t1073
  br label %L240
L240:
  br label %L237
L237:
  %t1086 = alloca ptr
  %t1087 = load i64, ptr %t1059
  %t1088 = call i32 @val_is_ptr(i64 %t1087)
  %t1089 = sext i32 %t1088 to i64
  %t1091 = icmp eq i64 %t1089, 0
  %t1090 = zext i1 %t1091 to i64
  %t1092 = load i64, ptr %t1059
  %t1093 = call i32 @val_is_64bit(i64 %t1092)
  %t1094 = sext i32 %t1093 to i64
  %t1096 = icmp eq i64 %t1094, 0
  %t1095 = zext i1 %t1096 to i64
  %t1098 = icmp ne i64 %t1090, 0
  %t1099 = icmp ne i64 %t1095, 0
  %t1100 = and i1 %t1098, %t1099
  %t1101 = zext i1 %t1100 to i64
  %t1102 = load ptr, ptr %t1059
  %t1103 = call i32 @type_is_fp(ptr %t1102)
  %t1104 = sext i32 %t1103 to i64
  %t1106 = icmp eq i64 %t1104, 0
  %t1105 = zext i1 %t1106 to i64
  %t1108 = icmp ne i64 %t1101, 0
  %t1109 = icmp ne i64 %t1105, 0
  %t1110 = and i1 %t1108, %t1109
  %t1111 = zext i1 %t1110 to i64
  %t1112 = icmp ne i64 %t1111, 0
  br i1 %t1112, label %L241, label %L242
L241:
  %t1113 = alloca i64
  %t1114 = call i32 @new_reg(ptr %t0)
  %t1115 = sext i32 %t1114 to i64
  store i64 %t1115, ptr %t1113
  %t1116 = getelementptr [30 x i8], ptr @.str130, i64 0, i64 0
  %t1117 = load i64, ptr %t1113
  %t1118 = load ptr, ptr %t1059
  call void @emit(ptr %t0, ptr %t1116, i64 %t1117, ptr %t1118)
  %t1120 = load ptr, ptr %t1086
  %t1121 = getelementptr [6 x i8], ptr @.str131, i64 0, i64 0
  %t1122 = load i64, ptr %t1113
  %t1123 = call i32 @snprintf(ptr %t1120, i64 64, ptr %t1121, i64 %t1122)
  %t1124 = sext i32 %t1123 to i64
  br label %L243
L242:
  %t1125 = load ptr, ptr %t1086
  %t1126 = load ptr, ptr %t1059
  %t1127 = call ptr @strncpy(ptr %t1125, ptr %t1126, i64 63)
  %t1128 = load ptr, ptr %t1086
  %t1130 = sext i32 63 to i64
  %t1129 = getelementptr i8, ptr %t1128, i64 %t1130
  %t1131 = sext i32 0 to i64
  store i64 %t1131, ptr %t1129
  br label %L243
L243:
  %t1132 = getelementptr [23 x i8], ptr @.str132, i64 0, i64 0
  %t1133 = load ptr, ptr %t1073
  %t1134 = load ptr, ptr %t1086
  %t1135 = load ptr, ptr %t1065
  call void @emit(ptr %t0, ptr %t1132, ptr %t1133, ptr %t1134, ptr %t1135)
  %t1137 = load ptr, ptr %t1065
  %t1138 = call i32 @free(ptr %t1137)
  %t1139 = sext i32 %t1138 to i64
  br label %L234
L234:
  %t1140 = load i64, ptr %t1059
  ret i64 %t1140
L244:
  br label %L14
L14:
  %t1141 = alloca i64
  %t1142 = load ptr, ptr %t1
  %t1143 = sext i32 0 to i64
  %t1144 = getelementptr i32, ptr %t1142, i64 %t1143
  %t1145 = load i64, ptr %t1144
  %t1146 = call i64 @emit_expr(ptr %t0, i64 %t1145)
  store i64 %t1146, ptr %t1141
  %t1147 = alloca i64
  %t1148 = load ptr, ptr %t1
  %t1149 = sext i32 1 to i64
  %t1150 = getelementptr i32, ptr %t1148, i64 %t1149
  %t1151 = load i64, ptr %t1150
  %t1152 = call i64 @emit_expr(ptr %t0, i64 %t1151)
  store i64 %t1152, ptr %t1147
  %t1153 = alloca i64
  %t1154 = call i32 @new_reg(ptr %t0)
  %t1155 = sext i32 %t1154 to i64
  store i64 %t1155, ptr %t1153
  %t1156 = alloca i64
  %t1157 = load ptr, ptr %t1141
  %t1158 = call i32 @type_is_fp(ptr %t1157)
  %t1159 = sext i32 %t1158 to i64
  %t1160 = load ptr, ptr %t1147
  %t1161 = call i32 @type_is_fp(ptr %t1160)
  %t1162 = sext i32 %t1161 to i64
  %t1164 = icmp ne i64 %t1159, 0
  %t1165 = icmp ne i64 %t1162, 0
  %t1166 = or i1 %t1164, %t1165
  %t1167 = zext i1 %t1166 to i64
  store i64 %t1167, ptr %t1156
  %t1168 = alloca ptr
  %t1169 = load i64, ptr %t1156
  %t1170 = icmp ne i64 %t1169, 0
  br i1 %t1170, label %L245, label %L246
L245:
  %t1171 = getelementptr [7 x i8], ptr @.str133, i64 0, i64 0
  %t1172 = ptrtoint ptr %t1171 to i64
  br label %L247
L246:
  %t1173 = getelementptr [4 x i8], ptr @.str134, i64 0, i64 0
  %t1174 = ptrtoint ptr %t1173 to i64
  br label %L247
L247:
  %t1175 = phi i64 [ %t1172, %L245 ], [ %t1174, %L246 ]
  store i64 %t1175, ptr %t1168
  %t1176 = alloca ptr
  %t1177 = alloca ptr
  %t1178 = load i64, ptr %t1156
  %t1180 = icmp eq i64 %t1178, 0
  %t1179 = zext i1 %t1180 to i64
  %t1181 = icmp ne i64 %t1179, 0
  br i1 %t1181, label %L248, label %L249
L248:
  %t1182 = load i64, ptr %t1141
  %t1183 = load ptr, ptr %t1176
  %t1184 = call i32 @promote_to_i64(ptr %t0, i64 %t1182, ptr %t1183, i64 64)
  %t1185 = sext i32 %t1184 to i64
  %t1186 = load i64, ptr %t1147
  %t1187 = load ptr, ptr %t1177
  %t1188 = call i32 @promote_to_i64(ptr %t0, i64 %t1186, ptr %t1187, i64 64)
  %t1189 = sext i32 %t1188 to i64
  br label %L250
L249:
  %t1190 = load ptr, ptr %t1176
  %t1191 = load ptr, ptr %t1141
  %t1192 = call ptr @strncpy(ptr %t1190, ptr %t1191, i64 63)
  %t1193 = load ptr, ptr %t1176
  %t1195 = sext i32 63 to i64
  %t1194 = getelementptr i8, ptr %t1193, i64 %t1195
  %t1196 = sext i32 0 to i64
  store i64 %t1196, ptr %t1194
  %t1197 = load ptr, ptr %t1177
  %t1198 = load ptr, ptr %t1147
  %t1199 = call ptr @strncpy(ptr %t1197, ptr %t1198, i64 63)
  %t1200 = load ptr, ptr %t1177
  %t1202 = sext i32 63 to i64
  %t1201 = getelementptr i8, ptr %t1200, i64 %t1202
  %t1203 = sext i32 0 to i64
  store i64 %t1203, ptr %t1201
  br label %L250
L250:
  %t1204 = alloca ptr
  %t1205 = load ptr, ptr %t1
  %t1206 = ptrtoint ptr %t1205 to i64
  %t1207 = add i64 %t1206, 0
  switch i64 %t1207, label %L262 [
    i64 56, label %L252
    i64 57, label %L253
    i64 58, label %L254
    i64 59, label %L255
    i64 65, label %L256
    i64 60, label %L257
    i64 61, label %L258
    i64 62, label %L259
    i64 63, label %L260
    i64 64, label %L261
  ]
L252:
  %t1208 = load i64, ptr %t1156
  %t1209 = icmp ne i64 %t1208, 0
  br i1 %t1209, label %L263, label %L264
L263:
  %t1210 = getelementptr [5 x i8], ptr @.str135, i64 0, i64 0
  %t1211 = ptrtoint ptr %t1210 to i64
  br label %L265
L264:
  %t1212 = getelementptr [4 x i8], ptr @.str136, i64 0, i64 0
  %t1213 = ptrtoint ptr %t1212 to i64
  br label %L265
L265:
  %t1214 = phi i64 [ %t1211, %L263 ], [ %t1213, %L264 ]
  store i64 %t1214, ptr %t1204
  br label %L251
L266:
  br label %L253
L253:
  %t1215 = load i64, ptr %t1156
  %t1216 = icmp ne i64 %t1215, 0
  br i1 %t1216, label %L267, label %L268
L267:
  %t1217 = getelementptr [5 x i8], ptr @.str137, i64 0, i64 0
  %t1218 = ptrtoint ptr %t1217 to i64
  br label %L269
L268:
  %t1219 = getelementptr [4 x i8], ptr @.str138, i64 0, i64 0
  %t1220 = ptrtoint ptr %t1219 to i64
  br label %L269
L269:
  %t1221 = phi i64 [ %t1218, %L267 ], [ %t1220, %L268 ]
  store i64 %t1221, ptr %t1204
  br label %L251
L270:
  br label %L254
L254:
  %t1222 = load i64, ptr %t1156
  %t1223 = icmp ne i64 %t1222, 0
  br i1 %t1223, label %L271, label %L272
L271:
  %t1224 = getelementptr [5 x i8], ptr @.str139, i64 0, i64 0
  %t1225 = ptrtoint ptr %t1224 to i64
  br label %L273
L272:
  %t1226 = getelementptr [4 x i8], ptr @.str140, i64 0, i64 0
  %t1227 = ptrtoint ptr %t1226 to i64
  br label %L273
L273:
  %t1228 = phi i64 [ %t1225, %L271 ], [ %t1227, %L272 ]
  store i64 %t1228, ptr %t1204
  br label %L251
L274:
  br label %L255
L255:
  %t1229 = load i64, ptr %t1156
  %t1230 = icmp ne i64 %t1229, 0
  br i1 %t1230, label %L275, label %L276
L275:
  %t1231 = getelementptr [5 x i8], ptr @.str141, i64 0, i64 0
  %t1232 = ptrtoint ptr %t1231 to i64
  br label %L277
L276:
  %t1233 = getelementptr [5 x i8], ptr @.str142, i64 0, i64 0
  %t1234 = ptrtoint ptr %t1233 to i64
  br label %L277
L277:
  %t1235 = phi i64 [ %t1232, %L275 ], [ %t1234, %L276 ]
  store i64 %t1235, ptr %t1204
  br label %L251
L278:
  br label %L256
L256:
  %t1236 = getelementptr [5 x i8], ptr @.str143, i64 0, i64 0
  store ptr %t1236, ptr %t1204
  br label %L251
L279:
  br label %L257
L257:
  %t1237 = getelementptr [4 x i8], ptr @.str144, i64 0, i64 0
  store ptr %t1237, ptr %t1204
  br label %L251
L280:
  br label %L258
L258:
  %t1238 = getelementptr [3 x i8], ptr @.str145, i64 0, i64 0
  store ptr %t1238, ptr %t1204
  br label %L251
L281:
  br label %L259
L259:
  %t1239 = getelementptr [4 x i8], ptr @.str146, i64 0, i64 0
  store ptr %t1239, ptr %t1204
  br label %L251
L282:
  br label %L260
L260:
  %t1240 = getelementptr [4 x i8], ptr @.str147, i64 0, i64 0
  store ptr %t1240, ptr %t1204
  br label %L251
L283:
  br label %L261
L261:
  %t1241 = getelementptr [5 x i8], ptr @.str148, i64 0, i64 0
  store ptr %t1241, ptr %t1204
  br label %L251
L284:
  br label %L251
L262:
  %t1242 = getelementptr [4 x i8], ptr @.str149, i64 0, i64 0
  store ptr %t1242, ptr %t1204
  br label %L251
L251:
  %t1243 = getelementptr [24 x i8], ptr @.str150, i64 0, i64 0
  %t1244 = load i64, ptr %t1153
  %t1245 = load ptr, ptr %t1204
  %t1246 = load ptr, ptr %t1168
  %t1247 = load ptr, ptr %t1176
  %t1248 = load ptr, ptr %t1177
  call void @emit(ptr %t0, ptr %t1243, i64 %t1244, ptr %t1245, ptr %t1246, ptr %t1247, ptr %t1248)
  %t1250 = alloca ptr
  %t1251 = load ptr, ptr %t1
  %t1252 = sext i32 0 to i64
  %t1253 = getelementptr i32, ptr %t1251, i64 %t1252
  %t1254 = load i64, ptr %t1253
  %t1255 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1254)
  store ptr %t1255, ptr %t1250
  %t1256 = load ptr, ptr %t1250
  %t1257 = icmp ne ptr %t1256, null
  br i1 %t1257, label %L285, label %L287
L285:
  %t1258 = getelementptr [26 x i8], ptr @.str151, i64 0, i64 0
  %t1259 = load ptr, ptr %t1168
  %t1260 = load i64, ptr %t1153
  %t1261 = load ptr, ptr %t1250
  call void @emit(ptr %t0, ptr %t1258, ptr %t1259, i64 %t1260, ptr %t1261)
  %t1263 = load ptr, ptr %t1250
  %t1264 = call i32 @free(ptr %t1263)
  %t1265 = sext i32 %t1264 to i64
  br label %L287
L287:
  %t1266 = alloca ptr
  %t1267 = load ptr, ptr %t1266
  %t1268 = getelementptr [6 x i8], ptr @.str152, i64 0, i64 0
  %t1269 = load i64, ptr %t1153
  %t1270 = call i32 @snprintf(ptr %t1267, i64 8, ptr %t1268, i64 %t1269)
  %t1271 = sext i32 %t1270 to i64
  %t1272 = load ptr, ptr %t1266
  %t1273 = load i64, ptr %t1156
  %t1274 = icmp ne i64 %t1273, 0
  br i1 %t1274, label %L288, label %L289
L288:
  %t1275 = load ptr, ptr %t1141
  %t1276 = ptrtoint ptr %t1275 to i64
  br label %L290
L289:
  %t1277 = call ptr @default_i64_type()
  %t1278 = ptrtoint ptr %t1277 to i64
  br label %L290
L290:
  %t1279 = phi i64 [ %t1276, %L288 ], [ %t1278, %L289 ]
  %t1280 = call i64 @make_val(ptr %t1272, i64 %t1279)
  ret i64 %t1280
L291:
  br label %L15
L15:
  br label %L16
L16:
  %t1281 = alloca i64
  %t1282 = load ptr, ptr %t1
  %t1283 = sext i32 0 to i64
  %t1284 = getelementptr i32, ptr %t1282, i64 %t1283
  %t1285 = load i64, ptr %t1284
  %t1286 = call i64 @emit_expr(ptr %t0, i64 %t1285)
  store i64 %t1286, ptr %t1281
  %t1287 = alloca i64
  %t1288 = call i32 @new_reg(ptr %t0)
  %t1289 = sext i32 %t1288 to i64
  store i64 %t1289, ptr %t1287
  %t1290 = alloca ptr
  %t1291 = load ptr, ptr %t1
  %t1293 = ptrtoint ptr %t1291 to i64
  %t1294 = sext i32 38 to i64
  %t1292 = icmp eq i64 %t1293, %t1294
  %t1295 = zext i1 %t1292 to i64
  %t1296 = icmp ne i64 %t1295, 0
  br i1 %t1296, label %L292, label %L293
L292:
  %t1297 = getelementptr [4 x i8], ptr @.str153, i64 0, i64 0
  %t1298 = ptrtoint ptr %t1297 to i64
  br label %L294
L293:
  %t1299 = getelementptr [4 x i8], ptr @.str154, i64 0, i64 0
  %t1300 = ptrtoint ptr %t1299 to i64
  br label %L294
L294:
  %t1301 = phi i64 [ %t1298, %L292 ], [ %t1300, %L293 ]
  store i64 %t1301, ptr %t1290
  %t1302 = alloca ptr
  %t1303 = load i64, ptr %t1281
  %t1304 = load ptr, ptr %t1302
  %t1305 = call i32 @promote_to_i64(ptr %t0, i64 %t1303, ptr %t1304, i64 64)
  %t1306 = sext i32 %t1305 to i64
  %t1307 = getelementptr [24 x i8], ptr @.str155, i64 0, i64 0
  %t1308 = load i64, ptr %t1287
  %t1309 = load ptr, ptr %t1290
  %t1310 = load ptr, ptr %t1302
  call void @emit(ptr %t0, ptr %t1307, i64 %t1308, ptr %t1309, ptr %t1310)
  %t1312 = alloca ptr
  %t1313 = load ptr, ptr %t1
  %t1314 = sext i32 0 to i64
  %t1315 = getelementptr i32, ptr %t1313, i64 %t1314
  %t1316 = load i64, ptr %t1315
  %t1317 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1316)
  store ptr %t1317, ptr %t1312
  %t1318 = load ptr, ptr %t1312
  %t1319 = icmp ne ptr %t1318, null
  br i1 %t1319, label %L295, label %L297
L295:
  %t1320 = getelementptr [27 x i8], ptr @.str156, i64 0, i64 0
  %t1321 = load i64, ptr %t1287
  %t1322 = load ptr, ptr %t1312
  call void @emit(ptr %t0, ptr %t1320, i64 %t1321, ptr %t1322)
  %t1324 = load ptr, ptr %t1312
  %t1325 = call i32 @free(ptr %t1324)
  %t1326 = sext i32 %t1325 to i64
  br label %L297
L297:
  %t1327 = alloca ptr
  %t1328 = load ptr, ptr %t1327
  %t1329 = getelementptr [6 x i8], ptr @.str157, i64 0, i64 0
  %t1330 = load i64, ptr %t1287
  %t1331 = call i32 @snprintf(ptr %t1328, i64 8, ptr %t1329, i64 %t1330)
  %t1332 = sext i32 %t1331 to i64
  %t1333 = load ptr, ptr %t1327
  %t1334 = call ptr @default_i64_type()
  %t1335 = call i64 @make_val(ptr %t1333, ptr %t1334)
  ret i64 %t1335
L298:
  br label %L17
L17:
  br label %L18
L18:
  %t1336 = alloca i64
  %t1337 = load ptr, ptr %t1
  %t1338 = sext i32 0 to i64
  %t1339 = getelementptr i32, ptr %t1337, i64 %t1338
  %t1340 = load i64, ptr %t1339
  %t1341 = call i64 @emit_expr(ptr %t0, i64 %t1340)
  store i64 %t1341, ptr %t1336
  %t1342 = alloca i64
  %t1343 = call i32 @new_reg(ptr %t0)
  %t1344 = sext i32 %t1343 to i64
  store i64 %t1344, ptr %t1342
  %t1345 = alloca ptr
  %t1346 = load ptr, ptr %t1
  %t1348 = ptrtoint ptr %t1346 to i64
  %t1349 = sext i32 40 to i64
  %t1347 = icmp eq i64 %t1348, %t1349
  %t1350 = zext i1 %t1347 to i64
  %t1351 = icmp ne i64 %t1350, 0
  br i1 %t1351, label %L299, label %L300
L299:
  %t1352 = getelementptr [4 x i8], ptr @.str158, i64 0, i64 0
  %t1353 = ptrtoint ptr %t1352 to i64
  br label %L301
L300:
  %t1354 = getelementptr [4 x i8], ptr @.str159, i64 0, i64 0
  %t1355 = ptrtoint ptr %t1354 to i64
  br label %L301
L301:
  %t1356 = phi i64 [ %t1353, %L299 ], [ %t1355, %L300 ]
  store i64 %t1356, ptr %t1345
  %t1357 = alloca ptr
  %t1358 = load i64, ptr %t1336
  %t1359 = load ptr, ptr %t1357
  %t1360 = call i32 @promote_to_i64(ptr %t0, i64 %t1358, ptr %t1359, i64 64)
  %t1361 = sext i32 %t1360 to i64
  %t1362 = getelementptr [24 x i8], ptr @.str160, i64 0, i64 0
  %t1363 = load i64, ptr %t1342
  %t1364 = load ptr, ptr %t1345
  %t1365 = load ptr, ptr %t1357
  call void @emit(ptr %t0, ptr %t1362, i64 %t1363, ptr %t1364, ptr %t1365)
  %t1367 = alloca ptr
  %t1368 = load ptr, ptr %t1
  %t1369 = sext i32 0 to i64
  %t1370 = getelementptr i32, ptr %t1368, i64 %t1369
  %t1371 = load i64, ptr %t1370
  %t1372 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1371)
  store ptr %t1372, ptr %t1367
  %t1373 = load ptr, ptr %t1367
  %t1374 = icmp ne ptr %t1373, null
  br i1 %t1374, label %L302, label %L304
L302:
  %t1375 = getelementptr [27 x i8], ptr @.str161, i64 0, i64 0
  %t1376 = load i64, ptr %t1342
  %t1377 = load ptr, ptr %t1367
  call void @emit(ptr %t0, ptr %t1375, i64 %t1376, ptr %t1377)
  %t1379 = load ptr, ptr %t1367
  %t1380 = call i32 @free(ptr %t1379)
  %t1381 = sext i32 %t1380 to i64
  br label %L304
L304:
  %t1382 = load i64, ptr %t1336
  ret i64 %t1382
L305:
  br label %L19
L19:
  %t1383 = alloca ptr
  %t1384 = load ptr, ptr %t1
  %t1385 = sext i32 0 to i64
  %t1386 = getelementptr i32, ptr %t1384, i64 %t1385
  %t1387 = load i64, ptr %t1386
  %t1388 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1387)
  store ptr %t1388, ptr %t1383
  %t1389 = load ptr, ptr %t1383
  %t1391 = ptrtoint ptr %t1389 to i64
  %t1392 = icmp eq i64 %t1391, 0
  %t1390 = zext i1 %t1392 to i64
  %t1393 = icmp ne i64 %t1390, 0
  br i1 %t1393, label %L306, label %L308
L306:
  %t1394 = getelementptr [5 x i8], ptr @.str162, i64 0, i64 0
  %t1395 = call ptr @default_ptr_type()
  %t1396 = call i64 @make_val(ptr %t1394, ptr %t1395)
  ret i64 %t1396
L309:
  br label %L308
L308:
  %t1397 = alloca i64
  %t1398 = load ptr, ptr %t1383
  %t1399 = call ptr @default_ptr_type()
  %t1400 = call i64 @make_val(ptr %t1398, ptr %t1399)
  store i64 %t1400, ptr %t1397
  %t1401 = load ptr, ptr %t1383
  %t1402 = call i32 @free(ptr %t1401)
  %t1403 = sext i32 %t1402 to i64
  %t1404 = load i64, ptr %t1397
  ret i64 %t1404
L310:
  br label %L20
L20:
  %t1405 = alloca i64
  %t1406 = load ptr, ptr %t1
  %t1407 = sext i32 0 to i64
  %t1408 = getelementptr i32, ptr %t1406, i64 %t1407
  %t1409 = load i64, ptr %t1408
  %t1410 = call i64 @emit_expr(ptr %t0, i64 %t1409)
  store i64 %t1410, ptr %t1405
  %t1411 = alloca i64
  %t1412 = call i32 @new_reg(ptr %t0)
  %t1413 = sext i32 %t1412 to i64
  store i64 %t1413, ptr %t1411
  %t1414 = alloca ptr
  %t1415 = load i64, ptr %t1405
  %t1416 = call i32 @val_is_ptr(i64 %t1415)
  %t1417 = sext i32 %t1416 to i64
  %t1418 = icmp ne i64 %t1417, 0
  br i1 %t1418, label %L311, label %L312
L311:
  %t1419 = load ptr, ptr %t1414
  %t1420 = load ptr, ptr %t1405
  %t1421 = call ptr @strncpy(ptr %t1419, ptr %t1420, i64 63)
  %t1422 = load ptr, ptr %t1414
  %t1424 = sext i32 63 to i64
  %t1423 = getelementptr i8, ptr %t1422, i64 %t1424
  %t1425 = sext i32 0 to i64
  store i64 %t1425, ptr %t1423
  br label %L313
L312:
  %t1426 = alloca i64
  %t1427 = call i32 @new_reg(ptr %t0)
  %t1428 = sext i32 %t1427 to i64
  store i64 %t1428, ptr %t1426
  %t1429 = getelementptr [34 x i8], ptr @.str163, i64 0, i64 0
  %t1430 = load i64, ptr %t1426
  %t1431 = load ptr, ptr %t1405
  call void @emit(ptr %t0, ptr %t1429, i64 %t1430, ptr %t1431)
  %t1433 = load ptr, ptr %t1414
  %t1434 = getelementptr [6 x i8], ptr @.str164, i64 0, i64 0
  %t1435 = load i64, ptr %t1426
  %t1436 = call i32 @snprintf(ptr %t1433, i64 64, ptr %t1434, i64 %t1435)
  %t1437 = sext i32 %t1436 to i64
  br label %L313
L313:
  %t1438 = alloca ptr
  %t1439 = load ptr, ptr %t1405
  %t1440 = load ptr, ptr %t1405
  %t1441 = load ptr, ptr %t1440
  %t1443 = ptrtoint ptr %t1439 to i64
  %t1444 = ptrtoint ptr %t1441 to i64
  %t1448 = ptrtoint ptr %t1439 to i64
  %t1449 = ptrtoint ptr %t1441 to i64
  %t1445 = icmp ne i64 %t1448, 0
  %t1446 = icmp ne i64 %t1449, 0
  %t1447 = and i1 %t1445, %t1446
  %t1450 = zext i1 %t1447 to i64
  %t1451 = icmp ne i64 %t1450, 0
  br i1 %t1451, label %L314, label %L315
L314:
  %t1452 = load ptr, ptr %t1405
  %t1453 = load ptr, ptr %t1452
  %t1454 = ptrtoint ptr %t1453 to i64
  br label %L316
L315:
  %t1455 = call ptr @default_int_type()
  %t1456 = ptrtoint ptr %t1455 to i64
  br label %L316
L316:
  %t1457 = phi i64 [ %t1454, %L314 ], [ %t1456, %L315 ]
  store i64 %t1457, ptr %t1438
  %t1458 = alloca i64
  %t1459 = load ptr, ptr %t1438
  %t1460 = load ptr, ptr %t1459
  %t1462 = ptrtoint ptr %t1460 to i64
  %t1463 = sext i32 15 to i64
  %t1461 = icmp eq i64 %t1462, %t1463
  %t1464 = zext i1 %t1461 to i64
  %t1465 = load ptr, ptr %t1438
  %t1466 = load ptr, ptr %t1465
  %t1468 = ptrtoint ptr %t1466 to i64
  %t1469 = sext i32 16 to i64
  %t1467 = icmp eq i64 %t1468, %t1469
  %t1470 = zext i1 %t1467 to i64
  %t1472 = icmp ne i64 %t1464, 0
  %t1473 = icmp ne i64 %t1470, 0
  %t1474 = or i1 %t1472, %t1473
  %t1475 = zext i1 %t1474 to i64
  store i64 %t1475, ptr %t1458
  %t1476 = alloca ptr
  %t1477 = load i64, ptr %t1458
  %t1478 = icmp ne i64 %t1477, 0
  br i1 %t1478, label %L317, label %L318
L317:
  %t1479 = getelementptr [4 x i8], ptr @.str165, i64 0, i64 0
  %t1480 = ptrtoint ptr %t1479 to i64
  br label %L319
L318:
  %t1481 = getelementptr [4 x i8], ptr @.str166, i64 0, i64 0
  %t1482 = ptrtoint ptr %t1481 to i64
  br label %L319
L319:
  %t1483 = phi i64 [ %t1480, %L317 ], [ %t1482, %L318 ]
  store i64 %t1483, ptr %t1476
  %t1484 = alloca ptr
  %t1485 = load i64, ptr %t1458
  %t1486 = icmp ne i64 %t1485, 0
  br i1 %t1486, label %L320, label %L321
L320:
  %t1487 = call ptr @default_ptr_type()
  %t1488 = ptrtoint ptr %t1487 to i64
  br label %L322
L321:
  %t1489 = call ptr @default_i64_type()
  %t1490 = ptrtoint ptr %t1489 to i64
  br label %L322
L322:
  %t1491 = phi i64 [ %t1488, %L320 ], [ %t1490, %L321 ]
  store i64 %t1491, ptr %t1484
  %t1492 = getelementptr [27 x i8], ptr @.str167, i64 0, i64 0
  %t1493 = load i64, ptr %t1411
  %t1494 = load ptr, ptr %t1476
  %t1495 = load ptr, ptr %t1414
  call void @emit(ptr %t0, ptr %t1492, i64 %t1493, ptr %t1494, ptr %t1495)
  %t1497 = alloca ptr
  %t1498 = load ptr, ptr %t1497
  %t1499 = getelementptr [6 x i8], ptr @.str168, i64 0, i64 0
  %t1500 = load i64, ptr %t1411
  %t1501 = call i32 @snprintf(ptr %t1498, i64 8, ptr %t1499, i64 %t1500)
  %t1502 = sext i32 %t1501 to i64
  %t1503 = load ptr, ptr %t1497
  %t1504 = load ptr, ptr %t1484
  %t1505 = call i64 @make_val(ptr %t1503, ptr %t1504)
  ret i64 %t1505
L323:
  br label %L21
L21:
  %t1506 = alloca i64
  %t1507 = load ptr, ptr %t1
  %t1508 = sext i32 0 to i64
  %t1509 = getelementptr i32, ptr %t1507, i64 %t1508
  %t1510 = load i64, ptr %t1509
  %t1511 = call i64 @emit_expr(ptr %t0, i64 %t1510)
  store i64 %t1511, ptr %t1506
  %t1512 = alloca i64
  %t1513 = load ptr, ptr %t1
  %t1514 = sext i32 1 to i64
  %t1515 = getelementptr i32, ptr %t1513, i64 %t1514
  %t1516 = load i64, ptr %t1515
  %t1517 = call i64 @emit_expr(ptr %t0, i64 %t1516)
  store i64 %t1517, ptr %t1512
  %t1518 = alloca ptr
  %t1519 = load ptr, ptr %t1506
  %t1520 = load ptr, ptr %t1506
  %t1521 = load ptr, ptr %t1520
  %t1523 = ptrtoint ptr %t1519 to i64
  %t1524 = ptrtoint ptr %t1521 to i64
  %t1528 = ptrtoint ptr %t1519 to i64
  %t1529 = ptrtoint ptr %t1521 to i64
  %t1525 = icmp ne i64 %t1528, 0
  %t1526 = icmp ne i64 %t1529, 0
  %t1527 = and i1 %t1525, %t1526
  %t1530 = zext i1 %t1527 to i64
  %t1531 = icmp ne i64 %t1530, 0
  br i1 %t1531, label %L324, label %L325
L324:
  %t1532 = load ptr, ptr %t1506
  %t1533 = load ptr, ptr %t1532
  %t1534 = ptrtoint ptr %t1533 to i64
  br label %L326
L325:
  %t1535 = call ptr @default_int_type()
  %t1536 = ptrtoint ptr %t1535 to i64
  br label %L326
L326:
  %t1537 = phi i64 [ %t1534, %L324 ], [ %t1536, %L325 ]
  store i64 %t1537, ptr %t1518
  %t1538 = alloca ptr
  %t1539 = alloca ptr
  %t1540 = load i64, ptr %t1506
  %t1541 = call i32 @val_is_ptr(i64 %t1540)
  %t1542 = sext i32 %t1541 to i64
  %t1543 = icmp ne i64 %t1542, 0
  br i1 %t1543, label %L327, label %L328
L327:
  %t1544 = load ptr, ptr %t1538
  %t1545 = load ptr, ptr %t1506
  %t1546 = call ptr @strncpy(ptr %t1544, ptr %t1545, i64 63)
  br label %L329
L328:
  %t1547 = alloca i64
  %t1548 = call i32 @new_reg(ptr %t0)
  %t1549 = sext i32 %t1548 to i64
  store i64 %t1549, ptr %t1547
  %t1550 = getelementptr [34 x i8], ptr @.str169, i64 0, i64 0
  %t1551 = load i64, ptr %t1547
  %t1552 = load ptr, ptr %t1506
  call void @emit(ptr %t0, ptr %t1550, i64 %t1551, ptr %t1552)
  %t1554 = load ptr, ptr %t1538
  %t1555 = getelementptr [6 x i8], ptr @.str170, i64 0, i64 0
  %t1556 = load i64, ptr %t1547
  %t1557 = call i32 @snprintf(ptr %t1554, i64 64, ptr %t1555, i64 %t1556)
  %t1558 = sext i32 %t1557 to i64
  br label %L329
L329:
  %t1559 = load i64, ptr %t1512
  %t1560 = load ptr, ptr %t1539
  %t1561 = call i32 @promote_to_i64(ptr %t0, i64 %t1559, ptr %t1560, i64 64)
  %t1562 = sext i32 %t1561 to i64
  %t1563 = load ptr, ptr %t1538
  %t1565 = sext i32 63 to i64
  %t1564 = getelementptr i8, ptr %t1563, i64 %t1565
  %t1566 = sext i32 0 to i64
  store i64 %t1566, ptr %t1564
  %t1567 = alloca i64
  %t1568 = call i32 @new_reg(ptr %t0)
  %t1569 = sext i32 %t1568 to i64
  store i64 %t1569, ptr %t1567
  %t1570 = getelementptr [44 x i8], ptr @.str171, i64 0, i64 0
  %t1571 = load i64, ptr %t1567
  %t1572 = load ptr, ptr %t1518
  %t1573 = call ptr @llvm_type(ptr %t1572)
  %t1574 = load ptr, ptr %t1538
  %t1575 = load ptr, ptr %t1539
  call void @emit(ptr %t0, ptr %t1570, i64 %t1571, ptr %t1573, ptr %t1574, ptr %t1575)
  %t1577 = alloca i64
  %t1578 = call i32 @new_reg(ptr %t0)
  %t1579 = sext i32 %t1578 to i64
  store i64 %t1579, ptr %t1577
  %t1580 = alloca i64
  %t1581 = load ptr, ptr %t1518
  %t1582 = load ptr, ptr %t1518
  %t1583 = load ptr, ptr %t1582
  %t1585 = ptrtoint ptr %t1583 to i64
  %t1586 = sext i32 15 to i64
  %t1584 = icmp eq i64 %t1585, %t1586
  %t1587 = zext i1 %t1584 to i64
  %t1588 = load ptr, ptr %t1518
  %t1589 = load ptr, ptr %t1588
  %t1591 = ptrtoint ptr %t1589 to i64
  %t1592 = sext i32 16 to i64
  %t1590 = icmp eq i64 %t1591, %t1592
  %t1593 = zext i1 %t1590 to i64
  %t1595 = icmp ne i64 %t1587, 0
  %t1596 = icmp ne i64 %t1593, 0
  %t1597 = or i1 %t1595, %t1596
  %t1598 = zext i1 %t1597 to i64
  %t1600 = ptrtoint ptr %t1581 to i64
  %t1604 = ptrtoint ptr %t1581 to i64
  %t1601 = icmp ne i64 %t1604, 0
  %t1602 = icmp ne i64 %t1598, 0
  %t1603 = and i1 %t1601, %t1602
  %t1605 = zext i1 %t1603 to i64
  store i64 %t1605, ptr %t1580
  %t1606 = alloca i64
  %t1607 = load ptr, ptr %t1518
  %t1608 = load ptr, ptr %t1518
  %t1609 = call i32 @type_is_fp(ptr %t1608)
  %t1610 = sext i32 %t1609 to i64
  %t1612 = ptrtoint ptr %t1607 to i64
  %t1616 = ptrtoint ptr %t1607 to i64
  %t1613 = icmp ne i64 %t1616, 0
  %t1614 = icmp ne i64 %t1610, 0
  %t1615 = and i1 %t1613, %t1614
  %t1617 = zext i1 %t1615 to i64
  store i64 %t1617, ptr %t1606
  %t1618 = alloca ptr
  %t1619 = alloca ptr
  %t1620 = load i64, ptr %t1580
  %t1621 = icmp ne i64 %t1620, 0
  br i1 %t1621, label %L330, label %L331
L330:
  %t1622 = getelementptr [4 x i8], ptr @.str172, i64 0, i64 0
  store ptr %t1622, ptr %t1618
  %t1623 = call ptr @default_ptr_type()
  store ptr %t1623, ptr %t1619
  br label %L332
L331:
  %t1624 = load i64, ptr %t1606
  %t1625 = icmp ne i64 %t1624, 0
  br i1 %t1625, label %L333, label %L334
L333:
  %t1626 = load ptr, ptr %t1518
  %t1627 = call ptr @llvm_type(ptr %t1626)
  store ptr %t1627, ptr %t1618
  %t1628 = load ptr, ptr %t1518
  store ptr %t1628, ptr %t1619
  br label %L335
L334:
  %t1629 = getelementptr [4 x i8], ptr @.str173, i64 0, i64 0
  store ptr %t1629, ptr %t1618
  %t1630 = call ptr @default_i64_type()
  store ptr %t1630, ptr %t1619
  br label %L335
L335:
  br label %L332
L332:
  %t1631 = getelementptr [30 x i8], ptr @.str174, i64 0, i64 0
  %t1632 = load i64, ptr %t1577
  %t1633 = load ptr, ptr %t1618
  %t1634 = load i64, ptr %t1567
  call void @emit(ptr %t0, ptr %t1631, i64 %t1632, ptr %t1633, i64 %t1634)
  %t1636 = alloca ptr
  %t1637 = load ptr, ptr %t1636
  %t1638 = getelementptr [6 x i8], ptr @.str175, i64 0, i64 0
  %t1639 = load i64, ptr %t1577
  %t1640 = call i32 @snprintf(ptr %t1637, i64 8, ptr %t1638, i64 %t1639)
  %t1641 = sext i32 %t1640 to i64
  %t1642 = load ptr, ptr %t1636
  %t1643 = load ptr, ptr %t1619
  %t1644 = call i64 @make_val(ptr %t1642, ptr %t1643)
  ret i64 %t1644
L336:
  br label %L22
L22:
  %t1645 = alloca i64
  %t1646 = load ptr, ptr %t1
  %t1647 = call i64 @emit_expr(ptr %t0, ptr %t1646)
  store i64 %t1647, ptr %t1645
  %t1648 = alloca ptr
  %t1649 = load ptr, ptr %t1
  store ptr %t1649, ptr %t1648
  %t1650 = load ptr, ptr %t1648
  %t1652 = ptrtoint ptr %t1650 to i64
  %t1653 = icmp eq i64 %t1652, 0
  %t1651 = zext i1 %t1653 to i64
  %t1654 = icmp ne i64 %t1651, 0
  br i1 %t1654, label %L337, label %L339
L337:
  %t1655 = load i64, ptr %t1645
  ret i64 %t1655
L340:
  br label %L339
L339:
  %t1656 = alloca i64
  %t1657 = call i32 @new_reg(ptr %t0)
  %t1658 = sext i32 %t1657 to i64
  store i64 %t1658, ptr %t1656
  %t1659 = alloca i64
  %t1660 = load ptr, ptr %t1645
  %t1661 = call i32 @type_is_fp(ptr %t1660)
  %t1662 = sext i32 %t1661 to i64
  store i64 %t1662, ptr %t1659
  %t1663 = alloca i64
  %t1664 = load ptr, ptr %t1648
  %t1665 = call i32 @type_is_fp(ptr %t1664)
  %t1666 = sext i32 %t1665 to i64
  store i64 %t1666, ptr %t1663
  %t1667 = alloca i64
  %t1668 = load ptr, ptr %t1648
  %t1669 = load ptr, ptr %t1668
  %t1671 = ptrtoint ptr %t1669 to i64
  %t1672 = sext i32 15 to i64
  %t1670 = icmp eq i64 %t1671, %t1672
  %t1673 = zext i1 %t1670 to i64
  %t1674 = load ptr, ptr %t1648
  %t1675 = load ptr, ptr %t1674
  %t1677 = ptrtoint ptr %t1675 to i64
  %t1678 = sext i32 16 to i64
  %t1676 = icmp eq i64 %t1677, %t1678
  %t1679 = zext i1 %t1676 to i64
  %t1681 = icmp ne i64 %t1673, 0
  %t1682 = icmp ne i64 %t1679, 0
  %t1683 = or i1 %t1681, %t1682
  %t1684 = zext i1 %t1683 to i64
  store i64 %t1684, ptr %t1667
  %t1685 = alloca i64
  %t1686 = load i64, ptr %t1645
  %t1687 = call i32 @val_is_ptr(i64 %t1686)
  %t1688 = sext i32 %t1687 to i64
  store i64 %t1688, ptr %t1685
  %t1689 = load i64, ptr %t1659
  %t1690 = load i64, ptr %t1663
  %t1692 = icmp ne i64 %t1689, 0
  %t1693 = icmp ne i64 %t1690, 0
  %t1694 = and i1 %t1692, %t1693
  %t1695 = zext i1 %t1694 to i64
  %t1696 = icmp ne i64 %t1695, 0
  br i1 %t1696, label %L341, label %L342
L341:
  %t1697 = alloca i64
  %t1698 = load ptr, ptr %t1645
  %t1699 = call i32 @type_size(ptr %t1698)
  %t1700 = sext i32 %t1699 to i64
  store i64 %t1700, ptr %t1697
  %t1701 = alloca i64
  %t1702 = load ptr, ptr %t1648
  %t1703 = call i32 @type_size(ptr %t1702)
  %t1704 = sext i32 %t1703 to i64
  store i64 %t1704, ptr %t1701
  %t1705 = load i64, ptr %t1701
  %t1706 = load i64, ptr %t1697
  %t1707 = icmp sgt i64 %t1705, %t1706
  %t1708 = zext i1 %t1707 to i64
  %t1709 = icmp ne i64 %t1708, 0
  br i1 %t1709, label %L344, label %L345
L344:
  %t1710 = getelementptr [36 x i8], ptr @.str176, i64 0, i64 0
  %t1711 = load i64, ptr %t1656
  %t1712 = load ptr, ptr %t1645
  call void @emit(ptr %t0, ptr %t1710, i64 %t1711, ptr %t1712)
  br label %L346
L345:
  %t1714 = getelementptr [38 x i8], ptr @.str177, i64 0, i64 0
  %t1715 = load i64, ptr %t1656
  %t1716 = load ptr, ptr %t1645
  call void @emit(ptr %t0, ptr %t1714, i64 %t1715, ptr %t1716)
  br label %L346
L346:
  br label %L343
L342:
  %t1718 = load i64, ptr %t1659
  %t1719 = load i64, ptr %t1663
  %t1721 = icmp eq i64 %t1719, 0
  %t1720 = zext i1 %t1721 to i64
  %t1723 = icmp ne i64 %t1718, 0
  %t1724 = icmp ne i64 %t1720, 0
  %t1725 = and i1 %t1723, %t1724
  %t1726 = zext i1 %t1725 to i64
  %t1727 = icmp ne i64 %t1726, 0
  br i1 %t1727, label %L347, label %L348
L347:
  %t1728 = getelementptr [35 x i8], ptr @.str178, i64 0, i64 0
  %t1729 = load i64, ptr %t1656
  %t1730 = load ptr, ptr %t1645
  call void @emit(ptr %t0, ptr %t1728, i64 %t1729, ptr %t1730)
  br label %L349
L348:
  %t1732 = load i64, ptr %t1659
  %t1734 = icmp eq i64 %t1732, 0
  %t1733 = zext i1 %t1734 to i64
  %t1735 = load i64, ptr %t1663
  %t1737 = icmp ne i64 %t1733, 0
  %t1738 = icmp ne i64 %t1735, 0
  %t1739 = and i1 %t1737, %t1738
  %t1740 = zext i1 %t1739 to i64
  %t1741 = icmp ne i64 %t1740, 0
  br i1 %t1741, label %L350, label %L351
L350:
  %t1742 = alloca ptr
  %t1743 = load i64, ptr %t1645
  %t1744 = load ptr, ptr %t1742
  %t1745 = call i32 @promote_to_i64(ptr %t0, i64 %t1743, ptr %t1744, i64 64)
  %t1746 = sext i32 %t1745 to i64
  %t1747 = getelementptr [31 x i8], ptr @.str179, i64 0, i64 0
  %t1748 = load i64, ptr %t1656
  %t1749 = load ptr, ptr %t1742
  %t1750 = load ptr, ptr %t1648
  %t1751 = call ptr @llvm_type(ptr %t1750)
  call void @emit(ptr %t0, ptr %t1747, i64 %t1748, ptr %t1749, ptr %t1751)
  br label %L352
L351:
  %t1753 = load i64, ptr %t1667
  %t1754 = load i64, ptr %t1685
  %t1756 = icmp eq i64 %t1754, 0
  %t1755 = zext i1 %t1756 to i64
  %t1758 = icmp ne i64 %t1753, 0
  %t1759 = icmp ne i64 %t1755, 0
  %t1760 = and i1 %t1758, %t1759
  %t1761 = zext i1 %t1760 to i64
  %t1762 = icmp ne i64 %t1761, 0
  br i1 %t1762, label %L353, label %L354
L353:
  %t1763 = alloca ptr
  %t1764 = load i64, ptr %t1645
  %t1765 = load ptr, ptr %t1763
  %t1766 = call i32 @promote_to_i64(ptr %t0, i64 %t1764, ptr %t1765, i64 64)
  %t1767 = sext i32 %t1766 to i64
  %t1768 = getelementptr [34 x i8], ptr @.str180, i64 0, i64 0
  %t1769 = load i64, ptr %t1656
  %t1770 = load ptr, ptr %t1763
  call void @emit(ptr %t0, ptr %t1768, i64 %t1769, ptr %t1770)
  br label %L355
L354:
  %t1772 = load i64, ptr %t1667
  %t1774 = icmp eq i64 %t1772, 0
  %t1773 = zext i1 %t1774 to i64
  %t1775 = load i64, ptr %t1685
  %t1777 = icmp ne i64 %t1773, 0
  %t1778 = icmp ne i64 %t1775, 0
  %t1779 = and i1 %t1777, %t1778
  %t1780 = zext i1 %t1779 to i64
  %t1781 = icmp ne i64 %t1780, 0
  br i1 %t1781, label %L356, label %L357
L356:
  %t1782 = getelementptr [34 x i8], ptr @.str181, i64 0, i64 0
  %t1783 = load i64, ptr %t1656
  %t1784 = load ptr, ptr %t1645
  call void @emit(ptr %t0, ptr %t1782, i64 %t1783, ptr %t1784)
  br label %L358
L357:
  %t1786 = load i64, ptr %t1667
  %t1787 = load i64, ptr %t1685
  %t1789 = icmp ne i64 %t1786, 0
  %t1790 = icmp ne i64 %t1787, 0
  %t1791 = and i1 %t1789, %t1790
  %t1792 = zext i1 %t1791 to i64
  %t1793 = icmp ne i64 %t1792, 0
  br i1 %t1793, label %L359, label %L360
L359:
  %t1794 = getelementptr [33 x i8], ptr @.str182, i64 0, i64 0
  %t1795 = load i64, ptr %t1656
  %t1796 = load ptr, ptr %t1645
  call void @emit(ptr %t0, ptr %t1794, i64 %t1795, ptr %t1796)
  br label %L361
L360:
  %t1798 = alloca ptr
  %t1799 = load i64, ptr %t1645
  %t1800 = load ptr, ptr %t1798
  %t1801 = call i32 @promote_to_i64(ptr %t0, i64 %t1799, ptr %t1800, i64 64)
  %t1802 = sext i32 %t1801 to i64
  %t1803 = getelementptr [25 x i8], ptr @.str183, i64 0, i64 0
  %t1804 = load i64, ptr %t1656
  %t1805 = load ptr, ptr %t1798
  call void @emit(ptr %t0, ptr %t1803, i64 %t1804, ptr %t1805)
  br label %L361
L361:
  br label %L358
L358:
  br label %L355
L355:
  br label %L352
L352:
  br label %L349
L349:
  br label %L343
L343:
  %t1807 = alloca ptr
  %t1808 = load ptr, ptr %t1807
  %t1809 = getelementptr [6 x i8], ptr @.str184, i64 0, i64 0
  %t1810 = load i64, ptr %t1656
  %t1811 = call i32 @snprintf(ptr %t1808, i64 8, ptr %t1809, i64 %t1810)
  %t1812 = sext i32 %t1811 to i64
  %t1813 = load i64, ptr %t1667
  %t1814 = icmp ne i64 %t1813, 0
  br i1 %t1814, label %L362, label %L364
L362:
  %t1815 = load ptr, ptr %t1807
  %t1816 = call ptr @default_ptr_type()
  %t1817 = call i64 @make_val(ptr %t1815, ptr %t1816)
  ret i64 %t1817
L365:
  br label %L364
L364:
  %t1818 = load i64, ptr %t1663
  %t1819 = icmp ne i64 %t1818, 0
  br i1 %t1819, label %L366, label %L368
L366:
  %t1820 = load ptr, ptr %t1807
  %t1821 = load ptr, ptr %t1648
  %t1822 = call i64 @make_val(ptr %t1820, ptr %t1821)
  ret i64 %t1822
L369:
  br label %L368
L368:
  %t1823 = load ptr, ptr %t1807
  %t1824 = call ptr @default_i64_type()
  %t1825 = call i64 @make_val(ptr %t1823, ptr %t1824)
  ret i64 %t1825
L370:
  br label %L23
L23:
  %t1826 = alloca i64
  %t1827 = load ptr, ptr %t1
  %t1828 = call i64 @emit_expr(ptr %t0, ptr %t1827)
  store i64 %t1828, ptr %t1826
  %t1829 = alloca i64
  %t1830 = call i32 @new_label(ptr %t0)
  %t1831 = sext i32 %t1830 to i64
  store i64 %t1831, ptr %t1829
  %t1832 = alloca i64
  %t1833 = call i32 @new_label(ptr %t0)
  %t1834 = sext i32 %t1833 to i64
  store i64 %t1834, ptr %t1832
  %t1835 = alloca i64
  %t1836 = call i32 @new_label(ptr %t0)
  %t1837 = sext i32 %t1836 to i64
  store i64 %t1837, ptr %t1835
  %t1838 = alloca i64
  %t1839 = load i64, ptr %t1826
  %t1840 = call i32 @emit_cond(ptr %t0, i64 %t1839)
  %t1841 = sext i32 %t1840 to i64
  store i64 %t1841, ptr %t1838
  %t1842 = getelementptr [41 x i8], ptr @.str185, i64 0, i64 0
  %t1843 = load i64, ptr %t1838
  %t1844 = load i64, ptr %t1829
  %t1845 = load i64, ptr %t1832
  call void @emit(ptr %t0, ptr %t1842, i64 %t1843, i64 %t1844, i64 %t1845)
  %t1847 = getelementptr [6 x i8], ptr @.str186, i64 0, i64 0
  %t1848 = load i64, ptr %t1829
  call void @emit(ptr %t0, ptr %t1847, i64 %t1848)
  %t1850 = alloca i64
  %t1851 = load ptr, ptr %t1
  %t1852 = sext i32 0 to i64
  %t1853 = getelementptr i32, ptr %t1851, i64 %t1852
  %t1854 = load i64, ptr %t1853
  %t1855 = call i64 @emit_expr(ptr %t0, i64 %t1854)
  store i64 %t1855, ptr %t1850
  %t1856 = alloca ptr
  %t1857 = load i64, ptr %t1850
  %t1858 = load ptr, ptr %t1856
  %t1859 = call i32 @promote_to_i64(ptr %t0, i64 %t1857, ptr %t1858, i64 64)
  %t1860 = sext i32 %t1859 to i64
  %t1861 = getelementptr [18 x i8], ptr @.str187, i64 0, i64 0
  %t1862 = load i64, ptr %t1835
  call void @emit(ptr %t0, ptr %t1861, i64 %t1862)
  %t1864 = getelementptr [6 x i8], ptr @.str188, i64 0, i64 0
  %t1865 = load i64, ptr %t1832
  call void @emit(ptr %t0, ptr %t1864, i64 %t1865)
  %t1867 = alloca i64
  %t1868 = load ptr, ptr %t1
  %t1869 = sext i32 1 to i64
  %t1870 = getelementptr i32, ptr %t1868, i64 %t1869
  %t1871 = load i64, ptr %t1870
  %t1872 = call i64 @emit_expr(ptr %t0, i64 %t1871)
  store i64 %t1872, ptr %t1867
  %t1873 = alloca ptr
  %t1874 = load i64, ptr %t1867
  %t1875 = load ptr, ptr %t1873
  %t1876 = call i32 @promote_to_i64(ptr %t0, i64 %t1874, ptr %t1875, i64 64)
  %t1877 = sext i32 %t1876 to i64
  %t1878 = getelementptr [18 x i8], ptr @.str189, i64 0, i64 0
  %t1879 = load i64, ptr %t1835
  call void @emit(ptr %t0, ptr %t1878, i64 %t1879)
  %t1881 = getelementptr [6 x i8], ptr @.str190, i64 0, i64 0
  %t1882 = load i64, ptr %t1835
  call void @emit(ptr %t0, ptr %t1881, i64 %t1882)
  %t1884 = alloca i64
  %t1885 = call i32 @new_reg(ptr %t0)
  %t1886 = sext i32 %t1885 to i64
  store i64 %t1886, ptr %t1884
  %t1887 = getelementptr [48 x i8], ptr @.str191, i64 0, i64 0
  %t1888 = load i64, ptr %t1884
  %t1889 = load ptr, ptr %t1856
  %t1890 = load i64, ptr %t1829
  %t1891 = load ptr, ptr %t1873
  %t1892 = load i64, ptr %t1832
  call void @emit(ptr %t0, ptr %t1887, i64 %t1888, ptr %t1889, i64 %t1890, ptr %t1891, i64 %t1892)
  %t1894 = alloca ptr
  %t1895 = load ptr, ptr %t1894
  %t1896 = getelementptr [6 x i8], ptr @.str192, i64 0, i64 0
  %t1897 = load i64, ptr %t1884
  %t1898 = call i32 @snprintf(ptr %t1895, i64 8, ptr %t1896, i64 %t1897)
  %t1899 = sext i32 %t1898 to i64
  %t1900 = load ptr, ptr %t1894
  %t1901 = call ptr @default_i64_type()
  %t1902 = call i64 @make_val(ptr %t1900, ptr %t1901)
  ret i64 %t1902
L371:
  br label %L24
L24:
  %t1903 = alloca i64
  %t1904 = load ptr, ptr %t1
  %t1905 = icmp ne ptr %t1904, null
  br i1 %t1905, label %L372, label %L373
L372:
  %t1906 = load ptr, ptr %t1
  %t1907 = call i32 @type_size(ptr %t1906)
  %t1908 = sext i32 %t1907 to i64
  br label %L374
L373:
  %t1909 = sext i32 0 to i64
  br label %L374
L374:
  %t1910 = phi i64 [ %t1908, %L372 ], [ %t1909, %L373 ]
  store i64 %t1910, ptr %t1903
  %t1911 = alloca ptr
  %t1912 = load ptr, ptr %t1911
  %t1913 = getelementptr [3 x i8], ptr @.str193, i64 0, i64 0
  %t1914 = load i64, ptr %t1903
  %t1915 = call i32 @snprintf(ptr %t1912, i64 8, ptr %t1913, i64 %t1914)
  %t1916 = sext i32 %t1915 to i64
  %t1917 = load ptr, ptr %t1911
  %t1918 = call ptr @default_int_type()
  %t1919 = call i64 @make_val(ptr %t1917, ptr %t1918)
  ret i64 %t1919
L375:
  br label %L25
L25:
  %t1920 = alloca i64
  %t1921 = load ptr, ptr %t1
  %t1922 = sext i32 0 to i64
  %t1923 = getelementptr i32, ptr %t1921, i64 %t1922
  %t1924 = load i64, ptr %t1923
  %t1925 = inttoptr i64 %t1924 to ptr
  %t1926 = load ptr, ptr %t1925
  %t1927 = icmp ne ptr %t1926, null
  br i1 %t1927, label %L376, label %L377
L376:
  %t1928 = load ptr, ptr %t1
  %t1929 = sext i32 0 to i64
  %t1930 = getelementptr i32, ptr %t1928, i64 %t1929
  %t1931 = load i64, ptr %t1930
  %t1932 = inttoptr i64 %t1931 to ptr
  %t1933 = load ptr, ptr %t1932
  %t1934 = call i32 @type_size(ptr %t1933)
  %t1935 = sext i32 %t1934 to i64
  br label %L378
L377:
  %t1936 = sext i32 8 to i64
  br label %L378
L378:
  %t1937 = phi i64 [ %t1935, %L376 ], [ %t1936, %L377 ]
  store i64 %t1937, ptr %t1920
  %t1938 = alloca ptr
  %t1939 = load ptr, ptr %t1938
  %t1940 = getelementptr [3 x i8], ptr @.str194, i64 0, i64 0
  %t1941 = load i64, ptr %t1920
  %t1942 = call i32 @snprintf(ptr %t1939, i64 8, ptr %t1940, i64 %t1941)
  %t1943 = sext i32 %t1942 to i64
  %t1944 = load ptr, ptr %t1938
  %t1945 = call ptr @default_int_type()
  %t1946 = call i64 @make_val(ptr %t1944, ptr %t1945)
  ret i64 %t1946
L379:
  br label %L26
L26:
  %t1947 = alloca i64
  %t1948 = getelementptr [2 x i8], ptr @.str195, i64 0, i64 0
  %t1949 = call ptr @default_int_type()
  %t1950 = call i64 @make_val(ptr %t1948, ptr %t1949)
  store i64 %t1950, ptr %t1947
  %t1951 = alloca i64
  %t1952 = sext i32 0 to i64
  store i64 %t1952, ptr %t1951
  br label %L380
L380:
  %t1953 = load i64, ptr %t1951
  %t1954 = load ptr, ptr %t1
  %t1956 = ptrtoint ptr %t1954 to i64
  %t1955 = icmp slt i64 %t1953, %t1956
  %t1957 = zext i1 %t1955 to i64
  %t1958 = icmp ne i64 %t1957, 0
  br i1 %t1958, label %L381, label %L383
L381:
  %t1959 = load ptr, ptr %t1
  %t1960 = load i64, ptr %t1951
  %t1961 = getelementptr i32, ptr %t1959, i64 %t1960
  %t1962 = load i64, ptr %t1961
  %t1963 = call i64 @emit_expr(ptr %t0, i64 %t1962)
  store i64 %t1963, ptr %t1947
  br label %L382
L382:
  %t1964 = load i64, ptr %t1951
  %t1965 = add i64 %t1964, 1
  store i64 %t1965, ptr %t1951
  br label %L380
L383:
  %t1966 = load i64, ptr %t1947
  ret i64 %t1966
L384:
  br label %L27
L27:
  br label %L28
L28:
  %t1967 = alloca i64
  %t1968 = load ptr, ptr %t1
  %t1970 = ptrtoint ptr %t1968 to i64
  %t1971 = sext i32 35 to i64
  %t1969 = icmp eq i64 %t1970, %t1971
  %t1972 = zext i1 %t1969 to i64
  %t1973 = icmp ne i64 %t1972, 0
  br i1 %t1973, label %L385, label %L386
L385:
  %t1974 = load ptr, ptr %t1
  %t1975 = sext i32 0 to i64
  %t1976 = getelementptr i32, ptr %t1974, i64 %t1975
  %t1977 = load i64, ptr %t1976
  %t1978 = call i64 @emit_expr(ptr %t0, i64 %t1977)
  store i64 %t1978, ptr %t1967
  br label %L387
L386:
  %t1979 = alloca ptr
  %t1980 = load ptr, ptr %t1
  %t1981 = sext i32 0 to i64
  %t1982 = getelementptr i32, ptr %t1980, i64 %t1981
  %t1983 = load i64, ptr %t1982
  %t1984 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1983)
  store ptr %t1984, ptr %t1979
  %t1985 = load ptr, ptr %t1979
  %t1986 = icmp ne ptr %t1985, null
  br i1 %t1986, label %L388, label %L389
L388:
  %t1987 = load ptr, ptr %t1979
  %t1988 = ptrtoint ptr %t1987 to i64
  br label %L390
L389:
  %t1989 = getelementptr [5 x i8], ptr @.str196, i64 0, i64 0
  %t1990 = ptrtoint ptr %t1989 to i64
  br label %L390
L390:
  %t1991 = phi i64 [ %t1988, %L388 ], [ %t1990, %L389 ]
  %t1992 = call ptr @default_ptr_type()
  %t1993 = call i64 @make_val(i64 %t1991, ptr %t1992)
  store i64 %t1993, ptr %t1967
  %t1994 = load ptr, ptr %t1979
  %t1995 = icmp ne ptr %t1994, null
  br i1 %t1995, label %L391, label %L393
L391:
  %t1996 = load ptr, ptr %t1979
  %t1997 = call i32 @free(ptr %t1996)
  %t1998 = sext i32 %t1997 to i64
  br label %L393
L393:
  br label %L387
L387:
  %t1999 = alloca ptr
  %t2000 = load i64, ptr %t1967
  %t2001 = call i32 @val_is_ptr(i64 %t2000)
  %t2002 = sext i32 %t2001 to i64
  %t2003 = icmp ne i64 %t2002, 0
  br i1 %t2003, label %L394, label %L395
L394:
  %t2004 = load ptr, ptr %t1999
  %t2005 = load ptr, ptr %t1967
  %t2006 = call ptr @strncpy(ptr %t2004, ptr %t2005, i64 63)
  %t2007 = load ptr, ptr %t1999
  %t2009 = sext i32 63 to i64
  %t2008 = getelementptr i8, ptr %t2007, i64 %t2009
  %t2010 = sext i32 0 to i64
  store i64 %t2010, ptr %t2008
  br label %L396
L395:
  %t2011 = alloca i64
  %t2012 = call i32 @new_reg(ptr %t0)
  %t2013 = sext i32 %t2012 to i64
  store i64 %t2013, ptr %t2011
  %t2014 = alloca ptr
  %t2015 = load i64, ptr %t1967
  %t2016 = load ptr, ptr %t2014
  %t2017 = call i32 @promote_to_i64(ptr %t0, i64 %t2015, ptr %t2016, i64 64)
  %t2018 = sext i32 %t2017 to i64
  %t2019 = getelementptr [34 x i8], ptr @.str197, i64 0, i64 0
  %t2020 = load i64, ptr %t2011
  %t2021 = load ptr, ptr %t2014
  call void @emit(ptr %t0, ptr %t2019, i64 %t2020, ptr %t2021)
  %t2023 = load ptr, ptr %t1999
  %t2024 = getelementptr [6 x i8], ptr @.str198, i64 0, i64 0
  %t2025 = load i64, ptr %t2011
  %t2026 = call i32 @snprintf(ptr %t2023, i64 64, ptr %t2024, i64 %t2025)
  %t2027 = sext i32 %t2026 to i64
  br label %L396
L396:
  %t2028 = alloca i64
  %t2029 = call i32 @new_reg(ptr %t0)
  %t2030 = sext i32 %t2029 to i64
  store i64 %t2030, ptr %t2028
  %t2031 = getelementptr [28 x i8], ptr @.str199, i64 0, i64 0
  %t2032 = load i64, ptr %t2028
  %t2033 = load ptr, ptr %t1999
  call void @emit(ptr %t0, ptr %t2031, i64 %t2032, ptr %t2033)
  %t2035 = alloca ptr
  %t2036 = load ptr, ptr %t2035
  %t2037 = getelementptr [6 x i8], ptr @.str200, i64 0, i64 0
  %t2038 = load i64, ptr %t2028
  %t2039 = call i32 @snprintf(ptr %t2036, i64 8, ptr %t2037, i64 %t2038)
  %t2040 = sext i32 %t2039 to i64
  %t2041 = load ptr, ptr %t2035
  %t2042 = call ptr @default_ptr_type()
  %t2043 = call i64 @make_val(ptr %t2041, ptr %t2042)
  ret i64 %t2043
L397:
  br label %L4
L29:
  %t2044 = getelementptr [28 x i8], ptr @.str201, i64 0, i64 0
  %t2045 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t2044, ptr %t2045)
  %t2047 = getelementptr [2 x i8], ptr @.str202, i64 0, i64 0
  %t2048 = call ptr @default_int_type()
  %t2049 = call i64 @make_val(ptr %t2047, ptr %t2048)
  ret i64 %t2049
L398:
  br label %L4
L4:
  ret i64 0
}

define internal void @emit_stmt(ptr %t0, ptr %t1) {
entry:
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = icmp eq i64 %t3, 0
  %t2 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t2, 0
  br i1 %t5, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %t6 = load ptr, ptr %t1
  %t7 = ptrtoint ptr %t6 to i64
  %t8 = add i64 %t7, 0
  switch i64 %t8, label %L21 [
    i64 5, label %L5
    i64 2, label %L6
    i64 18, label %L7
    i64 10, label %L8
    i64 6, label %L9
    i64 7, label %L10
    i64 8, label %L11
    i64 9, label %L12
    i64 11, label %L13
    i64 12, label %L14
    i64 13, label %L15
    i64 14, label %L16
    i64 15, label %L17
    i64 16, label %L18
    i64 17, label %L19
    i64 3, label %L20
  ]
L5:
  %t9 = load ptr, ptr %t1
  %t10 = icmp ne ptr %t9, null
  br i1 %t10, label %L22, label %L24
L22:
  call void @scope_push(ptr %t0)
  br label %L24
L24:
  %t12 = alloca i64
  %t13 = sext i32 0 to i64
  store i64 %t13, ptr %t12
  br label %L25
L25:
  %t14 = load i64, ptr %t12
  %t15 = load ptr, ptr %t1
  %t17 = ptrtoint ptr %t15 to i64
  %t16 = icmp slt i64 %t14, %t17
  %t18 = zext i1 %t16 to i64
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L26, label %L28
L26:
  %t20 = load ptr, ptr %t1
  %t21 = load i64, ptr %t12
  %t22 = getelementptr i32, ptr %t20, i64 %t21
  %t23 = load i64, ptr %t22
  call void @emit_stmt(ptr %t0, i64 %t23)
  br label %L27
L27:
  %t25 = load i64, ptr %t12
  %t26 = add i64 %t25, 1
  store i64 %t26, ptr %t12
  br label %L25
L28:
  %t27 = load ptr, ptr %t1
  %t28 = icmp ne ptr %t27, null
  br i1 %t28, label %L29, label %L31
L29:
  call void @scope_pop(ptr %t0)
  br label %L31
L31:
  br label %L4
L32:
  br label %L6
L6:
  %t30 = alloca ptr
  %t31 = load ptr, ptr %t1
  %t32 = icmp ne ptr %t31, null
  br i1 %t32, label %L33, label %L34
L33:
  %t33 = load ptr, ptr %t1
  %t34 = ptrtoint ptr %t33 to i64
  br label %L35
L34:
  %t35 = call ptr @default_int_type()
  %t36 = ptrtoint ptr %t35 to i64
  br label %L35
L35:
  %t37 = phi i64 [ %t34, %L33 ], [ %t36, %L34 ]
  store i64 %t37, ptr %t30
  %t38 = alloca ptr
  %t39 = alloca ptr
  %t40 = load ptr, ptr %t30
  %t41 = load ptr, ptr %t40
  %t43 = ptrtoint ptr %t41 to i64
  %t44 = sext i32 15 to i64
  %t42 = icmp eq i64 %t43, %t44
  %t45 = zext i1 %t42 to i64
  %t46 = load ptr, ptr %t30
  %t47 = load ptr, ptr %t46
  %t49 = ptrtoint ptr %t47 to i64
  %t50 = sext i32 16 to i64
  %t48 = icmp eq i64 %t49, %t50
  %t51 = zext i1 %t48 to i64
  %t53 = icmp ne i64 %t45, 0
  %t54 = icmp ne i64 %t51, 0
  %t55 = or i1 %t53, %t54
  %t56 = zext i1 %t55 to i64
  %t57 = icmp ne i64 %t56, 0
  br i1 %t57, label %L36, label %L37
L36:
  %t58 = getelementptr [4 x i8], ptr @.str203, i64 0, i64 0
  store ptr %t58, ptr %t38
  %t59 = call ptr @default_ptr_type()
  store ptr %t59, ptr %t39
  br label %L38
L37:
  %t60 = load ptr, ptr %t30
  %t61 = call i32 @type_is_fp(ptr %t60)
  %t62 = sext i32 %t61 to i64
  %t63 = icmp ne i64 %t62, 0
  br i1 %t63, label %L39, label %L40
L39:
  %t64 = load ptr, ptr %t30
  %t65 = call ptr @llvm_type(ptr %t64)
  store ptr %t65, ptr %t38
  %t66 = load ptr, ptr %t30
  store ptr %t66, ptr %t39
  br label %L41
L40:
  %t67 = getelementptr [4 x i8], ptr @.str204, i64 0, i64 0
  store ptr %t67, ptr %t38
  %t68 = call ptr @default_i64_type()
  store ptr %t68, ptr %t39
  br label %L41
L41:
  br label %L38
L38:
  %t69 = alloca i64
  %t70 = call i32 @new_reg(ptr %t0)
  %t71 = sext i32 %t70 to i64
  store i64 %t71, ptr %t69
  %t72 = getelementptr [21 x i8], ptr @.str205, i64 0, i64 0
  %t73 = load i64, ptr %t69
  %t74 = load ptr, ptr %t38
  call void @emit(ptr %t0, ptr %t72, i64 %t73, ptr %t74)
  %t76 = load ptr, ptr %t0
  %t78 = ptrtoint ptr %t76 to i64
  %t79 = sext i32 2048 to i64
  %t77 = icmp slt i64 %t78, %t79
  %t80 = zext i1 %t77 to i64
  %t81 = call i32 @assert(i64 %t80)
  %t82 = sext i32 %t81 to i64
  %t83 = alloca ptr
  %t84 = load ptr, ptr %t0
  %t85 = load ptr, ptr %t0
  %t87 = ptrtoint ptr %t85 to i64
  %t86 = add i64 %t87, 1
  store i64 %t86, ptr %t0
  %t89 = ptrtoint ptr %t85 to i64
  %t88 = getelementptr i8, ptr %t84, i64 %t89
  store ptr %t88, ptr %t83
  %t90 = load ptr, ptr %t1
  %t91 = icmp ne ptr %t90, null
  br i1 %t91, label %L42, label %L43
L42:
  %t92 = load ptr, ptr %t1
  %t93 = ptrtoint ptr %t92 to i64
  br label %L44
L43:
  %t94 = getelementptr [7 x i8], ptr @.str206, i64 0, i64 0
  %t95 = ptrtoint ptr %t94 to i64
  br label %L44
L44:
  %t96 = phi i64 [ %t93, %L42 ], [ %t95, %L43 ]
  %t97 = call ptr @strdup(i64 %t96)
  %t98 = load ptr, ptr %t83
  store ptr %t97, ptr %t98
  %t99 = call ptr @malloc(i64 32)
  %t100 = load ptr, ptr %t83
  store ptr %t99, ptr %t100
  %t101 = load ptr, ptr %t83
  %t102 = load ptr, ptr %t101
  %t103 = getelementptr [6 x i8], ptr @.str207, i64 0, i64 0
  %t104 = load i64, ptr %t69
  %t105 = call i32 @snprintf(ptr %t102, i64 32, ptr %t103, i64 %t104)
  %t106 = sext i32 %t105 to i64
  %t107 = load ptr, ptr %t39
  %t108 = load ptr, ptr %t83
  store ptr %t107, ptr %t108
  %t109 = load ptr, ptr %t83
  %t110 = sext i32 0 to i64
  store i64 %t110, ptr %t109
  %t111 = load ptr, ptr %t1
  %t113 = ptrtoint ptr %t111 to i64
  %t114 = sext i32 0 to i64
  %t112 = icmp sgt i64 %t113, %t114
  %t115 = zext i1 %t112 to i64
  %t116 = icmp ne i64 %t115, 0
  br i1 %t116, label %L45, label %L47
L45:
  %t117 = alloca i64
  %t118 = load ptr, ptr %t1
  %t119 = sext i32 0 to i64
  %t120 = getelementptr i32, ptr %t118, i64 %t119
  %t121 = load i64, ptr %t120
  %t122 = call i64 @emit_expr(ptr %t0, i64 %t121)
  store i64 %t122, ptr %t117
  %t123 = alloca ptr
  %t124 = load i64, ptr %t117
  %t125 = call i32 @val_is_ptr(i64 %t124)
  %t126 = sext i32 %t125 to i64
  %t127 = icmp ne i64 %t126, 0
  br i1 %t127, label %L48, label %L49
L48:
  %t128 = getelementptr [4 x i8], ptr @.str208, i64 0, i64 0
  store ptr %t128, ptr %t123
  br label %L50
L49:
  %t129 = load ptr, ptr %t117
  %t130 = call i32 @type_is_fp(ptr %t129)
  %t131 = sext i32 %t130 to i64
  %t132 = icmp ne i64 %t131, 0
  br i1 %t132, label %L51, label %L52
L51:
  %t133 = load ptr, ptr %t117
  %t134 = call ptr @llvm_type(ptr %t133)
  store ptr %t134, ptr %t123
  br label %L53
L52:
  %t135 = getelementptr [4 x i8], ptr @.str209, i64 0, i64 0
  store ptr %t135, ptr %t123
  br label %L53
L53:
  br label %L50
L50:
  %t136 = alloca ptr
  %t137 = load i64, ptr %t117
  %t138 = call i32 @val_is_ptr(i64 %t137)
  %t139 = sext i32 %t138 to i64
  %t141 = icmp eq i64 %t139, 0
  %t140 = zext i1 %t141 to i64
  %t142 = load i64, ptr %t117
  %t143 = call i32 @val_is_64bit(i64 %t142)
  %t144 = sext i32 %t143 to i64
  %t146 = icmp eq i64 %t144, 0
  %t145 = zext i1 %t146 to i64
  %t148 = icmp ne i64 %t140, 0
  %t149 = icmp ne i64 %t145, 0
  %t150 = and i1 %t148, %t149
  %t151 = zext i1 %t150 to i64
  %t152 = load ptr, ptr %t117
  %t153 = call i32 @type_is_fp(ptr %t152)
  %t154 = sext i32 %t153 to i64
  %t156 = icmp eq i64 %t154, 0
  %t155 = zext i1 %t156 to i64
  %t158 = icmp ne i64 %t151, 0
  %t159 = icmp ne i64 %t155, 0
  %t160 = and i1 %t158, %t159
  %t161 = zext i1 %t160 to i64
  %t162 = icmp ne i64 %t161, 0
  br i1 %t162, label %L54, label %L55
L54:
  %t163 = alloca i64
  %t164 = call i32 @new_reg(ptr %t0)
  %t165 = sext i32 %t164 to i64
  store i64 %t165, ptr %t163
  %t166 = getelementptr [30 x i8], ptr @.str210, i64 0, i64 0
  %t167 = load i64, ptr %t163
  %t168 = load ptr, ptr %t117
  call void @emit(ptr %t0, ptr %t166, i64 %t167, ptr %t168)
  %t170 = load ptr, ptr %t136
  %t171 = getelementptr [6 x i8], ptr @.str211, i64 0, i64 0
  %t172 = load i64, ptr %t163
  %t173 = call i32 @snprintf(ptr %t170, i64 64, ptr %t171, i64 %t172)
  %t174 = sext i32 %t173 to i64
  br label %L56
L55:
  %t175 = load ptr, ptr %t136
  %t176 = load ptr, ptr %t117
  %t177 = call ptr @strncpy(ptr %t175, ptr %t176, i64 63)
  %t178 = load ptr, ptr %t136
  %t180 = sext i32 63 to i64
  %t179 = getelementptr i8, ptr %t178, i64 %t180
  %t181 = sext i32 0 to i64
  store i64 %t181, ptr %t179
  br label %L56
L56:
  %t182 = getelementptr [26 x i8], ptr @.str212, i64 0, i64 0
  %t183 = load ptr, ptr %t123
  %t184 = load ptr, ptr %t136
  %t185 = load i64, ptr %t69
  call void @emit(ptr %t0, ptr %t182, ptr %t183, ptr %t184, i64 %t185)
  br label %L47
L47:
  %t187 = alloca i64
  %t188 = sext i32 1 to i64
  store i64 %t188, ptr %t187
  br label %L57
L57:
  %t189 = load i64, ptr %t187
  %t190 = load ptr, ptr %t1
  %t192 = ptrtoint ptr %t190 to i64
  %t191 = icmp slt i64 %t189, %t192
  %t193 = zext i1 %t191 to i64
  %t194 = icmp ne i64 %t193, 0
  br i1 %t194, label %L58, label %L60
L58:
  %t195 = load ptr, ptr %t1
  %t196 = load i64, ptr %t187
  %t197 = getelementptr i32, ptr %t195, i64 %t196
  %t198 = load i64, ptr %t197
  call void @emit_stmt(ptr %t0, i64 %t198)
  br label %L59
L59:
  %t200 = load i64, ptr %t187
  %t201 = add i64 %t200, 1
  store i64 %t201, ptr %t187
  br label %L57
L60:
  br label %L4
L61:
  br label %L7
L7:
  %t202 = load ptr, ptr %t1
  %t204 = ptrtoint ptr %t202 to i64
  %t205 = sext i32 0 to i64
  %t203 = icmp sgt i64 %t204, %t205
  %t206 = zext i1 %t203 to i64
  %t207 = icmp ne i64 %t206, 0
  br i1 %t207, label %L62, label %L64
L62:
  %t208 = load ptr, ptr %t1
  %t209 = sext i32 0 to i64
  %t210 = getelementptr i32, ptr %t208, i64 %t209
  %t211 = load i64, ptr %t210
  %t212 = call i64 @emit_expr(ptr %t0, i64 %t211)
  br label %L64
L64:
  br label %L4
L65:
  br label %L8
L8:
  %t213 = load ptr, ptr %t1
  %t214 = icmp ne ptr %t213, null
  br i1 %t214, label %L66, label %L67
L66:
  %t215 = alloca i64
  %t216 = load ptr, ptr %t1
  %t217 = call i64 @emit_expr(ptr %t0, ptr %t216)
  store i64 %t217, ptr %t215
  %t218 = alloca ptr
  %t219 = load ptr, ptr %t0
  store ptr %t219, ptr %t218
  %t220 = alloca i64
  %t221 = load ptr, ptr %t218
  %t222 = load ptr, ptr %t221
  %t224 = ptrtoint ptr %t222 to i64
  %t225 = sext i32 15 to i64
  %t223 = icmp eq i64 %t224, %t225
  %t226 = zext i1 %t223 to i64
  %t227 = load ptr, ptr %t218
  %t228 = load ptr, ptr %t227
  %t230 = ptrtoint ptr %t228 to i64
  %t231 = sext i32 16 to i64
  %t229 = icmp eq i64 %t230, %t231
  %t232 = zext i1 %t229 to i64
  %t234 = icmp ne i64 %t226, 0
  %t235 = icmp ne i64 %t232, 0
  %t236 = or i1 %t234, %t235
  %t237 = zext i1 %t236 to i64
  store i64 %t237, ptr %t220
  %t238 = alloca i64
  %t239 = load ptr, ptr %t218
  %t240 = load ptr, ptr %t239
  %t242 = ptrtoint ptr %t240 to i64
  %t243 = sext i32 0 to i64
  %t241 = icmp eq i64 %t242, %t243
  %t244 = zext i1 %t241 to i64
  store i64 %t244, ptr %t238
  %t245 = alloca i64
  %t246 = load ptr, ptr %t218
  %t247 = call i32 @type_is_fp(ptr %t246)
  %t248 = sext i32 %t247 to i64
  store i64 %t248, ptr %t245
  %t249 = alloca ptr
  %t250 = load ptr, ptr %t218
  %t251 = call ptr @llvm_type(ptr %t250)
  store ptr %t251, ptr %t249
  %t252 = load i64, ptr %t238
  %t253 = icmp ne i64 %t252, 0
  br i1 %t253, label %L69, label %L70
L69:
  %t254 = getelementptr [12 x i8], ptr @.str213, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t254)
  br label %L71
L70:
  %t256 = load i64, ptr %t245
  %t257 = icmp ne i64 %t256, 0
  br i1 %t257, label %L72, label %L73
L72:
  %t258 = getelementptr [13 x i8], ptr @.str214, i64 0, i64 0
  %t259 = load ptr, ptr %t249
  %t260 = load ptr, ptr %t215
  call void @emit(ptr %t0, ptr %t258, ptr %t259, ptr %t260)
  br label %L74
L73:
  %t262 = load i64, ptr %t220
  %t263 = icmp ne i64 %t262, 0
  br i1 %t263, label %L75, label %L76
L75:
  %t264 = load i64, ptr %t215
  %t265 = call i32 @val_is_ptr(i64 %t264)
  %t266 = sext i32 %t265 to i64
  %t267 = icmp ne i64 %t266, 0
  br i1 %t267, label %L78, label %L79
L78:
  %t268 = getelementptr [14 x i8], ptr @.str215, i64 0, i64 0
  %t269 = load ptr, ptr %t215
  call void @emit(ptr %t0, ptr %t268, ptr %t269)
  br label %L80
L79:
  %t271 = alloca i64
  %t272 = call i32 @new_reg(ptr %t0)
  %t273 = sext i32 %t272 to i64
  store i64 %t273, ptr %t271
  %t274 = alloca ptr
  %t275 = load i64, ptr %t215
  %t276 = load ptr, ptr %t274
  %t277 = call i32 @promote_to_i64(ptr %t0, i64 %t275, ptr %t276, i64 64)
  %t278 = sext i32 %t277 to i64
  %t279 = getelementptr [34 x i8], ptr @.str216, i64 0, i64 0
  %t280 = load i64, ptr %t271
  %t281 = load ptr, ptr %t274
  call void @emit(ptr %t0, ptr %t279, i64 %t280, ptr %t281)
  %t283 = getelementptr [17 x i8], ptr @.str217, i64 0, i64 0
  %t284 = load i64, ptr %t271
  call void @emit(ptr %t0, ptr %t283, i64 %t284)
  br label %L80
L80:
  br label %L77
L76:
  %t286 = alloca ptr
  %t287 = load i64, ptr %t215
  %t288 = load ptr, ptr %t286
  %t289 = call i32 @promote_to_i64(ptr %t0, i64 %t287, ptr %t288, i64 64)
  %t290 = sext i32 %t289 to i64
  %t291 = load ptr, ptr %t249
  %t292 = getelementptr [3 x i8], ptr @.str218, i64 0, i64 0
  %t293 = call i32 @strcmp(ptr %t291, ptr %t292)
  %t294 = sext i32 %t293 to i64
  %t296 = sext i32 0 to i64
  %t295 = icmp eq i64 %t294, %t296
  %t297 = zext i1 %t295 to i64
  %t298 = icmp ne i64 %t297, 0
  br i1 %t298, label %L81, label %L82
L81:
  %t299 = alloca i64
  %t300 = call i32 @new_reg(ptr %t0)
  %t301 = sext i32 %t300 to i64
  store i64 %t301, ptr %t299
  %t302 = getelementptr [30 x i8], ptr @.str219, i64 0, i64 0
  %t303 = load i64, ptr %t299
  %t304 = load ptr, ptr %t286
  call void @emit(ptr %t0, ptr %t302, i64 %t303, ptr %t304)
  %t306 = getelementptr [16 x i8], ptr @.str220, i64 0, i64 0
  %t307 = load i64, ptr %t299
  call void @emit(ptr %t0, ptr %t306, i64 %t307)
  br label %L83
L82:
  %t309 = load ptr, ptr %t249
  %t310 = getelementptr [4 x i8], ptr @.str221, i64 0, i64 0
  %t311 = call i32 @strcmp(ptr %t309, ptr %t310)
  %t312 = sext i32 %t311 to i64
  %t314 = sext i32 0 to i64
  %t313 = icmp eq i64 %t312, %t314
  %t315 = zext i1 %t313 to i64
  %t316 = icmp ne i64 %t315, 0
  br i1 %t316, label %L84, label %L85
L84:
  %t317 = alloca i64
  %t318 = call i32 @new_reg(ptr %t0)
  %t319 = sext i32 %t318 to i64
  store i64 %t319, ptr %t317
  %t320 = getelementptr [31 x i8], ptr @.str222, i64 0, i64 0
  %t321 = load i64, ptr %t317
  %t322 = load ptr, ptr %t286
  call void @emit(ptr %t0, ptr %t320, i64 %t321, ptr %t322)
  %t324 = getelementptr [17 x i8], ptr @.str223, i64 0, i64 0
  %t325 = load i64, ptr %t317
  call void @emit(ptr %t0, ptr %t324, i64 %t325)
  br label %L86
L85:
  %t327 = load ptr, ptr %t249
  %t328 = getelementptr [4 x i8], ptr @.str224, i64 0, i64 0
  %t329 = call i32 @strcmp(ptr %t327, ptr %t328)
  %t330 = sext i32 %t329 to i64
  %t332 = sext i32 0 to i64
  %t331 = icmp eq i64 %t330, %t332
  %t333 = zext i1 %t331 to i64
  %t334 = icmp ne i64 %t333, 0
  br i1 %t334, label %L87, label %L88
L87:
  %t335 = alloca i64
  %t336 = call i32 @new_reg(ptr %t0)
  %t337 = sext i32 %t336 to i64
  store i64 %t337, ptr %t335
  %t338 = getelementptr [31 x i8], ptr @.str225, i64 0, i64 0
  %t339 = load i64, ptr %t335
  %t340 = load ptr, ptr %t286
  call void @emit(ptr %t0, ptr %t338, i64 %t339, ptr %t340)
  %t342 = getelementptr [17 x i8], ptr @.str226, i64 0, i64 0
  %t343 = load i64, ptr %t335
  call void @emit(ptr %t0, ptr %t342, i64 %t343)
  br label %L89
L88:
  %t345 = getelementptr [14 x i8], ptr @.str227, i64 0, i64 0
  %t346 = load ptr, ptr %t286
  call void @emit(ptr %t0, ptr %t345, ptr %t346)
  br label %L89
L89:
  br label %L86
L86:
  br label %L83
L83:
  br label %L77
L77:
  br label %L74
L74:
  br label %L71
L71:
  br label %L68
L67:
  %t348 = getelementptr [12 x i8], ptr @.str228, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t348)
  br label %L68
L68:
  %t350 = alloca i64
  %t351 = call i32 @new_label(ptr %t0)
  %t352 = sext i32 %t351 to i64
  store i64 %t352, ptr %t350
  %t353 = getelementptr [6 x i8], ptr @.str229, i64 0, i64 0
  %t354 = load i64, ptr %t350
  call void @emit(ptr %t0, ptr %t353, i64 %t354)
  br label %L4
L90:
  br label %L9
L9:
  %t356 = alloca i64
  %t357 = load ptr, ptr %t1
  %t358 = call i64 @emit_expr(ptr %t0, ptr %t357)
  store i64 %t358, ptr %t356
  %t359 = alloca i64
  %t360 = load i64, ptr %t356
  %t361 = call i32 @emit_cond(ptr %t0, i64 %t360)
  %t362 = sext i32 %t361 to i64
  store i64 %t362, ptr %t359
  %t363 = alloca i64
  %t364 = call i32 @new_label(ptr %t0)
  %t365 = sext i32 %t364 to i64
  store i64 %t365, ptr %t363
  %t366 = alloca i64
  %t367 = call i32 @new_label(ptr %t0)
  %t368 = sext i32 %t367 to i64
  store i64 %t368, ptr %t366
  %t369 = alloca i64
  %t370 = call i32 @new_label(ptr %t0)
  %t371 = sext i32 %t370 to i64
  store i64 %t371, ptr %t369
  %t372 = getelementptr [41 x i8], ptr @.str230, i64 0, i64 0
  %t373 = load i64, ptr %t359
  %t374 = load i64, ptr %t363
  %t375 = load ptr, ptr %t1
  %t376 = icmp ne ptr %t375, null
  br i1 %t376, label %L91, label %L92
L91:
  %t377 = load i64, ptr %t366
  br label %L93
L92:
  %t378 = load i64, ptr %t369
  br label %L93
L93:
  %t379 = phi i64 [ %t377, %L91 ], [ %t378, %L92 ]
  call void @emit(ptr %t0, ptr %t372, i64 %t373, i64 %t374, i64 %t379)
  %t381 = getelementptr [6 x i8], ptr @.str231, i64 0, i64 0
  %t382 = load i64, ptr %t363
  call void @emit(ptr %t0, ptr %t381, i64 %t382)
  %t384 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t384)
  %t386 = getelementptr [18 x i8], ptr @.str232, i64 0, i64 0
  %t387 = load i64, ptr %t369
  call void @emit(ptr %t0, ptr %t386, i64 %t387)
  %t389 = load ptr, ptr %t1
  %t390 = icmp ne ptr %t389, null
  br i1 %t390, label %L94, label %L96
L94:
  %t391 = getelementptr [6 x i8], ptr @.str233, i64 0, i64 0
  %t392 = load i64, ptr %t366
  call void @emit(ptr %t0, ptr %t391, i64 %t392)
  %t394 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t394)
  %t396 = getelementptr [18 x i8], ptr @.str234, i64 0, i64 0
  %t397 = load i64, ptr %t369
  call void @emit(ptr %t0, ptr %t396, i64 %t397)
  br label %L96
L96:
  %t399 = getelementptr [6 x i8], ptr @.str235, i64 0, i64 0
  %t400 = load i64, ptr %t369
  call void @emit(ptr %t0, ptr %t399, i64 %t400)
  br label %L4
L97:
  br label %L10
L10:
  %t402 = alloca i64
  %t403 = call i32 @new_label(ptr %t0)
  %t404 = sext i32 %t403 to i64
  store i64 %t404, ptr %t402
  %t405 = alloca i64
  %t406 = call i32 @new_label(ptr %t0)
  %t407 = sext i32 %t406 to i64
  store i64 %t407, ptr %t405
  %t408 = alloca i64
  %t409 = call i32 @new_label(ptr %t0)
  %t410 = sext i32 %t409 to i64
  store i64 %t410, ptr %t408
  %t411 = alloca ptr
  %t412 = alloca ptr
  %t413 = load ptr, ptr %t411
  %t414 = load ptr, ptr %t0
  %t415 = call ptr @strcpy(ptr %t413, ptr %t414)
  %t416 = load ptr, ptr %t412
  %t417 = load ptr, ptr %t0
  %t418 = call ptr @strcpy(ptr %t416, ptr %t417)
  %t419 = load ptr, ptr %t0
  %t420 = getelementptr [4 x i8], ptr @.str236, i64 0, i64 0
  %t421 = load i64, ptr %t408
  %t422 = call i32 @snprintf(ptr %t419, i64 64, ptr %t420, i64 %t421)
  %t423 = sext i32 %t422 to i64
  %t424 = load ptr, ptr %t0
  %t425 = getelementptr [4 x i8], ptr @.str237, i64 0, i64 0
  %t426 = load i64, ptr %t402
  %t427 = call i32 @snprintf(ptr %t424, i64 64, ptr %t425, i64 %t426)
  %t428 = sext i32 %t427 to i64
  %t429 = getelementptr [18 x i8], ptr @.str238, i64 0, i64 0
  %t430 = load i64, ptr %t402
  call void @emit(ptr %t0, ptr %t429, i64 %t430)
  %t432 = getelementptr [6 x i8], ptr @.str239, i64 0, i64 0
  %t433 = load i64, ptr %t402
  call void @emit(ptr %t0, ptr %t432, i64 %t433)
  %t435 = alloca i64
  %t436 = load ptr, ptr %t1
  %t437 = call i64 @emit_expr(ptr %t0, ptr %t436)
  store i64 %t437, ptr %t435
  %t438 = alloca i64
  %t439 = load i64, ptr %t435
  %t440 = call i32 @emit_cond(ptr %t0, i64 %t439)
  %t441 = sext i32 %t440 to i64
  store i64 %t441, ptr %t438
  %t442 = getelementptr [41 x i8], ptr @.str240, i64 0, i64 0
  %t443 = load i64, ptr %t438
  %t444 = load i64, ptr %t405
  %t445 = load i64, ptr %t408
  call void @emit(ptr %t0, ptr %t442, i64 %t443, i64 %t444, i64 %t445)
  %t447 = getelementptr [6 x i8], ptr @.str241, i64 0, i64 0
  %t448 = load i64, ptr %t405
  call void @emit(ptr %t0, ptr %t447, i64 %t448)
  %t450 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t450)
  %t452 = getelementptr [18 x i8], ptr @.str242, i64 0, i64 0
  %t453 = load i64, ptr %t402
  call void @emit(ptr %t0, ptr %t452, i64 %t453)
  %t455 = getelementptr [6 x i8], ptr @.str243, i64 0, i64 0
  %t456 = load i64, ptr %t408
  call void @emit(ptr %t0, ptr %t455, i64 %t456)
  %t458 = load ptr, ptr %t0
  %t459 = load ptr, ptr %t411
  %t460 = call ptr @strcpy(ptr %t458, ptr %t459)
  %t461 = load ptr, ptr %t0
  %t462 = load ptr, ptr %t412
  %t463 = call ptr @strcpy(ptr %t461, ptr %t462)
  br label %L4
L98:
  br label %L11
L11:
  %t464 = alloca i64
  %t465 = call i32 @new_label(ptr %t0)
  %t466 = sext i32 %t465 to i64
  store i64 %t466, ptr %t464
  %t467 = alloca i64
  %t468 = call i32 @new_label(ptr %t0)
  %t469 = sext i32 %t468 to i64
  store i64 %t469, ptr %t467
  %t470 = alloca i64
  %t471 = call i32 @new_label(ptr %t0)
  %t472 = sext i32 %t471 to i64
  store i64 %t472, ptr %t470
  %t473 = alloca ptr
  %t474 = alloca ptr
  %t475 = load ptr, ptr %t473
  %t476 = load ptr, ptr %t0
  %t477 = call ptr @strcpy(ptr %t475, ptr %t476)
  %t478 = load ptr, ptr %t474
  %t479 = load ptr, ptr %t0
  %t480 = call ptr @strcpy(ptr %t478, ptr %t479)
  %t481 = load ptr, ptr %t0
  %t482 = getelementptr [4 x i8], ptr @.str244, i64 0, i64 0
  %t483 = load i64, ptr %t470
  %t484 = call i32 @snprintf(ptr %t481, i64 64, ptr %t482, i64 %t483)
  %t485 = sext i32 %t484 to i64
  %t486 = load ptr, ptr %t0
  %t487 = getelementptr [4 x i8], ptr @.str245, i64 0, i64 0
  %t488 = load i64, ptr %t467
  %t489 = call i32 @snprintf(ptr %t486, i64 64, ptr %t487, i64 %t488)
  %t490 = sext i32 %t489 to i64
  %t491 = getelementptr [18 x i8], ptr @.str246, i64 0, i64 0
  %t492 = load i64, ptr %t464
  call void @emit(ptr %t0, ptr %t491, i64 %t492)
  %t494 = getelementptr [6 x i8], ptr @.str247, i64 0, i64 0
  %t495 = load i64, ptr %t464
  call void @emit(ptr %t0, ptr %t494, i64 %t495)
  %t497 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t497)
  %t499 = getelementptr [18 x i8], ptr @.str248, i64 0, i64 0
  %t500 = load i64, ptr %t467
  call void @emit(ptr %t0, ptr %t499, i64 %t500)
  %t502 = getelementptr [6 x i8], ptr @.str249, i64 0, i64 0
  %t503 = load i64, ptr %t467
  call void @emit(ptr %t0, ptr %t502, i64 %t503)
  %t505 = alloca i64
  %t506 = load ptr, ptr %t1
  %t507 = call i64 @emit_expr(ptr %t0, ptr %t506)
  store i64 %t507, ptr %t505
  %t508 = alloca i64
  %t509 = load i64, ptr %t505
  %t510 = call i32 @emit_cond(ptr %t0, i64 %t509)
  %t511 = sext i32 %t510 to i64
  store i64 %t511, ptr %t508
  %t512 = getelementptr [41 x i8], ptr @.str250, i64 0, i64 0
  %t513 = load i64, ptr %t508
  %t514 = load i64, ptr %t464
  %t515 = load i64, ptr %t470
  call void @emit(ptr %t0, ptr %t512, i64 %t513, i64 %t514, i64 %t515)
  %t517 = getelementptr [6 x i8], ptr @.str251, i64 0, i64 0
  %t518 = load i64, ptr %t470
  call void @emit(ptr %t0, ptr %t517, i64 %t518)
  %t520 = load ptr, ptr %t0
  %t521 = load ptr, ptr %t473
  %t522 = call ptr @strcpy(ptr %t520, ptr %t521)
  %t523 = load ptr, ptr %t0
  %t524 = load ptr, ptr %t474
  %t525 = call ptr @strcpy(ptr %t523, ptr %t524)
  br label %L4
L99:
  br label %L12
L12:
  %t526 = alloca i64
  %t527 = call i32 @new_label(ptr %t0)
  %t528 = sext i32 %t527 to i64
  store i64 %t528, ptr %t526
  %t529 = alloca i64
  %t530 = call i32 @new_label(ptr %t0)
  %t531 = sext i32 %t530 to i64
  store i64 %t531, ptr %t529
  %t532 = alloca i64
  %t533 = call i32 @new_label(ptr %t0)
  %t534 = sext i32 %t533 to i64
  store i64 %t534, ptr %t532
  %t535 = alloca i64
  %t536 = call i32 @new_label(ptr %t0)
  %t537 = sext i32 %t536 to i64
  store i64 %t537, ptr %t535
  %t538 = alloca ptr
  %t539 = alloca ptr
  %t540 = load ptr, ptr %t538
  %t541 = load ptr, ptr %t0
  %t542 = call ptr @strcpy(ptr %t540, ptr %t541)
  %t543 = load ptr, ptr %t539
  %t544 = load ptr, ptr %t0
  %t545 = call ptr @strcpy(ptr %t543, ptr %t544)
  %t546 = load ptr, ptr %t0
  %t547 = getelementptr [4 x i8], ptr @.str252, i64 0, i64 0
  %t548 = load i64, ptr %t535
  %t549 = call i32 @snprintf(ptr %t546, i64 64, ptr %t547, i64 %t548)
  %t550 = sext i32 %t549 to i64
  %t551 = load ptr, ptr %t0
  %t552 = getelementptr [4 x i8], ptr @.str253, i64 0, i64 0
  %t553 = load i64, ptr %t532
  %t554 = call i32 @snprintf(ptr %t551, i64 64, ptr %t552, i64 %t553)
  %t555 = sext i32 %t554 to i64
  call void @scope_push(ptr %t0)
  %t557 = load ptr, ptr %t1
  %t558 = icmp ne ptr %t557, null
  br i1 %t558, label %L100, label %L102
L100:
  %t559 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t559)
  br label %L102
L102:
  %t561 = getelementptr [18 x i8], ptr @.str254, i64 0, i64 0
  %t562 = load i64, ptr %t526
  call void @emit(ptr %t0, ptr %t561, i64 %t562)
  %t564 = getelementptr [6 x i8], ptr @.str255, i64 0, i64 0
  %t565 = load i64, ptr %t526
  call void @emit(ptr %t0, ptr %t564, i64 %t565)
  %t567 = load ptr, ptr %t1
  %t568 = icmp ne ptr %t567, null
  br i1 %t568, label %L103, label %L104
L103:
  %t569 = alloca i64
  %t570 = load ptr, ptr %t1
  %t571 = call i64 @emit_expr(ptr %t0, ptr %t570)
  store i64 %t571, ptr %t569
  %t572 = alloca i64
  %t573 = load i64, ptr %t569
  %t574 = call i32 @emit_cond(ptr %t0, i64 %t573)
  %t575 = sext i32 %t574 to i64
  store i64 %t575, ptr %t572
  %t576 = getelementptr [41 x i8], ptr @.str256, i64 0, i64 0
  %t577 = load i64, ptr %t572
  %t578 = load i64, ptr %t529
  %t579 = load i64, ptr %t535
  call void @emit(ptr %t0, ptr %t576, i64 %t577, i64 %t578, i64 %t579)
  br label %L105
L104:
  %t581 = getelementptr [18 x i8], ptr @.str257, i64 0, i64 0
  %t582 = load i64, ptr %t529
  call void @emit(ptr %t0, ptr %t581, i64 %t582)
  br label %L105
L105:
  %t584 = getelementptr [6 x i8], ptr @.str258, i64 0, i64 0
  %t585 = load i64, ptr %t529
  call void @emit(ptr %t0, ptr %t584, i64 %t585)
  %t587 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t587)
  %t589 = getelementptr [18 x i8], ptr @.str259, i64 0, i64 0
  %t590 = load i64, ptr %t532
  call void @emit(ptr %t0, ptr %t589, i64 %t590)
  %t592 = getelementptr [6 x i8], ptr @.str260, i64 0, i64 0
  %t593 = load i64, ptr %t532
  call void @emit(ptr %t0, ptr %t592, i64 %t593)
  %t595 = load ptr, ptr %t1
  %t596 = icmp ne ptr %t595, null
  br i1 %t596, label %L106, label %L108
L106:
  %t597 = load ptr, ptr %t1
  %t598 = call i64 @emit_expr(ptr %t0, ptr %t597)
  br label %L108
L108:
  %t599 = getelementptr [18 x i8], ptr @.str261, i64 0, i64 0
  %t600 = load i64, ptr %t526
  call void @emit(ptr %t0, ptr %t599, i64 %t600)
  %t602 = getelementptr [6 x i8], ptr @.str262, i64 0, i64 0
  %t603 = load i64, ptr %t535
  call void @emit(ptr %t0, ptr %t602, i64 %t603)
  call void @scope_pop(ptr %t0)
  %t606 = load ptr, ptr %t0
  %t607 = load ptr, ptr %t538
  %t608 = call ptr @strcpy(ptr %t606, ptr %t607)
  %t609 = load ptr, ptr %t0
  %t610 = load ptr, ptr %t539
  %t611 = call ptr @strcpy(ptr %t609, ptr %t610)
  br label %L4
L109:
  br label %L13
L13:
  %t612 = getelementptr [17 x i8], ptr @.str263, i64 0, i64 0
  %t613 = load ptr, ptr %t0
  call void @emit(ptr %t0, ptr %t612, ptr %t613)
  %t615 = alloca i64
  %t616 = call i32 @new_label(ptr %t0)
  %t617 = sext i32 %t616 to i64
  store i64 %t617, ptr %t615
  %t618 = getelementptr [6 x i8], ptr @.str264, i64 0, i64 0
  %t619 = load i64, ptr %t615
  call void @emit(ptr %t0, ptr %t618, i64 %t619)
  br label %L4
L110:
  br label %L14
L14:
  %t621 = getelementptr [17 x i8], ptr @.str265, i64 0, i64 0
  %t622 = load ptr, ptr %t0
  call void @emit(ptr %t0, ptr %t621, ptr %t622)
  %t624 = alloca i64
  %t625 = call i32 @new_label(ptr %t0)
  %t626 = sext i32 %t625 to i64
  store i64 %t626, ptr %t624
  %t627 = getelementptr [6 x i8], ptr @.str266, i64 0, i64 0
  %t628 = load i64, ptr %t624
  call void @emit(ptr %t0, ptr %t627, i64 %t628)
  br label %L4
L111:
  br label %L15
L15:
  %t630 = alloca i64
  %t631 = load ptr, ptr %t1
  %t632 = call i64 @emit_expr(ptr %t0, ptr %t631)
  store i64 %t632, ptr %t630
  %t633 = alloca i64
  %t634 = call i32 @new_label(ptr %t0)
  %t635 = sext i32 %t634 to i64
  store i64 %t635, ptr %t633
  %t636 = alloca ptr
  %t637 = load ptr, ptr %t636
  %t638 = load ptr, ptr %t0
  %t639 = call ptr @strcpy(ptr %t637, ptr %t638)
  %t640 = load ptr, ptr %t0
  %t641 = getelementptr [4 x i8], ptr @.str267, i64 0, i64 0
  %t642 = load i64, ptr %t633
  %t643 = call i32 @snprintf(ptr %t640, i64 64, ptr %t641, i64 %t642)
  %t644 = sext i32 %t643 to i64
  %t645 = alloca ptr
  %t646 = load ptr, ptr %t1
  store ptr %t646, ptr %t645
  %t647 = alloca i64
  %t648 = sext i32 0 to i64
  store i64 %t648, ptr %t647
  %t649 = alloca ptr
  %t650 = alloca ptr
  %t651 = alloca i64
  %t652 = load i64, ptr %t633
  store i64 %t652, ptr %t651
  %t653 = alloca i64
  %t654 = sext i32 0 to i64
  store i64 %t654, ptr %t653
  br label %L112
L112:
  %t655 = load i64, ptr %t653
  %t656 = load ptr, ptr %t645
  %t657 = load ptr, ptr %t656
  %t659 = ptrtoint ptr %t657 to i64
  %t658 = icmp slt i64 %t655, %t659
  %t660 = zext i1 %t658 to i64
  %t661 = load i64, ptr %t647
  %t663 = sext i32 256 to i64
  %t662 = icmp slt i64 %t661, %t663
  %t664 = zext i1 %t662 to i64
  %t666 = icmp ne i64 %t660, 0
  %t667 = icmp ne i64 %t664, 0
  %t668 = and i1 %t666, %t667
  %t669 = zext i1 %t668 to i64
  %t670 = icmp ne i64 %t669, 0
  br i1 %t670, label %L113, label %L115
L113:
  %t671 = alloca ptr
  %t672 = load ptr, ptr %t645
  %t673 = load ptr, ptr %t672
  %t674 = load i64, ptr %t653
  %t675 = getelementptr i32, ptr %t673, i64 %t674
  %t676 = load i64, ptr %t675
  store i64 %t676, ptr %t671
  %t677 = load ptr, ptr %t671
  %t678 = load ptr, ptr %t677
  %t680 = ptrtoint ptr %t678 to i64
  %t681 = sext i32 14 to i64
  %t679 = icmp eq i64 %t680, %t681
  %t682 = zext i1 %t679 to i64
  %t683 = icmp ne i64 %t682, 0
  br i1 %t683, label %L116, label %L117
L116:
  %t684 = call i32 @new_label(ptr %t0)
  %t685 = sext i32 %t684 to i64
  %t686 = load ptr, ptr %t649
  %t687 = load i64, ptr %t647
  %t688 = getelementptr i8, ptr %t686, i64 %t687
  store i64 %t685, ptr %t688
  %t689 = load ptr, ptr %t671
  %t690 = load ptr, ptr %t689
  %t691 = icmp ne ptr %t690, null
  br i1 %t691, label %L119, label %L120
L119:
  %t692 = load ptr, ptr %t671
  %t693 = load ptr, ptr %t692
  %t694 = load ptr, ptr %t693
  %t695 = ptrtoint ptr %t694 to i64
  br label %L121
L120:
  %t696 = sext i32 0 to i64
  br label %L121
L121:
  %t697 = phi i64 [ %t695, %L119 ], [ %t696, %L120 ]
  %t698 = load ptr, ptr %t650
  %t699 = load i64, ptr %t647
  %t700 = getelementptr i8, ptr %t698, i64 %t699
  store i64 %t697, ptr %t700
  %t701 = load i64, ptr %t647
  %t702 = add i64 %t701, 1
  store i64 %t702, ptr %t647
  br label %L118
L117:
  %t703 = load ptr, ptr %t671
  %t704 = load ptr, ptr %t703
  %t706 = ptrtoint ptr %t704 to i64
  %t707 = sext i32 15 to i64
  %t705 = icmp eq i64 %t706, %t707
  %t708 = zext i1 %t705 to i64
  %t709 = icmp ne i64 %t708, 0
  br i1 %t709, label %L122, label %L124
L122:
  %t710 = call i32 @new_label(ptr %t0)
  %t711 = sext i32 %t710 to i64
  store i64 %t711, ptr %t651
  br label %L124
L124:
  br label %L118
L118:
  br label %L114
L114:
  %t712 = load i64, ptr %t653
  %t713 = add i64 %t712, 1
  store i64 %t713, ptr %t653
  br label %L112
L115:
  %t714 = alloca ptr
  %t715 = load i64, ptr %t630
  %t716 = load ptr, ptr %t714
  %t717 = call i32 @promote_to_i64(ptr %t0, i64 %t715, ptr %t716, i64 64)
  %t718 = sext i32 %t717 to i64
  %t719 = alloca i64
  %t720 = call i32 @new_reg(ptr %t0)
  %t721 = sext i32 %t720 to i64
  store i64 %t721, ptr %t719
  %t722 = getelementptr [25 x i8], ptr @.str268, i64 0, i64 0
  %t723 = load i64, ptr %t719
  %t724 = load ptr, ptr %t714
  call void @emit(ptr %t0, ptr %t722, i64 %t723, ptr %t724)
  %t726 = getelementptr [35 x i8], ptr @.str269, i64 0, i64 0
  %t727 = load i64, ptr %t719
  %t728 = load i64, ptr %t651
  call void @emit(ptr %t0, ptr %t726, i64 %t727, i64 %t728)
  %t730 = alloca i64
  %t731 = sext i32 0 to i64
  store i64 %t731, ptr %t730
  %t732 = alloca i64
  %t733 = sext i32 0 to i64
  store i64 %t733, ptr %t732
  br label %L125
L125:
  %t734 = load i64, ptr %t732
  %t735 = load ptr, ptr %t645
  %t736 = load ptr, ptr %t735
  %t738 = ptrtoint ptr %t736 to i64
  %t737 = icmp slt i64 %t734, %t738
  %t739 = zext i1 %t737 to i64
  %t740 = icmp ne i64 %t739, 0
  br i1 %t740, label %L126, label %L128
L126:
  %t741 = alloca ptr
  %t742 = load ptr, ptr %t645
  %t743 = load ptr, ptr %t742
  %t744 = load i64, ptr %t732
  %t745 = getelementptr i32, ptr %t743, i64 %t744
  %t746 = load i64, ptr %t745
  store i64 %t746, ptr %t741
  %t747 = load ptr, ptr %t741
  %t748 = load ptr, ptr %t747
  %t750 = ptrtoint ptr %t748 to i64
  %t751 = sext i32 14 to i64
  %t749 = icmp eq i64 %t750, %t751
  %t752 = zext i1 %t749 to i64
  %t753 = load i64, ptr %t730
  %t754 = load i64, ptr %t647
  %t755 = icmp slt i64 %t753, %t754
  %t756 = zext i1 %t755 to i64
  %t758 = icmp ne i64 %t752, 0
  %t759 = icmp ne i64 %t756, 0
  %t760 = and i1 %t758, %t759
  %t761 = zext i1 %t760 to i64
  %t762 = icmp ne i64 %t761, 0
  br i1 %t762, label %L129, label %L131
L129:
  %t763 = getelementptr [27 x i8], ptr @.str270, i64 0, i64 0
  %t764 = load ptr, ptr %t650
  %t765 = load i64, ptr %t730
  %t766 = getelementptr i32, ptr %t764, i64 %t765
  %t767 = load i64, ptr %t766
  %t768 = load ptr, ptr %t649
  %t769 = load i64, ptr %t730
  %t770 = getelementptr i32, ptr %t768, i64 %t769
  %t771 = load i64, ptr %t770
  call void @emit(ptr %t0, ptr %t763, i64 %t767, i64 %t771)
  %t773 = load i64, ptr %t730
  %t774 = add i64 %t773, 1
  store i64 %t774, ptr %t730
  br label %L131
L131:
  br label %L127
L127:
  %t775 = load i64, ptr %t732
  %t776 = add i64 %t775, 1
  store i64 %t776, ptr %t732
  br label %L125
L128:
  %t777 = getelementptr [5 x i8], ptr @.str271, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t777)
  %t779 = sext i32 0 to i64
  store i64 %t779, ptr %t730
  %t780 = alloca i64
  %t781 = sext i32 0 to i64
  store i64 %t781, ptr %t780
  %t782 = alloca i64
  %t783 = sext i32 0 to i64
  store i64 %t783, ptr %t782
  br label %L132
L132:
  %t784 = load i64, ptr %t782
  %t785 = load ptr, ptr %t645
  %t786 = load ptr, ptr %t785
  %t788 = ptrtoint ptr %t786 to i64
  %t787 = icmp slt i64 %t784, %t788
  %t789 = zext i1 %t787 to i64
  %t790 = icmp ne i64 %t789, 0
  br i1 %t790, label %L133, label %L135
L133:
  %t791 = alloca ptr
  %t792 = load ptr, ptr %t645
  %t793 = load ptr, ptr %t792
  %t794 = load i64, ptr %t782
  %t795 = getelementptr i32, ptr %t793, i64 %t794
  %t796 = load i64, ptr %t795
  store i64 %t796, ptr %t791
  %t797 = load ptr, ptr %t791
  %t798 = load ptr, ptr %t797
  %t800 = ptrtoint ptr %t798 to i64
  %t801 = sext i32 14 to i64
  %t799 = icmp eq i64 %t800, %t801
  %t802 = zext i1 %t799 to i64
  %t803 = load i64, ptr %t730
  %t804 = load i64, ptr %t647
  %t805 = icmp slt i64 %t803, %t804
  %t806 = zext i1 %t805 to i64
  %t808 = icmp ne i64 %t802, 0
  %t809 = icmp ne i64 %t806, 0
  %t810 = and i1 %t808, %t809
  %t811 = zext i1 %t810 to i64
  %t812 = icmp ne i64 %t811, 0
  br i1 %t812, label %L136, label %L137
L136:
  %t813 = getelementptr [6 x i8], ptr @.str272, i64 0, i64 0
  %t814 = load ptr, ptr %t649
  %t815 = load i64, ptr %t730
  %t816 = add i64 %t815, 1
  store i64 %t816, ptr %t730
  %t817 = getelementptr i32, ptr %t814, i64 %t815
  %t818 = load i64, ptr %t817
  call void @emit(ptr %t0, ptr %t813, i64 %t818)
  %t820 = load ptr, ptr %t791
  %t821 = load ptr, ptr %t820
  %t823 = ptrtoint ptr %t821 to i64
  %t824 = sext i32 0 to i64
  %t822 = icmp sgt i64 %t823, %t824
  %t825 = zext i1 %t822 to i64
  %t826 = icmp ne i64 %t825, 0
  br i1 %t826, label %L139, label %L141
L139:
  %t827 = load ptr, ptr %t791
  %t828 = load ptr, ptr %t827
  %t829 = sext i32 0 to i64
  %t830 = getelementptr i32, ptr %t828, i64 %t829
  %t831 = load i64, ptr %t830
  call void @emit_stmt(ptr %t0, i64 %t831)
  br label %L141
L141:
  %t833 = alloca i64
  %t834 = load i64, ptr %t730
  %t835 = load i64, ptr %t647
  %t836 = icmp slt i64 %t834, %t835
  %t837 = zext i1 %t836 to i64
  %t838 = icmp ne i64 %t837, 0
  br i1 %t838, label %L142, label %L143
L142:
  %t839 = load ptr, ptr %t649
  %t840 = load i64, ptr %t730
  %t841 = getelementptr i32, ptr %t839, i64 %t840
  %t842 = load i64, ptr %t841
  br label %L144
L143:
  %t843 = load i64, ptr %t633
  br label %L144
L144:
  %t844 = phi i64 [ %t842, %L142 ], [ %t843, %L143 ]
  store i64 %t844, ptr %t833
  %t845 = getelementptr [18 x i8], ptr @.str273, i64 0, i64 0
  %t846 = load i64, ptr %t833
  call void @emit(ptr %t0, ptr %t845, i64 %t846)
  br label %L138
L137:
  %t848 = load ptr, ptr %t791
  %t849 = load ptr, ptr %t848
  %t851 = ptrtoint ptr %t849 to i64
  %t852 = sext i32 15 to i64
  %t850 = icmp eq i64 %t851, %t852
  %t853 = zext i1 %t850 to i64
  %t854 = icmp ne i64 %t853, 0
  br i1 %t854, label %L145, label %L146
L145:
  %t855 = getelementptr [6 x i8], ptr @.str274, i64 0, i64 0
  %t856 = load i64, ptr %t651
  call void @emit(ptr %t0, ptr %t855, i64 %t856)
  %t858 = load ptr, ptr %t791
  %t859 = load ptr, ptr %t858
  %t861 = ptrtoint ptr %t859 to i64
  %t862 = sext i32 0 to i64
  %t860 = icmp sgt i64 %t861, %t862
  %t863 = zext i1 %t860 to i64
  %t864 = icmp ne i64 %t863, 0
  br i1 %t864, label %L148, label %L150
L148:
  %t865 = load ptr, ptr %t791
  %t866 = load ptr, ptr %t865
  %t867 = sext i32 0 to i64
  %t868 = getelementptr i32, ptr %t866, i64 %t867
  %t869 = load i64, ptr %t868
  call void @emit_stmt(ptr %t0, i64 %t869)
  br label %L150
L150:
  %t871 = getelementptr [18 x i8], ptr @.str275, i64 0, i64 0
  %t872 = load i64, ptr %t633
  call void @emit(ptr %t0, ptr %t871, i64 %t872)
  %t874 = load i64, ptr %t780
  %t875 = add i64 %t874, 1
  store i64 %t875, ptr %t780
  br label %L147
L146:
  %t876 = load ptr, ptr %t791
  call void @emit_stmt(ptr %t0, ptr %t876)
  br label %L147
L147:
  br label %L138
L138:
  br label %L134
L134:
  %t878 = load i64, ptr %t782
  %t879 = add i64 %t878, 1
  store i64 %t879, ptr %t782
  br label %L132
L135:
  %t880 = getelementptr [6 x i8], ptr @.str276, i64 0, i64 0
  %t881 = load i64, ptr %t633
  call void @emit(ptr %t0, ptr %t880, i64 %t881)
  %t883 = load ptr, ptr %t0
  %t884 = load ptr, ptr %t636
  %t885 = call ptr @strcpy(ptr %t883, ptr %t884)
  br label %L4
L151:
  br label %L16
L16:
  %t886 = load ptr, ptr %t1
  %t888 = ptrtoint ptr %t886 to i64
  %t889 = sext i32 0 to i64
  %t887 = icmp sgt i64 %t888, %t889
  %t890 = zext i1 %t887 to i64
  %t891 = icmp ne i64 %t890, 0
  br i1 %t891, label %L152, label %L154
L152:
  %t892 = load ptr, ptr %t1
  %t893 = sext i32 0 to i64
  %t894 = getelementptr i32, ptr %t892, i64 %t893
  %t895 = load i64, ptr %t894
  call void @emit_stmt(ptr %t0, i64 %t895)
  br label %L154
L154:
  br label %L4
L155:
  br label %L17
L17:
  %t897 = load ptr, ptr %t1
  %t899 = ptrtoint ptr %t897 to i64
  %t900 = sext i32 0 to i64
  %t898 = icmp sgt i64 %t899, %t900
  %t901 = zext i1 %t898 to i64
  %t902 = icmp ne i64 %t901, 0
  br i1 %t902, label %L156, label %L158
L156:
  %t903 = load ptr, ptr %t1
  %t904 = sext i32 0 to i64
  %t905 = getelementptr i32, ptr %t903, i64 %t904
  %t906 = load i64, ptr %t905
  call void @emit_stmt(ptr %t0, i64 %t906)
  br label %L158
L158:
  br label %L4
L159:
  br label %L18
L18:
  %t908 = getelementptr [17 x i8], ptr @.str277, i64 0, i64 0
  %t909 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t908, ptr %t909)
  %t911 = getelementptr [5 x i8], ptr @.str278, i64 0, i64 0
  %t912 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t911, ptr %t912)
  %t914 = load ptr, ptr %t1
  %t916 = ptrtoint ptr %t914 to i64
  %t917 = sext i32 0 to i64
  %t915 = icmp sgt i64 %t916, %t917
  %t918 = zext i1 %t915 to i64
  %t919 = icmp ne i64 %t918, 0
  br i1 %t919, label %L160, label %L162
L160:
  %t920 = load ptr, ptr %t1
  %t921 = sext i32 0 to i64
  %t922 = getelementptr i32, ptr %t920, i64 %t921
  %t923 = load i64, ptr %t922
  call void @emit_stmt(ptr %t0, i64 %t923)
  br label %L162
L162:
  br label %L4
L163:
  br label %L19
L19:
  %t925 = getelementptr [17 x i8], ptr @.str279, i64 0, i64 0
  %t926 = load ptr, ptr %t1
  call void @emit(ptr %t0, ptr %t925, ptr %t926)
  %t928 = alloca i64
  %t929 = call i32 @new_label(ptr %t0)
  %t930 = sext i32 %t929 to i64
  store i64 %t930, ptr %t928
  %t931 = getelementptr [6 x i8], ptr @.str280, i64 0, i64 0
  %t932 = load i64, ptr %t928
  call void @emit(ptr %t0, ptr %t931, i64 %t932)
  br label %L4
L164:
  br label %L20
L20:
  br label %L4
L165:
  br label %L4
L21:
  %t934 = call i64 @emit_expr(ptr %t0, ptr %t1)
  br label %L4
L166:
  br label %L4
L4:
  ret void
}

define internal void @emit_func_def(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca ptr
  %t3 = load ptr, ptr %t1
  store ptr %t3, ptr %t2
  %t4 = load ptr, ptr %t2
  %t6 = ptrtoint ptr %t4 to i64
  %t7 = icmp eq i64 %t6, 0
  %t5 = zext i1 %t7 to i64
  %t8 = load ptr, ptr %t2
  %t9 = load ptr, ptr %t8
  %t11 = ptrtoint ptr %t9 to i64
  %t12 = sext i32 17 to i64
  %t10 = icmp ne i64 %t11, %t12
  %t13 = zext i1 %t10 to i64
  %t15 = icmp ne i64 %t5, 0
  %t16 = icmp ne i64 %t13, 0
  %t17 = or i1 %t15, %t16
  %t18 = zext i1 %t17 to i64
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %t20 = sext i32 0 to i64
  store i64 %t20, ptr %t0
  %t21 = sext i32 0 to i64
  store i64 %t21, ptr %t0
  %t22 = sext i32 0 to i64
  store i64 %t22, ptr %t0
  %t23 = load ptr, ptr %t2
  %t24 = load ptr, ptr %t23
  %t25 = icmp ne ptr %t24, null
  br i1 %t25, label %L4, label %L5
L4:
  %t26 = load ptr, ptr %t2
  %t27 = load ptr, ptr %t26
  %t28 = ptrtoint ptr %t27 to i64
  br label %L6
L5:
  %t29 = call ptr @default_int_type()
  %t30 = ptrtoint ptr %t29 to i64
  br label %L6
L6:
  %t31 = phi i64 [ %t28, %L4 ], [ %t30, %L5 ]
  store i64 %t31, ptr %t0
  %t32 = load ptr, ptr %t0
  %t33 = load ptr, ptr %t1
  %t34 = icmp ne ptr %t33, null
  br i1 %t34, label %L7, label %L8
L7:
  %t35 = load ptr, ptr %t1
  %t36 = ptrtoint ptr %t35 to i64
  br label %L9
L8:
  %t37 = getelementptr [5 x i8], ptr @.str281, i64 0, i64 0
  %t38 = ptrtoint ptr %t37 to i64
  br label %L9
L9:
  %t39 = phi i64 [ %t36, %L7 ], [ %t38, %L8 ]
  %t40 = call ptr @strncpy(ptr %t32, i64 %t39, i64 127)
  %t41 = alloca ptr
  %t42 = load ptr, ptr %t1
  %t43 = icmp ne ptr %t42, null
  br i1 %t43, label %L10, label %L11
L10:
  %t44 = getelementptr [9 x i8], ptr @.str282, i64 0, i64 0
  %t45 = ptrtoint ptr %t44 to i64
  br label %L12
L11:
  %t46 = getelementptr [10 x i8], ptr @.str283, i64 0, i64 0
  %t47 = ptrtoint ptr %t46 to i64
  br label %L12
L12:
  %t48 = phi i64 [ %t45, %L10 ], [ %t47, %L11 ]
  store i64 %t48, ptr %t41
  %t49 = getelementptr [18 x i8], ptr @.str284, i64 0, i64 0
  %t50 = load ptr, ptr %t41
  %t51 = load ptr, ptr %t2
  %t52 = call ptr @llvm_ret_type(ptr %t51)
  %t53 = load ptr, ptr %t1
  %t54 = icmp ne ptr %t53, null
  br i1 %t54, label %L13, label %L14
L13:
  %t55 = load ptr, ptr %t1
  %t56 = ptrtoint ptr %t55 to i64
  br label %L15
L14:
  %t57 = getelementptr [5 x i8], ptr @.str285, i64 0, i64 0
  %t58 = ptrtoint ptr %t57 to i64
  br label %L15
L15:
  %t59 = phi i64 [ %t56, %L13 ], [ %t58, %L14 ]
  call void @emit(ptr %t0, ptr %t49, ptr %t50, ptr %t52, i64 %t59)
  call void @scope_push(ptr %t0)
  %t62 = alloca i64
  %t63 = sext i32 0 to i64
  store i64 %t63, ptr %t62
  %t64 = alloca i64
  %t65 = sext i32 0 to i64
  store i64 %t65, ptr %t64
  br label %L16
L16:
  %t66 = load i64, ptr %t64
  %t67 = load ptr, ptr %t2
  %t68 = load ptr, ptr %t67
  %t70 = ptrtoint ptr %t68 to i64
  %t69 = icmp slt i64 %t66, %t70
  %t71 = zext i1 %t69 to i64
  %t72 = icmp ne i64 %t71, 0
  br i1 %t72, label %L17, label %L19
L17:
  %t73 = alloca ptr
  %t74 = load ptr, ptr %t2
  %t75 = load ptr, ptr %t74
  %t76 = load i64, ptr %t64
  %t77 = getelementptr i8, ptr %t75, i64 %t76
  %t78 = load ptr, ptr %t77
  store ptr %t78, ptr %t73
  %t79 = load ptr, ptr %t73
  %t80 = load ptr, ptr %t73
  %t81 = load ptr, ptr %t80
  %t83 = ptrtoint ptr %t81 to i64
  %t84 = sext i32 0 to i64
  %t82 = icmp eq i64 %t83, %t84
  %t85 = zext i1 %t82 to i64
  %t87 = ptrtoint ptr %t79 to i64
  %t91 = ptrtoint ptr %t79 to i64
  %t88 = icmp ne i64 %t91, 0
  %t89 = icmp ne i64 %t85, 0
  %t90 = and i1 %t88, %t89
  %t92 = zext i1 %t90 to i64
  %t93 = load ptr, ptr %t2
  %t94 = load ptr, ptr %t93
  %t96 = ptrtoint ptr %t94 to i64
  %t97 = sext i32 1 to i64
  %t95 = icmp eq i64 %t96, %t97
  %t98 = zext i1 %t95 to i64
  %t100 = icmp ne i64 %t92, 0
  %t101 = icmp ne i64 %t98, 0
  %t102 = and i1 %t100, %t101
  %t103 = zext i1 %t102 to i64
  %t104 = icmp ne i64 %t103, 0
  br i1 %t104, label %L20, label %L22
L20:
  br label %L19
L23:
  br label %L22
L22:
  %t105 = load i64, ptr %t62
  %t106 = icmp ne i64 %t105, 0
  br i1 %t106, label %L24, label %L26
L24:
  %t107 = getelementptr [3 x i8], ptr @.str286, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t107)
  br label %L26
L26:
  %t109 = alloca ptr
  %t110 = alloca ptr
  %t111 = load ptr, ptr %t73
  %t113 = ptrtoint ptr %t111 to i64
  %t114 = icmp eq i64 %t113, 0
  %t112 = zext i1 %t114 to i64
  %t115 = load ptr, ptr %t73
  %t116 = call i32 @type_is_fp(ptr %t115)
  %t117 = sext i32 %t116 to i64
  %t119 = icmp ne i64 %t112, 0
  %t120 = icmp ne i64 %t117, 0
  %t121 = or i1 %t119, %t120
  %t122 = zext i1 %t121 to i64
  %t123 = icmp ne i64 %t122, 0
  br i1 %t123, label %L27, label %L28
L27:
  %t124 = load ptr, ptr %t73
  %t125 = icmp ne ptr %t124, null
  br i1 %t125, label %L30, label %L31
L30:
  %t126 = load ptr, ptr %t73
  %t127 = call ptr @llvm_type(ptr %t126)
  %t128 = ptrtoint ptr %t127 to i64
  br label %L32
L31:
  %t129 = getelementptr [4 x i8], ptr @.str287, i64 0, i64 0
  %t130 = ptrtoint ptr %t129 to i64
  br label %L32
L32:
  %t131 = phi i64 [ %t128, %L30 ], [ %t130, %L31 ]
  store i64 %t131, ptr %t109
  %t132 = load ptr, ptr %t73
  store ptr %t132, ptr %t110
  br label %L29
L28:
  %t133 = load ptr, ptr %t73
  %t134 = load ptr, ptr %t133
  %t136 = ptrtoint ptr %t134 to i64
  %t137 = sext i32 15 to i64
  %t135 = icmp eq i64 %t136, %t137
  %t138 = zext i1 %t135 to i64
  %t139 = load ptr, ptr %t73
  %t140 = load ptr, ptr %t139
  %t142 = ptrtoint ptr %t140 to i64
  %t143 = sext i32 16 to i64
  %t141 = icmp eq i64 %t142, %t143
  %t144 = zext i1 %t141 to i64
  %t146 = icmp ne i64 %t138, 0
  %t147 = icmp ne i64 %t144, 0
  %t148 = or i1 %t146, %t147
  %t149 = zext i1 %t148 to i64
  %t150 = icmp ne i64 %t149, 0
  br i1 %t150, label %L33, label %L34
L33:
  %t151 = getelementptr [4 x i8], ptr @.str288, i64 0, i64 0
  store ptr %t151, ptr %t109
  %t152 = call ptr @default_ptr_type()
  store ptr %t152, ptr %t110
  br label %L35
L34:
  %t153 = load ptr, ptr %t73
  %t154 = load ptr, ptr %t153
  %t156 = ptrtoint ptr %t154 to i64
  %t157 = sext i32 18 to i64
  %t155 = icmp eq i64 %t156, %t157
  %t158 = zext i1 %t155 to i64
  %t159 = load ptr, ptr %t73
  %t160 = load ptr, ptr %t159
  %t162 = ptrtoint ptr %t160 to i64
  %t163 = sext i32 19 to i64
  %t161 = icmp eq i64 %t162, %t163
  %t164 = zext i1 %t161 to i64
  %t166 = icmp ne i64 %t158, 0
  %t167 = icmp ne i64 %t164, 0
  %t168 = or i1 %t166, %t167
  %t169 = zext i1 %t168 to i64
  %t170 = load ptr, ptr %t73
  %t171 = load ptr, ptr %t170
  %t173 = ptrtoint ptr %t171 to i64
  %t174 = sext i32 21 to i64
  %t172 = icmp eq i64 %t173, %t174
  %t175 = zext i1 %t172 to i64
  %t177 = icmp ne i64 %t169, 0
  %t178 = icmp ne i64 %t175, 0
  %t179 = or i1 %t177, %t178
  %t180 = zext i1 %t179 to i64
  %t181 = icmp ne i64 %t180, 0
  br i1 %t181, label %L36, label %L37
L36:
  %t182 = getelementptr [4 x i8], ptr @.str289, i64 0, i64 0
  store ptr %t182, ptr %t109
  %t183 = call ptr @default_ptr_type()
  store ptr %t183, ptr %t110
  br label %L38
L37:
  %t184 = getelementptr [4 x i8], ptr @.str290, i64 0, i64 0
  store ptr %t184, ptr %t109
  %t185 = call ptr @default_i64_type()
  store ptr %t185, ptr %t110
  br label %L38
L38:
  br label %L35
L35:
  br label %L29
L29:
  %t186 = alloca i64
  %t187 = call i32 @new_reg(ptr %t0)
  %t188 = sext i32 %t187 to i64
  store i64 %t188, ptr %t186
  %t189 = getelementptr [9 x i8], ptr @.str291, i64 0, i64 0
  %t190 = load ptr, ptr %t109
  %t191 = load i64, ptr %t186
  call void @emit(ptr %t0, ptr %t189, ptr %t190, i64 %t191)
  %t193 = load i64, ptr %t62
  %t194 = add i64 %t193, 1
  store i64 %t194, ptr %t62
  %t195 = load ptr, ptr %t1
  %t196 = load ptr, ptr %t1
  %t197 = load i64, ptr %t64
  %t198 = getelementptr i32, ptr %t196, i64 %t197
  %t199 = load i64, ptr %t198
  %t201 = ptrtoint ptr %t195 to i64
  %t205 = ptrtoint ptr %t195 to i64
  %t202 = icmp ne i64 %t205, 0
  %t203 = icmp ne i64 %t199, 0
  %t204 = and i1 %t202, %t203
  %t206 = zext i1 %t204 to i64
  %t207 = icmp ne i64 %t206, 0
  br i1 %t207, label %L39, label %L41
L39:
  %t208 = load ptr, ptr %t0
  %t210 = ptrtoint ptr %t208 to i64
  %t211 = sext i32 2048 to i64
  %t209 = icmp slt i64 %t210, %t211
  %t212 = zext i1 %t209 to i64
  %t213 = call i32 @assert(i64 %t212)
  %t214 = sext i32 %t213 to i64
  %t215 = alloca ptr
  %t216 = load ptr, ptr %t0
  %t217 = load ptr, ptr %t0
  %t219 = ptrtoint ptr %t217 to i64
  %t218 = add i64 %t219, 1
  store i64 %t218, ptr %t0
  %t221 = ptrtoint ptr %t217 to i64
  %t220 = getelementptr i8, ptr %t216, i64 %t221
  store ptr %t220, ptr %t215
  %t222 = load ptr, ptr %t1
  %t223 = load i64, ptr %t64
  %t224 = getelementptr i32, ptr %t222, i64 %t223
  %t225 = load i64, ptr %t224
  %t226 = call ptr @strdup(i64 %t225)
  %t227 = load ptr, ptr %t215
  store ptr %t226, ptr %t227
  %t228 = call ptr @malloc(i64 32)
  %t229 = load ptr, ptr %t215
  store ptr %t228, ptr %t229
  %t230 = load ptr, ptr %t215
  %t231 = load ptr, ptr %t230
  %t232 = getelementptr [6 x i8], ptr @.str292, i64 0, i64 0
  %t233 = load i64, ptr %t186
  %t234 = call i32 @snprintf(ptr %t231, i64 32, ptr %t232, i64 %t233)
  %t235 = sext i32 %t234 to i64
  %t236 = load ptr, ptr %t110
  %t237 = load ptr, ptr %t215
  store ptr %t236, ptr %t237
  %t238 = load ptr, ptr %t215
  %t239 = sext i32 1 to i64
  store i64 %t239, ptr %t238
  br label %L41
L41:
  br label %L18
L18:
  %t240 = load i64, ptr %t64
  %t241 = add i64 %t240, 1
  store i64 %t241, ptr %t64
  br label %L16
L19:
  %t242 = load ptr, ptr %t2
  %t243 = load ptr, ptr %t242
  %t244 = icmp ne ptr %t243, null
  br i1 %t244, label %L42, label %L44
L42:
  %t245 = load i64, ptr %t62
  %t246 = icmp ne i64 %t245, 0
  br i1 %t246, label %L45, label %L47
L45:
  %t247 = getelementptr [3 x i8], ptr @.str293, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t247)
  br label %L47
L47:
  %t249 = getelementptr [4 x i8], ptr @.str294, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t249)
  br label %L44
L44:
  %t251 = getelementptr [5 x i8], ptr @.str295, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t251)
  %t253 = getelementptr [8 x i8], ptr @.str296, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t253)
  %t255 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t255)
  %t257 = load ptr, ptr %t2
  %t258 = load ptr, ptr %t257
  %t260 = ptrtoint ptr %t258 to i64
  %t261 = icmp eq i64 %t260, 0
  %t259 = zext i1 %t261 to i64
  %t262 = load ptr, ptr %t2
  %t263 = load ptr, ptr %t262
  %t264 = load ptr, ptr %t263
  %t266 = ptrtoint ptr %t264 to i64
  %t267 = sext i32 0 to i64
  %t265 = icmp eq i64 %t266, %t267
  %t268 = zext i1 %t265 to i64
  %t270 = icmp ne i64 %t259, 0
  %t271 = icmp ne i64 %t268, 0
  %t272 = or i1 %t270, %t271
  %t273 = zext i1 %t272 to i64
  %t274 = icmp ne i64 %t273, 0
  br i1 %t274, label %L48, label %L49
L48:
  %t275 = getelementptr [12 x i8], ptr @.str297, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t275)
  br label %L50
L49:
  %t277 = load ptr, ptr %t2
  %t278 = load ptr, ptr %t277
  %t279 = load ptr, ptr %t278
  %t281 = ptrtoint ptr %t279 to i64
  %t282 = sext i32 15 to i64
  %t280 = icmp eq i64 %t281, %t282
  %t283 = zext i1 %t280 to i64
  %t284 = load ptr, ptr %t2
  %t285 = load ptr, ptr %t284
  %t286 = load ptr, ptr %t285
  %t288 = ptrtoint ptr %t286 to i64
  %t289 = sext i32 16 to i64
  %t287 = icmp eq i64 %t288, %t289
  %t290 = zext i1 %t287 to i64
  %t292 = icmp ne i64 %t283, 0
  %t293 = icmp ne i64 %t290, 0
  %t294 = or i1 %t292, %t293
  %t295 = zext i1 %t294 to i64
  %t296 = icmp ne i64 %t295, 0
  br i1 %t296, label %L51, label %L52
L51:
  %t297 = getelementptr [16 x i8], ptr @.str298, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t297)
  br label %L53
L52:
  %t299 = load ptr, ptr %t2
  %t300 = load ptr, ptr %t299
  %t301 = call i32 @type_is_fp(ptr %t300)
  %t302 = sext i32 %t301 to i64
  %t303 = icmp ne i64 %t302, 0
  br i1 %t303, label %L54, label %L55
L54:
  %t304 = getelementptr [14 x i8], ptr @.str299, i64 0, i64 0
  %t305 = load ptr, ptr %t2
  %t306 = load ptr, ptr %t305
  %t307 = call ptr @llvm_type(ptr %t306)
  call void @emit(ptr %t0, ptr %t304, ptr %t307)
  br label %L56
L55:
  %t309 = alloca ptr
  %t310 = load ptr, ptr %t2
  %t311 = load ptr, ptr %t310
  %t312 = call ptr @llvm_type(ptr %t311)
  store ptr %t312, ptr %t309
  %t313 = load ptr, ptr %t309
  %t314 = getelementptr [3 x i8], ptr @.str300, i64 0, i64 0
  %t315 = call i32 @strcmp(ptr %t313, ptr %t314)
  %t316 = sext i32 %t315 to i64
  %t318 = sext i32 0 to i64
  %t317 = icmp eq i64 %t316, %t318
  %t319 = zext i1 %t317 to i64
  %t320 = icmp ne i64 %t319, 0
  br i1 %t320, label %L57, label %L58
L57:
  %t321 = getelementptr [12 x i8], ptr @.str301, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t321)
  br label %L59
L58:
  %t323 = load ptr, ptr %t309
  %t324 = getelementptr [4 x i8], ptr @.str302, i64 0, i64 0
  %t325 = call i32 @strcmp(ptr %t323, ptr %t324)
  %t326 = sext i32 %t325 to i64
  %t328 = sext i32 0 to i64
  %t327 = icmp eq i64 %t326, %t328
  %t329 = zext i1 %t327 to i64
  %t330 = icmp ne i64 %t329, 0
  br i1 %t330, label %L60, label %L61
L60:
  %t331 = getelementptr [13 x i8], ptr @.str303, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t331)
  br label %L62
L61:
  %t333 = load ptr, ptr %t309
  %t334 = getelementptr [4 x i8], ptr @.str304, i64 0, i64 0
  %t335 = call i32 @strcmp(ptr %t333, ptr %t334)
  %t336 = sext i32 %t335 to i64
  %t338 = sext i32 0 to i64
  %t337 = icmp eq i64 %t336, %t338
  %t339 = zext i1 %t337 to i64
  %t340 = icmp ne i64 %t339, 0
  br i1 %t340, label %L63, label %L64
L63:
  %t341 = getelementptr [13 x i8], ptr @.str305, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t341)
  br label %L65
L64:
  %t343 = getelementptr [13 x i8], ptr @.str306, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t343)
  br label %L65
L65:
  br label %L62
L62:
  br label %L59
L59:
  br label %L56
L56:
  br label %L53
L53:
  br label %L50
L50:
  %t345 = getelementptr [4 x i8], ptr @.str307, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t345)
  call void @scope_pop(ptr %t0)
  ret void
}

define internal void @emit_global_var(ptr %t0, ptr %t1) {
entry:
  %t2 = load ptr, ptr %t1
  %t4 = ptrtoint ptr %t2 to i64
  %t5 = icmp eq i64 %t4, 0
  %t3 = zext i1 %t5 to i64
  %t6 = icmp ne i64 %t3, 0
  br i1 %t6, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %t7 = alloca ptr
  %t8 = load ptr, ptr %t1
  store ptr %t8, ptr %t7
  %t9 = load ptr, ptr %t7
  %t10 = load ptr, ptr %t7
  %t11 = load ptr, ptr %t10
  %t13 = ptrtoint ptr %t11 to i64
  %t14 = sext i32 17 to i64
  %t12 = icmp eq i64 %t13, %t14
  %t15 = zext i1 %t12 to i64
  %t17 = ptrtoint ptr %t9 to i64
  %t21 = ptrtoint ptr %t9 to i64
  %t18 = icmp ne i64 %t21, 0
  %t19 = icmp ne i64 %t15, 0
  %t20 = and i1 %t18, %t19
  %t22 = zext i1 %t20 to i64
  %t23 = icmp ne i64 %t22, 0
  br i1 %t23, label %L4, label %L6
L4:
  %t24 = alloca i64
  %t25 = sext i32 0 to i64
  store i64 %t25, ptr %t24
  %t26 = alloca i64
  %t27 = sext i32 0 to i64
  store i64 %t27, ptr %t26
  br label %L7
L7:
  %t28 = load i64, ptr %t26
  %t29 = load ptr, ptr %t0
  %t31 = ptrtoint ptr %t29 to i64
  %t30 = icmp slt i64 %t28, %t31
  %t32 = zext i1 %t30 to i64
  %t33 = icmp ne i64 %t32, 0
  br i1 %t33, label %L8, label %L10
L8:
  %t34 = load ptr, ptr %t0
  %t35 = load i64, ptr %t26
  %t36 = getelementptr i8, ptr %t34, i64 %t35
  %t37 = load ptr, ptr %t36
  %t38 = load ptr, ptr %t1
  %t39 = call i32 @strcmp(ptr %t37, ptr %t38)
  %t40 = sext i32 %t39 to i64
  %t42 = sext i32 0 to i64
  %t41 = icmp eq i64 %t40, %t42
  %t43 = zext i1 %t41 to i64
  %t44 = icmp ne i64 %t43, 0
  br i1 %t44, label %L11, label %L13
L11:
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t24
  br label %L10
L14:
  br label %L13
L13:
  br label %L9
L9:
  %t46 = load i64, ptr %t26
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t26
  br label %L7
L10:
  %t48 = load i64, ptr %t24
  %t49 = icmp ne i64 %t48, 0
  br i1 %t49, label %L15, label %L17
L15:
  ret void
L18:
  br label %L17
L17:
  %t50 = load ptr, ptr %t0
  %t52 = ptrtoint ptr %t50 to i64
  %t53 = sext i32 2048 to i64
  %t51 = icmp slt i64 %t52, %t53
  %t54 = zext i1 %t51 to i64
  %t55 = icmp ne i64 %t54, 0
  br i1 %t55, label %L19, label %L21
L19:
  %t56 = load ptr, ptr %t1
  %t57 = call ptr @strdup(ptr %t56)
  %t58 = load ptr, ptr %t0
  %t59 = load ptr, ptr %t0
  %t61 = ptrtoint ptr %t59 to i64
  %t60 = getelementptr i8, ptr %t58, i64 %t61
  store ptr %t57, ptr %t60
  %t62 = load ptr, ptr %t7
  %t63 = load ptr, ptr %t0
  %t64 = load ptr, ptr %t0
  %t66 = ptrtoint ptr %t64 to i64
  %t65 = getelementptr i8, ptr %t63, i64 %t66
  store ptr %t62, ptr %t65
  %t67 = load ptr, ptr %t0
  %t68 = load ptr, ptr %t0
  %t70 = ptrtoint ptr %t68 to i64
  %t69 = getelementptr i8, ptr %t67, i64 %t70
  %t71 = sext i32 1 to i64
  store i64 %t71, ptr %t69
  %t72 = load ptr, ptr %t0
  %t74 = ptrtoint ptr %t72 to i64
  %t73 = add i64 %t74, 1
  store i64 %t73, ptr %t0
  br label %L21
L21:
  %t75 = alloca ptr
  %t76 = sext i32 0 to i64
  store i64 %t76, ptr %t75
  %t77 = alloca i64
  %t78 = sext i32 0 to i64
  store i64 %t78, ptr %t77
  %t79 = alloca i64
  %t80 = sext i32 0 to i64
  store i64 %t80, ptr %t79
  br label %L22
L22:
  %t81 = load i64, ptr %t79
  %t82 = load ptr, ptr %t7
  %t83 = load ptr, ptr %t82
  %t85 = ptrtoint ptr %t83 to i64
  %t84 = icmp slt i64 %t81, %t85
  %t86 = zext i1 %t84 to i64
  %t87 = load i64, ptr %t77
  %t89 = sext i32 480 to i64
  %t88 = icmp slt i64 %t87, %t89
  %t90 = zext i1 %t88 to i64
  %t92 = icmp ne i64 %t86, 0
  %t93 = icmp ne i64 %t90, 0
  %t94 = and i1 %t92, %t93
  %t95 = zext i1 %t94 to i64
  %t96 = icmp ne i64 %t95, 0
  br i1 %t96, label %L23, label %L25
L23:
  %t97 = alloca ptr
  %t98 = load ptr, ptr %t7
  %t99 = load ptr, ptr %t98
  %t100 = load i64, ptr %t79
  %t101 = getelementptr i8, ptr %t99, i64 %t100
  %t102 = load ptr, ptr %t101
  store ptr %t102, ptr %t97
  %t103 = load ptr, ptr %t97
  %t104 = load ptr, ptr %t97
  %t105 = load ptr, ptr %t104
  %t107 = ptrtoint ptr %t105 to i64
  %t108 = sext i32 0 to i64
  %t106 = icmp eq i64 %t107, %t108
  %t109 = zext i1 %t106 to i64
  %t111 = ptrtoint ptr %t103 to i64
  %t115 = ptrtoint ptr %t103 to i64
  %t112 = icmp ne i64 %t115, 0
  %t113 = icmp ne i64 %t109, 0
  %t114 = and i1 %t112, %t113
  %t116 = zext i1 %t114 to i64
  %t117 = load ptr, ptr %t7
  %t118 = load ptr, ptr %t117
  %t120 = ptrtoint ptr %t118 to i64
  %t121 = sext i32 1 to i64
  %t119 = icmp eq i64 %t120, %t121
  %t122 = zext i1 %t119 to i64
  %t124 = icmp ne i64 %t116, 0
  %t125 = icmp ne i64 %t122, 0
  %t126 = and i1 %t124, %t125
  %t127 = zext i1 %t126 to i64
  %t128 = icmp ne i64 %t127, 0
  br i1 %t128, label %L26, label %L28
L26:
  br label %L25
L29:
  br label %L28
L28:
  %t129 = load i64, ptr %t79
  %t130 = icmp ne i64 %t129, 0
  br i1 %t130, label %L30, label %L32
L30:
  %t131 = load i64, ptr %t77
  %t132 = load ptr, ptr %t75
  %t133 = load i64, ptr %t77
  %t135 = ptrtoint ptr %t132 to i64
  %t136 = inttoptr i64 %t135 to ptr
  %t134 = getelementptr i8, ptr %t136, i64 %t133
  %t137 = load i64, ptr %t77
  %t139 = sext i32 512 to i64
  %t138 = sub i64 %t139, %t137
  %t140 = getelementptr [3 x i8], ptr @.str308, i64 0, i64 0
  %t141 = call i32 @snprintf(ptr %t134, i64 %t138, ptr %t140)
  %t142 = sext i32 %t141 to i64
  %t143 = add i64 %t131, %t142
  store i64 %t143, ptr %t77
  br label %L32
L32:
  %t144 = alloca ptr
  %t145 = load ptr, ptr %t97
  %t147 = ptrtoint ptr %t145 to i64
  %t148 = icmp eq i64 %t147, 0
  %t146 = zext i1 %t148 to i64
  %t149 = load ptr, ptr %t97
  %t150 = call i32 @type_is_fp(ptr %t149)
  %t151 = sext i32 %t150 to i64
  %t153 = icmp ne i64 %t146, 0
  %t154 = icmp ne i64 %t151, 0
  %t155 = or i1 %t153, %t154
  %t156 = zext i1 %t155 to i64
  %t157 = icmp ne i64 %t156, 0
  br i1 %t157, label %L33, label %L34
L33:
  %t158 = load ptr, ptr %t97
  %t159 = icmp ne ptr %t158, null
  br i1 %t159, label %L36, label %L37
L36:
  %t160 = load ptr, ptr %t97
  %t161 = call ptr @llvm_type(ptr %t160)
  %t162 = ptrtoint ptr %t161 to i64
  br label %L38
L37:
  %t163 = getelementptr [4 x i8], ptr @.str309, i64 0, i64 0
  %t164 = ptrtoint ptr %t163 to i64
  br label %L38
L38:
  %t165 = phi i64 [ %t162, %L36 ], [ %t164, %L37 ]
  store i64 %t165, ptr %t144
  br label %L35
L34:
  %t166 = load ptr, ptr %t97
  %t167 = load ptr, ptr %t166
  %t169 = ptrtoint ptr %t167 to i64
  %t170 = sext i32 15 to i64
  %t168 = icmp eq i64 %t169, %t170
  %t171 = zext i1 %t168 to i64
  %t172 = load ptr, ptr %t97
  %t173 = load ptr, ptr %t172
  %t175 = ptrtoint ptr %t173 to i64
  %t176 = sext i32 16 to i64
  %t174 = icmp eq i64 %t175, %t176
  %t177 = zext i1 %t174 to i64
  %t179 = icmp ne i64 %t171, 0
  %t180 = icmp ne i64 %t177, 0
  %t181 = or i1 %t179, %t180
  %t182 = zext i1 %t181 to i64
  %t183 = icmp ne i64 %t182, 0
  br i1 %t183, label %L39, label %L40
L39:
  %t184 = getelementptr [4 x i8], ptr @.str310, i64 0, i64 0
  store ptr %t184, ptr %t144
  br label %L41
L40:
  %t185 = load ptr, ptr %t97
  %t186 = load ptr, ptr %t185
  %t188 = ptrtoint ptr %t186 to i64
  %t189 = sext i32 18 to i64
  %t187 = icmp eq i64 %t188, %t189
  %t190 = zext i1 %t187 to i64
  %t191 = load ptr, ptr %t97
  %t192 = load ptr, ptr %t191
  %t194 = ptrtoint ptr %t192 to i64
  %t195 = sext i32 19 to i64
  %t193 = icmp eq i64 %t194, %t195
  %t196 = zext i1 %t193 to i64
  %t198 = icmp ne i64 %t190, 0
  %t199 = icmp ne i64 %t196, 0
  %t200 = or i1 %t198, %t199
  %t201 = zext i1 %t200 to i64
  %t202 = load ptr, ptr %t97
  %t203 = load ptr, ptr %t202
  %t205 = ptrtoint ptr %t203 to i64
  %t206 = sext i32 21 to i64
  %t204 = icmp eq i64 %t205, %t206
  %t207 = zext i1 %t204 to i64
  %t209 = icmp ne i64 %t201, 0
  %t210 = icmp ne i64 %t207, 0
  %t211 = or i1 %t209, %t210
  %t212 = zext i1 %t211 to i64
  %t213 = icmp ne i64 %t212, 0
  br i1 %t213, label %L42, label %L43
L42:
  %t214 = getelementptr [4 x i8], ptr @.str311, i64 0, i64 0
  store ptr %t214, ptr %t144
  br label %L44
L43:
  %t215 = getelementptr [4 x i8], ptr @.str312, i64 0, i64 0
  store ptr %t215, ptr %t144
  br label %L44
L44:
  br label %L41
L41:
  br label %L35
L35:
  %t216 = load i64, ptr %t77
  %t217 = load ptr, ptr %t75
  %t218 = load i64, ptr %t77
  %t220 = ptrtoint ptr %t217 to i64
  %t221 = inttoptr i64 %t220 to ptr
  %t219 = getelementptr i8, ptr %t221, i64 %t218
  %t222 = load i64, ptr %t77
  %t224 = sext i32 512 to i64
  %t223 = sub i64 %t224, %t222
  %t225 = getelementptr [3 x i8], ptr @.str313, i64 0, i64 0
  %t226 = load ptr, ptr %t144
  %t227 = call i32 @snprintf(ptr %t219, i64 %t223, ptr %t225, ptr %t226)
  %t228 = sext i32 %t227 to i64
  %t229 = add i64 %t216, %t228
  store i64 %t229, ptr %t77
  br label %L24
L24:
  %t230 = load i64, ptr %t79
  %t231 = add i64 %t230, 1
  store i64 %t231, ptr %t79
  br label %L22
L25:
  %t232 = load ptr, ptr %t7
  %t233 = load ptr, ptr %t232
  %t234 = icmp ne ptr %t233, null
  br i1 %t234, label %L45, label %L47
L45:
  %t235 = load ptr, ptr %t7
  %t236 = load ptr, ptr %t235
  %t237 = icmp ne ptr %t236, null
  br i1 %t237, label %L48, label %L50
L48:
  %t238 = load i64, ptr %t77
  %t239 = load ptr, ptr %t75
  %t240 = load i64, ptr %t77
  %t242 = ptrtoint ptr %t239 to i64
  %t243 = inttoptr i64 %t242 to ptr
  %t241 = getelementptr i8, ptr %t243, i64 %t240
  %t244 = load i64, ptr %t77
  %t246 = sext i32 512 to i64
  %t245 = sub i64 %t246, %t244
  %t247 = getelementptr [3 x i8], ptr @.str314, i64 0, i64 0
  %t248 = call i32 @snprintf(ptr %t241, i64 %t245, ptr %t247)
  %t249 = sext i32 %t248 to i64
  %t250 = add i64 %t238, %t249
  store i64 %t250, ptr %t77
  br label %L50
L50:
  %t251 = load i64, ptr %t77
  %t252 = load ptr, ptr %t75
  %t253 = load i64, ptr %t77
  %t255 = ptrtoint ptr %t252 to i64
  %t256 = inttoptr i64 %t255 to ptr
  %t254 = getelementptr i8, ptr %t256, i64 %t253
  %t257 = load i64, ptr %t77
  %t259 = sext i32 512 to i64
  %t258 = sub i64 %t259, %t257
  %t260 = getelementptr [4 x i8], ptr @.str315, i64 0, i64 0
  %t261 = call i32 @snprintf(ptr %t254, i64 %t258, ptr %t260)
  %t262 = sext i32 %t261 to i64
  %t263 = add i64 %t251, %t262
  store i64 %t263, ptr %t77
  br label %L47
L47:
  %t264 = getelementptr [20 x i8], ptr @.str316, i64 0, i64 0
  %t265 = load ptr, ptr %t7
  %t266 = call ptr @llvm_ret_type(ptr %t265)
  %t267 = load ptr, ptr %t1
  %t268 = load ptr, ptr %t75
  call void @emit(ptr %t0, ptr %t264, ptr %t266, ptr %t267, ptr %t268)
  ret void
L51:
  br label %L6
L6:
  %t270 = alloca i64
  %t271 = sext i32 0 to i64
  store i64 %t271, ptr %t270
  %t272 = alloca i64
  %t273 = sext i32 0 to i64
  store i64 %t273, ptr %t272
  br label %L52
L52:
  %t274 = load i64, ptr %t272
  %t275 = load ptr, ptr %t0
  %t277 = ptrtoint ptr %t275 to i64
  %t276 = icmp slt i64 %t274, %t277
  %t278 = zext i1 %t276 to i64
  %t279 = icmp ne i64 %t278, 0
  br i1 %t279, label %L53, label %L55
L53:
  %t280 = load ptr, ptr %t0
  %t281 = load i64, ptr %t272
  %t282 = getelementptr i8, ptr %t280, i64 %t281
  %t283 = load ptr, ptr %t282
  %t284 = load ptr, ptr %t1
  %t285 = call i32 @strcmp(ptr %t283, ptr %t284)
  %t286 = sext i32 %t285 to i64
  %t288 = sext i32 0 to i64
  %t287 = icmp eq i64 %t286, %t288
  %t289 = zext i1 %t287 to i64
  %t290 = icmp ne i64 %t289, 0
  br i1 %t290, label %L56, label %L58
L56:
  %t291 = sext i32 1 to i64
  store i64 %t291, ptr %t270
  br label %L55
L59:
  br label %L58
L58:
  br label %L54
L54:
  %t292 = load i64, ptr %t272
  %t293 = add i64 %t292, 1
  store i64 %t293, ptr %t272
  br label %L52
L55:
  %t294 = load i64, ptr %t270
  %t296 = icmp eq i64 %t294, 0
  %t295 = zext i1 %t296 to i64
  %t297 = load ptr, ptr %t0
  %t299 = ptrtoint ptr %t297 to i64
  %t300 = sext i32 2048 to i64
  %t298 = icmp slt i64 %t299, %t300
  %t301 = zext i1 %t298 to i64
  %t303 = icmp ne i64 %t295, 0
  %t304 = icmp ne i64 %t301, 0
  %t305 = and i1 %t303, %t304
  %t306 = zext i1 %t305 to i64
  %t307 = icmp ne i64 %t306, 0
  br i1 %t307, label %L60, label %L62
L60:
  %t308 = load ptr, ptr %t1
  %t309 = call ptr @strdup(ptr %t308)
  %t310 = load ptr, ptr %t0
  %t311 = load ptr, ptr %t0
  %t313 = ptrtoint ptr %t311 to i64
  %t312 = getelementptr i8, ptr %t310, i64 %t313
  store ptr %t309, ptr %t312
  %t314 = load ptr, ptr %t7
  %t315 = load ptr, ptr %t0
  %t316 = load ptr, ptr %t0
  %t318 = ptrtoint ptr %t316 to i64
  %t317 = getelementptr i8, ptr %t315, i64 %t318
  store ptr %t314, ptr %t317
  %t319 = load ptr, ptr %t1
  %t320 = load ptr, ptr %t0
  %t321 = load ptr, ptr %t0
  %t323 = ptrtoint ptr %t321 to i64
  %t322 = getelementptr i8, ptr %t320, i64 %t323
  store ptr %t319, ptr %t322
  %t324 = load ptr, ptr %t0
  %t326 = ptrtoint ptr %t324 to i64
  %t325 = add i64 %t326, 1
  store i64 %t325, ptr %t0
  br label %L62
L62:
  %t327 = load ptr, ptr %t1
  %t328 = icmp ne ptr %t327, null
  br i1 %t328, label %L63, label %L65
L63:
  %t329 = getelementptr [26 x i8], ptr @.str317, i64 0, i64 0
  %t330 = load ptr, ptr %t1
  %t331 = load ptr, ptr %t7
  %t332 = call ptr @llvm_type(ptr %t331)
  call void @emit(ptr %t0, ptr %t329, ptr %t330, ptr %t332)
  ret void
L66:
  br label %L65
L65:
  %t334 = alloca ptr
  %t335 = load ptr, ptr %t1
  %t336 = icmp ne ptr %t335, null
  br i1 %t336, label %L67, label %L68
L67:
  %t337 = getelementptr [9 x i8], ptr @.str318, i64 0, i64 0
  %t338 = ptrtoint ptr %t337 to i64
  br label %L69
L68:
  %t339 = getelementptr [10 x i8], ptr @.str319, i64 0, i64 0
  %t340 = ptrtoint ptr %t339 to i64
  br label %L69
L69:
  %t341 = phi i64 [ %t338, %L67 ], [ %t340, %L68 ]
  store i64 %t341, ptr %t334
  %t342 = alloca ptr
  %t343 = load ptr, ptr %t7
  %t344 = call ptr @llvm_type(ptr %t343)
  store ptr %t344, ptr %t342
  %t345 = getelementptr [36 x i8], ptr @.str320, i64 0, i64 0
  %t346 = load ptr, ptr %t1
  %t347 = load ptr, ptr %t334
  %t348 = load ptr, ptr %t342
  call void @emit(ptr %t0, ptr %t345, ptr %t346, ptr %t347, ptr %t348)
  ret void
}

define dso_local ptr @codegen_new(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca ptr
  %t3 = call ptr @calloc(i64 1, i64 8)
  store ptr %t3, ptr %t2
  %t4 = load ptr, ptr %t2
  %t6 = ptrtoint ptr %t4 to i64
  %t7 = icmp eq i64 %t6, 0
  %t5 = zext i1 %t7 to i64
  %t8 = icmp ne i64 %t5, 0
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = getelementptr [7 x i8], ptr @.str321, i64 0, i64 0
  %t10 = call i32 @perror(ptr %t9)
  %t11 = sext i32 %t10 to i64
  %t12 = call i32 @exit(i64 1)
  %t13 = sext i32 %t12 to i64
  br label %L2
L2:
  %t14 = load ptr, ptr %t2
  store ptr %t0, ptr %t14
  %t15 = load ptr, ptr %t2
  store ptr %t1, ptr %t15
  %t16 = load ptr, ptr %t2
  ret ptr %t16
L3:
  ret ptr null
}

define dso_local void @codegen_free(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = sext i32 0 to i64
  store i64 %t2, ptr %t1
  br label %L0
L0:
  %t3 = load i64, ptr %t1
  %t4 = load ptr, ptr %t0
  %t6 = ptrtoint ptr %t4 to i64
  %t5 = icmp slt i64 %t3, %t6
  %t7 = zext i1 %t5 to i64
  %t8 = icmp ne i64 %t7, 0
  br i1 %t8, label %L1, label %L3
L1:
  %t9 = load ptr, ptr %t0
  %t10 = load i64, ptr %t1
  %t11 = getelementptr i8, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t13 = call i32 @free(ptr %t12)
  %t14 = sext i32 %t13 to i64
  br label %L2
L2:
  %t15 = load i64, ptr %t1
  %t16 = add i64 %t15, 1
  store i64 %t16, ptr %t1
  br label %L0
L3:
  %t17 = alloca i64
  %t18 = sext i32 0 to i64
  store i64 %t18, ptr %t17
  br label %L4
L4:
  %t19 = load i64, ptr %t17
  %t20 = load ptr, ptr %t0
  %t22 = ptrtoint ptr %t20 to i64
  %t21 = icmp slt i64 %t19, %t22
  %t23 = zext i1 %t21 to i64
  %t24 = icmp ne i64 %t23, 0
  br i1 %t24, label %L5, label %L7
L5:
  %t25 = load ptr, ptr %t0
  %t26 = load i64, ptr %t17
  %t27 = getelementptr i32, ptr %t25, i64 %t26
  %t28 = load i64, ptr %t27
  %t29 = call i32 @free(i64 %t28)
  %t30 = sext i32 %t29 to i64
  br label %L6
L6:
  %t31 = load i64, ptr %t17
  %t32 = add i64 %t31, 1
  store i64 %t32, ptr %t17
  br label %L4
L7:
  %t33 = call i32 @free(ptr %t0)
  %t34 = sext i32 %t33 to i64
  ret void
}

define dso_local void @codegen_emit(ptr %t0, ptr %t1) {
entry:
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = icmp eq i64 %t3, 0
  %t2 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t2, 0
  br i1 %t5, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %t6 = getelementptr [19 x i8], ptr @.str322, i64 0, i64 0
  %t7 = load ptr, ptr %t0
  call void @emit(ptr %t0, ptr %t6, ptr %t7)
  %t9 = getelementptr [24 x i8], ptr @.str323, i64 0, i64 0
  %t10 = load ptr, ptr %t0
  call void @emit(ptr %t0, ptr %t9, ptr %t10)
  %t12 = getelementptr [94 x i8], ptr @.str324, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t12)
  %t14 = getelementptr [45 x i8], ptr @.str325, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t14)
  %t16 = getelementptr [23 x i8], ptr @.str326, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t16)
  %t18 = getelementptr [26 x i8], ptr @.str327, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t18)
  %t20 = getelementptr [31 x i8], ptr @.str328, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t20)
  %t22 = getelementptr [32 x i8], ptr @.str329, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t22)
  %t24 = getelementptr [25 x i8], ptr @.str330, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t24)
  %t26 = getelementptr [26 x i8], ptr @.str331, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t26)
  %t28 = getelementptr [26 x i8], ptr @.str332, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t28)
  %t30 = getelementptr [32 x i8], ptr @.str333, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t30)
  %t32 = getelementptr [31 x i8], ptr @.str334, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t32)
  %t34 = getelementptr [37 x i8], ptr @.str335, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t34)
  %t36 = getelementptr [31 x i8], ptr @.str336, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t36)
  %t38 = getelementptr [31 x i8], ptr @.str337, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t38)
  %t40 = getelementptr [31 x i8], ptr @.str338, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t40)
  %t42 = getelementptr [31 x i8], ptr @.str339, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t42)
  %t44 = getelementptr [37 x i8], ptr @.str340, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t44)
  %t46 = getelementptr [36 x i8], ptr @.str341, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t46)
  %t48 = getelementptr [36 x i8], ptr @.str342, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t48)
  %t50 = getelementptr [36 x i8], ptr @.str343, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t50)
  %t52 = getelementptr [31 x i8], ptr @.str344, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t52)
  %t54 = getelementptr [37 x i8], ptr @.str345, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t54)
  %t56 = getelementptr [37 x i8], ptr @.str346, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t56)
  %t58 = getelementptr [43 x i8], ptr @.str347, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t58)
  %t60 = getelementptr [38 x i8], ptr @.str348, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t60)
  %t62 = getelementptr [34 x i8], ptr @.str349, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t62)
  %t64 = getelementptr [32 x i8], ptr @.str350, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t64)
  %t66 = getelementptr [38 x i8], ptr @.str351, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t66)
  %t68 = getelementptr [28 x i8], ptr @.str352, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t68)
  %t70 = getelementptr [26 x i8], ptr @.str353, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t70)
  %t72 = getelementptr [27 x i8], ptr @.str354, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t72)
  %t74 = getelementptr [30 x i8], ptr @.str355, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t74)
  %t76 = getelementptr [26 x i8], ptr @.str356, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t76)
  %t78 = getelementptr [40 x i8], ptr @.str357, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t78)
  %t80 = getelementptr [41 x i8], ptr @.str358, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t80)
  %t82 = getelementptr [35 x i8], ptr @.str359, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t82)
  %t84 = getelementptr [25 x i8], ptr @.str360, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t84)
  %t86 = getelementptr [27 x i8], ptr @.str361, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t86)
  %t88 = getelementptr [25 x i8], ptr @.str362, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t88)
  %t90 = getelementptr [26 x i8], ptr @.str363, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t90)
  %t92 = getelementptr [24 x i8], ptr @.str364, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t92)
  %t94 = getelementptr [24 x i8], ptr @.str365, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t94)
  %t96 = getelementptr [36 x i8], ptr @.str366, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t96)
  %t98 = getelementptr [37 x i8], ptr @.str367, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t98)
  %t100 = getelementptr [27 x i8], ptr @.str368, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t100)
  %t102 = getelementptr [27 x i8], ptr @.str369, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t102)
  %t104 = getelementptr [27 x i8], ptr @.str370, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t104)
  %t106 = getelementptr [27 x i8], ptr @.str371, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t106)
  %t108 = getelementptr [27 x i8], ptr @.str372, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t108)
  %t110 = getelementptr [28 x i8], ptr @.str373, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t110)
  %t112 = getelementptr [27 x i8], ptr @.str374, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t112)
  %t114 = getelementptr [27 x i8], ptr @.str375, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t114)
  %t116 = getelementptr [27 x i8], ptr @.str376, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t116)
  %t118 = getelementptr [27 x i8], ptr @.str377, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t118)
  %t120 = getelementptr [26 x i8], ptr @.str378, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t120)
  %t122 = getelementptr [31 x i8], ptr @.str379, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t122)
  %t124 = getelementptr [31 x i8], ptr @.str380, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t124)
  %t126 = getelementptr [31 x i8], ptr @.str381, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t126)
  %t128 = getelementptr [2 x i8], ptr @.str382, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t128)
  %t130 = alloca ptr
  %t131 = sext i32 0 to i64
  store i64 %t131, ptr %t130
  %t132 = alloca i64
  %t133 = sext i32 0 to i64
  store i64 %t133, ptr %t132
  br label %L4
L4:
  %t134 = load ptr, ptr %t130
  %t135 = load i64, ptr %t132
  %t136 = getelementptr i32, ptr %t134, i64 %t135
  %t137 = load i64, ptr %t136
  %t138 = icmp ne i64 %t137, 0
  br i1 %t138, label %L5, label %L7
L5:
  %t139 = alloca i64
  %t140 = sext i32 0 to i64
  store i64 %t140, ptr %t139
  %t141 = alloca i64
  %t142 = sext i32 0 to i64
  store i64 %t142, ptr %t141
  br label %L8
L8:
  %t143 = load i64, ptr %t141
  %t144 = load ptr, ptr %t0
  %t146 = ptrtoint ptr %t144 to i64
  %t145 = icmp slt i64 %t143, %t146
  %t147 = zext i1 %t145 to i64
  %t148 = icmp ne i64 %t147, 0
  br i1 %t148, label %L9, label %L11
L9:
  %t149 = load ptr, ptr %t0
  %t150 = load i64, ptr %t141
  %t151 = getelementptr i8, ptr %t149, i64 %t150
  %t152 = load ptr, ptr %t151
  %t153 = load ptr, ptr %t130
  %t154 = load i64, ptr %t132
  %t155 = getelementptr i32, ptr %t153, i64 %t154
  %t156 = load i64, ptr %t155
  %t157 = call i32 @strcmp(ptr %t152, i64 %t156)
  %t158 = sext i32 %t157 to i64
  %t160 = sext i32 0 to i64
  %t159 = icmp eq i64 %t158, %t160
  %t161 = zext i1 %t159 to i64
  %t162 = icmp ne i64 %t161, 0
  br i1 %t162, label %L12, label %L14
L12:
  %t163 = sext i32 1 to i64
  store i64 %t163, ptr %t139
  br label %L11
L15:
  br label %L14
L14:
  br label %L10
L10:
  %t164 = load i64, ptr %t141
  %t165 = add i64 %t164, 1
  store i64 %t165, ptr %t141
  br label %L8
L11:
  %t166 = load i64, ptr %t139
  %t168 = icmp eq i64 %t166, 0
  %t167 = zext i1 %t168 to i64
  %t169 = load ptr, ptr %t0
  %t171 = ptrtoint ptr %t169 to i64
  %t172 = sext i32 2048 to i64
  %t170 = icmp slt i64 %t171, %t172
  %t173 = zext i1 %t170 to i64
  %t175 = icmp ne i64 %t167, 0
  %t176 = icmp ne i64 %t173, 0
  %t177 = and i1 %t175, %t176
  %t178 = zext i1 %t177 to i64
  %t179 = icmp ne i64 %t178, 0
  br i1 %t179, label %L16, label %L18
L16:
  %t180 = load ptr, ptr %t130
  %t181 = load i64, ptr %t132
  %t182 = getelementptr i32, ptr %t180, i64 %t181
  %t183 = load i64, ptr %t182
  %t184 = call ptr @strdup(i64 %t183)
  %t185 = load ptr, ptr %t0
  %t186 = load ptr, ptr %t0
  %t188 = ptrtoint ptr %t186 to i64
  %t187 = getelementptr i8, ptr %t185, i64 %t188
  store ptr %t184, ptr %t187
  %t190 = sext i32 0 to i64
  %t189 = inttoptr i64 %t190 to ptr
  %t191 = load ptr, ptr %t0
  %t192 = load ptr, ptr %t0
  %t194 = ptrtoint ptr %t192 to i64
  %t193 = getelementptr i8, ptr %t191, i64 %t194
  store ptr %t189, ptr %t193
  %t195 = load ptr, ptr %t0
  %t196 = load ptr, ptr %t0
  %t198 = ptrtoint ptr %t196 to i64
  %t197 = getelementptr i8, ptr %t195, i64 %t198
  %t199 = sext i32 1 to i64
  store i64 %t199, ptr %t197
  %t200 = load ptr, ptr %t0
  %t202 = ptrtoint ptr %t200 to i64
  %t201 = add i64 %t202, 1
  store i64 %t201, ptr %t0
  br label %L18
L18:
  br label %L6
L6:
  %t203 = load i64, ptr %t132
  %t204 = add i64 %t203, 1
  store i64 %t204, ptr %t132
  br label %L4
L7:
  %t205 = alloca i64
  %t206 = sext i32 0 to i64
  store i64 %t206, ptr %t205
  br label %L19
L19:
  %t207 = load i64, ptr %t205
  %t208 = load ptr, ptr %t1
  %t210 = ptrtoint ptr %t208 to i64
  %t209 = icmp slt i64 %t207, %t210
  %t211 = zext i1 %t209 to i64
  %t212 = icmp ne i64 %t211, 0
  br i1 %t212, label %L20, label %L22
L20:
  %t213 = alloca ptr
  %t214 = load ptr, ptr %t1
  %t215 = load i64, ptr %t205
  %t216 = getelementptr i32, ptr %t214, i64 %t215
  %t217 = load i64, ptr %t216
  store i64 %t217, ptr %t213
  %t218 = load ptr, ptr %t213
  %t220 = ptrtoint ptr %t218 to i64
  %t221 = icmp eq i64 %t220, 0
  %t219 = zext i1 %t221 to i64
  %t222 = icmp ne i64 %t219, 0
  br i1 %t222, label %L23, label %L25
L23:
  br label %L21
L26:
  br label %L25
L25:
  %t223 = load ptr, ptr %t213
  %t224 = load ptr, ptr %t223
  %t226 = ptrtoint ptr %t224 to i64
  %t227 = sext i32 1 to i64
  %t225 = icmp eq i64 %t226, %t227
  %t228 = zext i1 %t225 to i64
  %t229 = icmp ne i64 %t228, 0
  br i1 %t229, label %L27, label %L29
L27:
  %t230 = alloca i64
  %t231 = sext i32 0 to i64
  store i64 %t231, ptr %t230
  %t232 = alloca i64
  %t233 = sext i32 0 to i64
  store i64 %t233, ptr %t232
  br label %L30
L30:
  %t234 = load i64, ptr %t232
  %t235 = load ptr, ptr %t0
  %t237 = ptrtoint ptr %t235 to i64
  %t236 = icmp slt i64 %t234, %t237
  %t238 = zext i1 %t236 to i64
  %t239 = icmp ne i64 %t238, 0
  br i1 %t239, label %L31, label %L33
L31:
  %t240 = load ptr, ptr %t0
  %t241 = load i64, ptr %t232
  %t242 = getelementptr i8, ptr %t240, i64 %t241
  %t243 = load ptr, ptr %t242
  %t244 = load ptr, ptr %t213
  %t245 = load ptr, ptr %t244
  %t246 = icmp ne ptr %t245, null
  br i1 %t246, label %L34, label %L35
L34:
  %t247 = load ptr, ptr %t213
  %t248 = load ptr, ptr %t247
  %t249 = ptrtoint ptr %t248 to i64
  br label %L36
L35:
  %t250 = getelementptr [1 x i8], ptr @.str383, i64 0, i64 0
  %t251 = ptrtoint ptr %t250 to i64
  br label %L36
L36:
  %t252 = phi i64 [ %t249, %L34 ], [ %t251, %L35 ]
  %t253 = call i32 @strcmp(ptr %t243, i64 %t252)
  %t254 = sext i32 %t253 to i64
  %t256 = sext i32 0 to i64
  %t255 = icmp eq i64 %t254, %t256
  %t257 = zext i1 %t255 to i64
  %t258 = icmp ne i64 %t257, 0
  br i1 %t258, label %L37, label %L39
L37:
  %t259 = sext i32 1 to i64
  store i64 %t259, ptr %t230
  br label %L33
L40:
  br label %L39
L39:
  br label %L32
L32:
  %t260 = load i64, ptr %t232
  %t261 = add i64 %t260, 1
  store i64 %t261, ptr %t232
  br label %L30
L33:
  %t262 = load i64, ptr %t230
  %t264 = icmp eq i64 %t262, 0
  %t263 = zext i1 %t264 to i64
  %t265 = load ptr, ptr %t0
  %t267 = ptrtoint ptr %t265 to i64
  %t268 = sext i32 2048 to i64
  %t266 = icmp slt i64 %t267, %t268
  %t269 = zext i1 %t266 to i64
  %t271 = icmp ne i64 %t263, 0
  %t272 = icmp ne i64 %t269, 0
  %t273 = and i1 %t271, %t272
  %t274 = zext i1 %t273 to i64
  %t275 = icmp ne i64 %t274, 0
  br i1 %t275, label %L41, label %L43
L41:
  %t276 = load ptr, ptr %t213
  %t277 = load ptr, ptr %t276
  %t278 = icmp ne ptr %t277, null
  br i1 %t278, label %L44, label %L45
L44:
  %t279 = load ptr, ptr %t213
  %t280 = load ptr, ptr %t279
  %t281 = ptrtoint ptr %t280 to i64
  br label %L46
L45:
  %t282 = getelementptr [7 x i8], ptr @.str384, i64 0, i64 0
  %t283 = ptrtoint ptr %t282 to i64
  br label %L46
L46:
  %t284 = phi i64 [ %t281, %L44 ], [ %t283, %L45 ]
  %t285 = call ptr @strdup(i64 %t284)
  %t286 = load ptr, ptr %t0
  %t287 = load ptr, ptr %t0
  %t289 = ptrtoint ptr %t287 to i64
  %t288 = getelementptr i8, ptr %t286, i64 %t289
  store ptr %t285, ptr %t288
  %t290 = load ptr, ptr %t213
  %t291 = load ptr, ptr %t290
  %t292 = load ptr, ptr %t0
  %t293 = load ptr, ptr %t0
  %t295 = ptrtoint ptr %t293 to i64
  %t294 = getelementptr i8, ptr %t292, i64 %t295
  store ptr %t291, ptr %t294
  %t296 = load ptr, ptr %t0
  %t297 = load ptr, ptr %t0
  %t299 = ptrtoint ptr %t297 to i64
  %t298 = getelementptr i8, ptr %t296, i64 %t299
  %t300 = sext i32 0 to i64
  store i64 %t300, ptr %t298
  %t301 = load ptr, ptr %t0
  %t303 = ptrtoint ptr %t301 to i64
  %t302 = add i64 %t303, 1
  store i64 %t302, ptr %t0
  br label %L43
L43:
  br label %L29
L29:
  br label %L21
L21:
  %t304 = load i64, ptr %t205
  %t305 = add i64 %t304, 1
  store i64 %t305, ptr %t205
  br label %L19
L22:
  %t306 = alloca i64
  %t307 = sext i32 0 to i64
  store i64 %t307, ptr %t306
  br label %L47
L47:
  %t308 = load i64, ptr %t306
  %t309 = load ptr, ptr %t1
  %t311 = ptrtoint ptr %t309 to i64
  %t310 = icmp slt i64 %t308, %t311
  %t312 = zext i1 %t310 to i64
  %t313 = icmp ne i64 %t312, 0
  br i1 %t313, label %L48, label %L50
L48:
  %t314 = alloca ptr
  %t315 = load ptr, ptr %t1
  %t316 = load i64, ptr %t306
  %t317 = getelementptr i32, ptr %t315, i64 %t316
  %t318 = load i64, ptr %t317
  store i64 %t318, ptr %t314
  %t319 = load ptr, ptr %t314
  %t321 = ptrtoint ptr %t319 to i64
  %t322 = icmp eq i64 %t321, 0
  %t320 = zext i1 %t322 to i64
  %t323 = icmp ne i64 %t320, 0
  br i1 %t323, label %L51, label %L53
L51:
  br label %L49
L54:
  br label %L53
L53:
  %t324 = load ptr, ptr %t314
  %t325 = load ptr, ptr %t324
  %t327 = ptrtoint ptr %t325 to i64
  %t328 = sext i32 2 to i64
  %t326 = icmp eq i64 %t327, %t328
  %t329 = zext i1 %t326 to i64
  %t330 = icmp ne i64 %t329, 0
  br i1 %t330, label %L55, label %L57
L55:
  %t331 = load ptr, ptr %t314
  call void @emit_global_var(ptr %t0, ptr %t331)
  br label %L57
L57:
  br label %L49
L49:
  %t333 = load i64, ptr %t306
  %t334 = add i64 %t333, 1
  store i64 %t334, ptr %t306
  br label %L47
L50:
  %t335 = getelementptr [2 x i8], ptr @.str385, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t335)
  %t337 = alloca i64
  %t338 = sext i32 0 to i64
  store i64 %t338, ptr %t337
  br label %L58
L58:
  %t339 = load i64, ptr %t337
  %t340 = load ptr, ptr %t1
  %t342 = ptrtoint ptr %t340 to i64
  %t341 = icmp slt i64 %t339, %t342
  %t343 = zext i1 %t341 to i64
  %t344 = icmp ne i64 %t343, 0
  br i1 %t344, label %L59, label %L61
L59:
  %t345 = alloca ptr
  %t346 = load ptr, ptr %t1
  %t347 = load i64, ptr %t337
  %t348 = getelementptr i32, ptr %t346, i64 %t347
  %t349 = load i64, ptr %t348
  store i64 %t349, ptr %t345
  %t350 = load ptr, ptr %t345
  %t352 = ptrtoint ptr %t350 to i64
  %t353 = icmp eq i64 %t352, 0
  %t351 = zext i1 %t353 to i64
  %t354 = icmp ne i64 %t351, 0
  br i1 %t354, label %L62, label %L64
L62:
  br label %L60
L65:
  br label %L64
L64:
  %t355 = load ptr, ptr %t345
  %t356 = load ptr, ptr %t355
  %t358 = ptrtoint ptr %t356 to i64
  %t359 = sext i32 1 to i64
  %t357 = icmp eq i64 %t358, %t359
  %t360 = zext i1 %t357 to i64
  %t361 = icmp ne i64 %t360, 0
  br i1 %t361, label %L66, label %L68
L66:
  %t362 = load ptr, ptr %t345
  call void @emit_func_def(ptr %t0, ptr %t362)
  br label %L68
L68:
  br label %L60
L60:
  %t364 = load i64, ptr %t337
  %t365 = add i64 %t364, 1
  store i64 %t365, ptr %t337
  br label %L58
L61:
  %t366 = alloca i64
  %t367 = sext i32 0 to i64
  store i64 %t367, ptr %t366
  br label %L69
L69:
  %t368 = load i64, ptr %t366
  %t369 = load ptr, ptr %t0
  %t371 = ptrtoint ptr %t369 to i64
  %t370 = icmp slt i64 %t368, %t371
  %t372 = zext i1 %t370 to i64
  %t373 = icmp ne i64 %t372, 0
  br i1 %t373, label %L70, label %L72
L70:
  %t374 = alloca i64
  %t375 = load ptr, ptr %t0
  %t376 = load i64, ptr %t366
  %t377 = getelementptr i32, ptr %t375, i64 %t376
  %t378 = load i64, ptr %t377
  %t379 = call i32 @str_literal_len(i64 %t378)
  %t380 = sext i32 %t379 to i64
  store i64 %t380, ptr %t374
  %t381 = getelementptr [53 x i8], ptr @.str386, i64 0, i64 0
  %t382 = load ptr, ptr %t0
  %t383 = load i64, ptr %t366
  %t384 = getelementptr i32, ptr %t382, i64 %t383
  %t385 = load i64, ptr %t384
  %t386 = load i64, ptr %t374
  call void @emit(ptr %t0, ptr %t381, i64 %t385, i64 %t386)
  %t388 = load ptr, ptr %t0
  %t389 = load i64, ptr %t366
  %t390 = getelementptr i32, ptr %t388, i64 %t389
  %t391 = load i64, ptr %t390
  call void @emit_str_content(ptr %t0, i64 %t391)
  %t393 = getelementptr [3 x i8], ptr @.str387, i64 0, i64 0
  call void @emit(ptr %t0, ptr %t393)
  br label %L71
L71:
  %t395 = load i64, ptr %t366
  %t396 = add i64 %t395, 1
  store i64 %t396, ptr %t366
  br label %L69
L72:
  ret void
}

@.str0 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str1 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str2 = private unnamed_addr constant [5 x i8] c"void\00"
@.str3 = private unnamed_addr constant [3 x i8] c"i1\00"
@.str4 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str5 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str6 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str7 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str8 = private unnamed_addr constant [6 x i8] c"float\00"
@.str9 = private unnamed_addr constant [7 x i8] c"double\00"
@.str10 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str11 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str12 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str13 = private unnamed_addr constant [12 x i8] c"%%struct.%s\00"
@.str14 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str15 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str16 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str17 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str18 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str19 = private unnamed_addr constant [4 x i8] c"\5C0A\00"
@.str20 = private unnamed_addr constant [4 x i8] c"\5C09\00"
@.str21 = private unnamed_addr constant [4 x i8] c"\5C0D\00"
@.str22 = private unnamed_addr constant [4 x i8] c"\5C00\00"
@.str23 = private unnamed_addr constant [4 x i8] c"\5C22\00"
@.str24 = private unnamed_addr constant [4 x i8] c"\5C5C\00"
@.str25 = private unnamed_addr constant [6 x i8] c"\5C%02X\00"
@.str26 = private unnamed_addr constant [3 x i8] c"%c\00"
@.str27 = private unnamed_addr constant [4 x i8] c"\5C00\00"
@.str28 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str29 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str30 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str31 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str32 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str33 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str34 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str35 = private unnamed_addr constant [44 x i8] c"  %%t%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str36 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str37 = private unnamed_addr constant [3 x i8] c"%s\00"
@.str38 = private unnamed_addr constant [34 x i8] c"  %%t%d = ptrtoint ptr %s to i64\0A\00"
@.str39 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str40 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str41 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str42 = private unnamed_addr constant [32 x i8] c"  %%t%d = icmp ne ptr %s, null\0A\00"
@.str43 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str44 = private unnamed_addr constant [2 x i8] c"0\00"
@.str45 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.str46 = private unnamed_addr constant [31 x i8] c"  %%t%d = fadd double 0.0, %g\0A\00"
@.str47 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str48 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.str49 = private unnamed_addr constant [62 x i8] c"  %%t%d = getelementptr [%d x i8], ptr @.str%d, i64 0, i64 0\0A\00"
@.str50 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str51 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str52 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str53 = private unnamed_addr constant [27 x i8] c"  %%t%d = load %s, ptr %s\0A\00"
@.str54 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str55 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str56 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str57 = private unnamed_addr constant [28 x i8] c"  %%t%d = load %s, ptr @%s\0A\00"
@.str58 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str59 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str60 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str61 = private unnamed_addr constant [16 x i8] c"  call void %s(\00"
@.str62 = private unnamed_addr constant [22 x i8] c"  %%t%d = call %s %s(\00"
@.str63 = private unnamed_addr constant [3 x i8] c", \00"
@.str64 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str65 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str66 = private unnamed_addr constant [6 x i8] c"%s %s\00"
@.str67 = private unnamed_addr constant [3 x i8] c")\0A\00"
@.str68 = private unnamed_addr constant [2 x i8] c"0\00"
@.str69 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str70 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str71 = private unnamed_addr constant [32 x i8] c"  %%t%d = sext %s %%t%d to i64\0A\00"
@.str72 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str73 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str74 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str75 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str76 = private unnamed_addr constant [14 x i8] c"getelementptr\00"
@.str77 = private unnamed_addr constant [4 x i8] c"add\00"
@.str78 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str79 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str80 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str81 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str82 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str83 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str84 = private unnamed_addr constant [5 x i8] c"frem\00"
@.str85 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str86 = private unnamed_addr constant [4 x i8] c"and\00"
@.str87 = private unnamed_addr constant [3 x i8] c"or\00"
@.str88 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str89 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str90 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str91 = private unnamed_addr constant [9 x i8] c"fcmp oeq\00"
@.str92 = private unnamed_addr constant [8 x i8] c"icmp eq\00"
@.str93 = private unnamed_addr constant [9 x i8] c"fcmp one\00"
@.str94 = private unnamed_addr constant [8 x i8] c"icmp ne\00"
@.str95 = private unnamed_addr constant [9 x i8] c"fcmp olt\00"
@.str96 = private unnamed_addr constant [9 x i8] c"icmp slt\00"
@.str97 = private unnamed_addr constant [9 x i8] c"fcmp ogt\00"
@.str98 = private unnamed_addr constant [9 x i8] c"icmp sgt\00"
@.str99 = private unnamed_addr constant [9 x i8] c"fcmp ole\00"
@.str100 = private unnamed_addr constant [9 x i8] c"icmp sle\00"
@.str101 = private unnamed_addr constant [9 x i8] c"fcmp oge\00"
@.str102 = private unnamed_addr constant [9 x i8] c"icmp sge\00"
@.str103 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str104 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str105 = private unnamed_addr constant [31 x i8] c"  %%t%d = and i1 %%t%d, %%t%d\0A\00"
@.str106 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str107 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str108 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str109 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str110 = private unnamed_addr constant [30 x i8] c"  %%t%d = or i1 %%t%d, %%t%d\0A\00"
@.str111 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str112 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str113 = private unnamed_addr constant [4 x i8] c"add\00"
@.str114 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str115 = private unnamed_addr constant [47 x i8] c"  %%t%d = getelementptr i8, ptr %%t%d, i64 %s\0A\00"
@.str116 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str117 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str118 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str119 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str120 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str121 = private unnamed_addr constant [26 x i8] c"  %%t%d = fneg double %s\0A\00"
@.str122 = private unnamed_addr constant [25 x i8] c"  %%t%d = sub i64 0, %s\0A\00"
@.str123 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp eq i64 %s, 0\0A\00"
@.str124 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str125 = private unnamed_addr constant [26 x i8] c"  %%t%d = xor i64 %s, -1\0A\00"
@.str126 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str127 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str128 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str129 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str130 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str131 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str132 = private unnamed_addr constant [23 x i8] c"  store %s %s, ptr %s\0A\00"
@.str133 = private unnamed_addr constant [7 x i8] c"double\00"
@.str134 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str135 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str136 = private unnamed_addr constant [4 x i8] c"add\00"
@.str137 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str138 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str139 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str140 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str141 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str142 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str143 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str144 = private unnamed_addr constant [4 x i8] c"and\00"
@.str145 = private unnamed_addr constant [3 x i8] c"or\00"
@.str146 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str147 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str148 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str149 = private unnamed_addr constant [4 x i8] c"add\00"
@.str150 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str151 = private unnamed_addr constant [26 x i8] c"  store %s %%t%d, ptr %s\0A\00"
@.str152 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str153 = private unnamed_addr constant [4 x i8] c"add\00"
@.str154 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str155 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s i64 %s, 1\0A\00"
@.str156 = private unnamed_addr constant [27 x i8] c"  store i64 %%t%d, ptr %s\0A\00"
@.str157 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str158 = private unnamed_addr constant [4 x i8] c"add\00"
@.str159 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str160 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s i64 %s, 1\0A\00"
@.str161 = private unnamed_addr constant [27 x i8] c"  store i64 %%t%d, ptr %s\0A\00"
@.str162 = private unnamed_addr constant [5 x i8] c"null\00"
@.str163 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str164 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str165 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str166 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str167 = private unnamed_addr constant [27 x i8] c"  %%t%d = load %s, ptr %s\0A\00"
@.str168 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str169 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str170 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str171 = private unnamed_addr constant [44 x i8] c"  %%t%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str172 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str173 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str174 = private unnamed_addr constant [30 x i8] c"  %%t%d = load %s, ptr %%t%d\0A\00"
@.str175 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str176 = private unnamed_addr constant [36 x i8] c"  %%t%d = fpext float %s to double\0A\00"
@.str177 = private unnamed_addr constant [38 x i8] c"  %%t%d = fptrunc double %s to float\0A\00"
@.str178 = private unnamed_addr constant [35 x i8] c"  %%t%d = fptosi double %s to i64\0A\00"
@.str179 = private unnamed_addr constant [31 x i8] c"  %%t%d = sitofp i64 %s to %s\0A\00"
@.str180 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str181 = private unnamed_addr constant [34 x i8] c"  %%t%d = ptrtoint ptr %s to i64\0A\00"
@.str182 = private unnamed_addr constant [33 x i8] c"  %%t%d = bitcast ptr %s to ptr\0A\00"
@.str183 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str184 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str185 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str186 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str187 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str188 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str189 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str190 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str191 = private unnamed_addr constant [48 x i8] c"  %%t%d = phi i64 [ %s, %%L%d ], [ %s, %%L%d ]\0A\00"
@.str192 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str193 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str194 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str195 = private unnamed_addr constant [2 x i8] c"0\00"
@.str196 = private unnamed_addr constant [5 x i8] c"null\00"
@.str197 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str198 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str199 = private unnamed_addr constant [28 x i8] c"  %%t%d = load ptr, ptr %s\0A\00"
@.str200 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str201 = private unnamed_addr constant [28 x i8] c"  ; unhandled expr node %d\0A\00"
@.str202 = private unnamed_addr constant [2 x i8] c"0\00"
@.str203 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str204 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str205 = private unnamed_addr constant [21 x i8] c"  %%t%d = alloca %s\0A\00"
@.str206 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str207 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str208 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str209 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str210 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str211 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str212 = private unnamed_addr constant [26 x i8] c"  store %s %s, ptr %%t%d\0A\00"
@.str213 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str214 = private unnamed_addr constant [13 x i8] c"  ret %s %s\0A\00"
@.str215 = private unnamed_addr constant [14 x i8] c"  ret ptr %s\0A\00"
@.str216 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str217 = private unnamed_addr constant [17 x i8] c"  ret ptr %%t%d\0A\00"
@.str218 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str219 = private unnamed_addr constant [30 x i8] c"  %%t%d = trunc i64 %s to i8\0A\00"
@.str220 = private unnamed_addr constant [16 x i8] c"  ret i8 %%t%d\0A\00"
@.str221 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str222 = private unnamed_addr constant [31 x i8] c"  %%t%d = trunc i64 %s to i16\0A\00"
@.str223 = private unnamed_addr constant [17 x i8] c"  ret i16 %%t%d\0A\00"
@.str224 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str225 = private unnamed_addr constant [31 x i8] c"  %%t%d = trunc i64 %s to i32\0A\00"
@.str226 = private unnamed_addr constant [17 x i8] c"  ret i32 %%t%d\0A\00"
@.str227 = private unnamed_addr constant [14 x i8] c"  ret i64 %s\0A\00"
@.str228 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str229 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str230 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str231 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str232 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str233 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str234 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str235 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str236 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str237 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str238 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str239 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str240 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str241 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str242 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str243 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str244 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str245 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str246 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str247 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str248 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str249 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str250 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str251 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str252 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str253 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str254 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str255 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str256 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str257 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str258 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str259 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str260 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str261 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str262 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str263 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str264 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str265 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str266 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str267 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str268 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str269 = private unnamed_addr constant [35 x i8] c"  switch i64 %%t%d, label %%L%d [\0A\00"
@.str270 = private unnamed_addr constant [27 x i8] c"    i64 %lld, label %%L%d\0A\00"
@.str271 = private unnamed_addr constant [5 x i8] c"  ]\0A\00"
@.str272 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str273 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str274 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str275 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str276 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str277 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str278 = private unnamed_addr constant [5 x i8] c"%s:\0A\00"
@.str279 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str280 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str281 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str282 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str283 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str284 = private unnamed_addr constant [18 x i8] c"define %s %s @%s(\00"
@.str285 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str286 = private unnamed_addr constant [3 x i8] c", \00"
@.str287 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str288 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str289 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str290 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str291 = private unnamed_addr constant [9 x i8] c"%s %%t%d\00"
@.str292 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str293 = private unnamed_addr constant [3 x i8] c", \00"
@.str294 = private unnamed_addr constant [4 x i8] c"...\00"
@.str295 = private unnamed_addr constant [5 x i8] c") {\0A\00"
@.str296 = private unnamed_addr constant [8 x i8] c"entry:\0A\00"
@.str297 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str298 = private unnamed_addr constant [16 x i8] c"  ret ptr null\0A\00"
@.str299 = private unnamed_addr constant [14 x i8] c"  ret %s 0.0\0A\00"
@.str300 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str301 = private unnamed_addr constant [12 x i8] c"  ret i8 0\0A\00"
@.str302 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str303 = private unnamed_addr constant [13 x i8] c"  ret i16 0\0A\00"
@.str304 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str305 = private unnamed_addr constant [13 x i8] c"  ret i32 0\0A\00"
@.str306 = private unnamed_addr constant [13 x i8] c"  ret i64 0\0A\00"
@.str307 = private unnamed_addr constant [4 x i8] c"}\0A\0A\00"
@.str308 = private unnamed_addr constant [3 x i8] c", \00"
@.str309 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str310 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str311 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str312 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str313 = private unnamed_addr constant [3 x i8] c"%s\00"
@.str314 = private unnamed_addr constant [3 x i8] c", \00"
@.str315 = private unnamed_addr constant [4 x i8] c"...\00"
@.str316 = private unnamed_addr constant [20 x i8] c"declare %s @%s(%s)\0A\00"
@.str317 = private unnamed_addr constant [26 x i8] c"@%s = external global %s\0A\00"
@.str318 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str319 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str320 = private unnamed_addr constant [36 x i8] c"@%s = %s global %s zeroinitializer\0A\00"
@.str321 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str322 = private unnamed_addr constant [19 x i8] c"; ModuleID = '%s'\0A\00"
@.str323 = private unnamed_addr constant [24 x i8] c"source_filename = \22%s\22\0A\00"
@.str324 = private unnamed_addr constant [94 x i8] c"target datalayout = \22e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128\22\0A\00"
@.str325 = private unnamed_addr constant [45 x i8] c"target triple = \22x86_64-unknown-linux-gnu\22\0A\0A\00"
@.str326 = private unnamed_addr constant [23 x i8] c"; stdlib declarations\0A\00"
@.str327 = private unnamed_addr constant [26 x i8] c"declare ptr @malloc(i64)\0A\00"
@.str328 = private unnamed_addr constant [31 x i8] c"declare ptr @calloc(i64, i64)\0A\00"
@.str329 = private unnamed_addr constant [32 x i8] c"declare ptr @realloc(ptr, i64)\0A\00"
@.str330 = private unnamed_addr constant [25 x i8] c"declare void @free(ptr)\0A\00"
@.str331 = private unnamed_addr constant [26 x i8] c"declare i64 @strlen(ptr)\0A\00"
@.str332 = private unnamed_addr constant [26 x i8] c"declare ptr @strdup(ptr)\0A\00"
@.str333 = private unnamed_addr constant [32 x i8] c"declare ptr @strndup(ptr, i64)\0A\00"
@.str334 = private unnamed_addr constant [31 x i8] c"declare ptr @strcpy(ptr, ptr)\0A\00"
@.str335 = private unnamed_addr constant [37 x i8] c"declare ptr @strncpy(ptr, ptr, i64)\0A\00"
@.str336 = private unnamed_addr constant [31 x i8] c"declare ptr @strcat(ptr, ptr)\0A\00"
@.str337 = private unnamed_addr constant [31 x i8] c"declare ptr @strchr(ptr, i64)\0A\00"
@.str338 = private unnamed_addr constant [31 x i8] c"declare ptr @strstr(ptr, ptr)\0A\00"
@.str339 = private unnamed_addr constant [31 x i8] c"declare i32 @strcmp(ptr, ptr)\0A\00"
@.str340 = private unnamed_addr constant [37 x i8] c"declare i32 @strncmp(ptr, ptr, i64)\0A\00"
@.str341 = private unnamed_addr constant [36 x i8] c"declare ptr @memcpy(ptr, ptr, i64)\0A\00"
@.str342 = private unnamed_addr constant [36 x i8] c"declare ptr @memset(ptr, i32, i64)\0A\00"
@.str343 = private unnamed_addr constant [36 x i8] c"declare i32 @memcmp(ptr, ptr, i64)\0A\00"
@.str344 = private unnamed_addr constant [31 x i8] c"declare i32 @printf(ptr, ...)\0A\00"
@.str345 = private unnamed_addr constant [37 x i8] c"declare i32 @fprintf(ptr, ptr, ...)\0A\00"
@.str346 = private unnamed_addr constant [37 x i8] c"declare i32 @sprintf(ptr, ptr, ...)\0A\00"
@.str347 = private unnamed_addr constant [43 x i8] c"declare i32 @snprintf(ptr, i64, ptr, ...)\0A\00"
@.str348 = private unnamed_addr constant [38 x i8] c"declare i32 @vfprintf(ptr, ptr, ptr)\0A\00"
@.str349 = private unnamed_addr constant [34 x i8] c"declare void @llvm.va_start(ptr)\0A\00"
@.str350 = private unnamed_addr constant [32 x i8] c"declare void @llvm.va_end(ptr)\0A\00"
@.str351 = private unnamed_addr constant [38 x i8] c"declare void @llvm.va_copy(ptr, ptr)\0A\00"
@.str352 = private unnamed_addr constant [28 x i8] c"declare i32 @va_start(...)\0A\00"
@.str353 = private unnamed_addr constant [26 x i8] c"declare i32 @va_end(...)\0A\00"
@.str354 = private unnamed_addr constant [27 x i8] c"declare i32 @va_copy(...)\0A\00"
@.str355 = private unnamed_addr constant [30 x i8] c"declare ptr @fopen(ptr, ptr)\0A\00"
@.str356 = private unnamed_addr constant [26 x i8] c"declare i32 @fclose(ptr)\0A\00"
@.str357 = private unnamed_addr constant [40 x i8] c"declare i64 @fread(ptr, i64, i64, ptr)\0A\00"
@.str358 = private unnamed_addr constant [41 x i8] c"declare i64 @fwrite(ptr, i64, i64, ptr)\0A\00"
@.str359 = private unnamed_addr constant [35 x i8] c"declare i32 @fseek(ptr, i64, i32)\0A\00"
@.str360 = private unnamed_addr constant [25 x i8] c"declare i64 @ftell(ptr)\0A\00"
@.str361 = private unnamed_addr constant [27 x i8] c"declare void @perror(ptr)\0A\00"
@.str362 = private unnamed_addr constant [25 x i8] c"declare void @exit(i32)\0A\00"
@.str363 = private unnamed_addr constant [26 x i8] c"declare ptr @getenv(ptr)\0A\00"
@.str364 = private unnamed_addr constant [24 x i8] c"declare i32 @atoi(ptr)\0A\00"
@.str365 = private unnamed_addr constant [24 x i8] c"declare i64 @atol(ptr)\0A\00"
@.str366 = private unnamed_addr constant [36 x i8] c"declare i64 @strtol(ptr, ptr, i32)\0A\00"
@.str367 = private unnamed_addr constant [37 x i8] c"declare i64 @strtoll(ptr, ptr, i32)\0A\00"
@.str368 = private unnamed_addr constant [27 x i8] c"declare double @atof(ptr)\0A\00"
@.str369 = private unnamed_addr constant [27 x i8] c"declare i32 @isspace(i32)\0A\00"
@.str370 = private unnamed_addr constant [27 x i8] c"declare i32 @isdigit(i32)\0A\00"
@.str371 = private unnamed_addr constant [27 x i8] c"declare i32 @isalpha(i32)\0A\00"
@.str372 = private unnamed_addr constant [27 x i8] c"declare i32 @isalnum(i32)\0A\00"
@.str373 = private unnamed_addr constant [28 x i8] c"declare i32 @isxdigit(i32)\0A\00"
@.str374 = private unnamed_addr constant [27 x i8] c"declare i32 @isupper(i32)\0A\00"
@.str375 = private unnamed_addr constant [27 x i8] c"declare i32 @islower(i32)\0A\00"
@.str376 = private unnamed_addr constant [27 x i8] c"declare i32 @toupper(i32)\0A\00"
@.str377 = private unnamed_addr constant [27 x i8] c"declare i32 @tolower(i32)\0A\00"
@.str378 = private unnamed_addr constant [26 x i8] c"declare i32 @assert(i32)\0A\00"
@.str379 = private unnamed_addr constant [31 x i8] c"@stderr = external global ptr\0A\00"
@.str380 = private unnamed_addr constant [31 x i8] c"@stdout = external global ptr\0A\00"
@.str381 = private unnamed_addr constant [31 x i8] c"@stdin  = external global ptr\0A\00"
@.str382 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str383 = private unnamed_addr constant [1 x i8] c"\00"
@.str384 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str385 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str386 = private unnamed_addr constant [53 x i8] c"@.str%d = private unnamed_addr constant [%d x i8] c\22\00"
@.str387 = private unnamed_addr constant [3 x i8] c"\22\0A\00"
