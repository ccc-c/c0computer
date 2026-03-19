; ModuleID = 'lexer.c'
source_filename = "lexer.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@lexer_new = dso_local global ptr zeroinitializer
@lexer_free = dso_local global ptr zeroinitializer
@lexer_next = dso_local global ptr zeroinitializer
@lexer_peek = dso_local global ptr zeroinitializer
@token_free = dso_local global ptr zeroinitializer
@token_type_name = dso_local global ptr zeroinitializer
@KEYWORDS = internal global ptr zeroinitializer

define internal i8 @cur(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %3 = load i64, ptr %0
  %4 = getelementptr i32, ptr %2, i64 %3
  %5 = load i32, ptr %4
  ret i8 %5
L0:
  ret i8 0
}

define internal i8 @peek1(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %3 = load i64, ptr %0
  %5 = sext i32 %3 to i64
  %6 = sext i32 1 to i64
  %4 = add i64 %5, %6
  %7 = getelementptr i32, ptr %2, i64 %4
  %8 = load i32, ptr %7
  ret i8 %8
L0:
  ret i8 0
}

define internal i8 @advance(ptr %0) {
entry:
  %2 = alloca i8
  %4 = load i64, ptr %0
  %5 = load i64, ptr %0
  %7 = sext i32 %5 to i64
  %6 = add i64 %7, 1
  store i64 %6, ptr %0
  %8 = getelementptr i32, ptr %4, i64 %5
  %9 = load i32, ptr %8
  store i8 %9, ptr %2
  %10 = load i8, ptr %2
  %12 = sext i32 %10 to i64
  %13 = sext i32 10 to i64
  %11 = icmp eq i64 %12, %13
  %14 = zext i1 %11 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %L0, label %L1
L0:
  %16 = load i64, ptr %0
  %18 = sext i32 %16 to i64
  %17 = add i64 %18, 1
  store i64 %17, ptr %0
  store i32 1, ptr %0
  br label %L2
L1:
  %19 = load i64, ptr %0
  %21 = sext i32 %19 to i64
  %20 = add i64 %21, 1
  store i64 %20, ptr %0
  br label %L2
L2:
  %22 = load i8, ptr %2
  ret i8 %22
L3:
  ret i8 0
}

define internal ptr @strndup_local(ptr %0, i64 %2) {
entry:
  %4 = alloca ptr
  %7 = sext i32 %2 to i64
  %8 = sext i32 1 to i64
  %6 = add i64 %7, %8
  %9 = call i32 @malloc(i64 %6)
  store ptr %9, ptr %4
  %10 = load ptr, ptr %4
  %12 = icmp eq i64 %10, 0
  %11 = zext i1 %12 to i64
  %13 = icmp ne i64 %11, 0
  br i1 %13, label %L0, label %L2
L0:
  %14 = getelementptr [7 x i8], ptr @.str0, i64 0, i64 0
  %15 = call i32 @perror(ptr %14)
  %16 = call i32 @exit(i32 1)
  br label %L2
L2:
  %17 = load ptr, ptr %4
  %18 = call i32 @memcpy(ptr %17, ptr %0, i64 %2)
  %19 = load ptr, ptr %4
  %20 = getelementptr i8, ptr %19, i64 %2
  store i8 0, ptr %20
  %21 = load ptr, ptr %4
  ret ptr %21
L3:
  ret ptr 0
}

define internal i64 @keyword_lookup(ptr %0) {
entry:
  %2 = alloca i32
  store i32 0, ptr %2
  br label %L0
L0:
  %4 = load ptr, ptr @KEYWORDS
  %5 = load i32, ptr %2
  %6 = getelementptr i8, ptr %4, i64 %5
  %7 = load i64, ptr %6
  %8 = icmp ne i64 %7, 0
  br i1 %8, label %L1, label %L3
L1:
  %9 = load ptr, ptr @KEYWORDS
  %10 = load i32, ptr %2
  %11 = getelementptr i8, ptr %9, i64 %10
  %12 = load i64, ptr %11
  %13 = call i32 @strcmp(i32 %12, ptr %0)
  %15 = sext i32 %13 to i64
  %16 = sext i32 0 to i64
  %14 = icmp eq i64 %15, %16
  %17 = zext i1 %14 to i64
  %18 = icmp ne i64 %17, 0
  br i1 %18, label %L4, label %L6
L4:
  %19 = load ptr, ptr @KEYWORDS
  %20 = load i32, ptr %2
  %21 = getelementptr i8, ptr %19, i64 %20
  %22 = load i64, ptr %21
  ret i64 %22
L7:
  br label %L6
L6:
  br label %L2
L2:
  %23 = load i32, ptr %2
  %25 = sext i32 %23 to i64
  %24 = add i64 %25, 1
  store i64 %24, ptr %2
  br label %L0
L3:
  ret i64 @TOK_IDENT
L8:
  ret i64 0
}

define dso_local ptr @lexer_new(ptr %0, ptr %2) {
entry:
  %4 = alloca ptr
  %6 = call i32 @calloc(i32 1, i32 8)
  store ptr %6, ptr %4
  %7 = load ptr, ptr %4
  %9 = icmp eq i64 %7, 0
  %8 = zext i1 %9 to i64
  %10 = icmp ne i64 %8, 0
  br i1 %10, label %L0, label %L2
L0:
  %11 = getelementptr [7 x i8], ptr @.str1, i64 0, i64 0
  %12 = call i32 @perror(ptr %11)
  %13 = call i32 @exit(i32 1)
  br label %L2
L2:
  %14 = load ptr, ptr %4
  store ptr %0, ptr %14
  %15 = load ptr, ptr %4
  store ptr %2, ptr %15
  %16 = load ptr, ptr %4
  store i32 1, ptr %16
  %17 = load ptr, ptr %4
  store i32 1, ptr %17
  %18 = load ptr, ptr %4
  ret ptr %18
L3:
  ret ptr 0
}

define dso_local void @lexer_free(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %3 = icmp ne i64 %2, 0
  br i1 %3, label %L0, label %L2
L0:
  %4 = load i64, ptr %0
  call void @token_free(i32 %4)
  br label %L2
L2:
  %6 = call i32 @free(ptr %0)
  ret void
}

define dso_local void @token_free(i64 %0) {
entry:
  %2 = load i64, ptr %0
  %3 = call i32 @free(i32 %2)
  ret void
}

define internal void @skip_ws(ptr %0) {
entry:
  br label %L0
L0:
  br label %L1
L1:
  br label %L4
L4:
  %2 = call i8 @cur(ptr %0)
  %3 = call i8 @cur(ptr %0)
  %4 = bitcast i8 %3 to i8
  %5 = call i32 @isspace(i8 %4)
  %7 = sext i32 %2 to i64
  %8 = sext i32 %5 to i64
  %9 = icmp ne i64 %7, 0
  %10 = icmp ne i64 %8, 0
  %11 = and i1 %9, %10
  %12 = zext i1 %11 to i64
  %13 = icmp ne i64 %12, 0
  br i1 %13, label %L5, label %L6
L5:
  %14 = call i8 @advance(ptr %0)
  br label %L4
L6:
  %15 = call i8 @cur(ptr %0)
  %17 = sext i32 %15 to i64
  %18 = sext i32 47 to i64
  %16 = icmp eq i64 %17, %18
  %19 = zext i1 %16 to i64
  %20 = call i8 @peek1(ptr %0)
  %22 = sext i32 %20 to i64
  %23 = sext i32 47 to i64
  %21 = icmp eq i64 %22, %23
  %24 = zext i1 %21 to i64
  %26 = sext i32 %19 to i64
  %27 = sext i32 %24 to i64
  %28 = icmp ne i64 %26, 0
  %29 = icmp ne i64 %27, 0
  %30 = and i1 %28, %29
  %31 = zext i1 %30 to i64
  %32 = icmp ne i64 %31, 0
  br i1 %32, label %L7, label %L9
L7:
  br label %L10
L10:
  %33 = call i8 @cur(ptr %0)
  %34 = call i8 @cur(ptr %0)
  %36 = sext i32 %34 to i64
  %37 = sext i32 10 to i64
  %35 = icmp ne i64 %36, %37
  %38 = zext i1 %35 to i64
  %40 = sext i32 %33 to i64
  %41 = sext i32 %38 to i64
  %42 = icmp ne i64 %40, 0
  %43 = icmp ne i64 %41, 0
  %44 = and i1 %42, %43
  %45 = zext i1 %44 to i64
  %46 = icmp ne i64 %45, 0
  br i1 %46, label %L11, label %L12
L11:
  %47 = call i8 @advance(ptr %0)
  br label %L10
L12:
  br label %L2
L13:
  br label %L9
L9:
  %48 = call i8 @cur(ptr %0)
  %50 = sext i32 %48 to i64
  %51 = sext i32 47 to i64
  %49 = icmp eq i64 %50, %51
  %52 = zext i1 %49 to i64
  %53 = call i8 @peek1(ptr %0)
  %55 = sext i32 %53 to i64
  %56 = sext i32 42 to i64
  %54 = icmp eq i64 %55, %56
  %57 = zext i1 %54 to i64
  %59 = sext i32 %52 to i64
  %60 = sext i32 %57 to i64
  %61 = icmp ne i64 %59, 0
  %62 = icmp ne i64 %60, 0
  %63 = and i1 %61, %62
  %64 = zext i1 %63 to i64
  %65 = icmp ne i64 %64, 0
  br i1 %65, label %L14, label %L16
L14:
  %66 = call i8 @advance(ptr %0)
  %67 = call i8 @advance(ptr %0)
  br label %L17
L17:
  %68 = call i8 @cur(ptr %0)
  %69 = call i8 @cur(ptr %0)
  %71 = sext i32 %69 to i64
  %72 = sext i32 42 to i64
  %70 = icmp eq i64 %71, %72
  %73 = zext i1 %70 to i64
  %74 = call i8 @peek1(ptr %0)
  %76 = sext i32 %74 to i64
  %77 = sext i32 47 to i64
  %75 = icmp eq i64 %76, %77
  %78 = zext i1 %75 to i64
  %80 = sext i32 %73 to i64
  %81 = sext i32 %78 to i64
  %82 = icmp ne i64 %80, 0
  %83 = icmp ne i64 %81, 0
  %84 = and i1 %82, %83
  %85 = zext i1 %84 to i64
  %87 = icmp eq i64 %85, 0
  %86 = zext i1 %87 to i64
  %89 = sext i32 %68 to i64
  %90 = sext i32 %86 to i64
  %91 = icmp ne i64 %89, 0
  %92 = icmp ne i64 %90, 0
  %93 = and i1 %91, %92
  %94 = zext i1 %93 to i64
  %95 = icmp ne i64 %94, 0
  br i1 %95, label %L18, label %L19
L18:
  %96 = call i8 @advance(ptr %0)
  br label %L17
L19:
  %97 = call i8 @cur(ptr %0)
  %98 = icmp ne i64 %97, 0
  br i1 %98, label %L20, label %L22
L20:
  %99 = call i8 @advance(ptr %0)
  %100 = call i8 @advance(ptr %0)
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

define internal i64 @read_token(ptr %0) {
entry:
  call void @skip_ws(ptr %0)
  %3 = alloca i64
  %5 = load i64, ptr %0
  store i32 %5, ptr %3
  %6 = load i64, ptr %0
  store i32 %6, ptr %3
  %7 = inttoptr i64 0 to ptr
  store ptr %7, ptr %3
  %8 = call i8 @cur(ptr %0)
  %10 = icmp eq i64 %8, 0
  %9 = zext i1 %10 to i64
  %11 = icmp ne i64 %9, 0
  br i1 %11, label %L0, label %L2
L0:
  store ptr @TOK_EOF, ptr %3
  %12 = getelementptr [1 x i8], ptr @.str2, i64 0, i64 0
  %13 = call i32 @strdup(ptr %12)
  store i32 %13, ptr %3
  %14 = load i64, ptr %3
  ret i64 %14
L3:
  br label %L2
L2:
  %15 = call i8 @cur(ptr %0)
  %16 = bitcast i8 %15 to i8
  %17 = call i32 @isdigit(i8 %16)
  %18 = call i8 @cur(ptr %0)
  %20 = sext i32 %18 to i64
  %21 = sext i32 46 to i64
  %19 = icmp eq i64 %20, %21
  %22 = zext i1 %19 to i64
  %23 = call i8 @peek1(ptr %0)
  %24 = bitcast i8 %23 to i8
  %25 = call i32 @isdigit(i8 %24)
  %27 = sext i32 %22 to i64
  %28 = sext i32 %25 to i64
  %29 = icmp ne i64 %27, 0
  %30 = icmp ne i64 %28, 0
  %31 = and i1 %29, %30
  %32 = zext i1 %31 to i64
  %34 = sext i32 %17 to i64
  %35 = sext i32 %32 to i64
  %36 = icmp ne i64 %34, 0
  %37 = icmp ne i64 %35, 0
  %38 = or i1 %36, %37
  %39 = zext i1 %38 to i64
  %40 = icmp ne i64 %39, 0
  br i1 %40, label %L4, label %L6
L4:
  %41 = alloca i64
  %43 = load i64, ptr %0
  store i64 %43, ptr %41
  %44 = alloca i32
  store i32 0, ptr %44
  %46 = call i8 @cur(ptr %0)
  %48 = sext i32 %46 to i64
  %49 = sext i32 48 to i64
  %47 = icmp eq i64 %48, %49
  %50 = zext i1 %47 to i64
  %51 = call i8 @peek1(ptr %0)
  %53 = sext i32 %51 to i64
  %54 = sext i32 120 to i64
  %52 = icmp eq i64 %53, %54
  %55 = zext i1 %52 to i64
  %56 = call i8 @peek1(ptr %0)
  %58 = sext i32 %56 to i64
  %59 = sext i32 88 to i64
  %57 = icmp eq i64 %58, %59
  %60 = zext i1 %57 to i64
  %62 = sext i32 %55 to i64
  %63 = sext i32 %60 to i64
  %64 = icmp ne i64 %62, 0
  %65 = icmp ne i64 %63, 0
  %66 = or i1 %64, %65
  %67 = zext i1 %66 to i64
  %69 = sext i32 %50 to i64
  %70 = sext i32 %67 to i64
  %71 = icmp ne i64 %69, 0
  %72 = icmp ne i64 %70, 0
  %73 = and i1 %71, %72
  %74 = zext i1 %73 to i64
  %75 = icmp ne i64 %74, 0
  br i1 %75, label %L7, label %L8
L7:
  %76 = call i8 @advance(ptr %0)
  %77 = call i8 @advance(ptr %0)
  br label %L10
L10:
  %78 = call i8 @cur(ptr %0)
  %79 = bitcast i8 %78 to i8
  %80 = call i32 @isxdigit(i8 %79)
  %81 = icmp ne i64 %80, 0
  br i1 %81, label %L11, label %L12
L11:
  %82 = call i8 @advance(ptr %0)
  br label %L10
L12:
  br label %L9
L8:
  br label %L13
L13:
  %83 = call i8 @cur(ptr %0)
  %84 = bitcast i8 %83 to i8
  %85 = call i32 @isdigit(i8 %84)
  %86 = icmp ne i64 %85, 0
  br i1 %86, label %L14, label %L15
L14:
  %87 = call i8 @advance(ptr %0)
  br label %L13
L15:
  %88 = call i8 @cur(ptr %0)
  %90 = sext i32 %88 to i64
  %91 = sext i32 46 to i64
  %89 = icmp eq i64 %90, %91
  %92 = zext i1 %89 to i64
  %93 = icmp ne i64 %92, 0
  br i1 %93, label %L16, label %L18
L16:
  store i32 1, ptr %44
  %94 = call i8 @advance(ptr %0)
  br label %L18
L18:
  br label %L19
L19:
  %95 = call i8 @cur(ptr %0)
  %96 = bitcast i8 %95 to i8
  %97 = call i32 @isdigit(i8 %96)
  %98 = icmp ne i64 %97, 0
  br i1 %98, label %L20, label %L21
L20:
  %99 = call i8 @advance(ptr %0)
  br label %L19
L21:
  %100 = call i8 @cur(ptr %0)
  %102 = sext i32 %100 to i64
  %103 = sext i32 101 to i64
  %101 = icmp eq i64 %102, %103
  %104 = zext i1 %101 to i64
  %105 = call i8 @cur(ptr %0)
  %107 = sext i32 %105 to i64
  %108 = sext i32 69 to i64
  %106 = icmp eq i64 %107, %108
  %109 = zext i1 %106 to i64
  %111 = sext i32 %104 to i64
  %112 = sext i32 %109 to i64
  %113 = icmp ne i64 %111, 0
  %114 = icmp ne i64 %112, 0
  %115 = or i1 %113, %114
  %116 = zext i1 %115 to i64
  %117 = icmp ne i64 %116, 0
  br i1 %117, label %L22, label %L24
L22:
  store i32 1, ptr %44
  %118 = call i8 @advance(ptr %0)
  %119 = call i8 @cur(ptr %0)
  %121 = sext i32 %119 to i64
  %122 = sext i32 43 to i64
  %120 = icmp eq i64 %121, %122
  %123 = zext i1 %120 to i64
  %124 = call i8 @cur(ptr %0)
  %126 = sext i32 %124 to i64
  %127 = sext i32 45 to i64
  %125 = icmp eq i64 %126, %127
  %128 = zext i1 %125 to i64
  %130 = sext i32 %123 to i64
  %131 = sext i32 %128 to i64
  %132 = icmp ne i64 %130, 0
  %133 = icmp ne i64 %131, 0
  %134 = or i1 %132, %133
  %135 = zext i1 %134 to i64
  %136 = icmp ne i64 %135, 0
  br i1 %136, label %L25, label %L27
L25:
  %137 = call i8 @advance(ptr %0)
  br label %L27
L27:
  br label %L28
L28:
  %138 = call i8 @cur(ptr %0)
  %139 = bitcast i8 %138 to i8
  %140 = call i32 @isdigit(i8 %139)
  %141 = icmp ne i64 %140, 0
  br i1 %141, label %L29, label %L30
L29:
  %142 = call i8 @advance(ptr %0)
  br label %L28
L30:
  br label %L24
L24:
  br label %L9
L9:
  br label %L31
L31:
  %143 = call i8 @cur(ptr %0)
  %145 = sext i32 %143 to i64
  %146 = sext i32 117 to i64
  %144 = icmp eq i64 %145, %146
  %147 = zext i1 %144 to i64
  %148 = call i8 @cur(ptr %0)
  %150 = sext i32 %148 to i64
  %151 = sext i32 85 to i64
  %149 = icmp eq i64 %150, %151
  %152 = zext i1 %149 to i64
  %154 = sext i32 %147 to i64
  %155 = sext i32 %152 to i64
  %156 = icmp ne i64 %154, 0
  %157 = icmp ne i64 %155, 0
  %158 = or i1 %156, %157
  %159 = zext i1 %158 to i64
  %160 = call i8 @cur(ptr %0)
  %162 = sext i32 %160 to i64
  %163 = sext i32 108 to i64
  %161 = icmp eq i64 %162, %163
  %164 = zext i1 %161 to i64
  %166 = sext i32 %159 to i64
  %167 = sext i32 %164 to i64
  %168 = icmp ne i64 %166, 0
  %169 = icmp ne i64 %167, 0
  %170 = or i1 %168, %169
  %171 = zext i1 %170 to i64
  %172 = call i8 @cur(ptr %0)
  %174 = sext i32 %172 to i64
  %175 = sext i32 76 to i64
  %173 = icmp eq i64 %174, %175
  %176 = zext i1 %173 to i64
  %178 = sext i32 %171 to i64
  %179 = sext i32 %176 to i64
  %180 = icmp ne i64 %178, 0
  %181 = icmp ne i64 %179, 0
  %182 = or i1 %180, %181
  %183 = zext i1 %182 to i64
  %184 = call i8 @cur(ptr %0)
  %186 = sext i32 %184 to i64
  %187 = sext i32 102 to i64
  %185 = icmp eq i64 %186, %187
  %188 = zext i1 %185 to i64
  %190 = sext i32 %183 to i64
  %191 = sext i32 %188 to i64
  %192 = icmp ne i64 %190, 0
  %193 = icmp ne i64 %191, 0
  %194 = or i1 %192, %193
  %195 = zext i1 %194 to i64
  %196 = call i8 @cur(ptr %0)
  %198 = sext i32 %196 to i64
  %199 = sext i32 70 to i64
  %197 = icmp eq i64 %198, %199
  %200 = zext i1 %197 to i64
  %202 = sext i32 %195 to i64
  %203 = sext i32 %200 to i64
  %204 = icmp ne i64 %202, 0
  %205 = icmp ne i64 %203, 0
  %206 = or i1 %204, %205
  %207 = zext i1 %206 to i64
  %208 = icmp ne i64 %207, 0
  br i1 %208, label %L32, label %L33
L32:
  %209 = call i8 @advance(ptr %0)
  br label %L31
L33:
  %210 = load i32, ptr %44
  %211 = icmp ne i64 %210, 0
  br i1 %211, label %L34, label %L35
L34:
  br label %L36
L35:
  br label %L36
L36:
  %212 = phi i64 [ @TOK_FLOAT_LIT, %L34 ], [ @TOK_INT_LIT, %L35 ]
  store ptr %212, ptr %3
  %213 = load i64, ptr %0
  %214 = load i64, ptr %41
  %216 = sext i32 %213 to i64
  %217 = sext i32 %214 to i64
  %215 = add i64 %216, %217
  %218 = load i64, ptr %0
  %219 = load i64, ptr %41
  %221 = sext i32 %218 to i64
  %222 = sext i32 %219 to i64
  %220 = sub i64 %221, %222
  %223 = call ptr @strndup_local(i32 %215, i32 %220)
  store ptr %223, ptr %3
  %224 = load i64, ptr %3
  ret i64 %224
L37:
  br label %L6
L6:
  %225 = call i8 @cur(ptr %0)
  %227 = sext i32 %225 to i64
  %228 = sext i32 39 to i64
  %226 = icmp eq i64 %227, %228
  %229 = zext i1 %226 to i64
  %230 = icmp ne i64 %229, 0
  br i1 %230, label %L38, label %L40
L38:
  %231 = alloca i64
  %233 = load i64, ptr %0
  store i64 %233, ptr %231
  %234 = call i8 @advance(ptr %0)
  %235 = call i8 @cur(ptr %0)
  %237 = sext i32 %235 to i64
  %238 = sext i32 92 to i64
  %236 = icmp eq i64 %237, %238
  %239 = zext i1 %236 to i64
  %240 = icmp ne i64 %239, 0
  br i1 %240, label %L41, label %L42
L41:
  %241 = call i8 @advance(ptr %0)
  %242 = call i8 @advance(ptr %0)
  br label %L43
L42:
  %243 = call i8 @advance(ptr %0)
  br label %L43
L43:
  %244 = call i8 @cur(ptr %0)
  %246 = sext i32 %244 to i64
  %247 = sext i32 39 to i64
  %245 = icmp eq i64 %246, %247
  %248 = zext i1 %245 to i64
  %249 = icmp ne i64 %248, 0
  br i1 %249, label %L44, label %L46
L44:
  %250 = call i8 @advance(ptr %0)
  br label %L46
L46:
  store ptr @TOK_CHAR_LIT, ptr %3
  %251 = load i64, ptr %0
  %252 = load i64, ptr %231
  %254 = sext i32 %251 to i64
  %255 = sext i32 %252 to i64
  %253 = add i64 %254, %255
  %256 = load i64, ptr %0
  %257 = load i64, ptr %231
  %259 = sext i32 %256 to i64
  %260 = sext i32 %257 to i64
  %258 = sub i64 %259, %260
  %261 = call ptr @strndup_local(i32 %253, i32 %258)
  store ptr %261, ptr %3
  %262 = load i64, ptr %3
  ret i64 %262
L47:
  br label %L40
L40:
  %263 = call i8 @cur(ptr %0)
  %265 = sext i32 %263 to i64
  %266 = sext i32 34 to i64
  %264 = icmp eq i64 %265, %266
  %267 = zext i1 %264 to i64
  %268 = icmp ne i64 %267, 0
  br i1 %268, label %L48, label %L50
L48:
  %269 = alloca i64
  %271 = load i64, ptr %0
  store i64 %271, ptr %269
  %272 = call i8 @advance(ptr %0)
  br label %L51
L51:
  %273 = call i8 @cur(ptr %0)
  %274 = call i8 @cur(ptr %0)
  %276 = sext i32 %274 to i64
  %277 = sext i32 34 to i64
  %275 = icmp ne i64 %276, %277
  %278 = zext i1 %275 to i64
  %280 = sext i32 %273 to i64
  %281 = sext i32 %278 to i64
  %282 = icmp ne i64 %280, 0
  %283 = icmp ne i64 %281, 0
  %284 = and i1 %282, %283
  %285 = zext i1 %284 to i64
  %286 = icmp ne i64 %285, 0
  br i1 %286, label %L52, label %L53
L52:
  %287 = call i8 @cur(ptr %0)
  %289 = sext i32 %287 to i64
  %290 = sext i32 92 to i64
  %288 = icmp eq i64 %289, %290
  %291 = zext i1 %288 to i64
  %292 = icmp ne i64 %291, 0
  br i1 %292, label %L54, label %L56
L54:
  %293 = call i8 @advance(ptr %0)
  br label %L56
L56:
  %294 = call i8 @cur(ptr %0)
  %295 = icmp ne i64 %294, 0
  br i1 %295, label %L57, label %L59
L57:
  %296 = call i8 @advance(ptr %0)
  br label %L59
L59:
  br label %L51
L53:
  %297 = call i8 @cur(ptr %0)
  %299 = sext i32 %297 to i64
  %300 = sext i32 34 to i64
  %298 = icmp eq i64 %299, %300
  %301 = zext i1 %298 to i64
  %302 = icmp ne i64 %301, 0
  br i1 %302, label %L60, label %L62
L60:
  %303 = call i8 @advance(ptr %0)
  br label %L62
L62:
  store ptr @TOK_STRING_LIT, ptr %3
  %304 = load i64, ptr %0
  %305 = load i64, ptr %269
  %307 = sext i32 %304 to i64
  %308 = sext i32 %305 to i64
  %306 = add i64 %307, %308
  %309 = load i64, ptr %0
  %310 = load i64, ptr %269
  %312 = sext i32 %309 to i64
  %313 = sext i32 %310 to i64
  %311 = sub i64 %312, %313
  %314 = call ptr @strndup_local(i32 %306, i32 %311)
  store ptr %314, ptr %3
  %315 = load i64, ptr %3
  ret i64 %315
L63:
  br label %L50
L50:
  %316 = call i8 @cur(ptr %0)
  %317 = bitcast i8 %316 to i8
  %318 = call i32 @isalpha(i8 %317)
  %319 = call i8 @cur(ptr %0)
  %321 = sext i32 %319 to i64
  %322 = sext i32 95 to i64
  %320 = icmp eq i64 %321, %322
  %323 = zext i1 %320 to i64
  %325 = sext i32 %318 to i64
  %326 = sext i32 %323 to i64
  %327 = icmp ne i64 %325, 0
  %328 = icmp ne i64 %326, 0
  %329 = or i1 %327, %328
  %330 = zext i1 %329 to i64
  %331 = icmp ne i64 %330, 0
  br i1 %331, label %L64, label %L66
L64:
  %332 = alloca i64
  %334 = load i64, ptr %0
  store i64 %334, ptr %332
  br label %L67
L67:
  %335 = call i8 @cur(ptr %0)
  %336 = bitcast i8 %335 to i8
  %337 = call i32 @isalnum(i8 %336)
  %338 = call i8 @cur(ptr %0)
  %340 = sext i32 %338 to i64
  %341 = sext i32 95 to i64
  %339 = icmp eq i64 %340, %341
  %342 = zext i1 %339 to i64
  %344 = sext i32 %337 to i64
  %345 = sext i32 %342 to i64
  %346 = icmp ne i64 %344, 0
  %347 = icmp ne i64 %345, 0
  %348 = or i1 %346, %347
  %349 = zext i1 %348 to i64
  %350 = icmp ne i64 %349, 0
  br i1 %350, label %L68, label %L69
L68:
  %351 = call i8 @advance(ptr %0)
  br label %L67
L69:
  %352 = load i64, ptr %0
  %353 = load i64, ptr %332
  %355 = sext i32 %352 to i64
  %356 = sext i32 %353 to i64
  %354 = add i64 %355, %356
  %357 = load i64, ptr %0
  %358 = load i64, ptr %332
  %360 = sext i32 %357 to i64
  %361 = sext i32 %358 to i64
  %359 = sub i64 %360, %361
  %362 = call ptr @strndup_local(i32 %354, i32 %359)
  store ptr %362, ptr %3
  %363 = load i64, ptr %3
  %364 = call i64 @keyword_lookup(i32 %363)
  store i64 %364, ptr %3
  %365 = load i64, ptr %3
  ret i64 %365
L70:
  br label %L66
L66:
  %366 = alloca i8
  %368 = call i8 @advance(ptr %0)
  store i8 %368, ptr %366
  %369 = alloca i8
  %371 = call i8 @cur(ptr %0)
  store i8 %371, ptr %369
  %372 = load i8, ptr %366
  %373 = sext i32 %372 to i64
  switch i64 %373, label %L96 [
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
  %374 = load i8, ptr %369
  %376 = sext i32 %374 to i64
  %377 = sext i32 43 to i64
  %375 = icmp eq i64 %376, %377
  %378 = zext i1 %375 to i64
  %379 = icmp ne i64 %378, 0
  br i1 %379, label %L97, label %L99
L97:
  br label %L100
L100:
  %380 = call i8 @advance(ptr %0)
  br label %L103
L103:
  store ptr @TOK_INC, ptr %3
  %381 = getelementptr [3 x i8], ptr @.str3, i64 0, i64 0
  %382 = call i32 @strdup(ptr %381)
  store i32 %382, ptr %3
  %383 = load i64, ptr %3
  ret i64 %383
L106:
  br label %L104
L104:
  %384 = icmp ne i64 0, 0
  br i1 %384, label %L103, label %L105
L105:
  br label %L101
L101:
  %385 = icmp ne i64 0, 0
  br i1 %385, label %L100, label %L102
L102:
  br label %L99
L99:
  %386 = load i8, ptr %369
  %388 = sext i32 %386 to i64
  %389 = sext i32 61 to i64
  %387 = icmp eq i64 %388, %389
  %390 = zext i1 %387 to i64
  %391 = icmp ne i64 %390, 0
  br i1 %391, label %L107, label %L109
L107:
  br label %L110
L110:
  %392 = call i8 @advance(ptr %0)
  br label %L113
L113:
  store ptr @TOK_PLUS_ASSIGN, ptr %3
  %393 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %394 = call i32 @strdup(ptr %393)
  store i32 %394, ptr %3
  %395 = load i64, ptr %3
  ret i64 %395
L116:
  br label %L114
L114:
  %396 = icmp ne i64 0, 0
  br i1 %396, label %L113, label %L115
L115:
  br label %L111
L111:
  %397 = icmp ne i64 0, 0
  br i1 %397, label %L110, label %L112
L112:
  br label %L109
L109:
  br label %L117
L117:
  store ptr @TOK_PLUS, ptr %3
  %398 = getelementptr [2 x i8], ptr @.str5, i64 0, i64 0
  %399 = call i32 @strdup(ptr %398)
  store i32 %399, ptr %3
  %400 = load i64, ptr %3
  ret i64 %400
L120:
  br label %L118
L118:
  %401 = icmp ne i64 0, 0
  br i1 %401, label %L117, label %L119
L119:
  br label %L73
L73:
  %402 = load i8, ptr %369
  %404 = sext i32 %402 to i64
  %405 = sext i32 45 to i64
  %403 = icmp eq i64 %404, %405
  %406 = zext i1 %403 to i64
  %407 = icmp ne i64 %406, 0
  br i1 %407, label %L121, label %L123
L121:
  br label %L124
L124:
  %408 = call i8 @advance(ptr %0)
  br label %L127
L127:
  store ptr @TOK_DEC, ptr %3
  %409 = getelementptr [3 x i8], ptr @.str6, i64 0, i64 0
  %410 = call i32 @strdup(ptr %409)
  store i32 %410, ptr %3
  %411 = load i64, ptr %3
  ret i64 %411
L130:
  br label %L128
L128:
  %412 = icmp ne i64 0, 0
  br i1 %412, label %L127, label %L129
L129:
  br label %L125
L125:
  %413 = icmp ne i64 0, 0
  br i1 %413, label %L124, label %L126
L126:
  br label %L123
L123:
  %414 = load i8, ptr %369
  %416 = sext i32 %414 to i64
  %417 = sext i32 61 to i64
  %415 = icmp eq i64 %416, %417
  %418 = zext i1 %415 to i64
  %419 = icmp ne i64 %418, 0
  br i1 %419, label %L131, label %L133
L131:
  br label %L134
L134:
  %420 = call i8 @advance(ptr %0)
  br label %L137
L137:
  store ptr @TOK_MINUS_ASSIGN, ptr %3
  %421 = getelementptr [3 x i8], ptr @.str7, i64 0, i64 0
  %422 = call i32 @strdup(ptr %421)
  store i32 %422, ptr %3
  %423 = load i64, ptr %3
  ret i64 %423
L140:
  br label %L138
L138:
  %424 = icmp ne i64 0, 0
  br i1 %424, label %L137, label %L139
L139:
  br label %L135
L135:
  %425 = icmp ne i64 0, 0
  br i1 %425, label %L134, label %L136
L136:
  br label %L133
L133:
  %426 = load i8, ptr %369
  %428 = sext i32 %426 to i64
  %429 = sext i32 62 to i64
  %427 = icmp eq i64 %428, %429
  %430 = zext i1 %427 to i64
  %431 = icmp ne i64 %430, 0
  br i1 %431, label %L141, label %L143
L141:
  br label %L144
L144:
  %432 = call i8 @advance(ptr %0)
  br label %L147
L147:
  store ptr @TOK_ARROW, ptr %3
  %433 = getelementptr [3 x i8], ptr @.str8, i64 0, i64 0
  %434 = call i32 @strdup(ptr %433)
  store i32 %434, ptr %3
  %435 = load i64, ptr %3
  ret i64 %435
L150:
  br label %L148
L148:
  %436 = icmp ne i64 0, 0
  br i1 %436, label %L147, label %L149
L149:
  br label %L145
L145:
  %437 = icmp ne i64 0, 0
  br i1 %437, label %L144, label %L146
L146:
  br label %L143
L143:
  br label %L151
L151:
  store ptr @TOK_MINUS, ptr %3
  %438 = getelementptr [2 x i8], ptr @.str9, i64 0, i64 0
  %439 = call i32 @strdup(ptr %438)
  store i32 %439, ptr %3
  %440 = load i64, ptr %3
  ret i64 %440
L154:
  br label %L152
L152:
  %441 = icmp ne i64 0, 0
  br i1 %441, label %L151, label %L153
L153:
  br label %L74
L74:
  %442 = load i8, ptr %369
  %444 = sext i32 %442 to i64
  %445 = sext i32 61 to i64
  %443 = icmp eq i64 %444, %445
  %446 = zext i1 %443 to i64
  %447 = icmp ne i64 %446, 0
  br i1 %447, label %L155, label %L157
L155:
  br label %L158
L158:
  %448 = call i8 @advance(ptr %0)
  br label %L161
L161:
  store ptr @TOK_STAR_ASSIGN, ptr %3
  %449 = getelementptr [3 x i8], ptr @.str10, i64 0, i64 0
  %450 = call i32 @strdup(ptr %449)
  store i32 %450, ptr %3
  %451 = load i64, ptr %3
  ret i64 %451
L164:
  br label %L162
L162:
  %452 = icmp ne i64 0, 0
  br i1 %452, label %L161, label %L163
L163:
  br label %L159
L159:
  %453 = icmp ne i64 0, 0
  br i1 %453, label %L158, label %L160
L160:
  br label %L157
L157:
  br label %L165
L165:
  store ptr @TOK_STAR, ptr %3
  %454 = getelementptr [2 x i8], ptr @.str11, i64 0, i64 0
  %455 = call i32 @strdup(ptr %454)
  store i32 %455, ptr %3
  %456 = load i64, ptr %3
  ret i64 %456
L168:
  br label %L166
L166:
  %457 = icmp ne i64 0, 0
  br i1 %457, label %L165, label %L167
L167:
  br label %L75
L75:
  %458 = load i8, ptr %369
  %460 = sext i32 %458 to i64
  %461 = sext i32 61 to i64
  %459 = icmp eq i64 %460, %461
  %462 = zext i1 %459 to i64
  %463 = icmp ne i64 %462, 0
  br i1 %463, label %L169, label %L171
L169:
  br label %L172
L172:
  %464 = call i8 @advance(ptr %0)
  br label %L175
L175:
  store ptr @TOK_SLASH_ASSIGN, ptr %3
  %465 = getelementptr [3 x i8], ptr @.str12, i64 0, i64 0
  %466 = call i32 @strdup(ptr %465)
  store i32 %466, ptr %3
  %467 = load i64, ptr %3
  ret i64 %467
L178:
  br label %L176
L176:
  %468 = icmp ne i64 0, 0
  br i1 %468, label %L175, label %L177
L177:
  br label %L173
L173:
  %469 = icmp ne i64 0, 0
  br i1 %469, label %L172, label %L174
L174:
  br label %L171
L171:
  br label %L179
L179:
  store ptr @TOK_SLASH, ptr %3
  %470 = getelementptr [2 x i8], ptr @.str13, i64 0, i64 0
  %471 = call i32 @strdup(ptr %470)
  store i32 %471, ptr %3
  %472 = load i64, ptr %3
  ret i64 %472
L182:
  br label %L180
L180:
  %473 = icmp ne i64 0, 0
  br i1 %473, label %L179, label %L181
L181:
  br label %L76
L76:
  %474 = load i8, ptr %369
  %476 = sext i32 %474 to i64
  %477 = sext i32 61 to i64
  %475 = icmp eq i64 %476, %477
  %478 = zext i1 %475 to i64
  %479 = icmp ne i64 %478, 0
  br i1 %479, label %L183, label %L185
L183:
  br label %L186
L186:
  %480 = call i8 @advance(ptr %0)
  br label %L189
L189:
  store ptr @TOK_PERCENT_ASSIGN, ptr %3
  %481 = getelementptr [3 x i8], ptr @.str14, i64 0, i64 0
  %482 = call i32 @strdup(ptr %481)
  store i32 %482, ptr %3
  %483 = load i64, ptr %3
  ret i64 %483
L192:
  br label %L190
L190:
  %484 = icmp ne i64 0, 0
  br i1 %484, label %L189, label %L191
L191:
  br label %L187
L187:
  %485 = icmp ne i64 0, 0
  br i1 %485, label %L186, label %L188
L188:
  br label %L185
L185:
  br label %L193
L193:
  store ptr @TOK_PERCENT, ptr %3
  %486 = getelementptr [2 x i8], ptr @.str15, i64 0, i64 0
  %487 = call i32 @strdup(ptr %486)
  store i32 %487, ptr %3
  %488 = load i64, ptr %3
  ret i64 %488
L196:
  br label %L194
L194:
  %489 = icmp ne i64 0, 0
  br i1 %489, label %L193, label %L195
L195:
  br label %L77
L77:
  %490 = load i8, ptr %369
  %492 = sext i32 %490 to i64
  %493 = sext i32 38 to i64
  %491 = icmp eq i64 %492, %493
  %494 = zext i1 %491 to i64
  %495 = icmp ne i64 %494, 0
  br i1 %495, label %L197, label %L199
L197:
  br label %L200
L200:
  %496 = call i8 @advance(ptr %0)
  br label %L203
L203:
  store ptr @TOK_AND, ptr %3
  %497 = getelementptr [3 x i8], ptr @.str16, i64 0, i64 0
  %498 = call i32 @strdup(ptr %497)
  store i32 %498, ptr %3
  %499 = load i64, ptr %3
  ret i64 %499
L206:
  br label %L204
L204:
  %500 = icmp ne i64 0, 0
  br i1 %500, label %L203, label %L205
L205:
  br label %L201
L201:
  %501 = icmp ne i64 0, 0
  br i1 %501, label %L200, label %L202
L202:
  br label %L199
L199:
  %502 = load i8, ptr %369
  %504 = sext i32 %502 to i64
  %505 = sext i32 61 to i64
  %503 = icmp eq i64 %504, %505
  %506 = zext i1 %503 to i64
  %507 = icmp ne i64 %506, 0
  br i1 %507, label %L207, label %L209
L207:
  br label %L210
L210:
  %508 = call i8 @advance(ptr %0)
  br label %L213
L213:
  store ptr @TOK_AMP_ASSIGN, ptr %3
  %509 = getelementptr [3 x i8], ptr @.str17, i64 0, i64 0
  %510 = call i32 @strdup(ptr %509)
  store i32 %510, ptr %3
  %511 = load i64, ptr %3
  ret i64 %511
L216:
  br label %L214
L214:
  %512 = icmp ne i64 0, 0
  br i1 %512, label %L213, label %L215
L215:
  br label %L211
L211:
  %513 = icmp ne i64 0, 0
  br i1 %513, label %L210, label %L212
L212:
  br label %L209
L209:
  br label %L217
L217:
  store ptr @TOK_AMP, ptr %3
  %514 = getelementptr [2 x i8], ptr @.str18, i64 0, i64 0
  %515 = call i32 @strdup(ptr %514)
  store i32 %515, ptr %3
  %516 = load i64, ptr %3
  ret i64 %516
L220:
  br label %L218
L218:
  %517 = icmp ne i64 0, 0
  br i1 %517, label %L217, label %L219
L219:
  br label %L78
L78:
  %518 = load i8, ptr %369
  %520 = sext i32 %518 to i64
  %521 = sext i32 124 to i64
  %519 = icmp eq i64 %520, %521
  %522 = zext i1 %519 to i64
  %523 = icmp ne i64 %522, 0
  br i1 %523, label %L221, label %L223
L221:
  br label %L224
L224:
  %524 = call i8 @advance(ptr %0)
  br label %L227
L227:
  store ptr @TOK_OR, ptr %3
  %525 = getelementptr [3 x i8], ptr @.str19, i64 0, i64 0
  %526 = call i32 @strdup(ptr %525)
  store i32 %526, ptr %3
  %527 = load i64, ptr %3
  ret i64 %527
L230:
  br label %L228
L228:
  %528 = icmp ne i64 0, 0
  br i1 %528, label %L227, label %L229
L229:
  br label %L225
L225:
  %529 = icmp ne i64 0, 0
  br i1 %529, label %L224, label %L226
L226:
  br label %L223
L223:
  %530 = load i8, ptr %369
  %532 = sext i32 %530 to i64
  %533 = sext i32 61 to i64
  %531 = icmp eq i64 %532, %533
  %534 = zext i1 %531 to i64
  %535 = icmp ne i64 %534, 0
  br i1 %535, label %L231, label %L233
L231:
  br label %L234
L234:
  %536 = call i8 @advance(ptr %0)
  br label %L237
L237:
  store ptr @TOK_PIPE_ASSIGN, ptr %3
  %537 = getelementptr [3 x i8], ptr @.str20, i64 0, i64 0
  %538 = call i32 @strdup(ptr %537)
  store i32 %538, ptr %3
  %539 = load i64, ptr %3
  ret i64 %539
L240:
  br label %L238
L238:
  %540 = icmp ne i64 0, 0
  br i1 %540, label %L237, label %L239
L239:
  br label %L235
L235:
  %541 = icmp ne i64 0, 0
  br i1 %541, label %L234, label %L236
L236:
  br label %L233
L233:
  br label %L241
L241:
  store ptr @TOK_PIPE, ptr %3
  %542 = getelementptr [2 x i8], ptr @.str21, i64 0, i64 0
  %543 = call i32 @strdup(ptr %542)
  store i32 %543, ptr %3
  %544 = load i64, ptr %3
  ret i64 %544
L244:
  br label %L242
L242:
  %545 = icmp ne i64 0, 0
  br i1 %545, label %L241, label %L243
L243:
  br label %L79
L79:
  %546 = load i8, ptr %369
  %548 = sext i32 %546 to i64
  %549 = sext i32 61 to i64
  %547 = icmp eq i64 %548, %549
  %550 = zext i1 %547 to i64
  %551 = icmp ne i64 %550, 0
  br i1 %551, label %L245, label %L247
L245:
  br label %L248
L248:
  %552 = call i8 @advance(ptr %0)
  br label %L251
L251:
  store ptr @TOK_CARET_ASSIGN, ptr %3
  %553 = getelementptr [3 x i8], ptr @.str22, i64 0, i64 0
  %554 = call i32 @strdup(ptr %553)
  store i32 %554, ptr %3
  %555 = load i64, ptr %3
  ret i64 %555
L254:
  br label %L252
L252:
  %556 = icmp ne i64 0, 0
  br i1 %556, label %L251, label %L253
L253:
  br label %L249
L249:
  %557 = icmp ne i64 0, 0
  br i1 %557, label %L248, label %L250
L250:
  br label %L247
L247:
  br label %L255
L255:
  store ptr @TOK_CARET, ptr %3
  %558 = getelementptr [2 x i8], ptr @.str23, i64 0, i64 0
  %559 = call i32 @strdup(ptr %558)
  store i32 %559, ptr %3
  %560 = load i64, ptr %3
  ret i64 %560
L258:
  br label %L256
L256:
  %561 = icmp ne i64 0, 0
  br i1 %561, label %L255, label %L257
L257:
  br label %L80
L80:
  br label %L259
L259:
  store ptr @TOK_TILDE, ptr %3
  %562 = getelementptr [2 x i8], ptr @.str24, i64 0, i64 0
  %563 = call i32 @strdup(ptr %562)
  store i32 %563, ptr %3
  %564 = load i64, ptr %3
  ret i64 %564
L262:
  br label %L260
L260:
  %565 = icmp ne i64 0, 0
  br i1 %565, label %L259, label %L261
L261:
  br label %L81
L81:
  %566 = load i8, ptr %369
  %568 = sext i32 %566 to i64
  %569 = sext i32 60 to i64
  %567 = icmp eq i64 %568, %569
  %570 = zext i1 %567 to i64
  %571 = icmp ne i64 %570, 0
  br i1 %571, label %L263, label %L265
L263:
  %572 = call i8 @advance(ptr %0)
  %573 = call i8 @cur(ptr %0)
  %575 = sext i32 %573 to i64
  %576 = sext i32 61 to i64
  %574 = icmp eq i64 %575, %576
  %577 = zext i1 %574 to i64
  %578 = icmp ne i64 %577, 0
  br i1 %578, label %L266, label %L268
L266:
  br label %L269
L269:
  %579 = call i8 @advance(ptr %0)
  br label %L272
L272:
  store ptr @TOK_LSHIFT_ASSIGN, ptr %3
  %580 = getelementptr [4 x i8], ptr @.str25, i64 0, i64 0
  %581 = call i32 @strdup(ptr %580)
  store i32 %581, ptr %3
  %582 = load i64, ptr %3
  ret i64 %582
L275:
  br label %L273
L273:
  %583 = icmp ne i64 0, 0
  br i1 %583, label %L272, label %L274
L274:
  br label %L270
L270:
  %584 = icmp ne i64 0, 0
  br i1 %584, label %L269, label %L271
L271:
  br label %L268
L268:
  br label %L276
L276:
  store ptr @TOK_LSHIFT, ptr %3
  %585 = getelementptr [3 x i8], ptr @.str26, i64 0, i64 0
  %586 = call i32 @strdup(ptr %585)
  store i32 %586, ptr %3
  %587 = load i64, ptr %3
  ret i64 %587
L279:
  br label %L277
L277:
  %588 = icmp ne i64 0, 0
  br i1 %588, label %L276, label %L278
L278:
  br label %L265
L265:
  %589 = load i8, ptr %369
  %591 = sext i32 %589 to i64
  %592 = sext i32 61 to i64
  %590 = icmp eq i64 %591, %592
  %593 = zext i1 %590 to i64
  %594 = icmp ne i64 %593, 0
  br i1 %594, label %L280, label %L282
L280:
  br label %L283
L283:
  %595 = call i8 @advance(ptr %0)
  br label %L286
L286:
  store ptr @TOK_LEQ, ptr %3
  %596 = getelementptr [3 x i8], ptr @.str27, i64 0, i64 0
  %597 = call i32 @strdup(ptr %596)
  store i32 %597, ptr %3
  %598 = load i64, ptr %3
  ret i64 %598
L289:
  br label %L287
L287:
  %599 = icmp ne i64 0, 0
  br i1 %599, label %L286, label %L288
L288:
  br label %L284
L284:
  %600 = icmp ne i64 0, 0
  br i1 %600, label %L283, label %L285
L285:
  br label %L282
L282:
  br label %L290
L290:
  store ptr @TOK_LT, ptr %3
  %601 = getelementptr [2 x i8], ptr @.str28, i64 0, i64 0
  %602 = call i32 @strdup(ptr %601)
  store i32 %602, ptr %3
  %603 = load i64, ptr %3
  ret i64 %603
L293:
  br label %L291
L291:
  %604 = icmp ne i64 0, 0
  br i1 %604, label %L290, label %L292
L292:
  br label %L82
L82:
  %605 = load i8, ptr %369
  %607 = sext i32 %605 to i64
  %608 = sext i32 62 to i64
  %606 = icmp eq i64 %607, %608
  %609 = zext i1 %606 to i64
  %610 = icmp ne i64 %609, 0
  br i1 %610, label %L294, label %L296
L294:
  %611 = call i8 @advance(ptr %0)
  %612 = call i8 @cur(ptr %0)
  %614 = sext i32 %612 to i64
  %615 = sext i32 61 to i64
  %613 = icmp eq i64 %614, %615
  %616 = zext i1 %613 to i64
  %617 = icmp ne i64 %616, 0
  br i1 %617, label %L297, label %L299
L297:
  br label %L300
L300:
  %618 = call i8 @advance(ptr %0)
  br label %L303
L303:
  store ptr @TOK_RSHIFT_ASSIGN, ptr %3
  %619 = getelementptr [4 x i8], ptr @.str29, i64 0, i64 0
  %620 = call i32 @strdup(ptr %619)
  store i32 %620, ptr %3
  %621 = load i64, ptr %3
  ret i64 %621
L306:
  br label %L304
L304:
  %622 = icmp ne i64 0, 0
  br i1 %622, label %L303, label %L305
L305:
  br label %L301
L301:
  %623 = icmp ne i64 0, 0
  br i1 %623, label %L300, label %L302
L302:
  br label %L299
L299:
  br label %L307
L307:
  store ptr @TOK_RSHIFT, ptr %3
  %624 = getelementptr [3 x i8], ptr @.str30, i64 0, i64 0
  %625 = call i32 @strdup(ptr %624)
  store i32 %625, ptr %3
  %626 = load i64, ptr %3
  ret i64 %626
L310:
  br label %L308
L308:
  %627 = icmp ne i64 0, 0
  br i1 %627, label %L307, label %L309
L309:
  br label %L296
L296:
  %628 = load i8, ptr %369
  %630 = sext i32 %628 to i64
  %631 = sext i32 61 to i64
  %629 = icmp eq i64 %630, %631
  %632 = zext i1 %629 to i64
  %633 = icmp ne i64 %632, 0
  br i1 %633, label %L311, label %L313
L311:
  br label %L314
L314:
  %634 = call i8 @advance(ptr %0)
  br label %L317
L317:
  store ptr @TOK_GEQ, ptr %3
  %635 = getelementptr [3 x i8], ptr @.str31, i64 0, i64 0
  %636 = call i32 @strdup(ptr %635)
  store i32 %636, ptr %3
  %637 = load i64, ptr %3
  ret i64 %637
L320:
  br label %L318
L318:
  %638 = icmp ne i64 0, 0
  br i1 %638, label %L317, label %L319
L319:
  br label %L315
L315:
  %639 = icmp ne i64 0, 0
  br i1 %639, label %L314, label %L316
L316:
  br label %L313
L313:
  br label %L321
L321:
  store ptr @TOK_GT, ptr %3
  %640 = getelementptr [2 x i8], ptr @.str32, i64 0, i64 0
  %641 = call i32 @strdup(ptr %640)
  store i32 %641, ptr %3
  %642 = load i64, ptr %3
  ret i64 %642
L324:
  br label %L322
L322:
  %643 = icmp ne i64 0, 0
  br i1 %643, label %L321, label %L323
L323:
  br label %L83
L83:
  %644 = load i8, ptr %369
  %646 = sext i32 %644 to i64
  %647 = sext i32 61 to i64
  %645 = icmp eq i64 %646, %647
  %648 = zext i1 %645 to i64
  %649 = icmp ne i64 %648, 0
  br i1 %649, label %L325, label %L327
L325:
  br label %L328
L328:
  %650 = call i8 @advance(ptr %0)
  br label %L331
L331:
  store ptr @TOK_EQ, ptr %3
  %651 = getelementptr [3 x i8], ptr @.str33, i64 0, i64 0
  %652 = call i32 @strdup(ptr %651)
  store i32 %652, ptr %3
  %653 = load i64, ptr %3
  ret i64 %653
L334:
  br label %L332
L332:
  %654 = icmp ne i64 0, 0
  br i1 %654, label %L331, label %L333
L333:
  br label %L329
L329:
  %655 = icmp ne i64 0, 0
  br i1 %655, label %L328, label %L330
L330:
  br label %L327
L327:
  br label %L335
L335:
  store ptr @TOK_ASSIGN, ptr %3
  %656 = getelementptr [2 x i8], ptr @.str34, i64 0, i64 0
  %657 = call i32 @strdup(ptr %656)
  store i32 %657, ptr %3
  %658 = load i64, ptr %3
  ret i64 %658
L338:
  br label %L336
L336:
  %659 = icmp ne i64 0, 0
  br i1 %659, label %L335, label %L337
L337:
  br label %L84
L84:
  %660 = load i8, ptr %369
  %662 = sext i32 %660 to i64
  %663 = sext i32 61 to i64
  %661 = icmp eq i64 %662, %663
  %664 = zext i1 %661 to i64
  %665 = icmp ne i64 %664, 0
  br i1 %665, label %L339, label %L341
L339:
  br label %L342
L342:
  %666 = call i8 @advance(ptr %0)
  br label %L345
L345:
  store ptr @TOK_NEQ, ptr %3
  %667 = getelementptr [3 x i8], ptr @.str35, i64 0, i64 0
  %668 = call i32 @strdup(ptr %667)
  store i32 %668, ptr %3
  %669 = load i64, ptr %3
  ret i64 %669
L348:
  br label %L346
L346:
  %670 = icmp ne i64 0, 0
  br i1 %670, label %L345, label %L347
L347:
  br label %L343
L343:
  %671 = icmp ne i64 0, 0
  br i1 %671, label %L342, label %L344
L344:
  br label %L341
L341:
  br label %L349
L349:
  store ptr @TOK_BANG, ptr %3
  %672 = getelementptr [2 x i8], ptr @.str36, i64 0, i64 0
  %673 = call i32 @strdup(ptr %672)
  store i32 %673, ptr %3
  %674 = load i64, ptr %3
  ret i64 %674
L352:
  br label %L350
L350:
  %675 = icmp ne i64 0, 0
  br i1 %675, label %L349, label %L351
L351:
  br label %L85
L85:
  %676 = load i8, ptr %369
  %678 = sext i32 %676 to i64
  %679 = sext i32 46 to i64
  %677 = icmp eq i64 %678, %679
  %680 = zext i1 %677 to i64
  %681 = load i64, ptr %0
  %682 = load i64, ptr %0
  %684 = sext i32 %682 to i64
  %685 = sext i32 1 to i64
  %683 = add i64 %684, %685
  %686 = getelementptr i32, ptr %681, i64 %683
  %687 = load i32, ptr %686
  %689 = sext i32 %687 to i64
  %690 = sext i32 46 to i64
  %688 = icmp eq i64 %689, %690
  %691 = zext i1 %688 to i64
  %693 = sext i32 %680 to i64
  %694 = sext i32 %691 to i64
  %695 = icmp ne i64 %693, 0
  %696 = icmp ne i64 %694, 0
  %697 = and i1 %695, %696
  %698 = zext i1 %697 to i64
  %699 = icmp ne i64 %698, 0
  br i1 %699, label %L353, label %L355
L353:
  %700 = call i8 @advance(ptr %0)
  %701 = call i8 @advance(ptr %0)
  br label %L356
L356:
  store ptr @TOK_ELLIPSIS, ptr %3
  %702 = getelementptr [4 x i8], ptr @.str37, i64 0, i64 0
  %703 = call i32 @strdup(ptr %702)
  store i32 %703, ptr %3
  %704 = load i64, ptr %3
  ret i64 %704
L359:
  br label %L357
L357:
  %705 = icmp ne i64 0, 0
  br i1 %705, label %L356, label %L358
L358:
  br label %L355
L355:
  br label %L360
L360:
  store ptr @TOK_DOT, ptr %3
  %706 = getelementptr [2 x i8], ptr @.str38, i64 0, i64 0
  %707 = call i32 @strdup(ptr %706)
  store i32 %707, ptr %3
  %708 = load i64, ptr %3
  ret i64 %708
L363:
  br label %L361
L361:
  %709 = icmp ne i64 0, 0
  br i1 %709, label %L360, label %L362
L362:
  br label %L86
L86:
  br label %L364
L364:
  store ptr @TOK_LPAREN, ptr %3
  %710 = getelementptr [2 x i8], ptr @.str39, i64 0, i64 0
  %711 = call i32 @strdup(ptr %710)
  store i32 %711, ptr %3
  %712 = load i64, ptr %3
  ret i64 %712
L367:
  br label %L365
L365:
  %713 = icmp ne i64 0, 0
  br i1 %713, label %L364, label %L366
L366:
  br label %L87
L87:
  br label %L368
L368:
  store ptr @TOK_RPAREN, ptr %3
  %714 = getelementptr [2 x i8], ptr @.str40, i64 0, i64 0
  %715 = call i32 @strdup(ptr %714)
  store i32 %715, ptr %3
  %716 = load i64, ptr %3
  ret i64 %716
L371:
  br label %L369
L369:
  %717 = icmp ne i64 0, 0
  br i1 %717, label %L368, label %L370
L370:
  br label %L88
L88:
  br label %L372
L372:
  store ptr @TOK_LBRACE, ptr %3
  %718 = getelementptr [2 x i8], ptr @.str41, i64 0, i64 0
  %719 = call i32 @strdup(ptr %718)
  store i32 %719, ptr %3
  %720 = load i64, ptr %3
  ret i64 %720
L375:
  br label %L373
L373:
  %721 = icmp ne i64 0, 0
  br i1 %721, label %L372, label %L374
L374:
  br label %L89
L89:
  br label %L376
L376:
  store ptr @TOK_RBRACE, ptr %3
  %722 = getelementptr [2 x i8], ptr @.str42, i64 0, i64 0
  %723 = call i32 @strdup(ptr %722)
  store i32 %723, ptr %3
  %724 = load i64, ptr %3
  ret i64 %724
L379:
  br label %L377
L377:
  %725 = icmp ne i64 0, 0
  br i1 %725, label %L376, label %L378
L378:
  br label %L90
L90:
  br label %L380
L380:
  store ptr @TOK_LBRACKET, ptr %3
  %726 = getelementptr [2 x i8], ptr @.str43, i64 0, i64 0
  %727 = call i32 @strdup(ptr %726)
  store i32 %727, ptr %3
  %728 = load i64, ptr %3
  ret i64 %728
L383:
  br label %L381
L381:
  %729 = icmp ne i64 0, 0
  br i1 %729, label %L380, label %L382
L382:
  br label %L91
L91:
  br label %L384
L384:
  store ptr @TOK_RBRACKET, ptr %3
  %730 = getelementptr [2 x i8], ptr @.str44, i64 0, i64 0
  %731 = call i32 @strdup(ptr %730)
  store i32 %731, ptr %3
  %732 = load i64, ptr %3
  ret i64 %732
L387:
  br label %L385
L385:
  %733 = icmp ne i64 0, 0
  br i1 %733, label %L384, label %L386
L386:
  br label %L92
L92:
  br label %L388
L388:
  store ptr @TOK_SEMICOLON, ptr %3
  %734 = getelementptr [2 x i8], ptr @.str45, i64 0, i64 0
  %735 = call i32 @strdup(ptr %734)
  store i32 %735, ptr %3
  %736 = load i64, ptr %3
  ret i64 %736
L391:
  br label %L389
L389:
  %737 = icmp ne i64 0, 0
  br i1 %737, label %L388, label %L390
L390:
  br label %L93
L93:
  br label %L392
L392:
  store ptr @TOK_COMMA, ptr %3
  %738 = getelementptr [2 x i8], ptr @.str46, i64 0, i64 0
  %739 = call i32 @strdup(ptr %738)
  store i32 %739, ptr %3
  %740 = load i64, ptr %3
  ret i64 %740
L395:
  br label %L393
L393:
  %741 = icmp ne i64 0, 0
  br i1 %741, label %L392, label %L394
L394:
  br label %L94
L94:
  br label %L396
L396:
  store ptr @TOK_QUESTION, ptr %3
  %742 = getelementptr [2 x i8], ptr @.str47, i64 0, i64 0
  %743 = call i32 @strdup(ptr %742)
  store i32 %743, ptr %3
  %744 = load i64, ptr %3
  ret i64 %744
L399:
  br label %L397
L397:
  %745 = icmp ne i64 0, 0
  br i1 %745, label %L396, label %L398
L398:
  br label %L95
L95:
  br label %L400
L400:
  store ptr @TOK_COLON, ptr %3
  %746 = getelementptr [2 x i8], ptr @.str48, i64 0, i64 0
  %747 = call i32 @strdup(ptr %746)
  store i32 %747, ptr %3
  %748 = load i64, ptr %3
  ret i64 %748
L403:
  br label %L401
L401:
  %749 = icmp ne i64 0, 0
  br i1 %749, label %L400, label %L402
L402:
  br label %L71
L96:
  store ptr @TOK_UNKNOWN, ptr %3
  %750 = call i32 @malloc(i32 2)
  store i32 %750, ptr %3
  %751 = load i8, ptr %366
  %752 = load i64, ptr %3
  %753 = getelementptr i8, ptr %752, i64 0
  store i8 %751, ptr %753
  %754 = load i64, ptr %3
  %755 = getelementptr i8, ptr %754, i64 1
  store i8 0, ptr %755
  %756 = load i64, ptr %3
  ret i64 %756
L404:
  br label %L71
L71:
  ret i64 0
}

define dso_local i64 @lexer_next(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %3 = icmp ne i64 %2, 0
  br i1 %3, label %L0, label %L2
L0:
  store i32 0, ptr %0
  %4 = load i64, ptr %0
  ret i64 %4
L3:
  br label %L2
L2:
  %5 = call i64 @read_token(ptr %0)
  ret i64 %5
L4:
  ret i64 0
}

define dso_local i64 @lexer_peek(ptr %0) {
entry:
  %2 = load i64, ptr %0
  %4 = icmp eq i64 %2, 0
  %3 = zext i1 %4 to i64
  %5 = icmp ne i64 %3, 0
  br i1 %5, label %L0, label %L2
L0:
  %6 = call i64 @read_token(ptr %0)
  store i64 %6, ptr %0
  store i32 1, ptr %0
  br label %L2
L2:
  %7 = load i64, ptr %0
  ret i64 %7
L3:
  ret i64 0
}

define dso_local ptr @token_type_name(i64 %0) {
entry:
  %2 = sext i32 %0 to i64
  switch i64 %2, label %L84 [
    i64 0, label %L1
    i64 0, label %L2
    i64 0, label %L3
    i64 0, label %L4
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
    i64 0, label %L23
    i64 0, label %L24
    i64 0, label %L25
    i64 0, label %L26
    i64 0, label %L27
    i64 0, label %L28
    i64 0, label %L29
    i64 0, label %L30
    i64 0, label %L31
    i64 0, label %L32
    i64 0, label %L33
    i64 0, label %L34
    i64 0, label %L35
    i64 0, label %L36
    i64 0, label %L37
    i64 0, label %L38
    i64 0, label %L39
    i64 0, label %L40
    i64 0, label %L41
    i64 0, label %L42
    i64 0, label %L43
    i64 0, label %L44
    i64 0, label %L45
    i64 0, label %L46
    i64 0, label %L47
    i64 0, label %L48
    i64 0, label %L49
    i64 0, label %L50
    i64 0, label %L51
    i64 0, label %L52
    i64 0, label %L53
    i64 0, label %L54
    i64 0, label %L55
    i64 0, label %L56
    i64 0, label %L57
    i64 0, label %L58
    i64 0, label %L59
    i64 0, label %L60
    i64 0, label %L61
    i64 0, label %L62
    i64 0, label %L63
    i64 0, label %L64
    i64 0, label %L65
    i64 0, label %L66
    i64 0, label %L67
    i64 0, label %L68
    i64 0, label %L69
    i64 0, label %L70
    i64 0, label %L71
    i64 0, label %L72
    i64 0, label %L73
    i64 0, label %L74
    i64 0, label %L75
    i64 0, label %L76
    i64 0, label %L77
    i64 0, label %L78
    i64 0, label %L79
    i64 0, label %L80
    i64 0, label %L81
    i64 0, label %L82
    i64 0, label %L83
  ]
L1:
  %3 = getelementptr [12 x i8], ptr @.str49, i64 0, i64 0
  ret ptr %3
L85:
  br label %L2
L2:
  %4 = getelementptr [14 x i8], ptr @.str50, i64 0, i64 0
  ret ptr %4
L86:
  br label %L3
L3:
  %5 = getelementptr [13 x i8], ptr @.str51, i64 0, i64 0
  ret ptr %5
L87:
  br label %L4
L4:
  %6 = getelementptr [15 x i8], ptr @.str52, i64 0, i64 0
  ret ptr %6
L88:
  br label %L5
L5:
  %7 = getelementptr [10 x i8], ptr @.str53, i64 0, i64 0
  ret ptr %7
L89:
  br label %L6
L6:
  %8 = getelementptr [8 x i8], ptr @.str54, i64 0, i64 0
  ret ptr %8
L90:
  br label %L7
L7:
  %9 = getelementptr [9 x i8], ptr @.str55, i64 0, i64 0
  ret ptr %9
L91:
  br label %L8
L8:
  %10 = getelementptr [10 x i8], ptr @.str56, i64 0, i64 0
  ret ptr %10
L92:
  br label %L9
L9:
  %11 = getelementptr [11 x i8], ptr @.str57, i64 0, i64 0
  ret ptr %11
L93:
  br label %L10
L10:
  %12 = getelementptr [9 x i8], ptr @.str58, i64 0, i64 0
  ret ptr %12
L94:
  br label %L11
L11:
  %13 = getelementptr [9 x i8], ptr @.str59, i64 0, i64 0
  ret ptr %13
L95:
  br label %L12
L12:
  %14 = getelementptr [10 x i8], ptr @.str60, i64 0, i64 0
  ret ptr %14
L96:
  br label %L13
L13:
  %15 = getelementptr [13 x i8], ptr @.str61, i64 0, i64 0
  ret ptr %15
L97:
  br label %L14
L14:
  %16 = getelementptr [11 x i8], ptr @.str62, i64 0, i64 0
  ret ptr %16
L98:
  br label %L15
L15:
  %17 = getelementptr [7 x i8], ptr @.str63, i64 0, i64 0
  ret ptr %17
L99:
  br label %L16
L16:
  %18 = getelementptr [9 x i8], ptr @.str64, i64 0, i64 0
  ret ptr %18
L100:
  br label %L17
L17:
  %19 = getelementptr [10 x i8], ptr @.str65, i64 0, i64 0
  ret ptr %19
L101:
  br label %L18
L18:
  %20 = getelementptr [8 x i8], ptr @.str66, i64 0, i64 0
  ret ptr %20
L102:
  br label %L19
L19:
  %21 = getelementptr [7 x i8], ptr @.str67, i64 0, i64 0
  ret ptr %21
L103:
  br label %L20
L20:
  %22 = getelementptr [11 x i8], ptr @.str68, i64 0, i64 0
  ret ptr %22
L104:
  br label %L21
L21:
  %23 = getelementptr [10 x i8], ptr @.str69, i64 0, i64 0
  ret ptr %23
L105:
  br label %L22
L22:
  %24 = getelementptr [13 x i8], ptr @.str70, i64 0, i64 0
  ret ptr %24
L106:
  br label %L23
L23:
  %25 = getelementptr [11 x i8], ptr @.str71, i64 0, i64 0
  ret ptr %25
L107:
  br label %L24
L24:
  %26 = getelementptr [10 x i8], ptr @.str72, i64 0, i64 0
  ret ptr %26
L108:
  br label %L25
L25:
  %27 = getelementptr [11 x i8], ptr @.str73, i64 0, i64 0
  ret ptr %27
L109:
  br label %L26
L26:
  %28 = getelementptr [9 x i8], ptr @.str74, i64 0, i64 0
  ret ptr %28
L110:
  br label %L27
L27:
  %29 = getelementptr [12 x i8], ptr @.str75, i64 0, i64 0
  ret ptr %29
L111:
  br label %L28
L28:
  %30 = getelementptr [9 x i8], ptr @.str76, i64 0, i64 0
  ret ptr %30
L112:
  br label %L29
L29:
  %31 = getelementptr [9 x i8], ptr @.str77, i64 0, i64 0
  ret ptr %31
L113:
  br label %L30
L30:
  %32 = getelementptr [12 x i8], ptr @.str78, i64 0, i64 0
  ret ptr %32
L114:
  br label %L31
L31:
  %33 = getelementptr [11 x i8], ptr @.str79, i64 0, i64 0
  ret ptr %33
L115:
  br label %L32
L32:
  %34 = getelementptr [11 x i8], ptr @.str80, i64 0, i64 0
  ret ptr %34
L116:
  br label %L33
L33:
  %35 = getelementptr [10 x i8], ptr @.str81, i64 0, i64 0
  ret ptr %35
L117:
  br label %L34
L34:
  %36 = getelementptr [13 x i8], ptr @.str82, i64 0, i64 0
  ret ptr %36
L118:
  br label %L35
L35:
  %37 = getelementptr [11 x i8], ptr @.str83, i64 0, i64 0
  ret ptr %37
L119:
  br label %L36
L36:
  %38 = getelementptr [9 x i8], ptr @.str84, i64 0, i64 0
  ret ptr %38
L120:
  br label %L37
L37:
  %39 = getelementptr [10 x i8], ptr @.str85, i64 0, i64 0
  ret ptr %39
L121:
  br label %L38
L38:
  %40 = getelementptr [9 x i8], ptr @.str86, i64 0, i64 0
  ret ptr %40
L122:
  br label %L39
L39:
  %41 = getelementptr [10 x i8], ptr @.str87, i64 0, i64 0
  ret ptr %41
L123:
  br label %L40
L40:
  %42 = getelementptr [12 x i8], ptr @.str88, i64 0, i64 0
  ret ptr %42
L124:
  br label %L41
L41:
  %43 = getelementptr [8 x i8], ptr @.str89, i64 0, i64 0
  ret ptr %43
L125:
  br label %L42
L42:
  %44 = getelementptr [9 x i8], ptr @.str90, i64 0, i64 0
  ret ptr %44
L126:
  br label %L43
L43:
  %45 = getelementptr [10 x i8], ptr @.str91, i64 0, i64 0
  ret ptr %45
L127:
  br label %L44
L44:
  %46 = getelementptr [10 x i8], ptr @.str92, i64 0, i64 0
  ret ptr %46
L128:
  br label %L45
L45:
  %47 = getelementptr [11 x i8], ptr @.str93, i64 0, i64 0
  ret ptr %47
L129:
  br label %L46
L46:
  %48 = getelementptr [11 x i8], ptr @.str94, i64 0, i64 0
  ret ptr %48
L130:
  br label %L47
L47:
  %49 = getelementptr [7 x i8], ptr @.str95, i64 0, i64 0
  ret ptr %49
L131:
  br label %L48
L48:
  %50 = getelementptr [8 x i8], ptr @.str96, i64 0, i64 0
  ret ptr %50
L132:
  br label %L49
L49:
  %51 = getelementptr [7 x i8], ptr @.str97, i64 0, i64 0
  ret ptr %51
L133:
  br label %L50
L50:
  %52 = getelementptr [7 x i8], ptr @.str98, i64 0, i64 0
  ret ptr %52
L134:
  br label %L51
L51:
  %53 = getelementptr [8 x i8], ptr @.str99, i64 0, i64 0
  ret ptr %53
L135:
  br label %L52
L52:
  %54 = getelementptr [8 x i8], ptr @.str100, i64 0, i64 0
  ret ptr %54
L136:
  br label %L53
L53:
  %55 = getelementptr [8 x i8], ptr @.str101, i64 0, i64 0
  ret ptr %55
L137:
  br label %L54
L54:
  %56 = getelementptr [7 x i8], ptr @.str102, i64 0, i64 0
  ret ptr %56
L138:
  br label %L55
L55:
  %57 = getelementptr [9 x i8], ptr @.str103, i64 0, i64 0
  ret ptr %57
L139:
  br label %L56
L56:
  %58 = getelementptr [11 x i8], ptr @.str104, i64 0, i64 0
  ret ptr %58
L140:
  br label %L57
L57:
  %59 = getelementptr [16 x i8], ptr @.str105, i64 0, i64 0
  ret ptr %59
L141:
  br label %L58
L58:
  %60 = getelementptr [17 x i8], ptr @.str106, i64 0, i64 0
  ret ptr %60
L142:
  br label %L59
L59:
  %61 = getelementptr [16 x i8], ptr @.str107, i64 0, i64 0
  ret ptr %61
L143:
  br label %L60
L60:
  %62 = getelementptr [17 x i8], ptr @.str108, i64 0, i64 0
  ret ptr %62
L144:
  br label %L61
L61:
  %63 = getelementptr [15 x i8], ptr @.str109, i64 0, i64 0
  ret ptr %63
L145:
  br label %L62
L62:
  %64 = getelementptr [16 x i8], ptr @.str110, i64 0, i64 0
  ret ptr %64
L146:
  br label %L63
L63:
  %65 = getelementptr [17 x i8], ptr @.str111, i64 0, i64 0
  ret ptr %65
L147:
  br label %L64
L64:
  %66 = getelementptr [18 x i8], ptr @.str112, i64 0, i64 0
  ret ptr %66
L148:
  br label %L65
L65:
  %67 = getelementptr [18 x i8], ptr @.str113, i64 0, i64 0
  ret ptr %67
L149:
  br label %L66
L66:
  %68 = getelementptr [19 x i8], ptr @.str114, i64 0, i64 0
  ret ptr %68
L150:
  br label %L67
L67:
  %69 = getelementptr [8 x i8], ptr @.str115, i64 0, i64 0
  ret ptr %69
L151:
  br label %L68
L68:
  %70 = getelementptr [8 x i8], ptr @.str116, i64 0, i64 0
  ret ptr %70
L152:
  br label %L69
L69:
  %71 = getelementptr [10 x i8], ptr @.str117, i64 0, i64 0
  ret ptr %71
L153:
  br label %L70
L70:
  %72 = getelementptr [8 x i8], ptr @.str118, i64 0, i64 0
  ret ptr %72
L154:
  br label %L71
L71:
  %73 = getelementptr [13 x i8], ptr @.str119, i64 0, i64 0
  ret ptr %73
L155:
  br label %L72
L72:
  %74 = getelementptr [10 x i8], ptr @.str120, i64 0, i64 0
  ret ptr %74
L156:
  br label %L73
L73:
  %75 = getelementptr [11 x i8], ptr @.str121, i64 0, i64 0
  ret ptr %75
L157:
  br label %L74
L74:
  %76 = getelementptr [11 x i8], ptr @.str122, i64 0, i64 0
  ret ptr %76
L158:
  br label %L75
L75:
  %77 = getelementptr [11 x i8], ptr @.str123, i64 0, i64 0
  ret ptr %77
L159:
  br label %L76
L76:
  %78 = getelementptr [11 x i8], ptr @.str124, i64 0, i64 0
  ret ptr %78
L160:
  br label %L77
L77:
  %79 = getelementptr [13 x i8], ptr @.str125, i64 0, i64 0
  ret ptr %79
L161:
  br label %L78
L78:
  %80 = getelementptr [13 x i8], ptr @.str126, i64 0, i64 0
  ret ptr %80
L162:
  br label %L79
L79:
  %81 = getelementptr [14 x i8], ptr @.str127, i64 0, i64 0
  ret ptr %81
L163:
  br label %L80
L80:
  %82 = getelementptr [10 x i8], ptr @.str128, i64 0, i64 0
  ret ptr %82
L164:
  br label %L81
L81:
  %83 = getelementptr [13 x i8], ptr @.str129, i64 0, i64 0
  ret ptr %83
L165:
  br label %L82
L82:
  %84 = getelementptr [8 x i8], ptr @.str130, i64 0, i64 0
  ret ptr %84
L166:
  br label %L83
L83:
  %85 = getelementptr [12 x i8], ptr @.str131, i64 0, i64 0
  ret ptr %85
L167:
  br label %L0
L84:
  %86 = getelementptr [4 x i8], ptr @.str132, i64 0, i64 0
  ret ptr %86
L168:
  br label %L0
L0:
  ret ptr 0
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
