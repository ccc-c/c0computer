; ModuleID = 'codegen.c'
source_filename = "codegen.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx15.0.0"

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
declare ptr @__c0c_get_td_name(i64)
declare i64 @__c0c_get_td_kind(i64)
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
  %t4 = call i32 (ptr, ...) @snprintf(ptr %t1, ptr %t2, ptr %t3, i64 %t0)
  %t5 = sext i32 %t4 to i64
  ret ptr %t1
L0:
  ret ptr null
}

define internal ptr @llvm_type(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = load i64, ptr @tbuf_idx
  %t4 = sext i32 %t2 to i64
  %t3 = add i64 %t4, 1
  store i64 %t3, ptr @tbuf_idx
  %t5 = call ptr @__c0c_get_tbuf(i64 %t2)
  store ptr %t5, ptr %t1
  %t6 = load ptr, ptr %t1
  %t8 = ptrtoint ptr %t6 to i64
  %t9 = icmp eq i64 %t8, 0
  %t7 = zext i1 %t9 to i64
  %t10 = icmp ne i64 %t7, 0
  br i1 %t10, label %L0, label %L2
L0:
  %t11 = call ptr @__c0c_get_tbuf(i64 0)
  store ptr %t11, ptr %t1
  br label %L2
L2:
  %t13 = ptrtoint ptr %t0 to i64
  %t14 = icmp eq i64 %t13, 0
  %t12 = zext i1 %t14 to i64
  %t15 = icmp ne i64 %t12, 0
  br i1 %t15, label %L3, label %L5
L3:
  %t16 = load ptr, ptr %t1
  %t17 = getelementptr [4 x i8], ptr @.str1, i64 0, i64 0
  %t18 = call ptr @strcpy(ptr %t16, ptr %t17)
  %t19 = load ptr, ptr %t1
  ret ptr %t19
L6:
  br label %L5
L5:
  %t20 = load ptr, ptr %t0
  %t21 = ptrtoint ptr %t20 to i64
  %t22 = add i64 %t21, 0
  switch i64 %t22, label %L30 [
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
  %t23 = load ptr, ptr %t1
  %t24 = getelementptr [5 x i8], ptr @.str2, i64 0, i64 0
  %t25 = call ptr @strcpy(ptr %t23, ptr %t24)
  br label %L7
L31:
  br label %L9
L9:
  %t26 = load ptr, ptr %t1
  %t27 = getelementptr [3 x i8], ptr @.str3, i64 0, i64 0
  %t28 = call ptr @strcpy(ptr %t26, ptr %t27)
  br label %L7
L32:
  br label %L10
L10:
  br label %L11
L11:
  br label %L12
L12:
  %t29 = load ptr, ptr %t1
  %t30 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %t31 = call ptr @strcpy(ptr %t29, ptr %t30)
  br label %L7
L33:
  br label %L13
L13:
  br label %L14
L14:
  %t32 = load ptr, ptr %t1
  %t33 = getelementptr [4 x i8], ptr @.str5, i64 0, i64 0
  %t34 = call ptr @strcpy(ptr %t32, ptr %t33)
  br label %L7
L34:
  br label %L15
L15:
  br label %L16
L16:
  br label %L17
L17:
  %t35 = load ptr, ptr %t1
  %t36 = getelementptr [4 x i8], ptr @.str6, i64 0, i64 0
  %t37 = call ptr @strcpy(ptr %t35, ptr %t36)
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
  %t38 = load ptr, ptr %t1
  %t39 = getelementptr [4 x i8], ptr @.str7, i64 0, i64 0
  %t40 = call ptr @strcpy(ptr %t38, ptr %t39)
  br label %L7
L36:
  br label %L22
L22:
  %t41 = load ptr, ptr %t1
  %t42 = getelementptr [6 x i8], ptr @.str8, i64 0, i64 0
  %t43 = call ptr @strcpy(ptr %t41, ptr %t42)
  br label %L7
L37:
  br label %L23
L23:
  %t44 = load ptr, ptr %t1
  %t45 = getelementptr [7 x i8], ptr @.str9, i64 0, i64 0
  %t46 = call ptr @strcpy(ptr %t44, ptr %t45)
  br label %L7
L38:
  br label %L24
L24:
  %t47 = load ptr, ptr %t1
  %t48 = getelementptr [4 x i8], ptr @.str10, i64 0, i64 0
  %t49 = call ptr @strcpy(ptr %t47, ptr %t48)
  br label %L7
L39:
  br label %L25
L25:
  %t50 = load ptr, ptr %t1
  %t51 = getelementptr [4 x i8], ptr @.str11, i64 0, i64 0
  %t52 = call ptr @strcpy(ptr %t50, ptr %t51)
  br label %L7
L40:
  br label %L26
L26:
  %t53 = load ptr, ptr %t1
  %t54 = getelementptr [4 x i8], ptr @.str12, i64 0, i64 0
  %t55 = call ptr @strcpy(ptr %t53, ptr %t54)
  br label %L7
L41:
  br label %L27
L27:
  br label %L28
L28:
  %t56 = load ptr, ptr %t0
  %t57 = icmp ne ptr %t56, null
  br i1 %t57, label %L42, label %L43
L42:
  %t58 = load ptr, ptr %t1
  %t59 = getelementptr [12 x i8], ptr @.str13, i64 0, i64 0
  %t60 = load ptr, ptr %t0
  %t61 = call i32 (ptr, ...) @snprintf(ptr %t58, i64 256, ptr %t59, ptr %t60)
  %t62 = sext i32 %t61 to i64
  br label %L44
L43:
  %t63 = load ptr, ptr %t1
  %t64 = getelementptr [4 x i8], ptr @.str14, i64 0, i64 0
  %t65 = call ptr @strcpy(ptr %t63, ptr %t64)
  br label %L44
L44:
  br label %L7
L45:
  br label %L29
L29:
  %t66 = load ptr, ptr %t1
  %t67 = getelementptr [4 x i8], ptr @.str15, i64 0, i64 0
  %t68 = call ptr @strcpy(ptr %t66, ptr %t67)
  br label %L7
L46:
  br label %L7
L30:
  %t69 = load ptr, ptr %t1
  %t70 = getelementptr [4 x i8], ptr @.str16, i64 0, i64 0
  %t71 = call ptr @strcpy(ptr %t69, ptr %t70)
  br label %L7
L47:
  br label %L7
L7:
  %t72 = load ptr, ptr %t1
  ret ptr %t72
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
  %t10 = sext i32 %t9 to i64
  store i64 %t10, ptr %t8
  br label %L0
L0:
  %t11 = load i64, ptr %t8
  %t12 = load ptr, ptr %t0
  %t14 = sext i32 %t11 to i64
  %t15 = ptrtoint ptr %t12 to i64
  %t13 = icmp slt i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L1, label %L3
L1:
  %t18 = load ptr, ptr %t0
  %t19 = load i64, ptr %t8
  %t21 = sext i32 %t19 to i64
  %t20 = getelementptr ptr, ptr %t18, i64 %t21
  %t22 = load ptr, ptr %t20
  call void @free(ptr %t22)
  %t24 = load ptr, ptr %t0
  %t25 = load i64, ptr %t8
  %t27 = sext i32 %t25 to i64
  %t26 = getelementptr ptr, ptr %t24, i64 %t27
  %t28 = load ptr, ptr %t26
  call void @free(ptr %t28)
  br label %L2
L2:
  %t30 = load i64, ptr %t8
  %t32 = sext i32 %t30 to i64
  %t31 = add i64 %t32, 1
  store i64 %t31, ptr %t8
  br label %L0
L3:
  %t33 = load i64, ptr %t1
  %t34 = sext i32 %t33 to i64
  store i64 %t34, ptr %t0
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
  %t9 = sext i32 %t7 to i64
  %t10 = sext i32 0 to i64
  %t8 = icmp sge i64 %t9, %t10
  %t11 = zext i1 %t8 to i64
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L1, label %L3
L1:
  %t13 = load ptr, ptr %t0
  %t14 = load i64, ptr %t2
  %t16 = sext i32 %t14 to i64
  %t15 = getelementptr ptr, ptr %t13, i64 %t16
  %t17 = load ptr, ptr %t15
  %t18 = call i32 @strcmp(ptr %t17, ptr %t1)
  %t19 = sext i32 %t18 to i64
  %t21 = sext i32 0 to i64
  %t20 = icmp eq i64 %t19, %t21
  %t22 = zext i1 %t20 to i64
  %t23 = icmp ne i64 %t22, 0
  br i1 %t23, label %L4, label %L6
L4:
  %t24 = load ptr, ptr %t0
  %t25 = load i64, ptr %t2
  %t27 = sext i32 %t25 to i64
  %t26 = getelementptr ptr, ptr %t24, i64 %t27
  ret ptr %t26
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t28 = load i64, ptr %t2
  %t30 = sext i32 %t28 to i64
  %t29 = sub i64 %t30, 1
  store i64 %t29, ptr %t2
  br label %L0
L3:
  %t32 = sext i32 0 to i64
  %t31 = inttoptr i64 %t32 to ptr
  ret ptr %t31
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
  %t7 = sext i32 %t4 to i64
  %t8 = ptrtoint ptr %t5 to i64
  %t6 = icmp slt i64 %t7, %t8
  %t9 = zext i1 %t6 to i64
  %t10 = icmp ne i64 %t9, 0
  br i1 %t10, label %L1, label %L3
L1:
  %t11 = load ptr, ptr %t0
  %t12 = load i64, ptr %t2
  %t14 = sext i32 %t12 to i64
  %t13 = getelementptr ptr, ptr %t11, i64 %t14
  %t15 = load ptr, ptr %t13
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
  %t25 = sext i32 %t23 to i64
  %t24 = getelementptr ptr, ptr %t22, i64 %t25
  ret ptr %t24
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t26 = load i64, ptr %t2
  %t28 = sext i32 %t26 to i64
  %t27 = add i64 %t28, 1
  store i64 %t27, ptr %t2
  br label %L0
L3:
  %t30 = sext i32 0 to i64
  %t29 = inttoptr i64 %t30 to ptr
  ret ptr %t29
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
  %t12 = call i32 (ptr, ...) @fprintf(ptr %t10, ptr %t11)
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
  %t33 = call i32 (ptr, ...) @snprintf(ptr %t30, i64 32, ptr %t31, i64 %t32)
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
  %t16 = sext i32 %t11 to i64
  store i64 %t16, ptr %t14
  %t17 = load ptr, ptr %t0
  %t19 = ptrtoint ptr %t17 to i64
  %t18 = add i64 %t19, 1
  store i64 %t18, ptr %t0
  %t20 = load i64, ptr %t2
  %t21 = sext i32 %t20 to i64
  %t22 = trunc i64 %t21 to i32
  ret i32 %t22
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
  %t40 = sext i32 %t38 to i64
  %t39 = add i64 %t40, 1
  store i64 %t39, ptr %t1
  br label %L0
L2:
  %t41 = load i64, ptr %t1
  %t43 = sext i32 %t41 to i64
  %t44 = sext i32 1 to i64
  %t42 = add i64 %t43, %t44
  %t45 = trunc i64 %t42 to i32
  ret i32 %t45
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
  call void (ptr, ...) @__c0c_emit(ptr %t41, ptr %t42)
  br label %L12
L20:
  br label %L14
L14:
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr [4 x i8], ptr @.str21, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t44, ptr %t45)
  br label %L12
L21:
  br label %L15
L15:
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr [4 x i8], ptr @.str22, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t47, ptr %t48)
  br label %L12
L22:
  br label %L16
L16:
  %t50 = load ptr, ptr %t0
  %t51 = getelementptr [4 x i8], ptr @.str23, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t50, ptr %t51)
  br label %L12
L23:
  br label %L17
L17:
  %t53 = load ptr, ptr %t0
  %t54 = getelementptr [4 x i8], ptr @.str24, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t53, ptr %t54)
  br label %L12
L24:
  br label %L18
L18:
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr [4 x i8], ptr @.str25, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t56, ptr %t57)
  br label %L12
L25:
  br label %L12
L19:
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr [6 x i8], ptr @.str26, i64 0, i64 0
  %t61 = load ptr, ptr %t2
  %t62 = load i64, ptr %t61
  %t63 = add i64 %t62, 0
  call void (ptr, ...) @__c0c_emit(ptr %t59, ptr %t60, i64 %t63)
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
  call void (ptr, ...) @__c0c_emit(ptr %t74, ptr %t75, i64 %t79)
  br label %L11
L11:
  br label %L0
L2:
  %t81 = load ptr, ptr %t0
  %t82 = getelementptr [4 x i8], ptr @.str28, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t81, ptr %t82)
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
  %t10 = sext i32 %t9 to i64
  ret i64 %t10
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
  %t26 = call i32 (ptr, ...) @snprintf(ptr %t23, i64 128, ptr %t24, ptr %t25)
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
  %t34 = call i32 (ptr, ...) @snprintf(ptr %t31, i64 128, ptr %t32, ptr %t33)
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
  call void (ptr, ...) @__c0c_emit(ptr %t58, ptr %t59, i64 %t60, ptr %t61)
  %t63 = alloca ptr
  %t64 = call ptr @malloc(i64 32)
  store ptr %t64, ptr %t63
  %t65 = load ptr, ptr %t63
  %t66 = getelementptr [6 x i8], ptr @.str32, i64 0, i64 0
  %t67 = load i64, ptr %t55
  %t68 = call i32 (ptr, ...) @snprintf(ptr %t65, i64 32, ptr %t66, i64 %t67)
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
  call void (ptr, ...) @__c0c_emit(ptr %t146, ptr %t147, i64 %t148, ptr %t149)
  %t151 = load ptr, ptr %t131
  %t152 = getelementptr [6 x i8], ptr @.str35, i64 0, i64 0
  %t153 = load i64, ptr %t143
  %t154 = call i32 (ptr, ...) @snprintf(ptr %t151, i64 64, ptr %t152, i64 %t153)
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
  call void (ptr, ...) @__c0c_emit(ptr %t161, ptr %t162, i64 %t163, ptr %t164, ptr %t165, ptr %t166)
  %t168 = alloca ptr
  %t169 = call ptr @malloc(i64 32)
  store ptr %t169, ptr %t168
  %t170 = load ptr, ptr %t168
  %t171 = getelementptr [6 x i8], ptr @.str37, i64 0, i64 0
  %t172 = load i64, ptr %t89
  %t173 = call i32 (ptr, ...) @snprintf(ptr %t170, i64 32, ptr %t171, i64 %t172)
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
  call void (ptr, ...) @__c0c_emit(ptr %t235, ptr %t236, i64 %t237, ptr %t238)
  %t240 = alloca ptr
  %t241 = load ptr, ptr %t240
  %t242 = getelementptr [6 x i8], ptr @.str39, i64 0, i64 0
  %t243 = load i64, ptr %t227
  %t244 = call i32 (ptr, ...) @snprintf(ptr %t241, i64 32, ptr %t242, i64 %t243)
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
  %t254 = call i32 (ptr, ...) @snprintf(ptr %t251, i64 64, ptr %t252, ptr %t253)
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
  call void (ptr, ...) @__c0c_emit(ptr %t10, ptr %t11, i64 %t12, ptr %t13)
  %t15 = getelementptr [6 x i8], ptr @.str42, i64 0, i64 0
  %t16 = load i64, ptr %t7
  %t17 = call i32 (ptr, ...) @snprintf(ptr %t2, ptr %t3, ptr %t15, i64 %t16)
  %t18 = sext i32 %t17 to i64
  %t19 = load i64, ptr %t7
  %t20 = sext i32 %t19 to i64
  %t21 = trunc i64 %t20 to i32
  ret i32 %t21
L3:
  br label %L2
L1:
  %t22 = call i32 @val_is_64bit(ptr %t1)
  %t23 = sext i32 %t22 to i64
  %t24 = icmp ne i64 %t23, 0
  br i1 %t24, label %L4, label %L5
L4:
  %t25 = load ptr, ptr %t1
  %t27 = ptrtoint ptr %t3 to i64
  %t28 = sext i32 1 to i64
  %t26 = sub i64 %t27, %t28
  %t29 = call ptr @strncpy(ptr %t2, ptr %t25, i64 %t26)
  %t31 = ptrtoint ptr %t3 to i64
  %t32 = sext i32 1 to i64
  %t30 = sub i64 %t31, %t32
  %t33 = getelementptr ptr, ptr %t2, i64 %t30
  %t34 = sext i32 0 to i64
  store i64 %t34, ptr %t33
  %t36 = sext i32 1 to i64
  %t35 = sub i64 0, %t36
  %t37 = trunc i64 %t35 to i32
  ret i32 %t37
L7:
  br label %L6
L5:
  %t38 = alloca i64
  %t39 = call i32 @new_reg(ptr %t0)
  %t40 = sext i32 %t39 to i64
  store i64 %t40, ptr %t38
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr [30 x i8], ptr @.str43, i64 0, i64 0
  %t43 = load i64, ptr %t38
  %t44 = load ptr, ptr %t1
  call void (ptr, ...) @__c0c_emit(ptr %t41, ptr %t42, i64 %t43, ptr %t44)
  %t46 = getelementptr [6 x i8], ptr @.str44, i64 0, i64 0
  %t47 = load i64, ptr %t38
  %t48 = call i32 (ptr, ...) @snprintf(ptr %t2, ptr %t3, ptr %t46, i64 %t47)
  %t49 = sext i32 %t48 to i64
  %t50 = load i64, ptr %t38
  %t51 = sext i32 %t50 to i64
  %t52 = trunc i64 %t51 to i32
  ret i32 %t52
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
  call void (ptr, ...) @__c0c_emit(ptr %t8, ptr %t9, i64 %t10, ptr %t11)
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
  call void (ptr, ...) @__c0c_emit(ptr %t17, ptr %t18, i64 %t19, ptr %t20)
  br label %L2
L2:
  %t22 = load i64, ptr %t2
  %t23 = sext i32 %t22 to i64
  %t24 = trunc i64 %t23 to i32
  ret i32 %t24
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
  %t13 = sext i32 %t11 to i64
  %t12 = add i64 %t13, 0
  %t14 = load ptr, ptr %t1
  %t15 = ptrtoint ptr %t14 to i64
  %t16 = add i64 %t15, 0
  switch i64 %t16, label %L29 [
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
  %t17 = alloca ptr
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr [5 x i8], ptr @.str48, i64 0, i64 0
  %t20 = load ptr, ptr %t1
  %t21 = call i32 (ptr, ...) @snprintf(ptr %t18, i64 8, ptr %t19, ptr %t20)
  %t22 = sext i32 %t21 to i64
  %t23 = load ptr, ptr %t17
  %t24 = call ptr @default_int_type()
  %t25 = call i64 @make_val(ptr %t23, ptr %t24)
  ret i64 %t25
L30:
  br label %L6
L6:
  %t26 = alloca i64
  %t27 = call i32 @new_reg(ptr %t0)
  %t28 = sext i32 %t27 to i64
  store i64 %t28, ptr %t26
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr [31 x i8], ptr @.str49, i64 0, i64 0
  %t31 = load i64, ptr %t26
  %t32 = load ptr, ptr %t1
  call void (ptr, ...) @__c0c_emit(ptr %t29, ptr %t30, i64 %t31, ptr %t32)
  %t34 = alloca ptr
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr [6 x i8], ptr @.str50, i64 0, i64 0
  %t37 = load i64, ptr %t26
  %t38 = call i32 (ptr, ...) @snprintf(ptr %t35, i64 8, ptr %t36, i64 %t37)
  %t39 = sext i32 %t38 to i64
  %t40 = alloca i64
  %t41 = sext i32 0 to i64
  store i64 %t41, ptr %t40
  %t42 = load ptr, ptr %t34
  %t43 = call i64 @make_val(ptr %t42, ptr %t40)
  ret i64 %t43
L31:
  br label %L7
L7:
  %t44 = alloca ptr
  %t45 = load ptr, ptr %t44
  %t46 = getelementptr [5 x i8], ptr @.str51, i64 0, i64 0
  %t47 = load ptr, ptr %t1
  %t48 = call i32 (ptr, ...) @snprintf(ptr %t45, i64 8, ptr %t46, ptr %t47)
  %t49 = sext i32 %t48 to i64
  %t50 = alloca i64
  %t51 = sext i32 0 to i64
  store i64 %t51, ptr %t50
  %t52 = load ptr, ptr %t44
  %t53 = call i64 @make_val(ptr %t52, ptr %t50)
  ret i64 %t53
L32:
  br label %L8
L8:
  %t54 = alloca i64
  %t55 = load ptr, ptr %t1
  %t56 = call i32 @intern_string(ptr %t0, ptr %t55)
  %t57 = sext i32 %t56 to i64
  store i64 %t57, ptr %t54
  %t58 = alloca i64
  %t59 = call i32 @new_reg(ptr %t0)
  %t60 = sext i32 %t59 to i64
  store i64 %t60, ptr %t58
  %t61 = alloca i64
  %t62 = load ptr, ptr %t1
  %t63 = call i32 @str_literal_len(ptr %t62)
  %t64 = sext i32 %t63 to i64
  store i64 %t64, ptr %t61
  %t65 = load ptr, ptr %t0
  %t66 = getelementptr [62 x i8], ptr @.str52, i64 0, i64 0
  %t67 = load i64, ptr %t58
  %t68 = load i64, ptr %t61
  %t69 = load i64, ptr %t54
  call void (ptr, ...) @__c0c_emit(ptr %t65, ptr %t66, i64 %t67, i64 %t68, i64 %t69)
  %t71 = alloca ptr
  %t72 = load ptr, ptr %t71
  %t73 = getelementptr [6 x i8], ptr @.str53, i64 0, i64 0
  %t74 = load i64, ptr %t58
  %t75 = call i32 (ptr, ...) @snprintf(ptr %t72, i64 8, ptr %t73, i64 %t74)
  %t76 = sext i32 %t75 to i64
  %t77 = load ptr, ptr %t71
  %t78 = call ptr @default_ptr_type()
  %t79 = call i64 @make_val(ptr %t77, ptr %t78)
  ret i64 %t79
L33:
  br label %L9
L9:
  %t80 = alloca ptr
  %t81 = load ptr, ptr %t1
  %t82 = call ptr @find_local(ptr %t0, ptr %t81)
  store ptr %t82, ptr %t80
  %t83 = load ptr, ptr %t80
  %t84 = icmp ne ptr %t83, null
  br i1 %t84, label %L34, label %L36
L34:
  %t85 = load ptr, ptr %t80
  %t86 = load ptr, ptr %t85
  %t87 = icmp ne ptr %t86, null
  br i1 %t87, label %L37, label %L39
L37:
  %t88 = load ptr, ptr %t80
  %t89 = load ptr, ptr %t88
  %t90 = load ptr, ptr %t80
  %t91 = load ptr, ptr %t90
  %t92 = call i64 @make_val(ptr %t89, ptr %t91)
  ret i64 %t92
L40:
  br label %L39
L39:
  %t93 = alloca i64
  %t94 = call i32 @new_reg(ptr %t0)
  %t95 = sext i32 %t94 to i64
  store i64 %t95, ptr %t93
  %t96 = alloca ptr
  %t97 = alloca ptr
  %t98 = load ptr, ptr %t80
  %t99 = load ptr, ptr %t98
  %t100 = ptrtoint ptr %t99 to i64
  %t101 = icmp ne i64 %t100, 0
  br i1 %t101, label %L41, label %L42
L41:
  %t102 = load ptr, ptr %t80
  %t103 = load ptr, ptr %t102
  %t104 = load ptr, ptr %t103
  %t106 = ptrtoint ptr %t104 to i64
  %t107 = sext i32 15 to i64
  %t105 = icmp eq i64 %t106, %t107
  %t108 = zext i1 %t105 to i64
  %t109 = icmp ne i64 %t108, 0
  br i1 %t109, label %L44, label %L45
L44:
  br label %L46
L45:
  %t110 = load ptr, ptr %t80
  %t111 = load ptr, ptr %t110
  %t112 = load ptr, ptr %t111
  %t114 = ptrtoint ptr %t112 to i64
  %t115 = sext i32 16 to i64
  %t113 = icmp eq i64 %t114, %t115
  %t116 = zext i1 %t113 to i64
  %t117 = icmp ne i64 %t116, 0
  %t118 = zext i1 %t117 to i64
  br label %L46
L46:
  %t119 = phi i64 [ 1, %L44 ], [ %t118, %L45 ]
  %t120 = icmp ne i64 %t119, 0
  %t121 = zext i1 %t120 to i64
  br label %L43
L42:
  br label %L43
L43:
  %t122 = phi i64 [ %t121, %L41 ], [ 0, %L42 ]
  %t123 = icmp ne i64 %t122, 0
  br i1 %t123, label %L47, label %L48
L47:
  %t124 = getelementptr [4 x i8], ptr @.str54, i64 0, i64 0
  store ptr %t124, ptr %t96
  %t125 = call ptr @default_ptr_type()
  store ptr %t125, ptr %t97
  br label %L49
L48:
  %t126 = load ptr, ptr %t80
  %t127 = load ptr, ptr %t126
  %t128 = ptrtoint ptr %t127 to i64
  %t129 = icmp ne i64 %t128, 0
  br i1 %t129, label %L50, label %L51
L50:
  %t130 = load ptr, ptr %t80
  %t131 = load ptr, ptr %t130
  %t132 = call i32 @type_is_fp(ptr %t131)
  %t133 = sext i32 %t132 to i64
  %t134 = icmp ne i64 %t133, 0
  %t135 = zext i1 %t134 to i64
  br label %L52
L51:
  br label %L52
L52:
  %t136 = phi i64 [ %t135, %L50 ], [ 0, %L51 ]
  %t137 = icmp ne i64 %t136, 0
  br i1 %t137, label %L53, label %L54
L53:
  %t138 = load ptr, ptr %t80
  %t139 = load ptr, ptr %t138
  %t140 = call ptr @llvm_type(ptr %t139)
  store ptr %t140, ptr %t96
  %t141 = load ptr, ptr %t80
  %t142 = load ptr, ptr %t141
  store ptr %t142, ptr %t97
  br label %L55
L54:
  %t143 = getelementptr [4 x i8], ptr @.str55, i64 0, i64 0
  store ptr %t143, ptr %t96
  %t144 = load ptr, ptr %t80
  %t145 = load ptr, ptr %t144
  %t146 = icmp ne ptr %t145, null
  br i1 %t146, label %L56, label %L57
L56:
  %t147 = load ptr, ptr %t80
  %t148 = load ptr, ptr %t147
  %t149 = ptrtoint ptr %t148 to i64
  br label %L58
L57:
  %t150 = call ptr @default_i64_type()
  %t151 = ptrtoint ptr %t150 to i64
  br label %L58
L58:
  %t152 = phi i64 [ %t149, %L56 ], [ %t151, %L57 ]
  store i64 %t152, ptr %t97
  br label %L55
L55:
  br label %L49
L49:
  %t153 = load ptr, ptr %t0
  %t154 = getelementptr [27 x i8], ptr @.str56, i64 0, i64 0
  %t155 = load i64, ptr %t93
  %t156 = load ptr, ptr %t96
  %t157 = load ptr, ptr %t80
  %t158 = load ptr, ptr %t157
  call void (ptr, ...) @__c0c_emit(ptr %t153, ptr %t154, i64 %t155, ptr %t156, ptr %t158)
  %t160 = alloca ptr
  %t161 = load ptr, ptr %t160
  %t162 = getelementptr [6 x i8], ptr @.str57, i64 0, i64 0
  %t163 = load i64, ptr %t93
  %t164 = call i32 (ptr, ...) @snprintf(ptr %t161, i64 8, ptr %t162, i64 %t163)
  %t165 = sext i32 %t164 to i64
  %t166 = load ptr, ptr %t160
  %t167 = load ptr, ptr %t97
  %t168 = call i64 @make_val(ptr %t166, ptr %t167)
  ret i64 %t168
L59:
  br label %L36
L36:
  %t169 = alloca ptr
  %t170 = load ptr, ptr %t1
  %t171 = call ptr @find_global(ptr %t0, ptr %t170)
  store ptr %t171, ptr %t169
  %t172 = load ptr, ptr %t169
  %t173 = ptrtoint ptr %t172 to i64
  %t174 = icmp ne i64 %t173, 0
  br i1 %t174, label %L60, label %L61
L60:
  %t175 = load ptr, ptr %t169
  %t176 = load ptr, ptr %t175
  %t177 = ptrtoint ptr %t176 to i64
  %t178 = icmp ne i64 %t177, 0
  %t179 = zext i1 %t178 to i64
  br label %L62
L61:
  br label %L62
L62:
  %t180 = phi i64 [ %t179, %L60 ], [ 0, %L61 ]
  %t181 = icmp ne i64 %t180, 0
  br i1 %t181, label %L63, label %L64
L63:
  %t182 = load ptr, ptr %t169
  %t183 = load ptr, ptr %t182
  %t184 = load ptr, ptr %t183
  %t186 = ptrtoint ptr %t184 to i64
  %t187 = sext i32 17 to i64
  %t185 = icmp ne i64 %t186, %t187
  %t188 = zext i1 %t185 to i64
  %t189 = icmp ne i64 %t188, 0
  %t190 = zext i1 %t189 to i64
  br label %L65
L64:
  br label %L65
L65:
  %t191 = phi i64 [ %t190, %L63 ], [ 0, %L64 ]
  %t192 = icmp ne i64 %t191, 0
  br i1 %t192, label %L66, label %L68
L66:
  %t193 = alloca i64
  %t194 = call i32 @new_reg(ptr %t0)
  %t195 = sext i32 %t194 to i64
  store i64 %t195, ptr %t193
  %t196 = alloca ptr
  %t197 = alloca ptr
  %t198 = load ptr, ptr %t169
  %t199 = load ptr, ptr %t198
  %t200 = load ptr, ptr %t199
  %t202 = ptrtoint ptr %t200 to i64
  %t203 = sext i32 15 to i64
  %t201 = icmp eq i64 %t202, %t203
  %t204 = zext i1 %t201 to i64
  %t205 = icmp ne i64 %t204, 0
  br i1 %t205, label %L69, label %L70
L69:
  br label %L71
L70:
  %t206 = load ptr, ptr %t169
  %t207 = load ptr, ptr %t206
  %t208 = load ptr, ptr %t207
  %t210 = ptrtoint ptr %t208 to i64
  %t211 = sext i32 16 to i64
  %t209 = icmp eq i64 %t210, %t211
  %t212 = zext i1 %t209 to i64
  %t213 = icmp ne i64 %t212, 0
  %t214 = zext i1 %t213 to i64
  br label %L71
L71:
  %t215 = phi i64 [ 1, %L69 ], [ %t214, %L70 ]
  %t216 = icmp ne i64 %t215, 0
  br i1 %t216, label %L72, label %L73
L72:
  %t217 = getelementptr [4 x i8], ptr @.str58, i64 0, i64 0
  store ptr %t217, ptr %t196
  %t218 = call ptr @default_ptr_type()
  store ptr %t218, ptr %t197
  br label %L74
L73:
  %t219 = load ptr, ptr %t169
  %t220 = load ptr, ptr %t219
  %t221 = call i32 @type_is_fp(ptr %t220)
  %t222 = sext i32 %t221 to i64
  %t223 = icmp ne i64 %t222, 0
  br i1 %t223, label %L75, label %L76
L75:
  %t224 = load ptr, ptr %t169
  %t225 = load ptr, ptr %t224
  %t226 = call ptr @llvm_type(ptr %t225)
  store ptr %t226, ptr %t196
  %t227 = load ptr, ptr %t169
  %t228 = load ptr, ptr %t227
  store ptr %t228, ptr %t197
  br label %L77
L76:
  %t229 = getelementptr [4 x i8], ptr @.str59, i64 0, i64 0
  store ptr %t229, ptr %t196
  %t230 = load ptr, ptr %t169
  %t231 = load ptr, ptr %t230
  %t232 = icmp ne ptr %t231, null
  br i1 %t232, label %L78, label %L79
L78:
  %t233 = load ptr, ptr %t169
  %t234 = load ptr, ptr %t233
  %t235 = ptrtoint ptr %t234 to i64
  br label %L80
L79:
  %t236 = call ptr @default_i64_type()
  %t237 = ptrtoint ptr %t236 to i64
  br label %L80
L80:
  %t238 = phi i64 [ %t235, %L78 ], [ %t237, %L79 ]
  store i64 %t238, ptr %t197
  br label %L77
L77:
  br label %L74
L74:
  %t239 = load ptr, ptr %t0
  %t240 = getelementptr [28 x i8], ptr @.str60, i64 0, i64 0
  %t241 = load i64, ptr %t193
  %t242 = load ptr, ptr %t196
  %t243 = load ptr, ptr %t1
  call void (ptr, ...) @__c0c_emit(ptr %t239, ptr %t240, i64 %t241, ptr %t242, ptr %t243)
  %t245 = alloca ptr
  %t246 = load ptr, ptr %t245
  %t247 = getelementptr [6 x i8], ptr @.str61, i64 0, i64 0
  %t248 = load i64, ptr %t193
  %t249 = call i32 (ptr, ...) @snprintf(ptr %t246, i64 8, ptr %t247, i64 %t248)
  %t250 = sext i32 %t249 to i64
  %t251 = load ptr, ptr %t245
  %t252 = load ptr, ptr %t197
  %t253 = call i64 @make_val(ptr %t251, ptr %t252)
  ret i64 %t253
L81:
  br label %L68
L68:
  %t254 = alloca ptr
  %t255 = load ptr, ptr %t254
  %t256 = getelementptr [4 x i8], ptr @.str62, i64 0, i64 0
  %t257 = load ptr, ptr %t1
  %t258 = call i32 (ptr, ...) @snprintf(ptr %t255, i64 8, ptr %t256, ptr %t257)
  %t259 = sext i32 %t258 to i64
  %t260 = load ptr, ptr %t254
  %t261 = call ptr @default_ptr_type()
  %t262 = call i64 @make_val(ptr %t260, ptr %t261)
  ret i64 %t262
L82:
  br label %L10
L10:
  %t263 = alloca ptr
  %t264 = load ptr, ptr %t1
  %t265 = sext i32 0 to i64
  %t266 = getelementptr ptr, ptr %t264, i64 %t265
  %t267 = load ptr, ptr %t266
  store ptr %t267, ptr %t263
  %t268 = alloca ptr
  %t269 = call ptr @default_int_type()
  store ptr %t269, ptr %t268
  %t270 = alloca ptr
  %t271 = load ptr, ptr %t1
  %t273 = ptrtoint ptr %t271 to i64
  %t274 = sext i32 8 to i64
  %t272 = mul i64 %t273, %t274
  %t275 = call ptr @malloc(i64 %t272)
  store ptr %t275, ptr %t270
  %t276 = alloca ptr
  %t277 = load ptr, ptr %t1
  %t279 = ptrtoint ptr %t277 to i64
  %t280 = sext i32 8 to i64
  %t278 = mul i64 %t279, %t280
  %t281 = call ptr @malloc(i64 %t278)
  store ptr %t281, ptr %t276
  %t282 = alloca i64
  %t283 = sext i32 1 to i64
  store i64 %t283, ptr %t282
  br label %L83
L83:
  %t284 = load i64, ptr %t282
  %t285 = load ptr, ptr %t1
  %t287 = sext i32 %t284 to i64
  %t288 = ptrtoint ptr %t285 to i64
  %t286 = icmp slt i64 %t287, %t288
  %t289 = zext i1 %t286 to i64
  %t290 = icmp ne i64 %t289, 0
  br i1 %t290, label %L84, label %L86
L84:
  %t291 = alloca i64
  %t292 = load ptr, ptr %t1
  %t293 = load i64, ptr %t282
  %t294 = sext i32 %t293 to i64
  %t295 = getelementptr ptr, ptr %t292, i64 %t294
  %t296 = load ptr, ptr %t295
  %t297 = call i64 @emit_expr(ptr %t0, ptr %t296)
  store i64 %t297, ptr %t291
  %t298 = load ptr, ptr %t291
  %t299 = call ptr @strdup(ptr %t298)
  %t300 = load ptr, ptr %t270
  %t301 = load i64, ptr %t282
  %t303 = sext i32 %t301 to i64
  %t302 = getelementptr ptr, ptr %t300, i64 %t303
  store ptr %t299, ptr %t302
  %t304 = load ptr, ptr %t291
  %t305 = load ptr, ptr %t276
  %t306 = load i64, ptr %t282
  %t308 = sext i32 %t306 to i64
  %t307 = getelementptr ptr, ptr %t305, i64 %t308
  store ptr %t304, ptr %t307
  br label %L85
L85:
  %t309 = load i64, ptr %t282
  %t311 = sext i32 %t309 to i64
  %t310 = add i64 %t311, 1
  store i64 %t310, ptr %t282
  br label %L83
L86:
  %t312 = alloca ptr
  %t313 = sext i32 0 to i64
  store i64 %t313, ptr %t312
  %t314 = load ptr, ptr %t263
  %t315 = load ptr, ptr %t314
  %t317 = ptrtoint ptr %t315 to i64
  %t318 = sext i32 23 to i64
  %t316 = icmp eq i64 %t317, %t318
  %t319 = zext i1 %t316 to i64
  %t320 = icmp ne i64 %t319, 0
  br i1 %t320, label %L87, label %L88
L87:
  %t321 = load ptr, ptr %t312
  %t322 = getelementptr [4 x i8], ptr @.str63, i64 0, i64 0
  %t323 = load ptr, ptr %t263
  %t324 = load ptr, ptr %t323
  %t325 = call i32 (ptr, ...) @snprintf(ptr %t321, i64 8, ptr %t322, ptr %t324)
  %t326 = sext i32 %t325 to i64
  %t327 = alloca ptr
  %t328 = load ptr, ptr %t263
  %t329 = load ptr, ptr %t328
  %t330 = call ptr @find_global(ptr %t0, ptr %t329)
  store ptr %t330, ptr %t327
  %t331 = load ptr, ptr %t327
  %t332 = ptrtoint ptr %t331 to i64
  %t333 = icmp ne i64 %t332, 0
  br i1 %t333, label %L90, label %L91
L90:
  %t334 = load ptr, ptr %t327
  %t335 = load ptr, ptr %t334
  %t336 = ptrtoint ptr %t335 to i64
  %t337 = icmp ne i64 %t336, 0
  %t338 = zext i1 %t337 to i64
  br label %L92
L91:
  br label %L92
L92:
  %t339 = phi i64 [ %t338, %L90 ], [ 0, %L91 ]
  %t340 = icmp ne i64 %t339, 0
  br i1 %t340, label %L93, label %L94
L93:
  %t341 = load ptr, ptr %t327
  %t342 = load ptr, ptr %t341
  %t343 = load ptr, ptr %t342
  %t345 = ptrtoint ptr %t343 to i64
  %t346 = sext i32 17 to i64
  %t344 = icmp eq i64 %t345, %t346
  %t347 = zext i1 %t344 to i64
  %t348 = icmp ne i64 %t347, 0
  %t349 = zext i1 %t348 to i64
  br label %L95
L94:
  br label %L95
L95:
  %t350 = phi i64 [ %t349, %L93 ], [ 0, %L94 ]
  %t351 = icmp ne i64 %t350, 0
  br i1 %t351, label %L96, label %L97
L96:
  %t352 = load ptr, ptr %t327
  %t353 = load ptr, ptr %t352
  %t354 = load ptr, ptr %t353
  store ptr %t354, ptr %t268
  br label %L98
L97:
  %t355 = alloca ptr
  %t356 = sext i32 0 to i64
  store i64 %t356, ptr %t355
  %t357 = alloca i64
  %t358 = sext i32 0 to i64
  store i64 %t358, ptr %t357
  br label %L99
L99:
  %t359 = load ptr, ptr %t355
  %t360 = load i64, ptr %t357
  %t361 = sext i32 %t360 to i64
  %t362 = getelementptr ptr, ptr %t359, i64 %t361
  %t363 = load ptr, ptr %t362
  %t364 = icmp ne ptr %t363, null
  br i1 %t364, label %L100, label %L102
L100:
  %t365 = load ptr, ptr %t263
  %t366 = load ptr, ptr %t365
  %t367 = load ptr, ptr %t355
  %t368 = load i64, ptr %t357
  %t369 = sext i32 %t368 to i64
  %t370 = getelementptr ptr, ptr %t367, i64 %t369
  %t371 = load ptr, ptr %t370
  %t372 = call i32 @strcmp(ptr %t366, ptr %t371)
  %t373 = sext i32 %t372 to i64
  %t375 = sext i32 0 to i64
  %t374 = icmp eq i64 %t373, %t375
  %t376 = zext i1 %t374 to i64
  %t377 = icmp ne i64 %t376, 0
  br i1 %t377, label %L103, label %L105
L103:
  %t378 = call ptr @default_ptr_type()
  store ptr %t378, ptr %t268
  br label %L102
L106:
  br label %L105
L105:
  br label %L101
L101:
  %t379 = load i64, ptr %t357
  %t381 = sext i32 %t379 to i64
  %t380 = add i64 %t381, 1
  store i64 %t380, ptr %t357
  br label %L99
L102:
  %t382 = alloca ptr
  %t383 = sext i32 0 to i64
  store i64 %t383, ptr %t382
  %t384 = alloca i64
  %t385 = sext i32 0 to i64
  store i64 %t385, ptr %t384
  br label %L107
L107:
  %t386 = load ptr, ptr %t382
  %t387 = load i64, ptr %t384
  %t388 = sext i32 %t387 to i64
  %t389 = getelementptr ptr, ptr %t386, i64 %t388
  %t390 = load ptr, ptr %t389
  %t391 = icmp ne ptr %t390, null
  br i1 %t391, label %L108, label %L110
L108:
  %t392 = load ptr, ptr %t263
  %t393 = load ptr, ptr %t392
  %t394 = load ptr, ptr %t382
  %t395 = load i64, ptr %t384
  %t396 = sext i32 %t395 to i64
  %t397 = getelementptr ptr, ptr %t394, i64 %t396
  %t398 = load ptr, ptr %t397
  %t399 = call i32 @strcmp(ptr %t393, ptr %t398)
  %t400 = sext i32 %t399 to i64
  %t402 = sext i32 0 to i64
  %t401 = icmp eq i64 %t400, %t402
  %t403 = zext i1 %t401 to i64
  %t404 = icmp ne i64 %t403, 0
  br i1 %t404, label %L111, label %L113
L111:
  %t405 = call ptr @default_i64_type()
  store ptr %t405, ptr %t268
  br label %L110
L114:
  br label %L113
L113:
  br label %L109
L109:
  %t406 = load i64, ptr %t384
  %t408 = sext i32 %t406 to i64
  %t407 = add i64 %t408, 1
  store i64 %t407, ptr %t384
  br label %L107
L110:
  %t409 = alloca i64
  %t410 = sext i32 0 to i64
  store i64 %t410, ptr %t409
  %t411 = alloca ptr
  %t412 = sext i32 0 to i64
  store i64 %t412, ptr %t411
  %t413 = alloca i64
  %t414 = sext i32 0 to i64
  store i64 %t414, ptr %t413
  br label %L115
L115:
  %t415 = load ptr, ptr %t411
  %t416 = load i64, ptr %t413
  %t417 = sext i32 %t416 to i64
  %t418 = getelementptr ptr, ptr %t415, i64 %t417
  %t419 = load ptr, ptr %t418
  %t420 = icmp ne ptr %t419, null
  br i1 %t420, label %L116, label %L118
L116:
  %t421 = load ptr, ptr %t263
  %t422 = load ptr, ptr %t421
  %t423 = load ptr, ptr %t411
  %t424 = load i64, ptr %t413
  %t425 = sext i32 %t424 to i64
  %t426 = getelementptr ptr, ptr %t423, i64 %t425
  %t427 = load ptr, ptr %t426
  %t428 = call i32 @strcmp(ptr %t422, ptr %t427)
  %t429 = sext i32 %t428 to i64
  %t431 = sext i32 0 to i64
  %t430 = icmp eq i64 %t429, %t431
  %t432 = zext i1 %t430 to i64
  %t433 = icmp ne i64 %t432, 0
  br i1 %t433, label %L119, label %L121
L119:
  store ptr %t409, ptr %t268
  br label %L118
L122:
  br label %L121
L121:
  br label %L117
L117:
  %t434 = load i64, ptr %t413
  %t436 = sext i32 %t434 to i64
  %t435 = add i64 %t436, 1
  store i64 %t435, ptr %t413
  br label %L115
L118:
  br label %L98
L98:
  br label %L89
L88:
  %t437 = alloca i64
  %t438 = load ptr, ptr %t263
  %t439 = call i64 @emit_expr(ptr %t0, ptr %t438)
  store i64 %t439, ptr %t437
  %t440 = load ptr, ptr %t312
  %t441 = load ptr, ptr %t437
  %t443 = sext i32 8 to i64
  %t444 = sext i32 1 to i64
  %t442 = sub i64 %t443, %t444
  %t445 = call ptr @strncpy(ptr %t440, ptr %t441, i64 %t442)
  br label %L89
L89:
  %t446 = alloca i64
  %t447 = sext i32 0 to i64
  store i64 %t447, ptr %t446
  %t448 = load ptr, ptr %t263
  %t449 = load ptr, ptr %t448
  %t451 = ptrtoint ptr %t449 to i64
  %t452 = sext i32 23 to i64
  %t450 = icmp eq i64 %t451, %t452
  %t453 = zext i1 %t450 to i64
  %t454 = icmp ne i64 %t453, 0
  br i1 %t454, label %L123, label %L125
L123:
  %t455 = alloca ptr
  %t456 = sext i32 0 to i64
  store i64 %t456, ptr %t455
  %t457 = alloca i64
  %t458 = sext i32 0 to i64
  store i64 %t458, ptr %t457
  br label %L126
L126:
  %t459 = load ptr, ptr %t455
  %t460 = load i64, ptr %t457
  %t461 = sext i32 %t460 to i64
  %t462 = getelementptr ptr, ptr %t459, i64 %t461
  %t463 = load ptr, ptr %t462
  %t464 = icmp ne ptr %t463, null
  br i1 %t464, label %L127, label %L129
L127:
  %t465 = load ptr, ptr %t263
  %t466 = load ptr, ptr %t465
  %t467 = load ptr, ptr %t455
  %t468 = load i64, ptr %t457
  %t469 = sext i32 %t468 to i64
  %t470 = getelementptr ptr, ptr %t467, i64 %t469
  %t471 = load ptr, ptr %t470
  %t472 = call i32 @strcmp(ptr %t466, ptr %t471)
  %t473 = sext i32 %t472 to i64
  %t475 = sext i32 0 to i64
  %t474 = icmp eq i64 %t473, %t475
  %t476 = zext i1 %t474 to i64
  %t477 = icmp ne i64 %t476, 0
  br i1 %t477, label %L130, label %L132
L130:
  %t478 = sext i32 1 to i64
  store i64 %t478, ptr %t446
  br label %L129
L133:
  br label %L132
L132:
  br label %L128
L128:
  %t479 = load i64, ptr %t457
  %t481 = sext i32 %t479 to i64
  %t480 = add i64 %t481, 1
  store i64 %t480, ptr %t457
  br label %L126
L129:
  br label %L125
L125:
  %t482 = alloca i64
  %t483 = call i32 @new_reg(ptr %t0)
  %t484 = sext i32 %t483 to i64
  store i64 %t484, ptr %t482
  %t485 = alloca ptr
  %t486 = load ptr, ptr %t268
  %t487 = call ptr @llvm_type(ptr %t486)
  store ptr %t487, ptr %t485
  %t488 = alloca i64
  %t489 = load ptr, ptr %t268
  %t490 = load ptr, ptr %t489
  %t492 = ptrtoint ptr %t490 to i64
  %t493 = sext i32 0 to i64
  %t491 = icmp eq i64 %t492, %t493
  %t494 = zext i1 %t491 to i64
  store i64 %t494, ptr %t488
  %t495 = load i64, ptr %t488
  %t496 = sext i32 %t495 to i64
  %t497 = icmp ne i64 %t496, 0
  br i1 %t497, label %L134, label %L135
L134:
  %t498 = load i64, ptr %t446
  %t499 = sext i32 %t498 to i64
  %t500 = icmp ne i64 %t499, 0
  %t501 = zext i1 %t500 to i64
  br label %L136
L135:
  br label %L136
L136:
  %t502 = phi i64 [ %t501, %L134 ], [ 0, %L135 ]
  %t503 = icmp ne i64 %t502, 0
  br i1 %t503, label %L137, label %L138
L137:
  %t504 = load ptr, ptr %t0
  %t505 = getelementptr [27 x i8], ptr @.str64, i64 0, i64 0
  %t506 = load ptr, ptr %t312
  call void (ptr, ...) @__c0c_emit(ptr %t504, ptr %t505, ptr %t506)
  br label %L139
L138:
  %t508 = load i64, ptr %t488
  %t510 = sext i32 %t508 to i64
  %t509 = icmp ne i64 %t510, 0
  br i1 %t509, label %L140, label %L141
L140:
  %t511 = load ptr, ptr %t0
  %t512 = getelementptr [16 x i8], ptr @.str65, i64 0, i64 0
  %t513 = load ptr, ptr %t312
  call void (ptr, ...) @__c0c_emit(ptr %t511, ptr %t512, ptr %t513)
  br label %L142
L141:
  %t515 = load i64, ptr %t446
  %t517 = sext i32 %t515 to i64
  %t516 = icmp ne i64 %t517, 0
  br i1 %t516, label %L143, label %L144
L143:
  %t518 = load ptr, ptr %t0
  %t519 = getelementptr [33 x i8], ptr @.str66, i64 0, i64 0
  %t520 = load i64, ptr %t482
  %t521 = load ptr, ptr %t485
  %t522 = load ptr, ptr %t312
  call void (ptr, ...) @__c0c_emit(ptr %t518, ptr %t519, i64 %t520, ptr %t521, ptr %t522)
  br label %L145
L144:
  %t524 = load ptr, ptr %t0
  %t525 = getelementptr [22 x i8], ptr @.str67, i64 0, i64 0
  %t526 = load i64, ptr %t482
  %t527 = load ptr, ptr %t485
  %t528 = load ptr, ptr %t312
  call void (ptr, ...) @__c0c_emit(ptr %t524, ptr %t525, i64 %t526, ptr %t527, ptr %t528)
  br label %L145
L145:
  br label %L142
L142:
  br label %L139
L139:
  %t530 = alloca i64
  %t531 = sext i32 1 to i64
  store i64 %t531, ptr %t530
  br label %L146
L146:
  %t532 = load i64, ptr %t530
  %t533 = load ptr, ptr %t1
  %t535 = sext i32 %t532 to i64
  %t536 = ptrtoint ptr %t533 to i64
  %t534 = icmp slt i64 %t535, %t536
  %t537 = zext i1 %t534 to i64
  %t538 = icmp ne i64 %t537, 0
  br i1 %t538, label %L147, label %L149
L147:
  %t539 = load i64, ptr %t530
  %t541 = sext i32 %t539 to i64
  %t542 = sext i32 1 to i64
  %t540 = icmp sgt i64 %t541, %t542
  %t543 = zext i1 %t540 to i64
  %t544 = icmp ne i64 %t543, 0
  br i1 %t544, label %L150, label %L152
L150:
  %t545 = load ptr, ptr %t0
  %t546 = getelementptr [3 x i8], ptr @.str68, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t545, ptr %t546)
  br label %L152
L152:
  %t548 = alloca ptr
  %t549 = load ptr, ptr %t276
  %t550 = load i64, ptr %t530
  %t551 = sext i32 %t550 to i64
  %t552 = getelementptr ptr, ptr %t549, i64 %t551
  %t553 = load ptr, ptr %t552
  %t554 = ptrtoint ptr %t553 to i64
  %t555 = icmp ne i64 %t554, 0
  br i1 %t555, label %L153, label %L154
L153:
  %t556 = load ptr, ptr %t276
  %t557 = load i64, ptr %t530
  %t558 = sext i32 %t557 to i64
  %t559 = getelementptr ptr, ptr %t556, i64 %t558
  %t560 = load ptr, ptr %t559
  %t561 = load ptr, ptr %t560
  %t563 = ptrtoint ptr %t561 to i64
  %t564 = sext i32 15 to i64
  %t562 = icmp eq i64 %t563, %t564
  %t565 = zext i1 %t562 to i64
  %t566 = icmp ne i64 %t565, 0
  br i1 %t566, label %L156, label %L157
L156:
  br label %L158
L157:
  %t567 = load ptr, ptr %t276
  %t568 = load i64, ptr %t530
  %t569 = sext i32 %t568 to i64
  %t570 = getelementptr ptr, ptr %t567, i64 %t569
  %t571 = load ptr, ptr %t570
  %t572 = load ptr, ptr %t571
  %t574 = ptrtoint ptr %t572 to i64
  %t575 = sext i32 16 to i64
  %t573 = icmp eq i64 %t574, %t575
  %t576 = zext i1 %t573 to i64
  %t577 = icmp ne i64 %t576, 0
  %t578 = zext i1 %t577 to i64
  br label %L158
L158:
  %t579 = phi i64 [ 1, %L156 ], [ %t578, %L157 ]
  %t580 = icmp ne i64 %t579, 0
  %t581 = zext i1 %t580 to i64
  br label %L155
L154:
  br label %L155
L155:
  %t582 = phi i64 [ %t581, %L153 ], [ 0, %L154 ]
  %t583 = icmp ne i64 %t582, 0
  br i1 %t583, label %L159, label %L160
L159:
  %t584 = getelementptr [4 x i8], ptr @.str69, i64 0, i64 0
  store ptr %t584, ptr %t548
  br label %L161
L160:
  %t585 = load ptr, ptr %t276
  %t586 = load i64, ptr %t530
  %t587 = sext i32 %t586 to i64
  %t588 = getelementptr ptr, ptr %t585, i64 %t587
  %t589 = load ptr, ptr %t588
  %t590 = ptrtoint ptr %t589 to i64
  %t591 = icmp ne i64 %t590, 0
  br i1 %t591, label %L162, label %L163
L162:
  %t592 = load ptr, ptr %t276
  %t593 = load i64, ptr %t530
  %t594 = sext i32 %t593 to i64
  %t595 = getelementptr ptr, ptr %t592, i64 %t594
  %t596 = load ptr, ptr %t595
  %t597 = call i32 @type_is_fp(ptr %t596)
  %t598 = sext i32 %t597 to i64
  %t599 = icmp ne i64 %t598, 0
  %t600 = zext i1 %t599 to i64
  br label %L164
L163:
  br label %L164
L164:
  %t601 = phi i64 [ %t600, %L162 ], [ 0, %L163 ]
  %t602 = icmp ne i64 %t601, 0
  br i1 %t602, label %L165, label %L166
L165:
  %t603 = load ptr, ptr %t276
  %t604 = load i64, ptr %t530
  %t605 = sext i32 %t604 to i64
  %t606 = getelementptr ptr, ptr %t603, i64 %t605
  %t607 = load ptr, ptr %t606
  %t608 = call ptr @llvm_type(ptr %t607)
  store ptr %t608, ptr %t548
  br label %L167
L166:
  %t609 = getelementptr [4 x i8], ptr @.str70, i64 0, i64 0
  store ptr %t609, ptr %t548
  br label %L167
L167:
  br label %L161
L161:
  %t610 = load ptr, ptr %t0
  %t611 = getelementptr [6 x i8], ptr @.str71, i64 0, i64 0
  %t612 = load ptr, ptr %t548
  %t613 = load ptr, ptr %t270
  %t614 = load i64, ptr %t530
  %t615 = sext i32 %t614 to i64
  %t616 = getelementptr ptr, ptr %t613, i64 %t615
  %t617 = load ptr, ptr %t616
  call void (ptr, ...) @__c0c_emit(ptr %t610, ptr %t611, ptr %t612, ptr %t617)
  br label %L148
L148:
  %t619 = load i64, ptr %t530
  %t621 = sext i32 %t619 to i64
  %t620 = add i64 %t621, 1
  store i64 %t620, ptr %t530
  br label %L146
L149:
  %t622 = load ptr, ptr %t0
  %t623 = getelementptr [3 x i8], ptr @.str72, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t622, ptr %t623)
  %t625 = alloca i64
  %t626 = sext i32 1 to i64
  store i64 %t626, ptr %t625
  br label %L168
L168:
  %t627 = load i64, ptr %t625
  %t628 = load ptr, ptr %t1
  %t630 = sext i32 %t627 to i64
  %t631 = ptrtoint ptr %t628 to i64
  %t629 = icmp slt i64 %t630, %t631
  %t632 = zext i1 %t629 to i64
  %t633 = icmp ne i64 %t632, 0
  br i1 %t633, label %L169, label %L171
L169:
  %t634 = load ptr, ptr %t270
  %t635 = load i64, ptr %t625
  %t636 = sext i32 %t635 to i64
  %t637 = getelementptr ptr, ptr %t634, i64 %t636
  %t638 = load ptr, ptr %t637
  call void @free(ptr %t638)
  br label %L170
L170:
  %t640 = load i64, ptr %t625
  %t642 = sext i32 %t640 to i64
  %t641 = add i64 %t642, 1
  store i64 %t641, ptr %t625
  br label %L168
L171:
  %t643 = load ptr, ptr %t270
  call void @free(ptr %t643)
  %t645 = load ptr, ptr %t276
  call void @free(ptr %t645)
  %t647 = load i64, ptr %t488
  %t649 = sext i32 %t647 to i64
  %t648 = icmp ne i64 %t649, 0
  br i1 %t648, label %L172, label %L174
L172:
  %t650 = getelementptr [2 x i8], ptr @.str73, i64 0, i64 0
  %t651 = load ptr, ptr %t268
  %t652 = call i64 @make_val(ptr %t650, ptr %t651)
  ret i64 %t652
L175:
  br label %L174
L174:
  %t653 = alloca ptr
  %t654 = load ptr, ptr %t653
  %t655 = getelementptr [6 x i8], ptr @.str74, i64 0, i64 0
  %t656 = load i64, ptr %t482
  %t657 = call i32 (ptr, ...) @snprintf(ptr %t654, i64 8, ptr %t655, i64 %t656)
  %t658 = sext i32 %t657 to i64
  %t659 = alloca ptr
  %t660 = load ptr, ptr %t268
  store ptr %t660, ptr %t659
  %t661 = load ptr, ptr %t268
  %t662 = call i32 @type_is_fp(ptr %t661)
  %t663 = sext i32 %t662 to i64
  %t665 = icmp eq i64 %t663, 0
  %t664 = zext i1 %t665 to i64
  %t666 = icmp ne i64 %t664, 0
  br i1 %t666, label %L176, label %L177
L176:
  %t667 = load ptr, ptr %t268
  %t668 = load ptr, ptr %t667
  %t670 = ptrtoint ptr %t668 to i64
  %t671 = sext i32 15 to i64
  %t669 = icmp ne i64 %t670, %t671
  %t672 = zext i1 %t669 to i64
  %t673 = icmp ne i64 %t672, 0
  %t674 = zext i1 %t673 to i64
  br label %L178
L177:
  br label %L178
L178:
  %t675 = phi i64 [ %t674, %L176 ], [ 0, %L177 ]
  %t676 = icmp ne i64 %t675, 0
  br i1 %t676, label %L179, label %L180
L179:
  %t677 = load ptr, ptr %t268
  %t678 = load ptr, ptr %t677
  %t680 = ptrtoint ptr %t678 to i64
  %t681 = sext i32 16 to i64
  %t679 = icmp ne i64 %t680, %t681
  %t682 = zext i1 %t679 to i64
  %t683 = icmp ne i64 %t682, 0
  %t684 = zext i1 %t683 to i64
  br label %L181
L180:
  br label %L181
L181:
  %t685 = phi i64 [ %t684, %L179 ], [ 0, %L180 ]
  %t686 = icmp ne i64 %t685, 0
  br i1 %t686, label %L182, label %L183
L182:
  %t687 = load ptr, ptr %t268
  %t688 = load ptr, ptr %t687
  %t690 = ptrtoint ptr %t688 to i64
  %t691 = sext i32 0 to i64
  %t689 = icmp ne i64 %t690, %t691
  %t692 = zext i1 %t689 to i64
  %t693 = icmp ne i64 %t692, 0
  %t694 = zext i1 %t693 to i64
  br label %L184
L183:
  br label %L184
L184:
  %t695 = phi i64 [ %t694, %L182 ], [ 0, %L183 ]
  %t696 = icmp ne i64 %t695, 0
  br i1 %t696, label %L185, label %L187
L185:
  %t697 = alloca i64
  %t698 = load ptr, ptr %t268
  %t699 = call i32 @type_size(ptr %t698)
  %t700 = sext i32 %t699 to i64
  store i64 %t700, ptr %t697
  %t701 = load i64, ptr %t697
  %t703 = sext i32 %t701 to i64
  %t704 = sext i32 0 to i64
  %t702 = icmp sgt i64 %t703, %t704
  %t705 = zext i1 %t702 to i64
  %t706 = icmp ne i64 %t705, 0
  br i1 %t706, label %L188, label %L189
L188:
  %t707 = load i64, ptr %t697
  %t709 = sext i32 %t707 to i64
  %t710 = sext i32 8 to i64
  %t708 = icmp slt i64 %t709, %t710
  %t711 = zext i1 %t708 to i64
  %t712 = icmp ne i64 %t711, 0
  %t713 = zext i1 %t712 to i64
  br label %L190
L189:
  br label %L190
L190:
  %t714 = phi i64 [ %t713, %L188 ], [ 0, %L189 ]
  %t715 = icmp ne i64 %t714, 0
  br i1 %t715, label %L191, label %L192
L191:
  %t716 = load ptr, ptr %t485
  %t717 = getelementptr [4 x i8], ptr @.str75, i64 0, i64 0
  %t718 = call i32 @strcmp(ptr %t716, ptr %t717)
  %t719 = sext i32 %t718 to i64
  %t721 = sext i32 0 to i64
  %t720 = icmp ne i64 %t719, %t721
  %t722 = zext i1 %t720 to i64
  %t723 = icmp ne i64 %t722, 0
  %t724 = zext i1 %t723 to i64
  br label %L193
L192:
  br label %L193
L193:
  %t725 = phi i64 [ %t724, %L191 ], [ 0, %L192 ]
  %t726 = icmp ne i64 %t725, 0
  br i1 %t726, label %L194, label %L196
L194:
  %t727 = alloca i64
  %t728 = call i32 @new_reg(ptr %t0)
  %t729 = sext i32 %t728 to i64
  store i64 %t729, ptr %t727
  %t730 = load ptr, ptr %t0
  %t731 = getelementptr [32 x i8], ptr @.str76, i64 0, i64 0
  %t732 = load i64, ptr %t727
  %t733 = load ptr, ptr %t485
  %t734 = load i64, ptr %t482
  call void (ptr, ...) @__c0c_emit(ptr %t730, ptr %t731, i64 %t732, ptr %t733, i64 %t734)
  %t736 = load ptr, ptr %t653
  %t737 = getelementptr [6 x i8], ptr @.str77, i64 0, i64 0
  %t738 = load i64, ptr %t727
  %t739 = call i32 (ptr, ...) @snprintf(ptr %t736, i64 8, ptr %t737, i64 %t738)
  %t740 = sext i32 %t739 to i64
  br label %L196
L196:
  %t741 = call ptr @default_i64_type()
  store ptr %t741, ptr %t659
  br label %L187
L187:
  %t742 = load ptr, ptr %t653
  %t743 = load ptr, ptr %t659
  %t744 = call i64 @make_val(ptr %t742, ptr %t743)
  ret i64 %t744
L197:
  br label %L11
L11:
  %t745 = load ptr, ptr %t1
  %t747 = ptrtoint ptr %t745 to i64
  %t748 = sext i32 52 to i64
  %t746 = icmp eq i64 %t747, %t748
  %t749 = zext i1 %t746 to i64
  %t750 = icmp ne i64 %t749, 0
  br i1 %t750, label %L198, label %L200
L198:
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
  %t775 = getelementptr [29 x i8], ptr @.str78, i64 0, i64 0
  %t776 = load i64, ptr %t771
  %t777 = load ptr, ptr %t766
  call void (ptr, ...) @__c0c_emit(ptr %t774, ptr %t775, i64 %t776, ptr %t777)
  %t779 = load ptr, ptr %t0
  %t780 = getelementptr [41 x i8], ptr @.str79, i64 0, i64 0
  %t781 = load i64, ptr %t771
  %t782 = load i64, ptr %t757
  %t783 = load i64, ptr %t760
  call void (ptr, ...) @__c0c_emit(ptr %t779, ptr %t780, i64 %t781, i64 %t782, i64 %t783)
  %t785 = load ptr, ptr %t0
  %t786 = getelementptr [6 x i8], ptr @.str80, i64 0, i64 0
  %t787 = load i64, ptr %t757
  call void (ptr, ...) @__c0c_emit(ptr %t785, ptr %t786, i64 %t787)
  %t789 = alloca i64
  %t790 = load ptr, ptr %t1
  %t791 = sext i32 1 to i64
  %t792 = getelementptr ptr, ptr %t790, i64 %t791
  %t793 = load ptr, ptr %t792
  %t794 = call i64 @emit_expr(ptr %t0, ptr %t793)
  store i64 %t794, ptr %t789
  %t795 = alloca ptr
  %t796 = load i64, ptr %t789
  %t797 = load ptr, ptr %t795
  %t798 = call i32 @promote_to_i64(ptr %t0, i64 %t796, ptr %t797, i64 64)
  %t799 = sext i32 %t798 to i64
  %t800 = alloca i64
  %t801 = call i32 @new_reg(ptr %t0)
  %t802 = sext i32 %t801 to i64
  store i64 %t802, ptr %t800
  %t803 = alloca i64
  %t804 = call i32 @new_reg(ptr %t0)
  %t805 = sext i32 %t804 to i64
  store i64 %t805, ptr %t803
  %t806 = load ptr, ptr %t0
  %t807 = getelementptr [29 x i8], ptr @.str81, i64 0, i64 0
  %t808 = load i64, ptr %t800
  %t809 = load ptr, ptr %t795
  call void (ptr, ...) @__c0c_emit(ptr %t806, ptr %t807, i64 %t808, ptr %t809)
  %t811 = load ptr, ptr %t0
  %t812 = getelementptr [32 x i8], ptr @.str82, i64 0, i64 0
  %t813 = load i64, ptr %t803
  %t814 = load i64, ptr %t800
  call void (ptr, ...) @__c0c_emit(ptr %t811, ptr %t812, i64 %t813, i64 %t814)
  %t816 = load ptr, ptr %t0
  %t817 = getelementptr [18 x i8], ptr @.str83, i64 0, i64 0
  %t818 = load i64, ptr %t763
  call void (ptr, ...) @__c0c_emit(ptr %t816, ptr %t817, i64 %t818)
  %t820 = load ptr, ptr %t0
  %t821 = getelementptr [6 x i8], ptr @.str84, i64 0, i64 0
  %t822 = load i64, ptr %t760
  call void (ptr, ...) @__c0c_emit(ptr %t820, ptr %t821, i64 %t822)
  %t824 = load ptr, ptr %t0
  %t825 = getelementptr [18 x i8], ptr @.str85, i64 0, i64 0
  %t826 = load i64, ptr %t763
  call void (ptr, ...) @__c0c_emit(ptr %t824, ptr %t825, i64 %t826)
  %t828 = load ptr, ptr %t0
  %t829 = getelementptr [6 x i8], ptr @.str86, i64 0, i64 0
  %t830 = load i64, ptr %t763
  call void (ptr, ...) @__c0c_emit(ptr %t828, ptr %t829, i64 %t830)
  %t832 = alloca i64
  %t833 = call i32 @new_reg(ptr %t0)
  %t834 = sext i32 %t833 to i64
  store i64 %t834, ptr %t832
  %t835 = load ptr, ptr %t0
  %t836 = getelementptr [50 x i8], ptr @.str87, i64 0, i64 0
  %t837 = load i64, ptr %t832
  %t838 = load i64, ptr %t803
  %t839 = load i64, ptr %t757
  %t840 = load i64, ptr %t760
  call void (ptr, ...) @__c0c_emit(ptr %t835, ptr %t836, i64 %t837, i64 %t838, i64 %t839, i64 %t840)
  %t842 = alloca ptr
  %t843 = load ptr, ptr %t842
  %t844 = getelementptr [6 x i8], ptr @.str88, i64 0, i64 0
  %t845 = load i64, ptr %t832
  %t846 = call i32 (ptr, ...) @snprintf(ptr %t843, i64 8, ptr %t844, i64 %t845)
  %t847 = sext i32 %t846 to i64
  %t848 = load ptr, ptr %t842
  %t849 = call ptr @default_i64_type()
  %t850 = call i64 @make_val(ptr %t848, ptr %t849)
  ret i64 %t850
L201:
  br label %L200
L200:
  %t851 = load ptr, ptr %t1
  %t853 = ptrtoint ptr %t851 to i64
  %t854 = sext i32 53 to i64
  %t852 = icmp eq i64 %t853, %t854
  %t855 = zext i1 %t852 to i64
  %t856 = icmp ne i64 %t855, 0
  br i1 %t856, label %L202, label %L204
L202:
  %t857 = alloca i64
  %t858 = load ptr, ptr %t1
  %t859 = sext i32 0 to i64
  %t860 = getelementptr ptr, ptr %t858, i64 %t859
  %t861 = load ptr, ptr %t860
  %t862 = call i64 @emit_expr(ptr %t0, ptr %t861)
  store i64 %t862, ptr %t857
  %t863 = alloca i64
  %t864 = call i32 @new_label(ptr %t0)
  %t865 = sext i32 %t864 to i64
  store i64 %t865, ptr %t863
  %t866 = alloca i64
  %t867 = call i32 @new_label(ptr %t0)
  %t868 = sext i32 %t867 to i64
  store i64 %t868, ptr %t866
  %t869 = alloca i64
  %t870 = call i32 @new_label(ptr %t0)
  %t871 = sext i32 %t870 to i64
  store i64 %t871, ptr %t869
  %t872 = alloca ptr
  %t873 = load i64, ptr %t857
  %t874 = load ptr, ptr %t872
  %t875 = call i32 @promote_to_i64(ptr %t0, i64 %t873, ptr %t874, i64 64)
  %t876 = sext i32 %t875 to i64
  %t877 = alloca i64
  %t878 = call i32 @new_reg(ptr %t0)
  %t879 = sext i32 %t878 to i64
  store i64 %t879, ptr %t877
  %t880 = load ptr, ptr %t0
  %t881 = getelementptr [29 x i8], ptr @.str89, i64 0, i64 0
  %t882 = load i64, ptr %t877
  %t883 = load ptr, ptr %t872
  call void (ptr, ...) @__c0c_emit(ptr %t880, ptr %t881, i64 %t882, ptr %t883)
  %t885 = load ptr, ptr %t0
  %t886 = getelementptr [41 x i8], ptr @.str90, i64 0, i64 0
  %t887 = load i64, ptr %t877
  %t888 = load i64, ptr %t863
  %t889 = load i64, ptr %t866
  call void (ptr, ...) @__c0c_emit(ptr %t885, ptr %t886, i64 %t887, i64 %t888, i64 %t889)
  %t891 = load ptr, ptr %t0
  %t892 = getelementptr [6 x i8], ptr @.str91, i64 0, i64 0
  %t893 = load i64, ptr %t863
  call void (ptr, ...) @__c0c_emit(ptr %t891, ptr %t892, i64 %t893)
  %t895 = load ptr, ptr %t0
  %t896 = getelementptr [18 x i8], ptr @.str92, i64 0, i64 0
  %t897 = load i64, ptr %t869
  call void (ptr, ...) @__c0c_emit(ptr %t895, ptr %t896, i64 %t897)
  %t899 = load ptr, ptr %t0
  %t900 = getelementptr [6 x i8], ptr @.str93, i64 0, i64 0
  %t901 = load i64, ptr %t866
  call void (ptr, ...) @__c0c_emit(ptr %t899, ptr %t900, i64 %t901)
  %t903 = alloca i64
  %t904 = load ptr, ptr %t1
  %t905 = sext i32 1 to i64
  %t906 = getelementptr ptr, ptr %t904, i64 %t905
  %t907 = load ptr, ptr %t906
  %t908 = call i64 @emit_expr(ptr %t0, ptr %t907)
  store i64 %t908, ptr %t903
  %t909 = alloca ptr
  %t910 = load i64, ptr %t903
  %t911 = load ptr, ptr %t909
  %t912 = call i32 @promote_to_i64(ptr %t0, i64 %t910, ptr %t911, i64 64)
  %t913 = sext i32 %t912 to i64
  %t914 = alloca i64
  %t915 = call i32 @new_reg(ptr %t0)
  %t916 = sext i32 %t915 to i64
  store i64 %t916, ptr %t914
  %t917 = alloca i64
  %t918 = call i32 @new_reg(ptr %t0)
  %t919 = sext i32 %t918 to i64
  store i64 %t919, ptr %t917
  %t920 = load ptr, ptr %t0
  %t921 = getelementptr [29 x i8], ptr @.str94, i64 0, i64 0
  %t922 = load i64, ptr %t914
  %t923 = load ptr, ptr %t909
  call void (ptr, ...) @__c0c_emit(ptr %t920, ptr %t921, i64 %t922, ptr %t923)
  %t925 = load ptr, ptr %t0
  %t926 = getelementptr [32 x i8], ptr @.str95, i64 0, i64 0
  %t927 = load i64, ptr %t917
  %t928 = load i64, ptr %t914
  call void (ptr, ...) @__c0c_emit(ptr %t925, ptr %t926, i64 %t927, i64 %t928)
  %t930 = load ptr, ptr %t0
  %t931 = getelementptr [18 x i8], ptr @.str96, i64 0, i64 0
  %t932 = load i64, ptr %t869
  call void (ptr, ...) @__c0c_emit(ptr %t930, ptr %t931, i64 %t932)
  %t934 = load ptr, ptr %t0
  %t935 = getelementptr [6 x i8], ptr @.str97, i64 0, i64 0
  %t936 = load i64, ptr %t869
  call void (ptr, ...) @__c0c_emit(ptr %t934, ptr %t935, i64 %t936)
  %t938 = alloca i64
  %t939 = call i32 @new_reg(ptr %t0)
  %t940 = sext i32 %t939 to i64
  store i64 %t940, ptr %t938
  %t941 = load ptr, ptr %t0
  %t942 = getelementptr [50 x i8], ptr @.str98, i64 0, i64 0
  %t943 = load i64, ptr %t938
  %t944 = load i64, ptr %t863
  %t945 = load i64, ptr %t917
  %t946 = load i64, ptr %t866
  call void (ptr, ...) @__c0c_emit(ptr %t941, ptr %t942, i64 %t943, i64 %t944, i64 %t945, i64 %t946)
  %t948 = alloca ptr
  %t949 = load ptr, ptr %t948
  %t950 = getelementptr [6 x i8], ptr @.str99, i64 0, i64 0
  %t951 = load i64, ptr %t938
  %t952 = call i32 (ptr, ...) @snprintf(ptr %t949, i64 8, ptr %t950, i64 %t951)
  %t953 = sext i32 %t952 to i64
  %t954 = load ptr, ptr %t948
  %t955 = call ptr @default_i64_type()
  %t956 = call i64 @make_val(ptr %t954, ptr %t955)
  ret i64 %t956
L205:
  br label %L204
L204:
  %t957 = alloca i64
  %t958 = load ptr, ptr %t1
  %t959 = sext i32 0 to i64
  %t960 = getelementptr ptr, ptr %t958, i64 %t959
  %t961 = load ptr, ptr %t960
  %t962 = call i64 @emit_expr(ptr %t0, ptr %t961)
  store i64 %t962, ptr %t957
  %t963 = alloca i64
  %t964 = load ptr, ptr %t1
  %t965 = sext i32 1 to i64
  %t966 = getelementptr ptr, ptr %t964, i64 %t965
  %t967 = load ptr, ptr %t966
  %t968 = call i64 @emit_expr(ptr %t0, ptr %t967)
  store i64 %t968, ptr %t963
  %t969 = alloca i64
  %t970 = call i32 @new_reg(ptr %t0)
  %t971 = sext i32 %t970 to i64
  store i64 %t971, ptr %t969
  %t972 = alloca i64
  %t973 = load ptr, ptr %t957
  %t974 = call i32 @type_is_fp(ptr %t973)
  %t975 = sext i32 %t974 to i64
  %t976 = icmp ne i64 %t975, 0
  br i1 %t976, label %L206, label %L207
L206:
  br label %L208
L207:
  %t977 = load ptr, ptr %t963
  %t978 = call i32 @type_is_fp(ptr %t977)
  %t979 = sext i32 %t978 to i64
  %t980 = icmp ne i64 %t979, 0
  %t981 = zext i1 %t980 to i64
  br label %L208
L208:
  %t982 = phi i64 [ 1, %L206 ], [ %t981, %L207 ]
  store i64 %t982, ptr %t972
  %t983 = alloca i64
  %t984 = load i64, ptr %t957
  %t985 = call i32 @val_is_ptr(i64 %t984)
  %t986 = sext i32 %t985 to i64
  store i64 %t986, ptr %t983
  %t987 = alloca ptr
  %t988 = load i64, ptr %t972
  %t990 = sext i32 %t988 to i64
  %t989 = icmp ne i64 %t990, 0
  br i1 %t989, label %L209, label %L210
L209:
  %t991 = load ptr, ptr %t957
  %t992 = call ptr @llvm_type(ptr %t991)
  %t993 = ptrtoint ptr %t992 to i64
  br label %L211
L210:
  %t994 = getelementptr [4 x i8], ptr @.str100, i64 0, i64 0
  %t995 = ptrtoint ptr %t994 to i64
  br label %L211
L211:
  %t996 = phi i64 [ %t993, %L209 ], [ %t995, %L210 ]
  store i64 %t996, ptr %t987
  %t997 = alloca ptr
  %t998 = alloca ptr
  %t999 = load ptr, ptr %t997
  %t1001 = sext i32 0 to i64
  %t1000 = getelementptr ptr, ptr %t999, i64 %t1001
  %t1002 = sext i32 0 to i64
  store i64 %t1002, ptr %t1000
  %t1003 = load ptr, ptr %t998
  %t1005 = sext i32 0 to i64
  %t1004 = getelementptr ptr, ptr %t1003, i64 %t1005
  %t1006 = sext i32 0 to i64
  store i64 %t1006, ptr %t1004
  %t1007 = load i64, ptr %t972
  %t1009 = sext i32 %t1007 to i64
  %t1010 = icmp eq i64 %t1009, 0
  %t1008 = zext i1 %t1010 to i64
  %t1011 = icmp ne i64 %t1008, 0
  br i1 %t1011, label %L212, label %L213
L212:
  %t1012 = load i64, ptr %t957
  %t1013 = load ptr, ptr %t997
  %t1014 = call i32 @promote_to_i64(ptr %t0, i64 %t1012, ptr %t1013, i64 64)
  %t1015 = sext i32 %t1014 to i64
  %t1016 = load i64, ptr %t963
  %t1017 = load ptr, ptr %t998
  %t1018 = call i32 @promote_to_i64(ptr %t0, i64 %t1016, ptr %t1017, i64 64)
  %t1019 = sext i32 %t1018 to i64
  %t1020 = getelementptr [4 x i8], ptr @.str101, i64 0, i64 0
  store ptr %t1020, ptr %t987
  br label %L214
L213:
  %t1021 = load ptr, ptr %t997
  %t1022 = load ptr, ptr %t957
  %t1023 = call ptr @strncpy(ptr %t1021, ptr %t1022, i64 63)
  %t1024 = load ptr, ptr %t997
  %t1026 = sext i32 63 to i64
  %t1025 = getelementptr ptr, ptr %t1024, i64 %t1026
  %t1027 = sext i32 0 to i64
  store i64 %t1027, ptr %t1025
  %t1028 = load ptr, ptr %t998
  %t1029 = load ptr, ptr %t963
  %t1030 = call ptr @strncpy(ptr %t1028, ptr %t1029, i64 63)
  %t1031 = load ptr, ptr %t998
  %t1033 = sext i32 63 to i64
  %t1032 = getelementptr ptr, ptr %t1031, i64 %t1033
  %t1034 = sext i32 0 to i64
  store i64 %t1034, ptr %t1032
  br label %L214
L214:
  %t1035 = alloca ptr
  %t1037 = sext i32 0 to i64
  %t1036 = inttoptr i64 %t1037 to ptr
  store ptr %t1036, ptr %t1035
  %t1038 = alloca i64
  %t1039 = sext i32 0 to i64
  store i64 %t1039, ptr %t1038
  %t1040 = load ptr, ptr %t1
  %t1041 = ptrtoint ptr %t1040 to i64
  %t1042 = add i64 %t1041, 0
  switch i64 %t1042, label %L234 [
    i64 35, label %L216
    i64 36, label %L217
    i64 37, label %L218
    i64 38, label %L219
    i64 39, label %L220
    i64 40, label %L221
    i64 41, label %L222
    i64 42, label %L223
    i64 44, label %L224
    i64 45, label %L225
    i64 46, label %L226
    i64 47, label %L227
    i64 48, label %L228
    i64 49, label %L229
    i64 50, label %L230
    i64 51, label %L231
    i64 52, label %L232
    i64 53, label %L233
  ]
L216:
  %t1043 = load i64, ptr %t972
  %t1045 = sext i32 %t1043 to i64
  %t1044 = icmp ne i64 %t1045, 0
  br i1 %t1044, label %L235, label %L236
L235:
  %t1046 = getelementptr [5 x i8], ptr @.str102, i64 0, i64 0
  %t1047 = ptrtoint ptr %t1046 to i64
  br label %L237
L236:
  %t1048 = load i64, ptr %t983
  %t1050 = sext i32 %t1048 to i64
  %t1049 = icmp ne i64 %t1050, 0
  br i1 %t1049, label %L238, label %L239
L238:
  %t1051 = getelementptr [14 x i8], ptr @.str103, i64 0, i64 0
  %t1052 = ptrtoint ptr %t1051 to i64
  br label %L240
L239:
  %t1053 = getelementptr [4 x i8], ptr @.str104, i64 0, i64 0
  %t1054 = ptrtoint ptr %t1053 to i64
  br label %L240
L240:
  %t1055 = phi i64 [ %t1052, %L238 ], [ %t1054, %L239 ]
  br label %L237
L237:
  %t1056 = phi i64 [ %t1047, %L235 ], [ %t1055, %L236 ]
  store i64 %t1056, ptr %t1035
  br label %L215
L241:
  br label %L217
L217:
  %t1057 = load i64, ptr %t972
  %t1059 = sext i32 %t1057 to i64
  %t1058 = icmp ne i64 %t1059, 0
  br i1 %t1058, label %L242, label %L243
L242:
  %t1060 = getelementptr [5 x i8], ptr @.str105, i64 0, i64 0
  %t1061 = ptrtoint ptr %t1060 to i64
  br label %L244
L243:
  %t1062 = getelementptr [4 x i8], ptr @.str106, i64 0, i64 0
  %t1063 = ptrtoint ptr %t1062 to i64
  br label %L244
L244:
  %t1064 = phi i64 [ %t1061, %L242 ], [ %t1063, %L243 ]
  store i64 %t1064, ptr %t1035
  br label %L215
L245:
  br label %L218
L218:
  %t1065 = load i64, ptr %t972
  %t1067 = sext i32 %t1065 to i64
  %t1066 = icmp ne i64 %t1067, 0
  br i1 %t1066, label %L246, label %L247
L246:
  %t1068 = getelementptr [5 x i8], ptr @.str107, i64 0, i64 0
  %t1069 = ptrtoint ptr %t1068 to i64
  br label %L248
L247:
  %t1070 = getelementptr [4 x i8], ptr @.str108, i64 0, i64 0
  %t1071 = ptrtoint ptr %t1070 to i64
  br label %L248
L248:
  %t1072 = phi i64 [ %t1069, %L246 ], [ %t1071, %L247 ]
  store i64 %t1072, ptr %t1035
  br label %L215
L249:
  br label %L219
L219:
  %t1073 = load i64, ptr %t972
  %t1075 = sext i32 %t1073 to i64
  %t1074 = icmp ne i64 %t1075, 0
  br i1 %t1074, label %L250, label %L251
L250:
  %t1076 = getelementptr [5 x i8], ptr @.str109, i64 0, i64 0
  %t1077 = ptrtoint ptr %t1076 to i64
  br label %L252
L251:
  %t1078 = getelementptr [5 x i8], ptr @.str110, i64 0, i64 0
  %t1079 = ptrtoint ptr %t1078 to i64
  br label %L252
L252:
  %t1080 = phi i64 [ %t1077, %L250 ], [ %t1079, %L251 ]
  store i64 %t1080, ptr %t1035
  br label %L215
L253:
  br label %L220
L220:
  %t1081 = load i64, ptr %t972
  %t1083 = sext i32 %t1081 to i64
  %t1082 = icmp ne i64 %t1083, 0
  br i1 %t1082, label %L254, label %L255
L254:
  %t1084 = getelementptr [5 x i8], ptr @.str111, i64 0, i64 0
  %t1085 = ptrtoint ptr %t1084 to i64
  br label %L256
L255:
  %t1086 = getelementptr [5 x i8], ptr @.str112, i64 0, i64 0
  %t1087 = ptrtoint ptr %t1086 to i64
  br label %L256
L256:
  %t1088 = phi i64 [ %t1085, %L254 ], [ %t1087, %L255 ]
  store i64 %t1088, ptr %t1035
  br label %L215
L257:
  br label %L221
L221:
  %t1089 = getelementptr [4 x i8], ptr @.str113, i64 0, i64 0
  store ptr %t1089, ptr %t1035
  br label %L215
L258:
  br label %L222
L222:
  %t1090 = getelementptr [3 x i8], ptr @.str114, i64 0, i64 0
  store ptr %t1090, ptr %t1035
  br label %L215
L259:
  br label %L223
L223:
  %t1091 = getelementptr [4 x i8], ptr @.str115, i64 0, i64 0
  store ptr %t1091, ptr %t1035
  br label %L215
L260:
  br label %L224
L224:
  %t1092 = getelementptr [4 x i8], ptr @.str116, i64 0, i64 0
  store ptr %t1092, ptr %t1035
  br label %L215
L261:
  br label %L225
L225:
  %t1093 = getelementptr [5 x i8], ptr @.str117, i64 0, i64 0
  store ptr %t1093, ptr %t1035
  br label %L215
L262:
  br label %L226
L226:
  %t1094 = load i64, ptr %t972
  %t1096 = sext i32 %t1094 to i64
  %t1095 = icmp ne i64 %t1096, 0
  br i1 %t1095, label %L263, label %L264
L263:
  %t1097 = getelementptr [9 x i8], ptr @.str118, i64 0, i64 0
  %t1098 = ptrtoint ptr %t1097 to i64
  br label %L265
L264:
  %t1099 = getelementptr [8 x i8], ptr @.str119, i64 0, i64 0
  %t1100 = ptrtoint ptr %t1099 to i64
  br label %L265
L265:
  %t1101 = phi i64 [ %t1098, %L263 ], [ %t1100, %L264 ]
  store i64 %t1101, ptr %t1035
  %t1102 = sext i32 1 to i64
  store i64 %t1102, ptr %t1038
  br label %L215
L266:
  br label %L227
L227:
  %t1103 = load i64, ptr %t972
  %t1105 = sext i32 %t1103 to i64
  %t1104 = icmp ne i64 %t1105, 0
  br i1 %t1104, label %L267, label %L268
L267:
  %t1106 = getelementptr [9 x i8], ptr @.str120, i64 0, i64 0
  %t1107 = ptrtoint ptr %t1106 to i64
  br label %L269
L268:
  %t1108 = getelementptr [8 x i8], ptr @.str121, i64 0, i64 0
  %t1109 = ptrtoint ptr %t1108 to i64
  br label %L269
L269:
  %t1110 = phi i64 [ %t1107, %L267 ], [ %t1109, %L268 ]
  store i64 %t1110, ptr %t1035
  %t1111 = sext i32 1 to i64
  store i64 %t1111, ptr %t1038
  br label %L215
L270:
  br label %L228
L228:
  %t1112 = load i64, ptr %t972
  %t1114 = sext i32 %t1112 to i64
  %t1113 = icmp ne i64 %t1114, 0
  br i1 %t1113, label %L271, label %L272
L271:
  %t1115 = getelementptr [9 x i8], ptr @.str122, i64 0, i64 0
  %t1116 = ptrtoint ptr %t1115 to i64
  br label %L273
L272:
  %t1117 = getelementptr [9 x i8], ptr @.str123, i64 0, i64 0
  %t1118 = ptrtoint ptr %t1117 to i64
  br label %L273
L273:
  %t1119 = phi i64 [ %t1116, %L271 ], [ %t1118, %L272 ]
  store i64 %t1119, ptr %t1035
  %t1120 = sext i32 1 to i64
  store i64 %t1120, ptr %t1038
  br label %L215
L274:
  br label %L229
L229:
  %t1121 = load i64, ptr %t972
  %t1123 = sext i32 %t1121 to i64
  %t1122 = icmp ne i64 %t1123, 0
  br i1 %t1122, label %L275, label %L276
L275:
  %t1124 = getelementptr [9 x i8], ptr @.str124, i64 0, i64 0
  %t1125 = ptrtoint ptr %t1124 to i64
  br label %L277
L276:
  %t1126 = getelementptr [9 x i8], ptr @.str125, i64 0, i64 0
  %t1127 = ptrtoint ptr %t1126 to i64
  br label %L277
L277:
  %t1128 = phi i64 [ %t1125, %L275 ], [ %t1127, %L276 ]
  store i64 %t1128, ptr %t1035
  %t1129 = sext i32 1 to i64
  store i64 %t1129, ptr %t1038
  br label %L215
L278:
  br label %L230
L230:
  %t1130 = load i64, ptr %t972
  %t1132 = sext i32 %t1130 to i64
  %t1131 = icmp ne i64 %t1132, 0
  br i1 %t1131, label %L279, label %L280
L279:
  %t1133 = getelementptr [9 x i8], ptr @.str126, i64 0, i64 0
  %t1134 = ptrtoint ptr %t1133 to i64
  br label %L281
L280:
  %t1135 = getelementptr [9 x i8], ptr @.str127, i64 0, i64 0
  %t1136 = ptrtoint ptr %t1135 to i64
  br label %L281
L281:
  %t1137 = phi i64 [ %t1134, %L279 ], [ %t1136, %L280 ]
  store i64 %t1137, ptr %t1035
  %t1138 = sext i32 1 to i64
  store i64 %t1138, ptr %t1038
  br label %L215
L282:
  br label %L231
L231:
  %t1139 = load i64, ptr %t972
  %t1141 = sext i32 %t1139 to i64
  %t1140 = icmp ne i64 %t1141, 0
  br i1 %t1140, label %L283, label %L284
L283:
  %t1142 = getelementptr [9 x i8], ptr @.str128, i64 0, i64 0
  %t1143 = ptrtoint ptr %t1142 to i64
  br label %L285
L284:
  %t1144 = getelementptr [9 x i8], ptr @.str129, i64 0, i64 0
  %t1145 = ptrtoint ptr %t1144 to i64
  br label %L285
L285:
  %t1146 = phi i64 [ %t1143, %L283 ], [ %t1145, %L284 ]
  store i64 %t1146, ptr %t1035
  %t1147 = sext i32 1 to i64
  store i64 %t1147, ptr %t1038
  br label %L215
L286:
  br label %L232
L232:
  br label %L233
L233:
  %t1148 = getelementptr [4 x i8], ptr @.str130, i64 0, i64 0
  store ptr %t1148, ptr %t1035
  br label %L215
L287:
  br label %L215
L234:
  %t1149 = getelementptr [4 x i8], ptr @.str131, i64 0, i64 0
  store ptr %t1149, ptr %t1035
  br label %L215
L215:
  %t1150 = load ptr, ptr %t1
  %t1152 = ptrtoint ptr %t1150 to i64
  %t1153 = sext i32 35 to i64
  %t1151 = icmp eq i64 %t1152, %t1153
  %t1154 = zext i1 %t1151 to i64
  %t1155 = icmp ne i64 %t1154, 0
  br i1 %t1155, label %L288, label %L289
L288:
  %t1156 = load i64, ptr %t983
  %t1157 = sext i32 %t1156 to i64
  %t1158 = icmp ne i64 %t1157, 0
  %t1159 = zext i1 %t1158 to i64
  br label %L290
L289:
  br label %L290
L290:
  %t1160 = phi i64 [ %t1159, %L288 ], [ 0, %L289 ]
  %t1161 = icmp ne i64 %t1160, 0
  br i1 %t1161, label %L291, label %L292
L291:
  %t1162 = alloca i64
  %t1163 = call i32 @new_reg(ptr %t0)
  %t1164 = sext i32 %t1163 to i64
  store i64 %t1164, ptr %t1162
  %t1165 = load ptr, ptr %t0
  %t1166 = getelementptr [34 x i8], ptr @.str132, i64 0, i64 0
  %t1167 = load i64, ptr %t1162
  %t1168 = load ptr, ptr %t997
  call void (ptr, ...) @__c0c_emit(ptr %t1165, ptr %t1166, i64 %t1167, ptr %t1168)
  %t1170 = load ptr, ptr %t0
  %t1171 = getelementptr [47 x i8], ptr @.str133, i64 0, i64 0
  %t1172 = load i64, ptr %t969
  %t1173 = load i64, ptr %t1162
  %t1174 = load ptr, ptr %t998
  call void (ptr, ...) @__c0c_emit(ptr %t1170, ptr %t1171, i64 %t1172, i64 %t1173, ptr %t1174)
  br label %L293
L292:
  %t1176 = load i64, ptr %t1038
  %t1178 = sext i32 %t1176 to i64
  %t1177 = icmp ne i64 %t1178, 0
  br i1 %t1177, label %L294, label %L295
L294:
  %t1179 = load ptr, ptr %t0
  %t1180 = getelementptr [24 x i8], ptr @.str134, i64 0, i64 0
  %t1181 = load i64, ptr %t969
  %t1182 = load ptr, ptr %t1035
  %t1183 = load ptr, ptr %t987
  %t1184 = load ptr, ptr %t997
  %t1185 = load ptr, ptr %t998
  call void (ptr, ...) @__c0c_emit(ptr %t1179, ptr %t1180, i64 %t1181, ptr %t1182, ptr %t1183, ptr %t1184, ptr %t1185)
  %t1187 = alloca i64
  %t1188 = call i32 @new_reg(ptr %t0)
  %t1189 = sext i32 %t1188 to i64
  store i64 %t1189, ptr %t1187
  %t1190 = load ptr, ptr %t0
  %t1191 = getelementptr [32 x i8], ptr @.str135, i64 0, i64 0
  %t1192 = load i64, ptr %t1187
  %t1193 = load i64, ptr %t969
  call void (ptr, ...) @__c0c_emit(ptr %t1190, ptr %t1191, i64 %t1192, i64 %t1193)
  %t1195 = alloca ptr
  %t1196 = load ptr, ptr %t1195
  %t1197 = getelementptr [6 x i8], ptr @.str136, i64 0, i64 0
  %t1198 = load i64, ptr %t1187
  %t1199 = call i32 (ptr, ...) @snprintf(ptr %t1196, i64 8, ptr %t1197, i64 %t1198)
  %t1200 = sext i32 %t1199 to i64
  %t1201 = load ptr, ptr %t1195
  %t1202 = call ptr @default_i64_type()
  %t1203 = call i64 @make_val(ptr %t1201, ptr %t1202)
  ret i64 %t1203
L297:
  br label %L296
L295:
  %t1204 = load ptr, ptr %t0
  %t1205 = getelementptr [24 x i8], ptr @.str137, i64 0, i64 0
  %t1206 = load i64, ptr %t969
  %t1207 = load ptr, ptr %t1035
  %t1208 = load ptr, ptr %t987
  %t1209 = load ptr, ptr %t997
  %t1210 = load ptr, ptr %t998
  call void (ptr, ...) @__c0c_emit(ptr %t1204, ptr %t1205, i64 %t1206, ptr %t1207, ptr %t1208, ptr %t1209, ptr %t1210)
  br label %L296
L296:
  br label %L293
L293:
  %t1212 = alloca ptr
  %t1213 = load ptr, ptr %t1212
  %t1214 = getelementptr [6 x i8], ptr @.str138, i64 0, i64 0
  %t1215 = load i64, ptr %t969
  %t1216 = call i32 (ptr, ...) @snprintf(ptr %t1213, i64 8, ptr %t1214, i64 %t1215)
  %t1217 = sext i32 %t1216 to i64
  %t1218 = load ptr, ptr %t1
  %t1220 = ptrtoint ptr %t1218 to i64
  %t1221 = sext i32 35 to i64
  %t1219 = icmp eq i64 %t1220, %t1221
  %t1222 = zext i1 %t1219 to i64
  %t1223 = icmp ne i64 %t1222, 0
  br i1 %t1223, label %L298, label %L299
L298:
  %t1224 = load i64, ptr %t983
  %t1225 = sext i32 %t1224 to i64
  %t1226 = icmp ne i64 %t1225, 0
  %t1227 = zext i1 %t1226 to i64
  br label %L300
L299:
  br label %L300
L300:
  %t1228 = phi i64 [ %t1227, %L298 ], [ 0, %L299 ]
  %t1229 = icmp ne i64 %t1228, 0
  br i1 %t1229, label %L301, label %L303
L301:
  %t1230 = load ptr, ptr %t1212
  %t1231 = call ptr @default_ptr_type()
  %t1232 = call i64 @make_val(ptr %t1230, ptr %t1231)
  ret i64 %t1232
L304:
  br label %L303
L303:
  %t1233 = load i64, ptr %t983
  %t1235 = sext i32 %t1233 to i64
  %t1234 = icmp ne i64 %t1235, 0
  br i1 %t1234, label %L305, label %L307
L305:
  %t1236 = load ptr, ptr %t1212
  %t1237 = call ptr @default_i64_type()
  %t1238 = call i64 @make_val(ptr %t1236, ptr %t1237)
  ret i64 %t1238
L308:
  br label %L307
L307:
  %t1239 = load ptr, ptr %t1212
  %t1240 = call ptr @default_i64_type()
  %t1241 = call i64 @make_val(ptr %t1239, ptr %t1240)
  ret i64 %t1241
L309:
  br label %L12
L12:
  %t1242 = alloca i64
  %t1243 = load ptr, ptr %t1
  %t1244 = sext i32 0 to i64
  %t1245 = getelementptr ptr, ptr %t1243, i64 %t1244
  %t1246 = load ptr, ptr %t1245
  %t1247 = call i64 @emit_expr(ptr %t0, ptr %t1246)
  store i64 %t1247, ptr %t1242
  %t1248 = alloca i64
  %t1249 = call i32 @new_reg(ptr %t0)
  %t1250 = sext i32 %t1249 to i64
  store i64 %t1250, ptr %t1248
  %t1251 = alloca i64
  %t1252 = load ptr, ptr %t1242
  %t1253 = call i32 @type_is_fp(ptr %t1252)
  %t1254 = sext i32 %t1253 to i64
  store i64 %t1254, ptr %t1251
  %t1255 = alloca ptr
  %t1256 = load i64, ptr %t1251
  %t1258 = sext i32 %t1256 to i64
  %t1259 = icmp eq i64 %t1258, 0
  %t1257 = zext i1 %t1259 to i64
  %t1260 = icmp ne i64 %t1257, 0
  br i1 %t1260, label %L310, label %L312
L310:
  %t1261 = load i64, ptr %t1242
  %t1262 = load ptr, ptr %t1255
  %t1263 = call i32 @promote_to_i64(ptr %t0, i64 %t1261, ptr %t1262, i64 64)
  %t1264 = sext i32 %t1263 to i64
  br label %L312
L312:
  %t1265 = load ptr, ptr %t1
  %t1266 = ptrtoint ptr %t1265 to i64
  %t1267 = add i64 %t1266, 0
  switch i64 %t1267, label %L318 [
    i64 36, label %L314
    i64 54, label %L315
    i64 43, label %L316
    i64 35, label %L317
  ]
L314:
  %t1268 = load i64, ptr %t1251
  %t1270 = sext i32 %t1268 to i64
  %t1269 = icmp ne i64 %t1270, 0
  br i1 %t1269, label %L319, label %L320
L319:
  %t1271 = load ptr, ptr %t0
  %t1272 = getelementptr [26 x i8], ptr @.str139, i64 0, i64 0
  %t1273 = load i64, ptr %t1248
  %t1274 = load ptr, ptr %t1242
  call void (ptr, ...) @__c0c_emit(ptr %t1271, ptr %t1272, i64 %t1273, ptr %t1274)
  br label %L321
L320:
  %t1276 = load ptr, ptr %t0
  %t1277 = getelementptr [25 x i8], ptr @.str140, i64 0, i64 0
  %t1278 = load i64, ptr %t1248
  %t1279 = load ptr, ptr %t1255
  call void (ptr, ...) @__c0c_emit(ptr %t1276, ptr %t1277, i64 %t1278, ptr %t1279)
  br label %L321
L321:
  br label %L313
L322:
  br label %L315
L315:
  %t1281 = alloca i64
  %t1282 = call i32 @new_reg(ptr %t0)
  %t1283 = sext i32 %t1282 to i64
  store i64 %t1283, ptr %t1281
  %t1284 = load ptr, ptr %t0
  %t1285 = getelementptr [29 x i8], ptr @.str141, i64 0, i64 0
  %t1286 = load i64, ptr %t1281
  %t1287 = load ptr, ptr %t1255
  call void (ptr, ...) @__c0c_emit(ptr %t1284, ptr %t1285, i64 %t1286, ptr %t1287)
  %t1289 = load ptr, ptr %t0
  %t1290 = getelementptr [32 x i8], ptr @.str142, i64 0, i64 0
  %t1291 = load i64, ptr %t1248
  %t1292 = load i64, ptr %t1281
  call void (ptr, ...) @__c0c_emit(ptr %t1289, ptr %t1290, i64 %t1291, i64 %t1292)
  br label %L313
L323:
  br label %L316
L316:
  %t1294 = load ptr, ptr %t0
  %t1295 = getelementptr [26 x i8], ptr @.str143, i64 0, i64 0
  %t1296 = load i64, ptr %t1248
  %t1297 = load ptr, ptr %t1255
  call void (ptr, ...) @__c0c_emit(ptr %t1294, ptr %t1295, i64 %t1296, ptr %t1297)
  br label %L313
L324:
  br label %L317
L317:
  %t1299 = load i64, ptr %t1242
  %t1300 = sext i32 %t1299 to i64
  ret i64 %t1300
L325:
  br label %L313
L318:
  %t1301 = load ptr, ptr %t0
  %t1302 = getelementptr [25 x i8], ptr @.str144, i64 0, i64 0
  %t1303 = load i64, ptr %t1248
  %t1304 = load ptr, ptr %t1255
  call void (ptr, ...) @__c0c_emit(ptr %t1301, ptr %t1302, i64 %t1303, ptr %t1304)
  br label %L313
L313:
  %t1306 = alloca ptr
  %t1307 = load ptr, ptr %t1306
  %t1308 = getelementptr [6 x i8], ptr @.str145, i64 0, i64 0
  %t1309 = load i64, ptr %t1248
  %t1310 = call i32 (ptr, ...) @snprintf(ptr %t1307, i64 8, ptr %t1308, i64 %t1309)
  %t1311 = sext i32 %t1310 to i64
  %t1312 = load ptr, ptr %t1306
  %t1313 = load i64, ptr %t1251
  %t1315 = sext i32 %t1313 to i64
  %t1314 = icmp ne i64 %t1315, 0
  br i1 %t1314, label %L326, label %L327
L326:
  %t1316 = load ptr, ptr %t1242
  %t1317 = ptrtoint ptr %t1316 to i64
  br label %L328
L327:
  %t1318 = call ptr @default_i64_type()
  %t1319 = ptrtoint ptr %t1318 to i64
  br label %L328
L328:
  %t1320 = phi i64 [ %t1317, %L326 ], [ %t1319, %L327 ]
  %t1321 = call i64 @make_val(ptr %t1312, i64 %t1320)
  ret i64 %t1321
L329:
  br label %L13
L13:
  %t1322 = alloca i64
  %t1323 = load ptr, ptr %t1
  %t1324 = sext i32 1 to i64
  %t1325 = getelementptr ptr, ptr %t1323, i64 %t1324
  %t1326 = load ptr, ptr %t1325
  %t1327 = call i64 @emit_expr(ptr %t0, ptr %t1326)
  store i64 %t1327, ptr %t1322
  %t1328 = alloca ptr
  %t1329 = load ptr, ptr %t1
  %t1330 = sext i32 0 to i64
  %t1331 = getelementptr ptr, ptr %t1329, i64 %t1330
  %t1332 = load ptr, ptr %t1331
  %t1333 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1332)
  store ptr %t1333, ptr %t1328
  %t1334 = load ptr, ptr %t1328
  %t1335 = icmp ne ptr %t1334, null
  br i1 %t1335, label %L330, label %L332
L330:
  %t1336 = alloca ptr
  %t1337 = load i64, ptr %t1322
  %t1338 = call i32 @val_is_ptr(i64 %t1337)
  %t1339 = sext i32 %t1338 to i64
  %t1340 = icmp ne i64 %t1339, 0
  br i1 %t1340, label %L333, label %L334
L333:
  %t1341 = getelementptr [4 x i8], ptr @.str146, i64 0, i64 0
  store ptr %t1341, ptr %t1336
  br label %L335
L334:
  %t1342 = load ptr, ptr %t1322
  %t1343 = call i32 @type_is_fp(ptr %t1342)
  %t1344 = sext i32 %t1343 to i64
  %t1345 = icmp ne i64 %t1344, 0
  br i1 %t1345, label %L336, label %L337
L336:
  %t1346 = load ptr, ptr %t1322
  %t1347 = call ptr @llvm_type(ptr %t1346)
  store ptr %t1347, ptr %t1336
  br label %L338
L337:
  %t1348 = getelementptr [4 x i8], ptr @.str147, i64 0, i64 0
  store ptr %t1348, ptr %t1336
  br label %L338
L338:
  br label %L335
L335:
  %t1349 = alloca ptr
  %t1350 = load i64, ptr %t1322
  %t1351 = call i32 @val_is_ptr(i64 %t1350)
  %t1352 = sext i32 %t1351 to i64
  %t1354 = icmp eq i64 %t1352, 0
  %t1353 = zext i1 %t1354 to i64
  %t1355 = icmp ne i64 %t1353, 0
  br i1 %t1355, label %L339, label %L340
L339:
  %t1356 = load i64, ptr %t1322
  %t1357 = call i32 @val_is_64bit(i64 %t1356)
  %t1358 = sext i32 %t1357 to i64
  %t1360 = icmp eq i64 %t1358, 0
  %t1359 = zext i1 %t1360 to i64
  %t1361 = icmp ne i64 %t1359, 0
  %t1362 = zext i1 %t1361 to i64
  br label %L341
L340:
  br label %L341
L341:
  %t1363 = phi i64 [ %t1362, %L339 ], [ 0, %L340 ]
  %t1364 = icmp ne i64 %t1363, 0
  br i1 %t1364, label %L342, label %L343
L342:
  %t1365 = load ptr, ptr %t1322
  %t1366 = call i32 @type_is_fp(ptr %t1365)
  %t1367 = sext i32 %t1366 to i64
  %t1369 = icmp eq i64 %t1367, 0
  %t1368 = zext i1 %t1369 to i64
  %t1370 = icmp ne i64 %t1368, 0
  %t1371 = zext i1 %t1370 to i64
  br label %L344
L343:
  br label %L344
L344:
  %t1372 = phi i64 [ %t1371, %L342 ], [ 0, %L343 ]
  %t1373 = icmp ne i64 %t1372, 0
  br i1 %t1373, label %L345, label %L346
L345:
  %t1374 = alloca i64
  %t1375 = call i32 @new_reg(ptr %t0)
  %t1376 = sext i32 %t1375 to i64
  store i64 %t1376, ptr %t1374
  %t1377 = load ptr, ptr %t0
  %t1378 = getelementptr [30 x i8], ptr @.str148, i64 0, i64 0
  %t1379 = load i64, ptr %t1374
  %t1380 = load ptr, ptr %t1322
  call void (ptr, ...) @__c0c_emit(ptr %t1377, ptr %t1378, i64 %t1379, ptr %t1380)
  %t1382 = load ptr, ptr %t1349
  %t1383 = getelementptr [6 x i8], ptr @.str149, i64 0, i64 0
  %t1384 = load i64, ptr %t1374
  %t1385 = call i32 (ptr, ...) @snprintf(ptr %t1382, i64 64, ptr %t1383, i64 %t1384)
  %t1386 = sext i32 %t1385 to i64
  br label %L347
L346:
  %t1387 = load ptr, ptr %t1349
  %t1388 = load ptr, ptr %t1322
  %t1389 = call ptr @strncpy(ptr %t1387, ptr %t1388, i64 63)
  %t1390 = load ptr, ptr %t1349
  %t1392 = sext i32 63 to i64
  %t1391 = getelementptr ptr, ptr %t1390, i64 %t1392
  %t1393 = sext i32 0 to i64
  store i64 %t1393, ptr %t1391
  br label %L347
L347:
  %t1394 = load ptr, ptr %t0
  %t1395 = getelementptr [23 x i8], ptr @.str150, i64 0, i64 0
  %t1396 = load ptr, ptr %t1336
  %t1397 = load ptr, ptr %t1349
  %t1398 = load ptr, ptr %t1328
  call void (ptr, ...) @__c0c_emit(ptr %t1394, ptr %t1395, ptr %t1396, ptr %t1397, ptr %t1398)
  %t1400 = load ptr, ptr %t1328
  call void @free(ptr %t1400)
  br label %L332
L332:
  %t1402 = load i64, ptr %t1322
  %t1403 = sext i32 %t1402 to i64
  ret i64 %t1403
L348:
  br label %L14
L14:
  %t1404 = alloca i64
  %t1405 = load ptr, ptr %t1
  %t1406 = sext i32 0 to i64
  %t1407 = getelementptr ptr, ptr %t1405, i64 %t1406
  %t1408 = load ptr, ptr %t1407
  %t1409 = call i64 @emit_expr(ptr %t0, ptr %t1408)
  store i64 %t1409, ptr %t1404
  %t1410 = alloca i64
  %t1411 = load ptr, ptr %t1
  %t1412 = sext i32 1 to i64
  %t1413 = getelementptr ptr, ptr %t1411, i64 %t1412
  %t1414 = load ptr, ptr %t1413
  %t1415 = call i64 @emit_expr(ptr %t0, ptr %t1414)
  store i64 %t1415, ptr %t1410
  %t1416 = alloca i64
  %t1417 = call i32 @new_reg(ptr %t0)
  %t1418 = sext i32 %t1417 to i64
  store i64 %t1418, ptr %t1416
  %t1419 = alloca i64
  %t1420 = load ptr, ptr %t1404
  %t1421 = call i32 @type_is_fp(ptr %t1420)
  %t1422 = sext i32 %t1421 to i64
  %t1423 = icmp ne i64 %t1422, 0
  br i1 %t1423, label %L349, label %L350
L349:
  br label %L351
L350:
  %t1424 = load ptr, ptr %t1410
  %t1425 = call i32 @type_is_fp(ptr %t1424)
  %t1426 = sext i32 %t1425 to i64
  %t1427 = icmp ne i64 %t1426, 0
  %t1428 = zext i1 %t1427 to i64
  br label %L351
L351:
  %t1429 = phi i64 [ 1, %L349 ], [ %t1428, %L350 ]
  store i64 %t1429, ptr %t1419
  %t1430 = alloca ptr
  %t1431 = load i64, ptr %t1419
  %t1433 = sext i32 %t1431 to i64
  %t1432 = icmp ne i64 %t1433, 0
  br i1 %t1432, label %L352, label %L353
L352:
  %t1434 = getelementptr [7 x i8], ptr @.str151, i64 0, i64 0
  %t1435 = ptrtoint ptr %t1434 to i64
  br label %L354
L353:
  %t1436 = getelementptr [4 x i8], ptr @.str152, i64 0, i64 0
  %t1437 = ptrtoint ptr %t1436 to i64
  br label %L354
L354:
  %t1438 = phi i64 [ %t1435, %L352 ], [ %t1437, %L353 ]
  store i64 %t1438, ptr %t1430
  %t1439 = alloca ptr
  %t1440 = alloca ptr
  %t1441 = load i64, ptr %t1419
  %t1443 = sext i32 %t1441 to i64
  %t1444 = icmp eq i64 %t1443, 0
  %t1442 = zext i1 %t1444 to i64
  %t1445 = icmp ne i64 %t1442, 0
  br i1 %t1445, label %L355, label %L356
L355:
  %t1446 = load i64, ptr %t1404
  %t1447 = load ptr, ptr %t1439
  %t1448 = call i32 @promote_to_i64(ptr %t0, i64 %t1446, ptr %t1447, i64 64)
  %t1449 = sext i32 %t1448 to i64
  %t1450 = load i64, ptr %t1410
  %t1451 = load ptr, ptr %t1440
  %t1452 = call i32 @promote_to_i64(ptr %t0, i64 %t1450, ptr %t1451, i64 64)
  %t1453 = sext i32 %t1452 to i64
  br label %L357
L356:
  %t1454 = load ptr, ptr %t1439
  %t1455 = load ptr, ptr %t1404
  %t1456 = call ptr @strncpy(ptr %t1454, ptr %t1455, i64 63)
  %t1457 = load ptr, ptr %t1439
  %t1459 = sext i32 63 to i64
  %t1458 = getelementptr ptr, ptr %t1457, i64 %t1459
  %t1460 = sext i32 0 to i64
  store i64 %t1460, ptr %t1458
  %t1461 = load ptr, ptr %t1440
  %t1462 = load ptr, ptr %t1410
  %t1463 = call ptr @strncpy(ptr %t1461, ptr %t1462, i64 63)
  %t1464 = load ptr, ptr %t1440
  %t1466 = sext i32 63 to i64
  %t1465 = getelementptr ptr, ptr %t1464, i64 %t1466
  %t1467 = sext i32 0 to i64
  store i64 %t1467, ptr %t1465
  br label %L357
L357:
  %t1468 = alloca ptr
  %t1469 = load ptr, ptr %t1
  %t1470 = ptrtoint ptr %t1469 to i64
  %t1471 = add i64 %t1470, 0
  switch i64 %t1471, label %L369 [
    i64 56, label %L359
    i64 57, label %L360
    i64 58, label %L361
    i64 59, label %L362
    i64 65, label %L363
    i64 60, label %L364
    i64 61, label %L365
    i64 62, label %L366
    i64 63, label %L367
    i64 64, label %L368
  ]
L359:
  %t1472 = load i64, ptr %t1419
  %t1474 = sext i32 %t1472 to i64
  %t1473 = icmp ne i64 %t1474, 0
  br i1 %t1473, label %L370, label %L371
L370:
  %t1475 = getelementptr [5 x i8], ptr @.str153, i64 0, i64 0
  %t1476 = ptrtoint ptr %t1475 to i64
  br label %L372
L371:
  %t1477 = getelementptr [4 x i8], ptr @.str154, i64 0, i64 0
  %t1478 = ptrtoint ptr %t1477 to i64
  br label %L372
L372:
  %t1479 = phi i64 [ %t1476, %L370 ], [ %t1478, %L371 ]
  store i64 %t1479, ptr %t1468
  br label %L358
L373:
  br label %L360
L360:
  %t1480 = load i64, ptr %t1419
  %t1482 = sext i32 %t1480 to i64
  %t1481 = icmp ne i64 %t1482, 0
  br i1 %t1481, label %L374, label %L375
L374:
  %t1483 = getelementptr [5 x i8], ptr @.str155, i64 0, i64 0
  %t1484 = ptrtoint ptr %t1483 to i64
  br label %L376
L375:
  %t1485 = getelementptr [4 x i8], ptr @.str156, i64 0, i64 0
  %t1486 = ptrtoint ptr %t1485 to i64
  br label %L376
L376:
  %t1487 = phi i64 [ %t1484, %L374 ], [ %t1486, %L375 ]
  store i64 %t1487, ptr %t1468
  br label %L358
L377:
  br label %L361
L361:
  %t1488 = load i64, ptr %t1419
  %t1490 = sext i32 %t1488 to i64
  %t1489 = icmp ne i64 %t1490, 0
  br i1 %t1489, label %L378, label %L379
L378:
  %t1491 = getelementptr [5 x i8], ptr @.str157, i64 0, i64 0
  %t1492 = ptrtoint ptr %t1491 to i64
  br label %L380
L379:
  %t1493 = getelementptr [4 x i8], ptr @.str158, i64 0, i64 0
  %t1494 = ptrtoint ptr %t1493 to i64
  br label %L380
L380:
  %t1495 = phi i64 [ %t1492, %L378 ], [ %t1494, %L379 ]
  store i64 %t1495, ptr %t1468
  br label %L358
L381:
  br label %L362
L362:
  %t1496 = load i64, ptr %t1419
  %t1498 = sext i32 %t1496 to i64
  %t1497 = icmp ne i64 %t1498, 0
  br i1 %t1497, label %L382, label %L383
L382:
  %t1499 = getelementptr [5 x i8], ptr @.str159, i64 0, i64 0
  %t1500 = ptrtoint ptr %t1499 to i64
  br label %L384
L383:
  %t1501 = getelementptr [5 x i8], ptr @.str160, i64 0, i64 0
  %t1502 = ptrtoint ptr %t1501 to i64
  br label %L384
L384:
  %t1503 = phi i64 [ %t1500, %L382 ], [ %t1502, %L383 ]
  store i64 %t1503, ptr %t1468
  br label %L358
L385:
  br label %L363
L363:
  %t1504 = getelementptr [5 x i8], ptr @.str161, i64 0, i64 0
  store ptr %t1504, ptr %t1468
  br label %L358
L386:
  br label %L364
L364:
  %t1505 = getelementptr [4 x i8], ptr @.str162, i64 0, i64 0
  store ptr %t1505, ptr %t1468
  br label %L358
L387:
  br label %L365
L365:
  %t1506 = getelementptr [3 x i8], ptr @.str163, i64 0, i64 0
  store ptr %t1506, ptr %t1468
  br label %L358
L388:
  br label %L366
L366:
  %t1507 = getelementptr [4 x i8], ptr @.str164, i64 0, i64 0
  store ptr %t1507, ptr %t1468
  br label %L358
L389:
  br label %L367
L367:
  %t1508 = getelementptr [4 x i8], ptr @.str165, i64 0, i64 0
  store ptr %t1508, ptr %t1468
  br label %L358
L390:
  br label %L368
L368:
  %t1509 = getelementptr [5 x i8], ptr @.str166, i64 0, i64 0
  store ptr %t1509, ptr %t1468
  br label %L358
L391:
  br label %L358
L369:
  %t1510 = getelementptr [4 x i8], ptr @.str167, i64 0, i64 0
  store ptr %t1510, ptr %t1468
  br label %L358
L358:
  %t1511 = load ptr, ptr %t0
  %t1512 = getelementptr [24 x i8], ptr @.str168, i64 0, i64 0
  %t1513 = load i64, ptr %t1416
  %t1514 = load ptr, ptr %t1468
  %t1515 = load ptr, ptr %t1430
  %t1516 = load ptr, ptr %t1439
  %t1517 = load ptr, ptr %t1440
  call void (ptr, ...) @__c0c_emit(ptr %t1511, ptr %t1512, i64 %t1513, ptr %t1514, ptr %t1515, ptr %t1516, ptr %t1517)
  %t1519 = alloca ptr
  %t1520 = load ptr, ptr %t1
  %t1521 = sext i32 0 to i64
  %t1522 = getelementptr ptr, ptr %t1520, i64 %t1521
  %t1523 = load ptr, ptr %t1522
  %t1524 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1523)
  store ptr %t1524, ptr %t1519
  %t1525 = load ptr, ptr %t1519
  %t1526 = icmp ne ptr %t1525, null
  br i1 %t1526, label %L392, label %L394
L392:
  %t1527 = load ptr, ptr %t0
  %t1528 = getelementptr [26 x i8], ptr @.str169, i64 0, i64 0
  %t1529 = load ptr, ptr %t1430
  %t1530 = load i64, ptr %t1416
  %t1531 = load ptr, ptr %t1519
  call void (ptr, ...) @__c0c_emit(ptr %t1527, ptr %t1528, ptr %t1529, i64 %t1530, ptr %t1531)
  %t1533 = load ptr, ptr %t1519
  call void @free(ptr %t1533)
  br label %L394
L394:
  %t1535 = alloca ptr
  %t1536 = load ptr, ptr %t1535
  %t1537 = getelementptr [6 x i8], ptr @.str170, i64 0, i64 0
  %t1538 = load i64, ptr %t1416
  %t1539 = call i32 (ptr, ...) @snprintf(ptr %t1536, i64 8, ptr %t1537, i64 %t1538)
  %t1540 = sext i32 %t1539 to i64
  %t1541 = load ptr, ptr %t1535
  %t1542 = load i64, ptr %t1419
  %t1544 = sext i32 %t1542 to i64
  %t1543 = icmp ne i64 %t1544, 0
  br i1 %t1543, label %L395, label %L396
L395:
  %t1545 = load ptr, ptr %t1404
  %t1546 = ptrtoint ptr %t1545 to i64
  br label %L397
L396:
  %t1547 = call ptr @default_i64_type()
  %t1548 = ptrtoint ptr %t1547 to i64
  br label %L397
L397:
  %t1549 = phi i64 [ %t1546, %L395 ], [ %t1548, %L396 ]
  %t1550 = call i64 @make_val(ptr %t1541, i64 %t1549)
  ret i64 %t1550
L398:
  br label %L15
L15:
  br label %L16
L16:
  %t1551 = alloca i64
  %t1552 = load ptr, ptr %t1
  %t1553 = sext i32 0 to i64
  %t1554 = getelementptr ptr, ptr %t1552, i64 %t1553
  %t1555 = load ptr, ptr %t1554
  %t1556 = call i64 @emit_expr(ptr %t0, ptr %t1555)
  store i64 %t1556, ptr %t1551
  %t1557 = alloca i64
  %t1558 = call i32 @new_reg(ptr %t0)
  %t1559 = sext i32 %t1558 to i64
  store i64 %t1559, ptr %t1557
  %t1560 = alloca ptr
  %t1561 = load ptr, ptr %t1
  %t1563 = ptrtoint ptr %t1561 to i64
  %t1564 = sext i32 38 to i64
  %t1562 = icmp eq i64 %t1563, %t1564
  %t1565 = zext i1 %t1562 to i64
  %t1566 = icmp ne i64 %t1565, 0
  br i1 %t1566, label %L399, label %L400
L399:
  %t1567 = getelementptr [4 x i8], ptr @.str171, i64 0, i64 0
  %t1568 = ptrtoint ptr %t1567 to i64
  br label %L401
L400:
  %t1569 = getelementptr [4 x i8], ptr @.str172, i64 0, i64 0
  %t1570 = ptrtoint ptr %t1569 to i64
  br label %L401
L401:
  %t1571 = phi i64 [ %t1568, %L399 ], [ %t1570, %L400 ]
  store i64 %t1571, ptr %t1560
  %t1572 = alloca ptr
  %t1573 = load i64, ptr %t1551
  %t1574 = load ptr, ptr %t1572
  %t1575 = call i32 @promote_to_i64(ptr %t0, i64 %t1573, ptr %t1574, i64 64)
  %t1576 = sext i32 %t1575 to i64
  %t1577 = load ptr, ptr %t0
  %t1578 = getelementptr [24 x i8], ptr @.str173, i64 0, i64 0
  %t1579 = load i64, ptr %t1557
  %t1580 = load ptr, ptr %t1560
  %t1581 = load ptr, ptr %t1572
  call void (ptr, ...) @__c0c_emit(ptr %t1577, ptr %t1578, i64 %t1579, ptr %t1580, ptr %t1581)
  %t1583 = alloca ptr
  %t1584 = load ptr, ptr %t1
  %t1585 = sext i32 0 to i64
  %t1586 = getelementptr ptr, ptr %t1584, i64 %t1585
  %t1587 = load ptr, ptr %t1586
  %t1588 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1587)
  store ptr %t1588, ptr %t1583
  %t1589 = load ptr, ptr %t1583
  %t1590 = icmp ne ptr %t1589, null
  br i1 %t1590, label %L402, label %L404
L402:
  %t1591 = load ptr, ptr %t0
  %t1592 = getelementptr [27 x i8], ptr @.str174, i64 0, i64 0
  %t1593 = load i64, ptr %t1557
  %t1594 = load ptr, ptr %t1583
  call void (ptr, ...) @__c0c_emit(ptr %t1591, ptr %t1592, i64 %t1593, ptr %t1594)
  %t1596 = load ptr, ptr %t1583
  call void @free(ptr %t1596)
  br label %L404
L404:
  %t1598 = alloca ptr
  %t1599 = load ptr, ptr %t1598
  %t1600 = getelementptr [6 x i8], ptr @.str175, i64 0, i64 0
  %t1601 = load i64, ptr %t1557
  %t1602 = call i32 (ptr, ...) @snprintf(ptr %t1599, i64 8, ptr %t1600, i64 %t1601)
  %t1603 = sext i32 %t1602 to i64
  %t1604 = load ptr, ptr %t1598
  %t1605 = call ptr @default_i64_type()
  %t1606 = call i64 @make_val(ptr %t1604, ptr %t1605)
  ret i64 %t1606
L405:
  br label %L17
L17:
  br label %L18
L18:
  %t1607 = alloca i64
  %t1608 = load ptr, ptr %t1
  %t1609 = sext i32 0 to i64
  %t1610 = getelementptr ptr, ptr %t1608, i64 %t1609
  %t1611 = load ptr, ptr %t1610
  %t1612 = call i64 @emit_expr(ptr %t0, ptr %t1611)
  store i64 %t1612, ptr %t1607
  %t1613 = alloca i64
  %t1614 = call i32 @new_reg(ptr %t0)
  %t1615 = sext i32 %t1614 to i64
  store i64 %t1615, ptr %t1613
  %t1616 = alloca ptr
  %t1617 = load ptr, ptr %t1
  %t1619 = ptrtoint ptr %t1617 to i64
  %t1620 = sext i32 40 to i64
  %t1618 = icmp eq i64 %t1619, %t1620
  %t1621 = zext i1 %t1618 to i64
  %t1622 = icmp ne i64 %t1621, 0
  br i1 %t1622, label %L406, label %L407
L406:
  %t1623 = getelementptr [4 x i8], ptr @.str176, i64 0, i64 0
  %t1624 = ptrtoint ptr %t1623 to i64
  br label %L408
L407:
  %t1625 = getelementptr [4 x i8], ptr @.str177, i64 0, i64 0
  %t1626 = ptrtoint ptr %t1625 to i64
  br label %L408
L408:
  %t1627 = phi i64 [ %t1624, %L406 ], [ %t1626, %L407 ]
  store i64 %t1627, ptr %t1616
  %t1628 = alloca ptr
  %t1629 = load i64, ptr %t1607
  %t1630 = load ptr, ptr %t1628
  %t1631 = call i32 @promote_to_i64(ptr %t0, i64 %t1629, ptr %t1630, i64 64)
  %t1632 = sext i32 %t1631 to i64
  %t1633 = load ptr, ptr %t0
  %t1634 = getelementptr [24 x i8], ptr @.str178, i64 0, i64 0
  %t1635 = load i64, ptr %t1613
  %t1636 = load ptr, ptr %t1616
  %t1637 = load ptr, ptr %t1628
  call void (ptr, ...) @__c0c_emit(ptr %t1633, ptr %t1634, i64 %t1635, ptr %t1636, ptr %t1637)
  %t1639 = alloca ptr
  %t1640 = load ptr, ptr %t1
  %t1641 = sext i32 0 to i64
  %t1642 = getelementptr ptr, ptr %t1640, i64 %t1641
  %t1643 = load ptr, ptr %t1642
  %t1644 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1643)
  store ptr %t1644, ptr %t1639
  %t1645 = load ptr, ptr %t1639
  %t1646 = icmp ne ptr %t1645, null
  br i1 %t1646, label %L409, label %L411
L409:
  %t1647 = load ptr, ptr %t0
  %t1648 = getelementptr [27 x i8], ptr @.str179, i64 0, i64 0
  %t1649 = load i64, ptr %t1613
  %t1650 = load ptr, ptr %t1639
  call void (ptr, ...) @__c0c_emit(ptr %t1647, ptr %t1648, i64 %t1649, ptr %t1650)
  %t1652 = load ptr, ptr %t1639
  call void @free(ptr %t1652)
  br label %L411
L411:
  %t1654 = load i64, ptr %t1607
  %t1655 = sext i32 %t1654 to i64
  ret i64 %t1655
L412:
  br label %L19
L19:
  %t1656 = alloca ptr
  %t1657 = load ptr, ptr %t1
  %t1658 = sext i32 0 to i64
  %t1659 = getelementptr ptr, ptr %t1657, i64 %t1658
  %t1660 = load ptr, ptr %t1659
  %t1661 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t1660)
  store ptr %t1661, ptr %t1656
  %t1662 = load ptr, ptr %t1656
  %t1664 = ptrtoint ptr %t1662 to i64
  %t1665 = icmp eq i64 %t1664, 0
  %t1663 = zext i1 %t1665 to i64
  %t1666 = icmp ne i64 %t1663, 0
  br i1 %t1666, label %L413, label %L415
L413:
  %t1667 = getelementptr [5 x i8], ptr @.str180, i64 0, i64 0
  %t1668 = call ptr @default_ptr_type()
  %t1669 = call i64 @make_val(ptr %t1667, ptr %t1668)
  ret i64 %t1669
L416:
  br label %L415
L415:
  %t1670 = alloca i64
  %t1671 = load ptr, ptr %t1656
  %t1672 = call ptr @default_ptr_type()
  %t1673 = call i64 @make_val(ptr %t1671, ptr %t1672)
  store i64 %t1673, ptr %t1670
  %t1674 = load ptr, ptr %t1656
  call void @free(ptr %t1674)
  %t1676 = load i64, ptr %t1670
  %t1677 = sext i32 %t1676 to i64
  ret i64 %t1677
L417:
  br label %L20
L20:
  %t1678 = alloca i64
  %t1679 = load ptr, ptr %t1
  %t1680 = sext i32 0 to i64
  %t1681 = getelementptr ptr, ptr %t1679, i64 %t1680
  %t1682 = load ptr, ptr %t1681
  %t1683 = call i64 @emit_expr(ptr %t0, ptr %t1682)
  store i64 %t1683, ptr %t1678
  %t1684 = alloca i64
  %t1685 = call i32 @new_reg(ptr %t0)
  %t1686 = sext i32 %t1685 to i64
  store i64 %t1686, ptr %t1684
  %t1687 = alloca ptr
  %t1688 = load i64, ptr %t1678
  %t1689 = call i32 @val_is_ptr(i64 %t1688)
  %t1690 = sext i32 %t1689 to i64
  %t1691 = icmp ne i64 %t1690, 0
  br i1 %t1691, label %L418, label %L419
L418:
  %t1692 = load ptr, ptr %t1687
  %t1693 = load ptr, ptr %t1678
  %t1694 = call ptr @strncpy(ptr %t1692, ptr %t1693, i64 63)
  %t1695 = load ptr, ptr %t1687
  %t1697 = sext i32 63 to i64
  %t1696 = getelementptr ptr, ptr %t1695, i64 %t1697
  %t1698 = sext i32 0 to i64
  store i64 %t1698, ptr %t1696
  br label %L420
L419:
  %t1699 = alloca i64
  %t1700 = call i32 @new_reg(ptr %t0)
  %t1701 = sext i32 %t1700 to i64
  store i64 %t1701, ptr %t1699
  %t1702 = load ptr, ptr %t0
  %t1703 = getelementptr [34 x i8], ptr @.str181, i64 0, i64 0
  %t1704 = load i64, ptr %t1699
  %t1705 = load ptr, ptr %t1678
  call void (ptr, ...) @__c0c_emit(ptr %t1702, ptr %t1703, i64 %t1704, ptr %t1705)
  %t1707 = load ptr, ptr %t1687
  %t1708 = getelementptr [6 x i8], ptr @.str182, i64 0, i64 0
  %t1709 = load i64, ptr %t1699
  %t1710 = call i32 (ptr, ...) @snprintf(ptr %t1707, i64 64, ptr %t1708, i64 %t1709)
  %t1711 = sext i32 %t1710 to i64
  br label %L420
L420:
  %t1712 = alloca ptr
  %t1713 = load ptr, ptr %t1678
  %t1714 = ptrtoint ptr %t1713 to i64
  %t1715 = icmp ne i64 %t1714, 0
  br i1 %t1715, label %L421, label %L422
L421:
  %t1716 = load ptr, ptr %t1678
  %t1717 = load ptr, ptr %t1716
  %t1718 = ptrtoint ptr %t1717 to i64
  %t1719 = icmp ne i64 %t1718, 0
  %t1720 = zext i1 %t1719 to i64
  br label %L423
L422:
  br label %L423
L423:
  %t1721 = phi i64 [ %t1720, %L421 ], [ 0, %L422 ]
  %t1722 = icmp ne i64 %t1721, 0
  br i1 %t1722, label %L424, label %L425
L424:
  %t1723 = load ptr, ptr %t1678
  %t1724 = load ptr, ptr %t1723
  %t1725 = ptrtoint ptr %t1724 to i64
  br label %L426
L425:
  %t1726 = call ptr @default_int_type()
  %t1727 = ptrtoint ptr %t1726 to i64
  br label %L426
L426:
  %t1728 = phi i64 [ %t1725, %L424 ], [ %t1727, %L425 ]
  store i64 %t1728, ptr %t1712
  %t1729 = alloca i64
  %t1730 = load ptr, ptr %t1712
  %t1731 = load ptr, ptr %t1730
  %t1733 = ptrtoint ptr %t1731 to i64
  %t1734 = sext i32 15 to i64
  %t1732 = icmp eq i64 %t1733, %t1734
  %t1735 = zext i1 %t1732 to i64
  %t1736 = icmp ne i64 %t1735, 0
  br i1 %t1736, label %L427, label %L428
L427:
  br label %L429
L428:
  %t1737 = load ptr, ptr %t1712
  %t1738 = load ptr, ptr %t1737
  %t1740 = ptrtoint ptr %t1738 to i64
  %t1741 = sext i32 16 to i64
  %t1739 = icmp eq i64 %t1740, %t1741
  %t1742 = zext i1 %t1739 to i64
  %t1743 = icmp ne i64 %t1742, 0
  %t1744 = zext i1 %t1743 to i64
  br label %L429
L429:
  %t1745 = phi i64 [ 1, %L427 ], [ %t1744, %L428 ]
  store i64 %t1745, ptr %t1729
  %t1746 = alloca ptr
  %t1747 = load i64, ptr %t1729
  %t1749 = sext i32 %t1747 to i64
  %t1748 = icmp ne i64 %t1749, 0
  br i1 %t1748, label %L430, label %L431
L430:
  %t1750 = getelementptr [4 x i8], ptr @.str183, i64 0, i64 0
  %t1751 = ptrtoint ptr %t1750 to i64
  br label %L432
L431:
  %t1752 = getelementptr [4 x i8], ptr @.str184, i64 0, i64 0
  %t1753 = ptrtoint ptr %t1752 to i64
  br label %L432
L432:
  %t1754 = phi i64 [ %t1751, %L430 ], [ %t1753, %L431 ]
  store i64 %t1754, ptr %t1746
  %t1755 = alloca ptr
  %t1756 = load i64, ptr %t1729
  %t1758 = sext i32 %t1756 to i64
  %t1757 = icmp ne i64 %t1758, 0
  br i1 %t1757, label %L433, label %L434
L433:
  %t1759 = call ptr @default_ptr_type()
  %t1760 = ptrtoint ptr %t1759 to i64
  br label %L435
L434:
  %t1761 = call ptr @default_i64_type()
  %t1762 = ptrtoint ptr %t1761 to i64
  br label %L435
L435:
  %t1763 = phi i64 [ %t1760, %L433 ], [ %t1762, %L434 ]
  store i64 %t1763, ptr %t1755
  %t1764 = load ptr, ptr %t0
  %t1765 = getelementptr [27 x i8], ptr @.str185, i64 0, i64 0
  %t1766 = load i64, ptr %t1684
  %t1767 = load ptr, ptr %t1746
  %t1768 = load ptr, ptr %t1687
  call void (ptr, ...) @__c0c_emit(ptr %t1764, ptr %t1765, i64 %t1766, ptr %t1767, ptr %t1768)
  %t1770 = alloca ptr
  %t1771 = load ptr, ptr %t1770
  %t1772 = getelementptr [6 x i8], ptr @.str186, i64 0, i64 0
  %t1773 = load i64, ptr %t1684
  %t1774 = call i32 (ptr, ...) @snprintf(ptr %t1771, i64 8, ptr %t1772, i64 %t1773)
  %t1775 = sext i32 %t1774 to i64
  %t1776 = load ptr, ptr %t1770
  %t1777 = load ptr, ptr %t1755
  %t1778 = call i64 @make_val(ptr %t1776, ptr %t1777)
  ret i64 %t1778
L436:
  br label %L21
L21:
  %t1779 = alloca i64
  %t1780 = load ptr, ptr %t1
  %t1781 = sext i32 0 to i64
  %t1782 = getelementptr ptr, ptr %t1780, i64 %t1781
  %t1783 = load ptr, ptr %t1782
  %t1784 = call i64 @emit_expr(ptr %t0, ptr %t1783)
  store i64 %t1784, ptr %t1779
  %t1785 = alloca i64
  %t1786 = load ptr, ptr %t1
  %t1787 = sext i32 1 to i64
  %t1788 = getelementptr ptr, ptr %t1786, i64 %t1787
  %t1789 = load ptr, ptr %t1788
  %t1790 = call i64 @emit_expr(ptr %t0, ptr %t1789)
  store i64 %t1790, ptr %t1785
  %t1791 = alloca ptr
  %t1792 = load ptr, ptr %t1779
  %t1793 = ptrtoint ptr %t1792 to i64
  %t1794 = icmp ne i64 %t1793, 0
  br i1 %t1794, label %L437, label %L438
L437:
  %t1795 = load ptr, ptr %t1779
  %t1796 = load ptr, ptr %t1795
  %t1797 = ptrtoint ptr %t1796 to i64
  %t1798 = icmp ne i64 %t1797, 0
  %t1799 = zext i1 %t1798 to i64
  br label %L439
L438:
  br label %L439
L439:
  %t1800 = phi i64 [ %t1799, %L437 ], [ 0, %L438 ]
  %t1801 = icmp ne i64 %t1800, 0
  br i1 %t1801, label %L440, label %L441
L440:
  %t1802 = load ptr, ptr %t1779
  %t1803 = load ptr, ptr %t1802
  %t1804 = ptrtoint ptr %t1803 to i64
  br label %L442
L441:
  %t1806 = sext i32 0 to i64
  %t1805 = inttoptr i64 %t1806 to ptr
  %t1807 = ptrtoint ptr %t1805 to i64
  br label %L442
L442:
  %t1808 = phi i64 [ %t1804, %L440 ], [ %t1807, %L441 ]
  store i64 %t1808, ptr %t1791
  %t1809 = alloca i64
  %t1810 = load ptr, ptr %t1791
  %t1811 = ptrtoint ptr %t1810 to i64
  %t1812 = icmp ne i64 %t1811, 0
  br i1 %t1812, label %L443, label %L444
L443:
  %t1813 = load ptr, ptr %t1791
  %t1814 = load ptr, ptr %t1813
  %t1816 = ptrtoint ptr %t1814 to i64
  %t1817 = sext i32 15 to i64
  %t1815 = icmp eq i64 %t1816, %t1817
  %t1818 = zext i1 %t1815 to i64
  %t1819 = icmp ne i64 %t1818, 0
  br i1 %t1819, label %L446, label %L447
L446:
  br label %L448
L447:
  %t1820 = load ptr, ptr %t1791
  %t1821 = load ptr, ptr %t1820
  %t1823 = ptrtoint ptr %t1821 to i64
  %t1824 = sext i32 16 to i64
  %t1822 = icmp eq i64 %t1823, %t1824
  %t1825 = zext i1 %t1822 to i64
  %t1826 = icmp ne i64 %t1825, 0
  %t1827 = zext i1 %t1826 to i64
  br label %L448
L448:
  %t1828 = phi i64 [ 1, %L446 ], [ %t1827, %L447 ]
  %t1829 = icmp ne i64 %t1828, 0
  %t1830 = zext i1 %t1829 to i64
  br label %L445
L444:
  br label %L445
L445:
  %t1831 = phi i64 [ %t1830, %L443 ], [ 0, %L444 ]
  store i64 %t1831, ptr %t1809
  %t1832 = alloca i64
  %t1833 = load ptr, ptr %t1791
  %t1834 = ptrtoint ptr %t1833 to i64
  %t1835 = icmp ne i64 %t1834, 0
  br i1 %t1835, label %L449, label %L450
L449:
  %t1836 = load ptr, ptr %t1791
  %t1837 = call i32 @type_is_fp(ptr %t1836)
  %t1838 = sext i32 %t1837 to i64
  %t1839 = icmp ne i64 %t1838, 0
  %t1840 = zext i1 %t1839 to i64
  br label %L451
L450:
  br label %L451
L451:
  %t1841 = phi i64 [ %t1840, %L449 ], [ 0, %L450 ]
  store i64 %t1841, ptr %t1832
  %t1842 = alloca ptr
  %t1843 = alloca ptr
  %t1844 = alloca ptr
  %t1845 = load ptr, ptr %t1791
  %t1847 = ptrtoint ptr %t1845 to i64
  %t1848 = icmp eq i64 %t1847, 0
  %t1846 = zext i1 %t1848 to i64
  %t1849 = icmp ne i64 %t1846, 0
  br i1 %t1849, label %L452, label %L453
L452:
  %t1850 = getelementptr [4 x i8], ptr @.str187, i64 0, i64 0
  store ptr %t1850, ptr %t1842
  %t1851 = getelementptr [4 x i8], ptr @.str188, i64 0, i64 0
  store ptr %t1851, ptr %t1843
  %t1852 = call ptr @default_ptr_type()
  store ptr %t1852, ptr %t1844
  br label %L454
L453:
  %t1853 = load i64, ptr %t1809
  %t1855 = sext i32 %t1853 to i64
  %t1854 = icmp ne i64 %t1855, 0
  br i1 %t1854, label %L455, label %L456
L455:
  %t1856 = getelementptr [4 x i8], ptr @.str189, i64 0, i64 0
  store ptr %t1856, ptr %t1842
  %t1857 = getelementptr [4 x i8], ptr @.str190, i64 0, i64 0
  store ptr %t1857, ptr %t1843
  %t1858 = call ptr @default_ptr_type()
  store ptr %t1858, ptr %t1844
  br label %L457
L456:
  %t1859 = load i64, ptr %t1832
  %t1861 = sext i32 %t1859 to i64
  %t1860 = icmp ne i64 %t1861, 0
  br i1 %t1860, label %L458, label %L459
L458:
  %t1862 = load ptr, ptr %t1791
  %t1863 = call ptr @llvm_type(ptr %t1862)
  store ptr %t1863, ptr %t1842
  %t1864 = load ptr, ptr %t1791
  %t1865 = call ptr @llvm_type(ptr %t1864)
  store ptr %t1865, ptr %t1843
  %t1866 = load ptr, ptr %t1791
  store ptr %t1866, ptr %t1844
  br label %L460
L459:
  %t1867 = getelementptr [4 x i8], ptr @.str191, i64 0, i64 0
  store ptr %t1867, ptr %t1842
  %t1868 = getelementptr [4 x i8], ptr @.str192, i64 0, i64 0
  store ptr %t1868, ptr %t1843
  %t1869 = call ptr @default_i64_type()
  store ptr %t1869, ptr %t1844
  br label %L460
L460:
  br label %L457
L457:
  br label %L454
L454:
  %t1870 = alloca ptr
  %t1871 = alloca ptr
  %t1872 = load i64, ptr %t1779
  %t1873 = call i32 @val_is_ptr(i64 %t1872)
  %t1874 = sext i32 %t1873 to i64
  %t1875 = icmp ne i64 %t1874, 0
  br i1 %t1875, label %L461, label %L462
L461:
  %t1876 = load ptr, ptr %t1870
  %t1877 = load ptr, ptr %t1779
  %t1878 = call ptr @strncpy(ptr %t1876, ptr %t1877, i64 63)
  br label %L463
L462:
  %t1879 = alloca i64
  %t1880 = call i32 @new_reg(ptr %t0)
  %t1881 = sext i32 %t1880 to i64
  store i64 %t1881, ptr %t1879
  %t1882 = load ptr, ptr %t0
  %t1883 = getelementptr [34 x i8], ptr @.str193, i64 0, i64 0
  %t1884 = load i64, ptr %t1879
  %t1885 = load ptr, ptr %t1779
  call void (ptr, ...) @__c0c_emit(ptr %t1882, ptr %t1883, i64 %t1884, ptr %t1885)
  %t1887 = load ptr, ptr %t1870
  %t1888 = getelementptr [6 x i8], ptr @.str194, i64 0, i64 0
  %t1889 = load i64, ptr %t1879
  %t1890 = call i32 (ptr, ...) @snprintf(ptr %t1887, i64 64, ptr %t1888, i64 %t1889)
  %t1891 = sext i32 %t1890 to i64
  br label %L463
L463:
  %t1892 = load i64, ptr %t1785
  %t1893 = load ptr, ptr %t1871
  %t1894 = call i32 @promote_to_i64(ptr %t0, i64 %t1892, ptr %t1893, i64 64)
  %t1895 = sext i32 %t1894 to i64
  %t1896 = load ptr, ptr %t1870
  %t1898 = sext i32 63 to i64
  %t1897 = getelementptr ptr, ptr %t1896, i64 %t1898
  %t1899 = sext i32 0 to i64
  store i64 %t1899, ptr %t1897
  %t1900 = alloca i64
  %t1901 = call i32 @new_reg(ptr %t0)
  %t1902 = sext i32 %t1901 to i64
  store i64 %t1902, ptr %t1900
  %t1903 = load ptr, ptr %t0
  %t1904 = getelementptr [44 x i8], ptr @.str195, i64 0, i64 0
  %t1905 = load i64, ptr %t1900
  %t1906 = load ptr, ptr %t1842
  %t1907 = load ptr, ptr %t1870
  %t1908 = load ptr, ptr %t1871
  call void (ptr, ...) @__c0c_emit(ptr %t1903, ptr %t1904, i64 %t1905, ptr %t1906, ptr %t1907, ptr %t1908)
  %t1910 = alloca i64
  %t1911 = call i32 @new_reg(ptr %t0)
  %t1912 = sext i32 %t1911 to i64
  store i64 %t1912, ptr %t1910
  %t1913 = load ptr, ptr %t0
  %t1914 = getelementptr [30 x i8], ptr @.str196, i64 0, i64 0
  %t1915 = load i64, ptr %t1910
  %t1916 = load ptr, ptr %t1843
  %t1917 = load i64, ptr %t1900
  call void (ptr, ...) @__c0c_emit(ptr %t1913, ptr %t1914, i64 %t1915, ptr %t1916, i64 %t1917)
  %t1919 = alloca ptr
  %t1920 = load ptr, ptr %t1919
  %t1921 = getelementptr [6 x i8], ptr @.str197, i64 0, i64 0
  %t1922 = load i64, ptr %t1910
  %t1923 = call i32 (ptr, ...) @snprintf(ptr %t1920, i64 8, ptr %t1921, i64 %t1922)
  %t1924 = sext i32 %t1923 to i64
  %t1925 = load ptr, ptr %t1919
  %t1926 = load ptr, ptr %t1844
  %t1927 = call i64 @make_val(ptr %t1925, ptr %t1926)
  ret i64 %t1927
L464:
  br label %L22
L22:
  %t1928 = alloca i64
  %t1929 = load ptr, ptr %t1
  %t1930 = call i64 @emit_expr(ptr %t0, ptr %t1929)
  store i64 %t1930, ptr %t1928
  %t1931 = alloca ptr
  %t1932 = load ptr, ptr %t1
  store ptr %t1932, ptr %t1931
  %t1933 = load ptr, ptr %t1931
  %t1935 = ptrtoint ptr %t1933 to i64
  %t1936 = icmp eq i64 %t1935, 0
  %t1934 = zext i1 %t1936 to i64
  %t1937 = icmp ne i64 %t1934, 0
  br i1 %t1937, label %L465, label %L467
L465:
  %t1938 = load i64, ptr %t1928
  %t1939 = sext i32 %t1938 to i64
  ret i64 %t1939
L468:
  br label %L467
L467:
  %t1940 = alloca i64
  %t1941 = call i32 @new_reg(ptr %t0)
  %t1942 = sext i32 %t1941 to i64
  store i64 %t1942, ptr %t1940
  %t1943 = alloca i64
  %t1944 = load ptr, ptr %t1928
  %t1945 = call i32 @type_is_fp(ptr %t1944)
  %t1946 = sext i32 %t1945 to i64
  store i64 %t1946, ptr %t1943
  %t1947 = alloca i64
  %t1948 = load ptr, ptr %t1931
  %t1949 = call i32 @type_is_fp(ptr %t1948)
  %t1950 = sext i32 %t1949 to i64
  store i64 %t1950, ptr %t1947
  %t1951 = alloca i64
  %t1952 = load ptr, ptr %t1931
  %t1953 = load ptr, ptr %t1952
  %t1955 = ptrtoint ptr %t1953 to i64
  %t1956 = sext i32 15 to i64
  %t1954 = icmp eq i64 %t1955, %t1956
  %t1957 = zext i1 %t1954 to i64
  %t1958 = icmp ne i64 %t1957, 0
  br i1 %t1958, label %L469, label %L470
L469:
  br label %L471
L470:
  %t1959 = load ptr, ptr %t1931
  %t1960 = load ptr, ptr %t1959
  %t1962 = ptrtoint ptr %t1960 to i64
  %t1963 = sext i32 16 to i64
  %t1961 = icmp eq i64 %t1962, %t1963
  %t1964 = zext i1 %t1961 to i64
  %t1965 = icmp ne i64 %t1964, 0
  %t1966 = zext i1 %t1965 to i64
  br label %L471
L471:
  %t1967 = phi i64 [ 1, %L469 ], [ %t1966, %L470 ]
  store i64 %t1967, ptr %t1951
  %t1968 = alloca i64
  %t1969 = load i64, ptr %t1928
  %t1970 = call i32 @val_is_ptr(i64 %t1969)
  %t1971 = sext i32 %t1970 to i64
  store i64 %t1971, ptr %t1968
  %t1972 = load i64, ptr %t1943
  %t1973 = sext i32 %t1972 to i64
  %t1974 = icmp ne i64 %t1973, 0
  br i1 %t1974, label %L472, label %L473
L472:
  %t1975 = load i64, ptr %t1947
  %t1976 = sext i32 %t1975 to i64
  %t1977 = icmp ne i64 %t1976, 0
  %t1978 = zext i1 %t1977 to i64
  br label %L474
L473:
  br label %L474
L474:
  %t1979 = phi i64 [ %t1978, %L472 ], [ 0, %L473 ]
  %t1980 = icmp ne i64 %t1979, 0
  br i1 %t1980, label %L475, label %L476
L475:
  %t1981 = alloca i64
  %t1982 = load ptr, ptr %t1928
  %t1983 = call i32 @type_size(ptr %t1982)
  %t1984 = sext i32 %t1983 to i64
  store i64 %t1984, ptr %t1981
  %t1985 = alloca i64
  %t1986 = load ptr, ptr %t1931
  %t1987 = call i32 @type_size(ptr %t1986)
  %t1988 = sext i32 %t1987 to i64
  store i64 %t1988, ptr %t1985
  %t1989 = load i64, ptr %t1985
  %t1990 = load i64, ptr %t1981
  %t1992 = sext i32 %t1989 to i64
  %t1993 = sext i32 %t1990 to i64
  %t1991 = icmp sgt i64 %t1992, %t1993
  %t1994 = zext i1 %t1991 to i64
  %t1995 = icmp ne i64 %t1994, 0
  br i1 %t1995, label %L478, label %L479
L478:
  %t1996 = load ptr, ptr %t0
  %t1997 = getelementptr [36 x i8], ptr @.str198, i64 0, i64 0
  %t1998 = load i64, ptr %t1940
  %t1999 = load ptr, ptr %t1928
  call void (ptr, ...) @__c0c_emit(ptr %t1996, ptr %t1997, i64 %t1998, ptr %t1999)
  br label %L480
L479:
  %t2001 = load ptr, ptr %t0
  %t2002 = getelementptr [38 x i8], ptr @.str199, i64 0, i64 0
  %t2003 = load i64, ptr %t1940
  %t2004 = load ptr, ptr %t1928
  call void (ptr, ...) @__c0c_emit(ptr %t2001, ptr %t2002, i64 %t2003, ptr %t2004)
  br label %L480
L480:
  br label %L477
L476:
  %t2006 = load i64, ptr %t1943
  %t2007 = sext i32 %t2006 to i64
  %t2008 = icmp ne i64 %t2007, 0
  br i1 %t2008, label %L481, label %L482
L481:
  %t2009 = load i64, ptr %t1947
  %t2011 = sext i32 %t2009 to i64
  %t2012 = icmp eq i64 %t2011, 0
  %t2010 = zext i1 %t2012 to i64
  %t2013 = icmp ne i64 %t2010, 0
  %t2014 = zext i1 %t2013 to i64
  br label %L483
L482:
  br label %L483
L483:
  %t2015 = phi i64 [ %t2014, %L481 ], [ 0, %L482 ]
  %t2016 = icmp ne i64 %t2015, 0
  br i1 %t2016, label %L484, label %L485
L484:
  %t2017 = load ptr, ptr %t0
  %t2018 = getelementptr [35 x i8], ptr @.str200, i64 0, i64 0
  %t2019 = load i64, ptr %t1940
  %t2020 = load ptr, ptr %t1928
  call void (ptr, ...) @__c0c_emit(ptr %t2017, ptr %t2018, i64 %t2019, ptr %t2020)
  br label %L486
L485:
  %t2022 = load i64, ptr %t1943
  %t2024 = sext i32 %t2022 to i64
  %t2025 = icmp eq i64 %t2024, 0
  %t2023 = zext i1 %t2025 to i64
  %t2026 = icmp ne i64 %t2023, 0
  br i1 %t2026, label %L487, label %L488
L487:
  %t2027 = load i64, ptr %t1947
  %t2028 = sext i32 %t2027 to i64
  %t2029 = icmp ne i64 %t2028, 0
  %t2030 = zext i1 %t2029 to i64
  br label %L489
L488:
  br label %L489
L489:
  %t2031 = phi i64 [ %t2030, %L487 ], [ 0, %L488 ]
  %t2032 = icmp ne i64 %t2031, 0
  br i1 %t2032, label %L490, label %L491
L490:
  %t2033 = alloca ptr
  %t2034 = load i64, ptr %t1928
  %t2035 = load ptr, ptr %t2033
  %t2036 = call i32 @promote_to_i64(ptr %t0, i64 %t2034, ptr %t2035, i64 64)
  %t2037 = sext i32 %t2036 to i64
  %t2038 = load ptr, ptr %t0
  %t2039 = getelementptr [31 x i8], ptr @.str201, i64 0, i64 0
  %t2040 = load i64, ptr %t1940
  %t2041 = load ptr, ptr %t2033
  %t2042 = load ptr, ptr %t1931
  %t2043 = call ptr @llvm_type(ptr %t2042)
  call void (ptr, ...) @__c0c_emit(ptr %t2038, ptr %t2039, i64 %t2040, ptr %t2041, ptr %t2043)
  br label %L492
L491:
  %t2045 = load i64, ptr %t1951
  %t2046 = sext i32 %t2045 to i64
  %t2047 = icmp ne i64 %t2046, 0
  br i1 %t2047, label %L493, label %L494
L493:
  %t2048 = load i64, ptr %t1968
  %t2050 = sext i32 %t2048 to i64
  %t2051 = icmp eq i64 %t2050, 0
  %t2049 = zext i1 %t2051 to i64
  %t2052 = icmp ne i64 %t2049, 0
  %t2053 = zext i1 %t2052 to i64
  br label %L495
L494:
  br label %L495
L495:
  %t2054 = phi i64 [ %t2053, %L493 ], [ 0, %L494 ]
  %t2055 = icmp ne i64 %t2054, 0
  br i1 %t2055, label %L496, label %L497
L496:
  %t2056 = alloca ptr
  %t2057 = load i64, ptr %t1928
  %t2058 = load ptr, ptr %t2056
  %t2059 = call i32 @promote_to_i64(ptr %t0, i64 %t2057, ptr %t2058, i64 64)
  %t2060 = sext i32 %t2059 to i64
  %t2061 = load ptr, ptr %t0
  %t2062 = getelementptr [34 x i8], ptr @.str202, i64 0, i64 0
  %t2063 = load i64, ptr %t1940
  %t2064 = load ptr, ptr %t2056
  call void (ptr, ...) @__c0c_emit(ptr %t2061, ptr %t2062, i64 %t2063, ptr %t2064)
  br label %L498
L497:
  %t2066 = load i64, ptr %t1951
  %t2068 = sext i32 %t2066 to i64
  %t2069 = icmp eq i64 %t2068, 0
  %t2067 = zext i1 %t2069 to i64
  %t2070 = icmp ne i64 %t2067, 0
  br i1 %t2070, label %L499, label %L500
L499:
  %t2071 = load i64, ptr %t1968
  %t2072 = sext i32 %t2071 to i64
  %t2073 = icmp ne i64 %t2072, 0
  %t2074 = zext i1 %t2073 to i64
  br label %L501
L500:
  br label %L501
L501:
  %t2075 = phi i64 [ %t2074, %L499 ], [ 0, %L500 ]
  %t2076 = icmp ne i64 %t2075, 0
  br i1 %t2076, label %L502, label %L503
L502:
  %t2077 = load ptr, ptr %t0
  %t2078 = getelementptr [34 x i8], ptr @.str203, i64 0, i64 0
  %t2079 = load i64, ptr %t1940
  %t2080 = load ptr, ptr %t1928
  call void (ptr, ...) @__c0c_emit(ptr %t2077, ptr %t2078, i64 %t2079, ptr %t2080)
  br label %L504
L503:
  %t2082 = load i64, ptr %t1951
  %t2083 = sext i32 %t2082 to i64
  %t2084 = icmp ne i64 %t2083, 0
  br i1 %t2084, label %L505, label %L506
L505:
  %t2085 = load i64, ptr %t1968
  %t2086 = sext i32 %t2085 to i64
  %t2087 = icmp ne i64 %t2086, 0
  %t2088 = zext i1 %t2087 to i64
  br label %L507
L506:
  br label %L507
L507:
  %t2089 = phi i64 [ %t2088, %L505 ], [ 0, %L506 ]
  %t2090 = icmp ne i64 %t2089, 0
  br i1 %t2090, label %L508, label %L509
L508:
  %t2091 = load ptr, ptr %t0
  %t2092 = getelementptr [33 x i8], ptr @.str204, i64 0, i64 0
  %t2093 = load i64, ptr %t1940
  %t2094 = load ptr, ptr %t1928
  call void (ptr, ...) @__c0c_emit(ptr %t2091, ptr %t2092, i64 %t2093, ptr %t2094)
  br label %L510
L509:
  %t2096 = alloca ptr
  %t2097 = load i64, ptr %t1928
  %t2098 = load ptr, ptr %t2096
  %t2099 = call i32 @promote_to_i64(ptr %t0, i64 %t2097, ptr %t2098, i64 64)
  %t2100 = sext i32 %t2099 to i64
  %t2101 = load ptr, ptr %t0
  %t2102 = getelementptr [25 x i8], ptr @.str205, i64 0, i64 0
  %t2103 = load i64, ptr %t1940
  %t2104 = load ptr, ptr %t2096
  call void (ptr, ...) @__c0c_emit(ptr %t2101, ptr %t2102, i64 %t2103, ptr %t2104)
  br label %L510
L510:
  br label %L504
L504:
  br label %L498
L498:
  br label %L492
L492:
  br label %L486
L486:
  br label %L477
L477:
  %t2106 = alloca ptr
  %t2107 = load ptr, ptr %t2106
  %t2108 = getelementptr [6 x i8], ptr @.str206, i64 0, i64 0
  %t2109 = load i64, ptr %t1940
  %t2110 = call i32 (ptr, ...) @snprintf(ptr %t2107, i64 8, ptr %t2108, i64 %t2109)
  %t2111 = sext i32 %t2110 to i64
  %t2112 = load i64, ptr %t1951
  %t2114 = sext i32 %t2112 to i64
  %t2113 = icmp ne i64 %t2114, 0
  br i1 %t2113, label %L511, label %L513
L511:
  %t2115 = load ptr, ptr %t2106
  %t2116 = call ptr @default_ptr_type()
  %t2117 = call i64 @make_val(ptr %t2115, ptr %t2116)
  ret i64 %t2117
L514:
  br label %L513
L513:
  %t2118 = load i64, ptr %t1947
  %t2120 = sext i32 %t2118 to i64
  %t2119 = icmp ne i64 %t2120, 0
  br i1 %t2119, label %L515, label %L517
L515:
  %t2121 = load ptr, ptr %t2106
  %t2122 = load ptr, ptr %t1931
  %t2123 = call i64 @make_val(ptr %t2121, ptr %t2122)
  ret i64 %t2123
L518:
  br label %L517
L517:
  %t2124 = load ptr, ptr %t2106
  %t2125 = call ptr @default_i64_type()
  %t2126 = call i64 @make_val(ptr %t2124, ptr %t2125)
  ret i64 %t2126
L519:
  br label %L23
L23:
  %t2127 = alloca i64
  %t2128 = load ptr, ptr %t1
  %t2129 = call i64 @emit_expr(ptr %t0, ptr %t2128)
  store i64 %t2129, ptr %t2127
  %t2130 = alloca i64
  %t2131 = call i32 @new_label(ptr %t0)
  %t2132 = sext i32 %t2131 to i64
  store i64 %t2132, ptr %t2130
  %t2133 = alloca i64
  %t2134 = call i32 @new_label(ptr %t0)
  %t2135 = sext i32 %t2134 to i64
  store i64 %t2135, ptr %t2133
  %t2136 = alloca i64
  %t2137 = call i32 @new_label(ptr %t0)
  %t2138 = sext i32 %t2137 to i64
  store i64 %t2138, ptr %t2136
  %t2139 = alloca i64
  %t2140 = load i64, ptr %t2127
  %t2141 = call i32 @emit_cond(ptr %t0, i64 %t2140)
  %t2142 = sext i32 %t2141 to i64
  store i64 %t2142, ptr %t2139
  %t2143 = load ptr, ptr %t0
  %t2144 = getelementptr [41 x i8], ptr @.str207, i64 0, i64 0
  %t2145 = load i64, ptr %t2139
  %t2146 = load i64, ptr %t2130
  %t2147 = load i64, ptr %t2133
  call void (ptr, ...) @__c0c_emit(ptr %t2143, ptr %t2144, i64 %t2145, i64 %t2146, i64 %t2147)
  %t2149 = load ptr, ptr %t0
  %t2150 = getelementptr [6 x i8], ptr @.str208, i64 0, i64 0
  %t2151 = load i64, ptr %t2130
  call void (ptr, ...) @__c0c_emit(ptr %t2149, ptr %t2150, i64 %t2151)
  %t2153 = alloca i64
  %t2154 = load ptr, ptr %t1
  %t2155 = sext i32 0 to i64
  %t2156 = getelementptr ptr, ptr %t2154, i64 %t2155
  %t2157 = load ptr, ptr %t2156
  %t2158 = call i64 @emit_expr(ptr %t0, ptr %t2157)
  store i64 %t2158, ptr %t2153
  %t2159 = alloca ptr
  %t2160 = load i64, ptr %t2153
  %t2161 = load ptr, ptr %t2159
  %t2162 = call i32 @promote_to_i64(ptr %t0, i64 %t2160, ptr %t2161, i64 64)
  %t2163 = sext i32 %t2162 to i64
  %t2164 = load ptr, ptr %t0
  %t2165 = getelementptr [18 x i8], ptr @.str209, i64 0, i64 0
  %t2166 = load i64, ptr %t2136
  call void (ptr, ...) @__c0c_emit(ptr %t2164, ptr %t2165, i64 %t2166)
  %t2168 = load ptr, ptr %t0
  %t2169 = getelementptr [6 x i8], ptr @.str210, i64 0, i64 0
  %t2170 = load i64, ptr %t2133
  call void (ptr, ...) @__c0c_emit(ptr %t2168, ptr %t2169, i64 %t2170)
  %t2172 = alloca i64
  %t2173 = load ptr, ptr %t1
  %t2174 = sext i32 1 to i64
  %t2175 = getelementptr ptr, ptr %t2173, i64 %t2174
  %t2176 = load ptr, ptr %t2175
  %t2177 = call i64 @emit_expr(ptr %t0, ptr %t2176)
  store i64 %t2177, ptr %t2172
  %t2178 = alloca ptr
  %t2179 = load i64, ptr %t2172
  %t2180 = load ptr, ptr %t2178
  %t2181 = call i32 @promote_to_i64(ptr %t0, i64 %t2179, ptr %t2180, i64 64)
  %t2182 = sext i32 %t2181 to i64
  %t2183 = load ptr, ptr %t0
  %t2184 = getelementptr [18 x i8], ptr @.str211, i64 0, i64 0
  %t2185 = load i64, ptr %t2136
  call void (ptr, ...) @__c0c_emit(ptr %t2183, ptr %t2184, i64 %t2185)
  %t2187 = load ptr, ptr %t0
  %t2188 = getelementptr [6 x i8], ptr @.str212, i64 0, i64 0
  %t2189 = load i64, ptr %t2136
  call void (ptr, ...) @__c0c_emit(ptr %t2187, ptr %t2188, i64 %t2189)
  %t2191 = alloca i64
  %t2192 = call i32 @new_reg(ptr %t0)
  %t2193 = sext i32 %t2192 to i64
  store i64 %t2193, ptr %t2191
  %t2194 = load ptr, ptr %t0
  %t2195 = getelementptr [48 x i8], ptr @.str213, i64 0, i64 0
  %t2196 = load i64, ptr %t2191
  %t2197 = load ptr, ptr %t2159
  %t2198 = load i64, ptr %t2130
  %t2199 = load ptr, ptr %t2178
  %t2200 = load i64, ptr %t2133
  call void (ptr, ...) @__c0c_emit(ptr %t2194, ptr %t2195, i64 %t2196, ptr %t2197, i64 %t2198, ptr %t2199, i64 %t2200)
  %t2202 = alloca ptr
  %t2203 = load ptr, ptr %t2202
  %t2204 = getelementptr [6 x i8], ptr @.str214, i64 0, i64 0
  %t2205 = load i64, ptr %t2191
  %t2206 = call i32 (ptr, ...) @snprintf(ptr %t2203, i64 8, ptr %t2204, i64 %t2205)
  %t2207 = sext i32 %t2206 to i64
  %t2208 = load ptr, ptr %t2202
  %t2209 = call ptr @default_i64_type()
  %t2210 = call i64 @make_val(ptr %t2208, ptr %t2209)
  ret i64 %t2210
L520:
  br label %L24
L24:
  %t2211 = alloca i64
  %t2212 = load ptr, ptr %t1
  %t2213 = icmp ne ptr %t2212, null
  br i1 %t2213, label %L521, label %L522
L521:
  %t2214 = load ptr, ptr %t1
  %t2215 = call i32 @type_size(ptr %t2214)
  %t2216 = sext i32 %t2215 to i64
  br label %L523
L522:
  %t2217 = sext i32 0 to i64
  br label %L523
L523:
  %t2218 = phi i64 [ %t2216, %L521 ], [ %t2217, %L522 ]
  store i64 %t2218, ptr %t2211
  %t2219 = alloca ptr
  %t2220 = load ptr, ptr %t2219
  %t2221 = getelementptr [3 x i8], ptr @.str215, i64 0, i64 0
  %t2222 = load i64, ptr %t2211
  %t2223 = call i32 (ptr, ...) @snprintf(ptr %t2220, i64 8, ptr %t2221, i64 %t2222)
  %t2224 = sext i32 %t2223 to i64
  %t2225 = load ptr, ptr %t2219
  %t2226 = call ptr @default_int_type()
  %t2227 = call i64 @make_val(ptr %t2225, ptr %t2226)
  ret i64 %t2227
L524:
  br label %L25
L25:
  %t2228 = alloca i64
  %t2229 = load ptr, ptr %t1
  %t2230 = sext i32 0 to i64
  %t2231 = getelementptr ptr, ptr %t2229, i64 %t2230
  %t2232 = load ptr, ptr %t2231
  %t2233 = load ptr, ptr %t2232
  %t2234 = icmp ne ptr %t2233, null
  br i1 %t2234, label %L525, label %L526
L525:
  %t2235 = load ptr, ptr %t1
  %t2236 = sext i32 0 to i64
  %t2237 = getelementptr ptr, ptr %t2235, i64 %t2236
  %t2238 = load ptr, ptr %t2237
  %t2239 = load ptr, ptr %t2238
  %t2240 = call i32 @type_size(ptr %t2239)
  %t2241 = sext i32 %t2240 to i64
  br label %L527
L526:
  %t2242 = sext i32 8 to i64
  br label %L527
L527:
  %t2243 = phi i64 [ %t2241, %L525 ], [ %t2242, %L526 ]
  store i64 %t2243, ptr %t2228
  %t2244 = alloca ptr
  %t2245 = load ptr, ptr %t2244
  %t2246 = getelementptr [3 x i8], ptr @.str216, i64 0, i64 0
  %t2247 = load i64, ptr %t2228
  %t2248 = call i32 (ptr, ...) @snprintf(ptr %t2245, i64 8, ptr %t2246, i64 %t2247)
  %t2249 = sext i32 %t2248 to i64
  %t2250 = load ptr, ptr %t2244
  %t2251 = call ptr @default_int_type()
  %t2252 = call i64 @make_val(ptr %t2250, ptr %t2251)
  ret i64 %t2252
L528:
  br label %L26
L26:
  %t2253 = alloca i64
  %t2254 = getelementptr [2 x i8], ptr @.str217, i64 0, i64 0
  %t2255 = call ptr @default_int_type()
  %t2256 = call i64 @make_val(ptr %t2254, ptr %t2255)
  store i64 %t2256, ptr %t2253
  %t2257 = alloca i64
  %t2258 = sext i32 0 to i64
  store i64 %t2258, ptr %t2257
  br label %L529
L529:
  %t2259 = load i64, ptr %t2257
  %t2260 = load ptr, ptr %t1
  %t2262 = sext i32 %t2259 to i64
  %t2263 = ptrtoint ptr %t2260 to i64
  %t2261 = icmp slt i64 %t2262, %t2263
  %t2264 = zext i1 %t2261 to i64
  %t2265 = icmp ne i64 %t2264, 0
  br i1 %t2265, label %L530, label %L532
L530:
  %t2266 = load ptr, ptr %t1
  %t2267 = load i64, ptr %t2257
  %t2268 = sext i32 %t2267 to i64
  %t2269 = getelementptr ptr, ptr %t2266, i64 %t2268
  %t2270 = load ptr, ptr %t2269
  %t2271 = call i64 @emit_expr(ptr %t0, ptr %t2270)
  store i64 %t2271, ptr %t2253
  br label %L531
L531:
  %t2272 = load i64, ptr %t2257
  %t2274 = sext i32 %t2272 to i64
  %t2273 = add i64 %t2274, 1
  store i64 %t2273, ptr %t2257
  br label %L529
L532:
  %t2275 = load i64, ptr %t2253
  %t2276 = sext i32 %t2275 to i64
  ret i64 %t2276
L533:
  br label %L27
L27:
  br label %L28
L28:
  %t2277 = alloca i64
  %t2278 = load ptr, ptr %t1
  %t2280 = ptrtoint ptr %t2278 to i64
  %t2281 = sext i32 35 to i64
  %t2279 = icmp eq i64 %t2280, %t2281
  %t2282 = zext i1 %t2279 to i64
  %t2283 = icmp ne i64 %t2282, 0
  br i1 %t2283, label %L534, label %L535
L534:
  %t2284 = load ptr, ptr %t1
  %t2285 = sext i32 0 to i64
  %t2286 = getelementptr ptr, ptr %t2284, i64 %t2285
  %t2287 = load ptr, ptr %t2286
  %t2288 = call i64 @emit_expr(ptr %t0, ptr %t2287)
  store i64 %t2288, ptr %t2277
  br label %L536
L535:
  %t2289 = alloca ptr
  %t2290 = load ptr, ptr %t1
  %t2291 = sext i32 0 to i64
  %t2292 = getelementptr ptr, ptr %t2290, i64 %t2291
  %t2293 = load ptr, ptr %t2292
  %t2294 = call ptr @emit_lvalue_addr(ptr %t0, ptr %t2293)
  store ptr %t2294, ptr %t2289
  %t2295 = load ptr, ptr %t2289
  %t2296 = icmp ne ptr %t2295, null
  br i1 %t2296, label %L537, label %L538
L537:
  %t2297 = load ptr, ptr %t2289
  %t2298 = call ptr @default_ptr_type()
  %t2299 = call i64 @make_val(ptr %t2297, ptr %t2298)
  store i64 %t2299, ptr %t2277
  %t2300 = load ptr, ptr %t2289
  call void @free(ptr %t2300)
  br label %L539
L538:
  %t2302 = load ptr, ptr %t1
  %t2303 = sext i32 0 to i64
  %t2304 = getelementptr ptr, ptr %t2302, i64 %t2303
  %t2305 = load ptr, ptr %t2304
  %t2306 = call i64 @emit_expr(ptr %t0, ptr %t2305)
  store i64 %t2306, ptr %t2277
  br label %L539
L539:
  br label %L536
L536:
  %t2307 = alloca ptr
  %t2308 = load i64, ptr %t2277
  %t2309 = call i32 @val_is_ptr(i64 %t2308)
  %t2310 = sext i32 %t2309 to i64
  %t2311 = icmp ne i64 %t2310, 0
  br i1 %t2311, label %L540, label %L541
L540:
  %t2312 = load ptr, ptr %t2307
  %t2313 = load ptr, ptr %t2277
  %t2314 = call ptr @strncpy(ptr %t2312, ptr %t2313, i64 63)
  %t2315 = load ptr, ptr %t2307
  %t2317 = sext i32 63 to i64
  %t2316 = getelementptr ptr, ptr %t2315, i64 %t2317
  %t2318 = sext i32 0 to i64
  store i64 %t2318, ptr %t2316
  br label %L542
L541:
  %t2319 = alloca i64
  %t2320 = call i32 @new_reg(ptr %t0)
  %t2321 = sext i32 %t2320 to i64
  store i64 %t2321, ptr %t2319
  %t2322 = alloca ptr
  %t2323 = load i64, ptr %t2277
  %t2324 = load ptr, ptr %t2322
  %t2325 = call i32 @promote_to_i64(ptr %t0, i64 %t2323, ptr %t2324, i64 64)
  %t2326 = sext i32 %t2325 to i64
  %t2327 = load ptr, ptr %t0
  %t2328 = getelementptr [34 x i8], ptr @.str218, i64 0, i64 0
  %t2329 = load i64, ptr %t2319
  %t2330 = load ptr, ptr %t2322
  call void (ptr, ...) @__c0c_emit(ptr %t2327, ptr %t2328, i64 %t2329, ptr %t2330)
  %t2332 = load ptr, ptr %t2307
  %t2333 = getelementptr [6 x i8], ptr @.str219, i64 0, i64 0
  %t2334 = load i64, ptr %t2319
  %t2335 = call i32 (ptr, ...) @snprintf(ptr %t2332, i64 64, ptr %t2333, i64 %t2334)
  %t2336 = sext i32 %t2335 to i64
  br label %L542
L542:
  %t2337 = alloca i64
  %t2338 = call i32 @new_reg(ptr %t0)
  %t2339 = sext i32 %t2338 to i64
  store i64 %t2339, ptr %t2337
  %t2340 = load ptr, ptr %t0
  %t2341 = getelementptr [28 x i8], ptr @.str220, i64 0, i64 0
  %t2342 = load i64, ptr %t2337
  %t2343 = load ptr, ptr %t2307
  call void (ptr, ...) @__c0c_emit(ptr %t2340, ptr %t2341, i64 %t2342, ptr %t2343)
  %t2345 = alloca ptr
  %t2346 = load ptr, ptr %t2345
  %t2347 = getelementptr [6 x i8], ptr @.str221, i64 0, i64 0
  %t2348 = load i64, ptr %t2337
  %t2349 = call i32 (ptr, ...) @snprintf(ptr %t2346, i64 8, ptr %t2347, i64 %t2348)
  %t2350 = sext i32 %t2349 to i64
  %t2351 = load ptr, ptr %t2345
  %t2352 = call ptr @default_ptr_type()
  %t2353 = call i64 @make_val(ptr %t2351, ptr %t2352)
  ret i64 %t2353
L543:
  br label %L4
L29:
  %t2354 = load ptr, ptr %t0
  %t2355 = getelementptr [28 x i8], ptr @.str222, i64 0, i64 0
  %t2356 = load ptr, ptr %t1
  call void (ptr, ...) @__c0c_emit(ptr %t2354, ptr %t2355, ptr %t2356)
  %t2358 = getelementptr [2 x i8], ptr @.str223, i64 0, i64 0
  %t2359 = call ptr @default_int_type()
  %t2360 = call i64 @make_val(ptr %t2358, ptr %t2359)
  ret i64 %t2360
L544:
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
  %t17 = sext i32 %t14 to i64
  %t18 = ptrtoint ptr %t15 to i64
  %t16 = icmp slt i64 %t17, %t18
  %t19 = zext i1 %t16 to i64
  %t20 = icmp ne i64 %t19, 0
  br i1 %t20, label %L26, label %L28
L26:
  %t21 = load ptr, ptr %t1
  %t22 = load i64, ptr %t12
  %t23 = sext i32 %t22 to i64
  %t24 = getelementptr ptr, ptr %t21, i64 %t23
  %t25 = load ptr, ptr %t24
  call void @emit_stmt(ptr %t0, ptr %t25)
  br label %L27
L27:
  %t27 = load i64, ptr %t12
  %t29 = sext i32 %t27 to i64
  %t28 = add i64 %t29, 1
  store i64 %t28, ptr %t12
  br label %L25
L28:
  %t30 = load ptr, ptr %t1
  %t31 = icmp ne ptr %t30, null
  br i1 %t31, label %L29, label %L31
L29:
  call void @scope_pop(ptr %t0)
  br label %L31
L31:
  br label %L4
L32:
  br label %L6
L6:
  %t33 = alloca ptr
  %t34 = load ptr, ptr %t1
  %t35 = icmp ne ptr %t34, null
  br i1 %t35, label %L33, label %L34
L33:
  %t36 = load ptr, ptr %t1
  %t37 = ptrtoint ptr %t36 to i64
  br label %L35
L34:
  %t38 = call ptr @default_int_type()
  %t39 = ptrtoint ptr %t38 to i64
  br label %L35
L35:
  %t40 = phi i64 [ %t37, %L33 ], [ %t39, %L34 ]
  store i64 %t40, ptr %t33
  %t41 = alloca ptr
  %t42 = alloca ptr
  %t43 = load ptr, ptr %t33
  %t44 = load ptr, ptr %t43
  %t46 = ptrtoint ptr %t44 to i64
  %t47 = sext i32 15 to i64
  %t45 = icmp eq i64 %t46, %t47
  %t48 = zext i1 %t45 to i64
  %t49 = icmp ne i64 %t48, 0
  br i1 %t49, label %L36, label %L37
L36:
  br label %L38
L37:
  %t50 = load ptr, ptr %t33
  %t51 = load ptr, ptr %t50
  %t53 = ptrtoint ptr %t51 to i64
  %t54 = sext i32 16 to i64
  %t52 = icmp eq i64 %t53, %t54
  %t55 = zext i1 %t52 to i64
  %t56 = icmp ne i64 %t55, 0
  %t57 = zext i1 %t56 to i64
  br label %L38
L38:
  %t58 = phi i64 [ 1, %L36 ], [ %t57, %L37 ]
  %t59 = icmp ne i64 %t58, 0
  br i1 %t59, label %L39, label %L40
L39:
  %t60 = getelementptr [4 x i8], ptr @.str224, i64 0, i64 0
  store ptr %t60, ptr %t41
  %t61 = call ptr @default_ptr_type()
  store ptr %t61, ptr %t42
  br label %L41
L40:
  %t62 = load ptr, ptr %t33
  %t63 = call i32 @type_is_fp(ptr %t62)
  %t64 = sext i32 %t63 to i64
  %t65 = icmp ne i64 %t64, 0
  br i1 %t65, label %L42, label %L43
L42:
  %t66 = load ptr, ptr %t33
  %t67 = call ptr @llvm_type(ptr %t66)
  store ptr %t67, ptr %t41
  %t68 = load ptr, ptr %t33
  store ptr %t68, ptr %t42
  br label %L44
L43:
  %t69 = getelementptr [4 x i8], ptr @.str225, i64 0, i64 0
  store ptr %t69, ptr %t41
  %t70 = load ptr, ptr %t33
  store ptr %t70, ptr %t42
  br label %L44
L44:
  br label %L41
L41:
  %t71 = alloca i64
  %t72 = call i32 @new_reg(ptr %t0)
  %t73 = sext i32 %t72 to i64
  store i64 %t73, ptr %t71
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr [21 x i8], ptr @.str226, i64 0, i64 0
  %t76 = load i64, ptr %t71
  %t77 = load ptr, ptr %t41
  call void (ptr, ...) @__c0c_emit(ptr %t74, ptr %t75, i64 %t76, ptr %t77)
  %t79 = load ptr, ptr %t0
  %t81 = ptrtoint ptr %t79 to i64
  %t82 = sext i32 2048 to i64
  %t80 = icmp sge i64 %t81, %t82
  %t83 = zext i1 %t80 to i64
  %t84 = icmp ne i64 %t83, 0
  br i1 %t84, label %L45, label %L47
L45:
  %t85 = call ptr @__c0c_stderr()
  %t86 = getelementptr [22 x i8], ptr @.str227, i64 0, i64 0
  %t87 = call i32 (ptr, ...) @fprintf(ptr %t85, ptr %t86)
  %t88 = sext i32 %t87 to i64
  call void @exit(i64 1)
  br label %L47
L47:
  %t90 = alloca ptr
  %t91 = load ptr, ptr %t0
  %t92 = load ptr, ptr %t0
  %t94 = ptrtoint ptr %t92 to i64
  %t93 = add i64 %t94, 1
  store i64 %t93, ptr %t0
  %t96 = ptrtoint ptr %t92 to i64
  %t95 = getelementptr ptr, ptr %t91, i64 %t96
  store ptr %t95, ptr %t90
  %t97 = load ptr, ptr %t1
  %t98 = icmp ne ptr %t97, null
  br i1 %t98, label %L48, label %L49
L48:
  %t99 = load ptr, ptr %t1
  %t100 = ptrtoint ptr %t99 to i64
  br label %L50
L49:
  %t101 = getelementptr [7 x i8], ptr @.str228, i64 0, i64 0
  %t102 = ptrtoint ptr %t101 to i64
  br label %L50
L50:
  %t103 = phi i64 [ %t100, %L48 ], [ %t102, %L49 ]
  %t104 = call ptr @strdup(i64 %t103)
  %t105 = load ptr, ptr %t90
  store ptr %t104, ptr %t105
  %t106 = call ptr @malloc(i64 32)
  %t107 = load ptr, ptr %t90
  store ptr %t106, ptr %t107
  %t108 = load ptr, ptr %t90
  %t109 = load ptr, ptr %t108
  %t110 = getelementptr [6 x i8], ptr @.str229, i64 0, i64 0
  %t111 = load i64, ptr %t71
  %t112 = call i32 (ptr, ...) @snprintf(ptr %t109, i64 32, ptr %t110, i64 %t111)
  %t113 = sext i32 %t112 to i64
  %t114 = load ptr, ptr %t42
  %t115 = load ptr, ptr %t90
  store ptr %t114, ptr %t115
  %t116 = load ptr, ptr %t90
  %t117 = sext i32 0 to i64
  store i64 %t117, ptr %t116
  %t118 = load ptr, ptr %t1
  %t120 = ptrtoint ptr %t118 to i64
  %t121 = sext i32 0 to i64
  %t119 = icmp sgt i64 %t120, %t121
  %t122 = zext i1 %t119 to i64
  %t123 = icmp ne i64 %t122, 0
  br i1 %t123, label %L51, label %L53
L51:
  %t124 = alloca i64
  %t125 = load ptr, ptr %t1
  %t126 = sext i32 0 to i64
  %t127 = getelementptr ptr, ptr %t125, i64 %t126
  %t128 = load ptr, ptr %t127
  %t129 = call i64 @emit_expr(ptr %t0, ptr %t128)
  store i64 %t129, ptr %t124
  %t130 = alloca ptr
  %t131 = load i64, ptr %t124
  %t132 = call i32 @val_is_ptr(i64 %t131)
  %t133 = sext i32 %t132 to i64
  %t134 = icmp ne i64 %t133, 0
  br i1 %t134, label %L54, label %L55
L54:
  %t135 = getelementptr [4 x i8], ptr @.str230, i64 0, i64 0
  store ptr %t135, ptr %t130
  br label %L56
L55:
  %t136 = load ptr, ptr %t124
  %t137 = call i32 @type_is_fp(ptr %t136)
  %t138 = sext i32 %t137 to i64
  %t139 = icmp ne i64 %t138, 0
  br i1 %t139, label %L57, label %L58
L57:
  %t140 = load ptr, ptr %t124
  %t141 = call ptr @llvm_type(ptr %t140)
  store ptr %t141, ptr %t130
  br label %L59
L58:
  %t142 = getelementptr [4 x i8], ptr @.str231, i64 0, i64 0
  store ptr %t142, ptr %t130
  br label %L59
L59:
  br label %L56
L56:
  %t143 = alloca ptr
  %t144 = load i64, ptr %t124
  %t145 = call i32 @val_is_ptr(i64 %t144)
  %t146 = sext i32 %t145 to i64
  %t148 = icmp eq i64 %t146, 0
  %t147 = zext i1 %t148 to i64
  %t149 = icmp ne i64 %t147, 0
  br i1 %t149, label %L60, label %L61
L60:
  %t150 = load i64, ptr %t124
  %t151 = call i32 @val_is_64bit(i64 %t150)
  %t152 = sext i32 %t151 to i64
  %t154 = icmp eq i64 %t152, 0
  %t153 = zext i1 %t154 to i64
  %t155 = icmp ne i64 %t153, 0
  %t156 = zext i1 %t155 to i64
  br label %L62
L61:
  br label %L62
L62:
  %t157 = phi i64 [ %t156, %L60 ], [ 0, %L61 ]
  %t158 = icmp ne i64 %t157, 0
  br i1 %t158, label %L63, label %L64
L63:
  %t159 = load ptr, ptr %t124
  %t160 = call i32 @type_is_fp(ptr %t159)
  %t161 = sext i32 %t160 to i64
  %t163 = icmp eq i64 %t161, 0
  %t162 = zext i1 %t163 to i64
  %t164 = icmp ne i64 %t162, 0
  %t165 = zext i1 %t164 to i64
  br label %L65
L64:
  br label %L65
L65:
  %t166 = phi i64 [ %t165, %L63 ], [ 0, %L64 ]
  %t167 = icmp ne i64 %t166, 0
  br i1 %t167, label %L66, label %L67
L66:
  %t168 = alloca i64
  %t169 = call i32 @new_reg(ptr %t0)
  %t170 = sext i32 %t169 to i64
  store i64 %t170, ptr %t168
  %t171 = load ptr, ptr %t0
  %t172 = getelementptr [30 x i8], ptr @.str232, i64 0, i64 0
  %t173 = load i64, ptr %t168
  %t174 = load ptr, ptr %t124
  call void (ptr, ...) @__c0c_emit(ptr %t171, ptr %t172, i64 %t173, ptr %t174)
  %t176 = load ptr, ptr %t143
  %t177 = getelementptr [6 x i8], ptr @.str233, i64 0, i64 0
  %t178 = load i64, ptr %t168
  %t179 = call i32 (ptr, ...) @snprintf(ptr %t176, i64 64, ptr %t177, i64 %t178)
  %t180 = sext i32 %t179 to i64
  br label %L68
L67:
  %t181 = load ptr, ptr %t143
  %t182 = load ptr, ptr %t124
  %t183 = call ptr @strncpy(ptr %t181, ptr %t182, i64 63)
  %t184 = load ptr, ptr %t143
  %t186 = sext i32 63 to i64
  %t185 = getelementptr ptr, ptr %t184, i64 %t186
  %t187 = sext i32 0 to i64
  store i64 %t187, ptr %t185
  br label %L68
L68:
  %t188 = load ptr, ptr %t0
  %t189 = getelementptr [26 x i8], ptr @.str234, i64 0, i64 0
  %t190 = load ptr, ptr %t130
  %t191 = load ptr, ptr %t143
  %t192 = load i64, ptr %t71
  call void (ptr, ...) @__c0c_emit(ptr %t188, ptr %t189, ptr %t190, ptr %t191, i64 %t192)
  br label %L53
L53:
  %t194 = alloca i64
  %t195 = sext i32 1 to i64
  store i64 %t195, ptr %t194
  br label %L69
L69:
  %t196 = load i64, ptr %t194
  %t197 = load ptr, ptr %t1
  %t199 = sext i32 %t196 to i64
  %t200 = ptrtoint ptr %t197 to i64
  %t198 = icmp slt i64 %t199, %t200
  %t201 = zext i1 %t198 to i64
  %t202 = icmp ne i64 %t201, 0
  br i1 %t202, label %L70, label %L72
L70:
  %t203 = load ptr, ptr %t1
  %t204 = load i64, ptr %t194
  %t205 = sext i32 %t204 to i64
  %t206 = getelementptr ptr, ptr %t203, i64 %t205
  %t207 = load ptr, ptr %t206
  call void @emit_stmt(ptr %t0, ptr %t207)
  br label %L71
L71:
  %t209 = load i64, ptr %t194
  %t211 = sext i32 %t209 to i64
  %t210 = add i64 %t211, 1
  store i64 %t210, ptr %t194
  br label %L69
L72:
  br label %L4
L73:
  br label %L7
L7:
  %t212 = load ptr, ptr %t1
  %t214 = ptrtoint ptr %t212 to i64
  %t215 = sext i32 0 to i64
  %t213 = icmp sgt i64 %t214, %t215
  %t216 = zext i1 %t213 to i64
  %t217 = icmp ne i64 %t216, 0
  br i1 %t217, label %L74, label %L76
L74:
  %t218 = load ptr, ptr %t1
  %t219 = sext i32 0 to i64
  %t220 = getelementptr ptr, ptr %t218, i64 %t219
  %t221 = load ptr, ptr %t220
  %t222 = call i64 @emit_expr(ptr %t0, ptr %t221)
  br label %L76
L76:
  br label %L4
L77:
  br label %L8
L8:
  %t223 = load ptr, ptr %t1
  %t224 = icmp ne ptr %t223, null
  br i1 %t224, label %L78, label %L79
L78:
  %t225 = alloca i64
  %t226 = load ptr, ptr %t1
  %t227 = call i64 @emit_expr(ptr %t0, ptr %t226)
  store i64 %t227, ptr %t225
  %t228 = alloca ptr
  %t229 = load ptr, ptr %t0
  store ptr %t229, ptr %t228
  %t230 = alloca i64
  %t231 = load ptr, ptr %t228
  %t232 = load ptr, ptr %t231
  %t234 = ptrtoint ptr %t232 to i64
  %t235 = sext i32 15 to i64
  %t233 = icmp eq i64 %t234, %t235
  %t236 = zext i1 %t233 to i64
  %t237 = icmp ne i64 %t236, 0
  br i1 %t237, label %L81, label %L82
L81:
  br label %L83
L82:
  %t238 = load ptr, ptr %t228
  %t239 = load ptr, ptr %t238
  %t241 = ptrtoint ptr %t239 to i64
  %t242 = sext i32 16 to i64
  %t240 = icmp eq i64 %t241, %t242
  %t243 = zext i1 %t240 to i64
  %t244 = icmp ne i64 %t243, 0
  %t245 = zext i1 %t244 to i64
  br label %L83
L83:
  %t246 = phi i64 [ 1, %L81 ], [ %t245, %L82 ]
  store i64 %t246, ptr %t230
  %t247 = alloca i64
  %t248 = load ptr, ptr %t228
  %t249 = load ptr, ptr %t248
  %t251 = ptrtoint ptr %t249 to i64
  %t252 = sext i32 0 to i64
  %t250 = icmp eq i64 %t251, %t252
  %t253 = zext i1 %t250 to i64
  store i64 %t253, ptr %t247
  %t254 = alloca i64
  %t255 = load ptr, ptr %t228
  %t256 = call i32 @type_is_fp(ptr %t255)
  %t257 = sext i32 %t256 to i64
  store i64 %t257, ptr %t254
  %t258 = alloca ptr
  %t259 = load ptr, ptr %t228
  %t260 = call ptr @llvm_type(ptr %t259)
  store ptr %t260, ptr %t258
  %t261 = load i64, ptr %t247
  %t263 = sext i32 %t261 to i64
  %t262 = icmp ne i64 %t263, 0
  br i1 %t262, label %L84, label %L85
L84:
  %t264 = load ptr, ptr %t0
  %t265 = getelementptr [12 x i8], ptr @.str235, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t264, ptr %t265)
  br label %L86
L85:
  %t267 = load i64, ptr %t254
  %t269 = sext i32 %t267 to i64
  %t268 = icmp ne i64 %t269, 0
  br i1 %t268, label %L87, label %L88
L87:
  %t270 = load ptr, ptr %t0
  %t271 = getelementptr [13 x i8], ptr @.str236, i64 0, i64 0
  %t272 = load ptr, ptr %t258
  %t273 = load ptr, ptr %t225
  call void (ptr, ...) @__c0c_emit(ptr %t270, ptr %t271, ptr %t272, ptr %t273)
  br label %L89
L88:
  %t275 = load i64, ptr %t230
  %t277 = sext i32 %t275 to i64
  %t276 = icmp ne i64 %t277, 0
  br i1 %t276, label %L90, label %L91
L90:
  %t278 = load i64, ptr %t225
  %t279 = call i32 @val_is_ptr(i64 %t278)
  %t280 = sext i32 %t279 to i64
  %t281 = icmp ne i64 %t280, 0
  br i1 %t281, label %L93, label %L94
L93:
  %t282 = load ptr, ptr %t0
  %t283 = getelementptr [14 x i8], ptr @.str237, i64 0, i64 0
  %t284 = load ptr, ptr %t225
  call void (ptr, ...) @__c0c_emit(ptr %t282, ptr %t283, ptr %t284)
  br label %L95
L94:
  %t286 = alloca i64
  %t287 = call i32 @new_reg(ptr %t0)
  %t288 = sext i32 %t287 to i64
  store i64 %t288, ptr %t286
  %t289 = alloca ptr
  %t290 = load i64, ptr %t225
  %t291 = load ptr, ptr %t289
  %t292 = call i32 @promote_to_i64(ptr %t0, i64 %t290, ptr %t291, i64 64)
  %t293 = sext i32 %t292 to i64
  %t294 = load ptr, ptr %t0
  %t295 = getelementptr [34 x i8], ptr @.str238, i64 0, i64 0
  %t296 = load i64, ptr %t286
  %t297 = load ptr, ptr %t289
  call void (ptr, ...) @__c0c_emit(ptr %t294, ptr %t295, i64 %t296, ptr %t297)
  %t299 = load ptr, ptr %t0
  %t300 = getelementptr [17 x i8], ptr @.str239, i64 0, i64 0
  %t301 = load i64, ptr %t286
  call void (ptr, ...) @__c0c_emit(ptr %t299, ptr %t300, i64 %t301)
  br label %L95
L95:
  br label %L92
L91:
  %t303 = alloca ptr
  %t304 = load i64, ptr %t225
  %t305 = load ptr, ptr %t303
  %t306 = call i32 @promote_to_i64(ptr %t0, i64 %t304, ptr %t305, i64 64)
  %t307 = sext i32 %t306 to i64
  %t308 = load ptr, ptr %t258
  %t309 = getelementptr [3 x i8], ptr @.str240, i64 0, i64 0
  %t310 = call i32 @strcmp(ptr %t308, ptr %t309)
  %t311 = sext i32 %t310 to i64
  %t313 = sext i32 0 to i64
  %t312 = icmp eq i64 %t311, %t313
  %t314 = zext i1 %t312 to i64
  %t315 = icmp ne i64 %t314, 0
  br i1 %t315, label %L96, label %L97
L96:
  %t316 = alloca i64
  %t317 = call i32 @new_reg(ptr %t0)
  %t318 = sext i32 %t317 to i64
  store i64 %t318, ptr %t316
  %t319 = load ptr, ptr %t0
  %t320 = getelementptr [30 x i8], ptr @.str241, i64 0, i64 0
  %t321 = load i64, ptr %t316
  %t322 = load ptr, ptr %t303
  call void (ptr, ...) @__c0c_emit(ptr %t319, ptr %t320, i64 %t321, ptr %t322)
  %t324 = load ptr, ptr %t0
  %t325 = getelementptr [16 x i8], ptr @.str242, i64 0, i64 0
  %t326 = load i64, ptr %t316
  call void (ptr, ...) @__c0c_emit(ptr %t324, ptr %t325, i64 %t326)
  br label %L98
L97:
  %t328 = load ptr, ptr %t258
  %t329 = getelementptr [4 x i8], ptr @.str243, i64 0, i64 0
  %t330 = call i32 @strcmp(ptr %t328, ptr %t329)
  %t331 = sext i32 %t330 to i64
  %t333 = sext i32 0 to i64
  %t332 = icmp eq i64 %t331, %t333
  %t334 = zext i1 %t332 to i64
  %t335 = icmp ne i64 %t334, 0
  br i1 %t335, label %L99, label %L100
L99:
  %t336 = alloca i64
  %t337 = call i32 @new_reg(ptr %t0)
  %t338 = sext i32 %t337 to i64
  store i64 %t338, ptr %t336
  %t339 = load ptr, ptr %t0
  %t340 = getelementptr [31 x i8], ptr @.str244, i64 0, i64 0
  %t341 = load i64, ptr %t336
  %t342 = load ptr, ptr %t303
  call void (ptr, ...) @__c0c_emit(ptr %t339, ptr %t340, i64 %t341, ptr %t342)
  %t344 = load ptr, ptr %t0
  %t345 = getelementptr [17 x i8], ptr @.str245, i64 0, i64 0
  %t346 = load i64, ptr %t336
  call void (ptr, ...) @__c0c_emit(ptr %t344, ptr %t345, i64 %t346)
  br label %L101
L100:
  %t348 = load ptr, ptr %t258
  %t349 = getelementptr [4 x i8], ptr @.str246, i64 0, i64 0
  %t350 = call i32 @strcmp(ptr %t348, ptr %t349)
  %t351 = sext i32 %t350 to i64
  %t353 = sext i32 0 to i64
  %t352 = icmp eq i64 %t351, %t353
  %t354 = zext i1 %t352 to i64
  %t355 = icmp ne i64 %t354, 0
  br i1 %t355, label %L102, label %L103
L102:
  %t356 = alloca i64
  %t357 = call i32 @new_reg(ptr %t0)
  %t358 = sext i32 %t357 to i64
  store i64 %t358, ptr %t356
  %t359 = load ptr, ptr %t0
  %t360 = getelementptr [31 x i8], ptr @.str247, i64 0, i64 0
  %t361 = load i64, ptr %t356
  %t362 = load ptr, ptr %t303
  call void (ptr, ...) @__c0c_emit(ptr %t359, ptr %t360, i64 %t361, ptr %t362)
  %t364 = load ptr, ptr %t0
  %t365 = getelementptr [17 x i8], ptr @.str248, i64 0, i64 0
  %t366 = load i64, ptr %t356
  call void (ptr, ...) @__c0c_emit(ptr %t364, ptr %t365, i64 %t366)
  br label %L104
L103:
  %t368 = load ptr, ptr %t0
  %t369 = getelementptr [14 x i8], ptr @.str249, i64 0, i64 0
  %t370 = load ptr, ptr %t303
  call void (ptr, ...) @__c0c_emit(ptr %t368, ptr %t369, ptr %t370)
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
  %t372 = load ptr, ptr %t0
  %t373 = getelementptr [12 x i8], ptr @.str250, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t372, ptr %t373)
  br label %L80
L80:
  %t375 = alloca i64
  %t376 = call i32 @new_label(ptr %t0)
  %t377 = sext i32 %t376 to i64
  store i64 %t377, ptr %t375
  %t378 = load ptr, ptr %t0
  %t379 = getelementptr [6 x i8], ptr @.str251, i64 0, i64 0
  %t380 = load i64, ptr %t375
  call void (ptr, ...) @__c0c_emit(ptr %t378, ptr %t379, i64 %t380)
  br label %L4
L105:
  br label %L9
L9:
  %t382 = alloca i64
  %t383 = load ptr, ptr %t1
  %t384 = call i64 @emit_expr(ptr %t0, ptr %t383)
  store i64 %t384, ptr %t382
  %t385 = alloca i64
  %t386 = load i64, ptr %t382
  %t387 = call i32 @emit_cond(ptr %t0, i64 %t386)
  %t388 = sext i32 %t387 to i64
  store i64 %t388, ptr %t385
  %t389 = alloca i64
  %t390 = call i32 @new_label(ptr %t0)
  %t391 = sext i32 %t390 to i64
  store i64 %t391, ptr %t389
  %t392 = alloca i64
  %t393 = call i32 @new_label(ptr %t0)
  %t394 = sext i32 %t393 to i64
  store i64 %t394, ptr %t392
  %t395 = alloca i64
  %t396 = call i32 @new_label(ptr %t0)
  %t397 = sext i32 %t396 to i64
  store i64 %t397, ptr %t395
  %t398 = load ptr, ptr %t0
  %t399 = getelementptr [41 x i8], ptr @.str252, i64 0, i64 0
  %t400 = load i64, ptr %t385
  %t401 = load i64, ptr %t389
  %t402 = load ptr, ptr %t1
  %t403 = icmp ne ptr %t402, null
  br i1 %t403, label %L106, label %L107
L106:
  %t404 = load i64, ptr %t392
  %t405 = sext i32 %t404 to i64
  br label %L108
L107:
  %t406 = load i64, ptr %t395
  %t407 = sext i32 %t406 to i64
  br label %L108
L108:
  %t408 = phi i64 [ %t405, %L106 ], [ %t407, %L107 ]
  call void (ptr, ...) @__c0c_emit(ptr %t398, ptr %t399, i64 %t400, i64 %t401, i64 %t408)
  %t410 = load ptr, ptr %t0
  %t411 = getelementptr [6 x i8], ptr @.str253, i64 0, i64 0
  %t412 = load i64, ptr %t389
  call void (ptr, ...) @__c0c_emit(ptr %t410, ptr %t411, i64 %t412)
  %t414 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t414)
  %t416 = load ptr, ptr %t0
  %t417 = getelementptr [18 x i8], ptr @.str254, i64 0, i64 0
  %t418 = load i64, ptr %t395
  call void (ptr, ...) @__c0c_emit(ptr %t416, ptr %t417, i64 %t418)
  %t420 = load ptr, ptr %t1
  %t421 = icmp ne ptr %t420, null
  br i1 %t421, label %L109, label %L111
L109:
  %t422 = load ptr, ptr %t0
  %t423 = getelementptr [6 x i8], ptr @.str255, i64 0, i64 0
  %t424 = load i64, ptr %t392
  call void (ptr, ...) @__c0c_emit(ptr %t422, ptr %t423, i64 %t424)
  %t426 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t426)
  %t428 = load ptr, ptr %t0
  %t429 = getelementptr [18 x i8], ptr @.str256, i64 0, i64 0
  %t430 = load i64, ptr %t395
  call void (ptr, ...) @__c0c_emit(ptr %t428, ptr %t429, i64 %t430)
  br label %L111
L111:
  %t432 = load ptr, ptr %t0
  %t433 = getelementptr [6 x i8], ptr @.str257, i64 0, i64 0
  %t434 = load i64, ptr %t395
  call void (ptr, ...) @__c0c_emit(ptr %t432, ptr %t433, i64 %t434)
  br label %L4
L112:
  br label %L10
L10:
  %t436 = alloca i64
  %t437 = call i32 @new_label(ptr %t0)
  %t438 = sext i32 %t437 to i64
  store i64 %t438, ptr %t436
  %t439 = alloca i64
  %t440 = call i32 @new_label(ptr %t0)
  %t441 = sext i32 %t440 to i64
  store i64 %t441, ptr %t439
  %t442 = alloca i64
  %t443 = call i32 @new_label(ptr %t0)
  %t444 = sext i32 %t443 to i64
  store i64 %t444, ptr %t442
  %t445 = alloca ptr
  %t446 = alloca ptr
  %t447 = load ptr, ptr %t445
  %t448 = load ptr, ptr %t0
  %t449 = call ptr @strcpy(ptr %t447, ptr %t448)
  %t450 = load ptr, ptr %t446
  %t451 = load ptr, ptr %t0
  %t452 = call ptr @strcpy(ptr %t450, ptr %t451)
  %t453 = load ptr, ptr %t0
  %t454 = getelementptr [4 x i8], ptr @.str258, i64 0, i64 0
  %t455 = load i64, ptr %t442
  %t456 = call i32 (ptr, ...) @snprintf(ptr %t453, i64 64, ptr %t454, i64 %t455)
  %t457 = sext i32 %t456 to i64
  %t458 = load ptr, ptr %t0
  %t459 = getelementptr [4 x i8], ptr @.str259, i64 0, i64 0
  %t460 = load i64, ptr %t436
  %t461 = call i32 (ptr, ...) @snprintf(ptr %t458, i64 64, ptr %t459, i64 %t460)
  %t462 = sext i32 %t461 to i64
  %t463 = load ptr, ptr %t0
  %t464 = getelementptr [18 x i8], ptr @.str260, i64 0, i64 0
  %t465 = load i64, ptr %t436
  call void (ptr, ...) @__c0c_emit(ptr %t463, ptr %t464, i64 %t465)
  %t467 = load ptr, ptr %t0
  %t468 = getelementptr [6 x i8], ptr @.str261, i64 0, i64 0
  %t469 = load i64, ptr %t436
  call void (ptr, ...) @__c0c_emit(ptr %t467, ptr %t468, i64 %t469)
  %t471 = alloca i64
  %t472 = load ptr, ptr %t1
  %t473 = call i64 @emit_expr(ptr %t0, ptr %t472)
  store i64 %t473, ptr %t471
  %t474 = alloca i64
  %t475 = load i64, ptr %t471
  %t476 = call i32 @emit_cond(ptr %t0, i64 %t475)
  %t477 = sext i32 %t476 to i64
  store i64 %t477, ptr %t474
  %t478 = load ptr, ptr %t0
  %t479 = getelementptr [41 x i8], ptr @.str262, i64 0, i64 0
  %t480 = load i64, ptr %t474
  %t481 = load i64, ptr %t439
  %t482 = load i64, ptr %t442
  call void (ptr, ...) @__c0c_emit(ptr %t478, ptr %t479, i64 %t480, i64 %t481, i64 %t482)
  %t484 = load ptr, ptr %t0
  %t485 = getelementptr [6 x i8], ptr @.str263, i64 0, i64 0
  %t486 = load i64, ptr %t439
  call void (ptr, ...) @__c0c_emit(ptr %t484, ptr %t485, i64 %t486)
  %t488 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t488)
  %t490 = load ptr, ptr %t0
  %t491 = getelementptr [18 x i8], ptr @.str264, i64 0, i64 0
  %t492 = load i64, ptr %t436
  call void (ptr, ...) @__c0c_emit(ptr %t490, ptr %t491, i64 %t492)
  %t494 = load ptr, ptr %t0
  %t495 = getelementptr [6 x i8], ptr @.str265, i64 0, i64 0
  %t496 = load i64, ptr %t442
  call void (ptr, ...) @__c0c_emit(ptr %t494, ptr %t495, i64 %t496)
  %t498 = load ptr, ptr %t0
  %t499 = load ptr, ptr %t445
  %t500 = call ptr @strcpy(ptr %t498, ptr %t499)
  %t501 = load ptr, ptr %t0
  %t502 = load ptr, ptr %t446
  %t503 = call ptr @strcpy(ptr %t501, ptr %t502)
  br label %L4
L113:
  br label %L11
L11:
  %t504 = alloca i64
  %t505 = call i32 @new_label(ptr %t0)
  %t506 = sext i32 %t505 to i64
  store i64 %t506, ptr %t504
  %t507 = alloca i64
  %t508 = call i32 @new_label(ptr %t0)
  %t509 = sext i32 %t508 to i64
  store i64 %t509, ptr %t507
  %t510 = alloca i64
  %t511 = call i32 @new_label(ptr %t0)
  %t512 = sext i32 %t511 to i64
  store i64 %t512, ptr %t510
  %t513 = alloca ptr
  %t514 = alloca ptr
  %t515 = load ptr, ptr %t513
  %t516 = load ptr, ptr %t0
  %t517 = call ptr @strcpy(ptr %t515, ptr %t516)
  %t518 = load ptr, ptr %t514
  %t519 = load ptr, ptr %t0
  %t520 = call ptr @strcpy(ptr %t518, ptr %t519)
  %t521 = load ptr, ptr %t0
  %t522 = getelementptr [4 x i8], ptr @.str266, i64 0, i64 0
  %t523 = load i64, ptr %t510
  %t524 = call i32 (ptr, ...) @snprintf(ptr %t521, i64 64, ptr %t522, i64 %t523)
  %t525 = sext i32 %t524 to i64
  %t526 = load ptr, ptr %t0
  %t527 = getelementptr [4 x i8], ptr @.str267, i64 0, i64 0
  %t528 = load i64, ptr %t507
  %t529 = call i32 (ptr, ...) @snprintf(ptr %t526, i64 64, ptr %t527, i64 %t528)
  %t530 = sext i32 %t529 to i64
  %t531 = load ptr, ptr %t0
  %t532 = getelementptr [18 x i8], ptr @.str268, i64 0, i64 0
  %t533 = load i64, ptr %t504
  call void (ptr, ...) @__c0c_emit(ptr %t531, ptr %t532, i64 %t533)
  %t535 = load ptr, ptr %t0
  %t536 = getelementptr [6 x i8], ptr @.str269, i64 0, i64 0
  %t537 = load i64, ptr %t504
  call void (ptr, ...) @__c0c_emit(ptr %t535, ptr %t536, i64 %t537)
  %t539 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t539)
  %t541 = load ptr, ptr %t0
  %t542 = getelementptr [18 x i8], ptr @.str270, i64 0, i64 0
  %t543 = load i64, ptr %t507
  call void (ptr, ...) @__c0c_emit(ptr %t541, ptr %t542, i64 %t543)
  %t545 = load ptr, ptr %t0
  %t546 = getelementptr [6 x i8], ptr @.str271, i64 0, i64 0
  %t547 = load i64, ptr %t507
  call void (ptr, ...) @__c0c_emit(ptr %t545, ptr %t546, i64 %t547)
  %t549 = alloca i64
  %t550 = load ptr, ptr %t1
  %t551 = call i64 @emit_expr(ptr %t0, ptr %t550)
  store i64 %t551, ptr %t549
  %t552 = alloca i64
  %t553 = load i64, ptr %t549
  %t554 = call i32 @emit_cond(ptr %t0, i64 %t553)
  %t555 = sext i32 %t554 to i64
  store i64 %t555, ptr %t552
  %t556 = load ptr, ptr %t0
  %t557 = getelementptr [41 x i8], ptr @.str272, i64 0, i64 0
  %t558 = load i64, ptr %t552
  %t559 = load i64, ptr %t504
  %t560 = load i64, ptr %t510
  call void (ptr, ...) @__c0c_emit(ptr %t556, ptr %t557, i64 %t558, i64 %t559, i64 %t560)
  %t562 = load ptr, ptr %t0
  %t563 = getelementptr [6 x i8], ptr @.str273, i64 0, i64 0
  %t564 = load i64, ptr %t510
  call void (ptr, ...) @__c0c_emit(ptr %t562, ptr %t563, i64 %t564)
  %t566 = load ptr, ptr %t0
  %t567 = load ptr, ptr %t513
  %t568 = call ptr @strcpy(ptr %t566, ptr %t567)
  %t569 = load ptr, ptr %t0
  %t570 = load ptr, ptr %t514
  %t571 = call ptr @strcpy(ptr %t569, ptr %t570)
  br label %L4
L114:
  br label %L12
L12:
  %t572 = alloca i64
  %t573 = call i32 @new_label(ptr %t0)
  %t574 = sext i32 %t573 to i64
  store i64 %t574, ptr %t572
  %t575 = alloca i64
  %t576 = call i32 @new_label(ptr %t0)
  %t577 = sext i32 %t576 to i64
  store i64 %t577, ptr %t575
  %t578 = alloca i64
  %t579 = call i32 @new_label(ptr %t0)
  %t580 = sext i32 %t579 to i64
  store i64 %t580, ptr %t578
  %t581 = alloca i64
  %t582 = call i32 @new_label(ptr %t0)
  %t583 = sext i32 %t582 to i64
  store i64 %t583, ptr %t581
  %t584 = alloca ptr
  %t585 = alloca ptr
  %t586 = load ptr, ptr %t584
  %t587 = load ptr, ptr %t0
  %t588 = call ptr @strcpy(ptr %t586, ptr %t587)
  %t589 = load ptr, ptr %t585
  %t590 = load ptr, ptr %t0
  %t591 = call ptr @strcpy(ptr %t589, ptr %t590)
  %t592 = load ptr, ptr %t0
  %t593 = getelementptr [4 x i8], ptr @.str274, i64 0, i64 0
  %t594 = load i64, ptr %t581
  %t595 = call i32 (ptr, ...) @snprintf(ptr %t592, i64 64, ptr %t593, i64 %t594)
  %t596 = sext i32 %t595 to i64
  %t597 = load ptr, ptr %t0
  %t598 = getelementptr [4 x i8], ptr @.str275, i64 0, i64 0
  %t599 = load i64, ptr %t578
  %t600 = call i32 (ptr, ...) @snprintf(ptr %t597, i64 64, ptr %t598, i64 %t599)
  %t601 = sext i32 %t600 to i64
  call void @scope_push(ptr %t0)
  %t603 = load ptr, ptr %t1
  %t604 = icmp ne ptr %t603, null
  br i1 %t604, label %L115, label %L117
L115:
  %t605 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t605)
  br label %L117
L117:
  %t607 = load ptr, ptr %t0
  %t608 = getelementptr [18 x i8], ptr @.str276, i64 0, i64 0
  %t609 = load i64, ptr %t572
  call void (ptr, ...) @__c0c_emit(ptr %t607, ptr %t608, i64 %t609)
  %t611 = load ptr, ptr %t0
  %t612 = getelementptr [6 x i8], ptr @.str277, i64 0, i64 0
  %t613 = load i64, ptr %t572
  call void (ptr, ...) @__c0c_emit(ptr %t611, ptr %t612, i64 %t613)
  %t615 = load ptr, ptr %t1
  %t616 = icmp ne ptr %t615, null
  br i1 %t616, label %L118, label %L119
L118:
  %t617 = alloca i64
  %t618 = load ptr, ptr %t1
  %t619 = call i64 @emit_expr(ptr %t0, ptr %t618)
  store i64 %t619, ptr %t617
  %t620 = alloca i64
  %t621 = load i64, ptr %t617
  %t622 = call i32 @emit_cond(ptr %t0, i64 %t621)
  %t623 = sext i32 %t622 to i64
  store i64 %t623, ptr %t620
  %t624 = load ptr, ptr %t0
  %t625 = getelementptr [41 x i8], ptr @.str278, i64 0, i64 0
  %t626 = load i64, ptr %t620
  %t627 = load i64, ptr %t575
  %t628 = load i64, ptr %t581
  call void (ptr, ...) @__c0c_emit(ptr %t624, ptr %t625, i64 %t626, i64 %t627, i64 %t628)
  br label %L120
L119:
  %t630 = load ptr, ptr %t0
  %t631 = getelementptr [18 x i8], ptr @.str279, i64 0, i64 0
  %t632 = load i64, ptr %t575
  call void (ptr, ...) @__c0c_emit(ptr %t630, ptr %t631, i64 %t632)
  br label %L120
L120:
  %t634 = load ptr, ptr %t0
  %t635 = getelementptr [6 x i8], ptr @.str280, i64 0, i64 0
  %t636 = load i64, ptr %t575
  call void (ptr, ...) @__c0c_emit(ptr %t634, ptr %t635, i64 %t636)
  %t638 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t638)
  %t640 = load ptr, ptr %t0
  %t641 = getelementptr [18 x i8], ptr @.str281, i64 0, i64 0
  %t642 = load i64, ptr %t578
  call void (ptr, ...) @__c0c_emit(ptr %t640, ptr %t641, i64 %t642)
  %t644 = load ptr, ptr %t0
  %t645 = getelementptr [6 x i8], ptr @.str282, i64 0, i64 0
  %t646 = load i64, ptr %t578
  call void (ptr, ...) @__c0c_emit(ptr %t644, ptr %t645, i64 %t646)
  %t648 = load ptr, ptr %t1
  %t649 = icmp ne ptr %t648, null
  br i1 %t649, label %L121, label %L123
L121:
  %t650 = load ptr, ptr %t1
  %t651 = call i64 @emit_expr(ptr %t0, ptr %t650)
  br label %L123
L123:
  %t652 = load ptr, ptr %t0
  %t653 = getelementptr [18 x i8], ptr @.str283, i64 0, i64 0
  %t654 = load i64, ptr %t572
  call void (ptr, ...) @__c0c_emit(ptr %t652, ptr %t653, i64 %t654)
  %t656 = load ptr, ptr %t0
  %t657 = getelementptr [6 x i8], ptr @.str284, i64 0, i64 0
  %t658 = load i64, ptr %t581
  call void (ptr, ...) @__c0c_emit(ptr %t656, ptr %t657, i64 %t658)
  call void @scope_pop(ptr %t0)
  %t661 = load ptr, ptr %t0
  %t662 = load ptr, ptr %t584
  %t663 = call ptr @strcpy(ptr %t661, ptr %t662)
  %t664 = load ptr, ptr %t0
  %t665 = load ptr, ptr %t585
  %t666 = call ptr @strcpy(ptr %t664, ptr %t665)
  br label %L4
L124:
  br label %L13
L13:
  %t667 = load ptr, ptr %t0
  %t668 = getelementptr [17 x i8], ptr @.str285, i64 0, i64 0
  %t669 = load ptr, ptr %t0
  call void (ptr, ...) @__c0c_emit(ptr %t667, ptr %t668, ptr %t669)
  %t671 = alloca i64
  %t672 = call i32 @new_label(ptr %t0)
  %t673 = sext i32 %t672 to i64
  store i64 %t673, ptr %t671
  %t674 = load ptr, ptr %t0
  %t675 = getelementptr [6 x i8], ptr @.str286, i64 0, i64 0
  %t676 = load i64, ptr %t671
  call void (ptr, ...) @__c0c_emit(ptr %t674, ptr %t675, i64 %t676)
  br label %L4
L125:
  br label %L14
L14:
  %t678 = load ptr, ptr %t0
  %t679 = getelementptr [17 x i8], ptr @.str287, i64 0, i64 0
  %t680 = load ptr, ptr %t0
  call void (ptr, ...) @__c0c_emit(ptr %t678, ptr %t679, ptr %t680)
  %t682 = alloca i64
  %t683 = call i32 @new_label(ptr %t0)
  %t684 = sext i32 %t683 to i64
  store i64 %t684, ptr %t682
  %t685 = load ptr, ptr %t0
  %t686 = getelementptr [6 x i8], ptr @.str288, i64 0, i64 0
  %t687 = load i64, ptr %t682
  call void (ptr, ...) @__c0c_emit(ptr %t685, ptr %t686, i64 %t687)
  br label %L4
L126:
  br label %L15
L15:
  %t689 = alloca i64
  %t690 = load ptr, ptr %t1
  %t691 = call i64 @emit_expr(ptr %t0, ptr %t690)
  store i64 %t691, ptr %t689
  %t692 = alloca i64
  %t693 = call i32 @new_label(ptr %t0)
  %t694 = sext i32 %t693 to i64
  store i64 %t694, ptr %t692
  %t695 = alloca ptr
  %t696 = load ptr, ptr %t695
  %t697 = load ptr, ptr %t0
  %t698 = call ptr @strcpy(ptr %t696, ptr %t697)
  %t699 = load ptr, ptr %t0
  %t700 = getelementptr [4 x i8], ptr @.str289, i64 0, i64 0
  %t701 = load i64, ptr %t692
  %t702 = call i32 (ptr, ...) @snprintf(ptr %t699, i64 64, ptr %t700, i64 %t701)
  %t703 = sext i32 %t702 to i64
  %t704 = alloca ptr
  %t705 = load ptr, ptr %t1
  store ptr %t705, ptr %t704
  %t706 = alloca i64
  %t707 = sext i32 0 to i64
  store i64 %t707, ptr %t706
  %t708 = alloca ptr
  %t709 = alloca ptr
  %t710 = alloca i64
  %t711 = load i64, ptr %t692
  %t712 = sext i32 %t711 to i64
  store i64 %t712, ptr %t710
  %t713 = alloca i64
  %t714 = sext i32 0 to i64
  store i64 %t714, ptr %t713
  br label %L127
L127:
  %t715 = load i64, ptr %t713
  %t716 = load ptr, ptr %t704
  %t717 = load ptr, ptr %t716
  %t719 = sext i32 %t715 to i64
  %t720 = ptrtoint ptr %t717 to i64
  %t718 = icmp slt i64 %t719, %t720
  %t721 = zext i1 %t718 to i64
  %t722 = icmp ne i64 %t721, 0
  br i1 %t722, label %L131, label %L132
L131:
  %t723 = load i64, ptr %t706
  %t725 = sext i32 %t723 to i64
  %t726 = sext i32 256 to i64
  %t724 = icmp slt i64 %t725, %t726
  %t727 = zext i1 %t724 to i64
  %t728 = icmp ne i64 %t727, 0
  %t729 = zext i1 %t728 to i64
  br label %L133
L132:
  br label %L133
L133:
  %t730 = phi i64 [ %t729, %L131 ], [ 0, %L132 ]
  %t731 = icmp ne i64 %t730, 0
  br i1 %t731, label %L128, label %L130
L128:
  %t732 = alloca ptr
  %t733 = load ptr, ptr %t704
  %t734 = load ptr, ptr %t733
  %t735 = load i64, ptr %t713
  %t736 = sext i32 %t735 to i64
  %t737 = getelementptr ptr, ptr %t734, i64 %t736
  %t738 = load ptr, ptr %t737
  store ptr %t738, ptr %t732
  %t739 = load ptr, ptr %t732
  %t740 = load ptr, ptr %t739
  %t742 = ptrtoint ptr %t740 to i64
  %t743 = sext i32 14 to i64
  %t741 = icmp eq i64 %t742, %t743
  %t744 = zext i1 %t741 to i64
  %t745 = icmp ne i64 %t744, 0
  br i1 %t745, label %L134, label %L135
L134:
  %t746 = call i32 @new_label(ptr %t0)
  %t747 = sext i32 %t746 to i64
  %t748 = load ptr, ptr %t708
  %t749 = load i64, ptr %t706
  %t751 = sext i32 %t749 to i64
  %t750 = getelementptr ptr, ptr %t748, i64 %t751
  store i64 %t747, ptr %t750
  %t752 = load ptr, ptr %t732
  %t753 = load ptr, ptr %t752
  %t754 = icmp ne ptr %t753, null
  br i1 %t754, label %L137, label %L138
L137:
  %t755 = load ptr, ptr %t732
  %t756 = load ptr, ptr %t755
  %t757 = load ptr, ptr %t756
  %t758 = ptrtoint ptr %t757 to i64
  br label %L139
L138:
  %t759 = sext i32 0 to i64
  br label %L139
L139:
  %t760 = phi i64 [ %t758, %L137 ], [ %t759, %L138 ]
  %t761 = load ptr, ptr %t709
  %t762 = load i64, ptr %t706
  %t764 = sext i32 %t762 to i64
  %t763 = getelementptr ptr, ptr %t761, i64 %t764
  store i64 %t760, ptr %t763
  %t765 = load i64, ptr %t706
  %t767 = sext i32 %t765 to i64
  %t766 = add i64 %t767, 1
  store i64 %t766, ptr %t706
  br label %L136
L135:
  %t768 = load ptr, ptr %t732
  %t769 = load ptr, ptr %t768
  %t771 = ptrtoint ptr %t769 to i64
  %t772 = sext i32 15 to i64
  %t770 = icmp eq i64 %t771, %t772
  %t773 = zext i1 %t770 to i64
  %t774 = icmp ne i64 %t773, 0
  br i1 %t774, label %L140, label %L142
L140:
  %t775 = call i32 @new_label(ptr %t0)
  %t776 = sext i32 %t775 to i64
  store i64 %t776, ptr %t710
  br label %L142
L142:
  br label %L136
L136:
  br label %L129
L129:
  %t777 = load i64, ptr %t713
  %t779 = sext i32 %t777 to i64
  %t778 = add i64 %t779, 1
  store i64 %t778, ptr %t713
  br label %L127
L130:
  %t780 = alloca ptr
  %t781 = load i64, ptr %t689
  %t782 = load ptr, ptr %t780
  %t783 = call i32 @promote_to_i64(ptr %t0, i64 %t781, ptr %t782, i64 64)
  %t784 = sext i32 %t783 to i64
  %t785 = alloca i64
  %t786 = call i32 @new_reg(ptr %t0)
  %t787 = sext i32 %t786 to i64
  store i64 %t787, ptr %t785
  %t788 = load ptr, ptr %t0
  %t789 = getelementptr [25 x i8], ptr @.str290, i64 0, i64 0
  %t790 = load i64, ptr %t785
  %t791 = load ptr, ptr %t780
  call void (ptr, ...) @__c0c_emit(ptr %t788, ptr %t789, i64 %t790, ptr %t791)
  %t793 = load ptr, ptr %t0
  %t794 = getelementptr [35 x i8], ptr @.str291, i64 0, i64 0
  %t795 = load i64, ptr %t785
  %t796 = load i64, ptr %t710
  call void (ptr, ...) @__c0c_emit(ptr %t793, ptr %t794, i64 %t795, i64 %t796)
  %t798 = alloca i64
  %t799 = sext i32 0 to i64
  store i64 %t799, ptr %t798
  %t800 = alloca i64
  %t801 = sext i32 0 to i64
  store i64 %t801, ptr %t800
  br label %L143
L143:
  %t802 = load i64, ptr %t800
  %t803 = load ptr, ptr %t704
  %t804 = load ptr, ptr %t803
  %t806 = sext i32 %t802 to i64
  %t807 = ptrtoint ptr %t804 to i64
  %t805 = icmp slt i64 %t806, %t807
  %t808 = zext i1 %t805 to i64
  %t809 = icmp ne i64 %t808, 0
  br i1 %t809, label %L144, label %L146
L144:
  %t810 = alloca ptr
  %t811 = load ptr, ptr %t704
  %t812 = load ptr, ptr %t811
  %t813 = load i64, ptr %t800
  %t814 = sext i32 %t813 to i64
  %t815 = getelementptr ptr, ptr %t812, i64 %t814
  %t816 = load ptr, ptr %t815
  store ptr %t816, ptr %t810
  %t817 = load ptr, ptr %t810
  %t818 = load ptr, ptr %t817
  %t820 = ptrtoint ptr %t818 to i64
  %t821 = sext i32 14 to i64
  %t819 = icmp eq i64 %t820, %t821
  %t822 = zext i1 %t819 to i64
  %t823 = icmp ne i64 %t822, 0
  br i1 %t823, label %L147, label %L148
L147:
  %t824 = load i64, ptr %t798
  %t825 = load i64, ptr %t706
  %t827 = sext i32 %t824 to i64
  %t828 = sext i32 %t825 to i64
  %t826 = icmp slt i64 %t827, %t828
  %t829 = zext i1 %t826 to i64
  %t830 = icmp ne i64 %t829, 0
  %t831 = zext i1 %t830 to i64
  br label %L149
L148:
  br label %L149
L149:
  %t832 = phi i64 [ %t831, %L147 ], [ 0, %L148 ]
  %t833 = icmp ne i64 %t832, 0
  br i1 %t833, label %L150, label %L152
L150:
  %t834 = load ptr, ptr %t0
  %t835 = getelementptr [27 x i8], ptr @.str292, i64 0, i64 0
  %t836 = load ptr, ptr %t709
  %t837 = load i64, ptr %t798
  %t838 = sext i32 %t837 to i64
  %t839 = getelementptr ptr, ptr %t836, i64 %t838
  %t840 = load ptr, ptr %t839
  %t841 = load ptr, ptr %t708
  %t842 = load i64, ptr %t798
  %t843 = sext i32 %t842 to i64
  %t844 = getelementptr ptr, ptr %t841, i64 %t843
  %t845 = load ptr, ptr %t844
  call void (ptr, ...) @__c0c_emit(ptr %t834, ptr %t835, ptr %t840, ptr %t845)
  %t847 = load i64, ptr %t798
  %t849 = sext i32 %t847 to i64
  %t848 = add i64 %t849, 1
  store i64 %t848, ptr %t798
  br label %L152
L152:
  br label %L145
L145:
  %t850 = load i64, ptr %t800
  %t852 = sext i32 %t850 to i64
  %t851 = add i64 %t852, 1
  store i64 %t851, ptr %t800
  br label %L143
L146:
  %t853 = load ptr, ptr %t0
  %t854 = getelementptr [5 x i8], ptr @.str293, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t853, ptr %t854)
  %t856 = sext i32 0 to i64
  store i64 %t856, ptr %t798
  %t857 = alloca i64
  %t858 = sext i32 0 to i64
  store i64 %t858, ptr %t857
  %t859 = alloca i64
  %t860 = sext i32 0 to i64
  store i64 %t860, ptr %t859
  br label %L153
L153:
  %t861 = load i64, ptr %t859
  %t862 = load ptr, ptr %t704
  %t863 = load ptr, ptr %t862
  %t865 = sext i32 %t861 to i64
  %t866 = ptrtoint ptr %t863 to i64
  %t864 = icmp slt i64 %t865, %t866
  %t867 = zext i1 %t864 to i64
  %t868 = icmp ne i64 %t867, 0
  br i1 %t868, label %L154, label %L156
L154:
  %t869 = alloca ptr
  %t870 = load ptr, ptr %t704
  %t871 = load ptr, ptr %t870
  %t872 = load i64, ptr %t859
  %t873 = sext i32 %t872 to i64
  %t874 = getelementptr ptr, ptr %t871, i64 %t873
  %t875 = load ptr, ptr %t874
  store ptr %t875, ptr %t869
  %t876 = load ptr, ptr %t869
  %t877 = load ptr, ptr %t876
  %t879 = ptrtoint ptr %t877 to i64
  %t880 = sext i32 14 to i64
  %t878 = icmp eq i64 %t879, %t880
  %t881 = zext i1 %t878 to i64
  %t882 = icmp ne i64 %t881, 0
  br i1 %t882, label %L157, label %L158
L157:
  %t883 = load i64, ptr %t798
  %t884 = load i64, ptr %t706
  %t886 = sext i32 %t883 to i64
  %t887 = sext i32 %t884 to i64
  %t885 = icmp slt i64 %t886, %t887
  %t888 = zext i1 %t885 to i64
  %t889 = icmp ne i64 %t888, 0
  %t890 = zext i1 %t889 to i64
  br label %L159
L158:
  br label %L159
L159:
  %t891 = phi i64 [ %t890, %L157 ], [ 0, %L158 ]
  %t892 = icmp ne i64 %t891, 0
  br i1 %t892, label %L160, label %L161
L160:
  %t893 = load ptr, ptr %t0
  %t894 = getelementptr [6 x i8], ptr @.str294, i64 0, i64 0
  %t895 = load ptr, ptr %t708
  %t896 = load i64, ptr %t798
  %t898 = sext i32 %t896 to i64
  %t897 = add i64 %t898, 1
  store i64 %t897, ptr %t798
  %t899 = sext i32 %t896 to i64
  %t900 = getelementptr ptr, ptr %t895, i64 %t899
  %t901 = load ptr, ptr %t900
  call void (ptr, ...) @__c0c_emit(ptr %t893, ptr %t894, ptr %t901)
  %t903 = load ptr, ptr %t869
  %t904 = load ptr, ptr %t903
  %t906 = ptrtoint ptr %t904 to i64
  %t907 = sext i32 0 to i64
  %t905 = icmp sgt i64 %t906, %t907
  %t908 = zext i1 %t905 to i64
  %t909 = icmp ne i64 %t908, 0
  br i1 %t909, label %L163, label %L165
L163:
  %t910 = load ptr, ptr %t869
  %t911 = load ptr, ptr %t910
  %t912 = sext i32 0 to i64
  %t913 = getelementptr ptr, ptr %t911, i64 %t912
  %t914 = load ptr, ptr %t913
  call void @emit_stmt(ptr %t0, ptr %t914)
  br label %L165
L165:
  %t916 = alloca i64
  %t917 = load i64, ptr %t798
  %t918 = load i64, ptr %t706
  %t920 = sext i32 %t917 to i64
  %t921 = sext i32 %t918 to i64
  %t919 = icmp slt i64 %t920, %t921
  %t922 = zext i1 %t919 to i64
  %t923 = icmp ne i64 %t922, 0
  br i1 %t923, label %L166, label %L167
L166:
  %t924 = load ptr, ptr %t708
  %t925 = load i64, ptr %t798
  %t926 = sext i32 %t925 to i64
  %t927 = getelementptr ptr, ptr %t924, i64 %t926
  %t928 = load ptr, ptr %t927
  %t929 = ptrtoint ptr %t928 to i64
  br label %L168
L167:
  %t930 = load i64, ptr %t692
  %t931 = sext i32 %t930 to i64
  br label %L168
L168:
  %t932 = phi i64 [ %t929, %L166 ], [ %t931, %L167 ]
  store i64 %t932, ptr %t916
  %t933 = load ptr, ptr %t0
  %t934 = getelementptr [18 x i8], ptr @.str295, i64 0, i64 0
  %t935 = load i64, ptr %t916
  call void (ptr, ...) @__c0c_emit(ptr %t933, ptr %t934, i64 %t935)
  br label %L162
L161:
  %t937 = load ptr, ptr %t869
  %t938 = load ptr, ptr %t937
  %t940 = ptrtoint ptr %t938 to i64
  %t941 = sext i32 15 to i64
  %t939 = icmp eq i64 %t940, %t941
  %t942 = zext i1 %t939 to i64
  %t943 = icmp ne i64 %t942, 0
  br i1 %t943, label %L169, label %L170
L169:
  %t944 = load ptr, ptr %t0
  %t945 = getelementptr [6 x i8], ptr @.str296, i64 0, i64 0
  %t946 = load i64, ptr %t710
  call void (ptr, ...) @__c0c_emit(ptr %t944, ptr %t945, i64 %t946)
  %t948 = load ptr, ptr %t869
  %t949 = load ptr, ptr %t948
  %t951 = ptrtoint ptr %t949 to i64
  %t952 = sext i32 0 to i64
  %t950 = icmp sgt i64 %t951, %t952
  %t953 = zext i1 %t950 to i64
  %t954 = icmp ne i64 %t953, 0
  br i1 %t954, label %L172, label %L174
L172:
  %t955 = load ptr, ptr %t869
  %t956 = load ptr, ptr %t955
  %t957 = sext i32 0 to i64
  %t958 = getelementptr ptr, ptr %t956, i64 %t957
  %t959 = load ptr, ptr %t958
  call void @emit_stmt(ptr %t0, ptr %t959)
  br label %L174
L174:
  %t961 = load ptr, ptr %t0
  %t962 = getelementptr [18 x i8], ptr @.str297, i64 0, i64 0
  %t963 = load i64, ptr %t692
  call void (ptr, ...) @__c0c_emit(ptr %t961, ptr %t962, i64 %t963)
  %t965 = load i64, ptr %t857
  %t967 = sext i32 %t965 to i64
  %t966 = add i64 %t967, 1
  store i64 %t966, ptr %t857
  br label %L171
L170:
  %t968 = load ptr, ptr %t869
  call void @emit_stmt(ptr %t0, ptr %t968)
  br label %L171
L171:
  br label %L162
L162:
  br label %L155
L155:
  %t970 = load i64, ptr %t859
  %t972 = sext i32 %t970 to i64
  %t971 = add i64 %t972, 1
  store i64 %t971, ptr %t859
  br label %L153
L156:
  %t973 = load ptr, ptr %t0
  %t974 = getelementptr [6 x i8], ptr @.str298, i64 0, i64 0
  %t975 = load i64, ptr %t692
  call void (ptr, ...) @__c0c_emit(ptr %t973, ptr %t974, i64 %t975)
  %t977 = load ptr, ptr %t0
  %t978 = load ptr, ptr %t695
  %t979 = call ptr @strcpy(ptr %t977, ptr %t978)
  br label %L4
L175:
  br label %L16
L16:
  %t980 = load ptr, ptr %t1
  %t982 = ptrtoint ptr %t980 to i64
  %t983 = sext i32 0 to i64
  %t981 = icmp sgt i64 %t982, %t983
  %t984 = zext i1 %t981 to i64
  %t985 = icmp ne i64 %t984, 0
  br i1 %t985, label %L176, label %L178
L176:
  %t986 = load ptr, ptr %t1
  %t987 = sext i32 0 to i64
  %t988 = getelementptr ptr, ptr %t986, i64 %t987
  %t989 = load ptr, ptr %t988
  call void @emit_stmt(ptr %t0, ptr %t989)
  br label %L178
L178:
  br label %L4
L179:
  br label %L17
L17:
  %t991 = load ptr, ptr %t1
  %t993 = ptrtoint ptr %t991 to i64
  %t994 = sext i32 0 to i64
  %t992 = icmp sgt i64 %t993, %t994
  %t995 = zext i1 %t992 to i64
  %t996 = icmp ne i64 %t995, 0
  br i1 %t996, label %L180, label %L182
L180:
  %t997 = load ptr, ptr %t1
  %t998 = sext i32 0 to i64
  %t999 = getelementptr ptr, ptr %t997, i64 %t998
  %t1000 = load ptr, ptr %t999
  call void @emit_stmt(ptr %t0, ptr %t1000)
  br label %L182
L182:
  br label %L4
L183:
  br label %L18
L18:
  %t1002 = load ptr, ptr %t0
  %t1003 = getelementptr [17 x i8], ptr @.str299, i64 0, i64 0
  %t1004 = load ptr, ptr %t1
  call void (ptr, ...) @__c0c_emit(ptr %t1002, ptr %t1003, ptr %t1004)
  %t1006 = load ptr, ptr %t0
  %t1007 = getelementptr [5 x i8], ptr @.str300, i64 0, i64 0
  %t1008 = load ptr, ptr %t1
  call void (ptr, ...) @__c0c_emit(ptr %t1006, ptr %t1007, ptr %t1008)
  %t1010 = load ptr, ptr %t1
  %t1012 = ptrtoint ptr %t1010 to i64
  %t1013 = sext i32 0 to i64
  %t1011 = icmp sgt i64 %t1012, %t1013
  %t1014 = zext i1 %t1011 to i64
  %t1015 = icmp ne i64 %t1014, 0
  br i1 %t1015, label %L184, label %L186
L184:
  %t1016 = load ptr, ptr %t1
  %t1017 = sext i32 0 to i64
  %t1018 = getelementptr ptr, ptr %t1016, i64 %t1017
  %t1019 = load ptr, ptr %t1018
  call void @emit_stmt(ptr %t0, ptr %t1019)
  br label %L186
L186:
  br label %L4
L187:
  br label %L19
L19:
  %t1021 = load ptr, ptr %t0
  %t1022 = getelementptr [17 x i8], ptr @.str301, i64 0, i64 0
  %t1023 = load ptr, ptr %t1
  call void (ptr, ...) @__c0c_emit(ptr %t1021, ptr %t1022, ptr %t1023)
  %t1025 = alloca i64
  %t1026 = call i32 @new_label(ptr %t0)
  %t1027 = sext i32 %t1026 to i64
  store i64 %t1027, ptr %t1025
  %t1028 = load ptr, ptr %t0
  %t1029 = getelementptr [6 x i8], ptr @.str302, i64 0, i64 0
  %t1030 = load i64, ptr %t1025
  call void (ptr, ...) @__c0c_emit(ptr %t1028, ptr %t1029, i64 %t1030)
  br label %L4
L188:
  br label %L20
L20:
  br label %L4
L189:
  br label %L4
L21:
  %t1032 = call i64 @emit_expr(ptr %t0, ptr %t1)
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
  %t36 = getelementptr [5 x i8], ptr @.str303, i64 0, i64 0
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
  %t43 = getelementptr [9 x i8], ptr @.str304, i64 0, i64 0
  %t44 = ptrtoint ptr %t43 to i64
  br label %L15
L14:
  %t45 = getelementptr [10 x i8], ptr @.str305, i64 0, i64 0
  %t46 = ptrtoint ptr %t45 to i64
  br label %L15
L15:
  %t47 = phi i64 [ %t44, %L13 ], [ %t46, %L14 ]
  store i64 %t47, ptr %t40
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr [18 x i8], ptr @.str306, i64 0, i64 0
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
  %t57 = getelementptr [5 x i8], ptr @.str307, i64 0, i64 0
  %t58 = ptrtoint ptr %t57 to i64
  br label %L18
L18:
  %t59 = phi i64 [ %t56, %L16 ], [ %t58, %L17 ]
  call void (ptr, ...) @__c0c_emit(ptr %t48, ptr %t49, ptr %t50, ptr %t52, i64 %t59)
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
  %t70 = sext i32 %t66 to i64
  %t71 = ptrtoint ptr %t68 to i64
  %t69 = icmp slt i64 %t70, %t71
  %t72 = zext i1 %t69 to i64
  %t73 = icmp ne i64 %t72, 0
  br i1 %t73, label %L20, label %L22
L20:
  %t74 = alloca ptr
  %t75 = load ptr, ptr %t2
  %t76 = load ptr, ptr %t75
  %t77 = load i64, ptr %t64
  %t79 = sext i32 %t77 to i64
  %t78 = getelementptr ptr, ptr %t76, i64 %t79
  %t80 = load ptr, ptr %t78
  store ptr %t80, ptr %t74
  %t81 = load ptr, ptr %t74
  %t82 = ptrtoint ptr %t81 to i64
  %t83 = icmp ne i64 %t82, 0
  br i1 %t83, label %L23, label %L24
L23:
  %t84 = load ptr, ptr %t74
  %t85 = load ptr, ptr %t84
  %t87 = ptrtoint ptr %t85 to i64
  %t88 = sext i32 0 to i64
  %t86 = icmp eq i64 %t87, %t88
  %t89 = zext i1 %t86 to i64
  %t90 = icmp ne i64 %t89, 0
  %t91 = zext i1 %t90 to i64
  br label %L25
L24:
  br label %L25
L25:
  %t92 = phi i64 [ %t91, %L23 ], [ 0, %L24 ]
  %t93 = icmp ne i64 %t92, 0
  br i1 %t93, label %L26, label %L27
L26:
  %t94 = load ptr, ptr %t2
  %t95 = load ptr, ptr %t94
  %t97 = ptrtoint ptr %t95 to i64
  %t98 = sext i32 1 to i64
  %t96 = icmp eq i64 %t97, %t98
  %t99 = zext i1 %t96 to i64
  %t100 = icmp ne i64 %t99, 0
  %t101 = zext i1 %t100 to i64
  br label %L28
L27:
  br label %L28
L28:
  %t102 = phi i64 [ %t101, %L26 ], [ 0, %L27 ]
  %t103 = icmp ne i64 %t102, 0
  br i1 %t103, label %L29, label %L31
L29:
  br label %L22
L32:
  br label %L31
L31:
  %t104 = load i64, ptr %t62
  %t106 = sext i32 %t104 to i64
  %t105 = icmp ne i64 %t106, 0
  br i1 %t105, label %L33, label %L35
L33:
  %t107 = load ptr, ptr %t0
  %t108 = getelementptr [3 x i8], ptr @.str308, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t107, ptr %t108)
  br label %L35
L35:
  %t110 = alloca ptr
  %t111 = alloca ptr
  %t112 = load ptr, ptr %t74
  %t114 = ptrtoint ptr %t112 to i64
  %t115 = icmp eq i64 %t114, 0
  %t113 = zext i1 %t115 to i64
  %t116 = icmp ne i64 %t113, 0
  br i1 %t116, label %L36, label %L37
L36:
  br label %L38
L37:
  %t117 = load ptr, ptr %t74
  %t118 = call i32 @type_is_fp(ptr %t117)
  %t119 = sext i32 %t118 to i64
  %t120 = icmp ne i64 %t119, 0
  %t121 = zext i1 %t120 to i64
  br label %L38
L38:
  %t122 = phi i64 [ 1, %L36 ], [ %t121, %L37 ]
  %t123 = icmp ne i64 %t122, 0
  br i1 %t123, label %L39, label %L40
L39:
  %t124 = load ptr, ptr %t74
  %t125 = icmp ne ptr %t124, null
  br i1 %t125, label %L42, label %L43
L42:
  %t126 = load ptr, ptr %t74
  %t127 = call ptr @llvm_type(ptr %t126)
  %t128 = ptrtoint ptr %t127 to i64
  br label %L44
L43:
  %t129 = getelementptr [4 x i8], ptr @.str309, i64 0, i64 0
  %t130 = ptrtoint ptr %t129 to i64
  br label %L44
L44:
  %t131 = phi i64 [ %t128, %L42 ], [ %t130, %L43 ]
  store i64 %t131, ptr %t110
  %t132 = load ptr, ptr %t74
  store ptr %t132, ptr %t111
  br label %L41
L40:
  %t133 = load ptr, ptr %t74
  %t134 = load ptr, ptr %t133
  %t136 = ptrtoint ptr %t134 to i64
  %t137 = sext i32 15 to i64
  %t135 = icmp eq i64 %t136, %t137
  %t138 = zext i1 %t135 to i64
  %t139 = icmp ne i64 %t138, 0
  br i1 %t139, label %L45, label %L46
L45:
  br label %L47
L46:
  %t140 = load ptr, ptr %t74
  %t141 = load ptr, ptr %t140
  %t143 = ptrtoint ptr %t141 to i64
  %t144 = sext i32 16 to i64
  %t142 = icmp eq i64 %t143, %t144
  %t145 = zext i1 %t142 to i64
  %t146 = icmp ne i64 %t145, 0
  %t147 = zext i1 %t146 to i64
  br label %L47
L47:
  %t148 = phi i64 [ 1, %L45 ], [ %t147, %L46 ]
  %t149 = icmp ne i64 %t148, 0
  br i1 %t149, label %L48, label %L49
L48:
  %t150 = getelementptr [4 x i8], ptr @.str310, i64 0, i64 0
  store ptr %t150, ptr %t110
  %t151 = call ptr @default_ptr_type()
  store ptr %t151, ptr %t111
  br label %L50
L49:
  %t152 = load ptr, ptr %t74
  %t153 = load ptr, ptr %t152
  %t155 = ptrtoint ptr %t153 to i64
  %t156 = sext i32 18 to i64
  %t154 = icmp eq i64 %t155, %t156
  %t157 = zext i1 %t154 to i64
  %t158 = icmp ne i64 %t157, 0
  br i1 %t158, label %L51, label %L52
L51:
  br label %L53
L52:
  %t159 = load ptr, ptr %t74
  %t160 = load ptr, ptr %t159
  %t162 = ptrtoint ptr %t160 to i64
  %t163 = sext i32 19 to i64
  %t161 = icmp eq i64 %t162, %t163
  %t164 = zext i1 %t161 to i64
  %t165 = icmp ne i64 %t164, 0
  %t166 = zext i1 %t165 to i64
  br label %L53
L53:
  %t167 = phi i64 [ 1, %L51 ], [ %t166, %L52 ]
  %t168 = icmp ne i64 %t167, 0
  br i1 %t168, label %L54, label %L55
L54:
  br label %L56
L55:
  %t169 = load ptr, ptr %t74
  %t170 = load ptr, ptr %t169
  %t172 = ptrtoint ptr %t170 to i64
  %t173 = sext i32 21 to i64
  %t171 = icmp eq i64 %t172, %t173
  %t174 = zext i1 %t171 to i64
  %t175 = icmp ne i64 %t174, 0
  %t176 = zext i1 %t175 to i64
  br label %L56
L56:
  %t177 = phi i64 [ 1, %L54 ], [ %t176, %L55 ]
  %t178 = icmp ne i64 %t177, 0
  br i1 %t178, label %L57, label %L58
L57:
  %t179 = getelementptr [4 x i8], ptr @.str311, i64 0, i64 0
  store ptr %t179, ptr %t110
  %t180 = call ptr @default_ptr_type()
  store ptr %t180, ptr %t111
  br label %L59
L58:
  %t181 = getelementptr [4 x i8], ptr @.str312, i64 0, i64 0
  store ptr %t181, ptr %t110
  %t182 = call ptr @default_i64_type()
  store ptr %t182, ptr %t111
  br label %L59
L59:
  br label %L50
L50:
  br label %L41
L41:
  %t183 = alloca i64
  %t184 = call i32 @new_reg(ptr %t0)
  %t185 = sext i32 %t184 to i64
  store i64 %t185, ptr %t183
  %t186 = load ptr, ptr %t0
  %t187 = getelementptr [9 x i8], ptr @.str313, i64 0, i64 0
  %t188 = load ptr, ptr %t110
  %t189 = load i64, ptr %t183
  call void (ptr, ...) @__c0c_emit(ptr %t186, ptr %t187, ptr %t188, i64 %t189)
  %t191 = load i64, ptr %t62
  %t193 = sext i32 %t191 to i64
  %t192 = add i64 %t193, 1
  store i64 %t192, ptr %t62
  %t194 = load ptr, ptr %t1
  %t195 = ptrtoint ptr %t194 to i64
  %t196 = icmp ne i64 %t195, 0
  br i1 %t196, label %L60, label %L61
L60:
  %t197 = load ptr, ptr %t1
  %t198 = load i64, ptr %t64
  %t199 = sext i32 %t198 to i64
  %t200 = getelementptr ptr, ptr %t197, i64 %t199
  %t201 = load ptr, ptr %t200
  %t202 = ptrtoint ptr %t201 to i64
  %t203 = icmp ne i64 %t202, 0
  %t204 = zext i1 %t203 to i64
  br label %L62
L61:
  br label %L62
L62:
  %t205 = phi i64 [ %t204, %L60 ], [ 0, %L61 ]
  %t206 = icmp ne i64 %t205, 0
  br i1 %t206, label %L63, label %L65
L63:
  %t207 = load ptr, ptr %t0
  %t209 = ptrtoint ptr %t207 to i64
  %t210 = sext i32 2048 to i64
  %t208 = icmp sge i64 %t209, %t210
  %t211 = zext i1 %t208 to i64
  %t212 = icmp ne i64 %t211, 0
  br i1 %t212, label %L66, label %L68
L66:
  %t213 = call ptr @__c0c_stderr()
  %t214 = getelementptr [22 x i8], ptr @.str314, i64 0, i64 0
  %t215 = call i32 (ptr, ...) @fprintf(ptr %t213, ptr %t214)
  %t216 = sext i32 %t215 to i64
  call void @exit(i64 1)
  br label %L68
L68:
  %t218 = alloca ptr
  %t219 = load ptr, ptr %t0
  %t220 = load ptr, ptr %t0
  %t222 = ptrtoint ptr %t220 to i64
  %t221 = add i64 %t222, 1
  store i64 %t221, ptr %t0
  %t224 = ptrtoint ptr %t220 to i64
  %t223 = getelementptr ptr, ptr %t219, i64 %t224
  store ptr %t223, ptr %t218
  %t225 = load ptr, ptr %t1
  %t226 = load i64, ptr %t64
  %t227 = sext i32 %t226 to i64
  %t228 = getelementptr ptr, ptr %t225, i64 %t227
  %t229 = load ptr, ptr %t228
  %t230 = call ptr @strdup(ptr %t229)
  %t231 = load ptr, ptr %t218
  store ptr %t230, ptr %t231
  %t232 = call ptr @malloc(i64 32)
  %t233 = load ptr, ptr %t218
  store ptr %t232, ptr %t233
  %t234 = load ptr, ptr %t218
  %t235 = load ptr, ptr %t234
  %t236 = getelementptr [6 x i8], ptr @.str315, i64 0, i64 0
  %t237 = load i64, ptr %t183
  %t238 = call i32 (ptr, ...) @snprintf(ptr %t235, i64 32, ptr %t236, i64 %t237)
  %t239 = sext i32 %t238 to i64
  %t240 = load ptr, ptr %t111
  %t241 = load ptr, ptr %t218
  store ptr %t240, ptr %t241
  %t242 = load ptr, ptr %t218
  %t243 = sext i32 1 to i64
  store i64 %t243, ptr %t242
  br label %L65
L65:
  br label %L21
L21:
  %t244 = load i64, ptr %t64
  %t246 = sext i32 %t244 to i64
  %t245 = add i64 %t246, 1
  store i64 %t245, ptr %t64
  br label %L19
L22:
  %t247 = load ptr, ptr %t2
  %t248 = load ptr, ptr %t247
  %t249 = icmp ne ptr %t248, null
  br i1 %t249, label %L69, label %L71
L69:
  %t250 = load i64, ptr %t62
  %t252 = sext i32 %t250 to i64
  %t251 = icmp ne i64 %t252, 0
  br i1 %t251, label %L72, label %L74
L72:
  %t253 = load ptr, ptr %t0
  %t254 = getelementptr [3 x i8], ptr @.str316, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t253, ptr %t254)
  br label %L74
L74:
  %t256 = load ptr, ptr %t0
  %t257 = getelementptr [4 x i8], ptr @.str317, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t256, ptr %t257)
  br label %L71
L71:
  %t259 = load ptr, ptr %t0
  %t260 = getelementptr [5 x i8], ptr @.str318, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t259, ptr %t260)
  %t262 = load ptr, ptr %t0
  %t263 = getelementptr [8 x i8], ptr @.str319, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t262, ptr %t263)
  %t265 = load ptr, ptr %t1
  call void @emit_stmt(ptr %t0, ptr %t265)
  %t267 = load ptr, ptr %t2
  %t268 = load ptr, ptr %t267
  %t270 = ptrtoint ptr %t268 to i64
  %t271 = icmp eq i64 %t270, 0
  %t269 = zext i1 %t271 to i64
  %t272 = icmp ne i64 %t269, 0
  br i1 %t272, label %L75, label %L76
L75:
  br label %L77
L76:
  %t273 = load ptr, ptr %t2
  %t274 = load ptr, ptr %t273
  %t275 = load ptr, ptr %t274
  %t277 = ptrtoint ptr %t275 to i64
  %t278 = sext i32 0 to i64
  %t276 = icmp eq i64 %t277, %t278
  %t279 = zext i1 %t276 to i64
  %t280 = icmp ne i64 %t279, 0
  %t281 = zext i1 %t280 to i64
  br label %L77
L77:
  %t282 = phi i64 [ 1, %L75 ], [ %t281, %L76 ]
  %t283 = icmp ne i64 %t282, 0
  br i1 %t283, label %L78, label %L79
L78:
  %t284 = load ptr, ptr %t0
  %t285 = getelementptr [12 x i8], ptr @.str320, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t284, ptr %t285)
  br label %L80
L79:
  %t287 = load ptr, ptr %t2
  %t288 = load ptr, ptr %t287
  %t289 = load ptr, ptr %t288
  %t291 = ptrtoint ptr %t289 to i64
  %t292 = sext i32 15 to i64
  %t290 = icmp eq i64 %t291, %t292
  %t293 = zext i1 %t290 to i64
  %t294 = icmp ne i64 %t293, 0
  br i1 %t294, label %L81, label %L82
L81:
  br label %L83
L82:
  %t295 = load ptr, ptr %t2
  %t296 = load ptr, ptr %t295
  %t297 = load ptr, ptr %t296
  %t299 = ptrtoint ptr %t297 to i64
  %t300 = sext i32 16 to i64
  %t298 = icmp eq i64 %t299, %t300
  %t301 = zext i1 %t298 to i64
  %t302 = icmp ne i64 %t301, 0
  %t303 = zext i1 %t302 to i64
  br label %L83
L83:
  %t304 = phi i64 [ 1, %L81 ], [ %t303, %L82 ]
  %t305 = icmp ne i64 %t304, 0
  br i1 %t305, label %L84, label %L85
L84:
  %t306 = load ptr, ptr %t0
  %t307 = getelementptr [16 x i8], ptr @.str321, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t306, ptr %t307)
  br label %L86
L85:
  %t309 = load ptr, ptr %t2
  %t310 = load ptr, ptr %t309
  %t311 = call i32 @type_is_fp(ptr %t310)
  %t312 = sext i32 %t311 to i64
  %t313 = icmp ne i64 %t312, 0
  br i1 %t313, label %L87, label %L88
L87:
  %t314 = load ptr, ptr %t0
  %t315 = getelementptr [14 x i8], ptr @.str322, i64 0, i64 0
  %t316 = load ptr, ptr %t2
  %t317 = load ptr, ptr %t316
  %t318 = call ptr @llvm_type(ptr %t317)
  call void (ptr, ...) @__c0c_emit(ptr %t314, ptr %t315, ptr %t318)
  br label %L89
L88:
  %t320 = alloca ptr
  %t321 = load ptr, ptr %t2
  %t322 = load ptr, ptr %t321
  %t323 = call ptr @llvm_type(ptr %t322)
  store ptr %t323, ptr %t320
  %t324 = load ptr, ptr %t320
  %t325 = getelementptr [3 x i8], ptr @.str323, i64 0, i64 0
  %t326 = call i32 @strcmp(ptr %t324, ptr %t325)
  %t327 = sext i32 %t326 to i64
  %t329 = sext i32 0 to i64
  %t328 = icmp eq i64 %t327, %t329
  %t330 = zext i1 %t328 to i64
  %t331 = icmp ne i64 %t330, 0
  br i1 %t331, label %L90, label %L91
L90:
  %t332 = load ptr, ptr %t0
  %t333 = getelementptr [12 x i8], ptr @.str324, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t332, ptr %t333)
  br label %L92
L91:
  %t335 = load ptr, ptr %t320
  %t336 = getelementptr [4 x i8], ptr @.str325, i64 0, i64 0
  %t337 = call i32 @strcmp(ptr %t335, ptr %t336)
  %t338 = sext i32 %t337 to i64
  %t340 = sext i32 0 to i64
  %t339 = icmp eq i64 %t338, %t340
  %t341 = zext i1 %t339 to i64
  %t342 = icmp ne i64 %t341, 0
  br i1 %t342, label %L93, label %L94
L93:
  %t343 = load ptr, ptr %t0
  %t344 = getelementptr [13 x i8], ptr @.str326, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t343, ptr %t344)
  br label %L95
L94:
  %t346 = load ptr, ptr %t320
  %t347 = getelementptr [4 x i8], ptr @.str327, i64 0, i64 0
  %t348 = call i32 @strcmp(ptr %t346, ptr %t347)
  %t349 = sext i32 %t348 to i64
  %t351 = sext i32 0 to i64
  %t350 = icmp eq i64 %t349, %t351
  %t352 = zext i1 %t350 to i64
  %t353 = icmp ne i64 %t352, 0
  br i1 %t353, label %L96, label %L97
L96:
  %t354 = load ptr, ptr %t0
  %t355 = getelementptr [13 x i8], ptr @.str328, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t354, ptr %t355)
  br label %L98
L97:
  %t357 = load ptr, ptr %t0
  %t358 = getelementptr [13 x i8], ptr @.str329, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t357, ptr %t358)
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
  %t360 = load ptr, ptr %t0
  %t361 = getelementptr [4 x i8], ptr @.str330, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t360, ptr %t361)
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
  %t29 = sext i32 %t26 to i64
  %t30 = ptrtoint ptr %t27 to i64
  %t28 = icmp slt i64 %t29, %t30
  %t31 = zext i1 %t28 to i64
  %t32 = icmp ne i64 %t31, 0
  br i1 %t32, label %L11, label %L13
L11:
  %t33 = load ptr, ptr %t0
  %t34 = load i64, ptr %t24
  %t36 = sext i32 %t34 to i64
  %t35 = getelementptr ptr, ptr %t33, i64 %t36
  %t37 = load ptr, ptr %t35
  %t38 = load ptr, ptr %t1
  %t39 = call i32 @strcmp(ptr %t37, ptr %t38)
  %t40 = sext i32 %t39 to i64
  %t42 = sext i32 0 to i64
  %t41 = icmp eq i64 %t40, %t42
  %t43 = zext i1 %t41 to i64
  %t44 = icmp ne i64 %t43, 0
  br i1 %t44, label %L14, label %L16
L14:
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t22
  br label %L13
L17:
  br label %L16
L16:
  br label %L12
L12:
  %t46 = load i64, ptr %t24
  %t48 = sext i32 %t46 to i64
  %t47 = add i64 %t48, 1
  store i64 %t47, ptr %t24
  br label %L10
L13:
  %t49 = load i64, ptr %t22
  %t51 = sext i32 %t49 to i64
  %t50 = icmp ne i64 %t51, 0
  br i1 %t50, label %L18, label %L20
L18:
  ret void
L21:
  br label %L20
L20:
  %t52 = load ptr, ptr %t0
  %t54 = ptrtoint ptr %t52 to i64
  %t55 = sext i32 2048 to i64
  %t53 = icmp slt i64 %t54, %t55
  %t56 = zext i1 %t53 to i64
  %t57 = icmp ne i64 %t56, 0
  br i1 %t57, label %L22, label %L24
L22:
  %t58 = load ptr, ptr %t1
  %t59 = call ptr @strdup(ptr %t58)
  %t60 = load ptr, ptr %t0
  %t61 = load ptr, ptr %t0
  %t63 = ptrtoint ptr %t61 to i64
  %t62 = getelementptr ptr, ptr %t60, i64 %t63
  store ptr %t59, ptr %t62
  %t64 = load ptr, ptr %t7
  %t65 = load ptr, ptr %t0
  %t66 = load ptr, ptr %t0
  %t68 = ptrtoint ptr %t66 to i64
  %t67 = getelementptr ptr, ptr %t65, i64 %t68
  store ptr %t64, ptr %t67
  %t69 = load ptr, ptr %t0
  %t70 = load ptr, ptr %t0
  %t72 = ptrtoint ptr %t70 to i64
  %t71 = getelementptr ptr, ptr %t69, i64 %t72
  %t73 = sext i32 1 to i64
  store i64 %t73, ptr %t71
  %t74 = load ptr, ptr %t0
  %t76 = ptrtoint ptr %t74 to i64
  %t75 = add i64 %t76, 1
  store i64 %t75, ptr %t0
  br label %L24
L24:
  %t77 = alloca ptr
  %t78 = sext i32 0 to i64
  store i64 %t78, ptr %t77
  %t79 = alloca i64
  %t80 = sext i32 0 to i64
  store i64 %t80, ptr %t79
  %t81 = alloca i64
  %t82 = sext i32 0 to i64
  store i64 %t82, ptr %t81
  br label %L25
L25:
  %t83 = load i64, ptr %t81
  %t84 = load ptr, ptr %t7
  %t85 = load ptr, ptr %t84
  %t87 = sext i32 %t83 to i64
  %t88 = ptrtoint ptr %t85 to i64
  %t86 = icmp slt i64 %t87, %t88
  %t89 = zext i1 %t86 to i64
  %t90 = icmp ne i64 %t89, 0
  br i1 %t90, label %L29, label %L30
L29:
  %t91 = load i64, ptr %t79
  %t93 = sext i32 %t91 to i64
  %t94 = sext i32 480 to i64
  %t92 = icmp slt i64 %t93, %t94
  %t95 = zext i1 %t92 to i64
  %t96 = icmp ne i64 %t95, 0
  %t97 = zext i1 %t96 to i64
  br label %L31
L30:
  br label %L31
L31:
  %t98 = phi i64 [ %t97, %L29 ], [ 0, %L30 ]
  %t99 = icmp ne i64 %t98, 0
  br i1 %t99, label %L26, label %L28
L26:
  %t100 = alloca ptr
  %t101 = load ptr, ptr %t7
  %t102 = load ptr, ptr %t101
  %t103 = load i64, ptr %t81
  %t105 = sext i32 %t103 to i64
  %t104 = getelementptr ptr, ptr %t102, i64 %t105
  %t106 = load ptr, ptr %t104
  store ptr %t106, ptr %t100
  %t107 = load ptr, ptr %t100
  %t108 = ptrtoint ptr %t107 to i64
  %t109 = icmp ne i64 %t108, 0
  br i1 %t109, label %L32, label %L33
L32:
  %t110 = load ptr, ptr %t100
  %t111 = load ptr, ptr %t110
  %t113 = ptrtoint ptr %t111 to i64
  %t114 = sext i32 0 to i64
  %t112 = icmp eq i64 %t113, %t114
  %t115 = zext i1 %t112 to i64
  %t116 = icmp ne i64 %t115, 0
  %t117 = zext i1 %t116 to i64
  br label %L34
L33:
  br label %L34
L34:
  %t118 = phi i64 [ %t117, %L32 ], [ 0, %L33 ]
  %t119 = icmp ne i64 %t118, 0
  br i1 %t119, label %L35, label %L36
L35:
  %t120 = load ptr, ptr %t7
  %t121 = load ptr, ptr %t120
  %t123 = ptrtoint ptr %t121 to i64
  %t124 = sext i32 1 to i64
  %t122 = icmp eq i64 %t123, %t124
  %t125 = zext i1 %t122 to i64
  %t126 = icmp ne i64 %t125, 0
  %t127 = zext i1 %t126 to i64
  br label %L37
L36:
  br label %L37
L37:
  %t128 = phi i64 [ %t127, %L35 ], [ 0, %L36 ]
  %t129 = icmp ne i64 %t128, 0
  br i1 %t129, label %L38, label %L40
L38:
  br label %L28
L41:
  br label %L40
L40:
  %t130 = load i64, ptr %t81
  %t132 = sext i32 %t130 to i64
  %t131 = icmp ne i64 %t132, 0
  br i1 %t131, label %L42, label %L44
L42:
  %t133 = load i64, ptr %t79
  %t134 = load ptr, ptr %t77
  %t135 = load i64, ptr %t79
  %t137 = ptrtoint ptr %t134 to i64
  %t138 = sext i32 %t135 to i64
  %t139 = inttoptr i64 %t137 to ptr
  %t136 = getelementptr i8, ptr %t139, i64 %t138
  %t140 = load i64, ptr %t79
  %t142 = sext i32 512 to i64
  %t143 = sext i32 %t140 to i64
  %t141 = sub i64 %t142, %t143
  %t144 = getelementptr [3 x i8], ptr @.str331, i64 0, i64 0
  %t145 = call i32 (ptr, ...) @snprintf(ptr %t136, i64 %t141, ptr %t144)
  %t146 = sext i32 %t145 to i64
  %t148 = sext i32 %t133 to i64
  %t147 = add i64 %t148, %t146
  store i64 %t147, ptr %t79
  br label %L44
L44:
  %t149 = alloca ptr
  %t150 = load ptr, ptr %t100
  %t152 = ptrtoint ptr %t150 to i64
  %t153 = icmp eq i64 %t152, 0
  %t151 = zext i1 %t153 to i64
  %t154 = icmp ne i64 %t151, 0
  br i1 %t154, label %L45, label %L46
L45:
  br label %L47
L46:
  %t155 = load ptr, ptr %t100
  %t156 = call i32 @type_is_fp(ptr %t155)
  %t157 = sext i32 %t156 to i64
  %t158 = icmp ne i64 %t157, 0
  %t159 = zext i1 %t158 to i64
  br label %L47
L47:
  %t160 = phi i64 [ 1, %L45 ], [ %t159, %L46 ]
  %t161 = icmp ne i64 %t160, 0
  br i1 %t161, label %L48, label %L49
L48:
  %t162 = load ptr, ptr %t100
  %t163 = icmp ne ptr %t162, null
  br i1 %t163, label %L51, label %L52
L51:
  %t164 = load ptr, ptr %t100
  %t165 = call ptr @llvm_type(ptr %t164)
  %t166 = ptrtoint ptr %t165 to i64
  br label %L53
L52:
  %t167 = getelementptr [4 x i8], ptr @.str332, i64 0, i64 0
  %t168 = ptrtoint ptr %t167 to i64
  br label %L53
L53:
  %t169 = phi i64 [ %t166, %L51 ], [ %t168, %L52 ]
  store i64 %t169, ptr %t149
  br label %L50
L49:
  %t170 = load ptr, ptr %t100
  %t171 = load ptr, ptr %t170
  %t173 = ptrtoint ptr %t171 to i64
  %t174 = sext i32 15 to i64
  %t172 = icmp eq i64 %t173, %t174
  %t175 = zext i1 %t172 to i64
  %t176 = icmp ne i64 %t175, 0
  br i1 %t176, label %L54, label %L55
L54:
  br label %L56
L55:
  %t177 = load ptr, ptr %t100
  %t178 = load ptr, ptr %t177
  %t180 = ptrtoint ptr %t178 to i64
  %t181 = sext i32 16 to i64
  %t179 = icmp eq i64 %t180, %t181
  %t182 = zext i1 %t179 to i64
  %t183 = icmp ne i64 %t182, 0
  %t184 = zext i1 %t183 to i64
  br label %L56
L56:
  %t185 = phi i64 [ 1, %L54 ], [ %t184, %L55 ]
  %t186 = icmp ne i64 %t185, 0
  br i1 %t186, label %L57, label %L58
L57:
  %t187 = getelementptr [4 x i8], ptr @.str333, i64 0, i64 0
  store ptr %t187, ptr %t149
  br label %L59
L58:
  %t188 = load ptr, ptr %t100
  %t189 = load ptr, ptr %t188
  %t191 = ptrtoint ptr %t189 to i64
  %t192 = sext i32 18 to i64
  %t190 = icmp eq i64 %t191, %t192
  %t193 = zext i1 %t190 to i64
  %t194 = icmp ne i64 %t193, 0
  br i1 %t194, label %L60, label %L61
L60:
  br label %L62
L61:
  %t195 = load ptr, ptr %t100
  %t196 = load ptr, ptr %t195
  %t198 = ptrtoint ptr %t196 to i64
  %t199 = sext i32 19 to i64
  %t197 = icmp eq i64 %t198, %t199
  %t200 = zext i1 %t197 to i64
  %t201 = icmp ne i64 %t200, 0
  %t202 = zext i1 %t201 to i64
  br label %L62
L62:
  %t203 = phi i64 [ 1, %L60 ], [ %t202, %L61 ]
  %t204 = icmp ne i64 %t203, 0
  br i1 %t204, label %L63, label %L64
L63:
  br label %L65
L64:
  %t205 = load ptr, ptr %t100
  %t206 = load ptr, ptr %t205
  %t208 = ptrtoint ptr %t206 to i64
  %t209 = sext i32 21 to i64
  %t207 = icmp eq i64 %t208, %t209
  %t210 = zext i1 %t207 to i64
  %t211 = icmp ne i64 %t210, 0
  %t212 = zext i1 %t211 to i64
  br label %L65
L65:
  %t213 = phi i64 [ 1, %L63 ], [ %t212, %L64 ]
  %t214 = icmp ne i64 %t213, 0
  br i1 %t214, label %L66, label %L67
L66:
  %t215 = getelementptr [4 x i8], ptr @.str334, i64 0, i64 0
  store ptr %t215, ptr %t149
  br label %L68
L67:
  %t216 = getelementptr [4 x i8], ptr @.str335, i64 0, i64 0
  store ptr %t216, ptr %t149
  br label %L68
L68:
  br label %L59
L59:
  br label %L50
L50:
  %t217 = load i64, ptr %t79
  %t218 = load ptr, ptr %t77
  %t219 = load i64, ptr %t79
  %t221 = ptrtoint ptr %t218 to i64
  %t222 = sext i32 %t219 to i64
  %t223 = inttoptr i64 %t221 to ptr
  %t220 = getelementptr i8, ptr %t223, i64 %t222
  %t224 = load i64, ptr %t79
  %t226 = sext i32 512 to i64
  %t227 = sext i32 %t224 to i64
  %t225 = sub i64 %t226, %t227
  %t228 = getelementptr [3 x i8], ptr @.str336, i64 0, i64 0
  %t229 = load ptr, ptr %t149
  %t230 = call i32 (ptr, ...) @snprintf(ptr %t220, i64 %t225, ptr %t228, ptr %t229)
  %t231 = sext i32 %t230 to i64
  %t233 = sext i32 %t217 to i64
  %t232 = add i64 %t233, %t231
  store i64 %t232, ptr %t79
  br label %L27
L27:
  %t234 = load i64, ptr %t81
  %t236 = sext i32 %t234 to i64
  %t235 = add i64 %t236, 1
  store i64 %t235, ptr %t81
  br label %L25
L28:
  %t237 = load ptr, ptr %t7
  %t238 = load ptr, ptr %t237
  %t239 = icmp ne ptr %t238, null
  br i1 %t239, label %L69, label %L71
L69:
  %t240 = load ptr, ptr %t7
  %t241 = load ptr, ptr %t240
  %t242 = icmp ne ptr %t241, null
  br i1 %t242, label %L72, label %L74
L72:
  %t243 = load i64, ptr %t79
  %t244 = load ptr, ptr %t77
  %t245 = load i64, ptr %t79
  %t247 = ptrtoint ptr %t244 to i64
  %t248 = sext i32 %t245 to i64
  %t249 = inttoptr i64 %t247 to ptr
  %t246 = getelementptr i8, ptr %t249, i64 %t248
  %t250 = load i64, ptr %t79
  %t252 = sext i32 512 to i64
  %t253 = sext i32 %t250 to i64
  %t251 = sub i64 %t252, %t253
  %t254 = getelementptr [3 x i8], ptr @.str337, i64 0, i64 0
  %t255 = call i32 (ptr, ...) @snprintf(ptr %t246, i64 %t251, ptr %t254)
  %t256 = sext i32 %t255 to i64
  %t258 = sext i32 %t243 to i64
  %t257 = add i64 %t258, %t256
  store i64 %t257, ptr %t79
  br label %L74
L74:
  %t259 = load i64, ptr %t79
  %t260 = load ptr, ptr %t77
  %t261 = load i64, ptr %t79
  %t263 = ptrtoint ptr %t260 to i64
  %t264 = sext i32 %t261 to i64
  %t265 = inttoptr i64 %t263 to ptr
  %t262 = getelementptr i8, ptr %t265, i64 %t264
  %t266 = load i64, ptr %t79
  %t268 = sext i32 512 to i64
  %t269 = sext i32 %t266 to i64
  %t267 = sub i64 %t268, %t269
  %t270 = getelementptr [4 x i8], ptr @.str338, i64 0, i64 0
  %t271 = call i32 (ptr, ...) @snprintf(ptr %t262, i64 %t267, ptr %t270)
  %t272 = sext i32 %t271 to i64
  %t274 = sext i32 %t259 to i64
  %t273 = add i64 %t274, %t272
  store i64 %t273, ptr %t79
  br label %L71
L71:
  %t275 = load ptr, ptr %t0
  %t276 = getelementptr [20 x i8], ptr @.str339, i64 0, i64 0
  %t277 = load ptr, ptr %t7
  %t278 = call ptr @llvm_ret_type(ptr %t277)
  %t279 = load ptr, ptr %t1
  %t280 = load ptr, ptr %t77
  call void (ptr, ...) @__c0c_emit(ptr %t275, ptr %t276, ptr %t278, ptr %t279, ptr %t280)
  ret void
L75:
  br label %L9
L9:
  %t282 = alloca i64
  %t283 = sext i32 0 to i64
  store i64 %t283, ptr %t282
  %t284 = alloca i64
  %t285 = sext i32 0 to i64
  store i64 %t285, ptr %t284
  br label %L76
L76:
  %t286 = load i64, ptr %t284
  %t287 = load ptr, ptr %t0
  %t289 = sext i32 %t286 to i64
  %t290 = ptrtoint ptr %t287 to i64
  %t288 = icmp slt i64 %t289, %t290
  %t291 = zext i1 %t288 to i64
  %t292 = icmp ne i64 %t291, 0
  br i1 %t292, label %L77, label %L79
L77:
  %t293 = load ptr, ptr %t0
  %t294 = load i64, ptr %t284
  %t296 = sext i32 %t294 to i64
  %t295 = getelementptr ptr, ptr %t293, i64 %t296
  %t297 = load ptr, ptr %t295
  %t298 = load ptr, ptr %t1
  %t299 = call i32 @strcmp(ptr %t297, ptr %t298)
  %t300 = sext i32 %t299 to i64
  %t302 = sext i32 0 to i64
  %t301 = icmp eq i64 %t300, %t302
  %t303 = zext i1 %t301 to i64
  %t304 = icmp ne i64 %t303, 0
  br i1 %t304, label %L80, label %L82
L80:
  %t305 = sext i32 1 to i64
  store i64 %t305, ptr %t282
  br label %L79
L83:
  br label %L82
L82:
  br label %L78
L78:
  %t306 = load i64, ptr %t284
  %t308 = sext i32 %t306 to i64
  %t307 = add i64 %t308, 1
  store i64 %t307, ptr %t284
  br label %L76
L79:
  %t309 = load i64, ptr %t282
  %t311 = sext i32 %t309 to i64
  %t312 = icmp eq i64 %t311, 0
  %t310 = zext i1 %t312 to i64
  %t313 = icmp ne i64 %t310, 0
  br i1 %t313, label %L84, label %L85
L84:
  %t314 = load ptr, ptr %t0
  %t316 = ptrtoint ptr %t314 to i64
  %t317 = sext i32 2048 to i64
  %t315 = icmp slt i64 %t316, %t317
  %t318 = zext i1 %t315 to i64
  %t319 = icmp ne i64 %t318, 0
  %t320 = zext i1 %t319 to i64
  br label %L86
L85:
  br label %L86
L86:
  %t321 = phi i64 [ %t320, %L84 ], [ 0, %L85 ]
  %t322 = icmp ne i64 %t321, 0
  br i1 %t322, label %L87, label %L89
L87:
  %t323 = load ptr, ptr %t1
  %t324 = call ptr @strdup(ptr %t323)
  %t325 = load ptr, ptr %t0
  %t326 = load ptr, ptr %t0
  %t328 = ptrtoint ptr %t326 to i64
  %t327 = getelementptr ptr, ptr %t325, i64 %t328
  store ptr %t324, ptr %t327
  %t329 = load ptr, ptr %t7
  %t330 = load ptr, ptr %t0
  %t331 = load ptr, ptr %t0
  %t333 = ptrtoint ptr %t331 to i64
  %t332 = getelementptr ptr, ptr %t330, i64 %t333
  store ptr %t329, ptr %t332
  %t334 = load ptr, ptr %t1
  %t335 = load ptr, ptr %t0
  %t336 = load ptr, ptr %t0
  %t338 = ptrtoint ptr %t336 to i64
  %t337 = getelementptr ptr, ptr %t335, i64 %t338
  store ptr %t334, ptr %t337
  %t339 = load ptr, ptr %t0
  %t341 = ptrtoint ptr %t339 to i64
  %t340 = add i64 %t341, 1
  store i64 %t340, ptr %t0
  br label %L89
L89:
  %t342 = load ptr, ptr %t1
  %t343 = icmp ne ptr %t342, null
  br i1 %t343, label %L90, label %L92
L90:
  %t344 = load ptr, ptr %t0
  %t345 = getelementptr [26 x i8], ptr @.str340, i64 0, i64 0
  %t346 = load ptr, ptr %t1
  %t347 = load ptr, ptr %t7
  %t348 = call ptr @llvm_type(ptr %t347)
  call void (ptr, ...) @__c0c_emit(ptr %t344, ptr %t345, ptr %t346, ptr %t348)
  ret void
L93:
  br label %L92
L92:
  %t350 = alloca ptr
  %t351 = load ptr, ptr %t1
  %t352 = icmp ne ptr %t351, null
  br i1 %t352, label %L94, label %L95
L94:
  %t353 = getelementptr [9 x i8], ptr @.str341, i64 0, i64 0
  %t354 = ptrtoint ptr %t353 to i64
  br label %L96
L95:
  %t355 = getelementptr [10 x i8], ptr @.str342, i64 0, i64 0
  %t356 = ptrtoint ptr %t355 to i64
  br label %L96
L96:
  %t357 = phi i64 [ %t354, %L94 ], [ %t356, %L95 ]
  store i64 %t357, ptr %t350
  %t358 = alloca ptr
  %t359 = load ptr, ptr %t7
  %t360 = call ptr @llvm_type(ptr %t359)
  store ptr %t360, ptr %t358
  %t361 = load ptr, ptr %t0
  %t362 = getelementptr [36 x i8], ptr @.str343, i64 0, i64 0
  %t363 = load ptr, ptr %t1
  %t364 = load ptr, ptr %t350
  %t365 = load ptr, ptr %t358
  call void (ptr, ...) @__c0c_emit(ptr %t361, ptr %t362, ptr %t363, ptr %t364, ptr %t365)
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
  %t9 = getelementptr [7 x i8], ptr @.str344, i64 0, i64 0
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
  %t6 = sext i32 %t3 to i64
  %t7 = ptrtoint ptr %t4 to i64
  %t5 = icmp slt i64 %t6, %t7
  %t8 = zext i1 %t5 to i64
  %t9 = icmp ne i64 %t8, 0
  br i1 %t9, label %L1, label %L3
L1:
  %t10 = load ptr, ptr %t0
  %t11 = load i64, ptr %t1
  %t13 = sext i32 %t11 to i64
  %t12 = getelementptr ptr, ptr %t10, i64 %t13
  %t14 = load ptr, ptr %t12
  call void @free(ptr %t14)
  br label %L2
L2:
  %t16 = load i64, ptr %t1
  %t18 = sext i32 %t16 to i64
  %t17 = add i64 %t18, 1
  store i64 %t17, ptr %t1
  br label %L0
L3:
  %t19 = alloca i64
  %t20 = sext i32 0 to i64
  store i64 %t20, ptr %t19
  br label %L4
L4:
  %t21 = load i64, ptr %t19
  %t22 = load ptr, ptr %t0
  %t24 = sext i32 %t21 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp slt i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L5, label %L7
L5:
  %t28 = load ptr, ptr %t0
  %t29 = load i64, ptr %t19
  %t30 = sext i32 %t29 to i64
  %t31 = getelementptr ptr, ptr %t28, i64 %t30
  %t32 = load ptr, ptr %t31
  call void @free(ptr %t32)
  br label %L6
L6:
  %t34 = load i64, ptr %t19
  %t36 = sext i32 %t34 to i64
  %t35 = add i64 %t36, 1
  store i64 %t35, ptr %t19
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
  %t7 = getelementptr [19 x i8], ptr @.str345, i64 0, i64 0
  %t8 = load ptr, ptr %t0
  call void (ptr, ...) @__c0c_emit(ptr %t6, ptr %t7, ptr %t8)
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr [24 x i8], ptr @.str346, i64 0, i64 0
  %t12 = load ptr, ptr %t0
  call void (ptr, ...) @__c0c_emit(ptr %t10, ptr %t11, ptr %t12)
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr [57 x i8], ptr @.str347, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t14, ptr %t15)
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr [45 x i8], ptr @.str348, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t17, ptr %t18)
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr [23 x i8], ptr @.str349, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t20, ptr %t21)
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr [26 x i8], ptr @.str350, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t23, ptr %t24)
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr [31 x i8], ptr @.str351, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t26, ptr %t27)
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr [32 x i8], ptr @.str352, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t29, ptr %t30)
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr [25 x i8], ptr @.str353, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t32, ptr %t33)
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr [26 x i8], ptr @.str354, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t35, ptr %t36)
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr [26 x i8], ptr @.str355, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr [32 x i8], ptr @.str356, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr [31 x i8], ptr @.str357, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t44, ptr %t45)
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr [37 x i8], ptr @.str358, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t47, ptr %t48)
  %t50 = load ptr, ptr %t0
  %t51 = getelementptr [31 x i8], ptr @.str359, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t50, ptr %t51)
  %t53 = load ptr, ptr %t0
  %t54 = getelementptr [31 x i8], ptr @.str360, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t53, ptr %t54)
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr [31 x i8], ptr @.str361, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t56, ptr %t57)
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr [31 x i8], ptr @.str362, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t59, ptr %t60)
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr [37 x i8], ptr @.str363, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t62, ptr %t63)
  %t65 = load ptr, ptr %t0
  %t66 = getelementptr [36 x i8], ptr @.str364, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t65, ptr %t66)
  %t68 = load ptr, ptr %t0
  %t69 = getelementptr [36 x i8], ptr @.str365, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t68, ptr %t69)
  %t71 = load ptr, ptr %t0
  %t72 = getelementptr [36 x i8], ptr @.str366, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t71, ptr %t72)
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr [31 x i8], ptr @.str367, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t74, ptr %t75)
  %t77 = load ptr, ptr %t0
  %t78 = getelementptr [37 x i8], ptr @.str368, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t77, ptr %t78)
  %t80 = load ptr, ptr %t0
  %t81 = getelementptr [37 x i8], ptr @.str369, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t80, ptr %t81)
  %t83 = load ptr, ptr %t0
  %t84 = getelementptr [43 x i8], ptr @.str370, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t83, ptr %t84)
  %t86 = load ptr, ptr %t0
  %t87 = getelementptr [38 x i8], ptr @.str371, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t86, ptr %t87)
  %t89 = load ptr, ptr %t0
  %t90 = getelementptr [44 x i8], ptr @.str372, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t89, ptr %t90)
  %t92 = load ptr, ptr %t0
  %t93 = getelementptr [30 x i8], ptr @.str373, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t92, ptr %t93)
  %t95 = load ptr, ptr %t0
  %t96 = getelementptr [26 x i8], ptr @.str374, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t95, ptr %t96)
  %t98 = load ptr, ptr %t0
  %t99 = getelementptr [40 x i8], ptr @.str375, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t98, ptr %t99)
  %t101 = load ptr, ptr %t0
  %t102 = getelementptr [41 x i8], ptr @.str376, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t101, ptr %t102)
  %t104 = load ptr, ptr %t0
  %t105 = getelementptr [35 x i8], ptr @.str377, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t104, ptr %t105)
  %t107 = load ptr, ptr %t0
  %t108 = getelementptr [25 x i8], ptr @.str378, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t107, ptr %t108)
  %t110 = load ptr, ptr %t0
  %t111 = getelementptr [27 x i8], ptr @.str379, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t110, ptr %t111)
  %t113 = load ptr, ptr %t0
  %t114 = getelementptr [25 x i8], ptr @.str380, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t113, ptr %t114)
  %t116 = load ptr, ptr %t0
  %t117 = getelementptr [26 x i8], ptr @.str381, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t116, ptr %t117)
  %t119 = load ptr, ptr %t0
  %t120 = getelementptr [24 x i8], ptr @.str382, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t119, ptr %t120)
  %t122 = load ptr, ptr %t0
  %t123 = getelementptr [24 x i8], ptr @.str383, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t122, ptr %t123)
  %t125 = load ptr, ptr %t0
  %t126 = getelementptr [36 x i8], ptr @.str384, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t125, ptr %t126)
  %t128 = load ptr, ptr %t0
  %t129 = getelementptr [37 x i8], ptr @.str385, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t128, ptr %t129)
  %t131 = load ptr, ptr %t0
  %t132 = getelementptr [27 x i8], ptr @.str386, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t131, ptr %t132)
  %t134 = load ptr, ptr %t0
  %t135 = getelementptr [27 x i8], ptr @.str387, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t134, ptr %t135)
  %t137 = load ptr, ptr %t0
  %t138 = getelementptr [27 x i8], ptr @.str388, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t137, ptr %t138)
  %t140 = load ptr, ptr %t0
  %t141 = getelementptr [27 x i8], ptr @.str389, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t140, ptr %t141)
  %t143 = load ptr, ptr %t0
  %t144 = getelementptr [27 x i8], ptr @.str390, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t143, ptr %t144)
  %t146 = load ptr, ptr %t0
  %t147 = getelementptr [28 x i8], ptr @.str391, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t146, ptr %t147)
  %t149 = load ptr, ptr %t0
  %t150 = getelementptr [27 x i8], ptr @.str392, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t149, ptr %t150)
  %t152 = load ptr, ptr %t0
  %t153 = getelementptr [27 x i8], ptr @.str393, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t152, ptr %t153)
  %t155 = load ptr, ptr %t0
  %t156 = getelementptr [27 x i8], ptr @.str394, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t155, ptr %t156)
  %t158 = load ptr, ptr %t0
  %t159 = getelementptr [27 x i8], ptr @.str395, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t158, ptr %t159)
  %t161 = load ptr, ptr %t0
  %t162 = getelementptr [26 x i8], ptr @.str396, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t161, ptr %t162)
  %t164 = load ptr, ptr %t0
  %t165 = getelementptr [29 x i8], ptr @.str397, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t164, ptr %t165)
  %t167 = load ptr, ptr %t0
  %t168 = getelementptr [29 x i8], ptr @.str398, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t167, ptr %t168)
  %t170 = load ptr, ptr %t0
  %t171 = getelementptr [28 x i8], ptr @.str399, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t170, ptr %t171)
  %t173 = load ptr, ptr %t0
  %t174 = getelementptr [34 x i8], ptr @.str400, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t173, ptr %t174)
  %t176 = load ptr, ptr %t0
  %t177 = getelementptr [37 x i8], ptr @.str401, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t176, ptr %t177)
  %t179 = load ptr, ptr %t0
  %t180 = getelementptr [37 x i8], ptr @.str402, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t179, ptr %t180)
  %t182 = load ptr, ptr %t0
  %t183 = getelementptr [41 x i8], ptr @.str403, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t182, ptr %t183)
  %t185 = load ptr, ptr %t0
  %t186 = getelementptr [2 x i8], ptr @.str404, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t185, ptr %t186)
  %t188 = alloca ptr
  %t189 = sext i32 0 to i64
  store i64 %t189, ptr %t188
  %t190 = alloca i64
  %t191 = sext i32 0 to i64
  store i64 %t191, ptr %t190
  br label %L4
L4:
  %t192 = load ptr, ptr %t188
  %t193 = load i64, ptr %t190
  %t194 = sext i32 %t193 to i64
  %t195 = getelementptr ptr, ptr %t192, i64 %t194
  %t196 = load ptr, ptr %t195
  %t197 = icmp ne ptr %t196, null
  br i1 %t197, label %L5, label %L7
L5:
  %t198 = alloca i64
  %t199 = sext i32 0 to i64
  store i64 %t199, ptr %t198
  %t200 = alloca i64
  %t201 = sext i32 0 to i64
  store i64 %t201, ptr %t200
  br label %L8
L8:
  %t202 = load i64, ptr %t200
  %t203 = load ptr, ptr %t0
  %t205 = sext i32 %t202 to i64
  %t206 = ptrtoint ptr %t203 to i64
  %t204 = icmp slt i64 %t205, %t206
  %t207 = zext i1 %t204 to i64
  %t208 = icmp ne i64 %t207, 0
  br i1 %t208, label %L9, label %L11
L9:
  %t209 = load ptr, ptr %t0
  %t210 = load i64, ptr %t200
  %t212 = sext i32 %t210 to i64
  %t211 = getelementptr ptr, ptr %t209, i64 %t212
  %t213 = load ptr, ptr %t211
  %t214 = load ptr, ptr %t188
  %t215 = load i64, ptr %t190
  %t216 = sext i32 %t215 to i64
  %t217 = getelementptr ptr, ptr %t214, i64 %t216
  %t218 = load ptr, ptr %t217
  %t219 = call i32 @strcmp(ptr %t213, ptr %t218)
  %t220 = sext i32 %t219 to i64
  %t222 = sext i32 0 to i64
  %t221 = icmp eq i64 %t220, %t222
  %t223 = zext i1 %t221 to i64
  %t224 = icmp ne i64 %t223, 0
  br i1 %t224, label %L12, label %L14
L12:
  %t225 = sext i32 1 to i64
  store i64 %t225, ptr %t198
  br label %L11
L15:
  br label %L14
L14:
  br label %L10
L10:
  %t226 = load i64, ptr %t200
  %t228 = sext i32 %t226 to i64
  %t227 = add i64 %t228, 1
  store i64 %t227, ptr %t200
  br label %L8
L11:
  %t229 = load i64, ptr %t198
  %t231 = sext i32 %t229 to i64
  %t232 = icmp eq i64 %t231, 0
  %t230 = zext i1 %t232 to i64
  %t233 = icmp ne i64 %t230, 0
  br i1 %t233, label %L16, label %L17
L16:
  %t234 = load ptr, ptr %t0
  %t236 = ptrtoint ptr %t234 to i64
  %t237 = sext i32 2048 to i64
  %t235 = icmp slt i64 %t236, %t237
  %t238 = zext i1 %t235 to i64
  %t239 = icmp ne i64 %t238, 0
  %t240 = zext i1 %t239 to i64
  br label %L18
L17:
  br label %L18
L18:
  %t241 = phi i64 [ %t240, %L16 ], [ 0, %L17 ]
  %t242 = icmp ne i64 %t241, 0
  br i1 %t242, label %L19, label %L21
L19:
  %t243 = load ptr, ptr %t188
  %t244 = load i64, ptr %t190
  %t245 = sext i32 %t244 to i64
  %t246 = getelementptr ptr, ptr %t243, i64 %t245
  %t247 = load ptr, ptr %t246
  %t248 = call ptr @strdup(ptr %t247)
  %t249 = load ptr, ptr %t0
  %t250 = load ptr, ptr %t0
  %t252 = ptrtoint ptr %t250 to i64
  %t251 = getelementptr ptr, ptr %t249, i64 %t252
  store ptr %t248, ptr %t251
  %t254 = sext i32 0 to i64
  %t253 = inttoptr i64 %t254 to ptr
  %t255 = load ptr, ptr %t0
  %t256 = load ptr, ptr %t0
  %t258 = ptrtoint ptr %t256 to i64
  %t257 = getelementptr ptr, ptr %t255, i64 %t258
  store ptr %t253, ptr %t257
  %t259 = load ptr, ptr %t0
  %t260 = load ptr, ptr %t0
  %t262 = ptrtoint ptr %t260 to i64
  %t261 = getelementptr ptr, ptr %t259, i64 %t262
  %t263 = sext i32 1 to i64
  store i64 %t263, ptr %t261
  %t264 = load ptr, ptr %t0
  %t266 = ptrtoint ptr %t264 to i64
  %t265 = add i64 %t266, 1
  store i64 %t265, ptr %t0
  br label %L21
L21:
  br label %L6
L6:
  %t267 = load i64, ptr %t190
  %t269 = sext i32 %t267 to i64
  %t268 = add i64 %t269, 1
  store i64 %t268, ptr %t190
  br label %L4
L7:
  %t270 = alloca i64
  %t271 = sext i32 0 to i64
  store i64 %t271, ptr %t270
  br label %L22
L22:
  %t272 = load i64, ptr %t270
  %t273 = load ptr, ptr %t1
  %t275 = sext i32 %t272 to i64
  %t276 = ptrtoint ptr %t273 to i64
  %t274 = icmp slt i64 %t275, %t276
  %t277 = zext i1 %t274 to i64
  %t278 = icmp ne i64 %t277, 0
  br i1 %t278, label %L23, label %L25
L23:
  %t279 = alloca ptr
  %t280 = load ptr, ptr %t1
  %t281 = load i64, ptr %t270
  %t282 = sext i32 %t281 to i64
  %t283 = getelementptr ptr, ptr %t280, i64 %t282
  %t284 = load ptr, ptr %t283
  store ptr %t284, ptr %t279
  %t285 = load ptr, ptr %t279
  %t287 = ptrtoint ptr %t285 to i64
  %t288 = icmp eq i64 %t287, 0
  %t286 = zext i1 %t288 to i64
  %t289 = icmp ne i64 %t286, 0
  br i1 %t289, label %L26, label %L28
L26:
  br label %L24
L29:
  br label %L28
L28:
  %t290 = load ptr, ptr %t279
  %t291 = load ptr, ptr %t290
  %t293 = ptrtoint ptr %t291 to i64
  %t294 = sext i32 1 to i64
  %t292 = icmp eq i64 %t293, %t294
  %t295 = zext i1 %t292 to i64
  %t296 = icmp ne i64 %t295, 0
  br i1 %t296, label %L30, label %L32
L30:
  %t297 = alloca i64
  %t298 = sext i32 0 to i64
  store i64 %t298, ptr %t297
  %t299 = alloca i64
  %t300 = sext i32 0 to i64
  store i64 %t300, ptr %t299
  br label %L33
L33:
  %t301 = load i64, ptr %t299
  %t302 = load ptr, ptr %t0
  %t304 = sext i32 %t301 to i64
  %t305 = ptrtoint ptr %t302 to i64
  %t303 = icmp slt i64 %t304, %t305
  %t306 = zext i1 %t303 to i64
  %t307 = icmp ne i64 %t306, 0
  br i1 %t307, label %L34, label %L36
L34:
  %t308 = load ptr, ptr %t0
  %t309 = load i64, ptr %t299
  %t311 = sext i32 %t309 to i64
  %t310 = getelementptr ptr, ptr %t308, i64 %t311
  %t312 = load ptr, ptr %t310
  %t313 = load ptr, ptr %t279
  %t314 = load ptr, ptr %t313
  %t315 = icmp ne ptr %t314, null
  br i1 %t315, label %L37, label %L38
L37:
  %t316 = load ptr, ptr %t279
  %t317 = load ptr, ptr %t316
  %t318 = ptrtoint ptr %t317 to i64
  br label %L39
L38:
  %t319 = getelementptr [1 x i8], ptr @.str405, i64 0, i64 0
  %t320 = ptrtoint ptr %t319 to i64
  br label %L39
L39:
  %t321 = phi i64 [ %t318, %L37 ], [ %t320, %L38 ]
  %t322 = call i32 @strcmp(ptr %t312, i64 %t321)
  %t323 = sext i32 %t322 to i64
  %t325 = sext i32 0 to i64
  %t324 = icmp eq i64 %t323, %t325
  %t326 = zext i1 %t324 to i64
  %t327 = icmp ne i64 %t326, 0
  br i1 %t327, label %L40, label %L42
L40:
  %t328 = sext i32 1 to i64
  store i64 %t328, ptr %t297
  br label %L36
L43:
  br label %L42
L42:
  br label %L35
L35:
  %t329 = load i64, ptr %t299
  %t331 = sext i32 %t329 to i64
  %t330 = add i64 %t331, 1
  store i64 %t330, ptr %t299
  br label %L33
L36:
  %t332 = load i64, ptr %t297
  %t334 = sext i32 %t332 to i64
  %t335 = icmp eq i64 %t334, 0
  %t333 = zext i1 %t335 to i64
  %t336 = icmp ne i64 %t333, 0
  br i1 %t336, label %L44, label %L45
L44:
  %t337 = load ptr, ptr %t0
  %t339 = ptrtoint ptr %t337 to i64
  %t340 = sext i32 2048 to i64
  %t338 = icmp slt i64 %t339, %t340
  %t341 = zext i1 %t338 to i64
  %t342 = icmp ne i64 %t341, 0
  %t343 = zext i1 %t342 to i64
  br label %L46
L45:
  br label %L46
L46:
  %t344 = phi i64 [ %t343, %L44 ], [ 0, %L45 ]
  %t345 = icmp ne i64 %t344, 0
  br i1 %t345, label %L47, label %L49
L47:
  %t346 = load ptr, ptr %t279
  %t347 = load ptr, ptr %t346
  %t348 = icmp ne ptr %t347, null
  br i1 %t348, label %L50, label %L51
L50:
  %t349 = load ptr, ptr %t279
  %t350 = load ptr, ptr %t349
  %t351 = ptrtoint ptr %t350 to i64
  br label %L52
L51:
  %t352 = getelementptr [7 x i8], ptr @.str406, i64 0, i64 0
  %t353 = ptrtoint ptr %t352 to i64
  br label %L52
L52:
  %t354 = phi i64 [ %t351, %L50 ], [ %t353, %L51 ]
  %t355 = call ptr @strdup(i64 %t354)
  %t356 = load ptr, ptr %t0
  %t357 = load ptr, ptr %t0
  %t359 = ptrtoint ptr %t357 to i64
  %t358 = getelementptr ptr, ptr %t356, i64 %t359
  store ptr %t355, ptr %t358
  %t360 = load ptr, ptr %t279
  %t361 = load ptr, ptr %t360
  %t362 = load ptr, ptr %t0
  %t363 = load ptr, ptr %t0
  %t365 = ptrtoint ptr %t363 to i64
  %t364 = getelementptr ptr, ptr %t362, i64 %t365
  store ptr %t361, ptr %t364
  %t366 = load ptr, ptr %t0
  %t367 = load ptr, ptr %t0
  %t369 = ptrtoint ptr %t367 to i64
  %t368 = getelementptr ptr, ptr %t366, i64 %t369
  %t370 = sext i32 0 to i64
  store i64 %t370, ptr %t368
  %t371 = load ptr, ptr %t0
  %t373 = ptrtoint ptr %t371 to i64
  %t372 = add i64 %t373, 1
  store i64 %t372, ptr %t0
  br label %L49
L49:
  br label %L32
L32:
  br label %L24
L24:
  %t374 = load i64, ptr %t270
  %t376 = sext i32 %t374 to i64
  %t375 = add i64 %t376, 1
  store i64 %t375, ptr %t270
  br label %L22
L25:
  %t377 = alloca i64
  %t378 = sext i32 0 to i64
  store i64 %t378, ptr %t377
  br label %L53
L53:
  %t379 = load i64, ptr %t377
  %t380 = load ptr, ptr %t1
  %t382 = sext i32 %t379 to i64
  %t383 = ptrtoint ptr %t380 to i64
  %t381 = icmp slt i64 %t382, %t383
  %t384 = zext i1 %t381 to i64
  %t385 = icmp ne i64 %t384, 0
  br i1 %t385, label %L54, label %L56
L54:
  %t386 = alloca ptr
  %t387 = load ptr, ptr %t1
  %t388 = load i64, ptr %t377
  %t389 = sext i32 %t388 to i64
  %t390 = getelementptr ptr, ptr %t387, i64 %t389
  %t391 = load ptr, ptr %t390
  store ptr %t391, ptr %t386
  %t392 = load ptr, ptr %t386
  %t394 = ptrtoint ptr %t392 to i64
  %t395 = icmp eq i64 %t394, 0
  %t393 = zext i1 %t395 to i64
  %t396 = icmp ne i64 %t393, 0
  br i1 %t396, label %L57, label %L59
L57:
  br label %L55
L60:
  br label %L59
L59:
  %t397 = load ptr, ptr %t386
  %t398 = load ptr, ptr %t397
  %t400 = ptrtoint ptr %t398 to i64
  %t401 = sext i32 2 to i64
  %t399 = icmp eq i64 %t400, %t401
  %t402 = zext i1 %t399 to i64
  %t403 = icmp ne i64 %t402, 0
  br i1 %t403, label %L61, label %L63
L61:
  %t404 = load ptr, ptr %t386
  call void @emit_global_var(ptr %t0, ptr %t404)
  br label %L63
L63:
  br label %L55
L55:
  %t406 = load i64, ptr %t377
  %t408 = sext i32 %t406 to i64
  %t407 = add i64 %t408, 1
  store i64 %t407, ptr %t377
  br label %L53
L56:
  %t409 = load ptr, ptr %t0
  %t410 = getelementptr [2 x i8], ptr @.str407, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t409, ptr %t410)
  %t412 = alloca i64
  %t413 = sext i32 0 to i64
  store i64 %t413, ptr %t412
  br label %L64
L64:
  %t414 = load i64, ptr %t412
  %t415 = load ptr, ptr %t1
  %t417 = sext i32 %t414 to i64
  %t418 = ptrtoint ptr %t415 to i64
  %t416 = icmp slt i64 %t417, %t418
  %t419 = zext i1 %t416 to i64
  %t420 = icmp ne i64 %t419, 0
  br i1 %t420, label %L65, label %L67
L65:
  %t421 = alloca ptr
  %t422 = load ptr, ptr %t1
  %t423 = load i64, ptr %t412
  %t424 = sext i32 %t423 to i64
  %t425 = getelementptr ptr, ptr %t422, i64 %t424
  %t426 = load ptr, ptr %t425
  store ptr %t426, ptr %t421
  %t427 = load ptr, ptr %t421
  %t429 = ptrtoint ptr %t427 to i64
  %t430 = icmp eq i64 %t429, 0
  %t428 = zext i1 %t430 to i64
  %t431 = icmp ne i64 %t428, 0
  br i1 %t431, label %L68, label %L70
L68:
  br label %L66
L71:
  br label %L70
L70:
  %t432 = load ptr, ptr %t421
  %t433 = load ptr, ptr %t432
  %t435 = ptrtoint ptr %t433 to i64
  %t436 = sext i32 1 to i64
  %t434 = icmp eq i64 %t435, %t436
  %t437 = zext i1 %t434 to i64
  %t438 = icmp ne i64 %t437, 0
  br i1 %t438, label %L72, label %L74
L72:
  %t439 = load ptr, ptr %t421
  call void @emit_func_def(ptr %t0, ptr %t439)
  br label %L74
L74:
  br label %L66
L66:
  %t441 = load i64, ptr %t412
  %t443 = sext i32 %t441 to i64
  %t442 = add i64 %t443, 1
  store i64 %t442, ptr %t412
  br label %L64
L67:
  %t444 = alloca i64
  %t445 = sext i32 0 to i64
  store i64 %t445, ptr %t444
  br label %L75
L75:
  %t446 = load i64, ptr %t444
  %t447 = load ptr, ptr %t0
  %t449 = sext i32 %t446 to i64
  %t450 = ptrtoint ptr %t447 to i64
  %t448 = icmp slt i64 %t449, %t450
  %t451 = zext i1 %t448 to i64
  %t452 = icmp ne i64 %t451, 0
  br i1 %t452, label %L76, label %L78
L76:
  %t453 = alloca i64
  %t454 = load ptr, ptr %t0
  %t455 = load i64, ptr %t444
  %t456 = sext i32 %t455 to i64
  %t457 = getelementptr ptr, ptr %t454, i64 %t456
  %t458 = load ptr, ptr %t457
  %t459 = call i32 @str_literal_len(ptr %t458)
  %t460 = sext i32 %t459 to i64
  store i64 %t460, ptr %t453
  %t461 = load ptr, ptr %t0
  %t462 = getelementptr [53 x i8], ptr @.str408, i64 0, i64 0
  %t463 = load ptr, ptr %t0
  %t464 = load i64, ptr %t444
  %t465 = sext i32 %t464 to i64
  %t466 = getelementptr ptr, ptr %t463, i64 %t465
  %t467 = load ptr, ptr %t466
  %t468 = load i64, ptr %t453
  call void (ptr, ...) @__c0c_emit(ptr %t461, ptr %t462, ptr %t467, i64 %t468)
  %t470 = load ptr, ptr %t0
  %t471 = load i64, ptr %t444
  %t472 = sext i32 %t471 to i64
  %t473 = getelementptr ptr, ptr %t470, i64 %t472
  %t474 = load ptr, ptr %t473
  call void @emit_str_content(ptr %t0, ptr %t474)
  %t476 = load ptr, ptr %t0
  %t477 = getelementptr [3 x i8], ptr @.str409, i64 0, i64 0
  call void (ptr, ...) @__c0c_emit(ptr %t476, ptr %t477)
  br label %L77
L77:
  %t479 = load i64, ptr %t444
  %t481 = sext i32 %t479 to i64
  %t480 = add i64 %t481, 1
  store i64 %t480, ptr %t444
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
@.str64 = private unnamed_addr constant [27 x i8] c"  call void (ptr, ...) %s(\00"
@.str65 = private unnamed_addr constant [16 x i8] c"  call void %s(\00"
@.str66 = private unnamed_addr constant [33 x i8] c"  %%t%d = call %s (ptr, ...) %s(\00"
@.str67 = private unnamed_addr constant [22 x i8] c"  %%t%d = call %s %s(\00"
@.str68 = private unnamed_addr constant [3 x i8] c", \00"
@.str69 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str70 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str71 = private unnamed_addr constant [6 x i8] c"%s %s\00"
@.str72 = private unnamed_addr constant [3 x i8] c")\0A\00"
@.str73 = private unnamed_addr constant [2 x i8] c"0\00"
@.str74 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str75 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str76 = private unnamed_addr constant [32 x i8] c"  %%t%d = sext %s %%t%d to i64\0A\00"
@.str77 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str78 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str79 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str80 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str81 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str82 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str83 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str84 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str85 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str86 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str87 = private unnamed_addr constant [50 x i8] c"  %%t%d = phi i64 [ %%t%d, %%L%d ], [ 0, %%L%d ]\0A\00"
@.str88 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str89 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str90 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str91 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str92 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str93 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str94 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp ne i64 %s, 0\0A\00"
@.str95 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str96 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str97 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str98 = private unnamed_addr constant [50 x i8] c"  %%t%d = phi i64 [ 1, %%L%d ], [ %%t%d, %%L%d ]\0A\00"
@.str99 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str100 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str101 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str102 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str103 = private unnamed_addr constant [14 x i8] c"getelementptr\00"
@.str104 = private unnamed_addr constant [4 x i8] c"add\00"
@.str105 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str106 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str107 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str108 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str109 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str110 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str111 = private unnamed_addr constant [5 x i8] c"frem\00"
@.str112 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str113 = private unnamed_addr constant [4 x i8] c"and\00"
@.str114 = private unnamed_addr constant [3 x i8] c"or\00"
@.str115 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str116 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str117 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str118 = private unnamed_addr constant [9 x i8] c"fcmp oeq\00"
@.str119 = private unnamed_addr constant [8 x i8] c"icmp eq\00"
@.str120 = private unnamed_addr constant [9 x i8] c"fcmp one\00"
@.str121 = private unnamed_addr constant [8 x i8] c"icmp ne\00"
@.str122 = private unnamed_addr constant [9 x i8] c"fcmp olt\00"
@.str123 = private unnamed_addr constant [9 x i8] c"icmp slt\00"
@.str124 = private unnamed_addr constant [9 x i8] c"fcmp ogt\00"
@.str125 = private unnamed_addr constant [9 x i8] c"icmp sgt\00"
@.str126 = private unnamed_addr constant [9 x i8] c"fcmp ole\00"
@.str127 = private unnamed_addr constant [9 x i8] c"icmp sle\00"
@.str128 = private unnamed_addr constant [9 x i8] c"fcmp oge\00"
@.str129 = private unnamed_addr constant [9 x i8] c"icmp sge\00"
@.str130 = private unnamed_addr constant [4 x i8] c"add\00"
@.str131 = private unnamed_addr constant [4 x i8] c"add\00"
@.str132 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str133 = private unnamed_addr constant [47 x i8] c"  %%t%d = getelementptr i8, ptr %%t%d, i64 %s\0A\00"
@.str134 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str135 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str136 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str137 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str138 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str139 = private unnamed_addr constant [26 x i8] c"  %%t%d = fneg double %s\0A\00"
@.str140 = private unnamed_addr constant [25 x i8] c"  %%t%d = sub i64 0, %s\0A\00"
@.str141 = private unnamed_addr constant [29 x i8] c"  %%t%d = icmp eq i64 %s, 0\0A\00"
@.str142 = private unnamed_addr constant [32 x i8] c"  %%t%d = zext i1 %%t%d to i64\0A\00"
@.str143 = private unnamed_addr constant [26 x i8] c"  %%t%d = xor i64 %s, -1\0A\00"
@.str144 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str145 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str146 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str147 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str148 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str149 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str150 = private unnamed_addr constant [23 x i8] c"  store %s %s, ptr %s\0A\00"
@.str151 = private unnamed_addr constant [7 x i8] c"double\00"
@.str152 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str153 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str154 = private unnamed_addr constant [4 x i8] c"add\00"
@.str155 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str156 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str157 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str158 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str159 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str160 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str161 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str162 = private unnamed_addr constant [4 x i8] c"and\00"
@.str163 = private unnamed_addr constant [3 x i8] c"or\00"
@.str164 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str165 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str166 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str167 = private unnamed_addr constant [4 x i8] c"add\00"
@.str168 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s %s %s, %s\0A\00"
@.str169 = private unnamed_addr constant [26 x i8] c"  store %s %%t%d, ptr %s\0A\00"
@.str170 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str171 = private unnamed_addr constant [4 x i8] c"add\00"
@.str172 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str173 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s i64 %s, 1\0A\00"
@.str174 = private unnamed_addr constant [27 x i8] c"  store i64 %%t%d, ptr %s\0A\00"
@.str175 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str176 = private unnamed_addr constant [4 x i8] c"add\00"
@.str177 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str178 = private unnamed_addr constant [24 x i8] c"  %%t%d = %s i64 %s, 1\0A\00"
@.str179 = private unnamed_addr constant [27 x i8] c"  store i64 %%t%d, ptr %s\0A\00"
@.str180 = private unnamed_addr constant [5 x i8] c"null\00"
@.str181 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str182 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str183 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str184 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str185 = private unnamed_addr constant [27 x i8] c"  %%t%d = load %s, ptr %s\0A\00"
@.str186 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str187 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str188 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str189 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str190 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str191 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str192 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str193 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str194 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str195 = private unnamed_addr constant [44 x i8] c"  %%t%d = getelementptr %s, ptr %s, i64 %s\0A\00"
@.str196 = private unnamed_addr constant [30 x i8] c"  %%t%d = load %s, ptr %%t%d\0A\00"
@.str197 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str198 = private unnamed_addr constant [36 x i8] c"  %%t%d = fpext float %s to double\0A\00"
@.str199 = private unnamed_addr constant [38 x i8] c"  %%t%d = fptrunc double %s to float\0A\00"
@.str200 = private unnamed_addr constant [35 x i8] c"  %%t%d = fptosi double %s to i64\0A\00"
@.str201 = private unnamed_addr constant [31 x i8] c"  %%t%d = sitofp i64 %s to %s\0A\00"
@.str202 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str203 = private unnamed_addr constant [34 x i8] c"  %%t%d = ptrtoint ptr %s to i64\0A\00"
@.str204 = private unnamed_addr constant [33 x i8] c"  %%t%d = bitcast ptr %s to ptr\0A\00"
@.str205 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str206 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str207 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str208 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str209 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str210 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str211 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str212 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str213 = private unnamed_addr constant [48 x i8] c"  %%t%d = phi i64 [ %s, %%L%d ], [ %s, %%L%d ]\0A\00"
@.str214 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str215 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str216 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str217 = private unnamed_addr constant [2 x i8] c"0\00"
@.str218 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str219 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str220 = private unnamed_addr constant [28 x i8] c"  %%t%d = load ptr, ptr %s\0A\00"
@.str221 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str222 = private unnamed_addr constant [28 x i8] c"  ; unhandled expr node %d\0A\00"
@.str223 = private unnamed_addr constant [2 x i8] c"0\00"
@.str224 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str225 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str226 = private unnamed_addr constant [21 x i8] c"  %%t%d = alloca %s\0A\00"
@.str227 = private unnamed_addr constant [22 x i8] c"c0c: too many locals\0A\00"
@.str228 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str229 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str230 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str231 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str232 = private unnamed_addr constant [30 x i8] c"  %%t%d = sext i32 %s to i64\0A\00"
@.str233 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str234 = private unnamed_addr constant [26 x i8] c"  store %s %s, ptr %%t%d\0A\00"
@.str235 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str236 = private unnamed_addr constant [13 x i8] c"  ret %s %s\0A\00"
@.str237 = private unnamed_addr constant [14 x i8] c"  ret ptr %s\0A\00"
@.str238 = private unnamed_addr constant [34 x i8] c"  %%t%d = inttoptr i64 %s to ptr\0A\00"
@.str239 = private unnamed_addr constant [17 x i8] c"  ret ptr %%t%d\0A\00"
@.str240 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str241 = private unnamed_addr constant [30 x i8] c"  %%t%d = trunc i64 %s to i8\0A\00"
@.str242 = private unnamed_addr constant [16 x i8] c"  ret i8 %%t%d\0A\00"
@.str243 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str244 = private unnamed_addr constant [31 x i8] c"  %%t%d = trunc i64 %s to i16\0A\00"
@.str245 = private unnamed_addr constant [17 x i8] c"  ret i16 %%t%d\0A\00"
@.str246 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str247 = private unnamed_addr constant [31 x i8] c"  %%t%d = trunc i64 %s to i32\0A\00"
@.str248 = private unnamed_addr constant [17 x i8] c"  ret i32 %%t%d\0A\00"
@.str249 = private unnamed_addr constant [14 x i8] c"  ret i64 %s\0A\00"
@.str250 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str251 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str252 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str253 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str254 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str255 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str256 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str257 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str258 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str259 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str260 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str261 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str262 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str263 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str264 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str265 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str266 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str267 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str268 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str269 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str270 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str271 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str272 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str273 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str274 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str275 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str276 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str277 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str278 = private unnamed_addr constant [41 x i8] c"  br i1 %%t%d, label %%L%d, label %%L%d\0A\00"
@.str279 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str280 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str281 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str282 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str283 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str284 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str285 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str286 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str287 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str288 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str289 = private unnamed_addr constant [4 x i8] c"L%d\00"
@.str290 = private unnamed_addr constant [25 x i8] c"  %%t%d = add i64 %s, 0\0A\00"
@.str291 = private unnamed_addr constant [35 x i8] c"  switch i64 %%t%d, label %%L%d [\0A\00"
@.str292 = private unnamed_addr constant [27 x i8] c"    i64 %lld, label %%L%d\0A\00"
@.str293 = private unnamed_addr constant [5 x i8] c"  ]\0A\00"
@.str294 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str295 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str296 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str297 = private unnamed_addr constant [18 x i8] c"  br label %%L%d\0A\00"
@.str298 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str299 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str300 = private unnamed_addr constant [5 x i8] c"%s:\0A\00"
@.str301 = private unnamed_addr constant [17 x i8] c"  br label %%%s\0A\00"
@.str302 = private unnamed_addr constant [6 x i8] c"L%d:\0A\00"
@.str303 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str304 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str305 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str306 = private unnamed_addr constant [18 x i8] c"define %s %s @%s(\00"
@.str307 = private unnamed_addr constant [5 x i8] c"anon\00"
@.str308 = private unnamed_addr constant [3 x i8] c", \00"
@.str309 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str310 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str311 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str312 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str313 = private unnamed_addr constant [9 x i8] c"%s %%t%d\00"
@.str314 = private unnamed_addr constant [22 x i8] c"c0c: too many locals\0A\00"
@.str315 = private unnamed_addr constant [6 x i8] c"%%t%d\00"
@.str316 = private unnamed_addr constant [3 x i8] c", \00"
@.str317 = private unnamed_addr constant [4 x i8] c"...\00"
@.str318 = private unnamed_addr constant [5 x i8] c") {\0A\00"
@.str319 = private unnamed_addr constant [8 x i8] c"entry:\0A\00"
@.str320 = private unnamed_addr constant [12 x i8] c"  ret void\0A\00"
@.str321 = private unnamed_addr constant [16 x i8] c"  ret ptr null\0A\00"
@.str322 = private unnamed_addr constant [14 x i8] c"  ret %s 0.0\0A\00"
@.str323 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str324 = private unnamed_addr constant [12 x i8] c"  ret i8 0\0A\00"
@.str325 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str326 = private unnamed_addr constant [13 x i8] c"  ret i16 0\0A\00"
@.str327 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str328 = private unnamed_addr constant [13 x i8] c"  ret i32 0\0A\00"
@.str329 = private unnamed_addr constant [13 x i8] c"  ret i64 0\0A\00"
@.str330 = private unnamed_addr constant [4 x i8] c"}\0A\0A\00"
@.str331 = private unnamed_addr constant [3 x i8] c", \00"
@.str332 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str333 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str334 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str335 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str336 = private unnamed_addr constant [3 x i8] c"%s\00"
@.str337 = private unnamed_addr constant [3 x i8] c", \00"
@.str338 = private unnamed_addr constant [4 x i8] c"...\00"
@.str339 = private unnamed_addr constant [20 x i8] c"declare %s @%s(%s)\0A\00"
@.str340 = private unnamed_addr constant [26 x i8] c"@%s = external global %s\0A\00"
@.str341 = private unnamed_addr constant [9 x i8] c"internal\00"
@.str342 = private unnamed_addr constant [10 x i8] c"dso_local\00"
@.str343 = private unnamed_addr constant [36 x i8] c"@%s = %s global %s zeroinitializer\0A\00"
@.str344 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str345 = private unnamed_addr constant [19 x i8] c"; ModuleID = '%s'\0A\00"
@.str346 = private unnamed_addr constant [24 x i8] c"source_filename = \22%s\22\0A\00"
@.str347 = private unnamed_addr constant [57 x i8] c"target datalayout = \22e-m:o-i64:64-i128:128-n32:64-S128\22\0A\00"
@.str348 = private unnamed_addr constant [45 x i8] c"target triple = \22arm64-apple-macosx15.0.0\22\0A\0A\00"
@.str349 = private unnamed_addr constant [23 x i8] c"; stdlib declarations\0A\00"
@.str350 = private unnamed_addr constant [26 x i8] c"declare ptr @malloc(i64)\0A\00"
@.str351 = private unnamed_addr constant [31 x i8] c"declare ptr @calloc(i64, i64)\0A\00"
@.str352 = private unnamed_addr constant [32 x i8] c"declare ptr @realloc(ptr, i64)\0A\00"
@.str353 = private unnamed_addr constant [25 x i8] c"declare void @free(ptr)\0A\00"
@.str354 = private unnamed_addr constant [26 x i8] c"declare i64 @strlen(ptr)\0A\00"
@.str355 = private unnamed_addr constant [26 x i8] c"declare ptr @strdup(ptr)\0A\00"
@.str356 = private unnamed_addr constant [32 x i8] c"declare ptr @strndup(ptr, i64)\0A\00"
@.str357 = private unnamed_addr constant [31 x i8] c"declare ptr @strcpy(ptr, ptr)\0A\00"
@.str358 = private unnamed_addr constant [37 x i8] c"declare ptr @strncpy(ptr, ptr, i64)\0A\00"
@.str359 = private unnamed_addr constant [31 x i8] c"declare ptr @strcat(ptr, ptr)\0A\00"
@.str360 = private unnamed_addr constant [31 x i8] c"declare ptr @strchr(ptr, i64)\0A\00"
@.str361 = private unnamed_addr constant [31 x i8] c"declare ptr @strstr(ptr, ptr)\0A\00"
@.str362 = private unnamed_addr constant [31 x i8] c"declare i32 @strcmp(ptr, ptr)\0A\00"
@.str363 = private unnamed_addr constant [37 x i8] c"declare i32 @strncmp(ptr, ptr, i64)\0A\00"
@.str364 = private unnamed_addr constant [36 x i8] c"declare ptr @memcpy(ptr, ptr, i64)\0A\00"
@.str365 = private unnamed_addr constant [36 x i8] c"declare ptr @memset(ptr, i32, i64)\0A\00"
@.str366 = private unnamed_addr constant [36 x i8] c"declare i32 @memcmp(ptr, ptr, i64)\0A\00"
@.str367 = private unnamed_addr constant [31 x i8] c"declare i32 @printf(ptr, ...)\0A\00"
@.str368 = private unnamed_addr constant [37 x i8] c"declare i32 @fprintf(ptr, ptr, ...)\0A\00"
@.str369 = private unnamed_addr constant [37 x i8] c"declare i32 @sprintf(ptr, ptr, ...)\0A\00"
@.str370 = private unnamed_addr constant [43 x i8] c"declare i32 @snprintf(ptr, i64, ptr, ...)\0A\00"
@.str371 = private unnamed_addr constant [38 x i8] c"declare i32 @vfprintf(ptr, ptr, ptr)\0A\00"
@.str372 = private unnamed_addr constant [44 x i8] c"declare i32 @vsnprintf(ptr, i64, ptr, ptr)\0A\00"
@.str373 = private unnamed_addr constant [30 x i8] c"declare ptr @fopen(ptr, ptr)\0A\00"
@.str374 = private unnamed_addr constant [26 x i8] c"declare i32 @fclose(ptr)\0A\00"
@.str375 = private unnamed_addr constant [40 x i8] c"declare i64 @fread(ptr, i64, i64, ptr)\0A\00"
@.str376 = private unnamed_addr constant [41 x i8] c"declare i64 @fwrite(ptr, i64, i64, ptr)\0A\00"
@.str377 = private unnamed_addr constant [35 x i8] c"declare i32 @fseek(ptr, i64, i32)\0A\00"
@.str378 = private unnamed_addr constant [25 x i8] c"declare i64 @ftell(ptr)\0A\00"
@.str379 = private unnamed_addr constant [27 x i8] c"declare void @perror(ptr)\0A\00"
@.str380 = private unnamed_addr constant [25 x i8] c"declare void @exit(i32)\0A\00"
@.str381 = private unnamed_addr constant [26 x i8] c"declare ptr @getenv(ptr)\0A\00"
@.str382 = private unnamed_addr constant [24 x i8] c"declare i32 @atoi(ptr)\0A\00"
@.str383 = private unnamed_addr constant [24 x i8] c"declare i64 @atol(ptr)\0A\00"
@.str384 = private unnamed_addr constant [36 x i8] c"declare i64 @strtol(ptr, ptr, i32)\0A\00"
@.str385 = private unnamed_addr constant [37 x i8] c"declare i64 @strtoll(ptr, ptr, i32)\0A\00"
@.str386 = private unnamed_addr constant [27 x i8] c"declare double @atof(ptr)\0A\00"
@.str387 = private unnamed_addr constant [27 x i8] c"declare i32 @isspace(i32)\0A\00"
@.str388 = private unnamed_addr constant [27 x i8] c"declare i32 @isdigit(i32)\0A\00"
@.str389 = private unnamed_addr constant [27 x i8] c"declare i32 @isalpha(i32)\0A\00"
@.str390 = private unnamed_addr constant [27 x i8] c"declare i32 @isalnum(i32)\0A\00"
@.str391 = private unnamed_addr constant [28 x i8] c"declare i32 @isxdigit(i32)\0A\00"
@.str392 = private unnamed_addr constant [27 x i8] c"declare i32 @isupper(i32)\0A\00"
@.str393 = private unnamed_addr constant [27 x i8] c"declare i32 @islower(i32)\0A\00"
@.str394 = private unnamed_addr constant [27 x i8] c"declare i32 @toupper(i32)\0A\00"
@.str395 = private unnamed_addr constant [27 x i8] c"declare i32 @tolower(i32)\0A\00"
@.str396 = private unnamed_addr constant [26 x i8] c"declare i32 @assert(i32)\0A\00"
@.str397 = private unnamed_addr constant [29 x i8] c"declare ptr @__c0c_stderr()\0A\00"
@.str398 = private unnamed_addr constant [29 x i8] c"declare ptr @__c0c_stdout()\0A\00"
@.str399 = private unnamed_addr constant [28 x i8] c"declare ptr @__c0c_stdin()\0A\00"
@.str400 = private unnamed_addr constant [34 x i8] c"declare ptr @__c0c_get_tbuf(i32)\0A\00"
@.str401 = private unnamed_addr constant [37 x i8] c"declare ptr @__c0c_get_td_name(i64)\0A\00"
@.str402 = private unnamed_addr constant [37 x i8] c"declare i64 @__c0c_get_td_kind(i64)\0A\00"
@.str403 = private unnamed_addr constant [41 x i8] c"declare void @__c0c_emit(ptr, ptr, ...)\0A\00"
@.str404 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str405 = private unnamed_addr constant [1 x i8] c"\00"
@.str406 = private unnamed_addr constant [7 x i8] c"__anon\00"
@.str407 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str408 = private unnamed_addr constant [53 x i8] c"@.str%d = private unnamed_addr constant [%d x i8] c\22\00"
@.str409 = private unnamed_addr constant [3 x i8] c"\22\0A\00"
