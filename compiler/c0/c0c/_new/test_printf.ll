; ModuleID = 'c0c'
@stdin = external global ptr
@stdout = external global ptr
@stderr = external global ptr
declare ptr @fopen(ptr %name, ptr %mode)

declare i32 @fclose(ptr %f)

declare i32 @fseek(ptr %f, i64 %offset, i32 %whence)

declare i64 @ftell(ptr %f)

declare i32 @fread(ptr %ptr, i32 %size, i32 %nmemb, ptr %f)

declare i32 @fputs(ptr %s, ptr %f)

declare i32 @printf(ptr %fmt, ...)

declare i32 @sprintf(ptr %str, ptr %fmt, ...)

declare i32 @snprintf(ptr %str, i32 %size, ptr %fmt, ...)

declare i32 @fprintf(ptr %f, ptr %fmt, ...)

declare void @perror(ptr %s)

define dso_local i32 @main() {
entry:
  %0 = getelementptr ([7 x i8], ptr @.str.0, i32 0, i32 0)
  %1 = call i32 (ptr, ...) @printf(ptr %0)
  ret i32 0
  ret i32 0
}

@.str.0 = private unnamed_addr constant [7 x i8] c"hello\0A\00", align 1
