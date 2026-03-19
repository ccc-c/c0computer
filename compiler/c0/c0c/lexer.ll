; ModuleID = 'lexer.c'
source_filename = "lexer.c"
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

@KEYWORDS = internal global ptr zeroinitializer

define internal i8 @cur(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t2 to i64
  %t4 = getelementptr i32, ptr %t1, i64 %t3
  %t5 = load i64, ptr %t4
  %t6 = trunc i64 %t5 to i8
  ret i8 %t6
L0:
  ret i8 0
}

define internal i8 @peek1(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = load ptr, ptr %t0
  %t4 = ptrtoint ptr %t2 to i64
  %t5 = sext i32 1 to i64
  %t6 = inttoptr i64 %t4 to ptr
  %t3 = getelementptr i8, ptr %t6, i64 %t5
  %t7 = ptrtoint ptr %t3 to i64
  %t8 = getelementptr i32, ptr %t1, i64 %t7
  %t9 = load i64, ptr %t8
  %t10 = trunc i64 %t9 to i8
  ret i8 %t10
L0:
  ret i8 0
}

define internal i8 @advance(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t3 to i64
  %t4 = add i64 %t5, 1
  store i64 %t4, ptr %t0
  %t6 = ptrtoint ptr %t3 to i64
  %t7 = getelementptr i32, ptr %t2, i64 %t6
  %t8 = load i64, ptr %t7
  store i64 %t8, ptr %t1
  %t9 = load i64, ptr %t1
  %t11 = sext i32 10 to i64
  %t10 = icmp eq i64 %t9, %t11
  %t12 = zext i1 %t10 to i64
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L0, label %L1
L0:
  %t14 = load ptr, ptr %t0
  %t16 = ptrtoint ptr %t14 to i64
  %t15 = add i64 %t16, 1
  store i64 %t15, ptr %t0
  %t17 = sext i32 1 to i64
  store i64 %t17, ptr %t0
  br label %L2
L1:
  %t18 = load ptr, ptr %t0
  %t20 = ptrtoint ptr %t18 to i64
  %t19 = add i64 %t20, 1
  store i64 %t19, ptr %t0
  br label %L2
L2:
  %t21 = load i64, ptr %t1
  %t22 = trunc i64 %t21 to i8
  ret i8 %t22
L3:
  ret i8 0
}

define internal ptr @strndup_local(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca ptr
  %t4 = ptrtoint ptr %t1 to i64
  %t5 = sext i32 1 to i64
  %t6 = inttoptr i64 %t4 to ptr
  %t3 = getelementptr i8, ptr %t6, i64 %t5
  %t7 = call ptr @malloc(ptr %t3)
  store ptr %t7, ptr %t2
  %t8 = load ptr, ptr %t2
  %t10 = ptrtoint ptr %t8 to i64
  %t11 = icmp eq i64 %t10, 0
  %t9 = zext i1 %t11 to i64
  %t12 = icmp ne i64 %t9, 0
  br i1 %t12, label %L0, label %L2
L0:
  %t13 = getelementptr [7 x i8], ptr @.str0, i64 0, i64 0
  %t14 = call i32 @perror(ptr %t13)
  %t15 = sext i32 %t14 to i64
  %t16 = call i32 @exit(i64 1)
  %t17 = sext i32 %t16 to i64
  br label %L2
L2:
  %t18 = load ptr, ptr %t2
  %t19 = call ptr @memcpy(ptr %t18, ptr %t0, ptr %t1)
  %t20 = load ptr, ptr %t2
  %t22 = ptrtoint ptr %t1 to i64
  %t21 = getelementptr i8, ptr %t20, i64 %t22
  %t23 = sext i32 0 to i64
  store i64 %t23, ptr %t21
  %t24 = load ptr, ptr %t2
  ret ptr %t24
L3:
  ret ptr null
}

define internal i64 @keyword_lookup(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = sext i32 0 to i64
  store i64 %t2, ptr %t1
  br label %L0
L0:
  %t3 = load ptr, ptr @KEYWORDS
  %t4 = load i64, ptr %t1
  %t5 = getelementptr i8, ptr %t3, i64 %t4
  %t6 = load ptr, ptr %t5
  %t7 = icmp ne ptr %t6, null
  br i1 %t7, label %L1, label %L3
L1:
  %t8 = load ptr, ptr @KEYWORDS
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
  %t18 = load ptr, ptr @KEYWORDS
  %t19 = load i64, ptr %t1
  %t20 = getelementptr i8, ptr %t18, i64 %t19
  %t21 = load ptr, ptr %t20
  %t22 = ptrtoint ptr %t21 to i64
  ret i64 %t22
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t23 = load i64, ptr %t1
  %t24 = add i64 %t23, 1
  store i64 %t24, ptr %t1
  br label %L0
L3:
  %t25 = sext i32 4 to i64
  ret i64 %t25
L8:
  ret i64 0
}

define dso_local ptr @lexer_new(ptr %t0, ptr %t1) {
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
  %t9 = getelementptr [7 x i8], ptr @.str1, i64 0, i64 0
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
  %t17 = sext i32 1 to i64
  store i64 %t17, ptr %t16
  %t18 = load ptr, ptr %t2
  %t19 = sext i32 1 to i64
  store i64 %t19, ptr %t18
  %t20 = load ptr, ptr %t2
  ret ptr %t20
L3:
  ret ptr null
}

define dso_local void @lexer_free(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = icmp ne ptr %t1, null
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = load ptr, ptr %t0
  call void @token_free(ptr %t3)
  br label %L2
L2:
  %t5 = call i32 @free(ptr %t0)
  %t6 = sext i32 %t5 to i64
  ret void
}

define dso_local void @token_free(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @free(ptr %t1)
  %t3 = sext i32 %t2 to i64
  ret void
}

define internal void @skip_ws(ptr %t0) {
entry:
  br label %L0
L0:
  br label %L1
L1:
  br label %L4
L4:
  %t1 = call i8 @cur(ptr %t0)
  %t2 = sext i8 %t1 to i64
  %t3 = call i8 @cur(ptr %t0)
  %t4 = sext i8 %t3 to i64
  %t5 = add i64 %t4, 0
  %t6 = call i32 @isspace(i64 %t5)
  %t7 = sext i32 %t6 to i64
  %t9 = icmp ne i64 %t2, 0
  %t10 = icmp ne i64 %t7, 0
  %t11 = and i1 %t9, %t10
  %t12 = zext i1 %t11 to i64
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L5, label %L6
L5:
  %t14 = call i8 @advance(ptr %t0)
  %t15 = sext i8 %t14 to i64
  br label %L4
L6:
  %t16 = call i8 @cur(ptr %t0)
  %t17 = sext i8 %t16 to i64
  %t19 = sext i32 47 to i64
  %t18 = icmp eq i64 %t17, %t19
  %t20 = zext i1 %t18 to i64
  %t21 = call i8 @peek1(ptr %t0)
  %t22 = sext i8 %t21 to i64
  %t24 = sext i32 47 to i64
  %t23 = icmp eq i64 %t22, %t24
  %t25 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t20, 0
  %t28 = icmp ne i64 %t25, 0
  %t29 = and i1 %t27, %t28
  %t30 = zext i1 %t29 to i64
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L7, label %L9
L7:
  br label %L10
L10:
  %t32 = call i8 @cur(ptr %t0)
  %t33 = sext i8 %t32 to i64
  %t34 = call i8 @cur(ptr %t0)
  %t35 = sext i8 %t34 to i64
  %t37 = sext i32 10 to i64
  %t36 = icmp ne i64 %t35, %t37
  %t38 = zext i1 %t36 to i64
  %t40 = icmp ne i64 %t33, 0
  %t41 = icmp ne i64 %t38, 0
  %t42 = and i1 %t40, %t41
  %t43 = zext i1 %t42 to i64
  %t44 = icmp ne i64 %t43, 0
  br i1 %t44, label %L11, label %L12
L11:
  %t45 = call i8 @advance(ptr %t0)
  %t46 = sext i8 %t45 to i64
  br label %L10
L12:
  br label %L2
L13:
  br label %L9
L9:
  %t47 = call i8 @cur(ptr %t0)
  %t48 = sext i8 %t47 to i64
  %t50 = sext i32 47 to i64
  %t49 = icmp eq i64 %t48, %t50
  %t51 = zext i1 %t49 to i64
  %t52 = call i8 @peek1(ptr %t0)
  %t53 = sext i8 %t52 to i64
  %t55 = sext i32 42 to i64
  %t54 = icmp eq i64 %t53, %t55
  %t56 = zext i1 %t54 to i64
  %t58 = icmp ne i64 %t51, 0
  %t59 = icmp ne i64 %t56, 0
  %t60 = and i1 %t58, %t59
  %t61 = zext i1 %t60 to i64
  %t62 = icmp ne i64 %t61, 0
  br i1 %t62, label %L14, label %L16
L14:
  %t63 = call i8 @advance(ptr %t0)
  %t64 = sext i8 %t63 to i64
  %t65 = call i8 @advance(ptr %t0)
  %t66 = sext i8 %t65 to i64
  br label %L17
L17:
  %t67 = call i8 @cur(ptr %t0)
  %t68 = sext i8 %t67 to i64
  %t69 = call i8 @cur(ptr %t0)
  %t70 = sext i8 %t69 to i64
  %t72 = sext i32 42 to i64
  %t71 = icmp eq i64 %t70, %t72
  %t73 = zext i1 %t71 to i64
  %t74 = call i8 @peek1(ptr %t0)
  %t75 = sext i8 %t74 to i64
  %t77 = sext i32 47 to i64
  %t76 = icmp eq i64 %t75, %t77
  %t78 = zext i1 %t76 to i64
  %t80 = icmp ne i64 %t73, 0
  %t81 = icmp ne i64 %t78, 0
  %t82 = and i1 %t80, %t81
  %t83 = zext i1 %t82 to i64
  %t85 = icmp eq i64 %t83, 0
  %t84 = zext i1 %t85 to i64
  %t87 = icmp ne i64 %t68, 0
  %t88 = icmp ne i64 %t84, 0
  %t89 = and i1 %t87, %t88
  %t90 = zext i1 %t89 to i64
  %t91 = icmp ne i64 %t90, 0
  br i1 %t91, label %L18, label %L19
L18:
  %t92 = call i8 @advance(ptr %t0)
  %t93 = sext i8 %t92 to i64
  br label %L17
L19:
  %t94 = call i8 @cur(ptr %t0)
  %t95 = sext i8 %t94 to i64
  %t96 = icmp ne i64 %t95, 0
  br i1 %t96, label %L20, label %L22
L20:
  %t97 = call i8 @advance(ptr %t0)
  %t98 = sext i8 %t97 to i64
  %t99 = call i8 @advance(ptr %t0)
  %t100 = sext i8 %t99 to i64
  br label %L22
L22:
  br label %L2
L23:
  br label %L16
L16:
  br label %L3
L24:
  br label %L2
L2:
  br label %L0
L3:
  ret void
}

define internal i64 @read_token(ptr %t0) {
entry:
  call void @skip_ws(ptr %t0)
  %t2 = alloca i64
  %t3 = load ptr, ptr %t0
  store ptr %t3, ptr %t2
  %t4 = load ptr, ptr %t0
  store ptr %t4, ptr %t2
  %t6 = sext i32 0 to i64
  %t5 = inttoptr i64 %t6 to ptr
  store ptr %t5, ptr %t2
  %t7 = call i8 @cur(ptr %t0)
  %t8 = sext i8 %t7 to i64
  %t10 = icmp eq i64 %t8, 0
  %t9 = zext i1 %t10 to i64
  %t11 = icmp ne i64 %t9, 0
  br i1 %t11, label %L0, label %L2
L0:
  %t12 = sext i32 81 to i64
  store i64 %t12, ptr %t2
  %t13 = getelementptr [1 x i8], ptr @.str2, i64 0, i64 0
  %t14 = call ptr @strdup(ptr %t13)
  store ptr %t14, ptr %t2
  %t15 = load i64, ptr %t2
  ret i64 %t15
L3:
  br label %L2
L2:
  %t16 = call i8 @cur(ptr %t0)
  %t17 = sext i8 %t16 to i64
  %t18 = add i64 %t17, 0
  %t19 = call i32 @isdigit(i64 %t18)
  %t20 = sext i32 %t19 to i64
  %t21 = call i8 @cur(ptr %t0)
  %t22 = sext i8 %t21 to i64
  %t24 = sext i32 46 to i64
  %t23 = icmp eq i64 %t22, %t24
  %t25 = zext i1 %t23 to i64
  %t26 = call i8 @peek1(ptr %t0)
  %t27 = sext i8 %t26 to i64
  %t28 = add i64 %t27, 0
  %t29 = call i32 @isdigit(i64 %t28)
  %t30 = sext i32 %t29 to i64
  %t32 = icmp ne i64 %t25, 0
  %t33 = icmp ne i64 %t30, 0
  %t34 = and i1 %t32, %t33
  %t35 = zext i1 %t34 to i64
  %t37 = icmp ne i64 %t20, 0
  %t38 = icmp ne i64 %t35, 0
  %t39 = or i1 %t37, %t38
  %t40 = zext i1 %t39 to i64
  %t41 = icmp ne i64 %t40, 0
  br i1 %t41, label %L4, label %L6
L4:
  %t42 = alloca i64
  %t43 = load ptr, ptr %t0
  store ptr %t43, ptr %t42
  %t44 = alloca i64
  %t45 = sext i32 0 to i64
  store i64 %t45, ptr %t44
  %t46 = call i8 @cur(ptr %t0)
  %t47 = sext i8 %t46 to i64
  %t49 = sext i32 48 to i64
  %t48 = icmp eq i64 %t47, %t49
  %t50 = zext i1 %t48 to i64
  %t51 = call i8 @peek1(ptr %t0)
  %t52 = sext i8 %t51 to i64
  %t54 = sext i32 120 to i64
  %t53 = icmp eq i64 %t52, %t54
  %t55 = zext i1 %t53 to i64
  %t56 = call i8 @peek1(ptr %t0)
  %t57 = sext i8 %t56 to i64
  %t59 = sext i32 88 to i64
  %t58 = icmp eq i64 %t57, %t59
  %t60 = zext i1 %t58 to i64
  %t62 = icmp ne i64 %t55, 0
  %t63 = icmp ne i64 %t60, 0
  %t64 = or i1 %t62, %t63
  %t65 = zext i1 %t64 to i64
  %t67 = icmp ne i64 %t50, 0
  %t68 = icmp ne i64 %t65, 0
  %t69 = and i1 %t67, %t68
  %t70 = zext i1 %t69 to i64
  %t71 = icmp ne i64 %t70, 0
  br i1 %t71, label %L7, label %L8
L7:
  %t72 = call i8 @advance(ptr %t0)
  %t73 = sext i8 %t72 to i64
  %t74 = call i8 @advance(ptr %t0)
  %t75 = sext i8 %t74 to i64
  br label %L10
L10:
  %t76 = call i8 @cur(ptr %t0)
  %t77 = sext i8 %t76 to i64
  %t78 = add i64 %t77, 0
  %t79 = call i32 @isxdigit(i64 %t78)
  %t80 = sext i32 %t79 to i64
  %t81 = icmp ne i64 %t80, 0
  br i1 %t81, label %L11, label %L12
L11:
  %t82 = call i8 @advance(ptr %t0)
  %t83 = sext i8 %t82 to i64
  br label %L10
L12:
  br label %L9
L8:
  br label %L13
L13:
  %t84 = call i8 @cur(ptr %t0)
  %t85 = sext i8 %t84 to i64
  %t86 = add i64 %t85, 0
  %t87 = call i32 @isdigit(i64 %t86)
  %t88 = sext i32 %t87 to i64
  %t89 = icmp ne i64 %t88, 0
  br i1 %t89, label %L14, label %L15
L14:
  %t90 = call i8 @advance(ptr %t0)
  %t91 = sext i8 %t90 to i64
  br label %L13
L15:
  %t92 = call i8 @cur(ptr %t0)
  %t93 = sext i8 %t92 to i64
  %t95 = sext i32 46 to i64
  %t94 = icmp eq i64 %t93, %t95
  %t96 = zext i1 %t94 to i64
  %t97 = icmp ne i64 %t96, 0
  br i1 %t97, label %L16, label %L18
L16:
  %t98 = sext i32 1 to i64
  store i64 %t98, ptr %t44
  %t99 = call i8 @advance(ptr %t0)
  %t100 = sext i8 %t99 to i64
  br label %L18
L18:
  br label %L19
L19:
  %t101 = call i8 @cur(ptr %t0)
  %t102 = sext i8 %t101 to i64
  %t103 = add i64 %t102, 0
  %t104 = call i32 @isdigit(i64 %t103)
  %t105 = sext i32 %t104 to i64
  %t106 = icmp ne i64 %t105, 0
  br i1 %t106, label %L20, label %L21
L20:
  %t107 = call i8 @advance(ptr %t0)
  %t108 = sext i8 %t107 to i64
  br label %L19
L21:
  %t109 = call i8 @cur(ptr %t0)
  %t110 = sext i8 %t109 to i64
  %t112 = sext i32 101 to i64
  %t111 = icmp eq i64 %t110, %t112
  %t113 = zext i1 %t111 to i64
  %t114 = call i8 @cur(ptr %t0)
  %t115 = sext i8 %t114 to i64
  %t117 = sext i32 69 to i64
  %t116 = icmp eq i64 %t115, %t117
  %t118 = zext i1 %t116 to i64
  %t120 = icmp ne i64 %t113, 0
  %t121 = icmp ne i64 %t118, 0
  %t122 = or i1 %t120, %t121
  %t123 = zext i1 %t122 to i64
  %t124 = icmp ne i64 %t123, 0
  br i1 %t124, label %L22, label %L24
L22:
  %t125 = sext i32 1 to i64
  store i64 %t125, ptr %t44
  %t126 = call i8 @advance(ptr %t0)
  %t127 = sext i8 %t126 to i64
  %t128 = call i8 @cur(ptr %t0)
  %t129 = sext i8 %t128 to i64
  %t131 = sext i32 43 to i64
  %t130 = icmp eq i64 %t129, %t131
  %t132 = zext i1 %t130 to i64
  %t133 = call i8 @cur(ptr %t0)
  %t134 = sext i8 %t133 to i64
  %t136 = sext i32 45 to i64
  %t135 = icmp eq i64 %t134, %t136
  %t137 = zext i1 %t135 to i64
  %t139 = icmp ne i64 %t132, 0
  %t140 = icmp ne i64 %t137, 0
  %t141 = or i1 %t139, %t140
  %t142 = zext i1 %t141 to i64
  %t143 = icmp ne i64 %t142, 0
  br i1 %t143, label %L25, label %L27
L25:
  %t144 = call i8 @advance(ptr %t0)
  %t145 = sext i8 %t144 to i64
  br label %L27
L27:
  br label %L28
L28:
  %t146 = call i8 @cur(ptr %t0)
  %t147 = sext i8 %t146 to i64
  %t148 = add i64 %t147, 0
  %t149 = call i32 @isdigit(i64 %t148)
  %t150 = sext i32 %t149 to i64
  %t151 = icmp ne i64 %t150, 0
  br i1 %t151, label %L29, label %L30
L29:
  %t152 = call i8 @advance(ptr %t0)
  %t153 = sext i8 %t152 to i64
  br label %L28
L30:
  br label %L24
L24:
  br label %L9
L9:
  br label %L31
L31:
  %t154 = call i8 @cur(ptr %t0)
  %t155 = sext i8 %t154 to i64
  %t157 = sext i32 117 to i64
  %t156 = icmp eq i64 %t155, %t157
  %t158 = zext i1 %t156 to i64
  %t159 = call i8 @cur(ptr %t0)
  %t160 = sext i8 %t159 to i64
  %t162 = sext i32 85 to i64
  %t161 = icmp eq i64 %t160, %t162
  %t163 = zext i1 %t161 to i64
  %t165 = icmp ne i64 %t158, 0
  %t166 = icmp ne i64 %t163, 0
  %t167 = or i1 %t165, %t166
  %t168 = zext i1 %t167 to i64
  %t169 = call i8 @cur(ptr %t0)
  %t170 = sext i8 %t169 to i64
  %t172 = sext i32 108 to i64
  %t171 = icmp eq i64 %t170, %t172
  %t173 = zext i1 %t171 to i64
  %t175 = icmp ne i64 %t168, 0
  %t176 = icmp ne i64 %t173, 0
  %t177 = or i1 %t175, %t176
  %t178 = zext i1 %t177 to i64
  %t179 = call i8 @cur(ptr %t0)
  %t180 = sext i8 %t179 to i64
  %t182 = sext i32 76 to i64
  %t181 = icmp eq i64 %t180, %t182
  %t183 = zext i1 %t181 to i64
  %t185 = icmp ne i64 %t178, 0
  %t186 = icmp ne i64 %t183, 0
  %t187 = or i1 %t185, %t186
  %t188 = zext i1 %t187 to i64
  %t189 = call i8 @cur(ptr %t0)
  %t190 = sext i8 %t189 to i64
  %t192 = sext i32 102 to i64
  %t191 = icmp eq i64 %t190, %t192
  %t193 = zext i1 %t191 to i64
  %t195 = icmp ne i64 %t188, 0
  %t196 = icmp ne i64 %t193, 0
  %t197 = or i1 %t195, %t196
  %t198 = zext i1 %t197 to i64
  %t199 = call i8 @cur(ptr %t0)
  %t200 = sext i8 %t199 to i64
  %t202 = sext i32 70 to i64
  %t201 = icmp eq i64 %t200, %t202
  %t203 = zext i1 %t201 to i64
  %t205 = icmp ne i64 %t198, 0
  %t206 = icmp ne i64 %t203, 0
  %t207 = or i1 %t205, %t206
  %t208 = zext i1 %t207 to i64
  %t209 = icmp ne i64 %t208, 0
  br i1 %t209, label %L32, label %L33
L32:
  %t210 = call i8 @advance(ptr %t0)
  %t211 = sext i8 %t210 to i64
  br label %L31
L33:
  %t212 = load i64, ptr %t44
  %t213 = icmp ne i64 %t212, 0
  br i1 %t213, label %L34, label %L35
L34:
  %t214 = sext i32 1 to i64
  br label %L36
L35:
  %t215 = sext i32 0 to i64
  br label %L36
L36:
  %t216 = phi i64 [ %t214, %L34 ], [ %t215, %L35 ]
  store i64 %t216, ptr %t2
  %t217 = load ptr, ptr %t0
  %t218 = load i64, ptr %t42
  %t220 = ptrtoint ptr %t217 to i64
  %t221 = inttoptr i64 %t220 to ptr
  %t219 = getelementptr i8, ptr %t221, i64 %t218
  %t222 = load ptr, ptr %t0
  %t223 = load i64, ptr %t42
  %t225 = ptrtoint ptr %t222 to i64
  %t224 = sub i64 %t225, %t223
  %t226 = call ptr @strndup_local(ptr %t219, i64 %t224)
  store ptr %t226, ptr %t2
  %t227 = load i64, ptr %t2
  ret i64 %t227
L37:
  br label %L6
L6:
  %t228 = call i8 @cur(ptr %t0)
  %t229 = sext i8 %t228 to i64
  %t231 = sext i32 39 to i64
  %t230 = icmp eq i64 %t229, %t231
  %t232 = zext i1 %t230 to i64
  %t233 = icmp ne i64 %t232, 0
  br i1 %t233, label %L38, label %L40
L38:
  %t234 = alloca i64
  %t235 = load ptr, ptr %t0
  store ptr %t235, ptr %t234
  %t236 = call i8 @advance(ptr %t0)
  %t237 = sext i8 %t236 to i64
  %t238 = call i8 @cur(ptr %t0)
  %t239 = sext i8 %t238 to i64
  %t241 = sext i32 92 to i64
  %t240 = icmp eq i64 %t239, %t241
  %t242 = zext i1 %t240 to i64
  %t243 = icmp ne i64 %t242, 0
  br i1 %t243, label %L41, label %L42
L41:
  %t244 = call i8 @advance(ptr %t0)
  %t245 = sext i8 %t244 to i64
  %t246 = call i8 @advance(ptr %t0)
  %t247 = sext i8 %t246 to i64
  br label %L43
L42:
  %t248 = call i8 @advance(ptr %t0)
  %t249 = sext i8 %t248 to i64
  br label %L43
L43:
  %t250 = call i8 @cur(ptr %t0)
  %t251 = sext i8 %t250 to i64
  %t253 = sext i32 39 to i64
  %t252 = icmp eq i64 %t251, %t253
  %t254 = zext i1 %t252 to i64
  %t255 = icmp ne i64 %t254, 0
  br i1 %t255, label %L44, label %L46
L44:
  %t256 = call i8 @advance(ptr %t0)
  %t257 = sext i8 %t256 to i64
  br label %L46
L46:
  %t258 = sext i32 2 to i64
  store i64 %t258, ptr %t2
  %t259 = load ptr, ptr %t0
  %t260 = load i64, ptr %t234
  %t262 = ptrtoint ptr %t259 to i64
  %t263 = inttoptr i64 %t262 to ptr
  %t261 = getelementptr i8, ptr %t263, i64 %t260
  %t264 = load ptr, ptr %t0
  %t265 = load i64, ptr %t234
  %t267 = ptrtoint ptr %t264 to i64
  %t266 = sub i64 %t267, %t265
  %t268 = call ptr @strndup_local(ptr %t261, i64 %t266)
  store ptr %t268, ptr %t2
  %t269 = load i64, ptr %t2
  ret i64 %t269
L47:
  br label %L40
L40:
  %t270 = call i8 @cur(ptr %t0)
  %t271 = sext i8 %t270 to i64
  %t273 = sext i32 34 to i64
  %t272 = icmp eq i64 %t271, %t273
  %t274 = zext i1 %t272 to i64
  %t275 = icmp ne i64 %t274, 0
  br i1 %t275, label %L48, label %L50
L48:
  %t276 = alloca i64
  %t277 = load ptr, ptr %t0
  store ptr %t277, ptr %t276
  %t278 = call i8 @advance(ptr %t0)
  %t279 = sext i8 %t278 to i64
  br label %L51
L51:
  %t280 = call i8 @cur(ptr %t0)
  %t281 = sext i8 %t280 to i64
  %t282 = call i8 @cur(ptr %t0)
  %t283 = sext i8 %t282 to i64
  %t285 = sext i32 34 to i64
  %t284 = icmp ne i64 %t283, %t285
  %t286 = zext i1 %t284 to i64
  %t288 = icmp ne i64 %t281, 0
  %t289 = icmp ne i64 %t286, 0
  %t290 = and i1 %t288, %t289
  %t291 = zext i1 %t290 to i64
  %t292 = icmp ne i64 %t291, 0
  br i1 %t292, label %L52, label %L53
L52:
  %t293 = call i8 @cur(ptr %t0)
  %t294 = sext i8 %t293 to i64
  %t296 = sext i32 92 to i64
  %t295 = icmp eq i64 %t294, %t296
  %t297 = zext i1 %t295 to i64
  %t298 = icmp ne i64 %t297, 0
  br i1 %t298, label %L54, label %L56
L54:
  %t299 = call i8 @advance(ptr %t0)
  %t300 = sext i8 %t299 to i64
  br label %L56
L56:
  %t301 = call i8 @cur(ptr %t0)
  %t302 = sext i8 %t301 to i64
  %t303 = icmp ne i64 %t302, 0
  br i1 %t303, label %L57, label %L59
L57:
  %t304 = call i8 @advance(ptr %t0)
  %t305 = sext i8 %t304 to i64
  br label %L59
L59:
  br label %L51
L53:
  %t306 = call i8 @cur(ptr %t0)
  %t307 = sext i8 %t306 to i64
  %t309 = sext i32 34 to i64
  %t308 = icmp eq i64 %t307, %t309
  %t310 = zext i1 %t308 to i64
  %t311 = icmp ne i64 %t310, 0
  br i1 %t311, label %L60, label %L62
L60:
  %t312 = call i8 @advance(ptr %t0)
  %t313 = sext i8 %t312 to i64
  br label %L62
L62:
  %t314 = sext i32 3 to i64
  store i64 %t314, ptr %t2
  %t315 = load ptr, ptr %t0
  %t316 = load i64, ptr %t276
  %t318 = ptrtoint ptr %t315 to i64
  %t319 = inttoptr i64 %t318 to ptr
  %t317 = getelementptr i8, ptr %t319, i64 %t316
  %t320 = load ptr, ptr %t0
  %t321 = load i64, ptr %t276
  %t323 = ptrtoint ptr %t320 to i64
  %t322 = sub i64 %t323, %t321
  %t324 = call ptr @strndup_local(ptr %t317, i64 %t322)
  store ptr %t324, ptr %t2
  %t325 = load i64, ptr %t2
  ret i64 %t325
L63:
  br label %L50
L50:
  %t326 = call i8 @cur(ptr %t0)
  %t327 = sext i8 %t326 to i64
  %t328 = add i64 %t327, 0
  %t329 = call i32 @isalpha(i64 %t328)
  %t330 = sext i32 %t329 to i64
  %t331 = call i8 @cur(ptr %t0)
  %t332 = sext i8 %t331 to i64
  %t334 = sext i32 95 to i64
  %t333 = icmp eq i64 %t332, %t334
  %t335 = zext i1 %t333 to i64
  %t337 = icmp ne i64 %t330, 0
  %t338 = icmp ne i64 %t335, 0
  %t339 = or i1 %t337, %t338
  %t340 = zext i1 %t339 to i64
  %t341 = icmp ne i64 %t340, 0
  br i1 %t341, label %L64, label %L66
L64:
  %t342 = alloca i64
  %t343 = load ptr, ptr %t0
  store ptr %t343, ptr %t342
  br label %L67
L67:
  %t344 = call i8 @cur(ptr %t0)
  %t345 = sext i8 %t344 to i64
  %t346 = add i64 %t345, 0
  %t347 = call i32 @isalnum(i64 %t346)
  %t348 = sext i32 %t347 to i64
  %t349 = call i8 @cur(ptr %t0)
  %t350 = sext i8 %t349 to i64
  %t352 = sext i32 95 to i64
  %t351 = icmp eq i64 %t350, %t352
  %t353 = zext i1 %t351 to i64
  %t355 = icmp ne i64 %t348, 0
  %t356 = icmp ne i64 %t353, 0
  %t357 = or i1 %t355, %t356
  %t358 = zext i1 %t357 to i64
  %t359 = icmp ne i64 %t358, 0
  br i1 %t359, label %L68, label %L69
L68:
  %t360 = call i8 @advance(ptr %t0)
  %t361 = sext i8 %t360 to i64
  br label %L67
L69:
  %t362 = load ptr, ptr %t0
  %t363 = load i64, ptr %t342
  %t365 = ptrtoint ptr %t362 to i64
  %t366 = inttoptr i64 %t365 to ptr
  %t364 = getelementptr i8, ptr %t366, i64 %t363
  %t367 = load ptr, ptr %t0
  %t368 = load i64, ptr %t342
  %t370 = ptrtoint ptr %t367 to i64
  %t369 = sub i64 %t370, %t368
  %t371 = call ptr @strndup_local(ptr %t364, i64 %t369)
  store ptr %t371, ptr %t2
  %t372 = load ptr, ptr %t2
  %t373 = call i64 @keyword_lookup(ptr %t372)
  store i64 %t373, ptr %t2
  %t374 = load i64, ptr %t2
  ret i64 %t374
L70:
  br label %L66
L66:
  %t375 = alloca i64
  %t376 = call i8 @advance(ptr %t0)
  %t377 = sext i8 %t376 to i64
  store i64 %t377, ptr %t375
  %t378 = alloca i64
  %t379 = call i8 @cur(ptr %t0)
  %t380 = sext i8 %t379 to i64
  store i64 %t380, ptr %t378
  %t381 = load i64, ptr %t375
  %t382 = add i64 %t381, 0
  switch i64 %t382, label %L96 [
    i64 43, label %L72
    i64 45, label %L73
    i64 42, label %L74
    i64 47, label %L75
    i64 37, label %L76
    i64 38, label %L77
    i64 124, label %L78
    i64 94, label %L79
    i64 126, label %L80
    i64 60, label %L81
    i64 62, label %L82
    i64 61, label %L83
    i64 33, label %L84
    i64 46, label %L85
    i64 40, label %L86
    i64 41, label %L87
    i64 123, label %L88
    i64 125, label %L89
    i64 91, label %L90
    i64 93, label %L91
    i64 59, label %L92
    i64 44, label %L93
    i64 63, label %L94
    i64 58, label %L95
  ]
L72:
  %t383 = load i64, ptr %t378
  %t385 = sext i32 43 to i64
  %t384 = icmp eq i64 %t383, %t385
  %t386 = zext i1 %t384 to i64
  %t387 = icmp ne i64 %t386, 0
  br i1 %t387, label %L97, label %L99
L97:
  br label %L100
L100:
  %t388 = call i8 @advance(ptr %t0)
  %t389 = sext i8 %t388 to i64
  br label %L103
L103:
  %t390 = sext i32 66 to i64
  store i64 %t390, ptr %t2
  %t391 = getelementptr [3 x i8], ptr @.str3, i64 0, i64 0
  %t392 = call ptr @strdup(ptr %t391)
  store ptr %t392, ptr %t2
  %t393 = load i64, ptr %t2
  ret i64 %t393
L106:
  br label %L104
L104:
  %t395 = sext i32 0 to i64
  %t394 = icmp ne i64 %t395, 0
  br i1 %t394, label %L103, label %L105
L105:
  br label %L101
L101:
  %t397 = sext i32 0 to i64
  %t396 = icmp ne i64 %t397, 0
  br i1 %t396, label %L100, label %L102
L102:
  br label %L99
L99:
  %t398 = load i64, ptr %t378
  %t400 = sext i32 61 to i64
  %t399 = icmp eq i64 %t398, %t400
  %t401 = zext i1 %t399 to i64
  %t402 = icmp ne i64 %t401, 0
  br i1 %t402, label %L107, label %L109
L107:
  br label %L110
L110:
  %t403 = call i8 @advance(ptr %t0)
  %t404 = sext i8 %t403 to i64
  br label %L113
L113:
  %t405 = sext i32 56 to i64
  store i64 %t405, ptr %t2
  %t406 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %t407 = call ptr @strdup(ptr %t406)
  store ptr %t407, ptr %t2
  %t408 = load i64, ptr %t2
  ret i64 %t408
L116:
  br label %L114
L114:
  %t410 = sext i32 0 to i64
  %t409 = icmp ne i64 %t410, 0
  br i1 %t409, label %L113, label %L115
L115:
  br label %L111
L111:
  %t412 = sext i32 0 to i64
  %t411 = icmp ne i64 %t412, 0
  br i1 %t411, label %L110, label %L112
L112:
  br label %L109
L109:
  br label %L117
L117:
  %t413 = sext i32 35 to i64
  store i64 %t413, ptr %t2
  %t414 = getelementptr [2 x i8], ptr @.str5, i64 0, i64 0
  %t415 = call ptr @strdup(ptr %t414)
  store ptr %t415, ptr %t2
  %t416 = load i64, ptr %t2
  ret i64 %t416
L120:
  br label %L118
L118:
  %t418 = sext i32 0 to i64
  %t417 = icmp ne i64 %t418, 0
  br i1 %t417, label %L117, label %L119
L119:
  br label %L73
L73:
  %t419 = load i64, ptr %t378
  %t421 = sext i32 45 to i64
  %t420 = icmp eq i64 %t419, %t421
  %t422 = zext i1 %t420 to i64
  %t423 = icmp ne i64 %t422, 0
  br i1 %t423, label %L121, label %L123
L121:
  br label %L124
L124:
  %t424 = call i8 @advance(ptr %t0)
  %t425 = sext i8 %t424 to i64
  br label %L127
L127:
  %t426 = sext i32 67 to i64
  store i64 %t426, ptr %t2
  %t427 = getelementptr [3 x i8], ptr @.str6, i64 0, i64 0
  %t428 = call ptr @strdup(ptr %t427)
  store ptr %t428, ptr %t2
  %t429 = load i64, ptr %t2
  ret i64 %t429
L130:
  br label %L128
L128:
  %t431 = sext i32 0 to i64
  %t430 = icmp ne i64 %t431, 0
  br i1 %t430, label %L127, label %L129
L129:
  br label %L125
L125:
  %t433 = sext i32 0 to i64
  %t432 = icmp ne i64 %t433, 0
  br i1 %t432, label %L124, label %L126
L126:
  br label %L123
L123:
  %t434 = load i64, ptr %t378
  %t436 = sext i32 61 to i64
  %t435 = icmp eq i64 %t434, %t436
  %t437 = zext i1 %t435 to i64
  %t438 = icmp ne i64 %t437, 0
  br i1 %t438, label %L131, label %L133
L131:
  br label %L134
L134:
  %t439 = call i8 @advance(ptr %t0)
  %t440 = sext i8 %t439 to i64
  br label %L137
L137:
  %t441 = sext i32 57 to i64
  store i64 %t441, ptr %t2
  %t442 = getelementptr [3 x i8], ptr @.str7, i64 0, i64 0
  %t443 = call ptr @strdup(ptr %t442)
  store ptr %t443, ptr %t2
  %t444 = load i64, ptr %t2
  ret i64 %t444
L140:
  br label %L138
L138:
  %t446 = sext i32 0 to i64
  %t445 = icmp ne i64 %t446, 0
  br i1 %t445, label %L137, label %L139
L139:
  br label %L135
L135:
  %t448 = sext i32 0 to i64
  %t447 = icmp ne i64 %t448, 0
  br i1 %t447, label %L134, label %L136
L136:
  br label %L133
L133:
  %t449 = load i64, ptr %t378
  %t451 = sext i32 62 to i64
  %t450 = icmp eq i64 %t449, %t451
  %t452 = zext i1 %t450 to i64
  %t453 = icmp ne i64 %t452, 0
  br i1 %t453, label %L141, label %L143
L141:
  br label %L144
L144:
  %t454 = call i8 @advance(ptr %t0)
  %t455 = sext i8 %t454 to i64
  br label %L147
L147:
  %t456 = sext i32 68 to i64
  store i64 %t456, ptr %t2
  %t457 = getelementptr [3 x i8], ptr @.str8, i64 0, i64 0
  %t458 = call ptr @strdup(ptr %t457)
  store ptr %t458, ptr %t2
  %t459 = load i64, ptr %t2
  ret i64 %t459
L150:
  br label %L148
L148:
  %t461 = sext i32 0 to i64
  %t460 = icmp ne i64 %t461, 0
  br i1 %t460, label %L147, label %L149
L149:
  br label %L145
L145:
  %t463 = sext i32 0 to i64
  %t462 = icmp ne i64 %t463, 0
  br i1 %t462, label %L144, label %L146
L146:
  br label %L143
L143:
  br label %L151
L151:
  %t464 = sext i32 36 to i64
  store i64 %t464, ptr %t2
  %t465 = getelementptr [2 x i8], ptr @.str9, i64 0, i64 0
  %t466 = call ptr @strdup(ptr %t465)
  store ptr %t466, ptr %t2
  %t467 = load i64, ptr %t2
  ret i64 %t467
L154:
  br label %L152
L152:
  %t469 = sext i32 0 to i64
  %t468 = icmp ne i64 %t469, 0
  br i1 %t468, label %L151, label %L153
L153:
  br label %L74
L74:
  %t470 = load i64, ptr %t378
  %t472 = sext i32 61 to i64
  %t471 = icmp eq i64 %t470, %t472
  %t473 = zext i1 %t471 to i64
  %t474 = icmp ne i64 %t473, 0
  br i1 %t474, label %L155, label %L157
L155:
  br label %L158
L158:
  %t475 = call i8 @advance(ptr %t0)
  %t476 = sext i8 %t475 to i64
  br label %L161
L161:
  %t477 = sext i32 58 to i64
  store i64 %t477, ptr %t2
  %t478 = getelementptr [3 x i8], ptr @.str10, i64 0, i64 0
  %t479 = call ptr @strdup(ptr %t478)
  store ptr %t479, ptr %t2
  %t480 = load i64, ptr %t2
  ret i64 %t480
L164:
  br label %L162
L162:
  %t482 = sext i32 0 to i64
  %t481 = icmp ne i64 %t482, 0
  br i1 %t481, label %L161, label %L163
L163:
  br label %L159
L159:
  %t484 = sext i32 0 to i64
  %t483 = icmp ne i64 %t484, 0
  br i1 %t483, label %L158, label %L160
L160:
  br label %L157
L157:
  br label %L165
L165:
  %t485 = sext i32 37 to i64
  store i64 %t485, ptr %t2
  %t486 = getelementptr [2 x i8], ptr @.str11, i64 0, i64 0
  %t487 = call ptr @strdup(ptr %t486)
  store ptr %t487, ptr %t2
  %t488 = load i64, ptr %t2
  ret i64 %t488
L168:
  br label %L166
L166:
  %t490 = sext i32 0 to i64
  %t489 = icmp ne i64 %t490, 0
  br i1 %t489, label %L165, label %L167
L167:
  br label %L75
L75:
  %t491 = load i64, ptr %t378
  %t493 = sext i32 61 to i64
  %t492 = icmp eq i64 %t491, %t493
  %t494 = zext i1 %t492 to i64
  %t495 = icmp ne i64 %t494, 0
  br i1 %t495, label %L169, label %L171
L169:
  br label %L172
L172:
  %t496 = call i8 @advance(ptr %t0)
  %t497 = sext i8 %t496 to i64
  br label %L175
L175:
  %t498 = sext i32 59 to i64
  store i64 %t498, ptr %t2
  %t499 = getelementptr [3 x i8], ptr @.str12, i64 0, i64 0
  %t500 = call ptr @strdup(ptr %t499)
  store ptr %t500, ptr %t2
  %t501 = load i64, ptr %t2
  ret i64 %t501
L178:
  br label %L176
L176:
  %t503 = sext i32 0 to i64
  %t502 = icmp ne i64 %t503, 0
  br i1 %t502, label %L175, label %L177
L177:
  br label %L173
L173:
  %t505 = sext i32 0 to i64
  %t504 = icmp ne i64 %t505, 0
  br i1 %t504, label %L172, label %L174
L174:
  br label %L171
L171:
  br label %L179
L179:
  %t506 = sext i32 38 to i64
  store i64 %t506, ptr %t2
  %t507 = getelementptr [2 x i8], ptr @.str13, i64 0, i64 0
  %t508 = call ptr @strdup(ptr %t507)
  store ptr %t508, ptr %t2
  %t509 = load i64, ptr %t2
  ret i64 %t509
L182:
  br label %L180
L180:
  %t511 = sext i32 0 to i64
  %t510 = icmp ne i64 %t511, 0
  br i1 %t510, label %L179, label %L181
L181:
  br label %L76
L76:
  %t512 = load i64, ptr %t378
  %t514 = sext i32 61 to i64
  %t513 = icmp eq i64 %t512, %t514
  %t515 = zext i1 %t513 to i64
  %t516 = icmp ne i64 %t515, 0
  br i1 %t516, label %L183, label %L185
L183:
  br label %L186
L186:
  %t517 = call i8 @advance(ptr %t0)
  %t518 = sext i8 %t517 to i64
  br label %L189
L189:
  %t519 = sext i32 65 to i64
  store i64 %t519, ptr %t2
  %t520 = getelementptr [3 x i8], ptr @.str14, i64 0, i64 0
  %t521 = call ptr @strdup(ptr %t520)
  store ptr %t521, ptr %t2
  %t522 = load i64, ptr %t2
  ret i64 %t522
L192:
  br label %L190
L190:
  %t524 = sext i32 0 to i64
  %t523 = icmp ne i64 %t524, 0
  br i1 %t523, label %L189, label %L191
L191:
  br label %L187
L187:
  %t526 = sext i32 0 to i64
  %t525 = icmp ne i64 %t526, 0
  br i1 %t525, label %L186, label %L188
L188:
  br label %L185
L185:
  br label %L193
L193:
  %t527 = sext i32 39 to i64
  store i64 %t527, ptr %t2
  %t528 = getelementptr [2 x i8], ptr @.str15, i64 0, i64 0
  %t529 = call ptr @strdup(ptr %t528)
  store ptr %t529, ptr %t2
  %t530 = load i64, ptr %t2
  ret i64 %t530
L196:
  br label %L194
L194:
  %t532 = sext i32 0 to i64
  %t531 = icmp ne i64 %t532, 0
  br i1 %t531, label %L193, label %L195
L195:
  br label %L77
L77:
  %t533 = load i64, ptr %t378
  %t535 = sext i32 38 to i64
  %t534 = icmp eq i64 %t533, %t535
  %t536 = zext i1 %t534 to i64
  %t537 = icmp ne i64 %t536, 0
  br i1 %t537, label %L197, label %L199
L197:
  br label %L200
L200:
  %t538 = call i8 @advance(ptr %t0)
  %t539 = sext i8 %t538 to i64
  br label %L203
L203:
  %t540 = sext i32 52 to i64
  store i64 %t540, ptr %t2
  %t541 = getelementptr [3 x i8], ptr @.str16, i64 0, i64 0
  %t542 = call ptr @strdup(ptr %t541)
  store ptr %t542, ptr %t2
  %t543 = load i64, ptr %t2
  ret i64 %t543
L206:
  br label %L204
L204:
  %t545 = sext i32 0 to i64
  %t544 = icmp ne i64 %t545, 0
  br i1 %t544, label %L203, label %L205
L205:
  br label %L201
L201:
  %t547 = sext i32 0 to i64
  %t546 = icmp ne i64 %t547, 0
  br i1 %t546, label %L200, label %L202
L202:
  br label %L199
L199:
  %t548 = load i64, ptr %t378
  %t550 = sext i32 61 to i64
  %t549 = icmp eq i64 %t548, %t550
  %t551 = zext i1 %t549 to i64
  %t552 = icmp ne i64 %t551, 0
  br i1 %t552, label %L207, label %L209
L207:
  br label %L210
L210:
  %t553 = call i8 @advance(ptr %t0)
  %t554 = sext i8 %t553 to i64
  br label %L213
L213:
  %t555 = sext i32 60 to i64
  store i64 %t555, ptr %t2
  %t556 = getelementptr [3 x i8], ptr @.str17, i64 0, i64 0
  %t557 = call ptr @strdup(ptr %t556)
  store ptr %t557, ptr %t2
  %t558 = load i64, ptr %t2
  ret i64 %t558
L216:
  br label %L214
L214:
  %t560 = sext i32 0 to i64
  %t559 = icmp ne i64 %t560, 0
  br i1 %t559, label %L213, label %L215
L215:
  br label %L211
L211:
  %t562 = sext i32 0 to i64
  %t561 = icmp ne i64 %t562, 0
  br i1 %t561, label %L210, label %L212
L212:
  br label %L209
L209:
  br label %L217
L217:
  %t563 = sext i32 40 to i64
  store i64 %t563, ptr %t2
  %t564 = getelementptr [2 x i8], ptr @.str18, i64 0, i64 0
  %t565 = call ptr @strdup(ptr %t564)
  store ptr %t565, ptr %t2
  %t566 = load i64, ptr %t2
  ret i64 %t566
L220:
  br label %L218
L218:
  %t568 = sext i32 0 to i64
  %t567 = icmp ne i64 %t568, 0
  br i1 %t567, label %L217, label %L219
L219:
  br label %L78
L78:
  %t569 = load i64, ptr %t378
  %t571 = sext i32 124 to i64
  %t570 = icmp eq i64 %t569, %t571
  %t572 = zext i1 %t570 to i64
  %t573 = icmp ne i64 %t572, 0
  br i1 %t573, label %L221, label %L223
L221:
  br label %L224
L224:
  %t574 = call i8 @advance(ptr %t0)
  %t575 = sext i8 %t574 to i64
  br label %L227
L227:
  %t576 = sext i32 53 to i64
  store i64 %t576, ptr %t2
  %t577 = getelementptr [3 x i8], ptr @.str19, i64 0, i64 0
  %t578 = call ptr @strdup(ptr %t577)
  store ptr %t578, ptr %t2
  %t579 = load i64, ptr %t2
  ret i64 %t579
L230:
  br label %L228
L228:
  %t581 = sext i32 0 to i64
  %t580 = icmp ne i64 %t581, 0
  br i1 %t580, label %L227, label %L229
L229:
  br label %L225
L225:
  %t583 = sext i32 0 to i64
  %t582 = icmp ne i64 %t583, 0
  br i1 %t582, label %L224, label %L226
L226:
  br label %L223
L223:
  %t584 = load i64, ptr %t378
  %t586 = sext i32 61 to i64
  %t585 = icmp eq i64 %t584, %t586
  %t587 = zext i1 %t585 to i64
  %t588 = icmp ne i64 %t587, 0
  br i1 %t588, label %L231, label %L233
L231:
  br label %L234
L234:
  %t589 = call i8 @advance(ptr %t0)
  %t590 = sext i8 %t589 to i64
  br label %L237
L237:
  %t591 = sext i32 61 to i64
  store i64 %t591, ptr %t2
  %t592 = getelementptr [3 x i8], ptr @.str20, i64 0, i64 0
  %t593 = call ptr @strdup(ptr %t592)
  store ptr %t593, ptr %t2
  %t594 = load i64, ptr %t2
  ret i64 %t594
L240:
  br label %L238
L238:
  %t596 = sext i32 0 to i64
  %t595 = icmp ne i64 %t596, 0
  br i1 %t595, label %L237, label %L239
L239:
  br label %L235
L235:
  %t598 = sext i32 0 to i64
  %t597 = icmp ne i64 %t598, 0
  br i1 %t597, label %L234, label %L236
L236:
  br label %L233
L233:
  br label %L241
L241:
  %t599 = sext i32 41 to i64
  store i64 %t599, ptr %t2
  %t600 = getelementptr [2 x i8], ptr @.str21, i64 0, i64 0
  %t601 = call ptr @strdup(ptr %t600)
  store ptr %t601, ptr %t2
  %t602 = load i64, ptr %t2
  ret i64 %t602
L244:
  br label %L242
L242:
  %t604 = sext i32 0 to i64
  %t603 = icmp ne i64 %t604, 0
  br i1 %t603, label %L241, label %L243
L243:
  br label %L79
L79:
  %t605 = load i64, ptr %t378
  %t607 = sext i32 61 to i64
  %t606 = icmp eq i64 %t605, %t607
  %t608 = zext i1 %t606 to i64
  %t609 = icmp ne i64 %t608, 0
  br i1 %t609, label %L245, label %L247
L245:
  br label %L248
L248:
  %t610 = call i8 @advance(ptr %t0)
  %t611 = sext i8 %t610 to i64
  br label %L251
L251:
  %t612 = sext i32 62 to i64
  store i64 %t612, ptr %t2
  %t613 = getelementptr [3 x i8], ptr @.str22, i64 0, i64 0
  %t614 = call ptr @strdup(ptr %t613)
  store ptr %t614, ptr %t2
  %t615 = load i64, ptr %t2
  ret i64 %t615
L254:
  br label %L252
L252:
  %t617 = sext i32 0 to i64
  %t616 = icmp ne i64 %t617, 0
  br i1 %t616, label %L251, label %L253
L253:
  br label %L249
L249:
  %t619 = sext i32 0 to i64
  %t618 = icmp ne i64 %t619, 0
  br i1 %t618, label %L248, label %L250
L250:
  br label %L247
L247:
  br label %L255
L255:
  %t620 = sext i32 42 to i64
  store i64 %t620, ptr %t2
  %t621 = getelementptr [2 x i8], ptr @.str23, i64 0, i64 0
  %t622 = call ptr @strdup(ptr %t621)
  store ptr %t622, ptr %t2
  %t623 = load i64, ptr %t2
  ret i64 %t623
L258:
  br label %L256
L256:
  %t625 = sext i32 0 to i64
  %t624 = icmp ne i64 %t625, 0
  br i1 %t624, label %L255, label %L257
L257:
  br label %L80
L80:
  br label %L259
L259:
  %t626 = sext i32 43 to i64
  store i64 %t626, ptr %t2
  %t627 = getelementptr [2 x i8], ptr @.str24, i64 0, i64 0
  %t628 = call ptr @strdup(ptr %t627)
  store ptr %t628, ptr %t2
  %t629 = load i64, ptr %t2
  ret i64 %t629
L262:
  br label %L260
L260:
  %t631 = sext i32 0 to i64
  %t630 = icmp ne i64 %t631, 0
  br i1 %t630, label %L259, label %L261
L261:
  br label %L81
L81:
  %t632 = load i64, ptr %t378
  %t634 = sext i32 60 to i64
  %t633 = icmp eq i64 %t632, %t634
  %t635 = zext i1 %t633 to i64
  %t636 = icmp ne i64 %t635, 0
  br i1 %t636, label %L263, label %L265
L263:
  %t637 = call i8 @advance(ptr %t0)
  %t638 = sext i8 %t637 to i64
  %t639 = call i8 @cur(ptr %t0)
  %t640 = sext i8 %t639 to i64
  %t642 = sext i32 61 to i64
  %t641 = icmp eq i64 %t640, %t642
  %t643 = zext i1 %t641 to i64
  %t644 = icmp ne i64 %t643, 0
  br i1 %t644, label %L266, label %L268
L266:
  br label %L269
L269:
  %t645 = call i8 @advance(ptr %t0)
  %t646 = sext i8 %t645 to i64
  br label %L272
L272:
  %t647 = sext i32 63 to i64
  store i64 %t647, ptr %t2
  %t648 = getelementptr [4 x i8], ptr @.str25, i64 0, i64 0
  %t649 = call ptr @strdup(ptr %t648)
  store ptr %t649, ptr %t2
  %t650 = load i64, ptr %t2
  ret i64 %t650
L275:
  br label %L273
L273:
  %t652 = sext i32 0 to i64
  %t651 = icmp ne i64 %t652, 0
  br i1 %t651, label %L272, label %L274
L274:
  br label %L270
L270:
  %t654 = sext i32 0 to i64
  %t653 = icmp ne i64 %t654, 0
  br i1 %t653, label %L269, label %L271
L271:
  br label %L268
L268:
  br label %L276
L276:
  %t655 = sext i32 44 to i64
  store i64 %t655, ptr %t2
  %t656 = getelementptr [3 x i8], ptr @.str26, i64 0, i64 0
  %t657 = call ptr @strdup(ptr %t656)
  store ptr %t657, ptr %t2
  %t658 = load i64, ptr %t2
  ret i64 %t658
L279:
  br label %L277
L277:
  %t660 = sext i32 0 to i64
  %t659 = icmp ne i64 %t660, 0
  br i1 %t659, label %L276, label %L278
L278:
  br label %L265
L265:
  %t661 = load i64, ptr %t378
  %t663 = sext i32 61 to i64
  %t662 = icmp eq i64 %t661, %t663
  %t664 = zext i1 %t662 to i64
  %t665 = icmp ne i64 %t664, 0
  br i1 %t665, label %L280, label %L282
L280:
  br label %L283
L283:
  %t666 = call i8 @advance(ptr %t0)
  %t667 = sext i8 %t666 to i64
  br label %L286
L286:
  %t668 = sext i32 50 to i64
  store i64 %t668, ptr %t2
  %t669 = getelementptr [3 x i8], ptr @.str27, i64 0, i64 0
  %t670 = call ptr @strdup(ptr %t669)
  store ptr %t670, ptr %t2
  %t671 = load i64, ptr %t2
  ret i64 %t671
L289:
  br label %L287
L287:
  %t673 = sext i32 0 to i64
  %t672 = icmp ne i64 %t673, 0
  br i1 %t672, label %L286, label %L288
L288:
  br label %L284
L284:
  %t675 = sext i32 0 to i64
  %t674 = icmp ne i64 %t675, 0
  br i1 %t674, label %L283, label %L285
L285:
  br label %L282
L282:
  br label %L290
L290:
  %t676 = sext i32 48 to i64
  store i64 %t676, ptr %t2
  %t677 = getelementptr [2 x i8], ptr @.str28, i64 0, i64 0
  %t678 = call ptr @strdup(ptr %t677)
  store ptr %t678, ptr %t2
  %t679 = load i64, ptr %t2
  ret i64 %t679
L293:
  br label %L291
L291:
  %t681 = sext i32 0 to i64
  %t680 = icmp ne i64 %t681, 0
  br i1 %t680, label %L290, label %L292
L292:
  br label %L82
L82:
  %t682 = load i64, ptr %t378
  %t684 = sext i32 62 to i64
  %t683 = icmp eq i64 %t682, %t684
  %t685 = zext i1 %t683 to i64
  %t686 = icmp ne i64 %t685, 0
  br i1 %t686, label %L294, label %L296
L294:
  %t687 = call i8 @advance(ptr %t0)
  %t688 = sext i8 %t687 to i64
  %t689 = call i8 @cur(ptr %t0)
  %t690 = sext i8 %t689 to i64
  %t692 = sext i32 61 to i64
  %t691 = icmp eq i64 %t690, %t692
  %t693 = zext i1 %t691 to i64
  %t694 = icmp ne i64 %t693, 0
  br i1 %t694, label %L297, label %L299
L297:
  br label %L300
L300:
  %t695 = call i8 @advance(ptr %t0)
  %t696 = sext i8 %t695 to i64
  br label %L303
L303:
  %t697 = sext i32 64 to i64
  store i64 %t697, ptr %t2
  %t698 = getelementptr [4 x i8], ptr @.str29, i64 0, i64 0
  %t699 = call ptr @strdup(ptr %t698)
  store ptr %t699, ptr %t2
  %t700 = load i64, ptr %t2
  ret i64 %t700
L306:
  br label %L304
L304:
  %t702 = sext i32 0 to i64
  %t701 = icmp ne i64 %t702, 0
  br i1 %t701, label %L303, label %L305
L305:
  br label %L301
L301:
  %t704 = sext i32 0 to i64
  %t703 = icmp ne i64 %t704, 0
  br i1 %t703, label %L300, label %L302
L302:
  br label %L299
L299:
  br label %L307
L307:
  %t705 = sext i32 45 to i64
  store i64 %t705, ptr %t2
  %t706 = getelementptr [3 x i8], ptr @.str30, i64 0, i64 0
  %t707 = call ptr @strdup(ptr %t706)
  store ptr %t707, ptr %t2
  %t708 = load i64, ptr %t2
  ret i64 %t708
L310:
  br label %L308
L308:
  %t710 = sext i32 0 to i64
  %t709 = icmp ne i64 %t710, 0
  br i1 %t709, label %L307, label %L309
L309:
  br label %L296
L296:
  %t711 = load i64, ptr %t378
  %t713 = sext i32 61 to i64
  %t712 = icmp eq i64 %t711, %t713
  %t714 = zext i1 %t712 to i64
  %t715 = icmp ne i64 %t714, 0
  br i1 %t715, label %L311, label %L313
L311:
  br label %L314
L314:
  %t716 = call i8 @advance(ptr %t0)
  %t717 = sext i8 %t716 to i64
  br label %L317
L317:
  %t718 = sext i32 51 to i64
  store i64 %t718, ptr %t2
  %t719 = getelementptr [3 x i8], ptr @.str31, i64 0, i64 0
  %t720 = call ptr @strdup(ptr %t719)
  store ptr %t720, ptr %t2
  %t721 = load i64, ptr %t2
  ret i64 %t721
L320:
  br label %L318
L318:
  %t723 = sext i32 0 to i64
  %t722 = icmp ne i64 %t723, 0
  br i1 %t722, label %L317, label %L319
L319:
  br label %L315
L315:
  %t725 = sext i32 0 to i64
  %t724 = icmp ne i64 %t725, 0
  br i1 %t724, label %L314, label %L316
L316:
  br label %L313
L313:
  br label %L321
L321:
  %t726 = sext i32 49 to i64
  store i64 %t726, ptr %t2
  %t727 = getelementptr [2 x i8], ptr @.str32, i64 0, i64 0
  %t728 = call ptr @strdup(ptr %t727)
  store ptr %t728, ptr %t2
  %t729 = load i64, ptr %t2
  ret i64 %t729
L324:
  br label %L322
L322:
  %t731 = sext i32 0 to i64
  %t730 = icmp ne i64 %t731, 0
  br i1 %t730, label %L321, label %L323
L323:
  br label %L83
L83:
  %t732 = load i64, ptr %t378
  %t734 = sext i32 61 to i64
  %t733 = icmp eq i64 %t732, %t734
  %t735 = zext i1 %t733 to i64
  %t736 = icmp ne i64 %t735, 0
  br i1 %t736, label %L325, label %L327
L325:
  br label %L328
L328:
  %t737 = call i8 @advance(ptr %t0)
  %t738 = sext i8 %t737 to i64
  br label %L331
L331:
  %t739 = sext i32 46 to i64
  store i64 %t739, ptr %t2
  %t740 = getelementptr [3 x i8], ptr @.str33, i64 0, i64 0
  %t741 = call ptr @strdup(ptr %t740)
  store ptr %t741, ptr %t2
  %t742 = load i64, ptr %t2
  ret i64 %t742
L334:
  br label %L332
L332:
  %t744 = sext i32 0 to i64
  %t743 = icmp ne i64 %t744, 0
  br i1 %t743, label %L331, label %L333
L333:
  br label %L329
L329:
  %t746 = sext i32 0 to i64
  %t745 = icmp ne i64 %t746, 0
  br i1 %t745, label %L328, label %L330
L330:
  br label %L327
L327:
  br label %L335
L335:
  %t747 = sext i32 55 to i64
  store i64 %t747, ptr %t2
  %t748 = getelementptr [2 x i8], ptr @.str34, i64 0, i64 0
  %t749 = call ptr @strdup(ptr %t748)
  store ptr %t749, ptr %t2
  %t750 = load i64, ptr %t2
  ret i64 %t750
L338:
  br label %L336
L336:
  %t752 = sext i32 0 to i64
  %t751 = icmp ne i64 %t752, 0
  br i1 %t751, label %L335, label %L337
L337:
  br label %L84
L84:
  %t753 = load i64, ptr %t378
  %t755 = sext i32 61 to i64
  %t754 = icmp eq i64 %t753, %t755
  %t756 = zext i1 %t754 to i64
  %t757 = icmp ne i64 %t756, 0
  br i1 %t757, label %L339, label %L341
L339:
  br label %L342
L342:
  %t758 = call i8 @advance(ptr %t0)
  %t759 = sext i8 %t758 to i64
  br label %L345
L345:
  %t760 = sext i32 47 to i64
  store i64 %t760, ptr %t2
  %t761 = getelementptr [3 x i8], ptr @.str35, i64 0, i64 0
  %t762 = call ptr @strdup(ptr %t761)
  store ptr %t762, ptr %t2
  %t763 = load i64, ptr %t2
  ret i64 %t763
L348:
  br label %L346
L346:
  %t765 = sext i32 0 to i64
  %t764 = icmp ne i64 %t765, 0
  br i1 %t764, label %L345, label %L347
L347:
  br label %L343
L343:
  %t767 = sext i32 0 to i64
  %t766 = icmp ne i64 %t767, 0
  br i1 %t766, label %L342, label %L344
L344:
  br label %L341
L341:
  br label %L349
L349:
  %t768 = sext i32 54 to i64
  store i64 %t768, ptr %t2
  %t769 = getelementptr [2 x i8], ptr @.str36, i64 0, i64 0
  %t770 = call ptr @strdup(ptr %t769)
  store ptr %t770, ptr %t2
  %t771 = load i64, ptr %t2
  ret i64 %t771
L352:
  br label %L350
L350:
  %t773 = sext i32 0 to i64
  %t772 = icmp ne i64 %t773, 0
  br i1 %t772, label %L349, label %L351
L351:
  br label %L85
L85:
  %t774 = load i64, ptr %t378
  %t776 = sext i32 46 to i64
  %t775 = icmp eq i64 %t774, %t776
  %t777 = zext i1 %t775 to i64
  %t778 = load ptr, ptr %t0
  %t779 = load ptr, ptr %t0
  %t781 = ptrtoint ptr %t779 to i64
  %t782 = sext i32 1 to i64
  %t783 = inttoptr i64 %t781 to ptr
  %t780 = getelementptr i8, ptr %t783, i64 %t782
  %t784 = ptrtoint ptr %t780 to i64
  %t785 = getelementptr i32, ptr %t778, i64 %t784
  %t786 = load i64, ptr %t785
  %t788 = sext i32 46 to i64
  %t787 = icmp eq i64 %t786, %t788
  %t789 = zext i1 %t787 to i64
  %t791 = icmp ne i64 %t777, 0
  %t792 = icmp ne i64 %t789, 0
  %t793 = and i1 %t791, %t792
  %t794 = zext i1 %t793 to i64
  %t795 = icmp ne i64 %t794, 0
  br i1 %t795, label %L353, label %L355
L353:
  %t796 = call i8 @advance(ptr %t0)
  %t797 = sext i8 %t796 to i64
  %t798 = call i8 @advance(ptr %t0)
  %t799 = sext i8 %t798 to i64
  br label %L356
L356:
  %t800 = sext i32 80 to i64
  store i64 %t800, ptr %t2
  %t801 = getelementptr [4 x i8], ptr @.str37, i64 0, i64 0
  %t802 = call ptr @strdup(ptr %t801)
  store ptr %t802, ptr %t2
  %t803 = load i64, ptr %t2
  ret i64 %t803
L359:
  br label %L357
L357:
  %t805 = sext i32 0 to i64
  %t804 = icmp ne i64 %t805, 0
  br i1 %t804, label %L356, label %L358
L358:
  br label %L355
L355:
  br label %L360
L360:
  %t806 = sext i32 69 to i64
  store i64 %t806, ptr %t2
  %t807 = getelementptr [2 x i8], ptr @.str38, i64 0, i64 0
  %t808 = call ptr @strdup(ptr %t807)
  store ptr %t808, ptr %t2
  %t809 = load i64, ptr %t2
  ret i64 %t809
L363:
  br label %L361
L361:
  %t811 = sext i32 0 to i64
  %t810 = icmp ne i64 %t811, 0
  br i1 %t810, label %L360, label %L362
L362:
  br label %L86
L86:
  br label %L364
L364:
  %t812 = sext i32 72 to i64
  store i64 %t812, ptr %t2
  %t813 = getelementptr [2 x i8], ptr @.str39, i64 0, i64 0
  %t814 = call ptr @strdup(ptr %t813)
  store ptr %t814, ptr %t2
  %t815 = load i64, ptr %t2
  ret i64 %t815
L367:
  br label %L365
L365:
  %t817 = sext i32 0 to i64
  %t816 = icmp ne i64 %t817, 0
  br i1 %t816, label %L364, label %L366
L366:
  br label %L87
L87:
  br label %L368
L368:
  %t818 = sext i32 73 to i64
  store i64 %t818, ptr %t2
  %t819 = getelementptr [2 x i8], ptr @.str40, i64 0, i64 0
  %t820 = call ptr @strdup(ptr %t819)
  store ptr %t820, ptr %t2
  %t821 = load i64, ptr %t2
  ret i64 %t821
L371:
  br label %L369
L369:
  %t823 = sext i32 0 to i64
  %t822 = icmp ne i64 %t823, 0
  br i1 %t822, label %L368, label %L370
L370:
  br label %L88
L88:
  br label %L372
L372:
  %t824 = sext i32 74 to i64
  store i64 %t824, ptr %t2
  %t825 = getelementptr [2 x i8], ptr @.str41, i64 0, i64 0
  %t826 = call ptr @strdup(ptr %t825)
  store ptr %t826, ptr %t2
  %t827 = load i64, ptr %t2
  ret i64 %t827
L375:
  br label %L373
L373:
  %t829 = sext i32 0 to i64
  %t828 = icmp ne i64 %t829, 0
  br i1 %t828, label %L372, label %L374
L374:
  br label %L89
L89:
  br label %L376
L376:
  %t830 = sext i32 75 to i64
  store i64 %t830, ptr %t2
  %t831 = getelementptr [2 x i8], ptr @.str42, i64 0, i64 0
  %t832 = call ptr @strdup(ptr %t831)
  store ptr %t832, ptr %t2
  %t833 = load i64, ptr %t2
  ret i64 %t833
L379:
  br label %L377
L377:
  %t835 = sext i32 0 to i64
  %t834 = icmp ne i64 %t835, 0
  br i1 %t834, label %L376, label %L378
L378:
  br label %L90
L90:
  br label %L380
L380:
  %t836 = sext i32 76 to i64
  store i64 %t836, ptr %t2
  %t837 = getelementptr [2 x i8], ptr @.str43, i64 0, i64 0
  %t838 = call ptr @strdup(ptr %t837)
  store ptr %t838, ptr %t2
  %t839 = load i64, ptr %t2
  ret i64 %t839
L383:
  br label %L381
L381:
  %t841 = sext i32 0 to i64
  %t840 = icmp ne i64 %t841, 0
  br i1 %t840, label %L380, label %L382
L382:
  br label %L91
L91:
  br label %L384
L384:
  %t842 = sext i32 77 to i64
  store i64 %t842, ptr %t2
  %t843 = getelementptr [2 x i8], ptr @.str44, i64 0, i64 0
  %t844 = call ptr @strdup(ptr %t843)
  store ptr %t844, ptr %t2
  %t845 = load i64, ptr %t2
  ret i64 %t845
L387:
  br label %L385
L385:
  %t847 = sext i32 0 to i64
  %t846 = icmp ne i64 %t847, 0
  br i1 %t846, label %L384, label %L386
L386:
  br label %L92
L92:
  br label %L388
L388:
  %t848 = sext i32 78 to i64
  store i64 %t848, ptr %t2
  %t849 = getelementptr [2 x i8], ptr @.str45, i64 0, i64 0
  %t850 = call ptr @strdup(ptr %t849)
  store ptr %t850, ptr %t2
  %t851 = load i64, ptr %t2
  ret i64 %t851
L391:
  br label %L389
L389:
  %t853 = sext i32 0 to i64
  %t852 = icmp ne i64 %t853, 0
  br i1 %t852, label %L388, label %L390
L390:
  br label %L93
L93:
  br label %L392
L392:
  %t854 = sext i32 79 to i64
  store i64 %t854, ptr %t2
  %t855 = getelementptr [2 x i8], ptr @.str46, i64 0, i64 0
  %t856 = call ptr @strdup(ptr %t855)
  store ptr %t856, ptr %t2
  %t857 = load i64, ptr %t2
  ret i64 %t857
L395:
  br label %L393
L393:
  %t859 = sext i32 0 to i64
  %t858 = icmp ne i64 %t859, 0
  br i1 %t858, label %L392, label %L394
L394:
  br label %L94
L94:
  br label %L396
L396:
  %t860 = sext i32 70 to i64
  store i64 %t860, ptr %t2
  %t861 = getelementptr [2 x i8], ptr @.str47, i64 0, i64 0
  %t862 = call ptr @strdup(ptr %t861)
  store ptr %t862, ptr %t2
  %t863 = load i64, ptr %t2
  ret i64 %t863
L399:
  br label %L397
L397:
  %t865 = sext i32 0 to i64
  %t864 = icmp ne i64 %t865, 0
  br i1 %t864, label %L396, label %L398
L398:
  br label %L95
L95:
  br label %L400
L400:
  %t866 = sext i32 71 to i64
  store i64 %t866, ptr %t2
  %t867 = getelementptr [2 x i8], ptr @.str48, i64 0, i64 0
  %t868 = call ptr @strdup(ptr %t867)
  store ptr %t868, ptr %t2
  %t869 = load i64, ptr %t2
  ret i64 %t869
L403:
  br label %L401
L401:
  %t871 = sext i32 0 to i64
  %t870 = icmp ne i64 %t871, 0
  br i1 %t870, label %L400, label %L402
L402:
  br label %L71
L96:
  %t872 = sext i32 82 to i64
  store i64 %t872, ptr %t2
  %t873 = call ptr @malloc(i64 2)
  store ptr %t873, ptr %t2
  %t874 = load i64, ptr %t375
  %t875 = load ptr, ptr %t2
  %t877 = sext i32 0 to i64
  %t876 = getelementptr i8, ptr %t875, i64 %t877
  store i64 %t874, ptr %t876
  %t878 = load ptr, ptr %t2
  %t880 = sext i32 1 to i64
  %t879 = getelementptr i8, ptr %t878, i64 %t880
  %t881 = sext i32 0 to i64
  store i64 %t881, ptr %t879
  %t882 = load i64, ptr %t2
  ret i64 %t882
L404:
  br label %L71
L71:
  ret i64 0
}

define dso_local i64 @lexer_next(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = icmp ne ptr %t1, null
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = sext i32 0 to i64
  store i64 %t3, ptr %t0
  %t4 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t4 to i64
  ret i64 %t5
L3:
  br label %L2
L2:
  %t6 = call i64 @read_token(ptr %t0)
  ret i64 %t6
L4:
  ret i64 0
}

define dso_local i64 @lexer_peek(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t1 to i64
  %t4 = icmp eq i64 %t3, 0
  %t2 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t2, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = call i64 @read_token(ptr %t0)
  store i64 %t6, ptr %t0
  %t7 = sext i32 1 to i64
  store i64 %t7, ptr %t0
  br label %L2
L2:
  %t8 = load ptr, ptr %t0
  %t9 = ptrtoint ptr %t8 to i64
  ret i64 %t9
L3:
  ret i64 0
}

define dso_local ptr @token_type_name(ptr %t0) {
entry:
  %t1 = ptrtoint ptr %t0 to i64
  %t2 = add i64 %t1, 0
  switch i64 %t2, label %L84 [
    i64 0, label %L1
    i64 1, label %L2
    i64 2, label %L3
    i64 3, label %L4
    i64 4, label %L5
    i64 5, label %L6
    i64 6, label %L7
    i64 7, label %L8
    i64 8, label %L9
    i64 9, label %L10
    i64 10, label %L11
    i64 11, label %L12
    i64 12, label %L13
    i64 13, label %L14
    i64 14, label %L15
    i64 15, label %L16
    i64 16, label %L17
    i64 17, label %L18
    i64 18, label %L19
    i64 19, label %L20
    i64 20, label %L21
    i64 21, label %L22
    i64 26, label %L23
    i64 27, label %L24
    i64 22, label %L25
    i64 23, label %L26
    i64 24, label %L27
    i64 25, label %L28
    i64 28, label %L29
    i64 29, label %L30
    i64 30, label %L31
    i64 31, label %L32
    i64 32, label %L33
    i64 33, label %L34
    i64 34, label %L35
    i64 35, label %L36
    i64 36, label %L37
    i64 37, label %L38
    i64 38, label %L39
    i64 39, label %L40
    i64 40, label %L41
    i64 41, label %L42
    i64 42, label %L43
    i64 43, label %L44
    i64 44, label %L45
    i64 45, label %L46
    i64 46, label %L47
    i64 47, label %L48
    i64 48, label %L49
    i64 49, label %L50
    i64 50, label %L51
    i64 51, label %L52
    i64 52, label %L53
    i64 53, label %L54
    i64 54, label %L55
    i64 55, label %L56
    i64 56, label %L57
    i64 57, label %L58
    i64 58, label %L59
    i64 59, label %L60
    i64 60, label %L61
    i64 61, label %L62
    i64 62, label %L63
    i64 63, label %L64
    i64 64, label %L65
    i64 65, label %L66
    i64 66, label %L67
    i64 67, label %L68
    i64 68, label %L69
    i64 69, label %L70
    i64 70, label %L71
    i64 71, label %L72
    i64 72, label %L73
    i64 73, label %L74
    i64 74, label %L75
    i64 75, label %L76
    i64 76, label %L77
    i64 77, label %L78
    i64 78, label %L79
    i64 79, label %L80
    i64 80, label %L81
    i64 81, label %L82
    i64 82, label %L83
  ]
L1:
  %t3 = getelementptr [12 x i8], ptr @.str49, i64 0, i64 0
  ret ptr %t3
L85:
  br label %L2
L2:
  %t4 = getelementptr [14 x i8], ptr @.str50, i64 0, i64 0
  ret ptr %t4
L86:
  br label %L3
L3:
  %t5 = getelementptr [13 x i8], ptr @.str51, i64 0, i64 0
  ret ptr %t5
L87:
  br label %L4
L4:
  %t6 = getelementptr [15 x i8], ptr @.str52, i64 0, i64 0
  ret ptr %t6
L88:
  br label %L5
L5:
  %t7 = getelementptr [10 x i8], ptr @.str53, i64 0, i64 0
  ret ptr %t7
L89:
  br label %L6
L6:
  %t8 = getelementptr [8 x i8], ptr @.str54, i64 0, i64 0
  ret ptr %t8
L90:
  br label %L7
L7:
  %t9 = getelementptr [9 x i8], ptr @.str55, i64 0, i64 0
  ret ptr %t9
L91:
  br label %L8
L8:
  %t10 = getelementptr [10 x i8], ptr @.str56, i64 0, i64 0
  ret ptr %t10
L92:
  br label %L9
L9:
  %t11 = getelementptr [11 x i8], ptr @.str57, i64 0, i64 0
  ret ptr %t11
L93:
  br label %L10
L10:
  %t12 = getelementptr [9 x i8], ptr @.str58, i64 0, i64 0
  ret ptr %t12
L94:
  br label %L11
L11:
  %t13 = getelementptr [9 x i8], ptr @.str59, i64 0, i64 0
  ret ptr %t13
L95:
  br label %L12
L12:
  %t14 = getelementptr [10 x i8], ptr @.str60, i64 0, i64 0
  ret ptr %t14
L96:
  br label %L13
L13:
  %t15 = getelementptr [13 x i8], ptr @.str61, i64 0, i64 0
  ret ptr %t15
L97:
  br label %L14
L14:
  %t16 = getelementptr [11 x i8], ptr @.str62, i64 0, i64 0
  ret ptr %t16
L98:
  br label %L15
L15:
  %t17 = getelementptr [7 x i8], ptr @.str63, i64 0, i64 0
  ret ptr %t17
L99:
  br label %L16
L16:
  %t18 = getelementptr [9 x i8], ptr @.str64, i64 0, i64 0
  ret ptr %t18
L100:
  br label %L17
L17:
  %t19 = getelementptr [10 x i8], ptr @.str65, i64 0, i64 0
  ret ptr %t19
L101:
  br label %L18
L18:
  %t20 = getelementptr [8 x i8], ptr @.str66, i64 0, i64 0
  ret ptr %t20
L102:
  br label %L19
L19:
  %t21 = getelementptr [7 x i8], ptr @.str67, i64 0, i64 0
  ret ptr %t21
L103:
  br label %L20
L20:
  %t22 = getelementptr [11 x i8], ptr @.str68, i64 0, i64 0
  ret ptr %t22
L104:
  br label %L21
L21:
  %t23 = getelementptr [10 x i8], ptr @.str69, i64 0, i64 0
  ret ptr %t23
L105:
  br label %L22
L22:
  %t24 = getelementptr [13 x i8], ptr @.str70, i64 0, i64 0
  ret ptr %t24
L106:
  br label %L23
L23:
  %t25 = getelementptr [11 x i8], ptr @.str71, i64 0, i64 0
  ret ptr %t25
L107:
  br label %L24
L24:
  %t26 = getelementptr [10 x i8], ptr @.str72, i64 0, i64 0
  ret ptr %t26
L108:
  br label %L25
L25:
  %t27 = getelementptr [11 x i8], ptr @.str73, i64 0, i64 0
  ret ptr %t27
L109:
  br label %L26
L26:
  %t28 = getelementptr [9 x i8], ptr @.str74, i64 0, i64 0
  ret ptr %t28
L110:
  br label %L27
L27:
  %t29 = getelementptr [12 x i8], ptr @.str75, i64 0, i64 0
  ret ptr %t29
L111:
  br label %L28
L28:
  %t30 = getelementptr [9 x i8], ptr @.str76, i64 0, i64 0
  ret ptr %t30
L112:
  br label %L29
L29:
  %t31 = getelementptr [9 x i8], ptr @.str77, i64 0, i64 0
  ret ptr %t31
L113:
  br label %L30
L30:
  %t32 = getelementptr [12 x i8], ptr @.str78, i64 0, i64 0
  ret ptr %t32
L114:
  br label %L31
L31:
  %t33 = getelementptr [11 x i8], ptr @.str79, i64 0, i64 0
  ret ptr %t33
L115:
  br label %L32
L32:
  %t34 = getelementptr [11 x i8], ptr @.str80, i64 0, i64 0
  ret ptr %t34
L116:
  br label %L33
L33:
  %t35 = getelementptr [10 x i8], ptr @.str81, i64 0, i64 0
  ret ptr %t35
L117:
  br label %L34
L34:
  %t36 = getelementptr [13 x i8], ptr @.str82, i64 0, i64 0
  ret ptr %t36
L118:
  br label %L35
L35:
  %t37 = getelementptr [11 x i8], ptr @.str83, i64 0, i64 0
  ret ptr %t37
L119:
  br label %L36
L36:
  %t38 = getelementptr [9 x i8], ptr @.str84, i64 0, i64 0
  ret ptr %t38
L120:
  br label %L37
L37:
  %t39 = getelementptr [10 x i8], ptr @.str85, i64 0, i64 0
  ret ptr %t39
L121:
  br label %L38
L38:
  %t40 = getelementptr [9 x i8], ptr @.str86, i64 0, i64 0
  ret ptr %t40
L122:
  br label %L39
L39:
  %t41 = getelementptr [10 x i8], ptr @.str87, i64 0, i64 0
  ret ptr %t41
L123:
  br label %L40
L40:
  %t42 = getelementptr [12 x i8], ptr @.str88, i64 0, i64 0
  ret ptr %t42
L124:
  br label %L41
L41:
  %t43 = getelementptr [8 x i8], ptr @.str89, i64 0, i64 0
  ret ptr %t43
L125:
  br label %L42
L42:
  %t44 = getelementptr [9 x i8], ptr @.str90, i64 0, i64 0
  ret ptr %t44
L126:
  br label %L43
L43:
  %t45 = getelementptr [10 x i8], ptr @.str91, i64 0, i64 0
  ret ptr %t45
L127:
  br label %L44
L44:
  %t46 = getelementptr [10 x i8], ptr @.str92, i64 0, i64 0
  ret ptr %t46
L128:
  br label %L45
L45:
  %t47 = getelementptr [11 x i8], ptr @.str93, i64 0, i64 0
  ret ptr %t47
L129:
  br label %L46
L46:
  %t48 = getelementptr [11 x i8], ptr @.str94, i64 0, i64 0
  ret ptr %t48
L130:
  br label %L47
L47:
  %t49 = getelementptr [7 x i8], ptr @.str95, i64 0, i64 0
  ret ptr %t49
L131:
  br label %L48
L48:
  %t50 = getelementptr [8 x i8], ptr @.str96, i64 0, i64 0
  ret ptr %t50
L132:
  br label %L49
L49:
  %t51 = getelementptr [7 x i8], ptr @.str97, i64 0, i64 0
  ret ptr %t51
L133:
  br label %L50
L50:
  %t52 = getelementptr [7 x i8], ptr @.str98, i64 0, i64 0
  ret ptr %t52
L134:
  br label %L51
L51:
  %t53 = getelementptr [8 x i8], ptr @.str99, i64 0, i64 0
  ret ptr %t53
L135:
  br label %L52
L52:
  %t54 = getelementptr [8 x i8], ptr @.str100, i64 0, i64 0
  ret ptr %t54
L136:
  br label %L53
L53:
  %t55 = getelementptr [8 x i8], ptr @.str101, i64 0, i64 0
  ret ptr %t55
L137:
  br label %L54
L54:
  %t56 = getelementptr [7 x i8], ptr @.str102, i64 0, i64 0
  ret ptr %t56
L138:
  br label %L55
L55:
  %t57 = getelementptr [9 x i8], ptr @.str103, i64 0, i64 0
  ret ptr %t57
L139:
  br label %L56
L56:
  %t58 = getelementptr [11 x i8], ptr @.str104, i64 0, i64 0
  ret ptr %t58
L140:
  br label %L57
L57:
  %t59 = getelementptr [16 x i8], ptr @.str105, i64 0, i64 0
  ret ptr %t59
L141:
  br label %L58
L58:
  %t60 = getelementptr [17 x i8], ptr @.str106, i64 0, i64 0
  ret ptr %t60
L142:
  br label %L59
L59:
  %t61 = getelementptr [16 x i8], ptr @.str107, i64 0, i64 0
  ret ptr %t61
L143:
  br label %L60
L60:
  %t62 = getelementptr [17 x i8], ptr @.str108, i64 0, i64 0
  ret ptr %t62
L144:
  br label %L61
L61:
  %t63 = getelementptr [15 x i8], ptr @.str109, i64 0, i64 0
  ret ptr %t63
L145:
  br label %L62
L62:
  %t64 = getelementptr [16 x i8], ptr @.str110, i64 0, i64 0
  ret ptr %t64
L146:
  br label %L63
L63:
  %t65 = getelementptr [17 x i8], ptr @.str111, i64 0, i64 0
  ret ptr %t65
L147:
  br label %L64
L64:
  %t66 = getelementptr [18 x i8], ptr @.str112, i64 0, i64 0
  ret ptr %t66
L148:
  br label %L65
L65:
  %t67 = getelementptr [18 x i8], ptr @.str113, i64 0, i64 0
  ret ptr %t67
L149:
  br label %L66
L66:
  %t68 = getelementptr [19 x i8], ptr @.str114, i64 0, i64 0
  ret ptr %t68
L150:
  br label %L67
L67:
  %t69 = getelementptr [8 x i8], ptr @.str115, i64 0, i64 0
  ret ptr %t69
L151:
  br label %L68
L68:
  %t70 = getelementptr [8 x i8], ptr @.str116, i64 0, i64 0
  ret ptr %t70
L152:
  br label %L69
L69:
  %t71 = getelementptr [10 x i8], ptr @.str117, i64 0, i64 0
  ret ptr %t71
L153:
  br label %L70
L70:
  %t72 = getelementptr [8 x i8], ptr @.str118, i64 0, i64 0
  ret ptr %t72
L154:
  br label %L71
L71:
  %t73 = getelementptr [13 x i8], ptr @.str119, i64 0, i64 0
  ret ptr %t73
L155:
  br label %L72
L72:
  %t74 = getelementptr [10 x i8], ptr @.str120, i64 0, i64 0
  ret ptr %t74
L156:
  br label %L73
L73:
  %t75 = getelementptr [11 x i8], ptr @.str121, i64 0, i64 0
  ret ptr %t75
L157:
  br label %L74
L74:
  %t76 = getelementptr [11 x i8], ptr @.str122, i64 0, i64 0
  ret ptr %t76
L158:
  br label %L75
L75:
  %t77 = getelementptr [11 x i8], ptr @.str123, i64 0, i64 0
  ret ptr %t77
L159:
  br label %L76
L76:
  %t78 = getelementptr [11 x i8], ptr @.str124, i64 0, i64 0
  ret ptr %t78
L160:
  br label %L77
L77:
  %t79 = getelementptr [13 x i8], ptr @.str125, i64 0, i64 0
  ret ptr %t79
L161:
  br label %L78
L78:
  %t80 = getelementptr [13 x i8], ptr @.str126, i64 0, i64 0
  ret ptr %t80
L162:
  br label %L79
L79:
  %t81 = getelementptr [14 x i8], ptr @.str127, i64 0, i64 0
  ret ptr %t81
L163:
  br label %L80
L80:
  %t82 = getelementptr [10 x i8], ptr @.str128, i64 0, i64 0
  ret ptr %t82
L164:
  br label %L81
L81:
  %t83 = getelementptr [13 x i8], ptr @.str129, i64 0, i64 0
  ret ptr %t83
L165:
  br label %L82
L82:
  %t84 = getelementptr [8 x i8], ptr @.str130, i64 0, i64 0
  ret ptr %t84
L166:
  br label %L83
L83:
  %t85 = getelementptr [12 x i8], ptr @.str131, i64 0, i64 0
  ret ptr %t85
L167:
  br label %L0
L84:
  %t86 = getelementptr [4 x i8], ptr @.str132, i64 0, i64 0
  ret ptr %t86
L168:
  br label %L0
L0:
  ret ptr null
}

@.str0 = private unnamed_addr constant [7 x i8] c"malloc\00"
@.str1 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str2 = private unnamed_addr constant [1 x i8] c"\00"
@.str3 = private unnamed_addr constant [3 x i8] c"++\00"
@.str4 = private unnamed_addr constant [3 x i8] c"+=\00"
@.str5 = private unnamed_addr constant [2 x i8] c"+\00"
@.str6 = private unnamed_addr constant [3 x i8] c"--\00"
@.str7 = private unnamed_addr constant [3 x i8] c"-=\00"
@.str8 = private unnamed_addr constant [3 x i8] c"->\00"
@.str9 = private unnamed_addr constant [2 x i8] c"-\00"
@.str10 = private unnamed_addr constant [3 x i8] c"*=\00"
@.str11 = private unnamed_addr constant [2 x i8] c"*\00"
@.str12 = private unnamed_addr constant [3 x i8] c"/=\00"
@.str13 = private unnamed_addr constant [2 x i8] c"/\00"
@.str14 = private unnamed_addr constant [3 x i8] c"%=\00"
@.str15 = private unnamed_addr constant [2 x i8] c"%\00"
@.str16 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str17 = private unnamed_addr constant [3 x i8] c"&=\00"
@.str18 = private unnamed_addr constant [2 x i8] c"&\00"
@.str19 = private unnamed_addr constant [3 x i8] c"||\00"
@.str20 = private unnamed_addr constant [3 x i8] c"|=\00"
@.str21 = private unnamed_addr constant [2 x i8] c"|\00"
@.str22 = private unnamed_addr constant [3 x i8] c"^=\00"
@.str23 = private unnamed_addr constant [2 x i8] c"^\00"
@.str24 = private unnamed_addr constant [2 x i8] c"~\00"
@.str25 = private unnamed_addr constant [4 x i8] c"<<=\00"
@.str26 = private unnamed_addr constant [3 x i8] c"<<\00"
@.str27 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str28 = private unnamed_addr constant [2 x i8] c"<\00"
@.str29 = private unnamed_addr constant [4 x i8] c">>=\00"
@.str30 = private unnamed_addr constant [3 x i8] c">>\00"
@.str31 = private unnamed_addr constant [3 x i8] c">=\00"
@.str32 = private unnamed_addr constant [2 x i8] c">\00"
@.str33 = private unnamed_addr constant [3 x i8] c"==\00"
@.str34 = private unnamed_addr constant [2 x i8] c"=\00"
@.str35 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str36 = private unnamed_addr constant [2 x i8] c"!\00"
@.str37 = private unnamed_addr constant [4 x i8] c"...\00"
@.str38 = private unnamed_addr constant [2 x i8] c".\00"
@.str39 = private unnamed_addr constant [2 x i8] c"(\00"
@.str40 = private unnamed_addr constant [2 x i8] c")\00"
@.str41 = private unnamed_addr constant [2 x i8] c"{\00"
@.str42 = private unnamed_addr constant [2 x i8] c"}\00"
@.str43 = private unnamed_addr constant [2 x i8] c"[\00"
@.str44 = private unnamed_addr constant [2 x i8] c"]\00"
@.str45 = private unnamed_addr constant [2 x i8] c";\00"
@.str46 = private unnamed_addr constant [2 x i8] c",\00"
@.str47 = private unnamed_addr constant [2 x i8] c"?\00"
@.str48 = private unnamed_addr constant [2 x i8] c":\00"
@.str49 = private unnamed_addr constant [12 x i8] c"TOK_INT_LIT\00"
@.str50 = private unnamed_addr constant [14 x i8] c"TOK_FLOAT_LIT\00"
@.str51 = private unnamed_addr constant [13 x i8] c"TOK_CHAR_LIT\00"
@.str52 = private unnamed_addr constant [15 x i8] c"TOK_STRING_LIT\00"
@.str53 = private unnamed_addr constant [10 x i8] c"TOK_IDENT\00"
@.str54 = private unnamed_addr constant [8 x i8] c"TOK_INT\00"
@.str55 = private unnamed_addr constant [9 x i8] c"TOK_CHAR\00"
@.str56 = private unnamed_addr constant [10 x i8] c"TOK_FLOAT\00"
@.str57 = private unnamed_addr constant [11 x i8] c"TOK_DOUBLE\00"
@.str58 = private unnamed_addr constant [9 x i8] c"TOK_VOID\00"
@.str59 = private unnamed_addr constant [9 x i8] c"TOK_LONG\00"
@.str60 = private unnamed_addr constant [10 x i8] c"TOK_SHORT\00"
@.str61 = private unnamed_addr constant [13 x i8] c"TOK_UNSIGNED\00"
@.str62 = private unnamed_addr constant [11 x i8] c"TOK_SIGNED\00"
@.str63 = private unnamed_addr constant [7 x i8] c"TOK_IF\00"
@.str64 = private unnamed_addr constant [9 x i8] c"TOK_ELSE\00"
@.str65 = private unnamed_addr constant [10 x i8] c"TOK_WHILE\00"
@.str66 = private unnamed_addr constant [8 x i8] c"TOK_FOR\00"
@.str67 = private unnamed_addr constant [7 x i8] c"TOK_DO\00"
@.str68 = private unnamed_addr constant [11 x i8] c"TOK_RETURN\00"
@.str69 = private unnamed_addr constant [10 x i8] c"TOK_BREAK\00"
@.str70 = private unnamed_addr constant [13 x i8] c"TOK_CONTINUE\00"
@.str71 = private unnamed_addr constant [11 x i8] c"TOK_STRUCT\00"
@.str72 = private unnamed_addr constant [10 x i8] c"TOK_UNION\00"
@.str73 = private unnamed_addr constant [11 x i8] c"TOK_SWITCH\00"
@.str74 = private unnamed_addr constant [9 x i8] c"TOK_CASE\00"
@.str75 = private unnamed_addr constant [12 x i8] c"TOK_DEFAULT\00"
@.str76 = private unnamed_addr constant [9 x i8] c"TOK_GOTO\00"
@.str77 = private unnamed_addr constant [9 x i8] c"TOK_ENUM\00"
@.str78 = private unnamed_addr constant [12 x i8] c"TOK_TYPEDEF\00"
@.str79 = private unnamed_addr constant [11 x i8] c"TOK_STATIC\00"
@.str80 = private unnamed_addr constant [11 x i8] c"TOK_EXTERN\00"
@.str81 = private unnamed_addr constant [10 x i8] c"TOK_CONST\00"
@.str82 = private unnamed_addr constant [13 x i8] c"TOK_VOLATILE\00"
@.str83 = private unnamed_addr constant [11 x i8] c"TOK_SIZEOF\00"
@.str84 = private unnamed_addr constant [9 x i8] c"TOK_PLUS\00"
@.str85 = private unnamed_addr constant [10 x i8] c"TOK_MINUS\00"
@.str86 = private unnamed_addr constant [9 x i8] c"TOK_STAR\00"
@.str87 = private unnamed_addr constant [10 x i8] c"TOK_SLASH\00"
@.str88 = private unnamed_addr constant [12 x i8] c"TOK_PERCENT\00"
@.str89 = private unnamed_addr constant [8 x i8] c"TOK_AMP\00"
@.str90 = private unnamed_addr constant [9 x i8] c"TOK_PIPE\00"
@.str91 = private unnamed_addr constant [10 x i8] c"TOK_CARET\00"
@.str92 = private unnamed_addr constant [10 x i8] c"TOK_TILDE\00"
@.str93 = private unnamed_addr constant [11 x i8] c"TOK_LSHIFT\00"
@.str94 = private unnamed_addr constant [11 x i8] c"TOK_RSHIFT\00"
@.str95 = private unnamed_addr constant [7 x i8] c"TOK_EQ\00"
@.str96 = private unnamed_addr constant [8 x i8] c"TOK_NEQ\00"
@.str97 = private unnamed_addr constant [7 x i8] c"TOK_LT\00"
@.str98 = private unnamed_addr constant [7 x i8] c"TOK_GT\00"
@.str99 = private unnamed_addr constant [8 x i8] c"TOK_LEQ\00"
@.str100 = private unnamed_addr constant [8 x i8] c"TOK_GEQ\00"
@.str101 = private unnamed_addr constant [8 x i8] c"TOK_AND\00"
@.str102 = private unnamed_addr constant [7 x i8] c"TOK_OR\00"
@.str103 = private unnamed_addr constant [9 x i8] c"TOK_BANG\00"
@.str104 = private unnamed_addr constant [11 x i8] c"TOK_ASSIGN\00"
@.str105 = private unnamed_addr constant [16 x i8] c"TOK_PLUS_ASSIGN\00"
@.str106 = private unnamed_addr constant [17 x i8] c"TOK_MINUS_ASSIGN\00"
@.str107 = private unnamed_addr constant [16 x i8] c"TOK_STAR_ASSIGN\00"
@.str108 = private unnamed_addr constant [17 x i8] c"TOK_SLASH_ASSIGN\00"
@.str109 = private unnamed_addr constant [15 x i8] c"TOK_AMP_ASSIGN\00"
@.str110 = private unnamed_addr constant [16 x i8] c"TOK_PIPE_ASSIGN\00"
@.str111 = private unnamed_addr constant [17 x i8] c"TOK_CARET_ASSIGN\00"
@.str112 = private unnamed_addr constant [18 x i8] c"TOK_LSHIFT_ASSIGN\00"
@.str113 = private unnamed_addr constant [18 x i8] c"TOK_RSHIFT_ASSIGN\00"
@.str114 = private unnamed_addr constant [19 x i8] c"TOK_PERCENT_ASSIGN\00"
@.str115 = private unnamed_addr constant [8 x i8] c"TOK_INC\00"
@.str116 = private unnamed_addr constant [8 x i8] c"TOK_DEC\00"
@.str117 = private unnamed_addr constant [10 x i8] c"TOK_ARROW\00"
@.str118 = private unnamed_addr constant [8 x i8] c"TOK_DOT\00"
@.str119 = private unnamed_addr constant [13 x i8] c"TOK_QUESTION\00"
@.str120 = private unnamed_addr constant [10 x i8] c"TOK_COLON\00"
@.str121 = private unnamed_addr constant [11 x i8] c"TOK_LPAREN\00"
@.str122 = private unnamed_addr constant [11 x i8] c"TOK_RPAREN\00"
@.str123 = private unnamed_addr constant [11 x i8] c"TOK_LBRACE\00"
@.str124 = private unnamed_addr constant [11 x i8] c"TOK_RBRACE\00"
@.str125 = private unnamed_addr constant [13 x i8] c"TOK_LBRACKET\00"
@.str126 = private unnamed_addr constant [13 x i8] c"TOK_RBRACKET\00"
@.str127 = private unnamed_addr constant [14 x i8] c"TOK_SEMICOLON\00"
@.str128 = private unnamed_addr constant [10 x i8] c"TOK_COMMA\00"
@.str129 = private unnamed_addr constant [13 x i8] c"TOK_ELLIPSIS\00"
@.str130 = private unnamed_addr constant [8 x i8] c"TOK_EOF\00"
@.str131 = private unnamed_addr constant [12 x i8] c"TOK_UNKNOWN\00"
@.str132 = private unnamed_addr constant [4 x i8] c"???\00"
