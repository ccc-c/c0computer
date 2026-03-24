; ModuleID = 'parser.c'
source_filename = "parser.c"
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
  %t8 = sext i32 %t5 to i64
  %t9 = ptrtoint ptr %t6 to i64
  %t7 = icmp slt i64 %t8, %t9
  %t10 = zext i1 %t7 to i64
  %t11 = icmp ne i64 %t10, 0
  br i1 %t11, label %L1, label %L3
L1:
  %t12 = alloca ptr
  %t13 = load ptr, ptr %t0
  %t14 = load i64, ptr %t3
  %t15 = sext i32 %t14 to i64
  %t16 = getelementptr ptr, ptr %t13, i64 %t15
  %t17 = load ptr, ptr %t16
  store ptr %t17, ptr %t12
  %t18 = load ptr, ptr %t12
  %t19 = ptrtoint ptr %t18 to i64
  %t20 = icmp ne i64 %t19, 0
  br i1 %t20, label %L4, label %L5
L4:
  %t21 = load ptr, ptr %t12
  %t22 = load ptr, ptr %t21
  %t23 = call i32 @strcmp(ptr %t22, ptr %t1)
  %t24 = sext i32 %t23 to i64
  %t26 = sext i32 0 to i64
  %t25 = icmp eq i64 %t24, %t26
  %t27 = zext i1 %t25 to i64
  %t28 = icmp ne i64 %t27, 0
  %t29 = zext i1 %t28 to i64
  br label %L6
L5:
  br label %L6
L6:
  %t30 = phi i64 [ %t29, %L4 ], [ 0, %L5 ]
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L7, label %L9
L7:
  %t32 = load ptr, ptr %t12
  %t33 = load ptr, ptr %t32
  store ptr %t33, ptr %t2
  %t34 = sext i32 1 to i64
  %t35 = trunc i64 %t34 to i32
  ret i32 %t35
L10:
  br label %L9
L9:
  br label %L2
L2:
  %t36 = load i64, ptr %t3
  %t38 = sext i32 %t36 to i64
  %t37 = add i64 %t38, 1
  store i64 %t37, ptr %t3
  br label %L0
L3:
  %t39 = sext i32 0 to i64
  %t40 = trunc i64 %t39 to i32
  ret i32 %t40
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
  %t12 = call i32 (ptr, ...) @fprintf(ptr %t2, ptr %t3, ptr %t4, ptr %t1, i64 %t11)
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
  %t11 = call i32 (ptr, ...) @snprintf(ptr %t8, i64 8, ptr %t9, ptr %t10)
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
  %t9 = sext i32 %t7 to i64
  %t10 = sext i32 0 to i64
  %t8 = icmp sge i64 %t9, %t10
  %t11 = zext i1 %t8 to i64
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L1, label %L3
L1:
  %t13 = alloca ptr
  %t14 = load ptr, ptr %t0
  %t15 = load i64, ptr %t2
  %t16 = sext i32 %t15 to i64
  %t17 = getelementptr ptr, ptr %t14, i64 %t16
  %t18 = load ptr, ptr %t17
  store ptr %t18, ptr %t13
  %t19 = load ptr, ptr %t13
  %t20 = ptrtoint ptr %t19 to i64
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L4, label %L5
L4:
  %t22 = load ptr, ptr %t13
  %t23 = load ptr, ptr %t22
  %t24 = call i32 @strcmp(ptr %t23, ptr %t1)
  %t25 = sext i32 %t24 to i64
  %t27 = sext i32 0 to i64
  %t26 = icmp eq i64 %t25, %t27
  %t28 = zext i1 %t26 to i64
  %t29 = icmp ne i64 %t28, 0
  %t30 = zext i1 %t29 to i64
  br label %L6
L5:
  br label %L6
L6:
  %t31 = phi i64 [ %t30, %L4 ], [ 0, %L5 ]
  %t32 = icmp ne i64 %t31, 0
  br i1 %t32, label %L7, label %L9
L7:
  %t33 = load ptr, ptr %t13
  %t34 = load ptr, ptr %t33
  ret ptr %t34
L10:
  br label %L9
L9:
  br label %L2
L2:
  %t35 = load i64, ptr %t2
  %t37 = sext i32 %t35 to i64
  %t36 = sub i64 %t37, 1
  store i64 %t36, ptr %t2
  br label %L0
L3:
  %t39 = sext i32 0 to i64
  %t38 = inttoptr i64 %t39 to ptr
  ret ptr %t38
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
  %t79 = sext i32 %t78 to i64
  %t80 = icmp ne i64 %t79, 0
  br i1 %t80, label %L27, label %L28
L27:
  %t81 = call i32 @check(ptr %t0, i64 72)
  %t82 = sext i32 %t81 to i64
  %t83 = icmp ne i64 %t82, 0
  %t84 = zext i1 %t83 to i64
  br label %L29
L28:
  br label %L29
L29:
  %t85 = phi i64 [ %t84, %L27 ], [ 0, %L28 ]
  %t86 = icmp ne i64 %t85, 0
  br i1 %t86, label %L30, label %L32
L30:
  %t87 = alloca i64
  %t88 = sext i32 1 to i64
  store i64 %t88, ptr %t87
  call void @advance(ptr %t0)
  br label %L33
L33:
  %t90 = call i32 @check(ptr %t0, i64 81)
  %t91 = sext i32 %t90 to i64
  %t93 = icmp eq i64 %t91, 0
  %t92 = zext i1 %t93 to i64
  %t94 = icmp ne i64 %t92, 0
  br i1 %t94, label %L36, label %L37
L36:
  %t95 = load i64, ptr %t87
  %t97 = sext i32 %t95 to i64
  %t98 = sext i32 0 to i64
  %t96 = icmp sgt i64 %t97, %t98
  %t99 = zext i1 %t96 to i64
  %t100 = icmp ne i64 %t99, 0
  %t101 = zext i1 %t100 to i64
  br label %L38
L37:
  br label %L38
L38:
  %t102 = phi i64 [ %t101, %L36 ], [ 0, %L37 ]
  %t103 = icmp ne i64 %t102, 0
  br i1 %t103, label %L34, label %L35
L34:
  %t104 = call i32 @check(ptr %t0, i64 72)
  %t105 = sext i32 %t104 to i64
  %t106 = icmp ne i64 %t105, 0
  br i1 %t106, label %L39, label %L40
L39:
  %t107 = load i64, ptr %t87
  %t109 = sext i32 %t107 to i64
  %t108 = add i64 %t109, 1
  store i64 %t108, ptr %t87
  br label %L41
L40:
  %t110 = call i32 @check(ptr %t0, i64 73)
  %t111 = sext i32 %t110 to i64
  %t112 = icmp ne i64 %t111, 0
  br i1 %t112, label %L42, label %L44
L42:
  %t113 = load i64, ptr %t87
  %t115 = sext i32 %t113 to i64
  %t114 = sub i64 %t115, 1
  store i64 %t114, ptr %t87
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
  %t20 = sext i32 %t18 to i64
  %t19 = icmp ne i64 %t20, 0
  br i1 %t19, label %L3, label %L4
L3:
  %t21 = sext i32 19 to i64
  br label %L5
L4:
  %t22 = sext i32 18 to i64
  br label %L5
L5:
  %t23 = phi i64 [ %t21, %L3 ], [ %t22, %L4 ]
  %t24 = call ptr @type_new(i64 %t23)
  store ptr %t24, ptr %t17
  %t25 = load ptr, ptr %t8
  %t26 = load ptr, ptr %t17
  store ptr %t25, ptr %t26
  %t27 = call i32 @check(ptr %t0, i64 74)
  %t28 = sext i32 %t27 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L6, label %L8
L6:
  call void @advance(ptr %t0)
  %t31 = alloca i64
  %t32 = sext i32 1 to i64
  store i64 %t32, ptr %t31
  br label %L9
L9:
  %t33 = call i32 @check(ptr %t0, i64 81)
  %t34 = sext i32 %t33 to i64
  %t36 = icmp eq i64 %t34, 0
  %t35 = zext i1 %t36 to i64
  %t37 = icmp ne i64 %t35, 0
  br i1 %t37, label %L12, label %L13
L12:
  %t38 = load i64, ptr %t31
  %t40 = sext i32 %t38 to i64
  %t41 = sext i32 0 to i64
  %t39 = icmp sgt i64 %t40, %t41
  %t42 = zext i1 %t39 to i64
  %t43 = icmp ne i64 %t42, 0
  %t44 = zext i1 %t43 to i64
  br label %L14
L13:
  br label %L14
L14:
  %t45 = phi i64 [ %t44, %L12 ], [ 0, %L13 ]
  %t46 = icmp ne i64 %t45, 0
  br i1 %t46, label %L10, label %L11
L10:
  %t47 = call i32 @check(ptr %t0, i64 74)
  %t48 = sext i32 %t47 to i64
  %t49 = icmp ne i64 %t48, 0
  br i1 %t49, label %L15, label %L16
L15:
  %t50 = load i64, ptr %t31
  %t52 = sext i32 %t50 to i64
  %t51 = add i64 %t52, 1
  store i64 %t51, ptr %t31
  br label %L17
L16:
  %t53 = call i32 @check(ptr %t0, i64 75)
  %t54 = sext i32 %t53 to i64
  %t55 = icmp ne i64 %t54, 0
  br i1 %t55, label %L18, label %L20
L18:
  %t56 = load i64, ptr %t31
  %t58 = sext i32 %t56 to i64
  %t57 = sub i64 %t58, 1
  store i64 %t57, ptr %t31
  br label %L20
L20:
  br label %L17
L17:
  call void @advance(ptr %t0)
  br label %L9
L11:
  br label %L8
L8:
  %t60 = load ptr, ptr %t17
  ret ptr %t60
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
  %t99 = sext i32 %t97 to i64
  %t98 = icmp ne i64 %t99, 0
  br i1 %t98, label %L42, label %L43
L42:
  %t100 = load i64, ptr %t15
  %t101 = load i64, ptr %t92
  %t102 = sub i64 %t100, %t101
  br label %L44
L43:
  %t103 = load i64, ptr %t15
  %t104 = load i64, ptr %t92
  %t105 = add i64 %t103, %t104
  br label %L44
L44:
  %t106 = phi i64 [ %t102, %L42 ], [ %t105, %L43 ]
  store i64 %t106, ptr %t15
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
  %t108 = load ptr, ptr %t33
  %t109 = load i64, ptr %t15
  %t110 = add i64 %t109, 1
  store i64 %t110, ptr %t15
  call void @register_enum_const(ptr %t0, ptr %t108, i64 %t109)
  %t112 = load ptr, ptr %t33
  call void @free(ptr %t112)
  br label %L14
L13:
  call void @advance(ptr %t0)
  br label %L14
L14:
  %t115 = call i32 @match(ptr %t0, i64 79)
  %t116 = sext i32 %t115 to i64
  %t118 = icmp eq i64 %t116, 0
  %t117 = zext i1 %t118 to i64
  %t119 = icmp ne i64 %t117, 0
  br i1 %t119, label %L45, label %L47
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
  %t121 = load ptr, ptr %t2
  ret ptr %t121
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
  %t63 = sext i32 %t61 to i64
  %t62 = icmp ne i64 %t63, 0
  br i1 %t62, label %L39, label %L40
L39:
  %t64 = sext i32 1 to i64
  store i64 %t64, ptr %t20
  br label %L41
L40:
  %t65 = sext i32 1 to i64
  store i64 %t65, ptr %t18
  br label %L41
L41:
  call void @advance(ptr %t0)
  br label %L11
L42:
  br label %L21
L21:
  %t67 = sext i32 0 to i64
  store i64 %t67, ptr %t24
  %t68 = sext i32 1 to i64
  store i64 %t68, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L43:
  br label %L22
L22:
  %t70 = sext i32 2 to i64
  store i64 %t70, ptr %t24
  %t71 = sext i32 1 to i64
  store i64 %t71, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L44:
  br label %L23
L23:
  %t73 = sext i32 7 to i64
  store i64 %t73, ptr %t24
  %t74 = sext i32 1 to i64
  store i64 %t74, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L45:
  br label %L24
L24:
  %t76 = sext i32 13 to i64
  store i64 %t76, ptr %t24
  %t77 = sext i32 1 to i64
  store i64 %t77, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L46:
  br label %L25
L25:
  %t79 = sext i32 14 to i64
  store i64 %t79, ptr %t24
  %t80 = sext i32 1 to i64
  store i64 %t80, ptr %t26
  call void @advance(ptr %t0)
  br label %L11
L47:
  br label %L26
L26:
  br label %L27
L27:
  %t82 = call ptr @parse_struct_union(ptr %t0)
  store ptr %t82, ptr %t28
  %t83 = sext i32 1 to i64
  store i64 %t83, ptr %t26
  br label %parse_type_done
L48:
  br label %L28
L28:
  %t84 = call ptr @parse_enum_specifier(ptr %t0)
  store ptr %t84, ptr %t28
  %t85 = sext i32 1 to i64
  store i64 %t85, ptr %t26
  br label %parse_type_done
L49:
  br label %L29
L29:
  %t86 = alloca ptr
  %t87 = load ptr, ptr %t0
  %t88 = call ptr @lookup_typedef(ptr %t0, ptr %t87)
  store ptr %t88, ptr %t86
  %t89 = load ptr, ptr %t86
  %t90 = icmp ne ptr %t89, null
  br i1 %t90, label %L50, label %L52
L50:
  %t91 = call ptr @type_new(i64 21)
  store ptr %t91, ptr %t28
  %t92 = load ptr, ptr %t0
  %t93 = call ptr @strdup(ptr %t92)
  %t94 = load ptr, ptr %t28
  store ptr %t93, ptr %t94
  %t95 = sext i32 1 to i64
  store i64 %t95, ptr %t26
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
  %t97 = icmp ne ptr %t1, null
  br i1 %t97, label %L56, label %L58
L56:
  %t98 = load i64, ptr %t4
  %t99 = sext i32 %t98 to i64
  store i64 %t99, ptr %t1
  br label %L58
L58:
  %t100 = icmp ne ptr %t2, null
  br i1 %t100, label %L59, label %L61
L59:
  %t101 = load i64, ptr %t6
  %t102 = sext i32 %t101 to i64
  store i64 %t102, ptr %t2
  br label %L61
L61:
  %t103 = icmp ne ptr %t3, null
  br i1 %t103, label %L62, label %L64
L62:
  %t104 = load i64, ptr %t8
  %t105 = sext i32 %t104 to i64
  store i64 %t105, ptr %t3
  br label %L64
L64:
  %t106 = load ptr, ptr %t28
  %t107 = icmp ne ptr %t106, null
  br i1 %t107, label %L65, label %L67
L65:
  %t108 = load i64, ptr %t10
  %t109 = load ptr, ptr %t28
  %t110 = sext i32 %t108 to i64
  store i64 %t110, ptr %t109
  %t111 = load i64, ptr %t12
  %t112 = load ptr, ptr %t28
  %t113 = sext i32 %t111 to i64
  store i64 %t113, ptr %t112
  %t114 = load ptr, ptr %t28
  ret ptr %t114
L68:
  br label %L67
L67:
  %t115 = load i64, ptr %t26
  %t117 = sext i32 %t115 to i64
  %t118 = icmp eq i64 %t117, 0
  %t116 = zext i1 %t118 to i64
  %t119 = icmp ne i64 %t116, 0
  br i1 %t119, label %L69, label %L70
L69:
  %t120 = load i64, ptr %t18
  %t122 = sext i32 %t120 to i64
  %t123 = icmp eq i64 %t122, 0
  %t121 = zext i1 %t123 to i64
  %t124 = icmp ne i64 %t121, 0
  %t125 = zext i1 %t124 to i64
  br label %L71
L70:
  br label %L71
L71:
  %t126 = phi i64 [ %t125, %L69 ], [ 0, %L70 ]
  %t127 = icmp ne i64 %t126, 0
  br i1 %t127, label %L72, label %L73
L72:
  %t128 = load i64, ptr %t22
  %t130 = sext i32 %t128 to i64
  %t131 = icmp eq i64 %t130, 0
  %t129 = zext i1 %t131 to i64
  %t132 = icmp ne i64 %t129, 0
  %t133 = zext i1 %t132 to i64
  br label %L74
L73:
  br label %L74
L74:
  %t134 = phi i64 [ %t133, %L72 ], [ 0, %L73 ]
  %t135 = icmp ne i64 %t134, 0
  br i1 %t135, label %L75, label %L76
L75:
  %t136 = load i64, ptr %t14
  %t138 = sext i32 %t136 to i64
  %t139 = icmp eq i64 %t138, 0
  %t137 = zext i1 %t139 to i64
  %t140 = icmp ne i64 %t137, 0
  %t141 = zext i1 %t140 to i64
  br label %L77
L76:
  br label %L77
L77:
  %t142 = phi i64 [ %t141, %L75 ], [ 0, %L76 ]
  %t143 = icmp ne i64 %t142, 0
  br i1 %t143, label %L78, label %L79
L78:
  %t144 = load i64, ptr %t16
  %t146 = sext i32 %t144 to i64
  %t147 = icmp eq i64 %t146, 0
  %t145 = zext i1 %t147 to i64
  %t148 = icmp ne i64 %t145, 0
  %t149 = zext i1 %t148 to i64
  br label %L80
L79:
  br label %L80
L80:
  %t150 = phi i64 [ %t149, %L78 ], [ 0, %L79 ]
  %t151 = icmp ne i64 %t150, 0
  br i1 %t151, label %L81, label %L83
L81:
  %t153 = sext i32 0 to i64
  %t152 = inttoptr i64 %t153 to ptr
  ret ptr %t152
L84:
  br label %L83
L83:
  %t154 = load i64, ptr %t24
  %t156 = sext i32 %t154 to i64
  %t157 = sext i32 2 to i64
  %t155 = icmp eq i64 %t156, %t157
  %t158 = zext i1 %t155 to i64
  %t159 = icmp ne i64 %t158, 0
  br i1 %t159, label %L85, label %L86
L85:
  %t160 = load i64, ptr %t14
  %t162 = sext i32 %t160 to i64
  %t161 = icmp ne i64 %t162, 0
  br i1 %t161, label %L88, label %L89
L88:
  %t163 = sext i32 4 to i64
  store i64 %t163, ptr %t24
  br label %L90
L89:
  %t164 = load i64, ptr %t16
  %t166 = sext i32 %t164 to i64
  %t165 = icmp ne i64 %t166, 0
  br i1 %t165, label %L91, label %L93
L91:
  %t167 = sext i32 3 to i64
  store i64 %t167, ptr %t24
  br label %L93
L93:
  br label %L90
L90:
  br label %L87
L86:
  %t168 = load i64, ptr %t20
  %t170 = sext i32 %t168 to i64
  %t169 = icmp ne i64 %t170, 0
  br i1 %t169, label %L94, label %L95
L94:
  %t171 = load i64, ptr %t14
  %t173 = sext i32 %t171 to i64
  %t172 = icmp ne i64 %t173, 0
  br i1 %t172, label %L97, label %L98
L97:
  %t174 = sext i32 12 to i64
  br label %L99
L98:
  %t175 = sext i32 11 to i64
  br label %L99
L99:
  %t176 = phi i64 [ %t174, %L97 ], [ %t175, %L98 ]
  store i64 %t176, ptr %t24
  br label %L96
L95:
  %t177 = load i64, ptr %t18
  %t179 = sext i32 %t177 to i64
  %t178 = icmp ne i64 %t179, 0
  br i1 %t178, label %L100, label %L101
L100:
  %t180 = load i64, ptr %t14
  %t182 = sext i32 %t180 to i64
  %t181 = icmp ne i64 %t182, 0
  br i1 %t181, label %L103, label %L104
L103:
  %t183 = sext i32 10 to i64
  br label %L105
L104:
  %t184 = sext i32 9 to i64
  br label %L105
L105:
  %t185 = phi i64 [ %t183, %L103 ], [ %t184, %L104 ]
  store i64 %t185, ptr %t24
  br label %L102
L101:
  %t186 = load i64, ptr %t22
  %t188 = sext i32 %t186 to i64
  %t187 = icmp ne i64 %t188, 0
  br i1 %t187, label %L106, label %L107
L106:
  %t189 = load i64, ptr %t14
  %t191 = sext i32 %t189 to i64
  %t190 = icmp ne i64 %t191, 0
  br i1 %t190, label %L109, label %L110
L109:
  %t192 = sext i32 6 to i64
  br label %L111
L110:
  %t193 = sext i32 5 to i64
  br label %L111
L111:
  %t194 = phi i64 [ %t192, %L109 ], [ %t193, %L110 ]
  store i64 %t194, ptr %t24
  br label %L108
L107:
  %t195 = load i64, ptr %t24
  %t197 = sext i32 %t195 to i64
  %t198 = sext i32 7 to i64
  %t196 = icmp eq i64 %t197, %t198
  %t199 = zext i1 %t196 to i64
  %t200 = icmp ne i64 %t199, 0
  br i1 %t200, label %L112, label %L113
L112:
  br label %L114
L113:
  %t201 = load i64, ptr %t26
  %t203 = sext i32 %t201 to i64
  %t204 = icmp eq i64 %t203, 0
  %t202 = zext i1 %t204 to i64
  %t205 = icmp ne i64 %t202, 0
  %t206 = zext i1 %t205 to i64
  br label %L114
L114:
  %t207 = phi i64 [ 1, %L112 ], [ %t206, %L113 ]
  %t208 = icmp ne i64 %t207, 0
  br i1 %t208, label %L115, label %L117
L115:
  %t209 = load i64, ptr %t14
  %t211 = sext i32 %t209 to i64
  %t210 = icmp ne i64 %t211, 0
  br i1 %t210, label %L118, label %L120
L118:
  %t212 = sext i32 8 to i64
  store i64 %t212, ptr %t24
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
  %t213 = alloca ptr
  %t214 = load i64, ptr %t24
  %t215 = call ptr @type_new(i64 %t214)
  store ptr %t215, ptr %t213
  %t216 = load i64, ptr %t10
  %t217 = load ptr, ptr %t213
  %t218 = sext i32 %t216 to i64
  store i64 %t218, ptr %t217
  %t219 = load i64, ptr %t12
  %t220 = load ptr, ptr %t213
  %t221 = sext i32 %t219 to i64
  store i64 %t221, ptr %t220
  %t222 = load ptr, ptr %t213
  ret ptr %t222
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
  %t12 = sext i32 %t10 to i64
  %t13 = sext i32 16 to i64
  %t11 = icmp slt i64 %t12, %t13
  %t14 = zext i1 %t11 to i64
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
  call void @advance(ptr %t0)
  %t20 = load ptr, ptr %t5
  %t21 = load i64, ptr %t3
  %t23 = sext i32 %t21 to i64
  %t22 = getelementptr ptr, ptr %t20, i64 %t23
  %t24 = sext i32 0 to i64
  store i64 %t24, ptr %t22
  br label %L6
L6:
  %t25 = call i32 @check(ptr %t0, i64 32)
  %t26 = sext i32 %t25 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L9, label %L10
L9:
  br label %L11
L10:
  %t28 = call i32 @check(ptr %t0, i64 33)
  %t29 = sext i32 %t28 to i64
  %t30 = icmp ne i64 %t29, 0
  %t31 = zext i1 %t30 to i64
  br label %L11
L11:
  %t32 = phi i64 [ 1, %L9 ], [ %t31, %L10 ]
  %t33 = icmp ne i64 %t32, 0
  br i1 %t33, label %L7, label %L8
L7:
  %t34 = call i32 @check(ptr %t0, i64 32)
  %t35 = sext i32 %t34 to i64
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L12, label %L14
L12:
  %t37 = load ptr, ptr %t5
  %t38 = load i64, ptr %t3
  %t40 = sext i32 %t38 to i64
  %t39 = getelementptr ptr, ptr %t37, i64 %t40
  %t41 = sext i32 1 to i64
  store i64 %t41, ptr %t39
  br label %L14
L14:
  call void @advance(ptr %t0)
  br label %L6
L8:
  %t43 = load i64, ptr %t3
  %t45 = sext i32 %t43 to i64
  %t44 = add i64 %t45, 1
  store i64 %t44, ptr %t3
  br label %L0
L2:
  %t46 = alloca i64
  %t47 = load i64, ptr %t3
  %t49 = sext i32 %t47 to i64
  %t50 = sext i32 1 to i64
  %t48 = sub i64 %t49, %t50
  store i64 %t48, ptr %t46
  br label %L15
L15:
  %t51 = load i64, ptr %t46
  %t53 = sext i32 %t51 to i64
  %t54 = sext i32 0 to i64
  %t52 = icmp sge i64 %t53, %t54
  %t55 = zext i1 %t52 to i64
  %t56 = icmp ne i64 %t55, 0
  br i1 %t56, label %L16, label %L18
L16:
  %t57 = alloca ptr
  %t58 = call ptr @type_ptr(ptr %t1)
  store ptr %t58, ptr %t57
  %t59 = load ptr, ptr %t5
  %t60 = load i64, ptr %t46
  %t61 = sext i32 %t60 to i64
  %t62 = getelementptr ptr, ptr %t59, i64 %t61
  %t63 = load ptr, ptr %t62
  %t64 = load ptr, ptr %t57
  store ptr %t63, ptr %t64
  %t65 = load ptr, ptr %t57
  store ptr %t65, ptr %t1
  br label %L17
L17:
  %t66 = load i64, ptr %t46
  %t68 = sext i32 %t66 to i64
  %t67 = sub i64 %t68, 1
  store i64 %t67, ptr %t46
  br label %L15
L18:
  %t69 = icmp ne ptr %t2, null
  br i1 %t69, label %L19, label %L21
L19:
  %t71 = sext i32 0 to i64
  %t70 = inttoptr i64 %t71 to ptr
  store ptr %t70, ptr %t2
  br label %L21
L21:
  call void @skip_gcc_extension(ptr %t0)
  %t73 = call i32 @check(ptr %t0, i64 4)
  %t74 = sext i32 %t73 to i64
  %t75 = icmp ne i64 %t74, 0
  br i1 %t75, label %L22, label %L23
L22:
  %t76 = load ptr, ptr %t0
  %t77 = call i32 @is_gcc_extension(ptr %t76)
  %t78 = sext i32 %t77 to i64
  %t80 = icmp eq i64 %t78, 0
  %t79 = zext i1 %t80 to i64
  %t81 = icmp ne i64 %t79, 0
  %t82 = zext i1 %t81 to i64
  br label %L24
L23:
  br label %L24
L24:
  %t83 = phi i64 [ %t82, %L22 ], [ 0, %L23 ]
  %t84 = icmp ne i64 %t83, 0
  br i1 %t84, label %L25, label %L26
L25:
  %t85 = icmp ne ptr %t2, null
  br i1 %t85, label %L28, label %L30
L28:
  %t86 = load ptr, ptr %t0
  %t87 = call ptr @strdup(ptr %t86)
  store ptr %t87, ptr %t2
  br label %L30
L30:
  call void @advance(ptr %t0)
  br label %L27
L26:
  %t89 = call i32 @check(ptr %t0, i64 72)
  %t90 = sext i32 %t89 to i64
  %t91 = icmp ne i64 %t90, 0
  br i1 %t91, label %L31, label %L33
L31:
  call void @advance(ptr %t0)
  %t93 = call ptr @parse_declarator(ptr %t0, ptr %t1, ptr %t2)
  store ptr %t93, ptr %t1
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
  %t96 = call i32 @check(ptr %t0, i64 4)
  %t97 = sext i32 %t96 to i64
  %t98 = icmp ne i64 %t97, 0
  br i1 %t98, label %L38, label %L39
L38:
  %t99 = load ptr, ptr %t0
  %t100 = call i32 @is_gcc_extension(ptr %t99)
  %t101 = sext i32 %t100 to i64
  %t102 = icmp ne i64 %t101, 0
  %t103 = zext i1 %t102 to i64
  br label %L40
L39:
  br label %L40
L40:
  %t104 = phi i64 [ %t103, %L38 ], [ 0, %L39 ]
  %t105 = icmp ne i64 %t104, 0
  br i1 %t105, label %L41, label %L43
L41:
  call void @skip_gcc_extension(ptr %t0)
  br label %L36
L44:
  br label %L43
L43:
  %t107 = call i32 @check(ptr %t0, i64 76)
  %t108 = sext i32 %t107 to i64
  %t109 = icmp ne i64 %t108, 0
  br i1 %t109, label %L45, label %L46
L45:
  call void @advance(ptr %t0)
  %t111 = alloca i64
  %t113 = sext i32 1 to i64
  %t112 = sub i64 0, %t113
  store i64 %t112, ptr %t111
  %t114 = call i32 @check(ptr %t0, i64 77)
  %t115 = sext i32 %t114 to i64
  %t117 = icmp eq i64 %t115, 0
  %t116 = zext i1 %t117 to i64
  %t118 = icmp ne i64 %t116, 0
  br i1 %t118, label %L48, label %L50
L48:
  %t119 = call i32 @check(ptr %t0, i64 0)
  %t120 = sext i32 %t119 to i64
  %t121 = icmp ne i64 %t120, 0
  br i1 %t121, label %L51, label %L52
L51:
  %t122 = load ptr, ptr %t0
  %t123 = call i64 @atol(ptr %t122)
  %t124 = add i64 %t123, 0
  store i64 %t124, ptr %t111
  call void @advance(ptr %t0)
  br label %L53
L52:
  %t126 = alloca i64
  %t127 = sext i32 0 to i64
  store i64 %t127, ptr %t126
  br label %L54
L54:
  %t128 = call i32 @check(ptr %t0, i64 81)
  %t129 = sext i32 %t128 to i64
  %t131 = icmp eq i64 %t129, 0
  %t130 = zext i1 %t131 to i64
  %t132 = icmp ne i64 %t130, 0
  br i1 %t132, label %L55, label %L56
L55:
  %t133 = call i32 @check(ptr %t0, i64 76)
  %t134 = sext i32 %t133 to i64
  %t135 = icmp ne i64 %t134, 0
  br i1 %t135, label %L57, label %L59
L57:
  %t136 = load i64, ptr %t126
  %t138 = sext i32 %t136 to i64
  %t137 = add i64 %t138, 1
  store i64 %t137, ptr %t126
  br label %L59
L59:
  %t139 = call i32 @check(ptr %t0, i64 77)
  %t140 = sext i32 %t139 to i64
  %t141 = icmp ne i64 %t140, 0
  br i1 %t141, label %L60, label %L62
L60:
  %t142 = load i64, ptr %t126
  %t144 = sext i32 %t142 to i64
  %t145 = sext i32 0 to i64
  %t143 = icmp eq i64 %t144, %t145
  %t146 = zext i1 %t143 to i64
  %t147 = icmp ne i64 %t146, 0
  br i1 %t147, label %L63, label %L65
L63:
  br label %L56
L66:
  br label %L65
L65:
  %t148 = load i64, ptr %t126
  %t150 = sext i32 %t148 to i64
  %t149 = sub i64 %t150, 1
  store i64 %t149, ptr %t126
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
  %t153 = load i64, ptr %t111
  %t154 = call ptr @type_array(ptr %t1, i64 %t153)
  store ptr %t154, ptr %t1
  br label %L47
L46:
  %t155 = call i32 @check(ptr %t0, i64 72)
  %t156 = sext i32 %t155 to i64
  %t157 = icmp ne i64 %t156, 0
  br i1 %t157, label %L67, label %L68
L67:
  call void @advance(ptr %t0)
  %t159 = alloca ptr
  %t160 = call ptr @type_new(i64 17)
  store ptr %t160, ptr %t159
  %t161 = load ptr, ptr %t159
  store ptr %t1, ptr %t161
  %t162 = alloca ptr
  %t164 = sext i32 0 to i64
  %t163 = inttoptr i64 %t164 to ptr
  store ptr %t163, ptr %t162
  %t165 = alloca i64
  %t166 = sext i32 0 to i64
  store i64 %t166, ptr %t165
  %t167 = alloca i64
  %t168 = sext i32 0 to i64
  store i64 %t168, ptr %t167
  br label %L70
L70:
  %t169 = call i32 @check(ptr %t0, i64 73)
  %t170 = sext i32 %t169 to i64
  %t172 = icmp eq i64 %t170, 0
  %t171 = zext i1 %t172 to i64
  %t173 = icmp ne i64 %t171, 0
  br i1 %t173, label %L73, label %L74
L73:
  %t174 = call i32 @check(ptr %t0, i64 81)
  %t175 = sext i32 %t174 to i64
  %t177 = icmp eq i64 %t175, 0
  %t176 = zext i1 %t177 to i64
  %t178 = icmp ne i64 %t176, 0
  %t179 = zext i1 %t178 to i64
  br label %L75
L74:
  br label %L75
L75:
  %t180 = phi i64 [ %t179, %L73 ], [ 0, %L74 ]
  %t181 = icmp ne i64 %t180, 0
  br i1 %t181, label %L71, label %L72
L71:
  %t182 = call i32 @check(ptr %t0, i64 80)
  %t183 = sext i32 %t182 to i64
  %t184 = icmp ne i64 %t183, 0
  br i1 %t184, label %L76, label %L78
L76:
  %t185 = sext i32 1 to i64
  store i64 %t185, ptr %t167
  call void @advance(ptr %t0)
  br label %L72
L79:
  br label %L78
L78:
  %t187 = alloca i64
  %t188 = sext i32 0 to i64
  store i64 %t188, ptr %t187
  %t189 = alloca i64
  %t190 = sext i32 0 to i64
  store i64 %t190, ptr %t189
  %t191 = alloca i64
  %t192 = sext i32 0 to i64
  store i64 %t192, ptr %t191
  %t193 = alloca ptr
  %t194 = call ptr @parse_type_specifier(ptr %t0, ptr %t187, ptr %t189, ptr %t191)
  store ptr %t194, ptr %t193
  %t195 = load ptr, ptr %t193
  %t197 = ptrtoint ptr %t195 to i64
  %t198 = icmp eq i64 %t197, 0
  %t196 = zext i1 %t198 to i64
  %t199 = icmp ne i64 %t196, 0
  br i1 %t199, label %L80, label %L82
L80:
  br label %L72
L83:
  br label %L82
L82:
  %t200 = alloca ptr
  %t202 = sext i32 0 to i64
  %t201 = inttoptr i64 %t202 to ptr
  store ptr %t201, ptr %t200
  %t203 = load ptr, ptr %t193
  %t204 = call ptr @parse_declarator(ptr %t0, ptr %t203, ptr %t200)
  store ptr %t204, ptr %t193
  %t205 = load ptr, ptr %t162
  %t206 = load i64, ptr %t165
  %t208 = sext i32 %t206 to i64
  %t209 = sext i32 1 to i64
  %t207 = add i64 %t208, %t209
  %t211 = sext i32 0 to i64
  %t210 = mul i64 %t207, %t211
  %t212 = call ptr @realloc(ptr %t205, i64 %t210)
  store ptr %t212, ptr %t162
  %t213 = load ptr, ptr %t162
  %t215 = ptrtoint ptr %t213 to i64
  %t216 = icmp eq i64 %t215, 0
  %t214 = zext i1 %t216 to i64
  %t217 = icmp ne i64 %t214, 0
  br i1 %t217, label %L84, label %L86
L84:
  %t218 = getelementptr [8 x i8], ptr @.str31, i64 0, i64 0
  call void @perror(ptr %t218)
  call void @exit(i64 1)
  br label %L86
L86:
  %t221 = load ptr, ptr %t200
  %t222 = load ptr, ptr %t162
  %t223 = load i64, ptr %t165
  %t225 = sext i32 %t223 to i64
  %t224 = getelementptr ptr, ptr %t222, i64 %t225
  store ptr %t221, ptr %t224
  %t226 = load ptr, ptr %t193
  %t227 = load ptr, ptr %t162
  %t228 = load i64, ptr %t165
  %t230 = sext i32 %t228 to i64
  %t229 = getelementptr ptr, ptr %t227, i64 %t230
  store ptr %t226, ptr %t229
  %t231 = load i64, ptr %t165
  %t233 = sext i32 %t231 to i64
  %t232 = add i64 %t233, 1
  store i64 %t232, ptr %t165
  %t234 = call i32 @match(ptr %t0, i64 79)
  %t235 = sext i32 %t234 to i64
  %t237 = icmp eq i64 %t235, 0
  %t236 = zext i1 %t237 to i64
  %t238 = icmp ne i64 %t236, 0
  br i1 %t238, label %L87, label %L89
L87:
  br label %L72
L90:
  br label %L89
L89:
  br label %L70
L72:
  call void @expect(ptr %t0, i64 73)
  %t240 = load ptr, ptr %t162
  %t241 = load ptr, ptr %t159
  store ptr %t240, ptr %t241
  %t242 = load i64, ptr %t165
  %t243 = load ptr, ptr %t159
  %t244 = sext i32 %t242 to i64
  store i64 %t244, ptr %t243
  %t245 = load i64, ptr %t167
  %t246 = load ptr, ptr %t159
  %t247 = sext i32 %t245 to i64
  store i64 %t247, ptr %t246
  %t248 = load ptr, ptr %t159
  store ptr %t248, ptr %t1
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
  %t97 = sext i32 %t95 to i64
  %t98 = sext i32 1 to i64
  %t96 = add i64 %t97, %t98
  %t99 = call ptr @malloc(i64 %t96)
  store ptr %t99, ptr %t94
  %t100 = load ptr, ptr %t94
  %t101 = load ptr, ptr %t0
  %t102 = load i64, ptr %t91
  %t104 = sext i32 %t102 to i64
  %t105 = sext i32 1 to i64
  %t103 = sub i64 %t104, %t105
  %t106 = call ptr @memcpy(ptr %t100, ptr %t101, i64 %t103)
  %t107 = load ptr, ptr %t94
  %t108 = load i64, ptr %t91
  %t110 = sext i32 %t108 to i64
  %t111 = sext i32 1 to i64
  %t109 = sub i64 %t110, %t111
  %t112 = getelementptr ptr, ptr %t107, i64 %t109
  %t113 = sext i32 0 to i64
  store i64 %t113, ptr %t112
  call void @advance(ptr %t0)
  br label %L32
L32:
  %t115 = call i32 @check(ptr %t0, i64 3)
  %t116 = sext i32 %t115 to i64
  %t117 = icmp ne i64 %t116, 0
  br i1 %t117, label %L33, label %L34
L33:
  %t118 = alloca ptr
  %t119 = load ptr, ptr %t0
  %t121 = ptrtoint ptr %t119 to i64
  %t122 = sext i32 1 to i64
  %t123 = inttoptr i64 %t121 to ptr
  %t120 = getelementptr i8, ptr %t123, i64 %t122
  store ptr %t120, ptr %t118
  %t124 = alloca i64
  %t125 = load ptr, ptr %t118
  %t126 = call i64 @strlen(ptr %t125)
  store i64 %t126, ptr %t124
  %t127 = alloca i64
  %t128 = load ptr, ptr %t94
  %t129 = call i64 @strlen(ptr %t128)
  store i64 %t129, ptr %t127
  %t130 = load ptr, ptr %t94
  %t131 = load i64, ptr %t127
  %t132 = load i64, ptr %t124
  %t134 = sext i32 %t131 to i64
  %t135 = sext i32 %t132 to i64
  %t133 = add i64 %t134, %t135
  %t137 = sext i32 1 to i64
  %t136 = add i64 %t133, %t137
  %t138 = call ptr @realloc(ptr %t130, i64 %t136)
  store ptr %t138, ptr %t94
  %t139 = load ptr, ptr %t94
  %t140 = load i64, ptr %t127
  %t142 = ptrtoint ptr %t139 to i64
  %t143 = sext i32 %t140 to i64
  %t144 = inttoptr i64 %t142 to ptr
  %t141 = getelementptr i8, ptr %t144, i64 %t143
  %t145 = load ptr, ptr %t118
  %t146 = load i64, ptr %t124
  %t147 = call ptr @memcpy(ptr %t141, ptr %t145, i64 %t146)
  %t148 = load ptr, ptr %t94
  %t149 = load i64, ptr %t127
  %t150 = load i64, ptr %t124
  %t152 = sext i32 %t149 to i64
  %t153 = sext i32 %t150 to i64
  %t151 = add i64 %t152, %t153
  %t154 = getelementptr ptr, ptr %t148, i64 %t151
  %t155 = sext i32 0 to i64
  store i64 %t155, ptr %t154
  call void @advance(ptr %t0)
  br label %L32
L34:
  %t157 = alloca i64
  %t158 = load ptr, ptr %t94
  %t159 = call i64 @strlen(ptr %t158)
  store i64 %t159, ptr %t157
  %t160 = load ptr, ptr %t94
  %t161 = load i64, ptr %t157
  %t163 = sext i32 %t161 to i64
  %t164 = sext i32 2 to i64
  %t162 = add i64 %t163, %t164
  %t165 = call ptr @realloc(ptr %t160, i64 %t162)
  store ptr %t165, ptr %t94
  %t166 = load ptr, ptr %t94
  %t167 = load i64, ptr %t157
  %t169 = sext i32 %t167 to i64
  %t168 = getelementptr ptr, ptr %t166, i64 %t169
  %t170 = sext i32 34 to i64
  store i64 %t170, ptr %t168
  %t171 = load ptr, ptr %t94
  %t172 = load i64, ptr %t157
  %t174 = sext i32 %t172 to i64
  %t175 = sext i32 1 to i64
  %t173 = add i64 %t174, %t175
  %t176 = getelementptr ptr, ptr %t171, i64 %t173
  %t177 = sext i32 0 to i64
  store i64 %t177, ptr %t176
  %t178 = load ptr, ptr %t94
  %t179 = load ptr, ptr %t88
  store ptr %t178, ptr %t179
  %t180 = load ptr, ptr %t88
  ret ptr %t180
L35:
  br label %L31
L31:
  %t181 = call i32 @check(ptr %t0, i64 4)
  %t182 = sext i32 %t181 to i64
  %t183 = icmp ne i64 %t182, 0
  br i1 %t183, label %L36, label %L38
L36:
  %t184 = alloca i64
  %t185 = load ptr, ptr %t0
  %t186 = call i32 @lookup_enum_const(ptr %t0, ptr %t185, ptr %t184)
  %t187 = sext i32 %t186 to i64
  %t188 = icmp ne i64 %t187, 0
  br i1 %t188, label %L39, label %L41
L39:
  %t189 = alloca ptr
  %t190 = load i64, ptr %t1
  %t191 = call ptr @node_new(i64 19, i64 %t190)
  store ptr %t191, ptr %t189
  %t192 = load i64, ptr %t184
  %t193 = load ptr, ptr %t189
  store i64 %t192, ptr %t193
  call void @advance(ptr %t0)
  %t195 = load ptr, ptr %t189
  ret ptr %t195
L42:
  br label %L41
L41:
  %t196 = alloca ptr
  %t197 = load i64, ptr %t1
  %t198 = call ptr @node_new(i64 23, i64 %t197)
  store ptr %t198, ptr %t196
  %t199 = load ptr, ptr %t0
  %t200 = call ptr @strdup(ptr %t199)
  %t201 = load ptr, ptr %t196
  store ptr %t200, ptr %t201
  call void @advance(ptr %t0)
  %t203 = load ptr, ptr %t196
  ret ptr %t203
L43:
  br label %L38
L38:
  %t204 = call i32 @match(ptr %t0, i64 72)
  %t205 = sext i32 %t204 to i64
  %t206 = icmp ne i64 %t205, 0
  br i1 %t206, label %L44, label %L46
L44:
  %t207 = call i32 @is_type_start(ptr %t0)
  %t208 = sext i32 %t207 to i64
  %t209 = icmp ne i64 %t208, 0
  br i1 %t209, label %L47, label %L49
L47:
  %t210 = alloca i64
  %t211 = sext i32 0 to i64
  store i64 %t211, ptr %t210
  %t212 = alloca i64
  %t213 = sext i32 0 to i64
  store i64 %t213, ptr %t212
  %t214 = alloca i64
  %t215 = sext i32 0 to i64
  store i64 %t215, ptr %t214
  %t216 = alloca ptr
  %t217 = call ptr @parse_type_specifier(ptr %t0, ptr %t210, ptr %t212, ptr %t214)
  store ptr %t217, ptr %t216
  %t218 = load ptr, ptr %t216
  %t219 = icmp ne ptr %t218, null
  br i1 %t219, label %L50, label %L52
L50:
  %t220 = alloca ptr
  %t222 = sext i32 0 to i64
  %t221 = inttoptr i64 %t222 to ptr
  store ptr %t221, ptr %t220
  %t223 = load ptr, ptr %t216
  %t224 = call ptr @parse_declarator(ptr %t0, ptr %t223, ptr %t220)
  store ptr %t224, ptr %t216
  %t225 = load ptr, ptr %t220
  call void @free(ptr %t225)
  %t227 = call i32 @match(ptr %t0, i64 73)
  %t228 = sext i32 %t227 to i64
  %t229 = icmp ne i64 %t228, 0
  br i1 %t229, label %L53, label %L55
L53:
  %t230 = alloca ptr
  %t231 = load i64, ptr %t1
  %t232 = call ptr @node_new(i64 29, i64 %t231)
  store ptr %t232, ptr %t230
  %t233 = load ptr, ptr %t216
  %t234 = load ptr, ptr %t230
  store ptr %t233, ptr %t234
  %t235 = call ptr @parse_cast(ptr %t0)
  %t236 = load ptr, ptr %t230
  store ptr %t235, ptr %t236
  %t237 = load ptr, ptr %t230
  ret ptr %t237
L56:
  br label %L55
L55:
  br label %L52
L52:
  br label %L49
L49:
  %t238 = alloca ptr
  %t239 = call ptr @parse_expr(ptr %t0)
  store ptr %t239, ptr %t238
  call void @expect(ptr %t0, i64 73)
  %t241 = load ptr, ptr %t238
  ret ptr %t241
L57:
  br label %L46
L46:
  %t242 = call i32 @check(ptr %t0, i64 34)
  %t243 = sext i32 %t242 to i64
  %t244 = icmp ne i64 %t243, 0
  br i1 %t244, label %L58, label %L60
L58:
  call void @advance(ptr %t0)
  %t246 = call i32 @match(ptr %t0, i64 72)
  %t247 = sext i32 %t246 to i64
  %t248 = icmp ne i64 %t247, 0
  br i1 %t248, label %L61, label %L63
L61:
  %t249 = call i32 @is_type_start(ptr %t0)
  %t250 = sext i32 %t249 to i64
  %t251 = icmp ne i64 %t250, 0
  br i1 %t251, label %L64, label %L66
L64:
  %t252 = alloca i64
  %t253 = sext i32 0 to i64
  store i64 %t253, ptr %t252
  %t254 = alloca i64
  %t255 = sext i32 0 to i64
  store i64 %t255, ptr %t254
  %t256 = alloca i64
  %t257 = sext i32 0 to i64
  store i64 %t257, ptr %t256
  %t258 = alloca ptr
  %t259 = call ptr @parse_type_specifier(ptr %t0, ptr %t252, ptr %t254, ptr %t256)
  store ptr %t259, ptr %t258
  %t260 = alloca ptr
  %t262 = sext i32 0 to i64
  %t261 = inttoptr i64 %t262 to ptr
  store ptr %t261, ptr %t260
  %t263 = load ptr, ptr %t258
  %t264 = call ptr @parse_declarator(ptr %t0, ptr %t263, ptr %t260)
  store ptr %t264, ptr %t258
  %t265 = load ptr, ptr %t260
  call void @free(ptr %t265)
  call void @expect(ptr %t0, i64 73)
  %t268 = alloca ptr
  %t269 = load i64, ptr %t1
  %t270 = call ptr @node_new(i64 31, i64 %t269)
  store ptr %t270, ptr %t268
  %t271 = load ptr, ptr %t258
  %t272 = load ptr, ptr %t268
  store ptr %t271, ptr %t272
  %t273 = load ptr, ptr %t268
  ret ptr %t273
L67:
  br label %L66
L66:
  %t274 = alloca ptr
  %t275 = call ptr @parse_expr(ptr %t0)
  store ptr %t275, ptr %t274
  call void @expect(ptr %t0, i64 73)
  %t277 = alloca ptr
  %t278 = load i64, ptr %t1
  %t279 = call ptr @node_new(i64 32, i64 %t278)
  store ptr %t279, ptr %t277
  %t280 = load ptr, ptr %t277
  %t281 = load ptr, ptr %t274
  call void @node_add_child(ptr %t280, ptr %t281)
  %t283 = load ptr, ptr %t277
  ret ptr %t283
L68:
  br label %L63
L63:
  %t284 = alloca ptr
  %t285 = call ptr @parse_unary(ptr %t0)
  store ptr %t285, ptr %t284
  %t286 = alloca ptr
  %t287 = load i64, ptr %t1
  %t288 = call ptr @node_new(i64 32, i64 %t287)
  store ptr %t288, ptr %t286
  %t289 = load ptr, ptr %t286
  %t290 = load ptr, ptr %t284
  call void @node_add_child(ptr %t289, ptr %t290)
  %t292 = load ptr, ptr %t286
  ret ptr %t292
L69:
  br label %L60
L60:
  %t293 = getelementptr [28 x i8], ptr @.str32, i64 0, i64 0
  call void @p_error(ptr %t0, ptr %t293)
  %t296 = sext i32 0 to i64
  %t295 = inttoptr i64 %t296 to ptr
  ret ptr %t295
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
  %t76 = sext i32 %t74 to i64
  store i64 %t76, ptr %t75
  %t77 = load ptr, ptr %t71
  %t78 = call ptr @parse_cast(ptr %t0)
  call void @node_add_child(ptr %t77, ptr %t78)
  %t80 = load ptr, ptr %t71
  ret ptr %t80
L28:
  br label %L27
L27:
  %t81 = call ptr @parse_postfix(ptr %t0)
  ret ptr %t81
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_cast(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_mul(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_add(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_shift(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_relational(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_equality(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_bitand(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_bitxor(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_bitor(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr ptr, ptr %t9, i64 %t11
  %t13 = load ptr, ptr %t12
  %t15 = ptrtoint ptr %t13 to i64
  %t16 = sext i32 81 to i64
  %t14 = icmp ne i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L5, label %L7
L5:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t3
  %t21 = load i64, ptr %t7
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr ptr, ptr %t20, i64 %t22
  %t24 = load ptr, ptr %t23
  %t26 = ptrtoint ptr %t19 to i64
  %t27 = ptrtoint ptr %t24 to i64
  %t25 = icmp eq i64 %t26, %t27
  %t28 = zext i1 %t25 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L8, label %L10
L8:
  %t30 = alloca i64
  %t31 = load ptr, ptr %t0
  store ptr %t31, ptr %t30
  %t32 = alloca i64
  %t33 = load ptr, ptr %t0
  store ptr %t33, ptr %t32
  call void @advance(ptr %t0)
  %t35 = alloca ptr
  %t36 = call ptr @parse_logand(ptr %t0)
  store ptr %t36, ptr %t35
  %t37 = alloca ptr
  %t38 = load i64, ptr %t30
  %t39 = call ptr @node_new(i64 25, i64 %t38)
  store ptr %t39, ptr %t37
  %t40 = load i64, ptr %t32
  %t41 = load ptr, ptr %t37
  %t42 = sext i32 %t40 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t37
  %t44 = load ptr, ptr %t1
  call void @node_add_child(ptr %t43, ptr %t44)
  %t46 = load ptr, ptr %t37
  %t47 = load ptr, ptr %t35
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t37
  store ptr %t49, ptr %t1
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t51 = load i64, ptr %t7
  %t53 = sext i32 %t51 to i64
  %t52 = add i64 %t53, 1
  store i64 %t52, ptr %t7
  br label %L4
L7:
  %t54 = load i64, ptr %t5
  %t56 = sext i32 %t54 to i64
  %t57 = icmp eq i64 %t56, 0
  %t55 = zext i1 %t57 to i64
  %t58 = icmp ne i64 %t55, 0
  br i1 %t58, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t59 = load ptr, ptr %t1
  ret ptr %t59
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
  %t5 = alloca i64
  %t6 = load ptr, ptr %t0
  store ptr %t6, ptr %t5
  %t7 = load i64, ptr %t5
  %t9 = sext i32 %t7 to i64
  %t10 = sext i32 55 to i64
  %t8 = icmp eq i64 %t9, %t10
  %t11 = zext i1 %t8 to i64
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L0, label %L1
L0:
  br label %L2
L1:
  %t13 = load i64, ptr %t5
  %t15 = sext i32 %t13 to i64
  %t16 = sext i32 56 to i64
  %t14 = icmp eq i64 %t15, %t16
  %t17 = zext i1 %t14 to i64
  %t18 = icmp ne i64 %t17, 0
  %t19 = zext i1 %t18 to i64
  br label %L2
L2:
  %t20 = phi i64 [ 1, %L0 ], [ %t19, %L1 ]
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L3, label %L4
L3:
  br label %L5
L4:
  %t22 = load i64, ptr %t5
  %t24 = sext i32 %t22 to i64
  %t25 = sext i32 57 to i64
  %t23 = icmp eq i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = icmp ne i64 %t26, 0
  %t28 = zext i1 %t27 to i64
  br label %L5
L5:
  %t29 = phi i64 [ 1, %L3 ], [ %t28, %L4 ]
  %t30 = icmp ne i64 %t29, 0
  br i1 %t30, label %L6, label %L7
L6:
  br label %L8
L7:
  %t31 = load i64, ptr %t5
  %t33 = sext i32 %t31 to i64
  %t34 = sext i32 58 to i64
  %t32 = icmp eq i64 %t33, %t34
  %t35 = zext i1 %t32 to i64
  %t36 = icmp ne i64 %t35, 0
  %t37 = zext i1 %t36 to i64
  br label %L8
L8:
  %t38 = phi i64 [ 1, %L6 ], [ %t37, %L7 ]
  %t39 = icmp ne i64 %t38, 0
  br i1 %t39, label %L9, label %L10
L9:
  br label %L11
L10:
  %t40 = load i64, ptr %t5
  %t42 = sext i32 %t40 to i64
  %t43 = sext i32 59 to i64
  %t41 = icmp eq i64 %t42, %t43
  %t44 = zext i1 %t41 to i64
  %t45 = icmp ne i64 %t44, 0
  %t46 = zext i1 %t45 to i64
  br label %L11
L11:
  %t47 = phi i64 [ 1, %L9 ], [ %t46, %L10 ]
  %t48 = icmp ne i64 %t47, 0
  br i1 %t48, label %L12, label %L13
L12:
  br label %L14
L13:
  %t49 = load i64, ptr %t5
  %t51 = sext i32 %t49 to i64
  %t52 = sext i32 65 to i64
  %t50 = icmp eq i64 %t51, %t52
  %t53 = zext i1 %t50 to i64
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
  %t58 = load i64, ptr %t5
  %t60 = sext i32 %t58 to i64
  %t61 = sext i32 60 to i64
  %t59 = icmp eq i64 %t60, %t61
  %t62 = zext i1 %t59 to i64
  %t63 = icmp ne i64 %t62, 0
  %t64 = zext i1 %t63 to i64
  br label %L17
L17:
  %t65 = phi i64 [ 1, %L15 ], [ %t64, %L16 ]
  %t66 = icmp ne i64 %t65, 0
  br i1 %t66, label %L18, label %L19
L18:
  br label %L20
L19:
  %t67 = load i64, ptr %t5
  %t69 = sext i32 %t67 to i64
  %t70 = sext i32 61 to i64
  %t68 = icmp eq i64 %t69, %t70
  %t71 = zext i1 %t68 to i64
  %t72 = icmp ne i64 %t71, 0
  %t73 = zext i1 %t72 to i64
  br label %L20
L20:
  %t74 = phi i64 [ 1, %L18 ], [ %t73, %L19 ]
  %t75 = icmp ne i64 %t74, 0
  br i1 %t75, label %L21, label %L22
L21:
  br label %L23
L22:
  %t76 = load i64, ptr %t5
  %t78 = sext i32 %t76 to i64
  %t79 = sext i32 62 to i64
  %t77 = icmp eq i64 %t78, %t79
  %t80 = zext i1 %t77 to i64
  %t81 = icmp ne i64 %t80, 0
  %t82 = zext i1 %t81 to i64
  br label %L23
L23:
  %t83 = phi i64 [ 1, %L21 ], [ %t82, %L22 ]
  %t84 = icmp ne i64 %t83, 0
  br i1 %t84, label %L24, label %L25
L24:
  br label %L26
L25:
  %t85 = load i64, ptr %t5
  %t87 = sext i32 %t85 to i64
  %t88 = sext i32 63 to i64
  %t86 = icmp eq i64 %t87, %t88
  %t89 = zext i1 %t86 to i64
  %t90 = icmp ne i64 %t89, 0
  %t91 = zext i1 %t90 to i64
  br label %L26
L26:
  %t92 = phi i64 [ 1, %L24 ], [ %t91, %L25 ]
  %t93 = icmp ne i64 %t92, 0
  br i1 %t93, label %L27, label %L28
L27:
  br label %L29
L28:
  %t94 = load i64, ptr %t5
  %t96 = sext i32 %t94 to i64
  %t97 = sext i32 64 to i64
  %t95 = icmp eq i64 %t96, %t97
  %t98 = zext i1 %t95 to i64
  %t99 = icmp ne i64 %t98, 0
  %t100 = zext i1 %t99 to i64
  br label %L29
L29:
  %t101 = phi i64 [ 1, %L27 ], [ %t100, %L28 ]
  %t102 = icmp ne i64 %t101, 0
  br i1 %t102, label %L30, label %L32
L30:
  %t103 = alloca i64
  %t104 = load i64, ptr %t5
  %t105 = sext i32 %t104 to i64
  store i64 %t105, ptr %t103
  call void @advance(ptr %t0)
  %t107 = alloca ptr
  %t108 = call ptr @parse_assign(ptr %t0)
  store ptr %t108, ptr %t107
  %t109 = alloca i64
  %t110 = load i64, ptr %t103
  %t112 = sext i32 %t110 to i64
  %t113 = sext i32 55 to i64
  %t111 = icmp eq i64 %t112, %t113
  %t114 = zext i1 %t111 to i64
  %t115 = icmp ne i64 %t114, 0
  br i1 %t115, label %L33, label %L34
L33:
  %t116 = sext i32 27 to i64
  br label %L35
L34:
  %t117 = sext i32 28 to i64
  br label %L35
L35:
  %t118 = phi i64 [ %t116, %L33 ], [ %t117, %L34 ]
  store i64 %t118, ptr %t109
  %t119 = alloca ptr
  %t120 = load i64, ptr %t109
  %t121 = load i64, ptr %t3
  %t122 = call ptr @node_new(i64 %t120, i64 %t121)
  store ptr %t122, ptr %t119
  %t123 = load i64, ptr %t103
  %t124 = load ptr, ptr %t119
  %t125 = sext i32 %t123 to i64
  store i64 %t125, ptr %t124
  %t126 = load ptr, ptr %t119
  %t127 = load ptr, ptr %t1
  call void @node_add_child(ptr %t126, ptr %t127)
  %t129 = load ptr, ptr %t119
  %t130 = load ptr, ptr %t107
  call void @node_add_child(ptr %t129, ptr %t130)
  %t132 = load ptr, ptr %t119
  ret ptr %t132
L36:
  br label %L32
L32:
  %t133 = load ptr, ptr %t1
  ret ptr %t133
L37:
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
  %t28 = sext i32 %t27 to i64
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L7, label %L8
L7:
  %t30 = load ptr, ptr %t21
  %t31 = ptrtoint ptr %t30 to i64
  %t32 = icmp ne i64 %t31, 0
  %t33 = zext i1 %t32 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t34 = phi i64 [ %t33, %L7 ], [ 0, %L8 ]
  %t35 = icmp ne i64 %t34, 0
  br i1 %t35, label %L10, label %L11
L10:
  %t36 = load ptr, ptr %t21
  %t37 = load ptr, ptr %t24
  call void @register_typedef(ptr %t0, ptr %t36, ptr %t37)
  %t39 = alloca ptr
  %t40 = load i64, ptr %t1
  %t41 = call ptr @node_new(i64 3, i64 %t40)
  store ptr %t41, ptr %t39
  %t42 = load ptr, ptr %t21
  %t43 = load ptr, ptr %t39
  store ptr %t42, ptr %t43
  %t44 = load ptr, ptr %t24
  %t45 = load ptr, ptr %t39
  store ptr %t44, ptr %t45
  %t46 = load ptr, ptr %t18
  %t47 = load ptr, ptr %t39
  call void @node_add_child(ptr %t46, ptr %t47)
  br label %L12
L11:
  %t49 = alloca ptr
  %t50 = load i64, ptr %t1
  %t51 = call ptr @node_new(i64 2, i64 %t50)
  store ptr %t51, ptr %t49
  %t52 = load ptr, ptr %t21
  %t53 = load ptr, ptr %t49
  store ptr %t52, ptr %t53
  %t54 = load ptr, ptr %t24
  %t55 = load ptr, ptr %t49
  store ptr %t54, ptr %t55
  %t56 = load i64, ptr %t5
  %t57 = load ptr, ptr %t49
  %t58 = sext i32 %t56 to i64
  store i64 %t58, ptr %t57
  %t59 = load i64, ptr %t7
  %t60 = load ptr, ptr %t49
  %t61 = sext i32 %t59 to i64
  store i64 %t61, ptr %t60
  %t62 = call i32 @match(ptr %t0, i64 55)
  %t63 = sext i32 %t62 to i64
  %t64 = icmp ne i64 %t63, 0
  br i1 %t64, label %L13, label %L15
L13:
  %t65 = load ptr, ptr %t49
  %t66 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t65, ptr %t66)
  br label %L15
L15:
  %t68 = load ptr, ptr %t18
  %t69 = load ptr, ptr %t49
  call void @node_add_child(ptr %t68, ptr %t69)
  br label %L12
L12:
  br label %L5
L5:
  %t71 = call i32 @match(ptr %t0, i64 79)
  %t72 = sext i32 %t71 to i64
  %t73 = icmp ne i64 %t72, 0
  br i1 %t73, label %L4, label %L6
L6:
  call void @expect(ptr %t0, i64 78)
  %t75 = load ptr, ptr %t18
  %t76 = load ptr, ptr %t75
  %t78 = ptrtoint ptr %t76 to i64
  %t79 = sext i32 1 to i64
  %t77 = icmp eq i64 %t78, %t79
  %t80 = zext i1 %t77 to i64
  %t81 = icmp ne i64 %t80, 0
  br i1 %t81, label %L16, label %L18
L16:
  %t82 = alloca ptr
  %t83 = load ptr, ptr %t18
  %t84 = load ptr, ptr %t83
  %t85 = sext i32 0 to i64
  %t86 = getelementptr ptr, ptr %t84, i64 %t85
  %t87 = load ptr, ptr %t86
  store ptr %t87, ptr %t82
  %t88 = load ptr, ptr %t18
  %t89 = sext i32 0 to i64
  store i64 %t89, ptr %t88
  %t90 = load ptr, ptr %t18
  %t91 = load ptr, ptr %t90
  call void @free(ptr %t91)
  %t93 = load ptr, ptr %t18
  call void @free(ptr %t93)
  %t95 = load ptr, ptr %t82
  ret ptr %t95
L19:
  br label %L18
L18:
  %t96 = load ptr, ptr %t18
  ret ptr %t96
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
  %t19 = sext i32 %t17 to i64
  %t20 = sext i32 0 to i64
  %t18 = icmp sgt i64 %t19, %t20
  %t21 = zext i1 %t18 to i64
  %t22 = icmp ne i64 %t21, 0
  %t23 = zext i1 %t22 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t24 = phi i64 [ %t23, %L7 ], [ 0, %L8 ]
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L5, label %L6
L5:
  %t26 = call i32 @check(ptr %t0, i64 74)
  %t27 = sext i32 %t26 to i64
  %t28 = icmp ne i64 %t27, 0
  br i1 %t28, label %L10, label %L11
L10:
  %t29 = load i64, ptr %t10
  %t31 = sext i32 %t29 to i64
  %t30 = add i64 %t31, 1
  store i64 %t30, ptr %t10
  br label %L12
L11:
  %t32 = call i32 @check(ptr %t0, i64 75)
  %t33 = sext i32 %t32 to i64
  %t34 = icmp ne i64 %t33, 0
  br i1 %t34, label %L13, label %L15
L13:
  %t35 = load i64, ptr %t10
  %t37 = sext i32 %t35 to i64
  %t36 = sub i64 %t37, 1
  store i64 %t36, ptr %t10
  %t38 = load i64, ptr %t10
  %t40 = sext i32 %t38 to i64
  %t41 = sext i32 0 to i64
  %t39 = icmp eq i64 %t40, %t41
  %t42 = zext i1 %t39 to i64
  %t43 = icmp ne i64 %t42, 0
  br i1 %t43, label %L16, label %L18
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
  %t46 = alloca ptr
  %t47 = load i64, ptr %t1
  %t48 = call ptr @node_new(i64 19, i64 %t47)
  store ptr %t48, ptr %t46
  %t49 = load ptr, ptr %t46
  %t50 = sext i32 0 to i64
  store i64 %t50, ptr %t49
  %t51 = getelementptr [7 x i8], ptr @.str33, i64 0, i64 0
  %t52 = call ptr @strdup(ptr %t51)
  %t53 = load ptr, ptr %t46
  store ptr %t52, ptr %t53
  %t54 = load ptr, ptr %t46
  ret ptr %t54
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
  %t36 = sext i32 %t34 to i64
  %t35 = icmp ne i64 %t36, 0
  br i1 %t35, label %L8, label %L10
L8:
  %t37 = load ptr, ptr %t27
  %t38 = icmp ne ptr %t37, null
  br i1 %t38, label %L11, label %L13
L11:
  %t39 = load ptr, ptr %t27
  %t40 = load ptr, ptr %t30
  call void @register_typedef(ptr %t0, ptr %t39, ptr %t40)
  br label %L13
L13:
  %t42 = alloca ptr
  %t43 = load i64, ptr %t1
  %t44 = call ptr @node_new(i64 3, i64 %t43)
  store ptr %t44, ptr %t42
  %t45 = load ptr, ptr %t27
  %t46 = load ptr, ptr %t42
  store ptr %t45, ptr %t46
  %t47 = load ptr, ptr %t30
  %t48 = load ptr, ptr %t42
  store ptr %t47, ptr %t48
  call void @expect(ptr %t0, i64 78)
  %t50 = load ptr, ptr %t42
  ret ptr %t50
L14:
  br label %L10
L10:
  %t51 = load ptr, ptr %t30
  %t52 = load ptr, ptr %t51
  %t54 = ptrtoint ptr %t52 to i64
  %t55 = sext i32 17 to i64
  %t53 = icmp eq i64 %t54, %t55
  %t56 = zext i1 %t53 to i64
  %t57 = icmp ne i64 %t56, 0
  br i1 %t57, label %L15, label %L16
L15:
  %t58 = call i32 @check(ptr %t0, i64 74)
  %t59 = sext i32 %t58 to i64
  %t60 = icmp ne i64 %t59, 0
  %t61 = zext i1 %t60 to i64
  br label %L17
L16:
  br label %L17
L17:
  %t62 = phi i64 [ %t61, %L15 ], [ 0, %L16 ]
  %t63 = icmp ne i64 %t62, 0
  br i1 %t63, label %L18, label %L20
L18:
  %t64 = alloca ptr
  %t65 = load i64, ptr %t1
  %t66 = call ptr @node_new(i64 1, i64 %t65)
  store ptr %t66, ptr %t64
  %t67 = load ptr, ptr %t27
  %t68 = load ptr, ptr %t64
  store ptr %t67, ptr %t68
  %t69 = load ptr, ptr %t30
  %t70 = load ptr, ptr %t64
  store ptr %t69, ptr %t70
  %t71 = load i64, ptr %t6
  %t72 = load ptr, ptr %t64
  %t73 = sext i32 %t71 to i64
  store i64 %t73, ptr %t72
  %t74 = load i64, ptr %t8
  %t75 = load ptr, ptr %t64
  %t76 = sext i32 %t74 to i64
  store i64 %t76, ptr %t75
  %t77 = load ptr, ptr %t30
  %t78 = load ptr, ptr %t77
  %t80 = ptrtoint ptr %t78 to i64
  %t81 = sext i32 8 to i64
  %t79 = mul i64 %t80, %t81
  %t82 = call ptr @malloc(i64 %t79)
  %t83 = load ptr, ptr %t64
  store ptr %t82, ptr %t83
  %t84 = alloca i64
  %t85 = sext i32 0 to i64
  store i64 %t85, ptr %t84
  br label %L21
L21:
  %t86 = load i64, ptr %t84
  %t87 = load ptr, ptr %t30
  %t88 = load ptr, ptr %t87
  %t90 = sext i32 %t86 to i64
  %t91 = ptrtoint ptr %t88 to i64
  %t89 = icmp slt i64 %t90, %t91
  %t92 = zext i1 %t89 to i64
  %t93 = icmp ne i64 %t92, 0
  br i1 %t93, label %L22, label %L24
L22:
  %t94 = load ptr, ptr %t30
  %t95 = load ptr, ptr %t94
  %t96 = load i64, ptr %t84
  %t98 = sext i32 %t96 to i64
  %t97 = getelementptr ptr, ptr %t95, i64 %t98
  %t99 = load ptr, ptr %t97
  %t100 = icmp ne ptr %t99, null
  br i1 %t100, label %L25, label %L26
L25:
  %t101 = load ptr, ptr %t30
  %t102 = load ptr, ptr %t101
  %t103 = load i64, ptr %t84
  %t105 = sext i32 %t103 to i64
  %t104 = getelementptr ptr, ptr %t102, i64 %t105
  %t106 = load ptr, ptr %t104
  %t107 = call ptr @strdup(ptr %t106)
  %t108 = ptrtoint ptr %t107 to i64
  br label %L27
L26:
  %t110 = sext i32 0 to i64
  %t109 = inttoptr i64 %t110 to ptr
  %t111 = ptrtoint ptr %t109 to i64
  br label %L27
L27:
  %t112 = phi i64 [ %t108, %L25 ], [ %t111, %L26 ]
  %t113 = load ptr, ptr %t64
  %t114 = load ptr, ptr %t113
  %t115 = load i64, ptr %t84
  %t117 = sext i32 %t115 to i64
  %t116 = getelementptr ptr, ptr %t114, i64 %t117
  store i64 %t112, ptr %t116
  br label %L23
L23:
  %t118 = load i64, ptr %t84
  %t120 = sext i32 %t118 to i64
  %t119 = add i64 %t120, 1
  store i64 %t119, ptr %t84
  br label %L21
L24:
  %t121 = call ptr @parse_block(ptr %t0)
  %t122 = load ptr, ptr %t64
  store ptr %t121, ptr %t122
  %t123 = load ptr, ptr %t64
  ret ptr %t123
L28:
  br label %L20
L20:
  %t124 = alloca ptr
  %t125 = load i64, ptr %t1
  %t126 = call ptr @node_new(i64 2, i64 %t125)
  store ptr %t126, ptr %t124
  %t127 = load ptr, ptr %t27
  %t128 = load ptr, ptr %t124
  store ptr %t127, ptr %t128
  %t129 = load ptr, ptr %t30
  %t130 = load ptr, ptr %t124
  store ptr %t129, ptr %t130
  %t131 = load ptr, ptr %t124
  %t132 = sext i32 1 to i64
  store i64 %t132, ptr %t131
  %t133 = load i64, ptr %t6
  %t134 = load ptr, ptr %t124
  %t135 = sext i32 %t133 to i64
  store i64 %t135, ptr %t134
  %t136 = load i64, ptr %t8
  %t137 = load ptr, ptr %t124
  %t138 = sext i32 %t136 to i64
  store i64 %t138, ptr %t137
  %t139 = call i32 @match(ptr %t0, i64 55)
  %t140 = sext i32 %t139 to i64
  %t141 = icmp ne i64 %t140, 0
  br i1 %t141, label %L29, label %L31
L29:
  %t142 = load ptr, ptr %t124
  %t143 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t142, ptr %t143)
  br label %L31
L31:
  br label %L32
L32:
  %t145 = call i32 @match(ptr %t0, i64 79)
  %t146 = sext i32 %t145 to i64
  %t147 = icmp ne i64 %t146, 0
  br i1 %t147, label %L33, label %L34
L33:
  %t148 = alloca ptr
  %t150 = sext i32 0 to i64
  %t149 = inttoptr i64 %t150 to ptr
  store ptr %t149, ptr %t148
  %t151 = alloca ptr
  %t152 = load ptr, ptr %t10
  %t153 = call ptr @parse_declarator(ptr %t0, ptr %t152, ptr %t148)
  store ptr %t153, ptr %t151
  %t154 = alloca ptr
  %t155 = load i64, ptr %t1
  %t156 = call ptr @node_new(i64 2, i64 %t155)
  store ptr %t156, ptr %t154
  %t157 = load ptr, ptr %t148
  %t158 = load ptr, ptr %t154
  store ptr %t157, ptr %t158
  %t159 = load ptr, ptr %t151
  %t160 = load ptr, ptr %t154
  store ptr %t159, ptr %t160
  %t161 = load ptr, ptr %t154
  %t162 = sext i32 1 to i64
  store i64 %t162, ptr %t161
  %t163 = call i32 @match(ptr %t0, i64 55)
  %t164 = sext i32 %t163 to i64
  %t165 = icmp ne i64 %t164, 0
  br i1 %t165, label %L35, label %L37
L35:
  %t166 = load ptr, ptr %t154
  %t167 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t166, ptr %t167)
  br label %L37
L37:
  %t169 = load ptr, ptr %t124
  %t170 = load ptr, ptr %t154
  call void @node_add_child(ptr %t169, ptr %t170)
  br label %L32
L34:
  call void @expect(ptr %t0, i64 78)
  %t173 = load ptr, ptr %t124
  ret ptr %t173
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
  %t18 = alloca i64
  %t19 = sext i32 0 to i64
  store i64 %t19, ptr %t18
  br label %L3
L3:
  %t20 = load i64, ptr %t18
  %t21 = call ptr @__c0c_get_td_name(i64 %t20)
  %t22 = icmp ne ptr %t21, null
  br i1 %t22, label %L4, label %L6
L4:
  %t23 = alloca ptr
  %t24 = load i64, ptr %t18
  %t25 = call i64 @__c0c_get_td_kind(i64 %t24)
  %t26 = call ptr @type_new(i64 %t25)
  store ptr %t26, ptr %t23
  %t27 = load ptr, ptr %t1
  %t28 = load i64, ptr %t18
  %t29 = call ptr @__c0c_get_td_name(i64 %t28)
  %t30 = load ptr, ptr %t23
  call void @register_typedef(ptr %t27, ptr %t29, ptr %t30)
  br label %L5
L5:
  %t32 = load i64, ptr %t18
  %t34 = sext i32 %t32 to i64
  %t33 = add i64 %t34, 1
  store i64 %t33, ptr %t18
  br label %L3
L6:
  %t35 = load ptr, ptr %t1
  ret ptr %t35
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
  %t8 = sext i32 %t5 to i64
  %t9 = ptrtoint ptr %t6 to i64
  %t7 = icmp slt i64 %t8, %t9
  %t10 = zext i1 %t7 to i64
  %t11 = icmp ne i64 %t10, 0
  br i1 %t11, label %L1, label %L3
L1:
  %t12 = alloca ptr
  %t13 = load ptr, ptr %t0
  %t14 = load i64, ptr %t3
  %t15 = sext i32 %t14 to i64
  %t16 = getelementptr ptr, ptr %t13, i64 %t15
  %t17 = load ptr, ptr %t16
  store ptr %t17, ptr %t12
  %t18 = load ptr, ptr %t12
  %t19 = icmp ne ptr %t18, null
  br i1 %t19, label %L4, label %L6
L4:
  %t20 = load ptr, ptr %t12
  %t21 = load ptr, ptr %t20
  call void @free(ptr %t21)
  %t23 = load ptr, ptr %t12
  call void @free(ptr %t23)
  br label %L6
L6:
  br label %L2
L2:
  %t25 = load i64, ptr %t3
  %t27 = sext i32 %t25 to i64
  %t26 = add i64 %t27, 1
  store i64 %t26, ptr %t3
  br label %L0
L3:
  %t28 = load ptr, ptr %t0
  call void @free(ptr %t28)
  %t30 = alloca i64
  %t31 = sext i32 0 to i64
  store i64 %t31, ptr %t30
  br label %L7
L7:
  %t32 = load i64, ptr %t30
  %t33 = load ptr, ptr %t0
  %t35 = sext i32 %t32 to i64
  %t36 = ptrtoint ptr %t33 to i64
  %t34 = icmp slt i64 %t35, %t36
  %t37 = zext i1 %t34 to i64
  %t38 = icmp ne i64 %t37, 0
  br i1 %t38, label %L8, label %L10
L8:
  %t39 = alloca ptr
  %t40 = load ptr, ptr %t0
  %t41 = load i64, ptr %t30
  %t42 = sext i32 %t41 to i64
  %t43 = getelementptr ptr, ptr %t40, i64 %t42
  %t44 = load ptr, ptr %t43
  store ptr %t44, ptr %t39
  %t45 = load ptr, ptr %t39
  %t46 = icmp ne ptr %t45, null
  br i1 %t46, label %L11, label %L13
L11:
  %t47 = load ptr, ptr %t39
  %t48 = load ptr, ptr %t47
  call void @free(ptr %t48)
  %t50 = load ptr, ptr %t39
  call void @free(ptr %t50)
  br label %L13
L13:
  br label %L9
L9:
  %t52 = load i64, ptr %t30
  %t54 = sext i32 %t52 to i64
  %t53 = add i64 %t54, 1
  store i64 %t53, ptr %t30
  br label %L7
L10:
  %t55 = load ptr, ptr %t0
  call void @free(ptr %t55)
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
