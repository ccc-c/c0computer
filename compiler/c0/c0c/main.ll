; ModuleID = 'main.c'
source_filename = "main.c"
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

declare ptr @macro_preprocess(ptr, ptr, i64)
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
declare ptr @parser_new(ptr)
declare void @parser_free(ptr)
declare ptr @parser_parse(ptr)
declare ptr @codegen_new(ptr, ptr)
declare void @codegen_free(ptr)
declare void @codegen_emit(ptr, ptr)

define internal ptr @read_file(ptr %t0) {
entry:
  %t1 = alloca ptr
  %t2 = getelementptr [2 x i8], ptr @.str0, i64 0, i64 0
  %t3 = call ptr @fopen(ptr %t0, ptr %t2)
  store ptr %t3, ptr %t1
  %t4 = load ptr, ptr %t1
  %t6 = ptrtoint ptr %t4 to i64
  %t7 = icmp eq i64 %t6, 0
  %t5 = zext i1 %t7 to i64
  %t8 = icmp ne i64 %t5, 0
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = call ptr @__c0c_stderr()
  %t10 = getelementptr [23 x i8], ptr @.str1, i64 0, i64 0
  %t11 = call i32 @fprintf(ptr %t9, ptr %t10, ptr %t0)
  %t12 = sext i32 %t11 to i64
  call void @exit(i64 1)
  br label %L2
L2:
  %t14 = load ptr, ptr %t1
  %t15 = call i64 @fseek(ptr %t14, i64 0, i64 2)
  %t16 = alloca i64
  %t17 = load ptr, ptr %t1
  %t18 = call i64 @ftell(ptr %t17)
  store i64 %t18, ptr %t16
  %t19 = load ptr, ptr %t1
  %t20 = call i64 @fseek(ptr %t19, i64 0, i64 0)
  %t21 = alloca ptr
  %t22 = load i64, ptr %t16
  %t24 = sext i32 2 to i64
  %t23 = add i64 %t22, %t24
  %t25 = call ptr @malloc(i64 %t23)
  store ptr %t25, ptr %t21
  %t26 = load ptr, ptr %t21
  %t28 = ptrtoint ptr %t26 to i64
  %t29 = icmp eq i64 %t28, 0
  %t27 = zext i1 %t29 to i64
  %t30 = icmp ne i64 %t27, 0
  br i1 %t30, label %L3, label %L5
L3:
  %t31 = getelementptr [7 x i8], ptr @.str2, i64 0, i64 0
  call void @perror(ptr %t31)
  call void @exit(i64 1)
  br label %L5
L5:
  %t34 = alloca i64
  %t35 = load ptr, ptr %t21
  %t36 = load i64, ptr %t16
  %t37 = load ptr, ptr %t1
  %t38 = call i64 @fread(ptr %t35, i64 1, i64 %t36, ptr %t37)
  store i64 %t38, ptr %t34
  %t39 = load ptr, ptr %t21
  %t40 = load i64, ptr %t34
  %t41 = getelementptr ptr, ptr %t39, i64 %t40
  %t42 = sext i32 0 to i64
  store i64 %t42, ptr %t41
  %t43 = load ptr, ptr %t1
  %t44 = call i32 @fclose(ptr %t43)
  %t45 = sext i32 %t44 to i64
  %t46 = load ptr, ptr %t21
  ret ptr %t46
L6:
  ret ptr null
}

define internal void @usage(ptr %t0) {
entry:
  %t1 = call ptr @__c0c_stderr()
  %t2 = getelementptr [45 x i8], ptr @.str3, i64 0, i64 0
  %t3 = call i32 @fprintf(ptr %t1, ptr %t2, ptr %t0, ptr %t0)
  %t4 = sext i32 %t3 to i64
  ret void
}

define internal void @compile(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca ptr
  %t3 = call ptr @read_file(ptr %t0)
  store ptr %t3, ptr %t2
  %t4 = alloca ptr
  %t5 = load ptr, ptr %t2
  %t6 = call ptr @macro_preprocess(ptr %t5, ptr %t0, i64 0)
  store ptr %t6, ptr %t4
  %t7 = load ptr, ptr %t2
  call void @free(ptr %t7)
  %t9 = alloca ptr
  %t10 = load ptr, ptr %t4
  %t11 = call ptr @lexer_new(ptr %t10, ptr %t0)
  store ptr %t11, ptr %t9
  %t12 = alloca ptr
  %t13 = load ptr, ptr %t9
  %t14 = call ptr @parser_new(ptr %t13)
  store ptr %t14, ptr %t12
  %t15 = alloca ptr
  %t16 = load ptr, ptr %t12
  %t17 = call ptr @parser_parse(ptr %t16)
  store ptr %t17, ptr %t15
  %t18 = alloca ptr
  %t19 = call ptr @codegen_new(ptr %t1, ptr %t0)
  store ptr %t19, ptr %t18
  %t20 = load ptr, ptr %t18
  %t21 = load ptr, ptr %t15
  call void @codegen_emit(ptr %t20, ptr %t21)
  %t23 = load ptr, ptr %t18
  call void @codegen_free(ptr %t23)
  %t25 = load ptr, ptr %t15
  call void @node_free(ptr %t25)
  %t27 = load ptr, ptr %t12
  call void @parser_free(ptr %t27)
  %t29 = load ptr, ptr %t9
  call void @lexer_free(ptr %t29)
  %t31 = load ptr, ptr %t4
  call void @free(ptr %t31)
  ret void
}

define dso_local i32 @main(i64 %t0, ptr %t1) {
entry:
  %t2 = alloca ptr
  %t4 = sext i32 0 to i64
  %t3 = inttoptr i64 %t4 to ptr
  store ptr %t3, ptr %t2
  %t5 = alloca ptr
  %t7 = sext i32 0 to i64
  %t6 = inttoptr i64 %t7 to ptr
  store ptr %t6, ptr %t5
  %t8 = alloca i64
  %t9 = sext i32 1 to i64
  store i64 %t9, ptr %t8
  br label %L0
L0:
  %t10 = load i64, ptr %t8
  %t11 = icmp slt i64 %t10, %t0
  %t12 = zext i1 %t11 to i64
  %t13 = icmp ne i64 %t12, 0
  br i1 %t13, label %L1, label %L3
L1:
  %t14 = load i64, ptr %t8
  %t15 = getelementptr ptr, ptr %t1, i64 %t14
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %t18 = call i32 @strcmp(ptr %t16, ptr %t17)
  %t19 = sext i32 %t18 to i64
  %t21 = sext i32 0 to i64
  %t20 = icmp eq i64 %t19, %t21
  %t22 = zext i1 %t20 to i64
  %t23 = icmp ne i64 %t22, 0
  br i1 %t23, label %L4, label %L5
L4:
  br label %L6
L5:
  %t24 = load i64, ptr %t8
  %t25 = getelementptr ptr, ptr %t1, i64 %t24
  %t26 = load ptr, ptr %t25
  %t27 = getelementptr [7 x i8], ptr @.str5, i64 0, i64 0
  %t28 = call i32 @strcmp(ptr %t26, ptr %t27)
  %t29 = sext i32 %t28 to i64
  %t31 = sext i32 0 to i64
  %t30 = icmp eq i64 %t29, %t31
  %t32 = zext i1 %t30 to i64
  %t33 = icmp ne i64 %t32, 0
  %t34 = zext i1 %t33 to i64
  br label %L6
L6:
  %t35 = phi i64 [ 1, %L4 ], [ %t34, %L5 ]
  %t36 = icmp ne i64 %t35, 0
  br i1 %t36, label %L7, label %L9
L7:
  %t37 = sext i32 0 to i64
  %t38 = getelementptr ptr, ptr %t1, i64 %t37
  %t39 = load ptr, ptr %t38
  call void @usage(ptr %t39)
  %t41 = sext i32 0 to i64
  %t42 = trunc i64 %t41 to i32
  ret i32 %t42
L10:
  br label %L9
L9:
  %t43 = load i64, ptr %t8
  %t44 = getelementptr ptr, ptr %t1, i64 %t43
  %t45 = load ptr, ptr %t44
  %t46 = getelementptr [3 x i8], ptr @.str6, i64 0, i64 0
  %t47 = call i32 @strcmp(ptr %t45, ptr %t46)
  %t48 = sext i32 %t47 to i64
  %t50 = sext i32 0 to i64
  %t49 = icmp eq i64 %t48, %t50
  %t51 = zext i1 %t49 to i64
  %t52 = icmp ne i64 %t51, 0
  br i1 %t52, label %L11, label %L12
L11:
  br label %L13
L12:
  %t53 = load i64, ptr %t8
  %t54 = getelementptr ptr, ptr %t1, i64 %t53
  %t55 = load ptr, ptr %t54
  %t56 = getelementptr [10 x i8], ptr @.str7, i64 0, i64 0
  %t57 = call i32 @strcmp(ptr %t55, ptr %t56)
  %t58 = sext i32 %t57 to i64
  %t60 = sext i32 0 to i64
  %t59 = icmp eq i64 %t58, %t60
  %t61 = zext i1 %t59 to i64
  %t62 = icmp ne i64 %t61, 0
  %t63 = zext i1 %t62 to i64
  br label %L13
L13:
  %t64 = phi i64 [ 1, %L11 ], [ %t63, %L12 ]
  %t65 = icmp ne i64 %t64, 0
  br i1 %t65, label %L14, label %L16
L14:
  %t66 = getelementptr [19 x i8], ptr @.str8, i64 0, i64 0
  %t67 = call i32 @printf(ptr %t66)
  %t68 = sext i32 %t67 to i64
  %t69 = sext i32 0 to i64
  %t70 = trunc i64 %t69 to i32
  ret i32 %t70
L17:
  br label %L16
L16:
  %t71 = load i64, ptr %t8
  %t72 = getelementptr ptr, ptr %t1, i64 %t71
  %t73 = load ptr, ptr %t72
  %t74 = getelementptr [3 x i8], ptr @.str9, i64 0, i64 0
  %t75 = call i32 @strcmp(ptr %t73, ptr %t74)
  %t76 = sext i32 %t75 to i64
  %t78 = sext i32 0 to i64
  %t77 = icmp eq i64 %t76, %t78
  %t79 = zext i1 %t77 to i64
  %t80 = icmp ne i64 %t79, 0
  br i1 %t80, label %L18, label %L20
L18:
  %t81 = load i64, ptr %t8
  %t82 = add i64 %t81, 1
  store i64 %t82, ptr %t8
  %t83 = icmp sge i64 %t82, %t0
  %t84 = zext i1 %t83 to i64
  %t85 = icmp ne i64 %t84, 0
  br i1 %t85, label %L21, label %L23
L21:
  %t86 = call ptr @__c0c_stderr()
  %t87 = getelementptr [30 x i8], ptr @.str10, i64 0, i64 0
  %t88 = call i32 @fprintf(ptr %t86, ptr %t87)
  %t89 = sext i32 %t88 to i64
  %t90 = sext i32 1 to i64
  %t91 = trunc i64 %t90 to i32
  ret i32 %t91
L24:
  br label %L23
L23:
  %t92 = load i64, ptr %t8
  %t93 = getelementptr ptr, ptr %t1, i64 %t92
  %t94 = load ptr, ptr %t93
  store ptr %t94, ptr %t2
  br label %L2
L25:
  br label %L20
L20:
  %t95 = load i64, ptr %t8
  %t96 = getelementptr ptr, ptr %t1, i64 %t95
  %t97 = load ptr, ptr %t96
  %t98 = getelementptr [3 x i8], ptr @.str11, i64 0, i64 0
  %t99 = call i32 @strcmp(ptr %t97, ptr %t98)
  %t100 = sext i32 %t99 to i64
  %t102 = sext i32 0 to i64
  %t101 = icmp eq i64 %t100, %t102
  %t103 = zext i1 %t101 to i64
  %t104 = icmp ne i64 %t103, 0
  br i1 %t104, label %L26, label %L28
L26:
  %t105 = load i64, ptr %t8
  %t106 = add i64 %t105, 1
  store i64 %t106, ptr %t8
  %t107 = icmp sge i64 %t106, %t0
  %t108 = zext i1 %t107 to i64
  %t109 = icmp ne i64 %t108, 0
  br i1 %t109, label %L29, label %L31
L29:
  %t110 = call ptr @__c0c_stderr()
  %t111 = getelementptr [30 x i8], ptr @.str12, i64 0, i64 0
  %t112 = call i32 @fprintf(ptr %t110, ptr %t111)
  %t113 = sext i32 %t112 to i64
  %t114 = sext i32 1 to i64
  %t115 = trunc i64 %t114 to i32
  ret i32 %t115
L32:
  br label %L31
L31:
  %t116 = load i64, ptr %t8
  %t117 = getelementptr ptr, ptr %t1, i64 %t116
  %t118 = load ptr, ptr %t117
  store ptr %t118, ptr %t5
  br label %L2
L33:
  br label %L28
L28:
  %t119 = load ptr, ptr %t2
  %t121 = ptrtoint ptr %t119 to i64
  %t122 = icmp eq i64 %t121, 0
  %t120 = zext i1 %t122 to i64
  %t123 = icmp ne i64 %t120, 0
  br i1 %t123, label %L34, label %L35
L34:
  %t124 = load i64, ptr %t8
  %t125 = getelementptr ptr, ptr %t1, i64 %t124
  %t126 = load ptr, ptr %t125
  store ptr %t126, ptr %t2
  br label %L36
L35:
  %t127 = call ptr @__c0c_stderr()
  %t128 = getelementptr [31 x i8], ptr @.str13, i64 0, i64 0
  %t129 = load i64, ptr %t8
  %t130 = getelementptr ptr, ptr %t1, i64 %t129
  %t131 = load ptr, ptr %t130
  %t132 = call i32 @fprintf(ptr %t127, ptr %t128, ptr %t131)
  %t133 = sext i32 %t132 to i64
  %t134 = sext i32 0 to i64
  %t135 = getelementptr ptr, ptr %t1, i64 %t134
  %t136 = load ptr, ptr %t135
  call void @usage(ptr %t136)
  %t138 = sext i32 1 to i64
  %t139 = trunc i64 %t138 to i32
  ret i32 %t139
L37:
  br label %L36
L36:
  br label %L2
L2:
  %t140 = load i64, ptr %t8
  %t141 = add i64 %t140, 1
  store i64 %t141, ptr %t8
  br label %L0
L3:
  %t142 = load ptr, ptr %t2
  %t144 = ptrtoint ptr %t142 to i64
  %t145 = icmp eq i64 %t144, 0
  %t143 = zext i1 %t145 to i64
  %t146 = icmp ne i64 %t143, 0
  br i1 %t146, label %L38, label %L40
L38:
  %t147 = call ptr @__c0c_stderr()
  %t148 = getelementptr [20 x i8], ptr @.str14, i64 0, i64 0
  %t149 = call i32 @fprintf(ptr %t147, ptr %t148)
  %t150 = sext i32 %t149 to i64
  %t151 = sext i32 0 to i64
  %t152 = getelementptr ptr, ptr %t1, i64 %t151
  %t153 = load ptr, ptr %t152
  call void @usage(ptr %t153)
  %t155 = sext i32 1 to i64
  %t156 = trunc i64 %t155 to i32
  ret i32 %t156
L41:
  br label %L40
L40:
  %t157 = alloca ptr
  %t158 = call ptr @__c0c_stdout()
  store ptr %t158, ptr %t157
  %t159 = load ptr, ptr %t5
  %t160 = icmp ne ptr %t159, null
  br i1 %t160, label %L42, label %L44
L42:
  %t161 = load ptr, ptr %t5
  %t162 = getelementptr [2 x i8], ptr @.str15, i64 0, i64 0
  %t163 = call ptr @fopen(ptr %t161, ptr %t162)
  store ptr %t163, ptr %t157
  %t164 = load ptr, ptr %t157
  %t166 = ptrtoint ptr %t164 to i64
  %t167 = icmp eq i64 %t166, 0
  %t165 = zext i1 %t167 to i64
  %t168 = icmp ne i64 %t165, 0
  br i1 %t168, label %L45, label %L47
L45:
  %t169 = call ptr @__c0c_stderr()
  %t170 = getelementptr [35 x i8], ptr @.str16, i64 0, i64 0
  %t171 = load ptr, ptr %t5
  %t172 = call i32 @fprintf(ptr %t169, ptr %t170, ptr %t171)
  %t173 = sext i32 %t172 to i64
  %t174 = sext i32 1 to i64
  %t175 = trunc i64 %t174 to i32
  ret i32 %t175
L48:
  br label %L47
L47:
  br label %L44
L44:
  %t176 = load ptr, ptr %t2
  %t177 = load ptr, ptr %t157
  call void @compile(ptr %t176, ptr %t177)
  %t179 = load ptr, ptr %t5
  %t180 = icmp ne ptr %t179, null
  br i1 %t180, label %L49, label %L51
L49:
  %t181 = load ptr, ptr %t157
  %t182 = call i32 @fclose(ptr %t181)
  %t183 = sext i32 %t182 to i64
  br label %L51
L51:
  %t184 = sext i32 0 to i64
  %t185 = trunc i64 %t184 to i32
  ret i32 %t185
L52:
  ret i32 0
}

@.str0 = private unnamed_addr constant [2 x i8] c"r\00"
@.str1 = private unnamed_addr constant [23 x i8] c"c0c: cannot open '%s'\0A\00"
@.str2 = private unnamed_addr constant [7 x i8] c"malloc\00"
@.str3 = private unnamed_addr constant [45 x i8] c"c0c - a self-hosting C to LLVM IR compiler\0A\0A\00"
@.str4 = private unnamed_addr constant [3 x i8] c"-h\00"
@.str5 = private unnamed_addr constant [7 x i8] c"--help\00"
@.str6 = private unnamed_addr constant [3 x i8] c"-v\00"
@.str7 = private unnamed_addr constant [10 x i8] c"--version\00"
@.str8 = private unnamed_addr constant [19 x i8] c"c0c version 0.1.0\0A\00"
@.str9 = private unnamed_addr constant [3 x i8] c"-c\00"
@.str10 = private unnamed_addr constant [30 x i8] c"c0c: -c requires an argument\0A\00"
@.str11 = private unnamed_addr constant [3 x i8] c"-o\00"
@.str12 = private unnamed_addr constant [30 x i8] c"c0c: -o requires an argument\0A\00"
@.str13 = private unnamed_addr constant [31 x i8] c"c0c: unexpected argument '%s'\0A\00"
@.str14 = private unnamed_addr constant [20 x i8] c"c0c: no input file\0A\00"
@.str15 = private unnamed_addr constant [2 x i8] c"w\00"
@.str16 = private unnamed_addr constant [35 x i8] c"c0c: cannot open output file '%s'\0A\00"
