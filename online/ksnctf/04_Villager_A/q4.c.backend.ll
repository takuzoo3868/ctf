source_filename = "test"
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"

%_IO_FILE = type { i32 }

@global_var_80487a4.7 = constant [18 x i8] c"What's your name?\00"
@global_var_80487b6.9 = constant [5 x i8] c"Hi, \00"
@global_var_80487bb.10 = constant [22 x i8] c"Do you want the flag?\00"
@global_var_80487d1.11 = constant [4 x i8] c"no\0A\00"
@global_var_80487d5.12 = constant [17 x i8] c"I see. Good bye.\00"
@global_var_8049a04.8 = local_unnamed_addr global %_IO_FILE* null

define i32 @main(i32 %argc, i8** %argv) local_unnamed_addr {
dec_label_pc_80485b4:
  %stack_var_-1048 = alloca i32, align 4
  %v3_80485c7 = call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @global_var_80487a4.7, i32 0, i32 0))
  %v0_80485cc = load %_IO_FILE*, %_IO_FILE** @global_var_8049a04.8, align 4
  %tmp115 = bitcast i32* %stack_var_-1048 to i8*
  %v8_80485e4 = call i8* @fgets(i8* %tmp115, i32 1024, %_IO_FILE* %v0_80485cc)
  %v3_80485f0 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @global_var_80487b6.9, i32 0, i32 0))
  %v3_80485fc = call i32 (i8*, ...) @printf(i8* %tmp115)
  %v2_8048608 = call i32 @putchar(i32 10)
  br label %dec_label_pc_8048681

dec_label_pc_8048656:                             ; preds = %dec_label_pc_8048681
  %v6_8048665 = call i32 @strcmp(i8* %tmp115, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @global_var_80487d1.11, i32 0, i32 0))
  %v1_804866a = icmp eq i32 %v6_8048665, 0
  %v1_804866c = icmp eq i1 %v1_804866a, false
  br i1 %v1_804866c, label %dec_label_pc_8048681, label %dec_label_pc_804866e

dec_label_pc_804866e:                             ; preds = %dec_label_pc_8048656
  %v3_8048675 = call i32 @puts(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @global_var_80487d5.12, i32 0, i32 0))
  br label %dec_label_pc_80486dc

dec_label_pc_8048681:                             ; preds = %dec_label_pc_8048656, %dec_label_pc_80485b4
  %v3_8048621 = call i32 @puts(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @global_var_80487bb.10, i32 0, i32 0))
  %v0_8048626 = load %_IO_FILE*, %_IO_FILE** @global_var_8049a04.8, align 4
  %v8_804863e = call i8* @fgets(i8* %tmp115, i32 1024, %_IO_FILE* %v0_8048626)
  %v1_8048643 = icmp eq i8* %v8_804863e, null
  %v5_8048648 = icmp eq i1 %v1_8048643, false
  br i1 %v5_8048648, label %dec_label_pc_8048656, label %dec_label_pc_80486dc

dec_label_pc_80486dc:                             ; preds = %dec_label_pc_8048681, %dec_label_pc_804866e
  ret i32 0

; uselistorder directives
  uselistorder i8* %tmp115, { 1, 0, 2, 3 }
  uselistorder i32 (i8*, ...)* @printf, { 1, 0 }
  uselistorder %_IO_FILE** @global_var_8049a04.8, { 1, 0 }
  uselistorder i32 (i8*)* @puts, { 1, 2, 0 }
  uselistorder i32 0, { 0, 5, 6, 1, 2, 11, 3, 4, 7, 8, 9, 10 }
}

declare i32 @putchar(i32) local_unnamed_addr

declare i8* @fgets(i8*, i32, %_IO_FILE*) local_unnamed_addr

declare i32 @printf(i8*, ...) local_unnamed_addr

declare i32 @puts(i8*) local_unnamed_addr

declare i32 @strcmp(i8*, i8*) local_unnamed_addr
