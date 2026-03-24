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
declare i32 @vsnprintf(ptr, i64, ptr, ptr)
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
declare ptr @__c0c_stderr()
declare ptr @__c0c_stdout()
declare ptr @__c0c_stdin()
declare void @__c0c_emit(ptr, ptr, ...)

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
  call void @free(ptr %t19)
  %t21 = load ptr, ptr %t0
  %t22 = load i64, ptr %t8
  %t23 = getelementptr i8, ptr %t21, i64 %t22
  %t24 = load ptr, ptr %t23
  call void @free(ptr %t24)
  br label %L2
L2:
  %t26 = load i64, ptr %t8
  %t27 = add i64 %t26, 1
  store i64 %t27, ptr %t8
  br label %L0
L3:
  %t28 = load i64, ptr %t1
  store i64 %t28, ptr %t0
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
  %t5 = icmp sge i64 %t6, %t7
  %t8 = zext i1 %t5 to i64
  %t9 = icmp ne i64 %t8, 0
  br i1 %t9, label %L0, label %L2
L0:
  %t10 = call ptr @__c0c_stderr()
  %t11 = getelementptr [22 x i8], ptr @.str18, i64 0, i64 0
  %t12 = call i32 @fprintf(ptr %t10, ptr %t11)
  %t13 = sext i32 %t12 to i64
  call void @exit(i64 1)
  br label %L2
L2:
  %t15 = alloca ptr
  %t16 = load ptr, ptr %t0
  %t17 = load ptr, ptr %t0
  %t19 = ptrtoint ptr %t17 to i64
  %t18 = add i64 %t19, 1
  store i64 %t18, ptr %t0
  %t21 = ptrtoint ptr %t17 to i64
  %t20 = getelementptr i8, ptr %t16, i64 %t21
  store ptr %t20, ptr %t15
  %t22 = call ptr @strdup(ptr %t1)
  %t23 = load ptr, ptr %t15
  store ptr %t22, ptr %t23
  %t24 = alloca i64
  %t25 = call i32 @new_reg(ptr %t0)
  %t26 = sext i32 %t25 to i64
  store i64 %t26, ptr %t24
  %t27 = call ptr @malloc(i64 32)
  %t28 = load ptr, ptr %t15
  store ptr %t27, ptr %t28
  %t29 = load ptr, ptr %t15
  %t30 = load ptr, ptr %t29
  %t31 = getelementptr [6 x i8], ptr @.str19, i64 0, i64 0
  %t32 = load i64, ptr %t24
  %t33 = call i32 @snprintf(ptr %t30, i64 32, ptr %t31, i64 %t32)
  %t34 = sext i32 %t33 to i64
  %t35 = load ptr, ptr %t15
  store ptr %t2, ptr %t35
  %t36 = load ptr, ptr %t15
  store i64 %t3, ptr %t36
  %t37 = load ptr, ptr %t15
  ret ptr %t37
L3:
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
  %t43 = load ptr, ptr %t0
  %t44 = getelementptr [4 x i8], ptr @.str20, i64 0, i64 0
  call void @__c0c_emit(ptr %t43, ptr %t44)
  br label %L6
L14:
  br label %L8
L8:
  %t46 = load ptr, ptr %t0
  %t47 = getelementptr [4 x i8], ptr @.str21, i64 0, i64 0
  call void @__c0c_emit(ptr %t46, ptr %t47)
  br label %L6
L15:
  br label %L9
L9:
  %t49 = load ptr, ptr %t0
  %t50 = getelementptr [4 x i8], ptr @.str22, i64 0, i64 0
  call void @__c0c_emit(ptr %t49, ptr %t50)
  br label %L6
L16:
  br label %L10
L10:
  %t52 = load ptr, ptr %t0
  %t53 = getelementptr [4 x i8], ptr @.str23, i64 0, i64 0
  call void @__c0c_emit(ptr %t52, ptr %t53)
  br label %L6
L17:
  br label %L11
L11:
  %t55 = load ptr, ptr %t0
  %t56 = getelementptr [4 x i8], ptr @.str24, i64 0, i64 0
  call void @__c0c_emit(ptr %t55, ptr %t56)
  br label %L6
L18:
  br label %L12
L12:
  %t58 = load ptr, ptr %t0
  %t59 = getelementptr [4 x i8], ptr @.str25, i64 0, i64 0
  call void @__c0c_emit(ptr %t58, ptr %t59)
  br label %L6
L19:
  br label %L6
L13:
  %t61 = load ptr, ptr %t0
  %t62 = getelementptr [6 x i8], ptr @.str26, i64 0, i64 0
  %t63 = load ptr, ptr %t2
  %t64 = load i64, ptr %t63
  %t65 = add i64 %t64, 0
  call void @__c0c_emit(ptr %t61, ptr %t62, i64 %t65)
  br label %L6
L20:
  br label %L6
L6:
  %t67 = load ptr, ptr %t2
  %t69 = ptrtoint ptr %t67 to i64
  %t68 = add i64 %t69, 1
  store i64 %t68, ptr %t2
  br label %L5
L4:
  %t70 = load ptr, ptr %t2
  %t71 = load i64, ptr %t70
  %t73 = sext i32 34 to i64
  %t72 = icmp eq i64 %t71, %t73
  %t74 = zext i1 %t72 to i64
  %t75 = icmp ne i64 %t74, 0
  br i1 %t75, label %L21, label %L23
L21:
  br label %L2
L24:
  br label %L23
L23:
  %t76 = load ptr, ptr %t0
  %t77 = getelementptr [3 x i8], ptr @.str27, i64 0, i64 0
  %t78 = load ptr, ptr %t2
  %t80 = ptrtoint ptr %t78 to i64
  %t79 = add i64 %t80, 1
  store i64 %t79, ptr %t2
  %t81 = load i64, ptr %t78
  call void @__c0c_emit(ptr %t76, ptr %t77, i64 %t81)
  br label %L5
L5:
  br label %L0
L2:
  %t83 = load ptr, ptr %t0
  %t84 = getelementptr [4 x i8], ptr @.str28, i64 0, i64 0
  call void @__c0c_emit(ptr %t83, ptr %t84)
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
  %t24 = getelementptr [4 x i8], ptr @.str29, i64 0, i64 0
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
  %t32 = getelementptr [4 x i8], ptr @.str30, i64 0, i64 0
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
  %t58 = load ptr, ptr %t0
  %t59 = getelementptr [34 x i8], ptr @.str31, i64 0, i64 0
  %t60 = load i64, ptr %t55
  %t61 = load ptr, ptr %t43
  call void @__c0c_emit(ptr %t58, ptr %t59, i64 %t60, ptr %t61)
  %t63 = alloca ptr
  %t64 = call ptr @malloc(i64 32)
  store ptr %t64, ptr %t63
  %t65 = load ptr, ptr %t63
  %t66 = getelementptr [6 x i8], ptr @.str32, i64 0, i64 0
  %t67 = load i64, ptr %t55
  %t68 = call i32 @snprintf(ptr %t65, i64 32, ptr %t66, i64 %t67)
  %t69 = sext i32 %t68 to i64
  %t70 = load ptr, ptr %t63
  ret ptr %t70
L19:
  br label %L14
L14:
  %t71 = load ptr, ptr %t1
  %t73 = ptrtoint ptr %t71 to i64
  %t74 = sext i32 33 to i64
  %t72 = icmp eq i64 %t73, %t74
  %t75 = zext i1 %t72 to i64
  %t76 = icmp ne i64 %t75, 0
  br i1 %t76, label %L20, label %L22
L20:
  %t77 = alloca i64
  %t78 = load ptr, ptr %t1
  %t79 = sext i32 0 to i64
  %t80 = getelementptr i32, ptr %t78, i64 %t79
  %t81 = load i64, ptr %t80
  %t82 = call i64 @emit_expr(ptr %t0, i64 %t81)
  store i64 %t82, ptr %t77
  %t83 = alloca i64
  %t84 = load ptr, ptr %t1
  %t85 = sext i32 1 to i64
  %t86 = getelementptr i32, ptr %t84, i64 %t85
  %t87 = load i64, ptr %t86
  %t88 = call i64 @emit_expr(ptr %t0, i64 %t87)
  store i64 %t88, ptr %t83
  %t89 = alloca i64
  %t90 = call i32 @new_reg(ptr %t0)
  %t91 = sext i32 %t90 to i64
  store i64 %t91, ptr %t89
  %t92 = alloca ptr
  %t93 = load ptr, ptr %t1
  %t94 = sext i32 0 to i64
  %t95 = getelementptr i32, ptr %t93, i64 %t94
  %t96 = load i64, ptr %t95
  %t97 = inttoptr i64 %t96 to ptr
  %t98 = load ptr, ptr %t97
  %t99 = load ptr, ptr %t1
  %t100 = sext i32 0 to i64
  %t101 = getelementptr i32, ptr %t99, i64 %t100
  %t102 = load i64, ptr %t101
  %t103 = inttoptr i64 %t102 to ptr
  %t104 = load ptr, ptr %t103
  %t105 = load ptr, ptr %t104
  %t107 = ptrtoint ptr %t98 to i64
  %t108 = ptrtoint ptr %t105 to i64
  %t112 = ptrtoint ptr %t98 to i64
  %t113 = ptrtoint ptr %t105 to i64
  %t109 = icmp ne i64 %t112, 0
  %t110 = icmp ne i64 %t113, 0
  %t111 = and i1 %t109, %t110
  %t114 = zext i1 %t111 to i64
  %t115 = icmp ne i64 %t114, 0
  br i1 %t115, label %L23, label %L24
L23:
  %t116 = load ptr, ptr %t1
  %t117 = sext i32 0 to i64
  %t118 = getelementptr i32, ptr %t116, i64 %t117
  %t119 = load i64, ptr %t118
  %t120 = inttoptr i64 %t119 to ptr
  %t121 = load ptr, ptr %t120
  %t122 = load ptr, ptr %t121
  %t123 = ptrtoint ptr %t122 to i64
  br label %L25
L24:
  %t125 = sext i32 0 to i64
  %t124 = inttoptr i64 %t125 to ptr
  %t126 = ptrtoint ptr %t124 to i64
  br label %L25
L25:
  %t127 = phi i64 [ %t123, %L23 ], [ %t126, %L24 ]
  store i64 %t127, ptr %t92
  %t128 = alloca ptr
  %t129 = load ptr, ptr %t92
  %t130 = icmp ne ptr %t129, null
  br i1 %t130, label %L26, label %L27
L26:
  %t131 = load ptr, ptr %t92
  %t132 = call ptr @llvm_type(ptr %t131)
  %t133 = ptrtoint ptr %t132 to i64
  br label %L28
L27:
  %t134 = getelementptr [3 x i8], ptr @.str33, i64 0, i64 0
  %t135 = ptrtoint ptr %t134 to i64
  br label %L28
L28:
  %t136 = phi i64 [ %t133, %L26 ], [ %t135, %L27 ]
  store i64 %t136, ptr %t128
  %t137 = alloca ptr
  %t138 = load i64, ptr %t77
  %t139 = call i32 @val_is_ptr(i64 %t138)
  %t140 = sext i32 %t139 to i64
  %t141 = icmp ne i64 %t140, 0
  br i1 %t141, label %L29, label %L30
L29:
  %t142 = load ptr, ptr %t137
  %t143 = load ptr, ptr %t77
  %t144 = call ptr @strncpy(ptr %t142, ptr %t143, i64 63)
  %t145 = load ptr, ptr %t137
  %t147 = sext i32 63 to i64
  %t146 = getelementptr i8, ptr %t145, i64 %t147
  %t148 = sext i32 0 to i64
  store i64 %t148, ptr %t146
  br label %L31
L30:
  %t149 = alloca i64
  %t150 = call i32 @new_reg(ptr %t0)
  %t151 = sext i32 %t150 to i64
  store i64 %t151, ptr %t149
  %t152 = load ptr, ptr %t0
  %t153 = getelementptr [34 x i8], ptr @.str34, i64 0, i64 0
  %t154 = load i64, ptr %t149
  %t155 = load ptr, ptr %t77
  call void @__c0c_emit(ptr %t152, ptr %t153, i64 %t154, ptr %t155)
  %t157 = load ptr, ptr %t137
  %t158 = getelementptr [6 x i8], ptr @.str35, i64 0, i64 0
  %t159 = load i64, ptr %t149
  %t160 = call i32 @snprintf(ptr %t157, i64 64, ptr %t158, i64 %t159)
  %t161 = sext i32 %t160 to i64
  br label %L31
L31:
  %t162 = alloca ptr
  %t163 = load i64, ptr %t83
  %t164 = load ptr, ptr %t162
  %t165 = call i32 @promote_to_i64(ptr %t0, i64 %t163, ptr %t164, i64 64)
  %t166 = sext i32 %t165 to i64
  %t167 = load ptr, ptr %t0
  %t168 = getelementptr [44 x i8], ptr @.str36, i64 0, i64 0
  %t169 = load i64, ptr %t89
  %t170 = load ptr, ptr %t128
  %t171 = load ptr, ptr %t137
  %t172 = load ptr, ptr %t162
  call void @__c0c_emit(ptr %t167, ptr %t168, i64 %t169, ptr %t170, ptr %t171, ptr %t172)
  %t174 = alloca ptr
  %t175 = call ptr @malloc(i64 32)
  store ptr %t175, ptr %t174
  %t176 = load ptr, ptr %t174
  %t177 = getelementptr [6 x i8], ptr @.str37, i64 0, i64 0
  %t178 = load i64, ptr %t89
  %t179 = call i32 @snprintf(ptr %t176, i64 32, ptr %t177, i64 %t178)
  %t180 = sext i32 %t179 to i64
  %t181 = load ptr, ptr %t174
  ret ptr %t181
L32:
  br label %L22
L22:
  %t182 = load ptr, ptr %t1
  %t184 = ptrtoint ptr %t182 to i64
  %t185 = sext i32 34 to i64
  %t183 = icmp eq i64 %t184, %t185
  %t186 = zext i1 %t183 to i64
  %t187 = load ptr, ptr %t1
  %t189 = ptrtoint ptr %t187 to i64
  %t190 = sext i32 35 to i64
  %t188 = icmp eq i64 %t189, %t190
  %t191 = zext i1 %t188 to i64
  %t193 = icmp ne i64 %t186, 0
  %t194 = icmp ne i64 %t191, 0
  %t195 = or i1 %t193, %t194
  %t196 = zext i1 %t195 to i64
  %t197 = icmp ne i64 %t196, 0
  br i1 %t197, label %L33, label %L35
L33:
  %t198 = alloca i64
  %t199 = load ptr, ptr %t1
  %t201 = ptrtoint ptr %t199 to i64
  %t202 = sext i32 35 to i64
  %t200 = icmp eq i64 %t201, %t202
  %t203 = zext i1 %t200 to i64
  %t204 = icmp ne i64 %t203, 0
  br i1 %t204, label %L36, label %L37
L36:
  %t205 = load ptr, ptr %t1
  %t206 = sext i32 0 to i64
  %t207 = getelementptr i32, ptr %t205, i64 %t206
  %t208 = load i64, ptr %t207
  %t209 = call i64 @emit_expr(ptr %t0, i64 %t208)
  store i64 %t209, ptr %t198
  br label %L38
L37:
  %t210 = alloca ptr
  %t211 = load ptr, ptr %t1
  %t212 = sext i32 0 to i64
  %t213 = getelementptr i32, ptr %t211, i64 %t212
  %t214 = load i64, ptr %t213
  %t215 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t214)
  store ptr %t215, ptr %t210
  %t216 = load ptr, ptr %t210
  %t217 = call ptr @default_ptr_type()
  %t218 = call i64 @make_val(ptr %t216, ptr %t217)
  store i64 %t218, ptr %t198
  %t219 = load ptr, ptr %t210
  call void @free(ptr %t219)
  br label %L38
L38:
  %t221 = alloca ptr
  %t222 = call ptr @malloc(i64 64)
  store ptr %t222, ptr %t221
  %t223 = load ptr, ptr %t221
  %t224 = getelementptr [3 x i8], ptr @.str38, i64 0, i64 0
  %t225 = load ptr, ptr %t198
  %t226 = call i32 @snprintf(ptr %t223, i64 64, ptr %t224, ptr %t225)
  %t227 = sext i32 %t226 to i64
  %t228 = load ptr, ptr %t221
  ret ptr %t228
L39:
  br label %L35
L35:
  %t230 = sext i32 0 to i64
  %t229 = inttoptr i64 %t230 to ptr
  ret ptr %t229
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
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr [34 x i8], ptr @.str39, i64 0, i64 0
  %t12 = load i64, ptr %t7
  %t13 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t10, ptr %t11, i64 %t12, ptr %t13)
  %t15 = getelementptr [6 x i8], ptr @.str40, i64 0, i64 0
  %t16 = load i64, ptr %t7
  %t17 = call i32 @snprintf(ptr %t2, ptr %t3, ptr %t15, i64 %t16)
  %t18 = sext i32 %t17 to i64
  %t19 = load i64, ptr %t7
  %t20 = trunc i64 %t19 to i32
  ret i32 %t20
L3:
  br label %L2
L1:
  %t21 = call i32 @val_is_64bit(ptr %t1)
  %t22 = sext i32 %t21 to i64
  %t23 = icmp ne i64 %t22, 0
  br i1 %t23, label %L4, label %L5
L4:
  %t24 = load ptr, ptr %t1
  %t26 = ptrtoint ptr %t3 to i64
  %t27 = sext i32 1 to i64
  %t25 = sub i64 %t26, %t27
  %t28 = call ptr @strncpy(ptr %t2, ptr %t24, i64 %t25)
  %t30 = ptrtoint ptr %t3 to i64
  %t31 = sext i32 1 to i64
  %t29 = sub i64 %t30, %t31
  %t32 = getelementptr i8, ptr %t2, i64 %t29
  %t33 = sext i32 0 to i64
  store i64 %t33, ptr %t32
  %t35 = sext i32 1 to i64
  %t34 = sub i64 0, %t35
  %t36 = trunc i64 %t34 to i32
  ret i32 %t36
L7:
  br label %L6
L5:
  %t37 = alloca i64
  %t38 = call i32 @new_reg(ptr %t0)
  %t39 = sext i32 %t38 to i64
  store i64 %t39, ptr %t37
  %t40 = load ptr, ptr %t0
  %t41 = getelementptr [30 x i8], ptr @.str41, i64 0, i64 0
  %t42 = load i64, ptr %t37
  %t43 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t40, ptr %t41, i64 %t42, ptr %t43)
  %t45 = getelementptr [6 x i8], ptr @.str42, i64 0, i64 0
  %t46 = load i64, ptr %t37
  %t47 = call i32 @snprintf(ptr %t2, ptr %t3, ptr %t45, i64 %t46)
  %t48 = sext i32 %t47 to i64
  %t49 = load i64, ptr %t37
  %t50 = trunc i64 %t49 to i32
  ret i32 %t50
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
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr [32 x i8], ptr @.str43, i64 0, i64 0
  %t10 = load i64, ptr %t2
  %t11 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t8, ptr %t9, i64 %t10, ptr %t11)
  br label %L2
L1:
  %t13 = alloca ptr
  %t14 = load ptr, ptr %t13
  %t15 = call i32 @promote_to_i64(ptr %t0, ptr %t1, ptr %t14, i64 64)
  %t16 = sext i32 %t15 to i64
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr [29 x i8], ptr @.str44, i64 0, i64 0
  %t19 = load i64, ptr %t2
  %t20 = load ptr, ptr %t13
  call void @__c0c_emit(ptr %t17, ptr %t18, i64 %t19, ptr %t20)
  br label %L2
L2:
  %t22 = load i64, ptr %t2
  %t23 = trunc i64 %t22 to i32
  ret i32 %t23
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
  %t6 = getelementptr [2 x i8], ptr @.str45, i64 0, i64 0
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
  %t18 = getelementptr [5 x i8], ptr @.str46, i64 0, i64 0
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
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr [31 x i8], ptr @.str47, i64 0, i64 0
  %t30 = load i64, ptr %t25
  %t31 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t28, ptr %t29, i64 %t30, ptr %t31)
  %t33 = alloca ptr
  %t34 = load ptr, ptr %t33
  %t35 = getelementptr [6 x i8], ptr @.str48, i64 0, i64 0
  %t36 = load i64, ptr %t25
  %t37 = call i32 @snprintf(ptr %t34, i64 8, ptr %t35, i64 %t36)
  %t38 = sext i32 %t37 to i64
  %t39 = alloca i64
  %t40 = sext i32 0 to i64
  store i64 %t40, ptr %t39
  %t41 = load ptr, ptr %t33
  %t42 = call i64 @make_val(ptr %t41, ptr %t39)
  ret i64 %t42
L31:
  br label %L7
L7:
  %t43 = alloca ptr
  %t44 = load ptr, ptr %t43
  %t45 = getelementptr [5 x i8], ptr @.str49, i64 0, i64 0
  %t46 = load ptr, ptr %t1
  %t47 = call i32 @snprintf(ptr %t44, i64 8, ptr %t45, ptr %t46)
  %t48 = sext i32 %t47 to i64
  %t49 = alloca i64
  %t50 = sext i32 0 to i64
  store i64 %t50, ptr %t49
  %t51 = load ptr, ptr %t43
  %t52 = call i64 @make_val(ptr %t51, ptr %t49)
  ret i64 %t52
L32:
  br label %L8
L8:
  %t53 = alloca i64
  %t54 = load ptr, ptr %t1
  %t55 = call i32 @intern_string(ptr %t0, ptr %t54)
  %t56 = sext i32 %t55 to i64
  store i64 %t56, ptr %t53
  %t57 = alloca i64
  %t58 = call i32 @new_reg(ptr %t0)
  %t59 = sext i32 %t58 to i64
  store i64 %t59, ptr %t57
  %t60 = alloca i64
  %t61 = load ptr, ptr %t1
  %t62 = call i32 @str_literal_len(ptr %t61)
  %t63 = sext i32 %t62 to i64
  store i64 %t63, ptr %t60
  %t64 = load ptr, ptr %t0
  %t65 = getelementptr [62 x i8], ptr @.str50, i64 0, i64 0
  %t66 = load i64, ptr %t57
  %t67 = load i64, ptr %t60
  %t68 = load i64, ptr %t53
  call void @__c0c_emit(ptr %t64, ptr %t65, i64 %t66, i64 %t67, i64 %t68)
  %t70 = alloca ptr
  %t71 = load ptr, ptr %t70
  %t72 = getelementptr [6 x i8], ptr @.str51, i64 0, i64 0
  %t73 = load i64, ptr %t57
  %t74 = call i32 @snprintf(ptr %t71, i64 8, ptr %t72, i64 %t73)
  %t75 = sext i32 %t74 to i64
  %t76 = load ptr, ptr %t70
  %t77 = call ptr @default_ptr_type()
  %t78 = call i64 @make_val(ptr %t76, ptr %t77)
  ret i64 %t78
L33:
  br label %L9
L9:
  %t79 = alloca ptr
  %t80 = load ptr, ptr %t1
  %t81 = call ptr @find_local(ptr %t0, ptr %t80)
  store ptr %t81, ptr %t79
  %t82 = load ptr, ptr %t79
  %t83 = icmp ne ptr %t82, null
  br i1 %t83, label %L34, label %L36
L34:
  %t84 = load ptr, ptr %t79
  %t85 = load ptr, ptr %t84
  %t86 = icmp ne ptr %t85, null
  br i1 %t86, label %L37, label %L39
L37:
  %t87 = load ptr, ptr %t79
  %t88 = load ptr, ptr %t87
  %t89 = load ptr, ptr %t79
  %t90 = load ptr, ptr %t89
  %t91 = call i64 @make_val(ptr %t88, ptr %t90)
  ret i64 %t91
L40:
  br label %L39
L39:
  %t92 = alloca i64
  %t93 = call i32 @new_reg(ptr %t0)
  %t94 = sext i32 %t93 to i64
  store i64 %t94, ptr %t92
  %t95 = alloca ptr
  %t96 = alloca ptr
  %t97 = load ptr, ptr %t79
  %t98 = load ptr, ptr %t97
  %t99 = load ptr, ptr %t79
  %t100 = load ptr, ptr %t99
  %t101 = load ptr, ptr %t100
  %t103 = ptrtoint ptr %t101 to i64
  %t104 = sext i32 15 to i64
  %t102 = icmp eq i64 %t103, %t104
  %t105 = zext i1 %t102 to i64
  %t106 = load ptr, ptr %t79
  %t107 = load ptr, ptr %t106
  %t108 = load ptr, ptr %t107
  %t110 = ptrtoint ptr %t108 to i64
  %t111 = sext i32 16 to i64
  %t109 = icmp eq i64 %t110, %t111
  %t112 = zext i1 %t109 to i64
  %t114 = icmp ne i64 %t105, 0
  %t115 = icmp ne i64 %t112, 0
  %t116 = or i1 %t114, %t115
  %t117 = zext i1 %t116 to i64
  %t119 = ptrtoint ptr %t98 to i64
  %t123 = ptrtoint ptr %t98 to i64
  %t120 = icmp ne i64 %t123, 0
  %t121 = icmp ne i64 %t117, 0
  %t122 = and i1 %t120, %t121
  %t124 = zext i1 %t122 to i64
  %t125 = icmp ne i64 %t124, 0
  br i1 %t125, label %L41, label %L42
L41:
  %t126 = getelementptr [4 x i8], ptr @.str52, i64 0, i64 0
  store ptr %t126, ptr %t95
  %t127 = call ptr @default_ptr_type()
  store ptr %t127, ptr %t96
  br label %L43
L42:
  %t128 = load ptr, ptr %t79
  %t129 = load ptr, ptr %t128
  %t130 = load ptr, ptr %t79
  %t131 = load ptr, ptr %t130
  %t132 = call i32 @type_is_fp(ptr %t131)
  %t133 = sext i32 %t132 to i64
  %t135 = ptrtoint ptr %t129 to i64
  %t139 = ptrtoint ptr %t129 to i64
  %t136 = icmp ne i64 %t139, 0
  %t137 = icmp ne i64 %t133, 0
  %t138 = and i1 %t136, %t137
  %t140 = zext i1 %t138 to i64
  %t141 = icmp ne i64 %t140, 0
  br i1 %t141, label %L44, label %L45
L44:
  %t142 = load ptr, ptr %t79
  %t143 = load ptr, ptr %t142
  %t144 = call ptr @llvm_type(ptr %t143)
  store ptr %t144, ptr %t95
  %t145 = load ptr, ptr %t79
  %t146 = load ptr, ptr %t145
  store ptr %t146, ptr %t96
  br label %L46
L45:
  %t147 = getelementptr [4 x i8], ptr @.str53, i64 0, i64 0
  store ptr %t147, ptr %t95
  %t148 = call ptr @default_i64_type()
  store ptr %t148, ptr %t96
  br label %L46
L46:
  br label %L43
L43:
  %t149 = load ptr, ptr %t0
  %t150 = getelementptr [27 x i8], ptr @.str54, i64 0, i64 0
  %t151 = load i64, ptr %t92
  %t152 = load ptr, ptr %t95
  %t153 = load ptr, ptr %t79
  %t154 = load ptr, ptr %t153
  call void @__c0c_emit(ptr %t149, ptr %t150, i64 %t151, ptr %t152, ptr %t154)
  %t156 = alloca ptr
  %t157 = load ptr, ptr %t156
  %t158 = getelementptr [6 x i8], ptr @.str55, i64 0, i64 0
  %t159 = load i64, ptr %t92
  %t160 = call i32 @snprintf(ptr %t157, i64 8, ptr %t158, i64 %t159)
  %t161 = sext i32 %t160 to i64
  %t162 = load ptr, ptr %t156
  %t163 = load ptr, ptr %t96
  %t164 = call i64 @make_val(ptr %t162, ptr %t163)
  ret i64 %t164
L47:
  br label %L36
L36:
  %t165 = alloca ptr
  %t166 = load ptr, ptr %t1
  %t167 = call ptr @find_global(ptr %t0, ptr %t166)
  store ptr %t167, ptr %t165
  %t168 = load ptr, ptr %t165
  %t169 = load ptr, ptr %t165
  %t170 = load ptr, ptr %t169
  %t172 = ptrtoint ptr %t168 to i64
  %t173 = ptrtoint ptr %t170 to i64
  %t177 = ptrtoint ptr %t168 to i64
  %t178 = ptrtoint ptr %t170 to i64
  %t174 = icmp ne i64 %t177, 0
  %t175 = icmp ne i64 %t178, 0
  %t176 = and i1 %t174, %t175
  %t179 = zext i1 %t176 to i64
  %t180 = load ptr, ptr %t165
  %t181 = load ptr, ptr %t180
  %t182 = load ptr, ptr %t181
  %t184 = ptrtoint ptr %t182 to i64
  %t185 = sext i32 17 to i64
  %t183 = icmp ne i64 %t184, %t185
  %t186 = zext i1 %t183 to i64
  %t188 = icmp ne i64 %t179, 0
  %t189 = icmp ne i64 %t186, 0
  %t190 = and i1 %t188, %t189
  %t191 = zext i1 %t190 to i64
  %t192 = icmp ne i64 %t191, 0
  br i1 %t192, label %L48, label %L50
L48:
  %t193 = alloca i64
  %t194 = call i32 @new_reg(ptr %t0)
  %t195 = sext i32 %t194 to i64
  store i64 %t195, ptr %t193
  %t196 = alloca ptr
  %t197 = alloca ptr
  %t198 = load ptr, ptr %t165
  %t199 = load ptr, ptr %t198
  %t200 = load ptr, ptr %t199
  %t202 = ptrtoint ptr %t200 to i64
  %t203 = sext i32 15 to i64
  %t201 = icmp eq i64 %t202, %t203
  %t204 = zext i1 %t201 to i64
  %t205 = load ptr, ptr %t165
  %t206 = load ptr, ptr %t205
  %t207 = load ptr, ptr %t206
  %t209 = ptrtoint ptr %t207 to i64
  %t210 = sext i32 16 to i64
  %t208 = icmp eq i64 %t209, %t210
  %t211 = zext i1 %t208 to i64
  %t213 = icmp ne i64 %t204, 0
  %t214 = icmp ne i64 %t211, 0
  %t215 = or i1 %t213, %t214
  %t216 = zext i1 %t215 to i64
  %t217 = icmp ne i64 %t216, 0
  br i1 %t217, label %L51, label %L52
L51:
  %t218 = getelementptr [4 x i8], ptr @.str56, i64 0, i64 0
  store ptr %t218, ptr %t196
  %t219 = call ptr @default_ptr_type()
  store ptr %t219, ptr %t197
  br label %L53
L52:
  %t220 = load ptr, ptr %t165
  %t221 = load ptr, ptr %t220
  %t222 = call i32 @type_is_fp(ptr %t221)
  %t223 = sext i32 %t222 to i64
  %t224 = icmp ne i64 %t223, 0
  br i1 %t224, label %L54, label %L55
L54:
  %t225 = load ptr, ptr %t165
  %t226 = load ptr, ptr %t225
  %t227 = call ptr @llvm_type(ptr %t226)
  store ptr %t227, ptr %t196
  %t228 = load ptr, ptr %t165
  %t229 = load ptr, ptr %t228
  store ptr %t229, ptr %t197
  br label %L56
L55:
  %t230 = getelementptr [4 x i8], ptr @.str57, i64 0, i64 0
  store ptr %t230, ptr %t196
  %t231 = call ptr @default_i64_type()
  store ptr %t231, ptr %t197
  br label %L56
L56:
  br label %L53
L53:
  %t232 = load ptr, ptr %t0
  %t233 = getelementptr [28 x i8], ptr @.str58, i64 0, i64 0
  %t234 = load i64, ptr %t193
  %t235 = load ptr, ptr %t196
  %t236 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t232, ptr %t233, i64 %t234, ptr %t235, ptr %t236)
  %t238 = alloca ptr
  %t239 = load ptr, ptr %t238
  %t240 = getelementptr [6 x i8], ptr @.str59, i64 0, i64 0
  %t241 = load i64, ptr %t193
  %t242 = call i32 @snprintf(ptr %t239, i64 8, ptr %t240, i64 %t241)
  %t243 = sext i32 %t242 to i64
  %t244 = load ptr, ptr %t238
  %t245 = load ptr, ptr %t197
  %t246 = call i64 @make_val(ptr %t244, ptr %t245)
  ret i64 %t246
L57:
  br label %L50
L50:
  %t247 = alloca ptr
  %t248 = load ptr, ptr %t247
  %t249 = getelementptr [4 x i8], ptr @.str60, i64 0, i64 0
  %t250 = load ptr, ptr %t1
  %t251 = call i32 @snprintf(ptr %t248, i64 8, ptr %t249, ptr %t250)
  %t252 = sext i32 %t251 to i64
  %t253 = load ptr, ptr %t247
  %t254 = call ptr @default_ptr_type()
  %t255 = call i64 @make_val(ptr %t253, ptr %t254)
  ret i64 %t255
L58:
  br label %L10
L10:
  %t256 = alloca ptr
  %t257 = load ptr, ptr %t1
  %t258 = sext i32 0 to i64
  %t259 = getelementptr i32, ptr %t257, i64 %t258
  %t260 = load i64, ptr %t259
  store i64 %t260, ptr %t256
  %t261 = alloca ptr
  %t262 = call ptr @default_int_type()
  store ptr %t262, ptr %t261
  %t263 = alloca ptr
  %t264 = load ptr, ptr %t1
  %t266 = ptrtoint ptr %t264 to i64
  %t267 = sext i32 8 to i64
  %t265 = mul i64 %t266, %t267
  %t268 = call ptr @malloc(i64 %t265)
  store ptr %t268, ptr %t263
  %t269 = alloca ptr
  %t270 = load ptr, ptr %t1
  %t272 = ptrtoint ptr %t270 to i64
  %t273 = sext i32 8 to i64
  %t271 = mul i64 %t272, %t273
  %t274 = call ptr @malloc(i64 %t271)
  store ptr %t274, ptr %t269
  %t275 = alloca i64
  %t276 = sext i32 1 to i64
  store i64 %t276, ptr %t275
  br label %L59
L59:
  %t277 = load i64, ptr %t275
  %t278 = load ptr, ptr %t1
  %t280 = ptrtoint ptr %t278 to i64
  %t279 = icmp slt i64 %t277, %t280
  %t281 = zext i1 %t279 to i64
  %t282 = icmp ne i64 %t281, 0
  br i1 %t282, label %L60, label %L62
L60:
  %t283 = alloca i64
  %t284 = load ptr, ptr %t1
  %t285 = load i64, ptr %t275
  %t286 = getelementptr i32, ptr %t284, i64 %t285
  %t287 = load i64, ptr %t286
  %t288 = call i64 @emit_expr(ptr %t0, i64 %t287)
  store i64 %t288, ptr %t283
  %t289 = load ptr, ptr %t283
  %t290 = call ptr @strdup(ptr %t289)
  %t291 = load ptr, ptr %t263
  %t292 = load i64, ptr %t275
  %t293 = getelementptr i8, ptr %t291, i64 %t292
  store ptr %t290, ptr %t293
  %t294 = load ptr, ptr %t283
  %t295 = load ptr, ptr %t269
  %t296 = load i64, ptr %t275
  %t297 = getelementptr i8, ptr %t295, i64 %t296
  store ptr %t294, ptr %t297
  br label %L61
L61:
  %t298 = load i64, ptr %t275
  %t299 = add i64 %t298, 1
  store i64 %t299, ptr %t275
  br label %L59
L62:
  %t300 = alloca ptr
  %t301 = sext i32 0 to i64
  store i64 %t301, ptr %t300
  %t302 = load ptr, ptr %t256
  %t303 = load ptr, ptr %t302
  %t305 = ptrtoint ptr %t303 to i64
  %t306 = sext i32 23 to i64
  %t304 = icmp eq i64 %t305, %t306
  %t307 = zext i1 %t304 to i64
  %t308 = icmp ne i64 %t307, 0
  br i1 %t308, label %L63, label %L64
L63:
  %t309 = load ptr, ptr %t300
  %t310 = getelementptr [4 x i8], ptr @.str61, i64 0, i64 0
  %t311 = load ptr, ptr %t256
  %t312 = load ptr, ptr %t311
  %t313 = call i32 @snprintf(ptr %t309, i64 8, ptr %t310, ptr %t312)
  %t314 = sext i32 %t313 to i64
  %t315 = alloca ptr
  %t316 = load ptr, ptr %t256
  %t317 = load ptr, ptr %t316
  %t318 = call ptr @find_global(ptr %t0, ptr %t317)
  store ptr %t318, ptr %t315
  %t319 = load ptr, ptr %t315
  %t320 = load ptr, ptr %t315
  %t321 = load ptr, ptr %t320
  %t323 = ptrtoint ptr %t319 to i64
  %t324 = ptrtoint ptr %t321 to i64
  %t328 = ptrtoint ptr %t319 to i64
  %t329 = ptrtoint ptr %t321 to i64
  %t325 = icmp ne i64 %t328, 0
  %t326 = icmp ne i64 %t329, 0
  %t327 = and i1 %t325, %t326
  %t330 = zext i1 %t327 to i64
  %t331 = load ptr, ptr %t315
  %t332 = load ptr, ptr %t331
  %t333 = load ptr, ptr %t332
  %t335 = ptrtoint ptr %t333 to i64
  %t336 = sext i32 17 to i64
  %t334 = icmp eq i64 %t335, %t336
  %t337 = zext i1 %t334 to i64
  %t339 = icmp ne i64 %t330, 0
  %t340 = icmp ne i64 %t337, 0
  %t341 = and i1 %t339, %t340
  %t342 = zext i1 %t341 to i64
  %t343 = icmp ne i64 %t342, 0
  br i1 %t343, label %L66, label %L67
L66:
  %t344 = load ptr, ptr %t315
  %t345 = load ptr, ptr %t344
  %t346 = load ptr, ptr %t345
  store ptr %t346, ptr %t261
  br label %L68
L67:
  %t347 = alloca ptr
  %t348 = sext i32 0 to i64
  store i64 %t348, ptr %t347
  %t349 = alloca i64
  %t350 = sext i32 0 to i64
  store i64 %t350, ptr %t349
  br label %L69
L69:
  %t351 = load ptr, ptr %t347
  %t352 = load i64, ptr %t349
  %t353 = getelementptr i32, ptr %t351, i64 %t352
  %t354 = load i64, ptr %t353
  %t355 = icmp ne i64 %t354, 0
  br i1 %t355, label %L70, label %L72
L70:
  %t356 = load ptr, ptr %t256
  %t357 = load ptr, ptr %t356
  %t358 = load ptr, ptr %t347
  %t359 = load i64, ptr %t349
  %t360 = getelementptr i32, ptr %t358, i64 %t359
  %t361 = load i64, ptr %t360
  %t362 = call i32 @strcmp(ptr %t357, i64 %t361)
  %t363 = sext i32 %t362 to i64
  %t365 = sext i32 0 to i64
  %t364 = icmp eq i64 %t363, %t365
  %t366 = zext i1 %t364 to i64
  %t367 = icmp ne i64 %t366, 0
  br i1 %t367, label %L73, label %L75
L73:
  %t368 = call ptr @default_ptr_type()
  store ptr %t368, ptr %t261
  br label %L72
L76:
  br label %L75
L75:
  br label %L71
L71:
  %t369 = load i64, ptr %t349
  %t370 = add i64 %t369, 1
  store i64 %t370, ptr %t349
  br label %L69
L72:
  %t371 = alloca ptr
  %t372 = sext i32 0 to i64
  store i64 %t372, ptr %t371
  %t373 = alloca i64
  %t374 = sext i32 0 to i64
  store i64 %t374, ptr %t373
  br label %L77
L77:
  %t375 = load ptr, ptr %t371
  %t376 = load i64, ptr %t373
  %t377 = getelementptr i32, ptr %t375, i64 %t376
  %t378 = load i64, ptr %t377
  %t379 = icmp ne i64 %t378, 0
  br i1 %t379, label %L78, label %L80
L78:
  %t380 = load ptr, ptr %t256
  %t381 = load ptr, ptr %t380
  %t382 = load ptr, ptr %t371
  %t383 = load i64, ptr %t373
  %t384 = getelementptr i32, ptr %t382, i64 %t383
  %t385 = load i64, ptr %t384
  %t386 = call i32 @strcmp(ptr %t381, i64 %t385)
  %t387 = sext i32 %t386 to i64
  %t389 = sext i32 0 to i64
  %t388 = icmp eq i64 %t387, %t389
  %t390 = zext i1 %t388 to i64
  %t391 = icmp ne i64 %t390, 0
  br i1 %t391, label %L81, label %L83
L81:
  %t392 = call ptr @default_i64_type()
  store ptr %t392, ptr %t261
  br label %L80
L84:
  br label %L83
L83:
  br label %L79
L79:
  %t393 = load i64, ptr %t373
  %t394 = add i64 %t393, 1
  store i64 %t394, ptr %t373
  br label %L77
L80:
  %t395 = alloca i64
  %t396 = sext i32 0 to i64
  store i64 %t396, ptr %t395
  %t397 = alloca ptr
  %t398 = sext i32 0 to i64
  store i64 %t398, ptr %t397
  %t399 = alloca i64
  %t400 = sext i32 0 to i64
  store i64 %t400, ptr %t399
  br label %L85
L85:
  %t401 = load ptr, ptr %t397
  %t402 = load i64, ptr %t399
  %t403 = getelementptr i32, ptr %t401, i64 %t402
  %t404 = load i64, ptr %t403
  %t405 = icmp ne i64 %t404, 0
  br i1 %t405, label %L86, label %L88
L86:
  %t406 = load ptr, ptr %t256
  %t407 = load ptr, ptr %t406
  %t408 = load ptr, ptr %t397
  %t409 = load i64, ptr %t399
  %t410 = getelementptr i32, ptr %t408, i64 %t409
  %t411 = load i64, ptr %t410
  %t412 = call i32 @strcmp(ptr %t407, i64 %t411)
  %t413 = sext i32 %t412 to i64
  %t415 = sext i32 0 to i64
  %t414 = icmp eq i64 %t413, %t415
  %t416 = zext i1 %t414 to i64
  %t417 = icmp ne i64 %t416, 0
  br i1 %t417, label %L89, label %L91
L89:
  store ptr %t395, ptr %t261
  br label %L88
L92:
  br label %L91
L91:
  br label %L87
L87:
  %t418 = load i64, ptr %t399
  %t419 = add i64 %t418, 1
  store i64 %t419, ptr %t399
  br label %L85
L88:
  br label %L68
L68:
  br label %L65
L64:
  %t420 = alloca i64
  %t421 = load ptr, ptr %t256
  %t422 = call i64 @emit_expr(ptr %t0, ptr %t421)
  store i64 %t422, ptr %t420
  %t423 = load ptr, ptr %t300
  %t424 = load ptr, ptr %t420
  %t426 = sext i32 8 to i64
  %t427 = sext i32 1 to i64
  %t425 = sub i64 %t426, %t427
  %t428 = call ptr @strncpy(ptr %t423, ptr %t424, i64 %t425)
  br label %L65
L65:
  %t429 = alloca i64
  %t430 = call i32 @new_reg(ptr %t0)
  %t431 = sext i32 %t430 to i64
  store i64 %t431, ptr %t429
  %t432 = alloca ptr
  %t433 = load ptr, ptr %t261
  %t434 = call ptr @llvm_type(ptr %t433)
  store ptr %t434, ptr %t432
  %t435 = alloca i64
  %t436 = load ptr, ptr %t261
  %t437 = load ptr, ptr %t436
  %t439 = ptrtoint ptr %t437 to i64
  %t440 = sext i32 0 to i64
  %t438 = icmp eq i64 %t439, %t440
  %t441 = zext i1 %t438 to i64
  store i64 %t441, ptr %t435
  %t442 = load i64, ptr %t435
  %t443 = icmp ne i64 %t442, 0
  br i1 %t443, label %L93, label %L94
L93:
  %t444 = load ptr, ptr %t0
  %t445 = getelementptr [16 x i8], ptr @.str62, i64 0, i64 0
  %t446 = load ptr, ptr %t300
  call void @__c0c_emit(ptr %t444, ptr %t445, ptr %t446)
  br label %L95
L94:
  %t448 = load ptr, ptr %t0
  %t449 = getelementptr [22 x i8], ptr @.str63, i64 0, i64 0
  %t450 = load i64, ptr %t429
  %t451 = load ptr, ptr %t432
  %t452 = load ptr, ptr %t300
  call void @__c0c_emit(ptr %t448, ptr %t449, i64 %t450, ptr %t451, ptr %t452)
  br label %L95
L95:
  %t454 = alloca i64
  %t455 = sext i32 1 to i64
  store i64 %t455, ptr %t454
  br label %L96
L96:
  %t456 = load i64, ptr %t454
  %t457 = load ptr, ptr %t1
  %t459 = ptrtoint ptr %t457 to i64
  %t458 = icmp slt i64 %t456, %t459
  %t460 = zext i1 %t458 to i64
  %t461 = icmp ne i64 %t460, 0
  br i1 %t461, label %L97, label %L99
L97:
  %t462 = load i64, ptr %t454
  %t464 = sext i32 1 to i64
  %t463 = icmp sgt i64 %t462, %t464
  %t465 = zext i1 %t463 to i64
  %t466 = icmp ne i64 %t465, 0
  br i1 %t466, label %L100, label %L102
L100:
  %t467 = load ptr, ptr %t0
  %t468 = getelementptr [3 x i8], ptr @.str64, i64 0, i64 0
  call void @__c0c_emit(ptr %t467, ptr %t468)
  br label %L102
L102:
  %t470 = alloca ptr
  %t471 = load ptr, ptr %t269
  %t472 = load i64, ptr %t454
  %t473 = getelementptr i32, ptr %t471, i64 %t472
  %t474 = load i64, ptr %t473
  %t475 = load ptr, ptr %t269
  %t476 = load i64, ptr %t454
  %t477 = getelementptr i32, ptr %t475, i64 %t476
  %t478 = load i64, ptr %t477
  %t479 = inttoptr i64 %t478 to ptr
  %t480 = load ptr, ptr %t479
  %t482 = ptrtoint ptr %t480 to i64
  %t483 = sext i32 15 to i64
  %t481 = icmp eq i64 %t482, %t483
  %t484 = zext i1 %t481 to i64
  %t485 = load ptr, ptr %t269
  %t486 = load i64, ptr %t454
  %t487 = getelementptr i32, ptr %t485, i64 %t486
  %t488 = load i64, ptr %t487
  %t489 = inttoptr i64 %t488 to ptr
  %t490 = load ptr, ptr %t489
  %t492 = ptrtoint ptr %t490 to i64
  %t493 = sext i32 16 to i64
  %t491 = icmp eq i64 %t492, %t493
  %t494 = zext i1 %t491 to i64
  %t496 = icmp ne i64 %t484, 0
  %t497 = icmp ne i64 %t494, 0
  %t498 = or i1 %t496, %t497
  %t499 = zext i1 %t498 to i64
  %t501 = icmp ne i64 %t474, 0
  %t502 = icmp ne i64 %t499, 0
  %t503 = and i1 %t501, %t502
  %t504 = zext i1 %t503 to i64
  %t505 = icmp ne i64 %t504, 0
  br i1 %t505, label %L103, label %L104
L103:
  %t506 = getelementptr [4 x i8], ptr @.str65, i64 0, i64 0
  store ptr %t506, ptr %t470
  br label %L105
L104:
  %t507 = load ptr, ptr %t269
  %t508 = load i64, ptr %t454
  %t509 = getelementptr i32, ptr %t507, i64 %t508
  %t510 = load i64, ptr %t509
  %t511 = load ptr, ptr %t269
  %t512 = load i64, ptr %t454
  %t513 = getelementptr i32, ptr %t511, i64 %t512
  %t514 = load i64, ptr %t513
  %t515 = call i32 @type_is_fp(i64 %t514)
  %t516 = sext i32 %t515 to i64
  %t518 = icmp ne i64 %t510, 0
  %t519 = icmp ne i64 %t516, 0
  %t520 = and i1 %t518, %t519
  %t521 = zext i1 %t520 to i64
  %t522 = icmp ne i64 %t521, 0
  br i1 %t522, label %L106, label %L107
L106:
  %t523 = load ptr, ptr %t269
  %t524 = load i64, ptr %t454
  %t525 = getelementptr i32, ptr %t523, i64 %t524
  %t526 = load i64, ptr %t525
  %t527 = call ptr @llvm_type(i64 %t526)
  store ptr %t527, ptr %t470
  br label %L108
L107:
  %t528 = getelementptr [4 x i8], ptr @.str66, i64 0, i64 0
  store ptr %t528, ptr %t470
  br label %L108
L108:
  br label %L105
L105:
  %t529 = load ptr, ptr %t0
  %t530 = getelementptr [6 x i8], ptr @.str67, i64 0, i64 0
  %t531 = load ptr, ptr %t470
  %t532 = load ptr, ptr %t263
  %t533 = load i64, ptr %t454
  %t534 = getelementptr i32, ptr %t532, i64 %t533
  %t535 = load i64, ptr %t534
  call void @__c0c_emit(ptr %t529, ptr %t530, ptr %t531, i64 %t535)
  br label %L98
L98:
  %t537 = load i64, ptr %t454
  %t538 = add i64 %t537, 1
  store i64 %t538, ptr %t454
  br label %L96
L99:
  %t539 = load ptr, ptr %t0
  %t540 = getelementptr [3 x i8], ptr @.str68, i64 0, i64 0
  call void @__c0c_emit(ptr %t539, ptr %t540)
  %t542 = alloca i64
  %t543 = sext i32 1 to i64
  store i64 %t543, ptr %t542
  br label %L109
L109:
  %t544 = load i64, ptr %t542
  %t545 = load ptr, ptr %t1
  %t547 = ptrtoint ptr %t545 to i64
  %t546 = icmp slt i64 %t544, %t547
  %t548 = zext i1 %t546 to i64
  %t549 = icmp ne i64 %t548, 0
  br i1 %t549, label %L110, label %L112
L110:
  %t550 = load ptr, ptr %t263
  %t551 = load i64, ptr %t542
  %t552 = getelementptr i32, ptr %t550, i64 %t551
  %t553 = load i64, ptr %t552
  call void @free(i64 %t553)
  br label %L111
L111:
  %t555 = load i64, ptr %t542
  %t556 = add i64 %t555, 1
  store i64 %t556, ptr %t542
  br label %L109
L112:
  %t557 = load ptr, ptr %t263
  call void @free(ptr %t557)
  %t559 = load ptr, ptr %t269
  call void @free(ptr %t559)
  %t561 = load i64, ptr %t435
  %t562 = icmp ne i64 %t561, 0
  br i1 %t562, label %L113, label %L115
L113:
  %t563 = getelementptr [2 x i8], ptr @.str69, i64 0, i64 0
  %t564 = load ptr, ptr %t261
  %t565 = call i64 @make_val(ptr %t563, ptr %t564)
  ret i64 %t565
L116:
  br label %L115
L115:
  %t566 = alloca ptr
  %t567 = load ptr, ptr %t566
  %t568 = getelementptr [6 x i8], ptr @.str70, i64 0, i64 0
  %t569 = load i64, ptr %t429
  %t570 = call i32 @snprintf(ptr %t567, i64 8, ptr %t568, i64 %t569)
  %t571 = sext i32 %t570 to i64
  %t572 = alloca ptr
  %t573 = load ptr, ptr %t261
  store ptr %t573, ptr %t572
  %t574 = load ptr, ptr %t261
  %t575 = call i32 @type_is_fp(ptr %t574)
  %t576 = sext i32 %t575 to i64
  %t578 = icmp eq i64 %t576, 0
  %t577 = zext i1 %t578 to i64
  %t579 = load ptr, ptr %t261
  %t580 = load ptr, ptr %t579
  %t582 = ptrtoint ptr %t580 to i64
  %t583 = sext i32 15 to i64
  %t581 = icmp ne i64 %t582, %t583
  %t584 = zext i1 %t581 to i64
  %t586 = icmp ne i64 %t577, 0
  %t587 = icmp ne i64 %t584, 0
  %t588 = and i1 %t586, %t587
  %t589 = zext i1 %t588 to i64
  %t590 = load ptr, ptr %t261
  %t591 = load ptr, ptr %t590
  %t593 = ptrtoint ptr %t591 to i64
  %t594 = sext i32 16 to i64
  %t592 = icmp ne i64 %t593, %t594
  %t595 = zext i1 %t592 to i64
  %t597 = icmp ne i64 %t589, 0
  %t598 = icmp ne i64 %t595, 0
  %t599 = and i1 %t597, %t598
  %t600 = zext i1 %t599 to i64
  %t601 = load ptr, ptr %t261
  %t602 = load ptr, ptr %t601
  %t604 = ptrtoint ptr %t602 to i64
  %t605 = sext i32 0 to i64
  %t603 = icmp ne i64 %t604, %t605
  %t606 = zext i1 %t603 to i64
  %t608 = icmp ne i64 %t600, 0
  %t609 = icmp ne i64 %t606, 0
  %t610 = and i1 %t608, %t609
  %t611 = zext i1 %t610 to i64
  %t612 = icmp ne i64 %t611, 0
  br i1 %t612, label %L117, label %L119
L117:
  %t613 = alloca i64
  %t614 = load ptr, ptr %t261
  %t615 = call i32 @type_size(ptr %t614)
  %t616 = sext i32 %t615 to i64
  store i64 %t616, ptr %t613
  %t617 = load i64, ptr %t613
  %t619 = sext i32 0 to i64
  %t618 = icmp sgt i64 %t617, %t619
  %t620 = zext i1 %t618 to i64
  %t621 = load i64, ptr %t613
  %t623 = sext i32 8 to i64
  %t622 = icmp slt i64 %t621, %t623
  %t624 = zext i1 %t622 to i64
  %t626 = icmp ne i64 %t620, 0
  %t627 = icmp ne i64 %t624, 0
  %t628 = and i1 %t626, %t627
  %t629 = zext i1 %t628 to i64
  %t630 = load ptr, ptr %t432
  %t631 = getelementptr [4 x i8], ptr @.str71, i64 0, i64 0
  %t632 = call i32 @strcmp(ptr %t630, ptr %t631)
  %t633 = sext i32 %t632 to i64
  %t635 = sext i32 0 to i64
  %t634 = icmp ne i64 %t633, %t635
  %t636 = zext i1 %t634 to i64
  %t638 = icmp ne i64 %t629, 0
  %t639 = icmp ne i64 %t636, 0
  %t640 = and i1 %t638, %t639
  %t641 = zext i1 %t640 to i64
  %t642 = icmp ne i64 %t641, 0
  br i1 %t642, label %L120, label %L122
L120:
  %t643 = alloca i64
  %t644 = call i32 @new_reg(ptr %t0)
  %t645 = sext i32 %t644 to i64
  store i64 %t645, ptr %t643
  %t646 = load ptr, ptr %t0
  %t647 = getelementptr [32 x i8], ptr @.str72, i64 0, i64 0
  %t648 = load i64, ptr %t643
  %t649 = load ptr, ptr %t432
  %t650 = load i64, ptr %t429
  call void @__c0c_emit(ptr %t646, ptr %t647, i64 %t648, ptr %t649, i64 %t650)
  %t652 = load ptr, ptr %t566
  %t653 = getelementptr [6 x i8], ptr @.str73, i64 0, i64 0
  %t654 = load i64, ptr %t643
  %t655 = call i32 @snprintf(ptr %t652, i64 8, ptr %t653, i64 %t654)
  %t656 = sext i32 %t655 to i64
  br label %L122
L122:
  %t657 = call ptr @default_i64_type()
  store ptr %t657, ptr %t572
  br label %L119
L119:
  %t658 = load ptr, ptr %t566
  %t659 = load ptr, ptr %t572
  %t660 = call i64 @make_val(ptr %t658, ptr %t659)
  ret i64 %t660
L123:
  br label %L11
L11:
  %t661 = alloca i64
  %t662 = load ptr, ptr %t1
  %t663 = sext i32 0 to i64
  %t664 = getelementptr i32, ptr %t662, i64 %t663
  %t665 = load i64, ptr %t664
  %t666 = call i64 @emit_expr(ptr %t0, i64 %t665)
  store i64 %t666, ptr %t661
  %t667 = alloca i64
  %t668 = load ptr, ptr %t1
  %t669 = sext i32 1 to i64
  %t670 = getelementptr i32, ptr %t668, i64 %t669
  %t671 = load i64, ptr %t670
  %t672 = call i64 @emit_expr(ptr %t0, i64 %t671)
  store i64 %t672, ptr %t667
  %t673 = alloca i64
  %t674 = call i32 @new_reg(ptr %t0)
  %t675 = sext i32 %t674 to i64
  store i64 %t675, ptr %t673
  %t676 = alloca i64
  %t677 = load ptr, ptr %t661
  %t678 = call i32 @type_is_fp(ptr %t677)
  %t679 = sext i32 %t678 to i64
  %t680 = load ptr, ptr %t667
  %t681 = call i32 @type_is_fp(ptr %t680)
  %t682 = sext i32 %t681 to i64
  %t684 = icmp ne i64 %t679, 0
  %t685 = icmp ne i64 %t682, 0
  %t686 = or i1 %t684, %t685
  %t687 = zext i1 %t686 to i64
  store i64 %t687, ptr %t676
  %t688 = alloca i64
  %t689 = load i64, ptr %t661
  %t690 = call i32 @val_is_ptr(i64 %t689)
  %t691 = sext i32 %t690 to i64
  store i64 %t691, ptr %t688
  %t692 = alloca ptr
  %t693 = load i64, ptr %t676
  %t694 = icmp ne i64 %t693, 0
  br i1 %t694, label %L124, label %L125
L124:
  %t695 = load ptr, ptr %t661
  %t696 = call ptr @llvm_type(ptr %t695)
  %t697 = ptrtoint ptr %t696 to i64
  br label %L126
L125:
  %t698 = getelementptr [4 x i8], ptr @.str74, i64 0, i64 0
  %t699 = ptrtoint ptr %t698 to i64
  br label %L126
L126:
  %t700 = phi i64 [ %t697, %L124 ], [ %t699, %L125 ]
  store i64 %t700, ptr %t692
  %t701 = alloca ptr
  %t702 = alloca ptr
  %t703 = load ptr, ptr %t701
  %t705 = sext i32 0 to i64
  %t704 = getelementptr i8, ptr %t703, i64 %t705
  %t706 = sext i32 0 to i64
  store i64 %t706, ptr %t704
  %t707 = load ptr, ptr %t702
  %t709 = sext i32 0 to i64
  %t708 = getelementptr i8, ptr %t707, i64 %t709
  %t710 = sext i32 0 to i64
  store i64 %t710, ptr %t708
  %t711 = load i64, ptr %t676
  %t713 = icmp eq i64 %t711, 0
  %t712 = zext i1 %t713 to i64
  %t714 = icmp ne i64 %t712, 0
  br i1 %t714, label %L127, label %L128
L127:
  %t715 = load i64, ptr %t661
  %t716 = load ptr, ptr %t701
  %t717 = call i32 @promote_to_i64(ptr %t0, i64 %t715, ptr %t716, i64 64)
  %t718 = sext i32 %t717 to i64
  %t719 = load i64, ptr %t667
  %t720 = load ptr, ptr %t702
  %t721 = call i32 @promote_to_i64(ptr %t0, i64 %t719, ptr %t720, i64 64)
  %t722 = sext i32 %t721 to i64
  %t723 = getelementptr [4 x i8], ptr @.str75, i64 0, i64 0
  store ptr %t723, ptr %t692
  br label %L129
L128:
  %t724 = load ptr, ptr %t701
  %t725 = load ptr, ptr %t661
  %t726 = call ptr @strncpy(ptr %t724, ptr %t725, i64 63)
  %t727 = load ptr, ptr %t701
  %t729 = sext i32 63 to i64
  %t728 = getelementptr i8, ptr %t727, i64 %t729
  %t730 = sext i32 0 to i64
  store i64 %t730, ptr %t728
  %t731 = load ptr, ptr %t702
  %t732 = load ptr, ptr %t667
  %t733 = call ptr @strncpy(ptr %t731, ptr %t732, i64 63)
  %t734 = load ptr, ptr %t702
  %t736 = sext i32 63 to i64
  %t735 = getelementptr i8, ptr %t734, i64 %t736
  %t737 = sext i32 0 to i64
  store i64 %t737, ptr %t735
  br label %L129
L129:
  %t738 = alloca ptr
  %t740 = sext i32 0 to i64
  %t739 = inttoptr i64 %t740 to ptr
  store ptr %t739, ptr %t738
  %t741 = alloca i64
  %t742 = sext i32 0 to i64
  store i64 %t742, ptr %t741
  %t743 = load ptr, ptr %t1
  %t744 = ptrtoint ptr %t743 to i64
  %t745 = add i64 %t744, 0
  switch i64 %t745, label %L149 [
    i64 35, label %L131
    i64 36, label %L132
    i64 37, label %L133
    i64 38, label %L134
    i64 39, label %L135
    i64 40, label %L136
    i64 41, label %L137
    i64 42, label %L138
    i64 44, label %L139
    i64 45, label %L140
    i64 46, label %L141
    i64 47, label %L142
    i64 48, label %L143
    i64 49, label %L144
    i64 50, label %L145
    i64 51, label %L146
    i64 52, label %L147
    i64 53, label %L148
  ]
L131:
  %t746 = load i64, ptr %t676
  %t747 = icmp ne i64 %t746, 0
  br i1 %t747, label %L150, label %L151
L150:
  %t748 = getelementptr [5 x i8], ptr @.str76, i64 0, i64 0
  %t749 = ptrtoint ptr %t748 to i64
  br label %L152
L151:
  %t750 = load i64, ptr %t688
  %t751 = icmp ne i64 %t750, 0
  br i1 %t751, label %L153, label %L154
L153:
  %t752 = getelementptr [14 x i8], ptr @.str77, i64 0, i64 0
  %t753 = ptrtoint ptr %t752 to i64
  br label %L155
L154:
  %t754 = getelementptr [4 x i8], ptr @.str78, i64 0, i64 0
  %t755 = ptrtoint ptr %t754 to i64
  br label %L155
L155:
  %t756 = phi i64 [ %t753, %L153 ], [ %t755, %L154 ]
  br label %L152
L152:
  %t757 = phi i64 [ %t749, %L150 ], [ %t756, %L151 ]
  store i64 %t757, ptr %t738
  br label %L130
L156:
  br label %L132
L132:
  %t758 = load i64, ptr %t676
  %t759 = icmp ne i64 %t758, 0
  br i1 %t759, label %L157, label %L158
L157:
  %t760 = getelementptr [5 x i8], ptr @.str79, i64 0, i64 0
  %t761 = ptrtoint ptr %t760 to i64
  br label %L159
L158:
  %t762 = getelementptr [4 x i8], ptr @.str80, i64 0, i64 0
  %t763 = ptrtoint ptr %t762 to i64
  br label %L159
L159:
  %t764 = phi i64 [ %t761, %L157 ], [ %t763, %L158 ]
  store i64 %t764, ptr %t738
  br label %L130
L160:
  br label %L133
L133:
  %t765 = load i64, ptr %t676
  %t766 = icmp ne i64 %t765, 0
  br i1 %t766, label %L161, label %L162
L161:
  %t767 = getelementptr [5 x i8], ptr @.str81, i64 0, i64 0
  %t768 = ptrtoint ptr %t767 to i64
  br label %L163
L162:
  %t769 = getelementptr [4 x i8], ptr @.str82, i64 0, i64 0
  %t770 = ptrtoint ptr %t769 to i64
  br label %L163
L163:
  %t771 = phi i64 [ %t768, %L161 ], [ %t770, %L162 ]
  store i64 %t771, ptr %t738
  br label %L130
L164:
  br label %L134
L134:
  %t772 = load i64, ptr %t676
  %t773 = icmp ne i64 %t772, 0
  br i1 %t773, label %L165, label %L166
L165:
  %t774 = getelementptr [5 x i8], ptr @.str83, i64 0, i64 0
  %t775 = ptrtoint ptr %t774 to i64
  br label %L167
L166:
  %t776 = getelementptr [5 x i8], ptr @.str84, i64 0, i64 0
  %t777 = ptrtoint ptr %t776 to i64
  br label %L167
L167:
  %t778 = phi i64 [ %t775, %L165 ], [ %t777, %L166 ]
  store i64 %t778, ptr %t738
  br label %L130
L168:
  br label %L135
L135:
  %t779 = load i64, ptr %t676
  %t780 = icmp ne i64 %t779, 0
  br i1 %t780, label %L169, label %L170
L169:
  %t781 = getelementptr [5 x i8], ptr @.str85, i64 0, i64 0
  %t782 = ptrtoint ptr %t781 to i64
  br label %L171
L170:
  %t783 = getelementptr [5 x i8], ptr @.str86, i64 0, i64 0
  %t784 = ptrtoint ptr %t783 to i64
  br label %L171
L171:
  %t785 = phi i64 [ %t782, %L169 ], [ %t784, %L170 ]
  store i64 %t785, ptr %t738
  br label %L130
L172:
  br label %L136
L136:
  %t786 = getelementptr [4 x i8], ptr @.str87, i64 0, i64 0
  store ptr %t786, ptr %t738
  br label %L130
L173:
  br label %L137
L137:
  %t787 = getelementptr [3 x i8], ptr @.str88, i64 0, i64 0
  store ptr %t787, ptr %t738
  br label %L130
L174:
  br label %L138
L138:
  %t788 = getelementptr [4 x i8], ptr @.str89, i64 0, i64 0
  store ptr %t788, ptr %t738
  br label %L130
L175:
  br label %L139
L139:
  %t789 = getelementptr [4 x i8], ptr @.str90, i64 0, i64 0
  store ptr %t789, ptr %t738
  br label %L130
L176:
  br label %L140
L140:
  %t790 = getelementptr [5 x i8], ptr @.str91, i64 0, i64 0
  store ptr %t790, ptr %t738
  br label %L130
L177:
  br label %L141
L141:
  %t791 = load i64, ptr %t676
  %t792 = icmp ne i64 %t791, 0
  br i1 %t792, label %L178, label %L179
L178:
  %t793 = getelementptr [9 x i8], ptr @.str92, i64 0, i64 0
  %t794 = ptrtoint ptr %t793 to i64
  br label %L180
L179:
  %t795 = getelementptr [8 x i8], ptr @.str93, i64 0, i64 0
  %t796 = ptrtoint ptr %t795 to i64
  br label %L180
L180:
  %t797 = phi i64 [ %t794, %L178 ], [ %t796, %L179 ]
  store i64 %t797, ptr %t738
  %t798 = sext i32 1 to i64
  store i64 %t798, ptr %t741
  br label %L130
L181:
  br label %L142
L142:
  %t799 = load i64, ptr %t676
  %t800 = icmp ne i64 %t799, 0
  br i1 %t800, label %L182, label %L183
L182:
  %t801 = getelementptr [9 x i8], ptr @.str94, i64 0, i64 0
  %t802 = ptrtoint ptr %t801 to i64
  br label %L184
L183:
  %t803 = getelementptr [8 x i8], ptr @.str95, i64 0, i64 0
  %t804 = ptrtoint ptr %t803 to i64
  br label %L184
L184:
  %t805 = phi i64 [ %t802, %L182 ], [ %t804, %L183 ]
  store i64 %t805, ptr %t738
  %t806 = sext i32 1 to i64
  store i64 %t806, ptr %t741
  br label %L130
L185:
  br label %L143
L143:
  %t807 = load i64, ptr %t676
  %t808 = icmp ne i64 %t807, 0
  br i1 %t808, label %L186, label %L187
L186:
  %t809 = getelementptr [9 x i8], ptr @.str96, i64 0, i64 0
  %t810 = ptrtoint ptr %t809 to i64
  br label %L188
L187:
  %t811 = getelementptr [9 x i8], ptr @.str97, i64 0, i64 0
  %t812 = ptrtoint ptr %t811 to i64
  br label %L188
L188:
  %t813 = phi i64 [ %t810, %L186 ], [ %t812, %L187 ]
  store i64 %t813, ptr %t738
  %t814 = sext i32 1 to i64
  store i64 %t814, ptr %t741
  br label %L130
L189:
  br label %L144
L144:
  %t815 = load i64, ptr %t676
  %t816 = icmp ne i64 %t815, 0
  br i1 %t816, label %L190, label %L191
L190:
  %t817 = getelementptr [9 x i8], ptr @.str98, i64 0, i64 0
  %t818 = ptrtoint ptr %t817 to i64
  br label %L192
L191:
  %t819 = getelementptr [9 x i8], ptr @.str99, i64 0, i64 0
  %t820 = ptrtoint ptr %t819 to i64
  br label %L192
L192:
  %t821 = phi i64 [ %t818, %L190 ], [ %t820, %L191 ]
  store i64 %t821, ptr %t738
  %t822 = sext i32 1 to i64
  store i64 %t822, ptr %t741
  br label %L130
L193:
  br label %L145
L145:
  %t823 = load i64, ptr %t676
  %t824 = icmp ne i64 %t823, 0
  br i1 %t824, label %L194, label %L195
L194:
  %t825 = getelementptr [9 x i8], ptr @.str100, i64 0, i64 0
  %t826 = ptrtoint ptr %t825 to i64
  br label %L196
L195:
  %t827 = getelementptr [9 x i8], ptr @.str101, i64 0, i64 0
  %t828 = ptrtoint ptr %t827 to i64
  br label %L196
L196:
  %t829 = phi i64 [ %t826, %L194 ], [ %t828, %L195 ]
  store i64 %t829, ptr %t738
  %t830 = sext i32 1 to i64
  store i64 %t830, ptr %t741
  br label %L130
L197:
  br label %L146
L146:
  %t831 = load i64, ptr %t676
  %t832 = icmp ne i64 %t831, 0
  br i1 %t832, label %L198, label %L199
L198:
  %t833 = getelementptr [9 x i8], ptr @.str102, i64 0, i64 0
  %t834 = ptrtoint ptr %t833 to i64
  br label %L200
L199:
  %t835 = getelementptr [9 x i8], ptr @.str103, i64 0, i64 0
  %t836 = ptrtoint ptr %t835 to i64
  br label %L200
L200:
  %t837 = phi i64 [ %t834, %L198 ], [ %t836, %L199 ]
  store i64 %t837, ptr %t738
  %t838 = sext i32 1 to i64
  store i64 %t838, ptr %t741
  br label %L130
L201:
  br label %L147
L147:
  %t839 = alloca i64
  %t840 = call i32 @new_reg(ptr %t0)
  %t841 = sext i32 %t840 to i64
  store i64 %t841, ptr %t839
  %t842 = alloca i64
  %t843 = call i32 @new_reg(ptr %t0)
  %t844 = sext i32 %t843 to i64
  store i64 %t844, ptr %t842
  %t845 = alloca i64
  %t846 = call i32 @new_reg(ptr %t0)
  %t847 = sext i32 %t846 to i64
  store i64 %t847, ptr %t845
  %t848 = alloca ptr
  %t849 = alloca ptr
  %t850 = load i64, ptr %t661
  %t851 = load ptr, ptr %t848
  %t852 = call i32 @promote_to_i64(ptr %t0, i64 %t850, ptr %t851, i64 64)
  %t853 = sext i32 %t852 to i64
  %t854 = load i64, ptr %t667
  %t855 = load ptr, ptr %t849
  %t856 = call i32 @promote_to_i64(ptr %t0, i64 %t854, ptr %t855, i64 64)
  %t857 = sext i32 %t856 to i64
  %t858 = load ptr, ptr %t0
  %t859 = getelementptr [29 x i8], ptr @.str104, i64 0, i64 0
  %t860 = load i64, ptr %t839
  %t861 = load ptr, ptr %t848
  call void @__c0c_emit(ptr %t858, ptr %t859, i64 %t860, ptr %t861)
  %t863 = load ptr, ptr %t0
  %t864 = getelementptr [29 x i8], ptr @.str105, i64 0, i64 0
  %t865 = load i64, ptr %t842
  %t866 = load ptr, ptr %t849
  call void @__c0c_emit(ptr %t863, ptr %t864, i64 %t865, ptr %t866)
  %t868 = load ptr, ptr %t0
  %t869 = getelementptr [31 x i8], ptr @.str106, i64 0, i64 0
  %t870 = load i64, ptr %t845
  %t871 = load i64, ptr %t839
  %t872 = load i64, ptr %t842
  call void @__c0c_emit(ptr %t868, ptr %t869, i64 %t870, i64 %t871, i64 %t872)
  %t874 = alloca i64
  %t875 = call i32 @new_reg(ptr %t0)
  %t876 = sext i32 %t875 to i64
  store i64 %t876, ptr %t874
  %t877 = load ptr, ptr %t0
  %t878 = getelementptr [32 x i8], ptr @.str107, i64 0, i64 0
  %t879 = load i64, ptr %t874
  %t880 = load i64, ptr %t845
  call void @__c0c_emit(ptr %t877, ptr %t878, i64 %t879, i64 %t880)
  %t882 = alloca ptr
  %t883 = load ptr, ptr %t882
  %t884 = getelementptr [6 x i8], ptr @.str108, i64 0, i64 0
  %t885 = load i64, ptr %t874
  %t886 = call i32 @snprintf(ptr %t883, i64 8, ptr %t884, i64 %t885)
  %t887 = sext i32 %t886 to i64
  %t888 = load ptr, ptr %t882
  %t889 = call ptr @default_i64_type()
  %t890 = call i64 @make_val(ptr %t888, ptr %t889)
  ret i64 %t890
L202:
  br label %L148
L148:
  %t891 = alloca i64
  %t892 = call i32 @new_reg(ptr %t0)
  %t893 = sext i32 %t892 to i64
  store i64 %t893, ptr %t891
  %t894 = alloca i64
  %t895 = call i32 @new_reg(ptr %t0)
  %t896 = sext i32 %t895 to i64
  store i64 %t896, ptr %t894
  %t897 = alloca i64
  %t898 = call i32 @new_reg(ptr %t0)
  %t899 = sext i32 %t898 to i64
  store i64 %t899, ptr %t897
  %t900 = alloca ptr
  %t901 = alloca ptr
  %t902 = load i64, ptr %t661
  %t903 = load ptr, ptr %t900
  %t904 = call i32 @promote_to_i64(ptr %t0, i64 %t902, ptr %t903, i64 64)
  %t905 = sext i32 %t904 to i64
  %t906 = load i64, ptr %t667
  %t907 = load ptr, ptr %t901
  %t908 = call i32 @promote_to_i64(ptr %t0, i64 %t906, ptr %t907, i64 64)
  %t909 = sext i32 %t908 to i64
  %t910 = load ptr, ptr %t0
  %t911 = getelementptr [29 x i8], ptr @.str109, i64 0, i64 0
  %t912 = load i64, ptr %t891
  %t913 = load ptr, ptr %t900
  call void @__c0c_emit(ptr %t910, ptr %t911, i64 %t912, ptr %t913)
  %t915 = load ptr, ptr %t0
  %t916 = getelementptr [29 x i8], ptr @.str110, i64 0, i64 0
  %t917 = load i64, ptr %t894
  %t918 = load ptr, ptr %t901
  call void @__c0c_emit(ptr %t915, ptr %t916, i64 %t917, ptr %t918)
  %t920 = load ptr, ptr %t0
  %t921 = getelementptr [30 x i8], ptr @.str111, i64 0, i64 0
  %t922 = load i64, ptr %t897
  %t923 = load i64, ptr %t891
  %t924 = load i64, ptr %t894
  call void @__c0c_emit(ptr %t920, ptr %t921, i64 %t922, i64 %t923, i64 %t924)
  %t926 = alloca i64
  %t927 = call i32 @new_reg(ptr %t0)
  %t928 = sext i32 %t927 to i64
  store i64 %t928, ptr %t926
  %t929 = load ptr, ptr %t0
  %t930 = getelementptr [32 x i8], ptr @.str112, i64 0, i64 0
  %t931 = load i64, ptr %t926
  %t932 = load i64, ptr %t897
  call void @__c0c_emit(ptr %t929, ptr %t930, i64 %t931, i64 %t932)
  %t934 = alloca ptr
  %t935 = load ptr, ptr %t934
  %t936 = getelementptr [6 x i8], ptr @.str113, i64 0, i64 0
  %t937 = load i64, ptr %t926
  %t938 = call i32 @snprintf(ptr %t935, i64 8, ptr %t936, i64 %t937)
  %t939 = sext i32 %t938 to i64
  %t940 = load ptr, ptr %t934
  %t941 = call ptr @default_i64_type()
  %t942 = call i64 @make_val(ptr %t940, ptr %t941)
  ret i64 %t942
L203:
  br label %L130
L149:
  %t943 = getelementptr [4 x i8], ptr @.str114, i64 0, i64 0
  store ptr %t943, ptr %t738
  br label %L130
L130:
  %t944 = load ptr, ptr %t1
  %t946 = ptrtoint ptr %t944 to i64
  %t947 = sext i32 35 to i64
  %t945 = icmp eq i64 %t946, %t947
  %t948 = zext i1 %t945 to i64
  %t949 = load i64, ptr %t688
  %t951 = icmp ne i64 %t948, 0
  %t952 = icmp ne i64 %t949, 0
  %t953 = and i1 %t951, %t952
  %t954 = zext i1 %t953 to i64
  %t955 = icmp ne i64 %t954, 0
  br i1 %t955, label %L204, label %L205
L204:
  %t956 = alloca i64
  %t957 = call i32 @new_reg(ptr %t0)
  %t958 = sext i32 %t957 to i64
  store i64 %t958, ptr %t956
  %t959 = load ptr, ptr %t0
  %t960 = getelementptr [34 x i8], ptr @.str115, i64 0, i64 0
  %t961 = load i64, ptr %t956
  %t962 = load ptr, ptr %t701
  call void @__c0c_emit(ptr %t959, ptr %t960, i64 %t961, ptr %t962)
  %t964 = load ptr, ptr %t0
  %t965 = getelementptr [47 x i8], ptr @.str116, i64 0, i64 0
  %t966 = load i64, ptr %t673
  %t967 = load i64, ptr %t956
  %t968 = load ptr, ptr %t702
  call void @__c0c_emit(ptr %t964, ptr %t965, i64 %t966, i64 %t967, ptr %t968)
  br label %L206
L205:
  %t970 = load i64, ptr %t741
  %t971 = icmp ne i64 %t970, 0
  br i1 %t971, label %L207, label %L208
L207:
  %t972 = load ptr, ptr %t0
  %t973 = getelementptr [24 x i8], ptr @.str117, i64 0, i64 0
  %t974 = load i64, ptr %t673
  %t975 = load ptr, ptr %t738
  %t976 = load ptr, ptr %t692
  %t977 = load ptr, ptr %t701
  %t978 = load ptr, ptr %t702
  call void @__c0c_emit(ptr %t972, ptr %t973, i64 %t974, ptr %t975, ptr %t976, ptr %t977, ptr %t978)
  %t980 = alloca i64
  %t981 = call i32 @new_reg(ptr %t0)
  %t982 = sext i32 %t981 to i64
  store i64 %t982, ptr %t980
  %t983 = load ptr, ptr %t0
  %t984 = getelementptr [32 x i8], ptr @.str118, i64 0, i64 0
  %t985 = load i64, ptr %t980
  %t986 = load i64, ptr %t673
  call void @__c0c_emit(ptr %t983, ptr %t984, i64 %t985, i64 %t986)
  %t988 = alloca ptr
  %t989 = load ptr, ptr %t988
  %t990 = getelementptr [6 x i8], ptr @.str119, i64 0, i64 0
  %t991 = load i64, ptr %t980
  %t992 = call i32 @snprintf(ptr %t989, i64 8, ptr %t990, i64 %t991)
  %t993 = sext i32 %t992 to i64
  %t994 = load ptr, ptr %t988
  %t995 = call ptr @default_i64_type()
  %t996 = call i64 @make_val(ptr %t994, ptr %t995)
  ret i64 %t996
L210:
  br label %L209
L208:
  %t997 = load ptr, ptr %t0
  %t998 = getelementptr [24 x i8], ptr @.str120, i64 0, i64 0
  %t999 = load i64, ptr %t673
  %t1000 = load ptr, ptr %t738
  %t1001 = load ptr, ptr %t692
  %t1002 = load ptr, ptr %t701
  %t1003 = load ptr, ptr %t702
  call void @__c0c_emit(ptr %t997, ptr %t998, i64 %t999, ptr %t1000, ptr %t1001, ptr %t1002, ptr %t1003)
  br label %L209
L209:
  br label %L206
L206:
  %t1005 = alloca ptr
  %t1006 = load ptr, ptr %t1005
  %t1007 = getelementptr [6 x i8], ptr @.str121, i64 0, i64 0
  %t1008 = load i64, ptr %t673
  %t1009 = call i32 @snprintf(ptr %t1006, i64 8, ptr %t1007, i64 %t1008)
  %t1010 = sext i32 %t1009 to i64
  %t1011 = load ptr, ptr %t1
  %t1013 = ptrtoint ptr %t1011 to i64
  %t1014 = sext i32 35 to i64
  %t1012 = icmp eq i64 %t1013, %t1014
  %t1015 = zext i1 %t1012 to i64
  %t1016 = load i64, ptr %t688
  %t1018 = icmp ne i64 %t1015, 0
  %t1019 = icmp ne i64 %t1016, 0
  %t1020 = and i1 %t1018, %t1019
  %t1021 = zext i1 %t1020 to i64
  %t1022 = icmp ne i64 %t1021, 0
  br i1 %t1022, label %L211, label %L213
L211:
  %t1023 = load ptr, ptr %t1005
  %t1024 = call ptr @default_ptr_type()
  %t1025 = call i64 @make_val(ptr %t1023, ptr %t1024)
  ret i64 %t1025
L214:
  br label %L213
L213:
  %t1026 = load i64, ptr %t688
  %t1027 = icmp ne i64 %t1026, 0
  br i1 %t1027, label %L215, label %L217
L215:
  %t1028 = load ptr, ptr %t1005
  %t1029 = call ptr @default_i64_type()
  %t1030 = call i64 @make_val(ptr %t1028, ptr %t1029)
  ret i64 %t1030
L218:
  br label %L217
L217:
  %t1031 = load ptr, ptr %t1005
  %t1032 = call ptr @default_i64_type()
  %t1033 = call i64 @make_val(ptr %t1031, ptr %t1032)
  ret i64 %t1033
L219:
  br label %L12
L12:
  %t1034 = alloca i64
  %t1035 = load ptr, ptr %t1
  %t1036 = sext i32 0 to i64
  %t1037 = getelementptr i32, ptr %t1035, i64 %t1036
  %t1038 = load i64, ptr %t1037
  %t1039 = call i64 @emit_expr(ptr %t0, i64 %t1038)
  store i64 %t1039, ptr %t1034
  %t1040 = alloca i64
  %t1041 = call i32 @new_reg(ptr %t0)
  %t1042 = sext i32 %t1041 to i64
  store i64 %t1042, ptr %t1040
  %t1043 = alloca i64
  %t1044 = load ptr, ptr %t1034
  %t1045 = call i32 @type_is_fp(ptr %t1044)
  %t1046 = sext i32 %t1045 to i64
  store i64 %t1046, ptr %t1043
  %t1047 = alloca ptr
  %t1048 = load i64, ptr %t1043
  %t1050 = icmp eq i64 %t1048, 0
  %t1049 = zext i1 %t1050 to i64
  %t1051 = icmp ne i64 %t1049, 0
  br i1 %t1051, label %L220, label %L222
L220:
  %t1052 = load i64, ptr %t1034
  %t1053 = load ptr, ptr %t1047
  %t1054 = call i32 @promote_to_i64(ptr %t0, i64 %t1052, ptr %t1053, i64 64)
  %t1055 = sext i32 %t1054 to i64
  br label %L222
L222:
  %t1056 = load ptr, ptr %t1
  %t1057 = ptrtoint ptr %t1056 to i64
  %t1058 = add i64 %t1057, 0
  switch i64 %t1058, label %L228 [
    i64 36, label %L224
    i64 54, label %L225
    i64 43, label %L226
    i64 35, label %L227
  ]
L224:
  %t1059 = load i64, ptr %t1043
  %t1060 = icmp ne i64 %t1059, 0
  br i1 %t1060, label %L229, label %L230
L229:
  %t1061 = load ptr, ptr %t0
  %t1062 = getelementptr [26 x i8], ptr @.str122, i64 0, i64 0
  %t1063 = load i64, ptr %t1040
  %t1064 = load ptr, ptr %t1034
  call void @__c0c_emit(ptr %t1061, ptr %t1062, i64 %t1063, ptr %t1064)
  br label %L231
L230:
  %t1066 = load ptr, ptr %t0
  %t1067 = getelementptr [25 x i8], ptr @.str123, i64 0, i64 0
  %t1068 = load i64, ptr %t1040
  %t1069 = load ptr, ptr %t1047
  call void @__c0c_emit(ptr %t1066, ptr %t1067, i64 %t1068, ptr %t1069)
  br label %L231
L231:
  br label %L223
L232:
  br label %L225
L225:
  %t1071 = alloca i64
  %t1072 = call i32 @new_reg(ptr %t0)
  %t1073 = sext i32 %t1072 to i64
  store i64 %t1073, ptr %t1071
  %t1074 = load ptr, ptr %t0
  %t1075 = getelementptr [29 x i8], ptr @.str124, i64 0, i64 0
  %t1076 = load i64, ptr %t1071
  %t1077 = load ptr, ptr %t1047
  call void @__c0c_emit(ptr %t1074, ptr %t1075, i64 %t1076, ptr %t1077)
  %t1079 = load ptr, ptr %t0
  %t1080 = getelementptr [32 x i8], ptr @.str125, i64 0, i64 0
  %t1081 = load i64, ptr %t1040
  %t1082 = load i64, ptr %t1071
  call void @__c0c_emit(ptr %t1079, ptr %t1080, i64 %t1081, i64 %t1082)
  br label %L223
L233:
  br label %L226
L226:
  %t1084 = load ptr, ptr %t0
  %t1085 = getelementptr [26 x i8], ptr @.str126, i64 0, i64 0
  %t1086 = load i64, ptr %t1040
  %t1087 = load ptr, ptr %t1047
  call void @__c0c_emit(ptr %t1084, ptr %t1085, i64 %t1086, ptr %t1087)
  br label %L223
L234:
  br label %L227
L227:
  %t1089 = load i64, ptr %t1034
  ret i64 %t1089
L235:
  br label %L223
L228:
  %t1090 = load ptr, ptr %t0
  %t1091 = getelementptr [25 x i8], ptr @.str127, i64 0, i64 0
  %t1092 = load i64, ptr %t1040
  %t1093 = load ptr, ptr %t1047
  call void @__c0c_emit(ptr %t1090, ptr %t1091, i64 %t1092, ptr %t1093)
  br label %L223
L223:
  %t1095 = alloca ptr
  %t1096 = load ptr, ptr %t1095
  %t1097 = getelementptr [6 x i8], ptr @.str128, i64 0, i64 0
  %t1098 = load i64, ptr %t1040
  %t1099 = call i32 @snprintf(ptr %t1096, i64 8, ptr %t1097, i64 %t1098)
  %t1100 = sext i32 %t1099 to i64
  %t1101 = load ptr, ptr %t1095
  %t1102 = load i64, ptr %t1043
  %t1103 = icmp ne i64 %t1102, 0
  br i1 %t1103, label %L236, label %L237
L236:
  %t1104 = load ptr, ptr %t1034
  %t1105 = ptrtoint ptr %t1104 to i64
  br label %L238
L237:
  %t1106 = call ptr @default_i64_type()
  %t1107 = ptrtoint ptr %t1106 to i64
  br label %L238
L238:
  %t1108 = phi i64 [ %t1105, %L236 ], [ %t1107, %L237 ]
  %t1109 = call i64 @make_val(ptr %t1101, i64 %t1108)
  ret i64 %t1109
L239:
  br label %L13
L13:
  %t1110 = alloca i64
  %t1111 = load ptr, ptr %t1
  %t1112 = sext i32 1 to i64
  %t1113 = getelementptr i32, ptr %t1111, i64 %t1112
  %t1114 = load i64, ptr %t1113
  %t1115 = call i64 @emit_expr(ptr %t0, i64 %t1114)
  store i64 %t1115, ptr %t1110
  %t1116 = alloca ptr
  %t1117 = load ptr, ptr %t1
  %t1118 = sext i32 0 to i64
  %t1119 = getelementptr i32, ptr %t1117, i64 %t1118
  %t1120 = load i64, ptr %t1119
  %t1121 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1120)
  store ptr %t1121, ptr %t1116
  %t1122 = load ptr, ptr %t1116
  %t1123 = icmp ne ptr %t1122, null
  br i1 %t1123, label %L240, label %L242
L240:
  %t1124 = alloca ptr
  %t1125 = load i64, ptr %t1110
  %t1126 = call i32 @val_is_ptr(i64 %t1125)
  %t1127 = sext i32 %t1126 to i64
  %t1128 = icmp ne i64 %t1127, 0
  br i1 %t1128, label %L243, label %L244
L243:
  %t1129 = getelementptr [4 x i8], ptr @.str129, i64 0, i64 0
  store ptr %t1129, ptr %t1124
  br label %L245
L244:
  %t1130 = load ptr, ptr %t1110
  %t1131 = call i32 @type_is_fp(ptr %t1130)
  %t1132 = sext i32 %t1131 to i64
  %t1133 = icmp ne i64 %t1132, 0
  br i1 %t1133, label %L246, label %L247
L246:
  %t1134 = load ptr, ptr %t1110
  %t1135 = call ptr @llvm_type(ptr %t1134)
  store ptr %t1135, ptr %t1124
  br label %L248
L247:
  %t1136 = getelementptr [4 x i8], ptr @.str130, i64 0, i64 0
  store ptr %t1136, ptr %t1124
  br label %L248
L248:
  br label %L245
L245:
  %t1137 = alloca ptr
  %t1138 = load i64, ptr %t1110
  %t1139 = call i32 @val_is_ptr(i64 %t1138)
  %t1140 = sext i32 %t1139 to i64
  %t1142 = icmp eq i64 %t1140, 0
  %t1141 = zext i1 %t1142 to i64
  %t1143 = load i64, ptr %t1110
  %t1144 = call i32 @val_is_64bit(i64 %t1143)
  %t1145 = sext i32 %t1144 to i64
  %t1147 = icmp eq i64 %t1145, 0
  %t1146 = zext i1 %t1147 to i64
  %t1149 = icmp ne i64 %t1141, 0
  %t1150 = icmp ne i64 %t1146, 0
  %t1151 = and i1 %t1149, %t1150
  %t1152 = zext i1 %t1151 to i64
  %t1153 = load ptr, ptr %t1110
  %t1154 = call i32 @type_is_fp(ptr %t1153)
  %t1155 = sext i32 %t1154 to i64
  %t1157 = icmp eq i64 %t1155, 0
  %t1156 = zext i1 %t1157 to i64
  %t1159 = icmp ne i64 %t1152, 0
  %t1160 = icmp ne i64 %t1156, 0
  %t1161 = and i1 %t1159, %t1160
  %t1162 = zext i1 %t1161 to i64
  %t1163 = icmp ne i64 %t1162, 0
  br i1 %t1163, label %L249, label %L250
L249:
  %t1164 = alloca i64
  %t1165 = call i32 @new_reg(ptr %t0)
  %t1166 = sext i32 %t1165 to i64
  store i64 %t1166, ptr %t1164
  %t1167 = load ptr, ptr %t0
  %t1168 = getelementptr [30 x i8], ptr @.str131, i64 0, i64 0
  %t1169 = load i64, ptr %t1164
  %t1170 = load ptr, ptr %t1110
  call void @__c0c_emit(ptr %t1167, ptr %t1168, i64 %t1169, ptr %t1170)
  %t1172 = load ptr, ptr %t1137
  %t1173 = getelementptr [6 x i8], ptr @.str132, i64 0, i64 0
  %t1174 = load i64, ptr %t1164
  %t1175 = call i32 @snprintf(ptr %t1172, i64 64, ptr %t1173, i64 %t1174)
  %t1176 = sext i32 %t1175 to i64
  br label %L251
L250:
  %t1177 = load ptr, ptr %t1137
  %t1178 = load ptr, ptr %t1110
  %t1179 = call ptr @strncpy(ptr %t1177, ptr %t1178, i64 63)
  %t1180 = load ptr, ptr %t1137
  %t1182 = sext i32 63 to i64
  %t1181 = getelementptr i8, ptr %t1180, i64 %t1182
  %t1183 = sext i32 0 to i64
  store i64 %t1183, ptr %t1181
  br label %L251
L251:
  %t1184 = load ptr, ptr %t0
  %t1185 = getelementptr [23 x i8], ptr @.str133, i64 0, i64 0
  %t1186 = load ptr, ptr %t1124
  %t1187 = load ptr, ptr %t1137
  %t1188 = load ptr, ptr %t1116
  call void @__c0c_emit(ptr %t1184, ptr %t1185, ptr %t1186, ptr %t1187, ptr %t1188)
  %t1190 = load ptr, ptr %t1116
  call void @free(ptr %t1190)
  br label %L242
L242:
  %t1192 = load i64, ptr %t1110
  ret i64 %t1192
L252:
  br label %L14
L14:
  %t1193 = alloca i64
  %t1194 = load ptr, ptr %t1
  %t1195 = sext i32 0 to i64
  %t1196 = getelementptr i32, ptr %t1194, i64 %t1195
  %t1197 = load i64, ptr %t1196
  %t1198 = call i64 @emit_expr(ptr %t0, i64 %t1197)
  store i64 %t1198, ptr %t1193
  %t1199 = alloca i64
  %t1200 = load ptr, ptr %t1
  %t1201 = sext i32 1 to i64
  %t1202 = getelementptr i32, ptr %t1200, i64 %t1201
  %t1203 = load i64, ptr %t1202
  %t1204 = call i64 @emit_expr(ptr %t0, i64 %t1203)
  store i64 %t1204, ptr %t1199
  %t1205 = alloca i64
  %t1206 = call i32 @new_reg(ptr %t0)
  %t1207 = sext i32 %t1206 to i64
  store i64 %t1207, ptr %t1205
  %t1208 = alloca i64
  %t1209 = load ptr, ptr %t1193
  %t1210 = call i32 @type_is_fp(ptr %t1209)
  %t1211 = sext i32 %t1210 to i64
  %t1212 = load ptr, ptr %t1199
  %t1213 = call i32 @type_is_fp(ptr %t1212)
  %t1214 = sext i32 %t1213 to i64
  %t1216 = icmp ne i64 %t1211, 0
  %t1217 = icmp ne i64 %t1214, 0
  %t1218 = or i1 %t1216, %t1217
  %t1219 = zext i1 %t1218 to i64
  store i64 %t1219, ptr %t1208
  %t1220 = alloca ptr
  %t1221 = load i64, ptr %t1208
  %t1222 = icmp ne i64 %t1221, 0
  br i1 %t1222, label %L253, label %L254
L253:
  %t1223 = getelementptr [7 x i8], ptr @.str134, i64 0, i64 0
  %t1224 = ptrtoint ptr %t1223 to i64
  br label %L255
L254:
  %t1225 = getelementptr [4 x i8], ptr @.str135, i64 0, i64 0
  %t1226 = ptrtoint ptr %t1225 to i64
  br label %L255
L255:
  %t1227 = phi i64 [ %t1224, %L253 ], [ %t1226, %L254 ]
  store i64 %t1227, ptr %t1220
  %t1228 = alloca ptr
  %t1229 = alloca ptr
  %t1230 = load i64, ptr %t1208
  %t1232 = icmp eq i64 %t1230, 0
  %t1231 = zext i1 %t1232 to i64
  %t1233 = icmp ne i64 %t1231, 0
  br i1 %t1233, label %L256, label %L257
L256:
  %t1234 = load i64, ptr %t1193
  %t1235 = load ptr, ptr %t1228
  %t1236 = call i32 @promote_to_i64(ptr %t0, i64 %t1234, ptr %t1235, i64 64)
  %t1237 = sext i32 %t1236 to i64
  %t1238 = load i64, ptr %t1199
  %t1239 = load ptr, ptr %t1229
  %t1240 = call i32 @promote_to_i64(ptr %t0, i64 %t1238, ptr %t1239, i64 64)
  %t1241 = sext i32 %t1240 to i64
  br label %L258
L257:
  %t1242 = load ptr, ptr %t1228
  %t1243 = load ptr, ptr %t1193
  %t1244 = call ptr @strncpy(ptr %t1242, ptr %t1243, i64 63)
  %t1245 = load ptr, ptr %t1228
  %t1247 = sext i32 63 to i64
  %t1246 = getelementptr i8, ptr %t1245, i64 %t1247
  %t1248 = sext i32 0 to i64
  store i64 %t1248, ptr %t1246
  %t1249 = load ptr, ptr %t1229
  %t1250 = load ptr, ptr %t1199
  %t1251 = call ptr @strncpy(ptr %t1249, ptr %t1250, i64 63)
  %t1252 = load ptr, ptr %t1229
  %t1254 = sext i32 63 to i64
  %t1253 = getelementptr i8, ptr %t1252, i64 %t1254
  %t1255 = sext i32 0 to i64
  store i64 %t1255, ptr %t1253
  br label %L258
L258:
  %t1256 = alloca ptr
  %t1257 = load ptr, ptr %t1
  %t1258 = ptrtoint ptr %t1257 to i64
  %t1259 = add i64 %t1258, 0
  switch i64 %t1259, label %L270 [
    i64 56, label %L260
    i64 57, label %L261
    i64 58, label %L262
    i64 59, label %L263
    i64 65, label %L264
    i64 60, label %L265
    i64 61, label %L266
    i64 62, label %L267
    i64 63, label %L268
    i64 64, label %L269
  ]
L260:
  %t1260 = load i64, ptr %t1208
  %t1261 = icmp ne i64 %t1260, 0
  br i1 %t1261, label %L271, label %L272
L271:
  %t1262 = getelementptr [5 x i8], ptr @.str136, i64 0, i64 0
  %t1263 = ptrtoint ptr %t1262 to i64
  br label %L273
L272:
  %t1264 = getelementptr [4 x i8], ptr @.str137, i64 0, i64 0
  %t1265 = ptrtoint ptr %t1264 to i64
  br label %L273
L273:
  %t1266 = phi i64 [ %t1263, %L271 ], [ %t1265, %L272 ]
  store i64 %t1266, ptr %t1256
  br label %L259
L274:
  br label %L261
L261:
  %t1267 = load i64, ptr %t1208
  %t1268 = icmp ne i64 %t1267, 0
  br i1 %t1268, label %L275, label %L276
L275:
  %t1269 = getelementptr [5 x i8], ptr @.str138, i64 0, i64 0
  %t1270 = ptrtoint ptr %t1269 to i64
  br label %L277
L276:
  %t1271 = getelementptr [4 x i8], ptr @.str139, i64 0, i64 0
  %t1272 = ptrtoint ptr %t1271 to i64
  br label %L277
L277:
  %t1273 = phi i64 [ %t1270, %L275 ], [ %t1272, %L276 ]
  store i64 %t1273, ptr %t1256
  br label %L259
L278:
  br label %L262
L262:
  %t1274 = load i64, ptr %t1208
  %t1275 = icmp ne i64 %t1274, 0
  br i1 %t1275, label %L279, label %L280
L279:
  %t1276 = getelementptr [5 x i8], ptr @.str140, i64 0, i64 0
  %t1277 = ptrtoint ptr %t1276 to i64
  br label %L281
L280:
  %t1278 = getelementptr [4 x i8], ptr @.str141, i64 0, i64 0
  %t1279 = ptrtoint ptr %t1278 to i64
  br label %L281
L281:
  %t1280 = phi i64 [ %t1277, %L279 ], [ %t1279, %L280 ]
  store i64 %t1280, ptr %t1256
  br label %L259
L282:
  br label %L263
L263:
  %t1281 = load i64, ptr %t1208
  %t1282 = icmp ne i64 %t1281, 0
  br i1 %t1282, label %L283, label %L284
L283:
  %t1283 = getelementptr [5 x i8], ptr @.str142, i64 0, i64 0
  %t1284 = ptrtoint ptr %t1283 to i64
  br label %L285
L284:
  %t1285 = getelementptr [5 x i8], ptr @.str143, i64 0, i64 0
  %t1286 = ptrtoint ptr %t1285 to i64
  br label %L285
L285:
  %t1287 = phi i64 [ %t1284, %L283 ], [ %t1286, %L284 ]
  store i64 %t1287, ptr %t1256
  br label %L259
L286:
  br label %L264
L264:
  %t1288 = getelementptr [5 x i8], ptr @.str144, i64 0, i64 0
  store ptr %t1288, ptr %t1256
  br label %L259
L287:
  br label %L265
L265:
  %t1289 = getelementptr [4 x i8], ptr @.str145, i64 0, i64 0
  store ptr %t1289, ptr %t1256
  br label %L259
L288:
  br label %L266
L266:
  %t1290 = getelementptr [3 x i8], ptr @.str146, i64 0, i64 0
  store ptr %t1290, ptr %t1256
  br label %L259
L289:
  br label %L267
L267:
  %t1291 = getelementptr [4 x i8], ptr @.str147, i64 0, i64 0
  store ptr %t1291, ptr %t1256
  br label %L259
L290:
  br label %L268
L268:
  %t1292 = getelementptr [4 x i8], ptr @.str148, i64 0, i64 0
  store ptr %t1292, ptr %t1256
  br label %L259
L291:
  br label %L269
L269:
  %t1293 = getelementptr [5 x i8], ptr @.str149, i64 0, i64 0
  store ptr %t1293, ptr %t1256
  br label %L259
L292:
  br label %L259
L270:
  %t1294 = getelementptr [4 x i8], ptr @.str150, i64 0, i64 0
  store ptr %t1294, ptr %t1256
  br label %L259
L259:
  %t1295 = load ptr, ptr %t0
  %t1296 = getelementptr [24 x i8], ptr @.str151, i64 0, i64 0
  %t1297 = load i64, ptr %t1205
  %t1298 = load ptr, ptr %t1256
  %t1299 = load ptr, ptr %t1220
  %t1300 = load ptr, ptr %t1228
  %t1301 = load ptr, ptr %t1229
  call void @__c0c_emit(ptr %t1295, ptr %t1296, i64 %t1297, ptr %t1298, ptr %t1299, ptr %t1300, ptr %t1301)
  %t1303 = alloca ptr
  %t1304 = load ptr, ptr %t1
  %t1305 = sext i32 0 to i64
  %t1306 = getelementptr i32, ptr %t1304, i64 %t1305
  %t1307 = load i64, ptr %t1306
  %t1308 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1307)
  store ptr %t1308, ptr %t1303
  %t1309 = load ptr, ptr %t1303
  %t1310 = icmp ne ptr %t1309, null
  br i1 %t1310, label %L293, label %L295
L293:
  %t1311 = load ptr, ptr %t0
  %t1312 = getelementptr [26 x i8], ptr @.str152, i64 0, i64 0
  %t1313 = load ptr, ptr %t1220
  %t1314 = load i64, ptr %t1205
  %t1315 = load ptr, ptr %t1303
  call void @__c0c_emit(ptr %t1311, ptr %t1312, ptr %t1313, i64 %t1314, ptr %t1315)
  %t1317 = load ptr, ptr %t1303
  call void @free(ptr %t1317)
  br label %L295
L295:
  %t1319 = alloca ptr
  %t1320 = load ptr, ptr %t1319
  %t1321 = getelementptr [6 x i8], ptr @.str153, i64 0, i64 0
  %t1322 = load i64, ptr %t1205
  %t1323 = call i32 @snprintf(ptr %t1320, i64 8, ptr %t1321, i64 %t1322)
  %t1324 = sext i32 %t1323 to i64
  %t1325 = load ptr, ptr %t1319
  %t1326 = load i64, ptr %t1208
  %t1327 = icmp ne i64 %t1326, 0
  br i1 %t1327, label %L296, label %L297
L296:
  %t1328 = load ptr, ptr %t1193
  %t1329 = ptrtoint ptr %t1328 to i64
  br label %L298
L297:
  %t1330 = call ptr @default_i64_type()
  %t1331 = ptrtoint ptr %t1330 to i64
  br label %L298
L298:
  %t1332 = phi i64 [ %t1329, %L296 ], [ %t1331, %L297 ]
  %t1333 = call i64 @make_val(ptr %t1325, i64 %t1332)
  ret i64 %t1333
L299:
  br label %L15
L15:
  br label %L16
L16:
  %t1334 = alloca i64
  %t1335 = load ptr, ptr %t1
  %t1336 = sext i32 0 to i64
  %t1337 = getelementptr i32, ptr %t1335, i64 %t1336
  %t1338 = load i64, ptr %t1337
  %t1339 = call i64 @emit_expr(ptr %t0, i64 %t1338)
  store i64 %t1339, ptr %t1334
  %t1340 = alloca i64
  %t1341 = call i32 @new_reg(ptr %t0)
  %t1342 = sext i32 %t1341 to i64
  store i64 %t1342, ptr %t1340
  %t1343 = alloca ptr
  %t1344 = load ptr, ptr %t1
  %t1346 = ptrtoint ptr %t1344 to i64
  %t1347 = sext i32 38 to i64
  %t1345 = icmp eq i64 %t1346, %t1347
  %t1348 = zext i1 %t1345 to i64
  %t1349 = icmp ne i64 %t1348, 0
  br i1 %t1349, label %L300, label %L301
L300:
  %t1350 = getelementptr [4 x i8], ptr @.str154, i64 0, i64 0
  %t1351 = ptrtoint ptr %t1350 to i64
  br label %L302
L301:
  %t1352 = getelementptr [4 x i8], ptr @.str155, i64 0, i64 0
  %t1353 = ptrtoint ptr %t1352 to i64
  br label %L302
L302:
  %t1354 = phi i64 [ %t1351, %L300 ], [ %t1353, %L301 ]
  store i64 %t1354, ptr %t1343
  %t1355 = alloca ptr
  %t1356 = load i64, ptr %t1334
  %t1357 = load ptr, ptr %t1355
  %t1358 = call i32 @promote_to_i64(ptr %t0, i64 %t1356, ptr %t1357, i64 64)
  %t1359 = sext i32 %t1358 to i64
  %t1360 = load ptr, ptr %t0
  %t1361 = getelementptr [24 x i8], ptr @.str156, i64 0, i64 0
  %t1362 = load i64, ptr %t1340
  %t1363 = load ptr, ptr %t1343
  %t1364 = load ptr, ptr %t1355
  call void @__c0c_emit(ptr %t1360, ptr %t1361, i64 %t1362, ptr %t1363, ptr %t1364)
  %t1366 = alloca ptr
  %t1367 = load ptr, ptr %t1
  %t1368 = sext i32 0 to i64
  %t1369 = getelementptr i32, ptr %t1367, i64 %t1368
  %t1370 = load i64, ptr %t1369
  %t1371 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1370)
  store ptr %t1371, ptr %t1366
  %t1372 = load ptr, ptr %t1366
  %t1373 = icmp ne ptr %t1372, null
  br i1 %t1373, label %L303, label %L305
L303:
  %t1374 = load ptr, ptr %t0
  %t1375 = getelementptr [27 x i8], ptr @.str157, i64 0, i64 0
  %t1376 = load i64, ptr %t1340
  %t1377 = load ptr, ptr %t1366
  call void @__c0c_emit(ptr %t1374, ptr %t1375, i64 %t1376, ptr %t1377)
  %t1379 = load ptr, ptr %t1366
  call void @free(ptr %t1379)
  br label %L305
L305:
  %t1381 = alloca ptr
  %t1382 = load ptr, ptr %t1381
  %t1383 = getelementptr [6 x i8], ptr @.str158, i64 0, i64 0
  %t1384 = load i64, ptr %t1340
  %t1385 = call i32 @snprintf(ptr %t1382, i64 8, ptr %t1383, i64 %t1384)
  %t1386 = sext i32 %t1385 to i64
  %t1387 = load ptr, ptr %t1381
  %t1388 = call ptr @default_i64_type()
  %t1389 = call i64 @make_val(ptr %t1387, ptr %t1388)
  ret i64 %t1389
L306:
  br label %L17
L17:
  br label %L18
L18:
  %t1390 = alloca i64
  %t1391 = load ptr, ptr %t1
  %t1392 = sext i32 0 to i64
  %t1393 = getelementptr i32, ptr %t1391, i64 %t1392
  %t1394 = load i64, ptr %t1393
  %t1395 = call i64 @emit_expr(ptr %t0, i64 %t1394)
  store i64 %t1395, ptr %t1390
  %t1396 = alloca i64
  %t1397 = call i32 @new_reg(ptr %t0)
  %t1398 = sext i32 %t1397 to i64
  store i64 %t1398, ptr %t1396
  %t1399 = alloca ptr
  %t1400 = load ptr, ptr %t1
  %t1402 = ptrtoint ptr %t1400 to i64
  %t1403 = sext i32 40 to i64
  %t1401 = icmp eq i64 %t1402, %t1403
  %t1404 = zext i1 %t1401 to i64
  %t1405 = icmp ne i64 %t1404, 0
  br i1 %t1405, label %L307, label %L308
L307:
  %t1406 = getelementptr [4 x i8], ptr @.str159, i64 0, i64 0
  %t1407 = ptrtoint ptr %t1406 to i64
  br label %L309
L308:
  %t1408 = getelementptr [4 x i8], ptr @.str160, i64 0, i64 0
  %t1409 = ptrtoint ptr %t1408 to i64
  br label %L309
L309:
  %t1410 = phi i64 [ %t1407, %L307 ], [ %t1409, %L308 ]
  store i64 %t1410, ptr %t1399
  %t1411 = alloca ptr
  %t1412 = load i64, ptr %t1390
  %t1413 = load ptr, ptr %t1411
  %t1414 = call i32 @promote_to_i64(ptr %t0, i64 %t1412, ptr %t1413, i64 64)
  %t1415 = sext i32 %t1414 to i64
  %t1416 = load ptr, ptr %t0
  %t1417 = getelementptr [24 x i8], ptr @.str161, i64 0, i64 0
  %t1418 = load i64, ptr %t1396
  %t1419 = load ptr, ptr %t1399
  %t1420 = load ptr, ptr %t1411
  call void @__c0c_emit(ptr %t1416, ptr %t1417, i64 %t1418, ptr %t1419, ptr %t1420)
  %t1422 = alloca ptr
  %t1423 = load ptr, ptr %t1
  %t1424 = sext i32 0 to i64
  %t1425 = getelementptr i32, ptr %t1423, i64 %t1424
  %t1426 = load i64, ptr %t1425
  %t1427 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1426)
  store ptr %t1427, ptr %t1422
  %t1428 = load ptr, ptr %t1422
  %t1429 = icmp ne ptr %t1428, null
  br i1 %t1429, label %L310, label %L312
L310:
  %t1430 = load ptr, ptr %t0
  %t1431 = getelementptr [27 x i8], ptr @.str162, i64 0, i64 0
  %t1432 = load i64, ptr %t1396
  %t1433 = load ptr, ptr %t1422
  call void @__c0c_emit(ptr %t1430, ptr %t1431, i64 %t1432, ptr %t1433)
  %t1435 = load ptr, ptr %t1422
  call void @free(ptr %t1435)
  br label %L312
L312:
  %t1437 = load i64, ptr %t1390
  ret i64 %t1437
L313:
  br label %L19
L19:
  %t1438 = alloca ptr
  %t1439 = load ptr, ptr %t1
  %t1440 = sext i32 0 to i64
  %t1441 = getelementptr i32, ptr %t1439, i64 %t1440
  %t1442 = load i64, ptr %t1441
  %t1443 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t1442)
  store ptr %t1443, ptr %t1438
  %t1444 = load ptr, ptr %t1438
  %t1446 = ptrtoint ptr %t1444 to i64
  %t1447 = icmp eq i64 %t1446, 0
  %t1445 = zext i1 %t1447 to i64
  %t1448 = icmp ne i64 %t1445, 0
  br i1 %t1448, label %L314, label %L316
L314:
  %t1449 = getelementptr [5 x i8], ptr @.str163, i64 0, i64 0
  %t1450 = call ptr @default_ptr_type()
  %t1451 = call i64 @make_val(ptr %t1449, ptr %t1450)
  ret i64 %t1451
L317:
  br label %L316
L316:
  %t1452 = alloca i64
  %t1453 = load ptr, ptr %t1438
  %t1454 = call ptr @default_ptr_type()
  %t1455 = call i64 @make_val(ptr %t1453, ptr %t1454)
  store i64 %t1455, ptr %t1452
  %t1456 = load ptr, ptr %t1438
  call void @free(ptr %t1456)
  %t1458 = load i64, ptr %t1452
  ret i64 %t1458
L318:
  br label %L20
L20:
  %t1459 = alloca i64
  %t1460 = load ptr, ptr %t1
  %t1461 = sext i32 0 to i64
  %t1462 = getelementptr i32, ptr %t1460, i64 %t1461
  %t1463 = load i64, ptr %t1462
  %t1464 = call i64 @emit_expr(ptr %t0, i64 %t1463)
  store i64 %t1464, ptr %t1459
  %t1465 = alloca i64
  %t1466 = call i32 @new_reg(ptr %t0)
  %t1467 = sext i32 %t1466 to i64
  store i64 %t1467, ptr %t1465
  %t1468 = alloca ptr
  %t1469 = load i64, ptr %t1459
  %t1470 = call i32 @val_is_ptr(i64 %t1469)
  %t1471 = sext i32 %t1470 to i64
  %t1472 = icmp ne i64 %t1471, 0
  br i1 %t1472, label %L319, label %L320
L319:
  %t1473 = load ptr, ptr %t1468
  %t1474 = load ptr, ptr %t1459
  %t1475 = call ptr @strncpy(ptr %t1473, ptr %t1474, i64 63)
  %t1476 = load ptr, ptr %t1468
  %t1478 = sext i32 63 to i64
  %t1477 = getelementptr i8, ptr %t1476, i64 %t1478
  %t1479 = sext i32 0 to i64
  store i64 %t1479, ptr %t1477
  br label %L321
L320:
  %t1480 = alloca i64
  %t1481 = call i32 @new_reg(ptr %t0)
  %t1482 = sext i32 %t1481 to i64
  store i64 %t1482, ptr %t1480
  %t1483 = load ptr, ptr %t0
  %t1484 = getelementptr [34 x i8], ptr @.str164, i64 0, i64 0
  %t1485 = load i64, ptr %t1480
  %t1486 = load ptr, ptr %t1459
  call void @__c0c_emit(ptr %t1483, ptr %t1484, i64 %t1485, ptr %t1486)
  %t1488 = load ptr, ptr %t1468
  %t1489 = getelementptr [6 x i8], ptr @.str165, i64 0, i64 0
  %t1490 = load i64, ptr %t1480
  %t1491 = call i32 @snprintf(ptr %t1488, i64 64, ptr %t1489, i64 %t1490)
  %t1492 = sext i32 %t1491 to i64
  br label %L321
L321:
  %t1493 = alloca ptr
  %t1494 = load ptr, ptr %t1459
  %t1495 = load ptr, ptr %t1459
  %t1496 = load ptr, ptr %t1495
  %t1498 = ptrtoint ptr %t1494 to i64
  %t1499 = ptrtoint ptr %t1496 to i64
  %t1503 = ptrtoint ptr %t1494 to i64
  %t1504 = ptrtoint ptr %t1496 to i64
  %t1500 = icmp ne i64 %t1503, 0
  %t1501 = icmp ne i64 %t1504, 0
  %t1502 = and i1 %t1500, %t1501
  %t1505 = zext i1 %t1502 to i64
  %t1506 = icmp ne i64 %t1505, 0
  br i1 %t1506, label %L322, label %L323
L322:
  %t1507 = load ptr, ptr %t1459
  %t1508 = load ptr, ptr %t1507
  %t1509 = ptrtoint ptr %t1508 to i64
  br label %L324
L323:
  %t1510 = call ptr @default_int_type()
  %t1511 = ptrtoint ptr %t1510 to i64
  br label %L324
L324:
  %t1512 = phi i64 [ %t1509, %L322 ], [ %t1511, %L323 ]
  store i64 %t1512, ptr %t1493
  %t1513 = alloca i64
  %t1514 = load ptr, ptr %t1493
  %t1515 = load ptr, ptr %t1514
  %t1517 = ptrtoint ptr %t1515 to i64
  %t1518 = sext i32 15 to i64
  %t1516 = icmp eq i64 %t1517, %t1518
  %t1519 = zext i1 %t1516 to i64
  %t1520 = load ptr, ptr %t1493
  %t1521 = load ptr, ptr %t1520
  %t1523 = ptrtoint ptr %t1521 to i64
  %t1524 = sext i32 16 to i64
  %t1522 = icmp eq i64 %t1523, %t1524
  %t1525 = zext i1 %t1522 to i64
  %t1527 = icmp ne i64 %t1519, 0
  %t1528 = icmp ne i64 %t1525, 0
  %t1529 = or i1 %t1527, %t1528
  %t1530 = zext i1 %t1529 to i64
  store i64 %t1530, ptr %t1513
  %t1531 = alloca ptr
  %t1532 = load i64, ptr %t1513
  %t1533 = icmp ne i64 %t1532, 0
  br i1 %t1533, label %L325, label %L326
L325:
  %t1534 = getelementptr [4 x i8], ptr @.str166, i64 0, i64 0
  %t1535 = ptrtoint ptr %t1534 to i64
  br label %L327
L326:
  %t1536 = getelementptr [4 x i8], ptr @.str167, i64 0, i64 0
  %t1537 = ptrtoint ptr %t1536 to i64
  br label %L327
L327:
  %t1538 = phi i64 [ %t1535, %L325 ], [ %t1537, %L326 ]
  store i64 %t1538, ptr %t1531
  %t1539 = alloca ptr
  %t1540 = load i64, ptr %t1513
  %t1541 = icmp ne i64 %t1540, 0
  br i1 %t1541, label %L328, label %L329
L328:
  %t1542 = call ptr @default_ptr_type()
  %t1543 = ptrtoint ptr %t1542 to i64
  br label %L330
L329:
  %t1544 = call ptr @default_i64_type()
  %t1545 = ptrtoint ptr %t1544 to i64
  br label %L330
L330:
  %t1546 = phi i64 [ %t1543, %L328 ], [ %t1545, %L329 ]
  store i64 %t1546, ptr %t1539
  %t1547 = load ptr, ptr %t0
  %t1548 = getelementptr [27 x i8], ptr @.str168, i64 0, i64 0
  %t1549 = load i64, ptr %t1465
  %t1550 = load ptr, ptr %t1531
  %t1551 = load ptr, ptr %t1468
  call void @__c0c_emit(ptr %t1547, ptr %t1548, i64 %t1549, ptr %t1550, ptr %t1551)
  %t1553 = alloca ptr
  %t1554 = load ptr, ptr %t1553
  %t1555 = getelementptr [6 x i8], ptr @.str169, i64 0, i64 0
  %t1556 = load i64, ptr %t1465
  %t1557 = call i32 @snprintf(ptr %t1554, i64 8, ptr %t1555, i64 %t1556)
  %t1558 = sext i32 %t1557 to i64
  %t1559 = load ptr, ptr %t1553
  %t1560 = load ptr, ptr %t1539
  %t1561 = call i64 @make_val(ptr %t1559, ptr %t1560)
  ret i64 %t1561
L331:
  br label %L21
L21:
  %t1562 = alloca i64
  %t1563 = load ptr, ptr %t1
  %t1564 = sext i32 0 to i64
  %t1565 = getelementptr i32, ptr %t1563, i64 %t1564
  %t1566 = load i64, ptr %t1565
  %t1567 = call i64 @emit_expr(ptr %t0, i64 %t1566)
  store i64 %t1567, ptr %t1562
  %t1568 = alloca i64
  %t1569 = load ptr, ptr %t1
  %t1570 = sext i32 1 to i64
  %t1571 = getelementptr i32, ptr %t1569, i64 %t1570
  %t1572 = load i64, ptr %t1571
  %t1573 = call i64 @emit_expr(ptr %t0, i64 %t1572)
  store i64 %t1573, ptr %t1568
  %t1574 = alloca ptr
  %t1575 = load ptr, ptr %t1562
  %t1576 = load ptr, ptr %t1562
  %t1577 = load ptr, ptr %t1576
  %t1579 = ptrtoint ptr %t1575 to i64
  %t1580 = ptrtoint ptr %t1577 to i64
  %t1584 = ptrtoint ptr %t1575 to i64
  %t1585 = ptrtoint ptr %t1577 to i64
  %t1581 = icmp ne i64 %t1584, 0
  %t1582 = icmp ne i64 %t1585, 0
  %t1583 = and i1 %t1581, %t1582
  %t1586 = zext i1 %t1583 to i64
  %t1587 = icmp ne i64 %t1586, 0
  br i1 %t1587, label %L332, label %L333
L332:
  %t1588 = load ptr, ptr %t1562
  %t1589 = load ptr, ptr %t1588
  %t1590 = ptrtoint ptr %t1589 to i64
  br label %L334
L333:
  %t1591 = call ptr @default_int_type()
  %t1592 = ptrtoint ptr %t1591 to i64
  br label %L334
L334:
  %t1593 = phi i64 [ %t1590, %L332 ], [ %t1592, %L333 ]
  store i64 %t1593, ptr %t1574
  %t1594 = alloca ptr
  %t1595 = alloca ptr
  %t1596 = load i64, ptr %t1562
  %t1597 = call i32 @val_is_ptr(i64 %t1596)
  %t1598 = sext i32 %t1597 to i64
  %t1599 = icmp ne i64 %t1598, 0
  br i1 %t1599, label %L335, label %L336
L335:
  %t1600 = load ptr, ptr %t1594
  %t1601 = load ptr, ptr %t1562
  %t1602 = call ptr @strncpy(ptr %t1600, ptr %t1601, i64 63)
  br label %L337
L336:
  %t1603 = alloca i64
  %t1604 = call i32 @new_reg(ptr %t0)
  %t1605 = sext i32 %t1604 to i64
  store i64 %t1605, ptr %t1603
  %t1606 = load ptr, ptr %t0
  %t1607 = getelementptr [34 x i8], ptr @.str170, i64 0, i64 0
  %t1608 = load i64, ptr %t1603
  %t1609 = load ptr, ptr %t1562
  call void @__c0c_emit(ptr %t1606, ptr %t1607, i64 %t1608, ptr %t1609)
  %t1611 = load ptr, ptr %t1594
  %t1612 = getelementptr [6 x i8], ptr @.str171, i64 0, i64 0
  %t1613 = load i64, ptr %t1603
  %t1614 = call i32 @snprintf(ptr %t1611, i64 64, ptr %t1612, i64 %t1613)
  %t1615 = sext i32 %t1614 to i64
  br label %L337
L337:
  %t1616 = load i64, ptr %t1568
  %t1617 = load ptr, ptr %t1595
  %t1618 = call i32 @promote_to_i64(ptr %t0, i64 %t1616, ptr %t1617, i64 64)
  %t1619 = sext i32 %t1618 to i64
  %t1620 = load ptr, ptr %t1594
  %t1622 = sext i32 63 to i64
  %t1621 = getelementptr i8, ptr %t1620, i64 %t1622
  %t1623 = sext i32 0 to i64
  store i64 %t1623, ptr %t1621
  %t1624 = alloca i64
  %t1625 = call i32 @new_reg(ptr %t0)
  %t1626 = sext i32 %t1625 to i64
  store i64 %t1626, ptr %t1624
  %t1627 = load ptr, ptr %t0
  %t1628 = getelementptr [44 x i8], ptr @.str172, i64 0, i64 0
  %t1629 = load i64, ptr %t1624
  %t1630 = load ptr, ptr %t1574
  %t1631 = call ptr @llvm_type(ptr %t1630)
  %t1632 = load ptr, ptr %t1594
  %t1633 = load ptr, ptr %t1595
  call void @__c0c_emit(ptr %t1627, ptr %t1628, i64 %t1629, ptr %t1631, ptr %t1632, ptr %t1633)
  %t1635 = alloca i64
  %t1636 = call i32 @new_reg(ptr %t0)
  %t1637 = sext i32 %t1636 to i64
  store i64 %t1637, ptr %t1635
  %t1638 = alloca i64
  %t1639 = load ptr, ptr %t1574
  %t1640 = load ptr, ptr %t1574
  %t1641 = load ptr, ptr %t1640
  %t1643 = ptrtoint ptr %t1641 to i64
  %t1644 = sext i32 15 to i64
  %t1642 = icmp eq i64 %t1643, %t1644
  %t1645 = zext i1 %t1642 to i64
  %t1646 = load ptr, ptr %t1574
  %t1647 = load ptr, ptr %t1646
  %t1649 = ptrtoint ptr %t1647 to i64
  %t1650 = sext i32 16 to i64
  %t1648 = icmp eq i64 %t1649, %t1650
  %t1651 = zext i1 %t1648 to i64
  %t1653 = icmp ne i64 %t1645, 0
  %t1654 = icmp ne i64 %t1651, 0
  %t1655 = or i1 %t1653, %t1654
  %t1656 = zext i1 %t1655 to i64
  %t1658 = ptrtoint ptr %t1639 to i64
  %t1662 = ptrtoint ptr %t1639 to i64
  %t1659 = icmp ne i64 %t1662, 0
  %t1660 = icmp ne i64 %t1656, 0
  %t1661 = and i1 %t1659, %t1660
  %t1663 = zext i1 %t1661 to i64
  store i64 %t1663, ptr %t1638
  %t1664 = alloca i64
  %t1665 = load ptr, ptr %t1574
  %t1666 = load ptr, ptr %t1574
  %t1667 = call i32 @type_is_fp(ptr %t1666)
  %t1668 = sext i32 %t1667 to i64
  %t1670 = ptrtoint ptr %t1665 to i64
  %t1674 = ptrtoint ptr %t1665 to i64
  %t1671 = icmp ne i64 %t1674, 0
  %t1672 = icmp ne i64 %t1668, 0
  %t1673 = and i1 %t1671, %t1672
  %t1675 = zext i1 %t1673 to i64
  store i64 %t1675, ptr %t1664
  %t1676 = alloca ptr
  %t1677 = alloca ptr
  %t1678 = load i64, ptr %t1638
  %t1679 = icmp ne i64 %t1678, 0
  br i1 %t1679, label %L338, label %L339
L338:
  %t1680 = getelementptr [4 x i8], ptr @.str173, i64 0, i64 0
  store ptr %t1680, ptr %t1676
  %t1681 = call ptr @default_ptr_type()
  store ptr %t1681, ptr %t1677
  br label %L340
L339:
  %t1682 = load i64, ptr %t1664
  %t1683 = icmp ne i64 %t1682, 0
  br i1 %t1683, label %L341, label %L342
L341:
  %t1684 = load ptr, ptr %t1574
  %t1685 = call ptr @llvm_type(ptr %t1684)
  store ptr %t1685, ptr %t1676
  %t1686 = load ptr, ptr %t1574
  store ptr %t1686, ptr %t1677
  br label %L343
L342:
  %t1687 = getelementptr [4 x i8], ptr @.str174, i64 0, i64 0
  store ptr %t1687, ptr %t1676
  %t1688 = call ptr @default_i64_type()
  store ptr %t1688, ptr %t1677
  br label %L343
L343:
  br label %L340
L340:
  %t1689 = load ptr, ptr %t0
  %t1690 = getelementptr [30 x i8], ptr @.str175, i64 0, i64 0
  %t1691 = load i64, ptr %t1635
  %t1692 = load ptr, ptr %t1676
  %t1693 = load i64, ptr %t1624
  call void @__c0c_emit(ptr %t1689, ptr %t1690, i64 %t1691, ptr %t1692, i64 %t1693)
  %t1695 = alloca ptr
  %t1696 = load ptr, ptr %t1695
  %t1697 = getelementptr [6 x i8], ptr @.str176, i64 0, i64 0
  %t1698 = load i64, ptr %t1635
  %t1699 = call i32 @snprintf(ptr %t1696, i64 8, ptr %t1697, i64 %t1698)
  %t1700 = sext i32 %t1699 to i64
  %t1701 = load ptr, ptr %t1695
  %t1702 = load ptr, ptr %t1677
  %t1703 = call i64 @make_val(ptr %t1701, ptr %t1702)
  ret i64 %t1703
L344:
  br label %L22
L22:
  %t1704 = alloca i64
  %t1705 = load ptr, ptr %t1
  %t1706 = call i64 @emit_expr(ptr %t0, ptr %t1705)
  store i64 %t1706, ptr %t1704
  %t1707 = alloca ptr
  %t1708 = load ptr, ptr %t1
  store ptr %t1708, ptr %t1707
  %t1709 = load ptr, ptr %t1707
  %t1711 = ptrtoint ptr %t1709 to i64
  %t1712 = icmp eq i64 %t1711, 0
  %t1710 = zext i1 %t1712 to i64
  %t1713 = icmp ne i64 %t1710, 0
  br i1 %t1713, label %L345, label %L347
L345:
  %t1714 = load i64, ptr %t1704
  ret i64 %t1714
L348:
  br label %L347
L347:
  %t1715 = alloca i64
  %t1716 = call i32 @new_reg(ptr %t0)
  %t1717 = sext i32 %t1716 to i64
  store i64 %t1717, ptr %t1715
  %t1718 = alloca i64
  %t1719 = load ptr, ptr %t1704
  %t1720 = call i32 @type_is_fp(ptr %t1719)
  %t1721 = sext i32 %t1720 to i64
  store i64 %t1721, ptr %t1718
  %t1722 = alloca i64
  %t1723 = load ptr, ptr %t1707
  %t1724 = call i32 @type_is_fp(ptr %t1723)
  %t1725 = sext i32 %t1724 to i64
  store i64 %t1725, ptr %t1722
  %t1726 = alloca i64
  %t1727 = load ptr, ptr %t1707
  %t1728 = load ptr, ptr %t1727
  %t1730 = ptrtoint ptr %t1728 to i64
  %t1731 = sext i32 15 to i64
  %t1729 = icmp eq i64 %t1730, %t1731
  %t1732 = zext i1 %t1729 to i64
  %t1733 = load ptr, ptr %t1707
  %t1734 = load ptr, ptr %t1733
  %t1736 = ptrtoint ptr %t1734 to i64
  %t1737 = sext i32 16 to i64
  %t1735 = icmp eq i64 %t1736, %t1737
  %t1738 = zext i1 %t1735 to i64
  %t1740 = icmp ne i64 %t1732, 0
  %t1741 = icmp ne i64 %t1738, 0
  %t1742 = or i1 %t1740, %t1741
  %t1743 = zext i1 %t1742 to i64
  store i64 %t1743, ptr %t1726
  %t1744 = alloca i64
  %t1745 = load i64, ptr %t1704
  %t1746 = call i32 @val_is_ptr(i64 %t1745)
  %t1747 = sext i32 %t1746 to i64
  store i64 %t1747, ptr %t1744
  %t1748 = load i64, ptr %t1718
  %t1749 = load i64, ptr %t1722
  %t1751 = icmp ne i64 %t1748, 0
  %t1752 = icmp ne i64 %t1749, 0
  %t1753 = and i1 %t1751, %t1752
  %t1754 = zext i1 %t1753 to i64
  %t1755 = icmp ne i64 %t1754, 0
  br i1 %t1755, label %L349, label %L350
L349:
  %t1756 = alloca i64
  %t1757 = load ptr, ptr %t1704
  %t1758 = call i32 @type_size(ptr %t1757)
  %t1759 = sext i32 %t1758 to i64
  store i64 %t1759, ptr %t1756
  %t1760 = alloca i64
  %t1761 = load ptr, ptr %t1707
  %t1762 = call i32 @type_size(ptr %t1761)
  %t1763 = sext i32 %t1762 to i64
  store i64 %t1763, ptr %t1760
  %t1764 = load i64, ptr %t1760
  %t1765 = load i64, ptr %t1756
  %t1766 = icmp sgt i64 %t1764, %t1765
  %t1767 = zext i1 %t1766 to i64
  %t1768 = icmp ne i64 %t1767, 0
  br i1 %t1768, label %L352, label %L353
L352:
  %t1769 = load ptr, ptr %t0
  %t1770 = getelementptr [36 x i8], ptr @.str177, i64 0, i64 0
  %t1771 = load i64, ptr %t1715
  %t1772 = load ptr, ptr %t1704
  call void @__c0c_emit(ptr %t1769, ptr %t1770, i64 %t1771, ptr %t1772)
  br label %L354
L353:
  %t1774 = load ptr, ptr %t0
  %t1775 = getelementptr [38 x i8], ptr @.str178, i64 0, i64 0
  %t1776 = load i64, ptr %t1715
  %t1777 = load ptr, ptr %t1704
  call void @__c0c_emit(ptr %t1774, ptr %t1775, i64 %t1776, ptr %t1777)
  br label %L354
L354:
  br label %L351
L350:
  %t1779 = load i64, ptr %t1718
  %t1780 = load i64, ptr %t1722
  %t1782 = icmp eq i64 %t1780, 0
  %t1781 = zext i1 %t1782 to i64
  %t1784 = icmp ne i64 %t1779, 0
  %t1785 = icmp ne i64 %t1781, 0
  %t1786 = and i1 %t1784, %t1785
  %t1787 = zext i1 %t1786 to i64
  %t1788 = icmp ne i64 %t1787, 0
  br i1 %t1788, label %L355, label %L356
L355:
  %t1789 = load ptr, ptr %t0
  %t1790 = getelementptr [35 x i8], ptr @.str179, i64 0, i64 0
  %t1791 = load i64, ptr %t1715
  %t1792 = load ptr, ptr %t1704
  call void @__c0c_emit(ptr %t1789, ptr %t1790, i64 %t1791, ptr %t1792)
  br label %L357
L356:
  %t1794 = load i64, ptr %t1718
  %t1796 = icmp eq i64 %t1794, 0
  %t1795 = zext i1 %t1796 to i64
  %t1797 = load i64, ptr %t1722
  %t1799 = icmp ne i64 %t1795, 0
  %t1800 = icmp ne i64 %t1797, 0
  %t1801 = and i1 %t1799, %t1800
  %t1802 = zext i1 %t1801 to i64
  %t1803 = icmp ne i64 %t1802, 0
  br i1 %t1803, label %L358, label %L359
L358:
  %t1804 = alloca ptr
  %t1805 = load i64, ptr %t1704
  %t1806 = load ptr, ptr %t1804
  %t1807 = call i32 @promote_to_i64(ptr %t0, i64 %t1805, ptr %t1806, i64 64)
  %t1808 = sext i32 %t1807 to i64
  %t1809 = load ptr, ptr %t0
  %t1810 = getelementptr [31 x i8], ptr @.str180, i64 0, i64 0
  %t1811 = load i64, ptr %t1715
  %t1812 = load ptr, ptr %t1804
  %t1813 = load ptr, ptr %t1707
  %t1814 = call ptr @llvm_type(ptr %t1813)
  call void @__c0c_emit(ptr %t1809, ptr %t1810, i64 %t1811, ptr %t1812, ptr %t1814)
  br label %L360
L359:
  %t1816 = load i64, ptr %t1726
  %t1817 = load i64, ptr %t1744
  %t1819 = icmp eq i64 %t1817, 0
  %t1818 = zext i1 %t1819 to i64
  %t1821 = icmp ne i64 %t1816, 0
  %t1822 = icmp ne i64 %t1818, 0
  %t1823 = and i1 %t1821, %t1822
  %t1824 = zext i1 %t1823 to i64
  %t1825 = icmp ne i64 %t1824, 0
  br i1 %t1825, label %L361, label %L362
L361:
  %t1826 = alloca ptr
  %t1827 = load i64, ptr %t1704
  %t1828 = load ptr, ptr %t1826
  %t1829 = call i32 @promote_to_i64(ptr %t0, i64 %t1827, ptr %t1828, i64 64)
  %t1830 = sext i32 %t1829 to i64
  %t1831 = load ptr, ptr %t0
  %t1832 = getelementptr [34 x i8], ptr @.str181, i64 0, i64 0
  %t1833 = load i64, ptr %t1715
  %t1834 = load ptr, ptr %t1826
  call void @__c0c_emit(ptr %t1831, ptr %t1832, i64 %t1833, ptr %t1834)
  br label %L363
L362:
  %t1836 = load i64, ptr %t1726
  %t1838 = icmp eq i64 %t1836, 0
  %t1837 = zext i1 %t1838 to i64
  %t1839 = load i64, ptr %t1744
  %t1841 = icmp ne i64 %t1837, 0
  %t1842 = icmp ne i64 %t1839, 0
  %t1843 = and i1 %t1841, %t1842
  %t1844 = zext i1 %t1843 to i64
  %t1845 = icmp ne i64 %t1844, 0
  br i1 %t1845, label %L364, label %L365
L364:
  %t1846 = load ptr, ptr %t0
  %t1847 = getelementptr [34 x i8], ptr @.str182, i64 0, i64 0
  %t1848 = load i64, ptr %t1715
  %t1849 = load ptr, ptr %t1704
  call void @__c0c_emit(ptr %t1846, ptr %t1847, i64 %t1848, ptr %t1849)
  br label %L366
L365:
  %t1851 = load i64, ptr %t1726
  %t1852 = load i64, ptr %t1744
  %t1854 = icmp ne i64 %t1851, 0
  %t1855 = icmp ne i64 %t1852, 0
  %t1856 = and i1 %t1854, %t1855
  %t1857 = zext i1 %t1856 to i64
  %t1858 = icmp ne i64 %t1857, 0
  br i1 %t1858, label %L367, label %L368
L367:
  %t1859 = load ptr, ptr %t0
  %t1860 = getelementptr [33 x i8], ptr @.str183, i64 0, i64 0
  %t1861 = load i64, ptr %t1715
  %t1862 = load ptr, ptr %t1704
  call void @__c0c_emit(ptr %t1859, ptr %t1860, i64 %t1861, ptr %t1862)
  br label %L369
L368:
  %t1864 = alloca ptr
  %t1865 = load i64, ptr %t1704
  %t1866 = load ptr, ptr %t1864
  %t1867 = call i32 @promote_to_i64(ptr %t0, i64 %t1865, ptr %t1866, i64 64)
  %t1868 = sext i32 %t1867 to i64
  %t1869 = load ptr, ptr %t0
  %t1870 = getelementptr [25 x i8], ptr @.str184, i64 0, i64 0
  %t1871 = load i64, ptr %t1715
  %t1872 = load ptr, ptr %t1864
  call void @__c0c_emit(ptr %t1869, ptr %t1870, i64 %t1871, ptr %t1872)
  br label %L369
L369:
  br label %L366
L366:
  br label %L363
L363:
  br label %L360
L360:
  br label %L357
L357:
  br label %L351
L351:
  %t1874 = alloca ptr
  %t1875 = load ptr, ptr %t1874
  %t1876 = getelementptr [6 x i8], ptr @.str185, i64 0, i64 0
  %t1877 = load i64, ptr %t1715
  %t1878 = call i32 @snprintf(ptr %t1875, i64 8, ptr %t1876, i64 %t1877)
  %t1879 = sext i32 %t1878 to i64
  %t1880 = load i64, ptr %t1726
  %t1881 = icmp ne i64 %t1880, 0
  br i1 %t1881, label %L370, label %L372
L370:
  %t1882 = load ptr, ptr %t1874
  %t1883 = call ptr @default_ptr_type()
  %t1884 = call i64 @make_val(ptr %t1882, ptr %t1883)
  ret i64 %t1884
L373:
  br label %L372
L372:
  %t1885 = load i64, ptr %t1722
  %t1886 = icmp ne i64 %t1885, 0
  br i1 %t1886, label %L374, label %L376
L374:
  %t1887 = load ptr, ptr %t1874
  %t1888 = load ptr, ptr %t1707
  %t1889 = call i64 @make_val(ptr %t1887, ptr %t1888)
  ret i64 %t1889
L377:
  br label %L376
L376:
  %t1890 = load ptr, ptr %t1874
  %t1891 = call ptr @default_i64_type()
  %t1892 = call i64 @make_val(ptr %t1890, ptr %t1891)
  ret i64 %t1892
L378:
  br label %L23
L23:
  %t1893 = alloca i64
  %t1894 = load ptr, ptr %t1
  %t1895 = call i64 @emit_expr(ptr %t0, ptr %t1894)
  store i64 %t1895, ptr %t1893
  %t1896 = alloca i64
  %t1897 = call i32 @new_label(ptr %t0)
  %t1898 = sext i32 %t1897 to i64
  store i64 %t1898, ptr %t1896
  %t1899 = alloca i64
  %t1900 = call i32 @new_label(ptr %t0)
  %t1901 = sext i32 %t1900 to i64
  store i64 %t1901, ptr %t1899
  %t1902 = alloca i64
  %t1903 = call i32 @new_label(ptr %t0)
  %t1904 = sext i32 %t1903 to i64
  store i64 %t1904, ptr %t1902
  %t1905 = alloca i64
  %t1906 = load i64, ptr %t1893
  %t1907 = call i32 @emit_cond(ptr %t0, i64 %t1906)
  %t1908 = sext i32 %t1907 to i64
  store i64 %t1908, ptr %t1905
  %t1909 = load ptr, ptr %t0
  %t1910 = getelementptr [41 x i8], ptr @.str186, i64 0, i64 0
  %t1911 = load i64, ptr %t1905
  %t1912 = load i64, ptr %t1896
  %t1913 = load i64, ptr %t1899
  call void @__c0c_emit(ptr %t1909, ptr %t1910, i64 %t1911, i64 %t1912, i64 %t1913)
  %t1915 = load ptr, ptr %t0
  %t1916 = getelementptr [6 x i8], ptr @.str187, i64 0, i64 0
  %t1917 = load i64, ptr %t1896
  call void @__c0c_emit(ptr %t1915, ptr %t1916, i64 %t1917)
  %t1919 = alloca i64
  %t1920 = load ptr, ptr %t1
  %t1921 = sext i32 0 to i64
  %t1922 = getelementptr i32, ptr %t1920, i64 %t1921
  %t1923 = load i64, ptr %t1922
  %t1924 = call i64 @emit_expr(ptr %t0, i64 %t1923)
  store i64 %t1924, ptr %t1919
  %t1925 = alloca ptr
  %t1926 = load i64, ptr %t1919
  %t1927 = load ptr, ptr %t1925
  %t1928 = call i32 @promote_to_i64(ptr %t0, i64 %t1926, ptr %t1927, i64 64)
  %t1929 = sext i32 %t1928 to i64
  %t1930 = load ptr, ptr %t0
  %t1931 = getelementptr [18 x i8], ptr @.str188, i64 0, i64 0
  %t1932 = load i64, ptr %t1902
  call void @__c0c_emit(ptr %t1930, ptr %t1931, i64 %t1932)
  %t1934 = load ptr, ptr %t0
  %t1935 = getelementptr [6 x i8], ptr @.str189, i64 0, i64 0
  %t1936 = load i64, ptr %t1899
  call void @__c0c_emit(ptr %t1934, ptr %t1935, i64 %t1936)
  %t1938 = alloca i64
  %t1939 = load ptr, ptr %t1
  %t1940 = sext i32 1 to i64
  %t1941 = getelementptr i32, ptr %t1939, i64 %t1940
  %t1942 = load i64, ptr %t1941
  %t1943 = call i64 @emit_expr(ptr %t0, i64 %t1942)
  store i64 %t1943, ptr %t1938
  %t1944 = alloca ptr
  %t1945 = load i64, ptr %t1938
  %t1946 = load ptr, ptr %t1944
  %t1947 = call i32 @promote_to_i64(ptr %t0, i64 %t1945, ptr %t1946, i64 64)
  %t1948 = sext i32 %t1947 to i64
  %t1949 = load ptr, ptr %t0
  %t1950 = getelementptr [18 x i8], ptr @.str190, i64 0, i64 0
  %t1951 = load i64, ptr %t1902
  call void @__c0c_emit(ptr %t1949, ptr %t1950, i64 %t1951)
  %t1953 = load ptr, ptr %t0
  %t1954 = getelementptr [6 x i8], ptr @.str191, i64 0, i64 0
  %t1955 = load i64, ptr %t1902
  call void @__c0c_emit(ptr %t1953, ptr %t1954, i64 %t1955)
  %t1957 = alloca i64
  %t1958 = call i32 @new_reg(ptr %t0)
  %t1959 = sext i32 %t1958 to i64
  store i64 %t1959, ptr %t1957
  %t1960 = load ptr, ptr %t0
  %t1961 = getelementptr [48 x i8], ptr @.str192, i64 0, i64 0
  %t1962 = load i64, ptr %t1957
  %t1963 = load ptr, ptr %t1925
  %t1964 = load i64, ptr %t1896
  %t1965 = load ptr, ptr %t1944
  %t1966 = load i64, ptr %t1899
  call void @__c0c_emit(ptr %t1960, ptr %t1961, i64 %t1962, ptr %t1963, i64 %t1964, ptr %t1965, i64 %t1966)
  %t1968 = alloca ptr
  %t1969 = load ptr, ptr %t1968
  %t1970 = getelementptr [6 x i8], ptr @.str193, i64 0, i64 0
  %t1971 = load i64, ptr %t1957
  %t1972 = call i32 @snprintf(ptr %t1969, i64 8, ptr %t1970, i64 %t1971)
  %t1973 = sext i32 %t1972 to i64
  %t1974 = load ptr, ptr %t1968
  %t1975 = call ptr @default_i64_type()
  %t1976 = call i64 @make_val(ptr %t1974, ptr %t1975)
  ret i64 %t1976
L379:
  br label %L24
L24:
  %t1977 = alloca i64
  %t1978 = load ptr, ptr %t1
  %t1979 = icmp ne ptr %t1978, null
  br i1 %t1979, label %L380, label %L381
L380:
  %t1980 = load ptr, ptr %t1
  %t1981 = call i32 @type_size(ptr %t1980)
  %t1982 = sext i32 %t1981 to i64
  br label %L382
L381:
  %t1983 = sext i32 0 to i64
  br label %L382
L382:
  %t1984 = phi i64 [ %t1982, %L380 ], [ %t1983, %L381 ]
  store i64 %t1984, ptr %t1977
  %t1985 = alloca ptr
  %t1986 = load ptr, ptr %t1985
  %t1987 = getelementptr [3 x i8], ptr @.str194, i64 0, i64 0
  %t1988 = load i64, ptr %t1977
  %t1989 = call i32 @snprintf(ptr %t1986, i64 8, ptr %t1987, i64 %t1988)
  %t1990 = sext i32 %t1989 to i64
  %t1991 = load ptr, ptr %t1985
  %t1992 = call ptr @default_int_type()
  %t1993 = call i64 @make_val(ptr %t1991, ptr %t1992)
  ret i64 %t1993
L383:
  br label %L25
L25:
  %t1994 = alloca i64
  %t1995 = load ptr, ptr %t1
  %t1996 = sext i32 0 to i64
  %t1997 = getelementptr i32, ptr %t1995, i64 %t1996
  %t1998 = load i64, ptr %t1997
  %t1999 = inttoptr i64 %t1998 to ptr
  %t2000 = load ptr, ptr %t1999
  %t2001 = icmp ne ptr %t2000, null
  br i1 %t2001, label %L384, label %L385
L384:
  %t2002 = load ptr, ptr %t1
  %t2003 = sext i32 0 to i64
  %t2004 = getelementptr i32, ptr %t2002, i64 %t2003
  %t2005 = load i64, ptr %t2004
  %t2006 = inttoptr i64 %t2005 to ptr
  %t2007 = load ptr, ptr %t2006
  %t2008 = call i32 @type_size(ptr %t2007)
  %t2009 = sext i32 %t2008 to i64
  br label %L386
L385:
  %t2010 = sext i32 8 to i64
  br label %L386
L386:
  %t2011 = phi i64 [ %t2009, %L384 ], [ %t2010, %L385 ]
  store i64 %t2011, ptr %t1994
  %t2012 = alloca ptr
  %t2013 = load ptr, ptr %t2012
  %t2014 = getelementptr [3 x i8], ptr @.str195, i64 0, i64 0
  %t2015 = load i64, ptr %t1994
  %t2016 = call i32 @snprintf(ptr %t2013, i64 8, ptr %t2014, i64 %t2015)
  %t2017 = sext i32 %t2016 to i64
  %t2018 = load ptr, ptr %t2012
  %t2019 = call ptr @default_int_type()
  %t2020 = call i64 @make_val(ptr %t2018, ptr %t2019)
  ret i64 %t2020
L387:
  br label %L26
L26:
  %t2021 = alloca i64
  %t2022 = getelementptr [2 x i8], ptr @.str196, i64 0, i64 0
  %t2023 = call ptr @default_int_type()
  %t2024 = call i64 @make_val(ptr %t2022, ptr %t2023)
  store i64 %t2024, ptr %t2021
  %t2025 = alloca i64
  %t2026 = sext i32 0 to i64
  store i64 %t2026, ptr %t2025
  br label %L388
L388:
  %t2027 = load i64, ptr %t2025
  %t2028 = load ptr, ptr %t1
  %t2030 = ptrtoint ptr %t2028 to i64
  %t2029 = icmp slt i64 %t2027, %t2030
  %t2031 = zext i1 %t2029 to i64
  %t2032 = icmp ne i64 %t2031, 0
  br i1 %t2032, label %L389, label %L391
L389:
  %t2033 = load ptr, ptr %t1
  %t2034 = load i64, ptr %t2025
  %t2035 = getelementptr i32, ptr %t2033, i64 %t2034
  %t2036 = load i64, ptr %t2035
  %t2037 = call i64 @emit_expr(ptr %t0, i64 %t2036)
  store i64 %t2037, ptr %t2021
  br label %L390
L390:
  %t2038 = load i64, ptr %t2025
  %t2039 = add i64 %t2038, 1
  store i64 %t2039, ptr %t2025
  br label %L388
L391:
  %t2040 = load i64, ptr %t2021
  ret i64 %t2040
L392:
  br label %L27
L27:
  br label %L28
L28:
  %t2041 = alloca i64
  %t2042 = load ptr, ptr %t1
  %t2044 = ptrtoint ptr %t2042 to i64
  %t2045 = sext i32 35 to i64
  %t2043 = icmp eq i64 %t2044, %t2045
  %t2046 = zext i1 %t2043 to i64
  %t2047 = icmp ne i64 %t2046, 0
  br i1 %t2047, label %L393, label %L394
L393:
  %t2048 = load ptr, ptr %t1
  %t2049 = sext i32 0 to i64
  %t2050 = getelementptr i32, ptr %t2048, i64 %t2049
  %t2051 = load i64, ptr %t2050
  %t2052 = call i64 @emit_expr(ptr %t0, i64 %t2051)
  store i64 %t2052, ptr %t2041
  br label %L395
L394:
  %t2053 = alloca ptr
  %t2054 = load ptr, ptr %t1
  %t2055 = sext i32 0 to i64
  %t2056 = getelementptr i32, ptr %t2054, i64 %t2055
  %t2057 = load i64, ptr %t2056
  %t2058 = call ptr @emit_lvalue_addr(ptr %t0, i64 %t2057)
  store ptr %t2058, ptr %t2053
  %t2059 = load ptr, ptr %t2053
  %t2060 = icmp ne ptr %t2059, null
  br i1 %t2060, label %L396, label %L397
L396:
  %t2061 = load ptr, ptr %t2053
  %t2062 = ptrtoint ptr %t2061 to i64
  br label %L398
L397:
  %t2063 = getelementptr [5 x i8], ptr @.str197, i64 0, i64 0
  %t2064 = ptrtoint ptr %t2063 to i64
  br label %L398
L398:
  %t2065 = phi i64 [ %t2062, %L396 ], [ %t2064, %L397 ]
  %t2066 = call ptr @default_ptr_type()
  %t2067 = call i64 @make_val(i64 %t2065, ptr %t2066)
  store i64 %t2067, ptr %t2041
  %t2068 = load ptr, ptr %t2053
  %t2069 = icmp ne ptr %t2068, null
  br i1 %t2069, label %L399, label %L401
L399:
  %t2070 = load ptr, ptr %t2053
  call void @free(ptr %t2070)
  br label %L401
L401:
  br label %L395
L395:
  %t2072 = alloca ptr
  %t2073 = load i64, ptr %t2041
  %t2074 = call i32 @val_is_ptr(i64 %t2073)
  %t2075 = sext i32 %t2074 to i64
  %t2076 = icmp ne i64 %t2075, 0
  br i1 %t2076, label %L402, label %L403
L402:
  %t2077 = load ptr, ptr %t2072
  %t2078 = load ptr, ptr %t2041
  %t2079 = call ptr @strncpy(ptr %t2077, ptr %t2078, i64 63)
  %t2080 = load ptr, ptr %t2072
  %t2082 = sext i32 63 to i64
  %t2081 = getelementptr i8, ptr %t2080, i64 %t2082
  %t2083 = sext i32 0 to i64
  store i64 %t2083, ptr %t2081
  br label %L404
L403:
  %t2084 = alloca i64
  %t2085 = call i32 @new_reg(ptr %t0)
  %t2086 = sext i32 %t2085 to i64
  store i64 %t2086, ptr %t2084
  %t2087 = alloca ptr
  %t2088 = load i64, ptr %t2041
  %t2089 = load ptr, ptr %t2087
  %t2090 = call i32 @promote_to_i64(ptr %t0, i64 %t2088, ptr %t2089, i64 64)
  %t2091 = sext i32 %t2090 to i64
  %t2092 = load ptr, ptr %t0
  %t2093 = getelementptr [34 x i8], ptr @.str198, i64 0, i64 0
  %t2094 = load i64, ptr %t2084
  %t2095 = load ptr, ptr %t2087
  call void @__c0c_emit(ptr %t2092, ptr %t2093, i64 %t2094, ptr %t2095)
  %t2097 = load ptr, ptr %t2072
  %t2098 = getelementptr [6 x i8], ptr @.str199, i64 0, i64 0
  %t2099 = load i64, ptr %t2084
  %t2100 = call i32 @snprintf(ptr %t2097, i64 64, ptr %t2098, i64 %t2099)
  %t2101 = sext i32 %t2100 to i64
  br label %L404
L404:
  %t2102 = alloca i64
  %t2103 = call i32 @new_reg(ptr %t0)
  %t2104 = sext i32 %t2103 to i64
  store i64 %t2104, ptr %t2102
  %t2105 = load ptr, ptr %t0
  %t2106 = getelementptr [28 x i8], ptr @.str200, i64 0, i64 0
  %t2107 = load i64, ptr %t2102
  %t2108 = load ptr, ptr %t2072
  call void @__c0c_emit(ptr %t2105, ptr %t2106, i64 %t2107, ptr %t2108)
  %t2110 = alloca ptr
  %t2111 = load ptr, ptr %t2110
  %t2112 = getelementptr [6 x i8], ptr @.str201, i64 0, i64 0
  %t2113 = load i64, ptr %t2102
  %t2114 = call i32 @snprintf(ptr %t2111, i64 8, ptr %t2112, i64 %t2113)
  %t2115 = sext i32 %t2114 to i64
  %t2116 = load ptr, ptr %t2110
  %t2117 = call ptr @default_ptr_type()
  %t2118 = call i64 @make_val(ptr %t2116, ptr %t2117)
  ret i64 %t2118
L405:
  br label %L4
L29:
  %t2119 = load ptr, ptr %t0
  %t2120 = getelementptr [28 x i8], ptr @.str202, i64 0, i64 0
  %t2121 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t2119, ptr %t2120, ptr %t2121)
  %t2123 = getelementptr [2 x i8], ptr @.str203, i64 0, i64 0
  %t2124 = call ptr @default_int_type()
  %t2125 = call i64 @make_val(ptr %t2123, ptr %t2124)
  ret i64 %t2125
L406:
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
  %t58 = getelementptr [4 x i8], ptr @.str204, i64 0, i64 0
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
  %t67 = getelementptr [4 x i8], ptr @.str205, i64 0, i64 0
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
  %t72 = load ptr, ptr %t0
  %t73 = getelementptr [21 x i8], ptr @.str206, i64 0, i64 0
  %t74 = load i64, ptr %t69
  %t75 = load ptr, ptr %t38
  call void @__c0c_emit(ptr %t72, ptr %t73, i64 %t74, ptr %t75)
  %t77 = load ptr, ptr %t0
  %t79 = ptrtoint ptr %t77 to i64
  %t80 = sext i32 2048 to i64
  %t78 = icmp sge i64 %t79, %t80
  %t81 = zext i1 %t78 to i64
  %t82 = icmp ne i64 %t81, 0
  br i1 %t82, label %L42, label %L44
L42:
  %t83 = call ptr @__c0c_stderr()
  %t84 = getelementptr [22 x i8], ptr @.str207, i64 0, i64 0
  %t85 = call i32 @fprintf(ptr %t83, ptr %t84)
  %t86 = sext i32 %t85 to i64
  call void @exit(i64 1)
  br label %L44
L44:
  %t88 = alloca ptr
  %t89 = load ptr, ptr %t0
  %t90 = load ptr, ptr %t0
  %t92 = ptrtoint ptr %t90 to i64
  %t91 = add i64 %t92, 1
  store i64 %t91, ptr %t0
  %t94 = ptrtoint ptr %t90 to i64
  %t93 = getelementptr i8, ptr %t89, i64 %t94
  store ptr %t93, ptr %t88
  %t95 = load ptr, ptr %t1
  %t96 = icmp ne ptr %t95, null
  br i1 %t96, label %L45, label %L46
L45:
  %t97 = load ptr, ptr %t1
  %t98 = ptrtoint ptr %t97 to i64
  br label %L47
L46:
  %t99 = getelementptr [7 x i8], ptr @.str208, i64 0, i64 0
  %t100 = ptrtoint ptr %t99 to i64
  br label %L47
L47:
  %t101 = phi i64 [ %t98, %L45 ], [ %t100, %L46 ]
  %t102 = call ptr @strdup(i64 %t101)
  %t103 = load ptr, ptr %t88
  store ptr %t102, ptr %t103
  %t104 = call ptr @malloc(i64 32)
  %t105 = load ptr, ptr %t88
  store ptr %t104, ptr %t105
  %t106 = load ptr, ptr %t88
  %t107 = load ptr, ptr %t106
  %t108 = getelementptr [6 x i8], ptr @.str209, i64 0, i64 0
  %t109 = load i64, ptr %t69
  %t110 = call i32 @snprintf(ptr %t107, i64 32, ptr %t108, i64 %t109)
  %t111 = sext i32 %t110 to i64
  %t112 = load ptr, ptr %t39
  %t113 = load ptr, ptr %t88
  store ptr %t112, ptr %t113
  %t114 = load ptr, ptr %t88
  %t115 = sext i32 0 to i64
  store i64 %t115, ptr %t114
  %t116 = load ptr, ptr %t1
  %t118 = ptrtoint ptr %t116 to i64
  %t119 = sext i32 0 to i64
  %t117 = icmp sgt i64 %t118, %t119
  %t120 = zext i1 %t117 to i64
  %t121 = icmp ne i64 %t120, 0
  br i1 %t121, label %L48, label %L50
L48:
  %t122 = alloca i64
  %t123 = load ptr, ptr %t1
  %t124 = sext i32 0 to i64
  %t125 = getelementptr i32, ptr %t123, i64 %t124
  %t126 = load i64, ptr %t125
  %t127 = call i64 @emit_expr(ptr %t0, i64 %t126)
  store i64 %t127, ptr %t122
  %t128 = alloca ptr
  %t129 = load i64, ptr %t122
  %t130 = call i32 @val_is_ptr(i64 %t129)
  %t131 = sext i32 %t130 to i64
  %t132 = icmp ne i64 %t131, 0
  br i1 %t132, label %L51, label %L52
L51:
  %t133 = getelementptr [4 x i8], ptr @.str210, i64 0, i64 0
  store ptr %t133, ptr %t128
  br label %L53
L52:
  %t134 = load ptr, ptr %t122
  %t135 = call i32 @type_is_fp(ptr %t134)
  %t136 = sext i32 %t135 to i64
  %t137 = icmp ne i64 %t136, 0
  br i1 %t137, label %L54, label %L55
L54:
  %t138 = load ptr, ptr %t122
  %t139 = call ptr @llvm_type(ptr %t138)
  store ptr %t139, ptr %t128
  br label %L56
L55:
  %t140 = getelementptr [4 x i8], ptr @.str211, i64 0, i64 0
  store ptr %t140, ptr %t128
  br label %L56
L56:
  br label %L53
L53:
  %t141 = alloca ptr
  %t142 = load i64, ptr %t122
  %t143 = call i32 @val_is_ptr(i64 %t142)
  %t144 = sext i32 %t143 to i64
  %t146 = icmp eq i64 %t144, 0
  %t145 = zext i1 %t146 to i64
  %t147 = load i64, ptr %t122
  %t148 = call i32 @val_is_64bit(i64 %t147)
  %t149 = sext i32 %t148 to i64
  %t151 = icmp eq i64 %t149, 0
  %t150 = zext i1 %t151 to i64
  %t153 = icmp ne i64 %t145, 0
  %t154 = icmp ne i64 %t150, 0
  %t155 = and i1 %t153, %t154
  %t156 = zext i1 %t155 to i64
  %t157 = load ptr, ptr %t122
  %t158 = call i32 @type_is_fp(ptr %t157)
  %t159 = sext i32 %t158 to i64
  %t161 = icmp eq i64 %t159, 0
  %t160 = zext i1 %t161 to i64
  %t163 = icmp ne i64 %t156, 0
  %t164 = icmp ne i64 %t160, 0
  %t165 = and i1 %t163, %t164
  %t166 = zext i1 %t165 to i64
  %t167 = icmp ne i64 %t166, 0
  br i1 %t167, label %L57, label %L58
L57:
  %t168 = alloca i64
  %t169 = call i32 @new_reg(ptr %t0)
  %t170 = sext i32 %t169 to i64
  store i64 %t170, ptr %t168
  %t171 = load ptr, ptr %t0
  %t172 = getelementptr [30 x i8], ptr @.str212, i64 0, i64 0
  %t173 = load i64, ptr %t168
  %t174 = load ptr, ptr %t122
  call void @__c0c_emit(ptr %t171, ptr %t172, i64 %t173, ptr %t174)
  %t176 = load ptr, ptr %t141
  %t177 = getelementptr [6 x i8], ptr @.str213, i64 0, i64 0
  %t178 = load i64, ptr %t168
  %t179 = call i32 @snprintf(ptr %t176, i64 64, ptr %t177, i64 %t178)
  %t180 = sext i32 %t179 to i64
  br label %L59
L58:
  %t181 = load ptr, ptr %t141
  %t182 = load ptr, ptr %t122
  %t183 = call ptr @strncpy(ptr %t181, ptr %t182, i64 63)
  %t184 = load ptr, ptr %t141
  %t186 = sext i32 63 to i64
  %t185 = getelementptr i8, ptr %t184, i64 %t186
  %t187 = sext i32 0 to i64
  store i64 %t187, ptr %t185
  br label %L59
L59:
  %t188 = load ptr, ptr %t0
  %t189 = getelementptr [26 x i8], ptr @.str214, i64 0, i64 0
  %t190 = load ptr, ptr %t128
  %t191 = load ptr, ptr %t141
  %t192 = load i64, ptr %t69
  call void @__c0c_emit(ptr %t188, ptr %t189, ptr %t190, ptr %t191, i64 %t192)
  br label %L50
L50:
  %t194 = alloca i64
  %t195 = sext i32 1 to i64
  store i64 %t195, ptr %t194
  br label %L60
L60:
  %t196 = load i64, ptr %t194
  %t197 = load ptr, ptr %t1
  %t199 = ptrtoint ptr %t197 to i64
  %t198 = icmp slt i64 %t196, %t199
  %t200 = zext i1 %t198 to i64
  %t201 = icmp ne i64 %t200, 0
  br i1 %t201, label %L61, label %L63
L61:
  %t202 = load ptr, ptr %t1
  %t203 = load i64, ptr %t194
  %t204 = getelementptr i32, ptr %t202, i64 %t203
  %t205 = load i64, ptr %t204
  call void @emit_stmt(ptr %t0, i64 %t205)
  br label %L62
L62:
  %t207 = load i64, ptr %t194
  %t208 = add i64 %t207, 1
  store i64 %t208, ptr %t194
  br label %L60
L63:
  br label %L4
L64:
  br label %L7
L7:
  %t209 = load ptr, ptr %t1
  %t211 = ptrtoint ptr %t209 to i64
  %t212 = sext i32 0 to i64
  %t210 = icmp sgt i64 %t211, %t212
  %t213 = zext i1 %t210 to i64
  %t214 = icmp ne i64 %t213, 0
  br i1 %t214, label %L65, label %L67
L65:
  %t215 = load ptr, ptr %t1
  %t216 = sext i32 0 to i64
  %t217 = getelementptr i32, ptr %t215, i64 %t216
  %t218 = load i64, ptr %t217
  %t219 = call i64 @emit_expr(ptr %t0, i64 %t218)
  br label %L67
L67:
  br label %L4
L68:
  br label %L8
L8:
  %t220 = load ptr, ptr %t1
  %t221 = icmp ne ptr %t220, null
  br i1 %t221, label %L69, label %L70
L69:
  %t222 = alloca i64
  %t223 = load ptr, ptr %t1
  %t224 = call i64 @emit_expr(ptr %t0, ptr %t223)
  store i64 %t224, ptr %t222
  %t225 = alloca ptr
  %t226 = load ptr, ptr %t0
  store ptr %t226, ptr %t225
  %t227 = alloca i64
  %t228 = load ptr, ptr %t225
  %t229 = load ptr, ptr %t228
  %t231 = ptrtoint ptr %t229 to i64
  %t232 = sext i32 15 to i64
  %t230 = icmp eq i64 %t231, %t232
  %t233 = zext i1 %t230 to i64
  %t234 = load ptr, ptr %t225
  %t235 = load ptr, ptr %t234
  %t237 = ptrtoint ptr %t235 to i64
  %t238 = sext i32 16 to i64
  %t236 = icmp eq i64 %t237, %t238
  %t239 = zext i1 %t236 to i64
  %t241 = icmp ne i64 %t233, 0
  %t242 = icmp ne i64 %t239, 0
  %t243 = or i1 %t241, %t242
  %t244 = zext i1 %t243 to i64
  store i64 %t244, ptr %t227
  %t245 = alloca i64
  %t246 = load ptr, ptr %t225
  %t247 = load ptr, ptr %t246
  %t249 = ptrtoint ptr %t247 to i64
  %t250 = sext i32 0 to i64
  %t248 = icmp eq i64 %t249, %t250
  %t251 = zext i1 %t248 to i64
  store i64 %t251, ptr %t245
  %t252 = alloca i64
  %t253 = load ptr, ptr %t225
  %t254 = call i32 @type_is_fp(ptr %t253)
  %t255 = sext i32 %t254 to i64
  store i64 %t255, ptr %t252
  %t256 = alloca ptr
  %t257 = load ptr, ptr %t225
  %t258 = call ptr @llvm_type(ptr %t257)
  store ptr %t258, ptr %t256
  %t259 = load i64, ptr %t245
  %t260 = icmp ne i64 %t259, 0
  br i1 %t260, label %L72, label %L73
L72:
  %t261 = load ptr, ptr %t0
  %t262 = getelementptr [12 x i8], ptr @.str215, i64 0, i64 0
  call void @__c0c_emit(ptr %t261, ptr %t262)
  br label %L74
L73:
  %t264 = load i64, ptr %t252
  %t265 = icmp ne i64 %t264, 0
  br i1 %t265, label %L75, label %L76
L75:
  %t266 = load ptr, ptr %t0
  %t267 = getelementptr [13 x i8], ptr @.str216, i64 0, i64 0
  %t268 = load ptr, ptr %t256
  %t269 = load ptr, ptr %t222
  call void @__c0c_emit(ptr %t266, ptr %t267, ptr %t268, ptr %t269)
  br label %L77
L76:
  %t271 = load i64, ptr %t227
  %t272 = icmp ne i64 %t271, 0
  br i1 %t272, label %L78, label %L79
L78:
  %t273 = load i64, ptr %t222
  %t274 = call i32 @val_is_ptr(i64 %t273)
  %t275 = sext i32 %t274 to i64
  %t276 = icmp ne i64 %t275, 0
  br i1 %t276, label %L81, label %L82
L81:
  %t277 = load ptr, ptr %t0
  %t278 = getelementptr [14 x i8], ptr @.str217, i64 0, i64 0
  %t279 = load ptr, ptr %t222
  call void @__c0c_emit(ptr %t277, ptr %t278, ptr %t279)
  br label %L83
L82:
  %t281 = alloca i64
  %t282 = call i32 @new_reg(ptr %t0)
  %t283 = sext i32 %t282 to i64
  store i64 %t283, ptr %t281
  %t284 = alloca ptr
  %t285 = load i64, ptr %t222
  %t286 = load ptr, ptr %t284
  %t287 = call i32 @promote_to_i64(ptr %t0, i64 %t285, ptr %t286, i64 64)
  %t288 = sext i32 %t287 to i64
  %t289 = load ptr, ptr %t0
  %t290 = getelementptr [34 x i8], ptr @.str218, i64 0, i64 0
  %t291 = load i64, ptr %t281
  %t292 = load ptr, ptr %t284
  call void @__c0c_emit(ptr %t289, ptr %t290, i64 %t291, ptr %t292)
  %t294 = load ptr, ptr %t0
  %t295 = getelementptr [17 x i8], ptr @.str219, i64 0, i64 0
  %t296 = load i64, ptr %t281
  call void @__c0c_emit(ptr %t294, ptr %t295, i64 %t296)
  br label %L83
L83:
  br label %L80
L79:
  %t298 = alloca ptr
  %t299 = load i64, ptr %t222
  %t300 = load ptr, ptr %t298
  %t301 = call i32 @promote_to_i64(ptr %t0, i64 %t299, ptr %t300, i64 64)
  %t302 = sext i32 %t301 to i64
  %t303 = load ptr, ptr %t256
  %t304 = getelementptr [3 x i8], ptr @.str220, i64 0, i64 0
  %t305 = call i32 @strcmp(ptr %t303, ptr %t304)
  %t306 = sext i32 %t305 to i64
  %t308 = sext i32 0 to i64
  %t307 = icmp eq i64 %t306, %t308
  %t309 = zext i1 %t307 to i64
  %t310 = icmp ne i64 %t309, 0
  br i1 %t310, label %L84, label %L85
L84:
  %t311 = alloca i64
  %t312 = call i32 @new_reg(ptr %t0)
  %t313 = sext i32 %t312 to i64
  store i64 %t313, ptr %t311
  %t314 = load ptr, ptr %t0
  %t315 = getelementptr [30 x i8], ptr @.str221, i64 0, i64 0
  %t316 = load i64, ptr %t311
  %t317 = load ptr, ptr %t298
  call void @__c0c_emit(ptr %t314, ptr %t315, i64 %t316, ptr %t317)
  %t319 = load ptr, ptr %t0
  %t320 = getelementptr [16 x i8], ptr @.str222, i64 0, i64 0
  %t321 = load i64, ptr %t311
  call void @__c0c_emit(ptr %t319, ptr %t320, i64 %t321)
  br label %L86
L85:
  %t323 = load ptr, ptr %t256
  %t324 = getelementptr [4 x i8], ptr @.str223, i64 0, i64 0
  %t325 = call i32 @strcmp(ptr %t323, ptr %t324)
  %t326 = sext i32 %t325 to i64
  %t328 = sext i32 0 to i64
  %t327 = icmp eq i64 %t326, %t328
  %t329 = zext i1 %t327 to i64
  %t330 = icmp ne i64 %t329, 0
  br i1 %t330, label %L87, label %L88
L87:
  %t331 = alloca i64
  %t332 = call i32 @new_reg(ptr %t0)
  %t333 = sext i32 %t332 to i64
  store i64 %t333, ptr %t331
  %t334 = load ptr, ptr %t0
  %t335 = getelementptr [31 x i8], ptr @.str224, i64 0, i64 0
  %t336 = load i64, ptr %t331
  %t337 = load ptr, ptr %t298
  call void @__c0c_emit(ptr %t334, ptr %t335, i64 %t336, ptr %t337)
  %t339 = load ptr, ptr %t0
  %t340 = getelementptr [17 x i8], ptr @.str225, i64 0, i64 0
  %t341 = load i64, ptr %t331
  call void @__c0c_emit(ptr %t339, ptr %t340, i64 %t341)
  br label %L89
L88:
  %t343 = load ptr, ptr %t256
  %t344 = getelementptr [4 x i8], ptr @.str226, i64 0, i64 0
  %t345 = call i32 @strcmp(ptr %t343, ptr %t344)
  %t346 = sext i32 %t345 to i64
  %t348 = sext i32 0 to i64
  %t347 = icmp eq i64 %t346, %t348
  %t349 = zext i1 %t347 to i64
  %t350 = icmp ne i64 %t349, 0
  br i1 %t350, label %L90, label %L91
L90:
  %t351 = alloca i64
  %t352 = call i32 @new_reg(ptr %t0)
  %t353 = sext i32 %t352 to i64
  store i64 %t353, ptr %t351
  %t354 = load ptr, ptr %t0
  %t355 = getelementptr [31 x i8], ptr @.str227, i64 0, i64 0
  %t356 = load i64, ptr %t351
  %t357 = load ptr, ptr %t298
  call void @__c0c_emit(ptr %t354, ptr %t355, i64 %t356, ptr %t357)
  %t359 = load ptr, ptr %t0
  %t360 = getelementptr [17 x i8], ptr @.str228, i64 0, i64 0
  %t361 = load i64, ptr %t351
  call void @__c0c_emit(ptr %t359, ptr %t360, i64 %t361)
  br label %L92
L91:
  %t363 = load ptr, ptr %t0
  %t364 = getelementptr [14 x i8], ptr @.str229, i64 0, i64 0
  %t365 = load ptr, ptr %t298
  call void @__c0c_emit(ptr %t363, ptr %t364, ptr %t365)
  br label %L92
L92:
  br label %L89
L89:
  br label %L86
L86:
  br label %L80
L80:
  br label %L77
L77:
  br label %L74
L74:
  br label %L71
L70:
  %t367 = load ptr, ptr %t0
  %t368 = getelementptr [12 x i8], ptr @.str230, i64 0, i64 0
  call void @__c0c_emit(ptr %t367, ptr %t368)
  br label %L71
L71:
  %t370 = alloca i64
  %t371 = call i32 @new_label(ptr %t0)
  %t372 = sext i32 %t371 to i64
  store i64 %t372, ptr %t370
  %t373 = load ptr, ptr %t0
  %t374 = getelementptr [6 x i8], ptr @.str231, i64 0, i64 0
  %t375 = load i64, ptr %t370
  call void @__c0c_emit(ptr %t373, ptr %t374, i64 %t375)
  br label %L4
L93:
  br label %L9
L9:
  %t377 = alloca i64
  %t378 = load ptr, ptr %t1
  %t379 = call i64 @emit_expr(ptr %t0, ptr %t378)
  store i64 %t379, ptr %t377
  %t380 = alloca i64
  %t381 = load i64, ptr %t377
  %t382 = call i32 @emit_cond(ptr %t0, i64 %t381)
  %t383 = sext i32 %t382 to i64
  store i64 %t383, ptr %t380
  %t384 = alloca i64
  %t385 = call i32 @new_label(ptr %t0)
  %t386 = sext i32 %t385 to i64
  store i64 %t386, ptr %t384
  %t387 = alloca i64
  %t388 = call i32 @new_label(ptr %t0)
  %t389 = sext i32 %t388 to i64
  store i64 %t389, ptr %t387
  %t390 = alloca i64
  %t391 = call i32 @new_label(ptr %t0)
  %t392 = sext i32 %t391 to i64
  store i64 %t392, ptr %t390
  %t393 = load ptr, ptr %t0
  %t394 = getelementptr [41 x i8], ptr @.str232, i64 0, i64 0
  %t395 = load i64, ptr %t380
  %t396 = load i64, ptr %t384
  %t397 = load ptr, ptr %t1
  %t398 = icmp ne ptr %t397, null
  br i1 %t398, label %L94, label %L95
L94:
  %t399 = load i64, ptr %t387
  br label %L96
L95:
  %t400 = load i64, ptr %t390
  br label %L96
L96:
  %t401 = phi i64 [ %t399, %L94 ], [ %t400, %L95 ]
  call void @__c0c_emit(ptr %t393, ptr %t394, i64 %t395, i64 %t396, i64 %t401)
  %t403 = load ptr, ptr %t0
  %t404 = getelementptr [6 x i8], ptr @.str233, i64 0, i64 0
  %t405 = load i64, ptr %t384
  call void @__c0c_emit(ptr %t403, ptr %t404, i64 %t405)
  %t407 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t407)
  %t409 = load ptr, ptr %t0
  %t410 = getelementptr [18 x i8], ptr @.str234, i64 0, i64 0
  %t411 = load i64, ptr %t390
  call void @__c0c_emit(ptr %t409, ptr %t410, i64 %t411)
  %t413 = load ptr, ptr %t1
  %t414 = icmp ne ptr %t413, null
  br i1 %t414, label %L97, label %L99
L97:
  %t415 = load ptr, ptr %t0
  %t416 = getelementptr [6 x i8], ptr @.str235, i64 0, i64 0
  %t417 = load i64, ptr %t387
  call void @__c0c_emit(ptr %t415, ptr %t416, i64 %t417)
  %t419 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t419)
  %t421 = load ptr, ptr %t0
  %t422 = getelementptr [18 x i8], ptr @.str236, i64 0, i64 0
  %t423 = load i64, ptr %t390
  call void @__c0c_emit(ptr %t421, ptr %t422, i64 %t423)
  br label %L99
L99:
  %t425 = load ptr, ptr %t0
  %t426 = getelementptr [6 x i8], ptr @.str237, i64 0, i64 0
  %t427 = load i64, ptr %t390
  call void @__c0c_emit(ptr %t425, ptr %t426, i64 %t427)
  br label %L4
L100:
  br label %L10
L10:
  %t429 = alloca i64
  %t430 = call i32 @new_label(ptr %t0)
  %t431 = sext i32 %t430 to i64
  store i64 %t431, ptr %t429
  %t432 = alloca i64
  %t433 = call i32 @new_label(ptr %t0)
  %t434 = sext i32 %t433 to i64
  store i64 %t434, ptr %t432
  %t435 = alloca i64
  %t436 = call i32 @new_label(ptr %t0)
  %t437 = sext i32 %t436 to i64
  store i64 %t437, ptr %t435
  %t438 = alloca ptr
  %t439 = alloca ptr
  %t440 = load ptr, ptr %t438
  %t441 = load ptr, ptr %t0
  %t442 = call ptr @strcpy(ptr %t440, ptr %t441)
  %t443 = load ptr, ptr %t439
  %t444 = load ptr, ptr %t0
  %t445 = call ptr @strcpy(ptr %t443, ptr %t444)
  %t446 = load ptr, ptr %t0
  %t447 = getelementptr [4 x i8], ptr @.str238, i64 0, i64 0
  %t448 = load i64, ptr %t435
  %t449 = call i32 @snprintf(ptr %t446, i64 64, ptr %t447, i64 %t448)
  %t450 = sext i32 %t449 to i64
  %t451 = load ptr, ptr %t0
  %t452 = getelementptr [4 x i8], ptr @.str239, i64 0, i64 0
  %t453 = load i64, ptr %t429
  %t454 = call i32 @snprintf(ptr %t451, i64 64, ptr %t452, i64 %t453)
  %t455 = sext i32 %t454 to i64
  %t456 = load ptr, ptr %t0
  %t457 = getelementptr [18 x i8], ptr @.str240, i64 0, i64 0
  %t458 = load i64, ptr %t429
  call void @__c0c_emit(ptr %t456, ptr %t457, i64 %t458)
  %t460 = load ptr, ptr %t0
  %t461 = getelementptr [6 x i8], ptr @.str241, i64 0, i64 0
  %t462 = load i64, ptr %t429
  call void @__c0c_emit(ptr %t460, ptr %t461, i64 %t462)
  %t464 = alloca i64
  %t465 = load ptr, ptr %t1
  %t466 = call i64 @emit_expr(ptr %t0, ptr %t465)
  store i64 %t466, ptr %t464
  %t467 = alloca i64
  %t468 = load i64, ptr %t464
  %t469 = call i32 @emit_cond(ptr %t0, i64 %t468)
  %t470 = sext i32 %t469 to i64
  store i64 %t470, ptr %t467
  %t471 = load ptr, ptr %t0
  %t472 = getelementptr [41 x i8], ptr @.str242, i64 0, i64 0
  %t473 = load i64, ptr %t467
  %t474 = load i64, ptr %t432
  %t475 = load i64, ptr %t435
  call void @__c0c_emit(ptr %t471, ptr %t472, i64 %t473, i64 %t474, i64 %t475)
  %t477 = load ptr, ptr %t0
  %t478 = getelementptr [6 x i8], ptr @.str243, i64 0, i64 0
  %t479 = load i64, ptr %t432
  call void @__c0c_emit(ptr %t477, ptr %t478, i64 %t479)
  %t481 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t481)
  %t483 = load ptr, ptr %t0
  %t484 = getelementptr [18 x i8], ptr @.str244, i64 0, i64 0
  %t485 = load i64, ptr %t429
  call void @__c0c_emit(ptr %t483, ptr %t484, i64 %t485)
  %t487 = load ptr, ptr %t0
  %t488 = getelementptr [6 x i8], ptr @.str245, i64 0, i64 0
  %t489 = load i64, ptr %t435
  call void @__c0c_emit(ptr %t487, ptr %t488, i64 %t489)
  %t491 = load ptr, ptr %t0
  %t492 = load ptr, ptr %t438
  %t493 = call ptr @strcpy(ptr %t491, ptr %t492)
  %t494 = load ptr, ptr %t0
  %t495 = load ptr, ptr %t439
  %t496 = call ptr @strcpy(ptr %t494, ptr %t495)
  br label %L4
L101:
  br label %L11
L11:
  %t497 = alloca i64
  %t498 = call i32 @new_label(ptr %t0)
  %t499 = sext i32 %t498 to i64
  store i64 %t499, ptr %t497
  %t500 = alloca i64
  %t501 = call i32 @new_label(ptr %t0)
  %t502 = sext i32 %t501 to i64
  store i64 %t502, ptr %t500
  %t503 = alloca i64
  %t504 = call i32 @new_label(ptr %t0)
  %t505 = sext i32 %t504 to i64
  store i64 %t505, ptr %t503
  %t506 = alloca ptr
  %t507 = alloca ptr
  %t508 = load ptr, ptr %t506
  %t509 = load ptr, ptr %t0
  %t510 = call ptr @strcpy(ptr %t508, ptr %t509)
  %t511 = load ptr, ptr %t507
  %t512 = load ptr, ptr %t0
  %t513 = call ptr @strcpy(ptr %t511, ptr %t512)
  %t514 = load ptr, ptr %t0
  %t515 = getelementptr [4 x i8], ptr @.str246, i64 0, i64 0
  %t516 = load i64, ptr %t503
  %t517 = call i32 @snprintf(ptr %t514, i64 64, ptr %t515, i64 %t516)
  %t518 = sext i32 %t517 to i64
  %t519 = load ptr, ptr %t0
  %t520 = getelementptr [4 x i8], ptr @.str247, i64 0, i64 0
  %t521 = load i64, ptr %t500
  %t522 = call i32 @snprintf(ptr %t519, i64 64, ptr %t520, i64 %t521)
  %t523 = sext i32 %t522 to i64
  %t524 = load ptr, ptr %t0
  %t525 = getelementptr [18 x i8], ptr @.str248, i64 0, i64 0
  %t526 = load i64, ptr %t497
  call void @__c0c_emit(ptr %t524, ptr %t525, i64 %t526)
  %t528 = load ptr, ptr %t0
  %t529 = getelementptr [6 x i8], ptr @.str249, i64 0, i64 0
  %t530 = load i64, ptr %t497
  call void @__c0c_emit(ptr %t528, ptr %t529, i64 %t530)
  %t532 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t532)
  %t534 = load ptr, ptr %t0
  %t535 = getelementptr [18 x i8], ptr @.str250, i64 0, i64 0
  %t536 = load i64, ptr %t500
  call void @__c0c_emit(ptr %t534, ptr %t535, i64 %t536)
  %t538 = load ptr, ptr %t0
  %t539 = getelementptr [6 x i8], ptr @.str251, i64 0, i64 0
  %t540 = load i64, ptr %t500
  call void @__c0c_emit(ptr %t538, ptr %t539, i64 %t540)
  %t542 = alloca i64
  %t543 = load ptr, ptr %t1
  %t544 = call i64 @emit_expr(ptr %t0, ptr %t543)
  store i64 %t544, ptr %t542
  %t545 = alloca i64
  %t546 = load i64, ptr %t542
  %t547 = call i32 @emit_cond(ptr %t0, i64 %t546)
  %t548 = sext i32 %t547 to i64
  store i64 %t548, ptr %t545
  %t549 = load ptr, ptr %t0
  %t550 = getelementptr [41 x i8], ptr @.str252, i64 0, i64 0
  %t551 = load i64, ptr %t545
  %t552 = load i64, ptr %t497
  %t553 = load i64, ptr %t503
  call void @__c0c_emit(ptr %t549, ptr %t550, i64 %t551, i64 %t552, i64 %t553)
  %t555 = load ptr, ptr %t0
  %t556 = getelementptr [6 x i8], ptr @.str253, i64 0, i64 0
  %t557 = load i64, ptr %t503
  call void @__c0c_emit(ptr %t555, ptr %t556, i64 %t557)
  %t559 = load ptr, ptr %t0
  %t560 = load ptr, ptr %t506
  %t561 = call ptr @strcpy(ptr %t559, ptr %t560)
  %t562 = load ptr, ptr %t0
  %t563 = load ptr, ptr %t507
  %t564 = call ptr @strcpy(ptr %t562, ptr %t563)
  br label %L4
L102:
  br label %L12
L12:
  %t565 = alloca i64
  %t566 = call i32 @new_label(ptr %t0)
  %t567 = sext i32 %t566 to i64
  store i64 %t567, ptr %t565
  %t568 = alloca i64
  %t569 = call i32 @new_label(ptr %t0)
  %t570 = sext i32 %t569 to i64
  store i64 %t570, ptr %t568
  %t571 = alloca i64
  %t572 = call i32 @new_label(ptr %t0)
  %t573 = sext i32 %t572 to i64
  store i64 %t573, ptr %t571
  %t574 = alloca i64
  %t575 = call i32 @new_label(ptr %t0)
  %t576 = sext i32 %t575 to i64
  store i64 %t576, ptr %t574
  %t577 = alloca ptr
  %t578 = alloca ptr
  %t579 = load ptr, ptr %t577
  %t580 = load ptr, ptr %t0
  %t581 = call ptr @strcpy(ptr %t579, ptr %t580)
  %t582 = load ptr, ptr %t578
  %t583 = load ptr, ptr %t0
  %t584 = call ptr @strcpy(ptr %t582, ptr %t583)
  %t585 = load ptr, ptr %t0
  %t586 = getelementptr [4 x i8], ptr @.str254, i64 0, i64 0
  %t587 = load i64, ptr %t574
  %t588 = call i32 @snprintf(ptr %t585, i64 64, ptr %t586, i64 %t587)
  %t589 = sext i32 %t588 to i64
  %t590 = load ptr, ptr %t0
  %t591 = getelementptr [4 x i8], ptr @.str255, i64 0, i64 0
  %t592 = load i64, ptr %t571
  %t593 = call i32 @snprintf(ptr %t590, i64 64, ptr %t591, i64 %t592)
  %t594 = sext i32 %t593 to i64
  call void @scope_push(ptr %t0)
  %t596 = load ptr, ptr %t1
  %t597 = icmp ne ptr %t596, null
  br i1 %t597, label %L103, label %L105
L103:
  %t598 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t598)
  br label %L105
L105:
  %t600 = load ptr, ptr %t0
  %t601 = getelementptr [18 x i8], ptr @.str256, i64 0, i64 0
  %t602 = load i64, ptr %t565
  call void @__c0c_emit(ptr %t600, ptr %t601, i64 %t602)
  %t604 = load ptr, ptr %t0
  %t605 = getelementptr [6 x i8], ptr @.str257, i64 0, i64 0
  %t606 = load i64, ptr %t565
  call void @__c0c_emit(ptr %t604, ptr %t605, i64 %t606)
  %t608 = load ptr, ptr %t1
  %t609 = icmp ne ptr %t608, null
  br i1 %t609, label %L106, label %L107
L106:
  %t610 = alloca i64
  %t611 = load ptr, ptr %t1
  %t612 = call i64 @emit_expr(ptr %t0, ptr %t611)
  store i64 %t612, ptr %t610
  %t613 = alloca i64
  %t614 = load i64, ptr %t610
  %t615 = call i32 @emit_cond(ptr %t0, i64 %t614)
  %t616 = sext i32 %t615 to i64
  store i64 %t616, ptr %t613
  %t617 = load ptr, ptr %t0
  %t618 = getelementptr [41 x i8], ptr @.str258, i64 0, i64 0
  %t619 = load i64, ptr %t613
  %t620 = load i64, ptr %t568
  %t621 = load i64, ptr %t574
  call void @__c0c_emit(ptr %t617, ptr %t618, i64 %t619, i64 %t620, i64 %t621)
  br label %L108
L107:
  %t623 = load ptr, ptr %t0
  %t624 = getelementptr [18 x i8], ptr @.str259, i64 0, i64 0
  %t625 = load i64, ptr %t568
  call void @__c0c_emit(ptr %t623, ptr %t624, i64 %t625)
  br label %L108
L108:
  %t627 = load ptr, ptr %t0
  %t628 = getelementptr [6 x i8], ptr @.str260, i64 0, i64 0
  %t629 = load i64, ptr %t568
  call void @__c0c_emit(ptr %t627, ptr %t628, i64 %t629)
  %t631 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t631)
  %t633 = load ptr, ptr %t0
  %t634 = getelementptr [18 x i8], ptr @.str261, i64 0, i64 0
  %t635 = load i64, ptr %t571
  call void @__c0c_emit(ptr %t633, ptr %t634, i64 %t635)
  %t637 = load ptr, ptr %t0
  %t638 = getelementptr [6 x i8], ptr @.str262, i64 0, i64 0
  %t639 = load i64, ptr %t571
  call void @__c0c_emit(ptr %t637, ptr %t638, i64 %t639)
  %t641 = load ptr, ptr %t1
  %t642 = icmp ne ptr %t641, null
  br i1 %t642, label %L109, label %L111
L109:
  %t643 = load ptr, ptr %t1
  %t644 = call i64 @emit_expr(ptr %t0, ptr %t643)
  br label %L111
L111:
  %t645 = load ptr, ptr %t0
  %t646 = getelementptr [18 x i8], ptr @.str263, i64 0, i64 0
  %t647 = load i64, ptr %t565
  call void @__c0c_emit(ptr %t645, ptr %t646, i64 %t647)
  %t649 = load ptr, ptr %t0
  %t650 = getelementptr [6 x i8], ptr @.str264, i64 0, i64 0
  %t651 = load i64, ptr %t574
  call void @__c0c_emit(ptr %t649, ptr %t650, i64 %t651)
  call void @scope_pop(ptr %t0)
  %t654 = load ptr, ptr %t0
  %t655 = load ptr, ptr %t577
  %t656 = call ptr @strcpy(ptr %t654, ptr %t655)
  %t657 = load ptr, ptr %t0
  %t658 = load ptr, ptr %t578
  %t659 = call ptr @strcpy(ptr %t657, ptr %t658)
  br label %L4
L112:
  br label %L13
L13:
  %t660 = load ptr, ptr %t0
  %t661 = getelementptr [17 x i8], ptr @.str265, i64 0, i64 0
  %t662 = load ptr, ptr %t0
  call void @__c0c_emit(ptr %t660, ptr %t661, ptr %t662)
  %t664 = alloca i64
  %t665 = call i32 @new_label(ptr %t0)
  %t666 = sext i32 %t665 to i64
  store i64 %t666, ptr %t664
  %t667 = load ptr, ptr %t0
  %t668 = getelementptr [6 x i8], ptr @.str266, i64 0, i64 0
  %t669 = load i64, ptr %t664
  call void @__c0c_emit(ptr %t667, ptr %t668, i64 %t669)
  br label %L4
L113:
  br label %L14
L14:
  %t671 = load ptr, ptr %t0
  %t672 = getelementptr [17 x i8], ptr @.str267, i64 0, i64 0
  %t673 = load ptr, ptr %t0
  call void @__c0c_emit(ptr %t671, ptr %t672, ptr %t673)
  %t675 = alloca i64
  %t676 = call i32 @new_label(ptr %t0)
  %t677 = sext i32 %t676 to i64
  store i64 %t677, ptr %t675
  %t678 = load ptr, ptr %t0
  %t679 = getelementptr [6 x i8], ptr @.str268, i64 0, i64 0
  %t680 = load i64, ptr %t675
  call void @__c0c_emit(ptr %t678, ptr %t679, i64 %t680)
  br label %L4
L114:
  br label %L15
L15:
  %t682 = alloca i64
  %t683 = load ptr, ptr %t1
  %t684 = call i64 @emit_expr(ptr %t0, ptr %t683)
  store i64 %t684, ptr %t682
  %t685 = alloca i64
  %t686 = call i32 @new_label(ptr %t0)
  %t687 = sext i32 %t686 to i64
  store i64 %t687, ptr %t685
  %t688 = alloca ptr
  %t689 = load ptr, ptr %t688
  %t690 = load ptr, ptr %t0
  %t691 = call ptr @strcpy(ptr %t689, ptr %t690)
  %t692 = load ptr, ptr %t0
  %t693 = getelementptr [4 x i8], ptr @.str269, i64 0, i64 0
  %t694 = load i64, ptr %t685
  %t695 = call i32 @snprintf(ptr %t692, i64 64, ptr %t693, i64 %t694)
  %t696 = sext i32 %t695 to i64
  %t697 = alloca ptr
  %t698 = load ptr, ptr %t1
  store ptr %t698, ptr %t697
  %t699 = alloca i64
  %t700 = sext i32 0 to i64
  store i64 %t700, ptr %t699
  %t701 = alloca ptr
  %t702 = alloca ptr
  %t703 = alloca i64
  %t704 = load i64, ptr %t685
  store i64 %t704, ptr %t703
  %t705 = alloca i64
  %t706 = sext i32 0 to i64
  store i64 %t706, ptr %t705
  br label %L115
L115:
  %t707 = load i64, ptr %t705
  %t708 = load ptr, ptr %t697
  %t709 = load ptr, ptr %t708
  %t711 = ptrtoint ptr %t709 to i64
  %t710 = icmp slt i64 %t707, %t711
  %t712 = zext i1 %t710 to i64
  %t713 = load i64, ptr %t699
  %t715 = sext i32 256 to i64
  %t714 = icmp slt i64 %t713, %t715
  %t716 = zext i1 %t714 to i64
  %t718 = icmp ne i64 %t712, 0
  %t719 = icmp ne i64 %t716, 0
  %t720 = and i1 %t718, %t719
  %t721 = zext i1 %t720 to i64
  %t722 = icmp ne i64 %t721, 0
  br i1 %t722, label %L116, label %L118
L116:
  %t723 = alloca ptr
  %t724 = load ptr, ptr %t697
  %t725 = load ptr, ptr %t724
  %t726 = load i64, ptr %t705
  %t727 = getelementptr i32, ptr %t725, i64 %t726
  %t728 = load i64, ptr %t727
  store i64 %t728, ptr %t723
  %t729 = load ptr, ptr %t723
  %t730 = load ptr, ptr %t729
  %t732 = ptrtoint ptr %t730 to i64
  %t733 = sext i32 14 to i64
  %t731 = icmp eq i64 %t732, %t733
  %t734 = zext i1 %t731 to i64
  %t735 = icmp ne i64 %t734, 0
  br i1 %t735, label %L119, label %L120
L119:
  %t736 = call i32 @new_label(ptr %t0)
  %t737 = sext i32 %t736 to i64
  %t738 = load ptr, ptr %t701
  %t739 = load i64, ptr %t699
  %t740 = getelementptr i8, ptr %t738, i64 %t739
  store i64 %t737, ptr %t740
  %t741 = load ptr, ptr %t723
  %t742 = load ptr, ptr %t741
  %t743 = icmp ne ptr %t742, null
  br i1 %t743, label %L122, label %L123
L122:
  %t744 = load ptr, ptr %t723
  %t745 = load ptr, ptr %t744
  %t746 = load ptr, ptr %t745
  %t747 = ptrtoint ptr %t746 to i64
  br label %L124
L123:
  %t748 = sext i32 0 to i64
  br label %L124
L124:
  %t749 = phi i64 [ %t747, %L122 ], [ %t748, %L123 ]
  %t750 = load ptr, ptr %t702
  %t751 = load i64, ptr %t699
  %t752 = getelementptr i8, ptr %t750, i64 %t751
  store i64 %t749, ptr %t752
  %t753 = load i64, ptr %t699
  %t754 = add i64 %t753, 1
  store i64 %t754, ptr %t699
  br label %L121
L120:
  %t755 = load ptr, ptr %t723
  %t756 = load ptr, ptr %t755
  %t758 = ptrtoint ptr %t756 to i64
  %t759 = sext i32 15 to i64
  %t757 = icmp eq i64 %t758, %t759
  %t760 = zext i1 %t757 to i64
  %t761 = icmp ne i64 %t760, 0
  br i1 %t761, label %L125, label %L127
L125:
  %t762 = call i32 @new_label(ptr %t0)
  %t763 = sext i32 %t762 to i64
  store i64 %t763, ptr %t703
  br label %L127
L127:
  br label %L121
L121:
  br label %L117
L117:
  %t764 = load i64, ptr %t705
  %t765 = add i64 %t764, 1
  store i64 %t765, ptr %t705
  br label %L115
L118:
  %t766 = alloca ptr
  %t767 = load i64, ptr %t682
  %t768 = load ptr, ptr %t766
  %t769 = call i32 @promote_to_i64(ptr %t0, i64 %t767, ptr %t768, i64 64)
  %t770 = sext i32 %t769 to i64
  %t771 = alloca i64
  %t772 = call i32 @new_reg(ptr %t0)
  %t773 = sext i32 %t772 to i64
  store i64 %t773, ptr %t771
  %t774 = load ptr, ptr %t0
  %t775 = getelementptr [25 x i8], ptr @.str270, i64 0, i64 0
  %t776 = load i64, ptr %t771
  %t777 = load ptr, ptr %t766
  call void @__c0c_emit(ptr %t774, ptr %t775, i64 %t776, ptr %t777)
  %t779 = load ptr, ptr %t0
  %t780 = getelementptr [35 x i8], ptr @.str271, i64 0, i64 0
  %t781 = load i64, ptr %t771
  %t782 = load i64, ptr %t703
  call void @__c0c_emit(ptr %t779, ptr %t780, i64 %t781, i64 %t782)
  %t784 = alloca i64
  %t785 = sext i32 0 to i64
  store i64 %t785, ptr %t784
  %t786 = alloca i64
  %t787 = sext i32 0 to i64
  store i64 %t787, ptr %t786
  br label %L128
L128:
  %t788 = load i64, ptr %t786
  %t789 = load ptr, ptr %t697
  %t790 = load ptr, ptr %t789
  %t792 = ptrtoint ptr %t790 to i64
  %t791 = icmp slt i64 %t788, %t792
  %t793 = zext i1 %t791 to i64
  %t794 = icmp ne i64 %t793, 0
  br i1 %t794, label %L129, label %L131
L129:
  %t795 = alloca ptr
  %t796 = load ptr, ptr %t697
  %t797 = load ptr, ptr %t796
  %t798 = load i64, ptr %t786
  %t799 = getelementptr i32, ptr %t797, i64 %t798
  %t800 = load i64, ptr %t799
  store i64 %t800, ptr %t795
  %t801 = load ptr, ptr %t795
  %t802 = load ptr, ptr %t801
  %t804 = ptrtoint ptr %t802 to i64
  %t805 = sext i32 14 to i64
  %t803 = icmp eq i64 %t804, %t805
  %t806 = zext i1 %t803 to i64
  %t807 = load i64, ptr %t784
  %t808 = load i64, ptr %t699
  %t809 = icmp slt i64 %t807, %t808
  %t810 = zext i1 %t809 to i64
  %t812 = icmp ne i64 %t806, 0
  %t813 = icmp ne i64 %t810, 0
  %t814 = and i1 %t812, %t813
  %t815 = zext i1 %t814 to i64
  %t816 = icmp ne i64 %t815, 0
  br i1 %t816, label %L132, label %L134
L132:
  %t817 = load ptr, ptr %t0
  %t818 = getelementptr [27 x i8], ptr @.str272, i64 0, i64 0
  %t819 = load ptr, ptr %t702
  %t820 = load i64, ptr %t784
  %t821 = getelementptr i32, ptr %t819, i64 %t820
  %t822 = load i64, ptr %t821
  %t823 = load ptr, ptr %t701
  %t824 = load i64, ptr %t784
  %t825 = getelementptr i32, ptr %t823, i64 %t824
  %t826 = load i64, ptr %t825
  call void @__c0c_emit(ptr %t817, ptr %t818, i64 %t822, i64 %t826)
  %t828 = load i64, ptr %t784
  %t829 = add i64 %t828, 1
  store i64 %t829, ptr %t784
  br label %L134
L134:
  br label %L130
L130:
  %t830 = load i64, ptr %t786
  %t831 = add i64 %t830, 1
  store i64 %t831, ptr %t786
  br label %L128
L131:
  %t832 = load ptr, ptr %t0
  %t833 = getelementptr [5 x i8], ptr @.str273, i64 0, i64 0
  call void @__c0c_emit(ptr %t832, ptr %t833)
  %t835 = sext i32 0 to i64
  store i64 %t835, ptr %t784
  %t836 = alloca i64
  %t837 = sext i32 0 to i64
  store i64 %t837, ptr %t836
  %t838 = alloca i64
  %t839 = sext i32 0 to i64
  store i64 %t839, ptr %t838
  br label %L135
L135:
  %t840 = load i64, ptr %t838
  %t841 = load ptr, ptr %t697
  %t842 = load ptr, ptr %t841
  %t844 = ptrtoint ptr %t842 to i64
  %t843 = icmp slt i64 %t840, %t844
  %t845 = zext i1 %t843 to i64
  %t846 = icmp ne i64 %t845, 0
  br i1 %t846, label %L136, label %L138
L136:
  %t847 = alloca ptr
  %t848 = load ptr, ptr %t697
  %t849 = load ptr, ptr %t848
  %t850 = load i64, ptr %t838
  %t851 = getelementptr i32, ptr %t849, i64 %t850
  %t852 = load i64, ptr %t851
  store i64 %t852, ptr %t847
  %t853 = load ptr, ptr %t847
  %t854 = load ptr, ptr %t853
  %t856 = ptrtoint ptr %t854 to i64
  %t857 = sext i32 14 to i64
  %t855 = icmp eq i64 %t856, %t857
  %t858 = zext i1 %t855 to i64
  %t859 = load i64, ptr %t784
  %t860 = load i64, ptr %t699
  %t861 = icmp slt i64 %t859, %t860
  %t862 = zext i1 %t861 to i64
  %t864 = icmp ne i64 %t858, 0
  %t865 = icmp ne i64 %t862, 0
  %t866 = and i1 %t864, %t865
  %t867 = zext i1 %t866 to i64
  %t868 = icmp ne i64 %t867, 0
  br i1 %t868, label %L139, label %L140
L139:
  %t869 = load ptr, ptr %t0
  %t870 = getelementptr [6 x i8], ptr @.str274, i64 0, i64 0
  %t871 = load ptr, ptr %t701
  %t872 = load i64, ptr %t784
  %t873 = add i64 %t872, 1
  store i64 %t873, ptr %t784
  %t874 = getelementptr i32, ptr %t871, i64 %t872
  %t875 = load i64, ptr %t874
  call void @__c0c_emit(ptr %t869, ptr %t870, i64 %t875)
  %t877 = load ptr, ptr %t847
  %t878 = load ptr, ptr %t877
  %t880 = ptrtoint ptr %t878 to i64
  %t881 = sext i32 0 to i64
  %t879 = icmp sgt i64 %t880, %t881
  %t882 = zext i1 %t879 to i64
  %t883 = icmp ne i64 %t882, 0
  br i1 %t883, label %L142, label %L144
L142:
  %t884 = load ptr, ptr %t847
  %t885 = load ptr, ptr %t884
  %t886 = sext i32 0 to i64
  %t887 = getelementptr i32, ptr %t885, i64 %t886
  %t888 = load i64, ptr %t887
  call void @emit_stmt(ptr %t0, i64 %t888)
  br label %L144
L144:
  %t890 = alloca i64
  %t891 = load i64, ptr %t784
  %t892 = load i64, ptr %t699
  %t893 = icmp slt i64 %t891, %t892
  %t894 = zext i1 %t893 to i64
  %t895 = icmp ne i64 %t894, 0
  br i1 %t895, label %L145, label %L146
L145:
  %t896 = load ptr, ptr %t701
  %t897 = load i64, ptr %t784
  %t898 = getelementptr i32, ptr %t896, i64 %t897
  %t899 = load i64, ptr %t898
  br label %L147
L146:
  %t900 = load i64, ptr %t685
  br label %L147
L147:
  %t901 = phi i64 [ %t899, %L145 ], [ %t900, %L146 ]
  store i64 %t901, ptr %t890
  %t902 = load ptr, ptr %t0
  %t903 = getelementptr [18 x i8], ptr @.str275, i64 0, i64 0
  %t904 = load i64, ptr %t890
  call void @__c0c_emit(ptr %t902, ptr %t903, i64 %t904)
  br label %L141
L140:
  %t906 = load ptr, ptr %t847
  %t907 = load ptr, ptr %t906
  %t909 = ptrtoint ptr %t907 to i64
  %t910 = sext i32 15 to i64
  %t908 = icmp eq i64 %t909, %t910
  %t911 = zext i1 %t908 to i64
  %t912 = icmp ne i64 %t911, 0
  br i1 %t912, label %L148, label %L149
L148:
  %t913 = load ptr, ptr %t0
  %t914 = getelementptr [6 x i8], ptr @.str276, i64 0, i64 0
  %t915 = load i64, ptr %t703
  call void @__c0c_emit(ptr %t913, ptr %t914, i64 %t915)
  %t917 = load ptr, ptr %t847
  %t918 = load ptr, ptr %t917
  %t920 = ptrtoint ptr %t918 to i64
  %t921 = sext i32 0 to i64
  %t919 = icmp sgt i64 %t920, %t921
  %t922 = zext i1 %t919 to i64
  %t923 = icmp ne i64 %t922, 0
  br i1 %t923, label %L151, label %L153
L151:
  %t924 = load ptr, ptr %t847
  %t925 = load ptr, ptr %t924
  %t926 = sext i32 0 to i64
  %t927 = getelementptr i32, ptr %t925, i64 %t926
  %t928 = load i64, ptr %t927
  call void @emit_stmt(ptr %t0, i64 %t928)
  br label %L153
L153:
  %t930 = load ptr, ptr %t0
  %t931 = getelementptr [18 x i8], ptr @.str277, i64 0, i64 0
  %t932 = load i64, ptr %t685
  call void @__c0c_emit(ptr %t930, ptr %t931, i64 %t932)
  %t934 = load i64, ptr %t836
  %t935 = add i64 %t934, 1
  store i64 %t935, ptr %t836
  br label %L150
L149:
  %t936 = load ptr, ptr %t847
  call void @emit_stmt(ptr %t0, ptr %t936)
  br label %L150
L150:
  br label %L141
L141:
  br label %L137
L137:
  %t938 = load i64, ptr %t838
  %t939 = add i64 %t938, 1
  store i64 %t939, ptr %t838
  br label %L135
L138:
  %t940 = load ptr, ptr %t0
  %t941 = getelementptr [6 x i8], ptr @.str278, i64 0, i64 0
  %t942 = load i64, ptr %t685
  call void @__c0c_emit(ptr %t940, ptr %t941, i64 %t942)
  %t944 = load ptr, ptr %t0
  %t945 = load ptr, ptr %t688
  %t946 = call ptr @strcpy(ptr %t944, ptr %t945)
  br label %L4
L154:
  br label %L16
L16:
  %t947 = load ptr, ptr %t1
  %t949 = ptrtoint ptr %t947 to i64
  %t950 = sext i32 0 to i64
  %t948 = icmp sgt i64 %t949, %t950
  %t951 = zext i1 %t948 to i64
  %t952 = icmp ne i64 %t951, 0
  br i1 %t952, label %L155, label %L157
L155:
  %t953 = load ptr, ptr %t1
  %t954 = sext i32 0 to i64
  %t955 = getelementptr i32, ptr %t953, i64 %t954
  %t956 = load i64, ptr %t955
  call void @emit_stmt(ptr %t0, i64 %t956)
  br label %L157
L157:
  br label %L4
L158:
  br label %L17
L17:
  %t958 = load ptr, ptr %t1
  %t960 = ptrtoint ptr %t958 to i64
  %t961 = sext i32 0 to i64
  %t959 = icmp sgt i64 %t960, %t961
  %t962 = zext i1 %t959 to i64
  %t963 = icmp ne i64 %t962, 0
  br i1 %t963, label %L159, label %L161
L159:
  %t964 = load ptr, ptr %t1
  %t965 = sext i32 0 to i64
  %t966 = getelementptr i32, ptr %t964, i64 %t965
  %t967 = load i64, ptr %t966
  call void @emit_stmt(ptr %t0, i64 %t967)
  br label %L161
L161:
  br label %L4
L162:
  br label %L18
L18:
  %t969 = load ptr, ptr %t0
  %t970 = getelementptr [17 x i8], ptr @.str279, i64 0, i64 0
  %t971 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t969, ptr %t970, ptr %t971)
  %t973 = load ptr, ptr %t0
  %t974 = getelementptr [5 x i8], ptr @.str280, i64 0, i64 0
  %t975 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t973, ptr %t974, ptr %t975)
  %t977 = load ptr, ptr %t1
  %t979 = ptrtoint ptr %t977 to i64
  %t980 = sext i32 0 to i64
  %t978 = icmp sgt i64 %t979, %t980
  %t981 = zext i1 %t978 to i64
  %t982 = icmp ne i64 %t981, 0
  br i1 %t982, label %L163, label %L165
L163:
  %t983 = load ptr, ptr %t1
  %t984 = sext i32 0 to i64
  %t985 = getelementptr i32, ptr %t983, i64 %t984
  %t986 = load i64, ptr %t985
  call void @emit_stmt(ptr %t0, i64 %t986)
  br label %L165
L165:
  br label %L4
L166:
  br label %L19
L19:
  %t988 = load ptr, ptr %t0
  %t989 = getelementptr [17 x i8], ptr @.str281, i64 0, i64 0
  %t990 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t988, ptr %t989, ptr %t990)
  %t992 = alloca i64
  %t993 = call i32 @new_label(ptr %t0)
  %t994 = sext i32 %t993 to i64
  store i64 %t994, ptr %t992
  %t995 = load ptr, ptr %t0
  %t996 = getelementptr [6 x i8], ptr @.str282, i64 0, i64 0
  %t997 = load i64, ptr %t992
  call void @__c0c_emit(ptr %t995, ptr %t996, i64 %t997)
  br label %L4
L167:
  br label %L20
L20:
  br label %L4
L168:
  br label %L4
L21:
  %t999 = call i64 @emit_expr(ptr %t0, ptr %t1)
  br label %L4
L169:
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
  %t37 = getelementptr [5 x i8], ptr @.str283, i64 0, i64 0
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
  %t44 = getelementptr [9 x i8], ptr @.str284, i64 0, i64 0
  %t45 = ptrtoint ptr %t44 to i64
  br label %L12
L11:
  %t46 = getelementptr [10 x i8], ptr @.str285, i64 0, i64 0
  %t47 = ptrtoint ptr %t46 to i64
  br label %L12
L12:
  %t48 = phi i64 [ %t45, %L10 ], [ %t47, %L11 ]
  store i64 %t48, ptr %t41
  %t49 = load ptr, ptr %t0
  %t50 = getelementptr [18 x i8], ptr @.str286, i64 0, i64 0
  %t51 = load ptr, ptr %t41
  %t52 = load ptr, ptr %t2
  %t53 = call ptr @llvm_ret_type(ptr %t52)
  %t54 = load ptr, ptr %t1
  %t55 = icmp ne ptr %t54, null
  br i1 %t55, label %L13, label %L14
L13:
  %t56 = load ptr, ptr %t1
  %t57 = ptrtoint ptr %t56 to i64
  br label %L15
L14:
  %t58 = getelementptr [5 x i8], ptr @.str287, i64 0, i64 0
  %t59 = ptrtoint ptr %t58 to i64
  br label %L15
L15:
  %t60 = phi i64 [ %t57, %L13 ], [ %t59, %L14 ]
  call void @__c0c_emit(ptr %t49, ptr %t50, ptr %t51, ptr %t53, i64 %t60)
  call void @scope_push(ptr %t0)
  %t63 = alloca i64
  %t64 = sext i32 0 to i64
  store i64 %t64, ptr %t63
  %t65 = alloca i64
  %t66 = sext i32 0 to i64
  store i64 %t66, ptr %t65
  br label %L16
L16:
  %t67 = load i64, ptr %t65
  %t68 = load ptr, ptr %t2
  %t69 = load ptr, ptr %t68
  %t71 = ptrtoint ptr %t69 to i64
  %t70 = icmp slt i64 %t67, %t71
  %t72 = zext i1 %t70 to i64
  %t73 = icmp ne i64 %t72, 0
  br i1 %t73, label %L17, label %L19
L17:
  %t74 = alloca ptr
  %t75 = load ptr, ptr %t2
  %t76 = load ptr, ptr %t75
  %t77 = load i64, ptr %t65
  %t78 = getelementptr i8, ptr %t76, i64 %t77
  %t79 = load ptr, ptr %t78
  store ptr %t79, ptr %t74
  %t80 = load ptr, ptr %t74
  %t81 = load ptr, ptr %t74
  %t82 = load ptr, ptr %t81
  %t84 = ptrtoint ptr %t82 to i64
  %t85 = sext i32 0 to i64
  %t83 = icmp eq i64 %t84, %t85
  %t86 = zext i1 %t83 to i64
  %t88 = ptrtoint ptr %t80 to i64
  %t92 = ptrtoint ptr %t80 to i64
  %t89 = icmp ne i64 %t92, 0
  %t90 = icmp ne i64 %t86, 0
  %t91 = and i1 %t89, %t90
  %t93 = zext i1 %t91 to i64
  %t94 = load ptr, ptr %t2
  %t95 = load ptr, ptr %t94
  %t97 = ptrtoint ptr %t95 to i64
  %t98 = sext i32 1 to i64
  %t96 = icmp eq i64 %t97, %t98
  %t99 = zext i1 %t96 to i64
  %t101 = icmp ne i64 %t93, 0
  %t102 = icmp ne i64 %t99, 0
  %t103 = and i1 %t101, %t102
  %t104 = zext i1 %t103 to i64
  %t105 = icmp ne i64 %t104, 0
  br i1 %t105, label %L20, label %L22
L20:
  br label %L19
L23:
  br label %L22
L22:
  %t106 = load i64, ptr %t63
  %t107 = icmp ne i64 %t106, 0
  br i1 %t107, label %L24, label %L26
L24:
  %t108 = load ptr, ptr %t0
  %t109 = getelementptr [3 x i8], ptr @.str288, i64 0, i64 0
  call void @__c0c_emit(ptr %t108, ptr %t109)
  br label %L26
L26:
  %t111 = alloca ptr
  %t112 = alloca ptr
  %t113 = load ptr, ptr %t74
  %t115 = ptrtoint ptr %t113 to i64
  %t116 = icmp eq i64 %t115, 0
  %t114 = zext i1 %t116 to i64
  %t117 = load ptr, ptr %t74
  %t118 = call i32 @type_is_fp(ptr %t117)
  %t119 = sext i32 %t118 to i64
  %t121 = icmp ne i64 %t114, 0
  %t122 = icmp ne i64 %t119, 0
  %t123 = or i1 %t121, %t122
  %t124 = zext i1 %t123 to i64
  %t125 = icmp ne i64 %t124, 0
  br i1 %t125, label %L27, label %L28
L27:
  %t126 = load ptr, ptr %t74
  %t127 = icmp ne ptr %t126, null
  br i1 %t127, label %L30, label %L31
L30:
  %t128 = load ptr, ptr %t74
  %t129 = call ptr @llvm_type(ptr %t128)
  %t130 = ptrtoint ptr %t129 to i64
  br label %L32
L31:
  %t131 = getelementptr [4 x i8], ptr @.str289, i64 0, i64 0
  %t132 = ptrtoint ptr %t131 to i64
  br label %L32
L32:
  %t133 = phi i64 [ %t130, %L30 ], [ %t132, %L31 ]
  store i64 %t133, ptr %t111
  %t134 = load ptr, ptr %t74
  store ptr %t134, ptr %t112
  br label %L29
L28:
  %t135 = load ptr, ptr %t74
  %t136 = load ptr, ptr %t135
  %t138 = ptrtoint ptr %t136 to i64
  %t139 = sext i32 15 to i64
  %t137 = icmp eq i64 %t138, %t139
  %t140 = zext i1 %t137 to i64
  %t141 = load ptr, ptr %t74
  %t142 = load ptr, ptr %t141
  %t144 = ptrtoint ptr %t142 to i64
  %t145 = sext i32 16 to i64
  %t143 = icmp eq i64 %t144, %t145
  %t146 = zext i1 %t143 to i64
  %t148 = icmp ne i64 %t140, 0
  %t149 = icmp ne i64 %t146, 0
  %t150 = or i1 %t148, %t149
  %t151 = zext i1 %t150 to i64
  %t152 = icmp ne i64 %t151, 0
  br i1 %t152, label %L33, label %L34
L33:
  %t153 = getelementptr [4 x i8], ptr @.str290, i64 0, i64 0
  store ptr %t153, ptr %t111
  %t154 = call ptr @default_ptr_type()
  store ptr %t154, ptr %t112
  br label %L35
L34:
  %t155 = load ptr, ptr %t74
  %t156 = load ptr, ptr %t155
  %t158 = ptrtoint ptr %t156 to i64
  %t159 = sext i32 18 to i64
  %t157 = icmp eq i64 %t158, %t159
  %t160 = zext i1 %t157 to i64
  %t161 = load ptr, ptr %t74
  %t162 = load ptr, ptr %t161
  %t164 = ptrtoint ptr %t162 to i64
  %t165 = sext i32 19 to i64
  %t163 = icmp eq i64 %t164, %t165
  %t166 = zext i1 %t163 to i64
  %t168 = icmp ne i64 %t160, 0
  %t169 = icmp ne i64 %t166, 0
  %t170 = or i1 %t168, %t169
  %t171 = zext i1 %t170 to i64
  %t172 = load ptr, ptr %t74
  %t173 = load ptr, ptr %t172
  %t175 = ptrtoint ptr %t173 to i64
  %t176 = sext i32 21 to i64
  %t174 = icmp eq i64 %t175, %t176
  %t177 = zext i1 %t174 to i64
  %t179 = icmp ne i64 %t171, 0
  %t180 = icmp ne i64 %t177, 0
  %t181 = or i1 %t179, %t180
  %t182 = zext i1 %t181 to i64
  %t183 = icmp ne i64 %t182, 0
  br i1 %t183, label %L36, label %L37
L36:
  %t184 = getelementptr [4 x i8], ptr @.str291, i64 0, i64 0
  store ptr %t184, ptr %t111
  %t185 = call ptr @default_ptr_type()
  store ptr %t185, ptr %t112
  br label %L38
L37:
  %t186 = getelementptr [4 x i8], ptr @.str292, i64 0, i64 0
  store ptr %t186, ptr %t111
  %t187 = call ptr @default_i64_type()
  store ptr %t187, ptr %t112
  br label %L38
L38:
  br label %L35
L35:
  br label %L29
L29:
  %t188 = alloca i64
  %t189 = call i32 @new_reg(ptr %t0)
  %t190 = sext i32 %t189 to i64
  store i64 %t190, ptr %t188
  %t191 = load ptr, ptr %t0
  %t192 = getelementptr [9 x i8], ptr @.str293, i64 0, i64 0
  %t193 = load ptr, ptr %t111
  %t194 = load i64, ptr %t188
  call void @__c0c_emit(ptr %t191, ptr %t192, ptr %t193, i64 %t194)
  %t196 = load i64, ptr %t63
  %t197 = add i64 %t196, 1
  store i64 %t197, ptr %t63
  %t198 = load ptr, ptr %t1
  %t199 = load ptr, ptr %t1
  %t200 = load i64, ptr %t65
  %t201 = getelementptr i32, ptr %t199, i64 %t200
  %t202 = load i64, ptr %t201
  %t204 = ptrtoint ptr %t198 to i64
  %t208 = ptrtoint ptr %t198 to i64
  %t205 = icmp ne i64 %t208, 0
  %t206 = icmp ne i64 %t202, 0
  %t207 = and i1 %t205, %t206
  %t209 = zext i1 %t207 to i64
  %t210 = icmp ne i64 %t209, 0
  br i1 %t210, label %L39, label %L41
L39:
  %t211 = load ptr, ptr %t0
  %t213 = ptrtoint ptr %t211 to i64
  %t214 = sext i32 2048 to i64
  %t212 = icmp sge i64 %t213, %t214
  %t215 = zext i1 %t212 to i64
  %t216 = icmp ne i64 %t215, 0
  br i1 %t216, label %L42, label %L44
L42:
  %t217 = call ptr @__c0c_stderr()
  %t218 = getelementptr [22 x i8], ptr @.str294, i64 0, i64 0
  %t219 = call i32 @fprintf(ptr %t217, ptr %t218)
  %t220 = sext i32 %t219 to i64
  call void @exit(i64 1)
  br label %L44
L44:
  %t222 = alloca ptr
  %t223 = load ptr, ptr %t0
  %t224 = load ptr, ptr %t0
  %t226 = ptrtoint ptr %t224 to i64
  %t225 = add i64 %t226, 1
  store i64 %t225, ptr %t0
  %t228 = ptrtoint ptr %t224 to i64
  %t227 = getelementptr i8, ptr %t223, i64 %t228
  store ptr %t227, ptr %t222
  %t229 = load ptr, ptr %t1
  %t230 = load i64, ptr %t65
  %t231 = getelementptr i32, ptr %t229, i64 %t230
  %t232 = load i64, ptr %t231
  %t233 = call ptr @strdup(i64 %t232)
  %t234 = load ptr, ptr %t222
  store ptr %t233, ptr %t234
  %t235 = call ptr @malloc(i64 32)
  %t236 = load ptr, ptr %t222
  store ptr %t235, ptr %t236
  %t237 = load ptr, ptr %t222
  %t238 = load ptr, ptr %t237
  %t239 = getelementptr [6 x i8], ptr @.str295, i64 0, i64 0
  %t240 = load i64, ptr %t188
  %t241 = call i32 @snprintf(ptr %t238, i64 32, ptr %t239, i64 %t240)
  %t242 = sext i32 %t241 to i64
  %t243 = load ptr, ptr %t112
  %t244 = load ptr, ptr %t222
  store ptr %t243, ptr %t244
  %t245 = load ptr, ptr %t222
  %t246 = sext i32 1 to i64
  store i64 %t246, ptr %t245
  br label %L41
L41:
  br label %L18
L18:
  %t247 = load i64, ptr %t65
  %t248 = add i64 %t247, 1
  store i64 %t248, ptr %t65
  br label %L16
L19:
  %t249 = load ptr, ptr %t2
  %t250 = load ptr, ptr %t249
  %t251 = icmp ne ptr %t250, null
  br i1 %t251, label %L45, label %L47
L45:
  %t252 = load i64, ptr %t63
  %t253 = icmp ne i64 %t252, 0
  br i1 %t253, label %L48, label %L50
L48:
  %t254 = load ptr, ptr %t0
  %t255 = getelementptr [3 x i8], ptr @.str296, i64 0, i64 0
  call void @__c0c_emit(ptr %t254, ptr %t255)
  br label %L50
L50:
  %t257 = load ptr, ptr %t0
  %t258 = getelementptr [4 x i8], ptr @.str297, i64 0, i64 0
  call void @__c0c_emit(ptr %t257, ptr %t258)
  br label %L47
L47:
  %t260 = load ptr, ptr %t0
  %t261 = getelementptr [5 x i8], ptr @.str298, i64 0, i64 0
  call void @__c0c_emit(ptr %t260, ptr %t261)
  %t263 = load ptr, ptr %t0
  %t264 = getelementptr [8 x i8], ptr @.str299, i64 0, i64 0
  call void @__c0c_emit(ptr %t263, ptr %t264)
  %t266 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t266)
  %t268 = load ptr, ptr %t2
  %t269 = load ptr, ptr %t268
  %t271 = ptrtoint ptr %t269 to i64
  %t272 = icmp eq i64 %t271, 0
  %t270 = zext i1 %t272 to i64
  %t273 = load ptr, ptr %t2
  %t274 = load ptr, ptr %t273
  %t275 = load ptr, ptr %t274
  %t277 = ptrtoint ptr %t275 to i64
  %t278 = sext i32 0 to i64
  %t276 = icmp eq i64 %t277, %t278
  %t279 = zext i1 %t276 to i64
  %t281 = icmp ne i64 %t270, 0
  %t282 = icmp ne i64 %t279, 0
  %t283 = or i1 %t281, %t282
  %t284 = zext i1 %t283 to i64
  %t285 = icmp ne i64 %t284, 0
  br i1 %t285, label %L51, label %L52
L51:
  %t286 = load ptr, ptr %t0
  %t287 = getelementptr [12 x i8], ptr @.str300, i64 0, i64 0
  call void @__c0c_emit(ptr %t286, ptr %t287)
  br label %L53
L52:
  %t289 = load ptr, ptr %t2
  %t290 = load ptr, ptr %t289
  %t291 = load ptr, ptr %t290
  %t293 = ptrtoint ptr %t291 to i64
  %t294 = sext i32 15 to i64
  %t292 = icmp eq i64 %t293, %t294
  %t295 = zext i1 %t292 to i64
  %t296 = load ptr, ptr %t2
  %t297 = load ptr, ptr %t296
  %t298 = load ptr, ptr %t297
  %t300 = ptrtoint ptr %t298 to i64
  %t301 = sext i32 16 to i64
  %t299 = icmp eq i64 %t300, %t301
  %t302 = zext i1 %t299 to i64
  %t304 = icmp ne i64 %t295, 0
  %t305 = icmp ne i64 %t302, 0
  %t306 = or i1 %t304, %t305
  %t307 = zext i1 %t306 to i64
  %t308 = icmp ne i64 %t307, 0
  br i1 %t308, label %L54, label %L55
L54:
  %t309 = load ptr, ptr %t0
  %t310 = getelementptr [16 x i8], ptr @.str301, i64 0, i64 0
  call void @__c0c_emit(ptr %t309, ptr %t310)
  br label %L56
L55:
  %t312 = load ptr, ptr %t2
  %t313 = load ptr, ptr %t312
  %t314 = call i32 @type_is_fp(ptr %t313)
  %t315 = sext i32 %t314 to i64
  %t316 = icmp ne i64 %t315, 0
  br i1 %t316, label %L57, label %L58
L57:
  %t317 = load ptr, ptr %t0
  %t318 = getelementptr [14 x i8], ptr @.str302, i64 0, i64 0
  %t319 = load ptr, ptr %t2
  %t320 = load ptr, ptr %t319
  %t321 = call ptr @llvm_type(ptr %t320)
  call void @__c0c_emit(ptr %t317, ptr %t318, ptr %t321)
  br label %L59
L58:
  %t323 = alloca ptr
  %t324 = load ptr, ptr %t2
  %t325 = load ptr, ptr %t324
  %t326 = call ptr @llvm_type(ptr %t325)
  store ptr %t326, ptr %t323
  %t327 = load ptr, ptr %t323
  %t328 = getelementptr [3 x i8], ptr @.str303, i64 0, i64 0
  %t329 = call i32 @strcmp(ptr %t327, ptr %t328)
  %t330 = sext i32 %t329 to i64
  %t332 = sext i32 0 to i64
  %t331 = icmp eq i64 %t330, %t332
  %t333 = zext i1 %t331 to i64
  %t334 = icmp ne i64 %t333, 0
  br i1 %t334, label %L60, label %L61
L60:
  %t335 = load ptr, ptr %t0
  %t336 = getelementptr [12 x i8], ptr @.str304, i64 0, i64 0
  call void @__c0c_emit(ptr %t335, ptr %t336)
  br label %L62
L61:
  %t338 = load ptr, ptr %t323
  %t339 = getelementptr [4 x i8], ptr @.str305, i64 0, i64 0
  %t340 = call i32 @strcmp(ptr %t338, ptr %t339)
  %t341 = sext i32 %t340 to i64
  %t343 = sext i32 0 to i64
  %t342 = icmp eq i64 %t341, %t343
  %t344 = zext i1 %t342 to i64
  %t345 = icmp ne i64 %t344, 0
  br i1 %t345, label %L63, label %L64
L63:
  %t346 = load ptr, ptr %t0
  %t347 = getelementptr [13 x i8], ptr @.str306, i64 0, i64 0
  call void @__c0c_emit(ptr %t346, ptr %t347)
  br label %L65
L64:
  %t349 = load ptr, ptr %t323
  %t350 = getelementptr [4 x i8], ptr @.str307, i64 0, i64 0
  %t351 = call i32 @strcmp(ptr %t349, ptr %t350)
  %t352 = sext i32 %t351 to i64
  %t354 = sext i32 0 to i64
  %t353 = icmp eq i64 %t352, %t354
  %t355 = zext i1 %t353 to i64
  %t356 = icmp ne i64 %t355, 0
  br i1 %t356, label %L66, label %L67
L66:
  %t357 = load ptr, ptr %t0
  %t358 = getelementptr [13 x i8], ptr @.str308, i64 0, i64 0
  call void @__c0c_emit(ptr %t357, ptr %t358)
  br label %L68
L67:
  %t360 = load ptr, ptr %t0
  %t361 = getelementptr [13 x i8], ptr @.str309, i64 0, i64 0
  call void @__c0c_emit(ptr %t360, ptr %t361)
  br label %L68
L68:
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
  %t363 = load ptr, ptr %t0
  %t364 = getelementptr [4 x i8], ptr @.str310, i64 0, i64 0
  call void @__c0c_emit(ptr %t363, ptr %t364)
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
  %t140 = getelementptr [3 x i8], ptr @.str311, i64 0, i64 0
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
  %t163 = getelementptr [4 x i8], ptr @.str312, i64 0, i64 0
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
  %t184 = getelementptr [4 x i8], ptr @.str313, i64 0, i64 0
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
  %t214 = getelementptr [4 x i8], ptr @.str314, i64 0, i64 0
  store ptr %t214, ptr %t144
  br label %L44
L43:
  %t215 = getelementptr [4 x i8], ptr @.str315, i64 0, i64 0
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
  %t225 = getelementptr [3 x i8], ptr @.str316, i64 0, i64 0
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
  %t247 = getelementptr [3 x i8], ptr @.str317, i64 0, i64 0
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
  %t260 = getelementptr [4 x i8], ptr @.str318, i64 0, i64 0
  %t261 = call i32 @snprintf(ptr %t254, i64 %t258, ptr %t260)
  %t262 = sext i32 %t261 to i64
  %t263 = add i64 %t251, %t262
  store i64 %t263, ptr %t77
  br label %L47
L47:
  %t264 = load ptr, ptr %t0
  %t265 = getelementptr [20 x i8], ptr @.str319, i64 0, i64 0
  %t266 = load ptr, ptr %t7
  %t267 = call ptr @llvm_ret_type(ptr %t266)
  %t268 = load ptr, ptr %t1
  %t269 = load ptr, ptr %t75
  call void @__c0c_emit(ptr %t264, ptr %t265, ptr %t267, ptr %t268, ptr %t269)
  ret void
L51:
  br label %L6
L6:
  %t271 = alloca i64
  %t272 = sext i32 0 to i64
  store i64 %t272, ptr %t271
  %t273 = alloca i64
  %t274 = sext i32 0 to i64
  store i64 %t274, ptr %t273
  br label %L52
L52:
  %t275 = load i64, ptr %t273
  %t276 = load ptr, ptr %t0
  %t278 = ptrtoint ptr %t276 to i64
  %t277 = icmp slt i64 %t275, %t278
  %t279 = zext i1 %t277 to i64
  %t280 = icmp ne i64 %t279, 0
  br i1 %t280, label %L53, label %L55
L53:
  %t281 = load ptr, ptr %t0
  %t282 = load i64, ptr %t273
  %t283 = getelementptr i8, ptr %t281, i64 %t282
  %t284 = load ptr, ptr %t283
  %t285 = load ptr, ptr %t1
  %t286 = call i32 @strcmp(ptr %t284, ptr %t285)
  %t287 = sext i32 %t286 to i64
  %t289 = sext i32 0 to i64
  %t288 = icmp eq i64 %t287, %t289
  %t290 = zext i1 %t288 to i64
  %t291 = icmp ne i64 %t290, 0
  br i1 %t291, label %L56, label %L58
L56:
  %t292 = sext i32 1 to i64
  store i64 %t292, ptr %t271
  br label %L55
L59:
  br label %L58
L58:
  br label %L54
L54:
  %t293 = load i64, ptr %t273
  %t294 = add i64 %t293, 1
  store i64 %t294, ptr %t273
  br label %L52
L55:
  %t295 = load i64, ptr %t271
  %t297 = icmp eq i64 %t295, 0
  %t296 = zext i1 %t297 to i64
  %t298 = load ptr, ptr %t0
  %t300 = ptrtoint ptr %t298 to i64
  %t301 = sext i32 2048 to i64
  %t299 = icmp slt i64 %t300, %t301
  %t302 = zext i1 %t299 to i64
  %t304 = icmp ne i64 %t296, 0
  %t305 = icmp ne i64 %t302, 0
  %t306 = and i1 %t304, %t305
  %t307 = zext i1 %t306 to i64
  %t308 = icmp ne i64 %t307, 0
  br i1 %t308, label %L60, label %L62
L60:
  %t309 = load ptr, ptr %t1
  %t310 = call ptr @strdup(ptr %t309)
  %t311 = load ptr, ptr %t0
  %t312 = load ptr, ptr %t0
  %t314 = ptrtoint ptr %t312 to i64
  %t313 = getelementptr i8, ptr %t311, i64 %t314
  store ptr %t310, ptr %t313
  %t315 = load ptr, ptr %t7
  %t316 = load ptr, ptr %t0
  %t317 = load ptr, ptr %t0
  %t319 = ptrtoint ptr %t317 to i64
  %t318 = getelementptr i8, ptr %t316, i64 %t319
  store ptr %t315, ptr %t318
  %t320 = load ptr, ptr %t1
  %t321 = load ptr, ptr %t0
  %t322 = load ptr, ptr %t0
  %t324 = ptrtoint ptr %t322 to i64
  %t323 = getelementptr i8, ptr %t321, i64 %t324
  store ptr %t320, ptr %t323
  %t325 = load ptr, ptr %t0
  %t327 = ptrtoint ptr %t325 to i64
  %t326 = add i64 %t327, 1
  store i64 %t326, ptr %t0
  br label %L62
L62:
  %t328 = load ptr, ptr %t1
  %t329 = icmp ne ptr %t328, null
  br i1 %t329, label %L63, label %L65
L63:
  %t330 = load ptr, ptr %t0
  %t331 = getelementptr [26 x i8], ptr @.str320, i64 0, i64 0
  %t332 = load ptr, ptr %t1
  %t333 = load ptr, ptr %t7
  %t334 = call ptr @llvm_type(ptr %t333)
  call void @__c0c_emit(ptr %t330, ptr %t331, ptr %t332, ptr %t334)
  ret void
L66:
  br label %L65
L65:
  %t336 = alloca ptr
  %t337 = load ptr, ptr %t1
  %t338 = icmp ne ptr %t337, null
  br i1 %t338, label %L67, label %L68
L67:
  %t339 = getelementptr [9 x i8], ptr @.str321, i64 0, i64 0
  %t340 = ptrtoint ptr %t339 to i64
  br label %L69
L68:
  %t341 = getelementptr [10 x i8], ptr @.str322, i64 0, i64 0
  %t342 = ptrtoint ptr %t341 to i64
  br label %L69
L69:
  %t343 = phi i64 [ %t340, %L67 ], [ %t342, %L68 ]
  store i64 %t343, ptr %t336
  %t344 = alloca ptr
  %t345 = load ptr, ptr %t7
  %t346 = call ptr @llvm_type(ptr %t345)
  store ptr %t346, ptr %t344
  %t347 = load ptr, ptr %t0
  %t348 = getelementptr [36 x i8], ptr @.str323, i64 0, i64 0
  %t349 = load ptr, ptr %t1
  %t350 = load ptr, ptr %t336
  %t351 = load ptr, ptr %t344
  call void @__c0c_emit(ptr %t347, ptr %t348, ptr %t349, ptr %t350, ptr %t351)
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
  %t9 = getelementptr [7 x i8], ptr @.str324, i64 0, i64 0
  call void @perror(ptr %t9)
  call void @exit(i64 1)
  br label %L2
L2:
  %t12 = load ptr, ptr %t2
  store ptr %t0, ptr %t12
  %t13 = load ptr, ptr %t2
  store ptr %t1, ptr %t13
  %t14 = load ptr, ptr %t2
  ret ptr %t14
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
  call void @free(ptr %t12)
  br label %L2
L2:
  %t14 = load i64, ptr %t1
  %t15 = add i64 %t14, 1
  store i64 %t15, ptr %t1
  br label %L0
L3:
  %t16 = alloca i64
  %t17 = sext i32 0 to i64
  store i64 %t17, ptr %t16
  br label %L4
L4:
  %t18 = load i64, ptr %t16
  %t19 = load ptr, ptr %t0
  %t21 = ptrtoint ptr %t19 to i64
  %t20 = icmp slt i64 %t18, %t21
  %t22 = zext i1 %t20 to i64
  %t23 = icmp ne i64 %t22, 0
  br i1 %t23, label %L5, label %L7
L5:
  %t24 = load ptr, ptr %t0
  %t25 = load i64, ptr %t16
  %t26 = getelementptr i32, ptr %t24, i64 %t25
  %t27 = load i64, ptr %t26
  call void @free(i64 %t27)
  br label %L6
L6:
  %t29 = load i64, ptr %t16
  %t30 = add i64 %t29, 1
  store i64 %t30, ptr %t16
  br label %L4
L7:
  call void @free(ptr %t0)
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
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr [19 x i8], ptr @.str325, i64 0, i64 0
  %t8 = load ptr, ptr %t0
  call void @__c0c_emit(ptr %t6, ptr %t7, ptr %t8)
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr [24 x i8], ptr @.str326, i64 0, i64 0
  %t12 = load ptr, ptr %t0
  call void @__c0c_emit(ptr %t10, ptr %t11, ptr %t12)
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr [94 x i8], ptr @.str327, i64 0, i64 0
  call void @__c0c_emit(ptr %t14, ptr %t15)
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr [45 x i8], ptr @.str328, i64 0, i64 0
  call void @__c0c_emit(ptr %t17, ptr %t18)
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr [23 x i8], ptr @.str329, i64 0, i64 0
  call void @__c0c_emit(ptr %t20, ptr %t21)
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr [26 x i8], ptr @.str330, i64 0, i64 0
  call void @__c0c_emit(ptr %t23, ptr %t24)
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr [31 x i8], ptr @.str331, i64 0, i64 0
  call void @__c0c_emit(ptr %t26, ptr %t27)
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr [32 x i8], ptr @.str332, i64 0, i64 0
  call void @__c0c_emit(ptr %t29, ptr %t30)
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr [25 x i8], ptr @.str333, i64 0, i64 0
  call void @__c0c_emit(ptr %t32, ptr %t33)
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr [26 x i8], ptr @.str334, i64 0, i64 0
  call void @__c0c_emit(ptr %t35, ptr %t36)
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr [26 x i8], ptr @.str335, i64 0, i64 0
  call void @__c0c_emit(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr [32 x i8], ptr @.str336, i64 0, i64 0
  call void @__c0c_emit(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr [31 x i8], ptr @.str337, i64 0, i64 0
  call void @__c0c_emit(ptr %t44, ptr %t45)
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr [37 x i8], ptr @.str338, i64 0, i64 0
  call void @__c0c_emit(ptr %t47, ptr %t48)
  %t50 = load ptr, ptr %t0
  %t51 = getelementptr [31 x i8], ptr @.str339, i64 0, i64 0
  call void @__c0c_emit(ptr %t50, ptr %t51)
  %t53 = load ptr, ptr %t0
  %t54 = getelementptr [31 x i8], ptr @.str340, i64 0, i64 0
  call void @__c0c_emit(ptr %t53, ptr %t54)
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr [31 x i8], ptr @.str341, i64 0, i64 0
  call void @__c0c_emit(ptr %t56, ptr %t57)
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr [31 x i8], ptr @.str342, i64 0, i64 0
  call void @__c0c_emit(ptr %t59, ptr %t60)
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr [37 x i8], ptr @.str343, i64 0, i64 0
  call void @__c0c_emit(ptr %t62, ptr %t63)
  %t65 = load ptr, ptr %t0
  %t66 = getelementptr [36 x i8], ptr @.str344, i64 0, i64 0
  call void @__c0c_emit(ptr %t65, ptr %t66)
  %t68 = load ptr, ptr %t0
  %t69 = getelementptr [36 x i8], ptr @.str345, i64 0, i64 0
  call void @__c0c_emit(ptr %t68, ptr %t69)
  %t71 = load ptr, ptr %t0
  %t72 = getelementptr [36 x i8], ptr @.str346, i64 0, i64 0
  call void @__c0c_emit(ptr %t71, ptr %t72)
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr [31 x i8], ptr @.str347, i64 0, i64 0
  call void @__c0c_emit(ptr %t74, ptr %t75)
  %t77 = load ptr, ptr %t0
  %t78 = getelementptr [37 x i8], ptr @.str348, i64 0, i64 0
  call void @__c0c_emit(ptr %t77, ptr %t78)
  %t80 = load ptr, ptr %t0
  %t81 = getelementptr [37 x i8], ptr @.str349, i64 0, i64 0
  call void @__c0c_emit(ptr %t80, ptr %t81)
  %t83 = load ptr, ptr %t0
  %t84 = getelementptr [43 x i8], ptr @.str350, i64 0, i64 0
  call void @__c0c_emit(ptr %t83, ptr %t84)
  %t86 = load ptr, ptr %t0
  %t87 = getelementptr [38 x i8], ptr @.str351, i64 0, i64 0
  call void @__c0c_emit(ptr %t86, ptr %t87)
  %t89 = load ptr, ptr %t0
  %t90 = getelementptr [44 x i8], ptr @.str352, i64 0, i64 0
  call void @__c0c_emit(ptr %t89, ptr %t90)
  %t92 = load ptr, ptr %t0
  %t93 = getelementptr [30 x i8], ptr @.str353, i64 0, i64 0
  call void @__c0c_emit(ptr %t92, ptr %t93)
  %t95 = load ptr, ptr %t0
  %t96 = getelementptr [26 x i8], ptr @.str354, i64 0, i64 0
  call void @__c0c_emit(ptr %t95, ptr %t96)
  %t98 = load ptr, ptr %t0
  %t99 = getelementptr [40 x i8], ptr @.str355, i64 0, i64 0
  call void @__c0c_emit(ptr %t98, ptr %t99)
  %t101 = load ptr, ptr %t0
  %t102 = getelementptr [41 x i8], ptr @.str356, i64 0, i64 0
  call void @__c0c_emit(ptr %t101, ptr %t102)
  %t104 = load ptr, ptr %t0
  %t105 = getelementptr [35 x i8], ptr @.str357, i64 0, i64 0
  call void @__c0c_emit(ptr %t104, ptr %t105)
  %t107 = load ptr, ptr %t0
  %t108 = getelementptr [25 x i8], ptr @.str358, i64 0, i64 0
  call void @__c0c_emit(ptr %t107, ptr %t108)
  %t110 = load ptr, ptr %t0
  %t111 = getelementptr [27 x i8], ptr @.str359, i64 0, i64 0
  call void @__c0c_emit(ptr %t110, ptr %t111)
  %t113 = load ptr, ptr %t0
  %t114 = getelementptr [25 x i8], ptr @.str360, i64 0, i64 0
  call void @__c0c_emit(ptr %t113, ptr %t114)
  %t116 = load ptr, ptr %t0
  %t117 = getelementptr [26 x i8], ptr @.str361, i64 0, i64 0
  call void @__c0c_emit(ptr %t116, ptr %t117)
  %t119 = load ptr, ptr %t0
  %t120 = getelementptr [24 x i8], ptr @.str362, i64 0, i64 0
  call void @__c0c_emit(ptr %t119, ptr %t120)
  %t122 = load ptr, ptr %t0
  %t123 = getelementptr [24 x i8], ptr @.str363, i64 0, i64 0
  call void @__c0c_emit(ptr %t122, ptr %t123)
  %t125 = load ptr, ptr %t0
  %t126 = getelementptr [36 x i8], ptr @.str364, i64 0, i64 0
  call void @__c0c_emit(ptr %t125, ptr %t126)
  %t128 = load ptr, ptr %t0
  %t129 = getelementptr [37 x i8], ptr @.str365, i64 0, i64 0
  call void @__c0c_emit(ptr %t128, ptr %t129)
  %t131 = load ptr, ptr %t0
  %t132 = getelementptr [27 x i8], ptr @.str366, i64 0, i64 0
  call void @__c0c_emit(ptr %t131, ptr %t132)
  %t134 = load ptr, ptr %t0
  %t135 = getelementptr [27 x i8], ptr @.str367, i64 0, i64 0
  call void @__c0c_emit(ptr %t134, ptr %t135)
  %t137 = load ptr, ptr %t0
  %t138 = getelementptr [27 x i8], ptr @.str368, i64 0, i64 0
  call void @__c0c_emit(ptr %t137, ptr %t138)
  %t140 = load ptr, ptr %t0
  %t141 = getelementptr [27 x i8], ptr @.str369, i64 0, i64 0
  call void @__c0c_emit(ptr %t140, ptr %t141)
  %t143 = load ptr, ptr %t0
  %t144 = getelementptr [27 x i8], ptr @.str370, i64 0, i64 0
  call void @__c0c_emit(ptr %t143, ptr %t144)
  %t146 = load ptr, ptr %t0
  %t147 = getelementptr [28 x i8], ptr @.str371, i64 0, i64 0
  call void @__c0c_emit(ptr %t146, ptr %t147)
  %t149 = load ptr, ptr %t0
  %t150 = getelementptr [27 x i8], ptr @.str372, i64 0, i64 0
  call void @__c0c_emit(ptr %t149, ptr %t150)
  %t152 = load ptr, ptr %t0
  %t153 = getelementptr [27 x i8], ptr @.str373, i64 0, i64 0
  call void @__c0c_emit(ptr %t152, ptr %t153)
  %t155 = load ptr, ptr %t0
  %t156 = getelementptr [27 x i8], ptr @.str374, i64 0, i64 0
  call void @__c0c_emit(ptr %t155, ptr %t156)
  %t158 = load ptr, ptr %t0
  %t159 = getelementptr [27 x i8], ptr @.str375, i64 0, i64 0
  call void @__c0c_emit(ptr %t158, ptr %t159)
  %t161 = load ptr, ptr %t0
  %t162 = getelementptr [26 x i8], ptr @.str376, i64 0, i64 0
  call void @__c0c_emit(ptr %t161, ptr %t162)
  %t164 = load ptr, ptr %t0
  %t165 = getelementptr [29 x i8], ptr @.str377, i64 0, i64 0
  call void @__c0c_emit(ptr %t164, ptr %t165)
  %t167 = load ptr, ptr %t0
  %t168 = getelementptr [29 x i8], ptr @.str378, i64 0, i64 0
  call void @__c0c_emit(ptr %t167, ptr %t168)
  %t170 = load ptr, ptr %t0
  %t171 = getelementptr [28 x i8], ptr @.str379, i64 0, i64 0
  call void @__c0c_emit(ptr %t170, ptr %t171)
  %t173 = load ptr, ptr %t0
  %t174 = getelementptr [41 x i8], ptr @.str380, i64 0, i64 0
  call void @__c0c_emit(ptr %t173, ptr %t174)
  %t176 = load ptr, ptr %t0
  %t177 = getelementptr [2 x i8], ptr @.str381, i64 0, i64 0
  call void @__c0c_emit(ptr %t176, ptr %t177)
  %t179 = alloca ptr
  %t180 = sext i32 0 to i64
  store i64 %t180, ptr %t179
  %t181 = alloca i64
  %t182 = sext i32 0 to i64
  store i64 %t182, ptr %t181
  br label %L4
L4:
  %t183 = load ptr, ptr %t179
  %t184 = load i64, ptr %t181
  %t185 = getelementptr i32, ptr %t183, i64 %t184
  %t186 = load i64, ptr %t185
  %t187 = icmp ne i64 %t186, 0
  br i1 %t187, label %L5, label %L7
L5:
  %t188 = alloca i64
  %t189 = sext i32 0 to i64
  store i64 %t189, ptr %t188
  %t190 = alloca i64
  %t191 = sext i32 0 to i64
  store i64 %t191, ptr %t190
  br label %L8
L8:
  %t192 = load i64, ptr %t190
  %t193 = load ptr, ptr %t0
  %t195 = ptrtoint ptr %t193 to i64
  %t194 = icmp slt i64 %t192, %t195
  %t196 = zext i1 %t194 to i64
  %t197 = icmp ne i64 %t196, 0
  br i1 %t197, label %L9, label %L11
L9:
  %t198 = load ptr, ptr %t0
  %t199 = load i64, ptr %t190
  %t200 = getelementptr i8, ptr %t198, i64 %t199
  %t201 = load ptr, ptr %t200
  %t202 = load ptr, ptr %t179
  %t203 = load i64, ptr %t181
  %t204 = getelementptr i32, ptr %t202, i64 %t203
  %t205 = load i64, ptr %t204
  %t206 = call i32 @strcmp(ptr %t201, i64 %t205)
  %t207 = sext i32 %t206 to i64
  %t209 = sext i32 0 to i64
  %t208 = icmp eq i64 %t207, %t209
  %t210 = zext i1 %t208 to i64
  %t211 = icmp ne i64 %t210, 0
  br i1 %t211, label %L12, label %L14
L12:
  %t212 = sext i32 1 to i64
  store i64 %t212, ptr %t188
  br label %L11
L15:
  br label %L14
L14:
  br label %L10
L10:
  %t213 = load i64, ptr %t190
  %t214 = add i64 %t213, 1
  store i64 %t214, ptr %t190
  br label %L8
L11:
  %t215 = load i64, ptr %t188
  %t217 = icmp eq i64 %t215, 0
  %t216 = zext i1 %t217 to i64
  %t218 = load ptr, ptr %t0
  %t220 = ptrtoint ptr %t218 to i64
  %t221 = sext i32 2048 to i64
  %t219 = icmp slt i64 %t220, %t221
  %t222 = zext i1 %t219 to i64
  %t224 = icmp ne i64 %t216, 0
  %t225 = icmp ne i64 %t222, 0
  %t226 = and i1 %t224, %t225
  %t227 = zext i1 %t226 to i64
  %t228 = icmp ne i64 %t227, 0
  br i1 %t228, label %L16, label %L18
L16:
  %t229 = load ptr, ptr %t179
  %t230 = load i64, ptr %t181
  %t231 = getelementptr i32, ptr %t229, i64 %t230
  %t232 = load i64, ptr %t231
  %t233 = call ptr @strdup(i64 %t232)
  %t234 = load ptr, ptr %t0
  %t235 = load ptr, ptr %t0
  %t237 = ptrtoint ptr %t235 to i64
  %t236 = getelementptr i8, ptr %t234, i64 %t237
  store ptr %t233, ptr %t236
  %t239 = sext i32 0 to i64
  %t238 = inttoptr i64 %t239 to ptr
  %t240 = load ptr, ptr %t0
  %t241 = load ptr, ptr %t0
  %t243 = ptrtoint ptr %t241 to i64
  %t242 = getelementptr i8, ptr %t240, i64 %t243
  store ptr %t238, ptr %t242
  %t244 = load ptr, ptr %t0
  %t245 = load ptr, ptr %t0
  %t247 = ptrtoint ptr %t245 to i64
  %t246 = getelementptr i8, ptr %t244, i64 %t247
  %t248 = sext i32 1 to i64
  store i64 %t248, ptr %t246
  %t249 = load ptr, ptr %t0
  %t251 = ptrtoint ptr %t249 to i64
  %t250 = add i64 %t251, 1
  store i64 %t250, ptr %t0
  br label %L18
L18:
  br label %L6
L6:
  %t252 = load i64, ptr %t181
  %t253 = add i64 %t252, 1
  store i64 %t253, ptr %t181
  br label %L4
L7:
  %t254 = alloca i64
  %t255 = sext i32 0 to i64
  store i64 %t255, ptr %t254
  br label %L19
L19:
  %t256 = load i64, ptr %t254
  %t257 = load ptr, ptr %t1
  %t259 = ptrtoint ptr %t257 to i64
  %t258 = icmp slt i64 %t256, %t259
  %t260 = zext i1 %t258 to i64
  %t261 = icmp ne i64 %t260, 0
  br i1 %t261, label %L20, label %L22
L20:
  %t262 = alloca ptr
  %t263 = load ptr, ptr %t1
  %t264 = load i64, ptr %t254
  %t265 = getelementptr i32, ptr %t263, i64 %t264
  %t266 = load i64, ptr %t265
  store i64 %t266, ptr %t262
  %t267 = load ptr, ptr %t262
  %t269 = ptrtoint ptr %t267 to i64
  %t270 = icmp eq i64 %t269, 0
  %t268 = zext i1 %t270 to i64
  %t271 = icmp ne i64 %t268, 0
  br i1 %t271, label %L23, label %L25
L23:
  br label %L21
L26:
  br label %L25
L25:
  %t272 = load ptr, ptr %t262
  %t273 = load ptr, ptr %t272
  %t275 = ptrtoint ptr %t273 to i64
  %t276 = sext i32 1 to i64
  %t274 = icmp eq i64 %t275, %t276
  %t277 = zext i1 %t274 to i64
  %t278 = icmp ne i64 %t277, 0
  br i1 %t278, label %L27, label %L29
L27:
  %t279 = alloca i64
  %t280 = sext i32 0 to i64
  store i64 %t280, ptr %t279
  %t281 = alloca i64
  %t282 = sext i32 0 to i64
  store i64 %t282, ptr %t281
  br label %L30
L30:
  %t283 = load i64, ptr %t281
  %t284 = load ptr, ptr %t0
  %t286 = ptrtoint ptr %t284 to i64
  %t285 = icmp slt i64 %t283, %t286
  %t287 = zext i1 %t285 to i64
  %t288 = icmp ne i64 %t287, 0
  br i1 %t288, label %L31, label %L33
L31:
  %t289 = load ptr, ptr %t0
  %t290 = load i64, ptr %t281
  %t291 = getelementptr i8, ptr %t289, i64 %t290
  %t292 = load ptr, ptr %t291
  %t293 = load ptr, ptr %t262
  %t294 = load ptr, ptr %t293
  %t295 = icmp ne ptr %t294, null
  br i1 %t295, label %L34, label %L35
L34:
  %t296 = load ptr, ptr %t262
  %t297 = load ptr, ptr %t296
  %t298 = ptrtoint ptr %t297 to i64
  br label %L36
L35:
  %t299 = getelementptr [1 x i8], ptr @.str382, i64 0, i64 0
  %t300 = ptrtoint ptr %t299 to i64
  br label %L36
L36:
  %t301 = phi i64 [ %t298, %L34 ], [ %t300, %L35 ]
  %t302 = call i32 @strcmp(ptr %t292, i64 %t301)
  %t303 = sext i32 %t302 to i64
  %t305 = sext i32 0 to i64
  %t304 = icmp eq i64 %t303, %t305
  %t306 = zext i1 %t304 to i64
  %t307 = icmp ne i64 %t306, 0
  br i1 %t307, label %L37, label %L39
L37:
  %t308 = sext i32 1 to i64
  store i64 %t308, ptr %t279
  br label %L33
L40:
  br label %L39
L39:
  br label %L32
L32:
  %t309 = load i64, ptr %t281
  %t310 = add i64 %t309, 1
  store i64 %t310, ptr %t281
  br label %L30
L33:
  %t311 = load i64, ptr %t279
  %t313 = icmp eq i64 %t311, 0
  %t312 = zext i1 %t313 to i64
  %t314 = load ptr, ptr %t0
  %t316 = ptrtoint ptr %t314 to i64
  %t317 = sext i32 2048 to i64
  %t315 = icmp slt i64 %t316, %t317
  %t318 = zext i1 %t315 to i64
  %t320 = icmp ne i64 %t312, 0
  %t321 = icmp ne i64 %t318, 0
  %t322 = and i1 %t320, %t321
  %t323 = zext i1 %t322 to i64
  %t324 = icmp ne i64 %t323, 0
  br i1 %t324, label %L41, label %L43
L41:
  %t325 = load ptr, ptr %t262
  %t326 = load ptr, ptr %t325
  %t327 = icmp ne ptr %t326, null
  br i1 %t327, label %L44, label %L45
L44:
  %t328 = load ptr, ptr %t262
  %t329 = load ptr, ptr %t328
  %t330 = ptrtoint ptr %t329 to i64
  br label %L46
L45:
  %t331 = getelementptr [7 x i8], ptr @.str383, i64 0, i64 0
  %t332 = ptrtoint ptr %t331 to i64
  br label %L46
L46:
  %t333 = phi i64 [ %t330, %L44 ], [ %t332, %L45 ]
  %t334 = call ptr @strdup(i64 %t333)
  %t335 = load ptr, ptr %t0
  %t336 = load ptr, ptr %t0
  %t338 = ptrtoint ptr %t336 to i64
  %t337 = getelementptr i8, ptr %t335, i64 %t338
  store ptr %t334, ptr %t337
  %t339 = load ptr, ptr %t262
  %t340 = load ptr, ptr %t339
  %t341 = load ptr, ptr %t0
  %t342 = load ptr, ptr %t0
  %t344 = ptrtoint ptr %t342 to i64
  %t343 = getelementptr i8, ptr %t341, i64 %t344
  store ptr %t340, ptr %t343
  %t345 = load ptr, ptr %t0
  %t346 = load ptr, ptr %t0
  %t348 = ptrtoint ptr %t346 to i64
  %t347 = getelementptr i8, ptr %t345, i64 %t348
  %t349 = sext i32 0 to i64
  store i64 %t349, ptr %t347
  %t350 = load ptr, ptr %t0
  %t352 = ptrtoint ptr %t350 to i64
  %t351 = add i64 %t352, 1
  store i64 %t351, ptr %t0
  br label %L43
L43:
  br label %L29
L29:
  br label %L21
L21:
  %t353 = load i64, ptr %t254
  %t354 = add i64 %t353, 1
  store i64 %t354, ptr %t254
  br label %L19
L22:
  %t355 = alloca i64
  %t356 = sext i32 0 to i64
  store i64 %t356, ptr %t355
  br label %L47
L47:
  %t357 = load i64, ptr %t355
  %t358 = load ptr, ptr %t1
  %t360 = ptrtoint ptr %t358 to i64
  %t359 = icmp slt i64 %t357, %t360
  %t361 = zext i1 %t359 to i64
  %t362 = icmp ne i64 %t361, 0
  br i1 %t362, label %L48, label %L50
L48:
  %t363 = alloca ptr
  %t364 = load ptr, ptr %t1
  %t365 = load i64, ptr %t355
  %t366 = getelementptr i32, ptr %t364, i64 %t365
  %t367 = load i64, ptr %t366
  store i64 %t367, ptr %t363
  %t368 = load ptr, ptr %t363
  %t370 = ptrtoint ptr %t368 to i64
  %t371 = icmp eq i64 %t370, 0
  %t369 = zext i1 %t371 to i64
  %t372 = icmp ne i64 %t369, 0
  br i1 %t372, label %L51, label %L53
L51:
  br label %L49
L54:
  br label %L53
L53:
  %t373 = load ptr, ptr %t363
  %t374 = load ptr, ptr %t373
  %t376 = ptrtoint ptr %t374 to i64
  %t377 = sext i32 2 to i64
  %t375 = icmp eq i64 %t376, %t377
  %t378 = zext i1 %t375 to i64
  %t379 = icmp ne i64 %t378, 0
  br i1 %t379, label %L55, label %L57
L55:
  %t380 = load ptr, ptr %t363
  call void @emit_global_var(ptr %t0, ptr %t380)
  br label %L57
L57:
  br label %L49
L49:
  %t382 = load i64, ptr %t355
  %t383 = add i64 %t382, 1
  store i64 %t383, ptr %t355
  br label %L47
L50:
  %t384 = load ptr, ptr %t0
  %t385 = getelementptr [2 x i8], ptr @.str384, i64 0, i64 0
  call void @__c0c_emit(ptr %t384, ptr %t385)
  %t387 = alloca i64
  %t388 = sext i32 0 to i64
  store i64 %t388, ptr %t387
  br label %L58
L58:
  %t389 = load i64, ptr %t387
  %t390 = load ptr, ptr %t1
  %t392 = ptrtoint ptr %t390 to i64
  %t391 = icmp slt i64 %t389, %t392
  %t393 = zext i1 %t391 to i64
  %t394 = icmp ne i64 %t393, 0
  br i1 %t394, label %L59, label %L61
L59:
  %t395 = alloca ptr
  %t396 = load ptr, ptr %t1
  %t397 = load i64, ptr %t387
  %t398 = getelementptr i32, ptr %t396, i64 %t397
  %t399 = load i64, ptr %t398
  store i64 %t399, ptr %t395
  %t400 = load ptr, ptr %t395
  %t402 = ptrtoint ptr %t400 to i64
  %t403 = icmp eq i64 %t402, 0
  %t401 = zext i1 %t403 to i64
  %t404 = icmp ne i64 %t401, 0
  br i1 %t404, label %L62, label %L64
L62:
  br label %L60
L65:
  br label %L64
L64:
  %t405 = load ptr, ptr %t395
  %t406 = load ptr, ptr %t405
  %t408 = ptrtoint ptr %t406 to i64
  %t409 = sext i32 1 to i64
  %t407 = icmp eq i64 %t408, %t409
  %t410 = zext i1 %t407 to i64
  %t411 = icmp ne i64 %t410, 0
  br i1 %t411, label %L66, label %L68
L66:
  %t412 = load ptr, ptr %t395
  call void @emit_func_def(ptr %t0, ptr %t412)
  br label %L68
L68:
  br label %L60
L60:
  %t414 = load i64, ptr %t387
  %t415 = add i64 %t414, 1
  store i64 %t415, ptr %t387
  br label %L58
L61:
  %t416 = alloca i64
  %t417 = sext i32 0 to i64
  store i64 %t417, ptr %t416
  br label %L69
L69:
  %t418 = load i64, ptr %t416
  %t419 = load ptr, ptr %t0
  %t421 = ptrtoint ptr %t419 to i64
  %t420 = icmp slt i64 %t418, %t421
  %t422 = zext i1 %t420 to i64
  %t423 = icmp ne i64 %t422, 0
  br i1 %t423, label %L70, label %L72
L70:
  %t424 = alloca i64
  %t425 = load ptr, ptr %t0
  %t426 = load i64, ptr %t416
  %t427 = getelementptr i32, ptr %t425, i64 %t426
  %t428 = load i64, ptr %t427
  %t429 = call i32 @str_literal_len(i64 %t428)
  %t430 = sext i32 %t429 to i64
  store i64 %t430, ptr %t424
  %t431 = load ptr, ptr %t0
  %t432 = getelementptr [53 x i8], ptr @.str385, i64 0, i64 0
  %t433 = load ptr, ptr %t0
  %t434 = load i64, ptr %t416
  %t435 = getelementptr i32, ptr %t433, i64 %t434
  %t436 = load i64, ptr %t435
  %t437 = load i64, ptr %t424
  call void @__c0c_emit(ptr %t431, ptr %t432, i64 %t436, i64 %t437)
  %t439 = load ptr, ptr %t0
  %t440 = load i64, ptr %t416
  %t441 = getelementptr i32, ptr %t439, i64 %t440
  %t442 = load i64, ptr %t441
  call void @emit_str_content(ptr %t0, i64 %t442)
  %t444 = load ptr, ptr %t0
  %t445 = getelementptr [3 x i8], ptr @.str386, i64 0, i64 0
  call void @__c0c_emit(ptr %t444, ptr %t445)
  br label %L71
L71:
  %t447 = load i64, ptr %t416
  %t448 = add i64 %t447, 1
  store i64 %t448, ptr %t416
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
@.str18 = private unnamed_addr constant [22 x i8] c"c0c: too many locals\0A\00"
@.str19 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str20 = private unnamed_addr constant [4 x i8] c"\5C0A\00"
@.str21 = private unnamed_addr constant [4 x i8] c"\5C09\00"
@.str22 = private unnamed_addr constant [4 x i8] c"\5C0D\00"
@.str23 = private unnamed_addr constant [4 x i8] c"\5C00\00"
@.str24 = private unnamed_addr constant [4 x i8] c"\5C22\00"
@.str25 = private unnamed_addr constant [4 x i8] c"\5C5C\00"
@.str26 = private unnamed_addr constant [6 x i8] c"\5C%02X\00"
@.str27 = private unnamed_addr constant [3 x i8] c"%c\00"
@.str28 = private unnamed_addr constant [4 x i8] c"\5C00\00"
@.str29 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str30 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str31 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str32 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str33 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str34 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str35 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str36 = private unnamed_addr constant [44 x i8] c"  %%t%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str37 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str38 = private unnamed_addr constant [3 x i8] c"%s\00"
@.str39 = private unnamed_addr constant [34 x i8] c"  %%t%d = ptrtoint ptr %s to i64\0A\00"
@.str40 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str41 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str42 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str43 = private unnamed_addr constant [32 x i8] c"  %%t%d = icmp ne ptr %s, null\0A\00"
@.str44 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str45 = private unnamed_addr constant [2 x i8] c"0\00"
@.str46 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.str47 = private unnamed_addr constant [31 x i8] c"  %%t%d = fadd double 0.0, %g\0A\00"
@.str48 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str49 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.str50 = private unnamed_addr constant [62 x i8] c"  %%t%d = getelementptr [%d x i8], ptr @.str%d, i64 0, i64 0\0A\00"
@.str51 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str52 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str53 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str54 = private unnamed_addr constant [27 x i8] c"  %%t%d = load %s, ptr %s\0A\00"
@.str55 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str56 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str57 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str58 = private unnamed_addr constant [28 x i8] c"  %%t%d = load %s, ptr @%s\0A\00"
@.str59 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str60 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str61 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str62 = private unnamed_addr constant [16 x i8] c"  call void %s(\00"
@.str63 = private unnamed_addr constant [22 x i8] c"  %%t%d = call %s %s(\00"
@.str64 = private unnamed_addr constant [3 x i8] c", \00"
@.str65 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str66 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str67 = private unnamed_addr constant [6 x i8] c"%s %s\00"
@.str68 = private unnamed_addr constant [3 x i8] c")\0A\00"
@.str69 = private unnamed_addr constant [2 x i8] c"0\00"
@.str70 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str71 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str72 = private unnamed_addr constant [32 x i8] c"  %%t%d = sext %s %%t%d to i64\0A\00"
@.str73 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str74 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str75 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str76 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str77 = private unnamed_addr constant [14 x i8] c"getelementptr\00"
@.str78 = private unnamed_addr constant [4 x i8] c"add\00"
@.str79 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str80 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str81 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str82 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str83 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str84 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str85 = private unnamed_addr constant [5 x i8] c"frem\00"
@.str86 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str87 = private unnamed_addr constant [4 x i8] c"and\00"
@.str88 = private unnamed_addr constant [3 x i8] c"or\00"
@.str89 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str90 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str91 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str92 = private unnamed_addr constant [9 x i8] c"fcmp oeq\00"
@.str93 = private unnamed_addr constant [8 x i8] c"icmp eq\00"
@.str94 = private unnamed_addr constant [9 x i8] c"fcmp one\00"
@.str95 = private unnamed_addr constant [8 x i8] c"icmp ne\00"
@.str96 = private unnamed_addr constant [9 x i8] c"fcmp olt\00"
@.str97 = private unnamed_addr constant [9 x i8] c"icmp slt\00"
@.str98 = private unnamed_addr constant [9 x i8] c"fcmp ogt\00"
@.str99 = private unnamed_addr constant [9 x i8] c"icmp sgt\00"
@.str100 = private unnamed_addr constant [9 x i8] c"fcmp ole\00"
@.str101 = private unnamed_addr constant [9 x i8] c"icmp sle\00"
@.str102 = private unnamed_addr constant [9 x i8] c"fcmp oge\00"
@.str103 = private unnamed_addr constant [9 x i8] c"icmp sge\00"
@.str104 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str105 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str106 = private unnamed_addr constant [31 x i8] c"  %%t%d = and i1 %%t%d, %%t%d\0A\00"
@.str107 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str108 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str109 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str110 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str111 = private unnamed_addr constant [30 x i8] c"  %%t%d = or i1 %%t%d, %%t%d\0A\00"
@.str112 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str113 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str114 = private unnamed_addr constant [4 x i8] c"add\00"
@.str115 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str116 = private unnamed_addr constant [47 x i8] c"  %%t%d = getelementptr i8, ptr %%t%d, i64 %s\0A\00"
@.str117 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str118 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str119 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str120 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str121 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str122 = private unnamed_addr constant [26 x i8] c"  %%t%d = fneg double %s\0A\00"
@.str123 = private unnamed_addr constant [25 x i8] c"  %%t%d = sub i64 0, %s\0A\00"
@.str124 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp eq i64 %s, 0\0A\00"
@.str125 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str126 = private unnamed_addr constant [26 x i8] c"  %%t%d = xor i64 %s, -1\0A\00"
@.str127 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str128 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str129 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str130 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str131 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str132 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str133 = private unnamed_addr constant [23 x i8] c"  store %s %s, ptr %s\0A\00"
@.str134 = private unnamed_addr constant [7 x i8] c"double\00"
@.str135 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str136 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str137 = private unnamed_addr constant [4 x i8] c"add\00"
@.str138 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str139 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str140 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str141 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str142 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str143 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str144 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str145 = private unnamed_addr constant [4 x i8] c"and\00"
@.str146 = private unnamed_addr constant [3 x i8] c"or\00"
@.str147 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str148 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str149 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str150 = private unnamed_addr constant [4 x i8] c"add\00"
@.str151 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str152 = private unnamed_addr constant [26 x i8] c"  store %s %%t%d, ptr %s\0A\00"
@.str153 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str154 = private unnamed_addr constant [4 x i8] c"add\00"
@.str155 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str156 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s i64 %s, 1\0A\00"
@.str157 = private unnamed_addr constant [27 x i8] c"  store i64 %%t%d, ptr %s\0A\00"
@.str158 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str159 = private unnamed_addr constant [4 x i8] c"add\00"
@.str160 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str161 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s i64 %s, 1\0A\00"
@.str162 = private unnamed_addr constant [27 x i8] c"  store i64 %%t%d, ptr %s\0A\00"
@.str163 = private unnamed_addr constant [5 x i8] c"null\00"
@.str164 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str165 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str166 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str167 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str168 = private unnamed_addr constant [27 x i8] c"  %%t%d = load %s, ptr %s\0A\00"
@.str169 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str170 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str171 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str172 = private unnamed_addr constant [44 x i8] c"  %%t%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str173 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str174 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str175 = private unnamed_addr constant [30 x i8] c"  %%t%d = load %s, ptr %%t%d\0A\00"
@.str176 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str177 = private unnamed_addr constant [36 x i8] c"  %%t%d = fpext float %s to double\0A\00"
@.str178 = private unnamed_addr constant [38 x i8] c"  %%t%d = fptrunc double %s to float\0A\00"
@.str179 = private unnamed_addr constant [35 x i8] c"  %%t%d = fptosi double %s to i64\0A\00"
@.str180 = private unnamed_addr constant [31 x i8] c"  %%t%d = sitofp i64 %s to %s\0A\00"
@.str181 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str182 = private unnamed_addr constant [34 x i8] c"  %%t%d = ptrtoint ptr %s to i64\0A\00"
@.str183 = private unnamed_addr constant [33 x i8] c"  %%t%d = bitcast ptr %s to ptr\0A\00"
@.str184 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str185 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str186 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str187 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str188 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str189 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str190 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str191 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str192 = private unnamed_addr constant [48 x i8] c"  %%t%d = phi i64 [ %s, %%L%d ], [ %s, %%L%d ]\0A\00"
@.str193 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str194 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str195 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str196 = private unnamed_addr constant [2 x i8] c"0\00"
@.str197 = private unnamed_addr constant [5 x i8] c"null\00"
@.str198 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str199 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str200 = private unnamed_addr constant [28 x i8] c"  %%t%d = load ptr, ptr %s\0A\00"
@.str201 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str202 = private unnamed_addr constant [28 x i8] c"  ; unhandled expr node %d\0A\00"
@.str203 = private unnamed_addr constant [2 x i8] c"0\00"
@.str204 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str205 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str206 = private unnamed_addr constant [21 x i8] c"  %%t%d = alloca %s\0A\00"
@.str207 = private unnamed_addr constant [22 x i8] c"c0c: too many locals\0A\00"
@.str208 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str209 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str210 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str211 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str212 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str213 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str214 = private unnamed_addr constant [26 x i8] c"  store %s %s, ptr %%t%d\0A\00"
@.str215 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str216 = private unnamed_addr constant [13 x i8] c"  ret %s %s\0A\00"
@.str217 = private unnamed_addr constant [14 x i8] c"  ret ptr %s\0A\00"
@.str218 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str219 = private unnamed_addr constant [17 x i8] c"  ret ptr %%t%d\0A\00"
@.str220 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str221 = private unnamed_addr constant [30 x i8] c"  %%t%d = trunc i64 %s to i8\0A\00"
@.str222 = private unnamed_addr constant [16 x i8] c"  ret i8 %%t%d\0A\00"
@.str223 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str224 = private unnamed_addr constant [31 x i8] c"  %%t%d = trunc i64 %s to i16\0A\00"
@.str225 = private unnamed_addr constant [17 x i8] c"  ret i16 %%t%d\0A\00"
@.str226 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str227 = private unnamed_addr constant [31 x i8] c"  %%t%d = trunc i64 %s to i32\0A\00"
@.str228 = private unnamed_addr constant [17 x i8] c"  ret i32 %%t%d\0A\00"
@.str229 = private unnamed_addr constant [14 x i8] c"  ret i64 %s\0A\00"
@.str230 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str231 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str232 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str233 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str234 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str235 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str236 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str237 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str238 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str239 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str240 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str241 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str242 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str243 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str244 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str245 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str246 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str247 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str248 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str249 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str250 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str251 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str252 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str253 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str254 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str255 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str256 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str257 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str258 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str259 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str260 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str261 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str262 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str263 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str264 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str265 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str266 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str267 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str268 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str269 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str270 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str271 = private unnamed_addr constant [35 x i8] c"  switch i64 %%t%d, label %%L%d [\0A\00"
@.str272 = private unnamed_addr constant [27 x i8] c"    i64 %lld, label %%L%d\0A\00"
@.str273 = private unnamed_addr constant [5 x i8] c"  ]\0A\00"
@.str274 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str275 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str276 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str277 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str278 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str279 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str280 = private unnamed_addr constant [5 x i8] c"%s:\0A\00"
@.str281 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str282 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str283 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str284 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str285 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str286 = private unnamed_addr constant [18 x i8] c"define %s %s @%s(\00"
@.str287 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str288 = private unnamed_addr constant [3 x i8] c", \00"
@.str289 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str290 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str291 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str292 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str293 = private unnamed_addr constant [9 x i8] c"%s %%t%d\00"
@.str294 = private unnamed_addr constant [22 x i8] c"c0c: too many locals\0A\00"
@.str295 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str296 = private unnamed_addr constant [3 x i8] c", \00"
@.str297 = private unnamed_addr constant [4 x i8] c"...\00"
@.str298 = private unnamed_addr constant [5 x i8] c") {\0A\00"
@.str299 = private unnamed_addr constant [8 x i8] c"entry:\0A\00"
@.str300 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str301 = private unnamed_addr constant [16 x i8] c"  ret ptr null\0A\00"
@.str302 = private unnamed_addr constant [14 x i8] c"  ret %s 0.0\0A\00"
@.str303 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str304 = private unnamed_addr constant [12 x i8] c"  ret i8 0\0A\00"
@.str305 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str306 = private unnamed_addr constant [13 x i8] c"  ret i16 0\0A\00"
@.str307 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str308 = private unnamed_addr constant [13 x i8] c"  ret i32 0\0A\00"
@.str309 = private unnamed_addr constant [13 x i8] c"  ret i64 0\0A\00"
@.str310 = private unnamed_addr constant [4 x i8] c"}\0A\0A\00"
@.str311 = private unnamed_addr constant [3 x i8] c", \00"
@.str312 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str313 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str314 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str315 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str316 = private unnamed_addr constant [3 x i8] c"%s\00"
@.str317 = private unnamed_addr constant [3 x i8] c", \00"
@.str318 = private unnamed_addr constant [4 x i8] c"...\00"
@.str319 = private unnamed_addr constant [20 x i8] c"declare %s @%s(%s)\0A\00"
@.str320 = private unnamed_addr constant [26 x i8] c"@%s = external global %s\0A\00"
@.str321 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str322 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str323 = private unnamed_addr constant [36 x i8] c"@%s = %s global %s zeroinitializer\0A\00"
@.str324 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str325 = private unnamed_addr constant [19 x i8] c"; ModuleID = '%s'\0A\00"
@.str326 = private unnamed_addr constant [24 x i8] c"source_filename = \22%s\22\0A\00"
@.str327 = private unnamed_addr constant [94 x i8] c"target datalayout = \22e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128\22\0A\00"
@.str328 = private unnamed_addr constant [45 x i8] c"target triple = \22x86_64-unknown-linux-gnu\22\0A\0A\00"
@.str329 = private unnamed_addr constant [23 x i8] c"; stdlib declarations\0A\00"
@.str330 = private unnamed_addr constant [26 x i8] c"declare ptr @malloc(i64)\0A\00"
@.str331 = private unnamed_addr constant [31 x i8] c"declare ptr @calloc(i64, i64)\0A\00"
@.str332 = private unnamed_addr constant [32 x i8] c"declare ptr @realloc(ptr, i64)\0A\00"
@.str333 = private unnamed_addr constant [25 x i8] c"declare void @free(ptr)\0A\00"
@.str334 = private unnamed_addr constant [26 x i8] c"declare i64 @strlen(ptr)\0A\00"
@.str335 = private unnamed_addr constant [26 x i8] c"declare ptr @strdup(ptr)\0A\00"
@.str336 = private unnamed_addr constant [32 x i8] c"declare ptr @strndup(ptr, i64)\0A\00"
@.str337 = private unnamed_addr constant [31 x i8] c"declare ptr @strcpy(ptr, ptr)\0A\00"
@.str338 = private unnamed_addr constant [37 x i8] c"declare ptr @strncpy(ptr, ptr, i64)\0A\00"
@.str339 = private unnamed_addr constant [31 x i8] c"declare ptr @strcat(ptr, ptr)\0A\00"
@.str340 = private unnamed_addr constant [31 x i8] c"declare ptr @strchr(ptr, i64)\0A\00"
@.str341 = private unnamed_addr constant [31 x i8] c"declare ptr @strstr(ptr, ptr)\0A\00"
@.str342 = private unnamed_addr constant [31 x i8] c"declare i32 @strcmp(ptr, ptr)\0A\00"
@.str343 = private unnamed_addr constant [37 x i8] c"declare i32 @strncmp(ptr, ptr, i64)\0A\00"
@.str344 = private unnamed_addr constant [36 x i8] c"declare ptr @memcpy(ptr, ptr, i64)\0A\00"
@.str345 = private unnamed_addr constant [36 x i8] c"declare ptr @memset(ptr, i32, i64)\0A\00"
@.str346 = private unnamed_addr constant [36 x i8] c"declare i32 @memcmp(ptr, ptr, i64)\0A\00"
@.str347 = private unnamed_addr constant [31 x i8] c"declare i32 @printf(ptr, ...)\0A\00"
@.str348 = private unnamed_addr constant [37 x i8] c"declare i32 @fprintf(ptr, ptr, ...)\0A\00"
@.str349 = private unnamed_addr constant [37 x i8] c"declare i32 @sprintf(ptr, ptr, ...)\0A\00"
@.str350 = private unnamed_addr constant [43 x i8] c"declare i32 @snprintf(ptr, i64, ptr, ...)\0A\00"
@.str351 = private unnamed_addr constant [38 x i8] c"declare i32 @vfprintf(ptr, ptr, ptr)\0A\00"
@.str352 = private unnamed_addr constant [44 x i8] c"declare i32 @vsnprintf(ptr, i64, ptr, ptr)\0A\00"
@.str353 = private unnamed_addr constant [30 x i8] c"declare ptr @fopen(ptr, ptr)\0A\00"
@.str354 = private unnamed_addr constant [26 x i8] c"declare i32 @fclose(ptr)\0A\00"
@.str355 = private unnamed_addr constant [40 x i8] c"declare i64 @fread(ptr, i64, i64, ptr)\0A\00"
@.str356 = private unnamed_addr constant [41 x i8] c"declare i64 @fwrite(ptr, i64, i64, ptr)\0A\00"
@.str357 = private unnamed_addr constant [35 x i8] c"declare i32 @fseek(ptr, i64, i32)\0A\00"
@.str358 = private unnamed_addr constant [25 x i8] c"declare i64 @ftell(ptr)\0A\00"
@.str359 = private unnamed_addr constant [27 x i8] c"declare void @perror(ptr)\0A\00"
@.str360 = private unnamed_addr constant [25 x i8] c"declare void @exit(i32)\0A\00"
@.str361 = private unnamed_addr constant [26 x i8] c"declare ptr @getenv(ptr)\0A\00"
@.str362 = private unnamed_addr constant [24 x i8] c"declare i32 @atoi(ptr)\0A\00"
@.str363 = private unnamed_addr constant [24 x i8] c"declare i64 @atol(ptr)\0A\00"
@.str364 = private unnamed_addr constant [36 x i8] c"declare i64 @strtol(ptr, ptr, i32)\0A\00"
@.str365 = private unnamed_addr constant [37 x i8] c"declare i64 @strtoll(ptr, ptr, i32)\0A\00"
@.str366 = private unnamed_addr constant [27 x i8] c"declare double @atof(ptr)\0A\00"
@.str367 = private unnamed_addr constant [27 x i8] c"declare i32 @isspace(i32)\0A\00"
@.str368 = private unnamed_addr constant [27 x i8] c"declare i32 @isdigit(i32)\0A\00"
@.str369 = private unnamed_addr constant [27 x i8] c"declare i32 @isalpha(i32)\0A\00"
@.str370 = private unnamed_addr constant [27 x i8] c"declare i32 @isalnum(i32)\0A\00"
@.str371 = private unnamed_addr constant [28 x i8] c"declare i32 @isxdigit(i32)\0A\00"
@.str372 = private unnamed_addr constant [27 x i8] c"declare i32 @isupper(i32)\0A\00"
@.str373 = private unnamed_addr constant [27 x i8] c"declare i32 @islower(i32)\0A\00"
@.str374 = private unnamed_addr constant [27 x i8] c"declare i32 @toupper(i32)\0A\00"
@.str375 = private unnamed_addr constant [27 x i8] c"declare i32 @tolower(i32)\0A\00"
@.str376 = private unnamed_addr constant [26 x i8] c"declare i32 @assert(i32)\0A\00"
@.str377 = private unnamed_addr constant [29 x i8] c"declare ptr @__c0c_stderr()\0A\00"
@.str378 = private unnamed_addr constant [29 x i8] c"declare ptr @__c0c_stdout()\0A\00"
@.str379 = private unnamed_addr constant [28 x i8] c"declare ptr @__c0c_stdin()\0A\00"
@.str380 = private unnamed_addr constant [41 x i8] c"declare void @__c0c_emit(ptr, ptr, ...)\0A\00"
@.str381 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str382 = private unnamed_addr constant [1 x i8] c"\00"
@.str383 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str384 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str385 = private unnamed_addr constant [53 x i8] c"@.str%d = private unnamed_addr constant [%d x i8] c\22\00"
@.str386 = private unnamed_addr constant [3 x i8] c"\22\0A\00"
