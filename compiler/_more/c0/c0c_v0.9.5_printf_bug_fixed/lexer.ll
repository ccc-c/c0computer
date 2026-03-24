; ModuleID = 'lexer.c'
source_filename = "lexer.c"
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
  %t11 = sext i32 %t9 to i64
  %t12 = sext i32 10 to i64
  %t10 = icmp eq i64 %t11, %t12
  %t13 = zext i1 %t10 to i64
  %t14 = icmp ne i64 %t13, 0
  br i1 %t14, label %L0, label %L1
L0:
  %t15 = load ptr, ptr %t0
  %t17 = ptrtoint ptr %t15 to i64
  %t16 = add i64 %t17, 1
  store i64 %t16, ptr %t0
  %t18 = sext i32 1 to i64
  store i64 %t18, ptr %t0
  br label %L2
L1:
  %t19 = load ptr, ptr %t0
  %t21 = ptrtoint ptr %t19 to i64
  %t20 = add i64 %t21, 1
  store i64 %t20, ptr %t0
  br label %L2
L2:
  %t22 = load i64, ptr %t1
  %t23 = sext i32 %t22 to i64
  %t24 = trunc i64 %t23 to i8
  ret i8 %t24
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
  %t16 = sext i32 %t15 to i64
  ret i64 %t16
L3:
  br label %L2
L2:
  %t17 = call i8 @cur(ptr %t0)
  %t18 = sext i8 %t17 to i64
  %t19 = add i64 %t18, 0
  %t20 = call i32 @isdigit(i64 %t19)
  %t21 = sext i32 %t20 to i64
  %t22 = icmp ne i64 %t21, 0
  br i1 %t22, label %L4, label %L5
L4:
  br label %L6
L5:
  %t23 = call i8 @cur(ptr %t0)
  %t24 = sext i8 %t23 to i64
  %t26 = sext i32 46 to i64
  %t25 = icmp eq i64 %t24, %t26
  %t27 = zext i1 %t25 to i64
  %t28 = icmp ne i64 %t27, 0
  br i1 %t28, label %L7, label %L8
L7:
  %t29 = call i8 @peek1(ptr %t0)
  %t30 = sext i8 %t29 to i64
  %t31 = add i64 %t30, 0
  %t32 = call i32 @isdigit(i64 %t31)
  %t33 = sext i32 %t32 to i64
  %t34 = icmp ne i64 %t33, 0
  %t35 = zext i1 %t34 to i64
  br label %L9
L8:
  br label %L9
L9:
  %t36 = phi i64 [ %t35, %L7 ], [ 0, %L8 ]
  %t37 = icmp ne i64 %t36, 0
  %t38 = zext i1 %t37 to i64
  br label %L6
L6:
  %t39 = phi i64 [ 1, %L4 ], [ %t38, %L5 ]
  %t40 = icmp ne i64 %t39, 0
  br i1 %t40, label %L10, label %L12
L10:
  %t41 = alloca i64
  %t42 = load ptr, ptr %t0
  store ptr %t42, ptr %t41
  %t43 = alloca i64
  %t44 = sext i32 0 to i64
  store i64 %t44, ptr %t43
  %t45 = call i8 @cur(ptr %t0)
  %t46 = sext i8 %t45 to i64
  %t48 = sext i32 48 to i64
  %t47 = icmp eq i64 %t46, %t48
  %t49 = zext i1 %t47 to i64
  %t50 = icmp ne i64 %t49, 0
  br i1 %t50, label %L13, label %L14
L13:
  %t51 = call i8 @peek1(ptr %t0)
  %t52 = sext i8 %t51 to i64
  %t54 = sext i32 120 to i64
  %t53 = icmp eq i64 %t52, %t54
  %t55 = zext i1 %t53 to i64
  %t56 = icmp ne i64 %t55, 0
  br i1 %t56, label %L16, label %L17
L16:
  br label %L18
L17:
  %t57 = call i8 @peek1(ptr %t0)
  %t58 = sext i8 %t57 to i64
  %t60 = sext i32 88 to i64
  %t59 = icmp eq i64 %t58, %t60
  %t61 = zext i1 %t59 to i64
  %t62 = icmp ne i64 %t61, 0
  %t63 = zext i1 %t62 to i64
  br label %L18
L18:
  %t64 = phi i64 [ 1, %L16 ], [ %t63, %L17 ]
  %t65 = icmp ne i64 %t64, 0
  %t66 = zext i1 %t65 to i64
  br label %L15
L14:
  br label %L15
L15:
  %t67 = phi i64 [ %t66, %L13 ], [ 0, %L14 ]
  %t68 = icmp ne i64 %t67, 0
  br i1 %t68, label %L19, label %L20
L19:
  %t69 = call i8 @advance(ptr %t0)
  %t70 = sext i8 %t69 to i64
  %t71 = call i8 @advance(ptr %t0)
  %t72 = sext i8 %t71 to i64
  br label %L22
L22:
  %t73 = call i8 @cur(ptr %t0)
  %t74 = sext i8 %t73 to i64
  %t75 = add i64 %t74, 0
  %t76 = call i32 @isxdigit(i64 %t75)
  %t77 = sext i32 %t76 to i64
  %t78 = icmp ne i64 %t77, 0
  br i1 %t78, label %L23, label %L24
L23:
  %t79 = call i8 @advance(ptr %t0)
  %t80 = sext i8 %t79 to i64
  br label %L22
L24:
  br label %L21
L20:
  br label %L25
L25:
  %t81 = call i8 @cur(ptr %t0)
  %t82 = sext i8 %t81 to i64
  %t83 = add i64 %t82, 0
  %t84 = call i32 @isdigit(i64 %t83)
  %t85 = sext i32 %t84 to i64
  %t86 = icmp ne i64 %t85, 0
  br i1 %t86, label %L26, label %L27
L26:
  %t87 = call i8 @advance(ptr %t0)
  %t88 = sext i8 %t87 to i64
  br label %L25
L27:
  %t89 = call i8 @cur(ptr %t0)
  %t90 = sext i8 %t89 to i64
  %t92 = sext i32 46 to i64
  %t91 = icmp eq i64 %t90, %t92
  %t93 = zext i1 %t91 to i64
  %t94 = icmp ne i64 %t93, 0
  br i1 %t94, label %L28, label %L30
L28:
  %t95 = sext i32 1 to i64
  store i64 %t95, ptr %t43
  %t96 = call i8 @advance(ptr %t0)
  %t97 = sext i8 %t96 to i64
  br label %L30
L30:
  br label %L31
L31:
  %t98 = call i8 @cur(ptr %t0)
  %t99 = sext i8 %t98 to i64
  %t100 = add i64 %t99, 0
  %t101 = call i32 @isdigit(i64 %t100)
  %t102 = sext i32 %t101 to i64
  %t103 = icmp ne i64 %t102, 0
  br i1 %t103, label %L32, label %L33
L32:
  %t104 = call i8 @advance(ptr %t0)
  %t105 = sext i8 %t104 to i64
  br label %L31
L33:
  %t106 = call i8 @cur(ptr %t0)
  %t107 = sext i8 %t106 to i64
  %t109 = sext i32 101 to i64
  %t108 = icmp eq i64 %t107, %t109
  %t110 = zext i1 %t108 to i64
  %t111 = icmp ne i64 %t110, 0
  br i1 %t111, label %L34, label %L35
L34:
  br label %L36
L35:
  %t112 = call i8 @cur(ptr %t0)
  %t113 = sext i8 %t112 to i64
  %t115 = sext i32 69 to i64
  %t114 = icmp eq i64 %t113, %t115
  %t116 = zext i1 %t114 to i64
  %t117 = icmp ne i64 %t116, 0
  %t118 = zext i1 %t117 to i64
  br label %L36
L36:
  %t119 = phi i64 [ 1, %L34 ], [ %t118, %L35 ]
  %t120 = icmp ne i64 %t119, 0
  br i1 %t120, label %L37, label %L39
L37:
  %t121 = sext i32 1 to i64
  store i64 %t121, ptr %t43
  %t122 = call i8 @advance(ptr %t0)
  %t123 = sext i8 %t122 to i64
  %t124 = call i8 @cur(ptr %t0)
  %t125 = sext i8 %t124 to i64
  %t127 = sext i32 43 to i64
  %t126 = icmp eq i64 %t125, %t127
  %t128 = zext i1 %t126 to i64
  %t129 = icmp ne i64 %t128, 0
  br i1 %t129, label %L40, label %L41
L40:
  br label %L42
L41:
  %t130 = call i8 @cur(ptr %t0)
  %t131 = sext i8 %t130 to i64
  %t133 = sext i32 45 to i64
  %t132 = icmp eq i64 %t131, %t133
  %t134 = zext i1 %t132 to i64
  %t135 = icmp ne i64 %t134, 0
  %t136 = zext i1 %t135 to i64
  br label %L42
L42:
  %t137 = phi i64 [ 1, %L40 ], [ %t136, %L41 ]
  %t138 = icmp ne i64 %t137, 0
  br i1 %t138, label %L43, label %L45
L43:
  %t139 = call i8 @advance(ptr %t0)
  %t140 = sext i8 %t139 to i64
  br label %L45
L45:
  br label %L46
L46:
  %t141 = call i8 @cur(ptr %t0)
  %t142 = sext i8 %t141 to i64
  %t143 = add i64 %t142, 0
  %t144 = call i32 @isdigit(i64 %t143)
  %t145 = sext i32 %t144 to i64
  %t146 = icmp ne i64 %t145, 0
  br i1 %t146, label %L47, label %L48
L47:
  %t147 = call i8 @advance(ptr %t0)
  %t148 = sext i8 %t147 to i64
  br label %L46
L48:
  br label %L39
L39:
  br label %L21
L21:
  br label %L49
L49:
  %t149 = call i8 @cur(ptr %t0)
  %t150 = sext i8 %t149 to i64
  %t152 = sext i32 117 to i64
  %t151 = icmp eq i64 %t150, %t152
  %t153 = zext i1 %t151 to i64
  %t154 = icmp ne i64 %t153, 0
  br i1 %t154, label %L52, label %L53
L52:
  br label %L54
L53:
  %t155 = call i8 @cur(ptr %t0)
  %t156 = sext i8 %t155 to i64
  %t158 = sext i32 85 to i64
  %t157 = icmp eq i64 %t156, %t158
  %t159 = zext i1 %t157 to i64
  %t160 = icmp ne i64 %t159, 0
  %t161 = zext i1 %t160 to i64
  br label %L54
L54:
  %t162 = phi i64 [ 1, %L52 ], [ %t161, %L53 ]
  %t163 = icmp ne i64 %t162, 0
  br i1 %t163, label %L55, label %L56
L55:
  br label %L57
L56:
  %t164 = call i8 @cur(ptr %t0)
  %t165 = sext i8 %t164 to i64
  %t167 = sext i32 108 to i64
  %t166 = icmp eq i64 %t165, %t167
  %t168 = zext i1 %t166 to i64
  %t169 = icmp ne i64 %t168, 0
  %t170 = zext i1 %t169 to i64
  br label %L57
L57:
  %t171 = phi i64 [ 1, %L55 ], [ %t170, %L56 ]
  %t172 = icmp ne i64 %t171, 0
  br i1 %t172, label %L58, label %L59
L58:
  br label %L60
L59:
  %t173 = call i8 @cur(ptr %t0)
  %t174 = sext i8 %t173 to i64
  %t176 = sext i32 76 to i64
  %t175 = icmp eq i64 %t174, %t176
  %t177 = zext i1 %t175 to i64
  %t178 = icmp ne i64 %t177, 0
  %t179 = zext i1 %t178 to i64
  br label %L60
L60:
  %t180 = phi i64 [ 1, %L58 ], [ %t179, %L59 ]
  %t181 = icmp ne i64 %t180, 0
  br i1 %t181, label %L61, label %L62
L61:
  br label %L63
L62:
  %t182 = call i8 @cur(ptr %t0)
  %t183 = sext i8 %t182 to i64
  %t185 = sext i32 102 to i64
  %t184 = icmp eq i64 %t183, %t185
  %t186 = zext i1 %t184 to i64
  %t187 = icmp ne i64 %t186, 0
  %t188 = zext i1 %t187 to i64
  br label %L63
L63:
  %t189 = phi i64 [ 1, %L61 ], [ %t188, %L62 ]
  %t190 = icmp ne i64 %t189, 0
  br i1 %t190, label %L64, label %L65
L64:
  br label %L66
L65:
  %t191 = call i8 @cur(ptr %t0)
  %t192 = sext i8 %t191 to i64
  %t194 = sext i32 70 to i64
  %t193 = icmp eq i64 %t192, %t194
  %t195 = zext i1 %t193 to i64
  %t196 = icmp ne i64 %t195, 0
  %t197 = zext i1 %t196 to i64
  br label %L66
L66:
  %t198 = phi i64 [ 1, %L64 ], [ %t197, %L65 ]
  %t199 = icmp ne i64 %t198, 0
  br i1 %t199, label %L50, label %L51
L50:
  %t200 = call i8 @advance(ptr %t0)
  %t201 = sext i8 %t200 to i64
  br label %L49
L51:
  %t202 = load i64, ptr %t43
  %t204 = sext i32 %t202 to i64
  %t203 = icmp ne i64 %t204, 0
  br i1 %t203, label %L67, label %L68
L67:
  %t205 = sext i32 1 to i64
  br label %L69
L68:
  %t206 = sext i32 0 to i64
  br label %L69
L69:
  %t207 = phi i64 [ %t205, %L67 ], [ %t206, %L68 ]
  store i64 %t207, ptr %t2
  %t208 = load ptr, ptr %t0
  %t209 = load i64, ptr %t41
  %t211 = ptrtoint ptr %t208 to i64
  %t212 = sext i32 %t209 to i64
  %t213 = inttoptr i64 %t211 to ptr
  %t210 = getelementptr i8, ptr %t213, i64 %t212
  %t214 = load ptr, ptr %t0
  %t215 = load i64, ptr %t41
  %t217 = ptrtoint ptr %t214 to i64
  %t218 = sext i32 %t215 to i64
  %t216 = sub i64 %t217, %t218
  %t219 = call ptr @strndup_local(ptr %t210, i64 %t216)
  store ptr %t219, ptr %t2
  %t220 = load i64, ptr %t2
  %t221 = sext i32 %t220 to i64
  ret i64 %t221
L70:
  br label %L12
L12:
  %t222 = call i8 @cur(ptr %t0)
  %t223 = sext i8 %t222 to i64
  %t225 = sext i32 39 to i64
  %t224 = icmp eq i64 %t223, %t225
  %t226 = zext i1 %t224 to i64
  %t227 = icmp ne i64 %t226, 0
  br i1 %t227, label %L71, label %L73
L71:
  %t228 = alloca i64
  %t229 = load ptr, ptr %t0
  store ptr %t229, ptr %t228
  %t230 = call i8 @advance(ptr %t0)
  %t231 = sext i8 %t230 to i64
  %t232 = call i8 @cur(ptr %t0)
  %t233 = sext i8 %t232 to i64
  %t235 = sext i32 92 to i64
  %t234 = icmp eq i64 %t233, %t235
  %t236 = zext i1 %t234 to i64
  %t237 = icmp ne i64 %t236, 0
  br i1 %t237, label %L74, label %L75
L74:
  %t238 = call i8 @advance(ptr %t0)
  %t239 = sext i8 %t238 to i64
  %t240 = call i8 @advance(ptr %t0)
  %t241 = sext i8 %t240 to i64
  br label %L76
L75:
  %t242 = call i8 @advance(ptr %t0)
  %t243 = sext i8 %t242 to i64
  br label %L76
L76:
  %t244 = call i8 @cur(ptr %t0)
  %t245 = sext i8 %t244 to i64
  %t247 = sext i32 39 to i64
  %t246 = icmp eq i64 %t245, %t247
  %t248 = zext i1 %t246 to i64
  %t249 = icmp ne i64 %t248, 0
  br i1 %t249, label %L77, label %L79
L77:
  %t250 = call i8 @advance(ptr %t0)
  %t251 = sext i8 %t250 to i64
  br label %L79
L79:
  %t252 = sext i32 2 to i64
  store i64 %t252, ptr %t2
  %t253 = load ptr, ptr %t0
  %t254 = load i64, ptr %t228
  %t256 = ptrtoint ptr %t253 to i64
  %t257 = sext i32 %t254 to i64
  %t258 = inttoptr i64 %t256 to ptr
  %t255 = getelementptr i8, ptr %t258, i64 %t257
  %t259 = load ptr, ptr %t0
  %t260 = load i64, ptr %t228
  %t262 = ptrtoint ptr %t259 to i64
  %t263 = sext i32 %t260 to i64
  %t261 = sub i64 %t262, %t263
  %t264 = call ptr @strndup_local(ptr %t255, i64 %t261)
  store ptr %t264, ptr %t2
  %t265 = load i64, ptr %t2
  %t266 = sext i32 %t265 to i64
  ret i64 %t266
L80:
  br label %L73
L73:
  %t267 = call i8 @cur(ptr %t0)
  %t268 = sext i8 %t267 to i64
  %t270 = sext i32 34 to i64
  %t269 = icmp eq i64 %t268, %t270
  %t271 = zext i1 %t269 to i64
  %t272 = icmp ne i64 %t271, 0
  br i1 %t272, label %L81, label %L83
L81:
  %t273 = alloca i64
  %t274 = load ptr, ptr %t0
  store ptr %t274, ptr %t273
  %t275 = call i8 @advance(ptr %t0)
  %t276 = sext i8 %t275 to i64
  br label %L84
L84:
  %t277 = call i8 @cur(ptr %t0)
  %t278 = sext i8 %t277 to i64
  %t279 = icmp ne i64 %t278, 0
  br i1 %t279, label %L87, label %L88
L87:
  %t280 = call i8 @cur(ptr %t0)
  %t281 = sext i8 %t280 to i64
  %t283 = sext i32 34 to i64
  %t282 = icmp ne i64 %t281, %t283
  %t284 = zext i1 %t282 to i64
  %t285 = icmp ne i64 %t284, 0
  %t286 = zext i1 %t285 to i64
  br label %L89
L88:
  br label %L89
L89:
  %t287 = phi i64 [ %t286, %L87 ], [ 0, %L88 ]
  %t288 = icmp ne i64 %t287, 0
  br i1 %t288, label %L85, label %L86
L85:
  %t289 = call i8 @cur(ptr %t0)
  %t290 = sext i8 %t289 to i64
  %t292 = sext i32 92 to i64
  %t291 = icmp eq i64 %t290, %t292
  %t293 = zext i1 %t291 to i64
  %t294 = icmp ne i64 %t293, 0
  br i1 %t294, label %L90, label %L92
L90:
  %t295 = call i8 @advance(ptr %t0)
  %t296 = sext i8 %t295 to i64
  br label %L92
L92:
  %t297 = call i8 @cur(ptr %t0)
  %t298 = sext i8 %t297 to i64
  %t299 = icmp ne i64 %t298, 0
  br i1 %t299, label %L93, label %L95
L93:
  %t300 = call i8 @advance(ptr %t0)
  %t301 = sext i8 %t300 to i64
  br label %L95
L95:
  br label %L84
L86:
  %t302 = call i8 @cur(ptr %t0)
  %t303 = sext i8 %t302 to i64
  %t305 = sext i32 34 to i64
  %t304 = icmp eq i64 %t303, %t305
  %t306 = zext i1 %t304 to i64
  %t307 = icmp ne i64 %t306, 0
  br i1 %t307, label %L96, label %L98
L96:
  %t308 = call i8 @advance(ptr %t0)
  %t309 = sext i8 %t308 to i64
  br label %L98
L98:
  %t310 = sext i32 3 to i64
  store i64 %t310, ptr %t2
  %t311 = load ptr, ptr %t0
  %t312 = load i64, ptr %t273
  %t314 = ptrtoint ptr %t311 to i64
  %t315 = sext i32 %t312 to i64
  %t316 = inttoptr i64 %t314 to ptr
  %t313 = getelementptr i8, ptr %t316, i64 %t315
  %t317 = load ptr, ptr %t0
  %t318 = load i64, ptr %t273
  %t320 = ptrtoint ptr %t317 to i64
  %t321 = sext i32 %t318 to i64
  %t319 = sub i64 %t320, %t321
  %t322 = call ptr @strndup_local(ptr %t313, i64 %t319)
  store ptr %t322, ptr %t2
  %t323 = load i64, ptr %t2
  %t324 = sext i32 %t323 to i64
  ret i64 %t324
L99:
  br label %L83
L83:
  %t325 = call i8 @cur(ptr %t0)
  %t326 = sext i8 %t325 to i64
  %t327 = add i64 %t326, 0
  %t328 = call i32 @isalpha(i64 %t327)
  %t329 = sext i32 %t328 to i64
  %t330 = icmp ne i64 %t329, 0
  br i1 %t330, label %L100, label %L101
L100:
  br label %L102
L101:
  %t331 = call i8 @cur(ptr %t0)
  %t332 = sext i8 %t331 to i64
  %t334 = sext i32 95 to i64
  %t333 = icmp eq i64 %t332, %t334
  %t335 = zext i1 %t333 to i64
  %t336 = icmp ne i64 %t335, 0
  %t337 = zext i1 %t336 to i64
  br label %L102
L102:
  %t338 = phi i64 [ 1, %L100 ], [ %t337, %L101 ]
  %t339 = icmp ne i64 %t338, 0
  br i1 %t339, label %L103, label %L105
L103:
  %t340 = alloca i64
  %t341 = load ptr, ptr %t0
  store ptr %t341, ptr %t340
  br label %L106
L106:
  %t342 = call i8 @cur(ptr %t0)
  %t343 = sext i8 %t342 to i64
  %t344 = add i64 %t343, 0
  %t345 = call i32 @isalnum(i64 %t344)
  %t346 = sext i32 %t345 to i64
  %t347 = icmp ne i64 %t346, 0
  br i1 %t347, label %L109, label %L110
L109:
  br label %L111
L110:
  %t348 = call i8 @cur(ptr %t0)
  %t349 = sext i8 %t348 to i64
  %t351 = sext i32 95 to i64
  %t350 = icmp eq i64 %t349, %t351
  %t352 = zext i1 %t350 to i64
  %t353 = icmp ne i64 %t352, 0
  %t354 = zext i1 %t353 to i64
  br label %L111
L111:
  %t355 = phi i64 [ 1, %L109 ], [ %t354, %L110 ]
  %t356 = icmp ne i64 %t355, 0
  br i1 %t356, label %L107, label %L108
L107:
  %t357 = call i8 @advance(ptr %t0)
  %t358 = sext i8 %t357 to i64
  br label %L106
L108:
  %t359 = load ptr, ptr %t0
  %t360 = load i64, ptr %t340
  %t362 = ptrtoint ptr %t359 to i64
  %t363 = sext i32 %t360 to i64
  %t364 = inttoptr i64 %t362 to ptr
  %t361 = getelementptr i8, ptr %t364, i64 %t363
  %t365 = load ptr, ptr %t0
  %t366 = load i64, ptr %t340
  %t368 = ptrtoint ptr %t365 to i64
  %t369 = sext i32 %t366 to i64
  %t367 = sub i64 %t368, %t369
  %t370 = call ptr @strndup_local(ptr %t361, i64 %t367)
  store ptr %t370, ptr %t2
  %t371 = load ptr, ptr %t2
  %t372 = call i64 @keyword_lookup(ptr %t371)
  store i64 %t372, ptr %t2
  %t373 = load i64, ptr %t2
  %t374 = sext i32 %t373 to i64
  ret i64 %t374
L112:
  br label %L105
L105:
  %t375 = alloca i64
  %t376 = call i8 @advance(ptr %t0)
  %t377 = sext i8 %t376 to i64
  store i64 %t377, ptr %t375
  %t378 = alloca i64
  %t379 = call i8 @cur(ptr %t0)
  %t380 = sext i8 %t379 to i64
  store i64 %t380, ptr %t378
  %t381 = load i64, ptr %t375
  %t382 = sext i32 %t381 to i64
  %t383 = add i64 %t382, 0
  switch i64 %t383, label %L138 [
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
  %t384 = load i64, ptr %t378
  %t386 = sext i32 %t384 to i64
  %t387 = sext i32 43 to i64
  %t385 = icmp eq i64 %t386, %t387
  %t388 = zext i1 %t385 to i64
  %t389 = icmp ne i64 %t388, 0
  br i1 %t389, label %L139, label %L141
L139:
  br label %L142
L142:
  %t390 = call i8 @advance(ptr %t0)
  %t391 = sext i8 %t390 to i64
  br label %L145
L145:
  %t392 = sext i32 66 to i64
  store i64 %t392, ptr %t2
  %t393 = getelementptr [3 x i8], ptr @.str33, i64 0, i64 0
  %t394 = call ptr @strdup(ptr %t393)
  store ptr %t394, ptr %t2
  %t395 = load i64, ptr %t2
  %t396 = sext i32 %t395 to i64
  ret i64 %t396
L148:
  br label %L146
L146:
  %t398 = sext i32 0 to i64
  %t397 = icmp ne i64 %t398, 0
  br i1 %t397, label %L145, label %L147
L147:
  br label %L143
L143:
  %t400 = sext i32 0 to i64
  %t399 = icmp ne i64 %t400, 0
  br i1 %t399, label %L142, label %L144
L144:
  br label %L141
L141:
  %t401 = load i64, ptr %t378
  %t403 = sext i32 %t401 to i64
  %t404 = sext i32 61 to i64
  %t402 = icmp eq i64 %t403, %t404
  %t405 = zext i1 %t402 to i64
  %t406 = icmp ne i64 %t405, 0
  br i1 %t406, label %L149, label %L151
L149:
  br label %L152
L152:
  %t407 = call i8 @advance(ptr %t0)
  %t408 = sext i8 %t407 to i64
  br label %L155
L155:
  %t409 = sext i32 56 to i64
  store i64 %t409, ptr %t2
  %t410 = getelementptr [3 x i8], ptr @.str34, i64 0, i64 0
  %t411 = call ptr @strdup(ptr %t410)
  store ptr %t411, ptr %t2
  %t412 = load i64, ptr %t2
  %t413 = sext i32 %t412 to i64
  ret i64 %t413
L158:
  br label %L156
L156:
  %t415 = sext i32 0 to i64
  %t414 = icmp ne i64 %t415, 0
  br i1 %t414, label %L155, label %L157
L157:
  br label %L153
L153:
  %t417 = sext i32 0 to i64
  %t416 = icmp ne i64 %t417, 0
  br i1 %t416, label %L152, label %L154
L154:
  br label %L151
L151:
  br label %L159
L159:
  %t418 = sext i32 35 to i64
  store i64 %t418, ptr %t2
  %t419 = getelementptr [2 x i8], ptr @.str35, i64 0, i64 0
  %t420 = call ptr @strdup(ptr %t419)
  store ptr %t420, ptr %t2
  %t421 = load i64, ptr %t2
  %t422 = sext i32 %t421 to i64
  ret i64 %t422
L162:
  br label %L160
L160:
  %t424 = sext i32 0 to i64
  %t423 = icmp ne i64 %t424, 0
  br i1 %t423, label %L159, label %L161
L161:
  br label %L115
L115:
  %t425 = load i64, ptr %t378
  %t427 = sext i32 %t425 to i64
  %t428 = sext i32 45 to i64
  %t426 = icmp eq i64 %t427, %t428
  %t429 = zext i1 %t426 to i64
  %t430 = icmp ne i64 %t429, 0
  br i1 %t430, label %L163, label %L165
L163:
  br label %L166
L166:
  %t431 = call i8 @advance(ptr %t0)
  %t432 = sext i8 %t431 to i64
  br label %L169
L169:
  %t433 = sext i32 67 to i64
  store i64 %t433, ptr %t2
  %t434 = getelementptr [3 x i8], ptr @.str36, i64 0, i64 0
  %t435 = call ptr @strdup(ptr %t434)
  store ptr %t435, ptr %t2
  %t436 = load i64, ptr %t2
  %t437 = sext i32 %t436 to i64
  ret i64 %t437
L172:
  br label %L170
L170:
  %t439 = sext i32 0 to i64
  %t438 = icmp ne i64 %t439, 0
  br i1 %t438, label %L169, label %L171
L171:
  br label %L167
L167:
  %t441 = sext i32 0 to i64
  %t440 = icmp ne i64 %t441, 0
  br i1 %t440, label %L166, label %L168
L168:
  br label %L165
L165:
  %t442 = load i64, ptr %t378
  %t444 = sext i32 %t442 to i64
  %t445 = sext i32 61 to i64
  %t443 = icmp eq i64 %t444, %t445
  %t446 = zext i1 %t443 to i64
  %t447 = icmp ne i64 %t446, 0
  br i1 %t447, label %L173, label %L175
L173:
  br label %L176
L176:
  %t448 = call i8 @advance(ptr %t0)
  %t449 = sext i8 %t448 to i64
  br label %L179
L179:
  %t450 = sext i32 57 to i64
  store i64 %t450, ptr %t2
  %t451 = getelementptr [3 x i8], ptr @.str37, i64 0, i64 0
  %t452 = call ptr @strdup(ptr %t451)
  store ptr %t452, ptr %t2
  %t453 = load i64, ptr %t2
  %t454 = sext i32 %t453 to i64
  ret i64 %t454
L182:
  br label %L180
L180:
  %t456 = sext i32 0 to i64
  %t455 = icmp ne i64 %t456, 0
  br i1 %t455, label %L179, label %L181
L181:
  br label %L177
L177:
  %t458 = sext i32 0 to i64
  %t457 = icmp ne i64 %t458, 0
  br i1 %t457, label %L176, label %L178
L178:
  br label %L175
L175:
  %t459 = load i64, ptr %t378
  %t461 = sext i32 %t459 to i64
  %t462 = sext i32 62 to i64
  %t460 = icmp eq i64 %t461, %t462
  %t463 = zext i1 %t460 to i64
  %t464 = icmp ne i64 %t463, 0
  br i1 %t464, label %L183, label %L185
L183:
  br label %L186
L186:
  %t465 = call i8 @advance(ptr %t0)
  %t466 = sext i8 %t465 to i64
  br label %L189
L189:
  %t467 = sext i32 68 to i64
  store i64 %t467, ptr %t2
  %t468 = getelementptr [3 x i8], ptr @.str38, i64 0, i64 0
  %t469 = call ptr @strdup(ptr %t468)
  store ptr %t469, ptr %t2
  %t470 = load i64, ptr %t2
  %t471 = sext i32 %t470 to i64
  ret i64 %t471
L192:
  br label %L190
L190:
  %t473 = sext i32 0 to i64
  %t472 = icmp ne i64 %t473, 0
  br i1 %t472, label %L189, label %L191
L191:
  br label %L187
L187:
  %t475 = sext i32 0 to i64
  %t474 = icmp ne i64 %t475, 0
  br i1 %t474, label %L186, label %L188
L188:
  br label %L185
L185:
  br label %L193
L193:
  %t476 = sext i32 36 to i64
  store i64 %t476, ptr %t2
  %t477 = getelementptr [2 x i8], ptr @.str39, i64 0, i64 0
  %t478 = call ptr @strdup(ptr %t477)
  store ptr %t478, ptr %t2
  %t479 = load i64, ptr %t2
  %t480 = sext i32 %t479 to i64
  ret i64 %t480
L196:
  br label %L194
L194:
  %t482 = sext i32 0 to i64
  %t481 = icmp ne i64 %t482, 0
  br i1 %t481, label %L193, label %L195
L195:
  br label %L116
L116:
  %t483 = load i64, ptr %t378
  %t485 = sext i32 %t483 to i64
  %t486 = sext i32 61 to i64
  %t484 = icmp eq i64 %t485, %t486
  %t487 = zext i1 %t484 to i64
  %t488 = icmp ne i64 %t487, 0
  br i1 %t488, label %L197, label %L199
L197:
  br label %L200
L200:
  %t489 = call i8 @advance(ptr %t0)
  %t490 = sext i8 %t489 to i64
  br label %L203
L203:
  %t491 = sext i32 58 to i64
  store i64 %t491, ptr %t2
  %t492 = getelementptr [3 x i8], ptr @.str40, i64 0, i64 0
  %t493 = call ptr @strdup(ptr %t492)
  store ptr %t493, ptr %t2
  %t494 = load i64, ptr %t2
  %t495 = sext i32 %t494 to i64
  ret i64 %t495
L206:
  br label %L204
L204:
  %t497 = sext i32 0 to i64
  %t496 = icmp ne i64 %t497, 0
  br i1 %t496, label %L203, label %L205
L205:
  br label %L201
L201:
  %t499 = sext i32 0 to i64
  %t498 = icmp ne i64 %t499, 0
  br i1 %t498, label %L200, label %L202
L202:
  br label %L199
L199:
  br label %L207
L207:
  %t500 = sext i32 37 to i64
  store i64 %t500, ptr %t2
  %t501 = getelementptr [2 x i8], ptr @.str41, i64 0, i64 0
  %t502 = call ptr @strdup(ptr %t501)
  store ptr %t502, ptr %t2
  %t503 = load i64, ptr %t2
  %t504 = sext i32 %t503 to i64
  ret i64 %t504
L210:
  br label %L208
L208:
  %t506 = sext i32 0 to i64
  %t505 = icmp ne i64 %t506, 0
  br i1 %t505, label %L207, label %L209
L209:
  br label %L117
L117:
  %t507 = load i64, ptr %t378
  %t509 = sext i32 %t507 to i64
  %t510 = sext i32 61 to i64
  %t508 = icmp eq i64 %t509, %t510
  %t511 = zext i1 %t508 to i64
  %t512 = icmp ne i64 %t511, 0
  br i1 %t512, label %L211, label %L213
L211:
  br label %L214
L214:
  %t513 = call i8 @advance(ptr %t0)
  %t514 = sext i8 %t513 to i64
  br label %L217
L217:
  %t515 = sext i32 59 to i64
  store i64 %t515, ptr %t2
  %t516 = getelementptr [3 x i8], ptr @.str42, i64 0, i64 0
  %t517 = call ptr @strdup(ptr %t516)
  store ptr %t517, ptr %t2
  %t518 = load i64, ptr %t2
  %t519 = sext i32 %t518 to i64
  ret i64 %t519
L220:
  br label %L218
L218:
  %t521 = sext i32 0 to i64
  %t520 = icmp ne i64 %t521, 0
  br i1 %t520, label %L217, label %L219
L219:
  br label %L215
L215:
  %t523 = sext i32 0 to i64
  %t522 = icmp ne i64 %t523, 0
  br i1 %t522, label %L214, label %L216
L216:
  br label %L213
L213:
  br label %L221
L221:
  %t524 = sext i32 38 to i64
  store i64 %t524, ptr %t2
  %t525 = getelementptr [2 x i8], ptr @.str43, i64 0, i64 0
  %t526 = call ptr @strdup(ptr %t525)
  store ptr %t526, ptr %t2
  %t527 = load i64, ptr %t2
  %t528 = sext i32 %t527 to i64
  ret i64 %t528
L224:
  br label %L222
L222:
  %t530 = sext i32 0 to i64
  %t529 = icmp ne i64 %t530, 0
  br i1 %t529, label %L221, label %L223
L223:
  br label %L118
L118:
  %t531 = load i64, ptr %t378
  %t533 = sext i32 %t531 to i64
  %t534 = sext i32 61 to i64
  %t532 = icmp eq i64 %t533, %t534
  %t535 = zext i1 %t532 to i64
  %t536 = icmp ne i64 %t535, 0
  br i1 %t536, label %L225, label %L227
L225:
  br label %L228
L228:
  %t537 = call i8 @advance(ptr %t0)
  %t538 = sext i8 %t537 to i64
  br label %L231
L231:
  %t539 = sext i32 65 to i64
  store i64 %t539, ptr %t2
  %t540 = getelementptr [3 x i8], ptr @.str44, i64 0, i64 0
  %t541 = call ptr @strdup(ptr %t540)
  store ptr %t541, ptr %t2
  %t542 = load i64, ptr %t2
  %t543 = sext i32 %t542 to i64
  ret i64 %t543
L234:
  br label %L232
L232:
  %t545 = sext i32 0 to i64
  %t544 = icmp ne i64 %t545, 0
  br i1 %t544, label %L231, label %L233
L233:
  br label %L229
L229:
  %t547 = sext i32 0 to i64
  %t546 = icmp ne i64 %t547, 0
  br i1 %t546, label %L228, label %L230
L230:
  br label %L227
L227:
  br label %L235
L235:
  %t548 = sext i32 39 to i64
  store i64 %t548, ptr %t2
  %t549 = getelementptr [2 x i8], ptr @.str45, i64 0, i64 0
  %t550 = call ptr @strdup(ptr %t549)
  store ptr %t550, ptr %t2
  %t551 = load i64, ptr %t2
  %t552 = sext i32 %t551 to i64
  ret i64 %t552
L238:
  br label %L236
L236:
  %t554 = sext i32 0 to i64
  %t553 = icmp ne i64 %t554, 0
  br i1 %t553, label %L235, label %L237
L237:
  br label %L119
L119:
  %t555 = load i64, ptr %t378
  %t557 = sext i32 %t555 to i64
  %t558 = sext i32 38 to i64
  %t556 = icmp eq i64 %t557, %t558
  %t559 = zext i1 %t556 to i64
  %t560 = icmp ne i64 %t559, 0
  br i1 %t560, label %L239, label %L241
L239:
  br label %L242
L242:
  %t561 = call i8 @advance(ptr %t0)
  %t562 = sext i8 %t561 to i64
  br label %L245
L245:
  %t563 = sext i32 52 to i64
  store i64 %t563, ptr %t2
  %t564 = getelementptr [3 x i8], ptr @.str46, i64 0, i64 0
  %t565 = call ptr @strdup(ptr %t564)
  store ptr %t565, ptr %t2
  %t566 = load i64, ptr %t2
  %t567 = sext i32 %t566 to i64
  ret i64 %t567
L248:
  br label %L246
L246:
  %t569 = sext i32 0 to i64
  %t568 = icmp ne i64 %t569, 0
  br i1 %t568, label %L245, label %L247
L247:
  br label %L243
L243:
  %t571 = sext i32 0 to i64
  %t570 = icmp ne i64 %t571, 0
  br i1 %t570, label %L242, label %L244
L244:
  br label %L241
L241:
  %t572 = load i64, ptr %t378
  %t574 = sext i32 %t572 to i64
  %t575 = sext i32 61 to i64
  %t573 = icmp eq i64 %t574, %t575
  %t576 = zext i1 %t573 to i64
  %t577 = icmp ne i64 %t576, 0
  br i1 %t577, label %L249, label %L251
L249:
  br label %L252
L252:
  %t578 = call i8 @advance(ptr %t0)
  %t579 = sext i8 %t578 to i64
  br label %L255
L255:
  %t580 = sext i32 60 to i64
  store i64 %t580, ptr %t2
  %t581 = getelementptr [3 x i8], ptr @.str47, i64 0, i64 0
  %t582 = call ptr @strdup(ptr %t581)
  store ptr %t582, ptr %t2
  %t583 = load i64, ptr %t2
  %t584 = sext i32 %t583 to i64
  ret i64 %t584
L258:
  br label %L256
L256:
  %t586 = sext i32 0 to i64
  %t585 = icmp ne i64 %t586, 0
  br i1 %t585, label %L255, label %L257
L257:
  br label %L253
L253:
  %t588 = sext i32 0 to i64
  %t587 = icmp ne i64 %t588, 0
  br i1 %t587, label %L252, label %L254
L254:
  br label %L251
L251:
  br label %L259
L259:
  %t589 = sext i32 40 to i64
  store i64 %t589, ptr %t2
  %t590 = getelementptr [2 x i8], ptr @.str48, i64 0, i64 0
  %t591 = call ptr @strdup(ptr %t590)
  store ptr %t591, ptr %t2
  %t592 = load i64, ptr %t2
  %t593 = sext i32 %t592 to i64
  ret i64 %t593
L262:
  br label %L260
L260:
  %t595 = sext i32 0 to i64
  %t594 = icmp ne i64 %t595, 0
  br i1 %t594, label %L259, label %L261
L261:
  br label %L120
L120:
  %t596 = load i64, ptr %t378
  %t598 = sext i32 %t596 to i64
  %t599 = sext i32 124 to i64
  %t597 = icmp eq i64 %t598, %t599
  %t600 = zext i1 %t597 to i64
  %t601 = icmp ne i64 %t600, 0
  br i1 %t601, label %L263, label %L265
L263:
  br label %L266
L266:
  %t602 = call i8 @advance(ptr %t0)
  %t603 = sext i8 %t602 to i64
  br label %L269
L269:
  %t604 = sext i32 53 to i64
  store i64 %t604, ptr %t2
  %t605 = getelementptr [3 x i8], ptr @.str49, i64 0, i64 0
  %t606 = call ptr @strdup(ptr %t605)
  store ptr %t606, ptr %t2
  %t607 = load i64, ptr %t2
  %t608 = sext i32 %t607 to i64
  ret i64 %t608
L272:
  br label %L270
L270:
  %t610 = sext i32 0 to i64
  %t609 = icmp ne i64 %t610, 0
  br i1 %t609, label %L269, label %L271
L271:
  br label %L267
L267:
  %t612 = sext i32 0 to i64
  %t611 = icmp ne i64 %t612, 0
  br i1 %t611, label %L266, label %L268
L268:
  br label %L265
L265:
  %t613 = load i64, ptr %t378
  %t615 = sext i32 %t613 to i64
  %t616 = sext i32 61 to i64
  %t614 = icmp eq i64 %t615, %t616
  %t617 = zext i1 %t614 to i64
  %t618 = icmp ne i64 %t617, 0
  br i1 %t618, label %L273, label %L275
L273:
  br label %L276
L276:
  %t619 = call i8 @advance(ptr %t0)
  %t620 = sext i8 %t619 to i64
  br label %L279
L279:
  %t621 = sext i32 61 to i64
  store i64 %t621, ptr %t2
  %t622 = getelementptr [3 x i8], ptr @.str50, i64 0, i64 0
  %t623 = call ptr @strdup(ptr %t622)
  store ptr %t623, ptr %t2
  %t624 = load i64, ptr %t2
  %t625 = sext i32 %t624 to i64
  ret i64 %t625
L282:
  br label %L280
L280:
  %t627 = sext i32 0 to i64
  %t626 = icmp ne i64 %t627, 0
  br i1 %t626, label %L279, label %L281
L281:
  br label %L277
L277:
  %t629 = sext i32 0 to i64
  %t628 = icmp ne i64 %t629, 0
  br i1 %t628, label %L276, label %L278
L278:
  br label %L275
L275:
  br label %L283
L283:
  %t630 = sext i32 41 to i64
  store i64 %t630, ptr %t2
  %t631 = getelementptr [2 x i8], ptr @.str51, i64 0, i64 0
  %t632 = call ptr @strdup(ptr %t631)
  store ptr %t632, ptr %t2
  %t633 = load i64, ptr %t2
  %t634 = sext i32 %t633 to i64
  ret i64 %t634
L286:
  br label %L284
L284:
  %t636 = sext i32 0 to i64
  %t635 = icmp ne i64 %t636, 0
  br i1 %t635, label %L283, label %L285
L285:
  br label %L121
L121:
  %t637 = load i64, ptr %t378
  %t639 = sext i32 %t637 to i64
  %t640 = sext i32 61 to i64
  %t638 = icmp eq i64 %t639, %t640
  %t641 = zext i1 %t638 to i64
  %t642 = icmp ne i64 %t641, 0
  br i1 %t642, label %L287, label %L289
L287:
  br label %L290
L290:
  %t643 = call i8 @advance(ptr %t0)
  %t644 = sext i8 %t643 to i64
  br label %L293
L293:
  %t645 = sext i32 62 to i64
  store i64 %t645, ptr %t2
  %t646 = getelementptr [3 x i8], ptr @.str52, i64 0, i64 0
  %t647 = call ptr @strdup(ptr %t646)
  store ptr %t647, ptr %t2
  %t648 = load i64, ptr %t2
  %t649 = sext i32 %t648 to i64
  ret i64 %t649
L296:
  br label %L294
L294:
  %t651 = sext i32 0 to i64
  %t650 = icmp ne i64 %t651, 0
  br i1 %t650, label %L293, label %L295
L295:
  br label %L291
L291:
  %t653 = sext i32 0 to i64
  %t652 = icmp ne i64 %t653, 0
  br i1 %t652, label %L290, label %L292
L292:
  br label %L289
L289:
  br label %L297
L297:
  %t654 = sext i32 42 to i64
  store i64 %t654, ptr %t2
  %t655 = getelementptr [2 x i8], ptr @.str53, i64 0, i64 0
  %t656 = call ptr @strdup(ptr %t655)
  store ptr %t656, ptr %t2
  %t657 = load i64, ptr %t2
  %t658 = sext i32 %t657 to i64
  ret i64 %t658
L300:
  br label %L298
L298:
  %t660 = sext i32 0 to i64
  %t659 = icmp ne i64 %t660, 0
  br i1 %t659, label %L297, label %L299
L299:
  br label %L122
L122:
  br label %L301
L301:
  %t661 = sext i32 43 to i64
  store i64 %t661, ptr %t2
  %t662 = getelementptr [2 x i8], ptr @.str54, i64 0, i64 0
  %t663 = call ptr @strdup(ptr %t662)
  store ptr %t663, ptr %t2
  %t664 = load i64, ptr %t2
  %t665 = sext i32 %t664 to i64
  ret i64 %t665
L304:
  br label %L302
L302:
  %t667 = sext i32 0 to i64
  %t666 = icmp ne i64 %t667, 0
  br i1 %t666, label %L301, label %L303
L303:
  br label %L123
L123:
  %t668 = load i64, ptr %t378
  %t670 = sext i32 %t668 to i64
  %t671 = sext i32 60 to i64
  %t669 = icmp eq i64 %t670, %t671
  %t672 = zext i1 %t669 to i64
  %t673 = icmp ne i64 %t672, 0
  br i1 %t673, label %L305, label %L307
L305:
  %t674 = call i8 @advance(ptr %t0)
  %t675 = sext i8 %t674 to i64
  %t676 = call i8 @cur(ptr %t0)
  %t677 = sext i8 %t676 to i64
  %t679 = sext i32 61 to i64
  %t678 = icmp eq i64 %t677, %t679
  %t680 = zext i1 %t678 to i64
  %t681 = icmp ne i64 %t680, 0
  br i1 %t681, label %L308, label %L310
L308:
  br label %L311
L311:
  %t682 = call i8 @advance(ptr %t0)
  %t683 = sext i8 %t682 to i64
  br label %L314
L314:
  %t684 = sext i32 63 to i64
  store i64 %t684, ptr %t2
  %t685 = getelementptr [4 x i8], ptr @.str55, i64 0, i64 0
  %t686 = call ptr @strdup(ptr %t685)
  store ptr %t686, ptr %t2
  %t687 = load i64, ptr %t2
  %t688 = sext i32 %t687 to i64
  ret i64 %t688
L317:
  br label %L315
L315:
  %t690 = sext i32 0 to i64
  %t689 = icmp ne i64 %t690, 0
  br i1 %t689, label %L314, label %L316
L316:
  br label %L312
L312:
  %t692 = sext i32 0 to i64
  %t691 = icmp ne i64 %t692, 0
  br i1 %t691, label %L311, label %L313
L313:
  br label %L310
L310:
  br label %L318
L318:
  %t693 = sext i32 44 to i64
  store i64 %t693, ptr %t2
  %t694 = getelementptr [3 x i8], ptr @.str56, i64 0, i64 0
  %t695 = call ptr @strdup(ptr %t694)
  store ptr %t695, ptr %t2
  %t696 = load i64, ptr %t2
  %t697 = sext i32 %t696 to i64
  ret i64 %t697
L321:
  br label %L319
L319:
  %t699 = sext i32 0 to i64
  %t698 = icmp ne i64 %t699, 0
  br i1 %t698, label %L318, label %L320
L320:
  br label %L307
L307:
  %t700 = load i64, ptr %t378
  %t702 = sext i32 %t700 to i64
  %t703 = sext i32 61 to i64
  %t701 = icmp eq i64 %t702, %t703
  %t704 = zext i1 %t701 to i64
  %t705 = icmp ne i64 %t704, 0
  br i1 %t705, label %L322, label %L324
L322:
  br label %L325
L325:
  %t706 = call i8 @advance(ptr %t0)
  %t707 = sext i8 %t706 to i64
  br label %L328
L328:
  %t708 = sext i32 50 to i64
  store i64 %t708, ptr %t2
  %t709 = getelementptr [3 x i8], ptr @.str57, i64 0, i64 0
  %t710 = call ptr @strdup(ptr %t709)
  store ptr %t710, ptr %t2
  %t711 = load i64, ptr %t2
  %t712 = sext i32 %t711 to i64
  ret i64 %t712
L331:
  br label %L329
L329:
  %t714 = sext i32 0 to i64
  %t713 = icmp ne i64 %t714, 0
  br i1 %t713, label %L328, label %L330
L330:
  br label %L326
L326:
  %t716 = sext i32 0 to i64
  %t715 = icmp ne i64 %t716, 0
  br i1 %t715, label %L325, label %L327
L327:
  br label %L324
L324:
  br label %L332
L332:
  %t717 = sext i32 48 to i64
  store i64 %t717, ptr %t2
  %t718 = getelementptr [2 x i8], ptr @.str58, i64 0, i64 0
  %t719 = call ptr @strdup(ptr %t718)
  store ptr %t719, ptr %t2
  %t720 = load i64, ptr %t2
  %t721 = sext i32 %t720 to i64
  ret i64 %t721
L335:
  br label %L333
L333:
  %t723 = sext i32 0 to i64
  %t722 = icmp ne i64 %t723, 0
  br i1 %t722, label %L332, label %L334
L334:
  br label %L124
L124:
  %t724 = load i64, ptr %t378
  %t726 = sext i32 %t724 to i64
  %t727 = sext i32 62 to i64
  %t725 = icmp eq i64 %t726, %t727
  %t728 = zext i1 %t725 to i64
  %t729 = icmp ne i64 %t728, 0
  br i1 %t729, label %L336, label %L338
L336:
  %t730 = call i8 @advance(ptr %t0)
  %t731 = sext i8 %t730 to i64
  %t732 = call i8 @cur(ptr %t0)
  %t733 = sext i8 %t732 to i64
  %t735 = sext i32 61 to i64
  %t734 = icmp eq i64 %t733, %t735
  %t736 = zext i1 %t734 to i64
  %t737 = icmp ne i64 %t736, 0
  br i1 %t737, label %L339, label %L341
L339:
  br label %L342
L342:
  %t738 = call i8 @advance(ptr %t0)
  %t739 = sext i8 %t738 to i64
  br label %L345
L345:
  %t740 = sext i32 64 to i64
  store i64 %t740, ptr %t2
  %t741 = getelementptr [4 x i8], ptr @.str59, i64 0, i64 0
  %t742 = call ptr @strdup(ptr %t741)
  store ptr %t742, ptr %t2
  %t743 = load i64, ptr %t2
  %t744 = sext i32 %t743 to i64
  ret i64 %t744
L348:
  br label %L346
L346:
  %t746 = sext i32 0 to i64
  %t745 = icmp ne i64 %t746, 0
  br i1 %t745, label %L345, label %L347
L347:
  br label %L343
L343:
  %t748 = sext i32 0 to i64
  %t747 = icmp ne i64 %t748, 0
  br i1 %t747, label %L342, label %L344
L344:
  br label %L341
L341:
  br label %L349
L349:
  %t749 = sext i32 45 to i64
  store i64 %t749, ptr %t2
  %t750 = getelementptr [3 x i8], ptr @.str60, i64 0, i64 0
  %t751 = call ptr @strdup(ptr %t750)
  store ptr %t751, ptr %t2
  %t752 = load i64, ptr %t2
  %t753 = sext i32 %t752 to i64
  ret i64 %t753
L352:
  br label %L350
L350:
  %t755 = sext i32 0 to i64
  %t754 = icmp ne i64 %t755, 0
  br i1 %t754, label %L349, label %L351
L351:
  br label %L338
L338:
  %t756 = load i64, ptr %t378
  %t758 = sext i32 %t756 to i64
  %t759 = sext i32 61 to i64
  %t757 = icmp eq i64 %t758, %t759
  %t760 = zext i1 %t757 to i64
  %t761 = icmp ne i64 %t760, 0
  br i1 %t761, label %L353, label %L355
L353:
  br label %L356
L356:
  %t762 = call i8 @advance(ptr %t0)
  %t763 = sext i8 %t762 to i64
  br label %L359
L359:
  %t764 = sext i32 51 to i64
  store i64 %t764, ptr %t2
  %t765 = getelementptr [3 x i8], ptr @.str61, i64 0, i64 0
  %t766 = call ptr @strdup(ptr %t765)
  store ptr %t766, ptr %t2
  %t767 = load i64, ptr %t2
  %t768 = sext i32 %t767 to i64
  ret i64 %t768
L362:
  br label %L360
L360:
  %t770 = sext i32 0 to i64
  %t769 = icmp ne i64 %t770, 0
  br i1 %t769, label %L359, label %L361
L361:
  br label %L357
L357:
  %t772 = sext i32 0 to i64
  %t771 = icmp ne i64 %t772, 0
  br i1 %t771, label %L356, label %L358
L358:
  br label %L355
L355:
  br label %L363
L363:
  %t773 = sext i32 49 to i64
  store i64 %t773, ptr %t2
  %t774 = getelementptr [2 x i8], ptr @.str62, i64 0, i64 0
  %t775 = call ptr @strdup(ptr %t774)
  store ptr %t775, ptr %t2
  %t776 = load i64, ptr %t2
  %t777 = sext i32 %t776 to i64
  ret i64 %t777
L366:
  br label %L364
L364:
  %t779 = sext i32 0 to i64
  %t778 = icmp ne i64 %t779, 0
  br i1 %t778, label %L363, label %L365
L365:
  br label %L125
L125:
  %t780 = load i64, ptr %t378
  %t782 = sext i32 %t780 to i64
  %t783 = sext i32 61 to i64
  %t781 = icmp eq i64 %t782, %t783
  %t784 = zext i1 %t781 to i64
  %t785 = icmp ne i64 %t784, 0
  br i1 %t785, label %L367, label %L369
L367:
  br label %L370
L370:
  %t786 = call i8 @advance(ptr %t0)
  %t787 = sext i8 %t786 to i64
  br label %L373
L373:
  %t788 = sext i32 46 to i64
  store i64 %t788, ptr %t2
  %t789 = getelementptr [3 x i8], ptr @.str63, i64 0, i64 0
  %t790 = call ptr @strdup(ptr %t789)
  store ptr %t790, ptr %t2
  %t791 = load i64, ptr %t2
  %t792 = sext i32 %t791 to i64
  ret i64 %t792
L376:
  br label %L374
L374:
  %t794 = sext i32 0 to i64
  %t793 = icmp ne i64 %t794, 0
  br i1 %t793, label %L373, label %L375
L375:
  br label %L371
L371:
  %t796 = sext i32 0 to i64
  %t795 = icmp ne i64 %t796, 0
  br i1 %t795, label %L370, label %L372
L372:
  br label %L369
L369:
  br label %L377
L377:
  %t797 = sext i32 55 to i64
  store i64 %t797, ptr %t2
  %t798 = getelementptr [2 x i8], ptr @.str64, i64 0, i64 0
  %t799 = call ptr @strdup(ptr %t798)
  store ptr %t799, ptr %t2
  %t800 = load i64, ptr %t2
  %t801 = sext i32 %t800 to i64
  ret i64 %t801
L380:
  br label %L378
L378:
  %t803 = sext i32 0 to i64
  %t802 = icmp ne i64 %t803, 0
  br i1 %t802, label %L377, label %L379
L379:
  br label %L126
L126:
  %t804 = load i64, ptr %t378
  %t806 = sext i32 %t804 to i64
  %t807 = sext i32 61 to i64
  %t805 = icmp eq i64 %t806, %t807
  %t808 = zext i1 %t805 to i64
  %t809 = icmp ne i64 %t808, 0
  br i1 %t809, label %L381, label %L383
L381:
  br label %L384
L384:
  %t810 = call i8 @advance(ptr %t0)
  %t811 = sext i8 %t810 to i64
  br label %L387
L387:
  %t812 = sext i32 47 to i64
  store i64 %t812, ptr %t2
  %t813 = getelementptr [3 x i8], ptr @.str65, i64 0, i64 0
  %t814 = call ptr @strdup(ptr %t813)
  store ptr %t814, ptr %t2
  %t815 = load i64, ptr %t2
  %t816 = sext i32 %t815 to i64
  ret i64 %t816
L390:
  br label %L388
L388:
  %t818 = sext i32 0 to i64
  %t817 = icmp ne i64 %t818, 0
  br i1 %t817, label %L387, label %L389
L389:
  br label %L385
L385:
  %t820 = sext i32 0 to i64
  %t819 = icmp ne i64 %t820, 0
  br i1 %t819, label %L384, label %L386
L386:
  br label %L383
L383:
  br label %L391
L391:
  %t821 = sext i32 54 to i64
  store i64 %t821, ptr %t2
  %t822 = getelementptr [2 x i8], ptr @.str66, i64 0, i64 0
  %t823 = call ptr @strdup(ptr %t822)
  store ptr %t823, ptr %t2
  %t824 = load i64, ptr %t2
  %t825 = sext i32 %t824 to i64
  ret i64 %t825
L394:
  br label %L392
L392:
  %t827 = sext i32 0 to i64
  %t826 = icmp ne i64 %t827, 0
  br i1 %t826, label %L391, label %L393
L393:
  br label %L127
L127:
  %t828 = load i64, ptr %t378
  %t830 = sext i32 %t828 to i64
  %t831 = sext i32 46 to i64
  %t829 = icmp eq i64 %t830, %t831
  %t832 = zext i1 %t829 to i64
  %t833 = icmp ne i64 %t832, 0
  br i1 %t833, label %L395, label %L396
L395:
  %t834 = load ptr, ptr %t0
  %t835 = load ptr, ptr %t0
  %t837 = ptrtoint ptr %t835 to i64
  %t838 = sext i32 1 to i64
  %t839 = inttoptr i64 %t837 to ptr
  %t836 = getelementptr i8, ptr %t839, i64 %t838
  %t840 = ptrtoint ptr %t836 to i64
  %t841 = getelementptr ptr, ptr %t834, i64 %t840
  %t842 = load ptr, ptr %t841
  %t844 = ptrtoint ptr %t842 to i64
  %t845 = sext i32 46 to i64
  %t843 = icmp eq i64 %t844, %t845
  %t846 = zext i1 %t843 to i64
  %t847 = icmp ne i64 %t846, 0
  %t848 = zext i1 %t847 to i64
  br label %L397
L396:
  br label %L397
L397:
  %t849 = phi i64 [ %t848, %L395 ], [ 0, %L396 ]
  %t850 = icmp ne i64 %t849, 0
  br i1 %t850, label %L398, label %L400
L398:
  %t851 = call i8 @advance(ptr %t0)
  %t852 = sext i8 %t851 to i64
  %t853 = call i8 @advance(ptr %t0)
  %t854 = sext i8 %t853 to i64
  br label %L401
L401:
  %t855 = sext i32 80 to i64
  store i64 %t855, ptr %t2
  %t856 = getelementptr [4 x i8], ptr @.str67, i64 0, i64 0
  %t857 = call ptr @strdup(ptr %t856)
  store ptr %t857, ptr %t2
  %t858 = load i64, ptr %t2
  %t859 = sext i32 %t858 to i64
  ret i64 %t859
L404:
  br label %L402
L402:
  %t861 = sext i32 0 to i64
  %t860 = icmp ne i64 %t861, 0
  br i1 %t860, label %L401, label %L403
L403:
  br label %L400
L400:
  br label %L405
L405:
  %t862 = sext i32 69 to i64
  store i64 %t862, ptr %t2
  %t863 = getelementptr [2 x i8], ptr @.str68, i64 0, i64 0
  %t864 = call ptr @strdup(ptr %t863)
  store ptr %t864, ptr %t2
  %t865 = load i64, ptr %t2
  %t866 = sext i32 %t865 to i64
  ret i64 %t866
L408:
  br label %L406
L406:
  %t868 = sext i32 0 to i64
  %t867 = icmp ne i64 %t868, 0
  br i1 %t867, label %L405, label %L407
L407:
  br label %L128
L128:
  br label %L409
L409:
  %t869 = sext i32 72 to i64
  store i64 %t869, ptr %t2
  %t870 = getelementptr [2 x i8], ptr @.str69, i64 0, i64 0
  %t871 = call ptr @strdup(ptr %t870)
  store ptr %t871, ptr %t2
  %t872 = load i64, ptr %t2
  %t873 = sext i32 %t872 to i64
  ret i64 %t873
L412:
  br label %L410
L410:
  %t875 = sext i32 0 to i64
  %t874 = icmp ne i64 %t875, 0
  br i1 %t874, label %L409, label %L411
L411:
  br label %L129
L129:
  br label %L413
L413:
  %t876 = sext i32 73 to i64
  store i64 %t876, ptr %t2
  %t877 = getelementptr [2 x i8], ptr @.str70, i64 0, i64 0
  %t878 = call ptr @strdup(ptr %t877)
  store ptr %t878, ptr %t2
  %t879 = load i64, ptr %t2
  %t880 = sext i32 %t879 to i64
  ret i64 %t880
L416:
  br label %L414
L414:
  %t882 = sext i32 0 to i64
  %t881 = icmp ne i64 %t882, 0
  br i1 %t881, label %L413, label %L415
L415:
  br label %L130
L130:
  br label %L417
L417:
  %t883 = sext i32 74 to i64
  store i64 %t883, ptr %t2
  %t884 = getelementptr [2 x i8], ptr @.str71, i64 0, i64 0
  %t885 = call ptr @strdup(ptr %t884)
  store ptr %t885, ptr %t2
  %t886 = load i64, ptr %t2
  %t887 = sext i32 %t886 to i64
  ret i64 %t887
L420:
  br label %L418
L418:
  %t889 = sext i32 0 to i64
  %t888 = icmp ne i64 %t889, 0
  br i1 %t888, label %L417, label %L419
L419:
  br label %L131
L131:
  br label %L421
L421:
  %t890 = sext i32 75 to i64
  store i64 %t890, ptr %t2
  %t891 = getelementptr [2 x i8], ptr @.str72, i64 0, i64 0
  %t892 = call ptr @strdup(ptr %t891)
  store ptr %t892, ptr %t2
  %t893 = load i64, ptr %t2
  %t894 = sext i32 %t893 to i64
  ret i64 %t894
L424:
  br label %L422
L422:
  %t896 = sext i32 0 to i64
  %t895 = icmp ne i64 %t896, 0
  br i1 %t895, label %L421, label %L423
L423:
  br label %L132
L132:
  br label %L425
L425:
  %t897 = sext i32 76 to i64
  store i64 %t897, ptr %t2
  %t898 = getelementptr [2 x i8], ptr @.str73, i64 0, i64 0
  %t899 = call ptr @strdup(ptr %t898)
  store ptr %t899, ptr %t2
  %t900 = load i64, ptr %t2
  %t901 = sext i32 %t900 to i64
  ret i64 %t901
L428:
  br label %L426
L426:
  %t903 = sext i32 0 to i64
  %t902 = icmp ne i64 %t903, 0
  br i1 %t902, label %L425, label %L427
L427:
  br label %L133
L133:
  br label %L429
L429:
  %t904 = sext i32 77 to i64
  store i64 %t904, ptr %t2
  %t905 = getelementptr [2 x i8], ptr @.str74, i64 0, i64 0
  %t906 = call ptr @strdup(ptr %t905)
  store ptr %t906, ptr %t2
  %t907 = load i64, ptr %t2
  %t908 = sext i32 %t907 to i64
  ret i64 %t908
L432:
  br label %L430
L430:
  %t910 = sext i32 0 to i64
  %t909 = icmp ne i64 %t910, 0
  br i1 %t909, label %L429, label %L431
L431:
  br label %L134
L134:
  br label %L433
L433:
  %t911 = sext i32 78 to i64
  store i64 %t911, ptr %t2
  %t912 = getelementptr [2 x i8], ptr @.str75, i64 0, i64 0
  %t913 = call ptr @strdup(ptr %t912)
  store ptr %t913, ptr %t2
  %t914 = load i64, ptr %t2
  %t915 = sext i32 %t914 to i64
  ret i64 %t915
L436:
  br label %L434
L434:
  %t917 = sext i32 0 to i64
  %t916 = icmp ne i64 %t917, 0
  br i1 %t916, label %L433, label %L435
L435:
  br label %L135
L135:
  br label %L437
L437:
  %t918 = sext i32 79 to i64
  store i64 %t918, ptr %t2
  %t919 = getelementptr [2 x i8], ptr @.str76, i64 0, i64 0
  %t920 = call ptr @strdup(ptr %t919)
  store ptr %t920, ptr %t2
  %t921 = load i64, ptr %t2
  %t922 = sext i32 %t921 to i64
  ret i64 %t922
L440:
  br label %L438
L438:
  %t924 = sext i32 0 to i64
  %t923 = icmp ne i64 %t924, 0
  br i1 %t923, label %L437, label %L439
L439:
  br label %L136
L136:
  br label %L441
L441:
  %t925 = sext i32 70 to i64
  store i64 %t925, ptr %t2
  %t926 = getelementptr [2 x i8], ptr @.str77, i64 0, i64 0
  %t927 = call ptr @strdup(ptr %t926)
  store ptr %t927, ptr %t2
  %t928 = load i64, ptr %t2
  %t929 = sext i32 %t928 to i64
  ret i64 %t929
L444:
  br label %L442
L442:
  %t931 = sext i32 0 to i64
  %t930 = icmp ne i64 %t931, 0
  br i1 %t930, label %L441, label %L443
L443:
  br label %L137
L137:
  br label %L445
L445:
  %t932 = sext i32 71 to i64
  store i64 %t932, ptr %t2
  %t933 = getelementptr [2 x i8], ptr @.str78, i64 0, i64 0
  %t934 = call ptr @strdup(ptr %t933)
  store ptr %t934, ptr %t2
  %t935 = load i64, ptr %t2
  %t936 = sext i32 %t935 to i64
  ret i64 %t936
L448:
  br label %L446
L446:
  %t938 = sext i32 0 to i64
  %t937 = icmp ne i64 %t938, 0
  br i1 %t937, label %L445, label %L447
L447:
  br label %L113
L138:
  %t939 = sext i32 82 to i64
  store i64 %t939, ptr %t2
  %t940 = call ptr @malloc(i64 2)
  store ptr %t940, ptr %t2
  %t941 = load i64, ptr %t375
  %t942 = load ptr, ptr %t2
  %t944 = sext i32 0 to i64
  %t943 = getelementptr ptr, ptr %t942, i64 %t944
  %t945 = sext i32 %t941 to i64
  store i64 %t945, ptr %t943
  %t946 = load ptr, ptr %t2
  %t948 = sext i32 1 to i64
  %t947 = getelementptr ptr, ptr %t946, i64 %t948
  %t949 = sext i32 0 to i64
  store i64 %t949, ptr %t947
  %t950 = load i64, ptr %t2
  %t951 = sext i32 %t950 to i64
  ret i64 %t951
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
