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
declare ptr @__c0c_get_tbuf(i32)
declare void @__c0c_emit(ptr, ptr, ...)

@macro_names = internal global ptr zeroinitializer
@macro_bodies = internal global ptr zeroinitializer
@macro_params_0 = internal global ptr zeroinitializer
@macro_params_1 = internal global ptr zeroinitializer
@macro_params_2 = internal global ptr zeroinitializer
@macro_params_3 = internal global ptr zeroinitializer
@macro_params_4 = internal global ptr zeroinitializer
@macro_params_5 = internal global ptr zeroinitializer
@macro_params_6 = internal global ptr zeroinitializer
@macro_params_7 = internal global ptr zeroinitializer
@macro_nparams = internal global ptr zeroinitializer
@macro_funclike = internal global ptr zeroinitializer
@macro_defined = internal global ptr zeroinitializer
@n_macros = internal global i32 zeroinitializer

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
  %t11 = getelementptr ptr, ptr %t10, i64 %t12
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
  %t17 = getelementptr ptr, ptr %t15, i64 %t18
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
  %t7 = getelementptr ptr, ptr %t3, i64 %t8
  store i64 %t1, ptr %t7
  %t9 = load ptr, ptr %t0
  %t10 = load ptr, ptr %t0
  %t12 = ptrtoint ptr %t10 to i64
  %t11 = getelementptr ptr, ptr %t9, i64 %t12
  %t13 = sext i32 0 to i64
  store i64 %t13, ptr %t11
  ret void
}

define internal void @macros_init() {
entry:
  %t0 = load ptr, ptr @macro_names
  %t1 = icmp ne ptr %t0, null
  br i1 %t1, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %t2 = call ptr @calloc(i64 512, i64 8)
  store ptr %t2, ptr @macro_names
  %t3 = call ptr @calloc(i64 512, i64 8)
  store ptr %t3, ptr @macro_bodies
  %t4 = call ptr @calloc(i64 512, i64 8)
  store ptr %t4, ptr @macro_params_0
  %t5 = call ptr @calloc(i64 512, i64 8)
  store ptr %t5, ptr @macro_params_1
  %t6 = call ptr @calloc(i64 512, i64 8)
  store ptr %t6, ptr @macro_params_2
  %t7 = call ptr @calloc(i64 512, i64 8)
  store ptr %t7, ptr @macro_params_3
  %t8 = call ptr @calloc(i64 512, i64 8)
  store ptr %t8, ptr @macro_params_4
  %t9 = call ptr @calloc(i64 512, i64 8)
  store ptr %t9, ptr @macro_params_5
  %t10 = call ptr @calloc(i64 512, i64 8)
  store ptr %t10, ptr @macro_params_6
  %t11 = call ptr @calloc(i64 512, i64 8)
  store ptr %t11, ptr @macro_params_7
  %t12 = call ptr @calloc(i64 512, i64 4)
  store ptr %t12, ptr @macro_nparams
  %t13 = call ptr @calloc(i64 512, i64 4)
  store ptr %t13, ptr @macro_funclike
  %t14 = call ptr @calloc(i64 512, i64 4)
  store ptr %t14, ptr @macro_defined
  ret void
}

define internal ptr @macro_get_param(i64 %t0, i64 %t1) {
entry:
  %t3 = sext i32 0 to i64
  %t2 = icmp eq i64 %t1, %t3
  %t4 = zext i1 %t2 to i64
  %t5 = icmp ne i64 %t4, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = load ptr, ptr @macro_params_0
  %t7 = getelementptr ptr, ptr %t6, i64 %t0
  %t8 = load ptr, ptr %t7
  ret ptr %t8
L3:
  br label %L2
L2:
  %t10 = sext i32 1 to i64
  %t9 = icmp eq i64 %t1, %t10
  %t11 = zext i1 %t9 to i64
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L4, label %L6
L4:
  %t13 = load ptr, ptr @macro_params_1
  %t14 = getelementptr ptr, ptr %t13, i64 %t0
  %t15 = load ptr, ptr %t14
  ret ptr %t15
L7:
  br label %L6
L6:
  %t17 = sext i32 2 to i64
  %t16 = icmp eq i64 %t1, %t17
  %t18 = zext i1 %t16 to i64
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L8, label %L10
L8:
  %t20 = load ptr, ptr @macro_params_2
  %t21 = getelementptr ptr, ptr %t20, i64 %t0
  %t22 = load ptr, ptr %t21
  ret ptr %t22
L11:
  br label %L10
L10:
  %t24 = sext i32 3 to i64
  %t23 = icmp eq i64 %t1, %t24
  %t25 = zext i1 %t23 to i64
  %t26 = icmp ne i64 %t25, 0
  br i1 %t26, label %L12, label %L14
L12:
  %t27 = load ptr, ptr @macro_params_3
  %t28 = getelementptr ptr, ptr %t27, i64 %t0
  %t29 = load ptr, ptr %t28
  ret ptr %t29
L15:
  br label %L14
L14:
  %t31 = sext i32 4 to i64
  %t30 = icmp eq i64 %t1, %t31
  %t32 = zext i1 %t30 to i64
  %t33 = icmp ne i64 %t32, 0
  br i1 %t33, label %L16, label %L18
L16:
  %t34 = load ptr, ptr @macro_params_4
  %t35 = getelementptr ptr, ptr %t34, i64 %t0
  %t36 = load ptr, ptr %t35
  ret ptr %t36
L19:
  br label %L18
L18:
  %t38 = sext i32 5 to i64
  %t37 = icmp eq i64 %t1, %t38
  %t39 = zext i1 %t37 to i64
  %t40 = icmp ne i64 %t39, 0
  br i1 %t40, label %L20, label %L22
L20:
  %t41 = load ptr, ptr @macro_params_5
  %t42 = getelementptr ptr, ptr %t41, i64 %t0
  %t43 = load ptr, ptr %t42
  ret ptr %t43
L23:
  br label %L22
L22:
  %t45 = sext i32 6 to i64
  %t44 = icmp eq i64 %t1, %t45
  %t46 = zext i1 %t44 to i64
  %t47 = icmp ne i64 %t46, 0
  br i1 %t47, label %L24, label %L26
L24:
  %t48 = load ptr, ptr @macro_params_6
  %t49 = getelementptr ptr, ptr %t48, i64 %t0
  %t50 = load ptr, ptr %t49
  ret ptr %t50
L27:
  br label %L26
L26:
  %t52 = sext i32 7 to i64
  %t51 = icmp eq i64 %t1, %t52
  %t53 = zext i1 %t51 to i64
  %t54 = icmp ne i64 %t53, 0
  br i1 %t54, label %L28, label %L30
L28:
  %t55 = load ptr, ptr @macro_params_7
  %t56 = getelementptr ptr, ptr %t55, i64 %t0
  %t57 = load ptr, ptr %t56
  ret ptr %t57
L31:
  br label %L30
L30:
  %t59 = sext i32 0 to i64
  %t58 = inttoptr i64 %t59 to ptr
  ret ptr %t58
L32:
  ret ptr null
}

define internal void @macro_set_param(i64 %t0, i64 %t1, ptr %t2) {
entry:
  %t4 = sext i32 0 to i64
  %t3 = icmp eq i64 %t1, %t4
  %t5 = zext i1 %t3 to i64
  %t6 = icmp ne i64 %t5, 0
  br i1 %t6, label %L0, label %L1
L0:
  %t7 = load ptr, ptr @macro_params_0
  %t8 = getelementptr ptr, ptr %t7, i64 %t0
  store ptr %t2, ptr %t8
  br label %L2
L1:
  %t10 = sext i32 1 to i64
  %t9 = icmp eq i64 %t1, %t10
  %t11 = zext i1 %t9 to i64
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L3, label %L4
L3:
  %t13 = load ptr, ptr @macro_params_1
  %t14 = getelementptr ptr, ptr %t13, i64 %t0
  store ptr %t2, ptr %t14
  br label %L5
L4:
  %t16 = sext i32 2 to i64
  %t15 = icmp eq i64 %t1, %t16
  %t17 = zext i1 %t15 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L6, label %L7
L6:
  %t19 = load ptr, ptr @macro_params_2
  %t20 = getelementptr ptr, ptr %t19, i64 %t0
  store ptr %t2, ptr %t20
  br label %L8
L7:
  %t22 = sext i32 3 to i64
  %t21 = icmp eq i64 %t1, %t22
  %t23 = zext i1 %t21 to i64
  %t24 = icmp ne i64 %t23, 0
  br i1 %t24, label %L9, label %L10
L9:
  %t25 = load ptr, ptr @macro_params_3
  %t26 = getelementptr ptr, ptr %t25, i64 %t0
  store ptr %t2, ptr %t26
  br label %L11
L10:
  %t28 = sext i32 4 to i64
  %t27 = icmp eq i64 %t1, %t28
  %t29 = zext i1 %t27 to i64
  %t30 = icmp ne i64 %t29, 0
  br i1 %t30, label %L12, label %L13
L12:
  %t31 = load ptr, ptr @macro_params_4
  %t32 = getelementptr ptr, ptr %t31, i64 %t0
  store ptr %t2, ptr %t32
  br label %L14
L13:
  %t34 = sext i32 5 to i64
  %t33 = icmp eq i64 %t1, %t34
  %t35 = zext i1 %t33 to i64
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L15, label %L16
L15:
  %t37 = load ptr, ptr @macro_params_5
  %t38 = getelementptr ptr, ptr %t37, i64 %t0
  store ptr %t2, ptr %t38
  br label %L17
L16:
  %t40 = sext i32 6 to i64
  %t39 = icmp eq i64 %t1, %t40
  %t41 = zext i1 %t39 to i64
  %t42 = icmp ne i64 %t41, 0
  br i1 %t42, label %L18, label %L19
L18:
  %t43 = load ptr, ptr @macro_params_6
  %t44 = getelementptr ptr, ptr %t43, i64 %t0
  store ptr %t2, ptr %t44
  br label %L20
L19:
  %t46 = sext i32 7 to i64
  %t45 = icmp eq i64 %t1, %t46
  %t47 = zext i1 %t45 to i64
  %t48 = icmp ne i64 %t47, 0
  br i1 %t48, label %L21, label %L23
L21:
  %t49 = load ptr, ptr @macro_params_7
  %t50 = getelementptr ptr, ptr %t49, i64 %t0
  store ptr %t2, ptr %t50
  br label %L23
L23:
  br label %L20
L20:
  br label %L17
L17:
  br label %L14
L14:
  br label %L11
L11:
  br label %L8
L8:
  br label %L5
L5:
  br label %L2
L2:
  ret void
}

define internal i32 @macro_find_idx(ptr %t0) {
entry:
  %t1 = load ptr, ptr @macro_names
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = icmp eq i64 %t3, 0
  %t2 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t2, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t7 = sext i32 1 to i64
  %t6 = sub i64 0, %t7
  %t8 = trunc i64 %t6 to i32
  ret i32 %t8
L3:
  br label %L2
L2:
  %t9 = alloca i64
  %t10 = sext i32 0 to i64
  store i64 %t10, ptr %t9
  br label %L4
L4:
  %t11 = load i64, ptr %t9
  %t12 = load i64, ptr @n_macros
  %t13 = icmp slt i64 %t11, %t12
  %t14 = zext i1 %t13 to i64
  %t15 = icmp ne i64 %t14, 0
  br i1 %t15, label %L5, label %L7
L5:
  %t16 = load ptr, ptr @macro_defined
  %t17 = load i64, ptr %t9
  %t18 = getelementptr ptr, ptr %t16, i64 %t17
  %t19 = load ptr, ptr %t18
  %t20 = ptrtoint ptr %t19 to i64
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L8, label %L9
L8:
  %t22 = load ptr, ptr @macro_names
  %t23 = load i64, ptr %t9
  %t24 = getelementptr ptr, ptr %t22, i64 %t23
  %t25 = load ptr, ptr %t24
  %t26 = ptrtoint ptr %t25 to i64
  %t27 = icmp ne i64 %t26, 0
  %t28 = zext i1 %t27 to i64
  br label %L10
L9:
  br label %L10
L10:
  %t29 = phi i64 [ %t28, %L8 ], [ 0, %L9 ]
  %t30 = icmp ne i64 %t29, 0
  br i1 %t30, label %L11, label %L12
L11:
  %t31 = load ptr, ptr @macro_names
  %t32 = load i64, ptr %t9
  %t33 = getelementptr ptr, ptr %t31, i64 %t32
  %t34 = load ptr, ptr %t33
  %t35 = call i32 @strcmp(ptr %t34, ptr %t0)
  %t36 = sext i32 %t35 to i64
  %t38 = sext i32 0 to i64
  %t37 = icmp eq i64 %t36, %t38
  %t39 = zext i1 %t37 to i64
  %t40 = icmp ne i64 %t39, 0
  %t41 = zext i1 %t40 to i64
  br label %L13
L12:
  br label %L13
L13:
  %t42 = phi i64 [ %t41, %L11 ], [ 0, %L12 ]
  %t43 = icmp ne i64 %t42, 0
  br i1 %t43, label %L14, label %L16
L14:
  %t44 = load i64, ptr %t9
  %t45 = trunc i64 %t44 to i32
  ret i32 %t45
L17:
  br label %L16
L16:
  br label %L6
L6:
  %t46 = load i64, ptr %t9
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t9
  br label %L4
L7:
  %t49 = sext i32 1 to i64
  %t48 = sub i64 0, %t49
  %t50 = trunc i64 %t48 to i32
  ret i32 %t50
L18:
  ret i32 0
}

define internal ptr @macro_find_body(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = call i32 @macro_find_idx(ptr %t0)
  %t3 = sext i32 %t2 to i64
  store i64 %t3, ptr %t1
  %t4 = load i64, ptr %t1
  %t6 = sext i32 0 to i64
  %t5 = icmp sge i64 %t4, %t6
  %t7 = zext i1 %t5 to i64
  %t8 = icmp ne i64 %t7, 0
  br i1 %t8, label %L0, label %L1
L0:
  %t9 = load ptr, ptr @macro_bodies
  %t10 = load i64, ptr %t1
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t13 = ptrtoint ptr %t12 to i64
  br label %L2
L1:
  %t15 = sext i32 0 to i64
  %t14 = inttoptr i64 %t15 to ptr
  %t16 = ptrtoint ptr %t14 to i64
  br label %L2
L2:
  %t17 = phi i64 [ %t13, %L0 ], [ %t16, %L1 ]
  %t18 = inttoptr i64 %t17 to ptr
  ret ptr %t18
L3:
  ret ptr null
}

define internal void @macro_define(ptr %t0, ptr %t1, ptr %t2, i64 %t3, i64 %t4) {
entry:
  %t5 = load ptr, ptr @macro_names
  %t7 = ptrtoint ptr %t5 to i64
  %t8 = icmp eq i64 %t7, 0
  %t6 = zext i1 %t8 to i64
  %t9 = icmp ne i64 %t6, 0
  br i1 %t9, label %L0, label %L2
L0:
  call void @macros_init()
  br label %L2
L2:
  %t11 = alloca i64
  %t12 = call i32 @macro_find_idx(ptr %t0)
  %t13 = sext i32 %t12 to i64
  store i64 %t13, ptr %t11
  %t14 = load i64, ptr %t11
  %t16 = sext i32 0 to i64
  %t15 = icmp slt i64 %t14, %t16
  %t17 = zext i1 %t15 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L3, label %L5
L3:
  %t19 = alloca i64
  %t20 = sext i32 0 to i64
  store i64 %t20, ptr %t19
  br label %L6
L6:
  %t21 = load i64, ptr %t19
  %t22 = load i64, ptr @n_macros
  %t23 = icmp slt i64 %t21, %t22
  %t24 = zext i1 %t23 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L7, label %L9
L7:
  %t26 = load ptr, ptr @macro_names
  %t27 = load i64, ptr %t19
  %t28 = getelementptr ptr, ptr %t26, i64 %t27
  %t29 = load ptr, ptr %t28
  %t30 = ptrtoint ptr %t29 to i64
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L10, label %L11
L10:
  %t32 = load ptr, ptr @macro_names
  %t33 = load i64, ptr %t19
  %t34 = getelementptr ptr, ptr %t32, i64 %t33
  %t35 = load ptr, ptr %t34
  %t36 = call i32 @strcmp(ptr %t35, ptr %t0)
  %t37 = sext i32 %t36 to i64
  %t39 = sext i32 0 to i64
  %t38 = icmp eq i64 %t37, %t39
  %t40 = zext i1 %t38 to i64
  %t41 = icmp ne i64 %t40, 0
  %t42 = zext i1 %t41 to i64
  br label %L12
L11:
  br label %L12
L12:
  %t43 = phi i64 [ %t42, %L10 ], [ 0, %L11 ]
  %t44 = icmp ne i64 %t43, 0
  br i1 %t44, label %L13, label %L15
L13:
  %t45 = load i64, ptr %t19
  store i64 %t45, ptr %t11
  br label %L9
L16:
  br label %L15
L15:
  br label %L8
L8:
  %t46 = load i64, ptr %t19
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t19
  br label %L6
L9:
  br label %L5
L5:
  %t48 = load i64, ptr %t11
  %t50 = sext i32 0 to i64
  %t49 = icmp sge i64 %t48, %t50
  %t51 = zext i1 %t49 to i64
  %t52 = icmp ne i64 %t51, 0
  br i1 %t52, label %L17, label %L19
L17:
  %t53 = load ptr, ptr @macro_bodies
  %t54 = load i64, ptr %t11
  %t55 = getelementptr ptr, ptr %t53, i64 %t54
  %t56 = load ptr, ptr %t55
  call void @free(ptr %t56)
  %t58 = call ptr @strdup(ptr %t1)
  %t59 = load ptr, ptr @macro_bodies
  %t60 = load i64, ptr %t11
  %t61 = getelementptr ptr, ptr %t59, i64 %t60
  store ptr %t58, ptr %t61
  %t62 = load ptr, ptr @macro_defined
  %t63 = load i64, ptr %t11
  %t64 = getelementptr ptr, ptr %t62, i64 %t63
  %t65 = sext i32 1 to i64
  store i64 %t65, ptr %t64
  ret void
L20:
  br label %L19
L19:
  %t66 = load i64, ptr @n_macros
  %t68 = sext i32 512 to i64
  %t67 = icmp sge i64 %t66, %t68
  %t69 = zext i1 %t67 to i64
  %t70 = icmp ne i64 %t69, 0
  br i1 %t70, label %L21, label %L23
L21:
  %t71 = call ptr @__c0c_stderr()
  %t72 = getelementptr [18 x i8], ptr @.str2, i64 0, i64 0
  %t73 = call i32 @fprintf(ptr %t71, ptr %t72)
  %t74 = sext i32 %t73 to i64
  ret void
L24:
  br label %L23
L23:
  %t75 = load i64, ptr @n_macros
  %t76 = add i64 %t75, 1
  store i64 %t76, ptr @n_macros
  store i64 %t75, ptr %t11
  %t77 = call ptr @strdup(ptr %t0)
  %t78 = load ptr, ptr @macro_names
  %t79 = load i64, ptr %t11
  %t80 = getelementptr ptr, ptr %t78, i64 %t79
  store ptr %t77, ptr %t80
  %t81 = call ptr @strdup(ptr %t1)
  %t82 = load ptr, ptr @macro_bodies
  %t83 = load i64, ptr %t11
  %t84 = getelementptr ptr, ptr %t82, i64 %t83
  store ptr %t81, ptr %t84
  %t85 = load ptr, ptr @macro_nparams
  %t86 = load i64, ptr %t11
  %t87 = getelementptr ptr, ptr %t85, i64 %t86
  store i64 %t3, ptr %t87
  %t88 = load ptr, ptr @macro_funclike
  %t89 = load i64, ptr %t11
  %t90 = getelementptr ptr, ptr %t88, i64 %t89
  store i64 %t4, ptr %t90
  %t91 = load ptr, ptr @macro_defined
  %t92 = load i64, ptr %t11
  %t93 = getelementptr ptr, ptr %t91, i64 %t92
  %t94 = sext i32 1 to i64
  store i64 %t94, ptr %t93
  %t95 = alloca i64
  %t96 = sext i32 0 to i64
  store i64 %t96, ptr %t95
  br label %L25
L25:
  %t97 = load i64, ptr %t95
  %t98 = icmp slt i64 %t97, %t3
  %t99 = zext i1 %t98 to i64
  %t100 = icmp ne i64 %t99, 0
  br i1 %t100, label %L29, label %L30
L29:
  %t101 = load i64, ptr %t95
  %t103 = sext i32 16 to i64
  %t102 = icmp slt i64 %t101, %t103
  %t104 = zext i1 %t102 to i64
  %t105 = icmp ne i64 %t104, 0
  %t106 = zext i1 %t105 to i64
  br label %L31
L30:
  br label %L31
L31:
  %t107 = phi i64 [ %t106, %L29 ], [ 0, %L30 ]
  %t108 = icmp ne i64 %t107, 0
  br i1 %t108, label %L26, label %L28
L26:
  %t109 = load i64, ptr %t11
  %t110 = load i64, ptr %t95
  %t111 = load i64, ptr %t95
  %t112 = getelementptr ptr, ptr %t2, i64 %t111
  %t113 = load ptr, ptr %t112
  %t114 = icmp ne ptr %t113, null
  br i1 %t114, label %L32, label %L33
L32:
  %t115 = load i64, ptr %t95
  %t116 = getelementptr ptr, ptr %t2, i64 %t115
  %t117 = load ptr, ptr %t116
  %t118 = call ptr @strdup(ptr %t117)
  %t119 = ptrtoint ptr %t118 to i64
  br label %L34
L33:
  %t121 = sext i32 0 to i64
  %t120 = inttoptr i64 %t121 to ptr
  %t122 = ptrtoint ptr %t120 to i64
  br label %L34
L34:
  %t123 = phi i64 [ %t119, %L32 ], [ %t122, %L33 ]
  call void @macro_set_param(i64 %t109, i64 %t110, i64 %t123)
  br label %L27
L27:
  %t125 = load i64, ptr %t95
  %t126 = add i64 %t125, 1
  store i64 %t126, ptr %t95
  br label %L25
L28:
  ret void
}

define internal void @macro_undef(ptr %t0) {
entry:
  %t1 = load ptr, ptr @macro_names
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
  %t6 = alloca i64
  %t7 = call i32 @macro_find_idx(ptr %t0)
  %t8 = sext i32 %t7 to i64
  store i64 %t8, ptr %t6
  %t9 = load i64, ptr %t6
  %t11 = sext i32 0 to i64
  %t10 = icmp sge i64 %t9, %t11
  %t12 = zext i1 %t10 to i64
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L4, label %L6
L4:
  %t14 = load ptr, ptr @macro_defined
  %t15 = load i64, ptr %t6
  %t16 = getelementptr ptr, ptr %t14, i64 %t15
  %t17 = sext i32 0 to i64
  store i64 %t17, ptr %t16
  br label %L6
L6:
  ret void
}

define internal i64 @macro_find_ref(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = sext i32 0 to i64
  store i64 %t2, ptr %t1
  %t3 = alloca i64
  %t4 = call i32 @macro_find_idx(ptr %t0)
  %t5 = sext i32 %t4 to i64
  store i64 %t5, ptr %t3
  %t6 = load i64, ptr %t3
  %t8 = sext i32 0 to i64
  %t7 = icmp sge i64 %t6, %t8
  %t9 = zext i1 %t7 to i64
  %t10 = icmp ne i64 %t9, 0
  br i1 %t10, label %L0, label %L2
L0:
  %t11 = load ptr, ptr @macro_names
  %t12 = load i64, ptr %t3
  %t13 = getelementptr ptr, ptr %t11, i64 %t12
  %t14 = load ptr, ptr %t13
  store ptr %t14, ptr %t1
  %t15 = load ptr, ptr @macro_bodies
  %t16 = load i64, ptr %t3
  %t17 = getelementptr ptr, ptr %t15, i64 %t16
  %t18 = load ptr, ptr %t17
  store ptr %t18, ptr %t1
  %t19 = load ptr, ptr @macro_nparams
  %t20 = load i64, ptr %t3
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  store ptr %t22, ptr %t1
  %t23 = load ptr, ptr @macro_funclike
  %t24 = load i64, ptr %t3
  %t25 = getelementptr ptr, ptr %t23, i64 %t24
  %t26 = load ptr, ptr %t25
  store ptr %t26, ptr %t1
  %t27 = load ptr, ptr @macro_defined
  %t28 = load i64, ptr %t3
  %t29 = getelementptr ptr, ptr %t27, i64 %t28
  %t30 = load ptr, ptr %t29
  store ptr %t30, ptr %t1
  %t31 = load i64, ptr %t3
  store i64 %t31, ptr %t1
  br label %L2
L2:
  %t32 = load i64, ptr %t1
  ret i64 %t32
L3:
  ret i64 0
}

define internal ptr @skip_ws(ptr %t0) {
entry:
  br label %L0
L0:
  %t1 = load i64, ptr %t0
  %t3 = sext i32 32 to i64
  %t2 = icmp eq i64 %t1, %t3
  %t4 = zext i1 %t2 to i64
  %t5 = icmp ne i64 %t4, 0
  br i1 %t5, label %L3, label %L4
L3:
  br label %L5
L4:
  %t6 = load i64, ptr %t0
  %t8 = sext i32 9 to i64
  %t7 = icmp eq i64 %t6, %t8
  %t9 = zext i1 %t7 to i64
  %t10 = icmp ne i64 %t9, 0
  %t11 = zext i1 %t10 to i64
  br label %L5
L5:
  %t12 = phi i64 [ 1, %L3 ], [ %t11, %L4 ]
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L1, label %L2
L1:
  %t15 = ptrtoint ptr %t0 to i64
  %t14 = add i64 %t15, 1
  store i64 %t14, ptr %t0
  br label %L0
L2:
  ret ptr %t0
L6:
  ret ptr null
}

define internal ptr @skip_to_eol(ptr %t0) {
entry:
  br label %L0
L0:
  %t1 = load i64, ptr %t0
  %t2 = icmp ne i64 %t1, 0
  br i1 %t2, label %L3, label %L4
L3:
  %t3 = load i64, ptr %t0
  %t5 = sext i32 10 to i64
  %t4 = icmp ne i64 %t3, %t5
  %t6 = zext i1 %t4 to i64
  %t7 = icmp ne i64 %t6, 0
  %t8 = zext i1 %t7 to i64
  br label %L5
L4:
  br label %L5
L5:
  %t9 = phi i64 [ %t8, %L3 ], [ 0, %L4 ]
  %t10 = icmp ne i64 %t9, 0
  br i1 %t10, label %L1, label %L2
L1:
  %t12 = ptrtoint ptr %t0 to i64
  %t11 = add i64 %t12, 1
  store i64 %t11, ptr %t0
  br label %L0
L2:
  ret ptr %t0
L6:
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
  %t6 = icmp ne i64 %t5, 0
  br i1 %t6, label %L3, label %L4
L3:
  %t7 = load i64, ptr %t0
  %t8 = add i64 %t7, 0
  %t9 = call i32 @isalnum(i64 %t8)
  %t10 = sext i32 %t9 to i64
  %t11 = icmp ne i64 %t10, 0
  br i1 %t11, label %L6, label %L7
L6:
  br label %L8
L7:
  %t12 = load i64, ptr %t0
  %t14 = sext i32 95 to i64
  %t13 = icmp eq i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  %t17 = zext i1 %t16 to i64
  br label %L8
L8:
  %t18 = phi i64 [ 1, %L6 ], [ %t17, %L7 ]
  %t19 = icmp ne i64 %t18, 0
  %t20 = zext i1 %t19 to i64
  br label %L5
L4:
  br label %L5
L5:
  %t21 = phi i64 [ %t20, %L3 ], [ 0, %L4 ]
  %t22 = icmp ne i64 %t21, 0
  br i1 %t22, label %L9, label %L10
L9:
  %t23 = load i64, ptr %t3
  %t25 = ptrtoint ptr %t2 to i64
  %t26 = sext i32 1 to i64
  %t24 = sub i64 %t25, %t26
  %t27 = icmp slt i64 %t23, %t24
  %t28 = zext i1 %t27 to i64
  %t29 = icmp ne i64 %t28, 0
  %t30 = zext i1 %t29 to i64
  br label %L11
L10:
  br label %L11
L11:
  %t31 = phi i64 [ %t30, %L9 ], [ 0, %L10 ]
  %t32 = icmp ne i64 %t31, 0
  br i1 %t32, label %L1, label %L2
L1:
  %t34 = ptrtoint ptr %t0 to i64
  %t33 = add i64 %t34, 1
  store i64 %t33, ptr %t0
  %t35 = load i64, ptr %t0
  %t36 = load i64, ptr %t3
  %t37 = add i64 %t36, 1
  store i64 %t37, ptr %t3
  %t38 = getelementptr ptr, ptr %t1, i64 %t36
  store i64 %t35, ptr %t38
  br label %L0
L2:
  %t39 = load i64, ptr %t3
  %t40 = getelementptr ptr, ptr %t1, i64 %t39
  %t41 = sext i32 0 to i64
  store i64 %t41, ptr %t40
  ret ptr %t0
L12:
  ret ptr null
}

define internal void @expand_func_macro(i64 %t0, ptr %t1, ptr %t2, i64 %t3) {
entry:
  %t4 = alloca ptr
  %t5 = load ptr, ptr @macro_names
  %t6 = getelementptr ptr, ptr %t5, i64 %t0
  %t7 = load ptr, ptr %t6
  store ptr %t7, ptr %t4
  %t8 = alloca ptr
  %t9 = load ptr, ptr @macro_bodies
  %t10 = getelementptr ptr, ptr %t9, i64 %t0
  %t11 = load ptr, ptr %t10
  store ptr %t11, ptr %t8
  %t12 = alloca i64
  %t13 = load ptr, ptr @macro_nparams
  %t14 = getelementptr ptr, ptr %t13, i64 %t0
  %t15 = load ptr, ptr %t14
  store ptr %t15, ptr %t12
  %t16 = alloca i64
  %t17 = load i64, ptr %t12
  %t19 = sext i32 0 to i64
  %t18 = icmp sgt i64 %t17, %t19
  %t20 = zext i1 %t18 to i64
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L0, label %L1
L0:
  %t22 = load i64, ptr %t12
  %t24 = sext i32 1 to i64
  %t23 = sub i64 %t22, %t24
  %t25 = call ptr @macro_get_param(i64 %t0, i64 %t23)
  %t26 = ptrtoint ptr %t25 to i64
  %t27 = icmp ne i64 %t26, 0
  %t28 = zext i1 %t27 to i64
  br label %L2
L1:
  br label %L2
L2:
  %t29 = phi i64 [ %t28, %L0 ], [ 0, %L1 ]
  %t30 = icmp ne i64 %t29, 0
  br i1 %t30, label %L3, label %L4
L3:
  %t31 = load i64, ptr %t12
  %t33 = sext i32 1 to i64
  %t32 = sub i64 %t31, %t33
  %t34 = call ptr @macro_get_param(i64 %t0, i64 %t32)
  %t35 = getelementptr [4 x i8], ptr @.str3, i64 0, i64 0
  %t36 = call i32 @strcmp(ptr %t34, ptr %t35)
  %t37 = sext i32 %t36 to i64
  %t39 = sext i32 0 to i64
  %t38 = icmp eq i64 %t37, %t39
  %t40 = zext i1 %t38 to i64
  %t41 = icmp ne i64 %t40, 0
  %t42 = zext i1 %t41 to i64
  br label %L5
L4:
  br label %L5
L5:
  %t43 = phi i64 [ %t42, %L3 ], [ 0, %L4 ]
  store i64 %t43, ptr %t16
  %t44 = alloca ptr
  %t45 = load i64, ptr %t1
  store i64 %t45, ptr %t44
  %t46 = load ptr, ptr %t44
  %t47 = call ptr @skip_ws(ptr %t46)
  store ptr %t47, ptr %t44
  %t48 = load ptr, ptr %t44
  %t49 = load i64, ptr %t48
  %t51 = sext i32 40 to i64
  %t50 = icmp ne i64 %t49, %t51
  %t52 = zext i1 %t50 to i64
  %t53 = icmp ne i64 %t52, 0
  br i1 %t53, label %L6, label %L8
L6:
  %t54 = load ptr, ptr %t4
  %t55 = load ptr, ptr %t4
  %t56 = call i64 @strlen(ptr %t55)
  call void @buf_append(ptr %t2, ptr %t54, i64 %t56)
  ret void
L9:
  br label %L8
L8:
  %t58 = load ptr, ptr %t44
  %t60 = ptrtoint ptr %t58 to i64
  %t59 = add i64 %t60, 1
  store i64 %t59, ptr %t44
  %t61 = alloca ptr
  %t62 = sext i32 0 to i64
  store i64 %t62, ptr %t61
  %t63 = alloca i64
  %t64 = sext i32 0 to i64
  store i64 %t64, ptr %t63
  %t65 = alloca i64
  %t66 = sext i32 0 to i64
  store i64 %t66, ptr %t65
  %t67 = alloca i64
  call void @buf_init(ptr %t67)
  br label %L10
L10:
  %t69 = load ptr, ptr %t44
  %t70 = load i64, ptr %t69
  %t71 = icmp ne i64 %t70, 0
  br i1 %t71, label %L13, label %L14
L13:
  %t72 = load i64, ptr %t65
  %t74 = sext i32 0 to i64
  %t73 = icmp eq i64 %t72, %t74
  %t75 = zext i1 %t73 to i64
  %t76 = icmp ne i64 %t75, 0
  br i1 %t76, label %L16, label %L17
L16:
  %t77 = load ptr, ptr %t44
  %t78 = load i64, ptr %t77
  %t80 = sext i32 41 to i64
  %t79 = icmp eq i64 %t78, %t80
  %t81 = zext i1 %t79 to i64
  %t82 = icmp ne i64 %t81, 0
  %t83 = zext i1 %t82 to i64
  br label %L18
L17:
  br label %L18
L18:
  %t84 = phi i64 [ %t83, %L16 ], [ 0, %L17 ]
  %t86 = icmp eq i64 %t84, 0
  %t85 = zext i1 %t86 to i64
  %t87 = icmp ne i64 %t85, 0
  %t88 = zext i1 %t87 to i64
  br label %L15
L14:
  br label %L15
L15:
  %t89 = phi i64 [ %t88, %L13 ], [ 0, %L14 ]
  %t90 = icmp ne i64 %t89, 0
  br i1 %t90, label %L11, label %L12
L11:
  %t91 = load ptr, ptr %t44
  %t92 = load i64, ptr %t91
  %t94 = sext i32 44 to i64
  %t93 = icmp eq i64 %t92, %t94
  %t95 = zext i1 %t93 to i64
  %t96 = icmp ne i64 %t95, 0
  br i1 %t96, label %L19, label %L20
L19:
  %t97 = load i64, ptr %t65
  %t99 = sext i32 0 to i64
  %t98 = icmp eq i64 %t97, %t99
  %t100 = zext i1 %t98 to i64
  %t101 = icmp ne i64 %t100, 0
  %t102 = zext i1 %t101 to i64
  br label %L21
L20:
  br label %L21
L21:
  %t103 = phi i64 [ %t102, %L19 ], [ 0, %L20 ]
  %t104 = icmp ne i64 %t103, 0
  br i1 %t104, label %L22, label %L23
L22:
  %t105 = load i64, ptr %t63
  %t107 = sext i32 16 to i64
  %t106 = icmp slt i64 %t105, %t107
  %t108 = zext i1 %t106 to i64
  %t109 = icmp ne i64 %t108, 0
  br i1 %t109, label %L25, label %L27
L25:
  %t110 = load ptr, ptr %t67
  %t111 = call ptr @strdup(ptr %t110)
  %t112 = load ptr, ptr %t61
  %t113 = load i64, ptr %t63
  %t114 = add i64 %t113, 1
  store i64 %t114, ptr %t63
  %t115 = getelementptr ptr, ptr %t112, i64 %t113
  store ptr %t111, ptr %t115
  br label %L27
L27:
  %t116 = sext i32 0 to i64
  store i64 %t116, ptr %t67
  %t117 = load ptr, ptr %t67
  %t119 = sext i32 0 to i64
  %t118 = getelementptr ptr, ptr %t117, i64 %t119
  %t120 = sext i32 0 to i64
  store i64 %t120, ptr %t118
  %t121 = load ptr, ptr %t44
  %t123 = ptrtoint ptr %t121 to i64
  %t122 = add i64 %t123, 1
  store i64 %t122, ptr %t44
  br label %L24
L23:
  %t124 = load ptr, ptr %t44
  %t125 = load i64, ptr %t124
  %t127 = sext i32 34 to i64
  %t126 = icmp eq i64 %t125, %t127
  %t128 = zext i1 %t126 to i64
  %t129 = icmp ne i64 %t128, 0
  br i1 %t129, label %L28, label %L29
L28:
  %t130 = load ptr, ptr %t44
  %t132 = ptrtoint ptr %t130 to i64
  %t131 = add i64 %t132, 1
  store i64 %t131, ptr %t44
  %t133 = load i64, ptr %t130
  call void @buf_putc(ptr %t67, i64 %t133)
  br label %L31
L31:
  %t135 = load ptr, ptr %t44
  %t136 = load i64, ptr %t135
  %t137 = icmp ne i64 %t136, 0
  br i1 %t137, label %L34, label %L35
L34:
  %t138 = load ptr, ptr %t44
  %t139 = load i64, ptr %t138
  %t141 = sext i32 34 to i64
  %t140 = icmp ne i64 %t139, %t141
  %t142 = zext i1 %t140 to i64
  %t143 = icmp ne i64 %t142, 0
  %t144 = zext i1 %t143 to i64
  br label %L36
L35:
  br label %L36
L36:
  %t145 = phi i64 [ %t144, %L34 ], [ 0, %L35 ]
  %t146 = icmp ne i64 %t145, 0
  br i1 %t146, label %L32, label %L33
L32:
  %t147 = load ptr, ptr %t44
  %t148 = load i64, ptr %t147
  %t150 = sext i32 92 to i64
  %t149 = icmp eq i64 %t148, %t150
  %t151 = zext i1 %t149 to i64
  %t152 = icmp ne i64 %t151, 0
  br i1 %t152, label %L37, label %L38
L37:
  %t153 = load ptr, ptr %t44
  %t155 = ptrtoint ptr %t153 to i64
  %t156 = sext i32 1 to i64
  %t157 = inttoptr i64 %t155 to ptr
  %t154 = getelementptr i8, ptr %t157, i64 %t156
  %t158 = load i64, ptr %t154
  %t159 = icmp ne i64 %t158, 0
  %t160 = zext i1 %t159 to i64
  br label %L39
L38:
  br label %L39
L39:
  %t161 = phi i64 [ %t160, %L37 ], [ 0, %L38 ]
  %t162 = icmp ne i64 %t161, 0
  br i1 %t162, label %L40, label %L42
L40:
  %t163 = load ptr, ptr %t44
  %t165 = ptrtoint ptr %t163 to i64
  %t164 = add i64 %t165, 1
  store i64 %t164, ptr %t44
  %t166 = load i64, ptr %t163
  call void @buf_putc(ptr %t67, i64 %t166)
  br label %L42
L42:
  %t168 = load ptr, ptr %t44
  %t170 = ptrtoint ptr %t168 to i64
  %t169 = add i64 %t170, 1
  store i64 %t169, ptr %t44
  %t171 = load i64, ptr %t168
  call void @buf_putc(ptr %t67, i64 %t171)
  br label %L31
L33:
  %t173 = load ptr, ptr %t44
  %t174 = load i64, ptr %t173
  %t175 = icmp ne i64 %t174, 0
  br i1 %t175, label %L43, label %L45
L43:
  %t176 = load ptr, ptr %t44
  %t178 = ptrtoint ptr %t176 to i64
  %t177 = add i64 %t178, 1
  store i64 %t177, ptr %t44
  %t179 = load i64, ptr %t176
  call void @buf_putc(ptr %t67, i64 %t179)
  br label %L45
L45:
  br label %L30
L29:
  %t181 = load ptr, ptr %t44
  %t182 = load i64, ptr %t181
  %t184 = sext i32 39 to i64
  %t183 = icmp eq i64 %t182, %t184
  %t185 = zext i1 %t183 to i64
  %t186 = icmp ne i64 %t185, 0
  br i1 %t186, label %L46, label %L47
L46:
  %t187 = load ptr, ptr %t44
  %t189 = ptrtoint ptr %t187 to i64
  %t188 = add i64 %t189, 1
  store i64 %t188, ptr %t44
  %t190 = load i64, ptr %t187
  call void @buf_putc(ptr %t67, i64 %t190)
  %t192 = load ptr, ptr %t44
  %t193 = load i64, ptr %t192
  %t195 = sext i32 92 to i64
  %t194 = icmp eq i64 %t193, %t195
  %t196 = zext i1 %t194 to i64
  %t197 = icmp ne i64 %t196, 0
  br i1 %t197, label %L49, label %L50
L49:
  %t198 = load ptr, ptr %t44
  %t200 = ptrtoint ptr %t198 to i64
  %t201 = sext i32 1 to i64
  %t202 = inttoptr i64 %t200 to ptr
  %t199 = getelementptr i8, ptr %t202, i64 %t201
  %t203 = load i64, ptr %t199
  %t204 = icmp ne i64 %t203, 0
  %t205 = zext i1 %t204 to i64
  br label %L51
L50:
  br label %L51
L51:
  %t206 = phi i64 [ %t205, %L49 ], [ 0, %L50 ]
  %t207 = icmp ne i64 %t206, 0
  br i1 %t207, label %L52, label %L54
L52:
  %t208 = load ptr, ptr %t44
  %t210 = ptrtoint ptr %t208 to i64
  %t209 = add i64 %t210, 1
  store i64 %t209, ptr %t44
  %t211 = load i64, ptr %t208
  call void @buf_putc(ptr %t67, i64 %t211)
  br label %L54
L54:
  %t213 = load ptr, ptr %t44
  %t214 = load i64, ptr %t213
  %t215 = icmp ne i64 %t214, 0
  br i1 %t215, label %L55, label %L57
L55:
  %t216 = load ptr, ptr %t44
  %t218 = ptrtoint ptr %t216 to i64
  %t217 = add i64 %t218, 1
  store i64 %t217, ptr %t44
  %t219 = load i64, ptr %t216
  call void @buf_putc(ptr %t67, i64 %t219)
  br label %L57
L57:
  %t221 = load ptr, ptr %t44
  %t222 = load i64, ptr %t221
  %t224 = sext i32 39 to i64
  %t223 = icmp eq i64 %t222, %t224
  %t225 = zext i1 %t223 to i64
  %t226 = icmp ne i64 %t225, 0
  br i1 %t226, label %L58, label %L60
L58:
  %t227 = load ptr, ptr %t44
  %t229 = ptrtoint ptr %t227 to i64
  %t228 = add i64 %t229, 1
  store i64 %t228, ptr %t44
  %t230 = load i64, ptr %t227
  call void @buf_putc(ptr %t67, i64 %t230)
  br label %L60
L60:
  br label %L48
L47:
  %t232 = load ptr, ptr %t44
  %t233 = load i64, ptr %t232
  %t235 = sext i32 40 to i64
  %t234 = icmp eq i64 %t233, %t235
  %t236 = zext i1 %t234 to i64
  %t237 = icmp ne i64 %t236, 0
  br i1 %t237, label %L61, label %L63
L61:
  %t238 = load i64, ptr %t65
  %t239 = add i64 %t238, 1
  store i64 %t239, ptr %t65
  br label %L63
L63:
  %t240 = load ptr, ptr %t44
  %t241 = load i64, ptr %t240
  %t243 = sext i32 41 to i64
  %t242 = icmp eq i64 %t241, %t243
  %t244 = zext i1 %t242 to i64
  %t245 = icmp ne i64 %t244, 0
  br i1 %t245, label %L64, label %L66
L64:
  %t246 = load i64, ptr %t65
  %t247 = sub i64 %t246, 1
  store i64 %t247, ptr %t65
  br label %L66
L66:
  %t248 = load i64, ptr %t65
  %t250 = sext i32 0 to i64
  %t249 = icmp sge i64 %t248, %t250
  %t251 = zext i1 %t249 to i64
  %t252 = icmp ne i64 %t251, 0
  br i1 %t252, label %L67, label %L68
L67:
  %t253 = load ptr, ptr %t44
  %t255 = ptrtoint ptr %t253 to i64
  %t254 = add i64 %t255, 1
  store i64 %t254, ptr %t44
  %t256 = load i64, ptr %t253
  call void @buf_putc(ptr %t67, i64 %t256)
  br label %L69
L68:
  br label %L12
L70:
  br label %L69
L69:
  br label %L48
L48:
  br label %L30
L30:
  br label %L24
L24:
  br label %L10
L12:
  %t258 = load ptr, ptr %t67
  %t260 = ptrtoint ptr %t258 to i64
  %t261 = sext i32 0 to i64
  %t259 = icmp sgt i64 %t260, %t261
  %t262 = zext i1 %t259 to i64
  %t263 = icmp ne i64 %t262, 0
  br i1 %t263, label %L71, label %L72
L71:
  br label %L73
L72:
  %t264 = load i64, ptr %t63
  %t266 = sext i32 0 to i64
  %t265 = icmp sgt i64 %t264, %t266
  %t267 = zext i1 %t265 to i64
  %t268 = icmp ne i64 %t267, 0
  %t269 = zext i1 %t268 to i64
  br label %L73
L73:
  %t270 = phi i64 [ 1, %L71 ], [ %t269, %L72 ]
  %t271 = icmp ne i64 %t270, 0
  br i1 %t271, label %L74, label %L76
L74:
  %t272 = load i64, ptr %t63
  %t274 = sext i32 16 to i64
  %t273 = icmp slt i64 %t272, %t274
  %t275 = zext i1 %t273 to i64
  %t276 = icmp ne i64 %t275, 0
  br i1 %t276, label %L77, label %L79
L77:
  %t277 = load ptr, ptr %t67
  %t278 = call ptr @strdup(ptr %t277)
  %t279 = load ptr, ptr %t61
  %t280 = load i64, ptr %t63
  %t281 = add i64 %t280, 1
  store i64 %t281, ptr %t63
  %t282 = getelementptr ptr, ptr %t279, i64 %t280
  store ptr %t278, ptr %t282
  br label %L79
L79:
  br label %L76
L76:
  %t283 = load ptr, ptr %t67
  call void @free(ptr %t283)
  %t285 = load ptr, ptr %t44
  %t286 = load i64, ptr %t285
  %t288 = sext i32 41 to i64
  %t287 = icmp eq i64 %t286, %t288
  %t289 = zext i1 %t287 to i64
  %t290 = icmp ne i64 %t289, 0
  br i1 %t290, label %L80, label %L82
L80:
  %t291 = load ptr, ptr %t44
  %t293 = ptrtoint ptr %t291 to i64
  %t292 = add i64 %t293, 1
  store i64 %t292, ptr %t44
  br label %L82
L82:
  %t294 = load ptr, ptr %t44
  store ptr %t294, ptr %t1
  %t295 = alloca ptr
  %t296 = load ptr, ptr %t8
  store ptr %t296, ptr %t295
  %t297 = alloca i64
  call void @buf_init(ptr %t297)
  br label %L83
L83:
  %t299 = load ptr, ptr %t295
  %t300 = load i64, ptr %t299
  %t301 = icmp ne i64 %t300, 0
  br i1 %t301, label %L84, label %L85
L84:
  %t302 = load ptr, ptr %t295
  %t303 = load i64, ptr %t302
  %t305 = sext i32 35 to i64
  %t304 = icmp eq i64 %t303, %t305
  %t306 = zext i1 %t304 to i64
  %t307 = icmp ne i64 %t306, 0
  br i1 %t307, label %L86, label %L87
L86:
  %t308 = load ptr, ptr %t295
  %t310 = ptrtoint ptr %t308 to i64
  %t311 = sext i32 1 to i64
  %t312 = inttoptr i64 %t310 to ptr
  %t309 = getelementptr i8, ptr %t312, i64 %t311
  %t313 = load i64, ptr %t309
  %t315 = sext i32 35 to i64
  %t314 = icmp ne i64 %t313, %t315
  %t316 = zext i1 %t314 to i64
  %t317 = icmp ne i64 %t316, 0
  %t318 = zext i1 %t317 to i64
  br label %L88
L87:
  br label %L88
L88:
  %t319 = phi i64 [ %t318, %L86 ], [ 0, %L87 ]
  %t320 = icmp ne i64 %t319, 0
  br i1 %t320, label %L89, label %L91
L89:
  %t321 = load ptr, ptr %t295
  %t323 = ptrtoint ptr %t321 to i64
  %t322 = add i64 %t323, 1
  store i64 %t322, ptr %t295
  br label %L92
L92:
  %t324 = load ptr, ptr %t295
  %t325 = load i64, ptr %t324
  %t327 = sext i32 32 to i64
  %t326 = icmp eq i64 %t325, %t327
  %t328 = zext i1 %t326 to i64
  %t329 = icmp ne i64 %t328, 0
  br i1 %t329, label %L95, label %L96
L95:
  br label %L97
L96:
  %t330 = load ptr, ptr %t295
  %t331 = load i64, ptr %t330
  %t333 = sext i32 9 to i64
  %t332 = icmp eq i64 %t331, %t333
  %t334 = zext i1 %t332 to i64
  %t335 = icmp ne i64 %t334, 0
  %t336 = zext i1 %t335 to i64
  br label %L97
L97:
  %t337 = phi i64 [ 1, %L95 ], [ %t336, %L96 ]
  %t338 = icmp ne i64 %t337, 0
  br i1 %t338, label %L93, label %L94
L93:
  %t339 = load ptr, ptr %t295
  %t341 = ptrtoint ptr %t339 to i64
  %t340 = add i64 %t341, 1
  store i64 %t340, ptr %t295
  br label %L92
L94:
  %t342 = alloca ptr
  %t343 = alloca ptr
  %t344 = load ptr, ptr %t295
  %t345 = load ptr, ptr %t342
  %t346 = call ptr @read_ident(ptr %t344, ptr %t345, i64 8)
  store ptr %t346, ptr %t343
  %t347 = alloca i64
  %t348 = sext i32 0 to i64
  store i64 %t348, ptr %t347
  %t349 = alloca i64
  %t350 = sext i32 0 to i64
  store i64 %t350, ptr %t349
  br label %L98
L98:
  %t351 = load i64, ptr %t349
  %t352 = load i64, ptr %t12
  %t353 = icmp slt i64 %t351, %t352
  %t354 = zext i1 %t353 to i64
  %t355 = icmp ne i64 %t354, 0
  br i1 %t355, label %L102, label %L103
L102:
  %t356 = load i64, ptr %t349
  %t358 = sext i32 16 to i64
  %t357 = icmp slt i64 %t356, %t358
  %t359 = zext i1 %t357 to i64
  %t360 = icmp ne i64 %t359, 0
  %t361 = zext i1 %t360 to i64
  br label %L104
L103:
  br label %L104
L104:
  %t362 = phi i64 [ %t361, %L102 ], [ 0, %L103 ]
  %t363 = icmp ne i64 %t362, 0
  br i1 %t363, label %L99, label %L101
L99:
  %t364 = alloca ptr
  %t365 = load i64, ptr %t349
  %t366 = call ptr @macro_get_param(i64 %t0, i64 %t365)
  store ptr %t366, ptr %t364
  %t367 = load ptr, ptr %t364
  %t368 = ptrtoint ptr %t367 to i64
  %t369 = icmp ne i64 %t368, 0
  br i1 %t369, label %L105, label %L106
L105:
  %t370 = load ptr, ptr %t364
  %t371 = load ptr, ptr %t342
  %t372 = call i32 @strcmp(ptr %t370, ptr %t371)
  %t373 = sext i32 %t372 to i64
  %t375 = sext i32 0 to i64
  %t374 = icmp eq i64 %t373, %t375
  %t376 = zext i1 %t374 to i64
  %t377 = icmp ne i64 %t376, 0
  %t378 = zext i1 %t377 to i64
  br label %L107
L106:
  br label %L107
L107:
  %t379 = phi i64 [ %t378, %L105 ], [ 0, %L106 ]
  %t380 = icmp ne i64 %t379, 0
  br i1 %t380, label %L108, label %L110
L108:
  call void @buf_putc(ptr %t297, i64 34)
  %t382 = load i64, ptr %t349
  %t383 = load i64, ptr %t63
  %t384 = icmp slt i64 %t382, %t383
  %t385 = zext i1 %t384 to i64
  %t386 = icmp ne i64 %t385, 0
  br i1 %t386, label %L111, label %L112
L111:
  %t387 = load ptr, ptr %t61
  %t388 = load i64, ptr %t349
  %t389 = getelementptr ptr, ptr %t387, i64 %t388
  %t390 = load ptr, ptr %t389
  %t391 = ptrtoint ptr %t390 to i64
  %t392 = icmp ne i64 %t391, 0
  %t393 = zext i1 %t392 to i64
  br label %L113
L112:
  br label %L113
L113:
  %t394 = phi i64 [ %t393, %L111 ], [ 0, %L112 ]
  %t395 = icmp ne i64 %t394, 0
  br i1 %t395, label %L114, label %L116
L114:
  %t396 = alloca ptr
  %t397 = load ptr, ptr %t61
  %t398 = load i64, ptr %t349
  %t399 = getelementptr ptr, ptr %t397, i64 %t398
  %t400 = load ptr, ptr %t399
  store ptr %t400, ptr %t396
  br label %L117
L117:
  %t401 = load ptr, ptr %t396
  %t402 = load i64, ptr %t401
  %t403 = icmp ne i64 %t402, 0
  br i1 %t403, label %L118, label %L119
L118:
  %t404 = load ptr, ptr %t396
  %t405 = load i64, ptr %t404
  %t407 = sext i32 34 to i64
  %t406 = icmp eq i64 %t405, %t407
  %t408 = zext i1 %t406 to i64
  %t409 = icmp ne i64 %t408, 0
  br i1 %t409, label %L120, label %L121
L120:
  br label %L122
L121:
  %t410 = load ptr, ptr %t396
  %t411 = load i64, ptr %t410
  %t413 = sext i32 92 to i64
  %t412 = icmp eq i64 %t411, %t413
  %t414 = zext i1 %t412 to i64
  %t415 = icmp ne i64 %t414, 0
  %t416 = zext i1 %t415 to i64
  br label %L122
L122:
  %t417 = phi i64 [ 1, %L120 ], [ %t416, %L121 ]
  %t418 = icmp ne i64 %t417, 0
  br i1 %t418, label %L123, label %L125
L123:
  call void @buf_putc(ptr %t297, i64 92)
  br label %L125
L125:
  %t420 = load ptr, ptr %t396
  %t422 = ptrtoint ptr %t420 to i64
  %t421 = add i64 %t422, 1
  store i64 %t421, ptr %t396
  %t423 = load i64, ptr %t420
  call void @buf_putc(ptr %t297, i64 %t423)
  br label %L117
L119:
  br label %L116
L116:
  call void @buf_putc(ptr %t297, i64 34)
  %t426 = sext i32 1 to i64
  store i64 %t426, ptr %t347
  br label %L101
L126:
  br label %L110
L110:
  br label %L100
L100:
  %t427 = load i64, ptr %t349
  %t428 = add i64 %t427, 1
  store i64 %t428, ptr %t349
  br label %L98
L101:
  %t429 = load i64, ptr %t347
  %t431 = icmp eq i64 %t429, 0
  %t430 = zext i1 %t431 to i64
  %t432 = icmp ne i64 %t430, 0
  br i1 %t432, label %L127, label %L129
L127:
  call void @buf_putc(ptr %t297, i64 34)
  call void @buf_putc(ptr %t297, i64 34)
  br label %L129
L129:
  %t435 = load ptr, ptr %t343
  store ptr %t435, ptr %t295
  br label %L83
L130:
  br label %L91
L91:
  %t436 = load ptr, ptr %t295
  %t437 = load i64, ptr %t436
  %t439 = sext i32 35 to i64
  %t438 = icmp eq i64 %t437, %t439
  %t440 = zext i1 %t438 to i64
  %t441 = icmp ne i64 %t440, 0
  br i1 %t441, label %L131, label %L132
L131:
  %t442 = load ptr, ptr %t295
  %t444 = ptrtoint ptr %t442 to i64
  %t445 = sext i32 1 to i64
  %t446 = inttoptr i64 %t444 to ptr
  %t443 = getelementptr i8, ptr %t446, i64 %t445
  %t447 = load i64, ptr %t443
  %t449 = sext i32 35 to i64
  %t448 = icmp eq i64 %t447, %t449
  %t450 = zext i1 %t448 to i64
  %t451 = icmp ne i64 %t450, 0
  %t452 = zext i1 %t451 to i64
  br label %L133
L132:
  br label %L133
L133:
  %t453 = phi i64 [ %t452, %L131 ], [ 0, %L132 ]
  %t454 = icmp ne i64 %t453, 0
  br i1 %t454, label %L134, label %L136
L134:
  %t455 = load ptr, ptr %t295
  %t457 = ptrtoint ptr %t455 to i64
  %t458 = sext i32 2 to i64
  %t456 = add i64 %t457, %t458
  store i64 %t456, ptr %t295
  br label %L137
L137:
  %t459 = load ptr, ptr %t295
  %t460 = load i64, ptr %t459
  %t462 = sext i32 32 to i64
  %t461 = icmp eq i64 %t460, %t462
  %t463 = zext i1 %t461 to i64
  %t464 = icmp ne i64 %t463, 0
  br i1 %t464, label %L140, label %L141
L140:
  br label %L142
L141:
  %t465 = load ptr, ptr %t295
  %t466 = load i64, ptr %t465
  %t468 = sext i32 9 to i64
  %t467 = icmp eq i64 %t466, %t468
  %t469 = zext i1 %t467 to i64
  %t470 = icmp ne i64 %t469, 0
  %t471 = zext i1 %t470 to i64
  br label %L142
L142:
  %t472 = phi i64 [ 1, %L140 ], [ %t471, %L141 ]
  %t473 = icmp ne i64 %t472, 0
  br i1 %t473, label %L138, label %L139
L138:
  %t474 = load ptr, ptr %t295
  %t476 = ptrtoint ptr %t474 to i64
  %t475 = add i64 %t476, 1
  store i64 %t475, ptr %t295
  br label %L137
L139:
  br label %L83
L143:
  br label %L136
L136:
  %t477 = load ptr, ptr %t295
  %t478 = load i64, ptr %t477
  %t479 = add i64 %t478, 0
  %t480 = call i32 @isalpha(i64 %t479)
  %t481 = sext i32 %t480 to i64
  %t482 = icmp ne i64 %t481, 0
  br i1 %t482, label %L144, label %L145
L144:
  br label %L146
L145:
  %t483 = load ptr, ptr %t295
  %t484 = load i64, ptr %t483
  %t486 = sext i32 95 to i64
  %t485 = icmp eq i64 %t484, %t486
  %t487 = zext i1 %t485 to i64
  %t488 = icmp ne i64 %t487, 0
  %t489 = zext i1 %t488 to i64
  br label %L146
L146:
  %t490 = phi i64 [ 1, %L144 ], [ %t489, %L145 ]
  %t491 = icmp ne i64 %t490, 0
  br i1 %t491, label %L147, label %L148
L147:
  %t492 = alloca ptr
  %t493 = alloca ptr
  %t494 = load ptr, ptr %t295
  %t495 = load ptr, ptr %t492
  %t496 = call ptr @read_ident(ptr %t494, ptr %t495, i64 8)
  store ptr %t496, ptr %t493
  %t497 = alloca i64
  %t498 = sext i32 0 to i64
  store i64 %t498, ptr %t497
  %t499 = load ptr, ptr %t492
  %t500 = getelementptr [12 x i8], ptr @.str4, i64 0, i64 0
  %t501 = call i32 @strcmp(ptr %t499, ptr %t500)
  %t502 = sext i32 %t501 to i64
  %t504 = sext i32 0 to i64
  %t503 = icmp eq i64 %t502, %t504
  %t505 = zext i1 %t503 to i64
  %t506 = icmp ne i64 %t505, 0
  br i1 %t506, label %L150, label %L152
L150:
  %t507 = alloca i64
  %t508 = load i64, ptr %t12
  store i64 %t508, ptr %t507
  br label %L153
L153:
  %t509 = load i64, ptr %t507
  %t510 = load i64, ptr %t63
  %t511 = icmp slt i64 %t509, %t510
  %t512 = zext i1 %t511 to i64
  %t513 = icmp ne i64 %t512, 0
  br i1 %t513, label %L154, label %L156
L154:
  %t514 = load i64, ptr %t507
  %t515 = load i64, ptr %t12
  %t516 = icmp sgt i64 %t514, %t515
  %t517 = zext i1 %t516 to i64
  %t518 = icmp ne i64 %t517, 0
  br i1 %t518, label %L157, label %L159
L157:
  call void @buf_putc(ptr %t297, i64 44)
  br label %L159
L159:
  %t520 = load ptr, ptr %t61
  %t521 = load i64, ptr %t507
  %t522 = getelementptr ptr, ptr %t520, i64 %t521
  %t523 = load ptr, ptr %t522
  %t524 = icmp ne ptr %t523, null
  br i1 %t524, label %L160, label %L162
L160:
  %t525 = load ptr, ptr %t61
  %t526 = load i64, ptr %t507
  %t527 = getelementptr ptr, ptr %t525, i64 %t526
  %t528 = load ptr, ptr %t527
  %t529 = load ptr, ptr %t61
  %t530 = load i64, ptr %t507
  %t531 = getelementptr ptr, ptr %t529, i64 %t530
  %t532 = load ptr, ptr %t531
  %t533 = call i64 @strlen(ptr %t532)
  call void @buf_append(ptr %t297, ptr %t528, i64 %t533)
  br label %L162
L162:
  br label %L155
L155:
  %t535 = load i64, ptr %t507
  %t536 = add i64 %t535, 1
  store i64 %t536, ptr %t507
  br label %L153
L156:
  %t537 = sext i32 1 to i64
  store i64 %t537, ptr %t497
  br label %L152
L152:
  %t538 = load i64, ptr %t497
  %t540 = icmp eq i64 %t538, 0
  %t539 = zext i1 %t540 to i64
  %t541 = icmp ne i64 %t539, 0
  br i1 %t541, label %L163, label %L165
L163:
  %t542 = alloca i64
  %t543 = sext i32 0 to i64
  store i64 %t543, ptr %t542
  br label %L166
L166:
  %t544 = load i64, ptr %t542
  %t545 = load i64, ptr %t12
  %t546 = icmp slt i64 %t544, %t545
  %t547 = zext i1 %t546 to i64
  %t548 = icmp ne i64 %t547, 0
  br i1 %t548, label %L170, label %L171
L170:
  %t549 = load i64, ptr %t542
  %t551 = sext i32 16 to i64
  %t550 = icmp slt i64 %t549, %t551
  %t552 = zext i1 %t550 to i64
  %t553 = icmp ne i64 %t552, 0
  %t554 = zext i1 %t553 to i64
  br label %L172
L171:
  br label %L172
L172:
  %t555 = phi i64 [ %t554, %L170 ], [ 0, %L171 ]
  %t556 = icmp ne i64 %t555, 0
  br i1 %t556, label %L167, label %L169
L167:
  %t557 = alloca ptr
  %t558 = load i64, ptr %t542
  %t559 = call ptr @macro_get_param(i64 %t0, i64 %t558)
  store ptr %t559, ptr %t557
  %t560 = load ptr, ptr %t557
  %t561 = ptrtoint ptr %t560 to i64
  %t562 = icmp ne i64 %t561, 0
  br i1 %t562, label %L173, label %L174
L173:
  %t563 = load ptr, ptr %t557
  %t564 = load ptr, ptr %t492
  %t565 = call i32 @strcmp(ptr %t563, ptr %t564)
  %t566 = sext i32 %t565 to i64
  %t568 = sext i32 0 to i64
  %t567 = icmp eq i64 %t566, %t568
  %t569 = zext i1 %t567 to i64
  %t570 = icmp ne i64 %t569, 0
  %t571 = zext i1 %t570 to i64
  br label %L175
L174:
  br label %L175
L175:
  %t572 = phi i64 [ %t571, %L173 ], [ 0, %L174 ]
  %t573 = icmp ne i64 %t572, 0
  br i1 %t573, label %L176, label %L178
L176:
  %t574 = load i64, ptr %t542
  %t575 = load i64, ptr %t63
  %t576 = icmp slt i64 %t574, %t575
  %t577 = zext i1 %t576 to i64
  %t578 = icmp ne i64 %t577, 0
  br i1 %t578, label %L179, label %L180
L179:
  %t579 = load ptr, ptr %t61
  %t580 = load i64, ptr %t542
  %t581 = getelementptr ptr, ptr %t579, i64 %t580
  %t582 = load ptr, ptr %t581
  %t583 = ptrtoint ptr %t582 to i64
  %t584 = icmp ne i64 %t583, 0
  %t585 = zext i1 %t584 to i64
  br label %L181
L180:
  br label %L181
L181:
  %t586 = phi i64 [ %t585, %L179 ], [ 0, %L180 ]
  %t587 = icmp ne i64 %t586, 0
  br i1 %t587, label %L182, label %L184
L182:
  %t588 = load ptr, ptr %t61
  %t589 = load i64, ptr %t542
  %t590 = getelementptr ptr, ptr %t588, i64 %t589
  %t591 = load ptr, ptr %t590
  %t592 = load ptr, ptr %t61
  %t593 = load i64, ptr %t542
  %t594 = getelementptr ptr, ptr %t592, i64 %t593
  %t595 = load ptr, ptr %t594
  %t596 = call i64 @strlen(ptr %t595)
  call void @buf_append(ptr %t297, ptr %t591, i64 %t596)
  br label %L184
L184:
  %t598 = sext i32 1 to i64
  store i64 %t598, ptr %t497
  br label %L169
L185:
  br label %L178
L178:
  br label %L168
L168:
  %t599 = load i64, ptr %t542
  %t600 = add i64 %t599, 1
  store i64 %t600, ptr %t542
  br label %L166
L169:
  br label %L165
L165:
  %t601 = load i64, ptr %t497
  %t603 = icmp eq i64 %t601, 0
  %t602 = zext i1 %t603 to i64
  %t604 = icmp ne i64 %t602, 0
  br i1 %t604, label %L186, label %L188
L186:
  %t605 = load ptr, ptr %t492
  %t606 = load ptr, ptr %t492
  %t607 = call i64 @strlen(ptr %t606)
  call void @buf_append(ptr %t297, ptr %t605, i64 %t607)
  br label %L188
L188:
  %t609 = load ptr, ptr %t493
  store ptr %t609, ptr %t295
  br label %L149
L148:
  %t610 = load ptr, ptr %t295
  %t612 = ptrtoint ptr %t610 to i64
  %t611 = add i64 %t612, 1
  store i64 %t611, ptr %t295
  %t613 = load i64, ptr %t610
  call void @buf_putc(ptr %t297, i64 %t613)
  br label %L149
L149:
  br label %L83
L85:
  %t615 = load ptr, ptr %t297
  %t617 = sext i32 1 to i64
  %t616 = add i64 %t3, %t617
  call void @expand_text(ptr %t615, ptr %t2, i64 %t616)
  %t619 = load ptr, ptr %t297
  call void @free(ptr %t619)
  %t621 = alloca i64
  %t622 = sext i32 0 to i64
  store i64 %t622, ptr %t621
  br label %L189
L189:
  %t623 = load i64, ptr %t621
  %t624 = load i64, ptr %t63
  %t625 = icmp slt i64 %t623, %t624
  %t626 = zext i1 %t625 to i64
  %t627 = icmp ne i64 %t626, 0
  br i1 %t627, label %L190, label %L192
L190:
  %t628 = load ptr, ptr %t61
  %t629 = load i64, ptr %t621
  %t630 = getelementptr ptr, ptr %t628, i64 %t629
  %t631 = load ptr, ptr %t630
  call void @free(ptr %t631)
  br label %L191
L191:
  %t633 = load i64, ptr %t621
  %t634 = add i64 %t633, 1
  store i64 %t634, ptr %t621
  br label %L189
L192:
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
  %t26 = icmp ne i64 %t25, 0
  br i1 %t26, label %L13, label %L14
L13:
  %t27 = load ptr, ptr %t9
  %t28 = load i64, ptr %t27
  %t30 = sext i32 34 to i64
  %t29 = icmp ne i64 %t28, %t30
  %t31 = zext i1 %t29 to i64
  %t32 = icmp ne i64 %t31, 0
  %t33 = zext i1 %t32 to i64
  br label %L15
L14:
  br label %L15
L15:
  %t34 = phi i64 [ %t33, %L13 ], [ 0, %L14 ]
  %t35 = icmp ne i64 %t34, 0
  br i1 %t35, label %L11, label %L12
L11:
  %t36 = load ptr, ptr %t9
  %t37 = load i64, ptr %t36
  %t39 = sext i32 92 to i64
  %t38 = icmp eq i64 %t37, %t39
  %t40 = zext i1 %t38 to i64
  %t41 = icmp ne i64 %t40, 0
  br i1 %t41, label %L16, label %L18
L16:
  %t42 = load ptr, ptr %t9
  %t44 = ptrtoint ptr %t42 to i64
  %t43 = add i64 %t44, 1
  store i64 %t43, ptr %t9
  %t45 = load i64, ptr %t42
  call void @buf_putc(ptr %t1, i64 %t45)
  br label %L18
L18:
  %t47 = load ptr, ptr %t9
  %t48 = load i64, ptr %t47
  %t49 = icmp ne i64 %t48, 0
  br i1 %t49, label %L19, label %L21
L19:
  %t50 = load ptr, ptr %t9
  %t52 = ptrtoint ptr %t50 to i64
  %t51 = add i64 %t52, 1
  store i64 %t51, ptr %t9
  %t53 = load i64, ptr %t50
  call void @buf_putc(ptr %t1, i64 %t53)
  br label %L21
L21:
  br label %L10
L12:
  %t55 = load ptr, ptr %t9
  %t56 = load i64, ptr %t55
  %t57 = icmp ne i64 %t56, 0
  br i1 %t57, label %L22, label %L24
L22:
  %t58 = load ptr, ptr %t9
  %t60 = ptrtoint ptr %t58 to i64
  %t59 = add i64 %t60, 1
  store i64 %t59, ptr %t9
  %t61 = load i64, ptr %t58
  call void @buf_putc(ptr %t1, i64 %t61)
  br label %L24
L24:
  br label %L4
L25:
  br label %L9
L9:
  %t63 = load ptr, ptr %t9
  %t64 = load i64, ptr %t63
  %t66 = sext i32 39 to i64
  %t65 = icmp eq i64 %t64, %t66
  %t67 = zext i1 %t65 to i64
  %t68 = icmp ne i64 %t67, 0
  br i1 %t68, label %L26, label %L28
L26:
  %t69 = load ptr, ptr %t9
  %t71 = ptrtoint ptr %t69 to i64
  %t70 = add i64 %t71, 1
  store i64 %t70, ptr %t9
  %t72 = load i64, ptr %t69
  call void @buf_putc(ptr %t1, i64 %t72)
  br label %L29
L29:
  %t74 = load ptr, ptr %t9
  %t75 = load i64, ptr %t74
  %t76 = icmp ne i64 %t75, 0
  br i1 %t76, label %L32, label %L33
L32:
  %t77 = load ptr, ptr %t9
  %t78 = load i64, ptr %t77
  %t80 = sext i32 39 to i64
  %t79 = icmp ne i64 %t78, %t80
  %t81 = zext i1 %t79 to i64
  %t82 = icmp ne i64 %t81, 0
  %t83 = zext i1 %t82 to i64
  br label %L34
L33:
  br label %L34
L34:
  %t84 = phi i64 [ %t83, %L32 ], [ 0, %L33 ]
  %t85 = icmp ne i64 %t84, 0
  br i1 %t85, label %L30, label %L31
L30:
  %t86 = load ptr, ptr %t9
  %t87 = load i64, ptr %t86
  %t89 = sext i32 92 to i64
  %t88 = icmp eq i64 %t87, %t89
  %t90 = zext i1 %t88 to i64
  %t91 = icmp ne i64 %t90, 0
  br i1 %t91, label %L35, label %L37
L35:
  %t92 = load ptr, ptr %t9
  %t94 = ptrtoint ptr %t92 to i64
  %t93 = add i64 %t94, 1
  store i64 %t93, ptr %t9
  %t95 = load i64, ptr %t92
  call void @buf_putc(ptr %t1, i64 %t95)
  br label %L37
L37:
  %t97 = load ptr, ptr %t9
  %t98 = load i64, ptr %t97
  %t99 = icmp ne i64 %t98, 0
  br i1 %t99, label %L38, label %L40
L38:
  %t100 = load ptr, ptr %t9
  %t102 = ptrtoint ptr %t100 to i64
  %t101 = add i64 %t102, 1
  store i64 %t101, ptr %t9
  %t103 = load i64, ptr %t100
  call void @buf_putc(ptr %t1, i64 %t103)
  br label %L40
L40:
  br label %L29
L31:
  %t105 = load ptr, ptr %t9
  %t106 = load i64, ptr %t105
  %t107 = icmp ne i64 %t106, 0
  br i1 %t107, label %L41, label %L43
L41:
  %t108 = load ptr, ptr %t9
  %t110 = ptrtoint ptr %t108 to i64
  %t109 = add i64 %t110, 1
  store i64 %t109, ptr %t9
  %t111 = load i64, ptr %t108
  call void @buf_putc(ptr %t1, i64 %t111)
  br label %L43
L43:
  br label %L4
L44:
  br label %L28
L28:
  %t113 = load ptr, ptr %t9
  %t114 = load i64, ptr %t113
  %t115 = add i64 %t114, 0
  %t116 = call i32 @isalpha(i64 %t115)
  %t117 = sext i32 %t116 to i64
  %t118 = icmp ne i64 %t117, 0
  br i1 %t118, label %L45, label %L46
L45:
  br label %L47
L46:
  %t119 = load ptr, ptr %t9
  %t120 = load i64, ptr %t119
  %t122 = sext i32 95 to i64
  %t121 = icmp eq i64 %t120, %t122
  %t123 = zext i1 %t121 to i64
  %t124 = icmp ne i64 %t123, 0
  %t125 = zext i1 %t124 to i64
  br label %L47
L47:
  %t126 = phi i64 [ 1, %L45 ], [ %t125, %L46 ]
  %t127 = icmp ne i64 %t126, 0
  br i1 %t127, label %L48, label %L50
L48:
  %t128 = alloca ptr
  %t129 = alloca ptr
  %t130 = load ptr, ptr %t9
  %t131 = load ptr, ptr %t128
  %t132 = call ptr @read_ident(ptr %t130, ptr %t131, i64 8)
  store ptr %t132, ptr %t129
  %t133 = alloca i64
  %t134 = load ptr, ptr %t128
  %t135 = call i32 @macro_find_idx(ptr %t134)
  %t136 = sext i32 %t135 to i64
  store i64 %t136, ptr %t133
  %t137 = load i64, ptr %t133
  %t139 = sext i32 0 to i64
  %t138 = icmp sge i64 %t137, %t139
  %t140 = zext i1 %t138 to i64
  %t141 = icmp ne i64 %t140, 0
  br i1 %t141, label %L51, label %L52
L51:
  %t142 = load ptr, ptr @macro_funclike
  %t143 = load i64, ptr %t133
  %t144 = getelementptr ptr, ptr %t142, i64 %t143
  %t145 = load ptr, ptr %t144
  %t146 = ptrtoint ptr %t145 to i64
  %t147 = icmp ne i64 %t146, 0
  %t148 = zext i1 %t147 to i64
  br label %L53
L52:
  br label %L53
L53:
  %t149 = phi i64 [ %t148, %L51 ], [ 0, %L52 ]
  %t150 = icmp ne i64 %t149, 0
  br i1 %t150, label %L54, label %L56
L54:
  %t151 = alloca ptr
  %t152 = load ptr, ptr %t129
  store ptr %t152, ptr %t151
  %t153 = load ptr, ptr %t151
  %t154 = call ptr @skip_ws(ptr %t153)
  store ptr %t154, ptr %t151
  %t155 = load ptr, ptr %t151
  %t156 = load i64, ptr %t155
  %t158 = sext i32 40 to i64
  %t157 = icmp eq i64 %t156, %t158
  %t159 = zext i1 %t157 to i64
  %t160 = icmp ne i64 %t159, 0
  br i1 %t160, label %L57, label %L59
L57:
  %t161 = load ptr, ptr %t129
  store ptr %t161, ptr %t9
  %t162 = load i64, ptr %t133
  %t164 = sext i32 1 to i64
  %t163 = add i64 %t2, %t164
  call void @expand_func_macro(i64 %t162, ptr %t9, ptr %t1, i64 %t163)
  br label %L4
L60:
  br label %L59
L59:
  br label %L56
L56:
  %t166 = load i64, ptr %t133
  %t168 = sext i32 0 to i64
  %t167 = icmp sge i64 %t166, %t168
  %t169 = zext i1 %t167 to i64
  %t170 = icmp ne i64 %t169, 0
  br i1 %t170, label %L61, label %L62
L61:
  %t171 = load ptr, ptr @macro_funclike
  %t172 = load i64, ptr %t133
  %t173 = getelementptr ptr, ptr %t171, i64 %t172
  %t174 = load ptr, ptr %t173
  %t176 = ptrtoint ptr %t174 to i64
  %t177 = icmp eq i64 %t176, 0
  %t175 = zext i1 %t177 to i64
  %t178 = icmp ne i64 %t175, 0
  %t179 = zext i1 %t178 to i64
  br label %L63
L62:
  br label %L63
L63:
  %t180 = phi i64 [ %t179, %L61 ], [ 0, %L62 ]
  %t181 = icmp ne i64 %t180, 0
  br i1 %t181, label %L64, label %L66
L64:
  %t182 = load ptr, ptr @macro_bodies
  %t183 = load i64, ptr %t133
  %t184 = getelementptr ptr, ptr %t182, i64 %t183
  %t185 = load ptr, ptr %t184
  %t187 = sext i32 1 to i64
  %t186 = add i64 %t2, %t187
  call void @expand_text(ptr %t185, ptr %t1, i64 %t186)
  %t189 = load ptr, ptr %t129
  store ptr %t189, ptr %t9
  br label %L4
L67:
  br label %L66
L66:
  %t190 = load ptr, ptr %t128
  %t191 = load ptr, ptr %t128
  %t192 = call i64 @strlen(ptr %t191)
  call void @buf_append(ptr %t1, ptr %t190, i64 %t192)
  %t194 = load ptr, ptr %t129
  store ptr %t194, ptr %t9
  br label %L4
L68:
  br label %L50
L50:
  %t195 = load ptr, ptr %t9
  %t197 = ptrtoint ptr %t195 to i64
  %t196 = add i64 %t197, 1
  store i64 %t196, ptr %t9
  %t198 = load i64, ptr %t195
  call void @buf_putc(ptr %t1, i64 %t198)
  br label %L4
L6:
  ret void
}

define internal ptr @read_file(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = getelementptr [2 x i8], ptr @.str5, i64 0, i64 0
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
  %t40 = getelementptr ptr, ptr %t38, i64 %t39
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

define internal ptr @get_include_paths() {
entry:
  %t0 = alloca ptr
  %t1 = alloca i64
  %t2 = sext i32 0 to i64
  store i64 %t2, ptr %t1
  %t3 = load i64, ptr %t1
  %t5 = icmp eq i64 %t3, 0
  %t4 = zext i1 %t5 to i64
  %t6 = icmp ne i64 %t4, 0
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = getelementptr [13 x i8], ptr @.str6, i64 0, i64 0
  %t8 = load ptr, ptr %t0
  %t10 = sext i32 0 to i64
  %t9 = getelementptr ptr, ptr %t8, i64 %t10
  store ptr %t7, ptr %t9
  %t11 = getelementptr [19 x i8], ptr @.str7, i64 0, i64 0
  %t12 = load ptr, ptr %t0
  %t14 = sext i32 1 to i64
  %t13 = getelementptr ptr, ptr %t12, i64 %t14
  store ptr %t11, ptr %t13
  %t15 = getelementptr [2 x i8], ptr @.str8, i64 0, i64 0
  %t16 = load ptr, ptr %t0
  %t18 = sext i32 2 to i64
  %t17 = getelementptr ptr, ptr %t16, i64 %t18
  store ptr %t15, ptr %t17
  %t20 = sext i32 0 to i64
  %t19 = inttoptr i64 %t20 to ptr
  %t21 = load ptr, ptr %t0
  %t23 = sext i32 3 to i64
  %t22 = getelementptr ptr, ptr %t21, i64 %t23
  store ptr %t19, ptr %t22
  %t24 = sext i32 1 to i64
  store i64 %t24, ptr %t1
  br label %L2
L2:
  %t25 = load ptr, ptr %t0
  ret ptr %t25
L3:
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
  %t10 = alloca ptr
  %t11 = call ptr @get_include_paths()
  store ptr %t11, ptr %t10
  %t12 = alloca i64
  %t13 = sext i32 0 to i64
  store i64 %t13, ptr %t12
  br label %L7
L7:
  %t14 = load ptr, ptr %t10
  %t15 = load i64, ptr %t12
  %t16 = getelementptr ptr, ptr %t14, i64 %t15
  %t17 = load ptr, ptr %t16
  %t18 = icmp ne ptr %t17, null
  br i1 %t18, label %L8, label %L10
L8:
  %t19 = alloca ptr
  %t20 = load ptr, ptr %t19
  %t21 = getelementptr [6 x i8], ptr @.str9, i64 0, i64 0
  %t22 = load ptr, ptr %t10
  %t23 = load i64, ptr %t12
  %t24 = getelementptr ptr, ptr %t22, i64 %t23
  %t25 = load ptr, ptr %t24
  %t26 = call i32 @snprintf(ptr %t20, i64 8, ptr %t21, ptr %t25, ptr %t0)
  %t27 = sext i32 %t26 to i64
  %t28 = alloca ptr
  %t29 = load ptr, ptr %t19
  %t30 = call ptr @read_file(ptr %t29)
  store ptr %t30, ptr %t28
  %t31 = load ptr, ptr %t28
  %t32 = icmp ne ptr %t31, null
  br i1 %t32, label %L11, label %L13
L11:
  %t33 = load ptr, ptr %t28
  ret ptr %t33
L14:
  br label %L13
L13:
  br label %L9
L9:
  %t34 = load i64, ptr %t12
  %t35 = add i64 %t34, 1
  store i64 %t35, ptr %t12
  br label %L7
L10:
  %t37 = sext i32 0 to i64
  %t36 = inttoptr i64 %t37 to ptr
  ret ptr %t36
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
  %t19 = getelementptr [6 x i8], ptr @.str10, i64 0, i64 0
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
  %t32 = call i32 @macro_find_idx(ptr %t31)
  %t33 = sext i32 %t32 to i64
  %t35 = sext i32 0 to i64
  %t34 = icmp sge i64 %t33, %t35
  %t36 = zext i1 %t34 to i64
  store i64 %t36, ptr %t30
  %t37 = load i64, ptr %t5
  %t39 = sext i32 32 to i64
  %t38 = icmp slt i64 %t37, %t39
  %t40 = zext i1 %t38 to i64
  %t41 = icmp ne i64 %t40, 0
  br i1 %t41, label %L3, label %L5
L3:
  %t42 = load i64, ptr %t30
  %t43 = load i64, ptr %t5
  %t44 = add i64 %t43, 1
  store i64 %t44, ptr %t5
  %t45 = getelementptr ptr, ptr %t4, i64 %t43
  store i64 %t42, ptr %t45
  br label %L5
L5:
  ret void
L6:
  br label %L2
L2:
  %t46 = load ptr, ptr %t12
  %t47 = getelementptr [7 x i8], ptr @.str11, i64 0, i64 0
  %t48 = call i32 @strcmp(ptr %t46, ptr %t47)
  %t49 = sext i32 %t48 to i64
  %t51 = sext i32 0 to i64
  %t50 = icmp eq i64 %t49, %t51
  %t52 = zext i1 %t50 to i64
  %t53 = icmp ne i64 %t52, 0
  br i1 %t53, label %L7, label %L9
L7:
  %t54 = alloca ptr
  %t55 = load ptr, ptr %t6
  %t56 = load ptr, ptr %t54
  %t57 = call ptr @read_ident(ptr %t55, ptr %t56, i64 8)
  %t58 = alloca i64
  %t59 = load ptr, ptr %t54
  %t60 = call i32 @macro_find_idx(ptr %t59)
  %t61 = sext i32 %t60 to i64
  %t63 = sext i32 0 to i64
  %t62 = icmp slt i64 %t61, %t63
  %t64 = zext i1 %t62 to i64
  store i64 %t64, ptr %t58
  %t65 = load i64, ptr %t5
  %t67 = sext i32 32 to i64
  %t66 = icmp slt i64 %t65, %t67
  %t68 = zext i1 %t66 to i64
  %t69 = icmp ne i64 %t68, 0
  br i1 %t69, label %L10, label %L12
L10:
  %t70 = load i64, ptr %t58
  %t71 = load i64, ptr %t5
  %t72 = add i64 %t71, 1
  store i64 %t72, ptr %t5
  %t73 = getelementptr ptr, ptr %t4, i64 %t71
  store i64 %t70, ptr %t73
  br label %L12
L12:
  ret void
L13:
  br label %L9
L9:
  %t74 = load ptr, ptr %t12
  %t75 = getelementptr [3 x i8], ptr @.str12, i64 0, i64 0
  %t76 = call i32 @strcmp(ptr %t74, ptr %t75)
  %t77 = sext i32 %t76 to i64
  %t79 = sext i32 0 to i64
  %t78 = icmp eq i64 %t77, %t79
  %t80 = zext i1 %t78 to i64
  %t81 = icmp ne i64 %t80, 0
  br i1 %t81, label %L14, label %L16
L14:
  %t82 = alloca i64
  %t83 = sext i32 0 to i64
  store i64 %t83, ptr %t82
  %t84 = load ptr, ptr %t6
  %t85 = getelementptr [8 x i8], ptr @.str13, i64 0, i64 0
  %t86 = call i32 @strncmp(ptr %t84, ptr %t85, i64 7)
  %t87 = sext i32 %t86 to i64
  %t89 = sext i32 0 to i64
  %t88 = icmp eq i64 %t87, %t89
  %t90 = zext i1 %t88 to i64
  %t91 = icmp ne i64 %t90, 0
  br i1 %t91, label %L17, label %L18
L17:
  %t92 = load ptr, ptr %t6
  %t94 = ptrtoint ptr %t92 to i64
  %t95 = sext i32 7 to i64
  %t93 = add i64 %t94, %t95
  store i64 %t93, ptr %t6
  %t96 = load ptr, ptr %t6
  %t97 = call ptr @skip_ws(ptr %t96)
  store ptr %t97, ptr %t6
  %t98 = load ptr, ptr %t6
  %t99 = load i64, ptr %t98
  %t101 = sext i32 40 to i64
  %t100 = icmp eq i64 %t99, %t101
  %t102 = zext i1 %t100 to i64
  %t103 = icmp ne i64 %t102, 0
  br i1 %t103, label %L20, label %L22
L20:
  %t104 = load ptr, ptr %t6
  %t106 = ptrtoint ptr %t104 to i64
  %t105 = add i64 %t106, 1
  store i64 %t105, ptr %t6
  br label %L22
L22:
  %t107 = load ptr, ptr %t6
  %t108 = call ptr @skip_ws(ptr %t107)
  store ptr %t108, ptr %t6
  %t109 = alloca ptr
  %t110 = alloca ptr
  %t111 = load ptr, ptr %t6
  %t112 = load ptr, ptr %t109
  %t113 = call ptr @read_ident(ptr %t111, ptr %t112, i64 8)
  store ptr %t113, ptr %t110
  %t114 = load ptr, ptr %t110
  %t115 = ptrtoint ptr %t114 to i64
  %t116 = load ptr, ptr %t109
  %t117 = call i32 @macro_find_idx(ptr %t116)
  %t118 = sext i32 %t117 to i64
  %t120 = sext i32 0 to i64
  %t119 = icmp sge i64 %t118, %t120
  %t121 = zext i1 %t119 to i64
  store i64 %t121, ptr %t82
  br label %L19
L18:
  %t122 = load ptr, ptr %t6
  %t123 = call i32 @atoi(ptr %t122)
  %t124 = sext i32 %t123 to i64
  %t126 = sext i32 0 to i64
  %t125 = icmp ne i64 %t124, %t126
  %t127 = zext i1 %t125 to i64
  store i64 %t127, ptr %t82
  br label %L19
L19:
  %t128 = load i64, ptr %t5
  %t130 = sext i32 32 to i64
  %t129 = icmp slt i64 %t128, %t130
  %t131 = zext i1 %t129 to i64
  %t132 = icmp ne i64 %t131, 0
  br i1 %t132, label %L23, label %L25
L23:
  %t133 = load i64, ptr %t82
  %t134 = load i64, ptr %t5
  %t135 = add i64 %t134, 1
  store i64 %t135, ptr %t5
  %t136 = getelementptr ptr, ptr %t4, i64 %t134
  store i64 %t133, ptr %t136
  br label %L25
L25:
  ret void
L26:
  br label %L16
L16:
  %t137 = load ptr, ptr %t12
  %t138 = getelementptr [5 x i8], ptr @.str14, i64 0, i64 0
  %t139 = call i32 @strcmp(ptr %t137, ptr %t138)
  %t140 = sext i32 %t139 to i64
  %t142 = sext i32 0 to i64
  %t141 = icmp eq i64 %t140, %t142
  %t143 = zext i1 %t141 to i64
  %t144 = icmp ne i64 %t143, 0
  br i1 %t144, label %L27, label %L29
L27:
  %t145 = load i64, ptr %t5
  %t147 = sext i32 0 to i64
  %t146 = icmp sgt i64 %t145, %t147
  %t148 = zext i1 %t146 to i64
  %t149 = icmp ne i64 %t148, 0
  br i1 %t149, label %L30, label %L32
L30:
  %t150 = alloca i64
  %t151 = load ptr, ptr %t6
  %t152 = call i32 @atoi(ptr %t151)
  %t153 = sext i32 %t152 to i64
  %t155 = sext i32 0 to i64
  %t154 = icmp ne i64 %t153, %t155
  %t156 = zext i1 %t154 to i64
  store i64 %t156, ptr %t150
  %t157 = load i64, ptr %t150
  %t158 = load i64, ptr %t5
  %t160 = sext i32 1 to i64
  %t159 = sub i64 %t158, %t160
  %t161 = getelementptr ptr, ptr %t4, i64 %t159
  store i64 %t157, ptr %t161
  br label %L32
L32:
  ret void
L33:
  br label %L29
L29:
  %t162 = load ptr, ptr %t12
  %t163 = getelementptr [5 x i8], ptr @.str15, i64 0, i64 0
  %t164 = call i32 @strcmp(ptr %t162, ptr %t163)
  %t165 = sext i32 %t164 to i64
  %t167 = sext i32 0 to i64
  %t166 = icmp eq i64 %t165, %t167
  %t168 = zext i1 %t166 to i64
  %t169 = icmp ne i64 %t168, 0
  br i1 %t169, label %L34, label %L36
L34:
  %t170 = load i64, ptr %t5
  %t172 = sext i32 0 to i64
  %t171 = icmp sgt i64 %t170, %t172
  %t173 = zext i1 %t171 to i64
  %t174 = icmp ne i64 %t173, 0
  br i1 %t174, label %L37, label %L39
L37:
  %t175 = load i64, ptr %t5
  %t177 = sext i32 1 to i64
  %t176 = sub i64 %t175, %t177
  %t178 = getelementptr ptr, ptr %t4, i64 %t176
  %t179 = load ptr, ptr %t178
  %t181 = ptrtoint ptr %t179 to i64
  %t182 = sext i32 1 to i64
  %t180 = xor i64 %t181, %t182
  %t183 = load i64, ptr %t5
  %t185 = sext i32 1 to i64
  %t184 = sub i64 %t183, %t185
  %t186 = getelementptr ptr, ptr %t4, i64 %t184
  store i64 %t180, ptr %t186
  br label %L39
L39:
  ret void
L40:
  br label %L36
L36:
  %t187 = load ptr, ptr %t12
  %t188 = getelementptr [6 x i8], ptr @.str16, i64 0, i64 0
  %t189 = call i32 @strcmp(ptr %t187, ptr %t188)
  %t190 = sext i32 %t189 to i64
  %t192 = sext i32 0 to i64
  %t191 = icmp eq i64 %t190, %t192
  %t193 = zext i1 %t191 to i64
  %t194 = icmp ne i64 %t193, 0
  br i1 %t194, label %L41, label %L43
L41:
  %t195 = load i64, ptr %t5
  %t197 = sext i32 0 to i64
  %t196 = icmp sgt i64 %t195, %t197
  %t198 = zext i1 %t196 to i64
  %t199 = icmp ne i64 %t198, 0
  br i1 %t199, label %L44, label %L46
L44:
  %t200 = load i64, ptr %t5
  %t201 = sub i64 %t200, 1
  store i64 %t201, ptr %t5
  br label %L46
L46:
  ret void
L47:
  br label %L43
L43:
  %t202 = alloca i64
  %t203 = sext i32 1 to i64
  store i64 %t203, ptr %t202
  %t204 = alloca i64
  %t205 = sext i32 0 to i64
  store i64 %t205, ptr %t204
  br label %L48
L48:
  %t206 = load i64, ptr %t204
  %t207 = load i64, ptr %t5
  %t208 = icmp slt i64 %t206, %t207
  %t209 = zext i1 %t208 to i64
  %t210 = icmp ne i64 %t209, 0
  br i1 %t210, label %L49, label %L51
L49:
  %t211 = load i64, ptr %t204
  %t212 = getelementptr ptr, ptr %t4, i64 %t211
  %t213 = load ptr, ptr %t212
  %t215 = ptrtoint ptr %t213 to i64
  %t216 = icmp eq i64 %t215, 0
  %t214 = zext i1 %t216 to i64
  %t217 = icmp ne i64 %t214, 0
  br i1 %t217, label %L52, label %L54
L52:
  %t218 = sext i32 0 to i64
  store i64 %t218, ptr %t202
  br label %L51
L55:
  br label %L54
L54:
  br label %L50
L50:
  %t219 = load i64, ptr %t204
  %t220 = add i64 %t219, 1
  store i64 %t220, ptr %t204
  br label %L48
L51:
  %t221 = load i64, ptr %t202
  %t223 = icmp eq i64 %t221, 0
  %t222 = zext i1 %t223 to i64
  %t224 = icmp ne i64 %t222, 0
  br i1 %t224, label %L56, label %L58
L56:
  ret void
L59:
  br label %L58
L58:
  %t225 = load ptr, ptr %t12
  %t226 = getelementptr [7 x i8], ptr @.str17, i64 0, i64 0
  %t227 = call i32 @strcmp(ptr %t225, ptr %t226)
  %t228 = sext i32 %t227 to i64
  %t230 = sext i32 0 to i64
  %t229 = icmp eq i64 %t228, %t230
  %t231 = zext i1 %t229 to i64
  %t232 = icmp ne i64 %t231, 0
  br i1 %t232, label %L60, label %L62
L60:
  %t233 = alloca ptr
  %t234 = load ptr, ptr %t6
  %t235 = load ptr, ptr %t233
  %t236 = call ptr @read_ident(ptr %t234, ptr %t235, i64 8)
  store ptr %t236, ptr %t6
  %t237 = load ptr, ptr %t6
  %t238 = load i64, ptr %t237
  %t240 = sext i32 40 to i64
  %t239 = icmp eq i64 %t238, %t240
  %t241 = zext i1 %t239 to i64
  %t242 = icmp ne i64 %t241, 0
  br i1 %t242, label %L63, label %L64
L63:
  %t243 = load ptr, ptr %t6
  %t245 = ptrtoint ptr %t243 to i64
  %t244 = add i64 %t245, 1
  store i64 %t244, ptr %t6
  %t246 = alloca ptr
  %t247 = sext i32 0 to i64
  store i64 %t247, ptr %t246
  %t248 = alloca i64
  %t249 = sext i32 0 to i64
  store i64 %t249, ptr %t248
  %t250 = alloca i64
  %t251 = sext i32 0 to i64
  store i64 %t251, ptr %t250
  br label %L66
L66:
  %t252 = load ptr, ptr %t6
  %t253 = load i64, ptr %t252
  %t254 = icmp ne i64 %t253, 0
  br i1 %t254, label %L69, label %L70
L69:
  %t255 = load ptr, ptr %t6
  %t256 = load i64, ptr %t255
  %t258 = sext i32 41 to i64
  %t257 = icmp ne i64 %t256, %t258
  %t259 = zext i1 %t257 to i64
  %t260 = icmp ne i64 %t259, 0
  %t261 = zext i1 %t260 to i64
  br label %L71
L70:
  br label %L71
L71:
  %t262 = phi i64 [ %t261, %L69 ], [ 0, %L70 ]
  %t263 = icmp ne i64 %t262, 0
  br i1 %t263, label %L67, label %L68
L67:
  %t264 = load ptr, ptr %t6
  %t265 = call ptr @skip_ws(ptr %t264)
  store ptr %t265, ptr %t6
  %t266 = load ptr, ptr %t6
  %t267 = load i64, ptr %t266
  %t269 = sext i32 41 to i64
  %t268 = icmp eq i64 %t267, %t269
  %t270 = zext i1 %t268 to i64
  %t271 = icmp ne i64 %t270, 0
  br i1 %t271, label %L72, label %L74
L72:
  br label %L68
L75:
  br label %L74
L74:
  %t272 = load ptr, ptr %t6
  %t273 = load i64, ptr %t272
  %t275 = sext i32 46 to i64
  %t274 = icmp eq i64 %t273, %t275
  %t276 = zext i1 %t274 to i64
  %t277 = icmp ne i64 %t276, 0
  br i1 %t277, label %L76, label %L77
L76:
  %t278 = load ptr, ptr %t6
  %t280 = ptrtoint ptr %t278 to i64
  %t281 = sext i32 1 to i64
  %t282 = inttoptr i64 %t280 to ptr
  %t279 = getelementptr i8, ptr %t282, i64 %t281
  %t283 = load i64, ptr %t279
  %t285 = sext i32 46 to i64
  %t284 = icmp eq i64 %t283, %t285
  %t286 = zext i1 %t284 to i64
  %t287 = icmp ne i64 %t286, 0
  %t288 = zext i1 %t287 to i64
  br label %L78
L77:
  br label %L78
L78:
  %t289 = phi i64 [ %t288, %L76 ], [ 0, %L77 ]
  %t290 = icmp ne i64 %t289, 0
  br i1 %t290, label %L79, label %L80
L79:
  %t291 = load ptr, ptr %t6
  %t293 = ptrtoint ptr %t291 to i64
  %t294 = sext i32 2 to i64
  %t295 = inttoptr i64 %t293 to ptr
  %t292 = getelementptr i8, ptr %t295, i64 %t294
  %t296 = load i64, ptr %t292
  %t298 = sext i32 46 to i64
  %t297 = icmp eq i64 %t296, %t298
  %t299 = zext i1 %t297 to i64
  %t300 = icmp ne i64 %t299, 0
  %t301 = zext i1 %t300 to i64
  br label %L81
L80:
  br label %L81
L81:
  %t302 = phi i64 [ %t301, %L79 ], [ 0, %L80 ]
  %t303 = icmp ne i64 %t302, 0
  br i1 %t303, label %L82, label %L84
L82:
  %t304 = sext i32 1 to i64
  store i64 %t304, ptr %t250
  %t305 = load ptr, ptr %t6
  %t307 = ptrtoint ptr %t305 to i64
  %t308 = sext i32 3 to i64
  %t306 = add i64 %t307, %t308
  store i64 %t306, ptr %t6
  %t309 = load ptr, ptr %t6
  %t310 = call ptr @skip_ws(ptr %t309)
  store ptr %t310, ptr %t6
  br label %L68
L85:
  br label %L84
L84:
  %t311 = alloca ptr
  %t312 = load ptr, ptr %t6
  %t313 = load ptr, ptr %t311
  %t314 = call ptr @read_ident(ptr %t312, ptr %t313, i64 8)
  store ptr %t314, ptr %t6
  %t315 = load ptr, ptr %t311
  %t316 = load i64, ptr %t315
  %t317 = icmp ne i64 %t316, 0
  br i1 %t317, label %L86, label %L87
L86:
  %t318 = load i64, ptr %t248
  %t320 = sext i32 16 to i64
  %t319 = icmp slt i64 %t318, %t320
  %t321 = zext i1 %t319 to i64
  %t322 = icmp ne i64 %t321, 0
  %t323 = zext i1 %t322 to i64
  br label %L88
L87:
  br label %L88
L88:
  %t324 = phi i64 [ %t323, %L86 ], [ 0, %L87 ]
  %t325 = icmp ne i64 %t324, 0
  br i1 %t325, label %L89, label %L91
L89:
  %t326 = load ptr, ptr %t311
  %t327 = call ptr @strdup(ptr %t326)
  %t328 = load ptr, ptr %t246
  %t329 = load i64, ptr %t248
  %t330 = add i64 %t329, 1
  store i64 %t330, ptr %t248
  %t331 = getelementptr ptr, ptr %t328, i64 %t329
  store ptr %t327, ptr %t331
  br label %L91
L91:
  %t332 = load ptr, ptr %t6
  %t333 = call ptr @skip_ws(ptr %t332)
  store ptr %t333, ptr %t6
  %t334 = load ptr, ptr %t6
  %t335 = load i64, ptr %t334
  %t337 = sext i32 44 to i64
  %t336 = icmp eq i64 %t335, %t337
  %t338 = zext i1 %t336 to i64
  %t339 = icmp ne i64 %t338, 0
  br i1 %t339, label %L92, label %L94
L92:
  %t340 = load ptr, ptr %t6
  %t342 = ptrtoint ptr %t340 to i64
  %t341 = add i64 %t342, 1
  store i64 %t341, ptr %t6
  br label %L94
L94:
  br label %L66
L68:
  %t343 = load i64, ptr %t250
  %t344 = add i64 %t343, 0
  %t345 = load ptr, ptr %t6
  %t346 = load i64, ptr %t345
  %t348 = sext i32 41 to i64
  %t347 = icmp eq i64 %t346, %t348
  %t349 = zext i1 %t347 to i64
  %t350 = icmp ne i64 %t349, 0
  br i1 %t350, label %L95, label %L97
L95:
  %t351 = load ptr, ptr %t6
  %t353 = ptrtoint ptr %t351 to i64
  %t352 = add i64 %t353, 1
  store i64 %t352, ptr %t6
  br label %L97
L97:
  %t354 = load ptr, ptr %t6
  %t355 = call ptr @skip_ws(ptr %t354)
  store ptr %t355, ptr %t6
  %t356 = alloca ptr
  %t357 = load ptr, ptr %t6
  store ptr %t357, ptr %t356
  %t358 = alloca ptr
  %t359 = load ptr, ptr %t6
  %t360 = call ptr @skip_to_eol(ptr %t359)
  store ptr %t360, ptr %t358
  %t361 = alloca ptr
  %t362 = load ptr, ptr %t358
  %t363 = load ptr, ptr %t356
  %t365 = ptrtoint ptr %t362 to i64
  %t366 = ptrtoint ptr %t363 to i64
  %t364 = sub i64 %t365, %t366
  %t368 = sext i32 1 to i64
  %t367 = add i64 %t364, %t368
  %t369 = call ptr @malloc(i64 %t367)
  store ptr %t369, ptr %t361
  %t370 = load ptr, ptr %t361
  %t371 = load ptr, ptr %t356
  %t372 = load ptr, ptr %t358
  %t373 = load ptr, ptr %t356
  %t375 = ptrtoint ptr %t372 to i64
  %t376 = ptrtoint ptr %t373 to i64
  %t374 = sub i64 %t375, %t376
  %t377 = call ptr @memcpy(ptr %t370, ptr %t371, i64 %t374)
  %t378 = load ptr, ptr %t361
  %t379 = load ptr, ptr %t358
  %t380 = load ptr, ptr %t356
  %t382 = ptrtoint ptr %t379 to i64
  %t383 = ptrtoint ptr %t380 to i64
  %t381 = sub i64 %t382, %t383
  %t384 = getelementptr ptr, ptr %t378, i64 %t381
  %t385 = sext i32 0 to i64
  store i64 %t385, ptr %t384
  %t386 = load ptr, ptr %t233
  %t387 = load ptr, ptr %t361
  %t388 = load ptr, ptr %t246
  %t389 = load i64, ptr %t248
  call void @macro_define(ptr %t386, ptr %t387, ptr %t388, i64 %t389, i64 1)
  %t391 = load ptr, ptr %t361
  call void @free(ptr %t391)
  %t393 = alloca i64
  %t394 = sext i32 0 to i64
  store i64 %t394, ptr %t393
  br label %L98
L98:
  %t395 = load i64, ptr %t393
  %t396 = load i64, ptr %t248
  %t397 = icmp slt i64 %t395, %t396
  %t398 = zext i1 %t397 to i64
  %t399 = icmp ne i64 %t398, 0
  br i1 %t399, label %L99, label %L101
L99:
  %t400 = load ptr, ptr %t246
  %t401 = load i64, ptr %t393
  %t402 = getelementptr ptr, ptr %t400, i64 %t401
  %t403 = load ptr, ptr %t402
  call void @free(ptr %t403)
  br label %L100
L100:
  %t405 = load i64, ptr %t393
  %t406 = add i64 %t405, 1
  store i64 %t406, ptr %t393
  br label %L98
L101:
  br label %L65
L64:
  %t407 = load ptr, ptr %t6
  %t408 = load i64, ptr %t407
  %t410 = sext i32 32 to i64
  %t409 = icmp eq i64 %t408, %t410
  %t411 = zext i1 %t409 to i64
  %t412 = icmp ne i64 %t411, 0
  br i1 %t412, label %L102, label %L103
L102:
  br label %L104
L103:
  %t413 = load ptr, ptr %t6
  %t414 = load i64, ptr %t413
  %t416 = sext i32 9 to i64
  %t415 = icmp eq i64 %t414, %t416
  %t417 = zext i1 %t415 to i64
  %t418 = icmp ne i64 %t417, 0
  %t419 = zext i1 %t418 to i64
  br label %L104
L104:
  %t420 = phi i64 [ 1, %L102 ], [ %t419, %L103 ]
  %t421 = icmp ne i64 %t420, 0
  br i1 %t421, label %L105, label %L107
L105:
  %t422 = load ptr, ptr %t6
  %t424 = ptrtoint ptr %t422 to i64
  %t423 = add i64 %t424, 1
  store i64 %t423, ptr %t6
  br label %L107
L107:
  %t425 = alloca ptr
  %t426 = load ptr, ptr %t6
  store ptr %t426, ptr %t425
  %t427 = alloca ptr
  %t428 = load ptr, ptr %t6
  %t429 = call ptr @skip_to_eol(ptr %t428)
  store ptr %t429, ptr %t427
  %t430 = alloca ptr
  %t431 = load ptr, ptr %t427
  %t432 = load ptr, ptr %t425
  %t434 = ptrtoint ptr %t431 to i64
  %t435 = ptrtoint ptr %t432 to i64
  %t433 = sub i64 %t434, %t435
  %t437 = sext i32 1 to i64
  %t436 = add i64 %t433, %t437
  %t438 = call ptr @malloc(i64 %t436)
  store ptr %t438, ptr %t430
  %t439 = load ptr, ptr %t430
  %t440 = load ptr, ptr %t425
  %t441 = load ptr, ptr %t427
  %t442 = load ptr, ptr %t425
  %t444 = ptrtoint ptr %t441 to i64
  %t445 = ptrtoint ptr %t442 to i64
  %t443 = sub i64 %t444, %t445
  %t446 = call ptr @memcpy(ptr %t439, ptr %t440, i64 %t443)
  %t447 = load ptr, ptr %t430
  %t448 = load ptr, ptr %t427
  %t449 = load ptr, ptr %t425
  %t451 = ptrtoint ptr %t448 to i64
  %t452 = ptrtoint ptr %t449 to i64
  %t450 = sub i64 %t451, %t452
  %t453 = getelementptr ptr, ptr %t447, i64 %t450
  %t454 = sext i32 0 to i64
  store i64 %t454, ptr %t453
  %t455 = load ptr, ptr %t233
  %t456 = load ptr, ptr %t430
  %t458 = sext i32 0 to i64
  %t457 = inttoptr i64 %t458 to ptr
  call void @macro_define(ptr %t455, ptr %t456, ptr %t457, i64 0, i64 0)
  %t460 = load ptr, ptr %t430
  call void @free(ptr %t460)
  br label %L65
L65:
  ret void
L108:
  br label %L62
L62:
  %t462 = load ptr, ptr %t12
  %t463 = getelementptr [6 x i8], ptr @.str18, i64 0, i64 0
  %t464 = call i32 @strcmp(ptr %t462, ptr %t463)
  %t465 = sext i32 %t464 to i64
  %t467 = sext i32 0 to i64
  %t466 = icmp eq i64 %t465, %t467
  %t468 = zext i1 %t466 to i64
  %t469 = icmp ne i64 %t468, 0
  br i1 %t469, label %L109, label %L111
L109:
  %t470 = alloca ptr
  %t471 = load ptr, ptr %t6
  %t472 = load ptr, ptr %t470
  %t473 = call ptr @read_ident(ptr %t471, ptr %t472, i64 8)
  %t474 = load ptr, ptr %t470
  call void @macro_undef(ptr %t474)
  ret void
L112:
  br label %L111
L111:
  %t476 = load ptr, ptr %t12
  %t477 = getelementptr [8 x i8], ptr @.str19, i64 0, i64 0
  %t478 = call i32 @strcmp(ptr %t476, ptr %t477)
  %t479 = sext i32 %t478 to i64
  %t481 = sext i32 0 to i64
  %t480 = icmp eq i64 %t479, %t481
  %t482 = zext i1 %t480 to i64
  %t483 = icmp ne i64 %t482, 0
  br i1 %t483, label %L113, label %L115
L113:
  %t485 = sext i32 32 to i64
  %t484 = icmp sgt i64 %t3, %t485
  %t486 = zext i1 %t484 to i64
  %t487 = icmp ne i64 %t486, 0
  br i1 %t487, label %L116, label %L118
L116:
  %t488 = call ptr @__c0c_stderr()
  %t489 = getelementptr [36 x i8], ptr @.str20, i64 0, i64 0
  %t490 = call i32 @fprintf(ptr %t488, ptr %t489)
  %t491 = sext i32 %t490 to i64
  ret void
L119:
  br label %L118
L118:
  %t492 = alloca i64
  %t493 = sext i32 0 to i64
  store i64 %t493, ptr %t492
  %t494 = alloca ptr
  %t495 = load ptr, ptr %t6
  %t496 = load i64, ptr %t495
  %t498 = sext i32 34 to i64
  %t497 = icmp eq i64 %t496, %t498
  %t499 = zext i1 %t497 to i64
  %t500 = icmp ne i64 %t499, 0
  br i1 %t500, label %L120, label %L121
L120:
  %t501 = load ptr, ptr %t6
  %t503 = ptrtoint ptr %t501 to i64
  %t502 = add i64 %t503, 1
  store i64 %t502, ptr %t6
  %t504 = alloca ptr
  %t505 = load ptr, ptr %t6
  %t506 = call ptr @strchr(ptr %t505, i64 34)
  store ptr %t506, ptr %t504
  %t507 = load ptr, ptr %t504
  %t509 = ptrtoint ptr %t507 to i64
  %t510 = icmp eq i64 %t509, 0
  %t508 = zext i1 %t510 to i64
  %t511 = icmp ne i64 %t508, 0
  br i1 %t511, label %L123, label %L125
L123:
  ret void
L126:
  br label %L125
L125:
  %t512 = alloca i64
  %t513 = load ptr, ptr %t504
  %t514 = load ptr, ptr %t6
  %t516 = ptrtoint ptr %t513 to i64
  %t517 = ptrtoint ptr %t514 to i64
  %t515 = sub i64 %t516, %t517
  %t518 = add i64 %t515, 0
  store i64 %t518, ptr %t512
  %t519 = load ptr, ptr %t494
  %t520 = load ptr, ptr %t6
  %t521 = load i64, ptr %t512
  %t522 = call ptr @memcpy(ptr %t519, ptr %t520, i64 %t521)
  %t523 = load ptr, ptr %t494
  %t524 = load i64, ptr %t512
  %t525 = getelementptr ptr, ptr %t523, i64 %t524
  %t526 = sext i32 0 to i64
  store i64 %t526, ptr %t525
  br label %L122
L121:
  %t527 = load ptr, ptr %t6
  %t528 = load i64, ptr %t527
  %t530 = sext i32 60 to i64
  %t529 = icmp eq i64 %t528, %t530
  %t531 = zext i1 %t529 to i64
  %t532 = icmp ne i64 %t531, 0
  br i1 %t532, label %L127, label %L128
L127:
  %t533 = load ptr, ptr %t6
  %t535 = ptrtoint ptr %t533 to i64
  %t534 = add i64 %t535, 1
  store i64 %t534, ptr %t6
  %t536 = alloca ptr
  %t537 = load ptr, ptr %t6
  %t538 = call ptr @strchr(ptr %t537, i64 62)
  store ptr %t538, ptr %t536
  %t539 = load ptr, ptr %t536
  %t541 = ptrtoint ptr %t539 to i64
  %t542 = icmp eq i64 %t541, 0
  %t540 = zext i1 %t542 to i64
  %t543 = icmp ne i64 %t540, 0
  br i1 %t543, label %L130, label %L132
L130:
  ret void
L133:
  br label %L132
L132:
  %t544 = alloca i64
  %t545 = load ptr, ptr %t536
  %t546 = load ptr, ptr %t6
  %t548 = ptrtoint ptr %t545 to i64
  %t549 = ptrtoint ptr %t546 to i64
  %t547 = sub i64 %t548, %t549
  %t550 = add i64 %t547, 0
  store i64 %t550, ptr %t544
  %t551 = load ptr, ptr %t494
  %t552 = load ptr, ptr %t6
  %t553 = load i64, ptr %t544
  %t554 = call ptr @memcpy(ptr %t551, ptr %t552, i64 %t553)
  %t555 = load ptr, ptr %t494
  %t556 = load i64, ptr %t544
  %t557 = getelementptr ptr, ptr %t555, i64 %t556
  %t558 = sext i32 0 to i64
  store i64 %t558, ptr %t557
  %t559 = sext i32 1 to i64
  store i64 %t559, ptr %t492
  br label %L129
L128:
  ret void
L134:
  br label %L129
L129:
  br label %L122
L122:
  %t560 = alloca ptr
  %t561 = load ptr, ptr %t494
  %t562 = load i64, ptr %t492
  %t563 = call ptr @find_include(ptr %t561, i64 %t562)
  store ptr %t563, ptr %t560
  %t564 = load ptr, ptr %t560
  %t566 = ptrtoint ptr %t564 to i64
  %t567 = icmp eq i64 %t566, 0
  %t565 = zext i1 %t567 to i64
  %t568 = icmp ne i64 %t565, 0
  br i1 %t568, label %L135, label %L137
L135:
  %t569 = getelementptr [2 x i8], ptr @.str21, i64 0, i64 0
  call void @buf_append(ptr %t2, ptr %t569, i64 1)
  ret void
L138:
  br label %L137
L137:
  %t571 = load i64, ptr %t492
  %t572 = icmp ne i64 %t571, 0
  br i1 %t572, label %L139, label %L141
L139:
  %t573 = load ptr, ptr %t560
  call void @free(ptr %t573)
  %t575 = getelementptr [2 x i8], ptr @.str22, i64 0, i64 0
  call void @buf_append(ptr %t2, ptr %t575, i64 1)
  ret void
L142:
  br label %L141
L141:
  %t577 = alloca ptr
  %t578 = load ptr, ptr %t560
  %t579 = load ptr, ptr %t494
  %t581 = sext i32 1 to i64
  %t580 = add i64 %t3, %t581
  %t582 = call ptr @macro_preprocess(ptr %t578, ptr %t579, i64 %t580)
  store ptr %t582, ptr %t577
  %t583 = load ptr, ptr %t560
  call void @free(ptr %t583)
  %t585 = load ptr, ptr %t577
  %t586 = load ptr, ptr %t577
  %t587 = call i64 @strlen(ptr %t586)
  call void @buf_append(ptr %t2, ptr %t585, i64 %t587)
  call void @buf_putc(ptr %t2, i64 10)
  %t590 = load ptr, ptr %t577
  call void @free(ptr %t590)
  ret void
L143:
  br label %L115
L115:
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
  %t15 = icmp ne i64 %t14, 0
  br i1 %t15, label %L3, label %L4
L3:
  %t16 = load ptr, ptr %t6
  %t18 = ptrtoint ptr %t16 to i64
  %t19 = sext i32 1 to i64
  %t20 = inttoptr i64 %t18 to ptr
  %t17 = getelementptr i8, ptr %t20, i64 %t19
  %t21 = load i64, ptr %t17
  %t23 = sext i32 10 to i64
  %t22 = icmp eq i64 %t21, %t23
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  %t26 = zext i1 %t25 to i64
  br label %L5
L4:
  br label %L5
L5:
  %t27 = phi i64 [ %t26, %L3 ], [ 0, %L4 ]
  %t28 = icmp ne i64 %t27, 0
  br i1 %t28, label %L6, label %L8
L6:
  %t29 = load ptr, ptr %t6
  %t31 = ptrtoint ptr %t29 to i64
  %t32 = sext i32 2 to i64
  %t30 = add i64 %t31, %t32
  store i64 %t30, ptr %t6
  br label %L0
L9:
  br label %L8
L8:
  %t33 = alloca i64
  call void @buf_init(ptr %t33)
  br label %L10
L10:
  %t35 = load ptr, ptr %t6
  %t36 = load i64, ptr %t35
  %t37 = icmp ne i64 %t36, 0
  br i1 %t37, label %L13, label %L14
L13:
  %t38 = load ptr, ptr %t6
  %t39 = load i64, ptr %t38
  %t41 = sext i32 10 to i64
  %t40 = icmp ne i64 %t39, %t41
  %t42 = zext i1 %t40 to i64
  %t43 = icmp ne i64 %t42, 0
  %t44 = zext i1 %t43 to i64
  br label %L15
L14:
  br label %L15
L15:
  %t45 = phi i64 [ %t44, %L13 ], [ 0, %L14 ]
  %t46 = icmp ne i64 %t45, 0
  br i1 %t46, label %L11, label %L12
L11:
  %t47 = load ptr, ptr %t6
  %t48 = load i64, ptr %t47
  %t50 = sext i32 92 to i64
  %t49 = icmp eq i64 %t48, %t50
  %t51 = zext i1 %t49 to i64
  %t52 = icmp ne i64 %t51, 0
  br i1 %t52, label %L16, label %L17
L16:
  %t53 = load ptr, ptr %t6
  %t55 = ptrtoint ptr %t53 to i64
  %t56 = sext i32 1 to i64
  %t57 = inttoptr i64 %t55 to ptr
  %t54 = getelementptr i8, ptr %t57, i64 %t56
  %t58 = load i64, ptr %t54
  %t60 = sext i32 10 to i64
  %t59 = icmp eq i64 %t58, %t60
  %t61 = zext i1 %t59 to i64
  %t62 = icmp ne i64 %t61, 0
  %t63 = zext i1 %t62 to i64
  br label %L18
L17:
  br label %L18
L18:
  %t64 = phi i64 [ %t63, %L16 ], [ 0, %L17 ]
  %t65 = icmp ne i64 %t64, 0
  br i1 %t65, label %L19, label %L21
L19:
  %t66 = load ptr, ptr %t6
  %t68 = ptrtoint ptr %t66 to i64
  %t69 = sext i32 2 to i64
  %t67 = add i64 %t68, %t69
  store i64 %t67, ptr %t6
  br label %L10
L22:
  br label %L21
L21:
  %t70 = load ptr, ptr %t6
  %t71 = load i64, ptr %t70
  %t73 = sext i32 39 to i64
  %t72 = icmp eq i64 %t71, %t73
  %t74 = zext i1 %t72 to i64
  %t75 = icmp ne i64 %t74, 0
  br i1 %t75, label %L23, label %L25
L23:
  %t76 = load ptr, ptr %t6
  %t78 = ptrtoint ptr %t76 to i64
  %t77 = add i64 %t78, 1
  store i64 %t77, ptr %t6
  %t79 = load i64, ptr %t76
  call void @buf_putc(ptr %t33, i64 %t79)
  %t81 = load ptr, ptr %t6
  %t82 = load i64, ptr %t81
  %t84 = sext i32 92 to i64
  %t83 = icmp eq i64 %t82, %t84
  %t85 = zext i1 %t83 to i64
  %t86 = icmp ne i64 %t85, 0
  br i1 %t86, label %L26, label %L27
L26:
  %t87 = load ptr, ptr %t6
  %t89 = ptrtoint ptr %t87 to i64
  %t90 = sext i32 1 to i64
  %t91 = inttoptr i64 %t89 to ptr
  %t88 = getelementptr i8, ptr %t91, i64 %t90
  %t92 = load i64, ptr %t88
  %t93 = icmp ne i64 %t92, 0
  %t94 = zext i1 %t93 to i64
  br label %L28
L27:
  br label %L28
L28:
  %t95 = phi i64 [ %t94, %L26 ], [ 0, %L27 ]
  %t96 = icmp ne i64 %t95, 0
  br i1 %t96, label %L29, label %L30
L29:
  %t97 = load ptr, ptr %t6
  %t99 = ptrtoint ptr %t97 to i64
  %t100 = sext i32 1 to i64
  %t101 = inttoptr i64 %t99 to ptr
  %t98 = getelementptr i8, ptr %t101, i64 %t100
  %t102 = load i64, ptr %t98
  %t104 = sext i32 10 to i64
  %t103 = icmp ne i64 %t102, %t104
  %t105 = zext i1 %t103 to i64
  %t106 = icmp ne i64 %t105, 0
  %t107 = zext i1 %t106 to i64
  br label %L31
L30:
  br label %L31
L31:
  %t108 = phi i64 [ %t107, %L29 ], [ 0, %L30 ]
  %t109 = icmp ne i64 %t108, 0
  br i1 %t109, label %L32, label %L34
L32:
  %t110 = load ptr, ptr %t6
  %t112 = ptrtoint ptr %t110 to i64
  %t111 = add i64 %t112, 1
  store i64 %t111, ptr %t6
  %t113 = load i64, ptr %t110
  call void @buf_putc(ptr %t33, i64 %t113)
  br label %L34
L34:
  %t115 = load ptr, ptr %t6
  %t116 = load i64, ptr %t115
  %t117 = icmp ne i64 %t116, 0
  br i1 %t117, label %L35, label %L36
L35:
  %t118 = load ptr, ptr %t6
  %t119 = load i64, ptr %t118
  %t121 = sext i32 10 to i64
  %t120 = icmp ne i64 %t119, %t121
  %t122 = zext i1 %t120 to i64
  %t123 = icmp ne i64 %t122, 0
  %t124 = zext i1 %t123 to i64
  br label %L37
L36:
  br label %L37
L37:
  %t125 = phi i64 [ %t124, %L35 ], [ 0, %L36 ]
  %t126 = icmp ne i64 %t125, 0
  br i1 %t126, label %L38, label %L40
L38:
  %t127 = load ptr, ptr %t6
  %t129 = ptrtoint ptr %t127 to i64
  %t128 = add i64 %t129, 1
  store i64 %t128, ptr %t6
  %t130 = load i64, ptr %t127
  call void @buf_putc(ptr %t33, i64 %t130)
  br label %L40
L40:
  %t132 = load ptr, ptr %t6
  %t133 = load i64, ptr %t132
  %t135 = sext i32 39 to i64
  %t134 = icmp eq i64 %t133, %t135
  %t136 = zext i1 %t134 to i64
  %t137 = icmp ne i64 %t136, 0
  br i1 %t137, label %L41, label %L43
L41:
  %t138 = load ptr, ptr %t6
  %t140 = ptrtoint ptr %t138 to i64
  %t139 = add i64 %t140, 1
  store i64 %t139, ptr %t6
  %t141 = load i64, ptr %t138
  call void @buf_putc(ptr %t33, i64 %t141)
  br label %L43
L43:
  br label %L10
L44:
  br label %L25
L25:
  %t143 = load ptr, ptr %t6
  %t144 = load i64, ptr %t143
  %t146 = sext i32 34 to i64
  %t145 = icmp eq i64 %t144, %t146
  %t147 = zext i1 %t145 to i64
  %t148 = icmp ne i64 %t147, 0
  br i1 %t148, label %L45, label %L47
L45:
  %t149 = load ptr, ptr %t6
  %t151 = ptrtoint ptr %t149 to i64
  %t150 = add i64 %t151, 1
  store i64 %t150, ptr %t6
  %t152 = load i64, ptr %t149
  call void @buf_putc(ptr %t33, i64 %t152)
  br label %L48
L48:
  %t154 = load ptr, ptr %t6
  %t155 = load i64, ptr %t154
  %t156 = icmp ne i64 %t155, 0
  br i1 %t156, label %L51, label %L52
L51:
  %t157 = load ptr, ptr %t6
  %t158 = load i64, ptr %t157
  %t160 = sext i32 34 to i64
  %t159 = icmp ne i64 %t158, %t160
  %t161 = zext i1 %t159 to i64
  %t162 = icmp ne i64 %t161, 0
  %t163 = zext i1 %t162 to i64
  br label %L53
L52:
  br label %L53
L53:
  %t164 = phi i64 [ %t163, %L51 ], [ 0, %L52 ]
  %t165 = icmp ne i64 %t164, 0
  br i1 %t165, label %L54, label %L55
L54:
  %t166 = load ptr, ptr %t6
  %t167 = load i64, ptr %t166
  %t169 = sext i32 10 to i64
  %t168 = icmp ne i64 %t167, %t169
  %t170 = zext i1 %t168 to i64
  %t171 = icmp ne i64 %t170, 0
  %t172 = zext i1 %t171 to i64
  br label %L56
L55:
  br label %L56
L56:
  %t173 = phi i64 [ %t172, %L54 ], [ 0, %L55 ]
  %t174 = icmp ne i64 %t173, 0
  br i1 %t174, label %L49, label %L50
L49:
  %t175 = load ptr, ptr %t6
  %t176 = load i64, ptr %t175
  %t178 = sext i32 92 to i64
  %t177 = icmp eq i64 %t176, %t178
  %t179 = zext i1 %t177 to i64
  %t180 = icmp ne i64 %t179, 0
  br i1 %t180, label %L57, label %L58
L57:
  %t181 = load ptr, ptr %t6
  %t183 = ptrtoint ptr %t181 to i64
  %t184 = sext i32 1 to i64
  %t185 = inttoptr i64 %t183 to ptr
  %t182 = getelementptr i8, ptr %t185, i64 %t184
  %t186 = load i64, ptr %t182
  %t187 = icmp ne i64 %t186, 0
  %t188 = zext i1 %t187 to i64
  br label %L59
L58:
  br label %L59
L59:
  %t189 = phi i64 [ %t188, %L57 ], [ 0, %L58 ]
  %t190 = icmp ne i64 %t189, 0
  br i1 %t190, label %L60, label %L62
L60:
  %t191 = load ptr, ptr %t6
  %t193 = ptrtoint ptr %t191 to i64
  %t192 = add i64 %t193, 1
  store i64 %t192, ptr %t6
  %t194 = load i64, ptr %t191
  call void @buf_putc(ptr %t33, i64 %t194)
  br label %L62
L62:
  %t196 = load ptr, ptr %t6
  %t198 = ptrtoint ptr %t196 to i64
  %t197 = add i64 %t198, 1
  store i64 %t197, ptr %t6
  %t199 = load i64, ptr %t196
  call void @buf_putc(ptr %t33, i64 %t199)
  br label %L48
L50:
  %t201 = load ptr, ptr %t6
  %t202 = load i64, ptr %t201
  %t204 = sext i32 34 to i64
  %t203 = icmp eq i64 %t202, %t204
  %t205 = zext i1 %t203 to i64
  %t206 = icmp ne i64 %t205, 0
  br i1 %t206, label %L63, label %L65
L63:
  %t207 = load ptr, ptr %t6
  %t209 = ptrtoint ptr %t207 to i64
  %t208 = add i64 %t209, 1
  store i64 %t208, ptr %t6
  %t210 = load i64, ptr %t207
  call void @buf_putc(ptr %t33, i64 %t210)
  br label %L65
L65:
  br label %L10
L66:
  br label %L47
L47:
  %t212 = load ptr, ptr %t6
  %t213 = load i64, ptr %t212
  %t215 = sext i32 47 to i64
  %t214 = icmp eq i64 %t213, %t215
  %t216 = zext i1 %t214 to i64
  %t217 = icmp ne i64 %t216, 0
  br i1 %t217, label %L67, label %L68
L67:
  %t218 = load ptr, ptr %t6
  %t220 = ptrtoint ptr %t218 to i64
  %t221 = sext i32 1 to i64
  %t222 = inttoptr i64 %t220 to ptr
  %t219 = getelementptr i8, ptr %t222, i64 %t221
  %t223 = load i64, ptr %t219
  %t225 = sext i32 47 to i64
  %t224 = icmp eq i64 %t223, %t225
  %t226 = zext i1 %t224 to i64
  %t227 = icmp ne i64 %t226, 0
  %t228 = zext i1 %t227 to i64
  br label %L69
L68:
  br label %L69
L69:
  %t229 = phi i64 [ %t228, %L67 ], [ 0, %L68 ]
  %t230 = icmp ne i64 %t229, 0
  br i1 %t230, label %L70, label %L72
L70:
  br label %L73
L73:
  %t231 = load ptr, ptr %t6
  %t232 = load i64, ptr %t231
  %t233 = icmp ne i64 %t232, 0
  br i1 %t233, label %L76, label %L77
L76:
  %t234 = load ptr, ptr %t6
  %t235 = load i64, ptr %t234
  %t237 = sext i32 10 to i64
  %t236 = icmp ne i64 %t235, %t237
  %t238 = zext i1 %t236 to i64
  %t239 = icmp ne i64 %t238, 0
  %t240 = zext i1 %t239 to i64
  br label %L78
L77:
  br label %L78
L78:
  %t241 = phi i64 [ %t240, %L76 ], [ 0, %L77 ]
  %t242 = icmp ne i64 %t241, 0
  br i1 %t242, label %L74, label %L75
L74:
  %t243 = load ptr, ptr %t6
  %t245 = ptrtoint ptr %t243 to i64
  %t244 = add i64 %t245, 1
  store i64 %t244, ptr %t6
  br label %L73
L75:
  br label %L12
L79:
  br label %L72
L72:
  %t246 = load ptr, ptr %t6
  %t247 = load i64, ptr %t246
  %t249 = sext i32 47 to i64
  %t248 = icmp eq i64 %t247, %t249
  %t250 = zext i1 %t248 to i64
  %t251 = icmp ne i64 %t250, 0
  br i1 %t251, label %L80, label %L81
L80:
  %t252 = load ptr, ptr %t6
  %t254 = ptrtoint ptr %t252 to i64
  %t255 = sext i32 1 to i64
  %t256 = inttoptr i64 %t254 to ptr
  %t253 = getelementptr i8, ptr %t256, i64 %t255
  %t257 = load i64, ptr %t253
  %t259 = sext i32 42 to i64
  %t258 = icmp eq i64 %t257, %t259
  %t260 = zext i1 %t258 to i64
  %t261 = icmp ne i64 %t260, 0
  %t262 = zext i1 %t261 to i64
  br label %L82
L81:
  br label %L82
L82:
  %t263 = phi i64 [ %t262, %L80 ], [ 0, %L81 ]
  %t264 = icmp ne i64 %t263, 0
  br i1 %t264, label %L83, label %L85
L83:
  %t265 = load ptr, ptr %t6
  %t267 = ptrtoint ptr %t265 to i64
  %t268 = sext i32 2 to i64
  %t266 = add i64 %t267, %t268
  store i64 %t266, ptr %t6
  br label %L86
L86:
  %t269 = load ptr, ptr %t6
  %t270 = load i64, ptr %t269
  %t271 = icmp ne i64 %t270, 0
  br i1 %t271, label %L89, label %L90
L89:
  %t272 = load ptr, ptr %t6
  %t273 = load i64, ptr %t272
  %t275 = sext i32 42 to i64
  %t274 = icmp eq i64 %t273, %t275
  %t276 = zext i1 %t274 to i64
  %t277 = icmp ne i64 %t276, 0
  br i1 %t277, label %L92, label %L93
L92:
  %t278 = load ptr, ptr %t6
  %t280 = ptrtoint ptr %t278 to i64
  %t281 = sext i32 1 to i64
  %t282 = inttoptr i64 %t280 to ptr
  %t279 = getelementptr i8, ptr %t282, i64 %t281
  %t283 = load i64, ptr %t279
  %t285 = sext i32 47 to i64
  %t284 = icmp eq i64 %t283, %t285
  %t286 = zext i1 %t284 to i64
  %t287 = icmp ne i64 %t286, 0
  %t288 = zext i1 %t287 to i64
  br label %L94
L93:
  br label %L94
L94:
  %t289 = phi i64 [ %t288, %L92 ], [ 0, %L93 ]
  %t291 = icmp eq i64 %t289, 0
  %t290 = zext i1 %t291 to i64
  %t292 = icmp ne i64 %t290, 0
  %t293 = zext i1 %t292 to i64
  br label %L91
L90:
  br label %L91
L91:
  %t294 = phi i64 [ %t293, %L89 ], [ 0, %L90 ]
  %t295 = icmp ne i64 %t294, 0
  br i1 %t295, label %L87, label %L88
L87:
  %t296 = load ptr, ptr %t6
  %t297 = load i64, ptr %t296
  %t299 = sext i32 10 to i64
  %t298 = icmp eq i64 %t297, %t299
  %t300 = zext i1 %t298 to i64
  %t301 = icmp ne i64 %t300, 0
  br i1 %t301, label %L95, label %L97
L95:
  call void @buf_putc(ptr %t33, i64 32)
  br label %L97
L97:
  %t303 = load ptr, ptr %t6
  %t305 = ptrtoint ptr %t303 to i64
  %t304 = add i64 %t305, 1
  store i64 %t304, ptr %t6
  br label %L86
L88:
  %t306 = load ptr, ptr %t6
  %t307 = load i64, ptr %t306
  %t308 = icmp ne i64 %t307, 0
  br i1 %t308, label %L98, label %L100
L98:
  %t309 = load ptr, ptr %t6
  %t311 = ptrtoint ptr %t309 to i64
  %t312 = sext i32 2 to i64
  %t310 = add i64 %t311, %t312
  store i64 %t310, ptr %t6
  br label %L100
L100:
  br label %L10
L101:
  br label %L85
L85:
  %t313 = load ptr, ptr %t6
  %t315 = ptrtoint ptr %t313 to i64
  %t314 = add i64 %t315, 1
  store i64 %t314, ptr %t6
  %t316 = load i64, ptr %t313
  call void @buf_putc(ptr %t33, i64 %t316)
  br label %L10
L12:
  %t318 = alloca ptr
  %t319 = load ptr, ptr %t33
  store ptr %t319, ptr %t318
  %t320 = load ptr, ptr %t6
  %t321 = load i64, ptr %t320
  %t323 = sext i32 10 to i64
  %t322 = icmp eq i64 %t321, %t323
  %t324 = zext i1 %t322 to i64
  %t325 = icmp ne i64 %t324, 0
  br i1 %t325, label %L102, label %L104
L102:
  %t326 = load ptr, ptr %t6
  %t328 = ptrtoint ptr %t326 to i64
  %t327 = add i64 %t328, 1
  store i64 %t327, ptr %t6
  br label %L104
L104:
  %t329 = alloca ptr
  %t330 = load ptr, ptr %t318
  %t331 = call ptr @skip_ws(ptr %t330)
  store ptr %t331, ptr %t329
  %t332 = load ptr, ptr %t329
  %t333 = load i64, ptr %t332
  %t335 = sext i32 35 to i64
  %t334 = icmp eq i64 %t333, %t335
  %t336 = zext i1 %t334 to i64
  %t337 = icmp ne i64 %t336, 0
  br i1 %t337, label %L105, label %L106
L105:
  %t338 = load ptr, ptr %t329
  call void @process_directive(ptr %t338, ptr %t1, ptr %t2, i64 %t3, ptr %t4, ptr %t5)
  br label %L107
L106:
  %t340 = alloca i64
  %t341 = sext i32 1 to i64
  store i64 %t341, ptr %t340
  %t342 = alloca i64
  %t343 = sext i32 0 to i64
  store i64 %t343, ptr %t342
  br label %L108
L108:
  %t344 = load i64, ptr %t342
  %t345 = load i64, ptr %t5
  %t346 = icmp slt i64 %t344, %t345
  %t347 = zext i1 %t346 to i64
  %t348 = icmp ne i64 %t347, 0
  br i1 %t348, label %L109, label %L111
L109:
  %t349 = load i64, ptr %t342
  %t350 = getelementptr ptr, ptr %t4, i64 %t349
  %t351 = load ptr, ptr %t350
  %t353 = ptrtoint ptr %t351 to i64
  %t354 = icmp eq i64 %t353, 0
  %t352 = zext i1 %t354 to i64
  %t355 = icmp ne i64 %t352, 0
  br i1 %t355, label %L112, label %L114
L112:
  %t356 = sext i32 0 to i64
  store i64 %t356, ptr %t340
  br label %L111
L115:
  br label %L114
L114:
  br label %L110
L110:
  %t357 = load i64, ptr %t342
  %t358 = add i64 %t357, 1
  store i64 %t358, ptr %t342
  br label %L108
L111:
  %t359 = load i64, ptr %t340
  %t360 = icmp ne i64 %t359, 0
  br i1 %t360, label %L116, label %L117
L116:
  %t361 = load ptr, ptr %t318
  call void @expand_text(ptr %t361, ptr %t2, i64 0)
  call void @buf_putc(ptr %t2, i64 10)
  br label %L118
L117:
  call void @buf_putc(ptr %t2, i64 10)
  br label %L118
L118:
  br label %L107
L107:
  %t365 = load ptr, ptr %t318
  call void @free(ptr %t365)
  br label %L0
L2:
  ret void
}

define dso_local ptr @macro_preprocess(ptr %t0, ptr %t1, i64 %t2) {
entry:
  call void @macros_init()
  %t4 = alloca i64
  call void @buf_init(ptr %t4)
  %t6 = alloca ptr
  %t7 = sext i32 0 to i64
  store i64 %t7, ptr %t6
  %t8 = alloca i64
  %t9 = sext i32 0 to i64
  store i64 %t9, ptr %t8
  %t11 = sext i32 0 to i64
  %t10 = icmp eq i64 %t2, %t11
  %t12 = zext i1 %t10 to i64
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L0, label %L2
L0:
  %t14 = getelementptr [8 x i8], ptr @.str23, i64 0, i64 0
  %t15 = getelementptr [2 x i8], ptr @.str24, i64 0, i64 0
  %t17 = sext i32 0 to i64
  %t16 = inttoptr i64 %t17 to ptr
  call void @macro_define(ptr %t14, ptr %t15, ptr %t16, i64 0, i64 0)
  %t19 = getelementptr [9 x i8], ptr @.str25, i64 0, i64 0
  %t20 = getelementptr [2 x i8], ptr @.str26, i64 0, i64 0
  %t22 = sext i32 0 to i64
  %t21 = inttoptr i64 %t22 to ptr
  call void @macro_define(ptr %t19, ptr %t20, ptr %t21, i64 0, i64 0)
  %t24 = getelementptr [5 x i8], ptr @.str27, i64 0, i64 0
  %t25 = getelementptr [11 x i8], ptr @.str28, i64 0, i64 0
  %t27 = sext i32 0 to i64
  %t26 = inttoptr i64 %t27 to ptr
  call void @macro_define(ptr %t24, ptr %t25, ptr %t26, i64 0, i64 0)
  %t29 = getelementptr [9 x i8], ptr @.str29, i64 0, i64 0
  %t30 = getelementptr [2 x i8], ptr @.str30, i64 0, i64 0
  %t32 = sext i32 0 to i64
  %t31 = inttoptr i64 %t32 to ptr
  call void @macro_define(ptr %t29, ptr %t30, ptr %t31, i64 0, i64 0)
  %t34 = getelementptr [9 x i8], ptr @.str31, i64 0, i64 0
  %t35 = getelementptr [2 x i8], ptr @.str32, i64 0, i64 0
  %t37 = sext i32 0 to i64
  %t36 = inttoptr i64 %t37 to ptr
  call void @macro_define(ptr %t34, ptr %t35, ptr %t36, i64 0, i64 0)
  %t39 = getelementptr [9 x i8], ptr @.str33, i64 0, i64 0
  %t40 = getelementptr [2 x i8], ptr @.str34, i64 0, i64 0
  %t42 = sext i32 0 to i64
  %t41 = inttoptr i64 %t42 to ptr
  call void @macro_define(ptr %t39, ptr %t40, ptr %t41, i64 0, i64 0)
  %t44 = getelementptr [9 x i8], ptr @.str35, i64 0, i64 0
  %t45 = getelementptr [2 x i8], ptr @.str36, i64 0, i64 0
  %t47 = sext i32 0 to i64
  %t46 = inttoptr i64 %t47 to ptr
  call void @macro_define(ptr %t44, ptr %t45, ptr %t46, i64 0, i64 0)
  %t49 = getelementptr [4 x i8], ptr @.str37, i64 0, i64 0
  %t50 = getelementptr [5 x i8], ptr @.str38, i64 0, i64 0
  %t52 = sext i32 0 to i64
  %t51 = inttoptr i64 %t52 to ptr
  call void @macro_define(ptr %t49, ptr %t50, ptr %t51, i64 0, i64 0)
  %t54 = getelementptr [13 x i8], ptr @.str39, i64 0, i64 0
  %t55 = getelementptr [2 x i8], ptr @.str40, i64 0, i64 0
  %t57 = sext i32 0 to i64
  %t56 = inttoptr i64 %t57 to ptr
  call void @macro_define(ptr %t54, ptr %t55, ptr %t56, i64 0, i64 0)
  %t59 = getelementptr [13 x i8], ptr @.str41, i64 0, i64 0
  %t60 = getelementptr [2 x i8], ptr @.str42, i64 0, i64 0
  %t62 = sext i32 0 to i64
  %t61 = inttoptr i64 %t62 to ptr
  call void @macro_define(ptr %t59, ptr %t60, ptr %t61, i64 0, i64 0)
  %t64 = getelementptr [7 x i8], ptr @.str43, i64 0, i64 0
  %t65 = getelementptr [10 x i8], ptr @.str44, i64 0, i64 0
  %t67 = sext i32 0 to i64
  %t66 = inttoptr i64 %t67 to ptr
  call void @macro_define(ptr %t64, ptr %t65, ptr %t66, i64 0, i64 0)
  %t69 = getelementptr [9 x i8], ptr @.str45, i64 0, i64 0
  %t70 = getelementptr [15 x i8], ptr @.str46, i64 0, i64 0
  %t72 = sext i32 0 to i64
  %t71 = inttoptr i64 %t72 to ptr
  call void @macro_define(ptr %t69, ptr %t70, ptr %t71, i64 0, i64 0)
  %t74 = getelementptr [7 x i8], ptr @.str47, i64 0, i64 0
  %t75 = getelementptr [13 x i8], ptr @.str48, i64 0, i64 0
  %t77 = sext i32 0 to i64
  %t76 = inttoptr i64 %t77 to ptr
  call void @macro_define(ptr %t74, ptr %t75, ptr %t76, i64 0, i64 0)
  %t79 = getelementptr [8 x i8], ptr @.str49, i64 0, i64 0
  %t80 = getelementptr [14 x i8], ptr @.str50, i64 0, i64 0
  %t82 = sext i32 0 to i64
  %t81 = inttoptr i64 %t82 to ptr
  call void @macro_define(ptr %t79, ptr %t80, ptr %t81, i64 0, i64 0)
  %t84 = getelementptr [7 x i8], ptr @.str51, i64 0, i64 0
  %t85 = getelementptr [15 x i8], ptr @.str52, i64 0, i64 0
  %t87 = sext i32 0 to i64
  %t86 = inttoptr i64 %t87 to ptr
  call void @macro_define(ptr %t84, ptr %t85, ptr %t86, i64 0, i64 0)
  %t89 = getelementptr [7 x i8], ptr @.str53, i64 0, i64 0
  %t90 = getelementptr [15 x i8], ptr @.str54, i64 0, i64 0
  %t92 = sext i32 0 to i64
  %t91 = inttoptr i64 %t92 to ptr
  call void @macro_define(ptr %t89, ptr %t90, ptr %t91, i64 0, i64 0)
  %t94 = getelementptr [6 x i8], ptr @.str55, i64 0, i64 0
  %t95 = getelementptr [14 x i8], ptr @.str56, i64 0, i64 0
  %t97 = sext i32 0 to i64
  %t96 = inttoptr i64 %t97 to ptr
  call void @macro_define(ptr %t94, ptr %t95, ptr %t96, i64 0, i64 0)
  br label %L2
L2:
  %t99 = load ptr, ptr %t6
  call void @preprocess_into(ptr %t0, ptr %t1, ptr %t4, i64 %t2, ptr %t99, ptr %t8)
  %t101 = load ptr, ptr %t4
  ret ptr %t101
L3:
  ret ptr null
}

@.str0 = private unnamed_addr constant [7 x i8] c"malloc\00"
@.str1 = private unnamed_addr constant [8 x i8] c"realloc\00"
@.str2 = private unnamed_addr constant [18 x i8] c"macro table full\0A\00"
@.str3 = private unnamed_addr constant [4 x i8] c"...\00"
@.str4 = private unnamed_addr constant [12 x i8] c"__VA_ARGS__\00"
@.str5 = private unnamed_addr constant [2 x i8] c"r\00"
@.str6 = private unnamed_addr constant [13 x i8] c"/usr/include\00"
@.str7 = private unnamed_addr constant [19 x i8] c"/usr/local/include\00"
@.str8 = private unnamed_addr constant [2 x i8] c".\00"
@.str9 = private unnamed_addr constant [6 x i8] c"%s/%s\00"
@.str10 = private unnamed_addr constant [6 x i8] c"ifdef\00"
@.str11 = private unnamed_addr constant [7 x i8] c"ifndef\00"
@.str12 = private unnamed_addr constant [3 x i8] c"if\00"
@.str13 = private unnamed_addr constant [8 x i8] c"defined\00"
@.str14 = private unnamed_addr constant [5 x i8] c"elif\00"
@.str15 = private unnamed_addr constant [5 x i8] c"else\00"
@.str16 = private unnamed_addr constant [6 x i8] c"endif\00"
@.str17 = private unnamed_addr constant [7 x i8] c"define\00"
@.str18 = private unnamed_addr constant [6 x i8] c"undef\00"
@.str19 = private unnamed_addr constant [8 x i8] c"include\00"
@.str20 = private unnamed_addr constant [36 x i8] c"warning: max include depth reached\0A\00"
@.str21 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str22 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str23 = private unnamed_addr constant [8 x i8] c"__C0C__\00"
@.str24 = private unnamed_addr constant [2 x i8] c"1\00"
@.str25 = private unnamed_addr constant [9 x i8] c"__STDC__\00"
@.str26 = private unnamed_addr constant [2 x i8] c"1\00"
@.str27 = private unnamed_addr constant [5 x i8] c"NULL\00"
@.str28 = private unnamed_addr constant [11 x i8] c"((void*)0)\00"
@.str29 = private unnamed_addr constant [9 x i8] c"__LP64__\00"
@.str30 = private unnamed_addr constant [2 x i8] c"1\00"
@.str31 = private unnamed_addr constant [9 x i8] c"SEEK_SET\00"
@.str32 = private unnamed_addr constant [2 x i8] c"0\00"
@.str33 = private unnamed_addr constant [9 x i8] c"SEEK_CUR\00"
@.str34 = private unnamed_addr constant [2 x i8] c"1\00"
@.str35 = private unnamed_addr constant [9 x i8] c"SEEK_END\00"
@.str36 = private unnamed_addr constant [2 x i8] c"2\00"
@.str37 = private unnamed_addr constant [4 x i8] c"EOF\00"
@.str38 = private unnamed_addr constant [5 x i8] c"(-1)\00"
@.str39 = private unnamed_addr constant [13 x i8] c"EXIT_SUCCESS\00"
@.str40 = private unnamed_addr constant [2 x i8] c"0\00"
@.str41 = private unnamed_addr constant [13 x i8] c"EXIT_FAILURE\00"
@.str42 = private unnamed_addr constant [2 x i8] c"1\00"
@.str43 = private unnamed_addr constant [7 x i8] c"assert\00"
@.str44 = private unnamed_addr constant [10 x i8] c"((void)0)\00"
@.str45 = private unnamed_addr constant [9 x i8] c"va_start\00"
@.str46 = private unnamed_addr constant [15 x i8] c"__c0c_va_start\00"
@.str47 = private unnamed_addr constant [7 x i8] c"va_end\00"
@.str48 = private unnamed_addr constant [13 x i8] c"__c0c_va_end\00"
@.str49 = private unnamed_addr constant [8 x i8] c"va_copy\00"
@.str50 = private unnamed_addr constant [14 x i8] c"__c0c_va_copy\00"
@.str51 = private unnamed_addr constant [7 x i8] c"stderr\00"
@.str52 = private unnamed_addr constant [15 x i8] c"__c0c_stderr()\00"
@.str53 = private unnamed_addr constant [7 x i8] c"stdout\00"
@.str54 = private unnamed_addr constant [15 x i8] c"__c0c_stdout()\00"
@.str55 = private unnamed_addr constant [6 x i8] c"stdin\00"
@.str56 = private unnamed_addr constant [14 x i8] c"__c0c_stdin()\00"
