; ModuleID = 'ast.c'
source_filename = "ast.c"
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


define dso_local ptr @node_new(ptr %t0, i64 %t1) {
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
  %t9 = getelementptr [7 x i8], ptr @.str0, i64 0, i64 0
  %t10 = call i32 @perror(ptr %t9)
  %t11 = sext i32 %t10 to i64
  %t12 = call i32 @exit(i64 1)
  %t13 = sext i32 %t12 to i64
  br label %L2
L2:
  %t14 = load ptr, ptr %t2
  store ptr %t0, ptr %t14
  %t15 = load ptr, ptr %t2
  store i64 %t1, ptr %t15
  %t16 = load ptr, ptr %t2
  ret ptr %t16
L3:
  ret ptr null
}

define dso_local void @node_add_child(ptr %t0, ptr %t1) {
entry:
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t3 to i64
  %t6 = sext i32 1 to i64
  %t7 = inttoptr i64 %t5 to ptr
  %t4 = getelementptr i8, ptr %t7, i64 %t6
  %t9 = ptrtoint ptr %t4 to i64
  %t10 = sext i32 8 to i64
  %t8 = mul i64 %t9, %t10
  %t11 = call ptr @realloc(ptr %t2, i64 %t8)
  store ptr %t11, ptr %t0
  %t12 = load ptr, ptr %t0
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = icmp eq i64 %t14, 0
  %t13 = zext i1 %t15 to i64
  %t16 = icmp ne i64 %t13, 0
  br i1 %t16, label %L0, label %L2
L0:
  %t17 = getelementptr [8 x i8], ptr @.str1, i64 0, i64 0
  %t18 = call i32 @perror(ptr %t17)
  %t19 = sext i32 %t18 to i64
  %t20 = call i32 @exit(i64 1)
  %t21 = sext i32 %t20 to i64
  br label %L2
L2:
  %t22 = load ptr, ptr %t0
  %t23 = load ptr, ptr %t0
  %t25 = ptrtoint ptr %t23 to i64
  %t24 = add i64 %t25, 1
  store i64 %t24, ptr %t0
  %t27 = ptrtoint ptr %t23 to i64
  %t26 = getelementptr i8, ptr %t22, i64 %t27
  store ptr %t1, ptr %t26
  ret void
}

define dso_local void @node_free(ptr %t0) {
entry:
  %t2 = ptrtoint ptr %t0 to i64
  %t3 = icmp eq i64 %t2, 0
  %t1 = zext i1 %t3 to i64
  %t4 = icmp ne i64 %t1, 0
  br i1 %t4, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  br label %L4
L4:
  %t7 = load i64, ptr %t5
  %t8 = load ptr, ptr %t0
  %t10 = ptrtoint ptr %t8 to i64
  %t9 = icmp slt i64 %t7, %t10
  %t11 = zext i1 %t9 to i64
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L5, label %L7
L5:
  %t13 = load ptr, ptr %t0
  %t14 = load i64, ptr %t5
  %t15 = getelementptr i32, ptr %t13, i64 %t14
  %t16 = load i64, ptr %t15
  call void @node_free(i64 %t16)
  br label %L6
L6:
  %t18 = load i64, ptr %t5
  %t19 = add i64 %t18, 1
  store i64 %t19, ptr %t5
  br label %L4
L7:
  %t20 = load ptr, ptr %t0
  %t21 = call i32 @free(ptr %t20)
  %t22 = sext i32 %t21 to i64
  %t23 = load ptr, ptr %t0
  %t24 = call i32 @free(ptr %t23)
  %t25 = sext i32 %t24 to i64
  %t26 = load ptr, ptr %t0
  %t27 = call i32 @free(ptr %t26)
  %t28 = sext i32 %t27 to i64
  %t29 = load ptr, ptr %t0
  %t30 = call i32 @free(ptr %t29)
  %t31 = sext i32 %t30 to i64
  %t32 = load ptr, ptr %t0
  %t33 = call i32 @free(ptr %t32)
  %t34 = sext i32 %t33 to i64
  %t35 = call i32 @free(ptr %t0)
  %t36 = sext i32 %t35 to i64
  ret void
}

define dso_local ptr @type_new(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @calloc(i64 1, i64 8)
  store ptr %t2, ptr %t1
  %t3 = load ptr, ptr %t1
  %t5 = ptrtoint ptr %t3 to i64
  %t6 = icmp eq i64 %t5, 0
  %t4 = zext i1 %t6 to i64
  %t7 = icmp ne i64 %t4, 0
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = getelementptr [7 x i8], ptr @.str2, i64 0, i64 0
  %t9 = call i32 @perror(ptr %t8)
  %t10 = sext i32 %t9 to i64
  %t11 = call i32 @exit(i64 1)
  %t12 = sext i32 %t11 to i64
  br label %L2
L2:
  %t13 = load ptr, ptr %t1
  store ptr %t0, ptr %t13
  %t15 = sext i32 1 to i64
  %t14 = sub i64 0, %t15
  %t16 = load ptr, ptr %t1
  store i64 %t14, ptr %t16
  %t17 = load ptr, ptr %t1
  ret ptr %t17
L3:
  ret ptr null
}

define dso_local ptr @type_ptr(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @type_new(i64 15)
  store ptr %t2, ptr %t1
  %t3 = load ptr, ptr %t1
  store ptr %t0, ptr %t3
  %t4 = load ptr, ptr %t1
  ret ptr %t4
L0:
  ret ptr null
}

define dso_local ptr @type_array(ptr %t0, i64 %t1) {
entry:
  %t2 = alloca ptr
  %t3 = call ptr @type_new(i64 16)
  store ptr %t3, ptr %t2
  %t4 = load ptr, ptr %t2
  store ptr %t0, ptr %t4
  %t5 = load ptr, ptr %t2
  store i64 %t1, ptr %t5
  %t6 = load ptr, ptr %t2
  ret ptr %t6
L0:
  ret ptr null
}

define dso_local void @type_free(ptr %t0) {
entry:
  %t2 = ptrtoint ptr %t0 to i64
  %t3 = icmp eq i64 %t2, 0
  %t1 = zext i1 %t3 to i64
  %t4 = icmp ne i64 %t1, 0
  br i1 %t4, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %t5 = load ptr, ptr %t0
  %t6 = call i32 @free(ptr %t5)
  %t7 = sext i32 %t6 to i64
  %t8 = load ptr, ptr %t0
  %t9 = call i32 @free(ptr %t8)
  %t10 = sext i32 %t9 to i64
  %t11 = load ptr, ptr %t0
  %t12 = icmp ne ptr %t11, null
  br i1 %t12, label %L4, label %L6
L4:
  %t13 = alloca i64
  %t14 = sext i32 0 to i64
  store i64 %t14, ptr %t13
  br label %L7
L7:
  %t15 = load i64, ptr %t13
  %t16 = load ptr, ptr %t0
  %t18 = ptrtoint ptr %t16 to i64
  %t17 = icmp slt i64 %t15, %t18
  %t19 = zext i1 %t17 to i64
  %t20 = icmp ne i64 %t19, 0
  br i1 %t20, label %L8, label %L10
L8:
  %t21 = load ptr, ptr %t0
  %t22 = load i64, ptr %t13
  %t23 = getelementptr i8, ptr %t21, i64 %t22
  %t24 = load ptr, ptr %t23
  %t25 = call i32 @free(ptr %t24)
  %t26 = sext i32 %t25 to i64
  br label %L9
L9:
  %t27 = load i64, ptr %t13
  %t28 = add i64 %t27, 1
  store i64 %t28, ptr %t13
  br label %L7
L10:
  %t29 = load ptr, ptr %t0
  %t30 = call i32 @free(ptr %t29)
  %t31 = sext i32 %t30 to i64
  br label %L6
L6:
  %t32 = call i32 @free(ptr %t0)
  %t33 = sext i32 %t32 to i64
  ret void
}

define dso_local i32 @type_is_integer(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = ptrtoint ptr %t1 to i64
  %t3 = add i64 %t2, 0
  switch i64 %t3, label %L14 [
    i64 1, label %L1
    i64 2, label %L2
    i64 3, label %L3
    i64 4, label %L4
    i64 5, label %L5
    i64 6, label %L6
    i64 7, label %L7
    i64 8, label %L8
    i64 9, label %L9
    i64 10, label %L10
    i64 11, label %L11
    i64 12, label %L12
    i64 20, label %L13
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
  %t4 = sext i32 1 to i64
  %t5 = trunc i64 %t4 to i32
  ret i32 %t5
L15:
  br label %L0
L14:
  %t6 = sext i32 0 to i64
  %t7 = trunc i64 %t6 to i32
  ret i32 %t7
L16:
  br label %L0
L0:
  ret i32 0
}

define dso_local i32 @type_is_float(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = sext i32 13 to i64
  %t2 = icmp eq i64 %t3, %t4
  %t5 = zext i1 %t2 to i64
  %t6 = load ptr, ptr %t0
  %t8 = ptrtoint ptr %t6 to i64
  %t9 = sext i32 14 to i64
  %t7 = icmp eq i64 %t8, %t9
  %t10 = zext i1 %t7 to i64
  %t12 = icmp ne i64 %t5, 0
  %t13 = icmp ne i64 %t10, 0
  %t14 = or i1 %t12, %t13
  %t15 = zext i1 %t14 to i64
  %t16 = trunc i64 %t15 to i32
  ret i32 %t16
L0:
  ret i32 0
}

define dso_local i32 @type_is_pointer(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = sext i32 15 to i64
  %t2 = icmp eq i64 %t3, %t4
  %t5 = zext i1 %t2 to i64
  %t6 = load ptr, ptr %t0
  %t8 = ptrtoint ptr %t6 to i64
  %t9 = sext i32 16 to i64
  %t7 = icmp eq i64 %t8, %t9
  %t10 = zext i1 %t7 to i64
  %t12 = icmp ne i64 %t5, 0
  %t13 = icmp ne i64 %t10, 0
  %t14 = or i1 %t12, %t13
  %t15 = zext i1 %t14 to i64
  %t16 = trunc i64 %t15 to i32
  ret i32 %t16
L0:
  ret i32 0
}

define dso_local i32 @type_size(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = ptrtoint ptr %t1 to i64
  %t3 = add i64 %t2, 0
  switch i64 %t3, label %L19 [
    i64 0, label %L1
    i64 1, label %L2
    i64 2, label %L3
    i64 3, label %L4
    i64 4, label %L5
    i64 5, label %L6
    i64 6, label %L7
    i64 7, label %L8
    i64 8, label %L9
    i64 13, label %L10
    i64 20, label %L11
    i64 9, label %L12
    i64 10, label %L13
    i64 11, label %L14
    i64 12, label %L15
    i64 14, label %L16
    i64 15, label %L17
    i64 16, label %L18
  ]
L1:
  %t4 = sext i32 0 to i64
  %t5 = trunc i64 %t4 to i32
  ret i32 %t5
L20:
  br label %L2
L2:
  br label %L3
L3:
  br label %L4
L4:
  br label %L5
L5:
  %t6 = sext i32 1 to i64
  %t7 = trunc i64 %t6 to i32
  ret i32 %t7
L21:
  br label %L6
L6:
  br label %L7
L7:
  %t8 = sext i32 2 to i64
  %t9 = trunc i64 %t8 to i32
  ret i32 %t9
L22:
  br label %L8
L8:
  br label %L9
L9:
  br label %L10
L10:
  br label %L11
L11:
  %t10 = sext i32 4 to i64
  %t11 = trunc i64 %t10 to i32
  ret i32 %t11
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
  %t12 = sext i32 8 to i64
  %t13 = trunc i64 %t12 to i32
  ret i32 %t13
L24:
  br label %L18
L18:
  %t14 = load ptr, ptr %t0
  %t16 = ptrtoint ptr %t14 to i64
  %t17 = sext i32 0 to i64
  %t15 = icmp slt i64 %t16, %t17
  %t18 = zext i1 %t15 to i64
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L25, label %L27
L25:
  %t20 = sext i32 0 to i64
  %t21 = trunc i64 %t20 to i32
  ret i32 %t21
L28:
  br label %L27
L27:
  %t22 = load ptr, ptr %t0
  %t23 = load ptr, ptr %t0
  %t24 = call i32 @type_size(ptr %t23)
  %t25 = sext i32 %t24 to i64
  %t27 = ptrtoint ptr %t22 to i64
  %t26 = mul i64 %t27, %t25
  %t28 = add i64 %t26, 0
  %t29 = trunc i64 %t28 to i32
  ret i32 %t29
L29:
  br label %L0
L19:
  %t30 = sext i32 0 to i64
  %t31 = trunc i64 %t30 to i32
  ret i32 %t31
L30:
  br label %L0
L0:
  ret i32 0
}

@.str0 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str1 = private unnamed_addr constant [8 x i8] c"realloc\00"
@.str2 = private unnamed_addr constant [7 x i8] c"calloc\00"
