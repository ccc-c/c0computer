; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@macro_preprocess = dso_local global ptr zeroinitializer
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
@codegen_new = dso_local global ptr zeroinitializer
@codegen_free = dso_local global ptr zeroinitializer
@codegen_emit = dso_local global ptr zeroinitializer

define internal ptr @read_file(ptr %0) {
entry:
  %2 = alloca ptr
  %4 = getelementptr [2 x i8], ptr @.str0, i64 0, i64 0
  %5 = call i32 @fopen(ptr %0, ptr %4)
  store ptr %5, ptr %2
  %6 = load ptr, ptr %2
  %8 = icmp eq i64 %6, 0
  %7 = zext i1 %8 to i64
  %9 = icmp ne i64 %7, 0
  br i1 %9, label %L0, label %L2
L0:
  %10 = getelementptr [23 x i8], ptr @.str1, i64 0, i64 0
  %11 = call i32 @fprintf(ptr @stderr, ptr %10, ptr %0)
  %12 = call i32 @exit(i32 1)
  br label %L2
L2:
  %13 = load ptr, ptr %2
  %14 = call i32 @fseek(ptr %13, i32 0, ptr @SEEK_END)
  %15 = alloca i64
  %17 = load ptr, ptr %2
  %18 = call i32 @ftell(ptr %17)
  store i64 %18, ptr %15
  %19 = load ptr, ptr %2
  %20 = call i32 @fseek(ptr %19, i32 0, ptr @SEEK_SET)
  %21 = alloca ptr
  %23 = load i64, ptr %15
  %25 = sext i32 %23 to i64
  %26 = sext i32 2 to i64
  %24 = add i64 %25, %26
  %27 = call i32 @malloc(i64 %24)
  store ptr %27, ptr %21
  %28 = load ptr, ptr %21
  %30 = icmp eq i64 %28, 0
  %29 = zext i1 %30 to i64
  %31 = icmp ne i64 %29, 0
  br i1 %31, label %L3, label %L5
L3:
  %32 = getelementptr [7 x i8], ptr @.str2, i64 0, i64 0
  %33 = call i32 @perror(ptr %32)
  %34 = call i32 @exit(i32 1)
  br label %L5
L5:
  %35 = alloca i64
  %37 = load ptr, ptr %21
  %38 = load i64, ptr %15
  %39 = load ptr, ptr %2
  %40 = call i32 @fread(ptr %37, i32 1, i64 %38, ptr %39)
  store ptr %40, ptr %35
  %41 = load ptr, ptr %21
  %42 = load i64, ptr %35
  %43 = getelementptr i8, ptr %41, i64 %42
  store i8 0, ptr %43
  %44 = load ptr, ptr %2
  %45 = call i32 @fclose(ptr %44)
  %46 = load ptr, ptr %21
  ret ptr %46
L6:
  ret ptr 0
}

define internal void @usage(ptr %0) {
entry:
  %2 = getelementptr [45 x i8], ptr @.str3, i64 0, i64 0
  %3 = call i32 @fprintf(ptr @stderr, ptr %2, ptr %0, ptr %0)
  ret void
}

define internal void @compile(ptr %0, ptr %2) {
entry:
  %4 = alloca ptr
  %6 = call ptr @read_file(ptr %0)
  store ptr %6, ptr %4
  %7 = alloca ptr
  %9 = load ptr, ptr %4
  %10 = call ptr @macro_preprocess(ptr %9, ptr %0, i32 0)
  store ptr %10, ptr %7
  %11 = load ptr, ptr %4
  %12 = call i32 @free(ptr %11)
  %13 = alloca ptr
  %15 = load ptr, ptr %7
  %16 = call ptr @lexer_new(ptr %15, ptr %0)
  store ptr %16, ptr %13
  %17 = alloca ptr
  %19 = load ptr, ptr %13
  %20 = call ptr @parser_new(ptr %19)
  store ptr %20, ptr %17
  %21 = alloca ptr
  %23 = load ptr, ptr %17
  %24 = call ptr @parser_parse(ptr %23)
  store ptr %24, ptr %21
  %25 = alloca ptr
  %27 = call ptr @codegen_new(ptr %2, ptr %0)
  store ptr %27, ptr %25
  %28 = load ptr, ptr %25
  %29 = load ptr, ptr %21
  call void @codegen_emit(ptr %28, ptr %29)
  %31 = load ptr, ptr %25
  call void @codegen_free(ptr %31)
  %33 = load ptr, ptr %21
  call void @node_free(ptr %33)
  %35 = load ptr, ptr %17
  call void @parser_free(ptr %35)
  %37 = load ptr, ptr %13
  call void @lexer_free(ptr %37)
  %39 = load ptr, ptr %7
  %40 = call i32 @free(ptr %39)
  ret void
}

define dso_local i32 @main(i32 %0, ptr %2) {
entry:
  %4 = alloca ptr
  %6 = inttoptr i64 0 to ptr
  store ptr %6, ptr %4
  %7 = alloca ptr
  %9 = inttoptr i64 0 to ptr
  store ptr %9, ptr %7
  %10 = alloca i32
  store i32 1, ptr %10
  br label %L0
L0:
  %12 = load i32, ptr %10
  %14 = sext i32 %12 to i64
  %15 = sext i32 %0 to i64
  %13 = icmp slt i64 %14, %15
  %16 = zext i1 %13 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %L1, label %L3
L1:
  %18 = load i32, ptr %10
  %19 = getelementptr ptr, ptr %2, i64 %18
  %20 = load ptr, ptr %19
  %21 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %22 = call i32 @strcmp(ptr %20, ptr %21)
  %24 = sext i32 %22 to i64
  %25 = sext i32 0 to i64
  %23 = icmp eq i64 %24, %25
  %26 = zext i1 %23 to i64
  %27 = load i32, ptr %10
  %28 = getelementptr ptr, ptr %2, i64 %27
  %29 = load ptr, ptr %28
  %30 = getelementptr [7 x i8], ptr @.str5, i64 0, i64 0
  %31 = call i32 @strcmp(ptr %29, ptr %30)
  %33 = sext i32 %31 to i64
  %34 = sext i32 0 to i64
  %32 = icmp eq i64 %33, %34
  %35 = zext i1 %32 to i64
  %37 = sext i32 %26 to i64
  %38 = sext i32 %35 to i64
  %39 = icmp ne i64 %37, 0
  %40 = icmp ne i64 %38, 0
  %41 = or i1 %39, %40
  %42 = zext i1 %41 to i64
  %43 = icmp ne i64 %42, 0
  br i1 %43, label %L4, label %L6
L4:
  %44 = getelementptr ptr, ptr %2, i64 0
  %45 = load ptr, ptr %44
  call void @usage(ptr %45)
  ret i32 0
L7:
  br label %L6
L6:
  %47 = load i32, ptr %10
  %48 = getelementptr ptr, ptr %2, i64 %47
  %49 = load ptr, ptr %48
  %50 = getelementptr [3 x i8], ptr @.str6, i64 0, i64 0
  %51 = call i32 @strcmp(ptr %49, ptr %50)
  %53 = sext i32 %51 to i64
  %54 = sext i32 0 to i64
  %52 = icmp eq i64 %53, %54
  %55 = zext i1 %52 to i64
  %56 = load i32, ptr %10
  %57 = getelementptr ptr, ptr %2, i64 %56
  %58 = load ptr, ptr %57
  %59 = getelementptr [10 x i8], ptr @.str7, i64 0, i64 0
  %60 = call i32 @strcmp(ptr %58, ptr %59)
  %62 = sext i32 %60 to i64
  %63 = sext i32 0 to i64
  %61 = icmp eq i64 %62, %63
  %64 = zext i1 %61 to i64
  %66 = sext i32 %55 to i64
  %67 = sext i32 %64 to i64
  %68 = icmp ne i64 %66, 0
  %69 = icmp ne i64 %67, 0
  %70 = or i1 %68, %69
  %71 = zext i1 %70 to i64
  %72 = icmp ne i64 %71, 0
  br i1 %72, label %L8, label %L10
L8:
  %73 = getelementptr [19 x i8], ptr @.str8, i64 0, i64 0
  %74 = call i32 @printf(ptr %73)
  ret i32 0
L11:
  br label %L10
L10:
  %75 = load i32, ptr %10
  %76 = getelementptr ptr, ptr %2, i64 %75
  %77 = load ptr, ptr %76
  %78 = getelementptr [3 x i8], ptr @.str9, i64 0, i64 0
  %79 = call i32 @strcmp(ptr %77, ptr %78)
  %81 = sext i32 %79 to i64
  %82 = sext i32 0 to i64
  %80 = icmp eq i64 %81, %82
  %83 = zext i1 %80 to i64
  %84 = icmp ne i64 %83, 0
  br i1 %84, label %L12, label %L14
L12:
  %85 = load i32, ptr %10
  %87 = sext i32 %85 to i64
  %86 = add i64 %87, 1
  store i64 %86, ptr %10
  %89 = sext i32 %86 to i64
  %90 = sext i32 %0 to i64
  %88 = icmp sge i64 %89, %90
  %91 = zext i1 %88 to i64
  %92 = icmp ne i64 %91, 0
  br i1 %92, label %L15, label %L17
L15:
  %93 = getelementptr [30 x i8], ptr @.str10, i64 0, i64 0
  %94 = call i32 @fprintf(ptr @stderr, ptr %93)
  ret i32 1
L18:
  br label %L17
L17:
  %95 = load i32, ptr %10
  %96 = getelementptr ptr, ptr %2, i64 %95
  %97 = load ptr, ptr %96
  store ptr %97, ptr %4
  br label %L2
L19:
  br label %L14
L14:
  %98 = load i32, ptr %10
  %99 = getelementptr ptr, ptr %2, i64 %98
  %100 = load ptr, ptr %99
  %101 = getelementptr [3 x i8], ptr @.str11, i64 0, i64 0
  %102 = call i32 @strcmp(ptr %100, ptr %101)
  %104 = sext i32 %102 to i64
  %105 = sext i32 0 to i64
  %103 = icmp eq i64 %104, %105
  %106 = zext i1 %103 to i64
  %107 = icmp ne i64 %106, 0
  br i1 %107, label %L20, label %L22
L20:
  %108 = load i32, ptr %10
  %110 = sext i32 %108 to i64
  %109 = add i64 %110, 1
  store i64 %109, ptr %10
  %112 = sext i32 %109 to i64
  %113 = sext i32 %0 to i64
  %111 = icmp sge i64 %112, %113
  %114 = zext i1 %111 to i64
  %115 = icmp ne i64 %114, 0
  br i1 %115, label %L23, label %L25
L23:
  %116 = getelementptr [30 x i8], ptr @.str12, i64 0, i64 0
  %117 = call i32 @fprintf(ptr @stderr, ptr %116)
  ret i32 1
L26:
  br label %L25
L25:
  %118 = load i32, ptr %10
  %119 = getelementptr ptr, ptr %2, i64 %118
  %120 = load ptr, ptr %119
  store ptr %120, ptr %7
  br label %L2
L27:
  br label %L22
L22:
  %121 = load ptr, ptr %4
  %123 = icmp eq i64 %121, 0
  %122 = zext i1 %123 to i64
  %124 = icmp ne i64 %122, 0
  br i1 %124, label %L28, label %L29
L28:
  %125 = load i32, ptr %10
  %126 = getelementptr ptr, ptr %2, i64 %125
  %127 = load ptr, ptr %126
  store ptr %127, ptr %4
  br label %L30
L29:
  %128 = getelementptr [31 x i8], ptr @.str13, i64 0, i64 0
  %129 = load i32, ptr %10
  %130 = getelementptr ptr, ptr %2, i64 %129
  %131 = load ptr, ptr %130
  %132 = call i32 @fprintf(ptr @stderr, ptr %128, ptr %131)
  %133 = getelementptr ptr, ptr %2, i64 0
  %134 = load ptr, ptr %133
  call void @usage(ptr %134)
  ret i32 1
L31:
  br label %L30
L30:
  br label %L2
L2:
  %136 = load i32, ptr %10
  %138 = sext i32 %136 to i64
  %137 = add i64 %138, 1
  store i64 %137, ptr %10
  br label %L0
L3:
  %139 = load ptr, ptr %4
  %141 = icmp eq i64 %139, 0
  %140 = zext i1 %141 to i64
  %142 = icmp ne i64 %140, 0
  br i1 %142, label %L32, label %L34
L32:
  %143 = getelementptr [20 x i8], ptr @.str14, i64 0, i64 0
  %144 = call i32 @fprintf(ptr @stderr, ptr %143)
  %145 = getelementptr ptr, ptr %2, i64 0
  %146 = load ptr, ptr %145
  call void @usage(ptr %146)
  ret i32 1
L35:
  br label %L34
L34:
  %148 = alloca ptr
  store ptr @stdout, ptr %148
  %150 = load ptr, ptr %7
  %151 = icmp ne i64 %150, 0
  br i1 %151, label %L36, label %L38
L36:
  %152 = load ptr, ptr %7
  %153 = getelementptr [2 x i8], ptr @.str15, i64 0, i64 0
  %154 = call i32 @fopen(ptr %152, ptr %153)
  store i32 %154, ptr %148
  %155 = load ptr, ptr %148
  %157 = icmp eq i64 %155, 0
  %156 = zext i1 %157 to i64
  %158 = icmp ne i64 %156, 0
  br i1 %158, label %L39, label %L41
L39:
  %159 = getelementptr [35 x i8], ptr @.str16, i64 0, i64 0
  %160 = load ptr, ptr %7
  %161 = call i32 @fprintf(ptr @stderr, ptr %159, ptr %160)
  ret i32 1
L42:
  br label %L41
L41:
  br label %L38
L38:
  %162 = load ptr, ptr %4
  %163 = load ptr, ptr %148
  call void @compile(ptr %162, ptr %163)
  %165 = load ptr, ptr %7
  %166 = icmp ne i64 %165, 0
  br i1 %166, label %L43, label %L45
L43:
  %167 = load ptr, ptr %148
  %168 = call i32 @fclose(ptr %167)
  br label %L45
L45:
  ret i32 0
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
