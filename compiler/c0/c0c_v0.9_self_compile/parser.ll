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
  %t9 = call ptr @strdup(ptr %t1)
  %t10 = load ptr, ptr %t0
  %t11 = load ptr, ptr %t0
  %t13 = ptrtoint ptr %t11 to i64
  %t12 = getelementptr i8, ptr %t10, i64 %t13
  store ptr %t9, ptr %t12
  %t14 = load ptr, ptr %t0
  %t15 = load ptr, ptr %t0
  %t17 = ptrtoint ptr %t15 to i64
  %t16 = getelementptr i8, ptr %t14, i64 %t17
  store i64 %t2, ptr %t16
  %t18 = load ptr, ptr %t0
  %t20 = ptrtoint ptr %t18 to i64
  %t19 = add i64 %t20, 1
  store i64 %t19, ptr %t0
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
  %t11 = load ptr, ptr %t0
  %t12 = load i64, ptr %t3
  %t13 = getelementptr i8, ptr %t11, i64 %t12
  %t14 = load ptr, ptr %t13
  %t15 = call i32 @strcmp(ptr %t14, ptr %t1)
  %t16 = sext i32 %t15 to i64
  %t18 = sext i32 0 to i64
  %t17 = icmp eq i64 %t16, %t18
  %t19 = zext i1 %t17 to i64
  %t20 = icmp ne i64 %t19, 0
  br i1 %t20, label %L4, label %L6
L4:
  %t21 = load ptr, ptr %t0
  %t22 = load i64, ptr %t3
  %t23 = getelementptr i8, ptr %t21, i64 %t22
  %t24 = load ptr, ptr %t23
  store ptr %t24, ptr %t2
  %t25 = sext i32 1 to i64
  %t26 = trunc i64 %t25 to i32
  ret i32 %t26
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t27 = load i64, ptr %t3
  %t28 = add i64 %t27, 1
  store i64 %t28, ptr %t3
  br label %L0
L3:
  %t29 = sext i32 0 to i64
  %t30 = trunc i64 %t29 to i32
  ret i32 %t30
L8:
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
  %t11 = call ptr @strdup(ptr %t1)
  %t12 = load ptr, ptr %t0
  %t13 = load ptr, ptr %t0
  %t15 = ptrtoint ptr %t13 to i64
  %t14 = getelementptr i8, ptr %t12, i64 %t15
  store ptr %t11, ptr %t14
  %t16 = load ptr, ptr %t0
  %t17 = load ptr, ptr %t0
  %t19 = ptrtoint ptr %t17 to i64
  %t18 = getelementptr i8, ptr %t16, i64 %t19
  store ptr %t2, ptr %t18
  %t20 = load ptr, ptr %t0
  %t22 = ptrtoint ptr %t20 to i64
  %t21 = add i64 %t22, 1
  store i64 %t21, ptr %t0
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
  %t25 = load ptr, ptr %t24
  ret ptr %t25
L7:
  br label %L6
L6:
  br label %L2
L2:
  %t26 = load i64, ptr %t2
  %t27 = sub i64 %t26, 1
  store i64 %t27, ptr %t2
  br label %L0
L3:
  %t29 = sext i32 0 to i64
  %t28 = inttoptr i64 %t29 to ptr
  ret ptr %t28
L8:
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
  %t7 = getelementptr [14 x i8], ptr @.str6, i64 0, i64 0
  %t8 = call i32 @strcmp(ptr %t0, ptr %t7)
  %t9 = sext i32 %t8 to i64
  %t11 = sext i32 0 to i64
  %t10 = icmp eq i64 %t9, %t11
  %t12 = zext i1 %t10 to i64
  %t14 = icmp ne i64 %t6, 0
  %t15 = icmp ne i64 %t12, 0
  %t16 = or i1 %t14, %t15
  %t17 = zext i1 %t16 to i64
  %t18 = getelementptr [8 x i8], ptr @.str7, i64 0, i64 0
  %t19 = call i32 @strcmp(ptr %t0, ptr %t18)
  %t20 = sext i32 %t19 to i64
  %t22 = sext i32 0 to i64
  %t21 = icmp eq i64 %t20, %t22
  %t23 = zext i1 %t21 to i64
  %t25 = icmp ne i64 %t17, 0
  %t26 = icmp ne i64 %t23, 0
  %t27 = or i1 %t25, %t26
  %t28 = zext i1 %t27 to i64
  %t29 = getelementptr [6 x i8], ptr @.str8, i64 0, i64 0
  %t30 = call i32 @strcmp(ptr %t0, ptr %t29)
  %t31 = sext i32 %t30 to i64
  %t33 = sext i32 0 to i64
  %t32 = icmp eq i64 %t31, %t33
  %t34 = zext i1 %t32 to i64
  %t36 = icmp ne i64 %t28, 0
  %t37 = icmp ne i64 %t34, 0
  %t38 = or i1 %t36, %t37
  %t39 = zext i1 %t38 to i64
  %t40 = getelementptr [11 x i8], ptr @.str9, i64 0, i64 0
  %t41 = call i32 @strcmp(ptr %t0, ptr %t40)
  %t42 = sext i32 %t41 to i64
  %t44 = sext i32 0 to i64
  %t43 = icmp eq i64 %t42, %t44
  %t45 = zext i1 %t43 to i64
  %t47 = icmp ne i64 %t39, 0
  %t48 = icmp ne i64 %t45, 0
  %t49 = or i1 %t47, %t48
  %t50 = zext i1 %t49 to i64
  %t51 = getelementptr [9 x i8], ptr @.str10, i64 0, i64 0
  %t52 = call i32 @strcmp(ptr %t0, ptr %t51)
  %t53 = sext i32 %t52 to i64
  %t55 = sext i32 0 to i64
  %t54 = icmp eq i64 %t53, %t55
  %t56 = zext i1 %t54 to i64
  %t58 = icmp ne i64 %t50, 0
  %t59 = icmp ne i64 %t56, 0
  %t60 = or i1 %t58, %t59
  %t61 = zext i1 %t60 to i64
  %t62 = getelementptr [13 x i8], ptr @.str11, i64 0, i64 0
  %t63 = call i32 @strcmp(ptr %t0, ptr %t62)
  %t64 = sext i32 %t63 to i64
  %t66 = sext i32 0 to i64
  %t65 = icmp eq i64 %t64, %t66
  %t67 = zext i1 %t65 to i64
  %t69 = icmp ne i64 %t61, 0
  %t70 = icmp ne i64 %t67, 0
  %t71 = or i1 %t69, %t70
  %t72 = zext i1 %t71 to i64
  %t73 = getelementptr [11 x i8], ptr @.str12, i64 0, i64 0
  %t74 = call i32 @strcmp(ptr %t0, ptr %t73)
  %t75 = sext i32 %t74 to i64
  %t77 = sext i32 0 to i64
  %t76 = icmp eq i64 %t75, %t77
  %t78 = zext i1 %t76 to i64
  %t80 = icmp ne i64 %t72, 0
  %t81 = icmp ne i64 %t78, 0
  %t82 = or i1 %t80, %t81
  %t83 = zext i1 %t82 to i64
  %t84 = getelementptr [11 x i8], ptr @.str13, i64 0, i64 0
  %t85 = call i32 @strcmp(ptr %t0, ptr %t84)
  %t86 = sext i32 %t85 to i64
  %t88 = sext i32 0 to i64
  %t87 = icmp eq i64 %t86, %t88
  %t89 = zext i1 %t87 to i64
  %t91 = icmp ne i64 %t83, 0
  %t92 = icmp ne i64 %t89, 0
  %t93 = or i1 %t91, %t92
  %t94 = zext i1 %t93 to i64
  %t95 = getelementptr [13 x i8], ptr @.str14, i64 0, i64 0
  %t96 = call i32 @strcmp(ptr %t0, ptr %t95)
  %t97 = sext i32 %t96 to i64
  %t99 = sext i32 0 to i64
  %t98 = icmp eq i64 %t97, %t99
  %t100 = zext i1 %t98 to i64
  %t102 = icmp ne i64 %t94, 0
  %t103 = icmp ne i64 %t100, 0
  %t104 = or i1 %t102, %t103
  %t105 = zext i1 %t104 to i64
  %t106 = getelementptr [8 x i8], ptr @.str15, i64 0, i64 0
  %t107 = call i32 @strcmp(ptr %t0, ptr %t106)
  %t108 = sext i32 %t107 to i64
  %t110 = sext i32 0 to i64
  %t109 = icmp eq i64 %t108, %t110
  %t111 = zext i1 %t109 to i64
  %t113 = icmp ne i64 %t105, 0
  %t114 = icmp ne i64 %t111, 0
  %t115 = or i1 %t113, %t114
  %t116 = zext i1 %t115 to i64
  %t117 = getelementptr [10 x i8], ptr @.str16, i64 0, i64 0
  %t118 = call i32 @strcmp(ptr %t0, ptr %t117)
  %t119 = sext i32 %t118 to i64
  %t121 = sext i32 0 to i64
  %t120 = icmp eq i64 %t119, %t121
  %t122 = zext i1 %t120 to i64
  %t124 = icmp ne i64 %t116, 0
  %t125 = icmp ne i64 %t122, 0
  %t126 = or i1 %t124, %t125
  %t127 = zext i1 %t126 to i64
  %t128 = getelementptr [11 x i8], ptr @.str17, i64 0, i64 0
  %t129 = call i32 @strcmp(ptr %t0, ptr %t128)
  %t130 = sext i32 %t129 to i64
  %t132 = sext i32 0 to i64
  %t131 = icmp eq i64 %t130, %t132
  %t133 = zext i1 %t131 to i64
  %t135 = icmp ne i64 %t127, 0
  %t136 = icmp ne i64 %t133, 0
  %t137 = or i1 %t135, %t136
  %t138 = zext i1 %t137 to i64
  %t139 = getelementptr [9 x i8], ptr @.str18, i64 0, i64 0
  %t140 = call i32 @strcmp(ptr %t0, ptr %t139)
  %t141 = sext i32 %t140 to i64
  %t143 = sext i32 0 to i64
  %t142 = icmp eq i64 %t141, %t143
  %t144 = zext i1 %t142 to i64
  %t146 = icmp ne i64 %t138, 0
  %t147 = icmp ne i64 %t144, 0
  %t148 = or i1 %t146, %t147
  %t149 = zext i1 %t148 to i64
  %t150 = getelementptr [11 x i8], ptr @.str19, i64 0, i64 0
  %t151 = call i32 @strcmp(ptr %t0, ptr %t150)
  %t152 = sext i32 %t151 to i64
  %t154 = sext i32 0 to i64
  %t153 = icmp eq i64 %t152, %t154
  %t155 = zext i1 %t153 to i64
  %t157 = icmp ne i64 %t149, 0
  %t158 = icmp ne i64 %t155, 0
  %t159 = or i1 %t157, %t158
  %t160 = zext i1 %t159 to i64
  %t161 = getelementptr [9 x i8], ptr @.str20, i64 0, i64 0
  %t162 = call i32 @strcmp(ptr %t0, ptr %t161)
  %t163 = sext i32 %t162 to i64
  %t165 = sext i32 0 to i64
  %t164 = icmp eq i64 %t163, %t165
  %t166 = zext i1 %t164 to i64
  %t168 = icmp ne i64 %t160, 0
  %t169 = icmp ne i64 %t166, 0
  %t170 = or i1 %t168, %t169
  %t171 = zext i1 %t170 to i64
  %t172 = getelementptr [8 x i8], ptr @.str21, i64 0, i64 0
  %t173 = call i32 @strcmp(ptr %t0, ptr %t172)
  %t174 = sext i32 %t173 to i64
  %t176 = sext i32 0 to i64
  %t175 = icmp eq i64 %t174, %t176
  %t177 = zext i1 %t175 to i64
  %t179 = icmp ne i64 %t171, 0
  %t180 = icmp ne i64 %t177, 0
  %t181 = or i1 %t179, %t180
  %t182 = zext i1 %t181 to i64
  %t183 = getelementptr [11 x i8], ptr @.str22, i64 0, i64 0
  %t184 = call i32 @strcmp(ptr %t0, ptr %t183)
  %t185 = sext i32 %t184 to i64
  %t187 = sext i32 0 to i64
  %t186 = icmp eq i64 %t185, %t187
  %t188 = zext i1 %t186 to i64
  %t190 = icmp ne i64 %t182, 0
  %t191 = icmp ne i64 %t188, 0
  %t192 = or i1 %t190, %t191
  %t193 = zext i1 %t192 to i64
  %t194 = getelementptr [14 x i8], ptr @.str23, i64 0, i64 0
  %t195 = call i32 @strcmp(ptr %t0, ptr %t194)
  %t196 = sext i32 %t195 to i64
  %t198 = sext i32 0 to i64
  %t197 = icmp eq i64 %t196, %t198
  %t199 = zext i1 %t197 to i64
  %t201 = icmp ne i64 %t193, 0
  %t202 = icmp ne i64 %t199, 0
  %t203 = or i1 %t201, %t202
  %t204 = zext i1 %t203 to i64
  %t205 = getelementptr [10 x i8], ptr @.str24, i64 0, i64 0
  %t206 = call i32 @strcmp(ptr %t0, ptr %t205)
  %t207 = sext i32 %t206 to i64
  %t209 = sext i32 0 to i64
  %t208 = icmp eq i64 %t207, %t209
  %t210 = zext i1 %t208 to i64
  %t212 = icmp ne i64 %t204, 0
  %t213 = icmp ne i64 %t210, 0
  %t214 = or i1 %t212, %t213
  %t215 = zext i1 %t214 to i64
  %t216 = trunc i64 %t215 to i32
  ret i32 %t216
L0:
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
  %t22 = load ptr, ptr %t12
  %t23 = getelementptr [8 x i8], ptr @.str26, i64 0, i64 0
  %t24 = call i32 @strcmp(ptr %t22, ptr %t23)
  %t25 = sext i32 %t24 to i64
  %t27 = sext i32 0 to i64
  %t26 = icmp eq i64 %t25, %t27
  %t28 = zext i1 %t26 to i64
  %t30 = icmp ne i64 %t21, 0
  %t31 = icmp ne i64 %t28, 0
  %t32 = or i1 %t30, %t31
  %t33 = zext i1 %t32 to i64
  %t34 = load ptr, ptr %t12
  %t35 = getelementptr [6 x i8], ptr @.str27, i64 0, i64 0
  %t36 = call i32 @strcmp(ptr %t34, ptr %t35)
  %t37 = sext i32 %t36 to i64
  %t39 = sext i32 0 to i64
  %t38 = icmp eq i64 %t37, %t39
  %t40 = zext i1 %t38 to i64
  %t42 = icmp ne i64 %t33, 0
  %t43 = icmp ne i64 %t40, 0
  %t44 = or i1 %t42, %t43
  %t45 = zext i1 %t44 to i64
  %t46 = load ptr, ptr %t12
  %t47 = getelementptr [11 x i8], ptr @.str28, i64 0, i64 0
  %t48 = call i32 @strcmp(ptr %t46, ptr %t47)
  %t49 = sext i32 %t48 to i64
  %t51 = sext i32 0 to i64
  %t50 = icmp eq i64 %t49, %t51
  %t52 = zext i1 %t50 to i64
  %t54 = icmp ne i64 %t45, 0
  %t55 = icmp ne i64 %t52, 0
  %t56 = or i1 %t54, %t55
  %t57 = zext i1 %t56 to i64
  %t58 = load ptr, ptr %t12
  %t59 = getelementptr [9 x i8], ptr @.str29, i64 0, i64 0
  %t60 = call i32 @strcmp(ptr %t58, ptr %t59)
  %t61 = sext i32 %t60 to i64
  %t63 = sext i32 0 to i64
  %t62 = icmp eq i64 %t61, %t63
  %t64 = zext i1 %t62 to i64
  %t66 = icmp ne i64 %t57, 0
  %t67 = icmp ne i64 %t64, 0
  %t68 = or i1 %t66, %t67
  %t69 = zext i1 %t68 to i64
  %t70 = load ptr, ptr %t12
  %t71 = getelementptr [11 x i8], ptr @.str30, i64 0, i64 0
  %t72 = call i32 @strcmp(ptr %t70, ptr %t71)
  %t73 = sext i32 %t72 to i64
  %t75 = sext i32 0 to i64
  %t74 = icmp eq i64 %t73, %t75
  %t76 = zext i1 %t74 to i64
  %t78 = icmp ne i64 %t69, 0
  %t79 = icmp ne i64 %t76, 0
  %t80 = or i1 %t78, %t79
  %t81 = zext i1 %t80 to i64
  store i64 %t81, ptr %t14
  call void @advance(ptr %t0)
  %t83 = load i64, ptr %t14
  %t84 = call i32 @check(ptr %t0, i64 72)
  %t85 = sext i32 %t84 to i64
  %t87 = icmp ne i64 %t83, 0
  %t88 = icmp ne i64 %t85, 0
  %t89 = and i1 %t87, %t88
  %t90 = zext i1 %t89 to i64
  %t91 = icmp ne i64 %t90, 0
  br i1 %t91, label %L12, label %L14
L12:
  %t92 = alloca i64
  %t93 = sext i32 1 to i64
  store i64 %t93, ptr %t92
  call void @advance(ptr %t0)
  br label %L15
L15:
  %t95 = call i32 @check(ptr %t0, i64 81)
  %t96 = sext i32 %t95 to i64
  %t98 = icmp eq i64 %t96, 0
  %t97 = zext i1 %t98 to i64
  %t99 = load i64, ptr %t92
  %t101 = sext i32 0 to i64
  %t100 = icmp sgt i64 %t99, %t101
  %t102 = zext i1 %t100 to i64
  %t104 = icmp ne i64 %t97, 0
  %t105 = icmp ne i64 %t102, 0
  %t106 = and i1 %t104, %t105
  %t107 = zext i1 %t106 to i64
  %t108 = icmp ne i64 %t107, 0
  br i1 %t108, label %L16, label %L17
L16:
  %t109 = call i32 @check(ptr %t0, i64 72)
  %t110 = sext i32 %t109 to i64
  %t111 = icmp ne i64 %t110, 0
  br i1 %t111, label %L18, label %L19
L18:
  %t112 = load i64, ptr %t92
  %t113 = add i64 %t112, 1
  store i64 %t113, ptr %t92
  br label %L20
L19:
  %t114 = call i32 @check(ptr %t0, i64 73)
  %t115 = sext i32 %t114 to i64
  %t116 = icmp ne i64 %t115, 0
  br i1 %t116, label %L21, label %L23
L21:
  %t117 = load i64, ptr %t92
  %t118 = sub i64 %t117, 1
  store i64 %t118, ptr %t92
  br label %L23
L23:
  br label %L20
L20:
  call void @advance(ptr %t0)
  br label %L15
L17:
  br label %L14
L14:
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
  %t3 = load ptr, ptr %t0
  %t4 = call i32 @is_gcc_extension(ptr %t3)
  %t5 = sext i32 %t4 to i64
  %t7 = icmp ne i64 %t2, 0
  %t8 = icmp ne i64 %t5, 0
  %t9 = and i1 %t7, %t8
  %t10 = zext i1 %t9 to i64
  %t11 = icmp ne i64 %t10, 0
  br i1 %t11, label %L0, label %L2
L0:
  %t12 = sext i32 0 to i64
  %t13 = trunc i64 %t12 to i32
  ret i32 %t13
L3:
  br label %L2
L2:
  %t14 = load ptr, ptr %t0
  %t15 = ptrtoint ptr %t14 to i64
  %t16 = add i64 %t15, 0
  switch i64 %t16, label %L23 [
    i64 5, label %L5
    i64 6, label %L6
    i64 7, label %L7
    i64 8, label %L8
    i64 9, label %L9
    i64 10, label %L10
    i64 11, label %L11
    i64 12, label %L12
    i64 13, label %L13
    i64 26, label %L14
    i64 27, label %L15
    i64 28, label %L16
    i64 32, label %L17
    i64 33, label %L18
    i64 30, label %L19
    i64 31, label %L20
    i64 29, label %L21
    i64 4, label %L22
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
  %t17 = sext i32 1 to i64
  %t18 = trunc i64 %t17 to i32
  ret i32 %t18
L24:
  br label %L22
L22:
  %t19 = load ptr, ptr %t0
  %t20 = call ptr @lookup_typedef(ptr %t0, ptr %t19)
  %t22 = sext i32 0 to i64
  %t21 = inttoptr i64 %t22 to ptr
  %t24 = ptrtoint ptr %t20 to i64
  %t25 = ptrtoint ptr %t21 to i64
  %t23 = icmp ne i64 %t24, %t25
  %t26 = zext i1 %t23 to i64
  %t27 = trunc i64 %t26 to i32
  ret i32 %t27
L25:
  br label %L4
L23:
  %t28 = sext i32 0 to i64
  %t29 = trunc i64 %t28 to i32
  ret i32 %t29
L26:
  br label %L4
L4:
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
  %t36 = load i64, ptr %t30
  %t38 = sext i32 0 to i64
  %t37 = icmp sgt i64 %t36, %t38
  %t39 = zext i1 %t37 to i64
  %t41 = icmp ne i64 %t34, 0
  %t42 = icmp ne i64 %t39, 0
  %t43 = and i1 %t41, %t42
  %t44 = zext i1 %t43 to i64
  %t45 = icmp ne i64 %t44, 0
  br i1 %t45, label %L10, label %L11
L10:
  %t46 = call i32 @check(ptr %t0, i64 74)
  %t47 = sext i32 %t46 to i64
  %t48 = icmp ne i64 %t47, 0
  br i1 %t48, label %L12, label %L13
L12:
  %t49 = load i64, ptr %t30
  %t50 = add i64 %t49, 1
  store i64 %t50, ptr %t30
  br label %L14
L13:
  %t51 = call i32 @check(ptr %t0, i64 75)
  %t52 = sext i32 %t51 to i64
  %t53 = icmp ne i64 %t52, 0
  br i1 %t53, label %L15, label %L17
L15:
  %t54 = load i64, ptr %t30
  %t55 = sub i64 %t54, 1
  store i64 %t55, ptr %t30
  br label %L17
L17:
  br label %L14
L14:
  call void @advance(ptr %t0)
  br label %L9
L11:
  br label %L8
L8:
  %t57 = load ptr, ptr %t17
  ret ptr %t57
L18:
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
  %t21 = call i32 @check(ptr %t0, i64 81)
  %t22 = sext i32 %t21 to i64
  %t24 = icmp eq i64 %t22, 0
  %t23 = zext i1 %t24 to i64
  %t26 = icmp ne i64 %t19, 0
  %t27 = icmp ne i64 %t23, 0
  %t28 = and i1 %t26, %t27
  %t29 = zext i1 %t28 to i64
  %t30 = icmp ne i64 %t29, 0
  br i1 %t30, label %L7, label %L8
L7:
  %t31 = call i32 @check(ptr %t0, i64 4)
  %t32 = sext i32 %t31 to i64
  %t33 = icmp ne i64 %t32, 0
  br i1 %t33, label %L9, label %L10
L9:
  %t34 = alloca ptr
  %t35 = load ptr, ptr %t0
  %t36 = call ptr @strdup(ptr %t35)
  store ptr %t36, ptr %t34
  call void @advance(ptr %t0)
  %t38 = call i32 @match(ptr %t0, i64 55)
  %t39 = sext i32 %t38 to i64
  %t40 = icmp ne i64 %t39, 0
  br i1 %t40, label %L12, label %L14
L12:
  %t41 = call i32 @check(ptr %t0, i64 0)
  %t42 = sext i32 %t41 to i64
  %t43 = icmp ne i64 %t42, 0
  br i1 %t43, label %L15, label %L16
L15:
  %t44 = load ptr, ptr %t0
  %t46 = sext i32 0 to i64
  %t45 = inttoptr i64 %t46 to ptr
  %t47 = call i64 @strtoll(ptr %t44, ptr %t45, i64 0)
  %t48 = add i64 %t47, 0
  store i64 %t48, ptr %t15
  call void @advance(ptr %t0)
  br label %L17
L16:
  %t50 = call i32 @check(ptr %t0, i64 36)
  %t51 = sext i32 %t50 to i64
  %t52 = icmp ne i64 %t51, 0
  br i1 %t52, label %L18, label %L19
L18:
  call void @advance(ptr %t0)
  %t54 = call i32 @check(ptr %t0, i64 0)
  %t55 = sext i32 %t54 to i64
  %t56 = icmp ne i64 %t55, 0
  br i1 %t56, label %L21, label %L23
L21:
  %t57 = load ptr, ptr %t0
  %t59 = sext i32 0 to i64
  %t58 = inttoptr i64 %t59 to ptr
  %t60 = call i64 @strtoll(ptr %t57, ptr %t58, i64 0)
  %t61 = add i64 %t60, 0
  %t62 = sub i64 0, %t61
  store i64 %t62, ptr %t15
  call void @advance(ptr %t0)
  br label %L23
L23:
  br label %L20
L19:
  %t64 = call i32 @check(ptr %t0, i64 4)
  %t65 = sext i32 %t64 to i64
  %t66 = icmp ne i64 %t65, 0
  br i1 %t66, label %L24, label %L26
L24:
  %t67 = alloca i64
  %t68 = load ptr, ptr %t0
  %t69 = call i32 @lookup_enum_const(ptr %t0, ptr %t68, ptr %t67)
  %t70 = sext i32 %t69 to i64
  %t71 = icmp ne i64 %t70, 0
  br i1 %t71, label %L27, label %L29
L27:
  %t72 = load i64, ptr %t67
  store i64 %t72, ptr %t15
  br label %L29
L29:
  call void @advance(ptr %t0)
  %t74 = call i32 @check(ptr %t0, i64 35)
  %t75 = sext i32 %t74 to i64
  %t76 = call i32 @check(ptr %t0, i64 36)
  %t77 = sext i32 %t76 to i64
  %t79 = icmp ne i64 %t75, 0
  %t80 = icmp ne i64 %t77, 0
  %t81 = or i1 %t79, %t80
  %t82 = zext i1 %t81 to i64
  %t83 = icmp ne i64 %t82, 0
  br i1 %t83, label %L30, label %L32
L30:
  %t84 = alloca i64
  %t85 = load ptr, ptr %t0
  %t87 = ptrtoint ptr %t85 to i64
  %t88 = sext i32 36 to i64
  %t86 = icmp eq i64 %t87, %t88
  %t89 = zext i1 %t86 to i64
  store i64 %t89, ptr %t84
  call void @advance(ptr %t0)
  %t91 = call i32 @check(ptr %t0, i64 0)
  %t92 = sext i32 %t91 to i64
  %t93 = icmp ne i64 %t92, 0
  br i1 %t93, label %L33, label %L35
L33:
  %t94 = alloca i64
  %t95 = load ptr, ptr %t0
  %t97 = sext i32 0 to i64
  %t96 = inttoptr i64 %t97 to ptr
  %t98 = call i64 @strtoll(ptr %t95, ptr %t96, i64 0)
  store i64 %t98, ptr %t94
  %t99 = load i64, ptr %t84
  %t100 = icmp ne i64 %t99, 0
  br i1 %t100, label %L36, label %L37
L36:
  %t101 = load i64, ptr %t15
  %t102 = load i64, ptr %t94
  %t103 = sub i64 %t101, %t102
  br label %L38
L37:
  %t104 = load i64, ptr %t15
  %t105 = load i64, ptr %t94
  %t106 = add i64 %t104, %t105
  br label %L38
L38:
  %t107 = phi i64 [ %t103, %L36 ], [ %t106, %L37 ]
  store i64 %t107, ptr %t15
  call void @advance(ptr %t0)
  br label %L35
L35:
  br label %L32
L32:
  br label %L26
L26:
  br label %L20
L20:
  br label %L17
L17:
  br label %L14
L14:
  %t109 = load ptr, ptr %t34
  %t110 = load i64, ptr %t15
  %t111 = add i64 %t110, 1
  store i64 %t111, ptr %t15
  call void @register_enum_const(ptr %t0, ptr %t109, i64 %t110)
  %t113 = load ptr, ptr %t34
  call void @free(ptr %t113)
  br label %L11
L10:
  call void @advance(ptr %t0)
  br label %L11
L11:
  %t116 = call i32 @match(ptr %t0, i64 79)
  %t117 = sext i32 %t116 to i64
  %t119 = icmp eq i64 %t117, 0
  %t118 = zext i1 %t119 to i64
  %t120 = icmp ne i64 %t118, 0
  br i1 %t120, label %L39, label %L41
L39:
  br label %L8
L42:
  br label %L41
L41:
  br label %L6
L8:
  call void @expect(ptr %t0, i64 75)
  br label %L5
L5:
  %t122 = load ptr, ptr %t2
  ret ptr %t122
L43:
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
  %t33 = load ptr, ptr %t0
  %t34 = call i32 @is_gcc_extension(ptr %t33)
  %t35 = sext i32 %t34 to i64
  %t37 = icmp ne i64 %t32, 0
  %t38 = icmp ne i64 %t35, 0
  %t39 = and i1 %t37, %t38
  %t40 = zext i1 %t39 to i64
  %t41 = icmp ne i64 %t40, 0
  br i1 %t41, label %L4, label %L6
L4:
  call void @skip_gcc_extension(ptr %t0)
  br label %L2
L7:
  br label %L6
L6:
  %t43 = load ptr, ptr %t0
  %t44 = ptrtoint ptr %t43 to i64
  %t45 = add i64 %t44, 0
  switch i64 %t45, label %L27 [
    i64 29, label %L9
    i64 30, label %L10
    i64 31, label %L11
    i64 32, label %L12
    i64 33, label %L13
    i64 12, label %L14
    i64 13, label %L15
    i64 11, label %L16
    i64 10, label %L17
    i64 9, label %L18
    i64 6, label %L19
    i64 5, label %L20
    i64 7, label %L21
    i64 8, label %L22
    i64 26, label %L23
    i64 27, label %L24
    i64 28, label %L25
    i64 4, label %L26
  ]
L9:
  %t46 = sext i32 1 to i64
  store i64 %t46, ptr %t4
  call void @advance(ptr %t0)
  br label %L8
L28:
  br label %L10
L10:
  %t48 = sext i32 1 to i64
  store i64 %t48, ptr %t6
  call void @advance(ptr %t0)
  br label %L8
L29:
  br label %L11
L11:
  %t50 = sext i32 1 to i64
  store i64 %t50, ptr %t8
  call void @advance(ptr %t0)
  br label %L8
L30:
  br label %L12
L12:
  %t52 = sext i32 1 to i64
  store i64 %t52, ptr %t10
  call void @advance(ptr %t0)
  br label %L8
L31:
  br label %L13
L13:
  %t54 = sext i32 1 to i64
  store i64 %t54, ptr %t12
  call void @advance(ptr %t0)
  br label %L8
L32:
  br label %L14
L14:
  %t56 = sext i32 1 to i64
  store i64 %t56, ptr %t14
  call void @advance(ptr %t0)
  br label %L8
L33:
  br label %L15
L15:
  %t58 = sext i32 1 to i64
  store i64 %t58, ptr %t16
  call void @advance(ptr %t0)
  br label %L8
L34:
  br label %L16
L16:
  %t60 = sext i32 1 to i64
  store i64 %t60, ptr %t22
  call void @advance(ptr %t0)
  br label %L8
L35:
  br label %L17
L17:
  %t62 = load i64, ptr %t18
  %t63 = icmp ne i64 %t62, 0
  br i1 %t63, label %L36, label %L37
L36:
  %t64 = sext i32 1 to i64
  store i64 %t64, ptr %t20
  br label %L38
L37:
  %t65 = sext i32 1 to i64
  store i64 %t65, ptr %t18
  br label %L38
L38:
  call void @advance(ptr %t0)
  br label %L8
L39:
  br label %L18
L18:
  %t67 = sext i32 0 to i64
  store i64 %t67, ptr %t24
  %t68 = sext i32 1 to i64
  store i64 %t68, ptr %t26
  call void @advance(ptr %t0)
  br label %L8
L40:
  br label %L19
L19:
  %t70 = sext i32 2 to i64
  store i64 %t70, ptr %t24
  %t71 = sext i32 1 to i64
  store i64 %t71, ptr %t26
  call void @advance(ptr %t0)
  br label %L8
L41:
  br label %L20
L20:
  %t73 = sext i32 7 to i64
  store i64 %t73, ptr %t24
  %t74 = sext i32 1 to i64
  store i64 %t74, ptr %t26
  call void @advance(ptr %t0)
  br label %L8
L42:
  br label %L21
L21:
  %t76 = sext i32 13 to i64
  store i64 %t76, ptr %t24
  %t77 = sext i32 1 to i64
  store i64 %t77, ptr %t26
  call void @advance(ptr %t0)
  br label %L8
L43:
  br label %L22
L22:
  %t79 = sext i32 14 to i64
  store i64 %t79, ptr %t24
  %t80 = sext i32 1 to i64
  store i64 %t80, ptr %t26
  call void @advance(ptr %t0)
  br label %L8
L44:
  br label %L23
L23:
  br label %L24
L24:
  %t82 = call ptr @parse_struct_union(ptr %t0)
  store ptr %t82, ptr %t28
  %t83 = sext i32 1 to i64
  store i64 %t83, ptr %t26
  br label %parse_type_done
L45:
  br label %L25
L25:
  %t84 = call ptr @parse_enum_specifier(ptr %t0)
  store ptr %t84, ptr %t28
  %t85 = sext i32 1 to i64
  store i64 %t85, ptr %t26
  br label %parse_type_done
L46:
  br label %L26
L26:
  %t86 = alloca ptr
  %t87 = load ptr, ptr %t0
  %t88 = call ptr @lookup_typedef(ptr %t0, ptr %t87)
  store ptr %t88, ptr %t86
  %t89 = load ptr, ptr %t86
  %t90 = icmp ne ptr %t89, null
  br i1 %t90, label %L47, label %L49
L47:
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
L50:
  br label %L49
L49:
  br label %parse_type_done
L51:
  br label %L8
L27:
  br label %parse_type_done
L52:
  br label %L8
L8:
  br label %L2
L2:
  br label %L0
L3:
  br label %parse_type_done
parse_type_done:
  %t97 = icmp ne ptr %t1, null
  br i1 %t97, label %L53, label %L55
L53:
  %t98 = load i64, ptr %t4
  store i64 %t98, ptr %t1
  br label %L55
L55:
  %t99 = icmp ne ptr %t2, null
  br i1 %t99, label %L56, label %L58
L56:
  %t100 = load i64, ptr %t6
  store i64 %t100, ptr %t2
  br label %L58
L58:
  %t101 = icmp ne ptr %t3, null
  br i1 %t101, label %L59, label %L61
L59:
  %t102 = load i64, ptr %t8
  store i64 %t102, ptr %t3
  br label %L61
L61:
  %t103 = load ptr, ptr %t28
  %t104 = icmp ne ptr %t103, null
  br i1 %t104, label %L62, label %L64
L62:
  %t105 = load i64, ptr %t10
  %t106 = load ptr, ptr %t28
  store i64 %t105, ptr %t106
  %t107 = load i64, ptr %t12
  %t108 = load ptr, ptr %t28
  store i64 %t107, ptr %t108
  %t109 = load ptr, ptr %t28
  ret ptr %t109
L65:
  br label %L64
L64:
  %t110 = load i64, ptr %t26
  %t112 = icmp eq i64 %t110, 0
  %t111 = zext i1 %t112 to i64
  %t113 = load i64, ptr %t18
  %t115 = icmp eq i64 %t113, 0
  %t114 = zext i1 %t115 to i64
  %t117 = icmp ne i64 %t111, 0
  %t118 = icmp ne i64 %t114, 0
  %t119 = and i1 %t117, %t118
  %t120 = zext i1 %t119 to i64
  %t121 = load i64, ptr %t22
  %t123 = icmp eq i64 %t121, 0
  %t122 = zext i1 %t123 to i64
  %t125 = icmp ne i64 %t120, 0
  %t126 = icmp ne i64 %t122, 0
  %t127 = and i1 %t125, %t126
  %t128 = zext i1 %t127 to i64
  %t129 = load i64, ptr %t14
  %t131 = icmp eq i64 %t129, 0
  %t130 = zext i1 %t131 to i64
  %t133 = icmp ne i64 %t128, 0
  %t134 = icmp ne i64 %t130, 0
  %t135 = and i1 %t133, %t134
  %t136 = zext i1 %t135 to i64
  %t137 = load i64, ptr %t16
  %t139 = icmp eq i64 %t137, 0
  %t138 = zext i1 %t139 to i64
  %t141 = icmp ne i64 %t136, 0
  %t142 = icmp ne i64 %t138, 0
  %t143 = and i1 %t141, %t142
  %t144 = zext i1 %t143 to i64
  %t145 = icmp ne i64 %t144, 0
  br i1 %t145, label %L66, label %L68
L66:
  %t147 = sext i32 0 to i64
  %t146 = inttoptr i64 %t147 to ptr
  ret ptr %t146
L69:
  br label %L68
L68:
  %t148 = load i64, ptr %t24
  %t150 = sext i32 2 to i64
  %t149 = icmp eq i64 %t148, %t150
  %t151 = zext i1 %t149 to i64
  %t152 = icmp ne i64 %t151, 0
  br i1 %t152, label %L70, label %L71
L70:
  %t153 = load i64, ptr %t14
  %t154 = icmp ne i64 %t153, 0
  br i1 %t154, label %L73, label %L74
L73:
  %t155 = sext i32 4 to i64
  store i64 %t155, ptr %t24
  br label %L75
L74:
  %t156 = load i64, ptr %t16
  %t157 = icmp ne i64 %t156, 0
  br i1 %t157, label %L76, label %L78
L76:
  %t158 = sext i32 3 to i64
  store i64 %t158, ptr %t24
  br label %L78
L78:
  br label %L75
L75:
  br label %L72
L71:
  %t159 = load i64, ptr %t20
  %t160 = icmp ne i64 %t159, 0
  br i1 %t160, label %L79, label %L80
L79:
  %t161 = load i64, ptr %t14
  %t162 = icmp ne i64 %t161, 0
  br i1 %t162, label %L82, label %L83
L82:
  %t163 = sext i32 12 to i64
  br label %L84
L83:
  %t164 = sext i32 11 to i64
  br label %L84
L84:
  %t165 = phi i64 [ %t163, %L82 ], [ %t164, %L83 ]
  store i64 %t165, ptr %t24
  br label %L81
L80:
  %t166 = load i64, ptr %t18
  %t167 = icmp ne i64 %t166, 0
  br i1 %t167, label %L85, label %L86
L85:
  %t168 = load i64, ptr %t14
  %t169 = icmp ne i64 %t168, 0
  br i1 %t169, label %L88, label %L89
L88:
  %t170 = sext i32 10 to i64
  br label %L90
L89:
  %t171 = sext i32 9 to i64
  br label %L90
L90:
  %t172 = phi i64 [ %t170, %L88 ], [ %t171, %L89 ]
  store i64 %t172, ptr %t24
  br label %L87
L86:
  %t173 = load i64, ptr %t22
  %t174 = icmp ne i64 %t173, 0
  br i1 %t174, label %L91, label %L92
L91:
  %t175 = load i64, ptr %t14
  %t176 = icmp ne i64 %t175, 0
  br i1 %t176, label %L94, label %L95
L94:
  %t177 = sext i32 6 to i64
  br label %L96
L95:
  %t178 = sext i32 5 to i64
  br label %L96
L96:
  %t179 = phi i64 [ %t177, %L94 ], [ %t178, %L95 ]
  store i64 %t179, ptr %t24
  br label %L93
L92:
  %t180 = load i64, ptr %t24
  %t182 = sext i32 7 to i64
  %t181 = icmp eq i64 %t180, %t182
  %t183 = zext i1 %t181 to i64
  %t184 = load i64, ptr %t26
  %t186 = icmp eq i64 %t184, 0
  %t185 = zext i1 %t186 to i64
  %t188 = icmp ne i64 %t183, 0
  %t189 = icmp ne i64 %t185, 0
  %t190 = or i1 %t188, %t189
  %t191 = zext i1 %t190 to i64
  %t192 = icmp ne i64 %t191, 0
  br i1 %t192, label %L97, label %L99
L97:
  %t193 = load i64, ptr %t14
  %t194 = icmp ne i64 %t193, 0
  br i1 %t194, label %L100, label %L102
L100:
  %t195 = sext i32 8 to i64
  store i64 %t195, ptr %t24
  br label %L102
L102:
  br label %L99
L99:
  br label %L93
L93:
  br label %L87
L87:
  br label %L81
L81:
  br label %L72
L72:
  %t196 = alloca ptr
  %t197 = load i64, ptr %t24
  %t198 = call ptr @type_new(i64 %t197)
  store ptr %t198, ptr %t196
  %t199 = load i64, ptr %t10
  %t200 = load ptr, ptr %t196
  store i64 %t199, ptr %t200
  %t201 = load i64, ptr %t12
  %t202 = load ptr, ptr %t196
  store i64 %t201, ptr %t202
  %t203 = load ptr, ptr %t196
  ret ptr %t203
L103:
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
  %t9 = load i64, ptr %t3
  %t11 = sext i32 16 to i64
  %t10 = icmp slt i64 %t9, %t11
  %t12 = zext i1 %t10 to i64
  %t14 = icmp ne i64 %t8, 0
  %t15 = icmp ne i64 %t12, 0
  %t16 = and i1 %t14, %t15
  %t17 = zext i1 %t16 to i64
  %t18 = icmp ne i64 %t17, 0
  br i1 %t18, label %L1, label %L2
L1:
  call void @advance(ptr %t0)
  %t20 = load ptr, ptr %t5
  %t21 = load i64, ptr %t3
  %t22 = getelementptr i8, ptr %t20, i64 %t21
  %t23 = sext i32 0 to i64
  store i64 %t23, ptr %t22
  br label %L3
L3:
  %t24 = call i32 @check(ptr %t0, i64 32)
  %t25 = sext i32 %t24 to i64
  %t26 = call i32 @check(ptr %t0, i64 33)
  %t27 = sext i32 %t26 to i64
  %t29 = icmp ne i64 %t25, 0
  %t30 = icmp ne i64 %t27, 0
  %t31 = or i1 %t29, %t30
  %t32 = zext i1 %t31 to i64
  %t33 = icmp ne i64 %t32, 0
  br i1 %t33, label %L4, label %L5
L4:
  %t34 = call i32 @check(ptr %t0, i64 32)
  %t35 = sext i32 %t34 to i64
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L6, label %L8
L6:
  %t37 = load ptr, ptr %t5
  %t38 = load i64, ptr %t3
  %t39 = getelementptr i8, ptr %t37, i64 %t38
  %t40 = sext i32 1 to i64
  store i64 %t40, ptr %t39
  br label %L8
L8:
  call void @advance(ptr %t0)
  br label %L3
L5:
  %t42 = load i64, ptr %t3
  %t43 = add i64 %t42, 1
  store i64 %t43, ptr %t3
  br label %L0
L2:
  %t44 = alloca i64
  %t45 = load i64, ptr %t3
  %t47 = sext i32 1 to i64
  %t46 = sub i64 %t45, %t47
  store i64 %t46, ptr %t44
  br label %L9
L9:
  %t48 = load i64, ptr %t44
  %t50 = sext i32 0 to i64
  %t49 = icmp sge i64 %t48, %t50
  %t51 = zext i1 %t49 to i64
  %t52 = icmp ne i64 %t51, 0
  br i1 %t52, label %L10, label %L12
L10:
  %t53 = alloca ptr
  %t54 = call ptr @type_ptr(ptr %t1)
  store ptr %t54, ptr %t53
  %t55 = load ptr, ptr %t5
  %t56 = load i64, ptr %t44
  %t57 = getelementptr i32, ptr %t55, i64 %t56
  %t58 = load i64, ptr %t57
  %t59 = load ptr, ptr %t53
  store i64 %t58, ptr %t59
  %t60 = load ptr, ptr %t53
  store ptr %t60, ptr %t1
  br label %L11
L11:
  %t61 = load i64, ptr %t44
  %t62 = sub i64 %t61, 1
  store i64 %t62, ptr %t44
  br label %L9
L12:
  %t63 = icmp ne ptr %t2, null
  br i1 %t63, label %L13, label %L15
L13:
  %t65 = sext i32 0 to i64
  %t64 = inttoptr i64 %t65 to ptr
  store ptr %t64, ptr %t2
  br label %L15
L15:
  call void @skip_gcc_extension(ptr %t0)
  %t67 = call i32 @check(ptr %t0, i64 4)
  %t68 = sext i32 %t67 to i64
  %t69 = load ptr, ptr %t0
  %t70 = call i32 @is_gcc_extension(ptr %t69)
  %t71 = sext i32 %t70 to i64
  %t73 = icmp eq i64 %t71, 0
  %t72 = zext i1 %t73 to i64
  %t75 = icmp ne i64 %t68, 0
  %t76 = icmp ne i64 %t72, 0
  %t77 = and i1 %t75, %t76
  %t78 = zext i1 %t77 to i64
  %t79 = icmp ne i64 %t78, 0
  br i1 %t79, label %L16, label %L17
L16:
  %t80 = icmp ne ptr %t2, null
  br i1 %t80, label %L19, label %L21
L19:
  %t81 = load ptr, ptr %t0
  %t82 = call ptr @strdup(ptr %t81)
  store ptr %t82, ptr %t2
  br label %L21
L21:
  call void @advance(ptr %t0)
  br label %L18
L17:
  %t84 = call i32 @check(ptr %t0, i64 72)
  %t85 = sext i32 %t84 to i64
  %t86 = icmp ne i64 %t85, 0
  br i1 %t86, label %L22, label %L24
L22:
  call void @advance(ptr %t0)
  %t88 = call ptr @parse_declarator(ptr %t0, ptr %t1, ptr %t2)
  store ptr %t88, ptr %t1
  call void @expect(ptr %t0, i64 73)
  br label %L24
L24:
  br label %L18
L18:
  call void @skip_gcc_extension(ptr %t0)
  br label %L25
L25:
  br label %L26
L26:
  %t91 = call i32 @check(ptr %t0, i64 4)
  %t92 = sext i32 %t91 to i64
  %t93 = load ptr, ptr %t0
  %t94 = call i32 @is_gcc_extension(ptr %t93)
  %t95 = sext i32 %t94 to i64
  %t97 = icmp ne i64 %t92, 0
  %t98 = icmp ne i64 %t95, 0
  %t99 = and i1 %t97, %t98
  %t100 = zext i1 %t99 to i64
  %t101 = icmp ne i64 %t100, 0
  br i1 %t101, label %L29, label %L31
L29:
  call void @skip_gcc_extension(ptr %t0)
  br label %L27
L32:
  br label %L31
L31:
  %t103 = call i32 @check(ptr %t0, i64 76)
  %t104 = sext i32 %t103 to i64
  %t105 = icmp ne i64 %t104, 0
  br i1 %t105, label %L33, label %L34
L33:
  call void @advance(ptr %t0)
  %t107 = alloca i64
  %t109 = sext i32 1 to i64
  %t108 = sub i64 0, %t109
  store i64 %t108, ptr %t107
  %t110 = call i32 @check(ptr %t0, i64 77)
  %t111 = sext i32 %t110 to i64
  %t113 = icmp eq i64 %t111, 0
  %t112 = zext i1 %t113 to i64
  %t114 = icmp ne i64 %t112, 0
  br i1 %t114, label %L36, label %L38
L36:
  %t115 = call i32 @check(ptr %t0, i64 0)
  %t116 = sext i32 %t115 to i64
  %t117 = icmp ne i64 %t116, 0
  br i1 %t117, label %L39, label %L40
L39:
  %t118 = load ptr, ptr %t0
  %t119 = call i64 @atol(ptr %t118)
  %t120 = add i64 %t119, 0
  store i64 %t120, ptr %t107
  call void @advance(ptr %t0)
  br label %L41
L40:
  %t122 = alloca i64
  %t123 = sext i32 0 to i64
  store i64 %t123, ptr %t122
  br label %L42
L42:
  %t124 = call i32 @check(ptr %t0, i64 81)
  %t125 = sext i32 %t124 to i64
  %t127 = icmp eq i64 %t125, 0
  %t126 = zext i1 %t127 to i64
  %t128 = icmp ne i64 %t126, 0
  br i1 %t128, label %L43, label %L44
L43:
  %t129 = call i32 @check(ptr %t0, i64 76)
  %t130 = sext i32 %t129 to i64
  %t131 = icmp ne i64 %t130, 0
  br i1 %t131, label %L45, label %L47
L45:
  %t132 = load i64, ptr %t122
  %t133 = add i64 %t132, 1
  store i64 %t133, ptr %t122
  br label %L47
L47:
  %t134 = call i32 @check(ptr %t0, i64 77)
  %t135 = sext i32 %t134 to i64
  %t136 = icmp ne i64 %t135, 0
  br i1 %t136, label %L48, label %L50
L48:
  %t137 = load i64, ptr %t122
  %t139 = sext i32 0 to i64
  %t138 = icmp eq i64 %t137, %t139
  %t140 = zext i1 %t138 to i64
  %t141 = icmp ne i64 %t140, 0
  br i1 %t141, label %L51, label %L53
L51:
  br label %L44
L54:
  br label %L53
L53:
  %t142 = load i64, ptr %t122
  %t143 = sub i64 %t142, 1
  store i64 %t143, ptr %t122
  br label %L50
L50:
  call void @advance(ptr %t0)
  br label %L42
L44:
  br label %L41
L41:
  br label %L38
L38:
  call void @expect(ptr %t0, i64 77)
  %t146 = load i64, ptr %t107
  %t147 = call ptr @type_array(ptr %t1, i64 %t146)
  store ptr %t147, ptr %t1
  br label %L35
L34:
  %t148 = call i32 @check(ptr %t0, i64 72)
  %t149 = sext i32 %t148 to i64
  %t150 = icmp ne i64 %t149, 0
  br i1 %t150, label %L55, label %L56
L55:
  call void @advance(ptr %t0)
  %t152 = alloca ptr
  %t153 = call ptr @type_new(i64 17)
  store ptr %t153, ptr %t152
  %t154 = load ptr, ptr %t152
  store ptr %t1, ptr %t154
  %t155 = alloca ptr
  %t157 = sext i32 0 to i64
  %t156 = inttoptr i64 %t157 to ptr
  store ptr %t156, ptr %t155
  %t158 = alloca i64
  %t159 = sext i32 0 to i64
  store i64 %t159, ptr %t158
  %t160 = alloca i64
  %t161 = sext i32 0 to i64
  store i64 %t161, ptr %t160
  br label %L58
L58:
  %t162 = call i32 @check(ptr %t0, i64 73)
  %t163 = sext i32 %t162 to i64
  %t165 = icmp eq i64 %t163, 0
  %t164 = zext i1 %t165 to i64
  %t166 = call i32 @check(ptr %t0, i64 81)
  %t167 = sext i32 %t166 to i64
  %t169 = icmp eq i64 %t167, 0
  %t168 = zext i1 %t169 to i64
  %t171 = icmp ne i64 %t164, 0
  %t172 = icmp ne i64 %t168, 0
  %t173 = and i1 %t171, %t172
  %t174 = zext i1 %t173 to i64
  %t175 = icmp ne i64 %t174, 0
  br i1 %t175, label %L59, label %L60
L59:
  %t176 = call i32 @check(ptr %t0, i64 80)
  %t177 = sext i32 %t176 to i64
  %t178 = icmp ne i64 %t177, 0
  br i1 %t178, label %L61, label %L63
L61:
  %t179 = sext i32 1 to i64
  store i64 %t179, ptr %t160
  call void @advance(ptr %t0)
  br label %L60
L64:
  br label %L63
L63:
  %t181 = alloca i64
  %t182 = sext i32 0 to i64
  store i64 %t182, ptr %t181
  %t183 = alloca i64
  %t184 = sext i32 0 to i64
  store i64 %t184, ptr %t183
  %t185 = alloca i64
  %t186 = sext i32 0 to i64
  store i64 %t186, ptr %t185
  %t187 = alloca ptr
  %t188 = call ptr @parse_type_specifier(ptr %t0, ptr %t181, ptr %t183, ptr %t185)
  store ptr %t188, ptr %t187
  %t189 = load ptr, ptr %t187
  %t191 = ptrtoint ptr %t189 to i64
  %t192 = icmp eq i64 %t191, 0
  %t190 = zext i1 %t192 to i64
  %t193 = icmp ne i64 %t190, 0
  br i1 %t193, label %L65, label %L67
L65:
  br label %L60
L68:
  br label %L67
L67:
  %t194 = alloca ptr
  %t196 = sext i32 0 to i64
  %t195 = inttoptr i64 %t196 to ptr
  store ptr %t195, ptr %t194
  %t197 = load ptr, ptr %t187
  %t198 = call ptr @parse_declarator(ptr %t0, ptr %t197, ptr %t194)
  store ptr %t198, ptr %t187
  %t199 = load ptr, ptr %t155
  %t200 = load i64, ptr %t158
  %t202 = sext i32 1 to i64
  %t201 = add i64 %t200, %t202
  %t204 = sext i32 8 to i64
  %t203 = mul i64 %t201, %t204
  %t205 = call ptr @realloc(ptr %t199, i64 %t203)
  store ptr %t205, ptr %t155
  %t206 = load ptr, ptr %t155
  %t208 = ptrtoint ptr %t206 to i64
  %t209 = icmp eq i64 %t208, 0
  %t207 = zext i1 %t209 to i64
  %t210 = icmp ne i64 %t207, 0
  br i1 %t210, label %L69, label %L71
L69:
  %t211 = getelementptr [8 x i8], ptr @.str31, i64 0, i64 0
  call void @perror(ptr %t211)
  call void @exit(i64 1)
  br label %L71
L71:
  %t214 = load ptr, ptr %t194
  %t215 = load ptr, ptr %t155
  %t216 = load i64, ptr %t158
  %t217 = getelementptr i8, ptr %t215, i64 %t216
  store ptr %t214, ptr %t217
  %t218 = load ptr, ptr %t187
  %t219 = load ptr, ptr %t155
  %t220 = load i64, ptr %t158
  %t221 = getelementptr i8, ptr %t219, i64 %t220
  store ptr %t218, ptr %t221
  %t222 = load i64, ptr %t158
  %t223 = add i64 %t222, 1
  store i64 %t223, ptr %t158
  %t224 = call i32 @match(ptr %t0, i64 79)
  %t225 = sext i32 %t224 to i64
  %t227 = icmp eq i64 %t225, 0
  %t226 = zext i1 %t227 to i64
  %t228 = icmp ne i64 %t226, 0
  br i1 %t228, label %L72, label %L74
L72:
  br label %L60
L75:
  br label %L74
L74:
  br label %L58
L60:
  call void @expect(ptr %t0, i64 73)
  %t230 = load ptr, ptr %t155
  %t231 = load ptr, ptr %t152
  store ptr %t230, ptr %t231
  %t232 = load i64, ptr %t158
  %t233 = load ptr, ptr %t152
  store i64 %t232, ptr %t233
  %t234 = load i64, ptr %t160
  %t235 = load ptr, ptr %t152
  store i64 %t234, ptr %t235
  %t236 = load ptr, ptr %t152
  store ptr %t236, ptr %t1
  br label %L57
L56:
  br label %L28
L76:
  br label %L57
L57:
  br label %L35
L35:
  br label %L27
L27:
  br label %L25
L28:
  ret ptr %t1
L77:
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
  %t39 = getelementptr i32, ptr %t37, i64 %t38
  %t40 = load i64, ptr %t39
  %t42 = sext i32 39 to i64
  %t41 = icmp eq i64 %t40, %t42
  %t43 = zext i1 %t41 to i64
  %t44 = load ptr, ptr %t35
  %t45 = sext i32 1 to i64
  %t46 = getelementptr i32, ptr %t44, i64 %t45
  %t47 = load i64, ptr %t46
  %t49 = sext i32 92 to i64
  %t48 = icmp eq i64 %t47, %t49
  %t50 = zext i1 %t48 to i64
  %t52 = icmp ne i64 %t43, 0
  %t53 = icmp ne i64 %t50, 0
  %t54 = and i1 %t52, %t53
  %t55 = zext i1 %t54 to i64
  %t56 = icmp ne i64 %t55, 0
  br i1 %t56, label %L11, label %L12
L11:
  %t57 = load ptr, ptr %t35
  %t58 = sext i32 2 to i64
  %t59 = getelementptr i32, ptr %t57, i64 %t58
  %t60 = load i64, ptr %t59
  %t61 = add i64 %t60, 0
  switch i64 %t61, label %L19 [
    i64 110, label %L15
    i64 116, label %L16
    i64 114, label %L17
    i64 48, label %L18
  ]
L15:
  %t62 = load ptr, ptr %t32
  %t63 = sext i32 10 to i64
  store i64 %t63, ptr %t62
  br label %L14
L20:
  br label %L16
L16:
  %t64 = load ptr, ptr %t32
  %t65 = sext i32 9 to i64
  store i64 %t65, ptr %t64
  br label %L14
L21:
  br label %L17
L17:
  %t66 = load ptr, ptr %t32
  %t67 = sext i32 13 to i64
  store i64 %t67, ptr %t66
  br label %L14
L22:
  br label %L18
L18:
  %t68 = load ptr, ptr %t32
  %t69 = sext i32 0 to i64
  store i64 %t69, ptr %t68
  br label %L14
L23:
  br label %L14
L19:
  %t70 = load ptr, ptr %t35
  %t71 = sext i32 2 to i64
  %t72 = getelementptr i32, ptr %t70, i64 %t71
  %t73 = load i64, ptr %t72
  %t74 = load ptr, ptr %t32
  store i64 %t73, ptr %t74
  br label %L14
L24:
  br label %L14
L14:
  br label %L13
L12:
  %t75 = load ptr, ptr %t35
  %t76 = sext i32 1 to i64
  %t77 = getelementptr i32, ptr %t75, i64 %t76
  %t78 = load i64, ptr %t77
  %t79 = add i64 %t78, 0
  %t80 = load ptr, ptr %t32
  store i64 %t79, ptr %t80
  br label %L13
L13:
  call void @advance(ptr %t0)
  %t82 = load ptr, ptr %t32
  ret ptr %t82
L25:
  br label %L10
L10:
  %t83 = call i32 @check(ptr %t0, i64 3)
  %t84 = sext i32 %t83 to i64
  %t85 = icmp ne i64 %t84, 0
  br i1 %t85, label %L26, label %L28
L26:
  %t86 = alloca ptr
  %t87 = load i64, ptr %t1
  %t88 = call ptr @node_new(i64 22, i64 %t87)
  store ptr %t88, ptr %t86
  %t89 = alloca i64
  %t90 = load ptr, ptr %t0
  %t91 = call i64 @strlen(ptr %t90)
  store i64 %t91, ptr %t89
  %t92 = alloca ptr
  %t93 = load i64, ptr %t89
  %t95 = sext i32 1 to i64
  %t94 = add i64 %t93, %t95
  %t96 = call ptr @malloc(i64 %t94)
  store ptr %t96, ptr %t92
  %t97 = load ptr, ptr %t92
  %t98 = load ptr, ptr %t0
  %t99 = load i64, ptr %t89
  %t101 = sext i32 1 to i64
  %t100 = sub i64 %t99, %t101
  %t102 = call ptr @memcpy(ptr %t97, ptr %t98, i64 %t100)
  %t103 = load ptr, ptr %t92
  %t104 = load i64, ptr %t89
  %t106 = sext i32 1 to i64
  %t105 = sub i64 %t104, %t106
  %t107 = getelementptr i8, ptr %t103, i64 %t105
  %t108 = sext i32 0 to i64
  store i64 %t108, ptr %t107
  call void @advance(ptr %t0)
  br label %L29
L29:
  %t110 = call i32 @check(ptr %t0, i64 3)
  %t111 = sext i32 %t110 to i64
  %t112 = icmp ne i64 %t111, 0
  br i1 %t112, label %L30, label %L31
L30:
  %t113 = alloca ptr
  %t114 = load ptr, ptr %t0
  %t116 = ptrtoint ptr %t114 to i64
  %t117 = sext i32 1 to i64
  %t118 = inttoptr i64 %t116 to ptr
  %t115 = getelementptr i8, ptr %t118, i64 %t117
  store ptr %t115, ptr %t113
  %t119 = alloca i64
  %t120 = load ptr, ptr %t113
  %t121 = call i64 @strlen(ptr %t120)
  store i64 %t121, ptr %t119
  %t122 = alloca i64
  %t123 = load ptr, ptr %t92
  %t124 = call i64 @strlen(ptr %t123)
  store i64 %t124, ptr %t122
  %t125 = load ptr, ptr %t92
  %t126 = load i64, ptr %t122
  %t127 = load i64, ptr %t119
  %t128 = add i64 %t126, %t127
  %t130 = sext i32 1 to i64
  %t129 = add i64 %t128, %t130
  %t131 = call ptr @realloc(ptr %t125, i64 %t129)
  store ptr %t131, ptr %t92
  %t132 = load ptr, ptr %t92
  %t133 = load i64, ptr %t122
  %t135 = ptrtoint ptr %t132 to i64
  %t136 = inttoptr i64 %t135 to ptr
  %t134 = getelementptr i8, ptr %t136, i64 %t133
  %t137 = load ptr, ptr %t113
  %t138 = load i64, ptr %t119
  %t139 = call ptr @memcpy(ptr %t134, ptr %t137, i64 %t138)
  %t140 = load ptr, ptr %t92
  %t141 = load i64, ptr %t122
  %t142 = load i64, ptr %t119
  %t143 = add i64 %t141, %t142
  %t144 = getelementptr i8, ptr %t140, i64 %t143
  %t145 = sext i32 0 to i64
  store i64 %t145, ptr %t144
  call void @advance(ptr %t0)
  br label %L29
L31:
  %t147 = alloca i64
  %t148 = load ptr, ptr %t92
  %t149 = call i64 @strlen(ptr %t148)
  store i64 %t149, ptr %t147
  %t150 = load ptr, ptr %t92
  %t151 = load i64, ptr %t147
  %t153 = sext i32 2 to i64
  %t152 = add i64 %t151, %t153
  %t154 = call ptr @realloc(ptr %t150, i64 %t152)
  store ptr %t154, ptr %t92
  %t155 = load ptr, ptr %t92
  %t156 = load i64, ptr %t147
  %t157 = getelementptr i8, ptr %t155, i64 %t156
  %t158 = sext i32 34 to i64
  store i64 %t158, ptr %t157
  %t159 = load ptr, ptr %t92
  %t160 = load i64, ptr %t147
  %t162 = sext i32 1 to i64
  %t161 = add i64 %t160, %t162
  %t163 = getelementptr i8, ptr %t159, i64 %t161
  %t164 = sext i32 0 to i64
  store i64 %t164, ptr %t163
  %t165 = load ptr, ptr %t92
  %t166 = load ptr, ptr %t86
  store ptr %t165, ptr %t166
  %t167 = load ptr, ptr %t86
  ret ptr %t167
L32:
  br label %L28
L28:
  %t168 = call i32 @check(ptr %t0, i64 4)
  %t169 = sext i32 %t168 to i64
  %t170 = icmp ne i64 %t169, 0
  br i1 %t170, label %L33, label %L35
L33:
  %t171 = alloca i64
  %t172 = load ptr, ptr %t0
  %t173 = call i32 @lookup_enum_const(ptr %t0, ptr %t172, ptr %t171)
  %t174 = sext i32 %t173 to i64
  %t175 = icmp ne i64 %t174, 0
  br i1 %t175, label %L36, label %L38
L36:
  %t176 = alloca ptr
  %t177 = load i64, ptr %t1
  %t178 = call ptr @node_new(i64 19, i64 %t177)
  store ptr %t178, ptr %t176
  %t179 = load i64, ptr %t171
  %t180 = load ptr, ptr %t176
  store i64 %t179, ptr %t180
  call void @advance(ptr %t0)
  %t182 = load ptr, ptr %t176
  ret ptr %t182
L39:
  br label %L38
L38:
  %t183 = alloca ptr
  %t184 = load i64, ptr %t1
  %t185 = call ptr @node_new(i64 23, i64 %t184)
  store ptr %t185, ptr %t183
  %t186 = load ptr, ptr %t0
  %t187 = call ptr @strdup(ptr %t186)
  %t188 = load ptr, ptr %t183
  store ptr %t187, ptr %t188
  call void @advance(ptr %t0)
  %t190 = load ptr, ptr %t183
  ret ptr %t190
L40:
  br label %L35
L35:
  %t191 = call i32 @match(ptr %t0, i64 72)
  %t192 = sext i32 %t191 to i64
  %t193 = icmp ne i64 %t192, 0
  br i1 %t193, label %L41, label %L43
L41:
  %t194 = call i32 @is_type_start(ptr %t0)
  %t195 = sext i32 %t194 to i64
  %t196 = icmp ne i64 %t195, 0
  br i1 %t196, label %L44, label %L46
L44:
  %t197 = alloca i64
  %t198 = sext i32 0 to i64
  store i64 %t198, ptr %t197
  %t199 = alloca i64
  %t200 = sext i32 0 to i64
  store i64 %t200, ptr %t199
  %t201 = alloca i64
  %t202 = sext i32 0 to i64
  store i64 %t202, ptr %t201
  %t203 = alloca ptr
  %t204 = call ptr @parse_type_specifier(ptr %t0, ptr %t197, ptr %t199, ptr %t201)
  store ptr %t204, ptr %t203
  %t205 = load ptr, ptr %t203
  %t206 = icmp ne ptr %t205, null
  br i1 %t206, label %L47, label %L49
L47:
  %t207 = alloca ptr
  %t209 = sext i32 0 to i64
  %t208 = inttoptr i64 %t209 to ptr
  store ptr %t208, ptr %t207
  %t210 = load ptr, ptr %t203
  %t211 = call ptr @parse_declarator(ptr %t0, ptr %t210, ptr %t207)
  store ptr %t211, ptr %t203
  %t212 = load ptr, ptr %t207
  call void @free(ptr %t212)
  %t214 = call i32 @match(ptr %t0, i64 73)
  %t215 = sext i32 %t214 to i64
  %t216 = icmp ne i64 %t215, 0
  br i1 %t216, label %L50, label %L52
L50:
  %t217 = alloca ptr
  %t218 = load i64, ptr %t1
  %t219 = call ptr @node_new(i64 29, i64 %t218)
  store ptr %t219, ptr %t217
  %t220 = load ptr, ptr %t203
  %t221 = load ptr, ptr %t217
  store ptr %t220, ptr %t221
  %t222 = call ptr @parse_cast(ptr %t0)
  %t223 = load ptr, ptr %t217
  store ptr %t222, ptr %t223
  %t224 = load ptr, ptr %t217
  ret ptr %t224
L53:
  br label %L52
L52:
  br label %L49
L49:
  br label %L46
L46:
  %t225 = alloca ptr
  %t226 = call ptr @parse_expr(ptr %t0)
  store ptr %t226, ptr %t225
  call void @expect(ptr %t0, i64 73)
  %t228 = load ptr, ptr %t225
  ret ptr %t228
L54:
  br label %L43
L43:
  %t229 = call i32 @check(ptr %t0, i64 34)
  %t230 = sext i32 %t229 to i64
  %t231 = icmp ne i64 %t230, 0
  br i1 %t231, label %L55, label %L57
L55:
  call void @advance(ptr %t0)
  %t233 = call i32 @match(ptr %t0, i64 72)
  %t234 = sext i32 %t233 to i64
  %t235 = icmp ne i64 %t234, 0
  br i1 %t235, label %L58, label %L60
L58:
  %t236 = call i32 @is_type_start(ptr %t0)
  %t237 = sext i32 %t236 to i64
  %t238 = icmp ne i64 %t237, 0
  br i1 %t238, label %L61, label %L63
L61:
  %t239 = alloca i64
  %t240 = sext i32 0 to i64
  store i64 %t240, ptr %t239
  %t241 = alloca i64
  %t242 = sext i32 0 to i64
  store i64 %t242, ptr %t241
  %t243 = alloca i64
  %t244 = sext i32 0 to i64
  store i64 %t244, ptr %t243
  %t245 = alloca ptr
  %t246 = call ptr @parse_type_specifier(ptr %t0, ptr %t239, ptr %t241, ptr %t243)
  store ptr %t246, ptr %t245
  %t247 = alloca ptr
  %t249 = sext i32 0 to i64
  %t248 = inttoptr i64 %t249 to ptr
  store ptr %t248, ptr %t247
  %t250 = load ptr, ptr %t245
  %t251 = call ptr @parse_declarator(ptr %t0, ptr %t250, ptr %t247)
  store ptr %t251, ptr %t245
  %t252 = load ptr, ptr %t247
  call void @free(ptr %t252)
  call void @expect(ptr %t0, i64 73)
  %t255 = alloca ptr
  %t256 = load i64, ptr %t1
  %t257 = call ptr @node_new(i64 31, i64 %t256)
  store ptr %t257, ptr %t255
  %t258 = load ptr, ptr %t245
  %t259 = load ptr, ptr %t255
  store ptr %t258, ptr %t259
  %t260 = load ptr, ptr %t255
  ret ptr %t260
L64:
  br label %L63
L63:
  %t261 = alloca ptr
  %t262 = call ptr @parse_expr(ptr %t0)
  store ptr %t262, ptr %t261
  call void @expect(ptr %t0, i64 73)
  %t264 = alloca ptr
  %t265 = load i64, ptr %t1
  %t266 = call ptr @node_new(i64 32, i64 %t265)
  store ptr %t266, ptr %t264
  %t267 = load ptr, ptr %t264
  %t268 = load ptr, ptr %t261
  call void @node_add_child(ptr %t267, ptr %t268)
  %t270 = load ptr, ptr %t264
  ret ptr %t270
L65:
  br label %L60
L60:
  %t271 = alloca ptr
  %t272 = call ptr @parse_unary(ptr %t0)
  store ptr %t272, ptr %t271
  %t273 = alloca ptr
  %t274 = load i64, ptr %t1
  %t275 = call ptr @node_new(i64 32, i64 %t274)
  store ptr %t275, ptr %t273
  %t276 = load ptr, ptr %t273
  %t277 = load ptr, ptr %t271
  call void @node_add_child(ptr %t276, ptr %t277)
  %t279 = load ptr, ptr %t273
  ret ptr %t279
L66:
  br label %L57
L57:
  %t280 = getelementptr [28 x i8], ptr @.str32, i64 0, i64 0
  call void @p_error(ptr %t0, ptr %t280)
  %t283 = sext i32 0 to i64
  %t282 = inttoptr i64 %t283 to ptr
  ret ptr %t282
L67:
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
  %t18 = call i32 @check(ptr %t0, i64 81)
  %t19 = sext i32 %t18 to i64
  %t21 = icmp eq i64 %t19, 0
  %t20 = zext i1 %t21 to i64
  %t23 = icmp ne i64 %t16, 0
  %t24 = icmp ne i64 %t20, 0
  %t25 = and i1 %t23, %t24
  %t26 = zext i1 %t25 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L8, label %L9
L8:
  %t28 = load ptr, ptr %t8
  %t29 = call ptr @parse_assign(ptr %t0)
  call void @node_add_child(ptr %t28, ptr %t29)
  %t31 = call i32 @match(ptr %t0, i64 79)
  %t32 = sext i32 %t31 to i64
  %t34 = icmp eq i64 %t32, 0
  %t33 = zext i1 %t34 to i64
  %t35 = icmp ne i64 %t33, 0
  br i1 %t35, label %L10, label %L12
L10:
  br label %L9
L13:
  br label %L12
L12:
  br label %L7
L9:
  call void @expect(ptr %t0, i64 73)
  %t37 = load ptr, ptr %t8
  store ptr %t37, ptr %t1
  br label %L6
L5:
  %t38 = call i32 @match(ptr %t0, i64 76)
  %t39 = sext i32 %t38 to i64
  %t40 = icmp ne i64 %t39, 0
  br i1 %t40, label %L14, label %L15
L14:
  %t41 = alloca ptr
  %t42 = load i64, ptr %t3
  %t43 = call ptr @node_new(i64 33, i64 %t42)
  store ptr %t43, ptr %t41
  %t44 = load ptr, ptr %t41
  %t45 = load ptr, ptr %t1
  call void @node_add_child(ptr %t44, ptr %t45)
  %t47 = load ptr, ptr %t41
  %t48 = call ptr @parse_expr(ptr %t0)
  call void @node_add_child(ptr %t47, ptr %t48)
  call void @expect(ptr %t0, i64 77)
  %t51 = load ptr, ptr %t41
  store ptr %t51, ptr %t1
  br label %L16
L15:
  %t52 = call i32 @match(ptr %t0, i64 69)
  %t53 = sext i32 %t52 to i64
  %t54 = icmp ne i64 %t53, 0
  br i1 %t54, label %L17, label %L18
L17:
  %t55 = alloca ptr
  %t56 = load i64, ptr %t3
  %t57 = call ptr @node_new(i64 34, i64 %t56)
  store ptr %t57, ptr %t55
  %t58 = call ptr @expect_ident(ptr %t0)
  %t59 = load ptr, ptr %t55
  store ptr %t58, ptr %t59
  %t60 = load ptr, ptr %t55
  %t61 = load ptr, ptr %t1
  call void @node_add_child(ptr %t60, ptr %t61)
  %t63 = load ptr, ptr %t55
  store ptr %t63, ptr %t1
  br label %L19
L18:
  %t64 = call i32 @match(ptr %t0, i64 68)
  %t65 = sext i32 %t64 to i64
  %t66 = icmp ne i64 %t65, 0
  br i1 %t66, label %L20, label %L21
L20:
  %t67 = alloca ptr
  %t68 = load i64, ptr %t3
  %t69 = call ptr @node_new(i64 35, i64 %t68)
  store ptr %t69, ptr %t67
  %t70 = call ptr @expect_ident(ptr %t0)
  %t71 = load ptr, ptr %t67
  store ptr %t70, ptr %t71
  %t72 = load ptr, ptr %t67
  %t73 = load ptr, ptr %t1
  call void @node_add_child(ptr %t72, ptr %t73)
  %t75 = load ptr, ptr %t67
  store ptr %t75, ptr %t1
  br label %L22
L21:
  %t76 = call i32 @check(ptr %t0, i64 66)
  %t77 = sext i32 %t76 to i64
  %t78 = icmp ne i64 %t77, 0
  br i1 %t78, label %L23, label %L24
L23:
  call void @advance(ptr %t0)
  %t80 = alloca ptr
  %t81 = load i64, ptr %t3
  %t82 = call ptr @node_new(i64 40, i64 %t81)
  store ptr %t82, ptr %t80
  %t83 = load ptr, ptr %t80
  %t84 = load ptr, ptr %t1
  call void @node_add_child(ptr %t83, ptr %t84)
  %t86 = load ptr, ptr %t80
  store ptr %t86, ptr %t1
  br label %L25
L24:
  %t87 = call i32 @check(ptr %t0, i64 67)
  %t88 = sext i32 %t87 to i64
  %t89 = icmp ne i64 %t88, 0
  br i1 %t89, label %L26, label %L27
L26:
  call void @advance(ptr %t0)
  %t91 = alloca ptr
  %t92 = load i64, ptr %t3
  %t93 = call ptr @node_new(i64 41, i64 %t92)
  store ptr %t93, ptr %t91
  %t94 = load ptr, ptr %t91
  %t95 = load ptr, ptr %t1
  call void @node_add_child(ptr %t94, ptr %t95)
  %t97 = load ptr, ptr %t91
  store ptr %t97, ptr %t1
  br label %L28
L27:
  br label %L3
L29:
  br label %L28
L28:
  br label %L25
L25:
  br label %L22
L22:
  br label %L19
L19:
  br label %L16
L16:
  br label %L6
L6:
  br label %L2
L2:
  br label %L0
L3:
  %t98 = load ptr, ptr %t1
  ret ptr %t98
L30:
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
  %t49 = call i32 @check(ptr %t0, i64 35)
  %t50 = sext i32 %t49 to i64
  %t52 = icmp ne i64 %t48, 0
  %t53 = icmp ne i64 %t50, 0
  %t54 = or i1 %t52, %t53
  %t55 = zext i1 %t54 to i64
  %t56 = call i32 @check(ptr %t0, i64 54)
  %t57 = sext i32 %t56 to i64
  %t59 = icmp ne i64 %t55, 0
  %t60 = icmp ne i64 %t57, 0
  %t61 = or i1 %t59, %t60
  %t62 = zext i1 %t61 to i64
  %t63 = call i32 @check(ptr %t0, i64 43)
  %t64 = sext i32 %t63 to i64
  %t66 = icmp ne i64 %t62, 0
  %t67 = icmp ne i64 %t64, 0
  %t68 = or i1 %t66, %t67
  %t69 = zext i1 %t68 to i64
  %t70 = icmp ne i64 %t69, 0
  br i1 %t70, label %L16, label %L18
L16:
  %t71 = alloca i64
  %t72 = load ptr, ptr %t0
  store ptr %t72, ptr %t71
  call void @advance(ptr %t0)
  %t74 = alloca ptr
  %t75 = load i64, ptr %t1
  %t76 = call ptr @node_new(i64 26, i64 %t75)
  store ptr %t76, ptr %t74
  %t77 = load i64, ptr %t71
  %t78 = load ptr, ptr %t74
  store i64 %t77, ptr %t78
  %t79 = load ptr, ptr %t74
  %t80 = call ptr @parse_cast(ptr %t0)
  call void @node_add_child(ptr %t79, ptr %t80)
  %t82 = load ptr, ptr %t74
  ret ptr %t82
L19:
  br label %L18
L18:
  %t83 = call ptr @parse_postfix(ptr %t0)
  ret ptr %t83
L20:
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_cast(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_mul(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_add(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_shift(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_relational(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_equality(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_bitand(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_bitxor(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_bitor(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L5, label %L7
L5:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t3
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L8, label %L10
L8:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  %t28 = alloca i64
  %t29 = load ptr, ptr %t0
  store ptr %t29, ptr %t28
  call void @advance(ptr %t0)
  %t31 = alloca ptr
  %t32 = call ptr @parse_logand(ptr %t0)
  store ptr %t32, ptr %t31
  %t33 = alloca ptr
  %t34 = load i64, ptr %t26
  %t35 = call ptr @node_new(i64 25, i64 %t34)
  store ptr %t35, ptr %t33
  %t36 = load i64, ptr %t28
  %t37 = load ptr, ptr %t33
  store i64 %t36, ptr %t37
  %t38 = load ptr, ptr %t33
  %t39 = load ptr, ptr %t1
  call void @node_add_child(ptr %t38, ptr %t39)
  %t41 = load ptr, ptr %t33
  %t42 = load ptr, ptr %t31
  call void @node_add_child(ptr %t41, ptr %t42)
  %t44 = load ptr, ptr %t33
  store ptr %t44, ptr %t1
  %t45 = sext i32 1 to i64
  store i64 %t45, ptr %t5
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %t46 = load i64, ptr %t7
  %t47 = add i64 %t46, 1
  store i64 %t47, ptr %t7
  br label %L4
L7:
  %t48 = load i64, ptr %t5
  %t50 = icmp eq i64 %t48, 0
  %t49 = zext i1 %t50 to i64
  %t51 = icmp ne i64 %t49, 0
  br i1 %t51, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %t52 = load ptr, ptr %t1
  ret ptr %t52
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
  %t11 = getelementptr i32, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t11
  %t14 = sext i32 81 to i64
  %t13 = icmp ne i64 %t12, %t14
  %t15 = zext i1 %t13 to i64
  %t16 = icmp ne i64 %t15, 0
  br i1 %t16, label %L1, label %L3
L1:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t5
  %t19 = load i64, ptr %t7
  %t20 = getelementptr i32, ptr %t18, i64 %t19
  %t21 = load i64, ptr %t20
  %t23 = ptrtoint ptr %t17 to i64
  %t22 = icmp eq i64 %t23, %t21
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L4, label %L6
L4:
  %t26 = alloca i64
  %t27 = load ptr, ptr %t0
  store ptr %t27, ptr %t26
  call void @advance(ptr %t0)
  %t29 = alloca ptr
  %t30 = call ptr @parse_assign(ptr %t0)
  store ptr %t30, ptr %t29
  %t31 = alloca i64
  %t32 = load i64, ptr %t26
  %t34 = sext i32 55 to i64
  %t33 = icmp eq i64 %t32, %t34
  %t35 = zext i1 %t33 to i64
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L7, label %L8
L7:
  %t37 = sext i32 27 to i64
  br label %L9
L8:
  %t38 = sext i32 28 to i64
  br label %L9
L9:
  %t39 = phi i64 [ %t37, %L7 ], [ %t38, %L8 ]
  store i64 %t39, ptr %t31
  %t40 = alloca ptr
  %t41 = load i64, ptr %t31
  %t42 = load i64, ptr %t3
  %t43 = call ptr @node_new(i64 %t41, i64 %t42)
  store ptr %t43, ptr %t40
  %t44 = load i64, ptr %t26
  %t45 = load ptr, ptr %t40
  store i64 %t44, ptr %t45
  %t46 = load ptr, ptr %t40
  %t47 = load ptr, ptr %t1
  call void @node_add_child(ptr %t46, ptr %t47)
  %t49 = load ptr, ptr %t40
  %t50 = load ptr, ptr %t29
  call void @node_add_child(ptr %t49, ptr %t50)
  %t52 = load ptr, ptr %t40
  ret ptr %t52
L10:
  br label %L6
L6:
  br label %L2
L2:
  %t53 = load i64, ptr %t7
  %t54 = add i64 %t53, 1
  store i64 %t54, ptr %t7
  br label %L0
L3:
  %t55 = load ptr, ptr %t1
  ret ptr %t55
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
  %t28 = load ptr, ptr %t21
  %t30 = ptrtoint ptr %t28 to i64
  %t34 = ptrtoint ptr %t28 to i64
  %t31 = icmp ne i64 %t27, 0
  %t32 = icmp ne i64 %t34, 0
  %t33 = and i1 %t31, %t32
  %t35 = zext i1 %t33 to i64
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L7, label %L8
L7:
  %t37 = load ptr, ptr %t21
  %t38 = load ptr, ptr %t24
  call void @register_typedef(ptr %t0, ptr %t37, ptr %t38)
  %t40 = alloca ptr
  %t41 = load i64, ptr %t1
  %t42 = call ptr @node_new(i64 3, i64 %t41)
  store ptr %t42, ptr %t40
  %t43 = load ptr, ptr %t21
  %t44 = load ptr, ptr %t40
  store ptr %t43, ptr %t44
  %t45 = load ptr, ptr %t24
  %t46 = load ptr, ptr %t40
  store ptr %t45, ptr %t46
  %t47 = load ptr, ptr %t18
  %t48 = load ptr, ptr %t40
  call void @node_add_child(ptr %t47, ptr %t48)
  br label %L9
L8:
  %t50 = alloca ptr
  %t51 = load i64, ptr %t1
  %t52 = call ptr @node_new(i64 2, i64 %t51)
  store ptr %t52, ptr %t50
  %t53 = load ptr, ptr %t21
  %t54 = load ptr, ptr %t50
  store ptr %t53, ptr %t54
  %t55 = load ptr, ptr %t24
  %t56 = load ptr, ptr %t50
  store ptr %t55, ptr %t56
  %t57 = load i64, ptr %t5
  %t58 = load ptr, ptr %t50
  store i64 %t57, ptr %t58
  %t59 = load i64, ptr %t7
  %t60 = load ptr, ptr %t50
  store i64 %t59, ptr %t60
  %t61 = call i32 @match(ptr %t0, i64 55)
  %t62 = sext i32 %t61 to i64
  %t63 = icmp ne i64 %t62, 0
  br i1 %t63, label %L10, label %L12
L10:
  %t64 = load ptr, ptr %t50
  %t65 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t64, ptr %t65)
  br label %L12
L12:
  %t67 = load ptr, ptr %t18
  %t68 = load ptr, ptr %t50
  call void @node_add_child(ptr %t67, ptr %t68)
  br label %L9
L9:
  br label %L5
L5:
  %t70 = call i32 @match(ptr %t0, i64 79)
  %t71 = sext i32 %t70 to i64
  %t72 = icmp ne i64 %t71, 0
  br i1 %t72, label %L4, label %L6
L6:
  call void @expect(ptr %t0, i64 78)
  %t74 = load ptr, ptr %t18
  %t75 = load ptr, ptr %t74
  %t77 = ptrtoint ptr %t75 to i64
  %t78 = sext i32 1 to i64
  %t76 = icmp eq i64 %t77, %t78
  %t79 = zext i1 %t76 to i64
  %t80 = icmp ne i64 %t79, 0
  br i1 %t80, label %L13, label %L15
L13:
  %t81 = alloca ptr
  %t82 = load ptr, ptr %t18
  %t83 = load ptr, ptr %t82
  %t84 = sext i32 0 to i64
  %t85 = getelementptr i32, ptr %t83, i64 %t84
  %t86 = load i64, ptr %t85
  store i64 %t86, ptr %t81
  %t87 = load ptr, ptr %t18
  %t88 = sext i32 0 to i64
  store i64 %t88, ptr %t87
  %t89 = load ptr, ptr %t18
  %t90 = load ptr, ptr %t89
  call void @free(ptr %t90)
  %t92 = load ptr, ptr %t18
  call void @free(ptr %t92)
  %t94 = load ptr, ptr %t81
  ret ptr %t94
L16:
  br label %L15
L15:
  %t95 = load ptr, ptr %t18
  ret ptr %t95
L17:
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
  %t16 = load i64, ptr %t10
  %t18 = sext i32 0 to i64
  %t17 = icmp sgt i64 %t16, %t18
  %t19 = zext i1 %t17 to i64
  %t21 = icmp ne i64 %t14, 0
  %t22 = icmp ne i64 %t19, 0
  %t23 = and i1 %t21, %t22
  %t24 = zext i1 %t23 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L5, label %L6
L5:
  %t26 = call i32 @check(ptr %t0, i64 74)
  %t27 = sext i32 %t26 to i64
  %t28 = icmp ne i64 %t27, 0
  br i1 %t28, label %L7, label %L8
L7:
  %t29 = load i64, ptr %t10
  %t30 = add i64 %t29, 1
  store i64 %t30, ptr %t10
  br label %L9
L8:
  %t31 = call i32 @check(ptr %t0, i64 75)
  %t32 = sext i32 %t31 to i64
  %t33 = icmp ne i64 %t32, 0
  br i1 %t33, label %L10, label %L12
L10:
  %t34 = load i64, ptr %t10
  %t35 = sub i64 %t34, 1
  store i64 %t35, ptr %t10
  %t36 = load i64, ptr %t10
  %t38 = sext i32 0 to i64
  %t37 = icmp eq i64 %t36, %t38
  %t39 = zext i1 %t37 to i64
  %t40 = icmp ne i64 %t39, 0
  br i1 %t40, label %L13, label %L15
L13:
  br label %L6
L16:
  br label %L15
L15:
  br label %L12
L12:
  br label %L9
L9:
  call void @advance(ptr %t0)
  br label %L4
L6:
  call void @expect(ptr %t0, i64 75)
  %t43 = alloca ptr
  %t44 = load i64, ptr %t1
  %t45 = call ptr @node_new(i64 19, i64 %t44)
  store ptr %t45, ptr %t43
  %t46 = load ptr, ptr %t43
  %t47 = sext i32 0 to i64
  store i64 %t47, ptr %t46
  %t48 = getelementptr [7 x i8], ptr @.str33, i64 0, i64 0
  %t49 = call ptr @strdup(ptr %t48)
  %t50 = load ptr, ptr %t43
  store ptr %t49, ptr %t50
  %t51 = load ptr, ptr %t43
  ret ptr %t51
L17:
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
  %t163 = call i32 @check(ptr %t0, i64 24)
  %t164 = sext i32 %t163 to i64
  %t166 = icmp eq i64 %t164, 0
  %t165 = zext i1 %t166 to i64
  %t168 = icmp ne i64 %t161, 0
  %t169 = icmp ne i64 %t165, 0
  %t170 = and i1 %t168, %t169
  %t171 = zext i1 %t170 to i64
  %t172 = call i32 @check(ptr %t0, i64 75)
  %t173 = sext i32 %t172 to i64
  %t175 = icmp eq i64 %t173, 0
  %t174 = zext i1 %t175 to i64
  %t177 = icmp ne i64 %t171, 0
  %t178 = icmp ne i64 %t174, 0
  %t179 = and i1 %t177, %t178
  %t180 = zext i1 %t179 to i64
  %t181 = call i32 @check(ptr %t0, i64 81)
  %t182 = sext i32 %t181 to i64
  %t184 = icmp eq i64 %t182, 0
  %t183 = zext i1 %t184 to i64
  %t186 = icmp ne i64 %t180, 0
  %t187 = icmp ne i64 %t183, 0
  %t188 = and i1 %t186, %t187
  %t189 = zext i1 %t188 to i64
  %t190 = icmp ne i64 %t189, 0
  br i1 %t190, label %L58, label %L59
L58:
  %t191 = load ptr, ptr %t156
  %t192 = call ptr @parse_stmt(ptr %t0)
  call void @node_add_child(ptr %t191, ptr %t192)
  br label %L57
L59:
  %t194 = load ptr, ptr %t150
  %t195 = load ptr, ptr %t156
  call void @node_add_child(ptr %t194, ptr %t195)
  %t197 = load ptr, ptr %t150
  ret ptr %t197
L60:
  br label %L56
L56:
  %t198 = call i32 @check(ptr %t0, i64 24)
  %t199 = sext i32 %t198 to i64
  %t200 = icmp ne i64 %t199, 0
  br i1 %t200, label %L61, label %L63
L61:
  call void @advance(ptr %t0)
  call void @expect(ptr %t0, i64 71)
  %t203 = alloca ptr
  %t204 = load i64, ptr %t1
  %t205 = call ptr @node_new(i64 15, i64 %t204)
  store ptr %t205, ptr %t203
  %t206 = alloca ptr
  %t207 = load i64, ptr %t1
  %t208 = call ptr @node_new(i64 5, i64 %t207)
  store ptr %t208, ptr %t206
  br label %L64
L64:
  %t209 = call i32 @check(ptr %t0, i64 23)
  %t210 = sext i32 %t209 to i64
  %t212 = icmp eq i64 %t210, 0
  %t211 = zext i1 %t212 to i64
  %t213 = call i32 @check(ptr %t0, i64 24)
  %t214 = sext i32 %t213 to i64
  %t216 = icmp eq i64 %t214, 0
  %t215 = zext i1 %t216 to i64
  %t218 = icmp ne i64 %t211, 0
  %t219 = icmp ne i64 %t215, 0
  %t220 = and i1 %t218, %t219
  %t221 = zext i1 %t220 to i64
  %t222 = call i32 @check(ptr %t0, i64 75)
  %t223 = sext i32 %t222 to i64
  %t225 = icmp eq i64 %t223, 0
  %t224 = zext i1 %t225 to i64
  %t227 = icmp ne i64 %t221, 0
  %t228 = icmp ne i64 %t224, 0
  %t229 = and i1 %t227, %t228
  %t230 = zext i1 %t229 to i64
  %t231 = call i32 @check(ptr %t0, i64 81)
  %t232 = sext i32 %t231 to i64
  %t234 = icmp eq i64 %t232, 0
  %t233 = zext i1 %t234 to i64
  %t236 = icmp ne i64 %t230, 0
  %t237 = icmp ne i64 %t233, 0
  %t238 = and i1 %t236, %t237
  %t239 = zext i1 %t238 to i64
  %t240 = icmp ne i64 %t239, 0
  br i1 %t240, label %L65, label %L66
L65:
  %t241 = load ptr, ptr %t206
  %t242 = call ptr @parse_stmt(ptr %t0)
  call void @node_add_child(ptr %t241, ptr %t242)
  br label %L64
L66:
  %t244 = load ptr, ptr %t203
  %t245 = load ptr, ptr %t206
  call void @node_add_child(ptr %t244, ptr %t245)
  %t247 = load ptr, ptr %t203
  ret ptr %t247
L67:
  br label %L63
L63:
  %t248 = call i32 @check(ptr %t0, i64 25)
  %t249 = sext i32 %t248 to i64
  %t250 = icmp ne i64 %t249, 0
  br i1 %t250, label %L68, label %L70
L68:
  call void @advance(ptr %t0)
  %t252 = alloca ptr
  %t253 = load i64, ptr %t1
  %t254 = call ptr @node_new(i64 17, i64 %t253)
  store ptr %t254, ptr %t252
  %t255 = call ptr @expect_ident(ptr %t0)
  %t256 = load ptr, ptr %t252
  store ptr %t255, ptr %t256
  call void @expect(ptr %t0, i64 78)
  %t258 = load ptr, ptr %t252
  ret ptr %t258
L71:
  br label %L70
L70:
  %t259 = call i32 @check(ptr %t0, i64 4)
  %t260 = sext i32 %t259 to i64
  %t261 = load ptr, ptr null
  %t263 = ptrtoint ptr %t261 to i64
  %t264 = sext i32 71 to i64
  %t262 = icmp eq i64 %t263, %t264
  %t265 = zext i1 %t262 to i64
  %t267 = icmp ne i64 %t260, 0
  %t268 = icmp ne i64 %t265, 0
  %t269 = and i1 %t267, %t268
  %t270 = zext i1 %t269 to i64
  %t271 = icmp ne i64 %t270, 0
  br i1 %t271, label %L72, label %L74
L72:
  %t272 = alloca ptr
  %t273 = load i64, ptr %t1
  %t274 = call ptr @node_new(i64 16, i64 %t273)
  store ptr %t274, ptr %t272
  %t275 = load ptr, ptr %t0
  %t276 = call ptr @strdup(ptr %t275)
  %t277 = load ptr, ptr %t272
  store ptr %t276, ptr %t277
  call void @advance(ptr %t0)
  call void @advance(ptr %t0)
  %t280 = load ptr, ptr %t272
  %t281 = call ptr @parse_stmt(ptr %t0)
  call void @node_add_child(ptr %t280, ptr %t281)
  %t283 = load ptr, ptr %t272
  ret ptr %t283
L75:
  br label %L74
L74:
  %t284 = call i32 @is_type_start(ptr %t0)
  %t285 = sext i32 %t284 to i64
  %t286 = icmp ne i64 %t285, 0
  br i1 %t286, label %L76, label %L78
L76:
  %t287 = call ptr @parse_local_decl(ptr %t0)
  ret ptr %t287
L79:
  br label %L78
L78:
  %t288 = call i32 @check(ptr %t0, i64 78)
  %t289 = sext i32 %t288 to i64
  %t290 = icmp ne i64 %t289, 0
  br i1 %t290, label %L80, label %L82
L80:
  call void @advance(ptr %t0)
  %t292 = load i64, ptr %t1
  %t293 = call ptr @node_new(i64 5, i64 %t292)
  ret ptr %t293
L83:
  br label %L82
L82:
  %t294 = alloca ptr
  %t295 = load i64, ptr %t1
  %t296 = call ptr @node_new(i64 18, i64 %t295)
  store ptr %t296, ptr %t294
  %t297 = load ptr, ptr %t294
  %t298 = call ptr @parse_expr(ptr %t0)
  call void @node_add_child(ptr %t297, ptr %t298)
  call void @expect(ptr %t0, i64 78)
  %t301 = load ptr, ptr %t294
  ret ptr %t301
L84:
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
  %t13 = call i32 @check(ptr %t0, i64 81)
  %t14 = sext i32 %t13 to i64
  %t16 = icmp eq i64 %t14, 0
  %t15 = zext i1 %t16 to i64
  %t18 = icmp ne i64 %t11, 0
  %t19 = icmp ne i64 %t15, 0
  %t20 = and i1 %t18, %t19
  %t21 = zext i1 %t20 to i64
  %t22 = icmp ne i64 %t21, 0
  br i1 %t22, label %L1, label %L2
L1:
  %t23 = load ptr, ptr %t4
  %t24 = call ptr @parse_stmt(ptr %t0)
  call void @node_add_child(ptr %t23, ptr %t24)
  br label %L0
L2:
  call void @expect(ptr %t0, i64 75)
  %t27 = load ptr, ptr %t4
  ret ptr %t27
L3:
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
  %t56 = call i32 @check(ptr %t0, i64 74)
  %t57 = sext i32 %t56 to i64
  %t59 = icmp ne i64 %t55, 0
  %t60 = icmp ne i64 %t57, 0
  %t61 = and i1 %t59, %t60
  %t62 = zext i1 %t61 to i64
  %t63 = icmp ne i64 %t62, 0
  br i1 %t63, label %L15, label %L17
L15:
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
  store i64 %t71, ptr %t72
  %t73 = load i64, ptr %t8
  %t74 = load ptr, ptr %t64
  store i64 %t73, ptr %t74
  %t75 = load ptr, ptr %t30
  %t76 = load ptr, ptr %t75
  %t78 = ptrtoint ptr %t76 to i64
  %t79 = sext i32 8 to i64
  %t77 = mul i64 %t78, %t79
  %t80 = call ptr @malloc(i64 %t77)
  %t81 = load ptr, ptr %t64
  store ptr %t80, ptr %t81
  %t82 = alloca i64
  %t83 = sext i32 0 to i64
  store i64 %t83, ptr %t82
  br label %L18
L18:
  %t84 = load i64, ptr %t82
  %t85 = load ptr, ptr %t30
  %t86 = load ptr, ptr %t85
  %t88 = ptrtoint ptr %t86 to i64
  %t87 = icmp slt i64 %t84, %t88
  %t89 = zext i1 %t87 to i64
  %t90 = icmp ne i64 %t89, 0
  br i1 %t90, label %L19, label %L21
L19:
  %t91 = load ptr, ptr %t30
  %t92 = load ptr, ptr %t91
  %t93 = load i64, ptr %t82
  %t94 = getelementptr i8, ptr %t92, i64 %t93
  %t95 = load ptr, ptr %t94
  %t96 = icmp ne ptr %t95, null
  br i1 %t96, label %L22, label %L23
L22:
  %t97 = load ptr, ptr %t30
  %t98 = load ptr, ptr %t97
  %t99 = load i64, ptr %t82
  %t100 = getelementptr i8, ptr %t98, i64 %t99
  %t101 = load ptr, ptr %t100
  %t102 = call ptr @strdup(ptr %t101)
  %t103 = ptrtoint ptr %t102 to i64
  br label %L24
L23:
  %t105 = sext i32 0 to i64
  %t104 = inttoptr i64 %t105 to ptr
  %t106 = ptrtoint ptr %t104 to i64
  br label %L24
L24:
  %t107 = phi i64 [ %t103, %L22 ], [ %t106, %L23 ]
  %t108 = load ptr, ptr %t64
  %t109 = load ptr, ptr %t108
  %t110 = load i64, ptr %t82
  %t111 = getelementptr i8, ptr %t109, i64 %t110
  store i64 %t107, ptr %t111
  br label %L20
L20:
  %t112 = load i64, ptr %t82
  %t113 = add i64 %t112, 1
  store i64 %t113, ptr %t82
  br label %L18
L21:
  %t114 = call ptr @parse_block(ptr %t0)
  %t115 = load ptr, ptr %t64
  store ptr %t114, ptr %t115
  %t116 = load ptr, ptr %t64
  ret ptr %t116
L25:
  br label %L17
L17:
  %t117 = alloca ptr
  %t118 = load i64, ptr %t1
  %t119 = call ptr @node_new(i64 2, i64 %t118)
  store ptr %t119, ptr %t117
  %t120 = load ptr, ptr %t27
  %t121 = load ptr, ptr %t117
  store ptr %t120, ptr %t121
  %t122 = load ptr, ptr %t30
  %t123 = load ptr, ptr %t117
  store ptr %t122, ptr %t123
  %t124 = load ptr, ptr %t117
  %t125 = sext i32 1 to i64
  store i64 %t125, ptr %t124
  %t126 = load i64, ptr %t6
  %t127 = load ptr, ptr %t117
  store i64 %t126, ptr %t127
  %t128 = load i64, ptr %t8
  %t129 = load ptr, ptr %t117
  store i64 %t128, ptr %t129
  %t130 = call i32 @match(ptr %t0, i64 55)
  %t131 = sext i32 %t130 to i64
  %t132 = icmp ne i64 %t131, 0
  br i1 %t132, label %L26, label %L28
L26:
  %t133 = load ptr, ptr %t117
  %t134 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t133, ptr %t134)
  br label %L28
L28:
  br label %L29
L29:
  %t136 = call i32 @match(ptr %t0, i64 79)
  %t137 = sext i32 %t136 to i64
  %t138 = icmp ne i64 %t137, 0
  br i1 %t138, label %L30, label %L31
L30:
  %t139 = alloca ptr
  %t141 = sext i32 0 to i64
  %t140 = inttoptr i64 %t141 to ptr
  store ptr %t140, ptr %t139
  %t142 = alloca ptr
  %t143 = load ptr, ptr %t10
  %t144 = call ptr @parse_declarator(ptr %t0, ptr %t143, ptr %t139)
  store ptr %t144, ptr %t142
  %t145 = alloca ptr
  %t146 = load i64, ptr %t1
  %t147 = call ptr @node_new(i64 2, i64 %t146)
  store ptr %t147, ptr %t145
  %t148 = load ptr, ptr %t139
  %t149 = load ptr, ptr %t145
  store ptr %t148, ptr %t149
  %t150 = load ptr, ptr %t142
  %t151 = load ptr, ptr %t145
  store ptr %t150, ptr %t151
  %t152 = load ptr, ptr %t145
  %t153 = sext i32 1 to i64
  store i64 %t153, ptr %t152
  %t154 = call i32 @match(ptr %t0, i64 55)
  %t155 = sext i32 %t154 to i64
  %t156 = icmp ne i64 %t155, 0
  br i1 %t156, label %L32, label %L34
L32:
  %t157 = load ptr, ptr %t145
  %t158 = call ptr @parse_initializer(ptr %t0)
  call void @node_add_child(ptr %t157, ptr %t158)
  br label %L34
L34:
  %t160 = load ptr, ptr %t117
  %t161 = load ptr, ptr %t145
  call void @node_add_child(ptr %t160, ptr %t161)
  br label %L29
L31:
  call void @expect(ptr %t0, i64 78)
  %t164 = load ptr, ptr %t117
  ret ptr %t164
L35:
  ret ptr null
}

define dso_local ptr @parser_new(ptr %t0) {
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
  %t14 = alloca ptr
  %t15 = sext i32 0 to i64
  store i64 %t15, ptr %t14
  %t16 = alloca i64
  %t17 = sext i32 0 to i64
  store i64 %t17, ptr %t16
  br label %L3
L3:
  %t18 = load ptr, ptr %t14
  %t19 = load i64, ptr %t16
  %t20 = getelementptr i8, ptr %t18, i64 %t19
  %t21 = load ptr, ptr %t20
  %t22 = icmp ne ptr %t21, null
  br i1 %t22, label %L4, label %L6
L4:
  %t23 = alloca ptr
  %t24 = load ptr, ptr %t14
  %t25 = load i64, ptr %t16
  %t26 = getelementptr i8, ptr %t24, i64 %t25
  %t27 = load ptr, ptr %t26
  %t28 = call ptr @type_new(ptr %t27)
  store ptr %t28, ptr %t23
  %t29 = load ptr, ptr %t1
  %t30 = load ptr, ptr %t14
  %t31 = load i64, ptr %t16
  %t32 = getelementptr i8, ptr %t30, i64 %t31
  %t33 = load ptr, ptr %t32
  %t34 = load ptr, ptr %t23
  call void @register_typedef(ptr %t29, ptr %t33, ptr %t34)
  br label %L5
L5:
  %t36 = load i64, ptr %t16
  %t37 = add i64 %t36, 1
  store i64 %t37, ptr %t16
  br label %L3
L6:
  %t38 = load ptr, ptr %t1
  ret ptr %t38
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
  %t11 = load ptr, ptr %t0
  %t12 = load i64, ptr %t3
  %t13 = getelementptr i8, ptr %t11, i64 %t12
  %t14 = load ptr, ptr %t13
  call void @free(ptr %t14)
  br label %L2
L2:
  %t16 = load i64, ptr %t3
  %t17 = add i64 %t16, 1
  store i64 %t17, ptr %t3
  br label %L0
L3:
  %t18 = alloca i64
  %t19 = sext i32 0 to i64
  store i64 %t19, ptr %t18
  br label %L4
L4:
  %t20 = load i64, ptr %t18
  %t21 = load ptr, ptr %t0
  %t23 = ptrtoint ptr %t21 to i64
  %t22 = icmp slt i64 %t20, %t23
  %t24 = zext i1 %t22 to i64
  %t25 = icmp ne i64 %t24, 0
  br i1 %t25, label %L5, label %L7
L5:
  %t26 = load ptr, ptr %t0
  %t27 = load i64, ptr %t18
  %t28 = getelementptr i8, ptr %t26, i64 %t27
  %t29 = load ptr, ptr %t28
  call void @free(ptr %t29)
  br label %L6
L6:
  %t31 = load i64, ptr %t18
  %t32 = add i64 %t31, 1
  store i64 %t32, ptr %t18
  br label %L4
L7:
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
