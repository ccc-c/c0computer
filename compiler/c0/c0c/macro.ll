; ModuleID = 'macro.c'
source_filename = "macro.c"
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

@macros = internal global ptr zeroinitializer
@n_macros = internal global i32 zeroinitializer
@INCLUDE_PATHS = internal global ptr zeroinitializer

define internal void @buf_init(ptr %t0) {
entry:
  %t1 = call ptr @malloc(i64 65536)
  store ptr %t1, ptr %t0
  %t2 = load ptr, ptr %t0
  %t4 = ptrtoint ptr %t2 to i64
  %t5 = icmp eq i64 %t4, 0
  %t3 = zext i1 %t5 to i64
  %t6 = icmp ne i64 %t3, 0
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = getelementptr [7 x i8], ptr @.str0, i64 0, i64 0
  call void @perror(ptr %t7)
  call void @exit(i64 1)
  br label %L2
L2:
  %t10 = load ptr, ptr %t0
  %t12 = sext i32 0 to i64
  %t11 = getelementptr i8, ptr %t10, i64 %t12
  %t13 = sext i32 0 to i64
  store i64 %t13, ptr %t11
  %t14 = sext i32 0 to i64
  store i64 %t14, ptr %t0
  %t15 = sext i32 65536 to i64
  store i64 %t15, ptr %t0
  ret void
}

define internal void @buf_grow(ptr %t0, ptr %t1) {
entry:
  br label %L0
L0:
  %t2 = load ptr, ptr %t0
  %t4 = ptrtoint ptr %t2 to i64
  %t5 = ptrtoint ptr %t1 to i64
  %t6 = inttoptr i64 %t4 to ptr
  %t3 = getelementptr i8, ptr %t6, i64 %t5
  %t8 = ptrtoint ptr %t3 to i64
  %t9 = sext i32 1 to i64
  %t10 = inttoptr i64 %t8 to ptr
  %t7 = getelementptr i8, ptr %t10, i64 %t9
  %t11 = load ptr, ptr %t0
  %t13 = ptrtoint ptr %t7 to i64
  %t14 = ptrtoint ptr %t11 to i64
  %t12 = icmp sgt i64 %t13, %t14
  %t15 = zext i1 %t12 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L1, label %L2
L1:
  %t17 = load ptr, ptr %t0
  %t19 = ptrtoint ptr %t17 to i64
  %t20 = sext i32 2 to i64
  %t18 = mul i64 %t19, %t20
  store i64 %t18, ptr %t0
  %t21 = load ptr, ptr %t0
  %t22 = load ptr, ptr %t0
  %t23 = call ptr @realloc(ptr %t21, ptr %t22)
  store ptr %t23, ptr %t0
  %t24 = load ptr, ptr %t0
  %t26 = ptrtoint ptr %t24 to i64
  %t27 = icmp eq i64 %t26, 0
  %t25 = zext i1 %t27 to i64
  %t28 = icmp ne i64 %t25, 0
  br i1 %t28, label %L3, label %L5
L3:
  %t29 = getelementptr [8 x i8], ptr @.str1, i64 0, i64 0
  call void @perror(ptr %t29)
  call void @exit(i64 1)
  br label %L5
L5:
  br label %L0
L2:
  ret void
}

define internal void @buf_append(ptr %t0, ptr %t1, ptr %t2) {
entry:
  call void @buf_grow(ptr %t0, ptr %t2)
  %t4 = load ptr, ptr %t0
  %t5 = load ptr, ptr %t0
  %t7 = ptrtoint ptr %t4 to i64
  %t8 = ptrtoint ptr %t5 to i64
  %t9 = inttoptr i64 %t7 to ptr
  %t6 = getelementptr i8, ptr %t9, i64 %t8
  %t10 = call ptr @memcpy(ptr %t6, ptr %t1, ptr %t2)
  %t11 = load ptr, ptr %t0
  %t13 = ptrtoint ptr %t11 to i64
  %t14 = ptrtoint ptr %t2 to i64
  %t12 = add i64 %t13, %t14
  store i64 %t12, ptr %t0
  %t15 = load ptr, ptr %t0
  %t16 = load ptr, ptr %t0
  %t18 = ptrtoint ptr %t16 to i64
  %t17 = getelementptr i8, ptr %t15, i64 %t18
  %t19 = sext i32 0 to i64
  store i64 %t19, ptr %t17
  ret void
}

define internal void @buf_putc(ptr %t0, i64 %t1) {
entry:
  call void @buf_grow(ptr %t0, i64 1)
  %t3 = load ptr, ptr %t0
  %t4 = load ptr, ptr %t0
  %t6 = ptrtoint ptr %t4 to i64
  %t5 = add i64 %t6, 1
  store i64 %t5, ptr %t0
  %t8 = ptrtoint ptr %t4 to i64
  %t7 = getelementptr i8, ptr %t3, i64 %t8
  store i64 %t1, ptr %t7
  %t9 = load ptr, ptr %t0
  %t10 = load ptr, ptr %t0
  %t12 = ptrtoint ptr %t10 to i64
  %t11 = getelementptr i8, ptr %t9, i64 %t12
  %t13 = sext i32 0 to i64
  store i64 %t13, ptr %t11
  ret void
}

define internal ptr @macro_find(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = sext i32 0 to i64
  store i64 %t2, ptr %t1
  br label %L0
L0:
  %t3 = load i64, ptr %t1
  %t4 = load i64, ptr @n_macros
  %t5 = icmp slt i64 %t3, %t4
  %t6 = zext i1 %t5 to i64
  %t7 = icmp ne i64 %t6, 0
  br i1 %t7, label %L1, label %L3
L1:
  %t8 = load ptr, ptr @macros
  %t9 = load i64, ptr %t1
  %t10 = getelementptr i8, ptr %t8, i64 %t9
  %t11 = load ptr, ptr %t10
  %t12 = load ptr, ptr @macros
  %t13 = load i64, ptr %t1
  %t14 = getelementptr i8, ptr %t12, i64 %t13
  %t15 = load ptr, ptr %t14
  %t16 = call i32 @strcmp(ptr %t15, ptr %t0)
  %t17 = sext i32 %t16 to i64
  %t19 = sext i32 0 to i64
  %t18 = icmp eq i64 %t17, %t19
  %t20 = zext i1 %t18 to i64
  %t22 = ptrtoint ptr %t11 to i64
  %t26 = ptrtoint ptr %t11 to i64
  %t23 = icmp ne i64 %t26, 0
  %t24 = icmp ne i64 %t20, 0
  %t25 = and i1 %t23, %t24
  %t27 = zext i1 %t25 to i64
  %t28 = icmp ne i64 %t27, 0
  br i1 %t28, label %L4, label %L6
L4:
  %t29 = load ptr, ptr @macros
  %t30 = load i64, ptr %t1
  %t31 = getelementptr i8, ptr %t29, i64 %t30
  ret ptr %t31
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t32 = load i64, ptr %t1
  %t33 = add i64 %t32, 1
  store i64 %t33, ptr %t1
  br label %L0
L3:
  %t35 = sext i32 0 to i64
  %t34 = inttoptr i64 %t35 to ptr
  ret ptr %t34
L8:
  ret ptr null
}

define internal void @macro_define(ptr %t0, ptr %t1, ptr %t2, i64 %t3, i64 %t4) {
entry:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  br label %L0
L0:
  %t7 = load i64, ptr %t5
  %t8 = load i64, ptr @n_macros
  %t9 = icmp slt i64 %t7, %t8
  %t10 = zext i1 %t9 to i64
  %t11 = icmp ne i64 %t10, 0
  br i1 %t11, label %L1, label %L3
L1:
  %t12 = load ptr, ptr @macros
  %t13 = load i64, ptr %t5
  %t14 = getelementptr i8, ptr %t12, i64 %t13
  %t15 = load ptr, ptr %t14
  %t16 = call i32 @strcmp(ptr %t15, ptr %t0)
  %t17 = sext i32 %t16 to i64
  %t19 = sext i32 0 to i64
  %t18 = icmp eq i64 %t17, %t19
  %t20 = zext i1 %t18 to i64
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L4, label %L6
L4:
  %t22 = load ptr, ptr @macros
  %t23 = load i64, ptr %t5
  %t24 = getelementptr i8, ptr %t22, i64 %t23
  %t25 = load ptr, ptr %t24
  call void @free(ptr %t25)
  %t27 = call ptr @strdup(ptr %t1)
  %t28 = load ptr, ptr @macros
  %t29 = load i64, ptr %t5
  %t30 = getelementptr i8, ptr %t28, i64 %t29
  store ptr %t27, ptr %t30
  %t31 = load ptr, ptr @macros
  %t32 = load i64, ptr %t5
  %t33 = getelementptr i8, ptr %t31, i64 %t32
  %t34 = sext i32 1 to i64
  store i64 %t34, ptr %t33
  ret void
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t35 = load i64, ptr %t5
  %t36 = add i64 %t35, 1
  store i64 %t36, ptr %t5
  br label %L0
L3:
  %t37 = load i64, ptr @n_macros
  %t39 = sext i32 512 to i64
  %t38 = icmp sge i64 %t37, %t39
  %t40 = zext i1 %t38 to i64
  %t41 = icmp ne i64 %t40, 0
  br i1 %t41, label %L8, label %L10
L8:
  %t42 = call ptr @__c0c_stderr()
  %t43 = getelementptr [18 x i8], ptr @.str2, i64 0, i64 0
  %t44 = call i32 @fprintf(ptr %t42, ptr %t43)
  %t45 = sext i32 %t44 to i64
  ret void
L11:
  br label %L10
L10:
  %t46 = alloca ptr
  %t47 = load ptr, ptr @macros
  %t48 = load i64, ptr @n_macros
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr @n_macros
  %t50 = getelementptr i8, ptr %t47, i64 %t48
  store ptr %t50, ptr %t46
  %t51 = call ptr @strdup(ptr %t0)
  %t52 = load ptr, ptr %t46
  store ptr %t51, ptr %t52
  %t53 = call ptr @strdup(ptr %t1)
  %t54 = load ptr, ptr %t46
  store ptr %t53, ptr %t54
  %t55 = load ptr, ptr %t46
  store i64 %t3, ptr %t55
  %t56 = load ptr, ptr %t46
  store i64 %t4, ptr %t56
  %t57 = load ptr, ptr %t46
  %t58 = sext i32 1 to i64
  store i64 %t58, ptr %t57
  %t59 = alloca i64
  %t60 = sext i32 0 to i64
  store i64 %t60, ptr %t59
  br label %L12
L12:
  %t61 = load i64, ptr %t59
  %t62 = icmp slt i64 %t61, %t3
  %t63 = zext i1 %t62 to i64
  %t64 = load i64, ptr %t59
  %t66 = sext i32 16 to i64
  %t65 = icmp slt i64 %t64, %t66
  %t67 = zext i1 %t65 to i64
  %t69 = icmp ne i64 %t63, 0
  %t70 = icmp ne i64 %t67, 0
  %t71 = and i1 %t69, %t70
  %t72 = zext i1 %t71 to i64
  %t73 = icmp ne i64 %t72, 0
  br i1 %t73, label %L13, label %L15
L13:
  %t74 = load i64, ptr %t59
  %t75 = getelementptr i32, ptr %t2, i64 %t74
  %t76 = load i64, ptr %t75
  %t77 = icmp ne i64 %t76, 0
  br i1 %t77, label %L16, label %L17
L16:
  %t78 = load i64, ptr %t59
  %t79 = getelementptr i32, ptr %t2, i64 %t78
  %t80 = load i64, ptr %t79
  %t81 = call ptr @strdup(i64 %t80)
  %t82 = ptrtoint ptr %t81 to i64
  br label %L18
L17:
  %t84 = sext i32 0 to i64
  %t83 = inttoptr i64 %t84 to ptr
  %t85 = ptrtoint ptr %t83 to i64
  br label %L18
L18:
  %t86 = phi i64 [ %t82, %L16 ], [ %t85, %L17 ]
  %t87 = load ptr, ptr %t46
  %t88 = load ptr, ptr %t87
  %t89 = load i64, ptr %t59
  %t90 = getelementptr i8, ptr %t88, i64 %t89
  store i64 %t86, ptr %t90
  br label %L14
L14:
  %t91 = load i64, ptr %t59
  %t92 = add i64 %t91, 1
  store i64 %t92, ptr %t59
  br label %L12
L15:
  ret void
}

define internal void @macro_undef(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = sext i32 0 to i64
  store i64 %t2, ptr %t1
  br label %L0
L0:
  %t3 = load i64, ptr %t1
  %t4 = load i64, ptr @n_macros
  %t5 = icmp slt i64 %t3, %t4
  %t6 = zext i1 %t5 to i64
  %t7 = icmp ne i64 %t6, 0
  br i1 %t7, label %L1, label %L3
L1:
  %t8 = load ptr, ptr @macros
  %t9 = load i64, ptr %t1
  %t10 = getelementptr i8, ptr %t8, i64 %t9
  %t11 = load ptr, ptr %t10
  %t12 = call i32 @strcmp(ptr %t11, ptr %t0)
  %t13 = sext i32 %t12 to i64
  %t15 = sext i32 0 to i64
  %t14 = icmp eq i64 %t13, %t15
  %t16 = zext i1 %t14 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L4, label %L6
L4:
  %t18 = load ptr, ptr @macros
  %t19 = load i64, ptr %t1
  %t20 = getelementptr i8, ptr %t18, i64 %t19
  %t21 = sext i32 0 to i64
  store i64 %t21, ptr %t20
  ret void
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t22 = load i64, ptr %t1
  %t23 = add i64 %t22, 1
  store i64 %t23, ptr %t1
  br label %L0
L3:
  ret void
}

define internal ptr @skip_ws(ptr %t0) {
entry:
  br label %L0
L0:
  %t1 = load i64, ptr %t0
  %t3 = sext i32 32 to i64
  %t2 = icmp eq i64 %t1, %t3
  %t4 = zext i1 %t2 to i64
  %t5 = load i64, ptr %t0
  %t7 = sext i32 9 to i64
  %t6 = icmp eq i64 %t5, %t7
  %t8 = zext i1 %t6 to i64
  %t10 = icmp ne i64 %t4, 0
  %t11 = icmp ne i64 %t8, 0
  %t12 = or i1 %t10, %t11
  %t13 = zext i1 %t12 to i64
  %t14 = icmp ne i64 %t13, 0
  br i1 %t14, label %L1, label %L2
L1:
  %t16 = ptrtoint ptr %t0 to i64
  %t15 = add i64 %t16, 1
  store i64 %t15, ptr %t0
  br label %L0
L2:
  ret ptr %t0
L3:
  ret ptr null
}

define internal ptr @skip_to_eol(ptr %t0) {
entry:
  br label %L0
L0:
  %t1 = load i64, ptr %t0
  %t2 = load i64, ptr %t0
  %t4 = sext i32 10 to i64
  %t3 = icmp ne i64 %t2, %t4
  %t5 = zext i1 %t3 to i64
  %t7 = icmp ne i64 %t1, 0
  %t8 = icmp ne i64 %t5, 0
  %t9 = and i1 %t7, %t8
  %t10 = zext i1 %t9 to i64
  %t11 = icmp ne i64 %t10, 0
  br i1 %t11, label %L1, label %L2
L1:
  %t13 = ptrtoint ptr %t0 to i64
  %t12 = add i64 %t13, 1
  store i64 %t12, ptr %t0
  br label %L0
L2:
  ret ptr %t0
L3:
  ret ptr null
}

define internal ptr @read_ident(ptr %t0, ptr %t1, ptr %t2) {
entry:
  %t3 = alloca i64
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  %t5 = load i64, ptr %t0
  %t6 = load i64, ptr %t0
  %t7 = add i64 %t6, 0
  %t8 = call i32 @isalnum(i64 %t7)
  %t9 = sext i32 %t8 to i64
  %t10 = load i64, ptr %t0
  %t12 = sext i32 95 to i64
  %t11 = icmp eq i64 %t10, %t12
  %t13 = zext i1 %t11 to i64
  %t15 = icmp ne i64 %t9, 0
  %t16 = icmp ne i64 %t13, 0
  %t17 = or i1 %t15, %t16
  %t18 = zext i1 %t17 to i64
  %t20 = icmp ne i64 %t5, 0
  %t21 = icmp ne i64 %t18, 0
  %t22 = and i1 %t20, %t21
  %t23 = zext i1 %t22 to i64
  %t24 = load i64, ptr %t3
  %t26 = ptrtoint ptr %t2 to i64
  %t27 = sext i32 1 to i64
  %t25 = sub i64 %t26, %t27
  %t28 = icmp slt i64 %t24, %t25
  %t29 = zext i1 %t28 to i64
  %t31 = icmp ne i64 %t23, 0
  %t32 = icmp ne i64 %t29, 0
  %t33 = and i1 %t31, %t32
  %t34 = zext i1 %t33 to i64
  %t35 = icmp ne i64 %t34, 0
  br i1 %t35, label %L1, label %L2
L1:
  %t37 = ptrtoint ptr %t0 to i64
  %t36 = add i64 %t37, 1
  store i64 %t36, ptr %t0
  %t38 = load i64, ptr %t0
  %t39 = load i64, ptr %t3
  %t40 = add i64 %t39, 1
  store i64 %t40, ptr %t3
  %t41 = getelementptr i8, ptr %t1, i64 %t39
  store i64 %t38, ptr %t41
  br label %L0
L2:
  %t42 = load i64, ptr %t3
  %t43 = getelementptr i8, ptr %t1, i64 %t42
  %t44 = sext i32 0 to i64
  store i64 %t44, ptr %t43
  ret ptr %t0
L3:
  ret ptr null
}

define internal void @expand_func_macro(ptr %t0, ptr %t1, ptr %t2, i64 %t3) {
entry:
  %t4 = alloca ptr
  %t5 = load i64, ptr %t1
  store i64 %t5, ptr %t4
  %t6 = load ptr, ptr %t4
  %t7 = call ptr @skip_ws(ptr %t6)
  store ptr %t7, ptr %t4
  %t8 = load ptr, ptr %t4
  %t9 = load i64, ptr %t8
  %t11 = sext i32 40 to i64
  %t10 = icmp ne i64 %t9, %t11
  %t12 = zext i1 %t10 to i64
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L0, label %L2
L0:
  %t14 = load ptr, ptr %t0
  %t15 = load ptr, ptr %t0
  %t16 = call i64 @strlen(ptr %t15)
  call void @buf_append(ptr %t2, ptr %t14, i64 %t16)
  ret void
L3:
  br label %L2
L2:
  %t18 = load ptr, ptr %t4
  %t20 = ptrtoint ptr %t18 to i64
  %t19 = add i64 %t20, 1
  store i64 %t19, ptr %t4
  %t21 = alloca ptr
  %t22 = sext i32 0 to i64
  store i64 %t22, ptr %t21
  %t23 = alloca i64
  %t24 = sext i32 0 to i64
  store i64 %t24, ptr %t23
  %t25 = alloca i64
  %t26 = sext i32 0 to i64
  store i64 %t26, ptr %t25
  %t27 = alloca i64
  call void @buf_init(ptr %t27)
  br label %L4
L4:
  %t29 = load ptr, ptr %t4
  %t30 = load i64, ptr %t29
  %t31 = load i64, ptr %t25
  %t33 = sext i32 0 to i64
  %t32 = icmp eq i64 %t31, %t33
  %t34 = zext i1 %t32 to i64
  %t35 = load ptr, ptr %t4
  %t36 = load i64, ptr %t35
  %t38 = sext i32 41 to i64
  %t37 = icmp eq i64 %t36, %t38
  %t39 = zext i1 %t37 to i64
  %t41 = icmp ne i64 %t34, 0
  %t42 = icmp ne i64 %t39, 0
  %t43 = and i1 %t41, %t42
  %t44 = zext i1 %t43 to i64
  %t46 = icmp eq i64 %t44, 0
  %t45 = zext i1 %t46 to i64
  %t48 = icmp ne i64 %t30, 0
  %t49 = icmp ne i64 %t45, 0
  %t50 = and i1 %t48, %t49
  %t51 = zext i1 %t50 to i64
  %t52 = icmp ne i64 %t51, 0
  br i1 %t52, label %L5, label %L6
L5:
  %t53 = load ptr, ptr %t4
  %t54 = load i64, ptr %t53
  %t56 = sext i32 44 to i64
  %t55 = icmp eq i64 %t54, %t56
  %t57 = zext i1 %t55 to i64
  %t58 = load i64, ptr %t25
  %t60 = sext i32 0 to i64
  %t59 = icmp eq i64 %t58, %t60
  %t61 = zext i1 %t59 to i64
  %t63 = icmp ne i64 %t57, 0
  %t64 = icmp ne i64 %t61, 0
  %t65 = and i1 %t63, %t64
  %t66 = zext i1 %t65 to i64
  %t67 = icmp ne i64 %t66, 0
  br i1 %t67, label %L7, label %L8
L7:
  %t68 = load i64, ptr %t23
  %t70 = sext i32 16 to i64
  %t69 = icmp slt i64 %t68, %t70
  %t71 = zext i1 %t69 to i64
  %t72 = icmp ne i64 %t71, 0
  br i1 %t72, label %L10, label %L12
L10:
  %t73 = load ptr, ptr %t27
  %t74 = call ptr @strdup(ptr %t73)
  %t75 = load ptr, ptr %t21
  %t76 = load i64, ptr %t23
  %t77 = add i64 %t76, 1
  store i64 %t77, ptr %t23
  %t78 = getelementptr i8, ptr %t75, i64 %t76
  store ptr %t74, ptr %t78
  br label %L12
L12:
  %t79 = sext i32 0 to i64
  store i64 %t79, ptr %t27
  %t80 = load ptr, ptr %t27
  %t82 = sext i32 0 to i64
  %t81 = getelementptr i8, ptr %t80, i64 %t82
  %t83 = sext i32 0 to i64
  store i64 %t83, ptr %t81
  %t84 = load ptr, ptr %t4
  %t86 = ptrtoint ptr %t84 to i64
  %t85 = add i64 %t86, 1
  store i64 %t85, ptr %t4
  br label %L9
L8:
  %t87 = load ptr, ptr %t4
  %t88 = load i64, ptr %t87
  %t90 = sext i32 34 to i64
  %t89 = icmp eq i64 %t88, %t90
  %t91 = zext i1 %t89 to i64
  %t92 = icmp ne i64 %t91, 0
  br i1 %t92, label %L13, label %L14
L13:
  %t93 = load ptr, ptr %t4
  %t95 = ptrtoint ptr %t93 to i64
  %t94 = add i64 %t95, 1
  store i64 %t94, ptr %t4
  %t96 = load i64, ptr %t93
  call void @buf_putc(ptr %t27, i64 %t96)
  br label %L16
L16:
  %t98 = load ptr, ptr %t4
  %t99 = load i64, ptr %t98
  %t100 = load ptr, ptr %t4
  %t101 = load i64, ptr %t100
  %t103 = sext i32 34 to i64
  %t102 = icmp ne i64 %t101, %t103
  %t104 = zext i1 %t102 to i64
  %t106 = icmp ne i64 %t99, 0
  %t107 = icmp ne i64 %t104, 0
  %t108 = and i1 %t106, %t107
  %t109 = zext i1 %t108 to i64
  %t110 = icmp ne i64 %t109, 0
  br i1 %t110, label %L17, label %L18
L17:
  %t111 = load ptr, ptr %t4
  %t112 = load i64, ptr %t111
  %t114 = sext i32 92 to i64
  %t113 = icmp eq i64 %t112, %t114
  %t115 = zext i1 %t113 to i64
  %t116 = load ptr, ptr %t4
  %t118 = ptrtoint ptr %t116 to i64
  %t119 = sext i32 1 to i64
  %t120 = inttoptr i64 %t118 to ptr
  %t117 = getelementptr i8, ptr %t120, i64 %t119
  %t121 = load i64, ptr %t117
  %t123 = icmp ne i64 %t115, 0
  %t124 = icmp ne i64 %t121, 0
  %t125 = and i1 %t123, %t124
  %t126 = zext i1 %t125 to i64
  %t127 = icmp ne i64 %t126, 0
  br i1 %t127, label %L19, label %L21
L19:
  %t128 = load ptr, ptr %t4
  %t130 = ptrtoint ptr %t128 to i64
  %t129 = add i64 %t130, 1
  store i64 %t129, ptr %t4
  %t131 = load i64, ptr %t128
  call void @buf_putc(ptr %t27, i64 %t131)
  br label %L21
L21:
  %t133 = load ptr, ptr %t4
  %t135 = ptrtoint ptr %t133 to i64
  %t134 = add i64 %t135, 1
  store i64 %t134, ptr %t4
  %t136 = load i64, ptr %t133
  call void @buf_putc(ptr %t27, i64 %t136)
  br label %L16
L18:
  %t138 = load ptr, ptr %t4
  %t139 = load i64, ptr %t138
  %t140 = icmp ne i64 %t139, 0
  br i1 %t140, label %L22, label %L24
L22:
  %t141 = load ptr, ptr %t4
  %t143 = ptrtoint ptr %t141 to i64
  %t142 = add i64 %t143, 1
  store i64 %t142, ptr %t4
  %t144 = load i64, ptr %t141
  call void @buf_putc(ptr %t27, i64 %t144)
  br label %L24
L24:
  br label %L15
L14:
  %t146 = load ptr, ptr %t4
  %t147 = load i64, ptr %t146
  %t149 = sext i32 39 to i64
  %t148 = icmp eq i64 %t147, %t149
  %t150 = zext i1 %t148 to i64
  %t151 = icmp ne i64 %t150, 0
  br i1 %t151, label %L25, label %L26
L25:
  %t152 = load ptr, ptr %t4
  %t154 = ptrtoint ptr %t152 to i64
  %t153 = add i64 %t154, 1
  store i64 %t153, ptr %t4
  %t155 = load i64, ptr %t152
  call void @buf_putc(ptr %t27, i64 %t155)
  %t157 = load ptr, ptr %t4
  %t158 = load i64, ptr %t157
  %t160 = sext i32 92 to i64
  %t159 = icmp eq i64 %t158, %t160
  %t161 = zext i1 %t159 to i64
  %t162 = load ptr, ptr %t4
  %t164 = ptrtoint ptr %t162 to i64
  %t165 = sext i32 1 to i64
  %t166 = inttoptr i64 %t164 to ptr
  %t163 = getelementptr i8, ptr %t166, i64 %t165
  %t167 = load i64, ptr %t163
  %t169 = icmp ne i64 %t161, 0
  %t170 = icmp ne i64 %t167, 0
  %t171 = and i1 %t169, %t170
  %t172 = zext i1 %t171 to i64
  %t173 = icmp ne i64 %t172, 0
  br i1 %t173, label %L28, label %L30
L28:
  %t174 = load ptr, ptr %t4
  %t176 = ptrtoint ptr %t174 to i64
  %t175 = add i64 %t176, 1
  store i64 %t175, ptr %t4
  %t177 = load i64, ptr %t174
  call void @buf_putc(ptr %t27, i64 %t177)
  br label %L30
L30:
  %t179 = load ptr, ptr %t4
  %t180 = load i64, ptr %t179
  %t181 = icmp ne i64 %t180, 0
  br i1 %t181, label %L31, label %L33
L31:
  %t182 = load ptr, ptr %t4
  %t184 = ptrtoint ptr %t182 to i64
  %t183 = add i64 %t184, 1
  store i64 %t183, ptr %t4
  %t185 = load i64, ptr %t182
  call void @buf_putc(ptr %t27, i64 %t185)
  br label %L33
L33:
  %t187 = load ptr, ptr %t4
  %t188 = load i64, ptr %t187
  %t190 = sext i32 39 to i64
  %t189 = icmp eq i64 %t188, %t190
  %t191 = zext i1 %t189 to i64
  %t192 = icmp ne i64 %t191, 0
  br i1 %t192, label %L34, label %L36
L34:
  %t193 = load ptr, ptr %t4
  %t195 = ptrtoint ptr %t193 to i64
  %t194 = add i64 %t195, 1
  store i64 %t194, ptr %t4
  %t196 = load i64, ptr %t193
  call void @buf_putc(ptr %t27, i64 %t196)
  br label %L36
L36:
  br label %L27
L26:
  %t198 = load ptr, ptr %t4
  %t199 = load i64, ptr %t198
  %t201 = sext i32 40 to i64
  %t200 = icmp eq i64 %t199, %t201
  %t202 = zext i1 %t200 to i64
  %t203 = icmp ne i64 %t202, 0
  br i1 %t203, label %L37, label %L39
L37:
  %t204 = load i64, ptr %t25
  %t205 = add i64 %t204, 1
  store i64 %t205, ptr %t25
  br label %L39
L39:
  %t206 = load ptr, ptr %t4
  %t207 = load i64, ptr %t206
  %t209 = sext i32 41 to i64
  %t208 = icmp eq i64 %t207, %t209
  %t210 = zext i1 %t208 to i64
  %t211 = icmp ne i64 %t210, 0
  br i1 %t211, label %L40, label %L42
L40:
  %t212 = load i64, ptr %t25
  %t213 = sub i64 %t212, 1
  store i64 %t213, ptr %t25
  br label %L42
L42:
  %t214 = load i64, ptr %t25
  %t216 = sext i32 0 to i64
  %t215 = icmp sge i64 %t214, %t216
  %t217 = zext i1 %t215 to i64
  %t218 = icmp ne i64 %t217, 0
  br i1 %t218, label %L43, label %L44
L43:
  %t219 = load ptr, ptr %t4
  %t221 = ptrtoint ptr %t219 to i64
  %t220 = add i64 %t221, 1
  store i64 %t220, ptr %t4
  %t222 = load i64, ptr %t219
  call void @buf_putc(ptr %t27, i64 %t222)
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
  %t224 = load ptr, ptr %t27
  %t226 = ptrtoint ptr %t224 to i64
  %t227 = sext i32 0 to i64
  %t225 = icmp sgt i64 %t226, %t227
  %t228 = zext i1 %t225 to i64
  %t229 = load i64, ptr %t23
  %t231 = sext i32 0 to i64
  %t230 = icmp sgt i64 %t229, %t231
  %t232 = zext i1 %t230 to i64
  %t234 = icmp ne i64 %t228, 0
  %t235 = icmp ne i64 %t232, 0
  %t236 = or i1 %t234, %t235
  %t237 = zext i1 %t236 to i64
  %t238 = icmp ne i64 %t237, 0
  br i1 %t238, label %L47, label %L49
L47:
  %t239 = load i64, ptr %t23
  %t241 = sext i32 16 to i64
  %t240 = icmp slt i64 %t239, %t241
  %t242 = zext i1 %t240 to i64
  %t243 = icmp ne i64 %t242, 0
  br i1 %t243, label %L50, label %L52
L50:
  %t244 = load ptr, ptr %t27
  %t245 = call ptr @strdup(ptr %t244)
  %t246 = load ptr, ptr %t21
  %t247 = load i64, ptr %t23
  %t248 = add i64 %t247, 1
  store i64 %t248, ptr %t23
  %t249 = getelementptr i8, ptr %t246, i64 %t247
  store ptr %t245, ptr %t249
  br label %L52
L52:
  br label %L49
L49:
  %t250 = load ptr, ptr %t27
  call void @free(ptr %t250)
  %t252 = load ptr, ptr %t4
  %t253 = load i64, ptr %t252
  %t255 = sext i32 41 to i64
  %t254 = icmp eq i64 %t253, %t255
  %t256 = zext i1 %t254 to i64
  %t257 = icmp ne i64 %t256, 0
  br i1 %t257, label %L53, label %L55
L53:
  %t258 = load ptr, ptr %t4
  %t260 = ptrtoint ptr %t258 to i64
  %t259 = add i64 %t260, 1
  store i64 %t259, ptr %t4
  br label %L55
L55:
  %t261 = load ptr, ptr %t4
  store ptr %t261, ptr %t1
  %t262 = alloca ptr
  %t263 = load ptr, ptr %t0
  store ptr %t263, ptr %t262
  %t264 = alloca i64
  call void @buf_init(ptr %t264)
  br label %L56
L56:
  %t266 = load ptr, ptr %t262
  %t267 = load i64, ptr %t266
  %t268 = icmp ne i64 %t267, 0
  br i1 %t268, label %L57, label %L58
L57:
  %t269 = load ptr, ptr %t262
  %t270 = load i64, ptr %t269
  %t272 = sext i32 35 to i64
  %t271 = icmp eq i64 %t270, %t272
  %t273 = zext i1 %t271 to i64
  %t274 = load ptr, ptr %t262
  %t276 = ptrtoint ptr %t274 to i64
  %t277 = sext i32 1 to i64
  %t278 = inttoptr i64 %t276 to ptr
  %t275 = getelementptr i8, ptr %t278, i64 %t277
  %t279 = load i64, ptr %t275
  %t281 = sext i32 35 to i64
  %t280 = icmp ne i64 %t279, %t281
  %t282 = zext i1 %t280 to i64
  %t284 = icmp ne i64 %t273, 0
  %t285 = icmp ne i64 %t282, 0
  %t286 = and i1 %t284, %t285
  %t287 = zext i1 %t286 to i64
  %t288 = icmp ne i64 %t287, 0
  br i1 %t288, label %L59, label %L61
L59:
  %t289 = load ptr, ptr %t262
  %t291 = ptrtoint ptr %t289 to i64
  %t290 = add i64 %t291, 1
  store i64 %t290, ptr %t262
  br label %L62
L62:
  %t292 = load ptr, ptr %t262
  %t293 = load i64, ptr %t292
  %t295 = sext i32 32 to i64
  %t294 = icmp eq i64 %t293, %t295
  %t296 = zext i1 %t294 to i64
  %t297 = load ptr, ptr %t262
  %t298 = load i64, ptr %t297
  %t300 = sext i32 9 to i64
  %t299 = icmp eq i64 %t298, %t300
  %t301 = zext i1 %t299 to i64
  %t303 = icmp ne i64 %t296, 0
  %t304 = icmp ne i64 %t301, 0
  %t305 = or i1 %t303, %t304
  %t306 = zext i1 %t305 to i64
  %t307 = icmp ne i64 %t306, 0
  br i1 %t307, label %L63, label %L64
L63:
  %t308 = load ptr, ptr %t262
  %t310 = ptrtoint ptr %t308 to i64
  %t309 = add i64 %t310, 1
  store i64 %t309, ptr %t262
  br label %L62
L64:
  %t311 = alloca ptr
  %t312 = alloca ptr
  %t313 = load ptr, ptr %t262
  %t314 = load ptr, ptr %t311
  %t315 = call ptr @read_ident(ptr %t313, ptr %t314, i64 8)
  store ptr %t315, ptr %t312
  %t316 = alloca i64
  %t317 = sext i32 0 to i64
  store i64 %t317, ptr %t316
  %t318 = alloca i64
  %t319 = sext i32 0 to i64
  store i64 %t319, ptr %t318
  br label %L65
L65:
  %t320 = load i64, ptr %t318
  %t321 = load ptr, ptr %t0
  %t323 = ptrtoint ptr %t321 to i64
  %t322 = icmp slt i64 %t320, %t323
  %t324 = zext i1 %t322 to i64
  %t325 = load i64, ptr %t318
  %t327 = sext i32 16 to i64
  %t326 = icmp slt i64 %t325, %t327
  %t328 = zext i1 %t326 to i64
  %t330 = icmp ne i64 %t324, 0
  %t331 = icmp ne i64 %t328, 0
  %t332 = and i1 %t330, %t331
  %t333 = zext i1 %t332 to i64
  %t334 = icmp ne i64 %t333, 0
  br i1 %t334, label %L66, label %L68
L66:
  %t335 = load ptr, ptr %t0
  %t336 = load i64, ptr %t318
  %t337 = getelementptr i32, ptr %t335, i64 %t336
  %t338 = load i64, ptr %t337
  %t339 = load ptr, ptr %t0
  %t340 = load i64, ptr %t318
  %t341 = getelementptr i32, ptr %t339, i64 %t340
  %t342 = load i64, ptr %t341
  %t343 = load ptr, ptr %t311
  %t344 = call i32 @strcmp(i64 %t342, ptr %t343)
  %t345 = sext i32 %t344 to i64
  %t347 = sext i32 0 to i64
  %t346 = icmp eq i64 %t345, %t347
  %t348 = zext i1 %t346 to i64
  %t350 = icmp ne i64 %t338, 0
  %t351 = icmp ne i64 %t348, 0
  %t352 = and i1 %t350, %t351
  %t353 = zext i1 %t352 to i64
  %t354 = icmp ne i64 %t353, 0
  br i1 %t354, label %L69, label %L71
L69:
  call void @buf_putc(ptr %t264, i64 34)
  %t356 = load i64, ptr %t318
  %t357 = load i64, ptr %t23
  %t358 = icmp slt i64 %t356, %t357
  %t359 = zext i1 %t358 to i64
  %t360 = load ptr, ptr %t21
  %t361 = load i64, ptr %t318
  %t362 = getelementptr i32, ptr %t360, i64 %t361
  %t363 = load i64, ptr %t362
  %t365 = icmp ne i64 %t359, 0
  %t366 = icmp ne i64 %t363, 0
  %t367 = and i1 %t365, %t366
  %t368 = zext i1 %t367 to i64
  %t369 = icmp ne i64 %t368, 0
  br i1 %t369, label %L72, label %L74
L72:
  %t370 = alloca ptr
  %t371 = load ptr, ptr %t21
  %t372 = load i64, ptr %t318
  %t373 = getelementptr i32, ptr %t371, i64 %t372
  %t374 = load i64, ptr %t373
  store i64 %t374, ptr %t370
  br label %L75
L75:
  %t375 = load ptr, ptr %t370
  %t376 = load i64, ptr %t375
  %t377 = icmp ne i64 %t376, 0
  br i1 %t377, label %L76, label %L77
L76:
  %t378 = load ptr, ptr %t370
  %t379 = load i64, ptr %t378
  %t381 = sext i32 34 to i64
  %t380 = icmp eq i64 %t379, %t381
  %t382 = zext i1 %t380 to i64
  %t383 = load ptr, ptr %t370
  %t384 = load i64, ptr %t383
  %t386 = sext i32 92 to i64
  %t385 = icmp eq i64 %t384, %t386
  %t387 = zext i1 %t385 to i64
  %t389 = icmp ne i64 %t382, 0
  %t390 = icmp ne i64 %t387, 0
  %t391 = or i1 %t389, %t390
  %t392 = zext i1 %t391 to i64
  %t393 = icmp ne i64 %t392, 0
  br i1 %t393, label %L78, label %L80
L78:
  call void @buf_putc(ptr %t264, i64 92)
  br label %L80
L80:
  %t395 = load ptr, ptr %t370
  %t397 = ptrtoint ptr %t395 to i64
  %t396 = add i64 %t397, 1
  store i64 %t396, ptr %t370
  %t398 = load i64, ptr %t395
  call void @buf_putc(ptr %t264, i64 %t398)
  br label %L75
L77:
  br label %L74
L74:
  call void @buf_putc(ptr %t264, i64 34)
  %t401 = sext i32 1 to i64
  store i64 %t401, ptr %t316
  br label %L68
L81:
  br label %L71
L71:
  br label %L67
L67:
  %t402 = load i64, ptr %t318
  %t403 = add i64 %t402, 1
  store i64 %t403, ptr %t318
  br label %L65
L68:
  %t404 = load i64, ptr %t316
  %t406 = icmp eq i64 %t404, 0
  %t405 = zext i1 %t406 to i64
  %t407 = icmp ne i64 %t405, 0
  br i1 %t407, label %L82, label %L84
L82:
  call void @buf_putc(ptr %t264, i64 34)
  call void @buf_putc(ptr %t264, i64 34)
  br label %L84
L84:
  %t410 = load ptr, ptr %t312
  store ptr %t410, ptr %t262
  br label %L56
L85:
  br label %L61
L61:
  %t411 = load ptr, ptr %t262
  %t412 = load i64, ptr %t411
  %t414 = sext i32 35 to i64
  %t413 = icmp eq i64 %t412, %t414
  %t415 = zext i1 %t413 to i64
  %t416 = load ptr, ptr %t262
  %t418 = ptrtoint ptr %t416 to i64
  %t419 = sext i32 1 to i64
  %t420 = inttoptr i64 %t418 to ptr
  %t417 = getelementptr i8, ptr %t420, i64 %t419
  %t421 = load i64, ptr %t417
  %t423 = sext i32 35 to i64
  %t422 = icmp eq i64 %t421, %t423
  %t424 = zext i1 %t422 to i64
  %t426 = icmp ne i64 %t415, 0
  %t427 = icmp ne i64 %t424, 0
  %t428 = and i1 %t426, %t427
  %t429 = zext i1 %t428 to i64
  %t430 = icmp ne i64 %t429, 0
  br i1 %t430, label %L86, label %L88
L86:
  %t431 = load ptr, ptr %t262
  %t433 = ptrtoint ptr %t431 to i64
  %t434 = sext i32 2 to i64
  %t432 = add i64 %t433, %t434
  store i64 %t432, ptr %t262
  br label %L89
L89:
  %t435 = load ptr, ptr %t262
  %t436 = load i64, ptr %t435
  %t438 = sext i32 32 to i64
  %t437 = icmp eq i64 %t436, %t438
  %t439 = zext i1 %t437 to i64
  %t440 = load ptr, ptr %t262
  %t441 = load i64, ptr %t440
  %t443 = sext i32 9 to i64
  %t442 = icmp eq i64 %t441, %t443
  %t444 = zext i1 %t442 to i64
  %t446 = icmp ne i64 %t439, 0
  %t447 = icmp ne i64 %t444, 0
  %t448 = or i1 %t446, %t447
  %t449 = zext i1 %t448 to i64
  %t450 = icmp ne i64 %t449, 0
  br i1 %t450, label %L90, label %L91
L90:
  %t451 = load ptr, ptr %t262
  %t453 = ptrtoint ptr %t451 to i64
  %t452 = add i64 %t453, 1
  store i64 %t452, ptr %t262
  br label %L89
L91:
  br label %L56
L92:
  br label %L88
L88:
  %t454 = load ptr, ptr %t262
  %t455 = load i64, ptr %t454
  %t456 = add i64 %t455, 0
  %t457 = call i32 @isalpha(i64 %t456)
  %t458 = sext i32 %t457 to i64
  %t459 = load ptr, ptr %t262
  %t460 = load i64, ptr %t459
  %t462 = sext i32 95 to i64
  %t461 = icmp eq i64 %t460, %t462
  %t463 = zext i1 %t461 to i64
  %t465 = icmp ne i64 %t458, 0
  %t466 = icmp ne i64 %t463, 0
  %t467 = or i1 %t465, %t466
  %t468 = zext i1 %t467 to i64
  %t469 = icmp ne i64 %t468, 0
  br i1 %t469, label %L93, label %L94
L93:
  %t470 = alloca ptr
  %t471 = alloca ptr
  %t472 = load ptr, ptr %t262
  %t473 = load ptr, ptr %t470
  %t474 = call ptr @read_ident(ptr %t472, ptr %t473, i64 8)
  store ptr %t474, ptr %t471
  %t475 = alloca i64
  %t476 = sext i32 0 to i64
  store i64 %t476, ptr %t475
  %t477 = load ptr, ptr %t470
  %t478 = getelementptr [12 x i8], ptr @.str3, i64 0, i64 0
  %t479 = call i32 @strcmp(ptr %t477, ptr %t478)
  %t480 = sext i32 %t479 to i64
  %t482 = sext i32 0 to i64
  %t481 = icmp eq i64 %t480, %t482
  %t483 = zext i1 %t481 to i64
  %t484 = icmp ne i64 %t483, 0
  br i1 %t484, label %L96, label %L98
L96:
  %t485 = alloca i64
  %t486 = load ptr, ptr %t0
  store ptr %t486, ptr %t485
  br label %L99
L99:
  %t487 = load i64, ptr %t485
  %t488 = load i64, ptr %t23
  %t489 = icmp slt i64 %t487, %t488
  %t490 = zext i1 %t489 to i64
  %t491 = icmp ne i64 %t490, 0
  br i1 %t491, label %L100, label %L102
L100:
  %t492 = load i64, ptr %t485
  %t493 = load ptr, ptr %t0
  %t495 = ptrtoint ptr %t493 to i64
  %t494 = icmp sgt i64 %t492, %t495
  %t496 = zext i1 %t494 to i64
  %t497 = icmp ne i64 %t496, 0
  br i1 %t497, label %L103, label %L105
L103:
  call void @buf_putc(ptr %t264, i64 44)
  br label %L105
L105:
  %t499 = load ptr, ptr %t21
  %t500 = load i64, ptr %t485
  %t501 = getelementptr i32, ptr %t499, i64 %t500
  %t502 = load i64, ptr %t501
  %t503 = icmp ne i64 %t502, 0
  br i1 %t503, label %L106, label %L108
L106:
  %t504 = load ptr, ptr %t21
  %t505 = load i64, ptr %t485
  %t506 = getelementptr i32, ptr %t504, i64 %t505
  %t507 = load i64, ptr %t506
  %t508 = load ptr, ptr %t21
  %t509 = load i64, ptr %t485
  %t510 = getelementptr i32, ptr %t508, i64 %t509
  %t511 = load i64, ptr %t510
  %t512 = call i64 @strlen(i64 %t511)
  call void @buf_append(ptr %t264, i64 %t507, i64 %t512)
  br label %L108
L108:
  br label %L101
L101:
  %t514 = load i64, ptr %t485
  %t515 = add i64 %t514, 1
  store i64 %t515, ptr %t485
  br label %L99
L102:
  %t516 = sext i32 1 to i64
  store i64 %t516, ptr %t475
  br label %L98
L98:
  %t517 = load i64, ptr %t475
  %t519 = icmp eq i64 %t517, 0
  %t518 = zext i1 %t519 to i64
  %t520 = icmp ne i64 %t518, 0
  br i1 %t520, label %L109, label %L111
L109:
  %t521 = alloca i64
  %t522 = sext i32 0 to i64
  store i64 %t522, ptr %t521
  br label %L112
L112:
  %t523 = load i64, ptr %t521
  %t524 = load ptr, ptr %t0
  %t526 = ptrtoint ptr %t524 to i64
  %t525 = icmp slt i64 %t523, %t526
  %t527 = zext i1 %t525 to i64
  %t528 = load i64, ptr %t521
  %t530 = sext i32 16 to i64
  %t529 = icmp slt i64 %t528, %t530
  %t531 = zext i1 %t529 to i64
  %t533 = icmp ne i64 %t527, 0
  %t534 = icmp ne i64 %t531, 0
  %t535 = and i1 %t533, %t534
  %t536 = zext i1 %t535 to i64
  %t537 = icmp ne i64 %t536, 0
  br i1 %t537, label %L113, label %L115
L113:
  %t538 = load ptr, ptr %t0
  %t539 = load i64, ptr %t521
  %t540 = getelementptr i32, ptr %t538, i64 %t539
  %t541 = load i64, ptr %t540
  %t542 = load ptr, ptr %t0
  %t543 = load i64, ptr %t521
  %t544 = getelementptr i32, ptr %t542, i64 %t543
  %t545 = load i64, ptr %t544
  %t546 = load ptr, ptr %t470
  %t547 = call i32 @strcmp(i64 %t545, ptr %t546)
  %t548 = sext i32 %t547 to i64
  %t550 = sext i32 0 to i64
  %t549 = icmp eq i64 %t548, %t550
  %t551 = zext i1 %t549 to i64
  %t553 = icmp ne i64 %t541, 0
  %t554 = icmp ne i64 %t551, 0
  %t555 = and i1 %t553, %t554
  %t556 = zext i1 %t555 to i64
  %t557 = icmp ne i64 %t556, 0
  br i1 %t557, label %L116, label %L118
L116:
  %t558 = load i64, ptr %t521
  %t559 = load i64, ptr %t23
  %t560 = icmp slt i64 %t558, %t559
  %t561 = zext i1 %t560 to i64
  %t562 = load ptr, ptr %t21
  %t563 = load i64, ptr %t521
  %t564 = getelementptr i32, ptr %t562, i64 %t563
  %t565 = load i64, ptr %t564
  %t567 = icmp ne i64 %t561, 0
  %t568 = icmp ne i64 %t565, 0
  %t569 = and i1 %t567, %t568
  %t570 = zext i1 %t569 to i64
  %t571 = icmp ne i64 %t570, 0
  br i1 %t571, label %L119, label %L121
L119:
  %t572 = load ptr, ptr %t21
  %t573 = load i64, ptr %t521
  %t574 = getelementptr i32, ptr %t572, i64 %t573
  %t575 = load i64, ptr %t574
  %t576 = load ptr, ptr %t21
  %t577 = load i64, ptr %t521
  %t578 = getelementptr i32, ptr %t576, i64 %t577
  %t579 = load i64, ptr %t578
  %t580 = call i64 @strlen(i64 %t579)
  call void @buf_append(ptr %t264, i64 %t575, i64 %t580)
  br label %L121
L121:
  %t582 = sext i32 1 to i64
  store i64 %t582, ptr %t475
  br label %L115
L122:
  br label %L118
L118:
  br label %L114
L114:
  %t583 = load i64, ptr %t521
  %t584 = add i64 %t583, 1
  store i64 %t584, ptr %t521
  br label %L112
L115:
  br label %L111
L111:
  %t585 = load i64, ptr %t475
  %t587 = icmp eq i64 %t585, 0
  %t586 = zext i1 %t587 to i64
  %t588 = icmp ne i64 %t586, 0
  br i1 %t588, label %L123, label %L125
L123:
  %t589 = load ptr, ptr %t470
  %t590 = load ptr, ptr %t470
  %t591 = call i64 @strlen(ptr %t590)
  call void @buf_append(ptr %t264, ptr %t589, i64 %t591)
  br label %L125
L125:
  %t593 = load ptr, ptr %t471
  store ptr %t593, ptr %t262
  br label %L95
L94:
  %t594 = load ptr, ptr %t262
  %t596 = ptrtoint ptr %t594 to i64
  %t595 = add i64 %t596, 1
  store i64 %t595, ptr %t262
  %t597 = load i64, ptr %t594
  call void @buf_putc(ptr %t264, i64 %t597)
  br label %L95
L95:
  br label %L56
L58:
  %t599 = load ptr, ptr %t264
  %t601 = sext i32 1 to i64
  %t600 = add i64 %t3, %t601
  call void @expand_text(ptr %t599, ptr %t2, i64 %t600)
  %t603 = load ptr, ptr %t264
  call void @free(ptr %t603)
  %t605 = alloca i64
  %t606 = sext i32 0 to i64
  store i64 %t606, ptr %t605
  br label %L126
L126:
  %t607 = load i64, ptr %t605
  %t608 = load i64, ptr %t23
  %t609 = icmp slt i64 %t607, %t608
  %t610 = zext i1 %t609 to i64
  %t611 = icmp ne i64 %t610, 0
  br i1 %t611, label %L127, label %L129
L127:
  %t612 = load ptr, ptr %t21
  %t613 = load i64, ptr %t605
  %t614 = getelementptr i32, ptr %t612, i64 %t613
  %t615 = load i64, ptr %t614
  call void @free(i64 %t615)
  br label %L128
L128:
  %t617 = load i64, ptr %t605
  %t618 = add i64 %t617, 1
  store i64 %t618, ptr %t605
  br label %L126
L129:
  ret void
}

define internal void @expand_text(ptr %t0, ptr %t1, i64 %t2) {
entry:
  %t4 = sext i32 64 to i64
  %t3 = icmp sgt i64 %t2, %t4
  %t5 = zext i1 %t3 to i64
  %t6 = icmp ne i64 %t5, 0
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = call i64 @strlen(ptr %t0)
  call void @buf_append(ptr %t1, ptr %t0, i64 %t7)
  ret void
L3:
  br label %L2
L2:
  %t9 = alloca ptr
  store ptr %t0, ptr %t9
  br label %L4
L4:
  %t10 = load ptr, ptr %t9
  %t11 = load i64, ptr %t10
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L5, label %L6
L5:
  %t13 = load ptr, ptr %t9
  %t14 = load i64, ptr %t13
  %t16 = sext i32 34 to i64
  %t15 = icmp eq i64 %t14, %t16
  %t17 = zext i1 %t15 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L7, label %L9
L7:
  %t19 = load ptr, ptr %t9
  %t21 = ptrtoint ptr %t19 to i64
  %t20 = add i64 %t21, 1
  store i64 %t20, ptr %t9
  %t22 = load i64, ptr %t19
  call void @buf_putc(ptr %t1, i64 %t22)
  br label %L10
L10:
  %t24 = load ptr, ptr %t9
  %t25 = load i64, ptr %t24
  %t26 = load ptr, ptr %t9
  %t27 = load i64, ptr %t26
  %t29 = sext i32 34 to i64
  %t28 = icmp ne i64 %t27, %t29
  %t30 = zext i1 %t28 to i64
  %t32 = icmp ne i64 %t25, 0
  %t33 = icmp ne i64 %t30, 0
  %t34 = and i1 %t32, %t33
  %t35 = zext i1 %t34 to i64
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L11, label %L12
L11:
  %t37 = load ptr, ptr %t9
  %t38 = load i64, ptr %t37
  %t40 = sext i32 92 to i64
  %t39 = icmp eq i64 %t38, %t40
  %t41 = zext i1 %t39 to i64
  %t42 = icmp ne i64 %t41, 0
  br i1 %t42, label %L13, label %L15
L13:
  %t43 = load ptr, ptr %t9
  %t45 = ptrtoint ptr %t43 to i64
  %t44 = add i64 %t45, 1
  store i64 %t44, ptr %t9
  %t46 = load i64, ptr %t43
  call void @buf_putc(ptr %t1, i64 %t46)
  br label %L15
L15:
  %t48 = load ptr, ptr %t9
  %t49 = load i64, ptr %t48
  %t50 = icmp ne i64 %t49, 0
  br i1 %t50, label %L16, label %L18
L16:
  %t51 = load ptr, ptr %t9
  %t53 = ptrtoint ptr %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t9
  %t54 = load i64, ptr %t51
  call void @buf_putc(ptr %t1, i64 %t54)
  br label %L18
L18:
  br label %L10
L12:
  %t56 = load ptr, ptr %t9
  %t57 = load i64, ptr %t56
  %t58 = icmp ne i64 %t57, 0
  br i1 %t58, label %L19, label %L21
L19:
  %t59 = load ptr, ptr %t9
  %t61 = ptrtoint ptr %t59 to i64
  %t60 = add i64 %t61, 1
  store i64 %t60, ptr %t9
  %t62 = load i64, ptr %t59
  call void @buf_putc(ptr %t1, i64 %t62)
  br label %L21
L21:
  br label %L4
L22:
  br label %L9
L9:
  %t64 = load ptr, ptr %t9
  %t65 = load i64, ptr %t64
  %t67 = sext i32 39 to i64
  %t66 = icmp eq i64 %t65, %t67
  %t68 = zext i1 %t66 to i64
  %t69 = icmp ne i64 %t68, 0
  br i1 %t69, label %L23, label %L25
L23:
  %t70 = load ptr, ptr %t9
  %t72 = ptrtoint ptr %t70 to i64
  %t71 = add i64 %t72, 1
  store i64 %t71, ptr %t9
  %t73 = load i64, ptr %t70
  call void @buf_putc(ptr %t1, i64 %t73)
  br label %L26
L26:
  %t75 = load ptr, ptr %t9
  %t76 = load i64, ptr %t75
  %t77 = load ptr, ptr %t9
  %t78 = load i64, ptr %t77
  %t80 = sext i32 39 to i64
  %t79 = icmp ne i64 %t78, %t80
  %t81 = zext i1 %t79 to i64
  %t83 = icmp ne i64 %t76, 0
  %t84 = icmp ne i64 %t81, 0
  %t85 = and i1 %t83, %t84
  %t86 = zext i1 %t85 to i64
  %t87 = icmp ne i64 %t86, 0
  br i1 %t87, label %L27, label %L28
L27:
  %t88 = load ptr, ptr %t9
  %t89 = load i64, ptr %t88
  %t91 = sext i32 92 to i64
  %t90 = icmp eq i64 %t89, %t91
  %t92 = zext i1 %t90 to i64
  %t93 = icmp ne i64 %t92, 0
  br i1 %t93, label %L29, label %L31
L29:
  %t94 = load ptr, ptr %t9
  %t96 = ptrtoint ptr %t94 to i64
  %t95 = add i64 %t96, 1
  store i64 %t95, ptr %t9
  %t97 = load i64, ptr %t94
  call void @buf_putc(ptr %t1, i64 %t97)
  br label %L31
L31:
  %t99 = load ptr, ptr %t9
  %t100 = load i64, ptr %t99
  %t101 = icmp ne i64 %t100, 0
  br i1 %t101, label %L32, label %L34
L32:
  %t102 = load ptr, ptr %t9
  %t104 = ptrtoint ptr %t102 to i64
  %t103 = add i64 %t104, 1
  store i64 %t103, ptr %t9
  %t105 = load i64, ptr %t102
  call void @buf_putc(ptr %t1, i64 %t105)
  br label %L34
L34:
  br label %L26
L28:
  %t107 = load ptr, ptr %t9
  %t108 = load i64, ptr %t107
  %t109 = icmp ne i64 %t108, 0
  br i1 %t109, label %L35, label %L37
L35:
  %t110 = load ptr, ptr %t9
  %t112 = ptrtoint ptr %t110 to i64
  %t111 = add i64 %t112, 1
  store i64 %t111, ptr %t9
  %t113 = load i64, ptr %t110
  call void @buf_putc(ptr %t1, i64 %t113)
  br label %L37
L37:
  br label %L4
L38:
  br label %L25
L25:
  %t115 = load ptr, ptr %t9
  %t116 = load i64, ptr %t115
  %t117 = add i64 %t116, 0
  %t118 = call i32 @isalpha(i64 %t117)
  %t119 = sext i32 %t118 to i64
  %t120 = load ptr, ptr %t9
  %t121 = load i64, ptr %t120
  %t123 = sext i32 95 to i64
  %t122 = icmp eq i64 %t121, %t123
  %t124 = zext i1 %t122 to i64
  %t126 = icmp ne i64 %t119, 0
  %t127 = icmp ne i64 %t124, 0
  %t128 = or i1 %t126, %t127
  %t129 = zext i1 %t128 to i64
  %t130 = icmp ne i64 %t129, 0
  br i1 %t130, label %L39, label %L41
L39:
  %t131 = alloca ptr
  %t132 = alloca ptr
  %t133 = load ptr, ptr %t9
  %t134 = load ptr, ptr %t131
  %t135 = call ptr @read_ident(ptr %t133, ptr %t134, i64 8)
  store ptr %t135, ptr %t132
  %t136 = alloca ptr
  %t137 = load ptr, ptr %t131
  %t138 = call ptr @macro_find(ptr %t137)
  store ptr %t138, ptr %t136
  %t139 = load ptr, ptr %t136
  %t140 = load ptr, ptr %t136
  %t141 = load ptr, ptr %t140
  %t143 = ptrtoint ptr %t139 to i64
  %t144 = ptrtoint ptr %t141 to i64
  %t148 = ptrtoint ptr %t139 to i64
  %t149 = ptrtoint ptr %t141 to i64
  %t145 = icmp ne i64 %t148, 0
  %t146 = icmp ne i64 %t149, 0
  %t147 = and i1 %t145, %t146
  %t150 = zext i1 %t147 to i64
  %t151 = icmp ne i64 %t150, 0
  br i1 %t151, label %L42, label %L44
L42:
  %t152 = alloca ptr
  %t153 = load ptr, ptr %t132
  store ptr %t153, ptr %t152
  %t154 = load ptr, ptr %t152
  %t155 = call ptr @skip_ws(ptr %t154)
  store ptr %t155, ptr %t152
  %t156 = load ptr, ptr %t152
  %t157 = load i64, ptr %t156
  %t159 = sext i32 40 to i64
  %t158 = icmp eq i64 %t157, %t159
  %t160 = zext i1 %t158 to i64
  %t161 = icmp ne i64 %t160, 0
  br i1 %t161, label %L45, label %L47
L45:
  %t162 = load ptr, ptr %t132
  store ptr %t162, ptr %t9
  %t163 = load ptr, ptr %t136
  %t165 = sext i32 1 to i64
  %t164 = add i64 %t2, %t165
  call void @expand_func_macro(ptr %t163, ptr %t9, ptr %t1, i64 %t164)
  br label %L4
L48:
  br label %L47
L47:
  br label %L44
L44:
  %t167 = load ptr, ptr %t136
  %t168 = load ptr, ptr %t136
  %t169 = load ptr, ptr %t168
  %t171 = ptrtoint ptr %t169 to i64
  %t172 = icmp eq i64 %t171, 0
  %t170 = zext i1 %t172 to i64
  %t174 = ptrtoint ptr %t167 to i64
  %t178 = ptrtoint ptr %t167 to i64
  %t175 = icmp ne i64 %t178, 0
  %t176 = icmp ne i64 %t170, 0
  %t177 = and i1 %t175, %t176
  %t179 = zext i1 %t177 to i64
  %t180 = icmp ne i64 %t179, 0
  br i1 %t180, label %L49, label %L51
L49:
  %t181 = load ptr, ptr %t136
  %t182 = load ptr, ptr %t181
  %t184 = sext i32 1 to i64
  %t183 = add i64 %t2, %t184
  call void @expand_text(ptr %t182, ptr %t1, i64 %t183)
  %t186 = load ptr, ptr %t132
  store ptr %t186, ptr %t9
  br label %L4
L52:
  br label %L51
L51:
  %t187 = load ptr, ptr %t131
  %t188 = load ptr, ptr %t131
  %t189 = call i64 @strlen(ptr %t188)
  call void @buf_append(ptr %t1, ptr %t187, i64 %t189)
  %t191 = load ptr, ptr %t132
  store ptr %t191, ptr %t9
  br label %L4
L53:
  br label %L41
L41:
  %t192 = load ptr, ptr %t9
  %t194 = ptrtoint ptr %t192 to i64
  %t193 = add i64 %t194, 1
  store i64 %t193, ptr %t9
  %t195 = load i64, ptr %t192
  call void @buf_putc(ptr %t1, i64 %t195)
  br label %L4
L6:
  ret void
}

define internal ptr @read_file(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = getelementptr [2 x i8], ptr @.str4, i64 0, i64 0
  %t3 = call ptr @fopen(ptr %t0, ptr %t2)
  store ptr %t3, ptr %t1
  %t4 = load ptr, ptr %t1
  %t6 = ptrtoint ptr %t4 to i64
  %t7 = icmp eq i64 %t6, 0
  %t5 = zext i1 %t7 to i64
  %t8 = icmp ne i64 %t5, 0
  br i1 %t8, label %L0, label %L2
L0:
  %t10 = sext i32 0 to i64
  %t9 = inttoptr i64 %t10 to ptr
  ret ptr %t9
L3:
  br label %L2
L2:
  %t11 = load ptr, ptr %t1
  %t12 = call i64 @fseek(ptr %t11, i64 0, i64 2)
  %t13 = alloca i64
  %t14 = load ptr, ptr %t1
  %t15 = call i64 @ftell(ptr %t14)
  store i64 %t15, ptr %t13
  %t16 = load ptr, ptr %t1
  %t17 = call i64 @fseek(ptr %t16, i64 0, i64 0)
  %t18 = alloca ptr
  %t19 = load i64, ptr %t13
  %t21 = sext i32 1 to i64
  %t20 = add i64 %t19, %t21
  %t22 = call ptr @malloc(i64 %t20)
  store ptr %t22, ptr %t18
  %t23 = load ptr, ptr %t18
  %t25 = ptrtoint ptr %t23 to i64
  %t26 = icmp eq i64 %t25, 0
  %t24 = zext i1 %t26 to i64
  %t27 = icmp ne i64 %t24, 0
  br i1 %t27, label %L4, label %L6
L4:
  %t28 = load ptr, ptr %t1
  %t29 = call i32 @fclose(ptr %t28)
  %t30 = sext i32 %t29 to i64
  %t32 = sext i32 0 to i64
  %t31 = inttoptr i64 %t32 to ptr
  ret ptr %t31
L7:
  br label %L6
L6:
  %t33 = alloca i64
  %t34 = load ptr, ptr %t18
  %t35 = load i64, ptr %t13
  %t36 = load ptr, ptr %t1
  %t37 = call i64 @fread(ptr %t34, i64 1, i64 %t35, ptr %t36)
  store i64 %t37, ptr %t33
  %t38 = load ptr, ptr %t18
  %t39 = load i64, ptr %t33
  %t40 = getelementptr i8, ptr %t38, i64 %t39
  %t41 = sext i32 0 to i64
  store i64 %t41, ptr %t40
  %t42 = load ptr, ptr %t1
  %t43 = call i32 @fclose(ptr %t42)
  %t44 = sext i32 %t43 to i64
  %t45 = load ptr, ptr %t18
  ret ptr %t45
L8:
  ret ptr null
}

define internal ptr @find_include(ptr %t0, i64 %t1) {
entry:
  %t3 = icmp eq i64 %t1, 0
  %t2 = zext i1 %t3 to i64
  %t4 = icmp ne i64 %t2, 0
  br i1 %t4, label %L0, label %L2
L0:
  %t5 = alloca ptr
  %t6 = call ptr @read_file(ptr %t0)
  store ptr %t6, ptr %t5
  %t7 = load ptr, ptr %t5
  %t8 = icmp ne ptr %t7, null
  br i1 %t8, label %L3, label %L5
L3:
  %t9 = load ptr, ptr %t5
  ret ptr %t9
L6:
  br label %L5
L5:
  br label %L2
L2:
  %t10 = alloca i64
  %t11 = sext i32 0 to i64
  store i64 %t11, ptr %t10
  br label %L7
L7:
  %t12 = load ptr, ptr @INCLUDE_PATHS
  %t13 = load i64, ptr %t10
  %t14 = getelementptr i32, ptr %t12, i64 %t13
  %t15 = load i64, ptr %t14
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L8, label %L10
L8:
  %t17 = alloca ptr
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr [6 x i8], ptr @.str5, i64 0, i64 0
  %t20 = load ptr, ptr @INCLUDE_PATHS
  %t21 = load i64, ptr %t10
  %t22 = getelementptr i32, ptr %t20, i64 %t21
  %t23 = load i64, ptr %t22
  %t24 = call i32 @snprintf(ptr %t18, i64 8, ptr %t19, i64 %t23, ptr %t0)
  %t25 = sext i32 %t24 to i64
  %t26 = alloca ptr
  %t27 = load ptr, ptr %t17
  %t28 = call ptr @read_file(ptr %t27)
  store ptr %t28, ptr %t26
  %t29 = load ptr, ptr %t26
  %t30 = icmp ne ptr %t29, null
  br i1 %t30, label %L11, label %L13
L11:
  %t31 = load ptr, ptr %t26
  ret ptr %t31
L14:
  br label %L13
L13:
  br label %L9
L9:
  %t32 = load i64, ptr %t10
  %t33 = add i64 %t32, 1
  store i64 %t33, ptr %t10
  br label %L7
L10:
  %t35 = sext i32 0 to i64
  %t34 = inttoptr i64 %t35 to ptr
  ret ptr %t34
L15:
  ret ptr null
}

define internal void @process_directive(ptr %t0, ptr %t1, ptr %t2, i64 %t3, ptr %t4, ptr %t5) {
entry:
  %t6 = alloca ptr
  %t8 = ptrtoint ptr %t0 to i64
  %t9 = sext i32 1 to i64
  %t10 = inttoptr i64 %t8 to ptr
  %t7 = getelementptr i8, ptr %t10, i64 %t9
  %t11 = call ptr @skip_ws(ptr %t7)
  store ptr %t11, ptr %t6
  %t12 = alloca ptr
  %t13 = load ptr, ptr %t6
  %t14 = load ptr, ptr %t12
  %t15 = call ptr @read_ident(ptr %t13, ptr %t14, i64 8)
  store ptr %t15, ptr %t6
  %t16 = load ptr, ptr %t6
  %t17 = call ptr @skip_ws(ptr %t16)
  store ptr %t17, ptr %t6
  %t18 = load ptr, ptr %t12
  %t19 = getelementptr [6 x i8], ptr @.str6, i64 0, i64 0
  %t20 = call i32 @strcmp(ptr %t18, ptr %t19)
  %t21 = sext i32 %t20 to i64
  %t23 = sext i32 0 to i64
  %t22 = icmp eq i64 %t21, %t23
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L0, label %L2
L0:
  %t26 = alloca ptr
  %t27 = load ptr, ptr %t6
  %t28 = load ptr, ptr %t26
  %t29 = call ptr @read_ident(ptr %t27, ptr %t28, i64 8)
  %t30 = alloca i64
  %t31 = load ptr, ptr %t26
  %t32 = call ptr @macro_find(ptr %t31)
  %t34 = sext i32 0 to i64
  %t33 = inttoptr i64 %t34 to ptr
  %t36 = ptrtoint ptr %t32 to i64
  %t37 = ptrtoint ptr %t33 to i64
  %t35 = icmp ne i64 %t36, %t37
  %t38 = zext i1 %t35 to i64
  store i64 %t38, ptr %t30
  %t39 = load i64, ptr %t5
  %t41 = sext i32 32 to i64
  %t40 = icmp slt i64 %t39, %t41
  %t42 = zext i1 %t40 to i64
  %t43 = icmp ne i64 %t42, 0
  br i1 %t43, label %L3, label %L5
L3:
  %t44 = load i64, ptr %t30
  %t45 = load i64, ptr %t5
  %t46 = add i64 %t45, 1
  store i64 %t46, ptr %t5
  %t47 = getelementptr i8, ptr %t4, i64 %t45
  store i64 %t44, ptr %t47
  br label %L5
L5:
  ret void
L6:
  br label %L2
L2:
  %t48 = load ptr, ptr %t12
  %t49 = getelementptr [7 x i8], ptr @.str7, i64 0, i64 0
  %t50 = call i32 @strcmp(ptr %t48, ptr %t49)
  %t51 = sext i32 %t50 to i64
  %t53 = sext i32 0 to i64
  %t52 = icmp eq i64 %t51, %t53
  %t54 = zext i1 %t52 to i64
  %t55 = icmp ne i64 %t54, 0
  br i1 %t55, label %L7, label %L9
L7:
  %t56 = alloca ptr
  %t57 = load ptr, ptr %t6
  %t58 = load ptr, ptr %t56
  %t59 = call ptr @read_ident(ptr %t57, ptr %t58, i64 8)
  %t60 = alloca i64
  %t61 = load ptr, ptr %t56
  %t62 = call ptr @macro_find(ptr %t61)
  %t64 = sext i32 0 to i64
  %t63 = inttoptr i64 %t64 to ptr
  %t66 = ptrtoint ptr %t62 to i64
  %t67 = ptrtoint ptr %t63 to i64
  %t65 = icmp eq i64 %t66, %t67
  %t68 = zext i1 %t65 to i64
  store i64 %t68, ptr %t60
  %t69 = load i64, ptr %t5
  %t71 = sext i32 32 to i64
  %t70 = icmp slt i64 %t69, %t71
  %t72 = zext i1 %t70 to i64
  %t73 = icmp ne i64 %t72, 0
  br i1 %t73, label %L10, label %L12
L10:
  %t74 = load i64, ptr %t60
  %t75 = load i64, ptr %t5
  %t76 = add i64 %t75, 1
  store i64 %t76, ptr %t5
  %t77 = getelementptr i8, ptr %t4, i64 %t75
  store i64 %t74, ptr %t77
  br label %L12
L12:
  ret void
L13:
  br label %L9
L9:
  %t78 = load ptr, ptr %t12
  %t79 = getelementptr [3 x i8], ptr @.str8, i64 0, i64 0
  %t80 = call i32 @strcmp(ptr %t78, ptr %t79)
  %t81 = sext i32 %t80 to i64
  %t83 = sext i32 0 to i64
  %t82 = icmp eq i64 %t81, %t83
  %t84 = zext i1 %t82 to i64
  %t85 = icmp ne i64 %t84, 0
  br i1 %t85, label %L14, label %L16
L14:
  %t86 = alloca i64
  %t87 = sext i32 0 to i64
  store i64 %t87, ptr %t86
  %t88 = load ptr, ptr %t6
  %t89 = getelementptr [8 x i8], ptr @.str9, i64 0, i64 0
  %t90 = call i32 @strncmp(ptr %t88, ptr %t89, i64 7)
  %t91 = sext i32 %t90 to i64
  %t93 = sext i32 0 to i64
  %t92 = icmp eq i64 %t91, %t93
  %t94 = zext i1 %t92 to i64
  %t95 = icmp ne i64 %t94, 0
  br i1 %t95, label %L17, label %L18
L17:
  %t96 = load ptr, ptr %t6
  %t98 = ptrtoint ptr %t96 to i64
  %t99 = sext i32 7 to i64
  %t97 = add i64 %t98, %t99
  store i64 %t97, ptr %t6
  %t100 = load ptr, ptr %t6
  %t101 = call ptr @skip_ws(ptr %t100)
  store ptr %t101, ptr %t6
  %t102 = load ptr, ptr %t6
  %t103 = load i64, ptr %t102
  %t105 = sext i32 40 to i64
  %t104 = icmp eq i64 %t103, %t105
  %t106 = zext i1 %t104 to i64
  %t107 = icmp ne i64 %t106, 0
  br i1 %t107, label %L20, label %L22
L20:
  %t108 = load ptr, ptr %t6
  %t110 = ptrtoint ptr %t108 to i64
  %t109 = add i64 %t110, 1
  store i64 %t109, ptr %t6
  br label %L22
L22:
  %t111 = load ptr, ptr %t6
  %t112 = call ptr @skip_ws(ptr %t111)
  store ptr %t112, ptr %t6
  %t113 = alloca ptr
  %t114 = alloca ptr
  %t115 = load ptr, ptr %t6
  %t116 = load ptr, ptr %t113
  %t117 = call ptr @read_ident(ptr %t115, ptr %t116, i64 8)
  store ptr %t117, ptr %t114
  %t118 = load ptr, ptr %t114
  %t119 = ptrtoint ptr %t118 to i64
  %t120 = load ptr, ptr %t113
  %t121 = call ptr @macro_find(ptr %t120)
  %t123 = sext i32 0 to i64
  %t122 = inttoptr i64 %t123 to ptr
  %t125 = ptrtoint ptr %t121 to i64
  %t126 = ptrtoint ptr %t122 to i64
  %t124 = icmp ne i64 %t125, %t126
  %t127 = zext i1 %t124 to i64
  store i64 %t127, ptr %t86
  br label %L19
L18:
  %t128 = load ptr, ptr %t6
  %t129 = call i32 @atoi(ptr %t128)
  %t130 = sext i32 %t129 to i64
  %t132 = sext i32 0 to i64
  %t131 = icmp ne i64 %t130, %t132
  %t133 = zext i1 %t131 to i64
  store i64 %t133, ptr %t86
  br label %L19
L19:
  %t134 = load i64, ptr %t5
  %t136 = sext i32 32 to i64
  %t135 = icmp slt i64 %t134, %t136
  %t137 = zext i1 %t135 to i64
  %t138 = icmp ne i64 %t137, 0
  br i1 %t138, label %L23, label %L25
L23:
  %t139 = load i64, ptr %t86
  %t140 = load i64, ptr %t5
  %t141 = add i64 %t140, 1
  store i64 %t141, ptr %t5
  %t142 = getelementptr i8, ptr %t4, i64 %t140
  store i64 %t139, ptr %t142
  br label %L25
L25:
  ret void
L26:
  br label %L16
L16:
  %t143 = load ptr, ptr %t12
  %t144 = getelementptr [5 x i8], ptr @.str10, i64 0, i64 0
  %t145 = call i32 @strcmp(ptr %t143, ptr %t144)
  %t146 = sext i32 %t145 to i64
  %t148 = sext i32 0 to i64
  %t147 = icmp eq i64 %t146, %t148
  %t149 = zext i1 %t147 to i64
  %t150 = icmp ne i64 %t149, 0
  br i1 %t150, label %L27, label %L29
L27:
  %t151 = load i64, ptr %t5
  %t153 = sext i32 0 to i64
  %t152 = icmp sgt i64 %t151, %t153
  %t154 = zext i1 %t152 to i64
  %t155 = icmp ne i64 %t154, 0
  br i1 %t155, label %L30, label %L32
L30:
  %t156 = alloca i64
  %t157 = load ptr, ptr %t6
  %t158 = call i32 @atoi(ptr %t157)
  %t159 = sext i32 %t158 to i64
  %t161 = sext i32 0 to i64
  %t160 = icmp ne i64 %t159, %t161
  %t162 = zext i1 %t160 to i64
  store i64 %t162, ptr %t156
  %t163 = load i64, ptr %t156
  %t164 = load i64, ptr %t5
  %t166 = sext i32 1 to i64
  %t165 = sub i64 %t164, %t166
  %t167 = getelementptr i8, ptr %t4, i64 %t165
  store i64 %t163, ptr %t167
  br label %L32
L32:
  ret void
L33:
  br label %L29
L29:
  %t168 = load ptr, ptr %t12
  %t169 = getelementptr [5 x i8], ptr @.str11, i64 0, i64 0
  %t170 = call i32 @strcmp(ptr %t168, ptr %t169)
  %t171 = sext i32 %t170 to i64
  %t173 = sext i32 0 to i64
  %t172 = icmp eq i64 %t171, %t173
  %t174 = zext i1 %t172 to i64
  %t175 = icmp ne i64 %t174, 0
  br i1 %t175, label %L34, label %L36
L34:
  %t176 = load i64, ptr %t5
  %t178 = sext i32 0 to i64
  %t177 = icmp sgt i64 %t176, %t178
  %t179 = zext i1 %t177 to i64
  %t180 = icmp ne i64 %t179, 0
  br i1 %t180, label %L37, label %L39
L37:
  %t181 = load i64, ptr %t5
  %t183 = sext i32 1 to i64
  %t182 = sub i64 %t181, %t183
  %t184 = getelementptr i32, ptr %t4, i64 %t182
  %t185 = load i64, ptr %t184
  %t187 = sext i32 1 to i64
  %t186 = xor i64 %t185, %t187
  %t188 = load i64, ptr %t5
  %t190 = sext i32 1 to i64
  %t189 = sub i64 %t188, %t190
  %t191 = getelementptr i8, ptr %t4, i64 %t189
  store i64 %t186, ptr %t191
  br label %L39
L39:
  ret void
L40:
  br label %L36
L36:
  %t192 = load ptr, ptr %t12
  %t193 = getelementptr [6 x i8], ptr @.str12, i64 0, i64 0
  %t194 = call i32 @strcmp(ptr %t192, ptr %t193)
  %t195 = sext i32 %t194 to i64
  %t197 = sext i32 0 to i64
  %t196 = icmp eq i64 %t195, %t197
  %t198 = zext i1 %t196 to i64
  %t199 = icmp ne i64 %t198, 0
  br i1 %t199, label %L41, label %L43
L41:
  %t200 = load i64, ptr %t5
  %t202 = sext i32 0 to i64
  %t201 = icmp sgt i64 %t200, %t202
  %t203 = zext i1 %t201 to i64
  %t204 = icmp ne i64 %t203, 0
  br i1 %t204, label %L44, label %L46
L44:
  %t205 = load i64, ptr %t5
  %t206 = sub i64 %t205, 1
  store i64 %t206, ptr %t5
  br label %L46
L46:
  ret void
L47:
  br label %L43
L43:
  %t207 = alloca i64
  %t208 = sext i32 1 to i64
  store i64 %t208, ptr %t207
  %t209 = alloca i64
  %t210 = sext i32 0 to i64
  store i64 %t210, ptr %t209
  br label %L48
L48:
  %t211 = load i64, ptr %t209
  %t212 = load i64, ptr %t5
  %t213 = icmp slt i64 %t211, %t212
  %t214 = zext i1 %t213 to i64
  %t215 = icmp ne i64 %t214, 0
  br i1 %t215, label %L49, label %L51
L49:
  %t216 = load i64, ptr %t209
  %t217 = getelementptr i32, ptr %t4, i64 %t216
  %t218 = load i64, ptr %t217
  %t220 = icmp eq i64 %t218, 0
  %t219 = zext i1 %t220 to i64
  %t221 = icmp ne i64 %t219, 0
  br i1 %t221, label %L52, label %L54
L52:
  %t222 = sext i32 0 to i64
  store i64 %t222, ptr %t207
  br label %L51
L55:
  br label %L54
L54:
  br label %L50
L50:
  %t223 = load i64, ptr %t209
  %t224 = add i64 %t223, 1
  store i64 %t224, ptr %t209
  br label %L48
L51:
  %t225 = load i64, ptr %t207
  %t227 = icmp eq i64 %t225, 0
  %t226 = zext i1 %t227 to i64
  %t228 = icmp ne i64 %t226, 0
  br i1 %t228, label %L56, label %L58
L56:
  ret void
L59:
  br label %L58
L58:
  %t229 = load ptr, ptr %t12
  %t230 = getelementptr [7 x i8], ptr @.str13, i64 0, i64 0
  %t231 = call i32 @strcmp(ptr %t229, ptr %t230)
  %t232 = sext i32 %t231 to i64
  %t234 = sext i32 0 to i64
  %t233 = icmp eq i64 %t232, %t234
  %t235 = zext i1 %t233 to i64
  %t236 = icmp ne i64 %t235, 0
  br i1 %t236, label %L60, label %L62
L60:
  %t237 = alloca ptr
  %t238 = load ptr, ptr %t6
  %t239 = load ptr, ptr %t237
  %t240 = call ptr @read_ident(ptr %t238, ptr %t239, i64 8)
  store ptr %t240, ptr %t6
  %t241 = load ptr, ptr %t6
  %t242 = load i64, ptr %t241
  %t244 = sext i32 40 to i64
  %t243 = icmp eq i64 %t242, %t244
  %t245 = zext i1 %t243 to i64
  %t246 = icmp ne i64 %t245, 0
  br i1 %t246, label %L63, label %L64
L63:
  %t247 = load ptr, ptr %t6
  %t249 = ptrtoint ptr %t247 to i64
  %t248 = add i64 %t249, 1
  store i64 %t248, ptr %t6
  %t250 = alloca ptr
  %t251 = sext i32 0 to i64
  store i64 %t251, ptr %t250
  %t252 = alloca i64
  %t253 = sext i32 0 to i64
  store i64 %t253, ptr %t252
  %t254 = alloca i64
  %t255 = sext i32 0 to i64
  store i64 %t255, ptr %t254
  br label %L66
L66:
  %t256 = load ptr, ptr %t6
  %t257 = load i64, ptr %t256
  %t258 = load ptr, ptr %t6
  %t259 = load i64, ptr %t258
  %t261 = sext i32 41 to i64
  %t260 = icmp ne i64 %t259, %t261
  %t262 = zext i1 %t260 to i64
  %t264 = icmp ne i64 %t257, 0
  %t265 = icmp ne i64 %t262, 0
  %t266 = and i1 %t264, %t265
  %t267 = zext i1 %t266 to i64
  %t268 = icmp ne i64 %t267, 0
  br i1 %t268, label %L67, label %L68
L67:
  %t269 = load ptr, ptr %t6
  %t270 = call ptr @skip_ws(ptr %t269)
  store ptr %t270, ptr %t6
  %t271 = load ptr, ptr %t6
  %t272 = load i64, ptr %t271
  %t274 = sext i32 41 to i64
  %t273 = icmp eq i64 %t272, %t274
  %t275 = zext i1 %t273 to i64
  %t276 = icmp ne i64 %t275, 0
  br i1 %t276, label %L69, label %L71
L69:
  br label %L68
L72:
  br label %L71
L71:
  %t277 = load ptr, ptr %t6
  %t278 = load i64, ptr %t277
  %t280 = sext i32 46 to i64
  %t279 = icmp eq i64 %t278, %t280
  %t281 = zext i1 %t279 to i64
  %t282 = load ptr, ptr %t6
  %t284 = ptrtoint ptr %t282 to i64
  %t285 = sext i32 1 to i64
  %t286 = inttoptr i64 %t284 to ptr
  %t283 = getelementptr i8, ptr %t286, i64 %t285
  %t287 = load i64, ptr %t283
  %t289 = sext i32 46 to i64
  %t288 = icmp eq i64 %t287, %t289
  %t290 = zext i1 %t288 to i64
  %t292 = icmp ne i64 %t281, 0
  %t293 = icmp ne i64 %t290, 0
  %t294 = and i1 %t292, %t293
  %t295 = zext i1 %t294 to i64
  %t296 = load ptr, ptr %t6
  %t298 = ptrtoint ptr %t296 to i64
  %t299 = sext i32 2 to i64
  %t300 = inttoptr i64 %t298 to ptr
  %t297 = getelementptr i8, ptr %t300, i64 %t299
  %t301 = load i64, ptr %t297
  %t303 = sext i32 46 to i64
  %t302 = icmp eq i64 %t301, %t303
  %t304 = zext i1 %t302 to i64
  %t306 = icmp ne i64 %t295, 0
  %t307 = icmp ne i64 %t304, 0
  %t308 = and i1 %t306, %t307
  %t309 = zext i1 %t308 to i64
  %t310 = icmp ne i64 %t309, 0
  br i1 %t310, label %L73, label %L75
L73:
  %t311 = sext i32 1 to i64
  store i64 %t311, ptr %t254
  %t312 = load ptr, ptr %t6
  %t314 = ptrtoint ptr %t312 to i64
  %t315 = sext i32 3 to i64
  %t313 = add i64 %t314, %t315
  store i64 %t313, ptr %t6
  %t316 = load ptr, ptr %t6
  %t317 = call ptr @skip_ws(ptr %t316)
  store ptr %t317, ptr %t6
  br label %L68
L76:
  br label %L75
L75:
  %t318 = alloca ptr
  %t319 = load ptr, ptr %t6
  %t320 = load ptr, ptr %t318
  %t321 = call ptr @read_ident(ptr %t319, ptr %t320, i64 8)
  store ptr %t321, ptr %t6
  %t322 = load ptr, ptr %t318
  %t323 = load i64, ptr %t322
  %t324 = load i64, ptr %t252
  %t326 = sext i32 16 to i64
  %t325 = icmp slt i64 %t324, %t326
  %t327 = zext i1 %t325 to i64
  %t329 = icmp ne i64 %t323, 0
  %t330 = icmp ne i64 %t327, 0
  %t331 = and i1 %t329, %t330
  %t332 = zext i1 %t331 to i64
  %t333 = icmp ne i64 %t332, 0
  br i1 %t333, label %L77, label %L79
L77:
  %t334 = load ptr, ptr %t318
  %t335 = call ptr @strdup(ptr %t334)
  %t336 = load ptr, ptr %t250
  %t337 = load i64, ptr %t252
  %t338 = add i64 %t337, 1
  store i64 %t338, ptr %t252
  %t339 = getelementptr i8, ptr %t336, i64 %t337
  store ptr %t335, ptr %t339
  br label %L79
L79:
  %t340 = load ptr, ptr %t6
  %t341 = call ptr @skip_ws(ptr %t340)
  store ptr %t341, ptr %t6
  %t342 = load ptr, ptr %t6
  %t343 = load i64, ptr %t342
  %t345 = sext i32 44 to i64
  %t344 = icmp eq i64 %t343, %t345
  %t346 = zext i1 %t344 to i64
  %t347 = icmp ne i64 %t346, 0
  br i1 %t347, label %L80, label %L82
L80:
  %t348 = load ptr, ptr %t6
  %t350 = ptrtoint ptr %t348 to i64
  %t349 = add i64 %t350, 1
  store i64 %t349, ptr %t6
  br label %L82
L82:
  br label %L66
L68:
  %t351 = load i64, ptr %t254
  %t352 = add i64 %t351, 0
  %t353 = load ptr, ptr %t6
  %t354 = load i64, ptr %t353
  %t356 = sext i32 41 to i64
  %t355 = icmp eq i64 %t354, %t356
  %t357 = zext i1 %t355 to i64
  %t358 = icmp ne i64 %t357, 0
  br i1 %t358, label %L83, label %L85
L83:
  %t359 = load ptr, ptr %t6
  %t361 = ptrtoint ptr %t359 to i64
  %t360 = add i64 %t361, 1
  store i64 %t360, ptr %t6
  br label %L85
L85:
  %t362 = load ptr, ptr %t6
  %t363 = call ptr @skip_ws(ptr %t362)
  store ptr %t363, ptr %t6
  %t364 = alloca ptr
  %t365 = load ptr, ptr %t6
  store ptr %t365, ptr %t364
  %t366 = alloca ptr
  %t367 = load ptr, ptr %t6
  %t368 = call ptr @skip_to_eol(ptr %t367)
  store ptr %t368, ptr %t366
  %t369 = alloca ptr
  %t370 = load ptr, ptr %t366
  %t371 = load ptr, ptr %t364
  %t373 = ptrtoint ptr %t370 to i64
  %t374 = ptrtoint ptr %t371 to i64
  %t372 = sub i64 %t373, %t374
  %t376 = sext i32 1 to i64
  %t375 = add i64 %t372, %t376
  %t377 = call ptr @malloc(i64 %t375)
  store ptr %t377, ptr %t369
  %t378 = load ptr, ptr %t369
  %t379 = load ptr, ptr %t364
  %t380 = load ptr, ptr %t366
  %t381 = load ptr, ptr %t364
  %t383 = ptrtoint ptr %t380 to i64
  %t384 = ptrtoint ptr %t381 to i64
  %t382 = sub i64 %t383, %t384
  %t385 = call ptr @memcpy(ptr %t378, ptr %t379, i64 %t382)
  %t386 = load ptr, ptr %t369
  %t387 = load ptr, ptr %t366
  %t388 = load ptr, ptr %t364
  %t390 = ptrtoint ptr %t387 to i64
  %t391 = ptrtoint ptr %t388 to i64
  %t389 = sub i64 %t390, %t391
  %t392 = getelementptr i8, ptr %t386, i64 %t389
  %t393 = sext i32 0 to i64
  store i64 %t393, ptr %t392
  %t394 = load ptr, ptr %t237
  %t395 = load ptr, ptr %t369
  %t396 = load ptr, ptr %t250
  %t397 = load i64, ptr %t252
  call void @macro_define(ptr %t394, ptr %t395, ptr %t396, i64 %t397, i64 1)
  %t399 = load ptr, ptr %t369
  call void @free(ptr %t399)
  %t401 = alloca i64
  %t402 = sext i32 0 to i64
  store i64 %t402, ptr %t401
  br label %L86
L86:
  %t403 = load i64, ptr %t401
  %t404 = load i64, ptr %t252
  %t405 = icmp slt i64 %t403, %t404
  %t406 = zext i1 %t405 to i64
  %t407 = icmp ne i64 %t406, 0
  br i1 %t407, label %L87, label %L89
L87:
  %t408 = load ptr, ptr %t250
  %t409 = load i64, ptr %t401
  %t410 = getelementptr i32, ptr %t408, i64 %t409
  %t411 = load i64, ptr %t410
  call void @free(i64 %t411)
  br label %L88
L88:
  %t413 = load i64, ptr %t401
  %t414 = add i64 %t413, 1
  store i64 %t414, ptr %t401
  br label %L86
L89:
  br label %L65
L64:
  %t415 = load ptr, ptr %t6
  %t416 = load i64, ptr %t415
  %t418 = sext i32 32 to i64
  %t417 = icmp eq i64 %t416, %t418
  %t419 = zext i1 %t417 to i64
  %t420 = load ptr, ptr %t6
  %t421 = load i64, ptr %t420
  %t423 = sext i32 9 to i64
  %t422 = icmp eq i64 %t421, %t423
  %t424 = zext i1 %t422 to i64
  %t426 = icmp ne i64 %t419, 0
  %t427 = icmp ne i64 %t424, 0
  %t428 = or i1 %t426, %t427
  %t429 = zext i1 %t428 to i64
  %t430 = icmp ne i64 %t429, 0
  br i1 %t430, label %L90, label %L92
L90:
  %t431 = load ptr, ptr %t6
  %t433 = ptrtoint ptr %t431 to i64
  %t432 = add i64 %t433, 1
  store i64 %t432, ptr %t6
  br label %L92
L92:
  %t434 = alloca ptr
  %t435 = load ptr, ptr %t6
  store ptr %t435, ptr %t434
  %t436 = alloca ptr
  %t437 = load ptr, ptr %t6
  %t438 = call ptr @skip_to_eol(ptr %t437)
  store ptr %t438, ptr %t436
  %t439 = alloca ptr
  %t440 = load ptr, ptr %t436
  %t441 = load ptr, ptr %t434
  %t443 = ptrtoint ptr %t440 to i64
  %t444 = ptrtoint ptr %t441 to i64
  %t442 = sub i64 %t443, %t444
  %t446 = sext i32 1 to i64
  %t445 = add i64 %t442, %t446
  %t447 = call ptr @malloc(i64 %t445)
  store ptr %t447, ptr %t439
  %t448 = load ptr, ptr %t439
  %t449 = load ptr, ptr %t434
  %t450 = load ptr, ptr %t436
  %t451 = load ptr, ptr %t434
  %t453 = ptrtoint ptr %t450 to i64
  %t454 = ptrtoint ptr %t451 to i64
  %t452 = sub i64 %t453, %t454
  %t455 = call ptr @memcpy(ptr %t448, ptr %t449, i64 %t452)
  %t456 = load ptr, ptr %t439
  %t457 = load ptr, ptr %t436
  %t458 = load ptr, ptr %t434
  %t460 = ptrtoint ptr %t457 to i64
  %t461 = ptrtoint ptr %t458 to i64
  %t459 = sub i64 %t460, %t461
  %t462 = getelementptr i8, ptr %t456, i64 %t459
  %t463 = sext i32 0 to i64
  store i64 %t463, ptr %t462
  %t464 = load ptr, ptr %t237
  %t465 = load ptr, ptr %t439
  %t467 = sext i32 0 to i64
  %t466 = inttoptr i64 %t467 to ptr
  call void @macro_define(ptr %t464, ptr %t465, ptr %t466, i64 0, i64 0)
  %t469 = load ptr, ptr %t439
  call void @free(ptr %t469)
  br label %L65
L65:
  ret void
L93:
  br label %L62
L62:
  %t471 = load ptr, ptr %t12
  %t472 = getelementptr [6 x i8], ptr @.str14, i64 0, i64 0
  %t473 = call i32 @strcmp(ptr %t471, ptr %t472)
  %t474 = sext i32 %t473 to i64
  %t476 = sext i32 0 to i64
  %t475 = icmp eq i64 %t474, %t476
  %t477 = zext i1 %t475 to i64
  %t478 = icmp ne i64 %t477, 0
  br i1 %t478, label %L94, label %L96
L94:
  %t479 = alloca ptr
  %t480 = load ptr, ptr %t6
  %t481 = load ptr, ptr %t479
  %t482 = call ptr @read_ident(ptr %t480, ptr %t481, i64 8)
  %t483 = load ptr, ptr %t479
  call void @macro_undef(ptr %t483)
  ret void
L97:
  br label %L96
L96:
  %t485 = load ptr, ptr %t12
  %t486 = getelementptr [8 x i8], ptr @.str15, i64 0, i64 0
  %t487 = call i32 @strcmp(ptr %t485, ptr %t486)
  %t488 = sext i32 %t487 to i64
  %t490 = sext i32 0 to i64
  %t489 = icmp eq i64 %t488, %t490
  %t491 = zext i1 %t489 to i64
  %t492 = icmp ne i64 %t491, 0
  br i1 %t492, label %L98, label %L100
L98:
  %t494 = sext i32 32 to i64
  %t493 = icmp sgt i64 %t3, %t494
  %t495 = zext i1 %t493 to i64
  %t496 = icmp ne i64 %t495, 0
  br i1 %t496, label %L101, label %L103
L101:
  %t497 = call ptr @__c0c_stderr()
  %t498 = getelementptr [36 x i8], ptr @.str16, i64 0, i64 0
  %t499 = call i32 @fprintf(ptr %t497, ptr %t498)
  %t500 = sext i32 %t499 to i64
  ret void
L104:
  br label %L103
L103:
  %t501 = alloca i64
  %t502 = sext i32 0 to i64
  store i64 %t502, ptr %t501
  %t503 = alloca ptr
  %t504 = load ptr, ptr %t6
  %t505 = load i64, ptr %t504
  %t507 = sext i32 34 to i64
  %t506 = icmp eq i64 %t505, %t507
  %t508 = zext i1 %t506 to i64
  %t509 = icmp ne i64 %t508, 0
  br i1 %t509, label %L105, label %L106
L105:
  %t510 = load ptr, ptr %t6
  %t512 = ptrtoint ptr %t510 to i64
  %t511 = add i64 %t512, 1
  store i64 %t511, ptr %t6
  %t513 = alloca ptr
  %t514 = load ptr, ptr %t6
  %t515 = call ptr @strchr(ptr %t514, i64 34)
  store ptr %t515, ptr %t513
  %t516 = load ptr, ptr %t513
  %t518 = ptrtoint ptr %t516 to i64
  %t519 = icmp eq i64 %t518, 0
  %t517 = zext i1 %t519 to i64
  %t520 = icmp ne i64 %t517, 0
  br i1 %t520, label %L108, label %L110
L108:
  ret void
L111:
  br label %L110
L110:
  %t521 = alloca i64
  %t522 = load ptr, ptr %t513
  %t523 = load ptr, ptr %t6
  %t525 = ptrtoint ptr %t522 to i64
  %t526 = ptrtoint ptr %t523 to i64
  %t524 = sub i64 %t525, %t526
  %t527 = add i64 %t524, 0
  store i64 %t527, ptr %t521
  %t528 = load ptr, ptr %t503
  %t529 = load ptr, ptr %t6
  %t530 = load i64, ptr %t521
  %t531 = call ptr @memcpy(ptr %t528, ptr %t529, i64 %t530)
  %t532 = load ptr, ptr %t503
  %t533 = load i64, ptr %t521
  %t534 = getelementptr i8, ptr %t532, i64 %t533
  %t535 = sext i32 0 to i64
  store i64 %t535, ptr %t534
  br label %L107
L106:
  %t536 = load ptr, ptr %t6
  %t537 = load i64, ptr %t536
  %t539 = sext i32 60 to i64
  %t538 = icmp eq i64 %t537, %t539
  %t540 = zext i1 %t538 to i64
  %t541 = icmp ne i64 %t540, 0
  br i1 %t541, label %L112, label %L113
L112:
  %t542 = load ptr, ptr %t6
  %t544 = ptrtoint ptr %t542 to i64
  %t543 = add i64 %t544, 1
  store i64 %t543, ptr %t6
  %t545 = alloca ptr
  %t546 = load ptr, ptr %t6
  %t547 = call ptr @strchr(ptr %t546, i64 62)
  store ptr %t547, ptr %t545
  %t548 = load ptr, ptr %t545
  %t550 = ptrtoint ptr %t548 to i64
  %t551 = icmp eq i64 %t550, 0
  %t549 = zext i1 %t551 to i64
  %t552 = icmp ne i64 %t549, 0
  br i1 %t552, label %L115, label %L117
L115:
  ret void
L118:
  br label %L117
L117:
  %t553 = alloca i64
  %t554 = load ptr, ptr %t545
  %t555 = load ptr, ptr %t6
  %t557 = ptrtoint ptr %t554 to i64
  %t558 = ptrtoint ptr %t555 to i64
  %t556 = sub i64 %t557, %t558
  %t559 = add i64 %t556, 0
  store i64 %t559, ptr %t553
  %t560 = load ptr, ptr %t503
  %t561 = load ptr, ptr %t6
  %t562 = load i64, ptr %t553
  %t563 = call ptr @memcpy(ptr %t560, ptr %t561, i64 %t562)
  %t564 = load ptr, ptr %t503
  %t565 = load i64, ptr %t553
  %t566 = getelementptr i8, ptr %t564, i64 %t565
  %t567 = sext i32 0 to i64
  store i64 %t567, ptr %t566
  %t568 = sext i32 1 to i64
  store i64 %t568, ptr %t501
  br label %L114
L113:
  ret void
L119:
  br label %L114
L114:
  br label %L107
L107:
  %t569 = alloca ptr
  %t570 = load ptr, ptr %t503
  %t571 = load i64, ptr %t501
  %t572 = call ptr @find_include(ptr %t570, i64 %t571)
  store ptr %t572, ptr %t569
  %t573 = load ptr, ptr %t569
  %t575 = ptrtoint ptr %t573 to i64
  %t576 = icmp eq i64 %t575, 0
  %t574 = zext i1 %t576 to i64
  %t577 = icmp ne i64 %t574, 0
  br i1 %t577, label %L120, label %L122
L120:
  %t578 = getelementptr [2 x i8], ptr @.str17, i64 0, i64 0
  call void @buf_append(ptr %t2, ptr %t578, i64 1)
  ret void
L123:
  br label %L122
L122:
  %t580 = load i64, ptr %t501
  %t581 = icmp ne i64 %t580, 0
  br i1 %t581, label %L124, label %L126
L124:
  %t582 = load ptr, ptr %t569
  call void @free(ptr %t582)
  %t584 = getelementptr [2 x i8], ptr @.str18, i64 0, i64 0
  call void @buf_append(ptr %t2, ptr %t584, i64 1)
  ret void
L127:
  br label %L126
L126:
  %t586 = alloca ptr
  %t587 = load ptr, ptr %t569
  %t588 = load ptr, ptr %t503
  %t590 = sext i32 1 to i64
  %t589 = add i64 %t3, %t590
  %t591 = call ptr @macro_preprocess(ptr %t587, ptr %t588, i64 %t589)
  store ptr %t591, ptr %t586
  %t592 = load ptr, ptr %t569
  call void @free(ptr %t592)
  %t594 = load ptr, ptr %t586
  %t595 = load ptr, ptr %t586
  %t596 = call i64 @strlen(ptr %t595)
  call void @buf_append(ptr %t2, ptr %t594, i64 %t596)
  call void @buf_putc(ptr %t2, i64 10)
  %t599 = load ptr, ptr %t586
  call void @free(ptr %t599)
  ret void
L128:
  br label %L100
L100:
  ret void
}

define internal void @preprocess_into(ptr %t0, ptr %t1, ptr %t2, i64 %t3, ptr %t4, ptr %t5) {
entry:
  %t6 = alloca ptr
  store ptr %t0, ptr %t6
  br label %L0
L0:
  %t7 = load ptr, ptr %t6
  %t8 = load i64, ptr %t7
  %t9 = icmp ne i64 %t8, 0
  br i1 %t9, label %L1, label %L2
L1:
  %t10 = load ptr, ptr %t6
  %t11 = load i64, ptr %t10
  %t13 = sext i32 92 to i64
  %t12 = icmp eq i64 %t11, %t13
  %t14 = zext i1 %t12 to i64
  %t15 = load ptr, ptr %t6
  %t17 = ptrtoint ptr %t15 to i64
  %t18 = sext i32 1 to i64
  %t19 = inttoptr i64 %t17 to ptr
  %t16 = getelementptr i8, ptr %t19, i64 %t18
  %t20 = load i64, ptr %t16
  %t22 = sext i32 10 to i64
  %t21 = icmp eq i64 %t20, %t22
  %t23 = zext i1 %t21 to i64
  %t25 = icmp ne i64 %t14, 0
  %t26 = icmp ne i64 %t23, 0
  %t27 = and i1 %t25, %t26
  %t28 = zext i1 %t27 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L3, label %L5
L3:
  %t30 = load ptr, ptr %t6
  %t32 = ptrtoint ptr %t30 to i64
  %t33 = sext i32 2 to i64
  %t31 = add i64 %t32, %t33
  store i64 %t31, ptr %t6
  br label %L0
L6:
  br label %L5
L5:
  %t34 = alloca i64
  call void @buf_init(ptr %t34)
  br label %L7
L7:
  %t36 = load ptr, ptr %t6
  %t37 = load i64, ptr %t36
  %t38 = load ptr, ptr %t6
  %t39 = load i64, ptr %t38
  %t41 = sext i32 10 to i64
  %t40 = icmp ne i64 %t39, %t41
  %t42 = zext i1 %t40 to i64
  %t44 = icmp ne i64 %t37, 0
  %t45 = icmp ne i64 %t42, 0
  %t46 = and i1 %t44, %t45
  %t47 = zext i1 %t46 to i64
  %t48 = icmp ne i64 %t47, 0
  br i1 %t48, label %L8, label %L9
L8:
  %t49 = load ptr, ptr %t6
  %t50 = load i64, ptr %t49
  %t52 = sext i32 92 to i64
  %t51 = icmp eq i64 %t50, %t52
  %t53 = zext i1 %t51 to i64
  %t54 = load ptr, ptr %t6
  %t56 = ptrtoint ptr %t54 to i64
  %t57 = sext i32 1 to i64
  %t58 = inttoptr i64 %t56 to ptr
  %t55 = getelementptr i8, ptr %t58, i64 %t57
  %t59 = load i64, ptr %t55
  %t61 = sext i32 10 to i64
  %t60 = icmp eq i64 %t59, %t61
  %t62 = zext i1 %t60 to i64
  %t64 = icmp ne i64 %t53, 0
  %t65 = icmp ne i64 %t62, 0
  %t66 = and i1 %t64, %t65
  %t67 = zext i1 %t66 to i64
  %t68 = icmp ne i64 %t67, 0
  br i1 %t68, label %L10, label %L12
L10:
  %t69 = load ptr, ptr %t6
  %t71 = ptrtoint ptr %t69 to i64
  %t72 = sext i32 2 to i64
  %t70 = add i64 %t71, %t72
  store i64 %t70, ptr %t6
  br label %L7
L13:
  br label %L12
L12:
  %t73 = load ptr, ptr %t6
  %t74 = load i64, ptr %t73
  %t76 = sext i32 39 to i64
  %t75 = icmp eq i64 %t74, %t76
  %t77 = zext i1 %t75 to i64
  %t78 = icmp ne i64 %t77, 0
  br i1 %t78, label %L14, label %L16
L14:
  %t79 = load ptr, ptr %t6
  %t81 = ptrtoint ptr %t79 to i64
  %t80 = add i64 %t81, 1
  store i64 %t80, ptr %t6
  %t82 = load i64, ptr %t79
  call void @buf_putc(ptr %t34, i64 %t82)
  %t84 = load ptr, ptr %t6
  %t85 = load i64, ptr %t84
  %t87 = sext i32 92 to i64
  %t86 = icmp eq i64 %t85, %t87
  %t88 = zext i1 %t86 to i64
  %t89 = load ptr, ptr %t6
  %t91 = ptrtoint ptr %t89 to i64
  %t92 = sext i32 1 to i64
  %t93 = inttoptr i64 %t91 to ptr
  %t90 = getelementptr i8, ptr %t93, i64 %t92
  %t94 = load i64, ptr %t90
  %t96 = icmp ne i64 %t88, 0
  %t97 = icmp ne i64 %t94, 0
  %t98 = and i1 %t96, %t97
  %t99 = zext i1 %t98 to i64
  %t100 = load ptr, ptr %t6
  %t102 = ptrtoint ptr %t100 to i64
  %t103 = sext i32 1 to i64
  %t104 = inttoptr i64 %t102 to ptr
  %t101 = getelementptr i8, ptr %t104, i64 %t103
  %t105 = load i64, ptr %t101
  %t107 = sext i32 10 to i64
  %t106 = icmp ne i64 %t105, %t107
  %t108 = zext i1 %t106 to i64
  %t110 = icmp ne i64 %t99, 0
  %t111 = icmp ne i64 %t108, 0
  %t112 = and i1 %t110, %t111
  %t113 = zext i1 %t112 to i64
  %t114 = icmp ne i64 %t113, 0
  br i1 %t114, label %L17, label %L19
L17:
  %t115 = load ptr, ptr %t6
  %t117 = ptrtoint ptr %t115 to i64
  %t116 = add i64 %t117, 1
  store i64 %t116, ptr %t6
  %t118 = load i64, ptr %t115
  call void @buf_putc(ptr %t34, i64 %t118)
  br label %L19
L19:
  %t120 = load ptr, ptr %t6
  %t121 = load i64, ptr %t120
  %t122 = load ptr, ptr %t6
  %t123 = load i64, ptr %t122
  %t125 = sext i32 10 to i64
  %t124 = icmp ne i64 %t123, %t125
  %t126 = zext i1 %t124 to i64
  %t128 = icmp ne i64 %t121, 0
  %t129 = icmp ne i64 %t126, 0
  %t130 = and i1 %t128, %t129
  %t131 = zext i1 %t130 to i64
  %t132 = icmp ne i64 %t131, 0
  br i1 %t132, label %L20, label %L22
L20:
  %t133 = load ptr, ptr %t6
  %t135 = ptrtoint ptr %t133 to i64
  %t134 = add i64 %t135, 1
  store i64 %t134, ptr %t6
  %t136 = load i64, ptr %t133
  call void @buf_putc(ptr %t34, i64 %t136)
  br label %L22
L22:
  %t138 = load ptr, ptr %t6
  %t139 = load i64, ptr %t138
  %t141 = sext i32 39 to i64
  %t140 = icmp eq i64 %t139, %t141
  %t142 = zext i1 %t140 to i64
  %t143 = icmp ne i64 %t142, 0
  br i1 %t143, label %L23, label %L25
L23:
  %t144 = load ptr, ptr %t6
  %t146 = ptrtoint ptr %t144 to i64
  %t145 = add i64 %t146, 1
  store i64 %t145, ptr %t6
  %t147 = load i64, ptr %t144
  call void @buf_putc(ptr %t34, i64 %t147)
  br label %L25
L25:
  br label %L7
L26:
  br label %L16
L16:
  %t149 = load ptr, ptr %t6
  %t150 = load i64, ptr %t149
  %t152 = sext i32 34 to i64
  %t151 = icmp eq i64 %t150, %t152
  %t153 = zext i1 %t151 to i64
  %t154 = icmp ne i64 %t153, 0
  br i1 %t154, label %L27, label %L29
L27:
  %t155 = load ptr, ptr %t6
  %t157 = ptrtoint ptr %t155 to i64
  %t156 = add i64 %t157, 1
  store i64 %t156, ptr %t6
  %t158 = load i64, ptr %t155
  call void @buf_putc(ptr %t34, i64 %t158)
  br label %L30
L30:
  %t160 = load ptr, ptr %t6
  %t161 = load i64, ptr %t160
  %t162 = load ptr, ptr %t6
  %t163 = load i64, ptr %t162
  %t165 = sext i32 34 to i64
  %t164 = icmp ne i64 %t163, %t165
  %t166 = zext i1 %t164 to i64
  %t168 = icmp ne i64 %t161, 0
  %t169 = icmp ne i64 %t166, 0
  %t170 = and i1 %t168, %t169
  %t171 = zext i1 %t170 to i64
  %t172 = load ptr, ptr %t6
  %t173 = load i64, ptr %t172
  %t175 = sext i32 10 to i64
  %t174 = icmp ne i64 %t173, %t175
  %t176 = zext i1 %t174 to i64
  %t178 = icmp ne i64 %t171, 0
  %t179 = icmp ne i64 %t176, 0
  %t180 = and i1 %t178, %t179
  %t181 = zext i1 %t180 to i64
  %t182 = icmp ne i64 %t181, 0
  br i1 %t182, label %L31, label %L32
L31:
  %t183 = load ptr, ptr %t6
  %t184 = load i64, ptr %t183
  %t186 = sext i32 92 to i64
  %t185 = icmp eq i64 %t184, %t186
  %t187 = zext i1 %t185 to i64
  %t188 = load ptr, ptr %t6
  %t190 = ptrtoint ptr %t188 to i64
  %t191 = sext i32 1 to i64
  %t192 = inttoptr i64 %t190 to ptr
  %t189 = getelementptr i8, ptr %t192, i64 %t191
  %t193 = load i64, ptr %t189
  %t195 = icmp ne i64 %t187, 0
  %t196 = icmp ne i64 %t193, 0
  %t197 = and i1 %t195, %t196
  %t198 = zext i1 %t197 to i64
  %t199 = icmp ne i64 %t198, 0
  br i1 %t199, label %L33, label %L35
L33:
  %t200 = load ptr, ptr %t6
  %t202 = ptrtoint ptr %t200 to i64
  %t201 = add i64 %t202, 1
  store i64 %t201, ptr %t6
  %t203 = load i64, ptr %t200
  call void @buf_putc(ptr %t34, i64 %t203)
  br label %L35
L35:
  %t205 = load ptr, ptr %t6
  %t207 = ptrtoint ptr %t205 to i64
  %t206 = add i64 %t207, 1
  store i64 %t206, ptr %t6
  %t208 = load i64, ptr %t205
  call void @buf_putc(ptr %t34, i64 %t208)
  br label %L30
L32:
  %t210 = load ptr, ptr %t6
  %t211 = load i64, ptr %t210
  %t213 = sext i32 34 to i64
  %t212 = icmp eq i64 %t211, %t213
  %t214 = zext i1 %t212 to i64
  %t215 = icmp ne i64 %t214, 0
  br i1 %t215, label %L36, label %L38
L36:
  %t216 = load ptr, ptr %t6
  %t218 = ptrtoint ptr %t216 to i64
  %t217 = add i64 %t218, 1
  store i64 %t217, ptr %t6
  %t219 = load i64, ptr %t216
  call void @buf_putc(ptr %t34, i64 %t219)
  br label %L38
L38:
  br label %L7
L39:
  br label %L29
L29:
  %t221 = load ptr, ptr %t6
  %t222 = load i64, ptr %t221
  %t224 = sext i32 47 to i64
  %t223 = icmp eq i64 %t222, %t224
  %t225 = zext i1 %t223 to i64
  %t226 = load ptr, ptr %t6
  %t228 = ptrtoint ptr %t226 to i64
  %t229 = sext i32 1 to i64
  %t230 = inttoptr i64 %t228 to ptr
  %t227 = getelementptr i8, ptr %t230, i64 %t229
  %t231 = load i64, ptr %t227
  %t233 = sext i32 47 to i64
  %t232 = icmp eq i64 %t231, %t233
  %t234 = zext i1 %t232 to i64
  %t236 = icmp ne i64 %t225, 0
  %t237 = icmp ne i64 %t234, 0
  %t238 = and i1 %t236, %t237
  %t239 = zext i1 %t238 to i64
  %t240 = icmp ne i64 %t239, 0
  br i1 %t240, label %L40, label %L42
L40:
  br label %L43
L43:
  %t241 = load ptr, ptr %t6
  %t242 = load i64, ptr %t241
  %t243 = load ptr, ptr %t6
  %t244 = load i64, ptr %t243
  %t246 = sext i32 10 to i64
  %t245 = icmp ne i64 %t244, %t246
  %t247 = zext i1 %t245 to i64
  %t249 = icmp ne i64 %t242, 0
  %t250 = icmp ne i64 %t247, 0
  %t251 = and i1 %t249, %t250
  %t252 = zext i1 %t251 to i64
  %t253 = icmp ne i64 %t252, 0
  br i1 %t253, label %L44, label %L45
L44:
  %t254 = load ptr, ptr %t6
  %t256 = ptrtoint ptr %t254 to i64
  %t255 = add i64 %t256, 1
  store i64 %t255, ptr %t6
  br label %L43
L45:
  br label %L9
L46:
  br label %L42
L42:
  %t257 = load ptr, ptr %t6
  %t258 = load i64, ptr %t257
  %t260 = sext i32 47 to i64
  %t259 = icmp eq i64 %t258, %t260
  %t261 = zext i1 %t259 to i64
  %t262 = load ptr, ptr %t6
  %t264 = ptrtoint ptr %t262 to i64
  %t265 = sext i32 1 to i64
  %t266 = inttoptr i64 %t264 to ptr
  %t263 = getelementptr i8, ptr %t266, i64 %t265
  %t267 = load i64, ptr %t263
  %t269 = sext i32 42 to i64
  %t268 = icmp eq i64 %t267, %t269
  %t270 = zext i1 %t268 to i64
  %t272 = icmp ne i64 %t261, 0
  %t273 = icmp ne i64 %t270, 0
  %t274 = and i1 %t272, %t273
  %t275 = zext i1 %t274 to i64
  %t276 = icmp ne i64 %t275, 0
  br i1 %t276, label %L47, label %L49
L47:
  %t277 = load ptr, ptr %t6
  %t279 = ptrtoint ptr %t277 to i64
  %t280 = sext i32 2 to i64
  %t278 = add i64 %t279, %t280
  store i64 %t278, ptr %t6
  br label %L50
L50:
  %t281 = load ptr, ptr %t6
  %t282 = load i64, ptr %t281
  %t283 = load ptr, ptr %t6
  %t284 = load i64, ptr %t283
  %t286 = sext i32 42 to i64
  %t285 = icmp eq i64 %t284, %t286
  %t287 = zext i1 %t285 to i64
  %t288 = load ptr, ptr %t6
  %t290 = ptrtoint ptr %t288 to i64
  %t291 = sext i32 1 to i64
  %t292 = inttoptr i64 %t290 to ptr
  %t289 = getelementptr i8, ptr %t292, i64 %t291
  %t293 = load i64, ptr %t289
  %t295 = sext i32 47 to i64
  %t294 = icmp eq i64 %t293, %t295
  %t296 = zext i1 %t294 to i64
  %t298 = icmp ne i64 %t287, 0
  %t299 = icmp ne i64 %t296, 0
  %t300 = and i1 %t298, %t299
  %t301 = zext i1 %t300 to i64
  %t303 = icmp eq i64 %t301, 0
  %t302 = zext i1 %t303 to i64
  %t305 = icmp ne i64 %t282, 0
  %t306 = icmp ne i64 %t302, 0
  %t307 = and i1 %t305, %t306
  %t308 = zext i1 %t307 to i64
  %t309 = icmp ne i64 %t308, 0
  br i1 %t309, label %L51, label %L52
L51:
  %t310 = load ptr, ptr %t6
  %t311 = load i64, ptr %t310
  %t313 = sext i32 10 to i64
  %t312 = icmp eq i64 %t311, %t313
  %t314 = zext i1 %t312 to i64
  %t315 = icmp ne i64 %t314, 0
  br i1 %t315, label %L53, label %L55
L53:
  call void @buf_putc(ptr %t34, i64 32)
  br label %L55
L55:
  %t317 = load ptr, ptr %t6
  %t319 = ptrtoint ptr %t317 to i64
  %t318 = add i64 %t319, 1
  store i64 %t318, ptr %t6
  br label %L50
L52:
  %t320 = load ptr, ptr %t6
  %t321 = load i64, ptr %t320
  %t322 = icmp ne i64 %t321, 0
  br i1 %t322, label %L56, label %L58
L56:
  %t323 = load ptr, ptr %t6
  %t325 = ptrtoint ptr %t323 to i64
  %t326 = sext i32 2 to i64
  %t324 = add i64 %t325, %t326
  store i64 %t324, ptr %t6
  br label %L58
L58:
  br label %L7
L59:
  br label %L49
L49:
  %t327 = load ptr, ptr %t6
  %t329 = ptrtoint ptr %t327 to i64
  %t328 = add i64 %t329, 1
  store i64 %t328, ptr %t6
  %t330 = load i64, ptr %t327
  call void @buf_putc(ptr %t34, i64 %t330)
  br label %L7
L9:
  %t332 = alloca ptr
  %t333 = load ptr, ptr %t34
  store ptr %t333, ptr %t332
  %t334 = load ptr, ptr %t6
  %t335 = load i64, ptr %t334
  %t337 = sext i32 10 to i64
  %t336 = icmp eq i64 %t335, %t337
  %t338 = zext i1 %t336 to i64
  %t339 = icmp ne i64 %t338, 0
  br i1 %t339, label %L60, label %L62
L60:
  %t340 = load ptr, ptr %t6
  %t342 = ptrtoint ptr %t340 to i64
  %t341 = add i64 %t342, 1
  store i64 %t341, ptr %t6
  br label %L62
L62:
  %t343 = alloca ptr
  %t344 = load ptr, ptr %t332
  %t345 = call ptr @skip_ws(ptr %t344)
  store ptr %t345, ptr %t343
  %t346 = load ptr, ptr %t343
  %t347 = load i64, ptr %t346
  %t349 = sext i32 35 to i64
  %t348 = icmp eq i64 %t347, %t349
  %t350 = zext i1 %t348 to i64
  %t351 = icmp ne i64 %t350, 0
  br i1 %t351, label %L63, label %L64
L63:
  %t352 = load ptr, ptr %t343
  call void @process_directive(ptr %t352, ptr %t1, ptr %t2, i64 %t3, ptr %t4, ptr %t5)
  br label %L65
L64:
  %t354 = alloca i64
  %t355 = sext i32 1 to i64
  store i64 %t355, ptr %t354
  %t356 = alloca i64
  %t357 = sext i32 0 to i64
  store i64 %t357, ptr %t356
  br label %L66
L66:
  %t358 = load i64, ptr %t356
  %t359 = load i64, ptr %t5
  %t360 = icmp slt i64 %t358, %t359
  %t361 = zext i1 %t360 to i64
  %t362 = icmp ne i64 %t361, 0
  br i1 %t362, label %L67, label %L69
L67:
  %t363 = load i64, ptr %t356
  %t364 = getelementptr i32, ptr %t4, i64 %t363
  %t365 = load i64, ptr %t364
  %t367 = icmp eq i64 %t365, 0
  %t366 = zext i1 %t367 to i64
  %t368 = icmp ne i64 %t366, 0
  br i1 %t368, label %L70, label %L72
L70:
  %t369 = sext i32 0 to i64
  store i64 %t369, ptr %t354
  br label %L69
L73:
  br label %L72
L72:
  br label %L68
L68:
  %t370 = load i64, ptr %t356
  %t371 = add i64 %t370, 1
  store i64 %t371, ptr %t356
  br label %L66
L69:
  %t372 = load i64, ptr %t354
  %t373 = icmp ne i64 %t372, 0
  br i1 %t373, label %L74, label %L75
L74:
  %t374 = load ptr, ptr %t332
  call void @expand_text(ptr %t374, ptr %t2, i64 0)
  call void @buf_putc(ptr %t2, i64 10)
  br label %L76
L75:
  call void @buf_putc(ptr %t2, i64 10)
  br label %L76
L76:
  br label %L65
L65:
  %t378 = load ptr, ptr %t332
  call void @free(ptr %t378)
  br label %L0
L2:
  ret void
}

define dso_local ptr @macro_preprocess(ptr %t0, ptr %t1, i64 %t2) {
entry:
  %t3 = alloca i64
  call void @buf_init(ptr %t3)
  %t5 = alloca ptr
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  %t10 = sext i32 0 to i64
  %t9 = icmp eq i64 %t2, %t10
  %t11 = zext i1 %t9 to i64
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L0, label %L2
L0:
  %t13 = getelementptr [8 x i8], ptr @.str19, i64 0, i64 0
  %t14 = getelementptr [2 x i8], ptr @.str20, i64 0, i64 0
  %t16 = sext i32 0 to i64
  %t15 = inttoptr i64 %t16 to ptr
  call void @macro_define(ptr %t13, ptr %t14, ptr %t15, i64 0, i64 0)
  %t18 = getelementptr [9 x i8], ptr @.str21, i64 0, i64 0
  %t19 = getelementptr [2 x i8], ptr @.str22, i64 0, i64 0
  %t21 = sext i32 0 to i64
  %t20 = inttoptr i64 %t21 to ptr
  call void @macro_define(ptr %t18, ptr %t19, ptr %t20, i64 0, i64 0)
  %t23 = getelementptr [5 x i8], ptr @.str23, i64 0, i64 0
  %t24 = getelementptr [11 x i8], ptr @.str24, i64 0, i64 0
  %t26 = sext i32 0 to i64
  %t25 = inttoptr i64 %t26 to ptr
  call void @macro_define(ptr %t23, ptr %t24, ptr %t25, i64 0, i64 0)
  %t28 = getelementptr [9 x i8], ptr @.str25, i64 0, i64 0
  %t29 = getelementptr [2 x i8], ptr @.str26, i64 0, i64 0
  %t31 = sext i32 0 to i64
  %t30 = inttoptr i64 %t31 to ptr
  call void @macro_define(ptr %t28, ptr %t29, ptr %t30, i64 0, i64 0)
  %t33 = getelementptr [9 x i8], ptr @.str27, i64 0, i64 0
  %t34 = getelementptr [2 x i8], ptr @.str28, i64 0, i64 0
  %t36 = sext i32 0 to i64
  %t35 = inttoptr i64 %t36 to ptr
  call void @macro_define(ptr %t33, ptr %t34, ptr %t35, i64 0, i64 0)
  %t38 = getelementptr [9 x i8], ptr @.str29, i64 0, i64 0
  %t39 = getelementptr [2 x i8], ptr @.str30, i64 0, i64 0
  %t41 = sext i32 0 to i64
  %t40 = inttoptr i64 %t41 to ptr
  call void @macro_define(ptr %t38, ptr %t39, ptr %t40, i64 0, i64 0)
  %t43 = getelementptr [9 x i8], ptr @.str31, i64 0, i64 0
  %t44 = getelementptr [2 x i8], ptr @.str32, i64 0, i64 0
  %t46 = sext i32 0 to i64
  %t45 = inttoptr i64 %t46 to ptr
  call void @macro_define(ptr %t43, ptr %t44, ptr %t45, i64 0, i64 0)
  %t48 = getelementptr [4 x i8], ptr @.str33, i64 0, i64 0
  %t49 = getelementptr [5 x i8], ptr @.str34, i64 0, i64 0
  %t51 = sext i32 0 to i64
  %t50 = inttoptr i64 %t51 to ptr
  call void @macro_define(ptr %t48, ptr %t49, ptr %t50, i64 0, i64 0)
  %t53 = getelementptr [13 x i8], ptr @.str35, i64 0, i64 0
  %t54 = getelementptr [2 x i8], ptr @.str36, i64 0, i64 0
  %t56 = sext i32 0 to i64
  %t55 = inttoptr i64 %t56 to ptr
  call void @macro_define(ptr %t53, ptr %t54, ptr %t55, i64 0, i64 0)
  %t58 = getelementptr [13 x i8], ptr @.str37, i64 0, i64 0
  %t59 = getelementptr [2 x i8], ptr @.str38, i64 0, i64 0
  %t61 = sext i32 0 to i64
  %t60 = inttoptr i64 %t61 to ptr
  call void @macro_define(ptr %t58, ptr %t59, ptr %t60, i64 0, i64 0)
  %t63 = getelementptr [7 x i8], ptr @.str39, i64 0, i64 0
  %t64 = getelementptr [10 x i8], ptr @.str40, i64 0, i64 0
  %t66 = sext i32 0 to i64
  %t65 = inttoptr i64 %t66 to ptr
  call void @macro_define(ptr %t63, ptr %t64, ptr %t65, i64 0, i64 0)
  %t68 = getelementptr [9 x i8], ptr @.str41, i64 0, i64 0
  %t69 = getelementptr [15 x i8], ptr @.str42, i64 0, i64 0
  %t71 = sext i32 0 to i64
  %t70 = inttoptr i64 %t71 to ptr
  call void @macro_define(ptr %t68, ptr %t69, ptr %t70, i64 0, i64 0)
  %t73 = getelementptr [7 x i8], ptr @.str43, i64 0, i64 0
  %t74 = getelementptr [13 x i8], ptr @.str44, i64 0, i64 0
  %t76 = sext i32 0 to i64
  %t75 = inttoptr i64 %t76 to ptr
  call void @macro_define(ptr %t73, ptr %t74, ptr %t75, i64 0, i64 0)
  %t78 = getelementptr [8 x i8], ptr @.str45, i64 0, i64 0
  %t79 = getelementptr [14 x i8], ptr @.str46, i64 0, i64 0
  %t81 = sext i32 0 to i64
  %t80 = inttoptr i64 %t81 to ptr
  call void @macro_define(ptr %t78, ptr %t79, ptr %t80, i64 0, i64 0)
  %t83 = getelementptr [7 x i8], ptr @.str47, i64 0, i64 0
  %t84 = getelementptr [15 x i8], ptr @.str48, i64 0, i64 0
  %t86 = sext i32 0 to i64
  %t85 = inttoptr i64 %t86 to ptr
  call void @macro_define(ptr %t83, ptr %t84, ptr %t85, i64 0, i64 0)
  %t88 = getelementptr [7 x i8], ptr @.str49, i64 0, i64 0
  %t89 = getelementptr [15 x i8], ptr @.str50, i64 0, i64 0
  %t91 = sext i32 0 to i64
  %t90 = inttoptr i64 %t91 to ptr
  call void @macro_define(ptr %t88, ptr %t89, ptr %t90, i64 0, i64 0)
  %t93 = getelementptr [6 x i8], ptr @.str51, i64 0, i64 0
  %t94 = getelementptr [14 x i8], ptr @.str52, i64 0, i64 0
  %t96 = sext i32 0 to i64
  %t95 = inttoptr i64 %t96 to ptr
  call void @macro_define(ptr %t93, ptr %t94, ptr %t95, i64 0, i64 0)
  br label %L2
L2:
  %t98 = load ptr, ptr %t5
  call void @preprocess_into(ptr %t0, ptr %t1, ptr %t3, i64 %t2, ptr %t98, ptr %t7)
  %t100 = load ptr, ptr %t3
  ret ptr %t100
L3:
  ret ptr null
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
@.str27 = private unnamed_addr constant [9 x i8] c"SEEK_SET\00"
@.str28 = private unnamed_addr constant [2 x i8] c"0\00"
@.str29 = private unnamed_addr constant [9 x i8] c"SEEK_CUR\00"
@.str30 = private unnamed_addr constant [2 x i8] c"1\00"
@.str31 = private unnamed_addr constant [9 x i8] c"SEEK_END\00"
@.str32 = private unnamed_addr constant [2 x i8] c"2\00"
@.str33 = private unnamed_addr constant [4 x i8] c"EOF\00"
@.str34 = private unnamed_addr constant [5 x i8] c"(-1)\00"
@.str35 = private unnamed_addr constant [13 x i8] c"EXIT_SUCCESS\00"
@.str36 = private unnamed_addr constant [2 x i8] c"0\00"
@.str37 = private unnamed_addr constant [13 x i8] c"EXIT_FAILURE\00"
@.str38 = private unnamed_addr constant [2 x i8] c"1\00"
@.str39 = private unnamed_addr constant [7 x i8] c"assert\00"
@.str40 = private unnamed_addr constant [10 x i8] c"((void)0)\00"
@.str41 = private unnamed_addr constant [9 x i8] c"va_start\00"
@.str42 = private unnamed_addr constant [15 x i8] c"__c0c_va_start\00"
@.str43 = private unnamed_addr constant [7 x i8] c"va_end\00"
@.str44 = private unnamed_addr constant [13 x i8] c"__c0c_va_end\00"
@.str45 = private unnamed_addr constant [8 x i8] c"va_copy\00"
@.str46 = private unnamed_addr constant [14 x i8] c"__c0c_va_copy\00"
@.str47 = private unnamed_addr constant [7 x i8] c"stderr\00"
@.str48 = private unnamed_addr constant [15 x i8] c"__c0c_stderr()\00"
@.str49 = private unnamed_addr constant [7 x i8] c"stdout\00"
@.str50 = private unnamed_addr constant [15 x i8] c"__c0c_stdout()\00"
@.str51 = private unnamed_addr constant [6 x i8] c"stdin\00"
@.str52 = private unnamed_addr constant [14 x i8] c"__c0c_stdin()\00"
