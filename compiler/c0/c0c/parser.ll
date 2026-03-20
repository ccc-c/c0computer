; ModuleID = 'parser.c'
source_filename = "parser.c"
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

declare ptr @lexer_new(ptr, ptr)
declare void @lexer_free(ptr)
declare i64 @lexer_next(ptr)
declare i64 @lexer_peek(ptr)
declare void @token_free(ptr)
declare ptr @token_type_name(ptr)
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

define internal void @register_enum_const(ptr %t0, ptr %t1, i64 %t2) {
entry:
  %t3 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t3 to i64
  %t6 = sext i32 1024 to i64
  %t4 = icmp sge i64 %t5, %t6
  %t7 = zext i1 %t4 to i64
  %t8 = icmp ne i64 %t7, 0
  br i1 %t8, label %L0, label %L2
L0:
  ret void
L3:
  br label %L2
L2:
  %t9 = alloca ptr
  %t10 = call ptr @calloc(i64 1, i64 0)
  store ptr %t10, ptr %t9
  %t11 = call ptr @strdup(ptr %t1)
  %t12 = load ptr, ptr %t9
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t9
  store i64 %t2, ptr %t13
  %t14 = load ptr, ptr %t9
  %t15 = load ptr, ptr %t0
  %t16 = load ptr, ptr %t0
  %t18 = ptrtoint ptr %t16 to i64
  %t17 = add i64 %t18, 1
  store i64 %t17, ptr %t0
  %t20 = ptrtoint ptr %t16 to i64
  %t19 = getelementptr ptr, ptr %t15, i64 %t20
  store ptr %t14, ptr %t19
  ret void
}

define internal i32 @lookup_enum_const(ptr %t0, ptr %t1, ptr %t2) {
entry:
  %t3 = alloca i64
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  %t5 = load i64, ptr %t3
  %t6 = load ptr, ptr %t0
  %t8 = ptrtoint ptr %t6 to i64
  %t7 = icmp slt i64 %t5, %t8
  %t9 = zext i1 %t7 to i64
  %t10 = icmp ne i64 %t9, 0
  br i1 %t10, label %L1, label %L3
L1:
  %t11 = alloca ptr
  %t12 = load ptr, ptr %t0
  %t13 = load i64, ptr %t3
  %t14 = getelementptr ptr, ptr %t12, i64 %t13
  %t15 = load ptr, ptr %t14
  store ptr %t15, ptr %t11
  %t16 = load ptr, ptr %t11
  %t17 = ptrtoint ptr %t16 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L4, label %L5
L4:
  %t19 = load ptr, ptr %t11
  %t20 = load ptr, ptr %t19
  %t21 = call i32 @strcmp(ptr %t20, ptr %t1)
  %t22 = sext i32 %t21 to i64
  %t24 = sext i32 0 to i64
  %t23 = icmp eq i64 %t22, %t24
  %t25 = zext i1 %t23 to i64
  %t26 = icmp ne i64 %t25, 0
  %t27 = zext i1 %t26 to i64
  br label %L6
L5:
  br label %L6
L6:
  %t28 = phi i64 [ %t27, %L4 ], [ 0, %L5 ]
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L7, label %L9
L7:
  %t30 = load ptr, ptr %t11
  %t31 = load ptr, ptr %t30
  store ptr %t31, ptr %t2
  %t32 = sext i32 1 to i64
  %t33 = trunc i64 %t32 to i32
  ret i32 %t33
L10:
  br label %L9
L9:
  br label %L2
L2:
  %t34 = load i64, ptr %t3
  %t35 = add i64 %t34, 1
  store i64 %t35, ptr %t3
  br label %L0
L3:
  %t36 = sext i32 0 to i64
  %t37 = trunc i64 %t36 to i32
  ret i32 %t37
L11:
  ret i32 0
}

define internal void @p_error(ptr %t0, ptr %t1) {
entry:
  %t2 = call ptr @__c0c_stderr()
  %t3 = getelementptr [38 x i8], ptr @.str0, i64 0, i64 0
  %t4 = load ptr, ptr %t0
  %t5 = load ptr, ptr %t0
  %t6 = icmp ne ptr %t5, null
  br i1 %t6, label %L0, label %L1
L0:
  %t7 = load ptr, ptr %t0
  %t8 = ptrtoint ptr %t7 to i64
  br label %L2
L1:
  %t9 = getelementptr [2 x i8], ptr @.str1, i64 0, i64 0
  %t10 = ptrtoint ptr %t9 to i64
  br label %L2
L2:
  %t11 = phi i64 [ %t8, %L0 ], [ %t10, %L1 ]
  %t12 = call i32 @fprintf(ptr %t2, ptr %t3, ptr %t4, ptr %t1, i64 %t11)
  %t13 = sext i32 %t12 to i64
  call void @exit(i64 1)
  ret void
}

define internal void @advance(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  call void @token_free(ptr %t1)
  %t3 = load ptr, ptr %t0
  %t4 = call i64 @lexer_next(ptr %t3)
  store i64 %t4, ptr %t0
  ret void
}

define internal i64 @peek(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = call i64 @lexer_peek(ptr %t1)
  ret i64 %t2
L0:
  ret i64 0
}

define internal i32 @check(ptr %t0, ptr %t1) {
entry:
  %t2 = load ptr, ptr %t0
  %t4 = ptrtoint ptr %t2 to i64
  %t5 = ptrtoint ptr %t1 to i64
  %t3 = icmp eq i64 %t4, %t5
  %t6 = zext i1 %t3 to i64
  %t7 = trunc i64 %t6 to i32
  ret i32 %t7
L0:
  ret i32 0
}

define internal i32 @match(ptr %t0, ptr %t1) {
entry:
  %t2 = call i32 @check(ptr %t0, ptr %t1)
  %t3 = sext i32 %t2 to i64
  %t4 = icmp ne i64 %t3, 0
  br i1 %t4, label %L0, label %L2
L0:
  call void @advance(ptr %t0)
  %t6 = sext i32 1 to i64
  %t7 = trunc i64 %t6 to i32
  ret i32 %t7
L3:
  br label %L2
L2:
  %t8 = sext i32 0 to i64
  %t9 = trunc i64 %t8 to i32
  ret i32 %t9
L4:
  ret i32 0
}

define internal void @expect(ptr %t0, ptr %t1) {
entry:
  %t2 = call i32 @check(ptr %t0, ptr %t1)
  %t3 = sext i32 %t2 to i64
  %t5 = icmp eq i64 %t3, 0
  %t4 = zext i1 %t5 to i64
  %t6 = icmp ne i64 %t4, 0
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = alloca ptr
  %t8 = load ptr, ptr %t7
  %t9 = getelementptr [12 x i8], ptr @.str2, i64 0, i64 0
  %t10 = call ptr @token_type_name(ptr %t1)
  %t11 = call i32 @snprintf(ptr %t8, i64 8, ptr %t9, ptr %t10)
  %t12 = sext i32 %t11 to i64
  %t13 = load ptr, ptr %t7
  call void @p_error(ptr %t0, ptr %t13)
  br label %L2
L2:
  call void @advance(ptr %t0)
  ret void
}

define internal ptr @expect_ident(ptr %t0) {
entry:
  %t1 = call i32 @check(ptr %t0, i64 4)
  %t2 = sext i32 %t1 to i64
  %t4 = icmp eq i64 %t2, 0
  %t3 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t3, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = getelementptr [20 x i8], ptr @.str3, i64 0, i64 0
  call void @p_error(ptr %t0, ptr %t6)
  br label %L2
L2:
  %t8 = alloca ptr
  %t9 = load ptr, ptr %t0
  %t10 = call ptr @strdup(ptr %t9)
  store ptr %t10, ptr %t8
  call void @advance(ptr %t0)
  %t12 = load ptr, ptr %t8
  ret ptr %t12
L3:
  ret ptr null
}

define internal void @register_typedef(ptr %t0, ptr %t1, ptr %t2) {
entry:
  %t3 = load ptr, ptr %t0
  %t5 = ptrtoint ptr %t3 to i64
  %t6 = sext i32 512 to i64
  %t4 = icmp sge i64 %t5, %t6
  %t7 = zext i1 %t4 to i64
  %t8 = icmp ne i64 %t7, 0
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = getelementptr [18 x i8], ptr @.str4, i64 0, i64 0
  call void @p_error(ptr %t0, ptr %t9)
  br label %L2
L2:
  %t11 = alloca ptr
  %t12 = call ptr @calloc(i64 1, i64 0)
  store ptr %t12, ptr %t11
  %t13 = call ptr @strdup(ptr %t1)
  %t14 = load ptr, ptr %t11
  store ptr %t13, ptr %t14
  %t15 = load ptr, ptr %t11
  store ptr %t2, ptr %t15
  %t16 = load ptr, ptr %t11
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t0
  %t20 = ptrtoint ptr %t18 to i64
  %t19 = add i64 %t20, 1
  store i64 %t19, ptr %t0
  %t22 = ptrtoint ptr %t18 to i64
  %t21 = getelementptr ptr, ptr %t17, i64 %t22
  store ptr %t16, ptr %t21
  ret void
}

define internal ptr @lookup_typedef(ptr %t0, ptr %t1) {
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
  %t12 = alloca ptr
  %t13 = load ptr, ptr %t0
  %t14 = load i64, ptr %t2
  %t15 = getelementptr ptr, ptr %t13, i64 %t14
  %t16 = load ptr, ptr %t15
  store ptr %t16, ptr %t12
  %t17 = load ptr, ptr %t12
  %t18 = ptrtoint ptr %t17 to i64
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L4, label %L5
L4:
  %t20 = load ptr, ptr %t12
  %t21 = load ptr, ptr %t20
  %t22 = call i32 @strcmp(ptr %t21, ptr %t1)
  %t23 = sext i32 %t22 to i64
  %t25 = sext i32 0 to i64
  %t24 = icmp eq i64 %t23, %t25
  %t26 = zext i1 %t24 to i64
  %t27 = icmp ne i64 %t26, 0
  %t28 = zext i1 %t27 to i64
  br label %L6
L5:
  br label %L6
L6:
  %t29 = phi i64 [ %t28, %L4 ], [ 0, %L5 ]
  %t30 = icmp ne i64 %t29, 0
  br i1 %t30, label %L7, label %L9
L7:
  %t31 = load ptr, ptr %t12
  %t32 = load ptr, ptr %t31
  ret ptr %t32
L10:
  br label %L9
L9:
  br label %L2
L2:
  %t33 = load i64, ptr %t2
  %t34 = sub i64 %t33, 1
  store i64 %t34, ptr %t2
  br label %L0
L3:
  %t36 = sext i32 0 to i64
  %t35 = inttoptr i64 %t36 to ptr
  ret ptr %t35
L11:
  ret ptr null
}

define internal i32 @is_gcc_extension(ptr %t0) {
entry:
  %t1 = getelementptr [14 x i8], ptr @.str5, i64 0, i64 0
  %t2 = call i32 @strcmp(ptr %t0, ptr %t1)
  %t3 = sext i32 %t2 to i64
  %t5 = sext i32 0 to i64
  %t4 = icmp eq i64 %t3, %t5
  %t6 = zext i1 %t4 to i64
  %t7 = icmp ne i64 %t6, 0
  br i1 %t7, label %L0, label %L1
L0:
  br label %L2
L1:
  %t8 = getelementptr [14 x i8], ptr @.str6, i64 0, i64 0
  %t9 = call i32 @strcmp(ptr %t0, ptr %t8)
  %t10 = sext i32 %t9 to i64
  %t12 = sext i32 0 to i64
  %t11 = icmp eq i64 %t10, %t12
  %t13 = zext i1 %t11 to i64
  %t14 = icmp ne i64 %t13, 0
  %t15 = zext i1 %t14 to i64
  br label %L2
L2:
  %t16 = phi i64 [ 1, %L0 ], [ %t15, %L1 ]
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L3, label %L4
L3:
  br label %L5
L4:
  %t18 = getelementptr [8 x i8], ptr @.str7, i64 0, i64 0
  %t19 = call i32 @strcmp(ptr %t0, ptr %t18)
  %t20 = sext i32 %t19 to i64
  %t22 = sext i32 0 to i64
  %t21 = icmp eq i64 %t20, %t22
  %t23 = zext i1 %t21 to i64
  %t24 = icmp ne i64 %t23, 0
  %t25 = zext i1 %t24 to i64
  br label %L5
L5:
  %t26 = phi i64 [ 1, %L3 ], [ %t25, %L4 ]
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L6, label %L7
L6:
  br label %L8
L7:
  %t28 = getelementptr [6 x i8], ptr @.str8, i64 0, i64 0
  %t29 = call i32 @strcmp(ptr %t0, ptr %t28)
  %t30 = sext i32 %t29 to i64
  %t32 = sext i32 0 to i64
  %t31 = icmp eq i64 %t30, %t32
  %t33 = zext i1 %t31 to i64
  %t34 = icmp ne i64 %t33, 0
  %t35 = zext i1 %t34 to i64
  br label %L8
L8:
  %t36 = phi i64 [ 1, %L6 ], [ %t35, %L7 ]
  %t37 = icmp ne i64 %t36, 0
  br i1 %t37, label %L9, label %L10
L9:
  br label %L11
L10:
  %t38 = getelementptr [11 x i8], ptr @.str9, i64 0, i64 0
  %t39 = call i32 @strcmp(ptr %t0, ptr %t38)
  %t40 = sext i32 %t39 to i64
  %t42 = sext i32 0 to i64
  %t41 = icmp eq i64 %t40, %t42
  %t43 = zext i1 %t41 to i64
  %t44 = icmp ne i64 %t43, 0
  %t45 = zext i1 %t44 to i64
  br label %L11
L11:
  %t46 = phi i64 [ 1, %L9 ], [ %t45, %L10 ]
  %t47 = icmp ne i64 %t46, 0
  br i1 %t47, label %L12, label %L13
L12:
  br label %L14
L13:
  %t48 = getelementptr [9 x i8], ptr @.str10, i64 0, i64 0
  %t49 = call i32 @strcmp(ptr %t0, ptr %t48)
  %t50 = sext i32 %t49 to i64
  %t52 = sext i32 0 to i64
  %t51 = icmp eq i64 %t50, %t52
  %t53 = zext i1 %t51 to i64
  %t54 = icmp ne i64 %t53, 0
  %t55 = zext i1 %t54 to i64
  br label %L14
L14:
  %t56 = phi i64 [ 1, %L12 ], [ %t55, %L13 ]
  %t57 = icmp ne i64 %t56, 0
  br i1 %t57, label %L15, label %L16
L15:
  br label %L17
L16:
  %t58 = getelementptr [13 x i8], ptr @.str11, i64 0, i64 0
  %t59 = call i32 @strcmp(ptr %t0, ptr %t58)
  %t60 = sext i32 %t59 to i64
  %t62 = sext i32 0 to i64
  %t61 = icmp eq i64 %t60, %t62
  %t63 = zext i1 %t61 to i64
  %t64 = icmp ne i64 %t63, 0
  %t65 = zext i1 %t64 to i64
  br label %L17
L17:
  %t66 = phi i64 [ 1, %L15 ], [ %t65, %L16 ]
  %t67 = icmp ne i64 %t66, 0
  br i1 %t67, label %L18, label %L19
L18:
  br label %L20
L19:
  %t68 = getelementptr [11 x i8], ptr @.str12, i64 0, i64 0
  %t69 = call i32 @strcmp(ptr %t0, ptr %t68)
  %t70 = sext i32 %t69 to i64
  %t72 = sext i32 0 to i64
  %t71 = icmp eq i64 %t70, %t72
  %t73 = zext i1 %t71 to i64
  %t74 = icmp ne i64 %t73, 0
  %t75 = zext i1 %t74 to i64
  br label %L20
L20:
  %t76 = phi i64 [ 1, %L18 ], [ %t75, %L19 ]
  %t77 = icmp ne i64 %t76, 0
  br i1 %t77, label %L21, label %L22
L21:
  br label %L23
L22:
  %t78 = getelementptr [11 x i8], ptr @.str13, i64 0, i64 0
  %t79 = call i32 @strcmp(ptr %t0, ptr %t78)
  %t80 = sext i32 %t79 to i64
  %t82 = sext i32 0 to i64
  %t81 = icmp eq i64 %t80, %t82
  %t83 = zext i1 %t81 to i64
  %t84 = icmp ne i64 %t83, 0
  %t85 = zext i1 %t84 to i64
  br label %L23
L23:
  %t86 = phi i64 [ 1, %L21 ], [ %t85, %L22 ]
  %t87 = icmp ne i64 %t86, 0
  br i1 %t87, label %L24, label %L25
L24:
  br label %L26
L25:
  %t88 = getelementptr [13 x i8], ptr @.str14, i64 0, i64 0
  %t89 = call i32 @strcmp(ptr %t0, ptr %t88)
  %t90 = sext i32 %t89 to i64
  %t92 = sext i32 0 to i64
  %t91 = icmp eq i64 %t90, %t92
  %t93 = zext i1 %t91 to i64
  %t94 = icmp ne i64 %t93, 0
  %t95 = zext i1 %t94 to i64
  br label %L26
L26:
  %t96 = phi i64 [ 1, %L24 ], [ %t95, %L25 ]
  %t97 = icmp ne i64 %t96, 0
  br i1 %t97, label %L27, label %L28
L27:
  br label %L29
L28:
  %t98 = getelementptr [8 x i8], ptr @.str15, i64 0, i64 0
  %t99 = call i32 @strcmp(ptr %t0, ptr %t98)
  %t100 = sext i32 %t99 to i64
  %t102 = sext i32 0 to i64
  %t101 = icmp eq i64 %t100, %t102
  %t103 = zext i1 %t101 to i64
  %t104 = icmp ne i64 %t103, 0
  %t105 = zext i1 %t104 to i64
  br label %L29
L29:
  %t106 = phi i64 [ 1, %L27 ], [ %t105, %L28 ]
  %t107 = icmp ne i64 %t106, 0
  br i1 %t107, label %L30, label %L31
L30:
  br label %L32
L31:
  %t108 = getelementptr [10 x i8], ptr @.str16, i64 0, i64 0
  %t109 = call i32 @strcmp(ptr %t0, ptr %t108)
  %t110 = sext i32 %t109 to i64
  %t112 = sext i32 0 to i64
  %t111 = icmp eq i64 %t110, %t112
  %t113 = zext i1 %t111 to i64
  %t114 = icmp ne i64 %t113, 0
  %t115 = zext i1 %t114 to i64
  br label %L32
L32:
  %t116 = phi i64 [ 1, %L30 ], [ %t115, %L31 ]
  %t117 = icmp ne i64 %t116, 0
  br i1 %t117, label %L33, label %L34
L33:
  br label %L35
L34:
  %t118 = getelementptr [11 x i8], ptr @.str17, i64 0, i64 0
  %t119 = call i32 @strcmp(ptr %t0, ptr %t118)
  %t120 = sext i32 %t119 to i64
  %t122 = sext i32 0 to i64
  %t121 = icmp eq i64 %t120, %t122
  %t123 = zext i1 %t121 to i64
  %t124 = icmp ne i64 %t123, 0
  %t125 = zext i1 %t124 to i64
  br label %L35
L35:
  %t126 = phi i64 [ 1, %L33 ], [ %t125, %L34 ]
  %t127 = icmp ne i64 %t126, 0
  br i1 %t127, label %L36, label %L37
L36:
  br label %L38
L37:
  %t128 = getelementptr [9 x i8], ptr @.str18, i64 0, i64 0
  %t129 = call i32 @strcmp(ptr %t0, ptr %t128)
  %t130 = sext i32 %t129 to i64
  %t132 = sext i32 0 to i64
  %t131 = icmp eq i64 %t130, %t132
  %t133 = zext i1 %t131 to i64
  %t134 = icmp ne i64 %t133, 0
  %t135 = zext i1 %t134 to i64
  br label %L38
L38:
  %t136 = phi i64 [ 1, %L36 ], [ %t135, %L37 ]
  %t137 = icmp ne i64 %t136, 0
  br i1 %t137, label %L39, label %L40
L39:
  br label %L41
L40:
  %t138 = getelementptr [11 x i8], ptr @.str19, i64 0, i64 0
  %t139 = call i32 @strcmp(ptr %t0, ptr %t138)
  %t140 = sext i32 %t139 to i64
  %t142 = sext i32 0 to i64
  %t141 = icmp eq i64 %t140, %t142
  %t143 = zext i1 %t141 to i64
  %t144 = icmp ne i64 %t143, 0
  %t145 = zext i1 %t144 to i64
  br label %L41
L41:
  %t146 = phi i64 [ 1, %L39 ], [ %t145, %L40 ]
  %t147 = icmp ne i64 %t146, 0
  br i1 %t147, label %L42, label %L43
L42:
  br label %L44
L43:
  %t148 = getelementptr [9 x i8], ptr @.str20, i64 0, i64 0
  %t149 = call i32 @strcmp(ptr %t0, ptr %t148)
  %t150 = sext i32 %t149 to i64
  %t152 = sext i32 0 to i64
  %t151 = icmp eq i64 %t150, %t152
  %t153 = zext i1 %t151 to i64
  %t154 = icmp ne i64 %t153, 0
  %t155 = zext i1 %t154 to i64
  br label %L44
L44:
  %t156 = phi i64 [ 1, %L42 ], [ %t155, %L43 ]
  %t157 = icmp ne i64 %t156, 0
  br i1 %t157, label %L45, label %L46
L45:
  br label %L47
L46:
  %t158 = getelementptr [8 x i8], ptr @.str21, i64 0, i64 0
  %t159 = call i32 @strcmp(ptr %t0, ptr %t158)
  %t160 = sext i32 %t159 to i64
  %t162 = sext i32 0 to i64
  %t161 = icmp eq i64 %t160, %t162
  %t163 = zext i1 %t161 to i64
  %t164 = icmp ne i64 %t163, 0
  %t165 = zext i1 %t164 to i64
  br label %L47
L47:
  %t166 = phi i64 [ 1, %L45 ], [ %t165, %L46 ]
  %t167 = icmp ne i64 %t166, 0
  br i1 %t167, label %L48, label %L49
L48:
  br label %L50
L49:
  %t168 = getelementptr [11 x i8], ptr @.str22, i64 0, i64 0
  %t169 = call i32 @strcmp(ptr %t0, ptr %t168)
  %t170 = sext i32 %t169 to i64
  %t172 = sext i32 0 to i64
  %t171 = icmp eq i64 %t170, %t172
  %t173 = zext i1 %t171 to i64
  %t174 = icmp ne i64 %t173, 0
  %t175 = zext i1 %t174 to i64
  br label %L50
L50:
  %t176 = phi i64 [ 1, %L48 ], [ %t175, %L49 ]
  %t177 = icmp ne i64 %t176, 0
  br i1 %t177, label %L51, label %L52
L51:
  br label %L53
L52:
  %t178 = getelementptr [14 x i8], ptr @.str23, i64 0, i64 0
  %t179 = call i32 @strcmp(ptr %t0, ptr %t178)
  %t180 = sext i32 %t179 to i64
  %t182 = sext i32 0 to i64
  %t181 = icmp eq i64 %t180, %t182
  %t183 = zext i1 %t181 to i64
  %t184 = icmp ne i64 %t183, 0
  %t185 = zext i1 %t184 to i64
  br label %L53
L53:
  %t186 = phi i64 [ 1, %L51 ], [ %t185, %L52 ]
  %t187 = icmp ne i64 %t186, 0
  br i1 %t187, label %L54, label %L55
L54:
  br label %L56
L55:
  %t188 = getelementptr [10 x i8], ptr @.str24, i64 0, i64 0
  %t189 = call i32 @strcmp(ptr %t0, ptr %t188)
  %t190 = sext i32 %t189 to i64
  %t192 = sext i32 0 to i64
  %t191 = icmp eq i64 %t190, %t192
  %t193 = zext i1 %t191 to i64
  %t194 = icmp ne i64 %t193, 0
  %t195 = zext i1 %t194 to i64
  br label %L56
L56:
  %t196 = phi i64 [ 1, %L54 ], [ %t195, %L55 ]
  %t197 = trunc i64 %t196 to i32
  ret i32 %t197
L57:
  ret i32 0
}

define internal void @skip_gcc_extension(ptr %t0) {
entry:
  br label %L0
L0:
  br label %L1
L1:
  %t1 = call i32 @check(ptr %t0, i64 4)
  %t2 = sext i32 %t1 to i64
  %t4 = icmp eq i64 %t2, 0
  %t3 = zext i1 %t4 to i64
  %t5 = icmp ne i64 %t3, 0
  br i1 %t5, label %L4, label %L6
L4:
  br label %L3
L7:
  br label %L6
L6:
  %t6 = load ptr, ptr %t0
  %t7 = call i32 @is_gcc_extension(ptr %t6)
  %t8 = sext i32 %t7 to i64
  %t10 = icmp eq i64 %t8, 0
  %t9 = zext i1 %t10 to i64
  %t11 = icmp ne i64 %t9, 0
  br i1 %t11, label %L8, label %L10
L8:
  br label %L3
L11:
  br label %L10
L10:
  %t12 = alloca ptr
  %t13 = load ptr, ptr %t0
  store ptr %t13, ptr %t12
  %t14 = alloca i64
  %t15 = load ptr, ptr %t12
  %t16 = getelementptr [14 x i8], ptr @.str25, i64 0, i64 0
  %t17 = call i32 @strcmp(ptr %t15, ptr %t16)
  %t18 = sext i32 %t17 to i64
  %t20 = sext i32 0 to i64
  %t19 = icmp eq i64 %t18, %t20
  %t21 = zext i1 %t19 to i64
  %t22 = icmp ne i64 %t21, 0
  br i1 %t22, label %L12, label %L13
L12:
  br label %L14
L13:
  %t23 = load ptr, ptr %t12
  %t24 = getelementptr [8 x i8], ptr @.str26, i64 0, i64 0
  %t25 = call i32 @strcmp(ptr %t23, ptr %t24)
  %t26 = sext i32 %t25 to i64
  %t28 = sext i32 0 to i64
  %t27 = icmp eq i64 %t26, %t28
  %t29 = zext i1 %t27 to i64
  %t30 = icmp ne i64 %t29, 0
  %t31 = zext i1 %t30 to i64
  br label %L14
L14:
  %t32 = phi i64 [ 1, %L12 ], [ %t31, %L13 ]
  %t33 = icmp ne i64 %t32, 0
  br i1 %t33, label %L15, label %L16
L15:
  br label %L17
L16:
  %t34 = load ptr, ptr %t12
  %t35 = getelementptr [6 x i8], ptr @.str27, i64 0, i64 0
  %t36 = call i32 @strcmp(ptr %t34, ptr %t35)
  %t37 = sext i32 %t36 to i64
  %t39 = sext i32 0 to i64
  %t38 = icmp eq i64 %t37, %t39
  %t40 = zext i1 %t38 to i64
  %t41 = icmp ne i64 %t40, 0
  %t42 = zext i1 %t41 to i64
  br label %L17
L17:
  %t43 = phi i64 [ 1, %L15 ], [ %t42, %L16 ]
  %t44 = icmp ne i64 %t43, 0
  br i1 %t44, label %L18, label %L19
L18:
  br label %L20
L19:
  %t45 = load ptr, ptr %t12
  %t46 = getelementptr [11 x i8], ptr @.str28, i64 0, i64 0
  %t47 = call i32 @strcmp(ptr %t45, ptr %t46)
  %t48 = sext i32 %t47 to i64
  %t50 = sext i32 0 to i64
  %t49 = icmp eq i64 %t48, %t50
  %t51 = zext i1 %t49 to i64
  %t52 = icmp ne i64 %t51, 0
  %t53 = zext i1 %t52 to i64
  br label %L20
L20:
  %t54 = phi i64 [ 1, %L18 ], [ %t53, %L19 ]
  %t55 = icmp ne i64 %t54, 0
  br i1 %t55, label %L21, label %L22
L21:
  br label %L23
L22:
  %t56 = load ptr, ptr %t12
  %t57 = getelementptr [9 x i8], ptr @.str29, i64 0, i64 0
  %t58 = call i32 @strcmp(ptr %t56, ptr %t57)
  %t59 = sext i32 %t58 to i64
  %t61 = sext i32 0 to i64
  %t60 = icmp eq i64 %t59, %t61
  %t62 = zext i1 %t60 to i64
  %t63 = icmp ne i64 %t62, 0
  %t64 = zext i1 %t63 to i64
  br label %L23
L23:
  %t65 = phi i64 [ 1, %L21 ], [ %t64, %L22 ]
  %t66 = icmp ne i64 %t65, 0
  br i1 %t66, label %L24, label %L25
L24:
  br label %L26
L25:
  %t67 = load ptr, ptr %t12
  %t68 = getelementptr [11 x i8], ptr @.str30, i64 0, i64 0
  %t69 = call i32 @strcmp(ptr %t67, ptr %t68)
  %t70 = sext i32 %t69 to i64
  %t72 = sext i32 0 to i64
  %t71 = icmp eq i64 %t70, %t72
  %t73 = zext i1 %t71 to i64
  %t74 = icmp ne i64 %t73, 0
  %t75 = zext i1 %t74 to i64
  br label %L26
L26:
  %t76 = phi i64 [ 1, %L24 ], [ %t75, %L25 ]
  store i64 %t76, ptr %t14
  call void @advance(ptr %t0)
  %t78 = load i64, ptr %t14
  %t79 = icmp ne i64 %t78, 0
  br i1 %t79, label %L27, label %L28
L27:
  %t80 = call i32 @check(ptr %t0, i64 72)
  %t81 = sext i32 %t80 to i64
  %t82 = icmp ne i64 %t81, 0
  %t83 = zext i1 %t82 to i64
  br label %L29
L28:
  br label %L29
L29:
  %t84 = phi i64 [ %t83, %L27 ], [ 0, %L28 ]
  %t85 = icmp ne i64 %t84, 0
  br i1 %t85, label %L30, label %L32
L30:
  %t86 = alloca i64
  %t87 = sext i32 1 to i64
  store i64 %t87, ptr %t86
  call void @advance(ptr %t0)
  br label %L33
L33:
  %t89 = call i32 @check(ptr %t0, i64 81)
  %t90 = sext i32 %t89 to i64
  %t92 = icmp eq i64 %t90, 0
  %t91 = zext i1 %t92 to i64
  %t93 = icmp ne i64 %t91, 0
  br i1 %t93, label %L36, label %L37
L36:
  %t94 = load i64, ptr %t86
  %t96 = sext i32 0 to i64
  %t95 = icmp sgt i64 %t94, %t96
  %t97 = zext i1 %t95 to i64
  %t98 = icmp ne i64 %t97, 0
  %t99 = zext i1 %t98 to i64
  br label %L38
L37:
  br label %L38
L38:
  %t100 = phi i64 [ %t99, %L36 ], [ 0, %L37 ]
  %t101 = icmp ne i64 %t100, 0
  br i1 %t101, label %L34, label %L35
L34:
  %t102 = call i32 @check(ptr %t0, i64 72)
  %t103 = sext i32 %t102 to i64
  %t104 = icmp ne i64 %t103, 0
  br i1 %t104, label %L39, label %L40
L39:
  %t105 = load i64, ptr %t86
  %t106 = add i64 %t105, 1
  store i64 %t106, ptr %t86
  br label %L41
L40:
  %t107 = call i32 @check(ptr %t0, i64 73)
  %t108 = sext i32 %t107 to i64
  %t109 = icmp ne i64 %t108, 0
  br i1 %t109, label %L42, label %L44
L42:
  %t110 = load i64, ptr %t86
  %t111 = sub i64 %t110, 1
  store i64 %t111, ptr %t86
  br label %L44
L44:
  br label %L41
L41:
  call void @advance(ptr %t0)
  br label %L33
L35:
  br label %L32
L32:
  br label %L2
L2:
  br label %L0
L3:
  ret void
}

define internal i32 @is_type_start(ptr %t0) {
entry:
  %t1 = call i32 @check(ptr %t0, i64 4)
  %t2 = sext i32 %t1 to i64
  %t3 = icmp ne i64 %t2, 0
  br i1 %t3, label %L0, label %L1
L0:
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @is_gcc_extension(ptr %t4)
  %t6 = sext i32 %t5 to i64
  %t7 = icmp ne i64 %t6, 0
  %t8 = zext i1 %t7 to i64
  br label %L2
L1:
  br label %L2
L2:
  %t9 = phi i64 [ %t8, %L0 ], [ 0, %L1 ]
  %t10 = icmp ne i64 %t9, 0
  br i1 %t10, label %L3, label %L5
L3:
  %t11 = sext i32 0 to i64
  %t12 = trunc i64 %t11 to i32
  ret i32 %t12
L6:
  br label %L5
L5:
  %t13 = load ptr, ptr %t0
  %t14 = ptrtoint ptr %t13 to i64
  %t15 = add i64 %t14, 0
  switch i64 %t15, label %L26 [
    i64 5, label %L8
    i64 6, label %L9
    i64 7, label %L10
    i64 8, label %L11
    i64 9, label %L12
    i64 10, label %L13
    i64 11, label %L14
    i64 12, label %L15
    i64 13, label %L16
    i64 26, label %L17
    i64 27, label %L18
    i64 28, label %L19
    i64 32, label %L20
    i64 33, label %L21
    i64 30, label %L22
    i64 31, label %L23
    i64 29, label %L24
    i64 4, label %L25
  ]
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
  br label %L14
L14:
  br label %L15
L15:
  br label %L16
L16:
  br label %L17
L17:
  br label %L18
L18:
  br label %L19
L19:
  br label %L20
L20:
  br label %L21
L21:
  br label %L22
L22:
  br label %L23
L23:
  br label %L24
L24:
  %t16 = sext i32 1 to i64
  %t17 = trunc i64 %t16 to i32
  ret i32 %t17
L27:
  br label %L25
L25:
  %t18 = load ptr, ptr %t0
  %t19 = call ptr @lookup_typedef(ptr %t0, ptr %t18)
  %t21 = sext i32 0 to i64
  %t20 = inttoptr i64 %t21 to ptr
  %t23 = ptrtoint ptr %t19 to i64
  %t24 = ptrtoint ptr %t20 to i64
  %t22 = icmp ne i64 %t23, %t24
  %t25 = zext i1 %t22 to i64
  %t26 = trunc i64 %t25 to i32
  ret i32 %t26
L28:
  br label %L7
L26:
  %t27 = sext i32 0 to i64
  %t28 = trunc i64 %t27 to i32
  ret i32 %t28
L29:
  br label %L7
L7:
  ret i32 0
}

define internal ptr @parse_struct_union(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  %t4 = ptrtoint ptr %t2 to i64
  %t5 = sext i32 27 to i64
  %t3 = icmp eq i64 %t4, %t5
  %t6 = zext i1 %t3 to i64
  store i64 %t6, ptr %t1
  call void @advance(ptr %t0)
  %t8 = alloca ptr
  %t10 = sext i32 0 to i64
  %t9 = inttoptr i64 %t10 to ptr
  store ptr %t9, ptr %t8
  %t11 = call i32 @check(ptr %t0, i64 4)
  %t12 = sext i32 %t11 to i64
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L0, label %L2
L0:
  %t14 = load ptr, ptr %t0
  %t15 = call ptr @strdup(ptr %t14)
  store ptr %t15, ptr %t8
  call void @advance(ptr %t0)
  br label %L2
L2:
  %t17 = alloca ptr
  %t18 = load i64, ptr %t1
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L3, label %L4
L3:
  %t20 = sext i32 19 to i64
  br label %L5
L4:
  %t21 = sext i32 18 to i64
  br label %L5
L5:
  %t22 = phi i64 [ %t20, %L3 ], [ %t21, %L4 ]
  %t23 = call ptr @type_new(i64 %t22)
  store ptr %t23, ptr %t17
  %t24 = load ptr, ptr %t8
  %t25 = load ptr, ptr %t17
  store ptr %t24, ptr %t25
  %t26 = call i32 @check(ptr %t0, i64 74)
  %t27 = sext i32 %t26 to i64
  %t28 = icmp ne i64 %t27, 0
  br i1 %t28, label %L6, label %L8
L6:
  call void @advance(ptr %t0)
  %t30 = alloca i64
  %t31 = sext i32 1 to i64
  store i64 %t31, ptr %t30
  br label %L9
L9:
  %t32 = call i32 @check(ptr %t0, i64 81)
  %t33 = sext i32 %t32 to i64
  %t35 = icmp eq i64 %t33, 0
  %t34 = zext i1 %t35 to i64
  %t36 = icmp ne i64 %t34, 0
  br i1 %t36, label %L12, label %L13
L12:
  %t37 = load i64, ptr %t30
  %t39 = sext i32 0 to i64
  %t38 = icmp sgt i64 %t37, %t39
  %t40 = zext i1 %t38 to i64
  %t41 = icmp ne i64 %t40, 0
  %t42 = zext i1 %t41 to i64
  br label %L14
L13:
  br label %L14
L14:
  %t43 = phi i64 [ %t42, %L12 ], [ 0, %L13 ]
  %t44 = icmp ne i64 %t43, 0
  br i1 %t44, label %L10, label %L11
L10:
  %t45 = call i32 @check(ptr %t0, i64 74)
  %t46 = sext i32 %t45 to i64
  %t47 = icmp ne i64 %t46, 0
  br i1 %t47, label %L15, label %L16
L15:
  %t48 = load i64, ptr %t30
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t30
  br label %L17
L16:
  %t50 = call i32 @check(ptr %t0, i64 75)
  %t51 = sext i32 %t50 to i64
  %t52 = icmp ne i64 %t51, 0
  br i1 %t52, label %L18, label %L20
L18:
  %t53 = load i64, ptr %t30
  %t54 = sub i64 %t53, 1
  store i64 %t54, ptr %t30
  br label %L20
L20:
  br label %L17
L17:
  call void @advance(ptr %t0)
  br label %L9
L11:
  br label %L8
L8:
  %t56 = load ptr, ptr %t17
  ret ptr %t56
L21:
  ret ptr null
}

define internal ptr @parse_enum_specifier(ptr %t0) {
entry:
  call void @advance(ptr %t0)
  %t2 = alloca ptr
  %t3 = call ptr @type_new(i64 20)
  store ptr %t3, ptr %t2
  %t4 = call i32 @check(ptr %t0, i64 4)
  %t5 = sext i32 %t4 to i64
  %t6 = icmp ne i64 %t5, 0
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = load ptr, ptr %t0
  %t8 = call ptr @strdup(ptr %t7)
  %t9 = load ptr, ptr %t2
  store ptr %t8, ptr %t9
  call void @advance(ptr %t0)
  br label %L2
L2:
  %t11 = call i32 @check(ptr %t0, i64 74)
  %t12 = sext i32 %t11 to i64
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L3, label %L5
L3:
  call void @advance(ptr %t0)
  %t15 = alloca i64
  %t16 = sext i32 0 to i64
  store i64 %t16, ptr %t15
  br label %L6
L6:
  %t17 = call i32 @check(ptr %t0, i64 75)
  %t18 = sext i32 %t17 to i64
  %t20 = icmp eq i64 %t18, 0
  %t19 = zext i1 %t20 to i64
  %t21 = icmp ne i64 %t19, 0
  br i1 %t21, label %L9, label %L10
L9:
  %t22 = call i32 @check(ptr %t0, i64 81)
  %t23 = sext i32 %t22 to i64
  %t25 = icmp eq i64 %t23, 0
  %t24 = zext i1 %t25 to i64
  %t26 = icmp ne i64 %t24, 0
  %t27 = zext i1 %t26 to i64
  br label %L11
L10:
  br label %L11
L11:
  %t28 = phi i64 [ %t27, %L9 ], [ 0, %L10 ]
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L7, label %L8
L7:
  %t30 = call i32 @check(ptr %t0, i64 4)
  %t31 = sext i32 %t30 to i64
  %t32 = icmp ne i64 %t31, 0
  br i1 %t32, label %L12, label %L13
L12:
  %t33 = alloca ptr
  %t34 = load ptr, ptr %t0
  %t35 = call ptr @strdup(ptr %t34)
  store ptr %t35, ptr %t33
  call void @advance(ptr %t0)
  %t37 = call i32 @match(ptr %t0, i64 55)
  %t38 = sext i32 %t37 to i64
  %t39 = icmp ne i64 %t38, 0
  br i1 %t39, label %L15, label %L17
L15:
  %t40 = call i32 @check(ptr %t0, i64 0)
  %t41 = sext i32 %t40 to i64
  %t42 = icmp ne i64 %t41, 0
  br i1 %t42, label %L18, label %L19
L18:
  %t43 = load ptr, ptr %t0
  %t45 = sext i32 0 to i64
  %t44 = inttoptr i64 %t45 to ptr
  %t46 = call i64 @strtoll(ptr %t43, ptr %t44, i64 0)
  %t47 = add i64 %t46, 0
  store i64 %t47, ptr %t15
  call void @advance(ptr %t0)
  br label %L20
L19:
  %t49 = call i32 @check(ptr %t0, i64 36)
  %t50 = sext i32 %t49 to i64
  %t51 = icmp ne i64 %t50, 0
  br i1 %t51, label %L21, label %L22
L21:
  call void @advance(ptr %t0)
  %t53 = call i32 @check(ptr %t0, i64 0)
  %t54 = sext i32 %t53 to i64
  %t55 = icmp ne i64 %t54, 0
  br i1 %t55, label %L24, label %L26
L24:
  %t56 = load ptr, ptr %t0
  %t58 = sext i32 0 to i64
  %t57 = inttoptr i64 %t58 to ptr
  %t59 = call i64 @strtoll(ptr %t56, ptr %t57, i64 0)
  %t60 = add i64 %t59, 0
  %t61 = sub i64 0, %t60
  store i64 %t61, ptr %t15
  call void @advance(ptr %t0)
  br label %L26
L26:
  br label %L23
L22:
  %t63 = call i32 @check(ptr %t0, i64 4)
  %t64 = sext i32 %t63 to i64
  %t65 = icmp ne i64 %t64, 0
  br i1 %t65, label %L27, label %L29
L27:
  %t66 = alloca i64
  %t67 = load ptr, ptr %t0
  %t68 = call i32 @lookup_enum_const(ptr %t0, ptr %t67, ptr %t66)
  %t69 = sext i32 %t68 to i64
  %t70 = icmp ne i64 %t69, 0
  br i1 %t70, label %L30, label %L32
L30:
  %t71 = load i64, ptr %t66
  store i64 %t71, ptr %t15
  br label %L32
L32:
  call void @advance(ptr %t0)
  %t73 = call i32 @check(ptr %t0, i64 35)
  %t74 = sext i32 %t73 to i64
  %t75 = icmp ne i64 %t74, 0
  br i1 %t75, label %L33, label %L34
L33:
  br label %L35
L34:
  %t76 = call i32 @check(ptr %t0, i64 36)
  %t77 = sext i32 %t76 to i64
  %t78 = icmp ne i64 %t77, 0
  %t79 = zext i1 %t78 to i64
  br label %L35
L35:
  %t80 = phi i64 [ 1, %L33 ], [ %t79, %L34 ]
  %t81 = icmp ne i64 %t80, 0
  br i1 %t81, label %L36, label %L38
L36:
  %t82 = alloca i64
  %t83 = load ptr, ptr %t0
  %t85 = ptrtoint ptr %t83 to i64
  %t86 = sext i32 36 to i64
  %t84 = icmp eq i64 %t85, %t86
  %t87 = zext i1 %t84 to i64
  store i64 %t87, ptr %t82
  call void @advance(ptr %t0)
  %t89 = call i32 @check(ptr %t0, i64 0)
  %t90 = sext i32 %t89 to i64
  %t91 = icmp ne i64 %t90, 0
  br i1 %t91, label %L39, label %L41
L39:
  %t92 = alloca i64
  %t93 = load ptr, ptr %t0
  %t95 = sext i32 0 to i64
  %t94 = inttoptr i64 %t95 to ptr
  %t96 = call i64 @strtoll(ptr %t93, ptr %t94, i64 0)
  store i64 %t96, ptr %t92
  %t97 = load i64, ptr %t82
  %t98 = icmp ne i64 %t97, 0
  br i1 %t98, label %L42, label %L43
L42:
  %t99 = load i64, ptr %t15
  %t100 = load i64, ptr %t92
  %t101 = sub i64 %t99, %t100
  br label %L44
L43:
  %t102 = load i64, ptr %t15
  %t103 = load i64, ptr %t92
  %t104 = add i64 %t102, %t103
  br label %L44
L44:
  %t105 = phi i64 [ %t101, %L42 ], [ %t104, %L43 ]
  store i64 %t105, ptr %t15
  call void @advance(ptr %t0)
  br label %L41
L41:
  br label %L38
L38:
  br label %L29
L29:
  br label %L23
L23:
  br label %L20
L20:
  br label %L17
L17:
  %t107 = load ptr, ptr %t33
  %t108 = load i64, ptr %t15
  %t109 = add i64 %t108, 1
  store i64 %t109, ptr %t15
  call void @register_enum_const(ptr %t0, ptr %t107, i64 %t108)
  %t111 = load ptr, ptr %t33
  call void @free(ptr %t111)
  br label %L14
L13:
  call void @advance(ptr %t0)
  br label %L14
L14:
  %t114 = call i32 @match(ptr %t0, i64 79)
  %t115 = sext i32 %t114 to i64
  %t117 = icmp eq i64 %t115, 0
  %t116 = zext i1 %t117 to i64
  %t118 = icmp ne i64 %t116, 0
  br i1 %t118, label %L45, label %L47
L45:
  br label %L8
L48:
  br label %L47
L47:
  br label %L6
L8:
  call void @expect(ptr %t0, i64 75)
  br label %L5
L5:
  %t120 = load ptr, ptr %t2
  ret ptr %t120
L49:
  ret ptr null
}

define internal ptr @parse_type_specifier(ptr %t0, ptr %t1, ptr %t2, ptr %t3) {
entry:
  %t4 = alloca i64
  %t5 = sext i32 0 to i64
  store i64 %t5, ptr %t4
  %t6 = alloca i64
  %t7 = sext i32 0 to i64
  store i64 %t7, ptr %t6
  %t8 = alloca i64
  %t9 = sext i32 0 to i64
  store i64 %t9, ptr %t8
  %t10 = alloca i64
  %t11 = sext i32 0 to i64
  store i64 %t11, ptr %t10
  %t12 = alloca i64
  %t13 = sext i32 0 to i64
  store i64 %t13, ptr %t12
  %t14 = alloca i64
  %t15 = sext i32 0 to i64
  store i64 %t15, ptr %t14
  %t16 = alloca i64
  %t17 = sext i32 0 to i64
  store i64 %t17, ptr %t16
  %t18 = alloca i64
  %t19 = sext i32 0 to i64
  store i64 %t19, ptr %t18
  %t20 = alloca i64
  %t21 = sext i32 0 to i64
  store i64 %t21, ptr %t20
  %t22 = alloca i64
  %t23 = sext i32 0 to i64
  store i64 %t23, ptr %t22
  %t24 = alloca i64
  %t25 = sext i32 7 to i64
  store i64 %t25, ptr %t24
  %t26 = alloca i64
  %t27 = sext i32 0 to i64
  store i64 %t27, ptr %t26
  %t28 = alloca ptr
  %t30 = sext i32 0 to i64
  %t29 = inttoptr i64 %t30 to ptr
  store ptr %t29, ptr %t28
  br label %L0
L0:
  br label %L1
L1:
  %t31 = call i32 @check(ptr %t0, i64 4)
  %t32 = sext i32 %t31 to i64
  %t33 = icmp ne i64 %t32, 0
  br i1 %t33, label %L4, label %L5
L4:
  %t34 = load ptr, ptr %t0
  %t35 = call i32 @is_gcc_extension(ptr %t34)
  %t36 = sext i32 %t35 to i64
  %t37 = icmp ne i64 %t36, 0
  %t38 = zext i1 %t37 to i64
  br label %L6
L5:
  br label %L6
L6:
  %t39 = phi i64 [ %t38, %L4 ], [ 0, %L5 ]
  %t40 = icmp ne i64 %t39, 0
  br i1 %t40, label %L7, label %L9
L7:
  call void @skip_gcc_extension(ptr %t0)
  br label %L2
L10:
  br label %L9
L9:
  %t42 = load ptr, ptr %t0
  %t43 = ptrtoint ptr %t42 to i64
  %t44 = add i64 %t43, 0
  switch i64 %t44, label %L30 [
    i64 29, label %L12
    i64 30, label %L13
    i64 31, label %L14
    i64 32, label %L15
    i64 33, label %L16
    i64 12, label %L17
    i64 13, label %L18
    i64 11, label %L19
    i64 10, label %L20
    i64 9, label %L21
    i64 6, label %L22
    i64 5, label %L23
    i64 7, label %L24
    i64 8, label %L25
    i64 26, label %L26
    i64 27, label %L27
    i64 28, label %L28
    i64 4, label %L29
  ]
L12:
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t4
  call void @advance(ptr %t0)
  br label %L11
L31:
  br label %L13
L13:
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t6
  call void @advance(ptr %t0)
  br label %L11
L32:
  br label %L14
L14:
  %t49 = sext i32 1 to i64
  store i64 %t49, ptr %t8
  call void @advance(ptr %t0)
  br label %L11
L33:
  br label %L15
L15:
  %t51 = sext i32 1 to i64
  store i64 %t51, ptr %t10
  call void @advance(ptr %t0)
  br label %L11
L34:
  br label %L16
L16:
  %t53 = sext i32 1 to i64
  store i64 %t53, ptr %t12
  call void @advance(ptr %t0)
  br label %L11
L35:
  br label %L17
L17:
  %t55 = sext i32 1 to i64
  store i64 %t55, ptr %t14
  call void @advance(ptr %t0)
  br label %L11
L36:
  br label %L18
L18:
  %t57 = sext i32 1 to i64
  store i64 %t57, ptr %t16
  call void @advance(ptr %t0)
  br label %L11
L37:
  br label %L19
L19:
  %t59 = sext i32 1 to i64
  store i64 %t59, ptr %t22
  call void @advance(ptr %t0)
  br label %L11
L38:
  br label %L20
L20:
  %t61 = load i64, ptr %t18
  %t62 = icmp ne i64 %t61, 0
  br i1 %t62, label %L39, label %L40
L39:
  %t63 = sext i32 1 to i64
  store i64 %t63, ptr %t20
  br label %L41
L40:
  %t64 = sext i32 1 to i64
  store i64 %t64, ptr %t18
  br label %L41
L41:
  call void @advance(ptr %t0)
  br label %L11
L42:
  br label %L21
L21:
  %t66 = sext i32 0 to i64
  store i64 %t66, ptr %t24
  %t67 = sext i32 1 to i64
  store i64 %t67, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L43:
  br label %L22
L22:
  %t69 = sext i32 2 to i64
  store i64 %t69, ptr %t24
  %t70 = sext i32 1 to i64
  store i64 %t70, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L44:
  br label %L23
L23:
  %t72 = sext i32 7 to i64
  store i64 %t72, ptr %t24
  %t73 = sext i32 1 to i64
  store i64 %t73, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L45:
  br label %L24
L24:
  %t75 = sext i32 13 to i64
  store i64 %t75, ptr %t24
  %t76 = sext i32 1 to i64
  store i64 %t76, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L46:
  br label %L25
L25:
  %t78 = sext i32 14 to i64
  store i64 %t78, ptr %t24
  %t79 = sext i32 1 to i64
  store i64 %t79, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L47:
  br label %L26
L26:
  br label %L27
L27:
  %t81 = call ptr @parse_struct_union(ptr %t0)
  store ptr %t81, ptr %t28
  %t82 = sext i32 1 to i64
  store i64 %t82, ptr %t26
  br label %parse_type_done
L48:
  br label %L28
L28:
  %t83 = call ptr @parse_enum_specifier(ptr %t0)
  store ptr %t83, ptr %t28
  %t84 = sext i32 1 to i64
  store i64 %t84, ptr %t26
  br label %parse_type_done
L49:
  br label %L29
L29:
  %t85 = alloca ptr
  %t86 = load ptr, ptr %t0
  %t87 = call ptr @lookup_typedef(ptr %t0, ptr %t86)
  store ptr %t87, ptr %t85
  %t88 = load ptr, ptr %t85
  %t89 = icmp ne ptr %t88, null
  br i1 %t89, label %L50, label %L52
L50:
  %t90 = call ptr @type_new(i64 21)
  store ptr %t90, ptr %t28
  %t91 = load ptr, ptr %t0
  %t92 = call ptr @strdup(ptr %t91)
  %t93 = load ptr, ptr %t28
  store ptr %t92, ptr %t93
  %t94 = sext i32 1 to i64
  store i64 %t94, ptr %t26
  call void @advance(ptr %t0)
  br label %parse_type_done
L53:
  br label %L52
L52:
  br label %parse_type_done
L54:
  br label %L11
L30:
  br label %parse_type_done
L55:
  br label %L11
L11:
  br label %L2
L2:
  br label %L0
L3:
  br label %parse_type_done
parse_type_done:
  %t96 = icmp ne ptr %t1, null
  br i1 %t96, label %L56, label %L58
L56:
  %t97 = load i64, ptr %t4
  store i64 %t97, ptr %t1
  br label %L58
L58:
  %t98 = icmp ne ptr %t2, null
  br i1 %t98, label %L59, label %L61
L59:
  %t99 = load i64, ptr %t6
  store i64 %t99, ptr %t2
  br label %L61
L61:
  %t100 = icmp ne ptr %t3, null
  br i1 %t100, label %L62, label %L64
L62:
  %t101 = load i64, ptr %t8
  store i64 %t101, ptr %t3
  br label %L64
L64:
  %t102 = load ptr, ptr %t28
  %t103 = icmp ne ptr %t102, null
  br i1 %t103, label %L65, label %L67
L65:
  %t104 = load i64, ptr %t10
  %t105 = load ptr, ptr %t28
  store i64 %t104, ptr %t105
  %t106 = load i64, ptr %t12
  %t107 = load ptr, ptr %t28
  store i64 %t106, ptr %t107
  %t108 = load ptr, ptr %t28
  ret ptr %t108
L68:
  br label %L67
L67:
  %t109 = load i64, ptr %t26
  %t111 = icmp eq i64 %t109, 0
  %t110 = zext i1 %t111 to i64
  %t112 = icmp ne i64 %t110, 0
  br i1 %t112, label %L69, label %L70
L69:
  %t113 = load i64, ptr %t18
  %t115 = icmp eq i64 %t113, 0
  %t114 = zext i1 %t115 to i64
  %t116 = icmp ne i64 %t114, 0
  %t117 = zext i1 %t116 to i64
  br label %L71
L70:
  br label %L71
L71:
  %t118 = phi i64 [ %t117, %L69 ], [ 0, %L70 ]
  %t119 = icmp ne i64 %t118, 0
  br i1 %t119, label %L72, label %L73
L72:
  %t120 = load i64, ptr %t22
  %t122 = icmp eq i64 %t120, 0
  %t121 = zext i1 %t122 to i64
  %t123 = icmp ne i64 %t121, 0
  %t124 = zext i1 %t123 to i64
  br label %L74
L73:
  br label %L74
L74:
  %t125 = phi i64 [ %t124, %L72 ], [ 0, %L73 ]
  %t126 = icmp ne i64 %t125, 0
  br i1 %t126, label %L75, label %L76
L75:
  %t127 = load i64, ptr %t14
  %t129 = icmp eq i64 %t127, 0
  %t128 = zext i1 %t129 to i64
  %t130 = icmp ne i64 %t128, 0
  %t131 = zext i1 %t130 to i64
  br label %L77
L76:
  br label %L77
L77:
  %t132 = phi i64 [ %t131, %L75 ], [ 0, %L76 ]
  %t133 = icmp ne i64 %t132, 0
  br i1 %t133, label %L78, label %L79
L78:
  %t134 = load i64, ptr %t16
  %t136 = icmp eq i64 %t134, 0
  %t135 = zext i1 %t136 to i64
  %t137 = icmp ne i64 %t135, 0
  %t138 = zext i1 %t137 to i64
  br label %L80
L79:
  br label %L80
L80:
  %t139 = phi i64 [ %t138, %L78 ], [ 0, %L79 ]
  %t140 = icmp ne i64 %t139, 0
  br i1 %t140, label %L81, label %L83
L81:
  %t142 = sext i32 0 to i64
  %t141 = inttoptr i64 %t142 to ptr
  ret ptr %t141
L84:
  br label %L83
L83:
  %t143 = load i64, ptr %t24
  %t145 = sext i32 2 to i64
  %t144 = icmp eq i64 %t143, %t145
  %t146 = zext i1 %t144 to i64
  %t147 = icmp ne i64 %t146, 0
  br i1 %t147, label %L85, label %L86
L85:
  %t148 = load i64, ptr %t14
  %t149 = icmp ne i64 %t148, 0
  br i1 %t149, label %L88, label %L89
L88:
  %t150 = sext i32 4 to i64
  store i64 %t150, ptr %t24
  br label %L90
L89:
  %t151 = load i64, ptr %t16
  %t152 = icmp ne i64 %t151, 0
  br i1 %t152, label %L91, label %L93
L91:
  %t153 = sext i32 3 to i64
  store i64 %t153, ptr %t24
  br label %L93
L93:
  br label %L90
L90:
  br label %L87
L86:
  %t154 = load i64, ptr %t20
  %t155 = icmp ne i64 %t154, 0
  br i1 %t155, label %L94, label %L95
L94:
  %t156 = load i64, ptr %t14
  %t157 = icmp ne i64 %t156, 0
  br i1 %t157, label %L97, label %L98
L97:
  %t158 = sext i32 12 to i64
  br label %L99
L98:
  %t159 = sext i32 11 to i64
  br label %L99
L99:
  %t160 = phi i64 [ %t158, %L97 ], [ %t159, %L98 ]
  store i64 %t160, ptr %t24
  br label %L96
L95:
  %t161 = load i64, ptr %t18
  %t162 = icmp ne i64 %t161, 0
  br i1 %t162, label %L100, label %L101
L100:
  %t163 = load i64, ptr %t14
  %t164 = icmp ne i64 %t163, 0
  br i1 %t164, label %L103, label %L104
L103:
  %t165 = sext i32 10 to i64
  br label %L105
L104:
  %t166 = sext i32 9 to i64
  br label %L105
L105:
  %t167 = phi i64 [ %t165, %L103 ], [ %t166, %L104 ]
  store i64 %t167, ptr %t24
  br label %L102
L101:
  %t168 = load i64, ptr %t22
  %t169 = icmp ne i64 %t168, 0
  br i1 %t169, label %L106, label %L107
L106:
  %t170 = load i64, ptr %t14
  %t171 = icmp ne i64 %t170, 0
  br i1 %t171, label %L109, label %L110
L109:
  %t172 = sext i32 6 to i64
  br label %L111
L110:
  %t173 = sext i32 5 to i64
  br label %L111
L111:
  %t174 = phi i64 [ %t172, %L109 ], [ %t173, %L110 ]
  store i64 %t174, ptr %t24
  br label %L108
L107:
  %t175 = load i64, ptr %t24
  %t177 = sext i32 7 to i64
  %t176 = icmp eq i64 %t175, %t177
  %t178 = zext i1 %t176 to i64
  %t179 = icmp ne i64 %t178, 0
  br i1 %t179, label %L112, label %L113
L112:
  br label %L114
L113:
  %t180 = load i64, ptr %t26
  %t182 = icmp eq i64 %t180, 0
  %t181 = zext i1 %t182 to i64
  %t183 = icmp ne i64 %t181, 0
  %t184 = zext i1 %t183 to i64
  br label %L114
L114:
  %t185 = phi i64 [ 1, %L112 ], [ %t184, %L113 ]
  %t186 = icmp ne i64 %t185, 0
  br i1 %t186, label %L115, label %L117
L115:
  %t187 = load i64, ptr %t14
  %t188 = icmp ne i64 %t187, 0
  br i1 %t188, label %L118, label %L120
L118:
  %t189 = sext i32 8 to i64
  store i64 %t189, ptr %t24
  br label %L120
L120:
  br label %L117
L117:
  br label %L108
L108:
  br label %L102
L102:
  br label %L96
L96:
  br label %L87
L87:
  %t190 = alloca ptr
  %t191 = load i64, ptr %t24
  %t192 = call ptr @type_new(i64 %t191)
  store ptr %t192, ptr %t190
  %t193 = load i64, ptr %t10
  %t194 = load ptr, ptr %t190
  store i64 %t193, ptr %t194
  %t195 = load i64, ptr %t12
  %t196 = load ptr, ptr %t190
  store i64 %t195, ptr %t196
  %t197 = load ptr, ptr %t190
  ret ptr %t197
L121:
  ret ptr null
}

define internal ptr @parse_declarator(ptr %t0, ptr %t1, ptr %t2) {
entry:
  %t3 = alloca i64
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  %t5 = alloca ptr
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  br label %L0
L0:
  %t7 = call i32 @check(ptr %t0, i64 37)
  %t8 = sext i32 %t7 to i64
  %t9 = icmp ne i64 %t8, 0
  br i1 %t9, label %L3, label %L4
L3:
  %t10 = load i64, ptr %t3
  %t12 = sext i32 16 to i64
  %t11 = icmp slt i64 %t10, %t12
  %t13 = zext i1 %t11 to i64
  %t14 = icmp ne i64 %t13, 0
  %t15 = zext i1 %t14 to i64
  br label %L5
L4:
  br label %L5
L5:
  %t16 = phi i64 [ %t15, %L3 ], [ 0, %L4 ]
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L1, label %L2
L1:
  call void @advance(ptr %t0)
  %t19 = load ptr, ptr %t5
  %t20 = load i64, ptr %t3
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = sext i32 0 to i64
  store i64 %t22, ptr %t21
  br label %L6
L6:
  %t23 = call i32 @check(ptr %t0, i64 32)
  %t24 = sext i32 %t23 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L9, label %L10
L9:
  br label %L11
L10:
  %t26 = call i32 @check(ptr %t0, i64 33)
  %t27 = sext i32 %t26 to i64
  %t28 = icmp ne i64 %t27, 0
  %t29 = zext i1 %t28 to i64
  br label %L11
L11:
  %t30 = phi i64 [ 1, %L9 ], [ %t29, %L10 ]
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L7, label %L8
L7:
  %t32 = call i32 @check(ptr %t0, i64 32)
  %t33 = sext i32 %t32 to i64
  %t34 = icmp ne i64 %t33, 0
  br i1 %t34, label %L12, label %L14
L12:
  %t35 = load ptr, ptr %t5
  %t36 = load i64, ptr %t3
  %t37 = getelementptr ptr, ptr %t35, i64 %t36
  %t38 = sext i32 1 to i64
  store i64 %t38, ptr %t37
  br label %L14
L14:
  call void @advance(ptr %t0)
  br label %L6
L8:
  %t40 = load i64, ptr %t3
  %t41 = add i64 %t40, 1
  store i64 %t41, ptr %t3
  br label %L0
L2:
  %t42 = alloca i64
  %t43 = load i64, ptr %t3
  %t45 = sext i32 1 to i64
  %t44 = sub i64 %t43, %t45
  store i64 %t44, ptr %t42
  br label %L15
L15:
  %t46 = load i64, ptr %t42
  %t48 = sext i32 0 to i64
  %t47 = icmp sge i64 %t46, %t48
  %t49 = zext i1 %t47 to i64
  %t50 = icmp ne i64 %t49, 0
  br i1 %t50, label %L16, label %L18
L16:
  %t51 = alloca ptr
  %t52 = call ptr @type_ptr(ptr %t1)
  store ptr %t52, ptr %t51
  %t53 = load ptr, ptr %t5
  %t54 = load i64, ptr %t42
  %t55 = getelementptr ptr, ptr %t53, i64 %t54
  %t56 = load ptr, ptr %t55
  %t57 = load ptr, ptr %t51
  store ptr %t56, ptr %t57
  %t58 = load ptr, ptr %t51
  store ptr %t58, ptr %t1
  br label %L17
L17:
  %t59 = load i64, ptr %t42
  %t60 = sub i64 %t59, 1
  store i64 %t60, ptr %t42
  br label %L15
L18:
  %t61 = icmp ne ptr %t2, null
  br i1 %t61, label %L19, label %L21
L19:
  %t63 = sext i32 0 to i64
  %t62 = inttoptr i64 %t63 to ptr
  store ptr %t62, ptr %t2
  br label %L21
L21:
  call void @skip_gcc_extension(ptr %t0)
  %t65 = call i32 @check(ptr %t0, i64 4)
  %t66 = sext i32 %t65 to i64
  %t67 = icmp ne i64 %t66, 0
  br i1 %t67, label %L22, label %L23
L22:
  %t68 = load ptr, ptr %t0
  %t69 = call i32 @is_gcc_extension(ptr %t68)
  %t70 = sext i32 %t69 to i64
  %t72 = icmp eq i64 %t70, 0
  %t71 = zext i1 %t72 to i64
  %t73 = icmp ne i64 %t71, 0
  %t74 = zext i1 %t73 to i64
  br label %L24
L23:
  br label %L24
L24:
  %t75 = phi i64 [ %t74, %L22 ], [ 0, %L23 ]
  %t76 = icmp ne i64 %t75, 0
  br i1 %t76, label %L25, label %L26
L25:
  %t77 = icmp ne ptr %t2, null
  br i1 %t77, label %L28, label %L30
L28:
  %t78 = load ptr, ptr %t0
  %t79 = call ptr @strdup(ptr %t78)
  store ptr %t79, ptr %t2
  br label %L30
L30:
  call void @advance(ptr %t0)
  br label %L27
L26:
  %t81 = call i32 @check(ptr %t0, i64 72)
  %t82 = sext i32 %t81 to i64
  %t83 = icmp ne i64 %t82, 0
  br i1 %t83, label %L31, label %L33
L31:
  call void @advance(ptr %t0)
  %t85 = call ptr @parse_declarator(ptr %t0, ptr %t1, ptr %t2)
  store ptr %t85, ptr %t1
  call void @expect(ptr %t0, i64 73)
  br label %L33
L33:
  br label %L27
L27:
  call void @skip_gcc_extension(ptr %t0)
  br label %L34
L34:
  br label %L35
L35:
  %t88 = call i32 @check(ptr %t0, i64 4)
  %t89 = sext i32 %t88 to i64
  %t90 = icmp ne i64 %t89, 0
  br i1 %t90, label %L38, label %L39
L38:
  %t91 = load ptr, ptr %t0
  %t92 = call i32 @is_gcc_extension(ptr %t91)
  %t93 = sext i32 %t92 to i64
  %t94 = icmp ne i64 %t93, 0
  %t95 = zext i1 %t94 to i64
  br label %L40
L39:
  br label %L40
L40:
  %t96 = phi i64 [ %t95, %L38 ], [ 0, %L39 ]
  %t97 = icmp ne i64 %t96, 0
  br i1 %t97, label %L41, label %L43
L41:
  call void @skip_gcc_extension(ptr %t0)
  br label %L36
L44:
  br label %L43
L43:
  %t99 = call i32 @check(ptr %t0, i64 76)
  %t100 = sext i32 %t99 to i64
  %t101 = icmp ne i64 %t100, 0
  br i1 %t101, label %L45, label %L46
L45:
  call void @advance(ptr %t0)
  %t103 = alloca i64
  %t105 = sext i32 1 to i64
  %t104 = sub i64 0, %t105
  store i64 %t104, ptr %t103
  %t106 = call i32 @check(ptr %t0, i64 77)
  %t107 = sext i32 %t106 to i64
  %t109 = icmp eq i64 %t107, 0
  %t108 = zext i1 %t109 to i64
  %t110 = icmp ne i64 %t108, 0
  br i1 %t110, label %L48, label %L50
L48:
  %t111 = call i32 @check(ptr %t0, i64 0)
  %t112 = sext i32 %t111 to i64
  %t113 = icmp ne i64 %t112, 0
  br i1 %t113, label %L51, label %L52
L51:
  %t114 = load ptr, ptr %t0
  %t115 = call i64 @atol(ptr %t114)
  %t116 = add i64 %t115, 0
  store i64 %t116, ptr %t103
  call void @advance(ptr %t0)
  br label %L53
L52:
  %t118 = alloca i64
  %t119 = sext i32 0 to i64
  store i64 %t119, ptr %t118
  br label %L54
L54:
  %t120 = call i32 @check(ptr %t0, i64 81)
  %t121 = sext i32 %t120 to i64
  %t123 = icmp eq i64 %t121, 0
  %t122 = zext i1 %t123 to i64
  %t124 = icmp ne i64 %t122, 0
  br i1 %t124, label %L55, label %L56
L55:
  %t125 = call i32 @check(ptr %t0, i64 76)
  %t126 = sext i32 %t125 to i64
  %t127 = icmp ne i64 %t126, 0
  br i1 %t127, label %L57, label %L59
L57:
  %t128 = load i64, ptr %t118
  %t129 = add i64 %t128, 1
  store i64 %t129, ptr %t118
  br label %L59
L59:
  %t130 = call i32 @check(ptr %t0, i64 77)
  %t131 = sext i32 %t130 to i64
  %t132 = icmp ne i64 %t131, 0
  br i1 %t132, label %L60, label %L62
L60:
  %t133 = load i64, ptr %t118
  %t135 = sext i32 0 to i64
  %t134 = icmp eq i64 %t133, %t135
  %t136 = zext i1 %t134 to i64
  %t137 = icmp ne i64 %t136, 0
  br i1 %t137, label %L63, label %L65
L63:
  br label %L56
L66:
  br label %L65
L65:
  %t138 = load i64, ptr %t118
  %t139 = sub i64 %t138, 1
  store i64 %t139, ptr %t118
  br label %L62
L62:
  call void @advance(ptr %t0)
  br label %L54
L56:
  br label %L53
L53:
  br label %L50
L50:
  call void @expect(ptr %t0, i64 77)
  %t142 = load i64, ptr %t103
  %t143 = call ptr @type_array(ptr %t1, i64 %t142)
  store ptr %t143, ptr %t1
  br label %L47
L46:
  %t144 = call i32 @check(ptr %t0, i64 72)
  %t145 = sext i32 %t144 to i64
  %t146 = icmp ne i64 %t145, 0
  br i1 %t146, label %L67, label %L68
L67:
  call void @advance(ptr %t0)
  %t148 = alloca ptr
  %t149 = call ptr @type_new(i64 17)
  store ptr %t149, ptr %t148
  %t150 = load ptr, ptr %t148
  store ptr %t1, ptr %t150
  %t151 = alloca ptr
  %t153 = sext i32 0 to i64
  %t152 = inttoptr i64 %t153 to ptr
  store ptr %t152, ptr %t151
  %t154 = alloca i64
  %t155 = sext i32 0 to i64
  store i64 %t155, ptr %t154
  %t156 = alloca i64
  %t157 = sext i32 0 to i64
  store i64 %t157, ptr %t156
  br label %L70
L70:
  %t158 = call i32 @check(ptr %t0, i64 73)
  %t159 = sext i32 %t158 to i64
  %t161 = icmp eq i64 %t159, 0
  %t160 = zext i1 %t161 to i64
  %t162 = icmp ne i64 %t160, 0
  br i1 %t162, label %L73, label %L74
L73:
  %t163 = call i32 @check(ptr %t0, i64 81)
  %t164 = sext i32 %t163 to i64
  %t166 = icmp eq i64 %t164, 0
  %t165 = zext i1 %t166 to i64
  %t167 = icmp ne i64 %t165, 0
  %t168 = zext i1 %t167 to i64
  br label %L75
L74:
  br label %L75
L75:
  %t169 = phi i64 [ %t168, %L73 ], [ 0, %L74 ]
  %t170 = icmp ne i64 %t169, 0
  br i1 %t170, label %L71, label %L72
L71:
  %t171 = call i32 @check(ptr %t0, i64 80)
  %t172 = sext i32 %t171 to i64
  %t173 = icmp ne i64 %t172, 0
  br i1 %t173, label %L76, label %L78
L76:
  %t174 = sext i32 1 to i64
  store i64 %t174, ptr %t156
  call void @advance(ptr %t0)
  br label %L72
L79:
  br label %L78
L78:
  %t176 = alloca i64
  %t177 = sext i32 0 to i64
  store i64 %t177, ptr %t176
  %t178 = alloca i64
  %t179 = sext i32 0 to i64
  store i64 %t179, ptr %t178
  %t180 = alloca i64
  %t181 = sext i32 0 to i64
  store i64 %t181, ptr %t180
  %t182 = alloca ptr
  %t183 = call ptr @parse_type_specifier(ptr %t0, ptr %t176, ptr %t178, ptr %t180)
  store ptr %t183, ptr %t182
  %t184 = load ptr, ptr %t182
  %t186 = ptrtoint ptr %t184 to i64
  %t187 = icmp eq i64 %t186, 0
  %t185 = zext i1 %t187 to i64
  %t188 = icmp ne i64 %t185, 0
  br i1 %t188, label %L80, label %L82
L80:
  br label %L72
L83:
  br label %L82
L82:
  %t189 = alloca ptr
  %t191 = sext i32 0 to i64
  %t190 = inttoptr i64 %t191 to ptr
  store ptr %t190, ptr %t189
  %t192 = load ptr, ptr %t182
  %t193 = call ptr @parse_declarator(ptr %t0, ptr %t192, ptr %t189)
  store ptr %t193, ptr %t182
  %t194 = load ptr, ptr %t151
  %t195 = load i64, ptr %t154
  %t197 = sext i32 1 to i64
  %t196 = add i64 %t195, %t197
  %t199 = sext i32 0 to i64
  %t198 = mul i64 %t196, %t199
  %t200 = call ptr @realloc(ptr %t194, i64 %t198)
  store ptr %t200, ptr %t151
  %t201 = load ptr, ptr %t151
  %t203 = ptrtoint ptr %t201 to i64
  %t204 = icmp eq i64 %t203, 0
  %t202 = zext i1 %t204 to i64
  %t205 = icmp ne i64 %t202, 0
  br i1 %t205, label %L84, label %L86
L84:
  %t206 = getelementptr [8 x i8], ptr @.str31, i64 0, i64 0
  call void @perror(ptr %t206)
  call void @exit(i64 1)
  br label %L86
L86:
  %t209 = load ptr, ptr %t189
  %t210 = load ptr, ptr %t151
  %t211 = load i64, ptr %t154
  %t212 = getelementptr ptr, ptr %t210, i64 %t211
  store ptr %t209, ptr %t212
  %t213 = load ptr, ptr %t182
  %t214 = load ptr, ptr %t151
  %t215 = load i64, ptr %t154
  %t216 = getelementptr ptr, ptr %t214, i64 %t215
  store ptr %t213, ptr %t216
  %t217 = load i64, ptr %t154
  %t218 = add i64 %t217, 1
  store i64 %t218, ptr %t154
  %t219 = call i32 @match(ptr %t0, i64 79)
  %t220 = sext i32 %t219 to i64
  %t222 = icmp eq i64 %t220, 0
  %t221 = zext i1 %t222 to i64
  %t223 = icmp ne i64 %t221, 0
  br i1 %t223, label %L87, label %L89
L87:
  br label %L72
L90:
  br label %L89
L89:
  br label %L70
L72:
  call void @expect(ptr %t0, i64 73)
  %t225 = load ptr, ptr %t151
  %t226 = load ptr, ptr %t148
  store ptr %t225, ptr %t226
  %t227 = load i64, ptr %t154
  %t228 = load ptr, ptr %t148
  store i64 %t227, ptr %t228
  %t229 = load i64, ptr %t156
  %t230 = load ptr, ptr %t148
  store i64 %t229, ptr %t230
  %t231 = load ptr, ptr %t148
  store ptr %t231, ptr %t1
  br label %L69
L68:
  br label %L37
L91:
  br label %L69
L69:
  br label %L47
L47:
  br label %L36
L36:
  br label %L34
L37:
  ret ptr %t1
L92:
  ret ptr null
}

define internal ptr @parse_primary(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  store ptr %t2, ptr %t1
  %t3 = call i32 @check(ptr %t0, i64 0)
  %t4 = sext i32 %t3 to i64
  %t5 = icmp ne i64 %t4, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = alloca ptr
  %t7 = load i64, ptr %t1
  %t8 = call ptr @node_new(i64 19, i64 %t7)
  store ptr %t8, ptr %t6
  %t9 = load ptr, ptr %t0
  %t11 = sext i32 0 to i64
  %t10 = inttoptr i64 %t11 to ptr
  %t12 = call i64 @strtoll(ptr %t9, ptr %t10, i64 0)
  %t13 = add i64 %t12, 0
  %t14 = load ptr, ptr %t6
  store i64 %t13, ptr %t14
  call void @advance(ptr %t0)
  %t16 = load ptr, ptr %t6
  ret ptr %t16
L3:
  br label %L2
L2:
  %t17 = call i32 @check(ptr %t0, i64 1)
  %t18 = sext i32 %t17 to i64
  %t19 = icmp ne i64 %t18, 0
  br i1 %t19, label %L4, label %L6
L4:
  %t20 = alloca ptr
  %t21 = load i64, ptr %t1
  %t22 = call ptr @node_new(i64 20, i64 %t21)
  store ptr %t22, ptr %t20
  %t23 = load ptr, ptr %t0
  %t24 = call i32 @atof(ptr %t23)
  %t25 = sext i32 %t24 to i64
  %t26 = load ptr, ptr %t20
  store i64 %t25, ptr %t26
  call void @advance(ptr %t0)
  %t28 = load ptr, ptr %t20
  ret ptr %t28
L7:
  br label %L6
L6:
  %t29 = call i32 @check(ptr %t0, i64 2)
  %t30 = sext i32 %t29 to i64
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L8, label %L10
L8:
  %t32 = alloca ptr
  %t33 = load i64, ptr %t1
  %t34 = call ptr @node_new(i64 21, i64 %t33)
  store ptr %t34, ptr %t32
  %t35 = alloca ptr
  %t36 = load ptr, ptr %t0
  store ptr %t36, ptr %t35
  %t37 = load ptr, ptr %t35
  %t38 = sext i32 0 to i64
  %t39 = getelementptr ptr, ptr %t37, i64 %t38
  %t40 = load ptr, ptr %t39
  %t42 = ptrtoint ptr %t40 to i64
  %t43 = sext i32 39 to i64
  %t41 = icmp eq i64 %t42, %t43
  %t44 = zext i1 %t41 to i64
  %t45 = icmp ne i64 %t44, 0
  br i1 %t45, label %L11, label %L12
L11:
  %t46 = load ptr, ptr %t35
  %t47 = sext i32 1 to i64
  %t48 = getelementptr ptr, ptr %t46, i64 %t47
  %t49 = load ptr, ptr %t48
  %t51 = ptrtoint ptr %t49 to i64
  %t52 = sext i32 92 to i64
  %t50 = icmp eq i64 %t51, %t52
  %t53 = zext i1 %t50 to i64
  %t54 = icmp ne i64 %t53, 0
  %t55 = zext i1 %t54 to i64
  br label %L13
L12:
  br label %L13
L13:
  %t56 = phi i64 [ %t55, %L11 ], [ 0, %L12 ]
  %t57 = icmp ne i64 %t56, 0
  br i1 %t57, label %L14, label %L15
L14:
  %t58 = load ptr, ptr %t35
  %t59 = sext i32 2 to i64
  %t60 = getelementptr ptr, ptr %t58, i64 %t59
  %t61 = load ptr, ptr %t60
  %t62 = ptrtoint ptr %t61 to i64
  %t63 = add i64 %t62, 0
  switch i64 %t63, label %L22 [
    i64 110, label %L18
    i64 116, label %L19
    i64 114, label %L20
    i64 48, label %L21
  ]
L18:
  %t64 = load ptr, ptr %t32
  %t65 = sext i32 10 to i64
  store i64 %t65, ptr %t64
  br label %L17
L23:
  br label %L19
L19:
  %t66 = load ptr, ptr %t32
  %t67 = sext i32 9 to i64
  store i64 %t67, ptr %t66
  br label %L17
L24:
  br label %L20
L20:
  %t68 = load ptr, ptr %t32
  %t69 = sext i32 13 to i64
  store i64 %t69, ptr %t68
  br label %L17
L25:
  br label %L21
L21:
  %t70 = load ptr, ptr %t32
  %t71 = sext i32 0 to i64
  store i64 %t71, ptr %t70
  br label %L17
L26:
  br label %L17
L22:
  %t72 = load ptr, ptr %t35
  %t73 = sext i32 2 to i64
  %t74 = getelementptr ptr, ptr %t72, i64 %t73
  %t75 = load ptr, ptr %t74
  %t76 = load ptr, ptr %t32
  store ptr %t75, ptr %t76
  br label %L17
L27:
  br label %L17
L17:
  br label %L16
L15:
  %t77 = load ptr, ptr %t35
  %t78 = sext i32 1 to i64
  %t79 = getelementptr ptr, ptr %t77, i64 %t78
  %t80 = load ptr, ptr %t79
  %t81 = ptrtoint ptr %t80 to i64
  %t82 = load ptr, ptr %t32
  store i64 %t81, ptr %t82
  br label %L16
L16:
  call void @advance(ptr %t0)
  %t84 = load ptr, ptr %t32
  ret ptr %t84
L28:
  br label %L10
L10:
  %t85 = call i32 @check(ptr %t0, i64 3)
  %t86 = sext i32 %t85 to i64
  %t87 = icmp ne i64 %t86, 0
  br i1 %t87, label %L29, label %L31
L29:
  %t88 = alloca ptr
  %t89 = load i64, ptr %t1
  %t90 = call ptr @node_new(i64 22, i64 %t89)
  store ptr %t90, ptr %t88
  %t91 = alloca i64
  %t92 = load ptr, ptr %t0
  %t93 = call i64 @strlen(ptr %t92)
  store i64 %t93, ptr %t91
  %t94 = alloca ptr
  %t95 = load i64, ptr %t91
  %t97 = sext i32 1 to i64
  %t96 = add i64 %t95, %t97
  %t98 = call ptr @malloc(i64 %t96)
  store ptr %t98, ptr %t94
  %t99 = load ptr, ptr %t94
  %t100 = load ptr, ptr %t0
  %t101 = load i64, ptr %t91
  %t103 = sext i32 1 to i64
  %t102 = sub i64 %t101, %t103
  %t104 = call ptr @memcpy(ptr %t99, ptr %t100, i64 %t102)
  %t105 = load ptr, ptr %t94
  %t106 = load i64, ptr %t91
  %t108 = sext i32 1 to i64
  %t107 = sub i64 %t106, %t108
  %t109 = getelementptr ptr, ptr %t105, i64 %t107
  %t110 = sext i32 0 to i64
  store i64 %t110, ptr %t109
  call void @advance(ptr %t0)
  br label %L32
L32:
  %t112 = call i32 @check(ptr %t0, i64 3)
  %t113 = sext i32 %t112 to i64
  %t114 = icmp ne i64 %t113, 0
  br i1 %t114, label %L33, label %L34
L33:
  %t115 = alloca ptr
  %t116 = load ptr, ptr %t0
  %t118 = ptrtoint ptr %t116 to i64
  %t119 = sext i32 1 to i64
  %t120 = inttoptr i64 %t118 to ptr
  %t117 = getelementptr i8, ptr %t120, i64 %t119
  store ptr %t117, ptr %t115
  %t121 = alloca i64
  %t122 = load ptr, ptr %t115
  %t123 = call i64 @strlen(ptr %t122)
  store i64 %t123, ptr %t121
  %t124 = alloca i64
  %t125 = load ptr, ptr %t94
  %t126 = call i64 @strlen(ptr %t125)
  store i64 %t126, ptr %t124
  %t127 = load ptr, ptr %t94
  %t128 = load i64, ptr %t124
  %t129 = load i64, ptr %t121
  %t130 = add i64 %t128, %t129
  %t132 = sext i32 1 to i64
  %t131 = add i64 %t130, %t132
  %t133 = call ptr @realloc(ptr %t127, i64 %t131)
  store ptr %t133, ptr %t94
  %t134 = load ptr, ptr %t94
  %t135 = load i64, ptr %t124
  %t137 = ptrtoint ptr %t134 to i64
  %t138 = inttoptr i64 %t137 to ptr
  %t136 = getelementptr i8, ptr %t138, i64 %t135
  %t139 = load ptr, ptr %t115
  %t140 = load i64, ptr %t121
  %t141 = call ptr @memcpy(ptr %t136, ptr %t139, i64 %t140)
  %t142 = load ptr, ptr %t94
  %t143 = load i64, ptr %t124
  %t144 = load i64, ptr %t121
  %t145 = add i64 %t143, %t144
  %t146 = getelementptr ptr, ptr %t142, i64 %t145
  %t147 = sext i32 0 to i64
  store i64 %t147, ptr %t146
  call void @advance(ptr %t0)
  br label %L32
L34:
  %t149 = alloca i64
  %t150 = load ptr, ptr %t94
  %t151 = call i64 @strlen(ptr %t150)
  store i64 %t151, ptr %t149
  %t152 = load ptr, ptr %t94
  %t153 = load i64, ptr %t149
  %t155 = sext i32 2 to i64
  %t154 = add i64 %t153, %t155
  %t156 = call ptr @realloc(ptr %t152, i64 %t154)
  store ptr %t156, ptr %t94
  %t157 = load ptr, ptr %t94
  %t158 = load i64, ptr %t149
  %t159 = getelementptr ptr, ptr %t157, i64 %t158
  %t160 = sext i32 34 to i64
  store i64 %t160, ptr %t159
  %t161 = load ptr, ptr %t94
  %t162 = load i64, ptr %t149
  %t164 = sext i32 1 to i64
  %t163 = add i64 %t162, %t164
  %t165 = getelementptr ptr, ptr %t161, i64 %t163
  %t166 = sext i32 0 to i64
  store i64 %t166, ptr %t165
  %t167 = load ptr, ptr %t94
  %t168 = load ptr, ptr %t88
  store ptr %t167, ptr %t168
  %t169 = load ptr, ptr %t88
  ret ptr %t169
L35:
  br label %L31
L31:
  %t170 = call i32 @check(ptr %t0, i64 4)
  %t171 = sext i32 %t170 to i64
  %t172 = icmp ne i64 %t171, 0
  br i1 %t172, label %L36, label %L38
L36:
  %t173 = alloca i64
  %t174 = load ptr, ptr %t0
  %t175 = call i32 @lookup_enum_const(ptr %t0, ptr %t174, ptr %t173)
  %t176 = sext i32 %t175 to i64
  %t177 = icmp ne i64 %t176, 0
  br i1 %t177, label %L39, label %L41
L39:
  %t178 = alloca ptr
  %t179 = load i64, ptr %t1
  %t180 = call ptr @node_new(i64 19, i64 %t179)
  store ptr %t180, ptr %t178
  %t181 = load i64, ptr %t173
  %t182 = load ptr, ptr %t178
  store i64 %t181, ptr %t182
  call void @advance(ptr %t0)
  %t184 = load ptr, ptr %t178
  ret ptr %t184
L42:
  br label %L41
L41:
  %t185 = alloca ptr
  %t186 = load i64, ptr %t1
  %t187 = call ptr @node_new(i64 23, i64 %t186)
  store ptr %t187, ptr %t185
  %t188 = load ptr, ptr %t0
  %t189 = call ptr @strdup(ptr %t188)
  %t190 = load ptr, ptr %t185
  store ptr %t189, ptr %t190
  call void @advance(ptr %t0)
  %t192 = load ptr, ptr %t185
  ret ptr %t192
L43:
  br label %L38
L38:
  %t193 = call i32 @match(ptr %t0, i64 72)
  %t194 = sext i32 %t193 to i64
  %t195 = icmp ne i64 %t194, 0
  br i1 %t195, label %L44, label %L46
L44:
  %t196 = call i32 @is_type_start(ptr %t0)
  %t197 = sext i32 %t196 to i64
  %t198 = icmp ne i64 %t197, 0
  br i1 %t198, label %L47, label %L49
L47:
  %t199 = alloca i64
  %t200 = sext i32 0 to i64
  store i64 %t200, ptr %t199
  %t201 = alloca i64
  %t202 = sext i32 0 to i64
  store i64 %t202, ptr %t201
  %t203 = alloca i64
  %t204 = sext i32 0 to i64
  store i64 %t204, ptr %t203
  %t205 = alloca ptr
  %t206 = call ptr @parse_type_specifier(ptr %t0, ptr %t199, ptr %t201, ptr %t203)
  store ptr %t206, ptr %t205
  %t207 = load ptr, ptr %t205
  %t208 = icmp ne ptr %t207, null
  br i1 %t208, label %L50, label %L52
L50:
  %t209 = alloca ptr
  %t211 = sext i32 0 to i64
  %t210 = inttoptr i64 %t211 to ptr
  store ptr %t210, ptr %t209
  %t212 = load ptr, ptr %t205
  %t213 = call ptr @parse_declarator(ptr %t0, ptr %t212, ptr %t209)
  store ptr %t213, ptr %t205
  %t214 = load ptr, ptr %t209
  call void @free(ptr %t214)
  %t216 = call i32 @match(ptr %t0, i64 73)
  %t217 = sext i32 %t216 to i64
  %t218 = icmp ne i64 %t217, 0
  br i1 %t218, label %L53, label %L55
L53:
  %t219 = alloca ptr
  %t220 = load i64, ptr %t1
  %t221 = call ptr @node_new(i64 29, i64 %t220)
  store ptr %t221, ptr %t219
  %t222 = load ptr, ptr %t205
  %t223 = load ptr, ptr %t219
  store ptr %t222, ptr %t223
  %t224 = call ptr @parse_cast(ptr %t0)
  %t225 = load ptr, ptr %t219
  store ptr %t224, ptr %t225
  %t226 = load ptr, ptr %t219
  ret ptr %t226
L56:
  br label %L55
L55:
  br label %L52
L52:
  br label %L49
L49:
  %t227 = alloca ptr
  %t228 = call ptr @parse_expr(ptr %t0)
  store ptr %t228, ptr %t227
  call void @expect(ptr %t0, i64 73)
  %t230 = load ptr, ptr %t227
  ret ptr %t230
L57:
  br label %L46
L46:
  %t231 = call i32 @check(ptr %t0, i64 34)
  %t232 = sext i32 %t231 to i64
  %t233 = icmp ne i64 %t232, 0
  br i1 %t233, label %L58, label %L60
L58:
  call void @advance(ptr %t0)
  %t235 = call i32 @match(ptr %t0, i64 72)
  %t236 = sext i32 %t235 to i64
  %t237 = icmp ne i64 %t236, 0
  br i1 %t237, label %L61, label %L63
L61:
  %t238 = call i32 @is_type_start(ptr %t0)
  %t239 = sext i32 %t238 to i64
  %t240 = icmp ne i64 %t239, 0
  br i1 %t240, label %L64, label %L66
L64:
  %t241 = alloca i64
  %t242 = sext i32 0 to i64
  store i64 %t242, ptr %t241
  %t243 = alloca i64
  %t244 = sext i32 0 to i64
  store i64 %t244, ptr %t243
  %t245 = alloca i64
  %t246 = sext i32 0 to i64
  store i64 %t246, ptr %t245
  %t247 = alloca ptr
  %t248 = call ptr @parse_type_specifier(ptr %t0, ptr %t241, ptr %t243, ptr %t245)
  store ptr %t248, ptr %t247
  %t249 = alloca ptr
  %t251 = sext i32 0 to i64
  %t250 = inttoptr i64 %t251 to ptr
  store ptr %t250, ptr %t249
  %t252 = load ptr, ptr %t247
  %t253 = call ptr @parse_declarator(ptr %t0, ptr %t252, ptr %t249)
  store ptr %t253, ptr %t247
  %t254 = load ptr, ptr %t249
  call void @free(ptr %t254)
  call void @expect(ptr %t0, i64 73)
  %t257 = alloca ptr
  %t258 = load i64, ptr %t1
  %t259 = call ptr @node_new(i64 31, i64 %t258)
  store ptr %t259, ptr %t257
  %t260 = load ptr, ptr %t247
  %t261 = load ptr, ptr %t257
  store ptr %t260, ptr %t261
  %t262 = load ptr, ptr %t257
  ret ptr %t262
L67:
  br label %L66
L66:
  %t263 = alloca ptr
  %t264 = call ptr @parse_expr(ptr %t0)
  store ptr %t264, ptr %t263
  call void @expect(ptr %t0, i64 73)
  %t266 = alloca ptr
  %t267 = load i64, ptr %t1
  %t268 = call ptr @node_new(i64 32, i64 %t267)
  store ptr %t268, ptr %t266
  %t269 = load ptr, ptr %t266
  %t270 = load ptr, ptr %t263
  call void @node_add_child(ptr %t269, ptr %t270)
  %t272 = load ptr, ptr %t266
  ret ptr %t272
L68:
  br label %L63
L63:
  %t273 = alloca ptr
  %t274 = call ptr @parse_unary(ptr %t0)
  store ptr %t274, ptr %t273
  %t275 = alloca ptr
  %t276 = load i64, ptr %t1
  %t277 = call ptr @node_new(i64 32, i64 %t276)
  store ptr %t277, ptr %t275
  %t278 = load ptr, ptr %t275
  %t279 = load ptr, ptr %t273
  call void @node_add_child(ptr %t278, ptr %t279)
  %t281 = load ptr, ptr %t275
  ret ptr %t281
L69:
  br label %L60
L60:
  %t282 = getelementptr [28 x i8], ptr @.str32, i64 0, i64 0
  call void @p_error(ptr %t0, ptr %t282)
  %t285 = sext i32 0 to i64
  %t284 = inttoptr i64 %t285 to ptr
  ret ptr %t284
L70:
  ret ptr null
}

define internal ptr @parse_postfix(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_primary(ptr %t0)
  store ptr %t2, ptr %t1
  br label %L0
L0:
  br label %L1
L1:
  %t3 = alloca i64
  %t4 = load ptr, ptr %t0
  store ptr %t4, ptr %t3
  %t5 = call i32 @match(ptr %t0, i64 72)
  %t6 = sext i32 %t5 to i64
  %t7 = icmp ne i64 %t6, 0
  br i1 %t7, label %L4, label %L5
L4:
  %t8 = alloca ptr
  %t9 = load i64, ptr %t3
  %t10 = call ptr @node_new(i64 24, i64 %t9)
  store ptr %t10, ptr %t8
  %t11 = load ptr, ptr %t8
  %t12 = load ptr, ptr %t1
  call void @node_add_child(ptr %t11, ptr %t12)
  br label %L7
L7:
  %t14 = call i32 @check(ptr %t0, i64 73)
  %t15 = sext i32 %t14 to i64
  %t17 = icmp eq i64 %t15, 0
  %t16 = zext i1 %t17 to i64
  %t18 = icmp ne i64 %t16, 0
  br i1 %t18, label %L10, label %L11
L10:
  %t19 = call i32 @check(ptr %t0, i64 81)
  %t20 = sext i32 %t19 to i64
  %t22 = icmp eq i64 %t20, 0
  %t21 = zext i1 %t22 to i64
  %t23 = icmp ne i64 %t21, 0
  %t24 = zext i1 %t23 to i64
  br label %L12
L11:
  br label %L12
L12:
  %t25 = phi i64 [ %t24, %L10 ], [ 0, %L11 ]
  %t26 = icmp ne i64 %t25, 0
  br i1 %t26, label %L8, label %L9
L8:
  %t27 = load ptr, ptr %t8
  %t28 = call ptr @parse_assign(ptr %t0)
  call void @node_add_child(ptr %t27, ptr %t28)
  %t30 = call i32 @match(ptr %t0, i64 79)
  %t31 = sext i32 %t30 to i64
  %t33 = icmp eq i64 %t31, 0
  %t32 = zext i1 %t33 to i64
  %t34 = icmp ne i64 %t32, 0
  br i1 %t34, label %L13, label %L15
L13:
  br label %L9
L16:
  br label %L15
L15:
  br label %L7
L9:
  call void @expect(ptr %t0, i64 73)
  %t36 = load ptr, ptr %t8
  store ptr %t36, ptr %t1
  br label %L6
L5:
  %t37 = call i32 @match(ptr %t0, i64 76)
  %t38 = sext i32 %t37 to i64
  %t39 = icmp ne i64 %t38, 0
  br i1 %t39, label %L17, label %L18
L17:
  %t40 = alloca ptr
  %t41 = load i64, ptr %t3
  %t42 = call ptr @node_new(i64 33, i64 %t41)
  store ptr %t42, ptr %t40
  %t43 = load ptr, ptr %t40
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t40
  %t47 = call ptr @parse_expr(ptr %t0)
  call void @node_add_child(ptr %t46, ptr %t47)
  call void @expect(ptr %t0, i64 77)
  %t50 = load ptr, ptr %t40
  store ptr %t50, ptr %t1
  br label %L19
L18:
  %t51 = call i32 @match(ptr %t0, i64 69)
  %t52 = sext i32 %t51 to i64
  %t53 = icmp ne i64 %t52, 0
  br i1 %t53, label %L20, label %L21
L20:
  %t54 = alloca ptr
  %t55 = load i64, ptr %t3
  %t56 = call ptr @node_new(i64 34, i64 %t55)
  store ptr %t56, ptr %t54
  %t57 = call ptr @expect_ident(ptr %t0)
  %t58 = load ptr, ptr %t54
  store ptr %t57, ptr %t58
  %t59 = load ptr, ptr %t54
  %t60 = load ptr, ptr %t1
  call void @node_add_child(ptr %t59, ptr %t60)
  %t62 = load ptr, ptr %t54
  store ptr %t62, ptr %t1
  br label %L22
L21:
  %t63 = call i32 @match(ptr %t0, i64 68)
  %t64 = sext i32 %t63 to i64
  %t65 = icmp ne i64 %t64, 0
  br i1 %t65, label %L23, label %L24
L23:
  %t66 = alloca ptr
  %t67 = load i64, ptr %t3
  %t68 = call ptr @node_new(i64 35, i64 %t67)
  store ptr %t68, ptr %t66
  %t69 = call ptr @expect_ident(ptr %t0)
  %t70 = load ptr, ptr %t66
  store ptr %t69, ptr %t70
  %t71 = load ptr, ptr %t66
  %t72 = load ptr, ptr %t1
  call void @node_add_child(ptr %t71, ptr %t72)
  %t74 = load ptr, ptr %t66
  store ptr %t74, ptr %t1
  br label %L25
L24:
  %t75 = call i32 @check(ptr %t0, i64 66)
  %t76 = sext i32 %t75 to i64
  %t77 = icmp ne i64 %t76, 0
  br i1 %t77, label %L26, label %L27
L26:
  call void @advance(ptr %t0)
  %t79 = alloca ptr
  %t80 = load i64, ptr %t3
  %t81 = call ptr @node_new(i64 40, i64 %t80)
  store ptr %t81, ptr %t79
  %t82 = load ptr, ptr %t79
  %t83 = load ptr, ptr %t1
  call void @node_add_child(ptr %t82, ptr %t83)
  %t85 = load ptr, ptr %t79
  store ptr %t85, ptr %t1
  br label %L28
L27:
  %t86 = call i32 @check(ptr %t0, i64 67)
  %t87 = sext i32 %t86 to i64
  %t88 = icmp ne i64 %t87, 0
  br i1 %t88, label %L29, label %L30
L29:
  call void @advance(ptr %t0)
  %t90 = alloca ptr
  %t91 = load i64, ptr %t3
  %t92 = call ptr @node_new(i64 41, i64 %t91)
  store ptr %t92, ptr %t90
  %t93 = load ptr, ptr %t90
  %t94 = load ptr, ptr %t1
  call void @node_add_child(ptr %t93, ptr %t94)
  %t96 = load ptr, ptr %t90
  store ptr %t96, ptr %t1
  br label %L31
L30:
  br label %L3
L32:
  br label %L31
L31:
  br label %L28
L28:
  br label %L25
L25:
  br label %L22
L22:
  br label %L19
L19:
  br label %L6
L6:
  br label %L2
L2:
  br label %L0
L3:
  %t97 = load ptr, ptr %t1
  ret ptr %t97
L33:
  ret ptr null
}

define internal ptr @parse_unary(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  store ptr %t2, ptr %t1
  %t3 = call i32 @check(ptr %t0, i64 66)
  %t4 = sext i32 %t3 to i64
  %t5 = icmp ne i64 %t4, 0
  br i1 %t5, label %L0, label %L2
L0:
  call void @advance(ptr %t0)
  %t7 = alloca ptr
  %t8 = load i64, ptr %t1
  %t9 = call ptr @node_new(i64 38, i64 %t8)
  store ptr %t9, ptr %t7
  %t10 = load ptr, ptr %t7
  %t11 = call ptr @parse_unary(ptr %t0)
  call void @node_add_child(ptr %t10, ptr %t11)
  %t13 = load ptr, ptr %t7
  ret ptr %t13
L3:
  br label %L2
L2:
  %t14 = call i32 @check(ptr %t0, i64 67)
  %t15 = sext i32 %t14 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L4, label %L6
L4:
  call void @advance(ptr %t0)
  %t18 = alloca ptr
  %t19 = load i64, ptr %t1
  %t20 = call ptr @node_new(i64 39, i64 %t19)
  store ptr %t20, ptr %t18
  %t21 = load ptr, ptr %t18
  %t22 = call ptr @parse_unary(ptr %t0)
  call void @node_add_child(ptr %t21, ptr %t22)
  %t24 = load ptr, ptr %t18
  ret ptr %t24
L7:
  br label %L6
L6:
  %t25 = call i32 @check(ptr %t0, i64 40)
  %t26 = sext i32 %t25 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  call void @advance(ptr %t0)
  %t29 = alloca ptr
  %t30 = load i64, ptr %t1
  %t31 = call ptr @node_new(i64 36, i64 %t30)
  store ptr %t31, ptr %t29
  %t32 = load ptr, ptr %t29
  %t33 = call ptr @parse_cast(ptr %t0)
  call void @node_add_child(ptr %t32, ptr %t33)
  %t35 = load ptr, ptr %t29
  ret ptr %t35
L11:
  br label %L10
L10:
  %t36 = call i32 @check(ptr %t0, i64 37)
  %t37 = sext i32 %t36 to i64
  %t38 = icmp ne i64 %t37, 0
  br i1 %t38, label %L12, label %L14
L12:
  call void @advance(ptr %t0)
  %t40 = alloca ptr
  %t41 = load i64, ptr %t1
  %t42 = call ptr @node_new(i64 37, i64 %t41)
  store ptr %t42, ptr %t40
  %t43 = load ptr, ptr %t40
  %t44 = call ptr @parse_cast(ptr %t0)
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t40
  ret ptr %t46
L15:
  br label %L14
L14:
  %t47 = call i32 @check(ptr %t0, i64 36)
  %t48 = sext i32 %t47 to i64
  %t49 = icmp ne i64 %t48, 0
  br i1 %t49, label %L16, label %L17
L16:
  br label %L18
L17:
  %t50 = call i32 @check(ptr %t0, i64 35)
  %t51 = sext i32 %t50 to i64
  %t52 = icmp ne i64 %t51, 0
  %t53 = zext i1 %t52 to i64
  br label %L18
L18:
  %t54 = phi i64 [ 1, %L16 ], [ %t53, %L17 ]
  %t55 = icmp ne i64 %t54, 0
  br i1 %t55, label %L19, label %L20
L19:
  br label %L21
L20:
  %t56 = call i32 @check(ptr %t0, i64 54)
  %t57 = sext i32 %t56 to i64
  %t58 = icmp ne i64 %t57, 0
  %t59 = zext i1 %t58 to i64
  br label %L21
L21:
  %t60 = phi i64 [ 1, %L19 ], [ %t59, %L20 ]
  %t61 = icmp ne i64 %t60, 0
  br i1 %t61, label %L22, label %L23
L22:
  br label %L24
L23:
  %t62 = call i32 @check(ptr %t0, i64 43)
  %t63 = sext i32 %t62 to i64
  %t64 = icmp ne i64 %t63, 0
  %t65 = zext i1 %t64 to i64
  br label %L24
L24:
  %t66 = phi i64 [ 1, %L22 ], [ %t65, %L23 ]
  %t67 = icmp ne i64 %t66, 0
  br i1 %t67, label %L25, label %L27
L25:
  %t68 = alloca i64
  %t69 = load ptr, ptr %t0
  store ptr %t69, ptr %t68
  call void @advance(ptr %t0)
  %t71 = alloca ptr
  %t72 = load i64, ptr %t1
  %t73 = call ptr @node_new(i64 26, i64 %t72)
  store ptr %t73, ptr %t71
  %t74 = load i64, ptr %t68
  %t75 = load ptr, ptr %t71
  store i64 %t74, ptr %t75
  %t76 = load ptr, ptr %t71
  %t77 = call ptr @parse_cast(ptr %t0)
  call void @node_add_child(ptr %t76, ptr %t77)
  %t79 = load ptr, ptr %t71
  ret ptr %t79
L28:
  br label %L27
L27:
  %t80 = call ptr @parse_postfix(ptr %t0)
  ret ptr %t80
L29:
  ret ptr null
}

define internal ptr @parse_cast(ptr %t0) {
entry:
  %t1 = call ptr @parse_unary(ptr %t0)
  ret ptr %t1
L0:
  ret ptr null
}

define internal ptr @parse_mul(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_cast(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_cast(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_add(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_mul(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_mul(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_shift(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_add(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_add(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_relational(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_shift(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_shift(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_equality(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_relational(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_relational(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_bitand(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_equality(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_equality(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_bitxor(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_bitand(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_bitand(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_bitor(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_bitxor(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_bitxor(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_logand(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_bitor(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_bitor(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_logor(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_logand(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca ptr
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  br label %L1
L1:
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L4
L4:
  %t9 = load ptr, ptr %t3
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L5, label %L7
L5:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t3
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L10
L8:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  call void @advance(ptr %t0)
  %t33 = alloca ptr
  %t34 = call ptr @parse_logand(ptr %t0)
  store ptr %t34, ptr %t33
  %t35 = alloca ptr
  %t36 = load i64, ptr %t28
  %t37 = call ptr @node_new(i64 25, i64 %t36)
  store ptr %t37, ptr %t35
  %t38 = load i64, ptr %t30
  %t39 = load ptr, ptr %t35
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t35
  %t41 = load ptr, ptr %t1
  call void @node_add_child(ptr %t40, ptr %t41)
  %t43 = load ptr, ptr %t35
  %t44 = load ptr, ptr %t33
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t35
  store ptr %t46, ptr %t1
  %t47 = sext i32 1 to i64
  store i64 %t47, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t48 = load i64, ptr %t7
  %t49 = add i64 %t48, 1
  store i64 %t49, ptr %t7
  br label %L4
L7:
  %t50 = load i64, ptr %t5
  %t52 = icmp eq i64 %t50, 0
  %t51 = zext i1 %t52 to i64
  %t53 = icmp ne i64 %t51, 0
  br i1 %t53, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t54 = load ptr, ptr %t1
  ret ptr %t54
L16:
  ret ptr null
}

define internal ptr @parse_ternary(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_logor(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = call i32 @check(ptr %t0, i64 70)
  %t4 = sext i32 %t3 to i64
  %t6 = icmp eq i64 %t4, 0
  %t5 = zext i1 %t6 to i64
  %t7 = icmp ne i64 %t5, 0
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = load ptr, ptr %t1
  ret ptr %t8
L3:
  br label %L2
L2:
  %t9 = alloca i64
  %t10 = load ptr, ptr %t0
  store ptr %t10, ptr %t9
  call void @advance(ptr %t0)
  %t12 = alloca ptr
  %t13 = call ptr @parse_expr(ptr %t0)
  store ptr %t13, ptr %t12
  call void @expect(ptr %t0, i64 71)
  %t15 = alloca ptr
  %t16 = call ptr @parse_ternary(ptr %t0)
  store ptr %t16, ptr %t15
  %t17 = alloca ptr
  %t18 = load i64, ptr %t9
  %t19 = call ptr @node_new(i64 30, i64 %t18)
  store ptr %t19, ptr %t17
  %t20 = load ptr, ptr %t1
  %t21 = load ptr, ptr %t17
  store ptr %t20, ptr %t21
  %t22 = load ptr, ptr %t17
  %t23 = load ptr, ptr %t12
  call void @node_add_child(ptr %t22, ptr %t23)
  %t25 = load ptr, ptr %t17
  %t26 = load ptr, ptr %t15
  call void @node_add_child(ptr %t25, ptr %t26)
  %t28 = load ptr, ptr %t17
  ret ptr %t28
L4:
  ret ptr null
}

define internal ptr @parse_assign(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_ternary(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = alloca i64
  %t4 = load ptr, ptr %t0
  store ptr %t4, ptr %t3
  %t5 = alloca ptr
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  br label %L0
L0:
  %t9 = load ptr, ptr %t5
  %t10 = load i64, ptr %t7
  %t11 = getelementptr ptr, ptr %t9, i64 %t10
  %t12 = load ptr, ptr %t11
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = sext i32 81 to i64
  %t13 = icmp ne i64 %t14, %t15
  %t16 = zext i1 %t13 to i64
  %t17 = icmp ne i64 %t16, 0
  br i1 %t17, label %L1, label %L3
L1:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t5
  %t20 = load i64, ptr %t7
  %t21 = getelementptr ptr, ptr %t19, i64 %t20
  %t22 = load ptr, ptr %t21
  %t24 = ptrtoint ptr %t18 to i64
  %t25 = ptrtoint ptr %t22 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L4, label %L6
L4:
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_assign(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca i64
  %t34 = load i64, ptr %t28
  %t36 = sext i32 55 to i64
  %t35 = icmp eq i64 %t34, %t36
  %t37 = zext i1 %t35 to i64
  %t38 = icmp ne i64 %t37, 0
  br i1 %t38, label %L7, label %L8
L7:
  %t39 = sext i32 27 to i64
  br label %L9
L8:
  %t40 = sext i32 28 to i64
  br label %L9
L9:
  %t41 = phi i64 [ %t39, %L7 ], [ %t40, %L8 ]
  store i64 %t41, ptr %t33
  %t42 = alloca ptr
  %t43 = load i64, ptr %t33
  %t44 = load i64, ptr %t3
  %t45 = call ptr @node_new(i64 %t43, i64 %t44)
  store ptr %t45, ptr %t42
  %t46 = load i64, ptr %t28
  %t47 = load ptr, ptr %t42
  store i64 %t46, ptr %t47
  %t48 = load ptr, ptr %t42
  %t49 = load ptr, ptr %t1
  call void @node_add_child(ptr %t48, ptr %t49)
  %t51 = load ptr, ptr %t42
  %t52 = load ptr, ptr %t31
  call void @node_add_child(ptr %t51, ptr %t52)
  %t54 = load ptr, ptr %t42
  ret ptr %t54
L10:
  br label %L6
L6:
  br label %L2
L2:
  %t55 = load i64, ptr %t7
  %t56 = add i64 %t55, 1
  store i64 %t56, ptr %t7
  br label %L0
L3:
  %t57 = load ptr, ptr %t1
  ret ptr %t57
L11:
  ret ptr null
}

define internal ptr @parse_expr(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @parse_assign(ptr %t0)
  store ptr %t2, ptr %t1
  %t3 = call i32 @check(ptr %t0, i64 79)
  %t4 = sext i32 %t3 to i64
  %t5 = icmp ne i64 %t4, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = alloca i64
  %t7 = load ptr, ptr %t0
  store ptr %t7, ptr %t6
  %t8 = alloca ptr
  %t9 = load i64, ptr %t6
  %t10 = call ptr @node_new(i64 43, i64 %t9)
  store ptr %t10, ptr %t8
  %t11 = load ptr, ptr %t8
  %t12 = load ptr, ptr %t1
  call void @node_add_child(ptr %t11, ptr %t12)
  br label %L3
L3:
  %t14 = call i32 @match(ptr %t0, i64 79)
  %t15 = sext i32 %t14 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L4, label %L5
L4:
  %t17 = load ptr, ptr %t8
  %t18 = call ptr @parse_assign(ptr %t0)
  call void @node_add_child(ptr %t17, ptr %t18)
  br label %L3
L5:
  %t20 = load ptr, ptr %t8
  ret ptr %t20
L6:
  br label %L2
L2:
  %t21 = load ptr, ptr %t1
  ret ptr %t21
L7:
  ret ptr null
}

define internal ptr @parse_local_decl(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  store ptr %t2, ptr %t1
  %t3 = alloca i64
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  %t5 = alloca i64
  %t6 = sext i32 0 to i64
  store i64 %t6, ptr %t5
  %t7 = alloca i64
  %t8 = sext i32 0 to i64
  store i64 %t8, ptr %t7
  %t9 = alloca ptr
  %t10 = call ptr @parse_type_specifier(ptr %t0, ptr %t3, ptr %t5, ptr %t7)
  store ptr %t10, ptr %t9
  %t11 = load ptr, ptr %t9
  %t13 = ptrtoint ptr %t11 to i64
  %t14 = icmp eq i64 %t13, 0
  %t12 = zext i1 %t14 to i64
  %t15 = icmp ne i64 %t12, 0
  br i1 %t15, label %L0, label %L2
L0:
  %t17 = sext i32 0 to i64
  %t16 = inttoptr i64 %t17 to ptr
  ret ptr %t16
L3:
  br label %L2
L2:
  %t18 = alloca ptr
  %t19 = load i64, ptr %t1
  %t20 = call ptr @node_new(i64 5, i64 %t19)
  store ptr %t20, ptr %t18
  br label %L4
L4:
  %t21 = alloca ptr
  %t23 = sext i32 0 to i64
  %t22 = inttoptr i64 %t23 to ptr
  store ptr %t22, ptr %t21
  %t24 = alloca ptr
  %t25 = load ptr, ptr %t9
  %t26 = call ptr @parse_declarator(ptr %t0, ptr %t25, ptr %t21)
  store ptr %t26, ptr %t24
  %t27 = load i64, ptr %t3
  %t28 = icmp ne i64 %t27, 0
  br i1 %t28, label %L7, label %L8
L7:
  %t29 = load ptr, ptr %t21
  %t30 = ptrtoint ptr %t29 to i64
  %t31 = icmp ne i64 %t30, 0
  %t32 = zext i1 %t31 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t33 = phi i64 [ %t32, %L7 ], [ 0, %L8 ]
  %t34 = icmp ne i64 %t33, 0
  br i1 %t34, label %L10, label %L11
L10:
  %t35 = load ptr, ptr %t21
  %t36 = load ptr, ptr %t24
  call void @register_typedef(ptr %t0, ptr %t35, ptr %t36)
  %t38 = alloca ptr
  %t39 = load i64, ptr %t1
  %t40 = call ptr @node_new(i64 3, i64 %t39)
  store ptr %t40, ptr %t38
  %t41 = load ptr, ptr %t21
  %t42 = load ptr, ptr %t38
  store ptr %t41, ptr %t42
  %t43 = load ptr, ptr %t24
  %t44 = load ptr, ptr %t38
  store ptr %t43, ptr %t44
  %t45 = load ptr, ptr %t18
  %t46 = load ptr, ptr %t38
  call void @node_add_child(ptr %t45, ptr %t46)
  br label %L12
L11:
  %t48 = alloca ptr
  %t49 = load i64, ptr %t1
  %t50 = call ptr @node_new(i64 2, i64 %t49)
  store ptr %t50, ptr %t48
  %t51 = load ptr, ptr %t21
  %t52 = load ptr, ptr %t48
  store ptr %t51, ptr %t52
  %t53 = load ptr, ptr %t24
  %t54 = load ptr, ptr %t48
  store ptr %t53, ptr %t54
  %t55 = load i64, ptr %t5
  %t56 = load ptr, ptr %t48
  store i64 %t55, ptr %t56
  %t57 = load i64, ptr %t7
  %t58 = load ptr, ptr %t48
  store i64 %t57, ptr %t58
  %t59 = call i32 @match(ptr %t0, i64 55)
  %t60 = sext i32 %t59 to i64
  %t61 = icmp ne i64 %t60, 0
  br i1 %t61, label %L13, label %L15
L13:
  %t62 = load ptr, ptr %t48
  %t63 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t62, ptr %t63)
  br label %L15
L15:
  %t65 = load ptr, ptr %t18
  %t66 = load ptr, ptr %t48
  call void @node_add_child(ptr %t65, ptr %t66)
  br label %L12
L12:
  br label %L5
L5:
  %t68 = call i32 @match(ptr %t0, i64 79)
  %t69 = sext i32 %t68 to i64
  %t70 = icmp ne i64 %t69, 0
  br i1 %t70, label %L4, label %L6
L6:
  call void @expect(ptr %t0, i64 78)
  %t72 = load ptr, ptr %t18
  %t73 = load ptr, ptr %t72
  %t75 = ptrtoint ptr %t73 to i64
  %t76 = sext i32 1 to i64
  %t74 = icmp eq i64 %t75, %t76
  %t77 = zext i1 %t74 to i64
  %t78 = icmp ne i64 %t77, 0
  br i1 %t78, label %L16, label %L18
L16:
  %t79 = alloca ptr
  %t80 = load ptr, ptr %t18
  %t81 = load ptr, ptr %t80
  %t82 = sext i32 0 to i64
  %t83 = getelementptr ptr, ptr %t81, i64 %t82
  %t84 = load ptr, ptr %t83
  store ptr %t84, ptr %t79
  %t85 = load ptr, ptr %t18
  %t86 = sext i32 0 to i64
  store i64 %t86, ptr %t85
  %t87 = load ptr, ptr %t18
  %t88 = load ptr, ptr %t87
  call void @free(ptr %t88)
  %t90 = load ptr, ptr %t18
  call void @free(ptr %t90)
  %t92 = load ptr, ptr %t79
  ret ptr %t92
L19:
  br label %L18
L18:
  %t93 = load ptr, ptr %t18
  ret ptr %t93
L20:
  ret ptr null
}

define internal ptr @parse_initializer(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  store ptr %t2, ptr %t1
  %t3 = call i32 @check(ptr %t0, i64 74)
  %t4 = sext i32 %t3 to i64
  %t6 = icmp eq i64 %t4, 0
  %t5 = zext i1 %t6 to i64
  %t7 = icmp ne i64 %t5, 0
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = call ptr @parse_assign(ptr %t0)
  ret ptr %t8
L3:
  br label %L2
L2:
  call void @advance(ptr %t0)
  %t10 = alloca i64
  %t11 = sext i32 1 to i64
  store i64 %t11, ptr %t10
  br label %L4
L4:
  %t12 = call i32 @check(ptr %t0, i64 81)
  %t13 = sext i32 %t12 to i64
  %t15 = icmp eq i64 %t13, 0
  %t14 = zext i1 %t15 to i64
  %t16 = icmp ne i64 %t14, 0
  br i1 %t16, label %L7, label %L8
L7:
  %t17 = load i64, ptr %t10
  %t19 = sext i32 0 to i64
  %t18 = icmp sgt i64 %t17, %t19
  %t20 = zext i1 %t18 to i64
  %t21 = icmp ne i64 %t20, 0
  %t22 = zext i1 %t21 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t23 = phi i64 [ %t22, %L7 ], [ 0, %L8 ]
  %t24 = icmp ne i64 %t23, 0
  br i1 %t24, label %L5, label %L6
L5:
  %t25 = call i32 @check(ptr %t0, i64 74)
  %t26 = sext i32 %t25 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L10, label %L11
L10:
  %t28 = load i64, ptr %t10
  %t29 = add i64 %t28, 1
  store i64 %t29, ptr %t10
  br label %L12
L11:
  %t30 = call i32 @check(ptr %t0, i64 75)
  %t31 = sext i32 %t30 to i64
  %t32 = icmp ne i64 %t31, 0
  br i1 %t32, label %L13, label %L15
L13:
  %t33 = load i64, ptr %t10
  %t34 = sub i64 %t33, 1
  store i64 %t34, ptr %t10
  %t35 = load i64, ptr %t10
  %t37 = sext i32 0 to i64
  %t36 = icmp eq i64 %t35, %t37
  %t38 = zext i1 %t36 to i64
  %t39 = icmp ne i64 %t38, 0
  br i1 %t39, label %L16, label %L18
L16:
  br label %L6
L19:
  br label %L18
L18:
  br label %L15
L15:
  br label %L12
L12:
  call void @advance(ptr %t0)
  br label %L4
L6:
  call void @expect(ptr %t0, i64 75)
  %t42 = alloca ptr
  %t43 = load i64, ptr %t1
  %t44 = call ptr @node_new(i64 19, i64 %t43)
  store ptr %t44, ptr %t42
  %t45 = load ptr, ptr %t42
  %t46 = sext i32 0 to i64
  store i64 %t46, ptr %t45
  %t47 = getelementptr [7 x i8], ptr @.str33, i64 0, i64 0
  %t48 = call ptr @strdup(ptr %t47)
  %t49 = load ptr, ptr %t42
  store ptr %t48, ptr %t49
  %t50 = load ptr, ptr %t42
  ret ptr %t50
L20:
  ret ptr null
}

define internal ptr @parse_stmt(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  store ptr %t2, ptr %t1
  %t3 = call i32 @check(ptr %t0, i64 74)
  %t4 = sext i32 %t3 to i64
  %t5 = icmp ne i64 %t4, 0
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = call ptr @parse_block(ptr %t0)
  ret ptr %t6
L3:
  br label %L2
L2:
  %t7 = call i32 @check(ptr %t0, i64 14)
  %t8 = sext i32 %t7 to i64
  %t9 = icmp ne i64 %t8, 0
  br i1 %t9, label %L4, label %L6
L4:
  call void @advance(ptr %t0)
  %t11 = alloca ptr
  %t12 = load i64, ptr %t1
  %t13 = call ptr @node_new(i64 6, i64 %t12)
  store ptr %t13, ptr %t11
  call void @expect(ptr %t0, i64 72)
  %t15 = call ptr @parse_expr(ptr %t0)
  %t16 = load ptr, ptr %t11
  store ptr %t15, ptr %t16
  call void @expect(ptr %t0, i64 73)
  %t18 = call ptr @parse_stmt(ptr %t0)
  %t19 = load ptr, ptr %t11
  store ptr %t18, ptr %t19
  %t20 = call i32 @match(ptr %t0, i64 15)
  %t21 = sext i32 %t20 to i64
  %t22 = icmp ne i64 %t21, 0
  br i1 %t22, label %L7, label %L9
L7:
  %t23 = call ptr @parse_stmt(ptr %t0)
  %t24 = load ptr, ptr %t11
  store ptr %t23, ptr %t24
  br label %L9
L9:
  %t25 = load ptr, ptr %t11
  ret ptr %t25
L10:
  br label %L6
L6:
  %t26 = call i32 @check(ptr %t0, i64 16)
  %t27 = sext i32 %t26 to i64
  %t28 = icmp ne i64 %t27, 0
  br i1 %t28, label %L11, label %L13
L11:
  call void @advance(ptr %t0)
  %t30 = alloca ptr
  %t31 = load i64, ptr %t1
  %t32 = call ptr @node_new(i64 7, i64 %t31)
  store ptr %t32, ptr %t30
  call void @expect(ptr %t0, i64 72)
  %t34 = call ptr @parse_expr(ptr %t0)
  %t35 = load ptr, ptr %t30
  store ptr %t34, ptr %t35
  call void @expect(ptr %t0, i64 73)
  %t37 = call ptr @parse_stmt(ptr %t0)
  %t38 = load ptr, ptr %t30
  store ptr %t37, ptr %t38
  %t39 = load ptr, ptr %t30
  ret ptr %t39
L14:
  br label %L13
L13:
  %t40 = call i32 @check(ptr %t0, i64 18)
  %t41 = sext i32 %t40 to i64
  %t42 = icmp ne i64 %t41, 0
  br i1 %t42, label %L15, label %L17
L15:
  call void @advance(ptr %t0)
  %t44 = alloca ptr
  %t45 = load i64, ptr %t1
  %t46 = call ptr @node_new(i64 8, i64 %t45)
  store ptr %t46, ptr %t44
  %t47 = call ptr @parse_stmt(ptr %t0)
  %t48 = load ptr, ptr %t44
  store ptr %t47, ptr %t48
  call void @expect(ptr %t0, i64 16)
  call void @expect(ptr %t0, i64 72)
  %t51 = call ptr @parse_expr(ptr %t0)
  %t52 = load ptr, ptr %t44
  store ptr %t51, ptr %t52
  call void @expect(ptr %t0, i64 73)
  call void @expect(ptr %t0, i64 78)
  %t55 = load ptr, ptr %t44
  ret ptr %t55
L18:
  br label %L17
L17:
  %t56 = call i32 @check(ptr %t0, i64 17)
  %t57 = sext i32 %t56 to i64
  %t58 = icmp ne i64 %t57, 0
  br i1 %t58, label %L19, label %L21
L19:
  call void @advance(ptr %t0)
  %t60 = alloca ptr
  %t61 = load i64, ptr %t1
  %t62 = call ptr @node_new(i64 9, i64 %t61)
  store ptr %t62, ptr %t60
  call void @expect(ptr %t0, i64 72)
  %t64 = call i32 @check(ptr %t0, i64 78)
  %t65 = sext i32 %t64 to i64
  %t67 = icmp eq i64 %t65, 0
  %t66 = zext i1 %t67 to i64
  %t68 = icmp ne i64 %t66, 0
  br i1 %t68, label %L22, label %L23
L22:
  %t69 = call i32 @is_type_start(ptr %t0)
  %t70 = sext i32 %t69 to i64
  %t71 = icmp ne i64 %t70, 0
  br i1 %t71, label %L25, label %L26
L25:
  %t72 = call ptr @parse_local_decl(ptr %t0)
  %t73 = load ptr, ptr %t60
  store ptr %t72, ptr %t73
  br label %L27
L26:
  %t74 = load i64, ptr %t1
  %t75 = call ptr @node_new(i64 18, i64 %t74)
  %t76 = load ptr, ptr %t60
  store ptr %t75, ptr %t76
  %t77 = load ptr, ptr %t60
  %t78 = load ptr, ptr %t77
  %t79 = call ptr @parse_expr(ptr %t0)
  call void @node_add_child(ptr %t78, ptr %t79)
  call void @expect(ptr %t0, i64 78)
  br label %L27
L27:
  br label %L24
L23:
  call void @advance(ptr %t0)
  br label %L24
L24:
  %t83 = call i32 @check(ptr %t0, i64 78)
  %t84 = sext i32 %t83 to i64
  %t86 = icmp eq i64 %t84, 0
  %t85 = zext i1 %t86 to i64
  %t87 = icmp ne i64 %t85, 0
  br i1 %t87, label %L28, label %L30
L28:
  %t88 = call ptr @parse_expr(ptr %t0)
  %t89 = load ptr, ptr %t60
  store ptr %t88, ptr %t89
  br label %L30
L30:
  call void @expect(ptr %t0, i64 78)
  %t91 = call i32 @check(ptr %t0, i64 73)
  %t92 = sext i32 %t91 to i64
  %t94 = icmp eq i64 %t92, 0
  %t93 = zext i1 %t94 to i64
  %t95 = icmp ne i64 %t93, 0
  br i1 %t95, label %L31, label %L33
L31:
  %t96 = call ptr @parse_expr(ptr %t0)
  %t97 = load ptr, ptr %t60
  store ptr %t96, ptr %t97
  br label %L33
L33:
  call void @expect(ptr %t0, i64 73)
  %t99 = call ptr @parse_stmt(ptr %t0)
  %t100 = load ptr, ptr %t60
  store ptr %t99, ptr %t100
  %t101 = load ptr, ptr %t60
  ret ptr %t101
L34:
  br label %L21
L21:
  %t102 = call i32 @check(ptr %t0, i64 19)
  %t103 = sext i32 %t102 to i64
  %t104 = icmp ne i64 %t103, 0
  br i1 %t104, label %L35, label %L37
L35:
  call void @advance(ptr %t0)
  %t106 = alloca ptr
  %t107 = load i64, ptr %t1
  %t108 = call ptr @node_new(i64 10, i64 %t107)
  store ptr %t108, ptr %t106
  %t109 = call i32 @check(ptr %t0, i64 78)
  %t110 = sext i32 %t109 to i64
  %t112 = icmp eq i64 %t110, 0
  %t111 = zext i1 %t112 to i64
  %t113 = icmp ne i64 %t111, 0
  br i1 %t113, label %L38, label %L40
L38:
  %t114 = call ptr @parse_expr(ptr %t0)
  %t115 = load ptr, ptr %t106
  store ptr %t114, ptr %t115
  br label %L40
L40:
  call void @expect(ptr %t0, i64 78)
  %t117 = load ptr, ptr %t106
  ret ptr %t117
L41:
  br label %L37
L37:
  %t118 = call i32 @check(ptr %t0, i64 20)
  %t119 = sext i32 %t118 to i64
  %t120 = icmp ne i64 %t119, 0
  br i1 %t120, label %L42, label %L44
L42:
  call void @advance(ptr %t0)
  call void @expect(ptr %t0, i64 78)
  %t123 = load i64, ptr %t1
  %t124 = call ptr @node_new(i64 11, i64 %t123)
  ret ptr %t124
L45:
  br label %L44
L44:
  %t125 = call i32 @check(ptr %t0, i64 21)
  %t126 = sext i32 %t125 to i64
  %t127 = icmp ne i64 %t126, 0
  br i1 %t127, label %L46, label %L48
L46:
  call void @advance(ptr %t0)
  call void @expect(ptr %t0, i64 78)
  %t130 = load i64, ptr %t1
  %t131 = call ptr @node_new(i64 12, i64 %t130)
  ret ptr %t131
L49:
  br label %L48
L48:
  %t132 = call i32 @check(ptr %t0, i64 22)
  %t133 = sext i32 %t132 to i64
  %t134 = icmp ne i64 %t133, 0
  br i1 %t134, label %L50, label %L52
L50:
  call void @advance(ptr %t0)
  %t136 = alloca ptr
  %t137 = load i64, ptr %t1
  %t138 = call ptr @node_new(i64 13, i64 %t137)
  store ptr %t138, ptr %t136
  call void @expect(ptr %t0, i64 72)
  %t140 = call ptr @parse_expr(ptr %t0)
  %t141 = load ptr, ptr %t136
  store ptr %t140, ptr %t141
  call void @expect(ptr %t0, i64 73)
  %t143 = call ptr @parse_stmt(ptr %t0)
  %t144 = load ptr, ptr %t136
  store ptr %t143, ptr %t144
  %t145 = load ptr, ptr %t136
  ret ptr %t145
L53:
  br label %L52
L52:
  %t146 = call i32 @check(ptr %t0, i64 23)
  %t147 = sext i32 %t146 to i64
  %t148 = icmp ne i64 %t147, 0
  br i1 %t148, label %L54, label %L56
L54:
  call void @advance(ptr %t0)
  %t150 = alloca ptr
  %t151 = load i64, ptr %t1
  %t152 = call ptr @node_new(i64 14, i64 %t151)
  store ptr %t152, ptr %t150
  %t153 = call ptr @parse_expr(ptr %t0)
  %t154 = load ptr, ptr %t150
  store ptr %t153, ptr %t154
  call void @expect(ptr %t0, i64 71)
  %t156 = alloca ptr
  %t157 = load i64, ptr %t1
  %t158 = call ptr @node_new(i64 5, i64 %t157)
  store ptr %t158, ptr %t156
  br label %L57
L57:
  %t159 = call i32 @check(ptr %t0, i64 23)
  %t160 = sext i32 %t159 to i64
  %t162 = icmp eq i64 %t160, 0
  %t161 = zext i1 %t162 to i64
  %t163 = icmp ne i64 %t161, 0
  br i1 %t163, label %L60, label %L61
L60:
  %t164 = call i32 @check(ptr %t0, i64 24)
  %t165 = sext i32 %t164 to i64
  %t167 = icmp eq i64 %t165, 0
  %t166 = zext i1 %t167 to i64
  %t168 = icmp ne i64 %t166, 0
  %t169 = zext i1 %t168 to i64
  br label %L62
L61:
  br label %L62
L62:
  %t170 = phi i64 [ %t169, %L60 ], [ 0, %L61 ]
  %t171 = icmp ne i64 %t170, 0
  br i1 %t171, label %L63, label %L64
L63:
  %t172 = call i32 @check(ptr %t0, i64 75)
  %t173 = sext i32 %t172 to i64
  %t175 = icmp eq i64 %t173, 0
  %t174 = zext i1 %t175 to i64
  %t176 = icmp ne i64 %t174, 0
  %t177 = zext i1 %t176 to i64
  br label %L65
L64:
  br label %L65
L65:
  %t178 = phi i64 [ %t177, %L63 ], [ 0, %L64 ]
  %t179 = icmp ne i64 %t178, 0
  br i1 %t179, label %L66, label %L67
L66:
  %t180 = call i32 @check(ptr %t0, i64 81)
  %t181 = sext i32 %t180 to i64
  %t183 = icmp eq i64 %t181, 0
  %t182 = zext i1 %t183 to i64
  %t184 = icmp ne i64 %t182, 0
  %t185 = zext i1 %t184 to i64
  br label %L68
L67:
  br label %L68
L68:
  %t186 = phi i64 [ %t185, %L66 ], [ 0, %L67 ]
  %t187 = icmp ne i64 %t186, 0
  br i1 %t187, label %L58, label %L59
L58:
  %t188 = load ptr, ptr %t156
  %t189 = call ptr @parse_stmt(ptr %t0)
  call void @node_add_child(ptr %t188, ptr %t189)
  br label %L57
L59:
  %t191 = load ptr, ptr %t150
  %t192 = load ptr, ptr %t156
  call void @node_add_child(ptr %t191, ptr %t192)
  %t194 = load ptr, ptr %t150
  ret ptr %t194
L69:
  br label %L56
L56:
  %t195 = call i32 @check(ptr %t0, i64 24)
  %t196 = sext i32 %t195 to i64
  %t197 = icmp ne i64 %t196, 0
  br i1 %t197, label %L70, label %L72
L70:
  call void @advance(ptr %t0)
  call void @expect(ptr %t0, i64 71)
  %t200 = alloca ptr
  %t201 = load i64, ptr %t1
  %t202 = call ptr @node_new(i64 15, i64 %t201)
  store ptr %t202, ptr %t200
  %t203 = alloca ptr
  %t204 = load i64, ptr %t1
  %t205 = call ptr @node_new(i64 5, i64 %t204)
  store ptr %t205, ptr %t203
  br label %L73
L73:
  %t206 = call i32 @check(ptr %t0, i64 23)
  %t207 = sext i32 %t206 to i64
  %t209 = icmp eq i64 %t207, 0
  %t208 = zext i1 %t209 to i64
  %t210 = icmp ne i64 %t208, 0
  br i1 %t210, label %L76, label %L77
L76:
  %t211 = call i32 @check(ptr %t0, i64 24)
  %t212 = sext i32 %t211 to i64
  %t214 = icmp eq i64 %t212, 0
  %t213 = zext i1 %t214 to i64
  %t215 = icmp ne i64 %t213, 0
  %t216 = zext i1 %t215 to i64
  br label %L78
L77:
  br label %L78
L78:
  %t217 = phi i64 [ %t216, %L76 ], [ 0, %L77 ]
  %t218 = icmp ne i64 %t217, 0
  br i1 %t218, label %L79, label %L80
L79:
  %t219 = call i32 @check(ptr %t0, i64 75)
  %t220 = sext i32 %t219 to i64
  %t222 = icmp eq i64 %t220, 0
  %t221 = zext i1 %t222 to i64
  %t223 = icmp ne i64 %t221, 0
  %t224 = zext i1 %t223 to i64
  br label %L81
L80:
  br label %L81
L81:
  %t225 = phi i64 [ %t224, %L79 ], [ 0, %L80 ]
  %t226 = icmp ne i64 %t225, 0
  br i1 %t226, label %L82, label %L83
L82:
  %t227 = call i32 @check(ptr %t0, i64 81)
  %t228 = sext i32 %t227 to i64
  %t230 = icmp eq i64 %t228, 0
  %t229 = zext i1 %t230 to i64
  %t231 = icmp ne i64 %t229, 0
  %t232 = zext i1 %t231 to i64
  br label %L84
L83:
  br label %L84
L84:
  %t233 = phi i64 [ %t232, %L82 ], [ 0, %L83 ]
  %t234 = icmp ne i64 %t233, 0
  br i1 %t234, label %L74, label %L75
L74:
  %t235 = load ptr, ptr %t203
  %t236 = call ptr @parse_stmt(ptr %t0)
  call void @node_add_child(ptr %t235, ptr %t236)
  br label %L73
L75:
  %t238 = load ptr, ptr %t200
  %t239 = load ptr, ptr %t203
  call void @node_add_child(ptr %t238, ptr %t239)
  %t241 = load ptr, ptr %t200
  ret ptr %t241
L85:
  br label %L72
L72:
  %t242 = call i32 @check(ptr %t0, i64 25)
  %t243 = sext i32 %t242 to i64
  %t244 = icmp ne i64 %t243, 0
  br i1 %t244, label %L86, label %L88
L86:
  call void @advance(ptr %t0)
  %t246 = alloca ptr
  %t247 = load i64, ptr %t1
  %t248 = call ptr @node_new(i64 17, i64 %t247)
  store ptr %t248, ptr %t246
  %t249 = call ptr @expect_ident(ptr %t0)
  %t250 = load ptr, ptr %t246
  store ptr %t249, ptr %t250
  call void @expect(ptr %t0, i64 78)
  %t252 = load ptr, ptr %t246
  ret ptr %t252
L89:
  br label %L88
L88:
  %t253 = call i32 @check(ptr %t0, i64 4)
  %t254 = sext i32 %t253 to i64
  %t255 = icmp ne i64 %t254, 0
  br i1 %t255, label %L90, label %L91
L90:
  %t256 = call i64 @peek(ptr %t0)
  %t257 = inttoptr i64 %t256 to ptr
  %t258 = load ptr, ptr %t257
  %t260 = ptrtoint ptr %t258 to i64
  %t261 = sext i32 71 to i64
  %t259 = icmp eq i64 %t260, %t261
  %t262 = zext i1 %t259 to i64
  %t263 = icmp ne i64 %t262, 0
  %t264 = zext i1 %t263 to i64
  br label %L92
L91:
  br label %L92
L92:
  %t265 = phi i64 [ %t264, %L90 ], [ 0, %L91 ]
  %t266 = icmp ne i64 %t265, 0
  br i1 %t266, label %L93, label %L95
L93:
  %t267 = alloca ptr
  %t268 = load i64, ptr %t1
  %t269 = call ptr @node_new(i64 16, i64 %t268)
  store ptr %t269, ptr %t267
  %t270 = load ptr, ptr %t0
  %t271 = call ptr @strdup(ptr %t270)
  %t272 = load ptr, ptr %t267
  store ptr %t271, ptr %t272
  call void @advance(ptr %t0)
  call void @advance(ptr %t0)
  %t275 = load ptr, ptr %t267
  %t276 = call ptr @parse_stmt(ptr %t0)
  call void @node_add_child(ptr %t275, ptr %t276)
  %t278 = load ptr, ptr %t267
  ret ptr %t278
L96:
  br label %L95
L95:
  %t279 = call i32 @is_type_start(ptr %t0)
  %t280 = sext i32 %t279 to i64
  %t281 = icmp ne i64 %t280, 0
  br i1 %t281, label %L97, label %L99
L97:
  %t282 = call ptr @parse_local_decl(ptr %t0)
  ret ptr %t282
L100:
  br label %L99
L99:
  %t283 = call i32 @check(ptr %t0, i64 78)
  %t284 = sext i32 %t283 to i64
  %t285 = icmp ne i64 %t284, 0
  br i1 %t285, label %L101, label %L103
L101:
  call void @advance(ptr %t0)
  %t287 = load i64, ptr %t1
  %t288 = call ptr @node_new(i64 5, i64 %t287)
  ret ptr %t288
L104:
  br label %L103
L103:
  %t289 = alloca ptr
  %t290 = load i64, ptr %t1
  %t291 = call ptr @node_new(i64 18, i64 %t290)
  store ptr %t291, ptr %t289
  %t292 = load ptr, ptr %t289
  %t293 = call ptr @parse_expr(ptr %t0)
  call void @node_add_child(ptr %t292, ptr %t293)
  call void @expect(ptr %t0, i64 78)
  %t296 = load ptr, ptr %t289
  ret ptr %t296
L105:
  ret ptr null
}

define internal ptr @parse_block(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  store ptr %t2, ptr %t1
  call void @expect(ptr %t0, i64 74)
  %t4 = alloca ptr
  %t5 = load i64, ptr %t1
  %t6 = call ptr @node_new(i64 5, i64 %t5)
  store ptr %t6, ptr %t4
  %t7 = load ptr, ptr %t4
  %t8 = sext i32 1 to i64
  store i64 %t8, ptr %t7
  br label %L0
L0:
  %t9 = call i32 @check(ptr %t0, i64 75)
  %t10 = sext i32 %t9 to i64
  %t12 = icmp eq i64 %t10, 0
  %t11 = zext i1 %t12 to i64
  %t13 = icmp ne i64 %t11, 0
  br i1 %t13, label %L3, label %L4
L3:
  %t14 = call i32 @check(ptr %t0, i64 81)
  %t15 = sext i32 %t14 to i64
  %t17 = icmp eq i64 %t15, 0
  %t16 = zext i1 %t17 to i64
  %t18 = icmp ne i64 %t16, 0
  %t19 = zext i1 %t18 to i64
  br label %L5
L4:
  br label %L5
L5:
  %t20 = phi i64 [ %t19, %L3 ], [ 0, %L4 ]
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L1, label %L2
L1:
  %t22 = load ptr, ptr %t4
  %t23 = call ptr @parse_stmt(ptr %t0)
  call void @node_add_child(ptr %t22, ptr %t23)
  br label %L0
L2:
  call void @expect(ptr %t0, i64 75)
  %t26 = load ptr, ptr %t4
  ret ptr %t26
L6:
  ret ptr null
}

define internal ptr @parse_toplevel(ptr %t0) {
entry:
  %t1 = alloca i64
  %t2 = load ptr, ptr %t0
  store ptr %t2, ptr %t1
  call void @skip_gcc_extension(ptr %t0)
  %t4 = alloca i64
  %t5 = sext i32 0 to i64
  store i64 %t5, ptr %t4
  %t6 = alloca i64
  %t7 = sext i32 0 to i64
  store i64 %t7, ptr %t6
  %t8 = alloca i64
  %t9 = sext i32 0 to i64
  store i64 %t9, ptr %t8
  %t10 = alloca ptr
  %t11 = call ptr @parse_type_specifier(ptr %t0, ptr %t4, ptr %t6, ptr %t8)
  store ptr %t11, ptr %t10
  %t12 = load ptr, ptr %t10
  %t14 = ptrtoint ptr %t12 to i64
  %t15 = icmp eq i64 %t14, 0
  %t13 = zext i1 %t15 to i64
  %t16 = icmp ne i64 %t13, 0
  br i1 %t16, label %L0, label %L2
L0:
  %t17 = getelementptr [21 x i8], ptr @.str34, i64 0, i64 0
  call void @p_error(ptr %t0, ptr %t17)
  %t20 = sext i32 0 to i64
  %t19 = inttoptr i64 %t20 to ptr
  ret ptr %t19
L3:
  br label %L2
L2:
  %t21 = call i32 @check(ptr %t0, i64 78)
  %t22 = sext i32 %t21 to i64
  %t23 = icmp ne i64 %t22, 0
  br i1 %t23, label %L4, label %L6
L4:
  call void @advance(ptr %t0)
  %t25 = load i64, ptr %t1
  %t26 = call ptr @node_new(i64 5, i64 %t25)
  ret ptr %t26
L7:
  br label %L6
L6:
  %t27 = alloca ptr
  %t29 = sext i32 0 to i64
  %t28 = inttoptr i64 %t29 to ptr
  store ptr %t28, ptr %t27
  %t30 = alloca ptr
  %t31 = load ptr, ptr %t10
  %t32 = call ptr @parse_declarator(ptr %t0, ptr %t31, ptr %t27)
  store ptr %t32, ptr %t30
  call void @skip_gcc_extension(ptr %t0)
  %t34 = load i64, ptr %t4
  %t35 = icmp ne i64 %t34, 0
  br i1 %t35, label %L8, label %L10
L8:
  %t36 = load ptr, ptr %t27
  %t37 = icmp ne ptr %t36, null
  br i1 %t37, label %L11, label %L13
L11:
  %t38 = load ptr, ptr %t27
  %t39 = load ptr, ptr %t30
  call void @register_typedef(ptr %t0, ptr %t38, ptr %t39)
  br label %L13
L13:
  %t41 = alloca ptr
  %t42 = load i64, ptr %t1
  %t43 = call ptr @node_new(i64 3, i64 %t42)
  store ptr %t43, ptr %t41
  %t44 = load ptr, ptr %t27
  %t45 = load ptr, ptr %t41
  store ptr %t44, ptr %t45
  %t46 = load ptr, ptr %t30
  %t47 = load ptr, ptr %t41
  store ptr %t46, ptr %t47
  call void @expect(ptr %t0, i64 78)
  %t49 = load ptr, ptr %t41
  ret ptr %t49
L14:
  br label %L10
L10:
  %t50 = load ptr, ptr %t30
  %t51 = load ptr, ptr %t50
  %t53 = ptrtoint ptr %t51 to i64
  %t54 = sext i32 17 to i64
  %t52 = icmp eq i64 %t53, %t54
  %t55 = zext i1 %t52 to i64
  %t56 = icmp ne i64 %t55, 0
  br i1 %t56, label %L15, label %L16
L15:
  %t57 = call i32 @check(ptr %t0, i64 74)
  %t58 = sext i32 %t57 to i64
  %t59 = icmp ne i64 %t58, 0
  %t60 = zext i1 %t59 to i64
  br label %L17
L16:
  br label %L17
L17:
  %t61 = phi i64 [ %t60, %L15 ], [ 0, %L16 ]
  %t62 = icmp ne i64 %t61, 0
  br i1 %t62, label %L18, label %L20
L18:
  %t63 = alloca ptr
  %t64 = load i64, ptr %t1
  %t65 = call ptr @node_new(i64 1, i64 %t64)
  store ptr %t65, ptr %t63
  %t66 = load ptr, ptr %t27
  %t67 = load ptr, ptr %t63
  store ptr %t66, ptr %t67
  %t68 = load ptr, ptr %t30
  %t69 = load ptr, ptr %t63
  store ptr %t68, ptr %t69
  %t70 = load i64, ptr %t6
  %t71 = load ptr, ptr %t63
  store i64 %t70, ptr %t71
  %t72 = load i64, ptr %t8
  %t73 = load ptr, ptr %t63
  store i64 %t72, ptr %t73
  %t74 = load ptr, ptr %t30
  %t75 = load ptr, ptr %t74
  %t77 = ptrtoint ptr %t75 to i64
  %t78 = sext i32 8 to i64
  %t76 = mul i64 %t77, %t78
  %t79 = call ptr @malloc(i64 %t76)
  %t80 = load ptr, ptr %t63
  store ptr %t79, ptr %t80
  %t81 = alloca i64
  %t82 = sext i32 0 to i64
  store i64 %t82, ptr %t81
  br label %L21
L21:
  %t83 = load i64, ptr %t81
  %t84 = load ptr, ptr %t30
  %t85 = load ptr, ptr %t84
  %t87 = ptrtoint ptr %t85 to i64
  %t86 = icmp slt i64 %t83, %t87
  %t88 = zext i1 %t86 to i64
  %t89 = icmp ne i64 %t88, 0
  br i1 %t89, label %L22, label %L24
L22:
  %t90 = load ptr, ptr %t30
  %t91 = load ptr, ptr %t90
  %t92 = load i64, ptr %t81
  %t93 = getelementptr ptr, ptr %t91, i64 %t92
  %t94 = load ptr, ptr %t93
  %t95 = icmp ne ptr %t94, null
  br i1 %t95, label %L25, label %L26
L25:
  %t96 = load ptr, ptr %t30
  %t97 = load ptr, ptr %t96
  %t98 = load i64, ptr %t81
  %t99 = getelementptr ptr, ptr %t97, i64 %t98
  %t100 = load ptr, ptr %t99
  %t101 = call ptr @strdup(ptr %t100)
  %t102 = ptrtoint ptr %t101 to i64
  br label %L27
L26:
  %t104 = sext i32 0 to i64
  %t103 = inttoptr i64 %t104 to ptr
  %t105 = ptrtoint ptr %t103 to i64
  br label %L27
L27:
  %t106 = phi i64 [ %t102, %L25 ], [ %t105, %L26 ]
  %t107 = load ptr, ptr %t63
  %t108 = load ptr, ptr %t107
  %t109 = load i64, ptr %t81
  %t110 = getelementptr ptr, ptr %t108, i64 %t109
  store i64 %t106, ptr %t110
  br label %L23
L23:
  %t111 = load i64, ptr %t81
  %t112 = add i64 %t111, 1
  store i64 %t112, ptr %t81
  br label %L21
L24:
  %t113 = call ptr @parse_block(ptr %t0)
  %t114 = load ptr, ptr %t63
  store ptr %t113, ptr %t114
  %t115 = load ptr, ptr %t63
  ret ptr %t115
L28:
  br label %L20
L20:
  %t116 = alloca ptr
  %t117 = load i64, ptr %t1
  %t118 = call ptr @node_new(i64 2, i64 %t117)
  store ptr %t118, ptr %t116
  %t119 = load ptr, ptr %t27
  %t120 = load ptr, ptr %t116
  store ptr %t119, ptr %t120
  %t121 = load ptr, ptr %t30
  %t122 = load ptr, ptr %t116
  store ptr %t121, ptr %t122
  %t123 = load ptr, ptr %t116
  %t124 = sext i32 1 to i64
  store i64 %t124, ptr %t123
  %t125 = load i64, ptr %t6
  %t126 = load ptr, ptr %t116
  store i64 %t125, ptr %t126
  %t127 = load i64, ptr %t8
  %t128 = load ptr, ptr %t116
  store i64 %t127, ptr %t128
  %t129 = call i32 @match(ptr %t0, i64 55)
  %t130 = sext i32 %t129 to i64
  %t131 = icmp ne i64 %t130, 0
  br i1 %t131, label %L29, label %L31
L29:
  %t132 = load ptr, ptr %t116
  %t133 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t132, ptr %t133)
  br label %L31
L31:
  br label %L32
L32:
  %t135 = call i32 @match(ptr %t0, i64 79)
  %t136 = sext i32 %t135 to i64
  %t137 = icmp ne i64 %t136, 0
  br i1 %t137, label %L33, label %L34
L33:
  %t138 = alloca ptr
  %t140 = sext i32 0 to i64
  %t139 = inttoptr i64 %t140 to ptr
  store ptr %t139, ptr %t138
  %t141 = alloca ptr
  %t142 = load ptr, ptr %t10
  %t143 = call ptr @parse_declarator(ptr %t0, ptr %t142, ptr %t138)
  store ptr %t143, ptr %t141
  %t144 = alloca ptr
  %t145 = load i64, ptr %t1
  %t146 = call ptr @node_new(i64 2, i64 %t145)
  store ptr %t146, ptr %t144
  %t147 = load ptr, ptr %t138
  %t148 = load ptr, ptr %t144
  store ptr %t147, ptr %t148
  %t149 = load ptr, ptr %t141
  %t150 = load ptr, ptr %t144
  store ptr %t149, ptr %t150
  %t151 = load ptr, ptr %t144
  %t152 = sext i32 1 to i64
  store i64 %t152, ptr %t151
  %t153 = call i32 @match(ptr %t0, i64 55)
  %t154 = sext i32 %t153 to i64
  %t155 = icmp ne i64 %t154, 0
  br i1 %t155, label %L35, label %L37
L35:
  %t156 = load ptr, ptr %t144
  %t157 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t156, ptr %t157)
  br label %L37
L37:
  %t159 = load ptr, ptr %t116
  %t160 = load ptr, ptr %t144
  call void @node_add_child(ptr %t159, ptr %t160)
  br label %L32
L34:
  call void @expect(ptr %t0, i64 78)
  %t163 = load ptr, ptr %t116
  ret ptr %t163
L38:
  ret ptr null
}

define dso_local ptr @parser_new(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @calloc(i64 1, i64 0)
  store ptr %t2, ptr %t1
  %t3 = load ptr, ptr %t1
  %t5 = ptrtoint ptr %t3 to i64
  %t6 = icmp eq i64 %t5, 0
  %t4 = zext i1 %t6 to i64
  %t7 = icmp ne i64 %t4, 0
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = getelementptr [7 x i8], ptr @.str35, i64 0, i64 0
  call void @perror(ptr %t8)
  call void @exit(i64 1)
  br label %L2
L2:
  %t11 = load ptr, ptr %t1
  store ptr %t0, ptr %t11
  %t12 = call i64 @lexer_next(ptr %t0)
  %t13 = load ptr, ptr %t1
  store i64 %t12, ptr %t13
  %t14 = call ptr @calloc(i64 512, i64 8)
  %t15 = load ptr, ptr %t1
  store ptr %t14, ptr %t15
  %t16 = call ptr @calloc(i64 1024, i64 8)
  %t17 = load ptr, ptr %t1
  store ptr %t16, ptr %t17
  %t18 = alloca ptr
  %t19 = sext i32 0 to i64
  store i64 %t19, ptr %t18
  %t20 = alloca ptr
  %t21 = sext i32 0 to i64
  store i64 %t21, ptr %t20
  %t22 = alloca i64
  %t23 = sext i32 0 to i64
  store i64 %t23, ptr %t22
  br label %L3
L3:
  %t24 = load ptr, ptr %t18
  %t25 = load i64, ptr %t22
  %t26 = getelementptr ptr, ptr %t24, i64 %t25
  %t27 = load ptr, ptr %t26
  %t28 = icmp ne ptr %t27, null
  br i1 %t28, label %L4, label %L6
L4:
  %t29 = alloca ptr
  %t30 = load ptr, ptr %t20
  %t31 = load i64, ptr %t22
  %t32 = getelementptr ptr, ptr %t30, i64 %t31
  %t33 = load ptr, ptr %t32
  %t34 = call ptr @type_new(ptr %t33)
  store ptr %t34, ptr %t29
  %t35 = load ptr, ptr %t1
  %t36 = load ptr, ptr %t18
  %t37 = load i64, ptr %t22
  %t38 = getelementptr ptr, ptr %t36, i64 %t37
  %t39 = load ptr, ptr %t38
  %t40 = load ptr, ptr %t29
  call void @register_typedef(ptr %t35, ptr %t39, ptr %t40)
  br label %L5
L5:
  %t42 = load i64, ptr %t22
  %t43 = add i64 %t42, 1
  store i64 %t43, ptr %t22
  br label %L3
L6:
  %t44 = load ptr, ptr %t1
  ret ptr %t44
L7:
  ret ptr null
}

define dso_local void @parser_free(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  call void @token_free(ptr %t1)
  %t3 = alloca i64
  %t4 = sext i32 0 to i64
  store i64 %t4, ptr %t3
  br label %L0
L0:
  %t5 = load i64, ptr %t3
  %t6 = load ptr, ptr %t0
  %t8 = ptrtoint ptr %t6 to i64
  %t7 = icmp slt i64 %t5, %t8
  %t9 = zext i1 %t7 to i64
  %t10 = icmp ne i64 %t9, 0
  br i1 %t10, label %L1, label %L3
L1:
  %t11 = alloca ptr
  %t12 = load ptr, ptr %t0
  %t13 = load i64, ptr %t3
  %t14 = getelementptr ptr, ptr %t12, i64 %t13
  %t15 = load ptr, ptr %t14
  store ptr %t15, ptr %t11
  %t16 = load ptr, ptr %t11
  %t17 = icmp ne ptr %t16, null
  br i1 %t17, label %L4, label %L6
L4:
  %t18 = load ptr, ptr %t11
  %t19 = load ptr, ptr %t18
  call void @free(ptr %t19)
  %t21 = load ptr, ptr %t11
  call void @free(ptr %t21)
  br label %L6
L6:
  br label %L2
L2:
  %t23 = load i64, ptr %t3
  %t24 = add i64 %t23, 1
  store i64 %t24, ptr %t3
  br label %L0
L3:
  %t25 = load ptr, ptr %t0
  call void @free(ptr %t25)
  %t27 = alloca i64
  %t28 = sext i32 0 to i64
  store i64 %t28, ptr %t27
  br label %L7
L7:
  %t29 = load i64, ptr %t27
  %t30 = load ptr, ptr %t0
  %t32 = ptrtoint ptr %t30 to i64
  %t31 = icmp slt i64 %t29, %t32
  %t33 = zext i1 %t31 to i64
  %t34 = icmp ne i64 %t33, 0
  br i1 %t34, label %L8, label %L10
L8:
  %t35 = alloca ptr
  %t36 = load ptr, ptr %t0
  %t37 = load i64, ptr %t27
  %t38 = getelementptr ptr, ptr %t36, i64 %t37
  %t39 = load ptr, ptr %t38
  store ptr %t39, ptr %t35
  %t40 = load ptr, ptr %t35
  %t41 = icmp ne ptr %t40, null
  br i1 %t41, label %L11, label %L13
L11:
  %t42 = load ptr, ptr %t35
  %t43 = load ptr, ptr %t42
  call void @free(ptr %t43)
  %t45 = load ptr, ptr %t35
  call void @free(ptr %t45)
  br label %L13
L13:
  br label %L9
L9:
  %t47 = load i64, ptr %t27
  %t48 = add i64 %t47, 1
  store i64 %t48, ptr %t27
  br label %L7
L10:
  %t49 = load ptr, ptr %t0
  call void @free(ptr %t49)
  call void @free(ptr %t0)
  ret void
}

define dso_local ptr @parser_parse(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = call ptr @node_new(i64 0, i64 0)
  store ptr %t2, ptr %t1
  br label %L0
L0:
  %t3 = call i32 @check(ptr %t0, i64 81)
  %t4 = sext i32 %t3 to i64
  %t6 = icmp eq i64 %t4, 0
  %t5 = zext i1 %t6 to i64
  %t7 = icmp ne i64 %t5, 0
  br i1 %t7, label %L1, label %L2
L1:
  br label %L3
L3:
  %t8 = call i32 @match(ptr %t0, i64 78)
  %t9 = sext i32 %t8 to i64
  %t10 = icmp ne i64 %t9, 0
  br i1 %t10, label %L4, label %L5
L4:
  br label %L3
L5:
  call void @skip_gcc_extension(ptr %t0)
  %t12 = call i32 @check(ptr %t0, i64 81)
  %t13 = sext i32 %t12 to i64
  %t14 = icmp ne i64 %t13, 0
  br i1 %t14, label %L6, label %L8
L6:
  br label %L2
L9:
  br label %L8
L8:
  %t15 = load ptr, ptr %t1
  %t16 = call ptr @parse_toplevel(ptr %t0)
  call void @node_add_child(ptr %t15, ptr %t16)
  br label %L0
L2:
  %t18 = load ptr, ptr %t1
  ret ptr %t18
L10:
  ret ptr null
}

@.str0 = private unnamed_addr constant [38 x i8] c"parse error (line %d): %s (got '%s')\0A\00"
@.str1 = private unnamed_addr constant [2 x i8] c"?\00"
@.str2 = private unnamed_addr constant [12 x i8] c"expected %s\00"
@.str3 = private unnamed_addr constant [20 x i8] c"expected identifier\00"
@.str4 = private unnamed_addr constant [18 x i8] c"too many typedefs\00"
@.str5 = private unnamed_addr constant [14 x i8] c"__attribute__\00"
@.str6 = private unnamed_addr constant [14 x i8] c"__extension__\00"
@.str7 = private unnamed_addr constant [8 x i8] c"__asm__\00"
@.str8 = private unnamed_addr constant [6 x i8] c"__asm\00"
@.str9 = private unnamed_addr constant [11 x i8] c"__inline__\00"
@.str10 = private unnamed_addr constant [9 x i8] c"__inline\00"
@.str11 = private unnamed_addr constant [13 x i8] c"__volatile__\00"
@.str12 = private unnamed_addr constant [11 x i8] c"__volatile\00"
@.str13 = private unnamed_addr constant [11 x i8] c"__restrict\00"
@.str14 = private unnamed_addr constant [13 x i8] c"__restrict__\00"
@.str15 = private unnamed_addr constant [8 x i8] c"__const\00"
@.str16 = private unnamed_addr constant [10 x i8] c"__const__\00"
@.str17 = private unnamed_addr constant [11 x i8] c"__signed__\00"
@.str18 = private unnamed_addr constant [9 x i8] c"__signed\00"
@.str19 = private unnamed_addr constant [11 x i8] c"__typeof__\00"
@.str20 = private unnamed_addr constant [9 x i8] c"__typeof\00"
@.str21 = private unnamed_addr constant [8 x i8] c"__cdecl\00"
@.str22 = private unnamed_addr constant [11 x i8] c"__declspec\00"
@.str23 = private unnamed_addr constant [14 x i8] c"__forceinline\00"
@.str24 = private unnamed_addr constant [10 x i8] c"__nonnull\00"
@.str25 = private unnamed_addr constant [14 x i8] c"__attribute__\00"
@.str26 = private unnamed_addr constant [8 x i8] c"__asm__\00"
@.str27 = private unnamed_addr constant [6 x i8] c"__asm\00"
@.str28 = private unnamed_addr constant [11 x i8] c"__typeof__\00"
@.str29 = private unnamed_addr constant [9 x i8] c"__typeof\00"
@.str30 = private unnamed_addr constant [11 x i8] c"__declspec\00"
@.str31 = private unnamed_addr constant [8 x i8] c"realloc\00"
@.str32 = private unnamed_addr constant [28 x i8] c"expected primary expression\00"
@.str33 = private unnamed_addr constant [7 x i8] c"{init}\00"
@.str34 = private unnamed_addr constant [21 x i8] c"expected declaration\00"
@.str35 = private unnamed_addr constant [7 x i8] c"calloc\00"
