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
declare ptr @__c0c_get_tbuf(i32)
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
  %t2 = load i64, ptr @tbuf_idx
  %t3 = add i64 %t2, 1
  store i64 %t3, ptr @tbuf_idx
  %t4 = call ptr @__c0c_get_tbuf(i64 %t2)
  store ptr %t4, ptr %t1
  %t5 = load ptr, ptr %t1
  %t7 = ptrtoint ptr %t5 to i64
  %t8 = icmp eq i64 %t7, 0
  %t6 = zext i1 %t8 to i64
  %t9 = icmp ne i64 %t6, 0
  br i1 %t9, label %L0, label %L2
L0:
  %t10 = call ptr @__c0c_get_tbuf(i64 0)
  store ptr %t10, ptr %t1
  br label %L2
L2:
  %t12 = ptrtoint ptr %t0 to i64
  %t13 = icmp eq i64 %t12, 0
  %t11 = zext i1 %t13 to i64
  %t14 = icmp ne i64 %t11, 0
  br i1 %t14, label %L3, label %L5
L3:
  %t15 = load ptr, ptr %t1
  %t16 = getelementptr [4 x i8], ptr @.str1, i64 0, i64 0
  %t17 = call ptr @strcpy(ptr %t15, ptr %t16)
  %t18 = load ptr, ptr %t1
  ret ptr %t18
L6:
  br label %L5
L5:
  %t19 = load ptr, ptr %t0
  %t20 = ptrtoint ptr %t19 to i64
  %t21 = add i64 %t20, 0
  switch i64 %t21, label %L30 [
    i64 0, label %L8
    i64 1, label %L9
    i64 2, label %L10
    i64 3, label %L11
    i64 4, label %L12
    i64 5, label %L13
    i64 6, label %L14
    i64 7, label %L15
    i64 8, label %L16
    i64 20, label %L17
    i64 9, label %L18
    i64 10, label %L19
    i64 11, label %L20
    i64 12, label %L21
    i64 13, label %L22
    i64 14, label %L23
    i64 15, label %L24
    i64 16, label %L25
    i64 17, label %L26
    i64 18, label %L27
    i64 19, label %L28
    i64 21, label %L29
  ]
L8:
  %t22 = load ptr, ptr %t1
  %t23 = getelementptr [5 x i8], ptr @.str2, i64 0, i64 0
  %t24 = call ptr @strcpy(ptr %t22, ptr %t23)
  br label %L7
L31:
  br label %L9
L9:
  %t25 = load ptr, ptr %t1
  %t26 = getelementptr [3 x i8], ptr @.str3, i64 0, i64 0
  %t27 = call ptr @strcpy(ptr %t25, ptr %t26)
  br label %L7
L32:
  br label %L10
L10:
  br label %L11
L11:
  br label %L12
L12:
  %t28 = load ptr, ptr %t1
  %t29 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %t30 = call ptr @strcpy(ptr %t28, ptr %t29)
  br label %L7
L33:
  br label %L13
L13:
  br label %L14
L14:
  %t31 = load ptr, ptr %t1
  %t32 = getelementptr [4 x i8], ptr @.str5, i64 0, i64 0
  %t33 = call ptr @strcpy(ptr %t31, ptr %t32)
  br label %L7
L34:
  br label %L15
L15:
  br label %L16
L16:
  br label %L17
L17:
  %t34 = load ptr, ptr %t1
  %t35 = getelementptr [4 x i8], ptr @.str6, i64 0, i64 0
  %t36 = call ptr @strcpy(ptr %t34, ptr %t35)
  br label %L7
L35:
  br label %L18
L18:
  br label %L19
L19:
  br label %L20
L20:
  br label %L21
L21:
  %t37 = load ptr, ptr %t1
  %t38 = getelementptr [4 x i8], ptr @.str7, i64 0, i64 0
  %t39 = call ptr @strcpy(ptr %t37, ptr %t38)
  br label %L7
L36:
  br label %L22
L22:
  %t40 = load ptr, ptr %t1
  %t41 = getelementptr [6 x i8], ptr @.str8, i64 0, i64 0
  %t42 = call ptr @strcpy(ptr %t40, ptr %t41)
  br label %L7
L37:
  br label %L23
L23:
  %t43 = load ptr, ptr %t1
  %t44 = getelementptr [7 x i8], ptr @.str9, i64 0, i64 0
  %t45 = call ptr @strcpy(ptr %t43, ptr %t44)
  br label %L7
L38:
  br label %L24
L24:
  %t46 = load ptr, ptr %t1
  %t47 = getelementptr [4 x i8], ptr @.str10, i64 0, i64 0
  %t48 = call ptr @strcpy(ptr %t46, ptr %t47)
  br label %L7
L39:
  br label %L25
L25:
  %t49 = load ptr, ptr %t1
  %t50 = getelementptr [4 x i8], ptr @.str11, i64 0, i64 0
  %t51 = call ptr @strcpy(ptr %t49, ptr %t50)
  br label %L7
L40:
  br label %L26
L26:
  %t52 = load ptr, ptr %t1
  %t53 = getelementptr [4 x i8], ptr @.str12, i64 0, i64 0
  %t54 = call ptr @strcpy(ptr %t52, ptr %t53)
  br label %L7
L41:
  br label %L27
L27:
  br label %L28
L28:
  %t55 = load ptr, ptr %t0
  %t56 = icmp ne ptr %t55, null
  br i1 %t56, label %L42, label %L43
L42:
  %t57 = load ptr, ptr %t1
  %t58 = getelementptr [12 x i8], ptr @.str13, i64 0, i64 0
  %t59 = load ptr, ptr %t0
  %t60 = call i32 @snprintf(ptr %t57, i64 256, ptr %t58, ptr %t59)
  %t61 = sext i32 %t60 to i64
  br label %L44
L43:
  %t62 = load ptr, ptr %t1
  %t63 = getelementptr [4 x i8], ptr @.str14, i64 0, i64 0
  %t64 = call ptr @strcpy(ptr %t62, ptr %t63)
  br label %L44
L44:
  br label %L7
L45:
  br label %L29
L29:
  %t65 = load ptr, ptr %t1
  %t66 = getelementptr [4 x i8], ptr @.str15, i64 0, i64 0
  %t67 = call ptr @strcpy(ptr %t65, ptr %t66)
  br label %L7
L46:
  br label %L7
L30:
  %t68 = load ptr, ptr %t1
  %t69 = getelementptr [4 x i8], ptr @.str16, i64 0, i64 0
  %t70 = call ptr @strcpy(ptr %t68, ptr %t69)
  br label %L7
L47:
  br label %L7
L7:
  %t71 = load ptr, ptr %t1
  ret ptr %t71
L48:
  ret ptr null
}

define internal ptr @llvm_ret_type(ptr %t0) {
entry:
  %t2 = ptrtoint ptr %t0 to i64
  %t3 = icmp eq i64 %t2, 0
  %t1 = zext i1 %t3 to i64
  %t4 = icmp ne i64 %t1, 0
  br i1 %t4, label %L0, label %L1
L0:
  br label %L2
L1:
  %t5 = load ptr, ptr %t0
  %t7 = ptrtoint ptr %t5 to i64
  %t8 = sext i32 17 to i64
  %t6 = icmp ne i64 %t7, %t8
  %t9 = zext i1 %t6 to i64
  %t10 = icmp ne i64 %t9, 0
  %t11 = zext i1 %t10 to i64
  br label %L2
L2:
  %t12 = phi i64 [ 1, %L0 ], [ %t11, %L1 ]
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L3, label %L5
L3:
  %t14 = getelementptr [4 x i8], ptr @.str17, i64 0, i64 0
  ret ptr %t14
L6:
  br label %L5
L5:
  %t15 = load ptr, ptr %t0
  %t16 = call ptr @llvm_type(ptr %t15)
  ret ptr %t16
L7:
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
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L4, label %L5
L4:
  br label %L6
L5:
  %t13 = load ptr, ptr %t0
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 14 to i64
  %t14 = icmp eq i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  %t19 = zext i1 %t18 to i64
  br label %L6
L6:
  %t20 = phi i64 [ 1, %L4 ], [ %t19, %L5 ]
  %t21 = trunc i64 %t20 to i32
  ret i32 %t21
L7:
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
  %t6 = getelementptr ptr, ptr %t2, i64 %t7
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
  %t6 = getelementptr ptr, ptr %t2, i64 %t4
  %t7 = load ptr, ptr %t6
  store ptr %t7, ptr %t1
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
  %t18 = getelementptr ptr, ptr %t16, i64 %t17
  %t19 = load ptr, ptr %t18
  call void @free(ptr %t19)
  %t21 = load ptr, ptr %t0
  %t22 = load i64, ptr %t8
  %t23 = getelementptr ptr, ptr %t21, i64 %t22
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
  %t14 = getelementptr ptr, ptr %t12, i64 %t13
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
  %t24 = getelementptr ptr, ptr %t22, i64 %t23
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
  %t12 = getelementptr ptr, ptr %t10, i64 %t11
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
  %t22 = getelementptr ptr, ptr %t20, i64 %t21
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
  %t20 = getelementptr ptr, ptr %t16, i64 %t21
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
  %t9 = getelementptr ptr, ptr %t7, i64 %t10
  store ptr %t6, ptr %t9
  %t11 = load i64, ptr %t2
  %t12 = load ptr, ptr %t0
  %t13 = load ptr, ptr %t0
  %t15 = ptrtoint ptr %t13 to i64
  %t14 = getelementptr ptr, ptr %t12, i64 %t15
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
  %t10 = icmp ne i64 %t9, 0
  br i1 %t10, label %L3, label %L4
L3:
  %t11 = load ptr, ptr %t3
  %t12 = load i64, ptr %t11
  %t14 = sext i32 34 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  %t17 = zext i1 %t16 to i64
  br label %L5
L4:
  br label %L5
L5:
  %t18 = phi i64 [ %t17, %L3 ], [ 0, %L4 ]
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L1, label %L2
L1:
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t20
  %t23 = sext i32 92 to i64
  %t22 = icmp eq i64 %t21, %t23
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L6, label %L7
L6:
  %t26 = load ptr, ptr %t3
  %t28 = ptrtoint ptr %t26 to i64
  %t27 = add i64 %t28, 1
  store i64 %t27, ptr %t3
  %t29 = load ptr, ptr %t3
  %t30 = load i64, ptr %t29
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L9, label %L11
L9:
  %t32 = load ptr, ptr %t3
  %t34 = ptrtoint ptr %t32 to i64
  %t33 = add i64 %t34, 1
  store i64 %t33, ptr %t3
  br label %L11
L11:
  br label %L8
L7:
  %t35 = load ptr, ptr %t3
  %t37 = ptrtoint ptr %t35 to i64
  %t36 = add i64 %t37, 1
  store i64 %t36, ptr %t3
  br label %L8
L8:
  %t38 = load i64, ptr %t1
  %t39 = add i64 %t38, 1
  store i64 %t39, ptr %t1
  br label %L0
L2:
  %t40 = load i64, ptr %t1
  %t42 = sext i32 1 to i64
  %t41 = add i64 %t40, %t42
  %t43 = trunc i64 %t41 to i32
  ret i32 %t43
L12:
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
  %t9 = icmp ne i64 %t8, 0
  br i1 %t9, label %L3, label %L4
L3:
  %t10 = load ptr, ptr %t2
  %t11 = load i64, ptr %t10
  %t13 = sext i32 34 to i64
  %t12 = icmp ne i64 %t11, %t13
  %t14 = zext i1 %t12 to i64
  %t15 = icmp ne i64 %t14, 0
  %t16 = zext i1 %t15 to i64
  br label %L5
L4:
  br label %L5
L5:
  %t17 = phi i64 [ %t16, %L3 ], [ 0, %L4 ]
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L1, label %L2
L1:
  %t19 = load ptr, ptr %t2
  %t20 = load i64, ptr %t19
  %t22 = sext i32 92 to i64
  %t21 = icmp eq i64 %t20, %t22
  %t23 = zext i1 %t21 to i64
  %t24 = icmp ne i64 %t23, 0
  br i1 %t24, label %L6, label %L7
L6:
  %t25 = load ptr, ptr %t2
  %t27 = ptrtoint ptr %t25 to i64
  %t28 = sext i32 1 to i64
  %t29 = inttoptr i64 %t27 to ptr
  %t26 = getelementptr i8, ptr %t29, i64 %t28
  %t30 = load i64, ptr %t26
  %t31 = icmp ne i64 %t30, 0
  %t32 = zext i1 %t31 to i64
  br label %L8
L7:
  br label %L8
L8:
  %t33 = phi i64 [ %t32, %L6 ], [ 0, %L7 ]
  %t34 = icmp ne i64 %t33, 0
  br i1 %t34, label %L9, label %L10
L9:
  %t35 = load ptr, ptr %t2
  %t37 = ptrtoint ptr %t35 to i64
  %t36 = add i64 %t37, 1
  store i64 %t36, ptr %t2
  %t38 = load ptr, ptr %t2
  %t39 = load i64, ptr %t38
  %t40 = add i64 %t39, 0
  switch i64 %t40, label %L19 [
    i64 110, label %L13
    i64 116, label %L14
    i64 114, label %L15
    i64 48, label %L16
    i64 34, label %L17
    i64 92, label %L18
  ]
L13:
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr [4 x i8], ptr @.str20, i64 0, i64 0
  call void @__c0c_emit(ptr %t41, ptr %t42)
  br label %L12
L20:
  br label %L14
L14:
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr [4 x i8], ptr @.str21, i64 0, i64 0
  call void @__c0c_emit(ptr %t44, ptr %t45)
  br label %L12
L21:
  br label %L15
L15:
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr [4 x i8], ptr @.str22, i64 0, i64 0
  call void @__c0c_emit(ptr %t47, ptr %t48)
  br label %L12
L22:
  br label %L16
L16:
  %t50 = load ptr, ptr %t0
  %t51 = getelementptr [4 x i8], ptr @.str23, i64 0, i64 0
  call void @__c0c_emit(ptr %t50, ptr %t51)
  br label %L12
L23:
  br label %L17
L17:
  %t53 = load ptr, ptr %t0
  %t54 = getelementptr [4 x i8], ptr @.str24, i64 0, i64 0
  call void @__c0c_emit(ptr %t53, ptr %t54)
  br label %L12
L24:
  br label %L18
L18:
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr [4 x i8], ptr @.str25, i64 0, i64 0
  call void @__c0c_emit(ptr %t56, ptr %t57)
  br label %L12
L25:
  br label %L12
L19:
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr [6 x i8], ptr @.str26, i64 0, i64 0
  %t61 = load ptr, ptr %t2
  %t62 = load i64, ptr %t61
  %t63 = add i64 %t62, 0
  call void @__c0c_emit(ptr %t59, ptr %t60, i64 %t63)
  br label %L12
L26:
  br label %L12
L12:
  %t65 = load ptr, ptr %t2
  %t67 = ptrtoint ptr %t65 to i64
  %t66 = add i64 %t67, 1
  store i64 %t66, ptr %t2
  br label %L11
L10:
  %t68 = load ptr, ptr %t2
  %t69 = load i64, ptr %t68
  %t71 = sext i32 34 to i64
  %t70 = icmp eq i64 %t69, %t71
  %t72 = zext i1 %t70 to i64
  %t73 = icmp ne i64 %t72, 0
  br i1 %t73, label %L27, label %L29
L27:
  br label %L2
L30:
  br label %L29
L29:
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr [3 x i8], ptr @.str27, i64 0, i64 0
  %t76 = load ptr, ptr %t2
  %t78 = ptrtoint ptr %t76 to i64
  %t77 = add i64 %t78, 1
  store i64 %t77, ptr %t2
  %t79 = load i64, ptr %t76
  call void @__c0c_emit(ptr %t74, ptr %t75, i64 %t79)
  br label %L11
L11:
  br label %L0
L2:
  %t81 = load ptr, ptr %t0
  %t82 = getelementptr [4 x i8], ptr @.str28, i64 0, i64 0
  call void @__c0c_emit(ptr %t81, ptr %t82)
  ret void
}

define internal i64 @make_val(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca i64
  %t3 = load ptr, ptr %t2
  %t4 = call ptr @strncpy(ptr %t3, ptr %t0, i64 63)
  %t5 = load ptr, ptr %t2
  %t7 = sext i32 63 to i64
  %t6 = getelementptr ptr, ptr %t5, i64 %t7
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
  %t46 = getelementptr ptr, ptr %t44, i64 %t45
  %t47 = load ptr, ptr %t46
  %t48 = call i64 @emit_expr(ptr %t0, ptr %t47)
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
  %t80 = getelementptr ptr, ptr %t78, i64 %t79
  %t81 = load ptr, ptr %t80
  %t82 = call i64 @emit_expr(ptr %t0, ptr %t81)
  store i64 %t82, ptr %t77
  %t83 = alloca i64
  %t84 = load ptr, ptr %t1
  %t85 = sext i32 1 to i64
  %t86 = getelementptr ptr, ptr %t84, i64 %t85
  %t87 = load ptr, ptr %t86
  %t88 = call i64 @emit_expr(ptr %t0, ptr %t87)
  store i64 %t88, ptr %t83
  %t89 = alloca i64
  %t90 = call i32 @new_reg(ptr %t0)
  %t91 = sext i32 %t90 to i64
  store i64 %t91, ptr %t89
  %t92 = alloca ptr
  %t93 = load ptr, ptr %t1
  %t94 = sext i32 0 to i64
  %t95 = getelementptr ptr, ptr %t93, i64 %t94
  %t96 = load ptr, ptr %t95
  %t97 = load ptr, ptr %t96
  %t98 = ptrtoint ptr %t97 to i64
  %t99 = icmp ne i64 %t98, 0
  br i1 %t99, label %L23, label %L24
L23:
  %t100 = load ptr, ptr %t1
  %t101 = sext i32 0 to i64
  %t102 = getelementptr ptr, ptr %t100, i64 %t101
  %t103 = load ptr, ptr %t102
  %t104 = load ptr, ptr %t103
  %t105 = load ptr, ptr %t104
  %t106 = ptrtoint ptr %t105 to i64
  %t107 = icmp ne i64 %t106, 0
  %t108 = zext i1 %t107 to i64
  br label %L25
L24:
  br label %L25
L25:
  %t109 = phi i64 [ %t108, %L23 ], [ 0, %L24 ]
  %t110 = icmp ne i64 %t109, 0
  br i1 %t110, label %L26, label %L27
L26:
  %t111 = load ptr, ptr %t1
  %t112 = sext i32 0 to i64
  %t113 = getelementptr ptr, ptr %t111, i64 %t112
  %t114 = load ptr, ptr %t113
  %t115 = load ptr, ptr %t114
  %t116 = load ptr, ptr %t115
  %t117 = ptrtoint ptr %t116 to i64
  br label %L28
L27:
  %t119 = sext i32 0 to i64
  %t118 = inttoptr i64 %t119 to ptr
  %t120 = ptrtoint ptr %t118 to i64
  br label %L28
L28:
  %t121 = phi i64 [ %t117, %L26 ], [ %t120, %L27 ]
  store i64 %t121, ptr %t92
  %t122 = alloca ptr
  %t123 = load ptr, ptr %t92
  %t124 = icmp ne ptr %t123, null
  br i1 %t124, label %L29, label %L30
L29:
  %t125 = load ptr, ptr %t92
  %t126 = call ptr @llvm_type(ptr %t125)
  %t127 = ptrtoint ptr %t126 to i64
  br label %L31
L30:
  %t128 = getelementptr [4 x i8], ptr @.str33, i64 0, i64 0
  %t129 = ptrtoint ptr %t128 to i64
  br label %L31
L31:
  %t130 = phi i64 [ %t127, %L29 ], [ %t129, %L30 ]
  store i64 %t130, ptr %t122
  %t131 = alloca ptr
  %t132 = load i64, ptr %t77
  %t133 = call i32 @val_is_ptr(i64 %t132)
  %t134 = sext i32 %t133 to i64
  %t135 = icmp ne i64 %t134, 0
  br i1 %t135, label %L32, label %L33
L32:
  %t136 = load ptr, ptr %t131
  %t137 = load ptr, ptr %t77
  %t138 = call ptr @strncpy(ptr %t136, ptr %t137, i64 63)
  %t139 = load ptr, ptr %t131
  %t141 = sext i32 63 to i64
  %t140 = getelementptr ptr, ptr %t139, i64 %t141
  %t142 = sext i32 0 to i64
  store i64 %t142, ptr %t140
  br label %L34
L33:
  %t143 = alloca i64
  %t144 = call i32 @new_reg(ptr %t0)
  %t145 = sext i32 %t144 to i64
  store i64 %t145, ptr %t143
  %t146 = load ptr, ptr %t0
  %t147 = getelementptr [34 x i8], ptr @.str34, i64 0, i64 0
  %t148 = load i64, ptr %t143
  %t149 = load ptr, ptr %t77
  call void @__c0c_emit(ptr %t146, ptr %t147, i64 %t148, ptr %t149)
  %t151 = load ptr, ptr %t131
  %t152 = getelementptr [6 x i8], ptr @.str35, i64 0, i64 0
  %t153 = load i64, ptr %t143
  %t154 = call i32 @snprintf(ptr %t151, i64 64, ptr %t152, i64 %t153)
  %t155 = sext i32 %t154 to i64
  br label %L34
L34:
  %t156 = alloca ptr
  %t157 = load i64, ptr %t83
  %t158 = load ptr, ptr %t156
  %t159 = call i32 @promote_to_i64(ptr %t0, i64 %t157, ptr %t158, i64 64)
  %t160 = sext i32 %t159 to i64
  %t161 = load ptr, ptr %t0
  %t162 = getelementptr [44 x i8], ptr @.str36, i64 0, i64 0
  %t163 = load i64, ptr %t89
  %t164 = load ptr, ptr %t122
  %t165 = load ptr, ptr %t131
  %t166 = load ptr, ptr %t156
  call void @__c0c_emit(ptr %t161, ptr %t162, i64 %t163, ptr %t164, ptr %t165, ptr %t166)
  %t168 = alloca ptr
  %t169 = call ptr @malloc(i64 32)
  store ptr %t169, ptr %t168
  %t170 = load ptr, ptr %t168
  %t171 = getelementptr [6 x i8], ptr @.str37, i64 0, i64 0
  %t172 = load i64, ptr %t89
  %t173 = call i32 @snprintf(ptr %t170, i64 32, ptr %t171, i64 %t172)
  %t174 = sext i32 %t173 to i64
  %t175 = load ptr, ptr %t168
  ret ptr %t175
L35:
  br label %L22
L22:
  %t176 = load ptr, ptr %t1
  %t178 = ptrtoint ptr %t176 to i64
  %t179 = sext i32 34 to i64
  %t177 = icmp eq i64 %t178, %t179
  %t180 = zext i1 %t177 to i64
  %t181 = icmp ne i64 %t180, 0
  br i1 %t181, label %L36, label %L37
L36:
  br label %L38
L37:
  %t182 = load ptr, ptr %t1
  %t184 = ptrtoint ptr %t182 to i64
  %t185 = sext i32 35 to i64
  %t183 = icmp eq i64 %t184, %t185
  %t186 = zext i1 %t183 to i64
  %t187 = icmp ne i64 %t186, 0
  %t188 = zext i1 %t187 to i64
  br label %L38
L38:
  %t189 = phi i64 [ 1, %L36 ], [ %t188, %L37 ]
  %t190 = icmp ne i64 %t189, 0
  br i1 %t190, label %L39, label %L41
L39:
  %t191 = alloca i64
  %t192 = load ptr, ptr %t1
  %t194 = ptrtoint ptr %t192 to i64
  %t195 = sext i32 35 to i64
  %t193 = icmp eq i64 %t194, %t195
  %t196 = zext i1 %t193 to i64
  %t197 = icmp ne i64 %t196, 0
  br i1 %t197, label %L42, label %L43
L42:
  %t198 = load ptr, ptr %t1
  %t199 = sext i32 0 to i64
  %t200 = getelementptr ptr, ptr %t198, i64 %t199
  %t201 = load ptr, ptr %t200
  %t202 = call i64 @emit_expr(ptr %t0, ptr %t201)
  store i64 %t202, ptr %t191
  br label %L44
L43:
  %t203 = alloca ptr
  %t204 = load ptr, ptr %t1
  %t205 = sext i32 0 to i64
  %t206 = getelementptr ptr, ptr %t204, i64 %t205
  %t207 = load ptr, ptr %t206
  %t208 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t207)
  store ptr %t208, ptr %t203
  %t209 = load ptr, ptr %t203
  %t210 = icmp ne ptr %t209, null
  br i1 %t210, label %L45, label %L46
L45:
  %t211 = load ptr, ptr %t203
  %t212 = call ptr @default_ptr_type()
  %t213 = call i64 @make_val(ptr %t211, ptr %t212)
  store i64 %t213, ptr %t191
  %t214 = load ptr, ptr %t203
  call void @free(ptr %t214)
  br label %L47
L46:
  %t216 = load ptr, ptr %t1
  %t217 = sext i32 0 to i64
  %t218 = getelementptr ptr, ptr %t216, i64 %t217
  %t219 = load ptr, ptr %t218
  %t220 = call i64 @emit_expr(ptr %t0, ptr %t219)
  store i64 %t220, ptr %t191
  %t221 = load i64, ptr %t191
  %t222 = call i32 @val_is_ptr(i64 %t221)
  %t223 = sext i32 %t222 to i64
  %t225 = icmp eq i64 %t223, 0
  %t224 = zext i1 %t225 to i64
  %t226 = icmp ne i64 %t224, 0
  br i1 %t226, label %L48, label %L50
L48:
  %t227 = alloca i64
  %t228 = call i32 @new_reg(ptr %t0)
  %t229 = sext i32 %t228 to i64
  store i64 %t229, ptr %t227
  %t230 = alloca ptr
  %t231 = load i64, ptr %t191
  %t232 = load ptr, ptr %t230
  %t233 = call i32 @promote_to_i64(ptr %t0, i64 %t231, ptr %t232, i64 64)
  %t234 = sext i32 %t233 to i64
  %t235 = load ptr, ptr %t0
  %t236 = getelementptr [34 x i8], ptr @.str38, i64 0, i64 0
  %t237 = load i64, ptr %t227
  %t238 = load ptr, ptr %t230
  call void @__c0c_emit(ptr %t235, ptr %t236, i64 %t237, ptr %t238)
  %t240 = alloca ptr
  %t241 = load ptr, ptr %t240
  %t242 = getelementptr [6 x i8], ptr @.str39, i64 0, i64 0
  %t243 = load i64, ptr %t227
  %t244 = call i32 @snprintf(ptr %t241, i64 32, ptr %t242, i64 %t243)
  %t245 = sext i32 %t244 to i64
  %t246 = load ptr, ptr %t240
  %t247 = call ptr @default_ptr_type()
  %t248 = call i64 @make_val(ptr %t246, ptr %t247)
  store i64 %t248, ptr %t191
  br label %L50
L50:
  br label %L47
L47:
  br label %L44
L44:
  %t249 = alloca ptr
  %t250 = call ptr @malloc(i64 64)
  store ptr %t250, ptr %t249
  %t251 = load ptr, ptr %t249
  %t252 = getelementptr [3 x i8], ptr @.str40, i64 0, i64 0
  %t253 = load ptr, ptr %t191
  %t254 = call i32 @snprintf(ptr %t251, i64 64, ptr %t252, ptr %t253)
  %t255 = sext i32 %t254 to i64
  %t256 = load ptr, ptr %t249
  ret ptr %t256
L51:
  br label %L41
L41:
  %t258 = sext i32 0 to i64
  %t257 = inttoptr i64 %t258 to ptr
  ret ptr %t257
L52:
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
  %t14 = icmp ne i64 %t13, 0
  br i1 %t14, label %L4, label %L5
L4:
  br label %L6
L5:
  %t15 = load ptr, ptr %t0
  %t16 = load ptr, ptr %t15
  %t18 = ptrtoint ptr %t16 to i64
  %t19 = sext i32 16 to i64
  %t17 = icmp eq i64 %t18, %t19
  %t20 = zext i1 %t17 to i64
  %t21 = icmp ne i64 %t20, 0
  %t22 = zext i1 %t21 to i64
  br label %L6
L6:
  %t23 = phi i64 [ 1, %L4 ], [ %t22, %L5 ]
  %t24 = trunc i64 %t23 to i32
  ret i32 %t24
L7:
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
  %t11 = getelementptr [34 x i8], ptr @.str41, i64 0, i64 0
  %t12 = load i64, ptr %t7
  %t13 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t10, ptr %t11, i64 %t12, ptr %t13)
  %t15 = getelementptr [6 x i8], ptr @.str42, i64 0, i64 0
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
  %t32 = getelementptr ptr, ptr %t2, i64 %t29
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
  %t41 = getelementptr [30 x i8], ptr @.str43, i64 0, i64 0
  %t42 = load i64, ptr %t37
  %t43 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t40, ptr %t41, i64 %t42, ptr %t43)
  %t45 = getelementptr [6 x i8], ptr @.str44, i64 0, i64 0
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
  %t9 = getelementptr [32 x i8], ptr @.str45, i64 0, i64 0
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
  %t18 = getelementptr [29 x i8], ptr @.str46, i64 0, i64 0
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
  %t6 = getelementptr [2 x i8], ptr @.str47, i64 0, i64 0
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
  %t18 = getelementptr [5 x i8], ptr @.str48, i64 0, i64 0
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
  %t29 = getelementptr [31 x i8], ptr @.str49, i64 0, i64 0
  %t30 = load i64, ptr %t25
  %t31 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t28, ptr %t29, i64 %t30, ptr %t31)
  %t33 = alloca ptr
  %t34 = load ptr, ptr %t33
  %t35 = getelementptr [6 x i8], ptr @.str50, i64 0, i64 0
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
  %t45 = getelementptr [5 x i8], ptr @.str51, i64 0, i64 0
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
  %t65 = getelementptr [62 x i8], ptr @.str52, i64 0, i64 0
  %t66 = load i64, ptr %t57
  %t67 = load i64, ptr %t60
  %t68 = load i64, ptr %t53
  call void @__c0c_emit(ptr %t64, ptr %t65, i64 %t66, i64 %t67, i64 %t68)
  %t70 = alloca ptr
  %t71 = load ptr, ptr %t70
  %t72 = getelementptr [6 x i8], ptr @.str53, i64 0, i64 0
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
  %t99 = ptrtoint ptr %t98 to i64
  %t100 = icmp ne i64 %t99, 0
  br i1 %t100, label %L41, label %L42
L41:
  %t101 = load ptr, ptr %t79
  %t102 = load ptr, ptr %t101
  %t103 = load ptr, ptr %t102
  %t105 = ptrtoint ptr %t103 to i64
  %t106 = sext i32 15 to i64
  %t104 = icmp eq i64 %t105, %t106
  %t107 = zext i1 %t104 to i64
  %t108 = icmp ne i64 %t107, 0
  br i1 %t108, label %L44, label %L45
L44:
  br label %L46
L45:
  %t109 = load ptr, ptr %t79
  %t110 = load ptr, ptr %t109
  %t111 = load ptr, ptr %t110
  %t113 = ptrtoint ptr %t111 to i64
  %t114 = sext i32 16 to i64
  %t112 = icmp eq i64 %t113, %t114
  %t115 = zext i1 %t112 to i64
  %t116 = icmp ne i64 %t115, 0
  %t117 = zext i1 %t116 to i64
  br label %L46
L46:
  %t118 = phi i64 [ 1, %L44 ], [ %t117, %L45 ]
  %t119 = icmp ne i64 %t118, 0
  %t120 = zext i1 %t119 to i64
  br label %L43
L42:
  br label %L43
L43:
  %t121 = phi i64 [ %t120, %L41 ], [ 0, %L42 ]
  %t122 = icmp ne i64 %t121, 0
  br i1 %t122, label %L47, label %L48
L47:
  %t123 = getelementptr [4 x i8], ptr @.str54, i64 0, i64 0
  store ptr %t123, ptr %t95
  %t124 = call ptr @default_ptr_type()
  store ptr %t124, ptr %t96
  br label %L49
L48:
  %t125 = load ptr, ptr %t79
  %t126 = load ptr, ptr %t125
  %t127 = ptrtoint ptr %t126 to i64
  %t128 = icmp ne i64 %t127, 0
  br i1 %t128, label %L50, label %L51
L50:
  %t129 = load ptr, ptr %t79
  %t130 = load ptr, ptr %t129
  %t131 = call i32 @type_is_fp(ptr %t130)
  %t132 = sext i32 %t131 to i64
  %t133 = icmp ne i64 %t132, 0
  %t134 = zext i1 %t133 to i64
  br label %L52
L51:
  br label %L52
L52:
  %t135 = phi i64 [ %t134, %L50 ], [ 0, %L51 ]
  %t136 = icmp ne i64 %t135, 0
  br i1 %t136, label %L53, label %L54
L53:
  %t137 = load ptr, ptr %t79
  %t138 = load ptr, ptr %t137
  %t139 = call ptr @llvm_type(ptr %t138)
  store ptr %t139, ptr %t95
  %t140 = load ptr, ptr %t79
  %t141 = load ptr, ptr %t140
  store ptr %t141, ptr %t96
  br label %L55
L54:
  %t142 = getelementptr [4 x i8], ptr @.str55, i64 0, i64 0
  store ptr %t142, ptr %t95
  %t143 = call ptr @default_i64_type()
  store ptr %t143, ptr %t96
  br label %L55
L55:
  br label %L49
L49:
  %t144 = load ptr, ptr %t0
  %t145 = getelementptr [27 x i8], ptr @.str56, i64 0, i64 0
  %t146 = load i64, ptr %t92
  %t147 = load ptr, ptr %t95
  %t148 = load ptr, ptr %t79
  %t149 = load ptr, ptr %t148
  call void @__c0c_emit(ptr %t144, ptr %t145, i64 %t146, ptr %t147, ptr %t149)
  %t151 = alloca ptr
  %t152 = load ptr, ptr %t151
  %t153 = getelementptr [6 x i8], ptr @.str57, i64 0, i64 0
  %t154 = load i64, ptr %t92
  %t155 = call i32 @snprintf(ptr %t152, i64 8, ptr %t153, i64 %t154)
  %t156 = sext i32 %t155 to i64
  %t157 = load ptr, ptr %t151
  %t158 = load ptr, ptr %t96
  %t159 = call i64 @make_val(ptr %t157, ptr %t158)
  ret i64 %t159
L56:
  br label %L36
L36:
  %t160 = alloca ptr
  %t161 = load ptr, ptr %t1
  %t162 = call ptr @find_global(ptr %t0, ptr %t161)
  store ptr %t162, ptr %t160
  %t163 = load ptr, ptr %t160
  %t164 = ptrtoint ptr %t163 to i64
  %t165 = icmp ne i64 %t164, 0
  br i1 %t165, label %L57, label %L58
L57:
  %t166 = load ptr, ptr %t160
  %t167 = load ptr, ptr %t166
  %t168 = ptrtoint ptr %t167 to i64
  %t169 = icmp ne i64 %t168, 0
  %t170 = zext i1 %t169 to i64
  br label %L59
L58:
  br label %L59
L59:
  %t171 = phi i64 [ %t170, %L57 ], [ 0, %L58 ]
  %t172 = icmp ne i64 %t171, 0
  br i1 %t172, label %L60, label %L61
L60:
  %t173 = load ptr, ptr %t160
  %t174 = load ptr, ptr %t173
  %t175 = load ptr, ptr %t174
  %t177 = ptrtoint ptr %t175 to i64
  %t178 = sext i32 17 to i64
  %t176 = icmp ne i64 %t177, %t178
  %t179 = zext i1 %t176 to i64
  %t180 = icmp ne i64 %t179, 0
  %t181 = zext i1 %t180 to i64
  br label %L62
L61:
  br label %L62
L62:
  %t182 = phi i64 [ %t181, %L60 ], [ 0, %L61 ]
  %t183 = icmp ne i64 %t182, 0
  br i1 %t183, label %L63, label %L65
L63:
  %t184 = alloca i64
  %t185 = call i32 @new_reg(ptr %t0)
  %t186 = sext i32 %t185 to i64
  store i64 %t186, ptr %t184
  %t187 = alloca ptr
  %t188 = alloca ptr
  %t189 = load ptr, ptr %t160
  %t190 = load ptr, ptr %t189
  %t191 = load ptr, ptr %t190
  %t193 = ptrtoint ptr %t191 to i64
  %t194 = sext i32 15 to i64
  %t192 = icmp eq i64 %t193, %t194
  %t195 = zext i1 %t192 to i64
  %t196 = icmp ne i64 %t195, 0
  br i1 %t196, label %L66, label %L67
L66:
  br label %L68
L67:
  %t197 = load ptr, ptr %t160
  %t198 = load ptr, ptr %t197
  %t199 = load ptr, ptr %t198
  %t201 = ptrtoint ptr %t199 to i64
  %t202 = sext i32 16 to i64
  %t200 = icmp eq i64 %t201, %t202
  %t203 = zext i1 %t200 to i64
  %t204 = icmp ne i64 %t203, 0
  %t205 = zext i1 %t204 to i64
  br label %L68
L68:
  %t206 = phi i64 [ 1, %L66 ], [ %t205, %L67 ]
  %t207 = icmp ne i64 %t206, 0
  br i1 %t207, label %L69, label %L70
L69:
  %t208 = getelementptr [4 x i8], ptr @.str58, i64 0, i64 0
  store ptr %t208, ptr %t187
  %t209 = call ptr @default_ptr_type()
  store ptr %t209, ptr %t188
  br label %L71
L70:
  %t210 = load ptr, ptr %t160
  %t211 = load ptr, ptr %t210
  %t212 = call i32 @type_is_fp(ptr %t211)
  %t213 = sext i32 %t212 to i64
  %t214 = icmp ne i64 %t213, 0
  br i1 %t214, label %L72, label %L73
L72:
  %t215 = load ptr, ptr %t160
  %t216 = load ptr, ptr %t215
  %t217 = call ptr @llvm_type(ptr %t216)
  store ptr %t217, ptr %t187
  %t218 = load ptr, ptr %t160
  %t219 = load ptr, ptr %t218
  store ptr %t219, ptr %t188
  br label %L74
L73:
  %t220 = getelementptr [4 x i8], ptr @.str59, i64 0, i64 0
  store ptr %t220, ptr %t187
  %t221 = call ptr @default_i64_type()
  store ptr %t221, ptr %t188
  br label %L74
L74:
  br label %L71
L71:
  %t222 = load ptr, ptr %t0
  %t223 = getelementptr [28 x i8], ptr @.str60, i64 0, i64 0
  %t224 = load i64, ptr %t184
  %t225 = load ptr, ptr %t187
  %t226 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t222, ptr %t223, i64 %t224, ptr %t225, ptr %t226)
  %t228 = alloca ptr
  %t229 = load ptr, ptr %t228
  %t230 = getelementptr [6 x i8], ptr @.str61, i64 0, i64 0
  %t231 = load i64, ptr %t184
  %t232 = call i32 @snprintf(ptr %t229, i64 8, ptr %t230, i64 %t231)
  %t233 = sext i32 %t232 to i64
  %t234 = load ptr, ptr %t228
  %t235 = load ptr, ptr %t188
  %t236 = call i64 @make_val(ptr %t234, ptr %t235)
  ret i64 %t236
L75:
  br label %L65
L65:
  %t237 = alloca ptr
  %t238 = load ptr, ptr %t237
  %t239 = getelementptr [4 x i8], ptr @.str62, i64 0, i64 0
  %t240 = load ptr, ptr %t1
  %t241 = call i32 @snprintf(ptr %t238, i64 8, ptr %t239, ptr %t240)
  %t242 = sext i32 %t241 to i64
  %t243 = load ptr, ptr %t237
  %t244 = call ptr @default_ptr_type()
  %t245 = call i64 @make_val(ptr %t243, ptr %t244)
  ret i64 %t245
L76:
  br label %L10
L10:
  %t246 = alloca ptr
  %t247 = load ptr, ptr %t1
  %t248 = sext i32 0 to i64
  %t249 = getelementptr ptr, ptr %t247, i64 %t248
  %t250 = load ptr, ptr %t249
  store ptr %t250, ptr %t246
  %t251 = alloca ptr
  %t252 = call ptr @default_int_type()
  store ptr %t252, ptr %t251
  %t253 = alloca ptr
  %t254 = load ptr, ptr %t1
  %t256 = ptrtoint ptr %t254 to i64
  %t257 = sext i32 8 to i64
  %t255 = mul i64 %t256, %t257
  %t258 = call ptr @malloc(i64 %t255)
  store ptr %t258, ptr %t253
  %t259 = alloca ptr
  %t260 = load ptr, ptr %t1
  %t262 = ptrtoint ptr %t260 to i64
  %t263 = sext i32 8 to i64
  %t261 = mul i64 %t262, %t263
  %t264 = call ptr @malloc(i64 %t261)
  store ptr %t264, ptr %t259
  %t265 = alloca i64
  %t266 = sext i32 1 to i64
  store i64 %t266, ptr %t265
  br label %L77
L77:
  %t267 = load i64, ptr %t265
  %t268 = load ptr, ptr %t1
  %t270 = ptrtoint ptr %t268 to i64
  %t269 = icmp slt i64 %t267, %t270
  %t271 = zext i1 %t269 to i64
  %t272 = icmp ne i64 %t271, 0
  br i1 %t272, label %L78, label %L80
L78:
  %t273 = alloca i64
  %t274 = load ptr, ptr %t1
  %t275 = load i64, ptr %t265
  %t276 = getelementptr ptr, ptr %t274, i64 %t275
  %t277 = load ptr, ptr %t276
  %t278 = call i64 @emit_expr(ptr %t0, ptr %t277)
  store i64 %t278, ptr %t273
  %t279 = load ptr, ptr %t273
  %t280 = call ptr @strdup(ptr %t279)
  %t281 = load ptr, ptr %t253
  %t282 = load i64, ptr %t265
  %t283 = getelementptr ptr, ptr %t281, i64 %t282
  store ptr %t280, ptr %t283
  %t284 = load ptr, ptr %t273
  %t285 = load ptr, ptr %t259
  %t286 = load i64, ptr %t265
  %t287 = getelementptr ptr, ptr %t285, i64 %t286
  store ptr %t284, ptr %t287
  br label %L79
L79:
  %t288 = load i64, ptr %t265
  %t289 = add i64 %t288, 1
  store i64 %t289, ptr %t265
  br label %L77
L80:
  %t290 = alloca ptr
  %t291 = sext i32 0 to i64
  store i64 %t291, ptr %t290
  %t292 = load ptr, ptr %t246
  %t293 = load ptr, ptr %t292
  %t295 = ptrtoint ptr %t293 to i64
  %t296 = sext i32 23 to i64
  %t294 = icmp eq i64 %t295, %t296
  %t297 = zext i1 %t294 to i64
  %t298 = icmp ne i64 %t297, 0
  br i1 %t298, label %L81, label %L82
L81:
  %t299 = load ptr, ptr %t290
  %t300 = getelementptr [4 x i8], ptr @.str63, i64 0, i64 0
  %t301 = load ptr, ptr %t246
  %t302 = load ptr, ptr %t301
  %t303 = call i32 @snprintf(ptr %t299, i64 8, ptr %t300, ptr %t302)
  %t304 = sext i32 %t303 to i64
  %t305 = alloca ptr
  %t306 = load ptr, ptr %t246
  %t307 = load ptr, ptr %t306
  %t308 = call ptr @find_global(ptr %t0, ptr %t307)
  store ptr %t308, ptr %t305
  %t309 = load ptr, ptr %t305
  %t310 = ptrtoint ptr %t309 to i64
  %t311 = icmp ne i64 %t310, 0
  br i1 %t311, label %L84, label %L85
L84:
  %t312 = load ptr, ptr %t305
  %t313 = load ptr, ptr %t312
  %t314 = ptrtoint ptr %t313 to i64
  %t315 = icmp ne i64 %t314, 0
  %t316 = zext i1 %t315 to i64
  br label %L86
L85:
  br label %L86
L86:
  %t317 = phi i64 [ %t316, %L84 ], [ 0, %L85 ]
  %t318 = icmp ne i64 %t317, 0
  br i1 %t318, label %L87, label %L88
L87:
  %t319 = load ptr, ptr %t305
  %t320 = load ptr, ptr %t319
  %t321 = load ptr, ptr %t320
  %t323 = ptrtoint ptr %t321 to i64
  %t324 = sext i32 17 to i64
  %t322 = icmp eq i64 %t323, %t324
  %t325 = zext i1 %t322 to i64
  %t326 = icmp ne i64 %t325, 0
  %t327 = zext i1 %t326 to i64
  br label %L89
L88:
  br label %L89
L89:
  %t328 = phi i64 [ %t327, %L87 ], [ 0, %L88 ]
  %t329 = icmp ne i64 %t328, 0
  br i1 %t329, label %L90, label %L91
L90:
  %t330 = load ptr, ptr %t305
  %t331 = load ptr, ptr %t330
  %t332 = load ptr, ptr %t331
  store ptr %t332, ptr %t251
  br label %L92
L91:
  %t333 = alloca ptr
  %t334 = sext i32 0 to i64
  store i64 %t334, ptr %t333
  %t335 = alloca i64
  %t336 = sext i32 0 to i64
  store i64 %t336, ptr %t335
  br label %L93
L93:
  %t337 = load ptr, ptr %t333
  %t338 = load i64, ptr %t335
  %t339 = getelementptr ptr, ptr %t337, i64 %t338
  %t340 = load ptr, ptr %t339
  %t341 = icmp ne ptr %t340, null
  br i1 %t341, label %L94, label %L96
L94:
  %t342 = load ptr, ptr %t246
  %t343 = load ptr, ptr %t342
  %t344 = load ptr, ptr %t333
  %t345 = load i64, ptr %t335
  %t346 = getelementptr ptr, ptr %t344, i64 %t345
  %t347 = load ptr, ptr %t346
  %t348 = call i32 @strcmp(ptr %t343, ptr %t347)
  %t349 = sext i32 %t348 to i64
  %t351 = sext i32 0 to i64
  %t350 = icmp eq i64 %t349, %t351
  %t352 = zext i1 %t350 to i64
  %t353 = icmp ne i64 %t352, 0
  br i1 %t353, label %L97, label %L99
L97:
  %t354 = call ptr @default_ptr_type()
  store ptr %t354, ptr %t251
  br label %L96
L100:
  br label %L99
L99:
  br label %L95
L95:
  %t355 = load i64, ptr %t335
  %t356 = add i64 %t355, 1
  store i64 %t356, ptr %t335
  br label %L93
L96:
  %t357 = alloca ptr
  %t358 = sext i32 0 to i64
  store i64 %t358, ptr %t357
  %t359 = alloca i64
  %t360 = sext i32 0 to i64
  store i64 %t360, ptr %t359
  br label %L101
L101:
  %t361 = load ptr, ptr %t357
  %t362 = load i64, ptr %t359
  %t363 = getelementptr ptr, ptr %t361, i64 %t362
  %t364 = load ptr, ptr %t363
  %t365 = icmp ne ptr %t364, null
  br i1 %t365, label %L102, label %L104
L102:
  %t366 = load ptr, ptr %t246
  %t367 = load ptr, ptr %t366
  %t368 = load ptr, ptr %t357
  %t369 = load i64, ptr %t359
  %t370 = getelementptr ptr, ptr %t368, i64 %t369
  %t371 = load ptr, ptr %t370
  %t372 = call i32 @strcmp(ptr %t367, ptr %t371)
  %t373 = sext i32 %t372 to i64
  %t375 = sext i32 0 to i64
  %t374 = icmp eq i64 %t373, %t375
  %t376 = zext i1 %t374 to i64
  %t377 = icmp ne i64 %t376, 0
  br i1 %t377, label %L105, label %L107
L105:
  %t378 = call ptr @default_i64_type()
  store ptr %t378, ptr %t251
  br label %L104
L108:
  br label %L107
L107:
  br label %L103
L103:
  %t379 = load i64, ptr %t359
  %t380 = add i64 %t379, 1
  store i64 %t380, ptr %t359
  br label %L101
L104:
  %t381 = alloca i64
  %t382 = sext i32 0 to i64
  store i64 %t382, ptr %t381
  %t383 = alloca ptr
  %t384 = sext i32 0 to i64
  store i64 %t384, ptr %t383
  %t385 = alloca i64
  %t386 = sext i32 0 to i64
  store i64 %t386, ptr %t385
  br label %L109
L109:
  %t387 = load ptr, ptr %t383
  %t388 = load i64, ptr %t385
  %t389 = getelementptr ptr, ptr %t387, i64 %t388
  %t390 = load ptr, ptr %t389
  %t391 = icmp ne ptr %t390, null
  br i1 %t391, label %L110, label %L112
L110:
  %t392 = load ptr, ptr %t246
  %t393 = load ptr, ptr %t392
  %t394 = load ptr, ptr %t383
  %t395 = load i64, ptr %t385
  %t396 = getelementptr ptr, ptr %t394, i64 %t395
  %t397 = load ptr, ptr %t396
  %t398 = call i32 @strcmp(ptr %t393, ptr %t397)
  %t399 = sext i32 %t398 to i64
  %t401 = sext i32 0 to i64
  %t400 = icmp eq i64 %t399, %t401
  %t402 = zext i1 %t400 to i64
  %t403 = icmp ne i64 %t402, 0
  br i1 %t403, label %L113, label %L115
L113:
  store ptr %t381, ptr %t251
  br label %L112
L116:
  br label %L115
L115:
  br label %L111
L111:
  %t404 = load i64, ptr %t385
  %t405 = add i64 %t404, 1
  store i64 %t405, ptr %t385
  br label %L109
L112:
  br label %L92
L92:
  br label %L83
L82:
  %t406 = alloca i64
  %t407 = load ptr, ptr %t246
  %t408 = call i64 @emit_expr(ptr %t0, ptr %t407)
  store i64 %t408, ptr %t406
  %t409 = load ptr, ptr %t290
  %t410 = load ptr, ptr %t406
  %t412 = sext i32 8 to i64
  %t413 = sext i32 1 to i64
  %t411 = sub i64 %t412, %t413
  %t414 = call ptr @strncpy(ptr %t409, ptr %t410, i64 %t411)
  br label %L83
L83:
  %t415 = alloca i64
  %t416 = call i32 @new_reg(ptr %t0)
  %t417 = sext i32 %t416 to i64
  store i64 %t417, ptr %t415
  %t418 = alloca ptr
  %t419 = load ptr, ptr %t251
  %t420 = call ptr @llvm_type(ptr %t419)
  store ptr %t420, ptr %t418
  %t421 = alloca i64
  %t422 = load ptr, ptr %t251
  %t423 = load ptr, ptr %t422
  %t425 = ptrtoint ptr %t423 to i64
  %t426 = sext i32 0 to i64
  %t424 = icmp eq i64 %t425, %t426
  %t427 = zext i1 %t424 to i64
  store i64 %t427, ptr %t421
  %t428 = load i64, ptr %t421
  %t429 = icmp ne i64 %t428, 0
  br i1 %t429, label %L117, label %L118
L117:
  %t430 = load ptr, ptr %t0
  %t431 = getelementptr [16 x i8], ptr @.str64, i64 0, i64 0
  %t432 = load ptr, ptr %t290
  call void @__c0c_emit(ptr %t430, ptr %t431, ptr %t432)
  br label %L119
L118:
  %t434 = load ptr, ptr %t0
  %t435 = getelementptr [22 x i8], ptr @.str65, i64 0, i64 0
  %t436 = load i64, ptr %t415
  %t437 = load ptr, ptr %t418
  %t438 = load ptr, ptr %t290
  call void @__c0c_emit(ptr %t434, ptr %t435, i64 %t436, ptr %t437, ptr %t438)
  br label %L119
L119:
  %t440 = alloca i64
  %t441 = sext i32 1 to i64
  store i64 %t441, ptr %t440
  br label %L120
L120:
  %t442 = load i64, ptr %t440
  %t443 = load ptr, ptr %t1
  %t445 = ptrtoint ptr %t443 to i64
  %t444 = icmp slt i64 %t442, %t445
  %t446 = zext i1 %t444 to i64
  %t447 = icmp ne i64 %t446, 0
  br i1 %t447, label %L121, label %L123
L121:
  %t448 = load i64, ptr %t440
  %t450 = sext i32 1 to i64
  %t449 = icmp sgt i64 %t448, %t450
  %t451 = zext i1 %t449 to i64
  %t452 = icmp ne i64 %t451, 0
  br i1 %t452, label %L124, label %L126
L124:
  %t453 = load ptr, ptr %t0
  %t454 = getelementptr [3 x i8], ptr @.str66, i64 0, i64 0
  call void @__c0c_emit(ptr %t453, ptr %t454)
  br label %L126
L126:
  %t456 = alloca ptr
  %t457 = load ptr, ptr %t259
  %t458 = load i64, ptr %t440
  %t459 = getelementptr ptr, ptr %t457, i64 %t458
  %t460 = load ptr, ptr %t459
  %t461 = ptrtoint ptr %t460 to i64
  %t462 = icmp ne i64 %t461, 0
  br i1 %t462, label %L127, label %L128
L127:
  %t463 = load ptr, ptr %t259
  %t464 = load i64, ptr %t440
  %t465 = getelementptr ptr, ptr %t463, i64 %t464
  %t466 = load ptr, ptr %t465
  %t467 = load ptr, ptr %t466
  %t469 = ptrtoint ptr %t467 to i64
  %t470 = sext i32 15 to i64
  %t468 = icmp eq i64 %t469, %t470
  %t471 = zext i1 %t468 to i64
  %t472 = icmp ne i64 %t471, 0
  br i1 %t472, label %L130, label %L131
L130:
  br label %L132
L131:
  %t473 = load ptr, ptr %t259
  %t474 = load i64, ptr %t440
  %t475 = getelementptr ptr, ptr %t473, i64 %t474
  %t476 = load ptr, ptr %t475
  %t477 = load ptr, ptr %t476
  %t479 = ptrtoint ptr %t477 to i64
  %t480 = sext i32 16 to i64
  %t478 = icmp eq i64 %t479, %t480
  %t481 = zext i1 %t478 to i64
  %t482 = icmp ne i64 %t481, 0
  %t483 = zext i1 %t482 to i64
  br label %L132
L132:
  %t484 = phi i64 [ 1, %L130 ], [ %t483, %L131 ]
  %t485 = icmp ne i64 %t484, 0
  %t486 = zext i1 %t485 to i64
  br label %L129
L128:
  br label %L129
L129:
  %t487 = phi i64 [ %t486, %L127 ], [ 0, %L128 ]
  %t488 = icmp ne i64 %t487, 0
  br i1 %t488, label %L133, label %L134
L133:
  %t489 = getelementptr [4 x i8], ptr @.str67, i64 0, i64 0
  store ptr %t489, ptr %t456
  br label %L135
L134:
  %t490 = load ptr, ptr %t259
  %t491 = load i64, ptr %t440
  %t492 = getelementptr ptr, ptr %t490, i64 %t491
  %t493 = load ptr, ptr %t492
  %t494 = ptrtoint ptr %t493 to i64
  %t495 = icmp ne i64 %t494, 0
  br i1 %t495, label %L136, label %L137
L136:
  %t496 = load ptr, ptr %t259
  %t497 = load i64, ptr %t440
  %t498 = getelementptr ptr, ptr %t496, i64 %t497
  %t499 = load ptr, ptr %t498
  %t500 = call i32 @type_is_fp(ptr %t499)
  %t501 = sext i32 %t500 to i64
  %t502 = icmp ne i64 %t501, 0
  %t503 = zext i1 %t502 to i64
  br label %L138
L137:
  br label %L138
L138:
  %t504 = phi i64 [ %t503, %L136 ], [ 0, %L137 ]
  %t505 = icmp ne i64 %t504, 0
  br i1 %t505, label %L139, label %L140
L139:
  %t506 = load ptr, ptr %t259
  %t507 = load i64, ptr %t440
  %t508 = getelementptr ptr, ptr %t506, i64 %t507
  %t509 = load ptr, ptr %t508
  %t510 = call ptr @llvm_type(ptr %t509)
  store ptr %t510, ptr %t456
  br label %L141
L140:
  %t511 = getelementptr [4 x i8], ptr @.str68, i64 0, i64 0
  store ptr %t511, ptr %t456
  br label %L141
L141:
  br label %L135
L135:
  %t512 = load ptr, ptr %t0
  %t513 = getelementptr [6 x i8], ptr @.str69, i64 0, i64 0
  %t514 = load ptr, ptr %t456
  %t515 = load ptr, ptr %t253
  %t516 = load i64, ptr %t440
  %t517 = getelementptr ptr, ptr %t515, i64 %t516
  %t518 = load ptr, ptr %t517
  call void @__c0c_emit(ptr %t512, ptr %t513, ptr %t514, ptr %t518)
  br label %L122
L122:
  %t520 = load i64, ptr %t440
  %t521 = add i64 %t520, 1
  store i64 %t521, ptr %t440
  br label %L120
L123:
  %t522 = load ptr, ptr %t0
  %t523 = getelementptr [3 x i8], ptr @.str70, i64 0, i64 0
  call void @__c0c_emit(ptr %t522, ptr %t523)
  %t525 = alloca i64
  %t526 = sext i32 1 to i64
  store i64 %t526, ptr %t525
  br label %L142
L142:
  %t527 = load i64, ptr %t525
  %t528 = load ptr, ptr %t1
  %t530 = ptrtoint ptr %t528 to i64
  %t529 = icmp slt i64 %t527, %t530
  %t531 = zext i1 %t529 to i64
  %t532 = icmp ne i64 %t531, 0
  br i1 %t532, label %L143, label %L145
L143:
  %t533 = load ptr, ptr %t253
  %t534 = load i64, ptr %t525
  %t535 = getelementptr ptr, ptr %t533, i64 %t534
  %t536 = load ptr, ptr %t535
  call void @free(ptr %t536)
  br label %L144
L144:
  %t538 = load i64, ptr %t525
  %t539 = add i64 %t538, 1
  store i64 %t539, ptr %t525
  br label %L142
L145:
  %t540 = load ptr, ptr %t253
  call void @free(ptr %t540)
  %t542 = load ptr, ptr %t259
  call void @free(ptr %t542)
  %t544 = load i64, ptr %t421
  %t545 = icmp ne i64 %t544, 0
  br i1 %t545, label %L146, label %L148
L146:
  %t546 = getelementptr [2 x i8], ptr @.str71, i64 0, i64 0
  %t547 = load ptr, ptr %t251
  %t548 = call i64 @make_val(ptr %t546, ptr %t547)
  ret i64 %t548
L149:
  br label %L148
L148:
  %t549 = alloca ptr
  %t550 = load ptr, ptr %t549
  %t551 = getelementptr [6 x i8], ptr @.str72, i64 0, i64 0
  %t552 = load i64, ptr %t415
  %t553 = call i32 @snprintf(ptr %t550, i64 8, ptr %t551, i64 %t552)
  %t554 = sext i32 %t553 to i64
  %t555 = alloca ptr
  %t556 = load ptr, ptr %t251
  store ptr %t556, ptr %t555
  %t557 = load ptr, ptr %t251
  %t558 = call i32 @type_is_fp(ptr %t557)
  %t559 = sext i32 %t558 to i64
  %t561 = icmp eq i64 %t559, 0
  %t560 = zext i1 %t561 to i64
  %t562 = icmp ne i64 %t560, 0
  br i1 %t562, label %L150, label %L151
L150:
  %t563 = load ptr, ptr %t251
  %t564 = load ptr, ptr %t563
  %t566 = ptrtoint ptr %t564 to i64
  %t567 = sext i32 15 to i64
  %t565 = icmp ne i64 %t566, %t567
  %t568 = zext i1 %t565 to i64
  %t569 = icmp ne i64 %t568, 0
  %t570 = zext i1 %t569 to i64
  br label %L152
L151:
  br label %L152
L152:
  %t571 = phi i64 [ %t570, %L150 ], [ 0, %L151 ]
  %t572 = icmp ne i64 %t571, 0
  br i1 %t572, label %L153, label %L154
L153:
  %t573 = load ptr, ptr %t251
  %t574 = load ptr, ptr %t573
  %t576 = ptrtoint ptr %t574 to i64
  %t577 = sext i32 16 to i64
  %t575 = icmp ne i64 %t576, %t577
  %t578 = zext i1 %t575 to i64
  %t579 = icmp ne i64 %t578, 0
  %t580 = zext i1 %t579 to i64
  br label %L155
L154:
  br label %L155
L155:
  %t581 = phi i64 [ %t580, %L153 ], [ 0, %L154 ]
  %t582 = icmp ne i64 %t581, 0
  br i1 %t582, label %L156, label %L157
L156:
  %t583 = load ptr, ptr %t251
  %t584 = load ptr, ptr %t583
  %t586 = ptrtoint ptr %t584 to i64
  %t587 = sext i32 0 to i64
  %t585 = icmp ne i64 %t586, %t587
  %t588 = zext i1 %t585 to i64
  %t589 = icmp ne i64 %t588, 0
  %t590 = zext i1 %t589 to i64
  br label %L158
L157:
  br label %L158
L158:
  %t591 = phi i64 [ %t590, %L156 ], [ 0, %L157 ]
  %t592 = icmp ne i64 %t591, 0
  br i1 %t592, label %L159, label %L161
L159:
  %t593 = alloca i64
  %t594 = load ptr, ptr %t251
  %t595 = call i32 @type_size(ptr %t594)
  %t596 = sext i32 %t595 to i64
  store i64 %t596, ptr %t593
  %t597 = load i64, ptr %t593
  %t599 = sext i32 0 to i64
  %t598 = icmp sgt i64 %t597, %t599
  %t600 = zext i1 %t598 to i64
  %t601 = icmp ne i64 %t600, 0
  br i1 %t601, label %L162, label %L163
L162:
  %t602 = load i64, ptr %t593
  %t604 = sext i32 8 to i64
  %t603 = icmp slt i64 %t602, %t604
  %t605 = zext i1 %t603 to i64
  %t606 = icmp ne i64 %t605, 0
  %t607 = zext i1 %t606 to i64
  br label %L164
L163:
  br label %L164
L164:
  %t608 = phi i64 [ %t607, %L162 ], [ 0, %L163 ]
  %t609 = icmp ne i64 %t608, 0
  br i1 %t609, label %L165, label %L166
L165:
  %t610 = load ptr, ptr %t418
  %t611 = getelementptr [4 x i8], ptr @.str73, i64 0, i64 0
  %t612 = call i32 @strcmp(ptr %t610, ptr %t611)
  %t613 = sext i32 %t612 to i64
  %t615 = sext i32 0 to i64
  %t614 = icmp ne i64 %t613, %t615
  %t616 = zext i1 %t614 to i64
  %t617 = icmp ne i64 %t616, 0
  %t618 = zext i1 %t617 to i64
  br label %L167
L166:
  br label %L167
L167:
  %t619 = phi i64 [ %t618, %L165 ], [ 0, %L166 ]
  %t620 = icmp ne i64 %t619, 0
  br i1 %t620, label %L168, label %L170
L168:
  %t621 = alloca i64
  %t622 = call i32 @new_reg(ptr %t0)
  %t623 = sext i32 %t622 to i64
  store i64 %t623, ptr %t621
  %t624 = load ptr, ptr %t0
  %t625 = getelementptr [32 x i8], ptr @.str74, i64 0, i64 0
  %t626 = load i64, ptr %t621
  %t627 = load ptr, ptr %t418
  %t628 = load i64, ptr %t415
  call void @__c0c_emit(ptr %t624, ptr %t625, i64 %t626, ptr %t627, i64 %t628)
  %t630 = load ptr, ptr %t549
  %t631 = getelementptr [6 x i8], ptr @.str75, i64 0, i64 0
  %t632 = load i64, ptr %t621
  %t633 = call i32 @snprintf(ptr %t630, i64 8, ptr %t631, i64 %t632)
  %t634 = sext i32 %t633 to i64
  br label %L170
L170:
  %t635 = call ptr @default_i64_type()
  store ptr %t635, ptr %t555
  br label %L161
L161:
  %t636 = load ptr, ptr %t549
  %t637 = load ptr, ptr %t555
  %t638 = call i64 @make_val(ptr %t636, ptr %t637)
  ret i64 %t638
L171:
  br label %L11
L11:
  %t639 = load ptr, ptr %t1
  %t641 = ptrtoint ptr %t639 to i64
  %t642 = sext i32 52 to i64
  %t640 = icmp eq i64 %t641, %t642
  %t643 = zext i1 %t640 to i64
  %t644 = icmp ne i64 %t643, 0
  br i1 %t644, label %L172, label %L174
L172:
  %t645 = alloca i64
  %t646 = load ptr, ptr %t1
  %t647 = sext i32 0 to i64
  %t648 = getelementptr ptr, ptr %t646, i64 %t647
  %t649 = load ptr, ptr %t648
  %t650 = call i64 @emit_expr(ptr %t0, ptr %t649)
  store i64 %t650, ptr %t645
  %t651 = alloca i64
  %t652 = call i32 @new_label(ptr %t0)
  %t653 = sext i32 %t652 to i64
  store i64 %t653, ptr %t651
  %t654 = alloca i64
  %t655 = call i32 @new_label(ptr %t0)
  %t656 = sext i32 %t655 to i64
  store i64 %t656, ptr %t654
  %t657 = alloca i64
  %t658 = call i32 @new_label(ptr %t0)
  %t659 = sext i32 %t658 to i64
  store i64 %t659, ptr %t657
  %t660 = alloca ptr
  %t661 = load i64, ptr %t645
  %t662 = load ptr, ptr %t660
  %t663 = call i32 @promote_to_i64(ptr %t0, i64 %t661, ptr %t662, i64 64)
  %t664 = sext i32 %t663 to i64
  %t665 = alloca i64
  %t666 = call i32 @new_reg(ptr %t0)
  %t667 = sext i32 %t666 to i64
  store i64 %t667, ptr %t665
  %t668 = load ptr, ptr %t0
  %t669 = getelementptr [29 x i8], ptr @.str76, i64 0, i64 0
  %t670 = load i64, ptr %t665
  %t671 = load ptr, ptr %t660
  call void @__c0c_emit(ptr %t668, ptr %t669, i64 %t670, ptr %t671)
  %t673 = load ptr, ptr %t0
  %t674 = getelementptr [41 x i8], ptr @.str77, i64 0, i64 0
  %t675 = load i64, ptr %t665
  %t676 = load i64, ptr %t651
  %t677 = load i64, ptr %t654
  call void @__c0c_emit(ptr %t673, ptr %t674, i64 %t675, i64 %t676, i64 %t677)
  %t679 = load ptr, ptr %t0
  %t680 = getelementptr [6 x i8], ptr @.str78, i64 0, i64 0
  %t681 = load i64, ptr %t651
  call void @__c0c_emit(ptr %t679, ptr %t680, i64 %t681)
  %t683 = alloca i64
  %t684 = load ptr, ptr %t1
  %t685 = sext i32 1 to i64
  %t686 = getelementptr ptr, ptr %t684, i64 %t685
  %t687 = load ptr, ptr %t686
  %t688 = call i64 @emit_expr(ptr %t0, ptr %t687)
  store i64 %t688, ptr %t683
  %t689 = alloca ptr
  %t690 = load i64, ptr %t683
  %t691 = load ptr, ptr %t689
  %t692 = call i32 @promote_to_i64(ptr %t0, i64 %t690, ptr %t691, i64 64)
  %t693 = sext i32 %t692 to i64
  %t694 = alloca i64
  %t695 = call i32 @new_reg(ptr %t0)
  %t696 = sext i32 %t695 to i64
  store i64 %t696, ptr %t694
  %t697 = alloca i64
  %t698 = call i32 @new_reg(ptr %t0)
  %t699 = sext i32 %t698 to i64
  store i64 %t699, ptr %t697
  %t700 = load ptr, ptr %t0
  %t701 = getelementptr [29 x i8], ptr @.str79, i64 0, i64 0
  %t702 = load i64, ptr %t694
  %t703 = load ptr, ptr %t689
  call void @__c0c_emit(ptr %t700, ptr %t701, i64 %t702, ptr %t703)
  %t705 = load ptr, ptr %t0
  %t706 = getelementptr [32 x i8], ptr @.str80, i64 0, i64 0
  %t707 = load i64, ptr %t697
  %t708 = load i64, ptr %t694
  call void @__c0c_emit(ptr %t705, ptr %t706, i64 %t707, i64 %t708)
  %t710 = load ptr, ptr %t0
  %t711 = getelementptr [18 x i8], ptr @.str81, i64 0, i64 0
  %t712 = load i64, ptr %t657
  call void @__c0c_emit(ptr %t710, ptr %t711, i64 %t712)
  %t714 = load ptr, ptr %t0
  %t715 = getelementptr [6 x i8], ptr @.str82, i64 0, i64 0
  %t716 = load i64, ptr %t654
  call void @__c0c_emit(ptr %t714, ptr %t715, i64 %t716)
  %t718 = load ptr, ptr %t0
  %t719 = getelementptr [18 x i8], ptr @.str83, i64 0, i64 0
  %t720 = load i64, ptr %t657
  call void @__c0c_emit(ptr %t718, ptr %t719, i64 %t720)
  %t722 = load ptr, ptr %t0
  %t723 = getelementptr [6 x i8], ptr @.str84, i64 0, i64 0
  %t724 = load i64, ptr %t657
  call void @__c0c_emit(ptr %t722, ptr %t723, i64 %t724)
  %t726 = alloca i64
  %t727 = call i32 @new_reg(ptr %t0)
  %t728 = sext i32 %t727 to i64
  store i64 %t728, ptr %t726
  %t729 = load ptr, ptr %t0
  %t730 = getelementptr [50 x i8], ptr @.str85, i64 0, i64 0
  %t731 = load i64, ptr %t726
  %t732 = load i64, ptr %t697
  %t733 = load i64, ptr %t651
  %t734 = load i64, ptr %t654
  call void @__c0c_emit(ptr %t729, ptr %t730, i64 %t731, i64 %t732, i64 %t733, i64 %t734)
  %t736 = alloca ptr
  %t737 = load ptr, ptr %t736
  %t738 = getelementptr [6 x i8], ptr @.str86, i64 0, i64 0
  %t739 = load i64, ptr %t726
  %t740 = call i32 @snprintf(ptr %t737, i64 8, ptr %t738, i64 %t739)
  %t741 = sext i32 %t740 to i64
  %t742 = load ptr, ptr %t736
  %t743 = call ptr @default_i64_type()
  %t744 = call i64 @make_val(ptr %t742, ptr %t743)
  ret i64 %t744
L175:
  br label %L174
L174:
  %t745 = load ptr, ptr %t1
  %t747 = ptrtoint ptr %t745 to i64
  %t748 = sext i32 53 to i64
  %t746 = icmp eq i64 %t747, %t748
  %t749 = zext i1 %t746 to i64
  %t750 = icmp ne i64 %t749, 0
  br i1 %t750, label %L176, label %L178
L176:
  %t751 = alloca i64
  %t752 = load ptr, ptr %t1
  %t753 = sext i32 0 to i64
  %t754 = getelementptr ptr, ptr %t752, i64 %t753
  %t755 = load ptr, ptr %t754
  %t756 = call i64 @emit_expr(ptr %t0, ptr %t755)
  store i64 %t756, ptr %t751
  %t757 = alloca i64
  %t758 = call i32 @new_label(ptr %t0)
  %t759 = sext i32 %t758 to i64
  store i64 %t759, ptr %t757
  %t760 = alloca i64
  %t761 = call i32 @new_label(ptr %t0)
  %t762 = sext i32 %t761 to i64
  store i64 %t762, ptr %t760
  %t763 = alloca i64
  %t764 = call i32 @new_label(ptr %t0)
  %t765 = sext i32 %t764 to i64
  store i64 %t765, ptr %t763
  %t766 = alloca ptr
  %t767 = load i64, ptr %t751
  %t768 = load ptr, ptr %t766
  %t769 = call i32 @promote_to_i64(ptr %t0, i64 %t767, ptr %t768, i64 64)
  %t770 = sext i32 %t769 to i64
  %t771 = alloca i64
  %t772 = call i32 @new_reg(ptr %t0)
  %t773 = sext i32 %t772 to i64
  store i64 %t773, ptr %t771
  %t774 = load ptr, ptr %t0
  %t775 = getelementptr [29 x i8], ptr @.str87, i64 0, i64 0
  %t776 = load i64, ptr %t771
  %t777 = load ptr, ptr %t766
  call void @__c0c_emit(ptr %t774, ptr %t775, i64 %t776, ptr %t777)
  %t779 = load ptr, ptr %t0
  %t780 = getelementptr [41 x i8], ptr @.str88, i64 0, i64 0
  %t781 = load i64, ptr %t771
  %t782 = load i64, ptr %t757
  %t783 = load i64, ptr %t760
  call void @__c0c_emit(ptr %t779, ptr %t780, i64 %t781, i64 %t782, i64 %t783)
  %t785 = load ptr, ptr %t0
  %t786 = getelementptr [6 x i8], ptr @.str89, i64 0, i64 0
  %t787 = load i64, ptr %t757
  call void @__c0c_emit(ptr %t785, ptr %t786, i64 %t787)
  %t789 = load ptr, ptr %t0
  %t790 = getelementptr [18 x i8], ptr @.str90, i64 0, i64 0
  %t791 = load i64, ptr %t763
  call void @__c0c_emit(ptr %t789, ptr %t790, i64 %t791)
  %t793 = load ptr, ptr %t0
  %t794 = getelementptr [6 x i8], ptr @.str91, i64 0, i64 0
  %t795 = load i64, ptr %t760
  call void @__c0c_emit(ptr %t793, ptr %t794, i64 %t795)
  %t797 = alloca i64
  %t798 = load ptr, ptr %t1
  %t799 = sext i32 1 to i64
  %t800 = getelementptr ptr, ptr %t798, i64 %t799
  %t801 = load ptr, ptr %t800
  %t802 = call i64 @emit_expr(ptr %t0, ptr %t801)
  store i64 %t802, ptr %t797
  %t803 = alloca ptr
  %t804 = load i64, ptr %t797
  %t805 = load ptr, ptr %t803
  %t806 = call i32 @promote_to_i64(ptr %t0, i64 %t804, ptr %t805, i64 64)
  %t807 = sext i32 %t806 to i64
  %t808 = alloca i64
  %t809 = call i32 @new_reg(ptr %t0)
  %t810 = sext i32 %t809 to i64
  store i64 %t810, ptr %t808
  %t811 = alloca i64
  %t812 = call i32 @new_reg(ptr %t0)
  %t813 = sext i32 %t812 to i64
  store i64 %t813, ptr %t811
  %t814 = load ptr, ptr %t0
  %t815 = getelementptr [29 x i8], ptr @.str92, i64 0, i64 0
  %t816 = load i64, ptr %t808
  %t817 = load ptr, ptr %t803
  call void @__c0c_emit(ptr %t814, ptr %t815, i64 %t816, ptr %t817)
  %t819 = load ptr, ptr %t0
  %t820 = getelementptr [32 x i8], ptr @.str93, i64 0, i64 0
  %t821 = load i64, ptr %t811
  %t822 = load i64, ptr %t808
  call void @__c0c_emit(ptr %t819, ptr %t820, i64 %t821, i64 %t822)
  %t824 = load ptr, ptr %t0
  %t825 = getelementptr [18 x i8], ptr @.str94, i64 0, i64 0
  %t826 = load i64, ptr %t763
  call void @__c0c_emit(ptr %t824, ptr %t825, i64 %t826)
  %t828 = load ptr, ptr %t0
  %t829 = getelementptr [6 x i8], ptr @.str95, i64 0, i64 0
  %t830 = load i64, ptr %t763
  call void @__c0c_emit(ptr %t828, ptr %t829, i64 %t830)
  %t832 = alloca i64
  %t833 = call i32 @new_reg(ptr %t0)
  %t834 = sext i32 %t833 to i64
  store i64 %t834, ptr %t832
  %t835 = load ptr, ptr %t0
  %t836 = getelementptr [50 x i8], ptr @.str96, i64 0, i64 0
  %t837 = load i64, ptr %t832
  %t838 = load i64, ptr %t757
  %t839 = load i64, ptr %t811
  %t840 = load i64, ptr %t760
  call void @__c0c_emit(ptr %t835, ptr %t836, i64 %t837, i64 %t838, i64 %t839, i64 %t840)
  %t842 = alloca ptr
  %t843 = load ptr, ptr %t842
  %t844 = getelementptr [6 x i8], ptr @.str97, i64 0, i64 0
  %t845 = load i64, ptr %t832
  %t846 = call i32 @snprintf(ptr %t843, i64 8, ptr %t844, i64 %t845)
  %t847 = sext i32 %t846 to i64
  %t848 = load ptr, ptr %t842
  %t849 = call ptr @default_i64_type()
  %t850 = call i64 @make_val(ptr %t848, ptr %t849)
  ret i64 %t850
L179:
  br label %L178
L178:
  %t851 = alloca i64
  %t852 = load ptr, ptr %t1
  %t853 = sext i32 0 to i64
  %t854 = getelementptr ptr, ptr %t852, i64 %t853
  %t855 = load ptr, ptr %t854
  %t856 = call i64 @emit_expr(ptr %t0, ptr %t855)
  store i64 %t856, ptr %t851
  %t857 = alloca i64
  %t858 = load ptr, ptr %t1
  %t859 = sext i32 1 to i64
  %t860 = getelementptr ptr, ptr %t858, i64 %t859
  %t861 = load ptr, ptr %t860
  %t862 = call i64 @emit_expr(ptr %t0, ptr %t861)
  store i64 %t862, ptr %t857
  %t863 = alloca i64
  %t864 = call i32 @new_reg(ptr %t0)
  %t865 = sext i32 %t864 to i64
  store i64 %t865, ptr %t863
  %t866 = alloca i64
  %t867 = load ptr, ptr %t851
  %t868 = call i32 @type_is_fp(ptr %t867)
  %t869 = sext i32 %t868 to i64
  %t870 = icmp ne i64 %t869, 0
  br i1 %t870, label %L180, label %L181
L180:
  br label %L182
L181:
  %t871 = load ptr, ptr %t857
  %t872 = call i32 @type_is_fp(ptr %t871)
  %t873 = sext i32 %t872 to i64
  %t874 = icmp ne i64 %t873, 0
  %t875 = zext i1 %t874 to i64
  br label %L182
L182:
  %t876 = phi i64 [ 1, %L180 ], [ %t875, %L181 ]
  store i64 %t876, ptr %t866
  %t877 = alloca i64
  %t878 = load i64, ptr %t851
  %t879 = call i32 @val_is_ptr(i64 %t878)
  %t880 = sext i32 %t879 to i64
  store i64 %t880, ptr %t877
  %t881 = alloca ptr
  %t882 = load i64, ptr %t866
  %t883 = icmp ne i64 %t882, 0
  br i1 %t883, label %L183, label %L184
L183:
  %t884 = load ptr, ptr %t851
  %t885 = call ptr @llvm_type(ptr %t884)
  %t886 = ptrtoint ptr %t885 to i64
  br label %L185
L184:
  %t887 = getelementptr [4 x i8], ptr @.str98, i64 0, i64 0
  %t888 = ptrtoint ptr %t887 to i64
  br label %L185
L185:
  %t889 = phi i64 [ %t886, %L183 ], [ %t888, %L184 ]
  store i64 %t889, ptr %t881
  %t890 = alloca ptr
  %t891 = alloca ptr
  %t892 = load ptr, ptr %t890
  %t894 = sext i32 0 to i64
  %t893 = getelementptr ptr, ptr %t892, i64 %t894
  %t895 = sext i32 0 to i64
  store i64 %t895, ptr %t893
  %t896 = load ptr, ptr %t891
  %t898 = sext i32 0 to i64
  %t897 = getelementptr ptr, ptr %t896, i64 %t898
  %t899 = sext i32 0 to i64
  store i64 %t899, ptr %t897
  %t900 = load i64, ptr %t866
  %t902 = icmp eq i64 %t900, 0
  %t901 = zext i1 %t902 to i64
  %t903 = icmp ne i64 %t901, 0
  br i1 %t903, label %L186, label %L187
L186:
  %t904 = load i64, ptr %t851
  %t905 = load ptr, ptr %t890
  %t906 = call i32 @promote_to_i64(ptr %t0, i64 %t904, ptr %t905, i64 64)
  %t907 = sext i32 %t906 to i64
  %t908 = load i64, ptr %t857
  %t909 = load ptr, ptr %t891
  %t910 = call i32 @promote_to_i64(ptr %t0, i64 %t908, ptr %t909, i64 64)
  %t911 = sext i32 %t910 to i64
  %t912 = getelementptr [4 x i8], ptr @.str99, i64 0, i64 0
  store ptr %t912, ptr %t881
  br label %L188
L187:
  %t913 = load ptr, ptr %t890
  %t914 = load ptr, ptr %t851
  %t915 = call ptr @strncpy(ptr %t913, ptr %t914, i64 63)
  %t916 = load ptr, ptr %t890
  %t918 = sext i32 63 to i64
  %t917 = getelementptr ptr, ptr %t916, i64 %t918
  %t919 = sext i32 0 to i64
  store i64 %t919, ptr %t917
  %t920 = load ptr, ptr %t891
  %t921 = load ptr, ptr %t857
  %t922 = call ptr @strncpy(ptr %t920, ptr %t921, i64 63)
  %t923 = load ptr, ptr %t891
  %t925 = sext i32 63 to i64
  %t924 = getelementptr ptr, ptr %t923, i64 %t925
  %t926 = sext i32 0 to i64
  store i64 %t926, ptr %t924
  br label %L188
L188:
  %t927 = alloca ptr
  %t929 = sext i32 0 to i64
  %t928 = inttoptr i64 %t929 to ptr
  store ptr %t928, ptr %t927
  %t930 = alloca i64
  %t931 = sext i32 0 to i64
  store i64 %t931, ptr %t930
  %t932 = load ptr, ptr %t1
  %t933 = ptrtoint ptr %t932 to i64
  %t934 = add i64 %t933, 0
  switch i64 %t934, label %L208 [
    i64 35, label %L190
    i64 36, label %L191
    i64 37, label %L192
    i64 38, label %L193
    i64 39, label %L194
    i64 40, label %L195
    i64 41, label %L196
    i64 42, label %L197
    i64 44, label %L198
    i64 45, label %L199
    i64 46, label %L200
    i64 47, label %L201
    i64 48, label %L202
    i64 49, label %L203
    i64 50, label %L204
    i64 51, label %L205
    i64 52, label %L206
    i64 53, label %L207
  ]
L190:
  %t935 = load i64, ptr %t866
  %t936 = icmp ne i64 %t935, 0
  br i1 %t936, label %L209, label %L210
L209:
  %t937 = getelementptr [5 x i8], ptr @.str100, i64 0, i64 0
  %t938 = ptrtoint ptr %t937 to i64
  br label %L211
L210:
  %t939 = load i64, ptr %t877
  %t940 = icmp ne i64 %t939, 0
  br i1 %t940, label %L212, label %L213
L212:
  %t941 = getelementptr [14 x i8], ptr @.str101, i64 0, i64 0
  %t942 = ptrtoint ptr %t941 to i64
  br label %L214
L213:
  %t943 = getelementptr [4 x i8], ptr @.str102, i64 0, i64 0
  %t944 = ptrtoint ptr %t943 to i64
  br label %L214
L214:
  %t945 = phi i64 [ %t942, %L212 ], [ %t944, %L213 ]
  br label %L211
L211:
  %t946 = phi i64 [ %t938, %L209 ], [ %t945, %L210 ]
  store i64 %t946, ptr %t927
  br label %L189
L215:
  br label %L191
L191:
  %t947 = load i64, ptr %t866
  %t948 = icmp ne i64 %t947, 0
  br i1 %t948, label %L216, label %L217
L216:
  %t949 = getelementptr [5 x i8], ptr @.str103, i64 0, i64 0
  %t950 = ptrtoint ptr %t949 to i64
  br label %L218
L217:
  %t951 = getelementptr [4 x i8], ptr @.str104, i64 0, i64 0
  %t952 = ptrtoint ptr %t951 to i64
  br label %L218
L218:
  %t953 = phi i64 [ %t950, %L216 ], [ %t952, %L217 ]
  store i64 %t953, ptr %t927
  br label %L189
L219:
  br label %L192
L192:
  %t954 = load i64, ptr %t866
  %t955 = icmp ne i64 %t954, 0
  br i1 %t955, label %L220, label %L221
L220:
  %t956 = getelementptr [5 x i8], ptr @.str105, i64 0, i64 0
  %t957 = ptrtoint ptr %t956 to i64
  br label %L222
L221:
  %t958 = getelementptr [4 x i8], ptr @.str106, i64 0, i64 0
  %t959 = ptrtoint ptr %t958 to i64
  br label %L222
L222:
  %t960 = phi i64 [ %t957, %L220 ], [ %t959, %L221 ]
  store i64 %t960, ptr %t927
  br label %L189
L223:
  br label %L193
L193:
  %t961 = load i64, ptr %t866
  %t962 = icmp ne i64 %t961, 0
  br i1 %t962, label %L224, label %L225
L224:
  %t963 = getelementptr [5 x i8], ptr @.str107, i64 0, i64 0
  %t964 = ptrtoint ptr %t963 to i64
  br label %L226
L225:
  %t965 = getelementptr [5 x i8], ptr @.str108, i64 0, i64 0
  %t966 = ptrtoint ptr %t965 to i64
  br label %L226
L226:
  %t967 = phi i64 [ %t964, %L224 ], [ %t966, %L225 ]
  store i64 %t967, ptr %t927
  br label %L189
L227:
  br label %L194
L194:
  %t968 = load i64, ptr %t866
  %t969 = icmp ne i64 %t968, 0
  br i1 %t969, label %L228, label %L229
L228:
  %t970 = getelementptr [5 x i8], ptr @.str109, i64 0, i64 0
  %t971 = ptrtoint ptr %t970 to i64
  br label %L230
L229:
  %t972 = getelementptr [5 x i8], ptr @.str110, i64 0, i64 0
  %t973 = ptrtoint ptr %t972 to i64
  br label %L230
L230:
  %t974 = phi i64 [ %t971, %L228 ], [ %t973, %L229 ]
  store i64 %t974, ptr %t927
  br label %L189
L231:
  br label %L195
L195:
  %t975 = getelementptr [4 x i8], ptr @.str111, i64 0, i64 0
  store ptr %t975, ptr %t927
  br label %L189
L232:
  br label %L196
L196:
  %t976 = getelementptr [3 x i8], ptr @.str112, i64 0, i64 0
  store ptr %t976, ptr %t927
  br label %L189
L233:
  br label %L197
L197:
  %t977 = getelementptr [4 x i8], ptr @.str113, i64 0, i64 0
  store ptr %t977, ptr %t927
  br label %L189
L234:
  br label %L198
L198:
  %t978 = getelementptr [4 x i8], ptr @.str114, i64 0, i64 0
  store ptr %t978, ptr %t927
  br label %L189
L235:
  br label %L199
L199:
  %t979 = getelementptr [5 x i8], ptr @.str115, i64 0, i64 0
  store ptr %t979, ptr %t927
  br label %L189
L236:
  br label %L200
L200:
  %t980 = load i64, ptr %t866
  %t981 = icmp ne i64 %t980, 0
  br i1 %t981, label %L237, label %L238
L237:
  %t982 = getelementptr [9 x i8], ptr @.str116, i64 0, i64 0
  %t983 = ptrtoint ptr %t982 to i64
  br label %L239
L238:
  %t984 = getelementptr [8 x i8], ptr @.str117, i64 0, i64 0
  %t985 = ptrtoint ptr %t984 to i64
  br label %L239
L239:
  %t986 = phi i64 [ %t983, %L237 ], [ %t985, %L238 ]
  store i64 %t986, ptr %t927
  %t987 = sext i32 1 to i64
  store i64 %t987, ptr %t930
  br label %L189
L240:
  br label %L201
L201:
  %t988 = load i64, ptr %t866
  %t989 = icmp ne i64 %t988, 0
  br i1 %t989, label %L241, label %L242
L241:
  %t990 = getelementptr [9 x i8], ptr @.str118, i64 0, i64 0
  %t991 = ptrtoint ptr %t990 to i64
  br label %L243
L242:
  %t992 = getelementptr [8 x i8], ptr @.str119, i64 0, i64 0
  %t993 = ptrtoint ptr %t992 to i64
  br label %L243
L243:
  %t994 = phi i64 [ %t991, %L241 ], [ %t993, %L242 ]
  store i64 %t994, ptr %t927
  %t995 = sext i32 1 to i64
  store i64 %t995, ptr %t930
  br label %L189
L244:
  br label %L202
L202:
  %t996 = load i64, ptr %t866
  %t997 = icmp ne i64 %t996, 0
  br i1 %t997, label %L245, label %L246
L245:
  %t998 = getelementptr [9 x i8], ptr @.str120, i64 0, i64 0
  %t999 = ptrtoint ptr %t998 to i64
  br label %L247
L246:
  %t1000 = getelementptr [9 x i8], ptr @.str121, i64 0, i64 0
  %t1001 = ptrtoint ptr %t1000 to i64
  br label %L247
L247:
  %t1002 = phi i64 [ %t999, %L245 ], [ %t1001, %L246 ]
  store i64 %t1002, ptr %t927
  %t1003 = sext i32 1 to i64
  store i64 %t1003, ptr %t930
  br label %L189
L248:
  br label %L203
L203:
  %t1004 = load i64, ptr %t866
  %t1005 = icmp ne i64 %t1004, 0
  br i1 %t1005, label %L249, label %L250
L249:
  %t1006 = getelementptr [9 x i8], ptr @.str122, i64 0, i64 0
  %t1007 = ptrtoint ptr %t1006 to i64
  br label %L251
L250:
  %t1008 = getelementptr [9 x i8], ptr @.str123, i64 0, i64 0
  %t1009 = ptrtoint ptr %t1008 to i64
  br label %L251
L251:
  %t1010 = phi i64 [ %t1007, %L249 ], [ %t1009, %L250 ]
  store i64 %t1010, ptr %t927
  %t1011 = sext i32 1 to i64
  store i64 %t1011, ptr %t930
  br label %L189
L252:
  br label %L204
L204:
  %t1012 = load i64, ptr %t866
  %t1013 = icmp ne i64 %t1012, 0
  br i1 %t1013, label %L253, label %L254
L253:
  %t1014 = getelementptr [9 x i8], ptr @.str124, i64 0, i64 0
  %t1015 = ptrtoint ptr %t1014 to i64
  br label %L255
L254:
  %t1016 = getelementptr [9 x i8], ptr @.str125, i64 0, i64 0
  %t1017 = ptrtoint ptr %t1016 to i64
  br label %L255
L255:
  %t1018 = phi i64 [ %t1015, %L253 ], [ %t1017, %L254 ]
  store i64 %t1018, ptr %t927
  %t1019 = sext i32 1 to i64
  store i64 %t1019, ptr %t930
  br label %L189
L256:
  br label %L205
L205:
  %t1020 = load i64, ptr %t866
  %t1021 = icmp ne i64 %t1020, 0
  br i1 %t1021, label %L257, label %L258
L257:
  %t1022 = getelementptr [9 x i8], ptr @.str126, i64 0, i64 0
  %t1023 = ptrtoint ptr %t1022 to i64
  br label %L259
L258:
  %t1024 = getelementptr [9 x i8], ptr @.str127, i64 0, i64 0
  %t1025 = ptrtoint ptr %t1024 to i64
  br label %L259
L259:
  %t1026 = phi i64 [ %t1023, %L257 ], [ %t1025, %L258 ]
  store i64 %t1026, ptr %t927
  %t1027 = sext i32 1 to i64
  store i64 %t1027, ptr %t930
  br label %L189
L260:
  br label %L206
L206:
  br label %L207
L207:
  %t1028 = getelementptr [4 x i8], ptr @.str128, i64 0, i64 0
  store ptr %t1028, ptr %t927
  br label %L189
L261:
  br label %L189
L208:
  %t1029 = getelementptr [4 x i8], ptr @.str129, i64 0, i64 0
  store ptr %t1029, ptr %t927
  br label %L189
L189:
  %t1030 = load ptr, ptr %t1
  %t1032 = ptrtoint ptr %t1030 to i64
  %t1033 = sext i32 35 to i64
  %t1031 = icmp eq i64 %t1032, %t1033
  %t1034 = zext i1 %t1031 to i64
  %t1035 = icmp ne i64 %t1034, 0
  br i1 %t1035, label %L262, label %L263
L262:
  %t1036 = load i64, ptr %t877
  %t1037 = icmp ne i64 %t1036, 0
  %t1038 = zext i1 %t1037 to i64
  br label %L264
L263:
  br label %L264
L264:
  %t1039 = phi i64 [ %t1038, %L262 ], [ 0, %L263 ]
  %t1040 = icmp ne i64 %t1039, 0
  br i1 %t1040, label %L265, label %L266
L265:
  %t1041 = alloca i64
  %t1042 = call i32 @new_reg(ptr %t0)
  %t1043 = sext i32 %t1042 to i64
  store i64 %t1043, ptr %t1041
  %t1044 = load ptr, ptr %t0
  %t1045 = getelementptr [34 x i8], ptr @.str130, i64 0, i64 0
  %t1046 = load i64, ptr %t1041
  %t1047 = load ptr, ptr %t890
  call void @__c0c_emit(ptr %t1044, ptr %t1045, i64 %t1046, ptr %t1047)
  %t1049 = load ptr, ptr %t0
  %t1050 = getelementptr [47 x i8], ptr @.str131, i64 0, i64 0
  %t1051 = load i64, ptr %t863
  %t1052 = load i64, ptr %t1041
  %t1053 = load ptr, ptr %t891
  call void @__c0c_emit(ptr %t1049, ptr %t1050, i64 %t1051, i64 %t1052, ptr %t1053)
  br label %L267
L266:
  %t1055 = load i64, ptr %t930
  %t1056 = icmp ne i64 %t1055, 0
  br i1 %t1056, label %L268, label %L269
L268:
  %t1057 = load ptr, ptr %t0
  %t1058 = getelementptr [24 x i8], ptr @.str132, i64 0, i64 0
  %t1059 = load i64, ptr %t863
  %t1060 = load ptr, ptr %t927
  %t1061 = load ptr, ptr %t881
  %t1062 = load ptr, ptr %t890
  %t1063 = load ptr, ptr %t891
  call void @__c0c_emit(ptr %t1057, ptr %t1058, i64 %t1059, ptr %t1060, ptr %t1061, ptr %t1062, ptr %t1063)
  %t1065 = alloca i64
  %t1066 = call i32 @new_reg(ptr %t0)
  %t1067 = sext i32 %t1066 to i64
  store i64 %t1067, ptr %t1065
  %t1068 = load ptr, ptr %t0
  %t1069 = getelementptr [32 x i8], ptr @.str133, i64 0, i64 0
  %t1070 = load i64, ptr %t1065
  %t1071 = load i64, ptr %t863
  call void @__c0c_emit(ptr %t1068, ptr %t1069, i64 %t1070, i64 %t1071)
  %t1073 = alloca ptr
  %t1074 = load ptr, ptr %t1073
  %t1075 = getelementptr [6 x i8], ptr @.str134, i64 0, i64 0
  %t1076 = load i64, ptr %t1065
  %t1077 = call i32 @snprintf(ptr %t1074, i64 8, ptr %t1075, i64 %t1076)
  %t1078 = sext i32 %t1077 to i64
  %t1079 = load ptr, ptr %t1073
  %t1080 = call ptr @default_i64_type()
  %t1081 = call i64 @make_val(ptr %t1079, ptr %t1080)
  ret i64 %t1081
L271:
  br label %L270
L269:
  %t1082 = load ptr, ptr %t0
  %t1083 = getelementptr [24 x i8], ptr @.str135, i64 0, i64 0
  %t1084 = load i64, ptr %t863
  %t1085 = load ptr, ptr %t927
  %t1086 = load ptr, ptr %t881
  %t1087 = load ptr, ptr %t890
  %t1088 = load ptr, ptr %t891
  call void @__c0c_emit(ptr %t1082, ptr %t1083, i64 %t1084, ptr %t1085, ptr %t1086, ptr %t1087, ptr %t1088)
  br label %L270
L270:
  br label %L267
L267:
  %t1090 = alloca ptr
  %t1091 = load ptr, ptr %t1090
  %t1092 = getelementptr [6 x i8], ptr @.str136, i64 0, i64 0
  %t1093 = load i64, ptr %t863
  %t1094 = call i32 @snprintf(ptr %t1091, i64 8, ptr %t1092, i64 %t1093)
  %t1095 = sext i32 %t1094 to i64
  %t1096 = load ptr, ptr %t1
  %t1098 = ptrtoint ptr %t1096 to i64
  %t1099 = sext i32 35 to i64
  %t1097 = icmp eq i64 %t1098, %t1099
  %t1100 = zext i1 %t1097 to i64
  %t1101 = icmp ne i64 %t1100, 0
  br i1 %t1101, label %L272, label %L273
L272:
  %t1102 = load i64, ptr %t877
  %t1103 = icmp ne i64 %t1102, 0
  %t1104 = zext i1 %t1103 to i64
  br label %L274
L273:
  br label %L274
L274:
  %t1105 = phi i64 [ %t1104, %L272 ], [ 0, %L273 ]
  %t1106 = icmp ne i64 %t1105, 0
  br i1 %t1106, label %L275, label %L277
L275:
  %t1107 = load ptr, ptr %t1090
  %t1108 = call ptr @default_ptr_type()
  %t1109 = call i64 @make_val(ptr %t1107, ptr %t1108)
  ret i64 %t1109
L278:
  br label %L277
L277:
  %t1110 = load i64, ptr %t877
  %t1111 = icmp ne i64 %t1110, 0
  br i1 %t1111, label %L279, label %L281
L279:
  %t1112 = load ptr, ptr %t1090
  %t1113 = call ptr @default_i64_type()
  %t1114 = call i64 @make_val(ptr %t1112, ptr %t1113)
  ret i64 %t1114
L282:
  br label %L281
L281:
  %t1115 = load ptr, ptr %t1090
  %t1116 = call ptr @default_i64_type()
  %t1117 = call i64 @make_val(ptr %t1115, ptr %t1116)
  ret i64 %t1117
L283:
  br label %L12
L12:
  %t1118 = alloca i64
  %t1119 = load ptr, ptr %t1
  %t1120 = sext i32 0 to i64
  %t1121 = getelementptr ptr, ptr %t1119, i64 %t1120
  %t1122 = load ptr, ptr %t1121
  %t1123 = call i64 @emit_expr(ptr %t0, ptr %t1122)
  store i64 %t1123, ptr %t1118
  %t1124 = alloca i64
  %t1125 = call i32 @new_reg(ptr %t0)
  %t1126 = sext i32 %t1125 to i64
  store i64 %t1126, ptr %t1124
  %t1127 = alloca i64
  %t1128 = load ptr, ptr %t1118
  %t1129 = call i32 @type_is_fp(ptr %t1128)
  %t1130 = sext i32 %t1129 to i64
  store i64 %t1130, ptr %t1127
  %t1131 = alloca ptr
  %t1132 = load i64, ptr %t1127
  %t1134 = icmp eq i64 %t1132, 0
  %t1133 = zext i1 %t1134 to i64
  %t1135 = icmp ne i64 %t1133, 0
  br i1 %t1135, label %L284, label %L286
L284:
  %t1136 = load i64, ptr %t1118
  %t1137 = load ptr, ptr %t1131
  %t1138 = call i32 @promote_to_i64(ptr %t0, i64 %t1136, ptr %t1137, i64 64)
  %t1139 = sext i32 %t1138 to i64
  br label %L286
L286:
  %t1140 = load ptr, ptr %t1
  %t1141 = ptrtoint ptr %t1140 to i64
  %t1142 = add i64 %t1141, 0
  switch i64 %t1142, label %L292 [
    i64 36, label %L288
    i64 54, label %L289
    i64 43, label %L290
    i64 35, label %L291
  ]
L288:
  %t1143 = load i64, ptr %t1127
  %t1144 = icmp ne i64 %t1143, 0
  br i1 %t1144, label %L293, label %L294
L293:
  %t1145 = load ptr, ptr %t0
  %t1146 = getelementptr [26 x i8], ptr @.str137, i64 0, i64 0
  %t1147 = load i64, ptr %t1124
  %t1148 = load ptr, ptr %t1118
  call void @__c0c_emit(ptr %t1145, ptr %t1146, i64 %t1147, ptr %t1148)
  br label %L295
L294:
  %t1150 = load ptr, ptr %t0
  %t1151 = getelementptr [25 x i8], ptr @.str138, i64 0, i64 0
  %t1152 = load i64, ptr %t1124
  %t1153 = load ptr, ptr %t1131
  call void @__c0c_emit(ptr %t1150, ptr %t1151, i64 %t1152, ptr %t1153)
  br label %L295
L295:
  br label %L287
L296:
  br label %L289
L289:
  %t1155 = alloca i64
  %t1156 = call i32 @new_reg(ptr %t0)
  %t1157 = sext i32 %t1156 to i64
  store i64 %t1157, ptr %t1155
  %t1158 = load ptr, ptr %t0
  %t1159 = getelementptr [29 x i8], ptr @.str139, i64 0, i64 0
  %t1160 = load i64, ptr %t1155
  %t1161 = load ptr, ptr %t1131
  call void @__c0c_emit(ptr %t1158, ptr %t1159, i64 %t1160, ptr %t1161)
  %t1163 = load ptr, ptr %t0
  %t1164 = getelementptr [32 x i8], ptr @.str140, i64 0, i64 0
  %t1165 = load i64, ptr %t1124
  %t1166 = load i64, ptr %t1155
  call void @__c0c_emit(ptr %t1163, ptr %t1164, i64 %t1165, i64 %t1166)
  br label %L287
L297:
  br label %L290
L290:
  %t1168 = load ptr, ptr %t0
  %t1169 = getelementptr [26 x i8], ptr @.str141, i64 0, i64 0
  %t1170 = load i64, ptr %t1124
  %t1171 = load ptr, ptr %t1131
  call void @__c0c_emit(ptr %t1168, ptr %t1169, i64 %t1170, ptr %t1171)
  br label %L287
L298:
  br label %L291
L291:
  %t1173 = load i64, ptr %t1118
  ret i64 %t1173
L299:
  br label %L287
L292:
  %t1174 = load ptr, ptr %t0
  %t1175 = getelementptr [25 x i8], ptr @.str142, i64 0, i64 0
  %t1176 = load i64, ptr %t1124
  %t1177 = load ptr, ptr %t1131
  call void @__c0c_emit(ptr %t1174, ptr %t1175, i64 %t1176, ptr %t1177)
  br label %L287
L287:
  %t1179 = alloca ptr
  %t1180 = load ptr, ptr %t1179
  %t1181 = getelementptr [6 x i8], ptr @.str143, i64 0, i64 0
  %t1182 = load i64, ptr %t1124
  %t1183 = call i32 @snprintf(ptr %t1180, i64 8, ptr %t1181, i64 %t1182)
  %t1184 = sext i32 %t1183 to i64
  %t1185 = load ptr, ptr %t1179
  %t1186 = load i64, ptr %t1127
  %t1187 = icmp ne i64 %t1186, 0
  br i1 %t1187, label %L300, label %L301
L300:
  %t1188 = load ptr, ptr %t1118
  %t1189 = ptrtoint ptr %t1188 to i64
  br label %L302
L301:
  %t1190 = call ptr @default_i64_type()
  %t1191 = ptrtoint ptr %t1190 to i64
  br label %L302
L302:
  %t1192 = phi i64 [ %t1189, %L300 ], [ %t1191, %L301 ]
  %t1193 = call i64 @make_val(ptr %t1185, i64 %t1192)
  ret i64 %t1193
L303:
  br label %L13
L13:
  %t1194 = alloca i64
  %t1195 = load ptr, ptr %t1
  %t1196 = sext i32 1 to i64
  %t1197 = getelementptr ptr, ptr %t1195, i64 %t1196
  %t1198 = load ptr, ptr %t1197
  %t1199 = call i64 @emit_expr(ptr %t0, ptr %t1198)
  store i64 %t1199, ptr %t1194
  %t1200 = alloca ptr
  %t1201 = load ptr, ptr %t1
  %t1202 = sext i32 0 to i64
  %t1203 = getelementptr ptr, ptr %t1201, i64 %t1202
  %t1204 = load ptr, ptr %t1203
  %t1205 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1204)
  store ptr %t1205, ptr %t1200
  %t1206 = load ptr, ptr %t1200
  %t1207 = icmp ne ptr %t1206, null
  br i1 %t1207, label %L304, label %L306
L304:
  %t1208 = alloca ptr
  %t1209 = load i64, ptr %t1194
  %t1210 = call i32 @val_is_ptr(i64 %t1209)
  %t1211 = sext i32 %t1210 to i64
  %t1212 = icmp ne i64 %t1211, 0
  br i1 %t1212, label %L307, label %L308
L307:
  %t1213 = getelementptr [4 x i8], ptr @.str144, i64 0, i64 0
  store ptr %t1213, ptr %t1208
  br label %L309
L308:
  %t1214 = load ptr, ptr %t1194
  %t1215 = call i32 @type_is_fp(ptr %t1214)
  %t1216 = sext i32 %t1215 to i64
  %t1217 = icmp ne i64 %t1216, 0
  br i1 %t1217, label %L310, label %L311
L310:
  %t1218 = load ptr, ptr %t1194
  %t1219 = call ptr @llvm_type(ptr %t1218)
  store ptr %t1219, ptr %t1208
  br label %L312
L311:
  %t1220 = getelementptr [4 x i8], ptr @.str145, i64 0, i64 0
  store ptr %t1220, ptr %t1208
  br label %L312
L312:
  br label %L309
L309:
  %t1221 = alloca ptr
  %t1222 = load i64, ptr %t1194
  %t1223 = call i32 @val_is_ptr(i64 %t1222)
  %t1224 = sext i32 %t1223 to i64
  %t1226 = icmp eq i64 %t1224, 0
  %t1225 = zext i1 %t1226 to i64
  %t1227 = icmp ne i64 %t1225, 0
  br i1 %t1227, label %L313, label %L314
L313:
  %t1228 = load i64, ptr %t1194
  %t1229 = call i32 @val_is_64bit(i64 %t1228)
  %t1230 = sext i32 %t1229 to i64
  %t1232 = icmp eq i64 %t1230, 0
  %t1231 = zext i1 %t1232 to i64
  %t1233 = icmp ne i64 %t1231, 0
  %t1234 = zext i1 %t1233 to i64
  br label %L315
L314:
  br label %L315
L315:
  %t1235 = phi i64 [ %t1234, %L313 ], [ 0, %L314 ]
  %t1236 = icmp ne i64 %t1235, 0
  br i1 %t1236, label %L316, label %L317
L316:
  %t1237 = load ptr, ptr %t1194
  %t1238 = call i32 @type_is_fp(ptr %t1237)
  %t1239 = sext i32 %t1238 to i64
  %t1241 = icmp eq i64 %t1239, 0
  %t1240 = zext i1 %t1241 to i64
  %t1242 = icmp ne i64 %t1240, 0
  %t1243 = zext i1 %t1242 to i64
  br label %L318
L317:
  br label %L318
L318:
  %t1244 = phi i64 [ %t1243, %L316 ], [ 0, %L317 ]
  %t1245 = icmp ne i64 %t1244, 0
  br i1 %t1245, label %L319, label %L320
L319:
  %t1246 = alloca i64
  %t1247 = call i32 @new_reg(ptr %t0)
  %t1248 = sext i32 %t1247 to i64
  store i64 %t1248, ptr %t1246
  %t1249 = load ptr, ptr %t0
  %t1250 = getelementptr [30 x i8], ptr @.str146, i64 0, i64 0
  %t1251 = load i64, ptr %t1246
  %t1252 = load ptr, ptr %t1194
  call void @__c0c_emit(ptr %t1249, ptr %t1250, i64 %t1251, ptr %t1252)
  %t1254 = load ptr, ptr %t1221
  %t1255 = getelementptr [6 x i8], ptr @.str147, i64 0, i64 0
  %t1256 = load i64, ptr %t1246
  %t1257 = call i32 @snprintf(ptr %t1254, i64 64, ptr %t1255, i64 %t1256)
  %t1258 = sext i32 %t1257 to i64
  br label %L321
L320:
  %t1259 = load ptr, ptr %t1221
  %t1260 = load ptr, ptr %t1194
  %t1261 = call ptr @strncpy(ptr %t1259, ptr %t1260, i64 63)
  %t1262 = load ptr, ptr %t1221
  %t1264 = sext i32 63 to i64
  %t1263 = getelementptr ptr, ptr %t1262, i64 %t1264
  %t1265 = sext i32 0 to i64
  store i64 %t1265, ptr %t1263
  br label %L321
L321:
  %t1266 = load ptr, ptr %t0
  %t1267 = getelementptr [23 x i8], ptr @.str148, i64 0, i64 0
  %t1268 = load ptr, ptr %t1208
  %t1269 = load ptr, ptr %t1221
  %t1270 = load ptr, ptr %t1200
  call void @__c0c_emit(ptr %t1266, ptr %t1267, ptr %t1268, ptr %t1269, ptr %t1270)
  %t1272 = load ptr, ptr %t1200
  call void @free(ptr %t1272)
  br label %L306
L306:
  %t1274 = load i64, ptr %t1194
  ret i64 %t1274
L322:
  br label %L14
L14:
  %t1275 = alloca i64
  %t1276 = load ptr, ptr %t1
  %t1277 = sext i32 0 to i64
  %t1278 = getelementptr ptr, ptr %t1276, i64 %t1277
  %t1279 = load ptr, ptr %t1278
  %t1280 = call i64 @emit_expr(ptr %t0, ptr %t1279)
  store i64 %t1280, ptr %t1275
  %t1281 = alloca i64
  %t1282 = load ptr, ptr %t1
  %t1283 = sext i32 1 to i64
  %t1284 = getelementptr ptr, ptr %t1282, i64 %t1283
  %t1285 = load ptr, ptr %t1284
  %t1286 = call i64 @emit_expr(ptr %t0, ptr %t1285)
  store i64 %t1286, ptr %t1281
  %t1287 = alloca i64
  %t1288 = call i32 @new_reg(ptr %t0)
  %t1289 = sext i32 %t1288 to i64
  store i64 %t1289, ptr %t1287
  %t1290 = alloca i64
  %t1291 = load ptr, ptr %t1275
  %t1292 = call i32 @type_is_fp(ptr %t1291)
  %t1293 = sext i32 %t1292 to i64
  %t1294 = icmp ne i64 %t1293, 0
  br i1 %t1294, label %L323, label %L324
L323:
  br label %L325
L324:
  %t1295 = load ptr, ptr %t1281
  %t1296 = call i32 @type_is_fp(ptr %t1295)
  %t1297 = sext i32 %t1296 to i64
  %t1298 = icmp ne i64 %t1297, 0
  %t1299 = zext i1 %t1298 to i64
  br label %L325
L325:
  %t1300 = phi i64 [ 1, %L323 ], [ %t1299, %L324 ]
  store i64 %t1300, ptr %t1290
  %t1301 = alloca ptr
  %t1302 = load i64, ptr %t1290
  %t1303 = icmp ne i64 %t1302, 0
  br i1 %t1303, label %L326, label %L327
L326:
  %t1304 = getelementptr [7 x i8], ptr @.str149, i64 0, i64 0
  %t1305 = ptrtoint ptr %t1304 to i64
  br label %L328
L327:
  %t1306 = getelementptr [4 x i8], ptr @.str150, i64 0, i64 0
  %t1307 = ptrtoint ptr %t1306 to i64
  br label %L328
L328:
  %t1308 = phi i64 [ %t1305, %L326 ], [ %t1307, %L327 ]
  store i64 %t1308, ptr %t1301
  %t1309 = alloca ptr
  %t1310 = alloca ptr
  %t1311 = load i64, ptr %t1290
  %t1313 = icmp eq i64 %t1311, 0
  %t1312 = zext i1 %t1313 to i64
  %t1314 = icmp ne i64 %t1312, 0
  br i1 %t1314, label %L329, label %L330
L329:
  %t1315 = load i64, ptr %t1275
  %t1316 = load ptr, ptr %t1309
  %t1317 = call i32 @promote_to_i64(ptr %t0, i64 %t1315, ptr %t1316, i64 64)
  %t1318 = sext i32 %t1317 to i64
  %t1319 = load i64, ptr %t1281
  %t1320 = load ptr, ptr %t1310
  %t1321 = call i32 @promote_to_i64(ptr %t0, i64 %t1319, ptr %t1320, i64 64)
  %t1322 = sext i32 %t1321 to i64
  br label %L331
L330:
  %t1323 = load ptr, ptr %t1309
  %t1324 = load ptr, ptr %t1275
  %t1325 = call ptr @strncpy(ptr %t1323, ptr %t1324, i64 63)
  %t1326 = load ptr, ptr %t1309
  %t1328 = sext i32 63 to i64
  %t1327 = getelementptr ptr, ptr %t1326, i64 %t1328
  %t1329 = sext i32 0 to i64
  store i64 %t1329, ptr %t1327
  %t1330 = load ptr, ptr %t1310
  %t1331 = load ptr, ptr %t1281
  %t1332 = call ptr @strncpy(ptr %t1330, ptr %t1331, i64 63)
  %t1333 = load ptr, ptr %t1310
  %t1335 = sext i32 63 to i64
  %t1334 = getelementptr ptr, ptr %t1333, i64 %t1335
  %t1336 = sext i32 0 to i64
  store i64 %t1336, ptr %t1334
  br label %L331
L331:
  %t1337 = alloca ptr
  %t1338 = load ptr, ptr %t1
  %t1339 = ptrtoint ptr %t1338 to i64
  %t1340 = add i64 %t1339, 0
  switch i64 %t1340, label %L343 [
    i64 56, label %L333
    i64 57, label %L334
    i64 58, label %L335
    i64 59, label %L336
    i64 65, label %L337
    i64 60, label %L338
    i64 61, label %L339
    i64 62, label %L340
    i64 63, label %L341
    i64 64, label %L342
  ]
L333:
  %t1341 = load i64, ptr %t1290
  %t1342 = icmp ne i64 %t1341, 0
  br i1 %t1342, label %L344, label %L345
L344:
  %t1343 = getelementptr [5 x i8], ptr @.str151, i64 0, i64 0
  %t1344 = ptrtoint ptr %t1343 to i64
  br label %L346
L345:
  %t1345 = getelementptr [4 x i8], ptr @.str152, i64 0, i64 0
  %t1346 = ptrtoint ptr %t1345 to i64
  br label %L346
L346:
  %t1347 = phi i64 [ %t1344, %L344 ], [ %t1346, %L345 ]
  store i64 %t1347, ptr %t1337
  br label %L332
L347:
  br label %L334
L334:
  %t1348 = load i64, ptr %t1290
  %t1349 = icmp ne i64 %t1348, 0
  br i1 %t1349, label %L348, label %L349
L348:
  %t1350 = getelementptr [5 x i8], ptr @.str153, i64 0, i64 0
  %t1351 = ptrtoint ptr %t1350 to i64
  br label %L350
L349:
  %t1352 = getelementptr [4 x i8], ptr @.str154, i64 0, i64 0
  %t1353 = ptrtoint ptr %t1352 to i64
  br label %L350
L350:
  %t1354 = phi i64 [ %t1351, %L348 ], [ %t1353, %L349 ]
  store i64 %t1354, ptr %t1337
  br label %L332
L351:
  br label %L335
L335:
  %t1355 = load i64, ptr %t1290
  %t1356 = icmp ne i64 %t1355, 0
  br i1 %t1356, label %L352, label %L353
L352:
  %t1357 = getelementptr [5 x i8], ptr @.str155, i64 0, i64 0
  %t1358 = ptrtoint ptr %t1357 to i64
  br label %L354
L353:
  %t1359 = getelementptr [4 x i8], ptr @.str156, i64 0, i64 0
  %t1360 = ptrtoint ptr %t1359 to i64
  br label %L354
L354:
  %t1361 = phi i64 [ %t1358, %L352 ], [ %t1360, %L353 ]
  store i64 %t1361, ptr %t1337
  br label %L332
L355:
  br label %L336
L336:
  %t1362 = load i64, ptr %t1290
  %t1363 = icmp ne i64 %t1362, 0
  br i1 %t1363, label %L356, label %L357
L356:
  %t1364 = getelementptr [5 x i8], ptr @.str157, i64 0, i64 0
  %t1365 = ptrtoint ptr %t1364 to i64
  br label %L358
L357:
  %t1366 = getelementptr [5 x i8], ptr @.str158, i64 0, i64 0
  %t1367 = ptrtoint ptr %t1366 to i64
  br label %L358
L358:
  %t1368 = phi i64 [ %t1365, %L356 ], [ %t1367, %L357 ]
  store i64 %t1368, ptr %t1337
  br label %L332
L359:
  br label %L337
L337:
  %t1369 = getelementptr [5 x i8], ptr @.str159, i64 0, i64 0
  store ptr %t1369, ptr %t1337
  br label %L332
L360:
  br label %L338
L338:
  %t1370 = getelementptr [4 x i8], ptr @.str160, i64 0, i64 0
  store ptr %t1370, ptr %t1337
  br label %L332
L361:
  br label %L339
L339:
  %t1371 = getelementptr [3 x i8], ptr @.str161, i64 0, i64 0
  store ptr %t1371, ptr %t1337
  br label %L332
L362:
  br label %L340
L340:
  %t1372 = getelementptr [4 x i8], ptr @.str162, i64 0, i64 0
  store ptr %t1372, ptr %t1337
  br label %L332
L363:
  br label %L341
L341:
  %t1373 = getelementptr [4 x i8], ptr @.str163, i64 0, i64 0
  store ptr %t1373, ptr %t1337
  br label %L332
L364:
  br label %L342
L342:
  %t1374 = getelementptr [5 x i8], ptr @.str164, i64 0, i64 0
  store ptr %t1374, ptr %t1337
  br label %L332
L365:
  br label %L332
L343:
  %t1375 = getelementptr [4 x i8], ptr @.str165, i64 0, i64 0
  store ptr %t1375, ptr %t1337
  br label %L332
L332:
  %t1376 = load ptr, ptr %t0
  %t1377 = getelementptr [24 x i8], ptr @.str166, i64 0, i64 0
  %t1378 = load i64, ptr %t1287
  %t1379 = load ptr, ptr %t1337
  %t1380 = load ptr, ptr %t1301
  %t1381 = load ptr, ptr %t1309
  %t1382 = load ptr, ptr %t1310
  call void @__c0c_emit(ptr %t1376, ptr %t1377, i64 %t1378, ptr %t1379, ptr %t1380, ptr %t1381, ptr %t1382)
  %t1384 = alloca ptr
  %t1385 = load ptr, ptr %t1
  %t1386 = sext i32 0 to i64
  %t1387 = getelementptr ptr, ptr %t1385, i64 %t1386
  %t1388 = load ptr, ptr %t1387
  %t1389 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1388)
  store ptr %t1389, ptr %t1384
  %t1390 = load ptr, ptr %t1384
  %t1391 = icmp ne ptr %t1390, null
  br i1 %t1391, label %L366, label %L368
L366:
  %t1392 = load ptr, ptr %t0
  %t1393 = getelementptr [26 x i8], ptr @.str167, i64 0, i64 0
  %t1394 = load ptr, ptr %t1301
  %t1395 = load i64, ptr %t1287
  %t1396 = load ptr, ptr %t1384
  call void @__c0c_emit(ptr %t1392, ptr %t1393, ptr %t1394, i64 %t1395, ptr %t1396)
  %t1398 = load ptr, ptr %t1384
  call void @free(ptr %t1398)
  br label %L368
L368:
  %t1400 = alloca ptr
  %t1401 = load ptr, ptr %t1400
  %t1402 = getelementptr [6 x i8], ptr @.str168, i64 0, i64 0
  %t1403 = load i64, ptr %t1287
  %t1404 = call i32 @snprintf(ptr %t1401, i64 8, ptr %t1402, i64 %t1403)
  %t1405 = sext i32 %t1404 to i64
  %t1406 = load ptr, ptr %t1400
  %t1407 = load i64, ptr %t1290
  %t1408 = icmp ne i64 %t1407, 0
  br i1 %t1408, label %L369, label %L370
L369:
  %t1409 = load ptr, ptr %t1275
  %t1410 = ptrtoint ptr %t1409 to i64
  br label %L371
L370:
  %t1411 = call ptr @default_i64_type()
  %t1412 = ptrtoint ptr %t1411 to i64
  br label %L371
L371:
  %t1413 = phi i64 [ %t1410, %L369 ], [ %t1412, %L370 ]
  %t1414 = call i64 @make_val(ptr %t1406, i64 %t1413)
  ret i64 %t1414
L372:
  br label %L15
L15:
  br label %L16
L16:
  %t1415 = alloca i64
  %t1416 = load ptr, ptr %t1
  %t1417 = sext i32 0 to i64
  %t1418 = getelementptr ptr, ptr %t1416, i64 %t1417
  %t1419 = load ptr, ptr %t1418
  %t1420 = call i64 @emit_expr(ptr %t0, ptr %t1419)
  store i64 %t1420, ptr %t1415
  %t1421 = alloca i64
  %t1422 = call i32 @new_reg(ptr %t0)
  %t1423 = sext i32 %t1422 to i64
  store i64 %t1423, ptr %t1421
  %t1424 = alloca ptr
  %t1425 = load ptr, ptr %t1
  %t1427 = ptrtoint ptr %t1425 to i64
  %t1428 = sext i32 38 to i64
  %t1426 = icmp eq i64 %t1427, %t1428
  %t1429 = zext i1 %t1426 to i64
  %t1430 = icmp ne i64 %t1429, 0
  br i1 %t1430, label %L373, label %L374
L373:
  %t1431 = getelementptr [4 x i8], ptr @.str169, i64 0, i64 0
  %t1432 = ptrtoint ptr %t1431 to i64
  br label %L375
L374:
  %t1433 = getelementptr [4 x i8], ptr @.str170, i64 0, i64 0
  %t1434 = ptrtoint ptr %t1433 to i64
  br label %L375
L375:
  %t1435 = phi i64 [ %t1432, %L373 ], [ %t1434, %L374 ]
  store i64 %t1435, ptr %t1424
  %t1436 = alloca ptr
  %t1437 = load i64, ptr %t1415
  %t1438 = load ptr, ptr %t1436
  %t1439 = call i32 @promote_to_i64(ptr %t0, i64 %t1437, ptr %t1438, i64 64)
  %t1440 = sext i32 %t1439 to i64
  %t1441 = load ptr, ptr %t0
  %t1442 = getelementptr [24 x i8], ptr @.str171, i64 0, i64 0
  %t1443 = load i64, ptr %t1421
  %t1444 = load ptr, ptr %t1424
  %t1445 = load ptr, ptr %t1436
  call void @__c0c_emit(ptr %t1441, ptr %t1442, i64 %t1443, ptr %t1444, ptr %t1445)
  %t1447 = alloca ptr
  %t1448 = load ptr, ptr %t1
  %t1449 = sext i32 0 to i64
  %t1450 = getelementptr ptr, ptr %t1448, i64 %t1449
  %t1451 = load ptr, ptr %t1450
  %t1452 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1451)
  store ptr %t1452, ptr %t1447
  %t1453 = load ptr, ptr %t1447
  %t1454 = icmp ne ptr %t1453, null
  br i1 %t1454, label %L376, label %L378
L376:
  %t1455 = load ptr, ptr %t0
  %t1456 = getelementptr [27 x i8], ptr @.str172, i64 0, i64 0
  %t1457 = load i64, ptr %t1421
  %t1458 = load ptr, ptr %t1447
  call void @__c0c_emit(ptr %t1455, ptr %t1456, i64 %t1457, ptr %t1458)
  %t1460 = load ptr, ptr %t1447
  call void @free(ptr %t1460)
  br label %L378
L378:
  %t1462 = alloca ptr
  %t1463 = load ptr, ptr %t1462
  %t1464 = getelementptr [6 x i8], ptr @.str173, i64 0, i64 0
  %t1465 = load i64, ptr %t1421
  %t1466 = call i32 @snprintf(ptr %t1463, i64 8, ptr %t1464, i64 %t1465)
  %t1467 = sext i32 %t1466 to i64
  %t1468 = load ptr, ptr %t1462
  %t1469 = call ptr @default_i64_type()
  %t1470 = call i64 @make_val(ptr %t1468, ptr %t1469)
  ret i64 %t1470
L379:
  br label %L17
L17:
  br label %L18
L18:
  %t1471 = alloca i64
  %t1472 = load ptr, ptr %t1
  %t1473 = sext i32 0 to i64
  %t1474 = getelementptr ptr, ptr %t1472, i64 %t1473
  %t1475 = load ptr, ptr %t1474
  %t1476 = call i64 @emit_expr(ptr %t0, ptr %t1475)
  store i64 %t1476, ptr %t1471
  %t1477 = alloca i64
  %t1478 = call i32 @new_reg(ptr %t0)
  %t1479 = sext i32 %t1478 to i64
  store i64 %t1479, ptr %t1477
  %t1480 = alloca ptr
  %t1481 = load ptr, ptr %t1
  %t1483 = ptrtoint ptr %t1481 to i64
  %t1484 = sext i32 40 to i64
  %t1482 = icmp eq i64 %t1483, %t1484
  %t1485 = zext i1 %t1482 to i64
  %t1486 = icmp ne i64 %t1485, 0
  br i1 %t1486, label %L380, label %L381
L380:
  %t1487 = getelementptr [4 x i8], ptr @.str174, i64 0, i64 0
  %t1488 = ptrtoint ptr %t1487 to i64
  br label %L382
L381:
  %t1489 = getelementptr [4 x i8], ptr @.str175, i64 0, i64 0
  %t1490 = ptrtoint ptr %t1489 to i64
  br label %L382
L382:
  %t1491 = phi i64 [ %t1488, %L380 ], [ %t1490, %L381 ]
  store i64 %t1491, ptr %t1480
  %t1492 = alloca ptr
  %t1493 = load i64, ptr %t1471
  %t1494 = load ptr, ptr %t1492
  %t1495 = call i32 @promote_to_i64(ptr %t0, i64 %t1493, ptr %t1494, i64 64)
  %t1496 = sext i32 %t1495 to i64
  %t1497 = load ptr, ptr %t0
  %t1498 = getelementptr [24 x i8], ptr @.str176, i64 0, i64 0
  %t1499 = load i64, ptr %t1477
  %t1500 = load ptr, ptr %t1480
  %t1501 = load ptr, ptr %t1492
  call void @__c0c_emit(ptr %t1497, ptr %t1498, i64 %t1499, ptr %t1500, ptr %t1501)
  %t1503 = alloca ptr
  %t1504 = load ptr, ptr %t1
  %t1505 = sext i32 0 to i64
  %t1506 = getelementptr ptr, ptr %t1504, i64 %t1505
  %t1507 = load ptr, ptr %t1506
  %t1508 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1507)
  store ptr %t1508, ptr %t1503
  %t1509 = load ptr, ptr %t1503
  %t1510 = icmp ne ptr %t1509, null
  br i1 %t1510, label %L383, label %L385
L383:
  %t1511 = load ptr, ptr %t0
  %t1512 = getelementptr [27 x i8], ptr @.str177, i64 0, i64 0
  %t1513 = load i64, ptr %t1477
  %t1514 = load ptr, ptr %t1503
  call void @__c0c_emit(ptr %t1511, ptr %t1512, i64 %t1513, ptr %t1514)
  %t1516 = load ptr, ptr %t1503
  call void @free(ptr %t1516)
  br label %L385
L385:
  %t1518 = load i64, ptr %t1471
  ret i64 %t1518
L386:
  br label %L19
L19:
  %t1519 = alloca ptr
  %t1520 = load ptr, ptr %t1
  %t1521 = sext i32 0 to i64
  %t1522 = getelementptr ptr, ptr %t1520, i64 %t1521
  %t1523 = load ptr, ptr %t1522
  %t1524 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1523)
  store ptr %t1524, ptr %t1519
  %t1525 = load ptr, ptr %t1519
  %t1527 = ptrtoint ptr %t1525 to i64
  %t1528 = icmp eq i64 %t1527, 0
  %t1526 = zext i1 %t1528 to i64
  %t1529 = icmp ne i64 %t1526, 0
  br i1 %t1529, label %L387, label %L389
L387:
  %t1530 = getelementptr [5 x i8], ptr @.str178, i64 0, i64 0
  %t1531 = call ptr @default_ptr_type()
  %t1532 = call i64 @make_val(ptr %t1530, ptr %t1531)
  ret i64 %t1532
L390:
  br label %L389
L389:
  %t1533 = alloca i64
  %t1534 = load ptr, ptr %t1519
  %t1535 = call ptr @default_ptr_type()
  %t1536 = call i64 @make_val(ptr %t1534, ptr %t1535)
  store i64 %t1536, ptr %t1533
  %t1537 = load ptr, ptr %t1519
  call void @free(ptr %t1537)
  %t1539 = load i64, ptr %t1533
  ret i64 %t1539
L391:
  br label %L20
L20:
  %t1540 = alloca i64
  %t1541 = load ptr, ptr %t1
  %t1542 = sext i32 0 to i64
  %t1543 = getelementptr ptr, ptr %t1541, i64 %t1542
  %t1544 = load ptr, ptr %t1543
  %t1545 = call i64 @emit_expr(ptr %t0, ptr %t1544)
  store i64 %t1545, ptr %t1540
  %t1546 = alloca i64
  %t1547 = call i32 @new_reg(ptr %t0)
  %t1548 = sext i32 %t1547 to i64
  store i64 %t1548, ptr %t1546
  %t1549 = alloca ptr
  %t1550 = load i64, ptr %t1540
  %t1551 = call i32 @val_is_ptr(i64 %t1550)
  %t1552 = sext i32 %t1551 to i64
  %t1553 = icmp ne i64 %t1552, 0
  br i1 %t1553, label %L392, label %L393
L392:
  %t1554 = load ptr, ptr %t1549
  %t1555 = load ptr, ptr %t1540
  %t1556 = call ptr @strncpy(ptr %t1554, ptr %t1555, i64 63)
  %t1557 = load ptr, ptr %t1549
  %t1559 = sext i32 63 to i64
  %t1558 = getelementptr ptr, ptr %t1557, i64 %t1559
  %t1560 = sext i32 0 to i64
  store i64 %t1560, ptr %t1558
  br label %L394
L393:
  %t1561 = alloca i64
  %t1562 = call i32 @new_reg(ptr %t0)
  %t1563 = sext i32 %t1562 to i64
  store i64 %t1563, ptr %t1561
  %t1564 = load ptr, ptr %t0
  %t1565 = getelementptr [34 x i8], ptr @.str179, i64 0, i64 0
  %t1566 = load i64, ptr %t1561
  %t1567 = load ptr, ptr %t1540
  call void @__c0c_emit(ptr %t1564, ptr %t1565, i64 %t1566, ptr %t1567)
  %t1569 = load ptr, ptr %t1549
  %t1570 = getelementptr [6 x i8], ptr @.str180, i64 0, i64 0
  %t1571 = load i64, ptr %t1561
  %t1572 = call i32 @snprintf(ptr %t1569, i64 64, ptr %t1570, i64 %t1571)
  %t1573 = sext i32 %t1572 to i64
  br label %L394
L394:
  %t1574 = alloca ptr
  %t1575 = load ptr, ptr %t1540
  %t1576 = ptrtoint ptr %t1575 to i64
  %t1577 = icmp ne i64 %t1576, 0
  br i1 %t1577, label %L395, label %L396
L395:
  %t1578 = load ptr, ptr %t1540
  %t1579 = load ptr, ptr %t1578
  %t1580 = ptrtoint ptr %t1579 to i64
  %t1581 = icmp ne i64 %t1580, 0
  %t1582 = zext i1 %t1581 to i64
  br label %L397
L396:
  br label %L397
L397:
  %t1583 = phi i64 [ %t1582, %L395 ], [ 0, %L396 ]
  %t1584 = icmp ne i64 %t1583, 0
  br i1 %t1584, label %L398, label %L399
L398:
  %t1585 = load ptr, ptr %t1540
  %t1586 = load ptr, ptr %t1585
  %t1587 = ptrtoint ptr %t1586 to i64
  br label %L400
L399:
  %t1588 = call ptr @default_int_type()
  %t1589 = ptrtoint ptr %t1588 to i64
  br label %L400
L400:
  %t1590 = phi i64 [ %t1587, %L398 ], [ %t1589, %L399 ]
  store i64 %t1590, ptr %t1574
  %t1591 = alloca i64
  %t1592 = load ptr, ptr %t1574
  %t1593 = load ptr, ptr %t1592
  %t1595 = ptrtoint ptr %t1593 to i64
  %t1596 = sext i32 15 to i64
  %t1594 = icmp eq i64 %t1595, %t1596
  %t1597 = zext i1 %t1594 to i64
  %t1598 = icmp ne i64 %t1597, 0
  br i1 %t1598, label %L401, label %L402
L401:
  br label %L403
L402:
  %t1599 = load ptr, ptr %t1574
  %t1600 = load ptr, ptr %t1599
  %t1602 = ptrtoint ptr %t1600 to i64
  %t1603 = sext i32 16 to i64
  %t1601 = icmp eq i64 %t1602, %t1603
  %t1604 = zext i1 %t1601 to i64
  %t1605 = icmp ne i64 %t1604, 0
  %t1606 = zext i1 %t1605 to i64
  br label %L403
L403:
  %t1607 = phi i64 [ 1, %L401 ], [ %t1606, %L402 ]
  store i64 %t1607, ptr %t1591
  %t1608 = alloca ptr
  %t1609 = load i64, ptr %t1591
  %t1610 = icmp ne i64 %t1609, 0
  br i1 %t1610, label %L404, label %L405
L404:
  %t1611 = getelementptr [4 x i8], ptr @.str181, i64 0, i64 0
  %t1612 = ptrtoint ptr %t1611 to i64
  br label %L406
L405:
  %t1613 = getelementptr [4 x i8], ptr @.str182, i64 0, i64 0
  %t1614 = ptrtoint ptr %t1613 to i64
  br label %L406
L406:
  %t1615 = phi i64 [ %t1612, %L404 ], [ %t1614, %L405 ]
  store i64 %t1615, ptr %t1608
  %t1616 = alloca ptr
  %t1617 = load i64, ptr %t1591
  %t1618 = icmp ne i64 %t1617, 0
  br i1 %t1618, label %L407, label %L408
L407:
  %t1619 = call ptr @default_ptr_type()
  %t1620 = ptrtoint ptr %t1619 to i64
  br label %L409
L408:
  %t1621 = call ptr @default_i64_type()
  %t1622 = ptrtoint ptr %t1621 to i64
  br label %L409
L409:
  %t1623 = phi i64 [ %t1620, %L407 ], [ %t1622, %L408 ]
  store i64 %t1623, ptr %t1616
  %t1624 = load ptr, ptr %t0
  %t1625 = getelementptr [27 x i8], ptr @.str183, i64 0, i64 0
  %t1626 = load i64, ptr %t1546
  %t1627 = load ptr, ptr %t1608
  %t1628 = load ptr, ptr %t1549
  call void @__c0c_emit(ptr %t1624, ptr %t1625, i64 %t1626, ptr %t1627, ptr %t1628)
  %t1630 = alloca ptr
  %t1631 = load ptr, ptr %t1630
  %t1632 = getelementptr [6 x i8], ptr @.str184, i64 0, i64 0
  %t1633 = load i64, ptr %t1546
  %t1634 = call i32 @snprintf(ptr %t1631, i64 8, ptr %t1632, i64 %t1633)
  %t1635 = sext i32 %t1634 to i64
  %t1636 = load ptr, ptr %t1630
  %t1637 = load ptr, ptr %t1616
  %t1638 = call i64 @make_val(ptr %t1636, ptr %t1637)
  ret i64 %t1638
L410:
  br label %L21
L21:
  %t1639 = alloca i64
  %t1640 = load ptr, ptr %t1
  %t1641 = sext i32 0 to i64
  %t1642 = getelementptr ptr, ptr %t1640, i64 %t1641
  %t1643 = load ptr, ptr %t1642
  %t1644 = call i64 @emit_expr(ptr %t0, ptr %t1643)
  store i64 %t1644, ptr %t1639
  %t1645 = alloca i64
  %t1646 = load ptr, ptr %t1
  %t1647 = sext i32 1 to i64
  %t1648 = getelementptr ptr, ptr %t1646, i64 %t1647
  %t1649 = load ptr, ptr %t1648
  %t1650 = call i64 @emit_expr(ptr %t0, ptr %t1649)
  store i64 %t1650, ptr %t1645
  %t1651 = alloca ptr
  %t1652 = load ptr, ptr %t1639
  %t1653 = ptrtoint ptr %t1652 to i64
  %t1654 = icmp ne i64 %t1653, 0
  br i1 %t1654, label %L411, label %L412
L411:
  %t1655 = load ptr, ptr %t1639
  %t1656 = load ptr, ptr %t1655
  %t1657 = ptrtoint ptr %t1656 to i64
  %t1658 = icmp ne i64 %t1657, 0
  %t1659 = zext i1 %t1658 to i64
  br label %L413
L412:
  br label %L413
L413:
  %t1660 = phi i64 [ %t1659, %L411 ], [ 0, %L412 ]
  %t1661 = icmp ne i64 %t1660, 0
  br i1 %t1661, label %L414, label %L415
L414:
  %t1662 = load ptr, ptr %t1639
  %t1663 = load ptr, ptr %t1662
  %t1664 = ptrtoint ptr %t1663 to i64
  br label %L416
L415:
  %t1666 = sext i32 0 to i64
  %t1665 = inttoptr i64 %t1666 to ptr
  %t1667 = ptrtoint ptr %t1665 to i64
  br label %L416
L416:
  %t1668 = phi i64 [ %t1664, %L414 ], [ %t1667, %L415 ]
  store i64 %t1668, ptr %t1651
  %t1669 = alloca i64
  %t1670 = load ptr, ptr %t1651
  %t1671 = ptrtoint ptr %t1670 to i64
  %t1672 = icmp ne i64 %t1671, 0
  br i1 %t1672, label %L417, label %L418
L417:
  %t1673 = load ptr, ptr %t1651
  %t1674 = load ptr, ptr %t1673
  %t1676 = ptrtoint ptr %t1674 to i64
  %t1677 = sext i32 15 to i64
  %t1675 = icmp eq i64 %t1676, %t1677
  %t1678 = zext i1 %t1675 to i64
  %t1679 = icmp ne i64 %t1678, 0
  br i1 %t1679, label %L420, label %L421
L420:
  br label %L422
L421:
  %t1680 = load ptr, ptr %t1651
  %t1681 = load ptr, ptr %t1680
  %t1683 = ptrtoint ptr %t1681 to i64
  %t1684 = sext i32 16 to i64
  %t1682 = icmp eq i64 %t1683, %t1684
  %t1685 = zext i1 %t1682 to i64
  %t1686 = icmp ne i64 %t1685, 0
  %t1687 = zext i1 %t1686 to i64
  br label %L422
L422:
  %t1688 = phi i64 [ 1, %L420 ], [ %t1687, %L421 ]
  %t1689 = icmp ne i64 %t1688, 0
  %t1690 = zext i1 %t1689 to i64
  br label %L419
L418:
  br label %L419
L419:
  %t1691 = phi i64 [ %t1690, %L417 ], [ 0, %L418 ]
  store i64 %t1691, ptr %t1669
  %t1692 = alloca i64
  %t1693 = load ptr, ptr %t1651
  %t1694 = ptrtoint ptr %t1693 to i64
  %t1695 = icmp ne i64 %t1694, 0
  br i1 %t1695, label %L423, label %L424
L423:
  %t1696 = load ptr, ptr %t1651
  %t1697 = call i32 @type_is_fp(ptr %t1696)
  %t1698 = sext i32 %t1697 to i64
  %t1699 = icmp ne i64 %t1698, 0
  %t1700 = zext i1 %t1699 to i64
  br label %L425
L424:
  br label %L425
L425:
  %t1701 = phi i64 [ %t1700, %L423 ], [ 0, %L424 ]
  store i64 %t1701, ptr %t1692
  %t1702 = alloca ptr
  %t1703 = alloca ptr
  %t1704 = alloca ptr
  %t1705 = load ptr, ptr %t1651
  %t1707 = ptrtoint ptr %t1705 to i64
  %t1708 = icmp eq i64 %t1707, 0
  %t1706 = zext i1 %t1708 to i64
  %t1709 = icmp ne i64 %t1706, 0
  br i1 %t1709, label %L426, label %L427
L426:
  %t1710 = getelementptr [4 x i8], ptr @.str185, i64 0, i64 0
  store ptr %t1710, ptr %t1702
  %t1711 = getelementptr [4 x i8], ptr @.str186, i64 0, i64 0
  store ptr %t1711, ptr %t1703
  %t1712 = call ptr @default_ptr_type()
  store ptr %t1712, ptr %t1704
  br label %L428
L427:
  %t1713 = load i64, ptr %t1669
  %t1714 = icmp ne i64 %t1713, 0
  br i1 %t1714, label %L429, label %L430
L429:
  %t1715 = getelementptr [4 x i8], ptr @.str187, i64 0, i64 0
  store ptr %t1715, ptr %t1702
  %t1716 = getelementptr [4 x i8], ptr @.str188, i64 0, i64 0
  store ptr %t1716, ptr %t1703
  %t1717 = call ptr @default_ptr_type()
  store ptr %t1717, ptr %t1704
  br label %L431
L430:
  %t1718 = load i64, ptr %t1692
  %t1719 = icmp ne i64 %t1718, 0
  br i1 %t1719, label %L432, label %L433
L432:
  %t1720 = load ptr, ptr %t1651
  %t1721 = call ptr @llvm_type(ptr %t1720)
  store ptr %t1721, ptr %t1702
  %t1722 = load ptr, ptr %t1651
  %t1723 = call ptr @llvm_type(ptr %t1722)
  store ptr %t1723, ptr %t1703
  %t1724 = load ptr, ptr %t1651
  store ptr %t1724, ptr %t1704
  br label %L434
L433:
  %t1725 = getelementptr [4 x i8], ptr @.str189, i64 0, i64 0
  store ptr %t1725, ptr %t1702
  %t1726 = getelementptr [4 x i8], ptr @.str190, i64 0, i64 0
  store ptr %t1726, ptr %t1703
  %t1727 = call ptr @default_i64_type()
  store ptr %t1727, ptr %t1704
  br label %L434
L434:
  br label %L431
L431:
  br label %L428
L428:
  %t1728 = alloca ptr
  %t1729 = alloca ptr
  %t1730 = load i64, ptr %t1639
  %t1731 = call i32 @val_is_ptr(i64 %t1730)
  %t1732 = sext i32 %t1731 to i64
  %t1733 = icmp ne i64 %t1732, 0
  br i1 %t1733, label %L435, label %L436
L435:
  %t1734 = load ptr, ptr %t1728
  %t1735 = load ptr, ptr %t1639
  %t1736 = call ptr @strncpy(ptr %t1734, ptr %t1735, i64 63)
  br label %L437
L436:
  %t1737 = alloca i64
  %t1738 = call i32 @new_reg(ptr %t0)
  %t1739 = sext i32 %t1738 to i64
  store i64 %t1739, ptr %t1737
  %t1740 = load ptr, ptr %t0
  %t1741 = getelementptr [34 x i8], ptr @.str191, i64 0, i64 0
  %t1742 = load i64, ptr %t1737
  %t1743 = load ptr, ptr %t1639
  call void @__c0c_emit(ptr %t1740, ptr %t1741, i64 %t1742, ptr %t1743)
  %t1745 = load ptr, ptr %t1728
  %t1746 = getelementptr [6 x i8], ptr @.str192, i64 0, i64 0
  %t1747 = load i64, ptr %t1737
  %t1748 = call i32 @snprintf(ptr %t1745, i64 64, ptr %t1746, i64 %t1747)
  %t1749 = sext i32 %t1748 to i64
  br label %L437
L437:
  %t1750 = load i64, ptr %t1645
  %t1751 = load ptr, ptr %t1729
  %t1752 = call i32 @promote_to_i64(ptr %t0, i64 %t1750, ptr %t1751, i64 64)
  %t1753 = sext i32 %t1752 to i64
  %t1754 = load ptr, ptr %t1728
  %t1756 = sext i32 63 to i64
  %t1755 = getelementptr ptr, ptr %t1754, i64 %t1756
  %t1757 = sext i32 0 to i64
  store i64 %t1757, ptr %t1755
  %t1758 = alloca i64
  %t1759 = call i32 @new_reg(ptr %t0)
  %t1760 = sext i32 %t1759 to i64
  store i64 %t1760, ptr %t1758
  %t1761 = load ptr, ptr %t0
  %t1762 = getelementptr [44 x i8], ptr @.str193, i64 0, i64 0
  %t1763 = load i64, ptr %t1758
  %t1764 = load ptr, ptr %t1702
  %t1765 = load ptr, ptr %t1728
  %t1766 = load ptr, ptr %t1729
  call void @__c0c_emit(ptr %t1761, ptr %t1762, i64 %t1763, ptr %t1764, ptr %t1765, ptr %t1766)
  %t1768 = alloca i64
  %t1769 = call i32 @new_reg(ptr %t0)
  %t1770 = sext i32 %t1769 to i64
  store i64 %t1770, ptr %t1768
  %t1771 = load ptr, ptr %t0
  %t1772 = getelementptr [30 x i8], ptr @.str194, i64 0, i64 0
  %t1773 = load i64, ptr %t1768
  %t1774 = load ptr, ptr %t1703
  %t1775 = load i64, ptr %t1758
  call void @__c0c_emit(ptr %t1771, ptr %t1772, i64 %t1773, ptr %t1774, i64 %t1775)
  %t1777 = alloca ptr
  %t1778 = load ptr, ptr %t1777
  %t1779 = getelementptr [6 x i8], ptr @.str195, i64 0, i64 0
  %t1780 = load i64, ptr %t1768
  %t1781 = call i32 @snprintf(ptr %t1778, i64 8, ptr %t1779, i64 %t1780)
  %t1782 = sext i32 %t1781 to i64
  %t1783 = load ptr, ptr %t1777
  %t1784 = load ptr, ptr %t1704
  %t1785 = call i64 @make_val(ptr %t1783, ptr %t1784)
  ret i64 %t1785
L438:
  br label %L22
L22:
  %t1786 = alloca i64
  %t1787 = load ptr, ptr %t1
  %t1788 = call i64 @emit_expr(ptr %t0, ptr %t1787)
  store i64 %t1788, ptr %t1786
  %t1789 = alloca ptr
  %t1790 = load ptr, ptr %t1
  store ptr %t1790, ptr %t1789
  %t1791 = load ptr, ptr %t1789
  %t1793 = ptrtoint ptr %t1791 to i64
  %t1794 = icmp eq i64 %t1793, 0
  %t1792 = zext i1 %t1794 to i64
  %t1795 = icmp ne i64 %t1792, 0
  br i1 %t1795, label %L439, label %L441
L439:
  %t1796 = load i64, ptr %t1786
  ret i64 %t1796
L442:
  br label %L441
L441:
  %t1797 = alloca i64
  %t1798 = call i32 @new_reg(ptr %t0)
  %t1799 = sext i32 %t1798 to i64
  store i64 %t1799, ptr %t1797
  %t1800 = alloca i64
  %t1801 = load ptr, ptr %t1786
  %t1802 = call i32 @type_is_fp(ptr %t1801)
  %t1803 = sext i32 %t1802 to i64
  store i64 %t1803, ptr %t1800
  %t1804 = alloca i64
  %t1805 = load ptr, ptr %t1789
  %t1806 = call i32 @type_is_fp(ptr %t1805)
  %t1807 = sext i32 %t1806 to i64
  store i64 %t1807, ptr %t1804
  %t1808 = alloca i64
  %t1809 = load ptr, ptr %t1789
  %t1810 = load ptr, ptr %t1809
  %t1812 = ptrtoint ptr %t1810 to i64
  %t1813 = sext i32 15 to i64
  %t1811 = icmp eq i64 %t1812, %t1813
  %t1814 = zext i1 %t1811 to i64
  %t1815 = icmp ne i64 %t1814, 0
  br i1 %t1815, label %L443, label %L444
L443:
  br label %L445
L444:
  %t1816 = load ptr, ptr %t1789
  %t1817 = load ptr, ptr %t1816
  %t1819 = ptrtoint ptr %t1817 to i64
  %t1820 = sext i32 16 to i64
  %t1818 = icmp eq i64 %t1819, %t1820
  %t1821 = zext i1 %t1818 to i64
  %t1822 = icmp ne i64 %t1821, 0
  %t1823 = zext i1 %t1822 to i64
  br label %L445
L445:
  %t1824 = phi i64 [ 1, %L443 ], [ %t1823, %L444 ]
  store i64 %t1824, ptr %t1808
  %t1825 = alloca i64
  %t1826 = load i64, ptr %t1786
  %t1827 = call i32 @val_is_ptr(i64 %t1826)
  %t1828 = sext i32 %t1827 to i64
  store i64 %t1828, ptr %t1825
  %t1829 = load i64, ptr %t1800
  %t1830 = icmp ne i64 %t1829, 0
  br i1 %t1830, label %L446, label %L447
L446:
  %t1831 = load i64, ptr %t1804
  %t1832 = icmp ne i64 %t1831, 0
  %t1833 = zext i1 %t1832 to i64
  br label %L448
L447:
  br label %L448
L448:
  %t1834 = phi i64 [ %t1833, %L446 ], [ 0, %L447 ]
  %t1835 = icmp ne i64 %t1834, 0
  br i1 %t1835, label %L449, label %L450
L449:
  %t1836 = alloca i64
  %t1837 = load ptr, ptr %t1786
  %t1838 = call i32 @type_size(ptr %t1837)
  %t1839 = sext i32 %t1838 to i64
  store i64 %t1839, ptr %t1836
  %t1840 = alloca i64
  %t1841 = load ptr, ptr %t1789
  %t1842 = call i32 @type_size(ptr %t1841)
  %t1843 = sext i32 %t1842 to i64
  store i64 %t1843, ptr %t1840
  %t1844 = load i64, ptr %t1840
  %t1845 = load i64, ptr %t1836
  %t1846 = icmp sgt i64 %t1844, %t1845
  %t1847 = zext i1 %t1846 to i64
  %t1848 = icmp ne i64 %t1847, 0
  br i1 %t1848, label %L452, label %L453
L452:
  %t1849 = load ptr, ptr %t0
  %t1850 = getelementptr [36 x i8], ptr @.str196, i64 0, i64 0
  %t1851 = load i64, ptr %t1797
  %t1852 = load ptr, ptr %t1786
  call void @__c0c_emit(ptr %t1849, ptr %t1850, i64 %t1851, ptr %t1852)
  br label %L454
L453:
  %t1854 = load ptr, ptr %t0
  %t1855 = getelementptr [38 x i8], ptr @.str197, i64 0, i64 0
  %t1856 = load i64, ptr %t1797
  %t1857 = load ptr, ptr %t1786
  call void @__c0c_emit(ptr %t1854, ptr %t1855, i64 %t1856, ptr %t1857)
  br label %L454
L454:
  br label %L451
L450:
  %t1859 = load i64, ptr %t1800
  %t1860 = icmp ne i64 %t1859, 0
  br i1 %t1860, label %L455, label %L456
L455:
  %t1861 = load i64, ptr %t1804
  %t1863 = icmp eq i64 %t1861, 0
  %t1862 = zext i1 %t1863 to i64
  %t1864 = icmp ne i64 %t1862, 0
  %t1865 = zext i1 %t1864 to i64
  br label %L457
L456:
  br label %L457
L457:
  %t1866 = phi i64 [ %t1865, %L455 ], [ 0, %L456 ]
  %t1867 = icmp ne i64 %t1866, 0
  br i1 %t1867, label %L458, label %L459
L458:
  %t1868 = load ptr, ptr %t0
  %t1869 = getelementptr [35 x i8], ptr @.str198, i64 0, i64 0
  %t1870 = load i64, ptr %t1797
  %t1871 = load ptr, ptr %t1786
  call void @__c0c_emit(ptr %t1868, ptr %t1869, i64 %t1870, ptr %t1871)
  br label %L460
L459:
  %t1873 = load i64, ptr %t1800
  %t1875 = icmp eq i64 %t1873, 0
  %t1874 = zext i1 %t1875 to i64
  %t1876 = icmp ne i64 %t1874, 0
  br i1 %t1876, label %L461, label %L462
L461:
  %t1877 = load i64, ptr %t1804
  %t1878 = icmp ne i64 %t1877, 0
  %t1879 = zext i1 %t1878 to i64
  br label %L463
L462:
  br label %L463
L463:
  %t1880 = phi i64 [ %t1879, %L461 ], [ 0, %L462 ]
  %t1881 = icmp ne i64 %t1880, 0
  br i1 %t1881, label %L464, label %L465
L464:
  %t1882 = alloca ptr
  %t1883 = load i64, ptr %t1786
  %t1884 = load ptr, ptr %t1882
  %t1885 = call i32 @promote_to_i64(ptr %t0, i64 %t1883, ptr %t1884, i64 64)
  %t1886 = sext i32 %t1885 to i64
  %t1887 = load ptr, ptr %t0
  %t1888 = getelementptr [31 x i8], ptr @.str199, i64 0, i64 0
  %t1889 = load i64, ptr %t1797
  %t1890 = load ptr, ptr %t1882
  %t1891 = load ptr, ptr %t1789
  %t1892 = call ptr @llvm_type(ptr %t1891)
  call void @__c0c_emit(ptr %t1887, ptr %t1888, i64 %t1889, ptr %t1890, ptr %t1892)
  br label %L466
L465:
  %t1894 = load i64, ptr %t1808
  %t1895 = icmp ne i64 %t1894, 0
  br i1 %t1895, label %L467, label %L468
L467:
  %t1896 = load i64, ptr %t1825
  %t1898 = icmp eq i64 %t1896, 0
  %t1897 = zext i1 %t1898 to i64
  %t1899 = icmp ne i64 %t1897, 0
  %t1900 = zext i1 %t1899 to i64
  br label %L469
L468:
  br label %L469
L469:
  %t1901 = phi i64 [ %t1900, %L467 ], [ 0, %L468 ]
  %t1902 = icmp ne i64 %t1901, 0
  br i1 %t1902, label %L470, label %L471
L470:
  %t1903 = alloca ptr
  %t1904 = load i64, ptr %t1786
  %t1905 = load ptr, ptr %t1903
  %t1906 = call i32 @promote_to_i64(ptr %t0, i64 %t1904, ptr %t1905, i64 64)
  %t1907 = sext i32 %t1906 to i64
  %t1908 = load ptr, ptr %t0
  %t1909 = getelementptr [34 x i8], ptr @.str200, i64 0, i64 0
  %t1910 = load i64, ptr %t1797
  %t1911 = load ptr, ptr %t1903
  call void @__c0c_emit(ptr %t1908, ptr %t1909, i64 %t1910, ptr %t1911)
  br label %L472
L471:
  %t1913 = load i64, ptr %t1808
  %t1915 = icmp eq i64 %t1913, 0
  %t1914 = zext i1 %t1915 to i64
  %t1916 = icmp ne i64 %t1914, 0
  br i1 %t1916, label %L473, label %L474
L473:
  %t1917 = load i64, ptr %t1825
  %t1918 = icmp ne i64 %t1917, 0
  %t1919 = zext i1 %t1918 to i64
  br label %L475
L474:
  br label %L475
L475:
  %t1920 = phi i64 [ %t1919, %L473 ], [ 0, %L474 ]
  %t1921 = icmp ne i64 %t1920, 0
  br i1 %t1921, label %L476, label %L477
L476:
  %t1922 = load ptr, ptr %t0
  %t1923 = getelementptr [34 x i8], ptr @.str201, i64 0, i64 0
  %t1924 = load i64, ptr %t1797
  %t1925 = load ptr, ptr %t1786
  call void @__c0c_emit(ptr %t1922, ptr %t1923, i64 %t1924, ptr %t1925)
  br label %L478
L477:
  %t1927 = load i64, ptr %t1808
  %t1928 = icmp ne i64 %t1927, 0
  br i1 %t1928, label %L479, label %L480
L479:
  %t1929 = load i64, ptr %t1825
  %t1930 = icmp ne i64 %t1929, 0
  %t1931 = zext i1 %t1930 to i64
  br label %L481
L480:
  br label %L481
L481:
  %t1932 = phi i64 [ %t1931, %L479 ], [ 0, %L480 ]
  %t1933 = icmp ne i64 %t1932, 0
  br i1 %t1933, label %L482, label %L483
L482:
  %t1934 = load ptr, ptr %t0
  %t1935 = getelementptr [33 x i8], ptr @.str202, i64 0, i64 0
  %t1936 = load i64, ptr %t1797
  %t1937 = load ptr, ptr %t1786
  call void @__c0c_emit(ptr %t1934, ptr %t1935, i64 %t1936, ptr %t1937)
  br label %L484
L483:
  %t1939 = alloca ptr
  %t1940 = load i64, ptr %t1786
  %t1941 = load ptr, ptr %t1939
  %t1942 = call i32 @promote_to_i64(ptr %t0, i64 %t1940, ptr %t1941, i64 64)
  %t1943 = sext i32 %t1942 to i64
  %t1944 = load ptr, ptr %t0
  %t1945 = getelementptr [25 x i8], ptr @.str203, i64 0, i64 0
  %t1946 = load i64, ptr %t1797
  %t1947 = load ptr, ptr %t1939
  call void @__c0c_emit(ptr %t1944, ptr %t1945, i64 %t1946, ptr %t1947)
  br label %L484
L484:
  br label %L478
L478:
  br label %L472
L472:
  br label %L466
L466:
  br label %L460
L460:
  br label %L451
L451:
  %t1949 = alloca ptr
  %t1950 = load ptr, ptr %t1949
  %t1951 = getelementptr [6 x i8], ptr @.str204, i64 0, i64 0
  %t1952 = load i64, ptr %t1797
  %t1953 = call i32 @snprintf(ptr %t1950, i64 8, ptr %t1951, i64 %t1952)
  %t1954 = sext i32 %t1953 to i64
  %t1955 = load i64, ptr %t1808
  %t1956 = icmp ne i64 %t1955, 0
  br i1 %t1956, label %L485, label %L487
L485:
  %t1957 = load ptr, ptr %t1949
  %t1958 = call ptr @default_ptr_type()
  %t1959 = call i64 @make_val(ptr %t1957, ptr %t1958)
  ret i64 %t1959
L488:
  br label %L487
L487:
  %t1960 = load i64, ptr %t1804
  %t1961 = icmp ne i64 %t1960, 0
  br i1 %t1961, label %L489, label %L491
L489:
  %t1962 = load ptr, ptr %t1949
  %t1963 = load ptr, ptr %t1789
  %t1964 = call i64 @make_val(ptr %t1962, ptr %t1963)
  ret i64 %t1964
L492:
  br label %L491
L491:
  %t1965 = load ptr, ptr %t1949
  %t1966 = call ptr @default_i64_type()
  %t1967 = call i64 @make_val(ptr %t1965, ptr %t1966)
  ret i64 %t1967
L493:
  br label %L23
L23:
  %t1968 = alloca i64
  %t1969 = load ptr, ptr %t1
  %t1970 = call i64 @emit_expr(ptr %t0, ptr %t1969)
  store i64 %t1970, ptr %t1968
  %t1971 = alloca i64
  %t1972 = call i32 @new_label(ptr %t0)
  %t1973 = sext i32 %t1972 to i64
  store i64 %t1973, ptr %t1971
  %t1974 = alloca i64
  %t1975 = call i32 @new_label(ptr %t0)
  %t1976 = sext i32 %t1975 to i64
  store i64 %t1976, ptr %t1974
  %t1977 = alloca i64
  %t1978 = call i32 @new_label(ptr %t0)
  %t1979 = sext i32 %t1978 to i64
  store i64 %t1979, ptr %t1977
  %t1980 = alloca i64
  %t1981 = load i64, ptr %t1968
  %t1982 = call i32 @emit_cond(ptr %t0, i64 %t1981)
  %t1983 = sext i32 %t1982 to i64
  store i64 %t1983, ptr %t1980
  %t1984 = load ptr, ptr %t0
  %t1985 = getelementptr [41 x i8], ptr @.str205, i64 0, i64 0
  %t1986 = load i64, ptr %t1980
  %t1987 = load i64, ptr %t1971
  %t1988 = load i64, ptr %t1974
  call void @__c0c_emit(ptr %t1984, ptr %t1985, i64 %t1986, i64 %t1987, i64 %t1988)
  %t1990 = load ptr, ptr %t0
  %t1991 = getelementptr [6 x i8], ptr @.str206, i64 0, i64 0
  %t1992 = load i64, ptr %t1971
  call void @__c0c_emit(ptr %t1990, ptr %t1991, i64 %t1992)
  %t1994 = alloca i64
  %t1995 = load ptr, ptr %t1
  %t1996 = sext i32 0 to i64
  %t1997 = getelementptr ptr, ptr %t1995, i64 %t1996
  %t1998 = load ptr, ptr %t1997
  %t1999 = call i64 @emit_expr(ptr %t0, ptr %t1998)
  store i64 %t1999, ptr %t1994
  %t2000 = alloca ptr
  %t2001 = load i64, ptr %t1994
  %t2002 = load ptr, ptr %t2000
  %t2003 = call i32 @promote_to_i64(ptr %t0, i64 %t2001, ptr %t2002, i64 64)
  %t2004 = sext i32 %t2003 to i64
  %t2005 = load ptr, ptr %t0
  %t2006 = getelementptr [18 x i8], ptr @.str207, i64 0, i64 0
  %t2007 = load i64, ptr %t1977
  call void @__c0c_emit(ptr %t2005, ptr %t2006, i64 %t2007)
  %t2009 = load ptr, ptr %t0
  %t2010 = getelementptr [6 x i8], ptr @.str208, i64 0, i64 0
  %t2011 = load i64, ptr %t1974
  call void @__c0c_emit(ptr %t2009, ptr %t2010, i64 %t2011)
  %t2013 = alloca i64
  %t2014 = load ptr, ptr %t1
  %t2015 = sext i32 1 to i64
  %t2016 = getelementptr ptr, ptr %t2014, i64 %t2015
  %t2017 = load ptr, ptr %t2016
  %t2018 = call i64 @emit_expr(ptr %t0, ptr %t2017)
  store i64 %t2018, ptr %t2013
  %t2019 = alloca ptr
  %t2020 = load i64, ptr %t2013
  %t2021 = load ptr, ptr %t2019
  %t2022 = call i32 @promote_to_i64(ptr %t0, i64 %t2020, ptr %t2021, i64 64)
  %t2023 = sext i32 %t2022 to i64
  %t2024 = load ptr, ptr %t0
  %t2025 = getelementptr [18 x i8], ptr @.str209, i64 0, i64 0
  %t2026 = load i64, ptr %t1977
  call void @__c0c_emit(ptr %t2024, ptr %t2025, i64 %t2026)
  %t2028 = load ptr, ptr %t0
  %t2029 = getelementptr [6 x i8], ptr @.str210, i64 0, i64 0
  %t2030 = load i64, ptr %t1977
  call void @__c0c_emit(ptr %t2028, ptr %t2029, i64 %t2030)
  %t2032 = alloca i64
  %t2033 = call i32 @new_reg(ptr %t0)
  %t2034 = sext i32 %t2033 to i64
  store i64 %t2034, ptr %t2032
  %t2035 = load ptr, ptr %t0
  %t2036 = getelementptr [48 x i8], ptr @.str211, i64 0, i64 0
  %t2037 = load i64, ptr %t2032
  %t2038 = load ptr, ptr %t2000
  %t2039 = load i64, ptr %t1971
  %t2040 = load ptr, ptr %t2019
  %t2041 = load i64, ptr %t1974
  call void @__c0c_emit(ptr %t2035, ptr %t2036, i64 %t2037, ptr %t2038, i64 %t2039, ptr %t2040, i64 %t2041)
  %t2043 = alloca ptr
  %t2044 = load ptr, ptr %t2043
  %t2045 = getelementptr [6 x i8], ptr @.str212, i64 0, i64 0
  %t2046 = load i64, ptr %t2032
  %t2047 = call i32 @snprintf(ptr %t2044, i64 8, ptr %t2045, i64 %t2046)
  %t2048 = sext i32 %t2047 to i64
  %t2049 = load ptr, ptr %t2043
  %t2050 = call ptr @default_i64_type()
  %t2051 = call i64 @make_val(ptr %t2049, ptr %t2050)
  ret i64 %t2051
L494:
  br label %L24
L24:
  %t2052 = alloca i64
  %t2053 = load ptr, ptr %t1
  %t2054 = icmp ne ptr %t2053, null
  br i1 %t2054, label %L495, label %L496
L495:
  %t2055 = load ptr, ptr %t1
  %t2056 = call i32 @type_size(ptr %t2055)
  %t2057 = sext i32 %t2056 to i64
  br label %L497
L496:
  %t2058 = sext i32 0 to i64
  br label %L497
L497:
  %t2059 = phi i64 [ %t2057, %L495 ], [ %t2058, %L496 ]
  store i64 %t2059, ptr %t2052
  %t2060 = alloca ptr
  %t2061 = load ptr, ptr %t2060
  %t2062 = getelementptr [3 x i8], ptr @.str213, i64 0, i64 0
  %t2063 = load i64, ptr %t2052
  %t2064 = call i32 @snprintf(ptr %t2061, i64 8, ptr %t2062, i64 %t2063)
  %t2065 = sext i32 %t2064 to i64
  %t2066 = load ptr, ptr %t2060
  %t2067 = call ptr @default_int_type()
  %t2068 = call i64 @make_val(ptr %t2066, ptr %t2067)
  ret i64 %t2068
L498:
  br label %L25
L25:
  %t2069 = alloca i64
  %t2070 = load ptr, ptr %t1
  %t2071 = sext i32 0 to i64
  %t2072 = getelementptr ptr, ptr %t2070, i64 %t2071
  %t2073 = load ptr, ptr %t2072
  %t2074 = load ptr, ptr %t2073
  %t2075 = icmp ne ptr %t2074, null
  br i1 %t2075, label %L499, label %L500
L499:
  %t2076 = load ptr, ptr %t1
  %t2077 = sext i32 0 to i64
  %t2078 = getelementptr ptr, ptr %t2076, i64 %t2077
  %t2079 = load ptr, ptr %t2078
  %t2080 = load ptr, ptr %t2079
  %t2081 = call i32 @type_size(ptr %t2080)
  %t2082 = sext i32 %t2081 to i64
  br label %L501
L500:
  %t2083 = sext i32 8 to i64
  br label %L501
L501:
  %t2084 = phi i64 [ %t2082, %L499 ], [ %t2083, %L500 ]
  store i64 %t2084, ptr %t2069
  %t2085 = alloca ptr
  %t2086 = load ptr, ptr %t2085
  %t2087 = getelementptr [3 x i8], ptr @.str214, i64 0, i64 0
  %t2088 = load i64, ptr %t2069
  %t2089 = call i32 @snprintf(ptr %t2086, i64 8, ptr %t2087, i64 %t2088)
  %t2090 = sext i32 %t2089 to i64
  %t2091 = load ptr, ptr %t2085
  %t2092 = call ptr @default_int_type()
  %t2093 = call i64 @make_val(ptr %t2091, ptr %t2092)
  ret i64 %t2093
L502:
  br label %L26
L26:
  %t2094 = alloca i64
  %t2095 = getelementptr [2 x i8], ptr @.str215, i64 0, i64 0
  %t2096 = call ptr @default_int_type()
  %t2097 = call i64 @make_val(ptr %t2095, ptr %t2096)
  store i64 %t2097, ptr %t2094
  %t2098 = alloca i64
  %t2099 = sext i32 0 to i64
  store i64 %t2099, ptr %t2098
  br label %L503
L503:
  %t2100 = load i64, ptr %t2098
  %t2101 = load ptr, ptr %t1
  %t2103 = ptrtoint ptr %t2101 to i64
  %t2102 = icmp slt i64 %t2100, %t2103
  %t2104 = zext i1 %t2102 to i64
  %t2105 = icmp ne i64 %t2104, 0
  br i1 %t2105, label %L504, label %L506
L504:
  %t2106 = load ptr, ptr %t1
  %t2107 = load i64, ptr %t2098
  %t2108 = getelementptr ptr, ptr %t2106, i64 %t2107
  %t2109 = load ptr, ptr %t2108
  %t2110 = call i64 @emit_expr(ptr %t0, ptr %t2109)
  store i64 %t2110, ptr %t2094
  br label %L505
L505:
  %t2111 = load i64, ptr %t2098
  %t2112 = add i64 %t2111, 1
  store i64 %t2112, ptr %t2098
  br label %L503
L506:
  %t2113 = load i64, ptr %t2094
  ret i64 %t2113
L507:
  br label %L27
L27:
  br label %L28
L28:
  %t2114 = alloca i64
  %t2115 = load ptr, ptr %t1
  %t2117 = ptrtoint ptr %t2115 to i64
  %t2118 = sext i32 35 to i64
  %t2116 = icmp eq i64 %t2117, %t2118
  %t2119 = zext i1 %t2116 to i64
  %t2120 = icmp ne i64 %t2119, 0
  br i1 %t2120, label %L508, label %L509
L508:
  %t2121 = load ptr, ptr %t1
  %t2122 = sext i32 0 to i64
  %t2123 = getelementptr ptr, ptr %t2121, i64 %t2122
  %t2124 = load ptr, ptr %t2123
  %t2125 = call i64 @emit_expr(ptr %t0, ptr %t2124)
  store i64 %t2125, ptr %t2114
  br label %L510
L509:
  %t2126 = alloca ptr
  %t2127 = load ptr, ptr %t1
  %t2128 = sext i32 0 to i64
  %t2129 = getelementptr ptr, ptr %t2127, i64 %t2128
  %t2130 = load ptr, ptr %t2129
  %t2131 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t2130)
  store ptr %t2131, ptr %t2126
  %t2132 = load ptr, ptr %t2126
  %t2133 = icmp ne ptr %t2132, null
  br i1 %t2133, label %L511, label %L512
L511:
  %t2134 = load ptr, ptr %t2126
  %t2135 = call ptr @default_ptr_type()
  %t2136 = call i64 @make_val(ptr %t2134, ptr %t2135)
  store i64 %t2136, ptr %t2114
  %t2137 = load ptr, ptr %t2126
  call void @free(ptr %t2137)
  br label %L513
L512:
  %t2139 = load ptr, ptr %t1
  %t2140 = sext i32 0 to i64
  %t2141 = getelementptr ptr, ptr %t2139, i64 %t2140
  %t2142 = load ptr, ptr %t2141
  %t2143 = call i64 @emit_expr(ptr %t0, ptr %t2142)
  store i64 %t2143, ptr %t2114
  br label %L513
L513:
  br label %L510
L510:
  %t2144 = alloca ptr
  %t2145 = load i64, ptr %t2114
  %t2146 = call i32 @val_is_ptr(i64 %t2145)
  %t2147 = sext i32 %t2146 to i64
  %t2148 = icmp ne i64 %t2147, 0
  br i1 %t2148, label %L514, label %L515
L514:
  %t2149 = load ptr, ptr %t2144
  %t2150 = load ptr, ptr %t2114
  %t2151 = call ptr @strncpy(ptr %t2149, ptr %t2150, i64 63)
  %t2152 = load ptr, ptr %t2144
  %t2154 = sext i32 63 to i64
  %t2153 = getelementptr ptr, ptr %t2152, i64 %t2154
  %t2155 = sext i32 0 to i64
  store i64 %t2155, ptr %t2153
  br label %L516
L515:
  %t2156 = alloca i64
  %t2157 = call i32 @new_reg(ptr %t0)
  %t2158 = sext i32 %t2157 to i64
  store i64 %t2158, ptr %t2156
  %t2159 = alloca ptr
  %t2160 = load i64, ptr %t2114
  %t2161 = load ptr, ptr %t2159
  %t2162 = call i32 @promote_to_i64(ptr %t0, i64 %t2160, ptr %t2161, i64 64)
  %t2163 = sext i32 %t2162 to i64
  %t2164 = load ptr, ptr %t0
  %t2165 = getelementptr [34 x i8], ptr @.str216, i64 0, i64 0
  %t2166 = load i64, ptr %t2156
  %t2167 = load ptr, ptr %t2159
  call void @__c0c_emit(ptr %t2164, ptr %t2165, i64 %t2166, ptr %t2167)
  %t2169 = load ptr, ptr %t2144
  %t2170 = getelementptr [6 x i8], ptr @.str217, i64 0, i64 0
  %t2171 = load i64, ptr %t2156
  %t2172 = call i32 @snprintf(ptr %t2169, i64 64, ptr %t2170, i64 %t2171)
  %t2173 = sext i32 %t2172 to i64
  br label %L516
L516:
  %t2174 = alloca i64
  %t2175 = call i32 @new_reg(ptr %t0)
  %t2176 = sext i32 %t2175 to i64
  store i64 %t2176, ptr %t2174
  %t2177 = load ptr, ptr %t0
  %t2178 = getelementptr [28 x i8], ptr @.str218, i64 0, i64 0
  %t2179 = load i64, ptr %t2174
  %t2180 = load ptr, ptr %t2144
  call void @__c0c_emit(ptr %t2177, ptr %t2178, i64 %t2179, ptr %t2180)
  %t2182 = alloca ptr
  %t2183 = load ptr, ptr %t2182
  %t2184 = getelementptr [6 x i8], ptr @.str219, i64 0, i64 0
  %t2185 = load i64, ptr %t2174
  %t2186 = call i32 @snprintf(ptr %t2183, i64 8, ptr %t2184, i64 %t2185)
  %t2187 = sext i32 %t2186 to i64
  %t2188 = load ptr, ptr %t2182
  %t2189 = call ptr @default_ptr_type()
  %t2190 = call i64 @make_val(ptr %t2188, ptr %t2189)
  ret i64 %t2190
L517:
  br label %L4
L29:
  %t2191 = load ptr, ptr %t0
  %t2192 = getelementptr [28 x i8], ptr @.str220, i64 0, i64 0
  %t2193 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t2191, ptr %t2192, ptr %t2193)
  %t2195 = getelementptr [2 x i8], ptr @.str221, i64 0, i64 0
  %t2196 = call ptr @default_int_type()
  %t2197 = call i64 @make_val(ptr %t2195, ptr %t2196)
  ret i64 %t2197
L518:
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
  %t22 = getelementptr ptr, ptr %t20, i64 %t21
  %t23 = load ptr, ptr %t22
  call void @emit_stmt(ptr %t0, ptr %t23)
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
  %t46 = icmp ne i64 %t45, 0
  br i1 %t46, label %L36, label %L37
L36:
  br label %L38
L37:
  %t47 = load ptr, ptr %t30
  %t48 = load ptr, ptr %t47
  %t50 = ptrtoint ptr %t48 to i64
  %t51 = sext i32 16 to i64
  %t49 = icmp eq i64 %t50, %t51
  %t52 = zext i1 %t49 to i64
  %t53 = icmp ne i64 %t52, 0
  %t54 = zext i1 %t53 to i64
  br label %L38
L38:
  %t55 = phi i64 [ 1, %L36 ], [ %t54, %L37 ]
  %t56 = icmp ne i64 %t55, 0
  br i1 %t56, label %L39, label %L40
L39:
  %t57 = getelementptr [4 x i8], ptr @.str222, i64 0, i64 0
  store ptr %t57, ptr %t38
  %t58 = call ptr @default_ptr_type()
  store ptr %t58, ptr %t39
  br label %L41
L40:
  %t59 = load ptr, ptr %t30
  %t60 = call i32 @type_is_fp(ptr %t59)
  %t61 = sext i32 %t60 to i64
  %t62 = icmp ne i64 %t61, 0
  br i1 %t62, label %L42, label %L43
L42:
  %t63 = load ptr, ptr %t30
  %t64 = call ptr @llvm_type(ptr %t63)
  store ptr %t64, ptr %t38
  %t65 = load ptr, ptr %t30
  store ptr %t65, ptr %t39
  br label %L44
L43:
  %t66 = getelementptr [4 x i8], ptr @.str223, i64 0, i64 0
  store ptr %t66, ptr %t38
  %t67 = call ptr @default_i64_type()
  store ptr %t67, ptr %t39
  br label %L44
L44:
  br label %L41
L41:
  %t68 = alloca i64
  %t69 = call i32 @new_reg(ptr %t0)
  %t70 = sext i32 %t69 to i64
  store i64 %t70, ptr %t68
  %t71 = load ptr, ptr %t0
  %t72 = getelementptr [21 x i8], ptr @.str224, i64 0, i64 0
  %t73 = load i64, ptr %t68
  %t74 = load ptr, ptr %t38
  call void @__c0c_emit(ptr %t71, ptr %t72, i64 %t73, ptr %t74)
  %t76 = load ptr, ptr %t0
  %t78 = ptrtoint ptr %t76 to i64
  %t79 = sext i32 2048 to i64
  %t77 = icmp sge i64 %t78, %t79
  %t80 = zext i1 %t77 to i64
  %t81 = icmp ne i64 %t80, 0
  br i1 %t81, label %L45, label %L47
L45:
  %t82 = call ptr @__c0c_stderr()
  %t83 = getelementptr [22 x i8], ptr @.str225, i64 0, i64 0
  %t84 = call i32 @fprintf(ptr %t82, ptr %t83)
  %t85 = sext i32 %t84 to i64
  call void @exit(i64 1)
  br label %L47
L47:
  %t87 = alloca ptr
  %t88 = load ptr, ptr %t0
  %t89 = load ptr, ptr %t0
  %t91 = ptrtoint ptr %t89 to i64
  %t90 = add i64 %t91, 1
  store i64 %t90, ptr %t0
  %t93 = ptrtoint ptr %t89 to i64
  %t92 = getelementptr ptr, ptr %t88, i64 %t93
  store ptr %t92, ptr %t87
  %t94 = load ptr, ptr %t1
  %t95 = icmp ne ptr %t94, null
  br i1 %t95, label %L48, label %L49
L48:
  %t96 = load ptr, ptr %t1
  %t97 = ptrtoint ptr %t96 to i64
  br label %L50
L49:
  %t98 = getelementptr [7 x i8], ptr @.str226, i64 0, i64 0
  %t99 = ptrtoint ptr %t98 to i64
  br label %L50
L50:
  %t100 = phi i64 [ %t97, %L48 ], [ %t99, %L49 ]
  %t101 = call ptr @strdup(i64 %t100)
  %t102 = load ptr, ptr %t87
  store ptr %t101, ptr %t102
  %t103 = call ptr @malloc(i64 32)
  %t104 = load ptr, ptr %t87
  store ptr %t103, ptr %t104
  %t105 = load ptr, ptr %t87
  %t106 = load ptr, ptr %t105
  %t107 = getelementptr [6 x i8], ptr @.str227, i64 0, i64 0
  %t108 = load i64, ptr %t68
  %t109 = call i32 @snprintf(ptr %t106, i64 32, ptr %t107, i64 %t108)
  %t110 = sext i32 %t109 to i64
  %t111 = load ptr, ptr %t39
  %t112 = load ptr, ptr %t87
  store ptr %t111, ptr %t112
  %t113 = load ptr, ptr %t87
  %t114 = sext i32 0 to i64
  store i64 %t114, ptr %t113
  %t115 = load ptr, ptr %t1
  %t117 = ptrtoint ptr %t115 to i64
  %t118 = sext i32 0 to i64
  %t116 = icmp sgt i64 %t117, %t118
  %t119 = zext i1 %t116 to i64
  %t120 = icmp ne i64 %t119, 0
  br i1 %t120, label %L51, label %L53
L51:
  %t121 = alloca i64
  %t122 = load ptr, ptr %t1
  %t123 = sext i32 0 to i64
  %t124 = getelementptr ptr, ptr %t122, i64 %t123
  %t125 = load ptr, ptr %t124
  %t126 = call i64 @emit_expr(ptr %t0, ptr %t125)
  store i64 %t126, ptr %t121
  %t127 = alloca ptr
  %t128 = load i64, ptr %t121
  %t129 = call i32 @val_is_ptr(i64 %t128)
  %t130 = sext i32 %t129 to i64
  %t131 = icmp ne i64 %t130, 0
  br i1 %t131, label %L54, label %L55
L54:
  %t132 = getelementptr [4 x i8], ptr @.str228, i64 0, i64 0
  store ptr %t132, ptr %t127
  br label %L56
L55:
  %t133 = load ptr, ptr %t121
  %t134 = call i32 @type_is_fp(ptr %t133)
  %t135 = sext i32 %t134 to i64
  %t136 = icmp ne i64 %t135, 0
  br i1 %t136, label %L57, label %L58
L57:
  %t137 = load ptr, ptr %t121
  %t138 = call ptr @llvm_type(ptr %t137)
  store ptr %t138, ptr %t127
  br label %L59
L58:
  %t139 = getelementptr [4 x i8], ptr @.str229, i64 0, i64 0
  store ptr %t139, ptr %t127
  br label %L59
L59:
  br label %L56
L56:
  %t140 = alloca ptr
  %t141 = load i64, ptr %t121
  %t142 = call i32 @val_is_ptr(i64 %t141)
  %t143 = sext i32 %t142 to i64
  %t145 = icmp eq i64 %t143, 0
  %t144 = zext i1 %t145 to i64
  %t146 = icmp ne i64 %t144, 0
  br i1 %t146, label %L60, label %L61
L60:
  %t147 = load i64, ptr %t121
  %t148 = call i32 @val_is_64bit(i64 %t147)
  %t149 = sext i32 %t148 to i64
  %t151 = icmp eq i64 %t149, 0
  %t150 = zext i1 %t151 to i64
  %t152 = icmp ne i64 %t150, 0
  %t153 = zext i1 %t152 to i64
  br label %L62
L61:
  br label %L62
L62:
  %t154 = phi i64 [ %t153, %L60 ], [ 0, %L61 ]
  %t155 = icmp ne i64 %t154, 0
  br i1 %t155, label %L63, label %L64
L63:
  %t156 = load ptr, ptr %t121
  %t157 = call i32 @type_is_fp(ptr %t156)
  %t158 = sext i32 %t157 to i64
  %t160 = icmp eq i64 %t158, 0
  %t159 = zext i1 %t160 to i64
  %t161 = icmp ne i64 %t159, 0
  %t162 = zext i1 %t161 to i64
  br label %L65
L64:
  br label %L65
L65:
  %t163 = phi i64 [ %t162, %L63 ], [ 0, %L64 ]
  %t164 = icmp ne i64 %t163, 0
  br i1 %t164, label %L66, label %L67
L66:
  %t165 = alloca i64
  %t166 = call i32 @new_reg(ptr %t0)
  %t167 = sext i32 %t166 to i64
  store i64 %t167, ptr %t165
  %t168 = load ptr, ptr %t0
  %t169 = getelementptr [30 x i8], ptr @.str230, i64 0, i64 0
  %t170 = load i64, ptr %t165
  %t171 = load ptr, ptr %t121
  call void @__c0c_emit(ptr %t168, ptr %t169, i64 %t170, ptr %t171)
  %t173 = load ptr, ptr %t140
  %t174 = getelementptr [6 x i8], ptr @.str231, i64 0, i64 0
  %t175 = load i64, ptr %t165
  %t176 = call i32 @snprintf(ptr %t173, i64 64, ptr %t174, i64 %t175)
  %t177 = sext i32 %t176 to i64
  br label %L68
L67:
  %t178 = load ptr, ptr %t140
  %t179 = load ptr, ptr %t121
  %t180 = call ptr @strncpy(ptr %t178, ptr %t179, i64 63)
  %t181 = load ptr, ptr %t140
  %t183 = sext i32 63 to i64
  %t182 = getelementptr ptr, ptr %t181, i64 %t183
  %t184 = sext i32 0 to i64
  store i64 %t184, ptr %t182
  br label %L68
L68:
  %t185 = load ptr, ptr %t0
  %t186 = getelementptr [26 x i8], ptr @.str232, i64 0, i64 0
  %t187 = load ptr, ptr %t127
  %t188 = load ptr, ptr %t140
  %t189 = load i64, ptr %t68
  call void @__c0c_emit(ptr %t185, ptr %t186, ptr %t187, ptr %t188, i64 %t189)
  br label %L53
L53:
  %t191 = alloca i64
  %t192 = sext i32 1 to i64
  store i64 %t192, ptr %t191
  br label %L69
L69:
  %t193 = load i64, ptr %t191
  %t194 = load ptr, ptr %t1
  %t196 = ptrtoint ptr %t194 to i64
  %t195 = icmp slt i64 %t193, %t196
  %t197 = zext i1 %t195 to i64
  %t198 = icmp ne i64 %t197, 0
  br i1 %t198, label %L70, label %L72
L70:
  %t199 = load ptr, ptr %t1
  %t200 = load i64, ptr %t191
  %t201 = getelementptr ptr, ptr %t199, i64 %t200
  %t202 = load ptr, ptr %t201
  call void @emit_stmt(ptr %t0, ptr %t202)
  br label %L71
L71:
  %t204 = load i64, ptr %t191
  %t205 = add i64 %t204, 1
  store i64 %t205, ptr %t191
  br label %L69
L72:
  br label %L4
L73:
  br label %L7
L7:
  %t206 = load ptr, ptr %t1
  %t208 = ptrtoint ptr %t206 to i64
  %t209 = sext i32 0 to i64
  %t207 = icmp sgt i64 %t208, %t209
  %t210 = zext i1 %t207 to i64
  %t211 = icmp ne i64 %t210, 0
  br i1 %t211, label %L74, label %L76
L74:
  %t212 = load ptr, ptr %t1
  %t213 = sext i32 0 to i64
  %t214 = getelementptr ptr, ptr %t212, i64 %t213
  %t215 = load ptr, ptr %t214
  %t216 = call i64 @emit_expr(ptr %t0, ptr %t215)
  br label %L76
L76:
  br label %L4
L77:
  br label %L8
L8:
  %t217 = load ptr, ptr %t1
  %t218 = icmp ne ptr %t217, null
  br i1 %t218, label %L78, label %L79
L78:
  %t219 = alloca i64
  %t220 = load ptr, ptr %t1
  %t221 = call i64 @emit_expr(ptr %t0, ptr %t220)
  store i64 %t221, ptr %t219
  %t222 = alloca ptr
  %t223 = load ptr, ptr %t0
  store ptr %t223, ptr %t222
  %t224 = alloca i64
  %t225 = load ptr, ptr %t222
  %t226 = load ptr, ptr %t225
  %t228 = ptrtoint ptr %t226 to i64
  %t229 = sext i32 15 to i64
  %t227 = icmp eq i64 %t228, %t229
  %t230 = zext i1 %t227 to i64
  %t231 = icmp ne i64 %t230, 0
  br i1 %t231, label %L81, label %L82
L81:
  br label %L83
L82:
  %t232 = load ptr, ptr %t222
  %t233 = load ptr, ptr %t232
  %t235 = ptrtoint ptr %t233 to i64
  %t236 = sext i32 16 to i64
  %t234 = icmp eq i64 %t235, %t236
  %t237 = zext i1 %t234 to i64
  %t238 = icmp ne i64 %t237, 0
  %t239 = zext i1 %t238 to i64
  br label %L83
L83:
  %t240 = phi i64 [ 1, %L81 ], [ %t239, %L82 ]
  store i64 %t240, ptr %t224
  %t241 = alloca i64
  %t242 = load ptr, ptr %t222
  %t243 = load ptr, ptr %t242
  %t245 = ptrtoint ptr %t243 to i64
  %t246 = sext i32 0 to i64
  %t244 = icmp eq i64 %t245, %t246
  %t247 = zext i1 %t244 to i64
  store i64 %t247, ptr %t241
  %t248 = alloca i64
  %t249 = load ptr, ptr %t222
  %t250 = call i32 @type_is_fp(ptr %t249)
  %t251 = sext i32 %t250 to i64
  store i64 %t251, ptr %t248
  %t252 = alloca ptr
  %t253 = load ptr, ptr %t222
  %t254 = call ptr @llvm_type(ptr %t253)
  store ptr %t254, ptr %t252
  %t255 = load i64, ptr %t241
  %t256 = icmp ne i64 %t255, 0
  br i1 %t256, label %L84, label %L85
L84:
  %t257 = load ptr, ptr %t0
  %t258 = getelementptr [12 x i8], ptr @.str233, i64 0, i64 0
  call void @__c0c_emit(ptr %t257, ptr %t258)
  br label %L86
L85:
  %t260 = load i64, ptr %t248
  %t261 = icmp ne i64 %t260, 0
  br i1 %t261, label %L87, label %L88
L87:
  %t262 = load ptr, ptr %t0
  %t263 = getelementptr [13 x i8], ptr @.str234, i64 0, i64 0
  %t264 = load ptr, ptr %t252
  %t265 = load ptr, ptr %t219
  call void @__c0c_emit(ptr %t262, ptr %t263, ptr %t264, ptr %t265)
  br label %L89
L88:
  %t267 = load i64, ptr %t224
  %t268 = icmp ne i64 %t267, 0
  br i1 %t268, label %L90, label %L91
L90:
  %t269 = load i64, ptr %t219
  %t270 = call i32 @val_is_ptr(i64 %t269)
  %t271 = sext i32 %t270 to i64
  %t272 = icmp ne i64 %t271, 0
  br i1 %t272, label %L93, label %L94
L93:
  %t273 = load ptr, ptr %t0
  %t274 = getelementptr [14 x i8], ptr @.str235, i64 0, i64 0
  %t275 = load ptr, ptr %t219
  call void @__c0c_emit(ptr %t273, ptr %t274, ptr %t275)
  br label %L95
L94:
  %t277 = alloca i64
  %t278 = call i32 @new_reg(ptr %t0)
  %t279 = sext i32 %t278 to i64
  store i64 %t279, ptr %t277
  %t280 = alloca ptr
  %t281 = load i64, ptr %t219
  %t282 = load ptr, ptr %t280
  %t283 = call i32 @promote_to_i64(ptr %t0, i64 %t281, ptr %t282, i64 64)
  %t284 = sext i32 %t283 to i64
  %t285 = load ptr, ptr %t0
  %t286 = getelementptr [34 x i8], ptr @.str236, i64 0, i64 0
  %t287 = load i64, ptr %t277
  %t288 = load ptr, ptr %t280
  call void @__c0c_emit(ptr %t285, ptr %t286, i64 %t287, ptr %t288)
  %t290 = load ptr, ptr %t0
  %t291 = getelementptr [17 x i8], ptr @.str237, i64 0, i64 0
  %t292 = load i64, ptr %t277
  call void @__c0c_emit(ptr %t290, ptr %t291, i64 %t292)
  br label %L95
L95:
  br label %L92
L91:
  %t294 = alloca ptr
  %t295 = load i64, ptr %t219
  %t296 = load ptr, ptr %t294
  %t297 = call i32 @promote_to_i64(ptr %t0, i64 %t295, ptr %t296, i64 64)
  %t298 = sext i32 %t297 to i64
  %t299 = load ptr, ptr %t252
  %t300 = getelementptr [3 x i8], ptr @.str238, i64 0, i64 0
  %t301 = call i32 @strcmp(ptr %t299, ptr %t300)
  %t302 = sext i32 %t301 to i64
  %t304 = sext i32 0 to i64
  %t303 = icmp eq i64 %t302, %t304
  %t305 = zext i1 %t303 to i64
  %t306 = icmp ne i64 %t305, 0
  br i1 %t306, label %L96, label %L97
L96:
  %t307 = alloca i64
  %t308 = call i32 @new_reg(ptr %t0)
  %t309 = sext i32 %t308 to i64
  store i64 %t309, ptr %t307
  %t310 = load ptr, ptr %t0
  %t311 = getelementptr [30 x i8], ptr @.str239, i64 0, i64 0
  %t312 = load i64, ptr %t307
  %t313 = load ptr, ptr %t294
  call void @__c0c_emit(ptr %t310, ptr %t311, i64 %t312, ptr %t313)
  %t315 = load ptr, ptr %t0
  %t316 = getelementptr [16 x i8], ptr @.str240, i64 0, i64 0
  %t317 = load i64, ptr %t307
  call void @__c0c_emit(ptr %t315, ptr %t316, i64 %t317)
  br label %L98
L97:
  %t319 = load ptr, ptr %t252
  %t320 = getelementptr [4 x i8], ptr @.str241, i64 0, i64 0
  %t321 = call i32 @strcmp(ptr %t319, ptr %t320)
  %t322 = sext i32 %t321 to i64
  %t324 = sext i32 0 to i64
  %t323 = icmp eq i64 %t322, %t324
  %t325 = zext i1 %t323 to i64
  %t326 = icmp ne i64 %t325, 0
  br i1 %t326, label %L99, label %L100
L99:
  %t327 = alloca i64
  %t328 = call i32 @new_reg(ptr %t0)
  %t329 = sext i32 %t328 to i64
  store i64 %t329, ptr %t327
  %t330 = load ptr, ptr %t0
  %t331 = getelementptr [31 x i8], ptr @.str242, i64 0, i64 0
  %t332 = load i64, ptr %t327
  %t333 = load ptr, ptr %t294
  call void @__c0c_emit(ptr %t330, ptr %t331, i64 %t332, ptr %t333)
  %t335 = load ptr, ptr %t0
  %t336 = getelementptr [17 x i8], ptr @.str243, i64 0, i64 0
  %t337 = load i64, ptr %t327
  call void @__c0c_emit(ptr %t335, ptr %t336, i64 %t337)
  br label %L101
L100:
  %t339 = load ptr, ptr %t252
  %t340 = getelementptr [4 x i8], ptr @.str244, i64 0, i64 0
  %t341 = call i32 @strcmp(ptr %t339, ptr %t340)
  %t342 = sext i32 %t341 to i64
  %t344 = sext i32 0 to i64
  %t343 = icmp eq i64 %t342, %t344
  %t345 = zext i1 %t343 to i64
  %t346 = icmp ne i64 %t345, 0
  br i1 %t346, label %L102, label %L103
L102:
  %t347 = alloca i64
  %t348 = call i32 @new_reg(ptr %t0)
  %t349 = sext i32 %t348 to i64
  store i64 %t349, ptr %t347
  %t350 = load ptr, ptr %t0
  %t351 = getelementptr [31 x i8], ptr @.str245, i64 0, i64 0
  %t352 = load i64, ptr %t347
  %t353 = load ptr, ptr %t294
  call void @__c0c_emit(ptr %t350, ptr %t351, i64 %t352, ptr %t353)
  %t355 = load ptr, ptr %t0
  %t356 = getelementptr [17 x i8], ptr @.str246, i64 0, i64 0
  %t357 = load i64, ptr %t347
  call void @__c0c_emit(ptr %t355, ptr %t356, i64 %t357)
  br label %L104
L103:
  %t359 = load ptr, ptr %t0
  %t360 = getelementptr [14 x i8], ptr @.str247, i64 0, i64 0
  %t361 = load ptr, ptr %t294
  call void @__c0c_emit(ptr %t359, ptr %t360, ptr %t361)
  br label %L104
L104:
  br label %L101
L101:
  br label %L98
L98:
  br label %L92
L92:
  br label %L89
L89:
  br label %L86
L86:
  br label %L80
L79:
  %t363 = load ptr, ptr %t0
  %t364 = getelementptr [12 x i8], ptr @.str248, i64 0, i64 0
  call void @__c0c_emit(ptr %t363, ptr %t364)
  br label %L80
L80:
  %t366 = alloca i64
  %t367 = call i32 @new_label(ptr %t0)
  %t368 = sext i32 %t367 to i64
  store i64 %t368, ptr %t366
  %t369 = load ptr, ptr %t0
  %t370 = getelementptr [6 x i8], ptr @.str249, i64 0, i64 0
  %t371 = load i64, ptr %t366
  call void @__c0c_emit(ptr %t369, ptr %t370, i64 %t371)
  br label %L4
L105:
  br label %L9
L9:
  %t373 = alloca i64
  %t374 = load ptr, ptr %t1
  %t375 = call i64 @emit_expr(ptr %t0, ptr %t374)
  store i64 %t375, ptr %t373
  %t376 = alloca i64
  %t377 = load i64, ptr %t373
  %t378 = call i32 @emit_cond(ptr %t0, i64 %t377)
  %t379 = sext i32 %t378 to i64
  store i64 %t379, ptr %t376
  %t380 = alloca i64
  %t381 = call i32 @new_label(ptr %t0)
  %t382 = sext i32 %t381 to i64
  store i64 %t382, ptr %t380
  %t383 = alloca i64
  %t384 = call i32 @new_label(ptr %t0)
  %t385 = sext i32 %t384 to i64
  store i64 %t385, ptr %t383
  %t386 = alloca i64
  %t387 = call i32 @new_label(ptr %t0)
  %t388 = sext i32 %t387 to i64
  store i64 %t388, ptr %t386
  %t389 = load ptr, ptr %t0
  %t390 = getelementptr [41 x i8], ptr @.str250, i64 0, i64 0
  %t391 = load i64, ptr %t376
  %t392 = load i64, ptr %t380
  %t393 = load ptr, ptr %t1
  %t394 = icmp ne ptr %t393, null
  br i1 %t394, label %L106, label %L107
L106:
  %t395 = load i64, ptr %t383
  br label %L108
L107:
  %t396 = load i64, ptr %t386
  br label %L108
L108:
  %t397 = phi i64 [ %t395, %L106 ], [ %t396, %L107 ]
  call void @__c0c_emit(ptr %t389, ptr %t390, i64 %t391, i64 %t392, i64 %t397)
  %t399 = load ptr, ptr %t0
  %t400 = getelementptr [6 x i8], ptr @.str251, i64 0, i64 0
  %t401 = load i64, ptr %t380
  call void @__c0c_emit(ptr %t399, ptr %t400, i64 %t401)
  %t403 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t403)
  %t405 = load ptr, ptr %t0
  %t406 = getelementptr [18 x i8], ptr @.str252, i64 0, i64 0
  %t407 = load i64, ptr %t386
  call void @__c0c_emit(ptr %t405, ptr %t406, i64 %t407)
  %t409 = load ptr, ptr %t1
  %t410 = icmp ne ptr %t409, null
  br i1 %t410, label %L109, label %L111
L109:
  %t411 = load ptr, ptr %t0
  %t412 = getelementptr [6 x i8], ptr @.str253, i64 0, i64 0
  %t413 = load i64, ptr %t383
  call void @__c0c_emit(ptr %t411, ptr %t412, i64 %t413)
  %t415 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t415)
  %t417 = load ptr, ptr %t0
  %t418 = getelementptr [18 x i8], ptr @.str254, i64 0, i64 0
  %t419 = load i64, ptr %t386
  call void @__c0c_emit(ptr %t417, ptr %t418, i64 %t419)
  br label %L111
L111:
  %t421 = load ptr, ptr %t0
  %t422 = getelementptr [6 x i8], ptr @.str255, i64 0, i64 0
  %t423 = load i64, ptr %t386
  call void @__c0c_emit(ptr %t421, ptr %t422, i64 %t423)
  br label %L4
L112:
  br label %L10
L10:
  %t425 = alloca i64
  %t426 = call i32 @new_label(ptr %t0)
  %t427 = sext i32 %t426 to i64
  store i64 %t427, ptr %t425
  %t428 = alloca i64
  %t429 = call i32 @new_label(ptr %t0)
  %t430 = sext i32 %t429 to i64
  store i64 %t430, ptr %t428
  %t431 = alloca i64
  %t432 = call i32 @new_label(ptr %t0)
  %t433 = sext i32 %t432 to i64
  store i64 %t433, ptr %t431
  %t434 = alloca ptr
  %t435 = alloca ptr
  %t436 = load ptr, ptr %t434
  %t437 = load ptr, ptr %t0
  %t438 = call ptr @strcpy(ptr %t436, ptr %t437)
  %t439 = load ptr, ptr %t435
  %t440 = load ptr, ptr %t0
  %t441 = call ptr @strcpy(ptr %t439, ptr %t440)
  %t442 = load ptr, ptr %t0
  %t443 = getelementptr [4 x i8], ptr @.str256, i64 0, i64 0
  %t444 = load i64, ptr %t431
  %t445 = call i32 @snprintf(ptr %t442, i64 64, ptr %t443, i64 %t444)
  %t446 = sext i32 %t445 to i64
  %t447 = load ptr, ptr %t0
  %t448 = getelementptr [4 x i8], ptr @.str257, i64 0, i64 0
  %t449 = load i64, ptr %t425
  %t450 = call i32 @snprintf(ptr %t447, i64 64, ptr %t448, i64 %t449)
  %t451 = sext i32 %t450 to i64
  %t452 = load ptr, ptr %t0
  %t453 = getelementptr [18 x i8], ptr @.str258, i64 0, i64 0
  %t454 = load i64, ptr %t425
  call void @__c0c_emit(ptr %t452, ptr %t453, i64 %t454)
  %t456 = load ptr, ptr %t0
  %t457 = getelementptr [6 x i8], ptr @.str259, i64 0, i64 0
  %t458 = load i64, ptr %t425
  call void @__c0c_emit(ptr %t456, ptr %t457, i64 %t458)
  %t460 = alloca i64
  %t461 = load ptr, ptr %t1
  %t462 = call i64 @emit_expr(ptr %t0, ptr %t461)
  store i64 %t462, ptr %t460
  %t463 = alloca i64
  %t464 = load i64, ptr %t460
  %t465 = call i32 @emit_cond(ptr %t0, i64 %t464)
  %t466 = sext i32 %t465 to i64
  store i64 %t466, ptr %t463
  %t467 = load ptr, ptr %t0
  %t468 = getelementptr [41 x i8], ptr @.str260, i64 0, i64 0
  %t469 = load i64, ptr %t463
  %t470 = load i64, ptr %t428
  %t471 = load i64, ptr %t431
  call void @__c0c_emit(ptr %t467, ptr %t468, i64 %t469, i64 %t470, i64 %t471)
  %t473 = load ptr, ptr %t0
  %t474 = getelementptr [6 x i8], ptr @.str261, i64 0, i64 0
  %t475 = load i64, ptr %t428
  call void @__c0c_emit(ptr %t473, ptr %t474, i64 %t475)
  %t477 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t477)
  %t479 = load ptr, ptr %t0
  %t480 = getelementptr [18 x i8], ptr @.str262, i64 0, i64 0
  %t481 = load i64, ptr %t425
  call void @__c0c_emit(ptr %t479, ptr %t480, i64 %t481)
  %t483 = load ptr, ptr %t0
  %t484 = getelementptr [6 x i8], ptr @.str263, i64 0, i64 0
  %t485 = load i64, ptr %t431
  call void @__c0c_emit(ptr %t483, ptr %t484, i64 %t485)
  %t487 = load ptr, ptr %t0
  %t488 = load ptr, ptr %t434
  %t489 = call ptr @strcpy(ptr %t487, ptr %t488)
  %t490 = load ptr, ptr %t0
  %t491 = load ptr, ptr %t435
  %t492 = call ptr @strcpy(ptr %t490, ptr %t491)
  br label %L4
L113:
  br label %L11
L11:
  %t493 = alloca i64
  %t494 = call i32 @new_label(ptr %t0)
  %t495 = sext i32 %t494 to i64
  store i64 %t495, ptr %t493
  %t496 = alloca i64
  %t497 = call i32 @new_label(ptr %t0)
  %t498 = sext i32 %t497 to i64
  store i64 %t498, ptr %t496
  %t499 = alloca i64
  %t500 = call i32 @new_label(ptr %t0)
  %t501 = sext i32 %t500 to i64
  store i64 %t501, ptr %t499
  %t502 = alloca ptr
  %t503 = alloca ptr
  %t504 = load ptr, ptr %t502
  %t505 = load ptr, ptr %t0
  %t506 = call ptr @strcpy(ptr %t504, ptr %t505)
  %t507 = load ptr, ptr %t503
  %t508 = load ptr, ptr %t0
  %t509 = call ptr @strcpy(ptr %t507, ptr %t508)
  %t510 = load ptr, ptr %t0
  %t511 = getelementptr [4 x i8], ptr @.str264, i64 0, i64 0
  %t512 = load i64, ptr %t499
  %t513 = call i32 @snprintf(ptr %t510, i64 64, ptr %t511, i64 %t512)
  %t514 = sext i32 %t513 to i64
  %t515 = load ptr, ptr %t0
  %t516 = getelementptr [4 x i8], ptr @.str265, i64 0, i64 0
  %t517 = load i64, ptr %t496
  %t518 = call i32 @snprintf(ptr %t515, i64 64, ptr %t516, i64 %t517)
  %t519 = sext i32 %t518 to i64
  %t520 = load ptr, ptr %t0
  %t521 = getelementptr [18 x i8], ptr @.str266, i64 0, i64 0
  %t522 = load i64, ptr %t493
  call void @__c0c_emit(ptr %t520, ptr %t521, i64 %t522)
  %t524 = load ptr, ptr %t0
  %t525 = getelementptr [6 x i8], ptr @.str267, i64 0, i64 0
  %t526 = load i64, ptr %t493
  call void @__c0c_emit(ptr %t524, ptr %t525, i64 %t526)
  %t528 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t528)
  %t530 = load ptr, ptr %t0
  %t531 = getelementptr [18 x i8], ptr @.str268, i64 0, i64 0
  %t532 = load i64, ptr %t496
  call void @__c0c_emit(ptr %t530, ptr %t531, i64 %t532)
  %t534 = load ptr, ptr %t0
  %t535 = getelementptr [6 x i8], ptr @.str269, i64 0, i64 0
  %t536 = load i64, ptr %t496
  call void @__c0c_emit(ptr %t534, ptr %t535, i64 %t536)
  %t538 = alloca i64
  %t539 = load ptr, ptr %t1
  %t540 = call i64 @emit_expr(ptr %t0, ptr %t539)
  store i64 %t540, ptr %t538
  %t541 = alloca i64
  %t542 = load i64, ptr %t538
  %t543 = call i32 @emit_cond(ptr %t0, i64 %t542)
  %t544 = sext i32 %t543 to i64
  store i64 %t544, ptr %t541
  %t545 = load ptr, ptr %t0
  %t546 = getelementptr [41 x i8], ptr @.str270, i64 0, i64 0
  %t547 = load i64, ptr %t541
  %t548 = load i64, ptr %t493
  %t549 = load i64, ptr %t499
  call void @__c0c_emit(ptr %t545, ptr %t546, i64 %t547, i64 %t548, i64 %t549)
  %t551 = load ptr, ptr %t0
  %t552 = getelementptr [6 x i8], ptr @.str271, i64 0, i64 0
  %t553 = load i64, ptr %t499
  call void @__c0c_emit(ptr %t551, ptr %t552, i64 %t553)
  %t555 = load ptr, ptr %t0
  %t556 = load ptr, ptr %t502
  %t557 = call ptr @strcpy(ptr %t555, ptr %t556)
  %t558 = load ptr, ptr %t0
  %t559 = load ptr, ptr %t503
  %t560 = call ptr @strcpy(ptr %t558, ptr %t559)
  br label %L4
L114:
  br label %L12
L12:
  %t561 = alloca i64
  %t562 = call i32 @new_label(ptr %t0)
  %t563 = sext i32 %t562 to i64
  store i64 %t563, ptr %t561
  %t564 = alloca i64
  %t565 = call i32 @new_label(ptr %t0)
  %t566 = sext i32 %t565 to i64
  store i64 %t566, ptr %t564
  %t567 = alloca i64
  %t568 = call i32 @new_label(ptr %t0)
  %t569 = sext i32 %t568 to i64
  store i64 %t569, ptr %t567
  %t570 = alloca i64
  %t571 = call i32 @new_label(ptr %t0)
  %t572 = sext i32 %t571 to i64
  store i64 %t572, ptr %t570
  %t573 = alloca ptr
  %t574 = alloca ptr
  %t575 = load ptr, ptr %t573
  %t576 = load ptr, ptr %t0
  %t577 = call ptr @strcpy(ptr %t575, ptr %t576)
  %t578 = load ptr, ptr %t574
  %t579 = load ptr, ptr %t0
  %t580 = call ptr @strcpy(ptr %t578, ptr %t579)
  %t581 = load ptr, ptr %t0
  %t582 = getelementptr [4 x i8], ptr @.str272, i64 0, i64 0
  %t583 = load i64, ptr %t570
  %t584 = call i32 @snprintf(ptr %t581, i64 64, ptr %t582, i64 %t583)
  %t585 = sext i32 %t584 to i64
  %t586 = load ptr, ptr %t0
  %t587 = getelementptr [4 x i8], ptr @.str273, i64 0, i64 0
  %t588 = load i64, ptr %t567
  %t589 = call i32 @snprintf(ptr %t586, i64 64, ptr %t587, i64 %t588)
  %t590 = sext i32 %t589 to i64
  call void @scope_push(ptr %t0)
  %t592 = load ptr, ptr %t1
  %t593 = icmp ne ptr %t592, null
  br i1 %t593, label %L115, label %L117
L115:
  %t594 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t594)
  br label %L117
L117:
  %t596 = load ptr, ptr %t0
  %t597 = getelementptr [18 x i8], ptr @.str274, i64 0, i64 0
  %t598 = load i64, ptr %t561
  call void @__c0c_emit(ptr %t596, ptr %t597, i64 %t598)
  %t600 = load ptr, ptr %t0
  %t601 = getelementptr [6 x i8], ptr @.str275, i64 0, i64 0
  %t602 = load i64, ptr %t561
  call void @__c0c_emit(ptr %t600, ptr %t601, i64 %t602)
  %t604 = load ptr, ptr %t1
  %t605 = icmp ne ptr %t604, null
  br i1 %t605, label %L118, label %L119
L118:
  %t606 = alloca i64
  %t607 = load ptr, ptr %t1
  %t608 = call i64 @emit_expr(ptr %t0, ptr %t607)
  store i64 %t608, ptr %t606
  %t609 = alloca i64
  %t610 = load i64, ptr %t606
  %t611 = call i32 @emit_cond(ptr %t0, i64 %t610)
  %t612 = sext i32 %t611 to i64
  store i64 %t612, ptr %t609
  %t613 = load ptr, ptr %t0
  %t614 = getelementptr [41 x i8], ptr @.str276, i64 0, i64 0
  %t615 = load i64, ptr %t609
  %t616 = load i64, ptr %t564
  %t617 = load i64, ptr %t570
  call void @__c0c_emit(ptr %t613, ptr %t614, i64 %t615, i64 %t616, i64 %t617)
  br label %L120
L119:
  %t619 = load ptr, ptr %t0
  %t620 = getelementptr [18 x i8], ptr @.str277, i64 0, i64 0
  %t621 = load i64, ptr %t564
  call void @__c0c_emit(ptr %t619, ptr %t620, i64 %t621)
  br label %L120
L120:
  %t623 = load ptr, ptr %t0
  %t624 = getelementptr [6 x i8], ptr @.str278, i64 0, i64 0
  %t625 = load i64, ptr %t564
  call void @__c0c_emit(ptr %t623, ptr %t624, i64 %t625)
  %t627 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t627)
  %t629 = load ptr, ptr %t0
  %t630 = getelementptr [18 x i8], ptr @.str279, i64 0, i64 0
  %t631 = load i64, ptr %t567
  call void @__c0c_emit(ptr %t629, ptr %t630, i64 %t631)
  %t633 = load ptr, ptr %t0
  %t634 = getelementptr [6 x i8], ptr @.str280, i64 0, i64 0
  %t635 = load i64, ptr %t567
  call void @__c0c_emit(ptr %t633, ptr %t634, i64 %t635)
  %t637 = load ptr, ptr %t1
  %t638 = icmp ne ptr %t637, null
  br i1 %t638, label %L121, label %L123
L121:
  %t639 = load ptr, ptr %t1
  %t640 = call i64 @emit_expr(ptr %t0, ptr %t639)
  br label %L123
L123:
  %t641 = load ptr, ptr %t0
  %t642 = getelementptr [18 x i8], ptr @.str281, i64 0, i64 0
  %t643 = load i64, ptr %t561
  call void @__c0c_emit(ptr %t641, ptr %t642, i64 %t643)
  %t645 = load ptr, ptr %t0
  %t646 = getelementptr [6 x i8], ptr @.str282, i64 0, i64 0
  %t647 = load i64, ptr %t570
  call void @__c0c_emit(ptr %t645, ptr %t646, i64 %t647)
  call void @scope_pop(ptr %t0)
  %t650 = load ptr, ptr %t0
  %t651 = load ptr, ptr %t573
  %t652 = call ptr @strcpy(ptr %t650, ptr %t651)
  %t653 = load ptr, ptr %t0
  %t654 = load ptr, ptr %t574
  %t655 = call ptr @strcpy(ptr %t653, ptr %t654)
  br label %L4
L124:
  br label %L13
L13:
  %t656 = load ptr, ptr %t0
  %t657 = getelementptr [17 x i8], ptr @.str283, i64 0, i64 0
  %t658 = load ptr, ptr %t0
  call void @__c0c_emit(ptr %t656, ptr %t657, ptr %t658)
  %t660 = alloca i64
  %t661 = call i32 @new_label(ptr %t0)
  %t662 = sext i32 %t661 to i64
  store i64 %t662, ptr %t660
  %t663 = load ptr, ptr %t0
  %t664 = getelementptr [6 x i8], ptr @.str284, i64 0, i64 0
  %t665 = load i64, ptr %t660
  call void @__c0c_emit(ptr %t663, ptr %t664, i64 %t665)
  br label %L4
L125:
  br label %L14
L14:
  %t667 = load ptr, ptr %t0
  %t668 = getelementptr [17 x i8], ptr @.str285, i64 0, i64 0
  %t669 = load ptr, ptr %t0
  call void @__c0c_emit(ptr %t667, ptr %t668, ptr %t669)
  %t671 = alloca i64
  %t672 = call i32 @new_label(ptr %t0)
  %t673 = sext i32 %t672 to i64
  store i64 %t673, ptr %t671
  %t674 = load ptr, ptr %t0
  %t675 = getelementptr [6 x i8], ptr @.str286, i64 0, i64 0
  %t676 = load i64, ptr %t671
  call void @__c0c_emit(ptr %t674, ptr %t675, i64 %t676)
  br label %L4
L126:
  br label %L15
L15:
  %t678 = alloca i64
  %t679 = load ptr, ptr %t1
  %t680 = call i64 @emit_expr(ptr %t0, ptr %t679)
  store i64 %t680, ptr %t678
  %t681 = alloca i64
  %t682 = call i32 @new_label(ptr %t0)
  %t683 = sext i32 %t682 to i64
  store i64 %t683, ptr %t681
  %t684 = alloca ptr
  %t685 = load ptr, ptr %t684
  %t686 = load ptr, ptr %t0
  %t687 = call ptr @strcpy(ptr %t685, ptr %t686)
  %t688 = load ptr, ptr %t0
  %t689 = getelementptr [4 x i8], ptr @.str287, i64 0, i64 0
  %t690 = load i64, ptr %t681
  %t691 = call i32 @snprintf(ptr %t688, i64 64, ptr %t689, i64 %t690)
  %t692 = sext i32 %t691 to i64
  %t693 = alloca ptr
  %t694 = load ptr, ptr %t1
  store ptr %t694, ptr %t693
  %t695 = alloca i64
  %t696 = sext i32 0 to i64
  store i64 %t696, ptr %t695
  %t697 = alloca ptr
  %t698 = alloca ptr
  %t699 = alloca i64
  %t700 = load i64, ptr %t681
  store i64 %t700, ptr %t699
  %t701 = alloca i64
  %t702 = sext i32 0 to i64
  store i64 %t702, ptr %t701
  br label %L127
L127:
  %t703 = load i64, ptr %t701
  %t704 = load ptr, ptr %t693
  %t705 = load ptr, ptr %t704
  %t707 = ptrtoint ptr %t705 to i64
  %t706 = icmp slt i64 %t703, %t707
  %t708 = zext i1 %t706 to i64
  %t709 = icmp ne i64 %t708, 0
  br i1 %t709, label %L131, label %L132
L131:
  %t710 = load i64, ptr %t695
  %t712 = sext i32 256 to i64
  %t711 = icmp slt i64 %t710, %t712
  %t713 = zext i1 %t711 to i64
  %t714 = icmp ne i64 %t713, 0
  %t715 = zext i1 %t714 to i64
  br label %L133
L132:
  br label %L133
L133:
  %t716 = phi i64 [ %t715, %L131 ], [ 0, %L132 ]
  %t717 = icmp ne i64 %t716, 0
  br i1 %t717, label %L128, label %L130
L128:
  %t718 = alloca ptr
  %t719 = load ptr, ptr %t693
  %t720 = load ptr, ptr %t719
  %t721 = load i64, ptr %t701
  %t722 = getelementptr ptr, ptr %t720, i64 %t721
  %t723 = load ptr, ptr %t722
  store ptr %t723, ptr %t718
  %t724 = load ptr, ptr %t718
  %t725 = load ptr, ptr %t724
  %t727 = ptrtoint ptr %t725 to i64
  %t728 = sext i32 14 to i64
  %t726 = icmp eq i64 %t727, %t728
  %t729 = zext i1 %t726 to i64
  %t730 = icmp ne i64 %t729, 0
  br i1 %t730, label %L134, label %L135
L134:
  %t731 = call i32 @new_label(ptr %t0)
  %t732 = sext i32 %t731 to i64
  %t733 = load ptr, ptr %t697
  %t734 = load i64, ptr %t695
  %t735 = getelementptr ptr, ptr %t733, i64 %t734
  store i64 %t732, ptr %t735
  %t736 = load ptr, ptr %t718
  %t737 = load ptr, ptr %t736
  %t738 = icmp ne ptr %t737, null
  br i1 %t738, label %L137, label %L138
L137:
  %t739 = load ptr, ptr %t718
  %t740 = load ptr, ptr %t739
  %t741 = load ptr, ptr %t740
  %t742 = ptrtoint ptr %t741 to i64
  br label %L139
L138:
  %t743 = sext i32 0 to i64
  br label %L139
L139:
  %t744 = phi i64 [ %t742, %L137 ], [ %t743, %L138 ]
  %t745 = load ptr, ptr %t698
  %t746 = load i64, ptr %t695
  %t747 = getelementptr ptr, ptr %t745, i64 %t746
  store i64 %t744, ptr %t747
  %t748 = load i64, ptr %t695
  %t749 = add i64 %t748, 1
  store i64 %t749, ptr %t695
  br label %L136
L135:
  %t750 = load ptr, ptr %t718
  %t751 = load ptr, ptr %t750
  %t753 = ptrtoint ptr %t751 to i64
  %t754 = sext i32 15 to i64
  %t752 = icmp eq i64 %t753, %t754
  %t755 = zext i1 %t752 to i64
  %t756 = icmp ne i64 %t755, 0
  br i1 %t756, label %L140, label %L142
L140:
  %t757 = call i32 @new_label(ptr %t0)
  %t758 = sext i32 %t757 to i64
  store i64 %t758, ptr %t699
  br label %L142
L142:
  br label %L136
L136:
  br label %L129
L129:
  %t759 = load i64, ptr %t701
  %t760 = add i64 %t759, 1
  store i64 %t760, ptr %t701
  br label %L127
L130:
  %t761 = alloca ptr
  %t762 = load i64, ptr %t678
  %t763 = load ptr, ptr %t761
  %t764 = call i32 @promote_to_i64(ptr %t0, i64 %t762, ptr %t763, i64 64)
  %t765 = sext i32 %t764 to i64
  %t766 = alloca i64
  %t767 = call i32 @new_reg(ptr %t0)
  %t768 = sext i32 %t767 to i64
  store i64 %t768, ptr %t766
  %t769 = load ptr, ptr %t0
  %t770 = getelementptr [25 x i8], ptr @.str288, i64 0, i64 0
  %t771 = load i64, ptr %t766
  %t772 = load ptr, ptr %t761
  call void @__c0c_emit(ptr %t769, ptr %t770, i64 %t771, ptr %t772)
  %t774 = load ptr, ptr %t0
  %t775 = getelementptr [35 x i8], ptr @.str289, i64 0, i64 0
  %t776 = load i64, ptr %t766
  %t777 = load i64, ptr %t699
  call void @__c0c_emit(ptr %t774, ptr %t775, i64 %t776, i64 %t777)
  %t779 = alloca i64
  %t780 = sext i32 0 to i64
  store i64 %t780, ptr %t779
  %t781 = alloca i64
  %t782 = sext i32 0 to i64
  store i64 %t782, ptr %t781
  br label %L143
L143:
  %t783 = load i64, ptr %t781
  %t784 = load ptr, ptr %t693
  %t785 = load ptr, ptr %t784
  %t787 = ptrtoint ptr %t785 to i64
  %t786 = icmp slt i64 %t783, %t787
  %t788 = zext i1 %t786 to i64
  %t789 = icmp ne i64 %t788, 0
  br i1 %t789, label %L144, label %L146
L144:
  %t790 = alloca ptr
  %t791 = load ptr, ptr %t693
  %t792 = load ptr, ptr %t791
  %t793 = load i64, ptr %t781
  %t794 = getelementptr ptr, ptr %t792, i64 %t793
  %t795 = load ptr, ptr %t794
  store ptr %t795, ptr %t790
  %t796 = load ptr, ptr %t790
  %t797 = load ptr, ptr %t796
  %t799 = ptrtoint ptr %t797 to i64
  %t800 = sext i32 14 to i64
  %t798 = icmp eq i64 %t799, %t800
  %t801 = zext i1 %t798 to i64
  %t802 = icmp ne i64 %t801, 0
  br i1 %t802, label %L147, label %L148
L147:
  %t803 = load i64, ptr %t779
  %t804 = load i64, ptr %t695
  %t805 = icmp slt i64 %t803, %t804
  %t806 = zext i1 %t805 to i64
  %t807 = icmp ne i64 %t806, 0
  %t808 = zext i1 %t807 to i64
  br label %L149
L148:
  br label %L149
L149:
  %t809 = phi i64 [ %t808, %L147 ], [ 0, %L148 ]
  %t810 = icmp ne i64 %t809, 0
  br i1 %t810, label %L150, label %L152
L150:
  %t811 = load ptr, ptr %t0
  %t812 = getelementptr [27 x i8], ptr @.str290, i64 0, i64 0
  %t813 = load ptr, ptr %t698
  %t814 = load i64, ptr %t779
  %t815 = getelementptr ptr, ptr %t813, i64 %t814
  %t816 = load ptr, ptr %t815
  %t817 = load ptr, ptr %t697
  %t818 = load i64, ptr %t779
  %t819 = getelementptr ptr, ptr %t817, i64 %t818
  %t820 = load ptr, ptr %t819
  call void @__c0c_emit(ptr %t811, ptr %t812, ptr %t816, ptr %t820)
  %t822 = load i64, ptr %t779
  %t823 = add i64 %t822, 1
  store i64 %t823, ptr %t779
  br label %L152
L152:
  br label %L145
L145:
  %t824 = load i64, ptr %t781
  %t825 = add i64 %t824, 1
  store i64 %t825, ptr %t781
  br label %L143
L146:
  %t826 = load ptr, ptr %t0
  %t827 = getelementptr [5 x i8], ptr @.str291, i64 0, i64 0
  call void @__c0c_emit(ptr %t826, ptr %t827)
  %t829 = sext i32 0 to i64
  store i64 %t829, ptr %t779
  %t830 = alloca i64
  %t831 = sext i32 0 to i64
  store i64 %t831, ptr %t830
  %t832 = alloca i64
  %t833 = sext i32 0 to i64
  store i64 %t833, ptr %t832
  br label %L153
L153:
  %t834 = load i64, ptr %t832
  %t835 = load ptr, ptr %t693
  %t836 = load ptr, ptr %t835
  %t838 = ptrtoint ptr %t836 to i64
  %t837 = icmp slt i64 %t834, %t838
  %t839 = zext i1 %t837 to i64
  %t840 = icmp ne i64 %t839, 0
  br i1 %t840, label %L154, label %L156
L154:
  %t841 = alloca ptr
  %t842 = load ptr, ptr %t693
  %t843 = load ptr, ptr %t842
  %t844 = load i64, ptr %t832
  %t845 = getelementptr ptr, ptr %t843, i64 %t844
  %t846 = load ptr, ptr %t845
  store ptr %t846, ptr %t841
  %t847 = load ptr, ptr %t841
  %t848 = load ptr, ptr %t847
  %t850 = ptrtoint ptr %t848 to i64
  %t851 = sext i32 14 to i64
  %t849 = icmp eq i64 %t850, %t851
  %t852 = zext i1 %t849 to i64
  %t853 = icmp ne i64 %t852, 0
  br i1 %t853, label %L157, label %L158
L157:
  %t854 = load i64, ptr %t779
  %t855 = load i64, ptr %t695
  %t856 = icmp slt i64 %t854, %t855
  %t857 = zext i1 %t856 to i64
  %t858 = icmp ne i64 %t857, 0
  %t859 = zext i1 %t858 to i64
  br label %L159
L158:
  br label %L159
L159:
  %t860 = phi i64 [ %t859, %L157 ], [ 0, %L158 ]
  %t861 = icmp ne i64 %t860, 0
  br i1 %t861, label %L160, label %L161
L160:
  %t862 = load ptr, ptr %t0
  %t863 = getelementptr [6 x i8], ptr @.str292, i64 0, i64 0
  %t864 = load ptr, ptr %t697
  %t865 = load i64, ptr %t779
  %t866 = add i64 %t865, 1
  store i64 %t866, ptr %t779
  %t867 = getelementptr ptr, ptr %t864, i64 %t865
  %t868 = load ptr, ptr %t867
  call void @__c0c_emit(ptr %t862, ptr %t863, ptr %t868)
  %t870 = load ptr, ptr %t841
  %t871 = load ptr, ptr %t870
  %t873 = ptrtoint ptr %t871 to i64
  %t874 = sext i32 0 to i64
  %t872 = icmp sgt i64 %t873, %t874
  %t875 = zext i1 %t872 to i64
  %t876 = icmp ne i64 %t875, 0
  br i1 %t876, label %L163, label %L165
L163:
  %t877 = load ptr, ptr %t841
  %t878 = load ptr, ptr %t877
  %t879 = sext i32 0 to i64
  %t880 = getelementptr ptr, ptr %t878, i64 %t879
  %t881 = load ptr, ptr %t880
  call void @emit_stmt(ptr %t0, ptr %t881)
  br label %L165
L165:
  %t883 = alloca i64
  %t884 = load i64, ptr %t779
  %t885 = load i64, ptr %t695
  %t886 = icmp slt i64 %t884, %t885
  %t887 = zext i1 %t886 to i64
  %t888 = icmp ne i64 %t887, 0
  br i1 %t888, label %L166, label %L167
L166:
  %t889 = load ptr, ptr %t697
  %t890 = load i64, ptr %t779
  %t891 = getelementptr ptr, ptr %t889, i64 %t890
  %t892 = load ptr, ptr %t891
  %t893 = ptrtoint ptr %t892 to i64
  br label %L168
L167:
  %t894 = load i64, ptr %t681
  br label %L168
L168:
  %t895 = phi i64 [ %t893, %L166 ], [ %t894, %L167 ]
  store i64 %t895, ptr %t883
  %t896 = load ptr, ptr %t0
  %t897 = getelementptr [18 x i8], ptr @.str293, i64 0, i64 0
  %t898 = load i64, ptr %t883
  call void @__c0c_emit(ptr %t896, ptr %t897, i64 %t898)
  br label %L162
L161:
  %t900 = load ptr, ptr %t841
  %t901 = load ptr, ptr %t900
  %t903 = ptrtoint ptr %t901 to i64
  %t904 = sext i32 15 to i64
  %t902 = icmp eq i64 %t903, %t904
  %t905 = zext i1 %t902 to i64
  %t906 = icmp ne i64 %t905, 0
  br i1 %t906, label %L169, label %L170
L169:
  %t907 = load ptr, ptr %t0
  %t908 = getelementptr [6 x i8], ptr @.str294, i64 0, i64 0
  %t909 = load i64, ptr %t699
  call void @__c0c_emit(ptr %t907, ptr %t908, i64 %t909)
  %t911 = load ptr, ptr %t841
  %t912 = load ptr, ptr %t911
  %t914 = ptrtoint ptr %t912 to i64
  %t915 = sext i32 0 to i64
  %t913 = icmp sgt i64 %t914, %t915
  %t916 = zext i1 %t913 to i64
  %t917 = icmp ne i64 %t916, 0
  br i1 %t917, label %L172, label %L174
L172:
  %t918 = load ptr, ptr %t841
  %t919 = load ptr, ptr %t918
  %t920 = sext i32 0 to i64
  %t921 = getelementptr ptr, ptr %t919, i64 %t920
  %t922 = load ptr, ptr %t921
  call void @emit_stmt(ptr %t0, ptr %t922)
  br label %L174
L174:
  %t924 = load ptr, ptr %t0
  %t925 = getelementptr [18 x i8], ptr @.str295, i64 0, i64 0
  %t926 = load i64, ptr %t681
  call void @__c0c_emit(ptr %t924, ptr %t925, i64 %t926)
  %t928 = load i64, ptr %t830
  %t929 = add i64 %t928, 1
  store i64 %t929, ptr %t830
  br label %L171
L170:
  %t930 = load ptr, ptr %t841
  call void @emit_stmt(ptr %t0, ptr %t930)
  br label %L171
L171:
  br label %L162
L162:
  br label %L155
L155:
  %t932 = load i64, ptr %t832
  %t933 = add i64 %t932, 1
  store i64 %t933, ptr %t832
  br label %L153
L156:
  %t934 = load ptr, ptr %t0
  %t935 = getelementptr [6 x i8], ptr @.str296, i64 0, i64 0
  %t936 = load i64, ptr %t681
  call void @__c0c_emit(ptr %t934, ptr %t935, i64 %t936)
  %t938 = load ptr, ptr %t0
  %t939 = load ptr, ptr %t684
  %t940 = call ptr @strcpy(ptr %t938, ptr %t939)
  br label %L4
L175:
  br label %L16
L16:
  %t941 = load ptr, ptr %t1
  %t943 = ptrtoint ptr %t941 to i64
  %t944 = sext i32 0 to i64
  %t942 = icmp sgt i64 %t943, %t944
  %t945 = zext i1 %t942 to i64
  %t946 = icmp ne i64 %t945, 0
  br i1 %t946, label %L176, label %L178
L176:
  %t947 = load ptr, ptr %t1
  %t948 = sext i32 0 to i64
  %t949 = getelementptr ptr, ptr %t947, i64 %t948
  %t950 = load ptr, ptr %t949
  call void @emit_stmt(ptr %t0, ptr %t950)
  br label %L178
L178:
  br label %L4
L179:
  br label %L17
L17:
  %t952 = load ptr, ptr %t1
  %t954 = ptrtoint ptr %t952 to i64
  %t955 = sext i32 0 to i64
  %t953 = icmp sgt i64 %t954, %t955
  %t956 = zext i1 %t953 to i64
  %t957 = icmp ne i64 %t956, 0
  br i1 %t957, label %L180, label %L182
L180:
  %t958 = load ptr, ptr %t1
  %t959 = sext i32 0 to i64
  %t960 = getelementptr ptr, ptr %t958, i64 %t959
  %t961 = load ptr, ptr %t960
  call void @emit_stmt(ptr %t0, ptr %t961)
  br label %L182
L182:
  br label %L4
L183:
  br label %L18
L18:
  %t963 = load ptr, ptr %t0
  %t964 = getelementptr [17 x i8], ptr @.str297, i64 0, i64 0
  %t965 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t963, ptr %t964, ptr %t965)
  %t967 = load ptr, ptr %t0
  %t968 = getelementptr [5 x i8], ptr @.str298, i64 0, i64 0
  %t969 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t967, ptr %t968, ptr %t969)
  %t971 = load ptr, ptr %t1
  %t973 = ptrtoint ptr %t971 to i64
  %t974 = sext i32 0 to i64
  %t972 = icmp sgt i64 %t973, %t974
  %t975 = zext i1 %t972 to i64
  %t976 = icmp ne i64 %t975, 0
  br i1 %t976, label %L184, label %L186
L184:
  %t977 = load ptr, ptr %t1
  %t978 = sext i32 0 to i64
  %t979 = getelementptr ptr, ptr %t977, i64 %t978
  %t980 = load ptr, ptr %t979
  call void @emit_stmt(ptr %t0, ptr %t980)
  br label %L186
L186:
  br label %L4
L187:
  br label %L19
L19:
  %t982 = load ptr, ptr %t0
  %t983 = getelementptr [17 x i8], ptr @.str299, i64 0, i64 0
  %t984 = load ptr, ptr %t1
  call void @__c0c_emit(ptr %t982, ptr %t983, ptr %t984)
  %t986 = alloca i64
  %t987 = call i32 @new_label(ptr %t0)
  %t988 = sext i32 %t987 to i64
  store i64 %t988, ptr %t986
  %t989 = load ptr, ptr %t0
  %t990 = getelementptr [6 x i8], ptr @.str300, i64 0, i64 0
  %t991 = load i64, ptr %t986
  call void @__c0c_emit(ptr %t989, ptr %t990, i64 %t991)
  br label %L4
L188:
  br label %L20
L20:
  br label %L4
L189:
  br label %L4
L21:
  %t993 = call i64 @emit_expr(ptr %t0, ptr %t1)
  br label %L4
L190:
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
  %t8 = icmp ne i64 %t5, 0
  br i1 %t8, label %L0, label %L1
L0:
  br label %L2
L1:
  %t9 = load ptr, ptr %t2
  %t10 = load ptr, ptr %t9
  %t12 = ptrtoint ptr %t10 to i64
  %t13 = sext i32 17 to i64
  %t11 = icmp ne i64 %t12, %t13
  %t14 = zext i1 %t11 to i64
  %t15 = icmp ne i64 %t14, 0
  %t16 = zext i1 %t15 to i64
  br label %L2
L2:
  %t17 = phi i64 [ 1, %L0 ], [ %t16, %L1 ]
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L3, label %L5
L3:
  ret void
L6:
  br label %L5
L5:
  %t19 = sext i32 0 to i64
  store i64 %t19, ptr %t0
  %t20 = sext i32 0 to i64
  store i64 %t20, ptr %t0
  %t21 = sext i32 0 to i64
  store i64 %t21, ptr %t0
  %t22 = load ptr, ptr %t2
  %t23 = load ptr, ptr %t22
  %t24 = icmp ne ptr %t23, null
  br i1 %t24, label %L7, label %L8
L7:
  %t25 = load ptr, ptr %t2
  %t26 = load ptr, ptr %t25
  %t27 = ptrtoint ptr %t26 to i64
  br label %L9
L8:
  %t28 = call ptr @default_int_type()
  %t29 = ptrtoint ptr %t28 to i64
  br label %L9
L9:
  %t30 = phi i64 [ %t27, %L7 ], [ %t29, %L8 ]
  store i64 %t30, ptr %t0
  %t31 = load ptr, ptr %t0
  %t32 = load ptr, ptr %t1
  %t33 = icmp ne ptr %t32, null
  br i1 %t33, label %L10, label %L11
L10:
  %t34 = load ptr, ptr %t1
  %t35 = ptrtoint ptr %t34 to i64
  br label %L12
L11:
  %t36 = getelementptr [5 x i8], ptr @.str301, i64 0, i64 0
  %t37 = ptrtoint ptr %t36 to i64
  br label %L12
L12:
  %t38 = phi i64 [ %t35, %L10 ], [ %t37, %L11 ]
  %t39 = call ptr @strncpy(ptr %t31, i64 %t38, i64 127)
  %t40 = alloca ptr
  %t41 = load ptr, ptr %t1
  %t42 = icmp ne ptr %t41, null
  br i1 %t42, label %L13, label %L14
L13:
  %t43 = getelementptr [9 x i8], ptr @.str302, i64 0, i64 0
  %t44 = ptrtoint ptr %t43 to i64
  br label %L15
L14:
  %t45 = getelementptr [10 x i8], ptr @.str303, i64 0, i64 0
  %t46 = ptrtoint ptr %t45 to i64
  br label %L15
L15:
  %t47 = phi i64 [ %t44, %L13 ], [ %t46, %L14 ]
  store i64 %t47, ptr %t40
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr [18 x i8], ptr @.str304, i64 0, i64 0
  %t50 = load ptr, ptr %t40
  %t51 = load ptr, ptr %t2
  %t52 = call ptr @llvm_ret_type(ptr %t51)
  %t53 = load ptr, ptr %t1
  %t54 = icmp ne ptr %t53, null
  br i1 %t54, label %L16, label %L17
L16:
  %t55 = load ptr, ptr %t1
  %t56 = ptrtoint ptr %t55 to i64
  br label %L18
L17:
  %t57 = getelementptr [5 x i8], ptr @.str305, i64 0, i64 0
  %t58 = ptrtoint ptr %t57 to i64
  br label %L18
L18:
  %t59 = phi i64 [ %t56, %L16 ], [ %t58, %L17 ]
  call void @__c0c_emit(ptr %t48, ptr %t49, ptr %t50, ptr %t52, i64 %t59)
  call void @scope_push(ptr %t0)
  %t62 = alloca i64
  %t63 = sext i32 0 to i64
  store i64 %t63, ptr %t62
  %t64 = alloca i64
  %t65 = sext i32 0 to i64
  store i64 %t65, ptr %t64
  br label %L19
L19:
  %t66 = load i64, ptr %t64
  %t67 = load ptr, ptr %t2
  %t68 = load ptr, ptr %t67
  %t70 = ptrtoint ptr %t68 to i64
  %t69 = icmp slt i64 %t66, %t70
  %t71 = zext i1 %t69 to i64
  %t72 = icmp ne i64 %t71, 0
  br i1 %t72, label %L20, label %L22
L20:
  %t73 = alloca ptr
  %t74 = load ptr, ptr %t2
  %t75 = load ptr, ptr %t74
  %t76 = load i64, ptr %t64
  %t77 = getelementptr ptr, ptr %t75, i64 %t76
  %t78 = load ptr, ptr %t77
  store ptr %t78, ptr %t73
  %t79 = load ptr, ptr %t73
  %t80 = ptrtoint ptr %t79 to i64
  %t81 = icmp ne i64 %t80, 0
  br i1 %t81, label %L23, label %L24
L23:
  %t82 = load ptr, ptr %t73
  %t83 = load ptr, ptr %t82
  %t85 = ptrtoint ptr %t83 to i64
  %t86 = sext i32 0 to i64
  %t84 = icmp eq i64 %t85, %t86
  %t87 = zext i1 %t84 to i64
  %t88 = icmp ne i64 %t87, 0
  %t89 = zext i1 %t88 to i64
  br label %L25
L24:
  br label %L25
L25:
  %t90 = phi i64 [ %t89, %L23 ], [ 0, %L24 ]
  %t91 = icmp ne i64 %t90, 0
  br i1 %t91, label %L26, label %L27
L26:
  %t92 = load ptr, ptr %t2
  %t93 = load ptr, ptr %t92
  %t95 = ptrtoint ptr %t93 to i64
  %t96 = sext i32 1 to i64
  %t94 = icmp eq i64 %t95, %t96
  %t97 = zext i1 %t94 to i64
  %t98 = icmp ne i64 %t97, 0
  %t99 = zext i1 %t98 to i64
  br label %L28
L27:
  br label %L28
L28:
  %t100 = phi i64 [ %t99, %L26 ], [ 0, %L27 ]
  %t101 = icmp ne i64 %t100, 0
  br i1 %t101, label %L29, label %L31
L29:
  br label %L22
L32:
  br label %L31
L31:
  %t102 = load i64, ptr %t62
  %t103 = icmp ne i64 %t102, 0
  br i1 %t103, label %L33, label %L35
L33:
  %t104 = load ptr, ptr %t0
  %t105 = getelementptr [3 x i8], ptr @.str306, i64 0, i64 0
  call void @__c0c_emit(ptr %t104, ptr %t105)
  br label %L35
L35:
  %t107 = alloca ptr
  %t108 = alloca ptr
  %t109 = load ptr, ptr %t73
  %t111 = ptrtoint ptr %t109 to i64
  %t112 = icmp eq i64 %t111, 0
  %t110 = zext i1 %t112 to i64
  %t113 = icmp ne i64 %t110, 0
  br i1 %t113, label %L36, label %L37
L36:
  br label %L38
L37:
  %t114 = load ptr, ptr %t73
  %t115 = call i32 @type_is_fp(ptr %t114)
  %t116 = sext i32 %t115 to i64
  %t117 = icmp ne i64 %t116, 0
  %t118 = zext i1 %t117 to i64
  br label %L38
L38:
  %t119 = phi i64 [ 1, %L36 ], [ %t118, %L37 ]
  %t120 = icmp ne i64 %t119, 0
  br i1 %t120, label %L39, label %L40
L39:
  %t121 = load ptr, ptr %t73
  %t122 = icmp ne ptr %t121, null
  br i1 %t122, label %L42, label %L43
L42:
  %t123 = load ptr, ptr %t73
  %t124 = call ptr @llvm_type(ptr %t123)
  %t125 = ptrtoint ptr %t124 to i64
  br label %L44
L43:
  %t126 = getelementptr [4 x i8], ptr @.str307, i64 0, i64 0
  %t127 = ptrtoint ptr %t126 to i64
  br label %L44
L44:
  %t128 = phi i64 [ %t125, %L42 ], [ %t127, %L43 ]
  store i64 %t128, ptr %t107
  %t129 = load ptr, ptr %t73
  store ptr %t129, ptr %t108
  br label %L41
L40:
  %t130 = load ptr, ptr %t73
  %t131 = load ptr, ptr %t130
  %t133 = ptrtoint ptr %t131 to i64
  %t134 = sext i32 15 to i64
  %t132 = icmp eq i64 %t133, %t134
  %t135 = zext i1 %t132 to i64
  %t136 = icmp ne i64 %t135, 0
  br i1 %t136, label %L45, label %L46
L45:
  br label %L47
L46:
  %t137 = load ptr, ptr %t73
  %t138 = load ptr, ptr %t137
  %t140 = ptrtoint ptr %t138 to i64
  %t141 = sext i32 16 to i64
  %t139 = icmp eq i64 %t140, %t141
  %t142 = zext i1 %t139 to i64
  %t143 = icmp ne i64 %t142, 0
  %t144 = zext i1 %t143 to i64
  br label %L47
L47:
  %t145 = phi i64 [ 1, %L45 ], [ %t144, %L46 ]
  %t146 = icmp ne i64 %t145, 0
  br i1 %t146, label %L48, label %L49
L48:
  %t147 = getelementptr [4 x i8], ptr @.str308, i64 0, i64 0
  store ptr %t147, ptr %t107
  %t148 = call ptr @default_ptr_type()
  store ptr %t148, ptr %t108
  br label %L50
L49:
  %t149 = load ptr, ptr %t73
  %t150 = load ptr, ptr %t149
  %t152 = ptrtoint ptr %t150 to i64
  %t153 = sext i32 18 to i64
  %t151 = icmp eq i64 %t152, %t153
  %t154 = zext i1 %t151 to i64
  %t155 = icmp ne i64 %t154, 0
  br i1 %t155, label %L51, label %L52
L51:
  br label %L53
L52:
  %t156 = load ptr, ptr %t73
  %t157 = load ptr, ptr %t156
  %t159 = ptrtoint ptr %t157 to i64
  %t160 = sext i32 19 to i64
  %t158 = icmp eq i64 %t159, %t160
  %t161 = zext i1 %t158 to i64
  %t162 = icmp ne i64 %t161, 0
  %t163 = zext i1 %t162 to i64
  br label %L53
L53:
  %t164 = phi i64 [ 1, %L51 ], [ %t163, %L52 ]
  %t165 = icmp ne i64 %t164, 0
  br i1 %t165, label %L54, label %L55
L54:
  br label %L56
L55:
  %t166 = load ptr, ptr %t73
  %t167 = load ptr, ptr %t166
  %t169 = ptrtoint ptr %t167 to i64
  %t170 = sext i32 21 to i64
  %t168 = icmp eq i64 %t169, %t170
  %t171 = zext i1 %t168 to i64
  %t172 = icmp ne i64 %t171, 0
  %t173 = zext i1 %t172 to i64
  br label %L56
L56:
  %t174 = phi i64 [ 1, %L54 ], [ %t173, %L55 ]
  %t175 = icmp ne i64 %t174, 0
  br i1 %t175, label %L57, label %L58
L57:
  %t176 = getelementptr [4 x i8], ptr @.str309, i64 0, i64 0
  store ptr %t176, ptr %t107
  %t177 = call ptr @default_ptr_type()
  store ptr %t177, ptr %t108
  br label %L59
L58:
  %t178 = getelementptr [4 x i8], ptr @.str310, i64 0, i64 0
  store ptr %t178, ptr %t107
  %t179 = call ptr @default_i64_type()
  store ptr %t179, ptr %t108
  br label %L59
L59:
  br label %L50
L50:
  br label %L41
L41:
  %t180 = alloca i64
  %t181 = call i32 @new_reg(ptr %t0)
  %t182 = sext i32 %t181 to i64
  store i64 %t182, ptr %t180
  %t183 = load ptr, ptr %t0
  %t184 = getelementptr [9 x i8], ptr @.str311, i64 0, i64 0
  %t185 = load ptr, ptr %t107
  %t186 = load i64, ptr %t180
  call void @__c0c_emit(ptr %t183, ptr %t184, ptr %t185, i64 %t186)
  %t188 = load i64, ptr %t62
  %t189 = add i64 %t188, 1
  store i64 %t189, ptr %t62
  %t190 = load ptr, ptr %t1
  %t191 = ptrtoint ptr %t190 to i64
  %t192 = icmp ne i64 %t191, 0
  br i1 %t192, label %L60, label %L61
L60:
  %t193 = load ptr, ptr %t1
  %t194 = load i64, ptr %t64
  %t195 = getelementptr ptr, ptr %t193, i64 %t194
  %t196 = load ptr, ptr %t195
  %t197 = ptrtoint ptr %t196 to i64
  %t198 = icmp ne i64 %t197, 0
  %t199 = zext i1 %t198 to i64
  br label %L62
L61:
  br label %L62
L62:
  %t200 = phi i64 [ %t199, %L60 ], [ 0, %L61 ]
  %t201 = icmp ne i64 %t200, 0
  br i1 %t201, label %L63, label %L65
L63:
  %t202 = load ptr, ptr %t0
  %t204 = ptrtoint ptr %t202 to i64
  %t205 = sext i32 2048 to i64
  %t203 = icmp sge i64 %t204, %t205
  %t206 = zext i1 %t203 to i64
  %t207 = icmp ne i64 %t206, 0
  br i1 %t207, label %L66, label %L68
L66:
  %t208 = call ptr @__c0c_stderr()
  %t209 = getelementptr [22 x i8], ptr @.str312, i64 0, i64 0
  %t210 = call i32 @fprintf(ptr %t208, ptr %t209)
  %t211 = sext i32 %t210 to i64
  call void @exit(i64 1)
  br label %L68
L68:
  %t213 = alloca ptr
  %t214 = load ptr, ptr %t0
  %t215 = load ptr, ptr %t0
  %t217 = ptrtoint ptr %t215 to i64
  %t216 = add i64 %t217, 1
  store i64 %t216, ptr %t0
  %t219 = ptrtoint ptr %t215 to i64
  %t218 = getelementptr ptr, ptr %t214, i64 %t219
  store ptr %t218, ptr %t213
  %t220 = load ptr, ptr %t1
  %t221 = load i64, ptr %t64
  %t222 = getelementptr ptr, ptr %t220, i64 %t221
  %t223 = load ptr, ptr %t222
  %t224 = call ptr @strdup(ptr %t223)
  %t225 = load ptr, ptr %t213
  store ptr %t224, ptr %t225
  %t226 = call ptr @malloc(i64 32)
  %t227 = load ptr, ptr %t213
  store ptr %t226, ptr %t227
  %t228 = load ptr, ptr %t213
  %t229 = load ptr, ptr %t228
  %t230 = getelementptr [6 x i8], ptr @.str313, i64 0, i64 0
  %t231 = load i64, ptr %t180
  %t232 = call i32 @snprintf(ptr %t229, i64 32, ptr %t230, i64 %t231)
  %t233 = sext i32 %t232 to i64
  %t234 = load ptr, ptr %t108
  %t235 = load ptr, ptr %t213
  store ptr %t234, ptr %t235
  %t236 = load ptr, ptr %t213
  %t237 = sext i32 1 to i64
  store i64 %t237, ptr %t236
  br label %L65
L65:
  br label %L21
L21:
  %t238 = load i64, ptr %t64
  %t239 = add i64 %t238, 1
  store i64 %t239, ptr %t64
  br label %L19
L22:
  %t240 = load ptr, ptr %t2
  %t241 = load ptr, ptr %t240
  %t242 = icmp ne ptr %t241, null
  br i1 %t242, label %L69, label %L71
L69:
  %t243 = load i64, ptr %t62
  %t244 = icmp ne i64 %t243, 0
  br i1 %t244, label %L72, label %L74
L72:
  %t245 = load ptr, ptr %t0
  %t246 = getelementptr [3 x i8], ptr @.str314, i64 0, i64 0
  call void @__c0c_emit(ptr %t245, ptr %t246)
  br label %L74
L74:
  %t248 = load ptr, ptr %t0
  %t249 = getelementptr [4 x i8], ptr @.str315, i64 0, i64 0
  call void @__c0c_emit(ptr %t248, ptr %t249)
  br label %L71
L71:
  %t251 = load ptr, ptr %t0
  %t252 = getelementptr [5 x i8], ptr @.str316, i64 0, i64 0
  call void @__c0c_emit(ptr %t251, ptr %t252)
  %t254 = load ptr, ptr %t0
  %t255 = getelementptr [8 x i8], ptr @.str317, i64 0, i64 0
  call void @__c0c_emit(ptr %t254, ptr %t255)
  %t257 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t257)
  %t259 = load ptr, ptr %t2
  %t260 = load ptr, ptr %t259
  %t262 = ptrtoint ptr %t260 to i64
  %t263 = icmp eq i64 %t262, 0
  %t261 = zext i1 %t263 to i64
  %t264 = icmp ne i64 %t261, 0
  br i1 %t264, label %L75, label %L76
L75:
  br label %L77
L76:
  %t265 = load ptr, ptr %t2
  %t266 = load ptr, ptr %t265
  %t267 = load ptr, ptr %t266
  %t269 = ptrtoint ptr %t267 to i64
  %t270 = sext i32 0 to i64
  %t268 = icmp eq i64 %t269, %t270
  %t271 = zext i1 %t268 to i64
  %t272 = icmp ne i64 %t271, 0
  %t273 = zext i1 %t272 to i64
  br label %L77
L77:
  %t274 = phi i64 [ 1, %L75 ], [ %t273, %L76 ]
  %t275 = icmp ne i64 %t274, 0
  br i1 %t275, label %L78, label %L79
L78:
  %t276 = load ptr, ptr %t0
  %t277 = getelementptr [12 x i8], ptr @.str318, i64 0, i64 0
  call void @__c0c_emit(ptr %t276, ptr %t277)
  br label %L80
L79:
  %t279 = load ptr, ptr %t2
  %t280 = load ptr, ptr %t279
  %t281 = load ptr, ptr %t280
  %t283 = ptrtoint ptr %t281 to i64
  %t284 = sext i32 15 to i64
  %t282 = icmp eq i64 %t283, %t284
  %t285 = zext i1 %t282 to i64
  %t286 = icmp ne i64 %t285, 0
  br i1 %t286, label %L81, label %L82
L81:
  br label %L83
L82:
  %t287 = load ptr, ptr %t2
  %t288 = load ptr, ptr %t287
  %t289 = load ptr, ptr %t288
  %t291 = ptrtoint ptr %t289 to i64
  %t292 = sext i32 16 to i64
  %t290 = icmp eq i64 %t291, %t292
  %t293 = zext i1 %t290 to i64
  %t294 = icmp ne i64 %t293, 0
  %t295 = zext i1 %t294 to i64
  br label %L83
L83:
  %t296 = phi i64 [ 1, %L81 ], [ %t295, %L82 ]
  %t297 = icmp ne i64 %t296, 0
  br i1 %t297, label %L84, label %L85
L84:
  %t298 = load ptr, ptr %t0
  %t299 = getelementptr [16 x i8], ptr @.str319, i64 0, i64 0
  call void @__c0c_emit(ptr %t298, ptr %t299)
  br label %L86
L85:
  %t301 = load ptr, ptr %t2
  %t302 = load ptr, ptr %t301
  %t303 = call i32 @type_is_fp(ptr %t302)
  %t304 = sext i32 %t303 to i64
  %t305 = icmp ne i64 %t304, 0
  br i1 %t305, label %L87, label %L88
L87:
  %t306 = load ptr, ptr %t0
  %t307 = getelementptr [14 x i8], ptr @.str320, i64 0, i64 0
  %t308 = load ptr, ptr %t2
  %t309 = load ptr, ptr %t308
  %t310 = call ptr @llvm_type(ptr %t309)
  call void @__c0c_emit(ptr %t306, ptr %t307, ptr %t310)
  br label %L89
L88:
  %t312 = alloca ptr
  %t313 = load ptr, ptr %t2
  %t314 = load ptr, ptr %t313
  %t315 = call ptr @llvm_type(ptr %t314)
  store ptr %t315, ptr %t312
  %t316 = load ptr, ptr %t312
  %t317 = getelementptr [3 x i8], ptr @.str321, i64 0, i64 0
  %t318 = call i32 @strcmp(ptr %t316, ptr %t317)
  %t319 = sext i32 %t318 to i64
  %t321 = sext i32 0 to i64
  %t320 = icmp eq i64 %t319, %t321
  %t322 = zext i1 %t320 to i64
  %t323 = icmp ne i64 %t322, 0
  br i1 %t323, label %L90, label %L91
L90:
  %t324 = load ptr, ptr %t0
  %t325 = getelementptr [12 x i8], ptr @.str322, i64 0, i64 0
  call void @__c0c_emit(ptr %t324, ptr %t325)
  br label %L92
L91:
  %t327 = load ptr, ptr %t312
  %t328 = getelementptr [4 x i8], ptr @.str323, i64 0, i64 0
  %t329 = call i32 @strcmp(ptr %t327, ptr %t328)
  %t330 = sext i32 %t329 to i64
  %t332 = sext i32 0 to i64
  %t331 = icmp eq i64 %t330, %t332
  %t333 = zext i1 %t331 to i64
  %t334 = icmp ne i64 %t333, 0
  br i1 %t334, label %L93, label %L94
L93:
  %t335 = load ptr, ptr %t0
  %t336 = getelementptr [13 x i8], ptr @.str324, i64 0, i64 0
  call void @__c0c_emit(ptr %t335, ptr %t336)
  br label %L95
L94:
  %t338 = load ptr, ptr %t312
  %t339 = getelementptr [4 x i8], ptr @.str325, i64 0, i64 0
  %t340 = call i32 @strcmp(ptr %t338, ptr %t339)
  %t341 = sext i32 %t340 to i64
  %t343 = sext i32 0 to i64
  %t342 = icmp eq i64 %t341, %t343
  %t344 = zext i1 %t342 to i64
  %t345 = icmp ne i64 %t344, 0
  br i1 %t345, label %L96, label %L97
L96:
  %t346 = load ptr, ptr %t0
  %t347 = getelementptr [13 x i8], ptr @.str326, i64 0, i64 0
  call void @__c0c_emit(ptr %t346, ptr %t347)
  br label %L98
L97:
  %t349 = load ptr, ptr %t0
  %t350 = getelementptr [13 x i8], ptr @.str327, i64 0, i64 0
  call void @__c0c_emit(ptr %t349, ptr %t350)
  br label %L98
L98:
  br label %L95
L95:
  br label %L92
L92:
  br label %L89
L89:
  br label %L86
L86:
  br label %L80
L80:
  %t352 = load ptr, ptr %t0
  %t353 = getelementptr [4 x i8], ptr @.str328, i64 0, i64 0
  call void @__c0c_emit(ptr %t352, ptr %t353)
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
  %t10 = ptrtoint ptr %t9 to i64
  %t11 = icmp ne i64 %t10, 0
  br i1 %t11, label %L4, label %L5
L4:
  %t12 = load ptr, ptr %t7
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 17 to i64
  %t14 = icmp eq i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  %t19 = zext i1 %t18 to i64
  br label %L6
L5:
  br label %L6
L6:
  %t20 = phi i64 [ %t19, %L4 ], [ 0, %L5 ]
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L7, label %L9
L7:
  %t22 = alloca i64
  %t23 = sext i32 0 to i64
  store i64 %t23, ptr %t22
  %t24 = alloca i64
  %t25 = sext i32 0 to i64
  store i64 %t25, ptr %t24
  br label %L10
L10:
  %t26 = load i64, ptr %t24
  %t27 = load ptr, ptr %t0
  %t29 = ptrtoint ptr %t27 to i64
  %t28 = icmp slt i64 %t26, %t29
  %t30 = zext i1 %t28 to i64
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L11, label %L13
L11:
  %t32 = load ptr, ptr %t0
  %t33 = load i64, ptr %t24
  %t34 = getelementptr ptr, ptr %t32, i64 %t33
  %t35 = load ptr, ptr %t34
  %t36 = load ptr, ptr %t1
  %t37 = call i32 @strcmp(ptr %t35, ptr %t36)
  %t38 = sext i32 %t37 to i64
  %t40 = sext i32 0 to i64
  %t39 = icmp eq i64 %t38, %t40
  %t41 = zext i1 %t39 to i64
  %t42 = icmp ne i64 %t41, 0
  br i1 %t42, label %L14, label %L16
L14:
  %t43 = sext i32 1 to i64
  store i64 %t43, ptr %t22
  br label %L13
L17:
  br label %L16
L16:
  br label %L12
L12:
  %t44 = load i64, ptr %t24
  %t45 = add i64 %t44, 1
  store i64 %t45, ptr %t24
  br label %L10
L13:
  %t46 = load i64, ptr %t22
  %t47 = icmp ne i64 %t46, 0
  br i1 %t47, label %L18, label %L20
L18:
  ret void
L21:
  br label %L20
L20:
  %t48 = load ptr, ptr %t0
  %t50 = ptrtoint ptr %t48 to i64
  %t51 = sext i32 2048 to i64
  %t49 = icmp slt i64 %t50, %t51
  %t52 = zext i1 %t49 to i64
  %t53 = icmp ne i64 %t52, 0
  br i1 %t53, label %L22, label %L24
L22:
  %t54 = load ptr, ptr %t1
  %t55 = call ptr @strdup(ptr %t54)
  %t56 = load ptr, ptr %t0
  %t57 = load ptr, ptr %t0
  %t59 = ptrtoint ptr %t57 to i64
  %t58 = getelementptr ptr, ptr %t56, i64 %t59
  store ptr %t55, ptr %t58
  %t60 = load ptr, ptr %t7
  %t61 = load ptr, ptr %t0
  %t62 = load ptr, ptr %t0
  %t64 = ptrtoint ptr %t62 to i64
  %t63 = getelementptr ptr, ptr %t61, i64 %t64
  store ptr %t60, ptr %t63
  %t65 = load ptr, ptr %t0
  %t66 = load ptr, ptr %t0
  %t68 = ptrtoint ptr %t66 to i64
  %t67 = getelementptr ptr, ptr %t65, i64 %t68
  %t69 = sext i32 1 to i64
  store i64 %t69, ptr %t67
  %t70 = load ptr, ptr %t0
  %t72 = ptrtoint ptr %t70 to i64
  %t71 = add i64 %t72, 1
  store i64 %t71, ptr %t0
  br label %L24
L24:
  %t73 = alloca ptr
  %t74 = sext i32 0 to i64
  store i64 %t74, ptr %t73
  %t75 = alloca i64
  %t76 = sext i32 0 to i64
  store i64 %t76, ptr %t75
  %t77 = alloca i64
  %t78 = sext i32 0 to i64
  store i64 %t78, ptr %t77
  br label %L25
L25:
  %t79 = load i64, ptr %t77
  %t80 = load ptr, ptr %t7
  %t81 = load ptr, ptr %t80
  %t83 = ptrtoint ptr %t81 to i64
  %t82 = icmp slt i64 %t79, %t83
  %t84 = zext i1 %t82 to i64
  %t85 = icmp ne i64 %t84, 0
  br i1 %t85, label %L29, label %L30
L29:
  %t86 = load i64, ptr %t75
  %t88 = sext i32 480 to i64
  %t87 = icmp slt i64 %t86, %t88
  %t89 = zext i1 %t87 to i64
  %t90 = icmp ne i64 %t89, 0
  %t91 = zext i1 %t90 to i64
  br label %L31
L30:
  br label %L31
L31:
  %t92 = phi i64 [ %t91, %L29 ], [ 0, %L30 ]
  %t93 = icmp ne i64 %t92, 0
  br i1 %t93, label %L26, label %L28
L26:
  %t94 = alloca ptr
  %t95 = load ptr, ptr %t7
  %t96 = load ptr, ptr %t95
  %t97 = load i64, ptr %t77
  %t98 = getelementptr ptr, ptr %t96, i64 %t97
  %t99 = load ptr, ptr %t98
  store ptr %t99, ptr %t94
  %t100 = load ptr, ptr %t94
  %t101 = ptrtoint ptr %t100 to i64
  %t102 = icmp ne i64 %t101, 0
  br i1 %t102, label %L32, label %L33
L32:
  %t103 = load ptr, ptr %t94
  %t104 = load ptr, ptr %t103
  %t106 = ptrtoint ptr %t104 to i64
  %t107 = sext i32 0 to i64
  %t105 = icmp eq i64 %t106, %t107
  %t108 = zext i1 %t105 to i64
  %t109 = icmp ne i64 %t108, 0
  %t110 = zext i1 %t109 to i64
  br label %L34
L33:
  br label %L34
L34:
  %t111 = phi i64 [ %t110, %L32 ], [ 0, %L33 ]
  %t112 = icmp ne i64 %t111, 0
  br i1 %t112, label %L35, label %L36
L35:
  %t113 = load ptr, ptr %t7
  %t114 = load ptr, ptr %t113
  %t116 = ptrtoint ptr %t114 to i64
  %t117 = sext i32 1 to i64
  %t115 = icmp eq i64 %t116, %t117
  %t118 = zext i1 %t115 to i64
  %t119 = icmp ne i64 %t118, 0
  %t120 = zext i1 %t119 to i64
  br label %L37
L36:
  br label %L37
L37:
  %t121 = phi i64 [ %t120, %L35 ], [ 0, %L36 ]
  %t122 = icmp ne i64 %t121, 0
  br i1 %t122, label %L38, label %L40
L38:
  br label %L28
L41:
  br label %L40
L40:
  %t123 = load i64, ptr %t77
  %t124 = icmp ne i64 %t123, 0
  br i1 %t124, label %L42, label %L44
L42:
  %t125 = load i64, ptr %t75
  %t126 = load ptr, ptr %t73
  %t127 = load i64, ptr %t75
  %t129 = ptrtoint ptr %t126 to i64
  %t130 = inttoptr i64 %t129 to ptr
  %t128 = getelementptr i8, ptr %t130, i64 %t127
  %t131 = load i64, ptr %t75
  %t133 = sext i32 512 to i64
  %t132 = sub i64 %t133, %t131
  %t134 = getelementptr [3 x i8], ptr @.str329, i64 0, i64 0
  %t135 = call i32 @snprintf(ptr %t128, i64 %t132, ptr %t134)
  %t136 = sext i32 %t135 to i64
  %t137 = add i64 %t125, %t136
  store i64 %t137, ptr %t75
  br label %L44
L44:
  %t138 = alloca ptr
  %t139 = load ptr, ptr %t94
  %t141 = ptrtoint ptr %t139 to i64
  %t142 = icmp eq i64 %t141, 0
  %t140 = zext i1 %t142 to i64
  %t143 = icmp ne i64 %t140, 0
  br i1 %t143, label %L45, label %L46
L45:
  br label %L47
L46:
  %t144 = load ptr, ptr %t94
  %t145 = call i32 @type_is_fp(ptr %t144)
  %t146 = sext i32 %t145 to i64
  %t147 = icmp ne i64 %t146, 0
  %t148 = zext i1 %t147 to i64
  br label %L47
L47:
  %t149 = phi i64 [ 1, %L45 ], [ %t148, %L46 ]
  %t150 = icmp ne i64 %t149, 0
  br i1 %t150, label %L48, label %L49
L48:
  %t151 = load ptr, ptr %t94
  %t152 = icmp ne ptr %t151, null
  br i1 %t152, label %L51, label %L52
L51:
  %t153 = load ptr, ptr %t94
  %t154 = call ptr @llvm_type(ptr %t153)
  %t155 = ptrtoint ptr %t154 to i64
  br label %L53
L52:
  %t156 = getelementptr [4 x i8], ptr @.str330, i64 0, i64 0
  %t157 = ptrtoint ptr %t156 to i64
  br label %L53
L53:
  %t158 = phi i64 [ %t155, %L51 ], [ %t157, %L52 ]
  store i64 %t158, ptr %t138
  br label %L50
L49:
  %t159 = load ptr, ptr %t94
  %t160 = load ptr, ptr %t159
  %t162 = ptrtoint ptr %t160 to i64
  %t163 = sext i32 15 to i64
  %t161 = icmp eq i64 %t162, %t163
  %t164 = zext i1 %t161 to i64
  %t165 = icmp ne i64 %t164, 0
  br i1 %t165, label %L54, label %L55
L54:
  br label %L56
L55:
  %t166 = load ptr, ptr %t94
  %t167 = load ptr, ptr %t166
  %t169 = ptrtoint ptr %t167 to i64
  %t170 = sext i32 16 to i64
  %t168 = icmp eq i64 %t169, %t170
  %t171 = zext i1 %t168 to i64
  %t172 = icmp ne i64 %t171, 0
  %t173 = zext i1 %t172 to i64
  br label %L56
L56:
  %t174 = phi i64 [ 1, %L54 ], [ %t173, %L55 ]
  %t175 = icmp ne i64 %t174, 0
  br i1 %t175, label %L57, label %L58
L57:
  %t176 = getelementptr [4 x i8], ptr @.str331, i64 0, i64 0
  store ptr %t176, ptr %t138
  br label %L59
L58:
  %t177 = load ptr, ptr %t94
  %t178 = load ptr, ptr %t177
  %t180 = ptrtoint ptr %t178 to i64
  %t181 = sext i32 18 to i64
  %t179 = icmp eq i64 %t180, %t181
  %t182 = zext i1 %t179 to i64
  %t183 = icmp ne i64 %t182, 0
  br i1 %t183, label %L60, label %L61
L60:
  br label %L62
L61:
  %t184 = load ptr, ptr %t94
  %t185 = load ptr, ptr %t184
  %t187 = ptrtoint ptr %t185 to i64
  %t188 = sext i32 19 to i64
  %t186 = icmp eq i64 %t187, %t188
  %t189 = zext i1 %t186 to i64
  %t190 = icmp ne i64 %t189, 0
  %t191 = zext i1 %t190 to i64
  br label %L62
L62:
  %t192 = phi i64 [ 1, %L60 ], [ %t191, %L61 ]
  %t193 = icmp ne i64 %t192, 0
  br i1 %t193, label %L63, label %L64
L63:
  br label %L65
L64:
  %t194 = load ptr, ptr %t94
  %t195 = load ptr, ptr %t194
  %t197 = ptrtoint ptr %t195 to i64
  %t198 = sext i32 21 to i64
  %t196 = icmp eq i64 %t197, %t198
  %t199 = zext i1 %t196 to i64
  %t200 = icmp ne i64 %t199, 0
  %t201 = zext i1 %t200 to i64
  br label %L65
L65:
  %t202 = phi i64 [ 1, %L63 ], [ %t201, %L64 ]
  %t203 = icmp ne i64 %t202, 0
  br i1 %t203, label %L66, label %L67
L66:
  %t204 = getelementptr [4 x i8], ptr @.str332, i64 0, i64 0
  store ptr %t204, ptr %t138
  br label %L68
L67:
  %t205 = getelementptr [4 x i8], ptr @.str333, i64 0, i64 0
  store ptr %t205, ptr %t138
  br label %L68
L68:
  br label %L59
L59:
  br label %L50
L50:
  %t206 = load i64, ptr %t75
  %t207 = load ptr, ptr %t73
  %t208 = load i64, ptr %t75
  %t210 = ptrtoint ptr %t207 to i64
  %t211 = inttoptr i64 %t210 to ptr
  %t209 = getelementptr i8, ptr %t211, i64 %t208
  %t212 = load i64, ptr %t75
  %t214 = sext i32 512 to i64
  %t213 = sub i64 %t214, %t212
  %t215 = getelementptr [3 x i8], ptr @.str334, i64 0, i64 0
  %t216 = load ptr, ptr %t138
  %t217 = call i32 @snprintf(ptr %t209, i64 %t213, ptr %t215, ptr %t216)
  %t218 = sext i32 %t217 to i64
  %t219 = add i64 %t206, %t218
  store i64 %t219, ptr %t75
  br label %L27
L27:
  %t220 = load i64, ptr %t77
  %t221 = add i64 %t220, 1
  store i64 %t221, ptr %t77
  br label %L25
L28:
  %t222 = load ptr, ptr %t7
  %t223 = load ptr, ptr %t222
  %t224 = icmp ne ptr %t223, null
  br i1 %t224, label %L69, label %L71
L69:
  %t225 = load ptr, ptr %t7
  %t226 = load ptr, ptr %t225
  %t227 = icmp ne ptr %t226, null
  br i1 %t227, label %L72, label %L74
L72:
  %t228 = load i64, ptr %t75
  %t229 = load ptr, ptr %t73
  %t230 = load i64, ptr %t75
  %t232 = ptrtoint ptr %t229 to i64
  %t233 = inttoptr i64 %t232 to ptr
  %t231 = getelementptr i8, ptr %t233, i64 %t230
  %t234 = load i64, ptr %t75
  %t236 = sext i32 512 to i64
  %t235 = sub i64 %t236, %t234
  %t237 = getelementptr [3 x i8], ptr @.str335, i64 0, i64 0
  %t238 = call i32 @snprintf(ptr %t231, i64 %t235, ptr %t237)
  %t239 = sext i32 %t238 to i64
  %t240 = add i64 %t228, %t239
  store i64 %t240, ptr %t75
  br label %L74
L74:
  %t241 = load i64, ptr %t75
  %t242 = load ptr, ptr %t73
  %t243 = load i64, ptr %t75
  %t245 = ptrtoint ptr %t242 to i64
  %t246 = inttoptr i64 %t245 to ptr
  %t244 = getelementptr i8, ptr %t246, i64 %t243
  %t247 = load i64, ptr %t75
  %t249 = sext i32 512 to i64
  %t248 = sub i64 %t249, %t247
  %t250 = getelementptr [4 x i8], ptr @.str336, i64 0, i64 0
  %t251 = call i32 @snprintf(ptr %t244, i64 %t248, ptr %t250)
  %t252 = sext i32 %t251 to i64
  %t253 = add i64 %t241, %t252
  store i64 %t253, ptr %t75
  br label %L71
L71:
  %t254 = load ptr, ptr %t0
  %t255 = getelementptr [20 x i8], ptr @.str337, i64 0, i64 0
  %t256 = load ptr, ptr %t7
  %t257 = call ptr @llvm_ret_type(ptr %t256)
  %t258 = load ptr, ptr %t1
  %t259 = load ptr, ptr %t73
  call void @__c0c_emit(ptr %t254, ptr %t255, ptr %t257, ptr %t258, ptr %t259)
  ret void
L75:
  br label %L9
L9:
  %t261 = alloca i64
  %t262 = sext i32 0 to i64
  store i64 %t262, ptr %t261
  %t263 = alloca i64
  %t264 = sext i32 0 to i64
  store i64 %t264, ptr %t263
  br label %L76
L76:
  %t265 = load i64, ptr %t263
  %t266 = load ptr, ptr %t0
  %t268 = ptrtoint ptr %t266 to i64
  %t267 = icmp slt i64 %t265, %t268
  %t269 = zext i1 %t267 to i64
  %t270 = icmp ne i64 %t269, 0
  br i1 %t270, label %L77, label %L79
L77:
  %t271 = load ptr, ptr %t0
  %t272 = load i64, ptr %t263
  %t273 = getelementptr ptr, ptr %t271, i64 %t272
  %t274 = load ptr, ptr %t273
  %t275 = load ptr, ptr %t1
  %t276 = call i32 @strcmp(ptr %t274, ptr %t275)
  %t277 = sext i32 %t276 to i64
  %t279 = sext i32 0 to i64
  %t278 = icmp eq i64 %t277, %t279
  %t280 = zext i1 %t278 to i64
  %t281 = icmp ne i64 %t280, 0
  br i1 %t281, label %L80, label %L82
L80:
  %t282 = sext i32 1 to i64
  store i64 %t282, ptr %t261
  br label %L79
L83:
  br label %L82
L82:
  br label %L78
L78:
  %t283 = load i64, ptr %t263
  %t284 = add i64 %t283, 1
  store i64 %t284, ptr %t263
  br label %L76
L79:
  %t285 = load i64, ptr %t261
  %t287 = icmp eq i64 %t285, 0
  %t286 = zext i1 %t287 to i64
  %t288 = icmp ne i64 %t286, 0
  br i1 %t288, label %L84, label %L85
L84:
  %t289 = load ptr, ptr %t0
  %t291 = ptrtoint ptr %t289 to i64
  %t292 = sext i32 2048 to i64
  %t290 = icmp slt i64 %t291, %t292
  %t293 = zext i1 %t290 to i64
  %t294 = icmp ne i64 %t293, 0
  %t295 = zext i1 %t294 to i64
  br label %L86
L85:
  br label %L86
L86:
  %t296 = phi i64 [ %t295, %L84 ], [ 0, %L85 ]
  %t297 = icmp ne i64 %t296, 0
  br i1 %t297, label %L87, label %L89
L87:
  %t298 = load ptr, ptr %t1
  %t299 = call ptr @strdup(ptr %t298)
  %t300 = load ptr, ptr %t0
  %t301 = load ptr, ptr %t0
  %t303 = ptrtoint ptr %t301 to i64
  %t302 = getelementptr ptr, ptr %t300, i64 %t303
  store ptr %t299, ptr %t302
  %t304 = load ptr, ptr %t7
  %t305 = load ptr, ptr %t0
  %t306 = load ptr, ptr %t0
  %t308 = ptrtoint ptr %t306 to i64
  %t307 = getelementptr ptr, ptr %t305, i64 %t308
  store ptr %t304, ptr %t307
  %t309 = load ptr, ptr %t1
  %t310 = load ptr, ptr %t0
  %t311 = load ptr, ptr %t0
  %t313 = ptrtoint ptr %t311 to i64
  %t312 = getelementptr ptr, ptr %t310, i64 %t313
  store ptr %t309, ptr %t312
  %t314 = load ptr, ptr %t0
  %t316 = ptrtoint ptr %t314 to i64
  %t315 = add i64 %t316, 1
  store i64 %t315, ptr %t0
  br label %L89
L89:
  %t317 = load ptr, ptr %t1
  %t318 = icmp ne ptr %t317, null
  br i1 %t318, label %L90, label %L92
L90:
  %t319 = load ptr, ptr %t0
  %t320 = getelementptr [26 x i8], ptr @.str338, i64 0, i64 0
  %t321 = load ptr, ptr %t1
  %t322 = load ptr, ptr %t7
  %t323 = call ptr @llvm_type(ptr %t322)
  call void @__c0c_emit(ptr %t319, ptr %t320, ptr %t321, ptr %t323)
  ret void
L93:
  br label %L92
L92:
  %t325 = alloca ptr
  %t326 = load ptr, ptr %t1
  %t327 = icmp ne ptr %t326, null
  br i1 %t327, label %L94, label %L95
L94:
  %t328 = getelementptr [9 x i8], ptr @.str339, i64 0, i64 0
  %t329 = ptrtoint ptr %t328 to i64
  br label %L96
L95:
  %t330 = getelementptr [10 x i8], ptr @.str340, i64 0, i64 0
  %t331 = ptrtoint ptr %t330 to i64
  br label %L96
L96:
  %t332 = phi i64 [ %t329, %L94 ], [ %t331, %L95 ]
  store i64 %t332, ptr %t325
  %t333 = alloca ptr
  %t334 = load ptr, ptr %t7
  %t335 = call ptr @llvm_type(ptr %t334)
  store ptr %t335, ptr %t333
  %t336 = load ptr, ptr %t0
  %t337 = getelementptr [36 x i8], ptr @.str341, i64 0, i64 0
  %t338 = load ptr, ptr %t1
  %t339 = load ptr, ptr %t325
  %t340 = load ptr, ptr %t333
  call void @__c0c_emit(ptr %t336, ptr %t337, ptr %t338, ptr %t339, ptr %t340)
  ret void
}

define dso_local ptr @codegen_new(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca ptr
  %t3 = call ptr @calloc(i64 1, i64 0)
  store ptr %t3, ptr %t2
  %t4 = load ptr, ptr %t2
  %t6 = ptrtoint ptr %t4 to i64
  %t7 = icmp eq i64 %t6, 0
  %t5 = zext i1 %t7 to i64
  %t8 = icmp ne i64 %t5, 0
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = getelementptr [7 x i8], ptr @.str342, i64 0, i64 0
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
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
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
  %t26 = getelementptr ptr, ptr %t24, i64 %t25
  %t27 = load ptr, ptr %t26
  call void @free(ptr %t27)
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
  %t7 = getelementptr [19 x i8], ptr @.str343, i64 0, i64 0
  %t8 = load ptr, ptr %t0
  call void @__c0c_emit(ptr %t6, ptr %t7, ptr %t8)
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr [24 x i8], ptr @.str344, i64 0, i64 0
  %t12 = load ptr, ptr %t0
  call void @__c0c_emit(ptr %t10, ptr %t11, ptr %t12)
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr [94 x i8], ptr @.str345, i64 0, i64 0
  call void @__c0c_emit(ptr %t14, ptr %t15)
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr [45 x i8], ptr @.str346, i64 0, i64 0
  call void @__c0c_emit(ptr %t17, ptr %t18)
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr [23 x i8], ptr @.str347, i64 0, i64 0
  call void @__c0c_emit(ptr %t20, ptr %t21)
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr [26 x i8], ptr @.str348, i64 0, i64 0
  call void @__c0c_emit(ptr %t23, ptr %t24)
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr [31 x i8], ptr @.str349, i64 0, i64 0
  call void @__c0c_emit(ptr %t26, ptr %t27)
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr [32 x i8], ptr @.str350, i64 0, i64 0
  call void @__c0c_emit(ptr %t29, ptr %t30)
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr [25 x i8], ptr @.str351, i64 0, i64 0
  call void @__c0c_emit(ptr %t32, ptr %t33)
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr [26 x i8], ptr @.str352, i64 0, i64 0
  call void @__c0c_emit(ptr %t35, ptr %t36)
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr [26 x i8], ptr @.str353, i64 0, i64 0
  call void @__c0c_emit(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr [32 x i8], ptr @.str354, i64 0, i64 0
  call void @__c0c_emit(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr [31 x i8], ptr @.str355, i64 0, i64 0
  call void @__c0c_emit(ptr %t44, ptr %t45)
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr [37 x i8], ptr @.str356, i64 0, i64 0
  call void @__c0c_emit(ptr %t47, ptr %t48)
  %t50 = load ptr, ptr %t0
  %t51 = getelementptr [31 x i8], ptr @.str357, i64 0, i64 0
  call void @__c0c_emit(ptr %t50, ptr %t51)
  %t53 = load ptr, ptr %t0
  %t54 = getelementptr [31 x i8], ptr @.str358, i64 0, i64 0
  call void @__c0c_emit(ptr %t53, ptr %t54)
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr [31 x i8], ptr @.str359, i64 0, i64 0
  call void @__c0c_emit(ptr %t56, ptr %t57)
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr [31 x i8], ptr @.str360, i64 0, i64 0
  call void @__c0c_emit(ptr %t59, ptr %t60)
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr [37 x i8], ptr @.str361, i64 0, i64 0
  call void @__c0c_emit(ptr %t62, ptr %t63)
  %t65 = load ptr, ptr %t0
  %t66 = getelementptr [36 x i8], ptr @.str362, i64 0, i64 0
  call void @__c0c_emit(ptr %t65, ptr %t66)
  %t68 = load ptr, ptr %t0
  %t69 = getelementptr [36 x i8], ptr @.str363, i64 0, i64 0
  call void @__c0c_emit(ptr %t68, ptr %t69)
  %t71 = load ptr, ptr %t0
  %t72 = getelementptr [36 x i8], ptr @.str364, i64 0, i64 0
  call void @__c0c_emit(ptr %t71, ptr %t72)
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr [31 x i8], ptr @.str365, i64 0, i64 0
  call void @__c0c_emit(ptr %t74, ptr %t75)
  %t77 = load ptr, ptr %t0
  %t78 = getelementptr [37 x i8], ptr @.str366, i64 0, i64 0
  call void @__c0c_emit(ptr %t77, ptr %t78)
  %t80 = load ptr, ptr %t0
  %t81 = getelementptr [37 x i8], ptr @.str367, i64 0, i64 0
  call void @__c0c_emit(ptr %t80, ptr %t81)
  %t83 = load ptr, ptr %t0
  %t84 = getelementptr [43 x i8], ptr @.str368, i64 0, i64 0
  call void @__c0c_emit(ptr %t83, ptr %t84)
  %t86 = load ptr, ptr %t0
  %t87 = getelementptr [38 x i8], ptr @.str369, i64 0, i64 0
  call void @__c0c_emit(ptr %t86, ptr %t87)
  %t89 = load ptr, ptr %t0
  %t90 = getelementptr [44 x i8], ptr @.str370, i64 0, i64 0
  call void @__c0c_emit(ptr %t89, ptr %t90)
  %t92 = load ptr, ptr %t0
  %t93 = getelementptr [30 x i8], ptr @.str371, i64 0, i64 0
  call void @__c0c_emit(ptr %t92, ptr %t93)
  %t95 = load ptr, ptr %t0
  %t96 = getelementptr [26 x i8], ptr @.str372, i64 0, i64 0
  call void @__c0c_emit(ptr %t95, ptr %t96)
  %t98 = load ptr, ptr %t0
  %t99 = getelementptr [40 x i8], ptr @.str373, i64 0, i64 0
  call void @__c0c_emit(ptr %t98, ptr %t99)
  %t101 = load ptr, ptr %t0
  %t102 = getelementptr [41 x i8], ptr @.str374, i64 0, i64 0
  call void @__c0c_emit(ptr %t101, ptr %t102)
  %t104 = load ptr, ptr %t0
  %t105 = getelementptr [35 x i8], ptr @.str375, i64 0, i64 0
  call void @__c0c_emit(ptr %t104, ptr %t105)
  %t107 = load ptr, ptr %t0
  %t108 = getelementptr [25 x i8], ptr @.str376, i64 0, i64 0
  call void @__c0c_emit(ptr %t107, ptr %t108)
  %t110 = load ptr, ptr %t0
  %t111 = getelementptr [27 x i8], ptr @.str377, i64 0, i64 0
  call void @__c0c_emit(ptr %t110, ptr %t111)
  %t113 = load ptr, ptr %t0
  %t114 = getelementptr [25 x i8], ptr @.str378, i64 0, i64 0
  call void @__c0c_emit(ptr %t113, ptr %t114)
  %t116 = load ptr, ptr %t0
  %t117 = getelementptr [26 x i8], ptr @.str379, i64 0, i64 0
  call void @__c0c_emit(ptr %t116, ptr %t117)
  %t119 = load ptr, ptr %t0
  %t120 = getelementptr [24 x i8], ptr @.str380, i64 0, i64 0
  call void @__c0c_emit(ptr %t119, ptr %t120)
  %t122 = load ptr, ptr %t0
  %t123 = getelementptr [24 x i8], ptr @.str381, i64 0, i64 0
  call void @__c0c_emit(ptr %t122, ptr %t123)
  %t125 = load ptr, ptr %t0
  %t126 = getelementptr [36 x i8], ptr @.str382, i64 0, i64 0
  call void @__c0c_emit(ptr %t125, ptr %t126)
  %t128 = load ptr, ptr %t0
  %t129 = getelementptr [37 x i8], ptr @.str383, i64 0, i64 0
  call void @__c0c_emit(ptr %t128, ptr %t129)
  %t131 = load ptr, ptr %t0
  %t132 = getelementptr [27 x i8], ptr @.str384, i64 0, i64 0
  call void @__c0c_emit(ptr %t131, ptr %t132)
  %t134 = load ptr, ptr %t0
  %t135 = getelementptr [27 x i8], ptr @.str385, i64 0, i64 0
  call void @__c0c_emit(ptr %t134, ptr %t135)
  %t137 = load ptr, ptr %t0
  %t138 = getelementptr [27 x i8], ptr @.str386, i64 0, i64 0
  call void @__c0c_emit(ptr %t137, ptr %t138)
  %t140 = load ptr, ptr %t0
  %t141 = getelementptr [27 x i8], ptr @.str387, i64 0, i64 0
  call void @__c0c_emit(ptr %t140, ptr %t141)
  %t143 = load ptr, ptr %t0
  %t144 = getelementptr [27 x i8], ptr @.str388, i64 0, i64 0
  call void @__c0c_emit(ptr %t143, ptr %t144)
  %t146 = load ptr, ptr %t0
  %t147 = getelementptr [28 x i8], ptr @.str389, i64 0, i64 0
  call void @__c0c_emit(ptr %t146, ptr %t147)
  %t149 = load ptr, ptr %t0
  %t150 = getelementptr [27 x i8], ptr @.str390, i64 0, i64 0
  call void @__c0c_emit(ptr %t149, ptr %t150)
  %t152 = load ptr, ptr %t0
  %t153 = getelementptr [27 x i8], ptr @.str391, i64 0, i64 0
  call void @__c0c_emit(ptr %t152, ptr %t153)
  %t155 = load ptr, ptr %t0
  %t156 = getelementptr [27 x i8], ptr @.str392, i64 0, i64 0
  call void @__c0c_emit(ptr %t155, ptr %t156)
  %t158 = load ptr, ptr %t0
  %t159 = getelementptr [27 x i8], ptr @.str393, i64 0, i64 0
  call void @__c0c_emit(ptr %t158, ptr %t159)
  %t161 = load ptr, ptr %t0
  %t162 = getelementptr [26 x i8], ptr @.str394, i64 0, i64 0
  call void @__c0c_emit(ptr %t161, ptr %t162)
  %t164 = load ptr, ptr %t0
  %t165 = getelementptr [29 x i8], ptr @.str395, i64 0, i64 0
  call void @__c0c_emit(ptr %t164, ptr %t165)
  %t167 = load ptr, ptr %t0
  %t168 = getelementptr [29 x i8], ptr @.str396, i64 0, i64 0
  call void @__c0c_emit(ptr %t167, ptr %t168)
  %t170 = load ptr, ptr %t0
  %t171 = getelementptr [28 x i8], ptr @.str397, i64 0, i64 0
  call void @__c0c_emit(ptr %t170, ptr %t171)
  %t173 = load ptr, ptr %t0
  %t174 = getelementptr [34 x i8], ptr @.str398, i64 0, i64 0
  call void @__c0c_emit(ptr %t173, ptr %t174)
  %t176 = load ptr, ptr %t0
  %t177 = getelementptr [41 x i8], ptr @.str399, i64 0, i64 0
  call void @__c0c_emit(ptr %t176, ptr %t177)
  %t179 = load ptr, ptr %t0
  %t180 = getelementptr [2 x i8], ptr @.str400, i64 0, i64 0
  call void @__c0c_emit(ptr %t179, ptr %t180)
  %t182 = alloca ptr
  %t183 = sext i32 0 to i64
  store i64 %t183, ptr %t182
  %t184 = alloca i64
  %t185 = sext i32 0 to i64
  store i64 %t185, ptr %t184
  br label %L4
L4:
  %t186 = load ptr, ptr %t182
  %t187 = load i64, ptr %t184
  %t188 = getelementptr ptr, ptr %t186, i64 %t187
  %t189 = load ptr, ptr %t188
  %t190 = icmp ne ptr %t189, null
  br i1 %t190, label %L5, label %L7
L5:
  %t191 = alloca i64
  %t192 = sext i32 0 to i64
  store i64 %t192, ptr %t191
  %t193 = alloca i64
  %t194 = sext i32 0 to i64
  store i64 %t194, ptr %t193
  br label %L8
L8:
  %t195 = load i64, ptr %t193
  %t196 = load ptr, ptr %t0
  %t198 = ptrtoint ptr %t196 to i64
  %t197 = icmp slt i64 %t195, %t198
  %t199 = zext i1 %t197 to i64
  %t200 = icmp ne i64 %t199, 0
  br i1 %t200, label %L9, label %L11
L9:
  %t201 = load ptr, ptr %t0
  %t202 = load i64, ptr %t193
  %t203 = getelementptr ptr, ptr %t201, i64 %t202
  %t204 = load ptr, ptr %t203
  %t205 = load ptr, ptr %t182
  %t206 = load i64, ptr %t184
  %t207 = getelementptr ptr, ptr %t205, i64 %t206
  %t208 = load ptr, ptr %t207
  %t209 = call i32 @strcmp(ptr %t204, ptr %t208)
  %t210 = sext i32 %t209 to i64
  %t212 = sext i32 0 to i64
  %t211 = icmp eq i64 %t210, %t212
  %t213 = zext i1 %t211 to i64
  %t214 = icmp ne i64 %t213, 0
  br i1 %t214, label %L12, label %L14
L12:
  %t215 = sext i32 1 to i64
  store i64 %t215, ptr %t191
  br label %L11
L15:
  br label %L14
L14:
  br label %L10
L10:
  %t216 = load i64, ptr %t193
  %t217 = add i64 %t216, 1
  store i64 %t217, ptr %t193
  br label %L8
L11:
  %t218 = load i64, ptr %t191
  %t220 = icmp eq i64 %t218, 0
  %t219 = zext i1 %t220 to i64
  %t221 = icmp ne i64 %t219, 0
  br i1 %t221, label %L16, label %L17
L16:
  %t222 = load ptr, ptr %t0
  %t224 = ptrtoint ptr %t222 to i64
  %t225 = sext i32 2048 to i64
  %t223 = icmp slt i64 %t224, %t225
  %t226 = zext i1 %t223 to i64
  %t227 = icmp ne i64 %t226, 0
  %t228 = zext i1 %t227 to i64
  br label %L18
L17:
  br label %L18
L18:
  %t229 = phi i64 [ %t228, %L16 ], [ 0, %L17 ]
  %t230 = icmp ne i64 %t229, 0
  br i1 %t230, label %L19, label %L21
L19:
  %t231 = load ptr, ptr %t182
  %t232 = load i64, ptr %t184
  %t233 = getelementptr ptr, ptr %t231, i64 %t232
  %t234 = load ptr, ptr %t233
  %t235 = call ptr @strdup(ptr %t234)
  %t236 = load ptr, ptr %t0
  %t237 = load ptr, ptr %t0
  %t239 = ptrtoint ptr %t237 to i64
  %t238 = getelementptr ptr, ptr %t236, i64 %t239
  store ptr %t235, ptr %t238
  %t241 = sext i32 0 to i64
  %t240 = inttoptr i64 %t241 to ptr
  %t242 = load ptr, ptr %t0
  %t243 = load ptr, ptr %t0
  %t245 = ptrtoint ptr %t243 to i64
  %t244 = getelementptr ptr, ptr %t242, i64 %t245
  store ptr %t240, ptr %t244
  %t246 = load ptr, ptr %t0
  %t247 = load ptr, ptr %t0
  %t249 = ptrtoint ptr %t247 to i64
  %t248 = getelementptr ptr, ptr %t246, i64 %t249
  %t250 = sext i32 1 to i64
  store i64 %t250, ptr %t248
  %t251 = load ptr, ptr %t0
  %t253 = ptrtoint ptr %t251 to i64
  %t252 = add i64 %t253, 1
  store i64 %t252, ptr %t0
  br label %L21
L21:
  br label %L6
L6:
  %t254 = load i64, ptr %t184
  %t255 = add i64 %t254, 1
  store i64 %t255, ptr %t184
  br label %L4
L7:
  %t256 = alloca i64
  %t257 = sext i32 0 to i64
  store i64 %t257, ptr %t256
  br label %L22
L22:
  %t258 = load i64, ptr %t256
  %t259 = load ptr, ptr %t1
  %t261 = ptrtoint ptr %t259 to i64
  %t260 = icmp slt i64 %t258, %t261
  %t262 = zext i1 %t260 to i64
  %t263 = icmp ne i64 %t262, 0
  br i1 %t263, label %L23, label %L25
L23:
  %t264 = alloca ptr
  %t265 = load ptr, ptr %t1
  %t266 = load i64, ptr %t256
  %t267 = getelementptr ptr, ptr %t265, i64 %t266
  %t268 = load ptr, ptr %t267
  store ptr %t268, ptr %t264
  %t269 = load ptr, ptr %t264
  %t271 = ptrtoint ptr %t269 to i64
  %t272 = icmp eq i64 %t271, 0
  %t270 = zext i1 %t272 to i64
  %t273 = icmp ne i64 %t270, 0
  br i1 %t273, label %L26, label %L28
L26:
  br label %L24
L29:
  br label %L28
L28:
  %t274 = load ptr, ptr %t264
  %t275 = load ptr, ptr %t274
  %t277 = ptrtoint ptr %t275 to i64
  %t278 = sext i32 1 to i64
  %t276 = icmp eq i64 %t277, %t278
  %t279 = zext i1 %t276 to i64
  %t280 = icmp ne i64 %t279, 0
  br i1 %t280, label %L30, label %L32
L30:
  %t281 = alloca i64
  %t282 = sext i32 0 to i64
  store i64 %t282, ptr %t281
  %t283 = alloca i64
  %t284 = sext i32 0 to i64
  store i64 %t284, ptr %t283
  br label %L33
L33:
  %t285 = load i64, ptr %t283
  %t286 = load ptr, ptr %t0
  %t288 = ptrtoint ptr %t286 to i64
  %t287 = icmp slt i64 %t285, %t288
  %t289 = zext i1 %t287 to i64
  %t290 = icmp ne i64 %t289, 0
  br i1 %t290, label %L34, label %L36
L34:
  %t291 = load ptr, ptr %t0
  %t292 = load i64, ptr %t283
  %t293 = getelementptr ptr, ptr %t291, i64 %t292
  %t294 = load ptr, ptr %t293
  %t295 = load ptr, ptr %t264
  %t296 = load ptr, ptr %t295
  %t297 = icmp ne ptr %t296, null
  br i1 %t297, label %L37, label %L38
L37:
  %t298 = load ptr, ptr %t264
  %t299 = load ptr, ptr %t298
  %t300 = ptrtoint ptr %t299 to i64
  br label %L39
L38:
  %t301 = getelementptr [1 x i8], ptr @.str401, i64 0, i64 0
  %t302 = ptrtoint ptr %t301 to i64
  br label %L39
L39:
  %t303 = phi i64 [ %t300, %L37 ], [ %t302, %L38 ]
  %t304 = call i32 @strcmp(ptr %t294, i64 %t303)
  %t305 = sext i32 %t304 to i64
  %t307 = sext i32 0 to i64
  %t306 = icmp eq i64 %t305, %t307
  %t308 = zext i1 %t306 to i64
  %t309 = icmp ne i64 %t308, 0
  br i1 %t309, label %L40, label %L42
L40:
  %t310 = sext i32 1 to i64
  store i64 %t310, ptr %t281
  br label %L36
L43:
  br label %L42
L42:
  br label %L35
L35:
  %t311 = load i64, ptr %t283
  %t312 = add i64 %t311, 1
  store i64 %t312, ptr %t283
  br label %L33
L36:
  %t313 = load i64, ptr %t281
  %t315 = icmp eq i64 %t313, 0
  %t314 = zext i1 %t315 to i64
  %t316 = icmp ne i64 %t314, 0
  br i1 %t316, label %L44, label %L45
L44:
  %t317 = load ptr, ptr %t0
  %t319 = ptrtoint ptr %t317 to i64
  %t320 = sext i32 2048 to i64
  %t318 = icmp slt i64 %t319, %t320
  %t321 = zext i1 %t318 to i64
  %t322 = icmp ne i64 %t321, 0
  %t323 = zext i1 %t322 to i64
  br label %L46
L45:
  br label %L46
L46:
  %t324 = phi i64 [ %t323, %L44 ], [ 0, %L45 ]
  %t325 = icmp ne i64 %t324, 0
  br i1 %t325, label %L47, label %L49
L47:
  %t326 = load ptr, ptr %t264
  %t327 = load ptr, ptr %t326
  %t328 = icmp ne ptr %t327, null
  br i1 %t328, label %L50, label %L51
L50:
  %t329 = load ptr, ptr %t264
  %t330 = load ptr, ptr %t329
  %t331 = ptrtoint ptr %t330 to i64
  br label %L52
L51:
  %t332 = getelementptr [7 x i8], ptr @.str402, i64 0, i64 0
  %t333 = ptrtoint ptr %t332 to i64
  br label %L52
L52:
  %t334 = phi i64 [ %t331, %L50 ], [ %t333, %L51 ]
  %t335 = call ptr @strdup(i64 %t334)
  %t336 = load ptr, ptr %t0
  %t337 = load ptr, ptr %t0
  %t339 = ptrtoint ptr %t337 to i64
  %t338 = getelementptr ptr, ptr %t336, i64 %t339
  store ptr %t335, ptr %t338
  %t340 = load ptr, ptr %t264
  %t341 = load ptr, ptr %t340
  %t342 = load ptr, ptr %t0
  %t343 = load ptr, ptr %t0
  %t345 = ptrtoint ptr %t343 to i64
  %t344 = getelementptr ptr, ptr %t342, i64 %t345
  store ptr %t341, ptr %t344
  %t346 = load ptr, ptr %t0
  %t347 = load ptr, ptr %t0
  %t349 = ptrtoint ptr %t347 to i64
  %t348 = getelementptr ptr, ptr %t346, i64 %t349
  %t350 = sext i32 0 to i64
  store i64 %t350, ptr %t348
  %t351 = load ptr, ptr %t0
  %t353 = ptrtoint ptr %t351 to i64
  %t352 = add i64 %t353, 1
  store i64 %t352, ptr %t0
  br label %L49
L49:
  br label %L32
L32:
  br label %L24
L24:
  %t354 = load i64, ptr %t256
  %t355 = add i64 %t354, 1
  store i64 %t355, ptr %t256
  br label %L22
L25:
  %t356 = alloca i64
  %t357 = sext i32 0 to i64
  store i64 %t357, ptr %t356
  br label %L53
L53:
  %t358 = load i64, ptr %t356
  %t359 = load ptr, ptr %t1
  %t361 = ptrtoint ptr %t359 to i64
  %t360 = icmp slt i64 %t358, %t361
  %t362 = zext i1 %t360 to i64
  %t363 = icmp ne i64 %t362, 0
  br i1 %t363, label %L54, label %L56
L54:
  %t364 = alloca ptr
  %t365 = load ptr, ptr %t1
  %t366 = load i64, ptr %t356
  %t367 = getelementptr ptr, ptr %t365, i64 %t366
  %t368 = load ptr, ptr %t367
  store ptr %t368, ptr %t364
  %t369 = load ptr, ptr %t364
  %t371 = ptrtoint ptr %t369 to i64
  %t372 = icmp eq i64 %t371, 0
  %t370 = zext i1 %t372 to i64
  %t373 = icmp ne i64 %t370, 0
  br i1 %t373, label %L57, label %L59
L57:
  br label %L55
L60:
  br label %L59
L59:
  %t374 = load ptr, ptr %t364
  %t375 = load ptr, ptr %t374
  %t377 = ptrtoint ptr %t375 to i64
  %t378 = sext i32 2 to i64
  %t376 = icmp eq i64 %t377, %t378
  %t379 = zext i1 %t376 to i64
  %t380 = icmp ne i64 %t379, 0
  br i1 %t380, label %L61, label %L63
L61:
  %t381 = load ptr, ptr %t364
  call void @emit_global_var(ptr %t0, ptr %t381)
  br label %L63
L63:
  br label %L55
L55:
  %t383 = load i64, ptr %t356
  %t384 = add i64 %t383, 1
  store i64 %t384, ptr %t356
  br label %L53
L56:
  %t385 = load ptr, ptr %t0
  %t386 = getelementptr [2 x i8], ptr @.str403, i64 0, i64 0
  call void @__c0c_emit(ptr %t385, ptr %t386)
  %t388 = alloca i64
  %t389 = sext i32 0 to i64
  store i64 %t389, ptr %t388
  br label %L64
L64:
  %t390 = load i64, ptr %t388
  %t391 = load ptr, ptr %t1
  %t393 = ptrtoint ptr %t391 to i64
  %t392 = icmp slt i64 %t390, %t393
  %t394 = zext i1 %t392 to i64
  %t395 = icmp ne i64 %t394, 0
  br i1 %t395, label %L65, label %L67
L65:
  %t396 = alloca ptr
  %t397 = load ptr, ptr %t1
  %t398 = load i64, ptr %t388
  %t399 = getelementptr ptr, ptr %t397, i64 %t398
  %t400 = load ptr, ptr %t399
  store ptr %t400, ptr %t396
  %t401 = load ptr, ptr %t396
  %t403 = ptrtoint ptr %t401 to i64
  %t404 = icmp eq i64 %t403, 0
  %t402 = zext i1 %t404 to i64
  %t405 = icmp ne i64 %t402, 0
  br i1 %t405, label %L68, label %L70
L68:
  br label %L66
L71:
  br label %L70
L70:
  %t406 = load ptr, ptr %t396
  %t407 = load ptr, ptr %t406
  %t409 = ptrtoint ptr %t407 to i64
  %t410 = sext i32 1 to i64
  %t408 = icmp eq i64 %t409, %t410
  %t411 = zext i1 %t408 to i64
  %t412 = icmp ne i64 %t411, 0
  br i1 %t412, label %L72, label %L74
L72:
  %t413 = load ptr, ptr %t396
  call void @emit_func_def(ptr %t0, ptr %t413)
  br label %L74
L74:
  br label %L66
L66:
  %t415 = load i64, ptr %t388
  %t416 = add i64 %t415, 1
  store i64 %t416, ptr %t388
  br label %L64
L67:
  %t417 = alloca i64
  %t418 = sext i32 0 to i64
  store i64 %t418, ptr %t417
  br label %L75
L75:
  %t419 = load i64, ptr %t417
  %t420 = load ptr, ptr %t0
  %t422 = ptrtoint ptr %t420 to i64
  %t421 = icmp slt i64 %t419, %t422
  %t423 = zext i1 %t421 to i64
  %t424 = icmp ne i64 %t423, 0
  br i1 %t424, label %L76, label %L78
L76:
  %t425 = alloca i64
  %t426 = load ptr, ptr %t0
  %t427 = load i64, ptr %t417
  %t428 = getelementptr ptr, ptr %t426, i64 %t427
  %t429 = load ptr, ptr %t428
  %t430 = call i32 @str_literal_len(ptr %t429)
  %t431 = sext i32 %t430 to i64
  store i64 %t431, ptr %t425
  %t432 = load ptr, ptr %t0
  %t433 = getelementptr [53 x i8], ptr @.str404, i64 0, i64 0
  %t434 = load ptr, ptr %t0
  %t435 = load i64, ptr %t417
  %t436 = getelementptr ptr, ptr %t434, i64 %t435
  %t437 = load ptr, ptr %t436
  %t438 = load i64, ptr %t425
  call void @__c0c_emit(ptr %t432, ptr %t433, ptr %t437, i64 %t438)
  %t440 = load ptr, ptr %t0
  %t441 = load i64, ptr %t417
  %t442 = getelementptr ptr, ptr %t440, i64 %t441
  %t443 = load ptr, ptr %t442
  call void @emit_str_content(ptr %t0, ptr %t443)
  %t445 = load ptr, ptr %t0
  %t446 = getelementptr [3 x i8], ptr @.str405, i64 0, i64 0
  call void @__c0c_emit(ptr %t445, ptr %t446)
  br label %L77
L77:
  %t448 = load i64, ptr %t417
  %t449 = add i64 %t448, 1
  store i64 %t449, ptr %t417
  br label %L75
L78:
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
@.str33 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str34 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str35 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str36 = private unnamed_addr constant [44 x i8] c"  %%t%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str37 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str38 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str39 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str40 = private unnamed_addr constant [3 x i8] c"%s\00"
@.str41 = private unnamed_addr constant [34 x i8] c"  %%t%d = ptrtoint ptr %s to i64\0A\00"
@.str42 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str43 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str44 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str45 = private unnamed_addr constant [32 x i8] c"  %%t%d = icmp ne ptr %s, null\0A\00"
@.str46 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str47 = private unnamed_addr constant [2 x i8] c"0\00"
@.str48 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.str49 = private unnamed_addr constant [31 x i8] c"  %%t%d = fadd double 0.0, %g\0A\00"
@.str50 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str51 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.str52 = private unnamed_addr constant [62 x i8] c"  %%t%d = getelementptr [%d x i8], ptr @.str%d, i64 0, i64 0\0A\00"
@.str53 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str54 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str55 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str56 = private unnamed_addr constant [27 x i8] c"  %%t%d = load %s, ptr %s\0A\00"
@.str57 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str58 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str59 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str60 = private unnamed_addr constant [28 x i8] c"  %%t%d = load %s, ptr @%s\0A\00"
@.str61 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str62 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str63 = private unnamed_addr constant [4 x i8] c"@%s\00"
@.str64 = private unnamed_addr constant [16 x i8] c"  call void %s(\00"
@.str65 = private unnamed_addr constant [22 x i8] c"  %%t%d = call %s %s(\00"
@.str66 = private unnamed_addr constant [3 x i8] c", \00"
@.str67 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str68 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str69 = private unnamed_addr constant [6 x i8] c"%s %s\00"
@.str70 = private unnamed_addr constant [3 x i8] c")\0A\00"
@.str71 = private unnamed_addr constant [2 x i8] c"0\00"
@.str72 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str73 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str74 = private unnamed_addr constant [32 x i8] c"  %%t%d = sext %s %%t%d to i64\0A\00"
@.str75 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str76 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str77 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str78 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str79 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str80 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str81 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str82 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str83 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str84 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str85 = private unnamed_addr constant [50 x i8] c"  %%t%d = phi i64 [ %%t%d, %%L%d ], [ 0, %%L%d ]\0A\00"
@.str86 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str87 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str88 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str89 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str90 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str91 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str92 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str93 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str94 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str95 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str96 = private unnamed_addr constant [50 x i8] c"  %%t%d = phi i64 [ 1, %%L%d ], [ %%t%d, %%L%d ]\0A\00"
@.str97 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str98 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str99 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str100 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str101 = private unnamed_addr constant [14 x i8] c"getelementptr\00"
@.str102 = private unnamed_addr constant [4 x i8] c"add\00"
@.str103 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str104 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str105 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str106 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str107 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str108 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str109 = private unnamed_addr constant [5 x i8] c"frem\00"
@.str110 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str111 = private unnamed_addr constant [4 x i8] c"and\00"
@.str112 = private unnamed_addr constant [3 x i8] c"or\00"
@.str113 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str114 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str115 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str116 = private unnamed_addr constant [9 x i8] c"fcmp oeq\00"
@.str117 = private unnamed_addr constant [8 x i8] c"icmp eq\00"
@.str118 = private unnamed_addr constant [9 x i8] c"fcmp one\00"
@.str119 = private unnamed_addr constant [8 x i8] c"icmp ne\00"
@.str120 = private unnamed_addr constant [9 x i8] c"fcmp olt\00"
@.str121 = private unnamed_addr constant [9 x i8] c"icmp slt\00"
@.str122 = private unnamed_addr constant [9 x i8] c"fcmp ogt\00"
@.str123 = private unnamed_addr constant [9 x i8] c"icmp sgt\00"
@.str124 = private unnamed_addr constant [9 x i8] c"fcmp ole\00"
@.str125 = private unnamed_addr constant [9 x i8] c"icmp sle\00"
@.str126 = private unnamed_addr constant [9 x i8] c"fcmp oge\00"
@.str127 = private unnamed_addr constant [9 x i8] c"icmp sge\00"
@.str128 = private unnamed_addr constant [4 x i8] c"add\00"
@.str129 = private unnamed_addr constant [4 x i8] c"add\00"
@.str130 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str131 = private unnamed_addr constant [47 x i8] c"  %%t%d = getelementptr i8, ptr %%t%d, i64 %s\0A\00"
@.str132 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str133 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str134 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str135 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str136 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str137 = private unnamed_addr constant [26 x i8] c"  %%t%d = fneg double %s\0A\00"
@.str138 = private unnamed_addr constant [25 x i8] c"  %%t%d = sub i64 0, %s\0A\00"
@.str139 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp eq i64 %s, 0\0A\00"
@.str140 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str141 = private unnamed_addr constant [26 x i8] c"  %%t%d = xor i64 %s, -1\0A\00"
@.str142 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str143 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str144 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str145 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str146 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str147 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str148 = private unnamed_addr constant [23 x i8] c"  store %s %s, ptr %s\0A\00"
@.str149 = private unnamed_addr constant [7 x i8] c"double\00"
@.str150 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str151 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str152 = private unnamed_addr constant [4 x i8] c"add\00"
@.str153 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str154 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str155 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str156 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str157 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str158 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str159 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str160 = private unnamed_addr constant [4 x i8] c"and\00"
@.str161 = private unnamed_addr constant [3 x i8] c"or\00"
@.str162 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str163 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str164 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str165 = private unnamed_addr constant [4 x i8] c"add\00"
@.str166 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str167 = private unnamed_addr constant [26 x i8] c"  store %s %%t%d, ptr %s\0A\00"
@.str168 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str169 = private unnamed_addr constant [4 x i8] c"add\00"
@.str170 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str171 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s i64 %s, 1\0A\00"
@.str172 = private unnamed_addr constant [27 x i8] c"  store i64 %%t%d, ptr %s\0A\00"
@.str173 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str174 = private unnamed_addr constant [4 x i8] c"add\00"
@.str175 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str176 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s i64 %s, 1\0A\00"
@.str177 = private unnamed_addr constant [27 x i8] c"  store i64 %%t%d, ptr %s\0A\00"
@.str178 = private unnamed_addr constant [5 x i8] c"null\00"
@.str179 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str180 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str181 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str182 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str183 = private unnamed_addr constant [27 x i8] c"  %%t%d = load %s, ptr %s\0A\00"
@.str184 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str185 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str186 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str187 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str188 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str189 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str190 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str191 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str192 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str193 = private unnamed_addr constant [44 x i8] c"  %%t%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str194 = private unnamed_addr constant [30 x i8] c"  %%t%d = load %s, ptr %%t%d\0A\00"
@.str195 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str196 = private unnamed_addr constant [36 x i8] c"  %%t%d = fpext float %s to double\0A\00"
@.str197 = private unnamed_addr constant [38 x i8] c"  %%t%d = fptrunc double %s to float\0A\00"
@.str198 = private unnamed_addr constant [35 x i8] c"  %%t%d = fptosi double %s to i64\0A\00"
@.str199 = private unnamed_addr constant [31 x i8] c"  %%t%d = sitofp i64 %s to %s\0A\00"
@.str200 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str201 = private unnamed_addr constant [34 x i8] c"  %%t%d = ptrtoint ptr %s to i64\0A\00"
@.str202 = private unnamed_addr constant [33 x i8] c"  %%t%d = bitcast ptr %s to ptr\0A\00"
@.str203 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str204 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str205 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str206 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str207 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str208 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str209 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str210 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str211 = private unnamed_addr constant [48 x i8] c"  %%t%d = phi i64 [ %s, %%L%d ], [ %s, %%L%d ]\0A\00"
@.str212 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str213 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str214 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str215 = private unnamed_addr constant [2 x i8] c"0\00"
@.str216 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str217 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str218 = private unnamed_addr constant [28 x i8] c"  %%t%d = load ptr, ptr %s\0A\00"
@.str219 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str220 = private unnamed_addr constant [28 x i8] c"  ; unhandled expr node %d\0A\00"
@.str221 = private unnamed_addr constant [2 x i8] c"0\00"
@.str222 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str223 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str224 = private unnamed_addr constant [21 x i8] c"  %%t%d = alloca %s\0A\00"
@.str225 = private unnamed_addr constant [22 x i8] c"c0c: too many locals\0A\00"
@.str226 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str227 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str228 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str229 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str230 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str231 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str232 = private unnamed_addr constant [26 x i8] c"  store %s %s, ptr %%t%d\0A\00"
@.str233 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str234 = private unnamed_addr constant [13 x i8] c"  ret %s %s\0A\00"
@.str235 = private unnamed_addr constant [14 x i8] c"  ret ptr %s\0A\00"
@.str236 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str237 = private unnamed_addr constant [17 x i8] c"  ret ptr %%t%d\0A\00"
@.str238 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str239 = private unnamed_addr constant [30 x i8] c"  %%t%d = trunc i64 %s to i8\0A\00"
@.str240 = private unnamed_addr constant [16 x i8] c"  ret i8 %%t%d\0A\00"
@.str241 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str242 = private unnamed_addr constant [31 x i8] c"  %%t%d = trunc i64 %s to i16\0A\00"
@.str243 = private unnamed_addr constant [17 x i8] c"  ret i16 %%t%d\0A\00"
@.str244 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str245 = private unnamed_addr constant [31 x i8] c"  %%t%d = trunc i64 %s to i32\0A\00"
@.str246 = private unnamed_addr constant [17 x i8] c"  ret i32 %%t%d\0A\00"
@.str247 = private unnamed_addr constant [14 x i8] c"  ret i64 %s\0A\00"
@.str248 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str249 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str250 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str251 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str252 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str253 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str254 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str255 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str256 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str257 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str258 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str259 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str260 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str261 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str262 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str263 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str264 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str265 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str266 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str267 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str268 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str269 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str270 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str271 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str272 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str273 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str274 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str275 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str276 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str277 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str278 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str279 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str280 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str281 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str282 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str283 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str284 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str285 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str286 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str287 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str288 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str289 = private unnamed_addr constant [35 x i8] c"  switch i64 %%t%d, label %%L%d [\0A\00"
@.str290 = private unnamed_addr constant [27 x i8] c"    i64 %lld, label %%L%d\0A\00"
@.str291 = private unnamed_addr constant [5 x i8] c"  ]\0A\00"
@.str292 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str293 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str294 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str295 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str296 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str297 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str298 = private unnamed_addr constant [5 x i8] c"%s:\0A\00"
@.str299 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str300 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str301 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str302 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str303 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str304 = private unnamed_addr constant [18 x i8] c"define %s %s @%s(\00"
@.str305 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str306 = private unnamed_addr constant [3 x i8] c", \00"
@.str307 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str308 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str309 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str310 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str311 = private unnamed_addr constant [9 x i8] c"%s %%t%d\00"
@.str312 = private unnamed_addr constant [22 x i8] c"c0c: too many locals\0A\00"
@.str313 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str314 = private unnamed_addr constant [3 x i8] c", \00"
@.str315 = private unnamed_addr constant [4 x i8] c"...\00"
@.str316 = private unnamed_addr constant [5 x i8] c") {\0A\00"
@.str317 = private unnamed_addr constant [8 x i8] c"entry:\0A\00"
@.str318 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str319 = private unnamed_addr constant [16 x i8] c"  ret ptr null\0A\00"
@.str320 = private unnamed_addr constant [14 x i8] c"  ret %s 0.0\0A\00"
@.str321 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str322 = private unnamed_addr constant [12 x i8] c"  ret i8 0\0A\00"
@.str323 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str324 = private unnamed_addr constant [13 x i8] c"  ret i16 0\0A\00"
@.str325 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str326 = private unnamed_addr constant [13 x i8] c"  ret i32 0\0A\00"
@.str327 = private unnamed_addr constant [13 x i8] c"  ret i64 0\0A\00"
@.str328 = private unnamed_addr constant [4 x i8] c"}\0A\0A\00"
@.str329 = private unnamed_addr constant [3 x i8] c", \00"
@.str330 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str331 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str332 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str333 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str334 = private unnamed_addr constant [3 x i8] c"%s\00"
@.str335 = private unnamed_addr constant [3 x i8] c", \00"
@.str336 = private unnamed_addr constant [4 x i8] c"...\00"
@.str337 = private unnamed_addr constant [20 x i8] c"declare %s @%s(%s)\0A\00"
@.str338 = private unnamed_addr constant [26 x i8] c"@%s = external global %s\0A\00"
@.str339 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str340 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str341 = private unnamed_addr constant [36 x i8] c"@%s = %s global %s zeroinitializer\0A\00"
@.str342 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str343 = private unnamed_addr constant [19 x i8] c"; ModuleID = '%s'\0A\00"
@.str344 = private unnamed_addr constant [24 x i8] c"source_filename = \22%s\22\0A\00"
@.str345 = private unnamed_addr constant [94 x i8] c"target datalayout = \22e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128\22\0A\00"
@.str346 = private unnamed_addr constant [45 x i8] c"target triple = \22x86_64-unknown-linux-gnu\22\0A\0A\00"
@.str347 = private unnamed_addr constant [23 x i8] c"; stdlib declarations\0A\00"
@.str348 = private unnamed_addr constant [26 x i8] c"declare ptr @malloc(i64)\0A\00"
@.str349 = private unnamed_addr constant [31 x i8] c"declare ptr @calloc(i64, i64)\0A\00"
@.str350 = private unnamed_addr constant [32 x i8] c"declare ptr @realloc(ptr, i64)\0A\00"
@.str351 = private unnamed_addr constant [25 x i8] c"declare void @free(ptr)\0A\00"
@.str352 = private unnamed_addr constant [26 x i8] c"declare i64 @strlen(ptr)\0A\00"
@.str353 = private unnamed_addr constant [26 x i8] c"declare ptr @strdup(ptr)\0A\00"
@.str354 = private unnamed_addr constant [32 x i8] c"declare ptr @strndup(ptr, i64)\0A\00"
@.str355 = private unnamed_addr constant [31 x i8] c"declare ptr @strcpy(ptr, ptr)\0A\00"
@.str356 = private unnamed_addr constant [37 x i8] c"declare ptr @strncpy(ptr, ptr, i64)\0A\00"
@.str357 = private unnamed_addr constant [31 x i8] c"declare ptr @strcat(ptr, ptr)\0A\00"
@.str358 = private unnamed_addr constant [31 x i8] c"declare ptr @strchr(ptr, i64)\0A\00"
@.str359 = private unnamed_addr constant [31 x i8] c"declare ptr @strstr(ptr, ptr)\0A\00"
@.str360 = private unnamed_addr constant [31 x i8] c"declare i32 @strcmp(ptr, ptr)\0A\00"
@.str361 = private unnamed_addr constant [37 x i8] c"declare i32 @strncmp(ptr, ptr, i64)\0A\00"
@.str362 = private unnamed_addr constant [36 x i8] c"declare ptr @memcpy(ptr, ptr, i64)\0A\00"
@.str363 = private unnamed_addr constant [36 x i8] c"declare ptr @memset(ptr, i32, i64)\0A\00"
@.str364 = private unnamed_addr constant [36 x i8] c"declare i32 @memcmp(ptr, ptr, i64)\0A\00"
@.str365 = private unnamed_addr constant [31 x i8] c"declare i32 @printf(ptr, ...)\0A\00"
@.str366 = private unnamed_addr constant [37 x i8] c"declare i32 @fprintf(ptr, ptr, ...)\0A\00"
@.str367 = private unnamed_addr constant [37 x i8] c"declare i32 @sprintf(ptr, ptr, ...)\0A\00"
@.str368 = private unnamed_addr constant [43 x i8] c"declare i32 @snprintf(ptr, i64, ptr, ...)\0A\00"
@.str369 = private unnamed_addr constant [38 x i8] c"declare i32 @vfprintf(ptr, ptr, ptr)\0A\00"
@.str370 = private unnamed_addr constant [44 x i8] c"declare i32 @vsnprintf(ptr, i64, ptr, ptr)\0A\00"
@.str371 = private unnamed_addr constant [30 x i8] c"declare ptr @fopen(ptr, ptr)\0A\00"
@.str372 = private unnamed_addr constant [26 x i8] c"declare i32 @fclose(ptr)\0A\00"
@.str373 = private unnamed_addr constant [40 x i8] c"declare i64 @fread(ptr, i64, i64, ptr)\0A\00"
@.str374 = private unnamed_addr constant [41 x i8] c"declare i64 @fwrite(ptr, i64, i64, ptr)\0A\00"
@.str375 = private unnamed_addr constant [35 x i8] c"declare i32 @fseek(ptr, i64, i32)\0A\00"
@.str376 = private unnamed_addr constant [25 x i8] c"declare i64 @ftell(ptr)\0A\00"
@.str377 = private unnamed_addr constant [27 x i8] c"declare void @perror(ptr)\0A\00"
@.str378 = private unnamed_addr constant [25 x i8] c"declare void @exit(i32)\0A\00"
@.str379 = private unnamed_addr constant [26 x i8] c"declare ptr @getenv(ptr)\0A\00"
@.str380 = private unnamed_addr constant [24 x i8] c"declare i32 @atoi(ptr)\0A\00"
@.str381 = private unnamed_addr constant [24 x i8] c"declare i64 @atol(ptr)\0A\00"
@.str382 = private unnamed_addr constant [36 x i8] c"declare i64 @strtol(ptr, ptr, i32)\0A\00"
@.str383 = private unnamed_addr constant [37 x i8] c"declare i64 @strtoll(ptr, ptr, i32)\0A\00"
@.str384 = private unnamed_addr constant [27 x i8] c"declare double @atof(ptr)\0A\00"
@.str385 = private unnamed_addr constant [27 x i8] c"declare i32 @isspace(i32)\0A\00"
@.str386 = private unnamed_addr constant [27 x i8] c"declare i32 @isdigit(i32)\0A\00"
@.str387 = private unnamed_addr constant [27 x i8] c"declare i32 @isalpha(i32)\0A\00"
@.str388 = private unnamed_addr constant [27 x i8] c"declare i32 @isalnum(i32)\0A\00"
@.str389 = private unnamed_addr constant [28 x i8] c"declare i32 @isxdigit(i32)\0A\00"
@.str390 = private unnamed_addr constant [27 x i8] c"declare i32 @isupper(i32)\0A\00"
@.str391 = private unnamed_addr constant [27 x i8] c"declare i32 @islower(i32)\0A\00"
@.str392 = private unnamed_addr constant [27 x i8] c"declare i32 @toupper(i32)\0A\00"
@.str393 = private unnamed_addr constant [27 x i8] c"declare i32 @tolower(i32)\0A\00"
@.str394 = private unnamed_addr constant [26 x i8] c"declare i32 @assert(i32)\0A\00"
@.str395 = private unnamed_addr constant [29 x i8] c"declare ptr @__c0c_stderr()\0A\00"
@.str396 = private unnamed_addr constant [29 x i8] c"declare ptr @__c0c_stdout()\0A\00"
@.str397 = private unnamed_addr constant [28 x i8] c"declare ptr @__c0c_stdin()\0A\00"
@.str398 = private unnamed_addr constant [34 x i8] c"declare ptr @__c0c_get_tbuf(i32)\0A\00"
@.str399 = private unnamed_addr constant [41 x i8] c"declare void @__c0c_emit(ptr, ptr, ...)\0A\00"
@.str400 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str401 = private unnamed_addr constant [1 x i8] c"\00"
@.str402 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str403 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str404 = private unnamed_addr constant [53 x i8] c"@.str%d = private unnamed_addr constant [%d x i8] c\22\00"
@.str405 = private unnamed_addr constant [3 x i8] c"\22\0A\00"
