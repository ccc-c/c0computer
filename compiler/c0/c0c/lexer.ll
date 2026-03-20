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


define internal i8 @cur(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  %t2 = load ptr, ptr %t0
  %t3 = ptrtoint ptr %t2 to i64
  %t4 = getelementptr ptr, ptr %t1, i64 %t3
  %t5 = load ptr, ptr %t4
  %t6 = ptrtoint ptr %t5 to i64
  %t7 = trunc i64 %t6 to i8
  ret i8 %t7
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
  %t8 = getelementptr ptr, ptr %t1, i64 %t7
  %t9 = load ptr, ptr %t8
  %t10 = ptrtoint ptr %t9 to i64
  %t11 = trunc i64 %t10 to i8
  ret i8 %t11
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
  %t7 = getelementptr ptr, ptr %t2, i64 %t6
  %t8 = load ptr, ptr %t7
  store ptr %t8, ptr %t1
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
  call void @perror(ptr %t13)
  call void @exit(i64 1)
  br label %L2
L2:
  %t16 = load ptr, ptr %t2
  %t17 = call ptr @memcpy(ptr %t16, ptr %t0, ptr %t1)
  %t18 = load ptr, ptr %t2
  %t20 = ptrtoint ptr %t1 to i64
  %t19 = getelementptr ptr, ptr %t18, i64 %t20
  %t21 = sext i32 0 to i64
  store i64 %t21, ptr %t19
  %t22 = load ptr, ptr %t2
  ret ptr %t22
L3:
  ret ptr null
}

define internal i64 @keyword_lookup(ptr %t0) {
entry:
  %t1 = getelementptr [4 x i8], ptr @.str1, i64 0, i64 0
  %t2 = call i32 @strcmp(ptr %t0, ptr %t1)
  %t3 = sext i32 %t2 to i64
  %t5 = sext i32 0 to i64
  %t4 = icmp eq i64 %t3, %t5
  %t6 = zext i1 %t4 to i64
  %t7 = icmp ne i64 %t6, 0
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = sext i32 5 to i64
  ret i64 %t8
L3:
  br label %L2
L2:
  %t9 = getelementptr [5 x i8], ptr @.str2, i64 0, i64 0
  %t10 = call i32 @strcmp(ptr %t0, ptr %t9)
  %t11 = sext i32 %t10 to i64
  %t13 = sext i32 0 to i64
  %t12 = icmp eq i64 %t11, %t13
  %t14 = zext i1 %t12 to i64
  %t15 = icmp ne i64 %t14, 0
  br i1 %t15, label %L4, label %L6
L4:
  %t16 = sext i32 6 to i64
  ret i64 %t16
L7:
  br label %L6
L6:
  %t17 = getelementptr [6 x i8], ptr @.str3, i64 0, i64 0
  %t18 = call i32 @strcmp(ptr %t0, ptr %t17)
  %t19 = sext i32 %t18 to i64
  %t21 = sext i32 0 to i64
  %t20 = icmp eq i64 %t19, %t21
  %t22 = zext i1 %t20 to i64
  %t23 = icmp ne i64 %t22, 0
  br i1 %t23, label %L8, label %L10
L8:
  %t24 = sext i32 7 to i64
  ret i64 %t24
L11:
  br label %L10
L10:
  %t25 = getelementptr [7 x i8], ptr @.str4, i64 0, i64 0
  %t26 = call i32 @strcmp(ptr %t0, ptr %t25)
  %t27 = sext i32 %t26 to i64
  %t29 = sext i32 0 to i64
  %t28 = icmp eq i64 %t27, %t29
  %t30 = zext i1 %t28 to i64
  %t31 = icmp ne i64 %t30, 0
  br i1 %t31, label %L12, label %L14
L12:
  %t32 = sext i32 8 to i64
  ret i64 %t32
L15:
  br label %L14
L14:
  %t33 = getelementptr [5 x i8], ptr @.str5, i64 0, i64 0
  %t34 = call i32 @strcmp(ptr %t0, ptr %t33)
  %t35 = sext i32 %t34 to i64
  %t37 = sext i32 0 to i64
  %t36 = icmp eq i64 %t35, %t37
  %t38 = zext i1 %t36 to i64
  %t39 = icmp ne i64 %t38, 0
  br i1 %t39, label %L16, label %L18
L16:
  %t40 = sext i32 9 to i64
  ret i64 %t40
L19:
  br label %L18
L18:
  %t41 = getelementptr [5 x i8], ptr @.str6, i64 0, i64 0
  %t42 = call i32 @strcmp(ptr %t0, ptr %t41)
  %t43 = sext i32 %t42 to i64
  %t45 = sext i32 0 to i64
  %t44 = icmp eq i64 %t43, %t45
  %t46 = zext i1 %t44 to i64
  %t47 = icmp ne i64 %t46, 0
  br i1 %t47, label %L20, label %L22
L20:
  %t48 = sext i32 10 to i64
  ret i64 %t48
L23:
  br label %L22
L22:
  %t49 = getelementptr [6 x i8], ptr @.str7, i64 0, i64 0
  %t50 = call i32 @strcmp(ptr %t0, ptr %t49)
  %t51 = sext i32 %t50 to i64
  %t53 = sext i32 0 to i64
  %t52 = icmp eq i64 %t51, %t53
  %t54 = zext i1 %t52 to i64
  %t55 = icmp ne i64 %t54, 0
  br i1 %t55, label %L24, label %L26
L24:
  %t56 = sext i32 11 to i64
  ret i64 %t56
L27:
  br label %L26
L26:
  %t57 = getelementptr [9 x i8], ptr @.str8, i64 0, i64 0
  %t58 = call i32 @strcmp(ptr %t0, ptr %t57)
  %t59 = sext i32 %t58 to i64
  %t61 = sext i32 0 to i64
  %t60 = icmp eq i64 %t59, %t61
  %t62 = zext i1 %t60 to i64
  %t63 = icmp ne i64 %t62, 0
  br i1 %t63, label %L28, label %L30
L28:
  %t64 = sext i32 12 to i64
  ret i64 %t64
L31:
  br label %L30
L30:
  %t65 = getelementptr [7 x i8], ptr @.str9, i64 0, i64 0
  %t66 = call i32 @strcmp(ptr %t0, ptr %t65)
  %t67 = sext i32 %t66 to i64
  %t69 = sext i32 0 to i64
  %t68 = icmp eq i64 %t67, %t69
  %t70 = zext i1 %t68 to i64
  %t71 = icmp ne i64 %t70, 0
  br i1 %t71, label %L32, label %L34
L32:
  %t72 = sext i32 13 to i64
  ret i64 %t72
L35:
  br label %L34
L34:
  %t73 = getelementptr [3 x i8], ptr @.str10, i64 0, i64 0
  %t74 = call i32 @strcmp(ptr %t0, ptr %t73)
  %t75 = sext i32 %t74 to i64
  %t77 = sext i32 0 to i64
  %t76 = icmp eq i64 %t75, %t77
  %t78 = zext i1 %t76 to i64
  %t79 = icmp ne i64 %t78, 0
  br i1 %t79, label %L36, label %L38
L36:
  %t80 = sext i32 14 to i64
  ret i64 %t80
L39:
  br label %L38
L38:
  %t81 = getelementptr [5 x i8], ptr @.str11, i64 0, i64 0
  %t82 = call i32 @strcmp(ptr %t0, ptr %t81)
  %t83 = sext i32 %t82 to i64
  %t85 = sext i32 0 to i64
  %t84 = icmp eq i64 %t83, %t85
  %t86 = zext i1 %t84 to i64
  %t87 = icmp ne i64 %t86, 0
  br i1 %t87, label %L40, label %L42
L40:
  %t88 = sext i32 15 to i64
  ret i64 %t88
L43:
  br label %L42
L42:
  %t89 = getelementptr [6 x i8], ptr @.str12, i64 0, i64 0
  %t90 = call i32 @strcmp(ptr %t0, ptr %t89)
  %t91 = sext i32 %t90 to i64
  %t93 = sext i32 0 to i64
  %t92 = icmp eq i64 %t91, %t93
  %t94 = zext i1 %t92 to i64
  %t95 = icmp ne i64 %t94, 0
  br i1 %t95, label %L44, label %L46
L44:
  %t96 = sext i32 16 to i64
  ret i64 %t96
L47:
  br label %L46
L46:
  %t97 = getelementptr [4 x i8], ptr @.str13, i64 0, i64 0
  %t98 = call i32 @strcmp(ptr %t0, ptr %t97)
  %t99 = sext i32 %t98 to i64
  %t101 = sext i32 0 to i64
  %t100 = icmp eq i64 %t99, %t101
  %t102 = zext i1 %t100 to i64
  %t103 = icmp ne i64 %t102, 0
  br i1 %t103, label %L48, label %L50
L48:
  %t104 = sext i32 17 to i64
  ret i64 %t104
L51:
  br label %L50
L50:
  %t105 = getelementptr [3 x i8], ptr @.str14, i64 0, i64 0
  %t106 = call i32 @strcmp(ptr %t0, ptr %t105)
  %t107 = sext i32 %t106 to i64
  %t109 = sext i32 0 to i64
  %t108 = icmp eq i64 %t107, %t109
  %t110 = zext i1 %t108 to i64
  %t111 = icmp ne i64 %t110, 0
  br i1 %t111, label %L52, label %L54
L52:
  %t112 = sext i32 18 to i64
  ret i64 %t112
L55:
  br label %L54
L54:
  %t113 = getelementptr [7 x i8], ptr @.str15, i64 0, i64 0
  %t114 = call i32 @strcmp(ptr %t0, ptr %t113)
  %t115 = sext i32 %t114 to i64
  %t117 = sext i32 0 to i64
  %t116 = icmp eq i64 %t115, %t117
  %t118 = zext i1 %t116 to i64
  %t119 = icmp ne i64 %t118, 0
  br i1 %t119, label %L56, label %L58
L56:
  %t120 = sext i32 19 to i64
  ret i64 %t120
L59:
  br label %L58
L58:
  %t121 = getelementptr [6 x i8], ptr @.str16, i64 0, i64 0
  %t122 = call i32 @strcmp(ptr %t0, ptr %t121)
  %t123 = sext i32 %t122 to i64
  %t125 = sext i32 0 to i64
  %t124 = icmp eq i64 %t123, %t125
  %t126 = zext i1 %t124 to i64
  %t127 = icmp ne i64 %t126, 0
  br i1 %t127, label %L60, label %L62
L60:
  %t128 = sext i32 20 to i64
  ret i64 %t128
L63:
  br label %L62
L62:
  %t129 = getelementptr [9 x i8], ptr @.str17, i64 0, i64 0
  %t130 = call i32 @strcmp(ptr %t0, ptr %t129)
  %t131 = sext i32 %t130 to i64
  %t133 = sext i32 0 to i64
  %t132 = icmp eq i64 %t131, %t133
  %t134 = zext i1 %t132 to i64
  %t135 = icmp ne i64 %t134, 0
  br i1 %t135, label %L64, label %L66
L64:
  %t136 = sext i32 21 to i64
  ret i64 %t136
L67:
  br label %L66
L66:
  %t137 = getelementptr [7 x i8], ptr @.str18, i64 0, i64 0
  %t138 = call i32 @strcmp(ptr %t0, ptr %t137)
  %t139 = sext i32 %t138 to i64
  %t141 = sext i32 0 to i64
  %t140 = icmp eq i64 %t139, %t141
  %t142 = zext i1 %t140 to i64
  %t143 = icmp ne i64 %t142, 0
  br i1 %t143, label %L68, label %L70
L68:
  %t144 = sext i32 22 to i64
  ret i64 %t144
L71:
  br label %L70
L70:
  %t145 = getelementptr [5 x i8], ptr @.str19, i64 0, i64 0
  %t146 = call i32 @strcmp(ptr %t0, ptr %t145)
  %t147 = sext i32 %t146 to i64
  %t149 = sext i32 0 to i64
  %t148 = icmp eq i64 %t147, %t149
  %t150 = zext i1 %t148 to i64
  %t151 = icmp ne i64 %t150, 0
  br i1 %t151, label %L72, label %L74
L72:
  %t152 = sext i32 23 to i64
  ret i64 %t152
L75:
  br label %L74
L74:
  %t153 = getelementptr [8 x i8], ptr @.str20, i64 0, i64 0
  %t154 = call i32 @strcmp(ptr %t0, ptr %t153)
  %t155 = sext i32 %t154 to i64
  %t157 = sext i32 0 to i64
  %t156 = icmp eq i64 %t155, %t157
  %t158 = zext i1 %t156 to i64
  %t159 = icmp ne i64 %t158, 0
  br i1 %t159, label %L76, label %L78
L76:
  %t160 = sext i32 24 to i64
  ret i64 %t160
L79:
  br label %L78
L78:
  %t161 = getelementptr [5 x i8], ptr @.str21, i64 0, i64 0
  %t162 = call i32 @strcmp(ptr %t0, ptr %t161)
  %t163 = sext i32 %t162 to i64
  %t165 = sext i32 0 to i64
  %t164 = icmp eq i64 %t163, %t165
  %t166 = zext i1 %t164 to i64
  %t167 = icmp ne i64 %t166, 0
  br i1 %t167, label %L80, label %L82
L80:
  %t168 = sext i32 25 to i64
  ret i64 %t168
L83:
  br label %L82
L82:
  %t169 = getelementptr [7 x i8], ptr @.str22, i64 0, i64 0
  %t170 = call i32 @strcmp(ptr %t0, ptr %t169)
  %t171 = sext i32 %t170 to i64
  %t173 = sext i32 0 to i64
  %t172 = icmp eq i64 %t171, %t173
  %t174 = zext i1 %t172 to i64
  %t175 = icmp ne i64 %t174, 0
  br i1 %t175, label %L84, label %L86
L84:
  %t176 = sext i32 26 to i64
  ret i64 %t176
L87:
  br label %L86
L86:
  %t177 = getelementptr [6 x i8], ptr @.str23, i64 0, i64 0
  %t178 = call i32 @strcmp(ptr %t0, ptr %t177)
  %t179 = sext i32 %t178 to i64
  %t181 = sext i32 0 to i64
  %t180 = icmp eq i64 %t179, %t181
  %t182 = zext i1 %t180 to i64
  %t183 = icmp ne i64 %t182, 0
  br i1 %t183, label %L88, label %L90
L88:
  %t184 = sext i32 27 to i64
  ret i64 %t184
L91:
  br label %L90
L90:
  %t185 = getelementptr [5 x i8], ptr @.str24, i64 0, i64 0
  %t186 = call i32 @strcmp(ptr %t0, ptr %t185)
  %t187 = sext i32 %t186 to i64
  %t189 = sext i32 0 to i64
  %t188 = icmp eq i64 %t187, %t189
  %t190 = zext i1 %t188 to i64
  %t191 = icmp ne i64 %t190, 0
  br i1 %t191, label %L92, label %L94
L92:
  %t192 = sext i32 28 to i64
  ret i64 %t192
L95:
  br label %L94
L94:
  %t193 = getelementptr [8 x i8], ptr @.str25, i64 0, i64 0
  %t194 = call i32 @strcmp(ptr %t0, ptr %t193)
  %t195 = sext i32 %t194 to i64
  %t197 = sext i32 0 to i64
  %t196 = icmp eq i64 %t195, %t197
  %t198 = zext i1 %t196 to i64
  %t199 = icmp ne i64 %t198, 0
  br i1 %t199, label %L96, label %L98
L96:
  %t200 = sext i32 29 to i64
  ret i64 %t200
L99:
  br label %L98
L98:
  %t201 = getelementptr [7 x i8], ptr @.str26, i64 0, i64 0
  %t202 = call i32 @strcmp(ptr %t0, ptr %t201)
  %t203 = sext i32 %t202 to i64
  %t205 = sext i32 0 to i64
  %t204 = icmp eq i64 %t203, %t205
  %t206 = zext i1 %t204 to i64
  %t207 = icmp ne i64 %t206, 0
  br i1 %t207, label %L100, label %L102
L100:
  %t208 = sext i32 30 to i64
  ret i64 %t208
L103:
  br label %L102
L102:
  %t209 = getelementptr [7 x i8], ptr @.str27, i64 0, i64 0
  %t210 = call i32 @strcmp(ptr %t0, ptr %t209)
  %t211 = sext i32 %t210 to i64
  %t213 = sext i32 0 to i64
  %t212 = icmp eq i64 %t211, %t213
  %t214 = zext i1 %t212 to i64
  %t215 = icmp ne i64 %t214, 0
  br i1 %t215, label %L104, label %L106
L104:
  %t216 = sext i32 31 to i64
  ret i64 %t216
L107:
  br label %L106
L106:
  %t217 = getelementptr [6 x i8], ptr @.str28, i64 0, i64 0
  %t218 = call i32 @strcmp(ptr %t0, ptr %t217)
  %t219 = sext i32 %t218 to i64
  %t221 = sext i32 0 to i64
  %t220 = icmp eq i64 %t219, %t221
  %t222 = zext i1 %t220 to i64
  %t223 = icmp ne i64 %t222, 0
  br i1 %t223, label %L108, label %L110
L108:
  %t224 = sext i32 32 to i64
  ret i64 %t224
L111:
  br label %L110
L110:
  %t225 = getelementptr [9 x i8], ptr @.str29, i64 0, i64 0
  %t226 = call i32 @strcmp(ptr %t0, ptr %t225)
  %t227 = sext i32 %t226 to i64
  %t229 = sext i32 0 to i64
  %t228 = icmp eq i64 %t227, %t229
  %t230 = zext i1 %t228 to i64
  %t231 = icmp ne i64 %t230, 0
  br i1 %t231, label %L112, label %L114
L112:
  %t232 = sext i32 33 to i64
  ret i64 %t232
L115:
  br label %L114
L114:
  %t233 = getelementptr [7 x i8], ptr @.str30, i64 0, i64 0
  %t234 = call i32 @strcmp(ptr %t0, ptr %t233)
  %t235 = sext i32 %t234 to i64
  %t237 = sext i32 0 to i64
  %t236 = icmp eq i64 %t235, %t237
  %t238 = zext i1 %t236 to i64
  %t239 = icmp ne i64 %t238, 0
  br i1 %t239, label %L116, label %L118
L116:
  %t240 = sext i32 34 to i64
  ret i64 %t240
L119:
  br label %L118
L118:
  %t241 = sext i32 4 to i64
  ret i64 %t241
L120:
  ret i64 0
}

define dso_local ptr @lexer_new(ptr %t0, ptr %t1) {
entry:
  %t2 = alloca ptr
  %t3 = call ptr @calloc(i64 1, i64 0)
  store ptr %t3, ptr %t2
  %t4 = load ptr, ptr %t2
  %t6 = ptrtoint ptr %t4 to i64
  %t7 = icmp eq i64 %t6, 0
  %t5 = zext i1 %t7 to i64
  %t8 = icmp ne i64 %t5, 0
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = getelementptr [7 x i8], ptr @.str31, i64 0, i64 0
  call void @perror(ptr %t9)
  call void @exit(i64 1)
  br label %L2
L2:
  %t12 = load ptr, ptr %t2
  store ptr %t0, ptr %t12
  %t13 = load ptr, ptr %t2
  store ptr %t1, ptr %t13
  %t14 = load ptr, ptr %t2
  %t15 = sext i32 1 to i64
  store i64 %t15, ptr %t14
  %t16 = load ptr, ptr %t2
  %t17 = sext i32 1 to i64
  store i64 %t17, ptr %t16
  %t18 = load ptr, ptr %t2
  ret ptr %t18
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
  call void @free(ptr %t0)
  ret void
}

define dso_local void @token_free(ptr %t0) {
entry:
  %t1 = load ptr, ptr %t0
  call void @free(ptr %t1)
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
  %t3 = icmp ne i64 %t2, 0
  br i1 %t3, label %L7, label %L8
L7:
  %t4 = call i8 @cur(ptr %t0)
  %t5 = sext i8 %t4 to i64
  %t6 = add i64 %t5, 0
  %t7 = call i32 @isspace(i64 %t6)
  %t8 = sext i32 %t7 to i64
  %t9 = icmp ne i64 %t8, 0
  %t10 = zext i1 %t9 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t11 = phi i64 [ %t10, %L7 ], [ 0, %L8 ]
  %t12 = icmp ne i64 %t11, 0
  br i1 %t12, label %L5, label %L6
L5:
  %t13 = call i8 @advance(ptr %t0)
  %t14 = sext i8 %t13 to i64
  br label %L4
L6:
  %t15 = call i8 @cur(ptr %t0)
  %t16 = sext i8 %t15 to i64
  %t18 = sext i32 47 to i64
  %t17 = icmp eq i64 %t16, %t18
  %t19 = zext i1 %t17 to i64
  %t20 = icmp ne i64 %t19, 0
  br i1 %t20, label %L10, label %L11
L10:
  %t21 = call i8 @peek1(ptr %t0)
  %t22 = sext i8 %t21 to i64
  %t24 = sext i32 47 to i64
  %t23 = icmp eq i64 %t22, %t24
  %t25 = zext i1 %t23 to i64
  %t26 = icmp ne i64 %t25, 0
  %t27 = zext i1 %t26 to i64
  br label %L12
L11:
  br label %L12
L12:
  %t28 = phi i64 [ %t27, %L10 ], [ 0, %L11 ]
  %t29 = icmp ne i64 %t28, 0
  br i1 %t29, label %L13, label %L15
L13:
  br label %L16
L16:
  %t30 = call i8 @cur(ptr %t0)
  %t31 = sext i8 %t30 to i64
  %t32 = icmp ne i64 %t31, 0
  br i1 %t32, label %L19, label %L20
L19:
  %t33 = call i8 @cur(ptr %t0)
  %t34 = sext i8 %t33 to i64
  %t36 = sext i32 10 to i64
  %t35 = icmp ne i64 %t34, %t36
  %t37 = zext i1 %t35 to i64
  %t38 = icmp ne i64 %t37, 0
  %t39 = zext i1 %t38 to i64
  br label %L21
L20:
  br label %L21
L21:
  %t40 = phi i64 [ %t39, %L19 ], [ 0, %L20 ]
  %t41 = icmp ne i64 %t40, 0
  br i1 %t41, label %L17, label %L18
L17:
  %t42 = call i8 @advance(ptr %t0)
  %t43 = sext i8 %t42 to i64
  br label %L16
L18:
  br label %L2
L22:
  br label %L15
L15:
  %t44 = call i8 @cur(ptr %t0)
  %t45 = sext i8 %t44 to i64
  %t47 = sext i32 47 to i64
  %t46 = icmp eq i64 %t45, %t47
  %t48 = zext i1 %t46 to i64
  %t49 = icmp ne i64 %t48, 0
  br i1 %t49, label %L23, label %L24
L23:
  %t50 = call i8 @peek1(ptr %t0)
  %t51 = sext i8 %t50 to i64
  %t53 = sext i32 42 to i64
  %t52 = icmp eq i64 %t51, %t53
  %t54 = zext i1 %t52 to i64
  %t55 = icmp ne i64 %t54, 0
  %t56 = zext i1 %t55 to i64
  br label %L25
L24:
  br label %L25
L25:
  %t57 = phi i64 [ %t56, %L23 ], [ 0, %L24 ]
  %t58 = icmp ne i64 %t57, 0
  br i1 %t58, label %L26, label %L28
L26:
  %t59 = call i8 @advance(ptr %t0)
  %t60 = sext i8 %t59 to i64
  %t61 = call i8 @advance(ptr %t0)
  %t62 = sext i8 %t61 to i64
  br label %L29
L29:
  %t63 = call i8 @cur(ptr %t0)
  %t64 = sext i8 %t63 to i64
  %t65 = icmp ne i64 %t64, 0
  br i1 %t65, label %L32, label %L33
L32:
  %t66 = call i8 @cur(ptr %t0)
  %t67 = sext i8 %t66 to i64
  %t69 = sext i32 42 to i64
  %t68 = icmp eq i64 %t67, %t69
  %t70 = zext i1 %t68 to i64
  %t71 = icmp ne i64 %t70, 0
  br i1 %t71, label %L35, label %L36
L35:
  %t72 = call i8 @peek1(ptr %t0)
  %t73 = sext i8 %t72 to i64
  %t75 = sext i32 47 to i64
  %t74 = icmp eq i64 %t73, %t75
  %t76 = zext i1 %t74 to i64
  %t77 = icmp ne i64 %t76, 0
  %t78 = zext i1 %t77 to i64
  br label %L37
L36:
  br label %L37
L37:
  %t79 = phi i64 [ %t78, %L35 ], [ 0, %L36 ]
  %t81 = icmp eq i64 %t79, 0
  %t80 = zext i1 %t81 to i64
  %t82 = icmp ne i64 %t80, 0
  %t83 = zext i1 %t82 to i64
  br label %L34
L33:
  br label %L34
L34:
  %t84 = phi i64 [ %t83, %L32 ], [ 0, %L33 ]
  %t85 = icmp ne i64 %t84, 0
  br i1 %t85, label %L30, label %L31
L30:
  %t86 = call i8 @advance(ptr %t0)
  %t87 = sext i8 %t86 to i64
  br label %L29
L31:
  %t88 = call i8 @cur(ptr %t0)
  %t89 = sext i8 %t88 to i64
  %t90 = icmp ne i64 %t89, 0
  br i1 %t90, label %L38, label %L40
L38:
  %t91 = call i8 @advance(ptr %t0)
  %t92 = sext i8 %t91 to i64
  %t93 = call i8 @advance(ptr %t0)
  %t94 = sext i8 %t93 to i64
  br label %L40
L40:
  br label %L2
L41:
  br label %L28
L28:
  br label %L3
L42:
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
  %t13 = getelementptr [1 x i8], ptr @.str32, i64 0, i64 0
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
  %t21 = icmp ne i64 %t20, 0
  br i1 %t21, label %L4, label %L5
L4:
  br label %L6
L5:
  %t22 = call i8 @cur(ptr %t0)
  %t23 = sext i8 %t22 to i64
  %t25 = sext i32 46 to i64
  %t24 = icmp eq i64 %t23, %t25
  %t26 = zext i1 %t24 to i64
  %t27 = icmp ne i64 %t26, 0
  br i1 %t27, label %L7, label %L8
L7:
  %t28 = call i8 @peek1(ptr %t0)
  %t29 = sext i8 %t28 to i64
  %t30 = add i64 %t29, 0
  %t31 = call i32 @isdigit(i64 %t30)
  %t32 = sext i32 %t31 to i64
  %t33 = icmp ne i64 %t32, 0
  %t34 = zext i1 %t33 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t35 = phi i64 [ %t34, %L7 ], [ 0, %L8 ]
  %t36 = icmp ne i64 %t35, 0
  %t37 = zext i1 %t36 to i64
  br label %L6
L6:
  %t38 = phi i64 [ 1, %L4 ], [ %t37, %L5 ]
  %t39 = icmp ne i64 %t38, 0
  br i1 %t39, label %L10, label %L12
L10:
  %t40 = alloca i64
  %t41 = load ptr, ptr %t0
  store ptr %t41, ptr %t40
  %t42 = alloca i64
  %t43 = sext i32 0 to i64
  store i64 %t43, ptr %t42
  %t44 = call i8 @cur(ptr %t0)
  %t45 = sext i8 %t44 to i64
  %t47 = sext i32 48 to i64
  %t46 = icmp eq i64 %t45, %t47
  %t48 = zext i1 %t46 to i64
  %t49 = icmp ne i64 %t48, 0
  br i1 %t49, label %L13, label %L14
L13:
  %t50 = call i8 @peek1(ptr %t0)
  %t51 = sext i8 %t50 to i64
  %t53 = sext i32 120 to i64
  %t52 = icmp eq i64 %t51, %t53
  %t54 = zext i1 %t52 to i64
  %t55 = icmp ne i64 %t54, 0
  br i1 %t55, label %L16, label %L17
L16:
  br label %L18
L17:
  %t56 = call i8 @peek1(ptr %t0)
  %t57 = sext i8 %t56 to i64
  %t59 = sext i32 88 to i64
  %t58 = icmp eq i64 %t57, %t59
  %t60 = zext i1 %t58 to i64
  %t61 = icmp ne i64 %t60, 0
  %t62 = zext i1 %t61 to i64
  br label %L18
L18:
  %t63 = phi i64 [ 1, %L16 ], [ %t62, %L17 ]
  %t64 = icmp ne i64 %t63, 0
  %t65 = zext i1 %t64 to i64
  br label %L15
L14:
  br label %L15
L15:
  %t66 = phi i64 [ %t65, %L13 ], [ 0, %L14 ]
  %t67 = icmp ne i64 %t66, 0
  br i1 %t67, label %L19, label %L20
L19:
  %t68 = call i8 @advance(ptr %t0)
  %t69 = sext i8 %t68 to i64
  %t70 = call i8 @advance(ptr %t0)
  %t71 = sext i8 %t70 to i64
  br label %L22
L22:
  %t72 = call i8 @cur(ptr %t0)
  %t73 = sext i8 %t72 to i64
  %t74 = add i64 %t73, 0
  %t75 = call i32 @isxdigit(i64 %t74)
  %t76 = sext i32 %t75 to i64
  %t77 = icmp ne i64 %t76, 0
  br i1 %t77, label %L23, label %L24
L23:
  %t78 = call i8 @advance(ptr %t0)
  %t79 = sext i8 %t78 to i64
  br label %L22
L24:
  br label %L21
L20:
  br label %L25
L25:
  %t80 = call i8 @cur(ptr %t0)
  %t81 = sext i8 %t80 to i64
  %t82 = add i64 %t81, 0
  %t83 = call i32 @isdigit(i64 %t82)
  %t84 = sext i32 %t83 to i64
  %t85 = icmp ne i64 %t84, 0
  br i1 %t85, label %L26, label %L27
L26:
  %t86 = call i8 @advance(ptr %t0)
  %t87 = sext i8 %t86 to i64
  br label %L25
L27:
  %t88 = call i8 @cur(ptr %t0)
  %t89 = sext i8 %t88 to i64
  %t91 = sext i32 46 to i64
  %t90 = icmp eq i64 %t89, %t91
  %t92 = zext i1 %t90 to i64
  %t93 = icmp ne i64 %t92, 0
  br i1 %t93, label %L28, label %L30
L28:
  %t94 = sext i32 1 to i64
  store i64 %t94, ptr %t42
  %t95 = call i8 @advance(ptr %t0)
  %t96 = sext i8 %t95 to i64
  br label %L30
L30:
  br label %L31
L31:
  %t97 = call i8 @cur(ptr %t0)
  %t98 = sext i8 %t97 to i64
  %t99 = add i64 %t98, 0
  %t100 = call i32 @isdigit(i64 %t99)
  %t101 = sext i32 %t100 to i64
  %t102 = icmp ne i64 %t101, 0
  br i1 %t102, label %L32, label %L33
L32:
  %t103 = call i8 @advance(ptr %t0)
  %t104 = sext i8 %t103 to i64
  br label %L31
L33:
  %t105 = call i8 @cur(ptr %t0)
  %t106 = sext i8 %t105 to i64
  %t108 = sext i32 101 to i64
  %t107 = icmp eq i64 %t106, %t108
  %t109 = zext i1 %t107 to i64
  %t110 = icmp ne i64 %t109, 0
  br i1 %t110, label %L34, label %L35
L34:
  br label %L36
L35:
  %t111 = call i8 @cur(ptr %t0)
  %t112 = sext i8 %t111 to i64
  %t114 = sext i32 69 to i64
  %t113 = icmp eq i64 %t112, %t114
  %t115 = zext i1 %t113 to i64
  %t116 = icmp ne i64 %t115, 0
  %t117 = zext i1 %t116 to i64
  br label %L36
L36:
  %t118 = phi i64 [ 1, %L34 ], [ %t117, %L35 ]
  %t119 = icmp ne i64 %t118, 0
  br i1 %t119, label %L37, label %L39
L37:
  %t120 = sext i32 1 to i64
  store i64 %t120, ptr %t42
  %t121 = call i8 @advance(ptr %t0)
  %t122 = sext i8 %t121 to i64
  %t123 = call i8 @cur(ptr %t0)
  %t124 = sext i8 %t123 to i64
  %t126 = sext i32 43 to i64
  %t125 = icmp eq i64 %t124, %t126
  %t127 = zext i1 %t125 to i64
  %t128 = icmp ne i64 %t127, 0
  br i1 %t128, label %L40, label %L41
L40:
  br label %L42
L41:
  %t129 = call i8 @cur(ptr %t0)
  %t130 = sext i8 %t129 to i64
  %t132 = sext i32 45 to i64
  %t131 = icmp eq i64 %t130, %t132
  %t133 = zext i1 %t131 to i64
  %t134 = icmp ne i64 %t133, 0
  %t135 = zext i1 %t134 to i64
  br label %L42
L42:
  %t136 = phi i64 [ 1, %L40 ], [ %t135, %L41 ]
  %t137 = icmp ne i64 %t136, 0
  br i1 %t137, label %L43, label %L45
L43:
  %t138 = call i8 @advance(ptr %t0)
  %t139 = sext i8 %t138 to i64
  br label %L45
L45:
  br label %L46
L46:
  %t140 = call i8 @cur(ptr %t0)
  %t141 = sext i8 %t140 to i64
  %t142 = add i64 %t141, 0
  %t143 = call i32 @isdigit(i64 %t142)
  %t144 = sext i32 %t143 to i64
  %t145 = icmp ne i64 %t144, 0
  br i1 %t145, label %L47, label %L48
L47:
  %t146 = call i8 @advance(ptr %t0)
  %t147 = sext i8 %t146 to i64
  br label %L46
L48:
  br label %L39
L39:
  br label %L21
L21:
  br label %L49
L49:
  %t148 = call i8 @cur(ptr %t0)
  %t149 = sext i8 %t148 to i64
  %t151 = sext i32 117 to i64
  %t150 = icmp eq i64 %t149, %t151
  %t152 = zext i1 %t150 to i64
  %t153 = icmp ne i64 %t152, 0
  br i1 %t153, label %L52, label %L53
L52:
  br label %L54
L53:
  %t154 = call i8 @cur(ptr %t0)
  %t155 = sext i8 %t154 to i64
  %t157 = sext i32 85 to i64
  %t156 = icmp eq i64 %t155, %t157
  %t158 = zext i1 %t156 to i64
  %t159 = icmp ne i64 %t158, 0
  %t160 = zext i1 %t159 to i64
  br label %L54
L54:
  %t161 = phi i64 [ 1, %L52 ], [ %t160, %L53 ]
  %t162 = icmp ne i64 %t161, 0
  br i1 %t162, label %L55, label %L56
L55:
  br label %L57
L56:
  %t163 = call i8 @cur(ptr %t0)
  %t164 = sext i8 %t163 to i64
  %t166 = sext i32 108 to i64
  %t165 = icmp eq i64 %t164, %t166
  %t167 = zext i1 %t165 to i64
  %t168 = icmp ne i64 %t167, 0
  %t169 = zext i1 %t168 to i64
  br label %L57
L57:
  %t170 = phi i64 [ 1, %L55 ], [ %t169, %L56 ]
  %t171 = icmp ne i64 %t170, 0
  br i1 %t171, label %L58, label %L59
L58:
  br label %L60
L59:
  %t172 = call i8 @cur(ptr %t0)
  %t173 = sext i8 %t172 to i64
  %t175 = sext i32 76 to i64
  %t174 = icmp eq i64 %t173, %t175
  %t176 = zext i1 %t174 to i64
  %t177 = icmp ne i64 %t176, 0
  %t178 = zext i1 %t177 to i64
  br label %L60
L60:
  %t179 = phi i64 [ 1, %L58 ], [ %t178, %L59 ]
  %t180 = icmp ne i64 %t179, 0
  br i1 %t180, label %L61, label %L62
L61:
  br label %L63
L62:
  %t181 = call i8 @cur(ptr %t0)
  %t182 = sext i8 %t181 to i64
  %t184 = sext i32 102 to i64
  %t183 = icmp eq i64 %t182, %t184
  %t185 = zext i1 %t183 to i64
  %t186 = icmp ne i64 %t185, 0
  %t187 = zext i1 %t186 to i64
  br label %L63
L63:
  %t188 = phi i64 [ 1, %L61 ], [ %t187, %L62 ]
  %t189 = icmp ne i64 %t188, 0
  br i1 %t189, label %L64, label %L65
L64:
  br label %L66
L65:
  %t190 = call i8 @cur(ptr %t0)
  %t191 = sext i8 %t190 to i64
  %t193 = sext i32 70 to i64
  %t192 = icmp eq i64 %t191, %t193
  %t194 = zext i1 %t192 to i64
  %t195 = icmp ne i64 %t194, 0
  %t196 = zext i1 %t195 to i64
  br label %L66
L66:
  %t197 = phi i64 [ 1, %L64 ], [ %t196, %L65 ]
  %t198 = icmp ne i64 %t197, 0
  br i1 %t198, label %L50, label %L51
L50:
  %t199 = call i8 @advance(ptr %t0)
  %t200 = sext i8 %t199 to i64
  br label %L49
L51:
  %t201 = load i64, ptr %t42
  %t202 = icmp ne i64 %t201, 0
  br i1 %t202, label %L67, label %L68
L67:
  %t203 = sext i32 1 to i64
  br label %L69
L68:
  %t204 = sext i32 0 to i64
  br label %L69
L69:
  %t205 = phi i64 [ %t203, %L67 ], [ %t204, %L68 ]
  store i64 %t205, ptr %t2
  %t206 = load ptr, ptr %t0
  %t207 = load i64, ptr %t40
  %t209 = ptrtoint ptr %t206 to i64
  %t210 = inttoptr i64 %t209 to ptr
  %t208 = getelementptr i8, ptr %t210, i64 %t207
  %t211 = load ptr, ptr %t0
  %t212 = load i64, ptr %t40
  %t214 = ptrtoint ptr %t211 to i64
  %t213 = sub i64 %t214, %t212
  %t215 = call ptr @strndup_local(ptr %t208, i64 %t213)
  store ptr %t215, ptr %t2
  %t216 = load i64, ptr %t2
  ret i64 %t216
L70:
  br label %L12
L12:
  %t217 = call i8 @cur(ptr %t0)
  %t218 = sext i8 %t217 to i64
  %t220 = sext i32 39 to i64
  %t219 = icmp eq i64 %t218, %t220
  %t221 = zext i1 %t219 to i64
  %t222 = icmp ne i64 %t221, 0
  br i1 %t222, label %L71, label %L73
L71:
  %t223 = alloca i64
  %t224 = load ptr, ptr %t0
  store ptr %t224, ptr %t223
  %t225 = call i8 @advance(ptr %t0)
  %t226 = sext i8 %t225 to i64
  %t227 = call i8 @cur(ptr %t0)
  %t228 = sext i8 %t227 to i64
  %t230 = sext i32 92 to i64
  %t229 = icmp eq i64 %t228, %t230
  %t231 = zext i1 %t229 to i64
  %t232 = icmp ne i64 %t231, 0
  br i1 %t232, label %L74, label %L75
L74:
  %t233 = call i8 @advance(ptr %t0)
  %t234 = sext i8 %t233 to i64
  %t235 = call i8 @advance(ptr %t0)
  %t236 = sext i8 %t235 to i64
  br label %L76
L75:
  %t237 = call i8 @advance(ptr %t0)
  %t238 = sext i8 %t237 to i64
  br label %L76
L76:
  %t239 = call i8 @cur(ptr %t0)
  %t240 = sext i8 %t239 to i64
  %t242 = sext i32 39 to i64
  %t241 = icmp eq i64 %t240, %t242
  %t243 = zext i1 %t241 to i64
  %t244 = icmp ne i64 %t243, 0
  br i1 %t244, label %L77, label %L79
L77:
  %t245 = call i8 @advance(ptr %t0)
  %t246 = sext i8 %t245 to i64
  br label %L79
L79:
  %t247 = sext i32 2 to i64
  store i64 %t247, ptr %t2
  %t248 = load ptr, ptr %t0
  %t249 = load i64, ptr %t223
  %t251 = ptrtoint ptr %t248 to i64
  %t252 = inttoptr i64 %t251 to ptr
  %t250 = getelementptr i8, ptr %t252, i64 %t249
  %t253 = load ptr, ptr %t0
  %t254 = load i64, ptr %t223
  %t256 = ptrtoint ptr %t253 to i64
  %t255 = sub i64 %t256, %t254
  %t257 = call ptr @strndup_local(ptr %t250, i64 %t255)
  store ptr %t257, ptr %t2
  %t258 = load i64, ptr %t2
  ret i64 %t258
L80:
  br label %L73
L73:
  %t259 = call i8 @cur(ptr %t0)
  %t260 = sext i8 %t259 to i64
  %t262 = sext i32 34 to i64
  %t261 = icmp eq i64 %t260, %t262
  %t263 = zext i1 %t261 to i64
  %t264 = icmp ne i64 %t263, 0
  br i1 %t264, label %L81, label %L83
L81:
  %t265 = alloca i64
  %t266 = load ptr, ptr %t0
  store ptr %t266, ptr %t265
  %t267 = call i8 @advance(ptr %t0)
  %t268 = sext i8 %t267 to i64
  br label %L84
L84:
  %t269 = call i8 @cur(ptr %t0)
  %t270 = sext i8 %t269 to i64
  %t271 = icmp ne i64 %t270, 0
  br i1 %t271, label %L87, label %L88
L87:
  %t272 = call i8 @cur(ptr %t0)
  %t273 = sext i8 %t272 to i64
  %t275 = sext i32 34 to i64
  %t274 = icmp ne i64 %t273, %t275
  %t276 = zext i1 %t274 to i64
  %t277 = icmp ne i64 %t276, 0
  %t278 = zext i1 %t277 to i64
  br label %L89
L88:
  br label %L89
L89:
  %t279 = phi i64 [ %t278, %L87 ], [ 0, %L88 ]
  %t280 = icmp ne i64 %t279, 0
  br i1 %t280, label %L85, label %L86
L85:
  %t281 = call i8 @cur(ptr %t0)
  %t282 = sext i8 %t281 to i64
  %t284 = sext i32 92 to i64
  %t283 = icmp eq i64 %t282, %t284
  %t285 = zext i1 %t283 to i64
  %t286 = icmp ne i64 %t285, 0
  br i1 %t286, label %L90, label %L92
L90:
  %t287 = call i8 @advance(ptr %t0)
  %t288 = sext i8 %t287 to i64
  br label %L92
L92:
  %t289 = call i8 @cur(ptr %t0)
  %t290 = sext i8 %t289 to i64
  %t291 = icmp ne i64 %t290, 0
  br i1 %t291, label %L93, label %L95
L93:
  %t292 = call i8 @advance(ptr %t0)
  %t293 = sext i8 %t292 to i64
  br label %L95
L95:
  br label %L84
L86:
  %t294 = call i8 @cur(ptr %t0)
  %t295 = sext i8 %t294 to i64
  %t297 = sext i32 34 to i64
  %t296 = icmp eq i64 %t295, %t297
  %t298 = zext i1 %t296 to i64
  %t299 = icmp ne i64 %t298, 0
  br i1 %t299, label %L96, label %L98
L96:
  %t300 = call i8 @advance(ptr %t0)
  %t301 = sext i8 %t300 to i64
  br label %L98
L98:
  %t302 = sext i32 3 to i64
  store i64 %t302, ptr %t2
  %t303 = load ptr, ptr %t0
  %t304 = load i64, ptr %t265
  %t306 = ptrtoint ptr %t303 to i64
  %t307 = inttoptr i64 %t306 to ptr
  %t305 = getelementptr i8, ptr %t307, i64 %t304
  %t308 = load ptr, ptr %t0
  %t309 = load i64, ptr %t265
  %t311 = ptrtoint ptr %t308 to i64
  %t310 = sub i64 %t311, %t309
  %t312 = call ptr @strndup_local(ptr %t305, i64 %t310)
  store ptr %t312, ptr %t2
  %t313 = load i64, ptr %t2
  ret i64 %t313
L99:
  br label %L83
L83:
  %t314 = call i8 @cur(ptr %t0)
  %t315 = sext i8 %t314 to i64
  %t316 = add i64 %t315, 0
  %t317 = call i32 @isalpha(i64 %t316)
  %t318 = sext i32 %t317 to i64
  %t319 = icmp ne i64 %t318, 0
  br i1 %t319, label %L100, label %L101
L100:
  br label %L102
L101:
  %t320 = call i8 @cur(ptr %t0)
  %t321 = sext i8 %t320 to i64
  %t323 = sext i32 95 to i64
  %t322 = icmp eq i64 %t321, %t323
  %t324 = zext i1 %t322 to i64
  %t325 = icmp ne i64 %t324, 0
  %t326 = zext i1 %t325 to i64
  br label %L102
L102:
  %t327 = phi i64 [ 1, %L100 ], [ %t326, %L101 ]
  %t328 = icmp ne i64 %t327, 0
  br i1 %t328, label %L103, label %L105
L103:
  %t329 = alloca i64
  %t330 = load ptr, ptr %t0
  store ptr %t330, ptr %t329
  br label %L106
L106:
  %t331 = call i8 @cur(ptr %t0)
  %t332 = sext i8 %t331 to i64
  %t333 = add i64 %t332, 0
  %t334 = call i32 @isalnum(i64 %t333)
  %t335 = sext i32 %t334 to i64
  %t336 = icmp ne i64 %t335, 0
  br i1 %t336, label %L109, label %L110
L109:
  br label %L111
L110:
  %t337 = call i8 @cur(ptr %t0)
  %t338 = sext i8 %t337 to i64
  %t340 = sext i32 95 to i64
  %t339 = icmp eq i64 %t338, %t340
  %t341 = zext i1 %t339 to i64
  %t342 = icmp ne i64 %t341, 0
  %t343 = zext i1 %t342 to i64
  br label %L111
L111:
  %t344 = phi i64 [ 1, %L109 ], [ %t343, %L110 ]
  %t345 = icmp ne i64 %t344, 0
  br i1 %t345, label %L107, label %L108
L107:
  %t346 = call i8 @advance(ptr %t0)
  %t347 = sext i8 %t346 to i64
  br label %L106
L108:
  %t348 = load ptr, ptr %t0
  %t349 = load i64, ptr %t329
  %t351 = ptrtoint ptr %t348 to i64
  %t352 = inttoptr i64 %t351 to ptr
  %t350 = getelementptr i8, ptr %t352, i64 %t349
  %t353 = load ptr, ptr %t0
  %t354 = load i64, ptr %t329
  %t356 = ptrtoint ptr %t353 to i64
  %t355 = sub i64 %t356, %t354
  %t357 = call ptr @strndup_local(ptr %t350, i64 %t355)
  store ptr %t357, ptr %t2
  %t358 = load ptr, ptr %t2
  %t359 = call i64 @keyword_lookup(ptr %t358)
  store i64 %t359, ptr %t2
  %t360 = load i64, ptr %t2
  ret i64 %t360
L112:
  br label %L105
L105:
  %t361 = alloca i64
  %t362 = call i8 @advance(ptr %t0)
  %t363 = sext i8 %t362 to i64
  store i64 %t363, ptr %t361
  %t364 = alloca i64
  %t365 = call i8 @cur(ptr %t0)
  %t366 = sext i8 %t365 to i64
  store i64 %t366, ptr %t364
  %t367 = load i64, ptr %t361
  %t368 = add i64 %t367, 0
  switch i64 %t368, label %L138 [
    i64 43, label %L114
    i64 45, label %L115
    i64 42, label %L116
    i64 47, label %L117
    i64 37, label %L118
    i64 38, label %L119
    i64 124, label %L120
    i64 94, label %L121
    i64 126, label %L122
    i64 60, label %L123
    i64 62, label %L124
    i64 61, label %L125
    i64 33, label %L126
    i64 46, label %L127
    i64 40, label %L128
    i64 41, label %L129
    i64 123, label %L130
    i64 125, label %L131
    i64 91, label %L132
    i64 93, label %L133
    i64 59, label %L134
    i64 44, label %L135
    i64 63, label %L136
    i64 58, label %L137
  ]
L114:
  %t369 = load i64, ptr %t364
  %t371 = sext i32 43 to i64
  %t370 = icmp eq i64 %t369, %t371
  %t372 = zext i1 %t370 to i64
  %t373 = icmp ne i64 %t372, 0
  br i1 %t373, label %L139, label %L141
L139:
  br label %L142
L142:
  %t374 = call i8 @advance(ptr %t0)
  %t375 = sext i8 %t374 to i64
  br label %L145
L145:
  %t376 = sext i32 66 to i64
  store i64 %t376, ptr %t2
  %t377 = getelementptr [3 x i8], ptr @.str33, i64 0, i64 0
  %t378 = call ptr @strdup(ptr %t377)
  store ptr %t378, ptr %t2
  %t379 = load i64, ptr %t2
  ret i64 %t379
L148:
  br label %L146
L146:
  %t381 = sext i32 0 to i64
  %t380 = icmp ne i64 %t381, 0
  br i1 %t380, label %L145, label %L147
L147:
  br label %L143
L143:
  %t383 = sext i32 0 to i64
  %t382 = icmp ne i64 %t383, 0
  br i1 %t382, label %L142, label %L144
L144:
  br label %L141
L141:
  %t384 = load i64, ptr %t364
  %t386 = sext i32 61 to i64
  %t385 = icmp eq i64 %t384, %t386
  %t387 = zext i1 %t385 to i64
  %t388 = icmp ne i64 %t387, 0
  br i1 %t388, label %L149, label %L151
L149:
  br label %L152
L152:
  %t389 = call i8 @advance(ptr %t0)
  %t390 = sext i8 %t389 to i64
  br label %L155
L155:
  %t391 = sext i32 56 to i64
  store i64 %t391, ptr %t2
  %t392 = getelementptr [3 x i8], ptr @.str34, i64 0, i64 0
  %t393 = call ptr @strdup(ptr %t392)
  store ptr %t393, ptr %t2
  %t394 = load i64, ptr %t2
  ret i64 %t394
L158:
  br label %L156
L156:
  %t396 = sext i32 0 to i64
  %t395 = icmp ne i64 %t396, 0
  br i1 %t395, label %L155, label %L157
L157:
  br label %L153
L153:
  %t398 = sext i32 0 to i64
  %t397 = icmp ne i64 %t398, 0
  br i1 %t397, label %L152, label %L154
L154:
  br label %L151
L151:
  br label %L159
L159:
  %t399 = sext i32 35 to i64
  store i64 %t399, ptr %t2
  %t400 = getelementptr [2 x i8], ptr @.str35, i64 0, i64 0
  %t401 = call ptr @strdup(ptr %t400)
  store ptr %t401, ptr %t2
  %t402 = load i64, ptr %t2
  ret i64 %t402
L162:
  br label %L160
L160:
  %t404 = sext i32 0 to i64
  %t403 = icmp ne i64 %t404, 0
  br i1 %t403, label %L159, label %L161
L161:
  br label %L115
L115:
  %t405 = load i64, ptr %t364
  %t407 = sext i32 45 to i64
  %t406 = icmp eq i64 %t405, %t407
  %t408 = zext i1 %t406 to i64
  %t409 = icmp ne i64 %t408, 0
  br i1 %t409, label %L163, label %L165
L163:
  br label %L166
L166:
  %t410 = call i8 @advance(ptr %t0)
  %t411 = sext i8 %t410 to i64
  br label %L169
L169:
  %t412 = sext i32 67 to i64
  store i64 %t412, ptr %t2
  %t413 = getelementptr [3 x i8], ptr @.str36, i64 0, i64 0
  %t414 = call ptr @strdup(ptr %t413)
  store ptr %t414, ptr %t2
  %t415 = load i64, ptr %t2
  ret i64 %t415
L172:
  br label %L170
L170:
  %t417 = sext i32 0 to i64
  %t416 = icmp ne i64 %t417, 0
  br i1 %t416, label %L169, label %L171
L171:
  br label %L167
L167:
  %t419 = sext i32 0 to i64
  %t418 = icmp ne i64 %t419, 0
  br i1 %t418, label %L166, label %L168
L168:
  br label %L165
L165:
  %t420 = load i64, ptr %t364
  %t422 = sext i32 61 to i64
  %t421 = icmp eq i64 %t420, %t422
  %t423 = zext i1 %t421 to i64
  %t424 = icmp ne i64 %t423, 0
  br i1 %t424, label %L173, label %L175
L173:
  br label %L176
L176:
  %t425 = call i8 @advance(ptr %t0)
  %t426 = sext i8 %t425 to i64
  br label %L179
L179:
  %t427 = sext i32 57 to i64
  store i64 %t427, ptr %t2
  %t428 = getelementptr [3 x i8], ptr @.str37, i64 0, i64 0
  %t429 = call ptr @strdup(ptr %t428)
  store ptr %t429, ptr %t2
  %t430 = load i64, ptr %t2
  ret i64 %t430
L182:
  br label %L180
L180:
  %t432 = sext i32 0 to i64
  %t431 = icmp ne i64 %t432, 0
  br i1 %t431, label %L179, label %L181
L181:
  br label %L177
L177:
  %t434 = sext i32 0 to i64
  %t433 = icmp ne i64 %t434, 0
  br i1 %t433, label %L176, label %L178
L178:
  br label %L175
L175:
  %t435 = load i64, ptr %t364
  %t437 = sext i32 62 to i64
  %t436 = icmp eq i64 %t435, %t437
  %t438 = zext i1 %t436 to i64
  %t439 = icmp ne i64 %t438, 0
  br i1 %t439, label %L183, label %L185
L183:
  br label %L186
L186:
  %t440 = call i8 @advance(ptr %t0)
  %t441 = sext i8 %t440 to i64
  br label %L189
L189:
  %t442 = sext i32 68 to i64
  store i64 %t442, ptr %t2
  %t443 = getelementptr [3 x i8], ptr @.str38, i64 0, i64 0
  %t444 = call ptr @strdup(ptr %t443)
  store ptr %t444, ptr %t2
  %t445 = load i64, ptr %t2
  ret i64 %t445
L192:
  br label %L190
L190:
  %t447 = sext i32 0 to i64
  %t446 = icmp ne i64 %t447, 0
  br i1 %t446, label %L189, label %L191
L191:
  br label %L187
L187:
  %t449 = sext i32 0 to i64
  %t448 = icmp ne i64 %t449, 0
  br i1 %t448, label %L186, label %L188
L188:
  br label %L185
L185:
  br label %L193
L193:
  %t450 = sext i32 36 to i64
  store i64 %t450, ptr %t2
  %t451 = getelementptr [2 x i8], ptr @.str39, i64 0, i64 0
  %t452 = call ptr @strdup(ptr %t451)
  store ptr %t452, ptr %t2
  %t453 = load i64, ptr %t2
  ret i64 %t453
L196:
  br label %L194
L194:
  %t455 = sext i32 0 to i64
  %t454 = icmp ne i64 %t455, 0
  br i1 %t454, label %L193, label %L195
L195:
  br label %L116
L116:
  %t456 = load i64, ptr %t364
  %t458 = sext i32 61 to i64
  %t457 = icmp eq i64 %t456, %t458
  %t459 = zext i1 %t457 to i64
  %t460 = icmp ne i64 %t459, 0
  br i1 %t460, label %L197, label %L199
L197:
  br label %L200
L200:
  %t461 = call i8 @advance(ptr %t0)
  %t462 = sext i8 %t461 to i64
  br label %L203
L203:
  %t463 = sext i32 58 to i64
  store i64 %t463, ptr %t2
  %t464 = getelementptr [3 x i8], ptr @.str40, i64 0, i64 0
  %t465 = call ptr @strdup(ptr %t464)
  store ptr %t465, ptr %t2
  %t466 = load i64, ptr %t2
  ret i64 %t466
L206:
  br label %L204
L204:
  %t468 = sext i32 0 to i64
  %t467 = icmp ne i64 %t468, 0
  br i1 %t467, label %L203, label %L205
L205:
  br label %L201
L201:
  %t470 = sext i32 0 to i64
  %t469 = icmp ne i64 %t470, 0
  br i1 %t469, label %L200, label %L202
L202:
  br label %L199
L199:
  br label %L207
L207:
  %t471 = sext i32 37 to i64
  store i64 %t471, ptr %t2
  %t472 = getelementptr [2 x i8], ptr @.str41, i64 0, i64 0
  %t473 = call ptr @strdup(ptr %t472)
  store ptr %t473, ptr %t2
  %t474 = load i64, ptr %t2
  ret i64 %t474
L210:
  br label %L208
L208:
  %t476 = sext i32 0 to i64
  %t475 = icmp ne i64 %t476, 0
  br i1 %t475, label %L207, label %L209
L209:
  br label %L117
L117:
  %t477 = load i64, ptr %t364
  %t479 = sext i32 61 to i64
  %t478 = icmp eq i64 %t477, %t479
  %t480 = zext i1 %t478 to i64
  %t481 = icmp ne i64 %t480, 0
  br i1 %t481, label %L211, label %L213
L211:
  br label %L214
L214:
  %t482 = call i8 @advance(ptr %t0)
  %t483 = sext i8 %t482 to i64
  br label %L217
L217:
  %t484 = sext i32 59 to i64
  store i64 %t484, ptr %t2
  %t485 = getelementptr [3 x i8], ptr @.str42, i64 0, i64 0
  %t486 = call ptr @strdup(ptr %t485)
  store ptr %t486, ptr %t2
  %t487 = load i64, ptr %t2
  ret i64 %t487
L220:
  br label %L218
L218:
  %t489 = sext i32 0 to i64
  %t488 = icmp ne i64 %t489, 0
  br i1 %t488, label %L217, label %L219
L219:
  br label %L215
L215:
  %t491 = sext i32 0 to i64
  %t490 = icmp ne i64 %t491, 0
  br i1 %t490, label %L214, label %L216
L216:
  br label %L213
L213:
  br label %L221
L221:
  %t492 = sext i32 38 to i64
  store i64 %t492, ptr %t2
  %t493 = getelementptr [2 x i8], ptr @.str43, i64 0, i64 0
  %t494 = call ptr @strdup(ptr %t493)
  store ptr %t494, ptr %t2
  %t495 = load i64, ptr %t2
  ret i64 %t495
L224:
  br label %L222
L222:
  %t497 = sext i32 0 to i64
  %t496 = icmp ne i64 %t497, 0
  br i1 %t496, label %L221, label %L223
L223:
  br label %L118
L118:
  %t498 = load i64, ptr %t364
  %t500 = sext i32 61 to i64
  %t499 = icmp eq i64 %t498, %t500
  %t501 = zext i1 %t499 to i64
  %t502 = icmp ne i64 %t501, 0
  br i1 %t502, label %L225, label %L227
L225:
  br label %L228
L228:
  %t503 = call i8 @advance(ptr %t0)
  %t504 = sext i8 %t503 to i64
  br label %L231
L231:
  %t505 = sext i32 65 to i64
  store i64 %t505, ptr %t2
  %t506 = getelementptr [3 x i8], ptr @.str44, i64 0, i64 0
  %t507 = call ptr @strdup(ptr %t506)
  store ptr %t507, ptr %t2
  %t508 = load i64, ptr %t2
  ret i64 %t508
L234:
  br label %L232
L232:
  %t510 = sext i32 0 to i64
  %t509 = icmp ne i64 %t510, 0
  br i1 %t509, label %L231, label %L233
L233:
  br label %L229
L229:
  %t512 = sext i32 0 to i64
  %t511 = icmp ne i64 %t512, 0
  br i1 %t511, label %L228, label %L230
L230:
  br label %L227
L227:
  br label %L235
L235:
  %t513 = sext i32 39 to i64
  store i64 %t513, ptr %t2
  %t514 = getelementptr [2 x i8], ptr @.str45, i64 0, i64 0
  %t515 = call ptr @strdup(ptr %t514)
  store ptr %t515, ptr %t2
  %t516 = load i64, ptr %t2
  ret i64 %t516
L238:
  br label %L236
L236:
  %t518 = sext i32 0 to i64
  %t517 = icmp ne i64 %t518, 0
  br i1 %t517, label %L235, label %L237
L237:
  br label %L119
L119:
  %t519 = load i64, ptr %t364
  %t521 = sext i32 38 to i64
  %t520 = icmp eq i64 %t519, %t521
  %t522 = zext i1 %t520 to i64
  %t523 = icmp ne i64 %t522, 0
  br i1 %t523, label %L239, label %L241
L239:
  br label %L242
L242:
  %t524 = call i8 @advance(ptr %t0)
  %t525 = sext i8 %t524 to i64
  br label %L245
L245:
  %t526 = sext i32 52 to i64
  store i64 %t526, ptr %t2
  %t527 = getelementptr [3 x i8], ptr @.str46, i64 0, i64 0
  %t528 = call ptr @strdup(ptr %t527)
  store ptr %t528, ptr %t2
  %t529 = load i64, ptr %t2
  ret i64 %t529
L248:
  br label %L246
L246:
  %t531 = sext i32 0 to i64
  %t530 = icmp ne i64 %t531, 0
  br i1 %t530, label %L245, label %L247
L247:
  br label %L243
L243:
  %t533 = sext i32 0 to i64
  %t532 = icmp ne i64 %t533, 0
  br i1 %t532, label %L242, label %L244
L244:
  br label %L241
L241:
  %t534 = load i64, ptr %t364
  %t536 = sext i32 61 to i64
  %t535 = icmp eq i64 %t534, %t536
  %t537 = zext i1 %t535 to i64
  %t538 = icmp ne i64 %t537, 0
  br i1 %t538, label %L249, label %L251
L249:
  br label %L252
L252:
  %t539 = call i8 @advance(ptr %t0)
  %t540 = sext i8 %t539 to i64
  br label %L255
L255:
  %t541 = sext i32 60 to i64
  store i64 %t541, ptr %t2
  %t542 = getelementptr [3 x i8], ptr @.str47, i64 0, i64 0
  %t543 = call ptr @strdup(ptr %t542)
  store ptr %t543, ptr %t2
  %t544 = load i64, ptr %t2
  ret i64 %t544
L258:
  br label %L256
L256:
  %t546 = sext i32 0 to i64
  %t545 = icmp ne i64 %t546, 0
  br i1 %t545, label %L255, label %L257
L257:
  br label %L253
L253:
  %t548 = sext i32 0 to i64
  %t547 = icmp ne i64 %t548, 0
  br i1 %t547, label %L252, label %L254
L254:
  br label %L251
L251:
  br label %L259
L259:
  %t549 = sext i32 40 to i64
  store i64 %t549, ptr %t2
  %t550 = getelementptr [2 x i8], ptr @.str48, i64 0, i64 0
  %t551 = call ptr @strdup(ptr %t550)
  store ptr %t551, ptr %t2
  %t552 = load i64, ptr %t2
  ret i64 %t552
L262:
  br label %L260
L260:
  %t554 = sext i32 0 to i64
  %t553 = icmp ne i64 %t554, 0
  br i1 %t553, label %L259, label %L261
L261:
  br label %L120
L120:
  %t555 = load i64, ptr %t364
  %t557 = sext i32 124 to i64
  %t556 = icmp eq i64 %t555, %t557
  %t558 = zext i1 %t556 to i64
  %t559 = icmp ne i64 %t558, 0
  br i1 %t559, label %L263, label %L265
L263:
  br label %L266
L266:
  %t560 = call i8 @advance(ptr %t0)
  %t561 = sext i8 %t560 to i64
  br label %L269
L269:
  %t562 = sext i32 53 to i64
  store i64 %t562, ptr %t2
  %t563 = getelementptr [3 x i8], ptr @.str49, i64 0, i64 0
  %t564 = call ptr @strdup(ptr %t563)
  store ptr %t564, ptr %t2
  %t565 = load i64, ptr %t2
  ret i64 %t565
L272:
  br label %L270
L270:
  %t567 = sext i32 0 to i64
  %t566 = icmp ne i64 %t567, 0
  br i1 %t566, label %L269, label %L271
L271:
  br label %L267
L267:
  %t569 = sext i32 0 to i64
  %t568 = icmp ne i64 %t569, 0
  br i1 %t568, label %L266, label %L268
L268:
  br label %L265
L265:
  %t570 = load i64, ptr %t364
  %t572 = sext i32 61 to i64
  %t571 = icmp eq i64 %t570, %t572
  %t573 = zext i1 %t571 to i64
  %t574 = icmp ne i64 %t573, 0
  br i1 %t574, label %L273, label %L275
L273:
  br label %L276
L276:
  %t575 = call i8 @advance(ptr %t0)
  %t576 = sext i8 %t575 to i64
  br label %L279
L279:
  %t577 = sext i32 61 to i64
  store i64 %t577, ptr %t2
  %t578 = getelementptr [3 x i8], ptr @.str50, i64 0, i64 0
  %t579 = call ptr @strdup(ptr %t578)
  store ptr %t579, ptr %t2
  %t580 = load i64, ptr %t2
  ret i64 %t580
L282:
  br label %L280
L280:
  %t582 = sext i32 0 to i64
  %t581 = icmp ne i64 %t582, 0
  br i1 %t581, label %L279, label %L281
L281:
  br label %L277
L277:
  %t584 = sext i32 0 to i64
  %t583 = icmp ne i64 %t584, 0
  br i1 %t583, label %L276, label %L278
L278:
  br label %L275
L275:
  br label %L283
L283:
  %t585 = sext i32 41 to i64
  store i64 %t585, ptr %t2
  %t586 = getelementptr [2 x i8], ptr @.str51, i64 0, i64 0
  %t587 = call ptr @strdup(ptr %t586)
  store ptr %t587, ptr %t2
  %t588 = load i64, ptr %t2
  ret i64 %t588
L286:
  br label %L284
L284:
  %t590 = sext i32 0 to i64
  %t589 = icmp ne i64 %t590, 0
  br i1 %t589, label %L283, label %L285
L285:
  br label %L121
L121:
  %t591 = load i64, ptr %t364
  %t593 = sext i32 61 to i64
  %t592 = icmp eq i64 %t591, %t593
  %t594 = zext i1 %t592 to i64
  %t595 = icmp ne i64 %t594, 0
  br i1 %t595, label %L287, label %L289
L287:
  br label %L290
L290:
  %t596 = call i8 @advance(ptr %t0)
  %t597 = sext i8 %t596 to i64
  br label %L293
L293:
  %t598 = sext i32 62 to i64
  store i64 %t598, ptr %t2
  %t599 = getelementptr [3 x i8], ptr @.str52, i64 0, i64 0
  %t600 = call ptr @strdup(ptr %t599)
  store ptr %t600, ptr %t2
  %t601 = load i64, ptr %t2
  ret i64 %t601
L296:
  br label %L294
L294:
  %t603 = sext i32 0 to i64
  %t602 = icmp ne i64 %t603, 0
  br i1 %t602, label %L293, label %L295
L295:
  br label %L291
L291:
  %t605 = sext i32 0 to i64
  %t604 = icmp ne i64 %t605, 0
  br i1 %t604, label %L290, label %L292
L292:
  br label %L289
L289:
  br label %L297
L297:
  %t606 = sext i32 42 to i64
  store i64 %t606, ptr %t2
  %t607 = getelementptr [2 x i8], ptr @.str53, i64 0, i64 0
  %t608 = call ptr @strdup(ptr %t607)
  store ptr %t608, ptr %t2
  %t609 = load i64, ptr %t2
  ret i64 %t609
L300:
  br label %L298
L298:
  %t611 = sext i32 0 to i64
  %t610 = icmp ne i64 %t611, 0
  br i1 %t610, label %L297, label %L299
L299:
  br label %L122
L122:
  br label %L301
L301:
  %t612 = sext i32 43 to i64
  store i64 %t612, ptr %t2
  %t613 = getelementptr [2 x i8], ptr @.str54, i64 0, i64 0
  %t614 = call ptr @strdup(ptr %t613)
  store ptr %t614, ptr %t2
  %t615 = load i64, ptr %t2
  ret i64 %t615
L304:
  br label %L302
L302:
  %t617 = sext i32 0 to i64
  %t616 = icmp ne i64 %t617, 0
  br i1 %t616, label %L301, label %L303
L303:
  br label %L123
L123:
  %t618 = load i64, ptr %t364
  %t620 = sext i32 60 to i64
  %t619 = icmp eq i64 %t618, %t620
  %t621 = zext i1 %t619 to i64
  %t622 = icmp ne i64 %t621, 0
  br i1 %t622, label %L305, label %L307
L305:
  %t623 = call i8 @advance(ptr %t0)
  %t624 = sext i8 %t623 to i64
  %t625 = call i8 @cur(ptr %t0)
  %t626 = sext i8 %t625 to i64
  %t628 = sext i32 61 to i64
  %t627 = icmp eq i64 %t626, %t628
  %t629 = zext i1 %t627 to i64
  %t630 = icmp ne i64 %t629, 0
  br i1 %t630, label %L308, label %L310
L308:
  br label %L311
L311:
  %t631 = call i8 @advance(ptr %t0)
  %t632 = sext i8 %t631 to i64
  br label %L314
L314:
  %t633 = sext i32 63 to i64
  store i64 %t633, ptr %t2
  %t634 = getelementptr [4 x i8], ptr @.str55, i64 0, i64 0
  %t635 = call ptr @strdup(ptr %t634)
  store ptr %t635, ptr %t2
  %t636 = load i64, ptr %t2
  ret i64 %t636
L317:
  br label %L315
L315:
  %t638 = sext i32 0 to i64
  %t637 = icmp ne i64 %t638, 0
  br i1 %t637, label %L314, label %L316
L316:
  br label %L312
L312:
  %t640 = sext i32 0 to i64
  %t639 = icmp ne i64 %t640, 0
  br i1 %t639, label %L311, label %L313
L313:
  br label %L310
L310:
  br label %L318
L318:
  %t641 = sext i32 44 to i64
  store i64 %t641, ptr %t2
  %t642 = getelementptr [3 x i8], ptr @.str56, i64 0, i64 0
  %t643 = call ptr @strdup(ptr %t642)
  store ptr %t643, ptr %t2
  %t644 = load i64, ptr %t2
  ret i64 %t644
L321:
  br label %L319
L319:
  %t646 = sext i32 0 to i64
  %t645 = icmp ne i64 %t646, 0
  br i1 %t645, label %L318, label %L320
L320:
  br label %L307
L307:
  %t647 = load i64, ptr %t364
  %t649 = sext i32 61 to i64
  %t648 = icmp eq i64 %t647, %t649
  %t650 = zext i1 %t648 to i64
  %t651 = icmp ne i64 %t650, 0
  br i1 %t651, label %L322, label %L324
L322:
  br label %L325
L325:
  %t652 = call i8 @advance(ptr %t0)
  %t653 = sext i8 %t652 to i64
  br label %L328
L328:
  %t654 = sext i32 50 to i64
  store i64 %t654, ptr %t2
  %t655 = getelementptr [3 x i8], ptr @.str57, i64 0, i64 0
  %t656 = call ptr @strdup(ptr %t655)
  store ptr %t656, ptr %t2
  %t657 = load i64, ptr %t2
  ret i64 %t657
L331:
  br label %L329
L329:
  %t659 = sext i32 0 to i64
  %t658 = icmp ne i64 %t659, 0
  br i1 %t658, label %L328, label %L330
L330:
  br label %L326
L326:
  %t661 = sext i32 0 to i64
  %t660 = icmp ne i64 %t661, 0
  br i1 %t660, label %L325, label %L327
L327:
  br label %L324
L324:
  br label %L332
L332:
  %t662 = sext i32 48 to i64
  store i64 %t662, ptr %t2
  %t663 = getelementptr [2 x i8], ptr @.str58, i64 0, i64 0
  %t664 = call ptr @strdup(ptr %t663)
  store ptr %t664, ptr %t2
  %t665 = load i64, ptr %t2
  ret i64 %t665
L335:
  br label %L333
L333:
  %t667 = sext i32 0 to i64
  %t666 = icmp ne i64 %t667, 0
  br i1 %t666, label %L332, label %L334
L334:
  br label %L124
L124:
  %t668 = load i64, ptr %t364
  %t670 = sext i32 62 to i64
  %t669 = icmp eq i64 %t668, %t670
  %t671 = zext i1 %t669 to i64
  %t672 = icmp ne i64 %t671, 0
  br i1 %t672, label %L336, label %L338
L336:
  %t673 = call i8 @advance(ptr %t0)
  %t674 = sext i8 %t673 to i64
  %t675 = call i8 @cur(ptr %t0)
  %t676 = sext i8 %t675 to i64
  %t678 = sext i32 61 to i64
  %t677 = icmp eq i64 %t676, %t678
  %t679 = zext i1 %t677 to i64
  %t680 = icmp ne i64 %t679, 0
  br i1 %t680, label %L339, label %L341
L339:
  br label %L342
L342:
  %t681 = call i8 @advance(ptr %t0)
  %t682 = sext i8 %t681 to i64
  br label %L345
L345:
  %t683 = sext i32 64 to i64
  store i64 %t683, ptr %t2
  %t684 = getelementptr [4 x i8], ptr @.str59, i64 0, i64 0
  %t685 = call ptr @strdup(ptr %t684)
  store ptr %t685, ptr %t2
  %t686 = load i64, ptr %t2
  ret i64 %t686
L348:
  br label %L346
L346:
  %t688 = sext i32 0 to i64
  %t687 = icmp ne i64 %t688, 0
  br i1 %t687, label %L345, label %L347
L347:
  br label %L343
L343:
  %t690 = sext i32 0 to i64
  %t689 = icmp ne i64 %t690, 0
  br i1 %t689, label %L342, label %L344
L344:
  br label %L341
L341:
  br label %L349
L349:
  %t691 = sext i32 45 to i64
  store i64 %t691, ptr %t2
  %t692 = getelementptr [3 x i8], ptr @.str60, i64 0, i64 0
  %t693 = call ptr @strdup(ptr %t692)
  store ptr %t693, ptr %t2
  %t694 = load i64, ptr %t2
  ret i64 %t694
L352:
  br label %L350
L350:
  %t696 = sext i32 0 to i64
  %t695 = icmp ne i64 %t696, 0
  br i1 %t695, label %L349, label %L351
L351:
  br label %L338
L338:
  %t697 = load i64, ptr %t364
  %t699 = sext i32 61 to i64
  %t698 = icmp eq i64 %t697, %t699
  %t700 = zext i1 %t698 to i64
  %t701 = icmp ne i64 %t700, 0
  br i1 %t701, label %L353, label %L355
L353:
  br label %L356
L356:
  %t702 = call i8 @advance(ptr %t0)
  %t703 = sext i8 %t702 to i64
  br label %L359
L359:
  %t704 = sext i32 51 to i64
  store i64 %t704, ptr %t2
  %t705 = getelementptr [3 x i8], ptr @.str61, i64 0, i64 0
  %t706 = call ptr @strdup(ptr %t705)
  store ptr %t706, ptr %t2
  %t707 = load i64, ptr %t2
  ret i64 %t707
L362:
  br label %L360
L360:
  %t709 = sext i32 0 to i64
  %t708 = icmp ne i64 %t709, 0
  br i1 %t708, label %L359, label %L361
L361:
  br label %L357
L357:
  %t711 = sext i32 0 to i64
  %t710 = icmp ne i64 %t711, 0
  br i1 %t710, label %L356, label %L358
L358:
  br label %L355
L355:
  br label %L363
L363:
  %t712 = sext i32 49 to i64
  store i64 %t712, ptr %t2
  %t713 = getelementptr [2 x i8], ptr @.str62, i64 0, i64 0
  %t714 = call ptr @strdup(ptr %t713)
  store ptr %t714, ptr %t2
  %t715 = load i64, ptr %t2
  ret i64 %t715
L366:
  br label %L364
L364:
  %t717 = sext i32 0 to i64
  %t716 = icmp ne i64 %t717, 0
  br i1 %t716, label %L363, label %L365
L365:
  br label %L125
L125:
  %t718 = load i64, ptr %t364
  %t720 = sext i32 61 to i64
  %t719 = icmp eq i64 %t718, %t720
  %t721 = zext i1 %t719 to i64
  %t722 = icmp ne i64 %t721, 0
  br i1 %t722, label %L367, label %L369
L367:
  br label %L370
L370:
  %t723 = call i8 @advance(ptr %t0)
  %t724 = sext i8 %t723 to i64
  br label %L373
L373:
  %t725 = sext i32 46 to i64
  store i64 %t725, ptr %t2
  %t726 = getelementptr [3 x i8], ptr @.str63, i64 0, i64 0
  %t727 = call ptr @strdup(ptr %t726)
  store ptr %t727, ptr %t2
  %t728 = load i64, ptr %t2
  ret i64 %t728
L376:
  br label %L374
L374:
  %t730 = sext i32 0 to i64
  %t729 = icmp ne i64 %t730, 0
  br i1 %t729, label %L373, label %L375
L375:
  br label %L371
L371:
  %t732 = sext i32 0 to i64
  %t731 = icmp ne i64 %t732, 0
  br i1 %t731, label %L370, label %L372
L372:
  br label %L369
L369:
  br label %L377
L377:
  %t733 = sext i32 55 to i64
  store i64 %t733, ptr %t2
  %t734 = getelementptr [2 x i8], ptr @.str64, i64 0, i64 0
  %t735 = call ptr @strdup(ptr %t734)
  store ptr %t735, ptr %t2
  %t736 = load i64, ptr %t2
  ret i64 %t736
L380:
  br label %L378
L378:
  %t738 = sext i32 0 to i64
  %t737 = icmp ne i64 %t738, 0
  br i1 %t737, label %L377, label %L379
L379:
  br label %L126
L126:
  %t739 = load i64, ptr %t364
  %t741 = sext i32 61 to i64
  %t740 = icmp eq i64 %t739, %t741
  %t742 = zext i1 %t740 to i64
  %t743 = icmp ne i64 %t742, 0
  br i1 %t743, label %L381, label %L383
L381:
  br label %L384
L384:
  %t744 = call i8 @advance(ptr %t0)
  %t745 = sext i8 %t744 to i64
  br label %L387
L387:
  %t746 = sext i32 47 to i64
  store i64 %t746, ptr %t2
  %t747 = getelementptr [3 x i8], ptr @.str65, i64 0, i64 0
  %t748 = call ptr @strdup(ptr %t747)
  store ptr %t748, ptr %t2
  %t749 = load i64, ptr %t2
  ret i64 %t749
L390:
  br label %L388
L388:
  %t751 = sext i32 0 to i64
  %t750 = icmp ne i64 %t751, 0
  br i1 %t750, label %L387, label %L389
L389:
  br label %L385
L385:
  %t753 = sext i32 0 to i64
  %t752 = icmp ne i64 %t753, 0
  br i1 %t752, label %L384, label %L386
L386:
  br label %L383
L383:
  br label %L391
L391:
  %t754 = sext i32 54 to i64
  store i64 %t754, ptr %t2
  %t755 = getelementptr [2 x i8], ptr @.str66, i64 0, i64 0
  %t756 = call ptr @strdup(ptr %t755)
  store ptr %t756, ptr %t2
  %t757 = load i64, ptr %t2
  ret i64 %t757
L394:
  br label %L392
L392:
  %t759 = sext i32 0 to i64
  %t758 = icmp ne i64 %t759, 0
  br i1 %t758, label %L391, label %L393
L393:
  br label %L127
L127:
  %t760 = load i64, ptr %t364
  %t762 = sext i32 46 to i64
  %t761 = icmp eq i64 %t760, %t762
  %t763 = zext i1 %t761 to i64
  %t764 = icmp ne i64 %t763, 0
  br i1 %t764, label %L395, label %L396
L395:
  %t765 = load ptr, ptr %t0
  %t766 = load ptr, ptr %t0
  %t768 = ptrtoint ptr %t766 to i64
  %t769 = sext i32 1 to i64
  %t770 = inttoptr i64 %t768 to ptr
  %t767 = getelementptr i8, ptr %t770, i64 %t769
  %t771 = ptrtoint ptr %t767 to i64
  %t772 = getelementptr ptr, ptr %t765, i64 %t771
  %t773 = load ptr, ptr %t772
  %t775 = ptrtoint ptr %t773 to i64
  %t776 = sext i32 46 to i64
  %t774 = icmp eq i64 %t775, %t776
  %t777 = zext i1 %t774 to i64
  %t778 = icmp ne i64 %t777, 0
  %t779 = zext i1 %t778 to i64
  br label %L397
L396:
  br label %L397
L397:
  %t780 = phi i64 [ %t779, %L395 ], [ 0, %L396 ]
  %t781 = icmp ne i64 %t780, 0
  br i1 %t781, label %L398, label %L400
L398:
  %t782 = call i8 @advance(ptr %t0)
  %t783 = sext i8 %t782 to i64
  %t784 = call i8 @advance(ptr %t0)
  %t785 = sext i8 %t784 to i64
  br label %L401
L401:
  %t786 = sext i32 80 to i64
  store i64 %t786, ptr %t2
  %t787 = getelementptr [4 x i8], ptr @.str67, i64 0, i64 0
  %t788 = call ptr @strdup(ptr %t787)
  store ptr %t788, ptr %t2
  %t789 = load i64, ptr %t2
  ret i64 %t789
L404:
  br label %L402
L402:
  %t791 = sext i32 0 to i64
  %t790 = icmp ne i64 %t791, 0
  br i1 %t790, label %L401, label %L403
L403:
  br label %L400
L400:
  br label %L405
L405:
  %t792 = sext i32 69 to i64
  store i64 %t792, ptr %t2
  %t793 = getelementptr [2 x i8], ptr @.str68, i64 0, i64 0
  %t794 = call ptr @strdup(ptr %t793)
  store ptr %t794, ptr %t2
  %t795 = load i64, ptr %t2
  ret i64 %t795
L408:
  br label %L406
L406:
  %t797 = sext i32 0 to i64
  %t796 = icmp ne i64 %t797, 0
  br i1 %t796, label %L405, label %L407
L407:
  br label %L128
L128:
  br label %L409
L409:
  %t798 = sext i32 72 to i64
  store i64 %t798, ptr %t2
  %t799 = getelementptr [2 x i8], ptr @.str69, i64 0, i64 0
  %t800 = call ptr @strdup(ptr %t799)
  store ptr %t800, ptr %t2
  %t801 = load i64, ptr %t2
  ret i64 %t801
L412:
  br label %L410
L410:
  %t803 = sext i32 0 to i64
  %t802 = icmp ne i64 %t803, 0
  br i1 %t802, label %L409, label %L411
L411:
  br label %L129
L129:
  br label %L413
L413:
  %t804 = sext i32 73 to i64
  store i64 %t804, ptr %t2
  %t805 = getelementptr [2 x i8], ptr @.str70, i64 0, i64 0
  %t806 = call ptr @strdup(ptr %t805)
  store ptr %t806, ptr %t2
  %t807 = load i64, ptr %t2
  ret i64 %t807
L416:
  br label %L414
L414:
  %t809 = sext i32 0 to i64
  %t808 = icmp ne i64 %t809, 0
  br i1 %t808, label %L413, label %L415
L415:
  br label %L130
L130:
  br label %L417
L417:
  %t810 = sext i32 74 to i64
  store i64 %t810, ptr %t2
  %t811 = getelementptr [2 x i8], ptr @.str71, i64 0, i64 0
  %t812 = call ptr @strdup(ptr %t811)
  store ptr %t812, ptr %t2
  %t813 = load i64, ptr %t2
  ret i64 %t813
L420:
  br label %L418
L418:
  %t815 = sext i32 0 to i64
  %t814 = icmp ne i64 %t815, 0
  br i1 %t814, label %L417, label %L419
L419:
  br label %L131
L131:
  br label %L421
L421:
  %t816 = sext i32 75 to i64
  store i64 %t816, ptr %t2
  %t817 = getelementptr [2 x i8], ptr @.str72, i64 0, i64 0
  %t818 = call ptr @strdup(ptr %t817)
  store ptr %t818, ptr %t2
  %t819 = load i64, ptr %t2
  ret i64 %t819
L424:
  br label %L422
L422:
  %t821 = sext i32 0 to i64
  %t820 = icmp ne i64 %t821, 0
  br i1 %t820, label %L421, label %L423
L423:
  br label %L132
L132:
  br label %L425
L425:
  %t822 = sext i32 76 to i64
  store i64 %t822, ptr %t2
  %t823 = getelementptr [2 x i8], ptr @.str73, i64 0, i64 0
  %t824 = call ptr @strdup(ptr %t823)
  store ptr %t824, ptr %t2
  %t825 = load i64, ptr %t2
  ret i64 %t825
L428:
  br label %L426
L426:
  %t827 = sext i32 0 to i64
  %t826 = icmp ne i64 %t827, 0
  br i1 %t826, label %L425, label %L427
L427:
  br label %L133
L133:
  br label %L429
L429:
  %t828 = sext i32 77 to i64
  store i64 %t828, ptr %t2
  %t829 = getelementptr [2 x i8], ptr @.str74, i64 0, i64 0
  %t830 = call ptr @strdup(ptr %t829)
  store ptr %t830, ptr %t2
  %t831 = load i64, ptr %t2
  ret i64 %t831
L432:
  br label %L430
L430:
  %t833 = sext i32 0 to i64
  %t832 = icmp ne i64 %t833, 0
  br i1 %t832, label %L429, label %L431
L431:
  br label %L134
L134:
  br label %L433
L433:
  %t834 = sext i32 78 to i64
  store i64 %t834, ptr %t2
  %t835 = getelementptr [2 x i8], ptr @.str75, i64 0, i64 0
  %t836 = call ptr @strdup(ptr %t835)
  store ptr %t836, ptr %t2
  %t837 = load i64, ptr %t2
  ret i64 %t837
L436:
  br label %L434
L434:
  %t839 = sext i32 0 to i64
  %t838 = icmp ne i64 %t839, 0
  br i1 %t838, label %L433, label %L435
L435:
  br label %L135
L135:
  br label %L437
L437:
  %t840 = sext i32 79 to i64
  store i64 %t840, ptr %t2
  %t841 = getelementptr [2 x i8], ptr @.str76, i64 0, i64 0
  %t842 = call ptr @strdup(ptr %t841)
  store ptr %t842, ptr %t2
  %t843 = load i64, ptr %t2
  ret i64 %t843
L440:
  br label %L438
L438:
  %t845 = sext i32 0 to i64
  %t844 = icmp ne i64 %t845, 0
  br i1 %t844, label %L437, label %L439
L439:
  br label %L136
L136:
  br label %L441
L441:
  %t846 = sext i32 70 to i64
  store i64 %t846, ptr %t2
  %t847 = getelementptr [2 x i8], ptr @.str77, i64 0, i64 0
  %t848 = call ptr @strdup(ptr %t847)
  store ptr %t848, ptr %t2
  %t849 = load i64, ptr %t2
  ret i64 %t849
L444:
  br label %L442
L442:
  %t851 = sext i32 0 to i64
  %t850 = icmp ne i64 %t851, 0
  br i1 %t850, label %L441, label %L443
L443:
  br label %L137
L137:
  br label %L445
L445:
  %t852 = sext i32 71 to i64
  store i64 %t852, ptr %t2
  %t853 = getelementptr [2 x i8], ptr @.str78, i64 0, i64 0
  %t854 = call ptr @strdup(ptr %t853)
  store ptr %t854, ptr %t2
  %t855 = load i64, ptr %t2
  ret i64 %t855
L448:
  br label %L446
L446:
  %t857 = sext i32 0 to i64
  %t856 = icmp ne i64 %t857, 0
  br i1 %t856, label %L445, label %L447
L447:
  br label %L113
L138:
  %t858 = sext i32 82 to i64
  store i64 %t858, ptr %t2
  %t859 = call ptr @malloc(i64 2)
  store ptr %t859, ptr %t2
  %t860 = load i64, ptr %t361
  %t861 = load ptr, ptr %t2
  %t863 = sext i32 0 to i64
  %t862 = getelementptr ptr, ptr %t861, i64 %t863
  store i64 %t860, ptr %t862
  %t864 = load ptr, ptr %t2
  %t866 = sext i32 1 to i64
  %t865 = getelementptr ptr, ptr %t864, i64 %t866
  %t867 = sext i32 0 to i64
  store i64 %t867, ptr %t865
  %t868 = load i64, ptr %t2
  ret i64 %t868
L449:
  br label %L113
L113:
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
  %t3 = getelementptr [12 x i8], ptr @.str79, i64 0, i64 0
  ret ptr %t3
L85:
  br label %L2
L2:
  %t4 = getelementptr [14 x i8], ptr @.str80, i64 0, i64 0
  ret ptr %t4
L86:
  br label %L3
L3:
  %t5 = getelementptr [13 x i8], ptr @.str81, i64 0, i64 0
  ret ptr %t5
L87:
  br label %L4
L4:
  %t6 = getelementptr [15 x i8], ptr @.str82, i64 0, i64 0
  ret ptr %t6
L88:
  br label %L5
L5:
  %t7 = getelementptr [10 x i8], ptr @.str83, i64 0, i64 0
  ret ptr %t7
L89:
  br label %L6
L6:
  %t8 = getelementptr [8 x i8], ptr @.str84, i64 0, i64 0
  ret ptr %t8
L90:
  br label %L7
L7:
  %t9 = getelementptr [9 x i8], ptr @.str85, i64 0, i64 0
  ret ptr %t9
L91:
  br label %L8
L8:
  %t10 = getelementptr [10 x i8], ptr @.str86, i64 0, i64 0
  ret ptr %t10
L92:
  br label %L9
L9:
  %t11 = getelementptr [11 x i8], ptr @.str87, i64 0, i64 0
  ret ptr %t11
L93:
  br label %L10
L10:
  %t12 = getelementptr [9 x i8], ptr @.str88, i64 0, i64 0
  ret ptr %t12
L94:
  br label %L11
L11:
  %t13 = getelementptr [9 x i8], ptr @.str89, i64 0, i64 0
  ret ptr %t13
L95:
  br label %L12
L12:
  %t14 = getelementptr [10 x i8], ptr @.str90, i64 0, i64 0
  ret ptr %t14
L96:
  br label %L13
L13:
  %t15 = getelementptr [13 x i8], ptr @.str91, i64 0, i64 0
  ret ptr %t15
L97:
  br label %L14
L14:
  %t16 = getelementptr [11 x i8], ptr @.str92, i64 0, i64 0
  ret ptr %t16
L98:
  br label %L15
L15:
  %t17 = getelementptr [7 x i8], ptr @.str93, i64 0, i64 0
  ret ptr %t17
L99:
  br label %L16
L16:
  %t18 = getelementptr [9 x i8], ptr @.str94, i64 0, i64 0
  ret ptr %t18
L100:
  br label %L17
L17:
  %t19 = getelementptr [10 x i8], ptr @.str95, i64 0, i64 0
  ret ptr %t19
L101:
  br label %L18
L18:
  %t20 = getelementptr [8 x i8], ptr @.str96, i64 0, i64 0
  ret ptr %t20
L102:
  br label %L19
L19:
  %t21 = getelementptr [7 x i8], ptr @.str97, i64 0, i64 0
  ret ptr %t21
L103:
  br label %L20
L20:
  %t22 = getelementptr [11 x i8], ptr @.str98, i64 0, i64 0
  ret ptr %t22
L104:
  br label %L21
L21:
  %t23 = getelementptr [10 x i8], ptr @.str99, i64 0, i64 0
  ret ptr %t23
L105:
  br label %L22
L22:
  %t24 = getelementptr [13 x i8], ptr @.str100, i64 0, i64 0
  ret ptr %t24
L106:
  br label %L23
L23:
  %t25 = getelementptr [11 x i8], ptr @.str101, i64 0, i64 0
  ret ptr %t25
L107:
  br label %L24
L24:
  %t26 = getelementptr [10 x i8], ptr @.str102, i64 0, i64 0
  ret ptr %t26
L108:
  br label %L25
L25:
  %t27 = getelementptr [11 x i8], ptr @.str103, i64 0, i64 0
  ret ptr %t27
L109:
  br label %L26
L26:
  %t28 = getelementptr [9 x i8], ptr @.str104, i64 0, i64 0
  ret ptr %t28
L110:
  br label %L27
L27:
  %t29 = getelementptr [12 x i8], ptr @.str105, i64 0, i64 0
  ret ptr %t29
L111:
  br label %L28
L28:
  %t30 = getelementptr [9 x i8], ptr @.str106, i64 0, i64 0
  ret ptr %t30
L112:
  br label %L29
L29:
  %t31 = getelementptr [9 x i8], ptr @.str107, i64 0, i64 0
  ret ptr %t31
L113:
  br label %L30
L30:
  %t32 = getelementptr [12 x i8], ptr @.str108, i64 0, i64 0
  ret ptr %t32
L114:
  br label %L31
L31:
  %t33 = getelementptr [11 x i8], ptr @.str109, i64 0, i64 0
  ret ptr %t33
L115:
  br label %L32
L32:
  %t34 = getelementptr [11 x i8], ptr @.str110, i64 0, i64 0
  ret ptr %t34
L116:
  br label %L33
L33:
  %t35 = getelementptr [10 x i8], ptr @.str111, i64 0, i64 0
  ret ptr %t35
L117:
  br label %L34
L34:
  %t36 = getelementptr [13 x i8], ptr @.str112, i64 0, i64 0
  ret ptr %t36
L118:
  br label %L35
L35:
  %t37 = getelementptr [11 x i8], ptr @.str113, i64 0, i64 0
  ret ptr %t37
L119:
  br label %L36
L36:
  %t38 = getelementptr [9 x i8], ptr @.str114, i64 0, i64 0
  ret ptr %t38
L120:
  br label %L37
L37:
  %t39 = getelementptr [10 x i8], ptr @.str115, i64 0, i64 0
  ret ptr %t39
L121:
  br label %L38
L38:
  %t40 = getelementptr [9 x i8], ptr @.str116, i64 0, i64 0
  ret ptr %t40
L122:
  br label %L39
L39:
  %t41 = getelementptr [10 x i8], ptr @.str117, i64 0, i64 0
  ret ptr %t41
L123:
  br label %L40
L40:
  %t42 = getelementptr [12 x i8], ptr @.str118, i64 0, i64 0
  ret ptr %t42
L124:
  br label %L41
L41:
  %t43 = getelementptr [8 x i8], ptr @.str119, i64 0, i64 0
  ret ptr %t43
L125:
  br label %L42
L42:
  %t44 = getelementptr [9 x i8], ptr @.str120, i64 0, i64 0
  ret ptr %t44
L126:
  br label %L43
L43:
  %t45 = getelementptr [10 x i8], ptr @.str121, i64 0, i64 0
  ret ptr %t45
L127:
  br label %L44
L44:
  %t46 = getelementptr [10 x i8], ptr @.str122, i64 0, i64 0
  ret ptr %t46
L128:
  br label %L45
L45:
  %t47 = getelementptr [11 x i8], ptr @.str123, i64 0, i64 0
  ret ptr %t47
L129:
  br label %L46
L46:
  %t48 = getelementptr [11 x i8], ptr @.str124, i64 0, i64 0
  ret ptr %t48
L130:
  br label %L47
L47:
  %t49 = getelementptr [7 x i8], ptr @.str125, i64 0, i64 0
  ret ptr %t49
L131:
  br label %L48
L48:
  %t50 = getelementptr [8 x i8], ptr @.str126, i64 0, i64 0
  ret ptr %t50
L132:
  br label %L49
L49:
  %t51 = getelementptr [7 x i8], ptr @.str127, i64 0, i64 0
  ret ptr %t51
L133:
  br label %L50
L50:
  %t52 = getelementptr [7 x i8], ptr @.str128, i64 0, i64 0
  ret ptr %t52
L134:
  br label %L51
L51:
  %t53 = getelementptr [8 x i8], ptr @.str129, i64 0, i64 0
  ret ptr %t53
L135:
  br label %L52
L52:
  %t54 = getelementptr [8 x i8], ptr @.str130, i64 0, i64 0
  ret ptr %t54
L136:
  br label %L53
L53:
  %t55 = getelementptr [8 x i8], ptr @.str131, i64 0, i64 0
  ret ptr %t55
L137:
  br label %L54
L54:
  %t56 = getelementptr [7 x i8], ptr @.str132, i64 0, i64 0
  ret ptr %t56
L138:
  br label %L55
L55:
  %t57 = getelementptr [9 x i8], ptr @.str133, i64 0, i64 0
  ret ptr %t57
L139:
  br label %L56
L56:
  %t58 = getelementptr [11 x i8], ptr @.str134, i64 0, i64 0
  ret ptr %t58
L140:
  br label %L57
L57:
  %t59 = getelementptr [16 x i8], ptr @.str135, i64 0, i64 0
  ret ptr %t59
L141:
  br label %L58
L58:
  %t60 = getelementptr [17 x i8], ptr @.str136, i64 0, i64 0
  ret ptr %t60
L142:
  br label %L59
L59:
  %t61 = getelementptr [16 x i8], ptr @.str137, i64 0, i64 0
  ret ptr %t61
L143:
  br label %L60
L60:
  %t62 = getelementptr [17 x i8], ptr @.str138, i64 0, i64 0
  ret ptr %t62
L144:
  br label %L61
L61:
  %t63 = getelementptr [15 x i8], ptr @.str139, i64 0, i64 0
  ret ptr %t63
L145:
  br label %L62
L62:
  %t64 = getelementptr [16 x i8], ptr @.str140, i64 0, i64 0
  ret ptr %t64
L146:
  br label %L63
L63:
  %t65 = getelementptr [17 x i8], ptr @.str141, i64 0, i64 0
  ret ptr %t65
L147:
  br label %L64
L64:
  %t66 = getelementptr [18 x i8], ptr @.str142, i64 0, i64 0
  ret ptr %t66
L148:
  br label %L65
L65:
  %t67 = getelementptr [18 x i8], ptr @.str143, i64 0, i64 0
  ret ptr %t67
L149:
  br label %L66
L66:
  %t68 = getelementptr [19 x i8], ptr @.str144, i64 0, i64 0
  ret ptr %t68
L150:
  br label %L67
L67:
  %t69 = getelementptr [8 x i8], ptr @.str145, i64 0, i64 0
  ret ptr %t69
L151:
  br label %L68
L68:
  %t70 = getelementptr [8 x i8], ptr @.str146, i64 0, i64 0
  ret ptr %t70
L152:
  br label %L69
L69:
  %t71 = getelementptr [10 x i8], ptr @.str147, i64 0, i64 0
  ret ptr %t71
L153:
  br label %L70
L70:
  %t72 = getelementptr [8 x i8], ptr @.str148, i64 0, i64 0
  ret ptr %t72
L154:
  br label %L71
L71:
  %t73 = getelementptr [13 x i8], ptr @.str149, i64 0, i64 0
  ret ptr %t73
L155:
  br label %L72
L72:
  %t74 = getelementptr [10 x i8], ptr @.str150, i64 0, i64 0
  ret ptr %t74
L156:
  br label %L73
L73:
  %t75 = getelementptr [11 x i8], ptr @.str151, i64 0, i64 0
  ret ptr %t75
L157:
  br label %L74
L74:
  %t76 = getelementptr [11 x i8], ptr @.str152, i64 0, i64 0
  ret ptr %t76
L158:
  br label %L75
L75:
  %t77 = getelementptr [11 x i8], ptr @.str153, i64 0, i64 0
  ret ptr %t77
L159:
  br label %L76
L76:
  %t78 = getelementptr [11 x i8], ptr @.str154, i64 0, i64 0
  ret ptr %t78
L160:
  br label %L77
L77:
  %t79 = getelementptr [13 x i8], ptr @.str155, i64 0, i64 0
  ret ptr %t79
L161:
  br label %L78
L78:
  %t80 = getelementptr [13 x i8], ptr @.str156, i64 0, i64 0
  ret ptr %t80
L162:
  br label %L79
L79:
  %t81 = getelementptr [14 x i8], ptr @.str157, i64 0, i64 0
  ret ptr %t81
L163:
  br label %L80
L80:
  %t82 = getelementptr [10 x i8], ptr @.str158, i64 0, i64 0
  ret ptr %t82
L164:
  br label %L81
L81:
  %t83 = getelementptr [13 x i8], ptr @.str159, i64 0, i64 0
  ret ptr %t83
L165:
  br label %L82
L82:
  %t84 = getelementptr [8 x i8], ptr @.str160, i64 0, i64 0
  ret ptr %t84
L166:
  br label %L83
L83:
  %t85 = getelementptr [12 x i8], ptr @.str161, i64 0, i64 0
  ret ptr %t85
L167:
  br label %L0
L84:
  %t86 = getelementptr [4 x i8], ptr @.str162, i64 0, i64 0
  ret ptr %t86
L168:
  br label %L0
L0:
  ret ptr null
}

@.str0 = private unnamed_addr constant [7 x i8] c"malloc\00"
@.str1 = private unnamed_addr constant [4 x i8] c"int\00"
@.str2 = private unnamed_addr constant [5 x i8] c"char\00"
@.str3 = private unnamed_addr constant [6 x i8] c"float\00"
@.str4 = private unnamed_addr constant [7 x i8] c"double\00"
@.str5 = private unnamed_addr constant [5 x i8] c"void\00"
@.str6 = private unnamed_addr constant [5 x i8] c"long\00"
@.str7 = private unnamed_addr constant [6 x i8] c"short\00"
@.str8 = private unnamed_addr constant [9 x i8] c"unsigned\00"
@.str9 = private unnamed_addr constant [7 x i8] c"signed\00"
@.str10 = private unnamed_addr constant [3 x i8] c"if\00"
@.str11 = private unnamed_addr constant [5 x i8] c"else\00"
@.str12 = private unnamed_addr constant [6 x i8] c"while\00"
@.str13 = private unnamed_addr constant [4 x i8] c"for\00"
@.str14 = private unnamed_addr constant [3 x i8] c"do\00"
@.str15 = private unnamed_addr constant [7 x i8] c"return\00"
@.str16 = private unnamed_addr constant [6 x i8] c"break\00"
@.str17 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str18 = private unnamed_addr constant [7 x i8] c"switch\00"
@.str19 = private unnamed_addr constant [5 x i8] c"case\00"
@.str20 = private unnamed_addr constant [8 x i8] c"default\00"
@.str21 = private unnamed_addr constant [5 x i8] c"goto\00"
@.str22 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str23 = private unnamed_addr constant [6 x i8] c"union\00"
@.str24 = private unnamed_addr constant [5 x i8] c"enum\00"
@.str25 = private unnamed_addr constant [8 x i8] c"typedef\00"
@.str26 = private unnamed_addr constant [7 x i8] c"static\00"
@.str27 = private unnamed_addr constant [7 x i8] c"extern\00"
@.str28 = private unnamed_addr constant [6 x i8] c"const\00"
@.str29 = private unnamed_addr constant [9 x i8] c"volatile\00"
@.str30 = private unnamed_addr constant [7 x i8] c"sizeof\00"
@.str31 = private unnamed_addr constant [7 x i8] c"calloc\00"
@.str32 = private unnamed_addr constant [1 x i8] c"\00"
@.str33 = private unnamed_addr constant [3 x i8] c"++\00"
@.str34 = private unnamed_addr constant [3 x i8] c"+=\00"
@.str35 = private unnamed_addr constant [2 x i8] c"+\00"
@.str36 = private unnamed_addr constant [3 x i8] c"--\00"
@.str37 = private unnamed_addr constant [3 x i8] c"-=\00"
@.str38 = private unnamed_addr constant [3 x i8] c"->\00"
@.str39 = private unnamed_addr constant [2 x i8] c"-\00"
@.str40 = private unnamed_addr constant [3 x i8] c"*=\00"
@.str41 = private unnamed_addr constant [2 x i8] c"*\00"
@.str42 = private unnamed_addr constant [3 x i8] c"/=\00"
@.str43 = private unnamed_addr constant [2 x i8] c"/\00"
@.str44 = private unnamed_addr constant [3 x i8] c"%=\00"
@.str45 = private unnamed_addr constant [2 x i8] c"%\00"
@.str46 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str47 = private unnamed_addr constant [3 x i8] c"&=\00"
@.str48 = private unnamed_addr constant [2 x i8] c"&\00"
@.str49 = private unnamed_addr constant [3 x i8] c"||\00"
@.str50 = private unnamed_addr constant [3 x i8] c"|=\00"
@.str51 = private unnamed_addr constant [2 x i8] c"|\00"
@.str52 = private unnamed_addr constant [3 x i8] c"^=\00"
@.str53 = private unnamed_addr constant [2 x i8] c"^\00"
@.str54 = private unnamed_addr constant [2 x i8] c"~\00"
@.str55 = private unnamed_addr constant [4 x i8] c"<<=\00"
@.str56 = private unnamed_addr constant [3 x i8] c"<<\00"
@.str57 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str58 = private unnamed_addr constant [2 x i8] c"<\00"
@.str59 = private unnamed_addr constant [4 x i8] c">>=\00"
@.str60 = private unnamed_addr constant [3 x i8] c">>\00"
@.str61 = private unnamed_addr constant [3 x i8] c">=\00"
@.str62 = private unnamed_addr constant [2 x i8] c">\00"
@.str63 = private unnamed_addr constant [3 x i8] c"==\00"
@.str64 = private unnamed_addr constant [2 x i8] c"=\00"
@.str65 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str66 = private unnamed_addr constant [2 x i8] c"!\00"
@.str67 = private unnamed_addr constant [4 x i8] c"...\00"
@.str68 = private unnamed_addr constant [2 x i8] c".\00"
@.str69 = private unnamed_addr constant [2 x i8] c"(\00"
@.str70 = private unnamed_addr constant [2 x i8] c")\00"
@.str71 = private unnamed_addr constant [2 x i8] c"{\00"
@.str72 = private unnamed_addr constant [2 x i8] c"}\00"
@.str73 = private unnamed_addr constant [2 x i8] c"[\00"
@.str74 = private unnamed_addr constant [2 x i8] c"]\00"
@.str75 = private unnamed_addr constant [2 x i8] c";\00"
@.str76 = private unnamed_addr constant [2 x i8] c",\00"
@.str77 = private unnamed_addr constant [2 x i8] c"?\00"
@.str78 = private unnamed_addr constant [2 x i8] c":\00"
@.str79 = private unnamed_addr constant [12 x i8] c"TOK_INT_LIT\00"
@.str80 = private unnamed_addr constant [14 x i8] c"TOK_FLOAT_LIT\00"
@.str81 = private unnamed_addr constant [13 x i8] c"TOK_CHAR_LIT\00"
@.str82 = private unnamed_addr constant [15 x i8] c"TOK_STRING_LIT\00"
@.str83 = private unnamed_addr constant [10 x i8] c"TOK_IDENT\00"
@.str84 = private unnamed_addr constant [8 x i8] c"TOK_INT\00"
@.str85 = private unnamed_addr constant [9 x i8] c"TOK_CHAR\00"
@.str86 = private unnamed_addr constant [10 x i8] c"TOK_FLOAT\00"
@.str87 = private unnamed_addr constant [11 x i8] c"TOK_DOUBLE\00"
@.str88 = private unnamed_addr constant [9 x i8] c"TOK_VOID\00"
@.str89 = private unnamed_addr constant [9 x i8] c"TOK_LONG\00"
@.str90 = private unnamed_addr constant [10 x i8] c"TOK_SHORT\00"
@.str91 = private unnamed_addr constant [13 x i8] c"TOK_UNSIGNED\00"
@.str92 = private unnamed_addr constant [11 x i8] c"TOK_SIGNED\00"
@.str93 = private unnamed_addr constant [7 x i8] c"TOK_IF\00"
@.str94 = private unnamed_addr constant [9 x i8] c"TOK_ELSE\00"
@.str95 = private unnamed_addr constant [10 x i8] c"TOK_WHILE\00"
@.str96 = private unnamed_addr constant [8 x i8] c"TOK_FOR\00"
@.str97 = private unnamed_addr constant [7 x i8] c"TOK_DO\00"
@.str98 = private unnamed_addr constant [11 x i8] c"TOK_RETURN\00"
@.str99 = private unnamed_addr constant [10 x i8] c"TOK_BREAK\00"
@.str100 = private unnamed_addr constant [13 x i8] c"TOK_CONTINUE\00"
@.str101 = private unnamed_addr constant [11 x i8] c"TOK_STRUCT\00"
@.str102 = private unnamed_addr constant [10 x i8] c"TOK_UNION\00"
@.str103 = private unnamed_addr constant [11 x i8] c"TOK_SWITCH\00"
@.str104 = private unnamed_addr constant [9 x i8] c"TOK_CASE\00"
@.str105 = private unnamed_addr constant [12 x i8] c"TOK_DEFAULT\00"
@.str106 = private unnamed_addr constant [9 x i8] c"TOK_GOTO\00"
@.str107 = private unnamed_addr constant [9 x i8] c"TOK_ENUM\00"
@.str108 = private unnamed_addr constant [12 x i8] c"TOK_TYPEDEF\00"
@.str109 = private unnamed_addr constant [11 x i8] c"TOK_STATIC\00"
@.str110 = private unnamed_addr constant [11 x i8] c"TOK_EXTERN\00"
@.str111 = private unnamed_addr constant [10 x i8] c"TOK_CONST\00"
@.str112 = private unnamed_addr constant [13 x i8] c"TOK_VOLATILE\00"
@.str113 = private unnamed_addr constant [11 x i8] c"TOK_SIZEOF\00"
@.str114 = private unnamed_addr constant [9 x i8] c"TOK_PLUS\00"
@.str115 = private unnamed_addr constant [10 x i8] c"TOK_MINUS\00"
@.str116 = private unnamed_addr constant [9 x i8] c"TOK_STAR\00"
@.str117 = private unnamed_addr constant [10 x i8] c"TOK_SLASH\00"
@.str118 = private unnamed_addr constant [12 x i8] c"TOK_PERCENT\00"
@.str119 = private unnamed_addr constant [8 x i8] c"TOK_AMP\00"
@.str120 = private unnamed_addr constant [9 x i8] c"TOK_PIPE\00"
@.str121 = private unnamed_addr constant [10 x i8] c"TOK_CARET\00"
@.str122 = private unnamed_addr constant [10 x i8] c"TOK_TILDE\00"
@.str123 = private unnamed_addr constant [11 x i8] c"TOK_LSHIFT\00"
@.str124 = private unnamed_addr constant [11 x i8] c"TOK_RSHIFT\00"
@.str125 = private unnamed_addr constant [7 x i8] c"TOK_EQ\00"
@.str126 = private unnamed_addr constant [8 x i8] c"TOK_NEQ\00"
@.str127 = private unnamed_addr constant [7 x i8] c"TOK_LT\00"
@.str128 = private unnamed_addr constant [7 x i8] c"TOK_GT\00"
@.str129 = private unnamed_addr constant [8 x i8] c"TOK_LEQ\00"
@.str130 = private unnamed_addr constant [8 x i8] c"TOK_GEQ\00"
@.str131 = private unnamed_addr constant [8 x i8] c"TOK_AND\00"
@.str132 = private unnamed_addr constant [7 x i8] c"TOK_OR\00"
@.str133 = private unnamed_addr constant [9 x i8] c"TOK_BANG\00"
@.str134 = private unnamed_addr constant [11 x i8] c"TOK_ASSIGN\00"
@.str135 = private unnamed_addr constant [16 x i8] c"TOK_PLUS_ASSIGN\00"
@.str136 = private unnamed_addr constant [17 x i8] c"TOK_MINUS_ASSIGN\00"
@.str137 = private unnamed_addr constant [16 x i8] c"TOK_STAR_ASSIGN\00"
@.str138 = private unnamed_addr constant [17 x i8] c"TOK_SLASH_ASSIGN\00"
@.str139 = private unnamed_addr constant [15 x i8] c"TOK_AMP_ASSIGN\00"
@.str140 = private unnamed_addr constant [16 x i8] c"TOK_PIPE_ASSIGN\00"
@.str141 = private unnamed_addr constant [17 x i8] c"TOK_CARET_ASSIGN\00"
@.str142 = private unnamed_addr constant [18 x i8] c"TOK_LSHIFT_ASSIGN\00"
@.str143 = private unnamed_addr constant [18 x i8] c"TOK_RSHIFT_ASSIGN\00"
@.str144 = private unnamed_addr constant [19 x i8] c"TOK_PERCENT_ASSIGN\00"
@.str145 = private unnamed_addr constant [8 x i8] c"TOK_INC\00"
@.str146 = private unnamed_addr constant [8 x i8] c"TOK_DEC\00"
@.str147 = private unnamed_addr constant [10 x i8] c"TOK_ARROW\00"
@.str148 = private unnamed_addr constant [8 x i8] c"TOK_DOT\00"
@.str149 = private unnamed_addr constant [13 x i8] c"TOK_QUESTION\00"
@.str150 = private unnamed_addr constant [10 x i8] c"TOK_COLON\00"
@.str151 = private unnamed_addr constant [11 x i8] c"TOK_LPAREN\00"
@.str152 = private unnamed_addr constant [11 x i8] c"TOK_RPAREN\00"
@.str153 = private unnamed_addr constant [11 x i8] c"TOK_LBRACE\00"
@.str154 = private unnamed_addr constant [11 x i8] c"TOK_RBRACE\00"
@.str155 = private unnamed_addr constant [13 x i8] c"TOK_LBRACKET\00"
@.str156 = private unnamed_addr constant [13 x i8] c"TOK_RBRACKET\00"
@.str157 = private unnamed_addr constant [14 x i8] c"TOK_SEMICOLON\00"
@.str158 = private unnamed_addr constant [10 x i8] c"TOK_COMMA\00"
@.str159 = private unnamed_addr constant [13 x i8] c"TOK_ELLIPSIS\00"
@.str160 = private unnamed_addr constant [8 x i8] c"TOK_EOF\00"
@.str161 = private unnamed_addr constant [12 x i8] c"TOK_UNKNOWN\00"
@.str162 = private unnamed_addr constant [4 x i8] c"???\00"
