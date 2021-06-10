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


@.test07 = global [0 x i8*] []

@.Operator = global [1 x i8*] [i8* bitcast (i32 (i8*)* @Operator.compute to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 11
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [1 x i8*], [1 x i8*]* @.Operator, i32 0, i32 0
	store i8** %_3, i8*** %_2

	%_4 = bitcast i8* %_1 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*)*
	%_9 = call i32 %_8(i8* %_1)
	call void (i32) @print_int(i32 %_9)

	ret i32 0
}


define i32 @Operator.compute(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 10
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = add i32 0, 10
	
	store i32 %_3, i32* %_1
	%_4 = getelementptr i8, i8* %this, i32 14
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = add i32 0, 20
	
	store i32 %_7, i32* %_5
	%_8 = getelementptr i8, i8* %this, i32 18
	%_9 = bitcast i8* %_8 to i1*
	%_10 = load i1, i1* %_9
	%_11 = getelementptr i8, i8* %this, i32 10
	%_12 = bitcast i8* %_11 to i32*
	%_13 = load i32, i32* %_12
	%_14 = getelementptr i8, i8* %this, i32 14
	%_15 = bitcast i8* %_14 to i32*
	%_16 = load i32, i32* %_15

	%_17 = icmp slt i32 %_13, %_16
	
	store i1 %_17, i1* %_9
	%_18 = add i32 0, 0
	ret i32 %_18
}
