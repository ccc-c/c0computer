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
  %2 = getelementptr [403 x i8], ptr @.str3, i64 0, i64 0
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
  store ptr 0, ptr %4
  %6 = alloca ptr
  store ptr 0, ptr %6
  %8 = alloca i32
  store i32 1, ptr %8
  br label %L0
L0:
  %10 = load i32, ptr %8
  %12 = sext i32 %10 to i64
  %13 = sext i32 %0 to i64
  %11 = icmp slt i64 %12, %13
  %14 = zext i1 %11 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %L1, label %L3
L1:
  %16 = load i32, ptr %8
  %17 = getelementptr ptr, ptr %2, i64 %16
  %18 = load ptr, ptr %17
  %19 = getelementptr [3 x i8], ptr @.str4, i64 0, i64 0
  %20 = call i32 @strcmp(ptr %18, ptr %19)
  %22 = sext i32 %20 to i64
  %23 = sext i32 0 to i64
  %21 = icmp eq i64 %22, %23
  %24 = zext i1 %21 to i64
  %25 = load i32, ptr %8
  %26 = getelementptr ptr, ptr %2, i64 %25
  %27 = load ptr, ptr %26
  %28 = getelementptr [7 x i8], ptr @.str5, i64 0, i64 0
  %29 = call i32 @strcmp(ptr %27, ptr %28)
  %31 = sext i32 %29 to i64
  %32 = sext i32 0 to i64
  %30 = icmp eq i64 %31, %32
  %33 = zext i1 %30 to i64
  %35 = sext i32 %24 to i64
  %36 = sext i32 %33 to i64
  %37 = icmp ne i64 %35, 0
  %38 = icmp ne i64 %36, 0
  %39 = or i1 %37, %38
  %40 = zext i1 %39 to i64
  %41 = icmp ne i64 %40, 0
  br i1 %41, label %L4, label %L6
L4:
  %42 = getelementptr ptr, ptr %2, i64 0
  %43 = load ptr, ptr %42
  call void @usage(ptr %43)
  ret i32 0
L7:
  br label %L6
L6:
  %45 = load i32, ptr %8
  %46 = getelementptr ptr, ptr %2, i64 %45
  %47 = load ptr, ptr %46
  %48 = getelementptr [3 x i8], ptr @.str6, i64 0, i64 0
  %49 = call i32 @strcmp(ptr %47, ptr %48)
  %51 = sext i32 %49 to i64
  %52 = sext i32 0 to i64
  %50 = icmp eq i64 %51, %52
  %53 = zext i1 %50 to i64
  %54 = load i32, ptr %8
  %55 = getelementptr ptr, ptr %2, i64 %54
  %56 = load ptr, ptr %55
  %57 = getelementptr [10 x i8], ptr @.str7, i64 0, i64 0
  %58 = call i32 @strcmp(ptr %56, ptr %57)
  %60 = sext i32 %58 to i64
  %61 = sext i32 0 to i64
  %59 = icmp eq i64 %60, %61
  %62 = zext i1 %59 to i64
  %64 = sext i32 %53 to i64
  %65 = sext i32 %62 to i64
  %66 = icmp ne i64 %64, 0
  %67 = icmp ne i64 %65, 0
  %68 = or i1 %66, %67
  %69 = zext i1 %68 to i64
  %70 = icmp ne i64 %69, 0
  br i1 %70, label %L8, label %L10
L8:
  %71 = getelementptr [19 x i8], ptr @.str8, i64 0, i64 0
  %72 = call i32 @printf(ptr %71)
  ret i32 0
L11:
  br label %L10
L10:
  %73 = load i32, ptr %8
  %74 = getelementptr ptr, ptr %2, i64 %73
  %75 = load ptr, ptr %74
  %76 = getelementptr [3 x i8], ptr @.str9, i64 0, i64 0
  %77 = call i32 @strcmp(ptr %75, ptr %76)
  %79 = sext i32 %77 to i64
  %80 = sext i32 0 to i64
  %78 = icmp eq i64 %79, %80
  %81 = zext i1 %78 to i64
  %82 = icmp ne i64 %81, 0
  br i1 %82, label %L12, label %L14
L12:
  %83 = load i32, ptr %8
  %85 = sext i32 %83 to i64
  %84 = add i64 %85, 1
  store i64 %84, ptr %8
  %87 = sext i32 %84 to i64
  %88 = sext i32 %0 to i64
  %86 = icmp sge i64 %87, %88
  %89 = zext i1 %86 to i64
  %90 = icmp ne i64 %89, 0
  br i1 %90, label %L15, label %L17
L15:
  %91 = getelementptr [30 x i8], ptr @.str10, i64 0, i64 0
  %92 = call i32 @fprintf(ptr @stderr, ptr %91)
  ret i32 1
L18:
  br label %L17
L17:
  %93 = load i32, ptr %8
  %94 = getelementptr ptr, ptr %2, i64 %93
  %95 = load ptr, ptr %94
  store ptr %95, ptr %4
  br label %L2
L19:
  br label %L14
L14:
  %96 = load i32, ptr %8
  %97 = getelementptr ptr, ptr %2, i64 %96
  %98 = load ptr, ptr %97
  %99 = getelementptr [3 x i8], ptr @.str11, i64 0, i64 0
  %100 = call i32 @strcmp(ptr %98, ptr %99)
  %102 = sext i32 %100 to i64
  %103 = sext i32 0 to i64
  %101 = icmp eq i64 %102, %103
  %104 = zext i1 %101 to i64
  %105 = icmp ne i64 %104, 0
  br i1 %105, label %L20, label %L22
L20:
  %106 = load i32, ptr %8
  %108 = sext i32 %106 to i64
  %107 = add i64 %108, 1
  store i64 %107, ptr %8
  %110 = sext i32 %107 to i64
  %111 = sext i32 %0 to i64
  %109 = icmp sge i64 %110, %111
  %112 = zext i1 %109 to i64
  %113 = icmp ne i64 %112, 0
  br i1 %113, label %L23, label %L25
L23:
  %114 = getelementptr [30 x i8], ptr @.str12, i64 0, i64 0
  %115 = call i32 @fprintf(ptr @stderr, ptr %114)
  ret i32 1
L26:
  br label %L25
L25:
  %116 = load i32, ptr %8
  %117 = getelementptr ptr, ptr %2, i64 %116
  %118 = load ptr, ptr %117
  store ptr %118, ptr %6
  br label %L2
L27:
  br label %L22
L22:
  %119 = load ptr, ptr %4
  %121 = icmp eq i64 %119, 0
  %120 = zext i1 %121 to i64
  %122 = icmp ne i64 %120, 0
  br i1 %122, label %L28, label %L29
L28:
  %123 = load i32, ptr %8
  %124 = getelementptr ptr, ptr %2, i64 %123
  %125 = load ptr, ptr %124
  store ptr %125, ptr %4
  br label %L30
L29:
  %126 = getelementptr [31 x i8], ptr @.str13, i64 0, i64 0
  %127 = load i32, ptr %8
  %128 = getelementptr ptr, ptr %2, i64 %127
  %129 = load ptr, ptr %128
  %130 = call i32 @fprintf(ptr @stderr, ptr %126, ptr %129)
  %131 = getelementptr ptr, ptr %2, i64 0
  %132 = load ptr, ptr %131
  call void @usage(ptr %132)
  ret i32 1
L31:
  br label %L30
L30:
  br label %L2
L2:
  %134 = load i32, ptr %8
  %136 = sext i32 %134 to i64
  %135 = add i64 %136, 1
  store i64 %135, ptr %8
  br label %L0
L3:
  %137 = load ptr, ptr %4
  %139 = icmp eq i64 %137, 0
  %138 = zext i1 %139 to i64
  %140 = icmp ne i64 %138, 0
  br i1 %140, label %L32, label %L34
L32:
  %141 = getelementptr [20 x i8], ptr @.str14, i64 0, i64 0
  %142 = call i32 @fprintf(ptr @stderr, ptr %141)
  %143 = getelementptr ptr, ptr %2, i64 0
  %144 = load ptr, ptr %143
  call void @usage(ptr %144)
  ret i32 1
L35:
  br label %L34
L34:
  %146 = alloca ptr
  store ptr @stdout, ptr %146
  %148 = load ptr, ptr %6
  %149 = icmp ne i64 %148, 0
  br i1 %149, label %L36, label %L38
L36:
  %150 = load ptr, ptr %6
  %151 = getelementptr [2 x i8], ptr @.str15, i64 0, i64 0
  %152 = call i32 @fopen(ptr %150, ptr %151)
  store i32 %152, ptr %146
  %153 = load ptr, ptr %146
  %155 = icmp eq i64 %153, 0
  %154 = zext i1 %155 to i64
  %156 = icmp ne i64 %154, 0
  br i1 %156, label %L39, label %L41
L39:
  %157 = getelementptr [35 x i8], ptr @.str16, i64 0, i64 0
  %158 = load ptr, ptr %6
  %159 = call i32 @fprintf(ptr @stderr, ptr %157, ptr %158)
  ret i32 1
L42:
  br label %L41
L41:
  br label %L38
L38:
  %160 = load ptr, ptr %4
  %161 = load ptr, ptr %146
  call void @compile(ptr %160, ptr %161)
  %163 = load ptr, ptr %6
  %164 = icmp ne i64 %163, 0
  br i1 %164, label %L43, label %L45
L43:
  %165 = load ptr, ptr %146
  %166 = call i32 @fclose(ptr %165)
  br label %L45
L45:
  ret i32 0
L46:
  ret i32 0
}

@.str0 = private unnamed_addr constant [2 x i8] c"r\00"
@.str1 = private unnamed_addr constant [23 x i8] c"c0c: cannot open '%s'\0A\00"
@.str2 = private unnamed_addr constant [7 x i8] c"malloc\00"
@.str3 = private unnamed_addr constant [403 x i8] c"c0c - a self-hosting C to LLVM IR compiler\0A\0AUsage:\0A  %s -c <input.c> -o <output.ll>\0A  %s -c <input.c>          (writes to stdout)\0A\0AOptions:\0A  -c <file>   Compile <file> (required)\0A  -o <file>   Write LLVM IR to <file>\0A  -h          Show this help\0A  -v          Show version\0A\0Ac0c is a subset-C compiler that produces LLVM IR (.ll) files.\0AThe output can be linked with clang:\0A  clang output.ll -o binary\0A\00"
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
