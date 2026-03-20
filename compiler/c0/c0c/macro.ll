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

@macro_ptrs = internal global ptr zeroinitializer
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
  %t0 = load ptr, ptr @macro_ptrs
  %t2 = ptrtoint ptr %t0 to i64
  %t3 = icmp eq i64 %t2, 0
  %t1 = zext i1 %t3 to i64
  %t4 = icmp ne i64 %t1, 0
  br i1 %t4, label %L0, label %L2
L0:
  %t5 = call ptr @calloc(i64 512, i64 8)
  store ptr %t5, ptr @macro_ptrs
  br label %L2
L2:
  ret void
}

define internal ptr @macro_find(ptr %t0) {
entry:
  %t1 = load ptr, ptr @macro_ptrs
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = icmp eq i64 %t3, 0
  %t2 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t2, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t7 = sext i32 0 to i64
  %t6 = inttoptr i64 %t7 to ptr
  ret ptr %t6
L3:
  br label %L2
L2:
  %t8 = alloca i64
  %t9 = sext i32 0 to i64
  store i64 %t9, ptr %t8
  br label %L4
L4:
  %t10 = load i64, ptr %t8
  %t11 = load i64, ptr @n_macros
  %t12 = icmp slt i64 %t10, %t11
  %t13 = zext i1 %t12 to i64
  %t14 = icmp ne i64 %t13, 0
  br i1 %t14, label %L5, label %L7
L5:
  %t15 = alloca ptr
  %t16 = load ptr, ptr @macro_ptrs
  %t17 = load i64, ptr %t8
  %t18 = getelementptr ptr, ptr %t16, i64 %t17
  %t19 = load ptr, ptr %t18
  store ptr %t19, ptr %t15
  %t20 = load ptr, ptr %t15
  %t21 = ptrtoint ptr %t20 to i64
  %t22 = icmp ne i64 %t21, 0
  br i1 %t22, label %L8, label %L9
L8:
  %t23 = load ptr, ptr %t15
  %t24 = load ptr, ptr %t23
  %t25 = ptrtoint ptr %t24 to i64
  %t26 = icmp ne i64 %t25, 0
  %t27 = zext i1 %t26 to i64
  br label %L10
L9:
  br label %L10
L10:
  %t28 = phi i64 [ %t27, %L8 ], [ 0, %L9 ]
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L11, label %L12
L11:
  %t30 = load ptr, ptr %t15
  %t31 = load ptr, ptr %t30
  %t32 = call i32 @strcmp(ptr %t31, ptr %t0)
  %t33 = sext i32 %t32 to i64
  %t35 = sext i32 0 to i64
  %t34 = icmp eq i64 %t33, %t35
  %t36 = zext i1 %t34 to i64
  %t37 = icmp ne i64 %t36, 0
  %t38 = zext i1 %t37 to i64
  br label %L13
L12:
  br label %L13
L13:
  %t39 = phi i64 [ %t38, %L11 ], [ 0, %L12 ]
  %t40 = icmp ne i64 %t39, 0
  br i1 %t40, label %L14, label %L16
L14:
  %t41 = load ptr, ptr %t15
  ret ptr %t41
L17:
  br label %L16
L16:
  br label %L6
L6:
  %t42 = load i64, ptr %t8
  %t43 = add i64 %t42, 1
  store i64 %t43, ptr %t8
  br label %L4
L7:
  %t45 = sext i32 0 to i64
  %t44 = inttoptr i64 %t45 to ptr
  ret ptr %t44
L18:
  ret ptr null
}

define internal void @macro_define(ptr %t0, ptr %t1, ptr %t2, i64 %t3, i64 %t4) {
entry:
  %t5 = load ptr, ptr @macro_ptrs
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
  %t12 = sext i32 0 to i64
  store i64 %t12, ptr %t11
  br label %L3
L3:
  %t13 = load i64, ptr %t11
  %t14 = load i64, ptr @n_macros
  %t15 = icmp slt i64 %t13, %t14
  %t16 = zext i1 %t15 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L4, label %L6
L4:
  %t18 = alloca ptr
  %t19 = load ptr, ptr @macro_ptrs
  %t20 = load i64, ptr %t11
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  store ptr %t22, ptr %t18
  %t23 = load ptr, ptr %t18
  %t24 = ptrtoint ptr %t23 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L7, label %L8
L7:
  %t26 = load ptr, ptr %t18
  %t27 = load ptr, ptr %t26
  %t28 = call i32 @strcmp(ptr %t27, ptr %t0)
  %t29 = sext i32 %t28 to i64
  %t31 = sext i32 0 to i64
  %t30 = icmp eq i64 %t29, %t31
  %t32 = zext i1 %t30 to i64
  %t33 = icmp ne i64 %t32, 0
  %t34 = zext i1 %t33 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t35 = phi i64 [ %t34, %L7 ], [ 0, %L8 ]
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L10, label %L12
L10:
  %t37 = load ptr, ptr %t18
  %t38 = load ptr, ptr %t37
  call void @free(ptr %t38)
  %t40 = call ptr @strdup(ptr %t1)
  %t41 = load ptr, ptr %t18
  store ptr %t40, ptr %t41
  %t42 = load ptr, ptr %t18
  %t43 = sext i32 1 to i64
  store i64 %t43, ptr %t42
  ret void
L13:
  br label %L12
L12:
  br label %L5
L5:
  %t44 = load i64, ptr %t11
  %t45 = add i64 %t44, 1
  store i64 %t45, ptr %t11
  br label %L3
L6:
  %t46 = load i64, ptr @n_macros
  %t48 = sext i32 512 to i64
  %t47 = icmp sge i64 %t46, %t48
  %t49 = zext i1 %t47 to i64
  %t50 = icmp ne i64 %t49, 0
  br i1 %t50, label %L14, label %L16
L14:
  %t51 = call ptr @__c0c_stderr()
  %t52 = getelementptr [18 x i8], ptr @.str2, i64 0, i64 0
  %t53 = call i32 @fprintf(ptr %t51, ptr %t52)
  %t54 = sext i32 %t53 to i64
  ret void
L17:
  br label %L16
L16:
  %t55 = alloca ptr
  %t56 = call ptr @calloc(i64 1, i64 0)
  store ptr %t56, ptr %t55
  %t57 = call ptr @strdup(ptr %t0)
  %t58 = load ptr, ptr %t55
  store ptr %t57, ptr %t58
  %t59 = call ptr @strdup(ptr %t1)
  %t60 = load ptr, ptr %t55
  store ptr %t59, ptr %t60
  %t61 = load ptr, ptr %t55
  store i64 %t3, ptr %t61
  %t62 = load ptr, ptr %t55
  store i64 %t4, ptr %t62
  %t63 = load ptr, ptr %t55
  %t64 = sext i32 1 to i64
  store i64 %t64, ptr %t63
  %t65 = alloca i64
  %t66 = sext i32 0 to i64
  store i64 %t66, ptr %t65
  br label %L18
L18:
  %t67 = load i64, ptr %t65
  %t68 = icmp slt i64 %t67, %t3
  %t69 = zext i1 %t68 to i64
  %t70 = icmp ne i64 %t69, 0
  br i1 %t70, label %L22, label %L23
L22:
  %t71 = load i64, ptr %t65
  %t73 = sext i32 16 to i64
  %t72 = icmp slt i64 %t71, %t73
  %t74 = zext i1 %t72 to i64
  %t75 = icmp ne i64 %t74, 0
  %t76 = zext i1 %t75 to i64
  br label %L24
L23:
  br label %L24
L24:
  %t77 = phi i64 [ %t76, %L22 ], [ 0, %L23 ]
  %t78 = icmp ne i64 %t77, 0
  br i1 %t78, label %L19, label %L21
L19:
  %t79 = load i64, ptr %t65
  %t80 = getelementptr ptr, ptr %t2, i64 %t79
  %t81 = load ptr, ptr %t80
  %t82 = icmp ne ptr %t81, null
  br i1 %t82, label %L25, label %L26
L25:
  %t83 = load i64, ptr %t65
  %t84 = getelementptr ptr, ptr %t2, i64 %t83
  %t85 = load ptr, ptr %t84
  %t86 = call ptr @strdup(ptr %t85)
  %t87 = ptrtoint ptr %t86 to i64
  br label %L27
L26:
  %t89 = sext i32 0 to i64
  %t88 = inttoptr i64 %t89 to ptr
  %t90 = ptrtoint ptr %t88 to i64
  br label %L27
L27:
  %t91 = phi i64 [ %t87, %L25 ], [ %t90, %L26 ]
  %t92 = load ptr, ptr %t55
  %t93 = load ptr, ptr %t92
  %t94 = load i64, ptr %t65
  %t95 = getelementptr ptr, ptr %t93, i64 %t94
  store i64 %t91, ptr %t95
  br label %L20
L20:
  %t96 = load i64, ptr %t65
  %t97 = add i64 %t96, 1
  store i64 %t97, ptr %t65
  br label %L18
L21:
  %t98 = load ptr, ptr %t55
  %t99 = load ptr, ptr @macro_ptrs
  %t100 = load i64, ptr @n_macros
  %t101 = add i64 %t100, 1
  store i64 %t101, ptr @n_macros
  %t102 = getelementptr ptr, ptr %t99, i64 %t100
  store ptr %t98, ptr %t102
  ret void
}

define internal void @macro_undef(ptr %t0) {
entry:
  %t1 = load ptr, ptr @macro_ptrs
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
  %t7 = sext i32 0 to i64
  store i64 %t7, ptr %t6
  br label %L4
L4:
  %t8 = load i64, ptr %t6
  %t9 = load i64, ptr @n_macros
  %t10 = icmp slt i64 %t8, %t9
  %t11 = zext i1 %t10 to i64
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L5, label %L7
L5:
  %t13 = alloca ptr
  %t14 = load ptr, ptr @macro_ptrs
  %t15 = load i64, ptr %t6
  %t16 = getelementptr ptr, ptr %t14, i64 %t15
  %t17 = load ptr, ptr %t16
  store ptr %t17, ptr %t13
  %t18 = load ptr, ptr %t13
  %t19 = ptrtoint ptr %t18 to i64
  %t20 = icmp ne i64 %t19, 0
  br i1 %t20, label %L8, label %L9
L8:
  %t21 = load ptr, ptr %t13
  %t22 = load ptr, ptr %t21
  %t23 = call i32 @strcmp(ptr %t22, ptr %t0)
  %t24 = sext i32 %t23 to i64
  %t26 = sext i32 0 to i64
  %t25 = icmp eq i64 %t24, %t26
  %t27 = zext i1 %t25 to i64
  %t28 = icmp ne i64 %t27, 0
  %t29 = zext i1 %t28 to i64
  br label %L10
L9:
  br label %L10
L10:
  %t30 = phi i64 [ %t29, %L8 ], [ 0, %L9 ]
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L11, label %L13
L11:
  %t32 = load ptr, ptr %t13
  %t33 = sext i32 0 to i64
  store i64 %t33, ptr %t32
  ret void
L14:
  br label %L13
L13:
  br label %L6
L6:
  %t34 = load i64, ptr %t6
  %t35 = add i64 %t34, 1
  store i64 %t35, ptr %t6
  br label %L4
L7:
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
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L7, label %L8
L7:
  %t32 = load i64, ptr %t25
  %t34 = sext i32 0 to i64
  %t33 = icmp eq i64 %t32, %t34
  %t35 = zext i1 %t33 to i64
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L10, label %L11
L10:
  %t37 = load ptr, ptr %t4
  %t38 = load i64, ptr %t37
  %t40 = sext i32 41 to i64
  %t39 = icmp eq i64 %t38, %t40
  %t41 = zext i1 %t39 to i64
  %t42 = icmp ne i64 %t41, 0
  %t43 = zext i1 %t42 to i64
  br label %L12
L11:
  br label %L12
L12:
  %t44 = phi i64 [ %t43, %L10 ], [ 0, %L11 ]
  %t46 = icmp eq i64 %t44, 0
  %t45 = zext i1 %t46 to i64
  %t47 = icmp ne i64 %t45, 0
  %t48 = zext i1 %t47 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t49 = phi i64 [ %t48, %L7 ], [ 0, %L8 ]
  %t50 = icmp ne i64 %t49, 0
  br i1 %t50, label %L5, label %L6
L5:
  %t51 = load ptr, ptr %t4
  %t52 = load i64, ptr %t51
  %t54 = sext i32 44 to i64
  %t53 = icmp eq i64 %t52, %t54
  %t55 = zext i1 %t53 to i64
  %t56 = icmp ne i64 %t55, 0
  br i1 %t56, label %L13, label %L14
L13:
  %t57 = load i64, ptr %t25
  %t59 = sext i32 0 to i64
  %t58 = icmp eq i64 %t57, %t59
  %t60 = zext i1 %t58 to i64
  %t61 = icmp ne i64 %t60, 0
  %t62 = zext i1 %t61 to i64
  br label %L15
L14:
  br label %L15
L15:
  %t63 = phi i64 [ %t62, %L13 ], [ 0, %L14 ]
  %t64 = icmp ne i64 %t63, 0
  br i1 %t64, label %L16, label %L17
L16:
  %t65 = load i64, ptr %t23
  %t67 = sext i32 16 to i64
  %t66 = icmp slt i64 %t65, %t67
  %t68 = zext i1 %t66 to i64
  %t69 = icmp ne i64 %t68, 0
  br i1 %t69, label %L19, label %L21
L19:
  %t70 = load ptr, ptr %t27
  %t71 = call ptr @strdup(ptr %t70)
  %t72 = load ptr, ptr %t21
  %t73 = load i64, ptr %t23
  %t74 = add i64 %t73, 1
  store i64 %t74, ptr %t23
  %t75 = getelementptr ptr, ptr %t72, i64 %t73
  store ptr %t71, ptr %t75
  br label %L21
L21:
  %t76 = sext i32 0 to i64
  store i64 %t76, ptr %t27
  %t77 = load ptr, ptr %t27
  %t79 = sext i32 0 to i64
  %t78 = getelementptr ptr, ptr %t77, i64 %t79
  %t80 = sext i32 0 to i64
  store i64 %t80, ptr %t78
  %t81 = load ptr, ptr %t4
  %t83 = ptrtoint ptr %t81 to i64
  %t82 = add i64 %t83, 1
  store i64 %t82, ptr %t4
  br label %L18
L17:
  %t84 = load ptr, ptr %t4
  %t85 = load i64, ptr %t84
  %t87 = sext i32 34 to i64
  %t86 = icmp eq i64 %t85, %t87
  %t88 = zext i1 %t86 to i64
  %t89 = icmp ne i64 %t88, 0
  br i1 %t89, label %L22, label %L23
L22:
  %t90 = load ptr, ptr %t4
  %t92 = ptrtoint ptr %t90 to i64
  %t91 = add i64 %t92, 1
  store i64 %t91, ptr %t4
  %t93 = load i64, ptr %t90
  call void @buf_putc(ptr %t27, i64 %t93)
  br label %L25
L25:
  %t95 = load ptr, ptr %t4
  %t96 = load i64, ptr %t95
  %t97 = icmp ne i64 %t96, 0
  br i1 %t97, label %L28, label %L29
L28:
  %t98 = load ptr, ptr %t4
  %t99 = load i64, ptr %t98
  %t101 = sext i32 34 to i64
  %t100 = icmp ne i64 %t99, %t101
  %t102 = zext i1 %t100 to i64
  %t103 = icmp ne i64 %t102, 0
  %t104 = zext i1 %t103 to i64
  br label %L30
L29:
  br label %L30
L30:
  %t105 = phi i64 [ %t104, %L28 ], [ 0, %L29 ]
  %t106 = icmp ne i64 %t105, 0
  br i1 %t106, label %L26, label %L27
L26:
  %t107 = load ptr, ptr %t4
  %t108 = load i64, ptr %t107
  %t110 = sext i32 92 to i64
  %t109 = icmp eq i64 %t108, %t110
  %t111 = zext i1 %t109 to i64
  %t112 = icmp ne i64 %t111, 0
  br i1 %t112, label %L31, label %L32
L31:
  %t113 = load ptr, ptr %t4
  %t115 = ptrtoint ptr %t113 to i64
  %t116 = sext i32 1 to i64
  %t117 = inttoptr i64 %t115 to ptr
  %t114 = getelementptr i8, ptr %t117, i64 %t116
  %t118 = load i64, ptr %t114
  %t119 = icmp ne i64 %t118, 0
  %t120 = zext i1 %t119 to i64
  br label %L33
L32:
  br label %L33
L33:
  %t121 = phi i64 [ %t120, %L31 ], [ 0, %L32 ]
  %t122 = icmp ne i64 %t121, 0
  br i1 %t122, label %L34, label %L36
L34:
  %t123 = load ptr, ptr %t4
  %t125 = ptrtoint ptr %t123 to i64
  %t124 = add i64 %t125, 1
  store i64 %t124, ptr %t4
  %t126 = load i64, ptr %t123
  call void @buf_putc(ptr %t27, i64 %t126)
  br label %L36
L36:
  %t128 = load ptr, ptr %t4
  %t130 = ptrtoint ptr %t128 to i64
  %t129 = add i64 %t130, 1
  store i64 %t129, ptr %t4
  %t131 = load i64, ptr %t128
  call void @buf_putc(ptr %t27, i64 %t131)
  br label %L25
L27:
  %t133 = load ptr, ptr %t4
  %t134 = load i64, ptr %t133
  %t135 = icmp ne i64 %t134, 0
  br i1 %t135, label %L37, label %L39
L37:
  %t136 = load ptr, ptr %t4
  %t138 = ptrtoint ptr %t136 to i64
  %t137 = add i64 %t138, 1
  store i64 %t137, ptr %t4
  %t139 = load i64, ptr %t136
  call void @buf_putc(ptr %t27, i64 %t139)
  br label %L39
L39:
  br label %L24
L23:
  %t141 = load ptr, ptr %t4
  %t142 = load i64, ptr %t141
  %t144 = sext i32 39 to i64
  %t143 = icmp eq i64 %t142, %t144
  %t145 = zext i1 %t143 to i64
  %t146 = icmp ne i64 %t145, 0
  br i1 %t146, label %L40, label %L41
L40:
  %t147 = load ptr, ptr %t4
  %t149 = ptrtoint ptr %t147 to i64
  %t148 = add i64 %t149, 1
  store i64 %t148, ptr %t4
  %t150 = load i64, ptr %t147
  call void @buf_putc(ptr %t27, i64 %t150)
  %t152 = load ptr, ptr %t4
  %t153 = load i64, ptr %t152
  %t155 = sext i32 92 to i64
  %t154 = icmp eq i64 %t153, %t155
  %t156 = zext i1 %t154 to i64
  %t157 = icmp ne i64 %t156, 0
  br i1 %t157, label %L43, label %L44
L43:
  %t158 = load ptr, ptr %t4
  %t160 = ptrtoint ptr %t158 to i64
  %t161 = sext i32 1 to i64
  %t162 = inttoptr i64 %t160 to ptr
  %t159 = getelementptr i8, ptr %t162, i64 %t161
  %t163 = load i64, ptr %t159
  %t164 = icmp ne i64 %t163, 0
  %t165 = zext i1 %t164 to i64
  br label %L45
L44:
  br label %L45
L45:
  %t166 = phi i64 [ %t165, %L43 ], [ 0, %L44 ]
  %t167 = icmp ne i64 %t166, 0
  br i1 %t167, label %L46, label %L48
L46:
  %t168 = load ptr, ptr %t4
  %t170 = ptrtoint ptr %t168 to i64
  %t169 = add i64 %t170, 1
  store i64 %t169, ptr %t4
  %t171 = load i64, ptr %t168
  call void @buf_putc(ptr %t27, i64 %t171)
  br label %L48
L48:
  %t173 = load ptr, ptr %t4
  %t174 = load i64, ptr %t173
  %t175 = icmp ne i64 %t174, 0
  br i1 %t175, label %L49, label %L51
L49:
  %t176 = load ptr, ptr %t4
  %t178 = ptrtoint ptr %t176 to i64
  %t177 = add i64 %t178, 1
  store i64 %t177, ptr %t4
  %t179 = load i64, ptr %t176
  call void @buf_putc(ptr %t27, i64 %t179)
  br label %L51
L51:
  %t181 = load ptr, ptr %t4
  %t182 = load i64, ptr %t181
  %t184 = sext i32 39 to i64
  %t183 = icmp eq i64 %t182, %t184
  %t185 = zext i1 %t183 to i64
  %t186 = icmp ne i64 %t185, 0
  br i1 %t186, label %L52, label %L54
L52:
  %t187 = load ptr, ptr %t4
  %t189 = ptrtoint ptr %t187 to i64
  %t188 = add i64 %t189, 1
  store i64 %t188, ptr %t4
  %t190 = load i64, ptr %t187
  call void @buf_putc(ptr %t27, i64 %t190)
  br label %L54
L54:
  br label %L42
L41:
  %t192 = load ptr, ptr %t4
  %t193 = load i64, ptr %t192
  %t195 = sext i32 40 to i64
  %t194 = icmp eq i64 %t193, %t195
  %t196 = zext i1 %t194 to i64
  %t197 = icmp ne i64 %t196, 0
  br i1 %t197, label %L55, label %L57
L55:
  %t198 = load i64, ptr %t25
  %t199 = add i64 %t198, 1
  store i64 %t199, ptr %t25
  br label %L57
L57:
  %t200 = load ptr, ptr %t4
  %t201 = load i64, ptr %t200
  %t203 = sext i32 41 to i64
  %t202 = icmp eq i64 %t201, %t203
  %t204 = zext i1 %t202 to i64
  %t205 = icmp ne i64 %t204, 0
  br i1 %t205, label %L58, label %L60
L58:
  %t206 = load i64, ptr %t25
  %t207 = sub i64 %t206, 1
  store i64 %t207, ptr %t25
  br label %L60
L60:
  %t208 = load i64, ptr %t25
  %t210 = sext i32 0 to i64
  %t209 = icmp sge i64 %t208, %t210
  %t211 = zext i1 %t209 to i64
  %t212 = icmp ne i64 %t211, 0
  br i1 %t212, label %L61, label %L62
L61:
  %t213 = load ptr, ptr %t4
  %t215 = ptrtoint ptr %t213 to i64
  %t214 = add i64 %t215, 1
  store i64 %t214, ptr %t4
  %t216 = load i64, ptr %t213
  call void @buf_putc(ptr %t27, i64 %t216)
  br label %L63
L62:
  br label %L6
L64:
  br label %L63
L63:
  br label %L42
L42:
  br label %L24
L24:
  br label %L18
L18:
  br label %L4
L6:
  %t218 = load ptr, ptr %t27
  %t220 = ptrtoint ptr %t218 to i64
  %t221 = sext i32 0 to i64
  %t219 = icmp sgt i64 %t220, %t221
  %t222 = zext i1 %t219 to i64
  %t223 = icmp ne i64 %t222, 0
  br i1 %t223, label %L65, label %L66
L65:
  br label %L67
L66:
  %t224 = load i64, ptr %t23
  %t226 = sext i32 0 to i64
  %t225 = icmp sgt i64 %t224, %t226
  %t227 = zext i1 %t225 to i64
  %t228 = icmp ne i64 %t227, 0
  %t229 = zext i1 %t228 to i64
  br label %L67
L67:
  %t230 = phi i64 [ 1, %L65 ], [ %t229, %L66 ]
  %t231 = icmp ne i64 %t230, 0
  br i1 %t231, label %L68, label %L70
L68:
  %t232 = load i64, ptr %t23
  %t234 = sext i32 16 to i64
  %t233 = icmp slt i64 %t232, %t234
  %t235 = zext i1 %t233 to i64
  %t236 = icmp ne i64 %t235, 0
  br i1 %t236, label %L71, label %L73
L71:
  %t237 = load ptr, ptr %t27
  %t238 = call ptr @strdup(ptr %t237)
  %t239 = load ptr, ptr %t21
  %t240 = load i64, ptr %t23
  %t241 = add i64 %t240, 1
  store i64 %t241, ptr %t23
  %t242 = getelementptr ptr, ptr %t239, i64 %t240
  store ptr %t238, ptr %t242
  br label %L73
L73:
  br label %L70
L70:
  %t243 = load ptr, ptr %t27
  call void @free(ptr %t243)
  %t245 = load ptr, ptr %t4
  %t246 = load i64, ptr %t245
  %t248 = sext i32 41 to i64
  %t247 = icmp eq i64 %t246, %t248
  %t249 = zext i1 %t247 to i64
  %t250 = icmp ne i64 %t249, 0
  br i1 %t250, label %L74, label %L76
L74:
  %t251 = load ptr, ptr %t4
  %t253 = ptrtoint ptr %t251 to i64
  %t252 = add i64 %t253, 1
  store i64 %t252, ptr %t4
  br label %L76
L76:
  %t254 = load ptr, ptr %t4
  store ptr %t254, ptr %t1
  %t255 = alloca ptr
  %t256 = load ptr, ptr %t0
  store ptr %t256, ptr %t255
  %t257 = alloca i64
  call void @buf_init(ptr %t257)
  br label %L77
L77:
  %t259 = load ptr, ptr %t255
  %t260 = load i64, ptr %t259
  %t261 = icmp ne i64 %t260, 0
  br i1 %t261, label %L78, label %L79
L78:
  %t262 = load ptr, ptr %t255
  %t263 = load i64, ptr %t262
  %t265 = sext i32 35 to i64
  %t264 = icmp eq i64 %t263, %t265
  %t266 = zext i1 %t264 to i64
  %t267 = icmp ne i64 %t266, 0
  br i1 %t267, label %L80, label %L81
L80:
  %t268 = load ptr, ptr %t255
  %t270 = ptrtoint ptr %t268 to i64
  %t271 = sext i32 1 to i64
  %t272 = inttoptr i64 %t270 to ptr
  %t269 = getelementptr i8, ptr %t272, i64 %t271
  %t273 = load i64, ptr %t269
  %t275 = sext i32 35 to i64
  %t274 = icmp ne i64 %t273, %t275
  %t276 = zext i1 %t274 to i64
  %t277 = icmp ne i64 %t276, 0
  %t278 = zext i1 %t277 to i64
  br label %L82
L81:
  br label %L82
L82:
  %t279 = phi i64 [ %t278, %L80 ], [ 0, %L81 ]
  %t280 = icmp ne i64 %t279, 0
  br i1 %t280, label %L83, label %L85
L83:
  %t281 = load ptr, ptr %t255
  %t283 = ptrtoint ptr %t281 to i64
  %t282 = add i64 %t283, 1
  store i64 %t282, ptr %t255
  br label %L86
L86:
  %t284 = load ptr, ptr %t255
  %t285 = load i64, ptr %t284
  %t287 = sext i32 32 to i64
  %t286 = icmp eq i64 %t285, %t287
  %t288 = zext i1 %t286 to i64
  %t289 = icmp ne i64 %t288, 0
  br i1 %t289, label %L89, label %L90
L89:
  br label %L91
L90:
  %t290 = load ptr, ptr %t255
  %t291 = load i64, ptr %t290
  %t293 = sext i32 9 to i64
  %t292 = icmp eq i64 %t291, %t293
  %t294 = zext i1 %t292 to i64
  %t295 = icmp ne i64 %t294, 0
  %t296 = zext i1 %t295 to i64
  br label %L91
L91:
  %t297 = phi i64 [ 1, %L89 ], [ %t296, %L90 ]
  %t298 = icmp ne i64 %t297, 0
  br i1 %t298, label %L87, label %L88
L87:
  %t299 = load ptr, ptr %t255
  %t301 = ptrtoint ptr %t299 to i64
  %t300 = add i64 %t301, 1
  store i64 %t300, ptr %t255
  br label %L86
L88:
  %t302 = alloca ptr
  %t303 = alloca ptr
  %t304 = load ptr, ptr %t255
  %t305 = load ptr, ptr %t302
  %t306 = call ptr @read_ident(ptr %t304, ptr %t305, i64 8)
  store ptr %t306, ptr %t303
  %t307 = alloca i64
  %t308 = sext i32 0 to i64
  store i64 %t308, ptr %t307
  %t309 = alloca i64
  %t310 = sext i32 0 to i64
  store i64 %t310, ptr %t309
  br label %L92
L92:
  %t311 = load i64, ptr %t309
  %t312 = load ptr, ptr %t0
  %t314 = ptrtoint ptr %t312 to i64
  %t313 = icmp slt i64 %t311, %t314
  %t315 = zext i1 %t313 to i64
  %t316 = icmp ne i64 %t315, 0
  br i1 %t316, label %L96, label %L97
L96:
  %t317 = load i64, ptr %t309
  %t319 = sext i32 16 to i64
  %t318 = icmp slt i64 %t317, %t319
  %t320 = zext i1 %t318 to i64
  %t321 = icmp ne i64 %t320, 0
  %t322 = zext i1 %t321 to i64
  br label %L98
L97:
  br label %L98
L98:
  %t323 = phi i64 [ %t322, %L96 ], [ 0, %L97 ]
  %t324 = icmp ne i64 %t323, 0
  br i1 %t324, label %L93, label %L95
L93:
  %t325 = load ptr, ptr %t0
  %t326 = load i64, ptr %t309
  %t327 = getelementptr ptr, ptr %t325, i64 %t326
  %t328 = load ptr, ptr %t327
  %t329 = ptrtoint ptr %t328 to i64
  %t330 = icmp ne i64 %t329, 0
  br i1 %t330, label %L99, label %L100
L99:
  %t331 = load ptr, ptr %t0
  %t332 = load i64, ptr %t309
  %t333 = getelementptr ptr, ptr %t331, i64 %t332
  %t334 = load ptr, ptr %t333
  %t335 = load ptr, ptr %t302
  %t336 = call i32 @strcmp(ptr %t334, ptr %t335)
  %t337 = sext i32 %t336 to i64
  %t339 = sext i32 0 to i64
  %t338 = icmp eq i64 %t337, %t339
  %t340 = zext i1 %t338 to i64
  %t341 = icmp ne i64 %t340, 0
  %t342 = zext i1 %t341 to i64
  br label %L101
L100:
  br label %L101
L101:
  %t343 = phi i64 [ %t342, %L99 ], [ 0, %L100 ]
  %t344 = icmp ne i64 %t343, 0
  br i1 %t344, label %L102, label %L104
L102:
  call void @buf_putc(ptr %t257, i64 34)
  %t346 = load i64, ptr %t309
  %t347 = load i64, ptr %t23
  %t348 = icmp slt i64 %t346, %t347
  %t349 = zext i1 %t348 to i64
  %t350 = icmp ne i64 %t349, 0
  br i1 %t350, label %L105, label %L106
L105:
  %t351 = load ptr, ptr %t21
  %t352 = load i64, ptr %t309
  %t353 = getelementptr ptr, ptr %t351, i64 %t352
  %t354 = load ptr, ptr %t353
  %t355 = ptrtoint ptr %t354 to i64
  %t356 = icmp ne i64 %t355, 0
  %t357 = zext i1 %t356 to i64
  br label %L107
L106:
  br label %L107
L107:
  %t358 = phi i64 [ %t357, %L105 ], [ 0, %L106 ]
  %t359 = icmp ne i64 %t358, 0
  br i1 %t359, label %L108, label %L110
L108:
  %t360 = alloca ptr
  %t361 = load ptr, ptr %t21
  %t362 = load i64, ptr %t309
  %t363 = getelementptr ptr, ptr %t361, i64 %t362
  %t364 = load ptr, ptr %t363
  store ptr %t364, ptr %t360
  br label %L111
L111:
  %t365 = load ptr, ptr %t360
  %t366 = load i64, ptr %t365
  %t367 = icmp ne i64 %t366, 0
  br i1 %t367, label %L112, label %L113
L112:
  %t368 = load ptr, ptr %t360
  %t369 = load i64, ptr %t368
  %t371 = sext i32 34 to i64
  %t370 = icmp eq i64 %t369, %t371
  %t372 = zext i1 %t370 to i64
  %t373 = icmp ne i64 %t372, 0
  br i1 %t373, label %L114, label %L115
L114:
  br label %L116
L115:
  %t374 = load ptr, ptr %t360
  %t375 = load i64, ptr %t374
  %t377 = sext i32 92 to i64
  %t376 = icmp eq i64 %t375, %t377
  %t378 = zext i1 %t376 to i64
  %t379 = icmp ne i64 %t378, 0
  %t380 = zext i1 %t379 to i64
  br label %L116
L116:
  %t381 = phi i64 [ 1, %L114 ], [ %t380, %L115 ]
  %t382 = icmp ne i64 %t381, 0
  br i1 %t382, label %L117, label %L119
L117:
  call void @buf_putc(ptr %t257, i64 92)
  br label %L119
L119:
  %t384 = load ptr, ptr %t360
  %t386 = ptrtoint ptr %t384 to i64
  %t385 = add i64 %t386, 1
  store i64 %t385, ptr %t360
  %t387 = load i64, ptr %t384
  call void @buf_putc(ptr %t257, i64 %t387)
  br label %L111
L113:
  br label %L110
L110:
  call void @buf_putc(ptr %t257, i64 34)
  %t390 = sext i32 1 to i64
  store i64 %t390, ptr %t307
  br label %L95
L120:
  br label %L104
L104:
  br label %L94
L94:
  %t391 = load i64, ptr %t309
  %t392 = add i64 %t391, 1
  store i64 %t392, ptr %t309
  br label %L92
L95:
  %t393 = load i64, ptr %t307
  %t395 = icmp eq i64 %t393, 0
  %t394 = zext i1 %t395 to i64
  %t396 = icmp ne i64 %t394, 0
  br i1 %t396, label %L121, label %L123
L121:
  call void @buf_putc(ptr %t257, i64 34)
  call void @buf_putc(ptr %t257, i64 34)
  br label %L123
L123:
  %t399 = load ptr, ptr %t303
  store ptr %t399, ptr %t255
  br label %L77
L124:
  br label %L85
L85:
  %t400 = load ptr, ptr %t255
  %t401 = load i64, ptr %t400
  %t403 = sext i32 35 to i64
  %t402 = icmp eq i64 %t401, %t403
  %t404 = zext i1 %t402 to i64
  %t405 = icmp ne i64 %t404, 0
  br i1 %t405, label %L125, label %L126
L125:
  %t406 = load ptr, ptr %t255
  %t408 = ptrtoint ptr %t406 to i64
  %t409 = sext i32 1 to i64
  %t410 = inttoptr i64 %t408 to ptr
  %t407 = getelementptr i8, ptr %t410, i64 %t409
  %t411 = load i64, ptr %t407
  %t413 = sext i32 35 to i64
  %t412 = icmp eq i64 %t411, %t413
  %t414 = zext i1 %t412 to i64
  %t415 = icmp ne i64 %t414, 0
  %t416 = zext i1 %t415 to i64
  br label %L127
L126:
  br label %L127
L127:
  %t417 = phi i64 [ %t416, %L125 ], [ 0, %L126 ]
  %t418 = icmp ne i64 %t417, 0
  br i1 %t418, label %L128, label %L130
L128:
  %t419 = load ptr, ptr %t255
  %t421 = ptrtoint ptr %t419 to i64
  %t422 = sext i32 2 to i64
  %t420 = add i64 %t421, %t422
  store i64 %t420, ptr %t255
  br label %L131
L131:
  %t423 = load ptr, ptr %t255
  %t424 = load i64, ptr %t423
  %t426 = sext i32 32 to i64
  %t425 = icmp eq i64 %t424, %t426
  %t427 = zext i1 %t425 to i64
  %t428 = icmp ne i64 %t427, 0
  br i1 %t428, label %L134, label %L135
L134:
  br label %L136
L135:
  %t429 = load ptr, ptr %t255
  %t430 = load i64, ptr %t429
  %t432 = sext i32 9 to i64
  %t431 = icmp eq i64 %t430, %t432
  %t433 = zext i1 %t431 to i64
  %t434 = icmp ne i64 %t433, 0
  %t435 = zext i1 %t434 to i64
  br label %L136
L136:
  %t436 = phi i64 [ 1, %L134 ], [ %t435, %L135 ]
  %t437 = icmp ne i64 %t436, 0
  br i1 %t437, label %L132, label %L133
L132:
  %t438 = load ptr, ptr %t255
  %t440 = ptrtoint ptr %t438 to i64
  %t439 = add i64 %t440, 1
  store i64 %t439, ptr %t255
  br label %L131
L133:
  br label %L77
L137:
  br label %L130
L130:
  %t441 = load ptr, ptr %t255
  %t442 = load i64, ptr %t441
  %t443 = add i64 %t442, 0
  %t444 = call i32 @isalpha(i64 %t443)
  %t445 = sext i32 %t444 to i64
  %t446 = icmp ne i64 %t445, 0
  br i1 %t446, label %L138, label %L139
L138:
  br label %L140
L139:
  %t447 = load ptr, ptr %t255
  %t448 = load i64, ptr %t447
  %t450 = sext i32 95 to i64
  %t449 = icmp eq i64 %t448, %t450
  %t451 = zext i1 %t449 to i64
  %t452 = icmp ne i64 %t451, 0
  %t453 = zext i1 %t452 to i64
  br label %L140
L140:
  %t454 = phi i64 [ 1, %L138 ], [ %t453, %L139 ]
  %t455 = icmp ne i64 %t454, 0
  br i1 %t455, label %L141, label %L142
L141:
  %t456 = alloca ptr
  %t457 = alloca ptr
  %t458 = load ptr, ptr %t255
  %t459 = load ptr, ptr %t456
  %t460 = call ptr @read_ident(ptr %t458, ptr %t459, i64 8)
  store ptr %t460, ptr %t457
  %t461 = alloca i64
  %t462 = sext i32 0 to i64
  store i64 %t462, ptr %t461
  %t463 = load ptr, ptr %t456
  %t464 = getelementptr [12 x i8], ptr @.str3, i64 0, i64 0
  %t465 = call i32 @strcmp(ptr %t463, ptr %t464)
  %t466 = sext i32 %t465 to i64
  %t468 = sext i32 0 to i64
  %t467 = icmp eq i64 %t466, %t468
  %t469 = zext i1 %t467 to i64
  %t470 = icmp ne i64 %t469, 0
  br i1 %t470, label %L144, label %L146
L144:
  %t471 = alloca i64
  %t472 = load ptr, ptr %t0
  store ptr %t472, ptr %t471
  br label %L147
L147:
  %t473 = load i64, ptr %t471
  %t474 = load i64, ptr %t23
  %t475 = icmp slt i64 %t473, %t474
  %t476 = zext i1 %t475 to i64
  %t477 = icmp ne i64 %t476, 0
  br i1 %t477, label %L148, label %L150
L148:
  %t478 = load i64, ptr %t471
  %t479 = load ptr, ptr %t0
  %t481 = ptrtoint ptr %t479 to i64
  %t480 = icmp sgt i64 %t478, %t481
  %t482 = zext i1 %t480 to i64
  %t483 = icmp ne i64 %t482, 0
  br i1 %t483, label %L151, label %L153
L151:
  call void @buf_putc(ptr %t257, i64 44)
  br label %L153
L153:
  %t485 = load ptr, ptr %t21
  %t486 = load i64, ptr %t471
  %t487 = getelementptr ptr, ptr %t485, i64 %t486
  %t488 = load ptr, ptr %t487
  %t489 = icmp ne ptr %t488, null
  br i1 %t489, label %L154, label %L156
L154:
  %t490 = load ptr, ptr %t21
  %t491 = load i64, ptr %t471
  %t492 = getelementptr ptr, ptr %t490, i64 %t491
  %t493 = load ptr, ptr %t492
  %t494 = load ptr, ptr %t21
  %t495 = load i64, ptr %t471
  %t496 = getelementptr ptr, ptr %t494, i64 %t495
  %t497 = load ptr, ptr %t496
  %t498 = call i64 @strlen(ptr %t497)
  call void @buf_append(ptr %t257, ptr %t493, i64 %t498)
  br label %L156
L156:
  br label %L149
L149:
  %t500 = load i64, ptr %t471
  %t501 = add i64 %t500, 1
  store i64 %t501, ptr %t471
  br label %L147
L150:
  %t502 = sext i32 1 to i64
  store i64 %t502, ptr %t461
  br label %L146
L146:
  %t503 = load i64, ptr %t461
  %t505 = icmp eq i64 %t503, 0
  %t504 = zext i1 %t505 to i64
  %t506 = icmp ne i64 %t504, 0
  br i1 %t506, label %L157, label %L159
L157:
  %t507 = alloca i64
  %t508 = sext i32 0 to i64
  store i64 %t508, ptr %t507
  br label %L160
L160:
  %t509 = load i64, ptr %t507
  %t510 = load ptr, ptr %t0
  %t512 = ptrtoint ptr %t510 to i64
  %t511 = icmp slt i64 %t509, %t512
  %t513 = zext i1 %t511 to i64
  %t514 = icmp ne i64 %t513, 0
  br i1 %t514, label %L164, label %L165
L164:
  %t515 = load i64, ptr %t507
  %t517 = sext i32 16 to i64
  %t516 = icmp slt i64 %t515, %t517
  %t518 = zext i1 %t516 to i64
  %t519 = icmp ne i64 %t518, 0
  %t520 = zext i1 %t519 to i64
  br label %L166
L165:
  br label %L166
L166:
  %t521 = phi i64 [ %t520, %L164 ], [ 0, %L165 ]
  %t522 = icmp ne i64 %t521, 0
  br i1 %t522, label %L161, label %L163
L161:
  %t523 = load ptr, ptr %t0
  %t524 = load i64, ptr %t507
  %t525 = getelementptr ptr, ptr %t523, i64 %t524
  %t526 = load ptr, ptr %t525
  %t527 = ptrtoint ptr %t526 to i64
  %t528 = icmp ne i64 %t527, 0
  br i1 %t528, label %L167, label %L168
L167:
  %t529 = load ptr, ptr %t0
  %t530 = load i64, ptr %t507
  %t531 = getelementptr ptr, ptr %t529, i64 %t530
  %t532 = load ptr, ptr %t531
  %t533 = load ptr, ptr %t456
  %t534 = call i32 @strcmp(ptr %t532, ptr %t533)
  %t535 = sext i32 %t534 to i64
  %t537 = sext i32 0 to i64
  %t536 = icmp eq i64 %t535, %t537
  %t538 = zext i1 %t536 to i64
  %t539 = icmp ne i64 %t538, 0
  %t540 = zext i1 %t539 to i64
  br label %L169
L168:
  br label %L169
L169:
  %t541 = phi i64 [ %t540, %L167 ], [ 0, %L168 ]
  %t542 = icmp ne i64 %t541, 0
  br i1 %t542, label %L170, label %L172
L170:
  %t543 = load i64, ptr %t507
  %t544 = load i64, ptr %t23
  %t545 = icmp slt i64 %t543, %t544
  %t546 = zext i1 %t545 to i64
  %t547 = icmp ne i64 %t546, 0
  br i1 %t547, label %L173, label %L174
L173:
  %t548 = load ptr, ptr %t21
  %t549 = load i64, ptr %t507
  %t550 = getelementptr ptr, ptr %t548, i64 %t549
  %t551 = load ptr, ptr %t550
  %t552 = ptrtoint ptr %t551 to i64
  %t553 = icmp ne i64 %t552, 0
  %t554 = zext i1 %t553 to i64
  br label %L175
L174:
  br label %L175
L175:
  %t555 = phi i64 [ %t554, %L173 ], [ 0, %L174 ]
  %t556 = icmp ne i64 %t555, 0
  br i1 %t556, label %L176, label %L178
L176:
  %t557 = load ptr, ptr %t21
  %t558 = load i64, ptr %t507
  %t559 = getelementptr ptr, ptr %t557, i64 %t558
  %t560 = load ptr, ptr %t559
  %t561 = load ptr, ptr %t21
  %t562 = load i64, ptr %t507
  %t563 = getelementptr ptr, ptr %t561, i64 %t562
  %t564 = load ptr, ptr %t563
  %t565 = call i64 @strlen(ptr %t564)
  call void @buf_append(ptr %t257, ptr %t560, i64 %t565)
  br label %L178
L178:
  %t567 = sext i32 1 to i64
  store i64 %t567, ptr %t461
  br label %L163
L179:
  br label %L172
L172:
  br label %L162
L162:
  %t568 = load i64, ptr %t507
  %t569 = add i64 %t568, 1
  store i64 %t569, ptr %t507
  br label %L160
L163:
  br label %L159
L159:
  %t570 = load i64, ptr %t461
  %t572 = icmp eq i64 %t570, 0
  %t571 = zext i1 %t572 to i64
  %t573 = icmp ne i64 %t571, 0
  br i1 %t573, label %L180, label %L182
L180:
  %t574 = load ptr, ptr %t456
  %t575 = load ptr, ptr %t456
  %t576 = call i64 @strlen(ptr %t575)
  call void @buf_append(ptr %t257, ptr %t574, i64 %t576)
  br label %L182
L182:
  %t578 = load ptr, ptr %t457
  store ptr %t578, ptr %t255
  br label %L143
L142:
  %t579 = load ptr, ptr %t255
  %t581 = ptrtoint ptr %t579 to i64
  %t580 = add i64 %t581, 1
  store i64 %t580, ptr %t255
  %t582 = load i64, ptr %t579
  call void @buf_putc(ptr %t257, i64 %t582)
  br label %L143
L143:
  br label %L77
L79:
  %t584 = load ptr, ptr %t257
  %t586 = sext i32 1 to i64
  %t585 = add i64 %t3, %t586
  call void @expand_text(ptr %t584, ptr %t2, i64 %t585)
  %t588 = load ptr, ptr %t257
  call void @free(ptr %t588)
  %t590 = alloca i64
  %t591 = sext i32 0 to i64
  store i64 %t591, ptr %t590
  br label %L183
L183:
  %t592 = load i64, ptr %t590
  %t593 = load i64, ptr %t23
  %t594 = icmp slt i64 %t592, %t593
  %t595 = zext i1 %t594 to i64
  %t596 = icmp ne i64 %t595, 0
  br i1 %t596, label %L184, label %L186
L184:
  %t597 = load ptr, ptr %t21
  %t598 = load i64, ptr %t590
  %t599 = getelementptr ptr, ptr %t597, i64 %t598
  %t600 = load ptr, ptr %t599
  call void @free(ptr %t600)
  br label %L185
L185:
  %t602 = load i64, ptr %t590
  %t603 = add i64 %t602, 1
  store i64 %t603, ptr %t590
  br label %L183
L186:
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
  %t133 = alloca ptr
  %t134 = load ptr, ptr %t128
  %t135 = call ptr @macro_find(ptr %t134)
  store ptr %t135, ptr %t133
  %t136 = load ptr, ptr %t133
  %t137 = ptrtoint ptr %t136 to i64
  %t138 = icmp ne i64 %t137, 0
  br i1 %t138, label %L51, label %L52
L51:
  %t139 = load ptr, ptr %t133
  %t140 = load ptr, ptr %t139
  %t141 = ptrtoint ptr %t140 to i64
  %t142 = icmp ne i64 %t141, 0
  %t143 = zext i1 %t142 to i64
  br label %L53
L52:
  br label %L53
L53:
  %t144 = phi i64 [ %t143, %L51 ], [ 0, %L52 ]
  %t145 = icmp ne i64 %t144, 0
  br i1 %t145, label %L54, label %L56
L54:
  %t146 = alloca ptr
  %t147 = load ptr, ptr %t129
  store ptr %t147, ptr %t146
  %t148 = load ptr, ptr %t146
  %t149 = call ptr @skip_ws(ptr %t148)
  store ptr %t149, ptr %t146
  %t150 = load ptr, ptr %t146
  %t151 = load i64, ptr %t150
  %t153 = sext i32 40 to i64
  %t152 = icmp eq i64 %t151, %t153
  %t154 = zext i1 %t152 to i64
  %t155 = icmp ne i64 %t154, 0
  br i1 %t155, label %L57, label %L59
L57:
  %t156 = load ptr, ptr %t129
  store ptr %t156, ptr %t9
  %t157 = load ptr, ptr %t133
  %t159 = sext i32 1 to i64
  %t158 = add i64 %t2, %t159
  call void @expand_func_macro(ptr %t157, ptr %t9, ptr %t1, i64 %t158)
  br label %L4
L60:
  br label %L59
L59:
  br label %L56
L56:
  %t161 = load ptr, ptr %t133
  %t162 = ptrtoint ptr %t161 to i64
  %t163 = icmp ne i64 %t162, 0
  br i1 %t163, label %L61, label %L62
L61:
  %t164 = load ptr, ptr %t133
  %t165 = load ptr, ptr %t164
  %t167 = ptrtoint ptr %t165 to i64
  %t168 = icmp eq i64 %t167, 0
  %t166 = zext i1 %t168 to i64
  %t169 = icmp ne i64 %t166, 0
  %t170 = zext i1 %t169 to i64
  br label %L63
L62:
  br label %L63
L63:
  %t171 = phi i64 [ %t170, %L61 ], [ 0, %L62 ]
  %t172 = icmp ne i64 %t171, 0
  br i1 %t172, label %L64, label %L66
L64:
  %t173 = load ptr, ptr %t133
  %t174 = load ptr, ptr %t173
  %t176 = sext i32 1 to i64
  %t175 = add i64 %t2, %t176
  call void @expand_text(ptr %t174, ptr %t1, i64 %t175)
  %t178 = load ptr, ptr %t129
  store ptr %t178, ptr %t9
  br label %L4
L67:
  br label %L66
L66:
  %t179 = load ptr, ptr %t128
  %t180 = load ptr, ptr %t128
  %t181 = call i64 @strlen(ptr %t180)
  call void @buf_append(ptr %t1, ptr %t179, i64 %t181)
  %t183 = load ptr, ptr %t129
  store ptr %t183, ptr %t9
  br label %L4
L68:
  br label %L50
L50:
  %t184 = load ptr, ptr %t9
  %t186 = ptrtoint ptr %t184 to i64
  %t185 = add i64 %t186, 1
  store i64 %t185, ptr %t9
  %t187 = load i64, ptr %t184
  call void @buf_putc(ptr %t1, i64 %t187)
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
  %t7 = getelementptr [13 x i8], ptr @.str5, i64 0, i64 0
  %t8 = load ptr, ptr %t0
  %t10 = sext i32 0 to i64
  %t9 = getelementptr ptr, ptr %t8, i64 %t10
  store ptr %t7, ptr %t9
  %t11 = getelementptr [19 x i8], ptr @.str6, i64 0, i64 0
  %t12 = load ptr, ptr %t0
  %t14 = sext i32 1 to i64
  %t13 = getelementptr ptr, ptr %t12, i64 %t14
  store ptr %t11, ptr %t13
  %t15 = getelementptr [2 x i8], ptr @.str7, i64 0, i64 0
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
  %t21 = getelementptr [6 x i8], ptr @.str8, i64 0, i64 0
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
  %t19 = getelementptr [6 x i8], ptr @.str9, i64 0, i64 0
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
  %t47 = getelementptr ptr, ptr %t4, i64 %t45
  store i64 %t44, ptr %t47
  br label %L5
L5:
  ret void
L6:
  br label %L2
L2:
  %t48 = load ptr, ptr %t12
  %t49 = getelementptr [7 x i8], ptr @.str10, i64 0, i64 0
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
  %t77 = getelementptr ptr, ptr %t4, i64 %t75
  store i64 %t74, ptr %t77
  br label %L12
L12:
  ret void
L13:
  br label %L9
L9:
  %t78 = load ptr, ptr %t12
  %t79 = getelementptr [3 x i8], ptr @.str11, i64 0, i64 0
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
  %t89 = getelementptr [8 x i8], ptr @.str12, i64 0, i64 0
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
  %t142 = getelementptr ptr, ptr %t4, i64 %t140
  store i64 %t139, ptr %t142
  br label %L25
L25:
  ret void
L26:
  br label %L16
L16:
  %t143 = load ptr, ptr %t12
  %t144 = getelementptr [5 x i8], ptr @.str13, i64 0, i64 0
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
  %t167 = getelementptr ptr, ptr %t4, i64 %t165
  store i64 %t163, ptr %t167
  br label %L32
L32:
  ret void
L33:
  br label %L29
L29:
  %t168 = load ptr, ptr %t12
  %t169 = getelementptr [5 x i8], ptr @.str14, i64 0, i64 0
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
  %t184 = getelementptr ptr, ptr %t4, i64 %t182
  %t185 = load ptr, ptr %t184
  %t187 = ptrtoint ptr %t185 to i64
  %t188 = sext i32 1 to i64
  %t186 = xor i64 %t187, %t188
  %t189 = load i64, ptr %t5
  %t191 = sext i32 1 to i64
  %t190 = sub i64 %t189, %t191
  %t192 = getelementptr ptr, ptr %t4, i64 %t190
  store i64 %t186, ptr %t192
  br label %L39
L39:
  ret void
L40:
  br label %L36
L36:
  %t193 = load ptr, ptr %t12
  %t194 = getelementptr [6 x i8], ptr @.str15, i64 0, i64 0
  %t195 = call i32 @strcmp(ptr %t193, ptr %t194)
  %t196 = sext i32 %t195 to i64
  %t198 = sext i32 0 to i64
  %t197 = icmp eq i64 %t196, %t198
  %t199 = zext i1 %t197 to i64
  %t200 = icmp ne i64 %t199, 0
  br i1 %t200, label %L41, label %L43
L41:
  %t201 = load i64, ptr %t5
  %t203 = sext i32 0 to i64
  %t202 = icmp sgt i64 %t201, %t203
  %t204 = zext i1 %t202 to i64
  %t205 = icmp ne i64 %t204, 0
  br i1 %t205, label %L44, label %L46
L44:
  %t206 = load i64, ptr %t5
  %t207 = sub i64 %t206, 1
  store i64 %t207, ptr %t5
  br label %L46
L46:
  ret void
L47:
  br label %L43
L43:
  %t208 = alloca i64
  %t209 = sext i32 1 to i64
  store i64 %t209, ptr %t208
  %t210 = alloca i64
  %t211 = sext i32 0 to i64
  store i64 %t211, ptr %t210
  br label %L48
L48:
  %t212 = load i64, ptr %t210
  %t213 = load i64, ptr %t5
  %t214 = icmp slt i64 %t212, %t213
  %t215 = zext i1 %t214 to i64
  %t216 = icmp ne i64 %t215, 0
  br i1 %t216, label %L49, label %L51
L49:
  %t217 = load i64, ptr %t210
  %t218 = getelementptr ptr, ptr %t4, i64 %t217
  %t219 = load ptr, ptr %t218
  %t221 = ptrtoint ptr %t219 to i64
  %t222 = icmp eq i64 %t221, 0
  %t220 = zext i1 %t222 to i64
  %t223 = icmp ne i64 %t220, 0
  br i1 %t223, label %L52, label %L54
L52:
  %t224 = sext i32 0 to i64
  store i64 %t224, ptr %t208
  br label %L51
L55:
  br label %L54
L54:
  br label %L50
L50:
  %t225 = load i64, ptr %t210
  %t226 = add i64 %t225, 1
  store i64 %t226, ptr %t210
  br label %L48
L51:
  %t227 = load i64, ptr %t208
  %t229 = icmp eq i64 %t227, 0
  %t228 = zext i1 %t229 to i64
  %t230 = icmp ne i64 %t228, 0
  br i1 %t230, label %L56, label %L58
L56:
  ret void
L59:
  br label %L58
L58:
  %t231 = load ptr, ptr %t12
  %t232 = getelementptr [7 x i8], ptr @.str16, i64 0, i64 0
  %t233 = call i32 @strcmp(ptr %t231, ptr %t232)
  %t234 = sext i32 %t233 to i64
  %t236 = sext i32 0 to i64
  %t235 = icmp eq i64 %t234, %t236
  %t237 = zext i1 %t235 to i64
  %t238 = icmp ne i64 %t237, 0
  br i1 %t238, label %L60, label %L62
L60:
  %t239 = alloca ptr
  %t240 = load ptr, ptr %t6
  %t241 = load ptr, ptr %t239
  %t242 = call ptr @read_ident(ptr %t240, ptr %t241, i64 8)
  store ptr %t242, ptr %t6
  %t243 = load ptr, ptr %t6
  %t244 = load i64, ptr %t243
  %t246 = sext i32 40 to i64
  %t245 = icmp eq i64 %t244, %t246
  %t247 = zext i1 %t245 to i64
  %t248 = icmp ne i64 %t247, 0
  br i1 %t248, label %L63, label %L64
L63:
  %t249 = load ptr, ptr %t6
  %t251 = ptrtoint ptr %t249 to i64
  %t250 = add i64 %t251, 1
  store i64 %t250, ptr %t6
  %t252 = alloca ptr
  %t253 = sext i32 0 to i64
  store i64 %t253, ptr %t252
  %t254 = alloca i64
  %t255 = sext i32 0 to i64
  store i64 %t255, ptr %t254
  %t256 = alloca i64
  %t257 = sext i32 0 to i64
  store i64 %t257, ptr %t256
  br label %L66
L66:
  %t258 = load ptr, ptr %t6
  %t259 = load i64, ptr %t258
  %t260 = icmp ne i64 %t259, 0
  br i1 %t260, label %L69, label %L70
L69:
  %t261 = load ptr, ptr %t6
  %t262 = load i64, ptr %t261
  %t264 = sext i32 41 to i64
  %t263 = icmp ne i64 %t262, %t264
  %t265 = zext i1 %t263 to i64
  %t266 = icmp ne i64 %t265, 0
  %t267 = zext i1 %t266 to i64
  br label %L71
L70:
  br label %L71
L71:
  %t268 = phi i64 [ %t267, %L69 ], [ 0, %L70 ]
  %t269 = icmp ne i64 %t268, 0
  br i1 %t269, label %L67, label %L68
L67:
  %t270 = load ptr, ptr %t6
  %t271 = call ptr @skip_ws(ptr %t270)
  store ptr %t271, ptr %t6
  %t272 = load ptr, ptr %t6
  %t273 = load i64, ptr %t272
  %t275 = sext i32 41 to i64
  %t274 = icmp eq i64 %t273, %t275
  %t276 = zext i1 %t274 to i64
  %t277 = icmp ne i64 %t276, 0
  br i1 %t277, label %L72, label %L74
L72:
  br label %L68
L75:
  br label %L74
L74:
  %t278 = load ptr, ptr %t6
  %t279 = load i64, ptr %t278
  %t281 = sext i32 46 to i64
  %t280 = icmp eq i64 %t279, %t281
  %t282 = zext i1 %t280 to i64
  %t283 = icmp ne i64 %t282, 0
  br i1 %t283, label %L76, label %L77
L76:
  %t284 = load ptr, ptr %t6
  %t286 = ptrtoint ptr %t284 to i64
  %t287 = sext i32 1 to i64
  %t288 = inttoptr i64 %t286 to ptr
  %t285 = getelementptr i8, ptr %t288, i64 %t287
  %t289 = load i64, ptr %t285
  %t291 = sext i32 46 to i64
  %t290 = icmp eq i64 %t289, %t291
  %t292 = zext i1 %t290 to i64
  %t293 = icmp ne i64 %t292, 0
  %t294 = zext i1 %t293 to i64
  br label %L78
L77:
  br label %L78
L78:
  %t295 = phi i64 [ %t294, %L76 ], [ 0, %L77 ]
  %t296 = icmp ne i64 %t295, 0
  br i1 %t296, label %L79, label %L80
L79:
  %t297 = load ptr, ptr %t6
  %t299 = ptrtoint ptr %t297 to i64
  %t300 = sext i32 2 to i64
  %t301 = inttoptr i64 %t299 to ptr
  %t298 = getelementptr i8, ptr %t301, i64 %t300
  %t302 = load i64, ptr %t298
  %t304 = sext i32 46 to i64
  %t303 = icmp eq i64 %t302, %t304
  %t305 = zext i1 %t303 to i64
  %t306 = icmp ne i64 %t305, 0
  %t307 = zext i1 %t306 to i64
  br label %L81
L80:
  br label %L81
L81:
  %t308 = phi i64 [ %t307, %L79 ], [ 0, %L80 ]
  %t309 = icmp ne i64 %t308, 0
  br i1 %t309, label %L82, label %L84
L82:
  %t310 = sext i32 1 to i64
  store i64 %t310, ptr %t256
  %t311 = load ptr, ptr %t6
  %t313 = ptrtoint ptr %t311 to i64
  %t314 = sext i32 3 to i64
  %t312 = add i64 %t313, %t314
  store i64 %t312, ptr %t6
  %t315 = load ptr, ptr %t6
  %t316 = call ptr @skip_ws(ptr %t315)
  store ptr %t316, ptr %t6
  br label %L68
L85:
  br label %L84
L84:
  %t317 = alloca ptr
  %t318 = load ptr, ptr %t6
  %t319 = load ptr, ptr %t317
  %t320 = call ptr @read_ident(ptr %t318, ptr %t319, i64 8)
  store ptr %t320, ptr %t6
  %t321 = load ptr, ptr %t317
  %t322 = load i64, ptr %t321
  %t323 = icmp ne i64 %t322, 0
  br i1 %t323, label %L86, label %L87
L86:
  %t324 = load i64, ptr %t254
  %t326 = sext i32 16 to i64
  %t325 = icmp slt i64 %t324, %t326
  %t327 = zext i1 %t325 to i64
  %t328 = icmp ne i64 %t327, 0
  %t329 = zext i1 %t328 to i64
  br label %L88
L87:
  br label %L88
L88:
  %t330 = phi i64 [ %t329, %L86 ], [ 0, %L87 ]
  %t331 = icmp ne i64 %t330, 0
  br i1 %t331, label %L89, label %L91
L89:
  %t332 = load ptr, ptr %t317
  %t333 = call ptr @strdup(ptr %t332)
  %t334 = load ptr, ptr %t252
  %t335 = load i64, ptr %t254
  %t336 = add i64 %t335, 1
  store i64 %t336, ptr %t254
  %t337 = getelementptr ptr, ptr %t334, i64 %t335
  store ptr %t333, ptr %t337
  br label %L91
L91:
  %t338 = load ptr, ptr %t6
  %t339 = call ptr @skip_ws(ptr %t338)
  store ptr %t339, ptr %t6
  %t340 = load ptr, ptr %t6
  %t341 = load i64, ptr %t340
  %t343 = sext i32 44 to i64
  %t342 = icmp eq i64 %t341, %t343
  %t344 = zext i1 %t342 to i64
  %t345 = icmp ne i64 %t344, 0
  br i1 %t345, label %L92, label %L94
L92:
  %t346 = load ptr, ptr %t6
  %t348 = ptrtoint ptr %t346 to i64
  %t347 = add i64 %t348, 1
  store i64 %t347, ptr %t6
  br label %L94
L94:
  br label %L66
L68:
  %t349 = load i64, ptr %t256
  %t350 = add i64 %t349, 0
  %t351 = load ptr, ptr %t6
  %t352 = load i64, ptr %t351
  %t354 = sext i32 41 to i64
  %t353 = icmp eq i64 %t352, %t354
  %t355 = zext i1 %t353 to i64
  %t356 = icmp ne i64 %t355, 0
  br i1 %t356, label %L95, label %L97
L95:
  %t357 = load ptr, ptr %t6
  %t359 = ptrtoint ptr %t357 to i64
  %t358 = add i64 %t359, 1
  store i64 %t358, ptr %t6
  br label %L97
L97:
  %t360 = load ptr, ptr %t6
  %t361 = call ptr @skip_ws(ptr %t360)
  store ptr %t361, ptr %t6
  %t362 = alloca ptr
  %t363 = load ptr, ptr %t6
  store ptr %t363, ptr %t362
  %t364 = alloca ptr
  %t365 = load ptr, ptr %t6
  %t366 = call ptr @skip_to_eol(ptr %t365)
  store ptr %t366, ptr %t364
  %t367 = alloca ptr
  %t368 = load ptr, ptr %t364
  %t369 = load ptr, ptr %t362
  %t371 = ptrtoint ptr %t368 to i64
  %t372 = ptrtoint ptr %t369 to i64
  %t370 = sub i64 %t371, %t372
  %t374 = sext i32 1 to i64
  %t373 = add i64 %t370, %t374
  %t375 = call ptr @malloc(i64 %t373)
  store ptr %t375, ptr %t367
  %t376 = load ptr, ptr %t367
  %t377 = load ptr, ptr %t362
  %t378 = load ptr, ptr %t364
  %t379 = load ptr, ptr %t362
  %t381 = ptrtoint ptr %t378 to i64
  %t382 = ptrtoint ptr %t379 to i64
  %t380 = sub i64 %t381, %t382
  %t383 = call ptr @memcpy(ptr %t376, ptr %t377, i64 %t380)
  %t384 = load ptr, ptr %t367
  %t385 = load ptr, ptr %t364
  %t386 = load ptr, ptr %t362
  %t388 = ptrtoint ptr %t385 to i64
  %t389 = ptrtoint ptr %t386 to i64
  %t387 = sub i64 %t388, %t389
  %t390 = getelementptr ptr, ptr %t384, i64 %t387
  %t391 = sext i32 0 to i64
  store i64 %t391, ptr %t390
  %t392 = load ptr, ptr %t239
  %t393 = load ptr, ptr %t367
  %t394 = load ptr, ptr %t252
  %t395 = load i64, ptr %t254
  call void @macro_define(ptr %t392, ptr %t393, ptr %t394, i64 %t395, i64 1)
  %t397 = load ptr, ptr %t367
  call void @free(ptr %t397)
  %t399 = alloca i64
  %t400 = sext i32 0 to i64
  store i64 %t400, ptr %t399
  br label %L98
L98:
  %t401 = load i64, ptr %t399
  %t402 = load i64, ptr %t254
  %t403 = icmp slt i64 %t401, %t402
  %t404 = zext i1 %t403 to i64
  %t405 = icmp ne i64 %t404, 0
  br i1 %t405, label %L99, label %L101
L99:
  %t406 = load ptr, ptr %t252
  %t407 = load i64, ptr %t399
  %t408 = getelementptr ptr, ptr %t406, i64 %t407
  %t409 = load ptr, ptr %t408
  call void @free(ptr %t409)
  br label %L100
L100:
  %t411 = load i64, ptr %t399
  %t412 = add i64 %t411, 1
  store i64 %t412, ptr %t399
  br label %L98
L101:
  br label %L65
L64:
  %t413 = load ptr, ptr %t6
  %t414 = load i64, ptr %t413
  %t416 = sext i32 32 to i64
  %t415 = icmp eq i64 %t414, %t416
  %t417 = zext i1 %t415 to i64
  %t418 = icmp ne i64 %t417, 0
  br i1 %t418, label %L102, label %L103
L102:
  br label %L104
L103:
  %t419 = load ptr, ptr %t6
  %t420 = load i64, ptr %t419
  %t422 = sext i32 9 to i64
  %t421 = icmp eq i64 %t420, %t422
  %t423 = zext i1 %t421 to i64
  %t424 = icmp ne i64 %t423, 0
  %t425 = zext i1 %t424 to i64
  br label %L104
L104:
  %t426 = phi i64 [ 1, %L102 ], [ %t425, %L103 ]
  %t427 = icmp ne i64 %t426, 0
  br i1 %t427, label %L105, label %L107
L105:
  %t428 = load ptr, ptr %t6
  %t430 = ptrtoint ptr %t428 to i64
  %t429 = add i64 %t430, 1
  store i64 %t429, ptr %t6
  br label %L107
L107:
  %t431 = alloca ptr
  %t432 = load ptr, ptr %t6
  store ptr %t432, ptr %t431
  %t433 = alloca ptr
  %t434 = load ptr, ptr %t6
  %t435 = call ptr @skip_to_eol(ptr %t434)
  store ptr %t435, ptr %t433
  %t436 = alloca ptr
  %t437 = load ptr, ptr %t433
  %t438 = load ptr, ptr %t431
  %t440 = ptrtoint ptr %t437 to i64
  %t441 = ptrtoint ptr %t438 to i64
  %t439 = sub i64 %t440, %t441
  %t443 = sext i32 1 to i64
  %t442 = add i64 %t439, %t443
  %t444 = call ptr @malloc(i64 %t442)
  store ptr %t444, ptr %t436
  %t445 = load ptr, ptr %t436
  %t446 = load ptr, ptr %t431
  %t447 = load ptr, ptr %t433
  %t448 = load ptr, ptr %t431
  %t450 = ptrtoint ptr %t447 to i64
  %t451 = ptrtoint ptr %t448 to i64
  %t449 = sub i64 %t450, %t451
  %t452 = call ptr @memcpy(ptr %t445, ptr %t446, i64 %t449)
  %t453 = load ptr, ptr %t436
  %t454 = load ptr, ptr %t433
  %t455 = load ptr, ptr %t431
  %t457 = ptrtoint ptr %t454 to i64
  %t458 = ptrtoint ptr %t455 to i64
  %t456 = sub i64 %t457, %t458
  %t459 = getelementptr ptr, ptr %t453, i64 %t456
  %t460 = sext i32 0 to i64
  store i64 %t460, ptr %t459
  %t461 = load ptr, ptr %t239
  %t462 = load ptr, ptr %t436
  %t464 = sext i32 0 to i64
  %t463 = inttoptr i64 %t464 to ptr
  call void @macro_define(ptr %t461, ptr %t462, ptr %t463, i64 0, i64 0)
  %t466 = load ptr, ptr %t436
  call void @free(ptr %t466)
  br label %L65
L65:
  ret void
L108:
  br label %L62
L62:
  %t468 = load ptr, ptr %t12
  %t469 = getelementptr [6 x i8], ptr @.str17, i64 0, i64 0
  %t470 = call i32 @strcmp(ptr %t468, ptr %t469)
  %t471 = sext i32 %t470 to i64
  %t473 = sext i32 0 to i64
  %t472 = icmp eq i64 %t471, %t473
  %t474 = zext i1 %t472 to i64
  %t475 = icmp ne i64 %t474, 0
  br i1 %t475, label %L109, label %L111
L109:
  %t476 = alloca ptr
  %t477 = load ptr, ptr %t6
  %t478 = load ptr, ptr %t476
  %t479 = call ptr @read_ident(ptr %t477, ptr %t478, i64 8)
  %t480 = load ptr, ptr %t476
  call void @macro_undef(ptr %t480)
  ret void
L112:
  br label %L111
L111:
  %t482 = load ptr, ptr %t12
  %t483 = getelementptr [8 x i8], ptr @.str18, i64 0, i64 0
  %t484 = call i32 @strcmp(ptr %t482, ptr %t483)
  %t485 = sext i32 %t484 to i64
  %t487 = sext i32 0 to i64
  %t486 = icmp eq i64 %t485, %t487
  %t488 = zext i1 %t486 to i64
  %t489 = icmp ne i64 %t488, 0
  br i1 %t489, label %L113, label %L115
L113:
  %t491 = sext i32 32 to i64
  %t490 = icmp sgt i64 %t3, %t491
  %t492 = zext i1 %t490 to i64
  %t493 = icmp ne i64 %t492, 0
  br i1 %t493, label %L116, label %L118
L116:
  %t494 = call ptr @__c0c_stderr()
  %t495 = getelementptr [36 x i8], ptr @.str19, i64 0, i64 0
  %t496 = call i32 @fprintf(ptr %t494, ptr %t495)
  %t497 = sext i32 %t496 to i64
  ret void
L119:
  br label %L118
L118:
  %t498 = alloca i64
  %t499 = sext i32 0 to i64
  store i64 %t499, ptr %t498
  %t500 = alloca ptr
  %t501 = load ptr, ptr %t6
  %t502 = load i64, ptr %t501
  %t504 = sext i32 34 to i64
  %t503 = icmp eq i64 %t502, %t504
  %t505 = zext i1 %t503 to i64
  %t506 = icmp ne i64 %t505, 0
  br i1 %t506, label %L120, label %L121
L120:
  %t507 = load ptr, ptr %t6
  %t509 = ptrtoint ptr %t507 to i64
  %t508 = add i64 %t509, 1
  store i64 %t508, ptr %t6
  %t510 = alloca ptr
  %t511 = load ptr, ptr %t6
  %t512 = call ptr @strchr(ptr %t511, i64 34)
  store ptr %t512, ptr %t510
  %t513 = load ptr, ptr %t510
  %t515 = ptrtoint ptr %t513 to i64
  %t516 = icmp eq i64 %t515, 0
  %t514 = zext i1 %t516 to i64
  %t517 = icmp ne i64 %t514, 0
  br i1 %t517, label %L123, label %L125
L123:
  ret void
L126:
  br label %L125
L125:
  %t518 = alloca i64
  %t519 = load ptr, ptr %t510
  %t520 = load ptr, ptr %t6
  %t522 = ptrtoint ptr %t519 to i64
  %t523 = ptrtoint ptr %t520 to i64
  %t521 = sub i64 %t522, %t523
  %t524 = add i64 %t521, 0
  store i64 %t524, ptr %t518
  %t525 = load ptr, ptr %t500
  %t526 = load ptr, ptr %t6
  %t527 = load i64, ptr %t518
  %t528 = call ptr @memcpy(ptr %t525, ptr %t526, i64 %t527)
  %t529 = load ptr, ptr %t500
  %t530 = load i64, ptr %t518
  %t531 = getelementptr ptr, ptr %t529, i64 %t530
  %t532 = sext i32 0 to i64
  store i64 %t532, ptr %t531
  br label %L122
L121:
  %t533 = load ptr, ptr %t6
  %t534 = load i64, ptr %t533
  %t536 = sext i32 60 to i64
  %t535 = icmp eq i64 %t534, %t536
  %t537 = zext i1 %t535 to i64
  %t538 = icmp ne i64 %t537, 0
  br i1 %t538, label %L127, label %L128
L127:
  %t539 = load ptr, ptr %t6
  %t541 = ptrtoint ptr %t539 to i64
  %t540 = add i64 %t541, 1
  store i64 %t540, ptr %t6
  %t542 = alloca ptr
  %t543 = load ptr, ptr %t6
  %t544 = call ptr @strchr(ptr %t543, i64 62)
  store ptr %t544, ptr %t542
  %t545 = load ptr, ptr %t542
  %t547 = ptrtoint ptr %t545 to i64
  %t548 = icmp eq i64 %t547, 0
  %t546 = zext i1 %t548 to i64
  %t549 = icmp ne i64 %t546, 0
  br i1 %t549, label %L130, label %L132
L130:
  ret void
L133:
  br label %L132
L132:
  %t550 = alloca i64
  %t551 = load ptr, ptr %t542
  %t552 = load ptr, ptr %t6
  %t554 = ptrtoint ptr %t551 to i64
  %t555 = ptrtoint ptr %t552 to i64
  %t553 = sub i64 %t554, %t555
  %t556 = add i64 %t553, 0
  store i64 %t556, ptr %t550
  %t557 = load ptr, ptr %t500
  %t558 = load ptr, ptr %t6
  %t559 = load i64, ptr %t550
  %t560 = call ptr @memcpy(ptr %t557, ptr %t558, i64 %t559)
  %t561 = load ptr, ptr %t500
  %t562 = load i64, ptr %t550
  %t563 = getelementptr ptr, ptr %t561, i64 %t562
  %t564 = sext i32 0 to i64
  store i64 %t564, ptr %t563
  %t565 = sext i32 1 to i64
  store i64 %t565, ptr %t498
  br label %L129
L128:
  ret void
L134:
  br label %L129
L129:
  br label %L122
L122:
  %t566 = alloca ptr
  %t567 = load ptr, ptr %t500
  %t568 = load i64, ptr %t498
  %t569 = call ptr @find_include(ptr %t567, i64 %t568)
  store ptr %t569, ptr %t566
  %t570 = load ptr, ptr %t566
  %t572 = ptrtoint ptr %t570 to i64
  %t573 = icmp eq i64 %t572, 0
  %t571 = zext i1 %t573 to i64
  %t574 = icmp ne i64 %t571, 0
  br i1 %t574, label %L135, label %L137
L135:
  %t575 = getelementptr [2 x i8], ptr @.str20, i64 0, i64 0
  call void @buf_append(ptr %t2, ptr %t575, i64 1)
  ret void
L138:
  br label %L137
L137:
  %t577 = load i64, ptr %t498
  %t578 = icmp ne i64 %t577, 0
  br i1 %t578, label %L139, label %L141
L139:
  %t579 = load ptr, ptr %t566
  call void @free(ptr %t579)
  %t581 = getelementptr [2 x i8], ptr @.str21, i64 0, i64 0
  call void @buf_append(ptr %t2, ptr %t581, i64 1)
  ret void
L142:
  br label %L141
L141:
  %t583 = alloca ptr
  %t584 = load ptr, ptr %t566
  %t585 = load ptr, ptr %t500
  %t587 = sext i32 1 to i64
  %t586 = add i64 %t3, %t587
  %t588 = call ptr @macro_preprocess(ptr %t584, ptr %t585, i64 %t586)
  store ptr %t588, ptr %t583
  %t589 = load ptr, ptr %t566
  call void @free(ptr %t589)
  %t591 = load ptr, ptr %t583
  %t592 = load ptr, ptr %t583
  %t593 = call i64 @strlen(ptr %t592)
  call void @buf_append(ptr %t2, ptr %t591, i64 %t593)
  call void @buf_putc(ptr %t2, i64 10)
  %t596 = load ptr, ptr %t583
  call void @free(ptr %t596)
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
  %t14 = getelementptr [8 x i8], ptr @.str22, i64 0, i64 0
  %t15 = getelementptr [2 x i8], ptr @.str23, i64 0, i64 0
  %t17 = sext i32 0 to i64
  %t16 = inttoptr i64 %t17 to ptr
  call void @macro_define(ptr %t14, ptr %t15, ptr %t16, i64 0, i64 0)
  %t19 = getelementptr [9 x i8], ptr @.str24, i64 0, i64 0
  %t20 = getelementptr [2 x i8], ptr @.str25, i64 0, i64 0
  %t22 = sext i32 0 to i64
  %t21 = inttoptr i64 %t22 to ptr
  call void @macro_define(ptr %t19, ptr %t20, ptr %t21, i64 0, i64 0)
  %t24 = getelementptr [5 x i8], ptr @.str26, i64 0, i64 0
  %t25 = getelementptr [11 x i8], ptr @.str27, i64 0, i64 0
  %t27 = sext i32 0 to i64
  %t26 = inttoptr i64 %t27 to ptr
  call void @macro_define(ptr %t24, ptr %t25, ptr %t26, i64 0, i64 0)
  %t29 = getelementptr [9 x i8], ptr @.str28, i64 0, i64 0
  %t30 = getelementptr [2 x i8], ptr @.str29, i64 0, i64 0
  %t32 = sext i32 0 to i64
  %t31 = inttoptr i64 %t32 to ptr
  call void @macro_define(ptr %t29, ptr %t30, ptr %t31, i64 0, i64 0)
  %t34 = getelementptr [9 x i8], ptr @.str30, i64 0, i64 0
  %t35 = getelementptr [2 x i8], ptr @.str31, i64 0, i64 0
  %t37 = sext i32 0 to i64
  %t36 = inttoptr i64 %t37 to ptr
  call void @macro_define(ptr %t34, ptr %t35, ptr %t36, i64 0, i64 0)
  %t39 = getelementptr [9 x i8], ptr @.str32, i64 0, i64 0
  %t40 = getelementptr [2 x i8], ptr @.str33, i64 0, i64 0
  %t42 = sext i32 0 to i64
  %t41 = inttoptr i64 %t42 to ptr
  call void @macro_define(ptr %t39, ptr %t40, ptr %t41, i64 0, i64 0)
  %t44 = getelementptr [9 x i8], ptr @.str34, i64 0, i64 0
  %t45 = getelementptr [2 x i8], ptr @.str35, i64 0, i64 0
  %t47 = sext i32 0 to i64
  %t46 = inttoptr i64 %t47 to ptr
  call void @macro_define(ptr %t44, ptr %t45, ptr %t46, i64 0, i64 0)
  %t49 = getelementptr [4 x i8], ptr @.str36, i64 0, i64 0
  %t50 = getelementptr [5 x i8], ptr @.str37, i64 0, i64 0
  %t52 = sext i32 0 to i64
  %t51 = inttoptr i64 %t52 to ptr
  call void @macro_define(ptr %t49, ptr %t50, ptr %t51, i64 0, i64 0)
  %t54 = getelementptr [13 x i8], ptr @.str38, i64 0, i64 0
  %t55 = getelementptr [2 x i8], ptr @.str39, i64 0, i64 0
  %t57 = sext i32 0 to i64
  %t56 = inttoptr i64 %t57 to ptr
  call void @macro_define(ptr %t54, ptr %t55, ptr %t56, i64 0, i64 0)
  %t59 = getelementptr [13 x i8], ptr @.str40, i64 0, i64 0
  %t60 = getelementptr [2 x i8], ptr @.str41, i64 0, i64 0
  %t62 = sext i32 0 to i64
  %t61 = inttoptr i64 %t62 to ptr
  call void @macro_define(ptr %t59, ptr %t60, ptr %t61, i64 0, i64 0)
  %t64 = getelementptr [7 x i8], ptr @.str42, i64 0, i64 0
  %t65 = getelementptr [10 x i8], ptr @.str43, i64 0, i64 0
  %t67 = sext i32 0 to i64
  %t66 = inttoptr i64 %t67 to ptr
  call void @macro_define(ptr %t64, ptr %t65, ptr %t66, i64 0, i64 0)
  %t69 = getelementptr [9 x i8], ptr @.str44, i64 0, i64 0
  %t70 = getelementptr [15 x i8], ptr @.str45, i64 0, i64 0
  %t72 = sext i32 0 to i64
  %t71 = inttoptr i64 %t72 to ptr
  call void @macro_define(ptr %t69, ptr %t70, ptr %t71, i64 0, i64 0)
  %t74 = getelementptr [7 x i8], ptr @.str46, i64 0, i64 0
  %t75 = getelementptr [13 x i8], ptr @.str47, i64 0, i64 0
  %t77 = sext i32 0 to i64
  %t76 = inttoptr i64 %t77 to ptr
  call void @macro_define(ptr %t74, ptr %t75, ptr %t76, i64 0, i64 0)
  %t79 = getelementptr [8 x i8], ptr @.str48, i64 0, i64 0
  %t80 = getelementptr [14 x i8], ptr @.str49, i64 0, i64 0
  %t82 = sext i32 0 to i64
  %t81 = inttoptr i64 %t82 to ptr
  call void @macro_define(ptr %t79, ptr %t80, ptr %t81, i64 0, i64 0)
  %t84 = getelementptr [7 x i8], ptr @.str50, i64 0, i64 0
  %t85 = getelementptr [15 x i8], ptr @.str51, i64 0, i64 0
  %t87 = sext i32 0 to i64
  %t86 = inttoptr i64 %t87 to ptr
  call void @macro_define(ptr %t84, ptr %t85, ptr %t86, i64 0, i64 0)
  %t89 = getelementptr [7 x i8], ptr @.str52, i64 0, i64 0
  %t90 = getelementptr [15 x i8], ptr @.str53, i64 0, i64 0
  %t92 = sext i32 0 to i64
  %t91 = inttoptr i64 %t92 to ptr
  call void @macro_define(ptr %t89, ptr %t90, ptr %t91, i64 0, i64 0)
  %t94 = getelementptr [6 x i8], ptr @.str54, i64 0, i64 0
  %t95 = getelementptr [14 x i8], ptr @.str55, i64 0, i64 0
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
@.str3 = private unnamed_addr constant [12 x i8] c"__VA_ARGS__\00"
@.str4 = private unnamed_addr constant [2 x i8] c"r\00"
@.str5 = private unnamed_addr constant [13 x i8] c"/usr/include\00"
@.str6 = private unnamed_addr constant [19 x i8] c"/usr/local/include\00"
@.str7 = private unnamed_addr constant [2 x i8] c".\00"
@.str8 = private unnamed_addr constant [6 x i8] c"%s/%s\00"
@.str9 = private unnamed_addr constant [6 x i8] c"ifdef\00"
@.str10 = private unnamed_addr constant [7 x i8] c"ifndef\00"
@.str11 = private unnamed_addr constant [3 x i8] c"if\00"
@.str12 = private unnamed_addr constant [8 x i8] c"defined\00"
@.str13 = private unnamed_addr constant [5 x i8] c"elif\00"
@.str14 = private unnamed_addr constant [5 x i8] c"else\00"
@.str15 = private unnamed_addr constant [6 x i8] c"endif\00"
@.str16 = private unnamed_addr constant [7 x i8] c"define\00"
@.str17 = private unnamed_addr constant [6 x i8] c"undef\00"
@.str18 = private unnamed_addr constant [8 x i8] c"include\00"
@.str19 = private unnamed_addr constant [36 x i8] c"warning: max include depth reached\0A\00"
@.str20 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str21 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str22 = private unnamed_addr constant [8 x i8] c"__C0C__\00"
@.str23 = private unnamed_addr constant [2 x i8] c"1\00"
@.str24 = private unnamed_addr constant [9 x i8] c"__STDC__\00"
@.str25 = private unnamed_addr constant [2 x i8] c"1\00"
@.str26 = private unnamed_addr constant [5 x i8] c"NULL\00"
@.str27 = private unnamed_addr constant [11 x i8] c"((void*)0)\00"
@.str28 = private unnamed_addr constant [9 x i8] c"__LP64__\00"
@.str29 = private unnamed_addr constant [2 x i8] c"1\00"
@.str30 = private unnamed_addr constant [9 x i8] c"SEEK_SET\00"
@.str31 = private unnamed_addr constant [2 x i8] c"0\00"
@.str32 = private unnamed_addr constant [9 x i8] c"SEEK_CUR\00"
@.str33 = private unnamed_addr constant [2 x i8] c"1\00"
@.str34 = private unnamed_addr constant [9 x i8] c"SEEK_END\00"
@.str35 = private unnamed_addr constant [2 x i8] c"2\00"
@.str36 = private unnamed_addr constant [4 x i8] c"EOF\00"
@.str37 = private unnamed_addr constant [5 x i8] c"(-1)\00"
@.str38 = private unnamed_addr constant [13 x i8] c"EXIT_SUCCESS\00"
@.str39 = private unnamed_addr constant [2 x i8] c"0\00"
@.str40 = private unnamed_addr constant [13 x i8] c"EXIT_FAILURE\00"
@.str41 = private unnamed_addr constant [2 x i8] c"1\00"
@.str42 = private unnamed_addr constant [7 x i8] c"assert\00"
@.str43 = private unnamed_addr constant [10 x i8] c"((void)0)\00"
@.str44 = private unnamed_addr constant [9 x i8] c"va_start\00"
@.str45 = private unnamed_addr constant [15 x i8] c"__c0c_va_start\00"
@.str46 = private unnamed_addr constant [7 x i8] c"va_end\00"
@.str47 = private unnamed_addr constant [13 x i8] c"__c0c_va_end\00"
@.str48 = private unnamed_addr constant [8 x i8] c"va_copy\00"
@.str49 = private unnamed_addr constant [14 x i8] c"__c0c_va_copy\00"
@.str50 = private unnamed_addr constant [7 x i8] c"stderr\00"
@.str51 = private unnamed_addr constant [15 x i8] c"__c0c_stderr()\00"
@.str52 = private unnamed_addr constant [7 x i8] c"stdout\00"
@.str53 = private unnamed_addr constant [15 x i8] c"__c0c_stdout()\00"
@.str54 = private unnamed_addr constant [6 x i8] c"stdin\00"
@.str55 = private unnamed_addr constant [14 x i8] c"__c0c_stdin()\00"
