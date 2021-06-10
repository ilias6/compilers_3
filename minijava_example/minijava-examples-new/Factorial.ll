declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
@_cNSZ = constant [15 x i8] c"Negative size\0a\00"

define void @print_int(i32 %i) {
	%_str = bitcast [4 x i8]* @_cint to i8*
	call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
	ret void
}

define void @throw_oob() {
	%_str = bitcast [15 x i8]* @_cOOB to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void
}

define void @throw_nsz() {
	%_str = bitcast [15 x i8]* @_cNSZ to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void
}


@.Factorial = global [0 x i8*] []

@.Fac = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @Fac.ComputeFac to i8*)]


define i32 @main (i8** %a) {

	%_0 = alloca i8*
	%_1 = load i8*, i8** %_0

	%_2 = add i32 8, 0
	%_3 = call i8* @calloc(i32 %_2, i32 1)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [1 x i8*], [1 x i8*]* @.Fac, i32 0, i32 0
	store i8** %_5, i8*** %_4
	
	store i8* %_3, i8** %_0

	%_6 = load i8*, i8** %_0
	%_7 = bitcast i8* %_6 to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 0
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*, i32)*
	%_13 = add i32 0, 10
	%_12 = call i32 %_11(i8* %_6, i32 %_13)
	call void (i32) @print_int(i32 %_12)

	ret i32 0
}


define i32 @Fac.ComputeFac(i8* %this, i32 %num) {
	%__num = alloca i32
	store i32 %num, i32* %__num

	%_0 = alloca i32
	store i32 0, i32* %_0
	%_1 = load i32, i32* %__num
	%_2 = add i32 0, 1

	%_3 = icmp slt i32 %_1, %_2

	br i1 %_3, label %if_then_0, label %if_else_0

	if_then_0:
	%_4 = load i32, i32* %_0
	%_5 = add i32 0, 1
	
	store i32 %_5, i32* %_0
	br label %if_end_0

	if_else_0:
	%_6 = load i32, i32* %_0
	%_7 = load i32, i32* %__num

	%_8 = bitcast i8* %this to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 0
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i32 (i8*, i32)*
	%_14 = load i32, i32* %__num
	%_15 = add i32 0, 1

	%_16 = sub i32 %_14, %_15
	%_13 = call i32 %_12(i8* %this, i32 %_16)

	%_17 = mul i32 %_7, %_13
	
	store i32 %_17, i32* %_0

	br label %if_end_0

	if_end_0:
	%_18 = load i32, i32* %_0
	ret i32 %_18
}
