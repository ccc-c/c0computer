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
  %t9 = getelementptr [23 x i8], ptr @.str1, i64 0, i64 0
  %t10 = call i32 @fprintf(ptr @stderr, ptr %t9, ptr %t0)
  %t11 = sext i32 %t10 to i64
  %t12 = call i32 @exit(i64 1)
  %t13 = sext i32 %t12 to i64
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
  %t32 = call i32 @perror(ptr %t31)
  %t33 = sext i32 %t32 to i64
  %t34 = call i32 @exit(i64 1)
  %t35 = sext i32 %t34 to i64
  br label %L5
L5:
  %t36 = alloca i64
  %t37 = load ptr, ptr %t21
  %t38 = load i64, ptr %t16
  %t39 = load ptr, ptr %t1
  %t40 = call i64 @fread(ptr %t37, i64 1, i64 %t38, ptr %t39)
  store i64 %t40, ptr %t36
  %t41 = load ptr, ptr %t21
  %t42 = load i64, ptr %t36
  %t43 = getelementptr i8, ptr %t41, i64 %t42
  %t44 = sext i32 0 to i64
  store i64 %t44, ptr %t43
  %t45 = load ptr, ptr %t1
  %t46 = call i32 @fclose(ptr %t45)
  %t47 = sext i32 %t46 to i64
  %t48 = load ptr, ptr %t21
  ret ptr %t48
L6:
  ret ptr null
}

define internal void @usage(ptr %t0) {
entry:
  %t1 = getelementptr [45 x i8], ptr @.str3, i64 0, i64 0
  %t2 = call i32 @fprintf(ptr @stderr, ptr %t1, ptr %t0, ptr %t0)
  %t3 = sext i32 %t2 to i64
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
  %t8 = call i32 @free(ptr %t7)
  %t9 = sext i32 %t8 to i64
  %t10 = alloca ptr
  %t11 = load ptr, ptr %t4
  %t12 = call ptr @lexer_new(ptr %t11, ptr %t0)
  store ptr %t12, ptr %t10
  %t13 = alloca ptr
  %t14 = load ptr, ptr %t10
  %t15 = call ptr @parser_new(ptr %t14)
  store ptr %t15, ptr %t13
  %t16 = alloca ptr
  %t17 = load ptr, ptr %t13
  %t18 = call ptr @parser_parse(ptr %t17)
  store ptr %t18, ptr %t16
  %t19 = alloca ptr
  %t20 = call ptr @codegen_new(ptr %t1, ptr %t0)
  store ptr %t20, ptr %t19
  %t21 = load ptr, ptr %t19
  %t22 = load ptr, ptr %t16
  call void @codegen_emit(ptr %t21, ptr %t22)
  %t24 = load ptr, ptr %t19
  call void @codegen_free(ptr %t24)
  %t26 = load ptr, ptr %t16
  call void @node_free(ptr %t26)
  %t28 = load ptr, ptr %t13
  call void @parser_free(ptr %t28)
  %t30 = load ptr, ptr %t10
  call void @lexer_free(ptr %t30)
  %t32 = load ptr, ptr %t4
  %t33 = call i32 @free(ptr %t32)
  %t34 = sext i32 %t33 to i64
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
  %t15 = getelementptr i32, ptr %t1, i64 %t14
  %t16 = load i64, ptr %t15
  %t17 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %t18 = call i32 @strcmp(i64 %t16, ptr %t17)
  %t19 = sext i32 %t18 to i64
  %t21 = sext i32 0 to i64
  %t20 = icmp eq i64 %t19, %t21
  %t22 = zext i1 %t20 to i64
  %t23 = load i64, ptr %t8
  %t24 = getelementptr i32, ptr %t1, i64 %t23
  %t25 = load i64, ptr %t24
  %t26 = getelementptr [7 x i8], ptr @.str5, i64 0, i64 0
  %t27 = call i32 @strcmp(i64 %t25, ptr %t26)
  %t28 = sext i32 %t27 to i64
  %t30 = sext i32 0 to i64
  %t29 = icmp eq i64 %t28, %t30
  %t31 = zext i1 %t29 to i64
  %t33 = icmp ne i64 %t22, 0
  %t34 = icmp ne i64 %t31, 0
  %t35 = or i1 %t33, %t34
  %t36 = zext i1 %t35 to i64
  %t37 = icmp ne i64 %t36, 0
  br i1 %t37, label %L4, label %L6
L4:
  %t38 = sext i32 0 to i64
  %t39 = getelementptr i32, ptr %t1, i64 %t38
  %t40 = load i64, ptr %t39
  call void @usage(i64 %t40)
  %t42 = sext i32 0 to i64
  %t43 = trunc i64 %t42 to i32
  ret i32 %t43
L7:
  br label %L6
L6:
  %t44 = load i64, ptr %t8
  %t45 = getelementptr i32, ptr %t1, i64 %t44
  %t46 = load i64, ptr %t45
  %t47 = getelementptr [3 x i8], ptr @.str6, i64 0, i64 0
  %t48 = call i32 @strcmp(i64 %t46, ptr %t47)
  %t49 = sext i32 %t48 to i64
  %t51 = sext i32 0 to i64
  %t50 = icmp eq i64 %t49, %t51
  %t52 = zext i1 %t50 to i64
  %t53 = load i64, ptr %t8
  %t54 = getelementptr i32, ptr %t1, i64 %t53
  %t55 = load i64, ptr %t54
  %t56 = getelementptr [10 x i8], ptr @.str7, i64 0, i64 0
  %t57 = call i32 @strcmp(i64 %t55, ptr %t56)
  %t58 = sext i32 %t57 to i64
  %t60 = sext i32 0 to i64
  %t59 = icmp eq i64 %t58, %t60
  %t61 = zext i1 %t59 to i64
  %t63 = icmp ne i64 %t52, 0
  %t64 = icmp ne i64 %t61, 0
  %t65 = or i1 %t63, %t64
  %t66 = zext i1 %t65 to i64
  %t67 = icmp ne i64 %t66, 0
  br i1 %t67, label %L8, label %L10
L8:
  %t68 = getelementptr [19 x i8], ptr @.str8, i64 0, i64 0
  %t69 = call i32 @printf(ptr %t68)
  %t70 = sext i32 %t69 to i64
  %t71 = sext i32 0 to i64
  %t72 = trunc i64 %t71 to i32
  ret i32 %t72
L11:
  br label %L10
L10:
  %t73 = load i64, ptr %t8
  %t74 = getelementptr i32, ptr %t1, i64 %t73
  %t75 = load i64, ptr %t74
  %t76 = getelementptr [3 x i8], ptr @.str9, i64 0, i64 0
  %t77 = call i32 @strcmp(i64 %t75, ptr %t76)
  %t78 = sext i32 %t77 to i64
  %t80 = sext i32 0 to i64
  %t79 = icmp eq i64 %t78, %t80
  %t81 = zext i1 %t79 to i64
  %t82 = icmp ne i64 %t81, 0
  br i1 %t82, label %L12, label %L14
L12:
  %t83 = load i64, ptr %t8
  %t84 = add i64 %t83, 1
  store i64 %t84, ptr %t8
  %t85 = icmp sge i64 %t84, %t0
  %t86 = zext i1 %t85 to i64
  %t87 = icmp ne i64 %t86, 0
  br i1 %t87, label %L15, label %L17
L15:
  %t88 = getelementptr [30 x i8], ptr @.str10, i64 0, i64 0
  %t89 = call i32 @fprintf(ptr @stderr, ptr %t88)
  %t90 = sext i32 %t89 to i64
  %t91 = sext i32 1 to i64
  %t92 = trunc i64 %t91 to i32
  ret i32 %t92
L18:
  br label %L17
L17:
  %t93 = load i64, ptr %t8
  %t94 = getelementptr i32, ptr %t1, i64 %t93
  %t95 = load i64, ptr %t94
  store i64 %t95, ptr %t2
  br label %L2
L19:
  br label %L14
L14:
  %t96 = load i64, ptr %t8
  %t97 = getelementptr i32, ptr %t1, i64 %t96
  %t98 = load i64, ptr %t97
  %t99 = getelementptr [3 x i8], ptr @.str11, i64 0, i64 0
  %t100 = call i32 @strcmp(i64 %t98, ptr %t99)
  %t101 = sext i32 %t100 to i64
  %t103 = sext i32 0 to i64
  %t102 = icmp eq i64 %t101, %t103
  %t104 = zext i1 %t102 to i64
  %t105 = icmp ne i64 %t104, 0
  br i1 %t105, label %L20, label %L22
L20:
  %t106 = load i64, ptr %t8
  %t107 = add i64 %t106, 1
  store i64 %t107, ptr %t8
  %t108 = icmp sge i64 %t107, %t0
  %t109 = zext i1 %t108 to i64
  %t110 = icmp ne i64 %t109, 0
  br i1 %t110, label %L23, label %L25
L23:
  %t111 = getelementptr [30 x i8], ptr @.str12, i64 0, i64 0
  %t112 = call i32 @fprintf(ptr @stderr, ptr %t111)
  %t113 = sext i32 %t112 to i64
  %t114 = sext i32 1 to i64
  %t115 = trunc i64 %t114 to i32
  ret i32 %t115
L26:
  br label %L25
L25:
  %t116 = load i64, ptr %t8
  %t117 = getelementptr i32, ptr %t1, i64 %t116
  %t118 = load i64, ptr %t117
  store i64 %t118, ptr %t5
  br label %L2
L27:
  br label %L22
L22:
  %t119 = load ptr, ptr %t2
  %t121 = ptrtoint ptr %t119 to i64
  %t122 = icmp eq i64 %t121, 0
  %t120 = zext i1 %t122 to i64
  %t123 = icmp ne i64 %t120, 0
  br i1 %t123, label %L28, label %L29
L28:
  %t124 = load i64, ptr %t8
  %t125 = getelementptr i32, ptr %t1, i64 %t124
  %t126 = load i64, ptr %t125
  store i64 %t126, ptr %t2
  br label %L30
L29:
  %t127 = getelementptr [31 x i8], ptr @.str13, i64 0, i64 0
  %t128 = load i64, ptr %t8
  %t129 = getelementptr i32, ptr %t1, i64 %t128
  %t130 = load i64, ptr %t129
  %t131 = call i32 @fprintf(ptr @stderr, ptr %t127, i64 %t130)
  %t132 = sext i32 %t131 to i64
  %t133 = sext i32 0 to i64
  %t134 = getelementptr i32, ptr %t1, i64 %t133
  %t135 = load i64, ptr %t134
  call void @usage(i64 %t135)
  %t137 = sext i32 1 to i64
  %t138 = trunc i64 %t137 to i32
  ret i32 %t138
L31:
  br label %L30
L30:
  br label %L2
L2:
  %t139 = load i64, ptr %t8
  %t140 = add i64 %t139, 1
  store i64 %t140, ptr %t8
  br label %L0
L3:
  %t141 = load ptr, ptr %t2
  %t143 = ptrtoint ptr %t141 to i64
  %t144 = icmp eq i64 %t143, 0
  %t142 = zext i1 %t144 to i64
  %t145 = icmp ne i64 %t142, 0
  br i1 %t145, label %L32, label %L34
L32:
  %t146 = getelementptr [20 x i8], ptr @.str14, i64 0, i64 0
  %t147 = call i32 @fprintf(ptr @stderr, ptr %t146)
  %t148 = sext i32 %t147 to i64
  %t149 = sext i32 0 to i64
  %t150 = getelementptr i32, ptr %t1, i64 %t149
  %t151 = load i64, ptr %t150
  call void @usage(i64 %t151)
  %t153 = sext i32 1 to i64
  %t154 = trunc i64 %t153 to i32
  ret i32 %t154
L35:
  br label %L34
L34:
  %t155 = alloca ptr
  store ptr @stdout, ptr %t155
  %t156 = load ptr, ptr %t5
  %t157 = icmp ne ptr %t156, null
  br i1 %t157, label %L36, label %L38
L36:
  %t158 = load ptr, ptr %t5
  %t159 = getelementptr [2 x i8], ptr @.str15, i64 0, i64 0
  %t160 = call ptr @fopen(ptr %t158, ptr %t159)
  store ptr %t160, ptr %t155
  %t161 = load ptr, ptr %t155
  %t163 = ptrtoint ptr %t161 to i64
  %t164 = icmp eq i64 %t163, 0
  %t162 = zext i1 %t164 to i64
  %t165 = icmp ne i64 %t162, 0
  br i1 %t165, label %L39, label %L41
L39:
  %t166 = getelementptr [35 x i8], ptr @.str16, i64 0, i64 0
  %t167 = load ptr, ptr %t5
  %t168 = call i32 @fprintf(ptr @stderr, ptr %t166, ptr %t167)
  %t169 = sext i32 %t168 to i64
  %t170 = sext i32 1 to i64
  %t171 = trunc i64 %t170 to i32
  ret i32 %t171
L42:
  br label %L41
L41:
  br label %L38
L38:
  %t172 = load ptr, ptr %t2
  %t173 = load ptr, ptr %t155
  call void @compile(ptr %t172, ptr %t173)
  %t175 = load ptr, ptr %t5
  %t176 = icmp ne ptr %t175, null
  br i1 %t176, label %L43, label %L45
L43:
  %t177 = load ptr, ptr %t155
  %t178 = call i32 @fclose(ptr %t177)
  %t179 = sext i32 %t178 to i64
  br label %L45
L45:
  %t180 = sext i32 0 to i64
  %t181 = trunc i64 %t180 to i32
  ret i32 %t181
L46:
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
