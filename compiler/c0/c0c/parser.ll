; ModuleID = 'parser.c'
source_filename = "parser.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@lexer_new = dso_local global ptr zeroinitializer
@lexer_free = dso_local global ptr zeroinitializer
@lexer_next = dso_local global ptr zeroinitializer
@lexer_peek = dso_local global ptr zeroinitializer
@token_free = dso_local global ptr zeroinitializer
@token_type_name = dso_local global ptr zeroinitializer
@node_new = dso_local global ptr zeroinitializer
@node_free = dso_local global ptr zeroinitializer
@node_add_child = dso_local global ptr zeroinitializer
@type_new = dso_local global ptr zeroinitializer
@type_ptr = dso_local global ptr zeroinitializer
@type_array = dso_local global ptr zeroinitializer
@type_free = dso_local global ptr zeroinitializer
@type_is_integer = dso_local global ptr zeroinitializer
@type_is_float = dso_local global ptr zeroinitializer
@type_is_pointer = dso_local global ptr zeroinitializer
@type_size = dso_local global ptr zeroinitializer
@parser_new = dso_local global ptr zeroinitializer
@parser_free = dso_local global ptr zeroinitializer
@parser_parse = dso_local global ptr zeroinitializer
@parse_expr = internal global ptr zeroinitializer
@parse_stmt = internal global ptr zeroinitializer
@parse_initializer = internal global ptr zeroinitializer
@parse_type_specifier = internal global ptr zeroinitializer
@parse_declarator = internal global ptr zeroinitializer
@parse_primary = internal global ptr zeroinitializer
@parse_postfix = internal global ptr zeroinitializer
@parse_unary = internal global ptr zeroinitializer
@parse_cast = internal global ptr zeroinitializer
@parse_mul = internal global ptr zeroinitializer
@parse_add = internal global ptr zeroinitializer
@parse_shift = internal global ptr zeroinitializer
@parse_relational = internal global ptr zeroinitializer
@parse_equality = internal global ptr zeroinitializer
@parse_bitand = internal global ptr zeroinitializer
@parse_bitxor = internal global ptr zeroinitializer
@parse_bitor = internal global ptr zeroinitializer
@parse_logand = internal global ptr zeroinitializer
@parse_logor = internal global ptr zeroinitializer
@parse_ternary = internal global ptr zeroinitializer
@parse_assign = internal global ptr zeroinitializer
@parse_block = internal global ptr zeroinitializer

define internal void @p_error(ptr %0, ptr %2) {
entry:
  %4 = getelementptr [38 x i8], ptr @.str0, i64 0, i64 0
  %5 = load i64, ptr %0
  %6 = load i64, ptr %0
  %7 = icmp ne i64 %6, 0
  br i1 %7, label %L0, label %L1
L0:
  %8 = load i64, ptr %0
  br label %L2
L1:
  %9 = getelementptr [2 x i8], ptr @.str1, i64 0, i64 0
  br label %L2
L2:
  %10 = phi i64 [ %8, %L0 ], [ %9, %L1 ]
  %11 = call i32 @fprintf(ptr @stderr, ptr %4, i32 %5, ptr %2, i32 %10)
  %12 = call i32 @exit(i32 1)
  ret void
}

define internal void @advance(ptr %0) {
entry:
  %2 = load i64, ptr %0
  call void @token_free(i32 %2)
  %4 = load i64, ptr %0
  %5 = call i64 @lexer_next(i32 %4)
  store i64 %5, ptr %0
  ret void
}

define internal i64 @peek(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %3 = call i64 @lexer_peek(i32 %2)
  ret i64 %3
L0:
  ret i64 0
}

define internal i32 @check(ptr %0, i64 %2) {
entry:
  %4 = load i64, ptr %0
  %6 = sext i32 %4 to i64
  %7 = sext i32 %2 to i64
  %5 = icmp eq i64 %6, %7
  %8 = zext i1 %5 to i64
  ret i32 %8
L0:
  ret i32 0
}

define internal i32 @match(ptr %0, i64 %2) {
entry:
  %4 = call i32 @check(ptr %0, i64 %2)
  %5 = icmp ne i64 %4, 0
  br i1 %5, label %L0, label %L2
L0:
  call void @advance(ptr %0)
  ret i32 1
L3:
  br label %L2
L2:
  ret i32 0
L4:
  ret i32 0
}

define internal void @expect(ptr %0, i64 %2) {
entry:
  %4 = call i32 @check(ptr %0, i64 %2)
  %6 = icmp eq i64 %4, 0
  %5 = zext i1 %6 to i64
  %7 = icmp ne i64 %5, 0
  br i1 %7, label %L0, label %L2
L0:
  %8 = alloca ptr
  %10 = load ptr, ptr %8
  %11 = getelementptr [12 x i8], ptr @.str2, i64 0, i64 0
  %12 = call ptr @token_type_name(i64 %2)
  %13 = call i32 @snprintf(ptr %10, i32 8, ptr %11, ptr %12)
  %14 = load ptr, ptr %8
  call void @p_error(ptr %0, ptr %14)
  br label %L2
L2:
  call void @advance(ptr %0)
  ret void
}

define internal ptr @expect_ident(ptr %0) {
entry:
  %2 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %4 = icmp eq i64 %2, 0
  %3 = zext i1 %4 to i64
  %5 = icmp ne i64 %3, 0
  br i1 %5, label %L0, label %L2
L0:
  %6 = getelementptr [20 x i8], ptr @.str3, i64 0, i64 0
  call void @p_error(ptr %0, ptr %6)
  br label %L2
L2:
  %8 = alloca ptr
  %10 = load i64, ptr %0
  %11 = call i32 @strdup(i32 %10)
  store ptr %11, ptr %8
  call void @advance(ptr %0)
  %13 = load ptr, ptr %8
  ret ptr %13
L3:
  ret ptr 0
}

define internal void @register_typedef(ptr %0, ptr %2, ptr %4) {
entry:
  %6 = load i64, ptr %0
  %8 = sext i32 %6 to i64
  %9 = sext i32 512 to i64
  %7 = icmp sge i64 %8, %9
  %10 = zext i1 %7 to i64
  %11 = icmp ne i64 %10, 0
  br i1 %11, label %L0, label %L2
L0:
  %12 = getelementptr [18 x i8], ptr @.str4, i64 0, i64 0
  call void @p_error(ptr %0, ptr %12)
  br label %L2
L2:
  %14 = call i32 @strdup(ptr %2)
  %15 = load i64, ptr %0
  %16 = load i64, ptr %0
  %17 = getelementptr i8, ptr %15, i64 %16
  store i32 %14, ptr %17
  %18 = load i64, ptr %0
  %19 = load i64, ptr %0
  %20 = getelementptr i8, ptr %18, i64 %19
  store ptr %4, ptr %20
  %21 = load i64, ptr %0
  %23 = sext i32 %21 to i64
  %22 = add i64 %23, 1
  store i64 %22, ptr %0
  ret void
}

define internal ptr @lookup_typedef(ptr %0, ptr %2) {
entry:
  %4 = alloca i32
  %6 = load i64, ptr %0
  %8 = sext i32 %6 to i64
  %9 = sext i32 1 to i64
  %7 = sub i64 %8, %9
  store i32 %7, ptr %4
  br label %L0
L0:
  %10 = load i32, ptr %4
  %12 = sext i32 %10 to i64
  %13 = sext i32 0 to i64
  %11 = icmp sge i64 %12, %13
  %14 = zext i1 %11 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %L1, label %L3
L1:
  %16 = load i64, ptr %0
  %17 = load i32, ptr %4
  %18 = getelementptr i8, ptr %16, i64 %17
  %19 = load i64, ptr %18
  %20 = call i32 @strcmp(i32 %19, ptr %2)
  %22 = sext i32 %20 to i64
  %23 = sext i32 0 to i64
  %21 = icmp eq i64 %22, %23
  %24 = zext i1 %21 to i64
  %25 = icmp ne i64 %24, 0
  br i1 %25, label %L4, label %L6
L4:
  %26 = load i64, ptr %0
  %27 = load i32, ptr %4
  %28 = getelementptr i8, ptr %26, i64 %27
  %29 = load i64, ptr %28
  ret ptr %29
L7:
  br label %L6
L6:
  br label %L2
L2:
  %30 = load i32, ptr %4
  %32 = sext i32 %30 to i64
  %31 = sub i64 %32, 1
  store i64 %31, ptr %4
  br label %L0
L3:
  %33 = inttoptr i64 0 to ptr
  ret ptr %33
L8:
  ret ptr 0
}

define internal i32 @is_gcc_extension(ptr %0) {
entry:
  %2 = getelementptr [14 x i8], ptr @.str5, i64 0, i64 0
  %3 = call i32 @strcmp(ptr %0, ptr %2)
  %5 = sext i32 %3 to i64
  %6 = sext i32 0 to i64
  %4 = icmp eq i64 %5, %6
  %7 = zext i1 %4 to i64
  %8 = getelementptr [14 x i8], ptr @.str6, i64 0, i64 0
  %9 = call i32 @strcmp(ptr %0, ptr %8)
  %11 = sext i32 %9 to i64
  %12 = sext i32 0 to i64
  %10 = icmp eq i64 %11, %12
  %13 = zext i1 %10 to i64
  %15 = sext i32 %7 to i64
  %16 = sext i32 %13 to i64
  %17 = icmp ne i64 %15, 0
  %18 = icmp ne i64 %16, 0
  %19 = or i1 %17, %18
  %20 = zext i1 %19 to i64
  %21 = getelementptr [8 x i8], ptr @.str7, i64 0, i64 0
  %22 = call i32 @strcmp(ptr %0, ptr %21)
  %24 = sext i32 %22 to i64
  %25 = sext i32 0 to i64
  %23 = icmp eq i64 %24, %25
  %26 = zext i1 %23 to i64
  %28 = sext i32 %20 to i64
  %29 = sext i32 %26 to i64
  %30 = icmp ne i64 %28, 0
  %31 = icmp ne i64 %29, 0
  %32 = or i1 %30, %31
  %33 = zext i1 %32 to i64
  %34 = getelementptr [6 x i8], ptr @.str8, i64 0, i64 0
  %35 = call i32 @strcmp(ptr %0, ptr %34)
  %37 = sext i32 %35 to i64
  %38 = sext i32 0 to i64
  %36 = icmp eq i64 %37, %38
  %39 = zext i1 %36 to i64
  %41 = sext i32 %33 to i64
  %42 = sext i32 %39 to i64
  %43 = icmp ne i64 %41, 0
  %44 = icmp ne i64 %42, 0
  %45 = or i1 %43, %44
  %46 = zext i1 %45 to i64
  %47 = getelementptr [11 x i8], ptr @.str9, i64 0, i64 0
  %48 = call i32 @strcmp(ptr %0, ptr %47)
  %50 = sext i32 %48 to i64
  %51 = sext i32 0 to i64
  %49 = icmp eq i64 %50, %51
  %52 = zext i1 %49 to i64
  %54 = sext i32 %46 to i64
  %55 = sext i32 %52 to i64
  %56 = icmp ne i64 %54, 0
  %57 = icmp ne i64 %55, 0
  %58 = or i1 %56, %57
  %59 = zext i1 %58 to i64
  %60 = getelementptr [9 x i8], ptr @.str10, i64 0, i64 0
  %61 = call i32 @strcmp(ptr %0, ptr %60)
  %63 = sext i32 %61 to i64
  %64 = sext i32 0 to i64
  %62 = icmp eq i64 %63, %64
  %65 = zext i1 %62 to i64
  %67 = sext i32 %59 to i64
  %68 = sext i32 %65 to i64
  %69 = icmp ne i64 %67, 0
  %70 = icmp ne i64 %68, 0
  %71 = or i1 %69, %70
  %72 = zext i1 %71 to i64
  %73 = getelementptr [13 x i8], ptr @.str11, i64 0, i64 0
  %74 = call i32 @strcmp(ptr %0, ptr %73)
  %76 = sext i32 %74 to i64
  %77 = sext i32 0 to i64
  %75 = icmp eq i64 %76, %77
  %78 = zext i1 %75 to i64
  %80 = sext i32 %72 to i64
  %81 = sext i32 %78 to i64
  %82 = icmp ne i64 %80, 0
  %83 = icmp ne i64 %81, 0
  %84 = or i1 %82, %83
  %85 = zext i1 %84 to i64
  %86 = getelementptr [11 x i8], ptr @.str12, i64 0, i64 0
  %87 = call i32 @strcmp(ptr %0, ptr %86)
  %89 = sext i32 %87 to i64
  %90 = sext i32 0 to i64
  %88 = icmp eq i64 %89, %90
  %91 = zext i1 %88 to i64
  %93 = sext i32 %85 to i64
  %94 = sext i32 %91 to i64
  %95 = icmp ne i64 %93, 0
  %96 = icmp ne i64 %94, 0
  %97 = or i1 %95, %96
  %98 = zext i1 %97 to i64
  %99 = getelementptr [11 x i8], ptr @.str13, i64 0, i64 0
  %100 = call i32 @strcmp(ptr %0, ptr %99)
  %102 = sext i32 %100 to i64
  %103 = sext i32 0 to i64
  %101 = icmp eq i64 %102, %103
  %104 = zext i1 %101 to i64
  %106 = sext i32 %98 to i64
  %107 = sext i32 %104 to i64
  %108 = icmp ne i64 %106, 0
  %109 = icmp ne i64 %107, 0
  %110 = or i1 %108, %109
  %111 = zext i1 %110 to i64
  %112 = getelementptr [13 x i8], ptr @.str14, i64 0, i64 0
  %113 = call i32 @strcmp(ptr %0, ptr %112)
  %115 = sext i32 %113 to i64
  %116 = sext i32 0 to i64
  %114 = icmp eq i64 %115, %116
  %117 = zext i1 %114 to i64
  %119 = sext i32 %111 to i64
  %120 = sext i32 %117 to i64
  %121 = icmp ne i64 %119, 0
  %122 = icmp ne i64 %120, 0
  %123 = or i1 %121, %122
  %124 = zext i1 %123 to i64
  %125 = getelementptr [8 x i8], ptr @.str15, i64 0, i64 0
  %126 = call i32 @strcmp(ptr %0, ptr %125)
  %128 = sext i32 %126 to i64
  %129 = sext i32 0 to i64
  %127 = icmp eq i64 %128, %129
  %130 = zext i1 %127 to i64
  %132 = sext i32 %124 to i64
  %133 = sext i32 %130 to i64
  %134 = icmp ne i64 %132, 0
  %135 = icmp ne i64 %133, 0
  %136 = or i1 %134, %135
  %137 = zext i1 %136 to i64
  %138 = getelementptr [10 x i8], ptr @.str16, i64 0, i64 0
  %139 = call i32 @strcmp(ptr %0, ptr %138)
  %141 = sext i32 %139 to i64
  %142 = sext i32 0 to i64
  %140 = icmp eq i64 %141, %142
  %143 = zext i1 %140 to i64
  %145 = sext i32 %137 to i64
  %146 = sext i32 %143 to i64
  %147 = icmp ne i64 %145, 0
  %148 = icmp ne i64 %146, 0
  %149 = or i1 %147, %148
  %150 = zext i1 %149 to i64
  %151 = getelementptr [11 x i8], ptr @.str17, i64 0, i64 0
  %152 = call i32 @strcmp(ptr %0, ptr %151)
  %154 = sext i32 %152 to i64
  %155 = sext i32 0 to i64
  %153 = icmp eq i64 %154, %155
  %156 = zext i1 %153 to i64
  %158 = sext i32 %150 to i64
  %159 = sext i32 %156 to i64
  %160 = icmp ne i64 %158, 0
  %161 = icmp ne i64 %159, 0
  %162 = or i1 %160, %161
  %163 = zext i1 %162 to i64
  %164 = getelementptr [9 x i8], ptr @.str18, i64 0, i64 0
  %165 = call i32 @strcmp(ptr %0, ptr %164)
  %167 = sext i32 %165 to i64
  %168 = sext i32 0 to i64
  %166 = icmp eq i64 %167, %168
  %169 = zext i1 %166 to i64
  %171 = sext i32 %163 to i64
  %172 = sext i32 %169 to i64
  %173 = icmp ne i64 %171, 0
  %174 = icmp ne i64 %172, 0
  %175 = or i1 %173, %174
  %176 = zext i1 %175 to i64
  %177 = getelementptr [11 x i8], ptr @.str19, i64 0, i64 0
  %178 = call i32 @strcmp(ptr %0, ptr %177)
  %180 = sext i32 %178 to i64
  %181 = sext i32 0 to i64
  %179 = icmp eq i64 %180, %181
  %182 = zext i1 %179 to i64
  %184 = sext i32 %176 to i64
  %185 = sext i32 %182 to i64
  %186 = icmp ne i64 %184, 0
  %187 = icmp ne i64 %185, 0
  %188 = or i1 %186, %187
  %189 = zext i1 %188 to i64
  %190 = getelementptr [9 x i8], ptr @.str20, i64 0, i64 0
  %191 = call i32 @strcmp(ptr %0, ptr %190)
  %193 = sext i32 %191 to i64
  %194 = sext i32 0 to i64
  %192 = icmp eq i64 %193, %194
  %195 = zext i1 %192 to i64
  %197 = sext i32 %189 to i64
  %198 = sext i32 %195 to i64
  %199 = icmp ne i64 %197, 0
  %200 = icmp ne i64 %198, 0
  %201 = or i1 %199, %200
  %202 = zext i1 %201 to i64
  %203 = getelementptr [8 x i8], ptr @.str21, i64 0, i64 0
  %204 = call i32 @strcmp(ptr %0, ptr %203)
  %206 = sext i32 %204 to i64
  %207 = sext i32 0 to i64
  %205 = icmp eq i64 %206, %207
  %208 = zext i1 %205 to i64
  %210 = sext i32 %202 to i64
  %211 = sext i32 %208 to i64
  %212 = icmp ne i64 %210, 0
  %213 = icmp ne i64 %211, 0
  %214 = or i1 %212, %213
  %215 = zext i1 %214 to i64
  %216 = getelementptr [11 x i8], ptr @.str22, i64 0, i64 0
  %217 = call i32 @strcmp(ptr %0, ptr %216)
  %219 = sext i32 %217 to i64
  %220 = sext i32 0 to i64
  %218 = icmp eq i64 %219, %220
  %221 = zext i1 %218 to i64
  %223 = sext i32 %215 to i64
  %224 = sext i32 %221 to i64
  %225 = icmp ne i64 %223, 0
  %226 = icmp ne i64 %224, 0
  %227 = or i1 %225, %226
  %228 = zext i1 %227 to i64
  %229 = getelementptr [14 x i8], ptr @.str23, i64 0, i64 0
  %230 = call i32 @strcmp(ptr %0, ptr %229)
  %232 = sext i32 %230 to i64
  %233 = sext i32 0 to i64
  %231 = icmp eq i64 %232, %233
  %234 = zext i1 %231 to i64
  %236 = sext i32 %228 to i64
  %237 = sext i32 %234 to i64
  %238 = icmp ne i64 %236, 0
  %239 = icmp ne i64 %237, 0
  %240 = or i1 %238, %239
  %241 = zext i1 %240 to i64
  %242 = getelementptr [10 x i8], ptr @.str24, i64 0, i64 0
  %243 = call i32 @strcmp(ptr %0, ptr %242)
  %245 = sext i32 %243 to i64
  %246 = sext i32 0 to i64
  %244 = icmp eq i64 %245, %246
  %247 = zext i1 %244 to i64
  %249 = sext i32 %241 to i64
  %250 = sext i32 %247 to i64
  %251 = icmp ne i64 %249, 0
  %252 = icmp ne i64 %250, 0
  %253 = or i1 %251, %252
  %254 = zext i1 %253 to i64
  ret i32 %254
L0:
  ret i32 0
}

define internal void @skip_gcc_extension(ptr %0) {
entry:
  br label %L0
L0:
  br label %L1
L1:
  %2 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %4 = icmp eq i64 %2, 0
  %3 = zext i1 %4 to i64
  %5 = icmp ne i64 %3, 0
  br i1 %5, label %L4, label %L6
L4:
  br label %L3
L7:
  br label %L6
L6:
  %6 = load i64, ptr %0
  %7 = call i32 @is_gcc_extension(i32 %6)
  %9 = icmp eq i64 %7, 0
  %8 = zext i1 %9 to i64
  %10 = icmp ne i64 %8, 0
  br i1 %10, label %L8, label %L10
L8:
  br label %L3
L11:
  br label %L10
L10:
  %11 = alloca ptr
  %13 = load i64, ptr %0
  store ptr %13, ptr %11
  %14 = alloca i32
  %16 = load ptr, ptr %11
  %17 = getelementptr [14 x i8], ptr @.str25, i64 0, i64 0
  %18 = call i32 @strcmp(ptr %16, ptr %17)
  %20 = sext i32 %18 to i64
  %21 = sext i32 0 to i64
  %19 = icmp eq i64 %20, %21
  %22 = zext i1 %19 to i64
  %23 = load ptr, ptr %11
  %24 = getelementptr [8 x i8], ptr @.str26, i64 0, i64 0
  %25 = call i32 @strcmp(ptr %23, ptr %24)
  %27 = sext i32 %25 to i64
  %28 = sext i32 0 to i64
  %26 = icmp eq i64 %27, %28
  %29 = zext i1 %26 to i64
  %31 = sext i32 %22 to i64
  %32 = sext i32 %29 to i64
  %33 = icmp ne i64 %31, 0
  %34 = icmp ne i64 %32, 0
  %35 = or i1 %33, %34
  %36 = zext i1 %35 to i64
  %37 = load ptr, ptr %11
  %38 = getelementptr [6 x i8], ptr @.str27, i64 0, i64 0
  %39 = call i32 @strcmp(ptr %37, ptr %38)
  %41 = sext i32 %39 to i64
  %42 = sext i32 0 to i64
  %40 = icmp eq i64 %41, %42
  %43 = zext i1 %40 to i64
  %45 = sext i32 %36 to i64
  %46 = sext i32 %43 to i64
  %47 = icmp ne i64 %45, 0
  %48 = icmp ne i64 %46, 0
  %49 = or i1 %47, %48
  %50 = zext i1 %49 to i64
  %51 = load ptr, ptr %11
  %52 = getelementptr [11 x i8], ptr @.str28, i64 0, i64 0
  %53 = call i32 @strcmp(ptr %51, ptr %52)
  %55 = sext i32 %53 to i64
  %56 = sext i32 0 to i64
  %54 = icmp eq i64 %55, %56
  %57 = zext i1 %54 to i64
  %59 = sext i32 %50 to i64
  %60 = sext i32 %57 to i64
  %61 = icmp ne i64 %59, 0
  %62 = icmp ne i64 %60, 0
  %63 = or i1 %61, %62
  %64 = zext i1 %63 to i64
  %65 = load ptr, ptr %11
  %66 = getelementptr [9 x i8], ptr @.str29, i64 0, i64 0
  %67 = call i32 @strcmp(ptr %65, ptr %66)
  %69 = sext i32 %67 to i64
  %70 = sext i32 0 to i64
  %68 = icmp eq i64 %69, %70
  %71 = zext i1 %68 to i64
  %73 = sext i32 %64 to i64
  %74 = sext i32 %71 to i64
  %75 = icmp ne i64 %73, 0
  %76 = icmp ne i64 %74, 0
  %77 = or i1 %75, %76
  %78 = zext i1 %77 to i64
  %79 = load ptr, ptr %11
  %80 = getelementptr [11 x i8], ptr @.str30, i64 0, i64 0
  %81 = call i32 @strcmp(ptr %79, ptr %80)
  %83 = sext i32 %81 to i64
  %84 = sext i32 0 to i64
  %82 = icmp eq i64 %83, %84
  %85 = zext i1 %82 to i64
  %87 = sext i32 %78 to i64
  %88 = sext i32 %85 to i64
  %89 = icmp ne i64 %87, 0
  %90 = icmp ne i64 %88, 0
  %91 = or i1 %89, %90
  %92 = zext i1 %91 to i64
  store ptr %92, ptr %14
  call void @advance(ptr %0)
  %94 = load i32, ptr %14
  %95 = call i32 @check(ptr %0, ptr @TOK_LPAREN)
  %97 = sext i32 %94 to i64
  %98 = sext i32 %95 to i64
  %99 = icmp ne i64 %97, 0
  %100 = icmp ne i64 %98, 0
  %101 = and i1 %99, %100
  %102 = zext i1 %101 to i64
  %103 = icmp ne i64 %102, 0
  br i1 %103, label %L12, label %L14
L12:
  %104 = alloca i32
  store i32 1, ptr %104
  call void @advance(ptr %0)
  br label %L15
L15:
  %107 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %109 = icmp eq i64 %107, 0
  %108 = zext i1 %109 to i64
  %110 = load i32, ptr %104
  %112 = sext i32 %110 to i64
  %113 = sext i32 0 to i64
  %111 = icmp sgt i64 %112, %113
  %114 = zext i1 %111 to i64
  %116 = sext i32 %108 to i64
  %117 = sext i32 %114 to i64
  %118 = icmp ne i64 %116, 0
  %119 = icmp ne i64 %117, 0
  %120 = and i1 %118, %119
  %121 = zext i1 %120 to i64
  %122 = icmp ne i64 %121, 0
  br i1 %122, label %L16, label %L17
L16:
  %123 = call i32 @check(ptr %0, ptr @TOK_LPAREN)
  %124 = icmp ne i64 %123, 0
  br i1 %124, label %L18, label %L19
L18:
  %125 = load i32, ptr %104
  %127 = sext i32 %125 to i64
  %126 = add i64 %127, 1
  store i64 %126, ptr %104
  br label %L20
L19:
  %128 = call i32 @check(ptr %0, ptr @TOK_RPAREN)
  %129 = icmp ne i64 %128, 0
  br i1 %129, label %L21, label %L23
L21:
  %130 = load i32, ptr %104
  %132 = sext i32 %130 to i64
  %131 = sub i64 %132, 1
  store i64 %131, ptr %104
  br label %L23
L23:
  br label %L20
L20:
  call void @advance(ptr %0)
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

define internal i32 @is_type_start(ptr %0) {
entry:
  %2 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %3 = load i64, ptr %0
  %4 = call i32 @is_gcc_extension(i32 %3)
  %6 = sext i32 %2 to i64
  %7 = sext i32 %4 to i64
  %8 = icmp ne i64 %6, 0
  %9 = icmp ne i64 %7, 0
  %10 = and i1 %8, %9
  %11 = zext i1 %10 to i64
  %12 = icmp ne i64 %11, 0
  br i1 %12, label %L0, label %L2
L0:
  ret i32 0
L3:
  br label %L2
L2:
  %13 = load i64, ptr %0
  %14 = sext i32 %13 to i64
  switch i64 %14, label %L23 [
    i64 0, label %L5
    i64 0, label %L6
    i64 0, label %L7
    i64 0, label %L8
    i64 0, label %L9
    i64 0, label %L10
    i64 0, label %L11
    i64 0, label %L12
    i64 0, label %L13
    i64 0, label %L14
    i64 0, label %L15
    i64 0, label %L16
    i64 0, label %L17
    i64 0, label %L18
    i64 0, label %L19
    i64 0, label %L20
    i64 0, label %L21
    i64 0, label %L22
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
  ret i32 1
L24:
  br label %L22
L22:
  %15 = load i64, ptr %0
  %16 = call ptr @lookup_typedef(ptr %0, i32 %15)
  %17 = inttoptr i64 0 to ptr
  %18 = icmp ne ptr %16, %17
  %19 = zext i1 %18 to i64
  ret i32 %19
L25:
  br label %L4
L23:
  ret i32 0
L26:
  br label %L4
L4:
  ret i32 0
}

define internal ptr @parse_struct_union(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  %6 = sext i32 %4 to i64
  %7 = sext i32 @TOK_UNION to i64
  %5 = icmp eq i64 %6, %7
  %8 = zext i1 %5 to i64
  store i32 %8, ptr %2
  call void @advance(ptr %0)
  %10 = alloca ptr
  %12 = inttoptr i64 0 to ptr
  store ptr %12, ptr %10
  %13 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %14 = icmp ne i64 %13, 0
  br i1 %14, label %L0, label %L2
L0:
  %15 = load i64, ptr %0
  %16 = call i32 @strdup(i32 %15)
  store i32 %16, ptr %10
  call void @advance(ptr %0)
  br label %L2
L2:
  %18 = alloca ptr
  %20 = load i32, ptr %2
  %21 = icmp ne i64 %20, 0
  br i1 %21, label %L3, label %L4
L3:
  br label %L5
L4:
  br label %L5
L5:
  %22 = phi i64 [ @TY_UNION, %L3 ], [ @TY_STRUCT, %L4 ]
  %23 = call ptr @type_new(ptr %22)
  store ptr %23, ptr %18
  %24 = load ptr, ptr %10
  %25 = load ptr, ptr %18
  store ptr %24, ptr %25
  %26 = call i32 @check(ptr %0, ptr @TOK_LBRACE)
  %27 = icmp ne i64 %26, 0
  br i1 %27, label %L6, label %L8
L6:
  call void @advance(ptr %0)
  %29 = alloca i32
  store i32 1, ptr %29
  br label %L9
L9:
  %31 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %33 = icmp eq i64 %31, 0
  %32 = zext i1 %33 to i64
  %34 = load i32, ptr %29
  %36 = sext i32 %34 to i64
  %37 = sext i32 0 to i64
  %35 = icmp sgt i64 %36, %37
  %38 = zext i1 %35 to i64
  %40 = sext i32 %32 to i64
  %41 = sext i32 %38 to i64
  %42 = icmp ne i64 %40, 0
  %43 = icmp ne i64 %41, 0
  %44 = and i1 %42, %43
  %45 = zext i1 %44 to i64
  %46 = icmp ne i64 %45, 0
  br i1 %46, label %L10, label %L11
L10:
  %47 = call i32 @check(ptr %0, ptr @TOK_LBRACE)
  %48 = icmp ne i64 %47, 0
  br i1 %48, label %L12, label %L13
L12:
  %49 = load i32, ptr %29
  %51 = sext i32 %49 to i64
  %50 = add i64 %51, 1
  store i64 %50, ptr %29
  br label %L14
L13:
  %52 = call i32 @check(ptr %0, ptr @TOK_RBRACE)
  %53 = icmp ne i64 %52, 0
  br i1 %53, label %L15, label %L17
L15:
  %54 = load i32, ptr %29
  %56 = sext i32 %54 to i64
  %55 = sub i64 %56, 1
  store i64 %55, ptr %29
  br label %L17
L17:
  br label %L14
L14:
  call void @advance(ptr %0)
  br label %L9
L11:
  br label %L8
L8:
  %58 = load ptr, ptr %18
  ret ptr %58
L18:
  ret ptr 0
}

define internal ptr @parse_enum_specifier(ptr %0) {
entry:
  call void @advance(ptr %0)
  %3 = alloca ptr
  %5 = call ptr @type_new(ptr @TY_ENUM)
  store ptr %5, ptr %3
  %6 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %7 = icmp ne i64 %6, 0
  br i1 %7, label %L0, label %L2
L0:
  %8 = load i64, ptr %0
  %9 = call i32 @strdup(i32 %8)
  %10 = load ptr, ptr %3
  store i32 %9, ptr %10
  call void @advance(ptr %0)
  br label %L2
L2:
  %12 = call i32 @check(ptr %0, ptr @TOK_LBRACE)
  %13 = icmp ne i64 %12, 0
  br i1 %13, label %L3, label %L5
L3:
  call void @advance(ptr %0)
  %15 = alloca i64
  store i64 0, ptr %15
  br label %L6
L6:
  %17 = call i32 @check(ptr %0, ptr @TOK_RBRACE)
  %19 = icmp eq i64 %17, 0
  %18 = zext i1 %19 to i64
  %20 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %22 = icmp eq i64 %20, 0
  %21 = zext i1 %22 to i64
  %24 = sext i32 %18 to i64
  %25 = sext i32 %21 to i64
  %26 = icmp ne i64 %24, 0
  %27 = icmp ne i64 %25, 0
  %28 = and i1 %26, %27
  %29 = zext i1 %28 to i64
  %30 = icmp ne i64 %29, 0
  br i1 %30, label %L7, label %L8
L7:
  %31 = call i32 @check(ptr %0, ptr @TOK_COMMA)
  %32 = icmp ne i64 %31, 0
  br i1 %32, label %L9, label %L10
L9:
  call void @advance(ptr %0)
  br label %L11
L10:
  call void @advance(ptr %0)
  br label %L11
L11:
  %35 = load i64, ptr %15
  %36 = trunc i64 %35 to void
  br label %L6
L8:
  call void @expect(ptr %0, ptr @TOK_RBRACE)
  br label %L5
L5:
  %38 = load ptr, ptr %3
  ret ptr %38
L12:
  ret ptr 0
}

define internal ptr @parse_type_specifier(ptr %0, ptr %2, ptr %4, ptr %6) {
entry:
  %8 = alloca i32
  store i32 0, ptr %8
  %10 = alloca i32
  store i32 0, ptr %10
  %12 = alloca i32
  store i32 0, ptr %12
  %14 = alloca i32
  store i32 0, ptr %14
  %16 = alloca i32
  store i32 0, ptr %16
  %18 = alloca i32
  store i32 0, ptr %18
  %20 = alloca i32
  store i32 0, ptr %20
  %22 = alloca i32
  store i32 0, ptr %22
  %24 = alloca i32
  store i32 0, ptr %24
  %26 = alloca i32
  store i32 0, ptr %26
  %28 = alloca i64
  store i64 @TY_INT, ptr %28
  %30 = alloca i32
  store i32 0, ptr %30
  %32 = alloca ptr
  %34 = inttoptr i64 0 to ptr
  store ptr %34, ptr %32
  br label %L0
L0:
  br label %L1
L1:
  %35 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %36 = load i64, ptr %0
  %37 = call i32 @is_gcc_extension(i32 %36)
  %39 = sext i32 %35 to i64
  %40 = sext i32 %37 to i64
  %41 = icmp ne i64 %39, 0
  %42 = icmp ne i64 %40, 0
  %43 = and i1 %41, %42
  %44 = zext i1 %43 to i64
  %45 = icmp ne i64 %44, 0
  br i1 %45, label %L4, label %L6
L4:
  call void @skip_gcc_extension(ptr %0)
  br label %L2
L7:
  br label %L6
L6:
  %47 = load i64, ptr %0
  %48 = sext i32 %47 to i64
  switch i64 %48, label %L27 [
    i64 0, label %L9
    i64 0, label %L10
    i64 0, label %L11
    i64 0, label %L12
    i64 0, label %L13
    i64 0, label %L14
    i64 0, label %L15
    i64 0, label %L16
    i64 0, label %L17
    i64 0, label %L18
    i64 0, label %L19
    i64 0, label %L20
    i64 0, label %L21
    i64 0, label %L22
    i64 0, label %L23
    i64 0, label %L24
    i64 0, label %L25
    i64 0, label %L26
  ]
L9:
  store i32 1, ptr @is_typedef
  call void @advance(ptr %0)
  br label %L8
L28:
  br label %L10
L10:
  store i32 1, ptr @is_static
  call void @advance(ptr %0)
  br label %L8
L29:
  br label %L11
L11:
  store i32 1, ptr @is_extern
  call void @advance(ptr %0)
  br label %L8
L30:
  br label %L12
L12:
  store i32 1, ptr @is_const
  call void @advance(ptr %0)
  br label %L8
L31:
  br label %L13
L13:
  store i32 1, ptr @is_volatile
  call void @advance(ptr %0)
  br label %L8
L32:
  br label %L14
L14:
  store i32 1, ptr @is_unsigned
  call void @advance(ptr %0)
  br label %L8
L33:
  br label %L15
L15:
  store i32 1, ptr @is_signed
  call void @advance(ptr %0)
  br label %L8
L34:
  br label %L16
L16:
  store i32 1, ptr @is_short
  call void @advance(ptr %0)
  br label %L8
L35:
  br label %L17
L17:
  %57 = icmp ne i64 @is_long, 0
  br i1 %57, label %L36, label %L37
L36:
  store i32 1, ptr @is_longlong
  br label %L38
L37:
  store i32 1, ptr @is_long
  br label %L38
L38:
  call void @advance(ptr %0)
  br label %L8
L39:
  br label %L18
L18:
  store ptr @TY_VOID, ptr %28
  store i32 1, ptr %30
  call void @advance(ptr %0)
  br label %L8
L40:
  br label %L19
L19:
  store ptr @TY_CHAR, ptr %28
  store i32 1, ptr %30
  call void @advance(ptr %0)
  br label %L8
L41:
  br label %L20
L20:
  store ptr @TY_INT, ptr %28
  store i32 1, ptr %30
  call void @advance(ptr %0)
  br label %L8
L42:
  br label %L21
L21:
  store ptr @TY_FLOAT, ptr %28
  store i32 1, ptr %30
  call void @advance(ptr %0)
  br label %L8
L43:
  br label %L22
L22:
  store ptr @TY_DOUBLE, ptr %28
  store i32 1, ptr %30
  call void @advance(ptr %0)
  br label %L8
L44:
  br label %L23
L23:
  br label %L24
L24:
  %64 = call ptr @parse_struct_union(ptr %0)
  store ptr %64, ptr %32
  store i32 1, ptr %30
  br label %done
L45:
  br label %L25
L25:
  %65 = call ptr @parse_enum_specifier(ptr %0)
  store ptr %65, ptr %32
  store i32 1, ptr %30
  br label %done
L46:
  br label %L26
L26:
  %66 = alloca ptr
  %68 = load i64, ptr %0
  %69 = call ptr @lookup_typedef(ptr %0, i32 %68)
  store ptr %69, ptr %66
  %70 = load ptr, ptr %66
  %71 = icmp ne i64 %70, 0
  br i1 %71, label %L47, label %L49
L47:
  %72 = call ptr @type_new(ptr @TY_TYPEDEF_REF)
  store ptr %72, ptr %32
  %73 = load i64, ptr %0
  %74 = call i32 @strdup(i32 %73)
  %75 = load ptr, ptr %32
  store i32 %74, ptr %75
  store i32 1, ptr %30
  call void @advance(ptr %0)
  br label %done
L50:
  br label %L49
L49:
  br label %done
L51:
  br label %L8
L27:
  br label %done
L52:
  br label %L8
L8:
  br label %L2
L2:
  br label %L0
L3:
done:
  %77 = icmp ne i64 %2, 0
  br i1 %77, label %L53, label %L55
L53:
  store ptr @is_typedef, ptr %2
  br label %L55
L55:
  %78 = icmp ne i64 %4, 0
  br i1 %78, label %L56, label %L58
L56:
  store ptr @is_static, ptr %4
  br label %L58
L58:
  %79 = icmp ne i64 %6, 0
  br i1 %79, label %L59, label %L61
L59:
  store ptr @is_extern, ptr %6
  br label %L61
L61:
  %80 = load ptr, ptr %32
  %81 = icmp ne i64 %80, 0
  br i1 %81, label %L62, label %L64
L62:
  %82 = load ptr, ptr %32
  store ptr @is_const, ptr %82
  %83 = load ptr, ptr %32
  store ptr @is_volatile, ptr %83
  %84 = load ptr, ptr %32
  ret ptr %84
L65:
  br label %L64
L64:
  %85 = load i32, ptr %30
  %87 = icmp eq i64 %85, 0
  %86 = zext i1 %87 to i64
  %89 = icmp eq i64 @is_long, 0
  %88 = zext i1 %89 to i64
  %91 = sext i32 %86 to i64
  %92 = sext i32 %88 to i64
  %93 = icmp ne i64 %91, 0
  %94 = icmp ne i64 %92, 0
  %95 = and i1 %93, %94
  %96 = zext i1 %95 to i64
  %98 = icmp eq i64 @is_short, 0
  %97 = zext i1 %98 to i64
  %100 = sext i32 %96 to i64
  %101 = sext i32 %97 to i64
  %102 = icmp ne i64 %100, 0
  %103 = icmp ne i64 %101, 0
  %104 = and i1 %102, %103
  %105 = zext i1 %104 to i64
  %107 = icmp eq i64 @is_unsigned, 0
  %106 = zext i1 %107 to i64
  %109 = sext i32 %105 to i64
  %110 = sext i32 %106 to i64
  %111 = icmp ne i64 %109, 0
  %112 = icmp ne i64 %110, 0
  %113 = and i1 %111, %112
  %114 = zext i1 %113 to i64
  %116 = icmp eq i64 @is_signed, 0
  %115 = zext i1 %116 to i64
  %118 = sext i32 %114 to i64
  %119 = sext i32 %115 to i64
  %120 = icmp ne i64 %118, 0
  %121 = icmp ne i64 %119, 0
  %122 = and i1 %120, %121
  %123 = zext i1 %122 to i64
  %124 = icmp ne i64 %123, 0
  br i1 %124, label %L66, label %L68
L66:
  %125 = inttoptr i64 0 to ptr
  ret ptr %125
L69:
  br label %L68
L68:
  %126 = load i64, ptr %28
  %128 = sext i32 %126 to i64
  %129 = sext i32 @TY_CHAR to i64
  %127 = icmp eq i64 %128, %129
  %130 = zext i1 %127 to i64
  %131 = icmp ne i64 %130, 0
  br i1 %131, label %L70, label %L71
L70:
  %132 = icmp ne i64 @is_unsigned, 0
  br i1 %132, label %L73, label %L74
L73:
  store ptr @TY_UCHAR, ptr %28
  br label %L75
L74:
  %133 = icmp ne i64 @is_signed, 0
  br i1 %133, label %L76, label %L78
L76:
  store ptr @TY_SCHAR, ptr %28
  br label %L78
L78:
  br label %L75
L75:
  br label %L72
L71:
  %134 = icmp ne i64 @is_longlong, 0
  br i1 %134, label %L79, label %L80
L79:
  %135 = icmp ne i64 @is_unsigned, 0
  br i1 %135, label %L82, label %L83
L82:
  br label %L84
L83:
  br label %L84
L84:
  %136 = phi i64 [ @TY_ULONGLONG, %L82 ], [ @TY_LONGLONG, %L83 ]
  store ptr %136, ptr %28
  br label %L81
L80:
  %137 = icmp ne i64 @is_long, 0
  br i1 %137, label %L85, label %L86
L85:
  %138 = icmp ne i64 @is_unsigned, 0
  br i1 %138, label %L88, label %L89
L88:
  br label %L90
L89:
  br label %L90
L90:
  %139 = phi i64 [ @TY_ULONG, %L88 ], [ @TY_LONG, %L89 ]
  store ptr %139, ptr %28
  br label %L87
L86:
  %140 = icmp ne i64 @is_short, 0
  br i1 %140, label %L91, label %L92
L91:
  %141 = icmp ne i64 @is_unsigned, 0
  br i1 %141, label %L94, label %L95
L94:
  br label %L96
L95:
  br label %L96
L96:
  %142 = phi i64 [ @TY_USHORT, %L94 ], [ @TY_SHORT, %L95 ]
  store ptr %142, ptr %28
  br label %L93
L92:
  %143 = load i64, ptr %28
  %145 = sext i32 %143 to i64
  %146 = sext i32 @TY_INT to i64
  %144 = icmp eq i64 %145, %146
  %147 = zext i1 %144 to i64
  %148 = load i32, ptr %30
  %150 = icmp eq i64 %148, 0
  %149 = zext i1 %150 to i64
  %152 = sext i32 %147 to i64
  %153 = sext i32 %149 to i64
  %154 = icmp ne i64 %152, 0
  %155 = icmp ne i64 %153, 0
  %156 = or i1 %154, %155
  %157 = zext i1 %156 to i64
  %158 = icmp ne i64 %157, 0
  br i1 %158, label %L97, label %L99
L97:
  %159 = icmp ne i64 @is_unsigned, 0
  br i1 %159, label %L100, label %L102
L100:
  store ptr @TY_UINT, ptr %28
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
  %160 = alloca ptr
  %162 = load i64, ptr %28
  %163 = call ptr @type_new(i64 %162)
  store ptr %163, ptr %160
  %164 = load ptr, ptr %160
  store ptr @is_const, ptr %164
  %165 = load ptr, ptr %160
  store ptr @is_volatile, ptr %165
  %166 = load ptr, ptr %160
  ret ptr %166
L103:
  ret ptr 0
}

define internal ptr @parse_declarator(ptr %0, ptr %2, ptr %4) {
entry:
  %6 = alloca i32
  store i32 0, ptr %6
  %8 = alloca ptr
  store ptr 0, ptr %8
  br label %L0
L0:
  %10 = call i32 @check(ptr %0, ptr @TOK_STAR)
  %11 = load i32, ptr %6
  %13 = sext i32 %11 to i64
  %14 = sext i32 16 to i64
  %12 = icmp slt i64 %13, %14
  %15 = zext i1 %12 to i64
  %17 = sext i32 %10 to i64
  %18 = sext i32 %15 to i64
  %19 = icmp ne i64 %17, 0
  %20 = icmp ne i64 %18, 0
  %21 = and i1 %19, %20
  %22 = zext i1 %21 to i64
  %23 = icmp ne i64 %22, 0
  br i1 %23, label %L1, label %L2
L1:
  call void @advance(ptr %0)
  %25 = load ptr, ptr %8
  %26 = load i32, ptr %6
  %27 = getelementptr i8, ptr %25, i64 %26
  store i32 0, ptr %27
  br label %L3
L3:
  %28 = call i32 @check(ptr %0, ptr @TOK_CONST)
  %29 = call i32 @check(ptr %0, ptr @TOK_VOLATILE)
  %31 = sext i32 %28 to i64
  %32 = sext i32 %29 to i64
  %33 = icmp ne i64 %31, 0
  %34 = icmp ne i64 %32, 0
  %35 = or i1 %33, %34
  %36 = zext i1 %35 to i64
  %37 = icmp ne i64 %36, 0
  br i1 %37, label %L4, label %L5
L4:
  %38 = call i32 @check(ptr %0, ptr @TOK_CONST)
  %39 = icmp ne i64 %38, 0
  br i1 %39, label %L6, label %L8
L6:
  %40 = load ptr, ptr %8
  %41 = load i32, ptr %6
  %42 = getelementptr i8, ptr %40, i64 %41
  store i32 1, ptr %42
  br label %L8
L8:
  call void @advance(ptr %0)
  br label %L3
L5:
  %44 = load i32, ptr %6
  %46 = sext i32 %44 to i64
  %45 = add i64 %46, 1
  store i64 %45, ptr %6
  br label %L0
L2:
  %47 = alloca i32
  %49 = load i32, ptr %6
  %51 = sext i32 %49 to i64
  %52 = sext i32 1 to i64
  %50 = sub i64 %51, %52
  store i32 %50, ptr %47
  br label %L9
L9:
  %53 = load i32, ptr %47
  %55 = sext i32 %53 to i64
  %56 = sext i32 0 to i64
  %54 = icmp sge i64 %55, %56
  %57 = zext i1 %54 to i64
  %58 = icmp ne i64 %57, 0
  br i1 %58, label %L10, label %L12
L10:
  %59 = alloca ptr
  %61 = call ptr @type_ptr(ptr %2)
  store ptr %61, ptr %59
  %62 = load ptr, ptr %8
  %63 = load i32, ptr %47
  %64 = getelementptr i32, ptr %62, i64 %63
  %65 = load i32, ptr %64
  %66 = load ptr, ptr %59
  store i32 %65, ptr %66
  %67 = load ptr, ptr %59
  store ptr %67, ptr %2
  br label %L11
L11:
  %68 = load i32, ptr %47
  %70 = sext i32 %68 to i64
  %69 = sub i64 %70, 1
  store i64 %69, ptr %47
  br label %L9
L12:
  %71 = icmp ne i64 %4, 0
  br i1 %71, label %L13, label %L15
L13:
  %72 = inttoptr i64 0 to ptr
  store ptr %72, ptr %4
  br label %L15
L15:
  call void @skip_gcc_extension(ptr %0)
  %74 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %75 = load i64, ptr %0
  %76 = call i32 @is_gcc_extension(i32 %75)
  %78 = icmp eq i64 %76, 0
  %77 = zext i1 %78 to i64
  %80 = sext i32 %74 to i64
  %81 = sext i32 %77 to i64
  %82 = icmp ne i64 %80, 0
  %83 = icmp ne i64 %81, 0
  %84 = and i1 %82, %83
  %85 = zext i1 %84 to i64
  %86 = icmp ne i64 %85, 0
  br i1 %86, label %L16, label %L17
L16:
  %87 = icmp ne i64 %4, 0
  br i1 %87, label %L19, label %L21
L19:
  %88 = load i64, ptr %0
  %89 = call i32 @strdup(i32 %88)
  store i32 %89, ptr %4
  br label %L21
L21:
  call void @advance(ptr %0)
  br label %L18
L17:
  %91 = call i32 @check(ptr %0, ptr @TOK_LPAREN)
  %92 = icmp ne i64 %91, 0
  br i1 %92, label %L22, label %L24
L22:
  call void @advance(ptr %0)
  %94 = call ptr @parse_declarator(ptr %0, ptr %2, ptr %4)
  store ptr %94, ptr %2
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  br label %L24
L24:
  br label %L18
L18:
  call void @skip_gcc_extension(ptr %0)
  br label %L25
L25:
  br label %L26
L26:
  %97 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %98 = load i64, ptr %0
  %99 = call i32 @is_gcc_extension(i32 %98)
  %101 = sext i32 %97 to i64
  %102 = sext i32 %99 to i64
  %103 = icmp ne i64 %101, 0
  %104 = icmp ne i64 %102, 0
  %105 = and i1 %103, %104
  %106 = zext i1 %105 to i64
  %107 = icmp ne i64 %106, 0
  br i1 %107, label %L29, label %L31
L29:
  call void @skip_gcc_extension(ptr %0)
  br label %L27
L32:
  br label %L31
L31:
  %109 = call i32 @check(ptr %0, ptr @TOK_LBRACKET)
  %110 = icmp ne i64 %109, 0
  br i1 %110, label %L33, label %L34
L33:
  call void @advance(ptr %0)
  %112 = alloca i64
  %114 = sub i64 0, 1
  store i64 %114, ptr %112
  %115 = call i32 @check(ptr %0, ptr @TOK_RBRACKET)
  %117 = icmp eq i64 %115, 0
  %116 = zext i1 %117 to i64
  %118 = icmp ne i64 %116, 0
  br i1 %118, label %L36, label %L38
L36:
  %119 = call i32 @check(ptr %0, ptr @TOK_INT_LIT)
  %120 = icmp ne i64 %119, 0
  br i1 %120, label %L39, label %L40
L39:
  %121 = load i64, ptr %0
  %122 = call i32 @atol(i32 %121)
  %123 = sext i32 %122 to i64
  store i64 %123, ptr %112
  call void @advance(ptr %0)
  br label %L41
L40:
  %125 = alloca i32
  store i32 0, ptr %125
  br label %L42
L42:
  %127 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %129 = icmp eq i64 %127, 0
  %128 = zext i1 %129 to i64
  %130 = icmp ne i64 %128, 0
  br i1 %130, label %L43, label %L44
L43:
  %131 = call i32 @check(ptr %0, ptr @TOK_LBRACKET)
  %132 = icmp ne i64 %131, 0
  br i1 %132, label %L45, label %L47
L45:
  %133 = load i32, ptr %125
  %135 = sext i32 %133 to i64
  %134 = add i64 %135, 1
  store i64 %134, ptr %125
  br label %L47
L47:
  %136 = call i32 @check(ptr %0, ptr @TOK_RBRACKET)
  %137 = icmp ne i64 %136, 0
  br i1 %137, label %L48, label %L50
L48:
  %138 = load i32, ptr %125
  %140 = sext i32 %138 to i64
  %141 = sext i32 0 to i64
  %139 = icmp eq i64 %140, %141
  %142 = zext i1 %139 to i64
  %143 = icmp ne i64 %142, 0
  br i1 %143, label %L51, label %L53
L51:
  br label %L44
L54:
  br label %L53
L53:
  %144 = load i32, ptr %125
  %146 = sext i32 %144 to i64
  %145 = sub i64 %146, 1
  store i64 %145, ptr %125
  br label %L50
L50:
  call void @advance(ptr %0)
  br label %L42
L44:
  br label %L41
L41:
  br label %L38
L38:
  call void @expect(ptr %0, ptr @TOK_RBRACKET)
  %149 = load i64, ptr %112
  %150 = call ptr @type_array(ptr %2, i64 %149)
  store ptr %150, ptr %2
  br label %L35
L34:
  %151 = call i32 @check(ptr %0, ptr @TOK_LPAREN)
  %152 = icmp ne i64 %151, 0
  br i1 %152, label %L55, label %L56
L55:
  call void @advance(ptr %0)
  %154 = alloca ptr
  %156 = call ptr @type_new(ptr @TY_FUNC)
  store ptr %156, ptr %154
  %157 = load ptr, ptr %154
  store ptr %2, ptr %157
  %158 = alloca ptr
  %160 = inttoptr i64 0 to ptr
  store ptr %160, ptr %158
  %161 = alloca i32
  store i32 0, ptr %161
  %163 = alloca i32
  store i32 0, ptr %163
  br label %L58
L58:
  %165 = call i32 @check(ptr %0, ptr @TOK_RPAREN)
  %167 = icmp eq i64 %165, 0
  %166 = zext i1 %167 to i64
  %168 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %170 = icmp eq i64 %168, 0
  %169 = zext i1 %170 to i64
  %172 = sext i32 %166 to i64
  %173 = sext i32 %169 to i64
  %174 = icmp ne i64 %172, 0
  %175 = icmp ne i64 %173, 0
  %176 = and i1 %174, %175
  %177 = zext i1 %176 to i64
  %178 = icmp ne i64 %177, 0
  br i1 %178, label %L59, label %L60
L59:
  %179 = call i32 @check(ptr %0, ptr @TOK_ELLIPSIS)
  %180 = icmp ne i64 %179, 0
  br i1 %180, label %L61, label %L63
L61:
  store i32 1, ptr %163
  call void @advance(ptr %0)
  br label %L60
L64:
  br label %L63
L63:
  %182 = alloca i32
  store i32 0, ptr %182
  %184 = alloca i32
  store i32 0, ptr %184
  %186 = alloca i32
  store i32 0, ptr %186
  %188 = alloca ptr
  %190 = call ptr @parse_type_specifier(ptr %0, ptr @dummy_td, ptr @dummy_st, ptr @dummy_ex)
  store ptr %190, ptr %188
  %191 = load ptr, ptr %188
  %193 = icmp eq i64 %191, 0
  %192 = zext i1 %193 to i64
  %194 = icmp ne i64 %192, 0
  br i1 %194, label %L65, label %L67
L65:
  br label %L60
L68:
  br label %L67
L67:
  %195 = alloca ptr
  %197 = inttoptr i64 0 to ptr
  store ptr %197, ptr %195
  %198 = load ptr, ptr %188
  %199 = call ptr @parse_declarator(ptr %0, ptr %198, ptr %195)
  store ptr %199, ptr %188
  %200 = load ptr, ptr %158
  %201 = load i32, ptr %161
  %203 = sext i32 %201 to i64
  %204 = sext i32 1 to i64
  %202 = add i64 %203, %204
  %206 = sext i32 %202 to i64
  %207 = sext i32 8 to i64
  %205 = mul i64 %206, %207
  %208 = call i32 @realloc(ptr %200, i32 %205)
  store i32 %208, ptr %158
  %209 = load ptr, ptr %158
  %211 = icmp eq i64 %209, 0
  %210 = zext i1 %211 to i64
  %212 = icmp ne i64 %210, 0
  br i1 %212, label %L69, label %L71
L69:
  %213 = getelementptr [8 x i8], ptr @.str31, i64 0, i64 0
  %214 = call i32 @perror(ptr %213)
  %215 = call i32 @exit(i32 1)
  br label %L71
L71:
  %216 = load ptr, ptr %195
  %217 = load ptr, ptr %158
  %218 = load i32, ptr %161
  %219 = getelementptr i8, ptr %217, i64 %218
  store ptr %216, ptr %219
  %220 = load ptr, ptr %188
  %221 = load ptr, ptr %158
  %222 = load i32, ptr %161
  %223 = getelementptr i8, ptr %221, i64 %222
  store ptr %220, ptr %223
  %224 = load i32, ptr %161
  %226 = sext i32 %224 to i64
  %225 = add i64 %226, 1
  store i64 %225, ptr %161
  %227 = call i32 @match(ptr %0, ptr @TOK_COMMA)
  %229 = icmp eq i64 %227, 0
  %228 = zext i1 %229 to i64
  %230 = icmp ne i64 %228, 0
  br i1 %230, label %L72, label %L74
L72:
  br label %L60
L75:
  br label %L74
L74:
  br label %L58
L60:
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %232 = load ptr, ptr %158
  %233 = load ptr, ptr %154
  store ptr %232, ptr %233
  %234 = load i32, ptr %161
  %235 = load ptr, ptr %154
  store i32 %234, ptr %235
  %236 = load i32, ptr %163
  %237 = load ptr, ptr %154
  store i32 %236, ptr %237
  %238 = load ptr, ptr %154
  store ptr %238, ptr %2
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
  ret ptr %2
L77:
  ret ptr 0
}

define internal ptr @parse_primary(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  store i32 %4, ptr %2
  %5 = call i32 @check(ptr %0, ptr @TOK_INT_LIT)
  %6 = icmp ne i64 %5, 0
  br i1 %6, label %L0, label %L2
L0:
  %7 = alloca ptr
  %9 = load i32, ptr %2
  %10 = call ptr @node_new(ptr @ND_INT_LIT, i32 %9)
  store ptr %10, ptr %7
  %11 = load i64, ptr %0
  %12 = inttoptr i64 0 to ptr
  %13 = call i32 @strtoll(i32 %11, ptr %12, i32 0)
  %14 = sext i32 %13 to i64
  %15 = load ptr, ptr %7
  store i64 %14, ptr %15
  call void @advance(ptr %0)
  %17 = load ptr, ptr %7
  ret ptr %17
L3:
  br label %L2
L2:
  %18 = call i32 @check(ptr %0, ptr @TOK_FLOAT_LIT)
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L4, label %L6
L4:
  %20 = alloca ptr
  %22 = load i32, ptr %2
  %23 = call ptr @node_new(ptr @ND_FLOAT_LIT, i32 %22)
  store ptr %23, ptr %20
  %24 = load i64, ptr %0
  %25 = call i32 @atof(i32 %24)
  %26 = load ptr, ptr %20
  store i32 %25, ptr %26
  call void @advance(ptr %0)
  %28 = load ptr, ptr %20
  ret ptr %28
L7:
  br label %L6
L6:
  %29 = call i32 @check(ptr %0, ptr @TOK_CHAR_LIT)
  %30 = icmp ne i64 %29, 0
  br i1 %30, label %L8, label %L10
L8:
  %31 = alloca ptr
  %33 = load i32, ptr %2
  %34 = call ptr @node_new(ptr @ND_CHAR_LIT, i32 %33)
  store ptr %34, ptr %31
  %35 = alloca ptr
  %37 = load i64, ptr %0
  store ptr %37, ptr %35
  %38 = load ptr, ptr %35
  %39 = getelementptr i8, ptr %38, i64 0
  %40 = load i8, ptr %39
  %42 = sext i32 %40 to i64
  %43 = sext i32 39 to i64
  %41 = icmp eq i64 %42, %43
  %44 = zext i1 %41 to i64
  %45 = load ptr, ptr %35
  %46 = getelementptr i8, ptr %45, i64 1
  %47 = load i8, ptr %46
  %49 = sext i32 %47 to i64
  %50 = sext i32 92 to i64
  %48 = icmp eq i64 %49, %50
  %51 = zext i1 %48 to i64
  %53 = sext i32 %44 to i64
  %54 = sext i32 %51 to i64
  %55 = icmp ne i64 %53, 0
  %56 = icmp ne i64 %54, 0
  %57 = and i1 %55, %56
  %58 = zext i1 %57 to i64
  %59 = icmp ne i64 %58, 0
  br i1 %59, label %L11, label %L12
L11:
  %60 = load ptr, ptr %35
  %61 = getelementptr i8, ptr %60, i64 2
  %62 = load i8, ptr %61
  %63 = sext i32 %62 to i64
  switch i64 %63, label %L19 [
    i64 110, label %L15
    i64 116, label %L16
    i64 114, label %L17
    i64 48, label %L18
  ]
L15:
  %64 = load ptr, ptr %31
  store i8 10, ptr %64
  br label %L14
L20:
  br label %L16
L16:
  %65 = load ptr, ptr %31
  store i8 9, ptr %65
  br label %L14
L21:
  br label %L17
L17:
  %66 = load ptr, ptr %31
  store i8 13, ptr %66
  br label %L14
L22:
  br label %L18
L18:
  %67 = load ptr, ptr %31
  store i8 0, ptr %67
  br label %L14
L23:
  br label %L14
L19:
  %68 = load ptr, ptr %35
  %69 = getelementptr i8, ptr %68, i64 2
  %70 = load i8, ptr %69
  %71 = load ptr, ptr %31
  store i8 %70, ptr %71
  br label %L14
L24:
  br label %L14
L14:
  br label %L13
L12:
  %72 = load ptr, ptr %35
  %73 = getelementptr i8, ptr %72, i64 1
  %74 = load i8, ptr %73
  %75 = bitcast i8 %74 to i8
  %76 = load ptr, ptr %31
  store i8 %75, ptr %76
  br label %L13
L13:
  call void @advance(ptr %0)
  %78 = load ptr, ptr %31
  ret ptr %78
L25:
  br label %L10
L10:
  %79 = call i32 @check(ptr %0, ptr @TOK_STRING_LIT)
  %80 = icmp ne i64 %79, 0
  br i1 %80, label %L26, label %L28
L26:
  %81 = alloca ptr
  %83 = load i32, ptr %2
  %84 = call ptr @node_new(ptr @ND_STRING_LIT, i32 %83)
  store ptr %84, ptr %81
  %85 = alloca i64
  %87 = load i64, ptr %0
  %88 = call i32 @strlen(i32 %87)
  store i64 %88, ptr %85
  %89 = alloca ptr
  %91 = load i64, ptr %85
  %93 = sext i32 %91 to i64
  %94 = sext i32 1 to i64
  %92 = add i64 %93, %94
  %95 = call i32 @malloc(i64 %92)
  store ptr %95, ptr %89
  %96 = load ptr, ptr %89
  %97 = load i64, ptr %0
  %98 = load i64, ptr %85
  %100 = sext i32 %98 to i64
  %101 = sext i32 1 to i64
  %99 = sub i64 %100, %101
  %102 = call i32 @memcpy(ptr %96, i32 %97, i64 %99)
  %103 = load ptr, ptr %89
  %104 = load i64, ptr %85
  %106 = sext i32 %104 to i64
  %107 = sext i32 1 to i64
  %105 = sub i64 %106, %107
  %108 = getelementptr i8, ptr %103, i64 %105
  store i8 0, ptr %108
  call void @advance(ptr %0)
  br label %L29
L29:
  %110 = call i32 @check(ptr %0, ptr @TOK_STRING_LIT)
  %111 = icmp ne i64 %110, 0
  br i1 %111, label %L30, label %L31
L30:
  %112 = alloca ptr
  %114 = load i64, ptr %0
  %116 = sext i32 %114 to i64
  %117 = sext i32 1 to i64
  %115 = add i64 %116, %117
  store ptr %115, ptr %112
  %118 = alloca i64
  %120 = load ptr, ptr %112
  %121 = call i32 @strlen(ptr %120)
  store i64 %121, ptr %118
  %122 = alloca i64
  %124 = load ptr, ptr %89
  %125 = call i32 @strlen(ptr %124)
  store i64 %125, ptr %122
  %126 = load ptr, ptr %89
  %127 = load i64, ptr %122
  %128 = load i64, ptr %118
  %130 = sext i32 %127 to i64
  %131 = sext i32 %128 to i64
  %129 = add i64 %130, %131
  %133 = sext i32 %129 to i64
  %134 = sext i32 1 to i64
  %132 = add i64 %133, %134
  %135 = call i32 @realloc(ptr %126, i64 %132)
  store i32 %135, ptr %89
  %136 = load ptr, ptr %89
  %137 = load i64, ptr %122
  %138 = getelementptr i8, ptr %136, i64 %137
  %139 = load ptr, ptr %112
  %140 = load i64, ptr %118
  %141 = call i32 @memcpy(ptr %138, ptr %139, i64 %140)
  %142 = load ptr, ptr %89
  %143 = load i64, ptr %122
  %144 = load i64, ptr %118
  %146 = sext i32 %143 to i64
  %147 = sext i32 %144 to i64
  %145 = add i64 %146, %147
  %148 = getelementptr i8, ptr %142, i64 %145
  store i8 0, ptr %148
  call void @advance(ptr %0)
  br label %L29
L31:
  %150 = alloca i64
  %152 = load ptr, ptr %89
  %153 = call i32 @strlen(ptr %152)
  store i64 %153, ptr %150
  %154 = load ptr, ptr %89
  %155 = load i64, ptr %150
  %157 = sext i32 %155 to i64
  %158 = sext i32 2 to i64
  %156 = add i64 %157, %158
  %159 = call i32 @realloc(ptr %154, i64 %156)
  store i32 %159, ptr %89
  %160 = load ptr, ptr %89
  %161 = load i64, ptr %150
  %162 = getelementptr i8, ptr %160, i64 %161
  store i8 34, ptr %162
  %163 = load ptr, ptr %89
  %164 = load i64, ptr %150
  %166 = sext i32 %164 to i64
  %167 = sext i32 1 to i64
  %165 = add i64 %166, %167
  %168 = getelementptr i8, ptr %163, i64 %165
  store i8 0, ptr %168
  %169 = load ptr, ptr %89
  %170 = load ptr, ptr %81
  store ptr %169, ptr %170
  %171 = load ptr, ptr %81
  ret ptr %171
L32:
  br label %L28
L28:
  %172 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %173 = icmp ne i64 %172, 0
  br i1 %173, label %L33, label %L35
L33:
  %174 = alloca ptr
  %176 = load i32, ptr %2
  %177 = call ptr @node_new(ptr @ND_IDENT, i32 %176)
  store ptr %177, ptr %174
  %178 = load i64, ptr %0
  %179 = call i32 @strdup(i32 %178)
  %180 = load ptr, ptr %174
  store i32 %179, ptr %180
  call void @advance(ptr %0)
  %182 = load ptr, ptr %174
  ret ptr %182
L36:
  br label %L35
L35:
  %183 = call i32 @match(ptr %0, ptr @TOK_LPAREN)
  %184 = icmp ne i64 %183, 0
  br i1 %184, label %L37, label %L39
L37:
  %185 = call i32 @is_type_start(ptr %0)
  %186 = icmp ne i64 %185, 0
  br i1 %186, label %L40, label %L42
L40:
  %187 = alloca i32
  store i32 0, ptr %187
  %189 = alloca i32
  store i32 0, ptr %189
  %191 = alloca i32
  store i32 0, ptr %191
  %193 = alloca ptr
  %195 = call ptr @parse_type_specifier(ptr %0, ptr @dummy_td, ptr @dummy_st, ptr @dummy_ex)
  store ptr %195, ptr %193
  %196 = load ptr, ptr %193
  %197 = icmp ne i64 %196, 0
  br i1 %197, label %L43, label %L45
L43:
  %198 = alloca ptr
  %200 = inttoptr i64 0 to ptr
  store ptr %200, ptr %198
  %201 = load ptr, ptr %193
  %202 = call ptr @parse_declarator(ptr %0, ptr %201, ptr %198)
  store ptr %202, ptr %193
  %203 = load ptr, ptr %198
  %204 = call i32 @free(ptr %203)
  %205 = call i32 @match(ptr %0, ptr @TOK_RPAREN)
  %206 = icmp ne i64 %205, 0
  br i1 %206, label %L46, label %L48
L46:
  %207 = alloca ptr
  %209 = load i32, ptr %2
  %210 = call ptr @node_new(ptr @ND_CAST, i32 %209)
  store ptr %210, ptr %207
  %211 = load ptr, ptr %193
  %212 = load ptr, ptr %207
  store ptr %211, ptr %212
  %213 = call ptr @parse_cast(ptr %0)
  %214 = load ptr, ptr %207
  store ptr %213, ptr %214
  %215 = load ptr, ptr %207
  ret ptr %215
L49:
  br label %L48
L48:
  br label %L45
L45:
  br label %L42
L42:
  %216 = alloca ptr
  %218 = call ptr @parse_expr(ptr %0)
  store ptr %218, ptr %216
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %220 = load ptr, ptr %216
  ret ptr %220
L50:
  br label %L39
L39:
  %221 = call i32 @check(ptr %0, ptr @TOK_SIZEOF)
  %222 = icmp ne i64 %221, 0
  br i1 %222, label %L51, label %L53
L51:
  call void @advance(ptr %0)
  %224 = call i32 @match(ptr %0, ptr @TOK_LPAREN)
  %225 = icmp ne i64 %224, 0
  br i1 %225, label %L54, label %L56
L54:
  %226 = call i32 @is_type_start(ptr %0)
  %227 = icmp ne i64 %226, 0
  br i1 %227, label %L57, label %L59
L57:
  %228 = alloca i32
  store i32 0, ptr %228
  %230 = alloca i32
  store i32 0, ptr %230
  %232 = alloca i32
  store i32 0, ptr %232
  %234 = alloca ptr
  %236 = call ptr @parse_type_specifier(ptr %0, ptr @dummy_td, ptr @dummy_st, ptr @dummy_ex)
  store ptr %236, ptr %234
  %237 = alloca ptr
  %239 = inttoptr i64 0 to ptr
  store ptr %239, ptr %237
  %240 = load ptr, ptr %234
  %241 = call ptr @parse_declarator(ptr %0, ptr %240, ptr %237)
  store ptr %241, ptr %234
  %242 = load ptr, ptr %237
  %243 = call i32 @free(ptr %242)
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %245 = alloca ptr
  %247 = load i32, ptr %2
  %248 = call ptr @node_new(ptr @ND_SIZEOF_TYPE, i32 %247)
  store ptr %248, ptr %245
  %249 = load ptr, ptr %234
  %250 = load ptr, ptr %245
  store ptr %249, ptr %250
  %251 = load ptr, ptr %245
  ret ptr %251
L60:
  br label %L59
L59:
  %252 = alloca ptr
  %254 = call ptr @parse_expr(ptr %0)
  store ptr %254, ptr %252
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %256 = alloca ptr
  %258 = load i32, ptr %2
  %259 = call ptr @node_new(ptr @ND_SIZEOF_EXPR, i32 %258)
  store ptr %259, ptr %256
  %260 = load ptr, ptr %256
  %261 = load ptr, ptr %252
  call void @node_add_child(ptr %260, ptr %261)
  %263 = load ptr, ptr %256
  ret ptr %263
L61:
  br label %L56
L56:
  %264 = alloca ptr
  %266 = call ptr @parse_unary(ptr %0)
  store ptr %266, ptr %264
  %267 = alloca ptr
  %269 = load i32, ptr %2
  %270 = call ptr @node_new(ptr @ND_SIZEOF_EXPR, i32 %269)
  store ptr %270, ptr %267
  %271 = load ptr, ptr %267
  %272 = load ptr, ptr %264
  call void @node_add_child(ptr %271, ptr %272)
  %274 = load ptr, ptr %267
  ret ptr %274
L62:
  br label %L53
L53:
  %275 = getelementptr [28 x i8], ptr @.str32, i64 0, i64 0
  call void @p_error(ptr %0, ptr %275)
  %277 = inttoptr i64 0 to ptr
  ret ptr %277
L63:
  ret ptr 0
}

define internal ptr @parse_postfix(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_primary(ptr %0)
  store ptr %4, ptr %2
  br label %L0
L0:
  br label %L1
L1:
  %5 = alloca i32
  %7 = load i64, ptr %0
  store i32 %7, ptr %5
  %8 = call i32 @match(ptr %0, ptr @TOK_LPAREN)
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %L4, label %L5
L4:
  %10 = alloca ptr
  %12 = load i32, ptr %5
  %13 = call ptr @node_new(ptr @ND_CALL, i32 %12)
  store ptr %13, ptr %10
  %14 = load ptr, ptr %10
  %15 = load ptr, ptr %2
  call void @node_add_child(ptr %14, ptr %15)
  br label %L7
L7:
  %17 = call i32 @check(ptr %0, ptr @TOK_RPAREN)
  %19 = icmp eq i64 %17, 0
  %18 = zext i1 %19 to i64
  %20 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %22 = icmp eq i64 %20, 0
  %21 = zext i1 %22 to i64
  %24 = sext i32 %18 to i64
  %25 = sext i32 %21 to i64
  %26 = icmp ne i64 %24, 0
  %27 = icmp ne i64 %25, 0
  %28 = and i1 %26, %27
  %29 = zext i1 %28 to i64
  %30 = icmp ne i64 %29, 0
  br i1 %30, label %L8, label %L9
L8:
  %31 = load ptr, ptr %10
  %32 = call ptr @parse_assign(ptr %0)
  call void @node_add_child(ptr %31, ptr %32)
  %34 = call i32 @match(ptr %0, ptr @TOK_COMMA)
  %36 = icmp eq i64 %34, 0
  %35 = zext i1 %36 to i64
  %37 = icmp ne i64 %35, 0
  br i1 %37, label %L10, label %L12
L10:
  br label %L9
L13:
  br label %L12
L12:
  br label %L7
L9:
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %39 = load ptr, ptr %10
  store ptr %39, ptr %2
  br label %L6
L5:
  %40 = call i32 @match(ptr %0, ptr @TOK_LBRACKET)
  %41 = icmp ne i64 %40, 0
  br i1 %41, label %L14, label %L15
L14:
  %42 = alloca ptr
  %44 = load i32, ptr %5
  %45 = call ptr @node_new(ptr @ND_INDEX, i32 %44)
  store ptr %45, ptr %42
  %46 = load ptr, ptr %42
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %42
  %50 = call ptr @parse_expr(ptr %0)
  call void @node_add_child(ptr %49, ptr %50)
  call void @expect(ptr %0, ptr @TOK_RBRACKET)
  %53 = load ptr, ptr %42
  store ptr %53, ptr %2
  br label %L16
L15:
  %54 = call i32 @match(ptr %0, ptr @TOK_DOT)
  %55 = icmp ne i64 %54, 0
  br i1 %55, label %L17, label %L18
L17:
  %56 = alloca ptr
  %58 = load i32, ptr %5
  %59 = call ptr @node_new(ptr @ND_MEMBER, i32 %58)
  store ptr %59, ptr %56
  %60 = call ptr @expect_ident(ptr %0)
  %61 = load ptr, ptr %56
  store ptr %60, ptr %61
  %62 = load ptr, ptr %56
  %63 = load ptr, ptr %2
  call void @node_add_child(ptr %62, ptr %63)
  %65 = load ptr, ptr %56
  store ptr %65, ptr %2
  br label %L19
L18:
  %66 = call i32 @match(ptr %0, ptr @TOK_ARROW)
  %67 = icmp ne i64 %66, 0
  br i1 %67, label %L20, label %L21
L20:
  %68 = alloca ptr
  %70 = load i32, ptr %5
  %71 = call ptr @node_new(ptr @ND_ARROW, i32 %70)
  store ptr %71, ptr %68
  %72 = call ptr @expect_ident(ptr %0)
  %73 = load ptr, ptr %68
  store ptr %72, ptr %73
  %74 = load ptr, ptr %68
  %75 = load ptr, ptr %2
  call void @node_add_child(ptr %74, ptr %75)
  %77 = load ptr, ptr %68
  store ptr %77, ptr %2
  br label %L22
L21:
  %78 = call i32 @check(ptr %0, ptr @TOK_INC)
  %79 = icmp ne i64 %78, 0
  br i1 %79, label %L23, label %L24
L23:
  call void @advance(ptr %0)
  %81 = alloca ptr
  %83 = load i32, ptr %5
  %84 = call ptr @node_new(ptr @ND_POST_INC, i32 %83)
  store ptr %84, ptr %81
  %85 = load ptr, ptr %81
  %86 = load ptr, ptr %2
  call void @node_add_child(ptr %85, ptr %86)
  %88 = load ptr, ptr %81
  store ptr %88, ptr %2
  br label %L25
L24:
  %89 = call i32 @check(ptr %0, ptr @TOK_DEC)
  %90 = icmp ne i64 %89, 0
  br i1 %90, label %L26, label %L27
L26:
  call void @advance(ptr %0)
  %92 = alloca ptr
  %94 = load i32, ptr %5
  %95 = call ptr @node_new(ptr @ND_POST_DEC, i32 %94)
  store ptr %95, ptr %92
  %96 = load ptr, ptr %92
  %97 = load ptr, ptr %2
  call void @node_add_child(ptr %96, ptr %97)
  %99 = load ptr, ptr %92
  store ptr %99, ptr %2
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
  %100 = load ptr, ptr %2
  ret ptr %100
L30:
  ret ptr 0
}

define internal ptr @parse_unary(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  store i32 %4, ptr %2
  %5 = call i32 @check(ptr %0, ptr @TOK_INC)
  %6 = icmp ne i64 %5, 0
  br i1 %6, label %L0, label %L2
L0:
  call void @advance(ptr %0)
  %8 = alloca ptr
  %10 = load i32, ptr %2
  %11 = call ptr @node_new(ptr @ND_PRE_INC, i32 %10)
  store ptr %11, ptr %8
  %12 = load ptr, ptr %8
  %13 = call ptr @parse_unary(ptr %0)
  call void @node_add_child(ptr %12, ptr %13)
  %15 = load ptr, ptr %8
  ret ptr %15
L3:
  br label %L2
L2:
  %16 = call i32 @check(ptr %0, ptr @TOK_DEC)
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %L4, label %L6
L4:
  call void @advance(ptr %0)
  %19 = alloca ptr
  %21 = load i32, ptr %2
  %22 = call ptr @node_new(ptr @ND_PRE_DEC, i32 %21)
  store ptr %22, ptr %19
  %23 = load ptr, ptr %19
  %24 = call ptr @parse_unary(ptr %0)
  call void @node_add_child(ptr %23, ptr %24)
  %26 = load ptr, ptr %19
  ret ptr %26
L7:
  br label %L6
L6:
  %27 = call i32 @check(ptr %0, ptr @TOK_AMP)
  %28 = icmp ne i64 %27, 0
  br i1 %28, label %L8, label %L10
L8:
  call void @advance(ptr %0)
  %30 = alloca ptr
  %32 = load i32, ptr %2
  %33 = call ptr @node_new(ptr @ND_ADDR, i32 %32)
  store ptr %33, ptr %30
  %34 = load ptr, ptr %30
  %35 = call ptr @parse_cast(ptr %0)
  call void @node_add_child(ptr %34, ptr %35)
  %37 = load ptr, ptr %30
  ret ptr %37
L11:
  br label %L10
L10:
  %38 = call i32 @check(ptr %0, ptr @TOK_STAR)
  %39 = icmp ne i64 %38, 0
  br i1 %39, label %L12, label %L14
L12:
  call void @advance(ptr %0)
  %41 = alloca ptr
  %43 = load i32, ptr %2
  %44 = call ptr @node_new(ptr @ND_DEREF, i32 %43)
  store ptr %44, ptr %41
  %45 = load ptr, ptr %41
  %46 = call ptr @parse_cast(ptr %0)
  call void @node_add_child(ptr %45, ptr %46)
  %48 = load ptr, ptr %41
  ret ptr %48
L15:
  br label %L14
L14:
  %49 = call i32 @check(ptr %0, ptr @TOK_MINUS)
  %50 = call i32 @check(ptr %0, ptr @TOK_PLUS)
  %52 = sext i32 %49 to i64
  %53 = sext i32 %50 to i64
  %54 = icmp ne i64 %52, 0
  %55 = icmp ne i64 %53, 0
  %56 = or i1 %54, %55
  %57 = zext i1 %56 to i64
  %58 = call i32 @check(ptr %0, ptr @TOK_BANG)
  %60 = sext i32 %57 to i64
  %61 = sext i32 %58 to i64
  %62 = icmp ne i64 %60, 0
  %63 = icmp ne i64 %61, 0
  %64 = or i1 %62, %63
  %65 = zext i1 %64 to i64
  %66 = call i32 @check(ptr %0, ptr @TOK_TILDE)
  %68 = sext i32 %65 to i64
  %69 = sext i32 %66 to i64
  %70 = icmp ne i64 %68, 0
  %71 = icmp ne i64 %69, 0
  %72 = or i1 %70, %71
  %73 = zext i1 %72 to i64
  %74 = icmp ne i64 %73, 0
  br i1 %74, label %L16, label %L18
L16:
  %75 = alloca i32
  %77 = load i64, ptr %0
  store i32 %77, ptr %75
  call void @advance(ptr %0)
  %79 = alloca ptr
  %81 = load i32, ptr %2
  %82 = call ptr @node_new(ptr @ND_UNOP, i32 %81)
  store ptr %82, ptr %79
  %83 = load i32, ptr %75
  %84 = load ptr, ptr %79
  store i32 %83, ptr %84
  %85 = load ptr, ptr %79
  %86 = call ptr @parse_cast(ptr %0)
  call void @node_add_child(ptr %85, ptr %86)
  %88 = load ptr, ptr %79
  ret ptr %88
L19:
  br label %L18
L18:
  %89 = call ptr @parse_postfix(ptr %0)
  ret ptr %89
L20:
  ret ptr 0
}

define internal ptr @parse_cast(ptr %0) {
entry:
  %2 = call ptr @parse_unary(ptr %0)
  ret ptr %2
L0:
  ret ptr 0
}

define internal ptr @parse_mul(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_cast(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_cast(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_add(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_mul(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_mul(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_shift(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_add(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_add(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_relational(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_shift(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_shift(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_equality(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_relational(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_relational(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_bitand(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_equality(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_equality(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_bitxor(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_bitand(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_bitand(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_bitor(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_bitxor(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_bitxor(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_logand(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_bitor(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_bitor(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_logor(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_logand(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca ptr
  store ptr 0, ptr %5
  br label %L0
L0:
  br label %L1
L1:
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  br label %L4
L4:
  %11 = load ptr, ptr %5
  %12 = load i32, ptr %9
  %13 = getelementptr i64, ptr %11, i64 %12
  %14 = load i64, ptr %13
  %16 = sext i32 %14 to i64
  %17 = sext i32 @TOK_EOF to i64
  %15 = icmp ne i64 %16, %17
  %18 = zext i1 %15 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %L5, label %L7
L5:
  %20 = load i64, ptr %0
  %21 = load ptr, ptr %5
  %22 = load i32, ptr %9
  %23 = getelementptr i64, ptr %21, i64 %22
  %24 = load i64, ptr %23
  %26 = sext i32 %20 to i64
  %27 = sext i32 %24 to i64
  %25 = icmp eq i64 %26, %27
  %28 = zext i1 %25 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %L8, label %L10
L8:
  %30 = alloca i32
  %32 = load i64, ptr %0
  store i32 %32, ptr %30
  %33 = alloca i32
  %35 = load i64, ptr %0
  store i32 %35, ptr %33
  call void @advance(ptr %0)
  %37 = alloca ptr
  %39 = call ptr @parse_logand(ptr %0)
  store ptr %39, ptr %37
  %40 = alloca ptr
  %42 = load i32, ptr %30
  %43 = call ptr @node_new(ptr @ND_BINOP, i32 %42)
  store ptr %43, ptr %40
  %44 = load i32, ptr %33
  %45 = load ptr, ptr %40
  store i32 %44, ptr %45
  %46 = load ptr, ptr %40
  %47 = load ptr, ptr %2
  call void @node_add_child(ptr %46, ptr %47)
  %49 = load ptr, ptr %40
  %50 = load ptr, ptr %37
  call void @node_add_child(ptr %49, ptr %50)
  %52 = load ptr, ptr %40
  store ptr %52, ptr %2
  store i32 1, ptr %7
  br label %L7
L11:
  br label %L10
L10:
  br label %L6
L6:
  %53 = load i32, ptr %9
  %55 = sext i32 %53 to i64
  %54 = add i64 %55, 1
  store i64 %54, ptr %9
  br label %L4
L7:
  %56 = load i32, ptr %7
  %58 = icmp eq i64 %56, 0
  %57 = zext i1 %58 to i64
  %59 = icmp ne i64 %57, 0
  br i1 %59, label %L12, label %L14
L12:
  br label %L3
L15:
  br label %L14
L14:
  br label %L2
L2:
  br label %L0
L3:
  %60 = load ptr, ptr %2
  ret ptr %60
L16:
  ret ptr 0
}

define internal ptr @parse_ternary(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_logor(ptr %0)
  store ptr %4, ptr %2
  %5 = call i32 @check(ptr %0, ptr @TOK_QUESTION)
  %7 = icmp eq i64 %5, 0
  %6 = zext i1 %7 to i64
  %8 = icmp ne i64 %6, 0
  br i1 %8, label %L0, label %L2
L0:
  %9 = load ptr, ptr %2
  ret ptr %9
L3:
  br label %L2
L2:
  %10 = alloca i32
  %12 = load i64, ptr %0
  store i32 %12, ptr %10
  call void @advance(ptr %0)
  %14 = alloca ptr
  %16 = call ptr @parse_expr(ptr %0)
  store ptr %16, ptr %14
  call void @expect(ptr %0, ptr @TOK_COLON)
  %18 = alloca ptr
  %20 = call ptr @parse_ternary(ptr %0)
  store ptr %20, ptr %18
  %21 = alloca ptr
  %23 = load i32, ptr %10
  %24 = call ptr @node_new(ptr @ND_TERNARY, i32 %23)
  store ptr %24, ptr %21
  %25 = load ptr, ptr %2
  %26 = load ptr, ptr %21
  store ptr %25, ptr %26
  %27 = load ptr, ptr %21
  %28 = load ptr, ptr %14
  call void @node_add_child(ptr %27, ptr %28)
  %30 = load ptr, ptr %21
  %31 = load ptr, ptr %18
  call void @node_add_child(ptr %30, ptr %31)
  %33 = load ptr, ptr %21
  ret ptr %33
L4:
  ret ptr 0
}

define internal ptr @parse_assign(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_ternary(ptr %0)
  store ptr %4, ptr %2
  %5 = alloca i32
  %7 = load i64, ptr %0
  store i32 %7, ptr %5
  %8 = alloca ptr
  store ptr 0, ptr %8
  %10 = alloca i32
  store i32 0, ptr %10
  br label %L0
L0:
  %12 = load ptr, ptr %8
  %13 = load i32, ptr %10
  %14 = getelementptr i64, ptr %12, i64 %13
  %15 = load i64, ptr %14
  %17 = sext i32 %15 to i64
  %18 = sext i32 @TOK_EOF to i64
  %16 = icmp ne i64 %17, %18
  %19 = zext i1 %16 to i64
  %20 = icmp ne i64 %19, 0
  br i1 %20, label %L1, label %L3
L1:
  %21 = load i64, ptr %0
  %22 = load ptr, ptr %8
  %23 = load i32, ptr %10
  %24 = getelementptr i64, ptr %22, i64 %23
  %25 = load i64, ptr %24
  %27 = sext i32 %21 to i64
  %28 = sext i32 %25 to i64
  %26 = icmp eq i64 %27, %28
  %29 = zext i1 %26 to i64
  %30 = icmp ne i64 %29, 0
  br i1 %30, label %L4, label %L6
L4:
  %31 = alloca i32
  %33 = load i64, ptr %0
  store i32 %33, ptr %31
  call void @advance(ptr %0)
  %35 = alloca ptr
  %37 = call ptr @parse_assign(ptr %0)
  store ptr %37, ptr %35
  %38 = alloca i64
  %40 = load i32, ptr %31
  %42 = sext i32 %40 to i64
  %43 = sext i32 @TOK_ASSIGN to i64
  %41 = icmp eq i64 %42, %43
  %44 = zext i1 %41 to i64
  %45 = icmp ne i64 %44, 0
  br i1 %45, label %L7, label %L8
L7:
  br label %L9
L8:
  br label %L9
L9:
  %46 = phi i64 [ @ND_ASSIGN, %L7 ], [ @ND_COMPOUND_ASSIGN, %L8 ]
  store i64 %46, ptr %38
  %47 = alloca ptr
  %49 = load i64, ptr %38
  %50 = load i32, ptr %5
  %51 = call ptr @node_new(i64 %49, i32 %50)
  store ptr %51, ptr %47
  %52 = load i32, ptr %31
  %53 = load ptr, ptr %47
  store i32 %52, ptr %53
  %54 = load ptr, ptr %47
  %55 = load ptr, ptr %2
  call void @node_add_child(ptr %54, ptr %55)
  %57 = load ptr, ptr %47
  %58 = load ptr, ptr %35
  call void @node_add_child(ptr %57, ptr %58)
  %60 = load ptr, ptr %47
  ret ptr %60
L10:
  br label %L6
L6:
  br label %L2
L2:
  %61 = load i32, ptr %10
  %63 = sext i32 %61 to i64
  %62 = add i64 %63, 1
  store i64 %62, ptr %10
  br label %L0
L3:
  %64 = load ptr, ptr %2
  ret ptr %64
L11:
  ret ptr 0
}

define internal ptr @parse_expr(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @parse_assign(ptr %0)
  store ptr %4, ptr %2
  %5 = call i32 @check(ptr %0, ptr @TOK_COMMA)
  %6 = icmp ne i64 %5, 0
  br i1 %6, label %L0, label %L2
L0:
  %7 = alloca i32
  %9 = load i64, ptr %0
  store i32 %9, ptr %7
  %10 = alloca ptr
  %12 = load i32, ptr %7
  %13 = call ptr @node_new(ptr @ND_COMMA, i32 %12)
  store ptr %13, ptr %10
  %14 = load ptr, ptr %10
  %15 = load ptr, ptr %2
  call void @node_add_child(ptr %14, ptr %15)
  br label %L3
L3:
  %17 = call i32 @match(ptr %0, ptr @TOK_COMMA)
  %18 = icmp ne i64 %17, 0
  br i1 %18, label %L4, label %L5
L4:
  %19 = load ptr, ptr %10
  %20 = call ptr @parse_assign(ptr %0)
  call void @node_add_child(ptr %19, ptr %20)
  br label %L3
L5:
  %22 = load ptr, ptr %10
  ret ptr %22
L6:
  br label %L2
L2:
  %23 = load ptr, ptr %2
  ret ptr %23
L7:
  ret ptr 0
}

define internal ptr @parse_local_decl(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  store i32 %4, ptr %2
  %5 = alloca i32
  store i32 0, ptr %5
  %7 = alloca i32
  store i32 0, ptr %7
  %9 = alloca i32
  store i32 0, ptr %9
  %11 = alloca ptr
  %13 = call ptr @parse_type_specifier(ptr %0, ptr @is_typedef, ptr @is_static, ptr @is_extern)
  store ptr %13, ptr %11
  %14 = load ptr, ptr %11
  %16 = icmp eq i64 %14, 0
  %15 = zext i1 %16 to i64
  %17 = icmp ne i64 %15, 0
  br i1 %17, label %L0, label %L2
L0:
  %18 = inttoptr i64 0 to ptr
  ret ptr %18
L3:
  br label %L2
L2:
  %19 = alloca ptr
  %21 = load i32, ptr %2
  %22 = call ptr @node_new(ptr @ND_BLOCK, i32 %21)
  store ptr %22, ptr %19
  br label %L4
L4:
  %23 = alloca ptr
  %25 = inttoptr i64 0 to ptr
  store ptr %25, ptr %23
  %26 = alloca ptr
  %28 = load ptr, ptr %11
  %29 = call ptr @parse_declarator(ptr %0, ptr %28, ptr %23)
  store ptr %29, ptr %26
  %30 = load ptr, ptr %23
  %32 = icmp ne i64 @is_typedef, 0
  %33 = icmp ne i64 %30, 0
  %34 = and i1 %32, %33
  %35 = zext i1 %34 to i64
  %36 = icmp ne i64 %35, 0
  br i1 %36, label %L7, label %L8
L7:
  %37 = load ptr, ptr %23
  %38 = load ptr, ptr %26
  call void @register_typedef(ptr %0, ptr %37, ptr %38)
  %40 = alloca ptr
  %42 = load i32, ptr %2
  %43 = call ptr @node_new(ptr @ND_TYPEDEF, i32 %42)
  store ptr %43, ptr %40
  %44 = load ptr, ptr %23
  %45 = load ptr, ptr %40
  store ptr %44, ptr %45
  %46 = load ptr, ptr %26
  %47 = load ptr, ptr %40
  store ptr %46, ptr %47
  %48 = load ptr, ptr %19
  %49 = load ptr, ptr %40
  call void @node_add_child(ptr %48, ptr %49)
  br label %L9
L8:
  %51 = alloca ptr
  %53 = load i32, ptr %2
  %54 = call ptr @node_new(ptr @ND_VAR_DECL, i32 %53)
  store ptr %54, ptr %51
  %55 = load ptr, ptr %23
  %56 = load ptr, ptr %51
  store ptr %55, ptr %56
  %57 = load ptr, ptr %26
  %58 = load ptr, ptr %51
  store ptr %57, ptr %58
  %59 = load ptr, ptr %51
  store ptr @is_static, ptr %59
  %60 = load ptr, ptr %51
  store ptr @is_extern, ptr %60
  %61 = call i32 @match(ptr %0, ptr @TOK_ASSIGN)
  %62 = icmp ne i64 %61, 0
  br i1 %62, label %L10, label %L12
L10:
  %63 = load ptr, ptr %51
  %64 = call ptr @parse_initializer(ptr %0)
  call void @node_add_child(ptr %63, ptr %64)
  br label %L12
L12:
  %66 = load ptr, ptr %19
  %67 = load ptr, ptr %51
  call void @node_add_child(ptr %66, ptr %67)
  br label %L9
L9:
  br label %L5
L5:
  %69 = call i32 @match(ptr %0, ptr @TOK_COMMA)
  %70 = icmp ne i64 %69, 0
  br i1 %70, label %L4, label %L6
L6:
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %72 = load ptr, ptr %19
  %73 = load i64, ptr %72
  %75 = sext i32 %73 to i64
  %76 = sext i32 1 to i64
  %74 = icmp eq i64 %75, %76
  %77 = zext i1 %74 to i64
  %78 = icmp ne i64 %77, 0
  br i1 %78, label %L13, label %L15
L13:
  %79 = alloca ptr
  %81 = load ptr, ptr %19
  %82 = load i64, ptr %81
  %83 = getelementptr i32, ptr %82, i64 0
  %84 = load i32, ptr %83
  store ptr %84, ptr %79
  %85 = load ptr, ptr %19
  store i32 0, ptr %85
  %86 = load ptr, ptr %19
  %87 = load i64, ptr %86
  %88 = call i32 @free(i32 %87)
  %89 = load ptr, ptr %19
  %90 = call i32 @free(ptr %89)
  %91 = load ptr, ptr %79
  ret ptr %91
L16:
  br label %L15
L15:
  %92 = load ptr, ptr %19
  ret ptr %92
L17:
  ret ptr 0
}

define internal ptr @parse_initializer(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  store i32 %4, ptr %2
  %5 = call i32 @check(ptr %0, ptr @TOK_LBRACE)
  %7 = icmp eq i64 %5, 0
  %6 = zext i1 %7 to i64
  %8 = icmp ne i64 %6, 0
  br i1 %8, label %L0, label %L2
L0:
  %9 = call ptr @parse_assign(ptr %0)
  ret ptr %9
L3:
  br label %L2
L2:
  call void @advance(ptr %0)
  %11 = alloca i32
  store i32 1, ptr %11
  br label %L4
L4:
  %13 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %15 = icmp eq i64 %13, 0
  %14 = zext i1 %15 to i64
  %16 = load i32, ptr %11
  %18 = sext i32 %16 to i64
  %19 = sext i32 0 to i64
  %17 = icmp sgt i64 %18, %19
  %20 = zext i1 %17 to i64
  %22 = sext i32 %14 to i64
  %23 = sext i32 %20 to i64
  %24 = icmp ne i64 %22, 0
  %25 = icmp ne i64 %23, 0
  %26 = and i1 %24, %25
  %27 = zext i1 %26 to i64
  %28 = icmp ne i64 %27, 0
  br i1 %28, label %L5, label %L6
L5:
  %29 = call i32 @check(ptr %0, ptr @TOK_LBRACE)
  %30 = icmp ne i64 %29, 0
  br i1 %30, label %L7, label %L8
L7:
  %31 = load i32, ptr %11
  %33 = sext i32 %31 to i64
  %32 = add i64 %33, 1
  store i64 %32, ptr %11
  br label %L9
L8:
  %34 = call i32 @check(ptr %0, ptr @TOK_RBRACE)
  %35 = icmp ne i64 %34, 0
  br i1 %35, label %L10, label %L12
L10:
  %36 = load i32, ptr %11
  %38 = sext i32 %36 to i64
  %37 = sub i64 %38, 1
  store i64 %37, ptr %11
  %39 = load i32, ptr %11
  %41 = sext i32 %39 to i64
  %42 = sext i32 0 to i64
  %40 = icmp eq i64 %41, %42
  %43 = zext i1 %40 to i64
  %44 = icmp ne i64 %43, 0
  br i1 %44, label %L13, label %L15
L13:
  br label %L6
L16:
  br label %L15
L15:
  br label %L12
L12:
  br label %L9
L9:
  call void @advance(ptr %0)
  br label %L4
L6:
  call void @expect(ptr %0, ptr @TOK_RBRACE)
  %47 = alloca ptr
  %49 = load i32, ptr %2
  %50 = call ptr @node_new(ptr @ND_INT_LIT, i32 %49)
  store ptr %50, ptr %47
  %51 = load ptr, ptr %47
  store i32 0, ptr %51
  %52 = getelementptr [7 x i8], ptr @.str33, i64 0, i64 0
  %53 = call i32 @strdup(ptr %52)
  %54 = load ptr, ptr %47
  store i32 %53, ptr %54
  %55 = load ptr, ptr %47
  ret ptr %55
L17:
  ret ptr 0
}

define internal ptr @parse_stmt(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  store i32 %4, ptr %2
  %5 = call i32 @check(ptr %0, ptr @TOK_LBRACE)
  %6 = icmp ne i64 %5, 0
  br i1 %6, label %L0, label %L2
L0:
  %7 = call ptr @parse_block(ptr %0)
  ret ptr %7
L3:
  br label %L2
L2:
  %8 = call i32 @check(ptr %0, ptr @TOK_IF)
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %L4, label %L6
L4:
  call void @advance(ptr %0)
  %11 = alloca ptr
  %13 = load i32, ptr %2
  %14 = call ptr @node_new(ptr @ND_IF, i32 %13)
  store ptr %14, ptr %11
  call void @expect(ptr %0, ptr @TOK_LPAREN)
  %16 = call ptr @parse_expr(ptr %0)
  %17 = load ptr, ptr %11
  store ptr %16, ptr %17
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %19 = call ptr @parse_stmt(ptr %0)
  %20 = load ptr, ptr %11
  store ptr %19, ptr %20
  %21 = call i32 @match(ptr %0, ptr @TOK_ELSE)
  %22 = icmp ne i64 %21, 0
  br i1 %22, label %L7, label %L9
L7:
  %23 = call ptr @parse_stmt(ptr %0)
  %24 = load ptr, ptr %11
  store ptr %23, ptr %24
  br label %L9
L9:
  %25 = load ptr, ptr %11
  ret ptr %25
L10:
  br label %L6
L6:
  %26 = call i32 @check(ptr %0, ptr @TOK_WHILE)
  %27 = icmp ne i64 %26, 0
  br i1 %27, label %L11, label %L13
L11:
  call void @advance(ptr %0)
  %29 = alloca ptr
  %31 = load i32, ptr %2
  %32 = call ptr @node_new(ptr @ND_WHILE, i32 %31)
  store ptr %32, ptr %29
  call void @expect(ptr %0, ptr @TOK_LPAREN)
  %34 = call ptr @parse_expr(ptr %0)
  %35 = load ptr, ptr %29
  store ptr %34, ptr %35
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %37 = call ptr @parse_stmt(ptr %0)
  %38 = load ptr, ptr %29
  store ptr %37, ptr %38
  %39 = load ptr, ptr %29
  ret ptr %39
L14:
  br label %L13
L13:
  %40 = call i32 @check(ptr %0, ptr @TOK_DO)
  %41 = icmp ne i64 %40, 0
  br i1 %41, label %L15, label %L17
L15:
  call void @advance(ptr %0)
  %43 = alloca ptr
  %45 = load i32, ptr %2
  %46 = call ptr @node_new(ptr @ND_DO_WHILE, i32 %45)
  store ptr %46, ptr %43
  %47 = call ptr @parse_stmt(ptr %0)
  %48 = load ptr, ptr %43
  store ptr %47, ptr %48
  call void @expect(ptr %0, ptr @TOK_WHILE)
  call void @expect(ptr %0, ptr @TOK_LPAREN)
  %51 = call ptr @parse_expr(ptr %0)
  %52 = load ptr, ptr %43
  store ptr %51, ptr %52
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %55 = load ptr, ptr %43
  ret ptr %55
L18:
  br label %L17
L17:
  %56 = call i32 @check(ptr %0, ptr @TOK_FOR)
  %57 = icmp ne i64 %56, 0
  br i1 %57, label %L19, label %L21
L19:
  call void @advance(ptr %0)
  %59 = alloca ptr
  %61 = load i32, ptr %2
  %62 = call ptr @node_new(ptr @ND_FOR, i32 %61)
  store ptr %62, ptr %59
  call void @expect(ptr %0, ptr @TOK_LPAREN)
  %64 = call i32 @check(ptr %0, ptr @TOK_SEMICOLON)
  %66 = icmp eq i64 %64, 0
  %65 = zext i1 %66 to i64
  %67 = icmp ne i64 %65, 0
  br i1 %67, label %L22, label %L23
L22:
  %68 = call i32 @is_type_start(ptr %0)
  %69 = icmp ne i64 %68, 0
  br i1 %69, label %L25, label %L26
L25:
  %70 = call ptr @parse_local_decl(ptr %0)
  %71 = load ptr, ptr %59
  store ptr %70, ptr %71
  br label %L27
L26:
  %72 = load i32, ptr %2
  %73 = call ptr @node_new(ptr @ND_EXPR_STMT, i32 %72)
  %74 = load ptr, ptr %59
  store ptr %73, ptr %74
  %75 = load ptr, ptr %59
  %76 = load i64, ptr %75
  %77 = call ptr @parse_expr(ptr %0)
  call void @node_add_child(i32 %76, ptr %77)
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  br label %L27
L27:
  br label %L24
L23:
  call void @advance(ptr %0)
  br label %L24
L24:
  %81 = call i32 @check(ptr %0, ptr @TOK_SEMICOLON)
  %83 = icmp eq i64 %81, 0
  %82 = zext i1 %83 to i64
  %84 = icmp ne i64 %82, 0
  br i1 %84, label %L28, label %L30
L28:
  %85 = call ptr @parse_expr(ptr %0)
  %86 = load ptr, ptr %59
  store ptr %85, ptr %86
  br label %L30
L30:
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %88 = call i32 @check(ptr %0, ptr @TOK_RPAREN)
  %90 = icmp eq i64 %88, 0
  %89 = zext i1 %90 to i64
  %91 = icmp ne i64 %89, 0
  br i1 %91, label %L31, label %L33
L31:
  %92 = call ptr @parse_expr(ptr %0)
  %93 = load ptr, ptr %59
  store ptr %92, ptr %93
  br label %L33
L33:
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %95 = call ptr @parse_stmt(ptr %0)
  %96 = load ptr, ptr %59
  store ptr %95, ptr %96
  %97 = load ptr, ptr %59
  ret ptr %97
L34:
  br label %L21
L21:
  %98 = call i32 @check(ptr %0, ptr @TOK_RETURN)
  %99 = icmp ne i64 %98, 0
  br i1 %99, label %L35, label %L37
L35:
  call void @advance(ptr %0)
  %101 = alloca ptr
  %103 = load i32, ptr %2
  %104 = call ptr @node_new(ptr @ND_RETURN, i32 %103)
  store ptr %104, ptr %101
  %105 = call i32 @check(ptr %0, ptr @TOK_SEMICOLON)
  %107 = icmp eq i64 %105, 0
  %106 = zext i1 %107 to i64
  %108 = icmp ne i64 %106, 0
  br i1 %108, label %L38, label %L40
L38:
  %109 = call ptr @parse_expr(ptr %0)
  %110 = load ptr, ptr %101
  store ptr %109, ptr %110
  br label %L40
L40:
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %112 = load ptr, ptr %101
  ret ptr %112
L41:
  br label %L37
L37:
  %113 = call i32 @check(ptr %0, ptr @TOK_BREAK)
  %114 = icmp ne i64 %113, 0
  br i1 %114, label %L42, label %L44
L42:
  call void @advance(ptr %0)
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %117 = load i32, ptr %2
  %118 = call ptr @node_new(ptr @ND_BREAK, i32 %117)
  ret ptr %118
L45:
  br label %L44
L44:
  %119 = call i32 @check(ptr %0, ptr @TOK_CONTINUE)
  %120 = icmp ne i64 %119, 0
  br i1 %120, label %L46, label %L48
L46:
  call void @advance(ptr %0)
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %123 = load i32, ptr %2
  %124 = call ptr @node_new(ptr @ND_CONTINUE, i32 %123)
  ret ptr %124
L49:
  br label %L48
L48:
  %125 = call i32 @check(ptr %0, ptr @TOK_SWITCH)
  %126 = icmp ne i64 %125, 0
  br i1 %126, label %L50, label %L52
L50:
  call void @advance(ptr %0)
  %128 = alloca ptr
  %130 = load i32, ptr %2
  %131 = call ptr @node_new(ptr @ND_SWITCH, i32 %130)
  store ptr %131, ptr %128
  call void @expect(ptr %0, ptr @TOK_LPAREN)
  %133 = call ptr @parse_expr(ptr %0)
  %134 = load ptr, ptr %128
  store ptr %133, ptr %134
  call void @expect(ptr %0, ptr @TOK_RPAREN)
  %136 = call ptr @parse_stmt(ptr %0)
  %137 = load ptr, ptr %128
  store ptr %136, ptr %137
  %138 = load ptr, ptr %128
  ret ptr %138
L53:
  br label %L52
L52:
  %139 = call i32 @check(ptr %0, ptr @TOK_CASE)
  %140 = icmp ne i64 %139, 0
  br i1 %140, label %L54, label %L56
L54:
  call void @advance(ptr %0)
  %142 = alloca ptr
  %144 = load i32, ptr %2
  %145 = call ptr @node_new(ptr @ND_CASE, i32 %144)
  store ptr %145, ptr %142
  %146 = call ptr @parse_expr(ptr %0)
  %147 = load ptr, ptr %142
  store ptr %146, ptr %147
  call void @expect(ptr %0, ptr @TOK_COLON)
  %149 = alloca ptr
  %151 = load i32, ptr %2
  %152 = call ptr @node_new(ptr @ND_BLOCK, i32 %151)
  store ptr %152, ptr %149
  br label %L57
L57:
  %153 = call i32 @check(ptr %0, ptr @TOK_CASE)
  %155 = icmp eq i64 %153, 0
  %154 = zext i1 %155 to i64
  %156 = call i32 @check(ptr %0, ptr @TOK_DEFAULT)
  %158 = icmp eq i64 %156, 0
  %157 = zext i1 %158 to i64
  %160 = sext i32 %154 to i64
  %161 = sext i32 %157 to i64
  %162 = icmp ne i64 %160, 0
  %163 = icmp ne i64 %161, 0
  %164 = and i1 %162, %163
  %165 = zext i1 %164 to i64
  %166 = call i32 @check(ptr %0, ptr @TOK_RBRACE)
  %168 = icmp eq i64 %166, 0
  %167 = zext i1 %168 to i64
  %170 = sext i32 %165 to i64
  %171 = sext i32 %167 to i64
  %172 = icmp ne i64 %170, 0
  %173 = icmp ne i64 %171, 0
  %174 = and i1 %172, %173
  %175 = zext i1 %174 to i64
  %176 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %178 = icmp eq i64 %176, 0
  %177 = zext i1 %178 to i64
  %180 = sext i32 %175 to i64
  %181 = sext i32 %177 to i64
  %182 = icmp ne i64 %180, 0
  %183 = icmp ne i64 %181, 0
  %184 = and i1 %182, %183
  %185 = zext i1 %184 to i64
  %186 = icmp ne i64 %185, 0
  br i1 %186, label %L58, label %L59
L58:
  %187 = load ptr, ptr %149
  %188 = call ptr @parse_stmt(ptr %0)
  call void @node_add_child(ptr %187, ptr %188)
  br label %L57
L59:
  %190 = load ptr, ptr %142
  %191 = load ptr, ptr %149
  call void @node_add_child(ptr %190, ptr %191)
  %193 = load ptr, ptr %142
  ret ptr %193
L60:
  br label %L56
L56:
  %194 = call i32 @check(ptr %0, ptr @TOK_DEFAULT)
  %195 = icmp ne i64 %194, 0
  br i1 %195, label %L61, label %L63
L61:
  call void @advance(ptr %0)
  call void @expect(ptr %0, ptr @TOK_COLON)
  %198 = alloca ptr
  %200 = load i32, ptr %2
  %201 = call ptr @node_new(ptr @ND_DEFAULT, i32 %200)
  store ptr %201, ptr %198
  %202 = alloca ptr
  %204 = load i32, ptr %2
  %205 = call ptr @node_new(ptr @ND_BLOCK, i32 %204)
  store ptr %205, ptr %202
  br label %L64
L64:
  %206 = call i32 @check(ptr %0, ptr @TOK_CASE)
  %208 = icmp eq i64 %206, 0
  %207 = zext i1 %208 to i64
  %209 = call i32 @check(ptr %0, ptr @TOK_DEFAULT)
  %211 = icmp eq i64 %209, 0
  %210 = zext i1 %211 to i64
  %213 = sext i32 %207 to i64
  %214 = sext i32 %210 to i64
  %215 = icmp ne i64 %213, 0
  %216 = icmp ne i64 %214, 0
  %217 = and i1 %215, %216
  %218 = zext i1 %217 to i64
  %219 = call i32 @check(ptr %0, ptr @TOK_RBRACE)
  %221 = icmp eq i64 %219, 0
  %220 = zext i1 %221 to i64
  %223 = sext i32 %218 to i64
  %224 = sext i32 %220 to i64
  %225 = icmp ne i64 %223, 0
  %226 = icmp ne i64 %224, 0
  %227 = and i1 %225, %226
  %228 = zext i1 %227 to i64
  %229 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %231 = icmp eq i64 %229, 0
  %230 = zext i1 %231 to i64
  %233 = sext i32 %228 to i64
  %234 = sext i32 %230 to i64
  %235 = icmp ne i64 %233, 0
  %236 = icmp ne i64 %234, 0
  %237 = and i1 %235, %236
  %238 = zext i1 %237 to i64
  %239 = icmp ne i64 %238, 0
  br i1 %239, label %L65, label %L66
L65:
  %240 = load ptr, ptr %202
  %241 = call ptr @parse_stmt(ptr %0)
  call void @node_add_child(ptr %240, ptr %241)
  br label %L64
L66:
  %243 = load ptr, ptr %198
  %244 = load ptr, ptr %202
  call void @node_add_child(ptr %243, ptr %244)
  %246 = load ptr, ptr %198
  ret ptr %246
L67:
  br label %L63
L63:
  %247 = call i32 @check(ptr %0, ptr @TOK_GOTO)
  %248 = icmp ne i64 %247, 0
  br i1 %248, label %L68, label %L70
L68:
  call void @advance(ptr %0)
  %250 = alloca ptr
  %252 = load i32, ptr %2
  %253 = call ptr @node_new(ptr @ND_GOTO, i32 %252)
  store ptr %253, ptr %250
  %254 = call ptr @expect_ident(ptr %0)
  %255 = load ptr, ptr %250
  store ptr %254, ptr %255
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %257 = load ptr, ptr %250
  ret ptr %257
L71:
  br label %L70
L70:
  %258 = call i32 @check(ptr %0, ptr @TOK_IDENT)
  %259 = load i64, ptr null
  %261 = sext i32 %259 to i64
  %262 = sext i32 @TOK_COLON to i64
  %260 = icmp eq i64 %261, %262
  %263 = zext i1 %260 to i64
  %265 = sext i32 %258 to i64
  %266 = sext i32 %263 to i64
  %267 = icmp ne i64 %265, 0
  %268 = icmp ne i64 %266, 0
  %269 = and i1 %267, %268
  %270 = zext i1 %269 to i64
  %271 = icmp ne i64 %270, 0
  br i1 %271, label %L72, label %L74
L72:
  %272 = alloca ptr
  %274 = load i32, ptr %2
  %275 = call ptr @node_new(ptr @ND_LABEL, i32 %274)
  store ptr %275, ptr %272
  %276 = load i64, ptr %0
  %277 = call i32 @strdup(i32 %276)
  %278 = load ptr, ptr %272
  store i32 %277, ptr %278
  call void @advance(ptr %0)
  call void @advance(ptr %0)
  %281 = load ptr, ptr %272
  %282 = call ptr @parse_stmt(ptr %0)
  call void @node_add_child(ptr %281, ptr %282)
  %284 = load ptr, ptr %272
  ret ptr %284
L75:
  br label %L74
L74:
  %285 = call i32 @is_type_start(ptr %0)
  %286 = icmp ne i64 %285, 0
  br i1 %286, label %L76, label %L78
L76:
  %287 = call ptr @parse_local_decl(ptr %0)
  ret ptr %287
L79:
  br label %L78
L78:
  %288 = call i32 @check(ptr %0, ptr @TOK_SEMICOLON)
  %289 = icmp ne i64 %288, 0
  br i1 %289, label %L80, label %L82
L80:
  call void @advance(ptr %0)
  %291 = load i32, ptr %2
  %292 = call ptr @node_new(ptr @ND_BLOCK, i32 %291)
  ret ptr %292
L83:
  br label %L82
L82:
  %293 = alloca ptr
  %295 = load i32, ptr %2
  %296 = call ptr @node_new(ptr @ND_EXPR_STMT, i32 %295)
  store ptr %296, ptr %293
  %297 = load ptr, ptr %293
  %298 = call ptr @parse_expr(ptr %0)
  call void @node_add_child(ptr %297, ptr %298)
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %301 = load ptr, ptr %293
  ret ptr %301
L84:
  ret ptr 0
}

define internal ptr @parse_block(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  store i32 %4, ptr %2
  call void @expect(ptr %0, ptr @TOK_LBRACE)
  %6 = alloca ptr
  %8 = load i32, ptr %2
  %9 = call ptr @node_new(ptr @ND_BLOCK, i32 %8)
  store ptr %9, ptr %6
  br label %L0
L0:
  %10 = call i32 @check(ptr %0, ptr @TOK_RBRACE)
  %12 = icmp eq i64 %10, 0
  %11 = zext i1 %12 to i64
  %13 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %15 = icmp eq i64 %13, 0
  %14 = zext i1 %15 to i64
  %17 = sext i32 %11 to i64
  %18 = sext i32 %14 to i64
  %19 = icmp ne i64 %17, 0
  %20 = icmp ne i64 %18, 0
  %21 = and i1 %19, %20
  %22 = zext i1 %21 to i64
  %23 = icmp ne i64 %22, 0
  br i1 %23, label %L1, label %L2
L1:
  %24 = load ptr, ptr %6
  %25 = call ptr @parse_stmt(ptr %0)
  call void @node_add_child(ptr %24, ptr %25)
  br label %L0
L2:
  call void @expect(ptr %0, ptr @TOK_RBRACE)
  %28 = load ptr, ptr %6
  ret ptr %28
L3:
  ret ptr 0
}

define internal ptr @parse_toplevel(ptr %0) {
entry:
  %2 = alloca i32
  %4 = load i64, ptr %0
  store i32 %4, ptr %2
  call void @skip_gcc_extension(ptr %0)
  %6 = alloca i32
  store i32 0, ptr %6
  %8 = alloca i32
  store i32 0, ptr %8
  %10 = alloca i32
  store i32 0, ptr %10
  %12 = alloca ptr
  %14 = call ptr @parse_type_specifier(ptr %0, ptr @is_typedef, ptr @is_static, ptr @is_extern)
  store ptr %14, ptr %12
  %15 = load ptr, ptr %12
  %17 = icmp eq i64 %15, 0
  %16 = zext i1 %17 to i64
  %18 = icmp ne i64 %16, 0
  br i1 %18, label %L0, label %L2
L0:
  %19 = getelementptr [21 x i8], ptr @.str34, i64 0, i64 0
  call void @p_error(ptr %0, ptr %19)
  %21 = inttoptr i64 0 to ptr
  ret ptr %21
L3:
  br label %L2
L2:
  %22 = call i32 @check(ptr %0, ptr @TOK_SEMICOLON)
  %23 = icmp ne i64 %22, 0
  br i1 %23, label %L4, label %L6
L4:
  call void @advance(ptr %0)
  %25 = load i32, ptr %2
  %26 = call ptr @node_new(ptr @ND_BLOCK, i32 %25)
  ret ptr %26
L7:
  br label %L6
L6:
  %27 = alloca ptr
  %29 = inttoptr i64 0 to ptr
  store ptr %29, ptr %27
  %30 = alloca ptr
  %32 = load ptr, ptr %12
  %33 = call ptr @parse_declarator(ptr %0, ptr %32, ptr %27)
  store ptr %33, ptr %30
  call void @skip_gcc_extension(ptr %0)
  %35 = icmp ne i64 @is_typedef, 0
  br i1 %35, label %L8, label %L10
L8:
  %36 = load ptr, ptr %27
  %37 = icmp ne i64 %36, 0
  br i1 %37, label %L11, label %L13
L11:
  %38 = load ptr, ptr %27
  %39 = load ptr, ptr %30
  call void @register_typedef(ptr %0, ptr %38, ptr %39)
  br label %L13
L13:
  %41 = alloca ptr
  %43 = load i32, ptr %2
  %44 = call ptr @node_new(ptr @ND_TYPEDEF, i32 %43)
  store ptr %44, ptr %41
  %45 = load ptr, ptr %27
  %46 = load ptr, ptr %41
  store ptr %45, ptr %46
  %47 = load ptr, ptr %30
  %48 = load ptr, ptr %41
  store ptr %47, ptr %48
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %50 = load ptr, ptr %41
  ret ptr %50
L14:
  br label %L10
L10:
  %51 = load ptr, ptr %30
  %52 = load i64, ptr %51
  %54 = sext i32 %52 to i64
  %55 = sext i32 @TY_FUNC to i64
  %53 = icmp eq i64 %54, %55
  %56 = zext i1 %53 to i64
  %57 = call i32 @check(ptr %0, ptr @TOK_LBRACE)
  %59 = sext i32 %56 to i64
  %60 = sext i32 %57 to i64
  %61 = icmp ne i64 %59, 0
  %62 = icmp ne i64 %60, 0
  %63 = and i1 %61, %62
  %64 = zext i1 %63 to i64
  %65 = icmp ne i64 %64, 0
  br i1 %65, label %L15, label %L17
L15:
  %66 = alloca ptr
  %68 = load i32, ptr %2
  %69 = call ptr @node_new(ptr @ND_FUNC_DEF, i32 %68)
  store ptr %69, ptr %66
  %70 = load ptr, ptr %27
  %71 = load ptr, ptr %66
  store ptr %70, ptr %71
  %72 = load ptr, ptr %30
  %73 = load ptr, ptr %66
  store ptr %72, ptr %73
  %74 = load ptr, ptr %66
  store ptr @is_static, ptr %74
  %75 = load ptr, ptr %66
  store ptr @is_extern, ptr %75
  %76 = load ptr, ptr %30
  %77 = load i64, ptr %76
  %79 = sext i32 %77 to i64
  %80 = sext i32 8 to i64
  %78 = mul i64 %79, %80
  %81 = call i32 @malloc(i32 %78)
  %82 = load ptr, ptr %66
  store i32 %81, ptr %82
  %83 = alloca i32
  store i32 0, ptr %83
  br label %L18
L18:
  %85 = load i32, ptr %83
  %86 = load ptr, ptr %30
  %87 = load i64, ptr %86
  %89 = sext i32 %85 to i64
  %90 = sext i32 %87 to i64
  %88 = icmp slt i64 %89, %90
  %91 = zext i1 %88 to i64
  %92 = icmp ne i64 %91, 0
  br i1 %92, label %L19, label %L21
L19:
  %93 = load ptr, ptr %30
  %94 = load i64, ptr %93
  %95 = load i32, ptr %83
  %96 = getelementptr i8, ptr %94, i64 %95
  %97 = load i64, ptr %96
  %98 = icmp ne i64 %97, 0
  br i1 %98, label %L22, label %L23
L22:
  %99 = load ptr, ptr %30
  %100 = load i64, ptr %99
  %101 = load i32, ptr %83
  %102 = getelementptr i8, ptr %100, i64 %101
  %103 = load i64, ptr %102
  %104 = call i32 @strdup(i32 %103)
  br label %L24
L23:
  %105 = inttoptr i64 0 to ptr
  br label %L24
L24:
  %106 = phi i64 [ %104, %L22 ], [ %105, %L23 ]
  %107 = load ptr, ptr %66
  %108 = load i64, ptr %107
  %109 = load i32, ptr %83
  %110 = getelementptr i8, ptr %108, i64 %109
  store i32 %106, ptr %110
  br label %L20
L20:
  %111 = load i32, ptr %83
  %113 = sext i32 %111 to i64
  %112 = add i64 %113, 1
  store i64 %112, ptr %83
  br label %L18
L21:
  %114 = call ptr @parse_block(ptr %0)
  %115 = load ptr, ptr %66
  store ptr %114, ptr %115
  %116 = load ptr, ptr %66
  ret ptr %116
L25:
  br label %L17
L17:
  %117 = alloca ptr
  %119 = load i32, ptr %2
  %120 = call ptr @node_new(ptr @ND_VAR_DECL, i32 %119)
  store ptr %120, ptr %117
  %121 = load ptr, ptr %27
  %122 = load ptr, ptr %117
  store ptr %121, ptr %122
  %123 = load ptr, ptr %30
  %124 = load ptr, ptr %117
  store ptr %123, ptr %124
  %125 = load ptr, ptr %117
  store i32 1, ptr %125
  %126 = load ptr, ptr %117
  store ptr @is_static, ptr %126
  %127 = load ptr, ptr %117
  store ptr @is_extern, ptr %127
  %128 = call i32 @match(ptr %0, ptr @TOK_ASSIGN)
  %129 = icmp ne i64 %128, 0
  br i1 %129, label %L26, label %L28
L26:
  %130 = load ptr, ptr %117
  %131 = call ptr @parse_initializer(ptr %0)
  call void @node_add_child(ptr %130, ptr %131)
  br label %L28
L28:
  br label %L29
L29:
  %133 = call i32 @match(ptr %0, ptr @TOK_COMMA)
  %134 = icmp ne i64 %133, 0
  br i1 %134, label %L30, label %L31
L30:
  %135 = alloca ptr
  %137 = inttoptr i64 0 to ptr
  store ptr %137, ptr %135
  %138 = alloca ptr
  %140 = load ptr, ptr %12
  %141 = call ptr @parse_declarator(ptr %0, ptr %140, ptr %135)
  store ptr %141, ptr %138
  %142 = alloca ptr
  %144 = load i32, ptr %2
  %145 = call ptr @node_new(ptr @ND_VAR_DECL, i32 %144)
  store ptr %145, ptr %142
  %146 = load ptr, ptr %135
  %147 = load ptr, ptr %142
  store ptr %146, ptr %147
  %148 = load ptr, ptr %138
  %149 = load ptr, ptr %142
  store ptr %148, ptr %149
  %150 = load ptr, ptr %142
  store i32 1, ptr %150
  %151 = call i32 @match(ptr %0, ptr @TOK_ASSIGN)
  %152 = icmp ne i64 %151, 0
  br i1 %152, label %L32, label %L34
L32:
  %153 = load ptr, ptr %142
  %154 = call ptr @parse_initializer(ptr %0)
  call void @node_add_child(ptr %153, ptr %154)
  br label %L34
L34:
  %156 = load ptr, ptr %117
  %157 = load ptr, ptr %142
  call void @node_add_child(ptr %156, ptr %157)
  br label %L29
L31:
  call void @expect(ptr %0, ptr @TOK_SEMICOLON)
  %160 = load ptr, ptr %117
  ret ptr %160
L35:
  ret ptr 0
}

define dso_local ptr @parser_new(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call i32 @calloc(i32 1, i32 8)
  store ptr %4, ptr %2
  %5 = load ptr, ptr %2
  %7 = icmp eq i64 %5, 0
  %6 = zext i1 %7 to i64
  %8 = icmp ne i64 %6, 0
  br i1 %8, label %L0, label %L2
L0:
  %9 = getelementptr [7 x i8], ptr @.str35, i64 0, i64 0
  %10 = call i32 @perror(ptr %9)
  %11 = call i32 @exit(i32 1)
  br label %L2
L2:
  %12 = load ptr, ptr %2
  store ptr %0, ptr %12
  %13 = call i64 @lexer_next(ptr %0)
  %14 = load ptr, ptr %2
  store i64 %13, ptr %14
  %15 = alloca ptr
  store ptr 0, ptr %15
  %17 = alloca i32
  store i32 0, ptr %17
  br label %L3
L3:
  %19 = load ptr, ptr %15
  %20 = load i32, ptr %17
  %21 = getelementptr i8, ptr %19, i64 %20
  %22 = load i64, ptr %21
  %23 = icmp ne i64 %22, 0
  br i1 %23, label %L4, label %L6
L4:
  %24 = alloca ptr
  %26 = load ptr, ptr %15
  %27 = load i32, ptr %17
  %28 = getelementptr i8, ptr %26, i64 %27
  %29 = load i64, ptr %28
  %30 = call ptr @type_new(i32 %29)
  store ptr %30, ptr %24
  %31 = load ptr, ptr %2
  %32 = load ptr, ptr %15
  %33 = load i32, ptr %17
  %34 = getelementptr i8, ptr %32, i64 %33
  %35 = load i64, ptr %34
  %36 = load ptr, ptr %24
  call void @register_typedef(ptr %31, i32 %35, ptr %36)
  br label %L5
L5:
  %38 = load i32, ptr %17
  %40 = sext i32 %38 to i64
  %39 = add i64 %40, 1
  store i64 %39, ptr %17
  br label %L3
L6:
  %41 = load ptr, ptr %2
  ret ptr %41
L7:
  ret ptr 0
}

define dso_local void @parser_free(ptr %0) {
entry:
  %2 = load i64, ptr %0
  call void @token_free(i32 %2)
  %4 = alloca i32
  store i32 0, ptr %4
  br label %L0
L0:
  %6 = load i32, ptr %4
  %7 = load i64, ptr %0
  %9 = sext i32 %6 to i64
  %10 = sext i32 %7 to i64
  %8 = icmp slt i64 %9, %10
  %11 = zext i1 %8 to i64
  %12 = icmp ne i64 %11, 0
  br i1 %12, label %L1, label %L3
L1:
  %13 = load i64, ptr %0
  %14 = load i32, ptr %4
  %15 = getelementptr i8, ptr %13, i64 %14
  %16 = load i64, ptr %15
  %17 = call i32 @free(i32 %16)
  br label %L2
L2:
  %18 = load i32, ptr %4
  %20 = sext i32 %18 to i64
  %19 = add i64 %20, 1
  store i64 %19, ptr %4
  br label %L0
L3:
  %21 = call i32 @free(ptr %0)
  ret void
}

define dso_local ptr @parser_parse(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = call ptr @node_new(ptr @ND_TRANSLATION_UNIT, i32 0)
  store ptr %4, ptr %2
  br label %L0
L0:
  %5 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %7 = icmp eq i64 %5, 0
  %6 = zext i1 %7 to i64
  %8 = icmp ne i64 %6, 0
  br i1 %8, label %L1, label %L2
L1:
  br label %L3
L3:
  %9 = call i32 @match(ptr %0, ptr @TOK_SEMICOLON)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %L4, label %L5
L4:
  br label %L3
L5:
  call void @skip_gcc_extension(ptr %0)
  %12 = call i32 @check(ptr %0, ptr @TOK_EOF)
  %13 = icmp ne i64 %12, 0
  br i1 %13, label %L6, label %L8
L6:
  br label %L2
L9:
  br label %L8
L8:
  %14 = load ptr, ptr %2
  %15 = call ptr @parse_toplevel(ptr %0)
  call void @node_add_child(ptr %14, ptr %15)
  br label %L0
L2:
  %17 = load ptr, ptr %2
  ret ptr %17
L10:
  ret ptr 0
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
