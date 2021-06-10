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


@.test15 = global [0 x i8*] []

@.Test = global [3 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i32 (i8*)* @Test.mutual1 to i8*),
	i8* bitcast (i32 (i8*)* @Test.mutual2 to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 8
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [3 x i8*], [3 x i8*]* @.Test, i32 0, i32 0
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


define i32 @Test.start(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = add i32 0, 4
	
	store i32 %_3, i32* %_1
	%_4 = getelementptr i8, i8* %this, i32 12
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = add i32 0, 0
	
	store i32 %_7, i32* %_5

	%_8 = bitcast i8* %this to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 1
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i32 (i8*)*
	%_13 = call i32 %_12(i8* %this)
	ret i32 %_13
}

define i32 @Test.mutual1(i8* %this) {

	%_0 = alloca i32
	store i32 0, i32* %_0
	%_1 = getelementptr i8, i8* %this, i32 8
	%_2 = bitcast i8* %_1 to i32*
	%_3 = load i32, i32* %_2
	%_4 = getelementptr i8, i8* %this, i32 8
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = add i32 0, 1

	%_8 = sub i32 %_6, %_7
	
	store i32 %_8, i32* %_2
	%_9 = getelementptr i8, i8* %this, i32 8
	%_10 = bitcast i8* %_9 to i32*
	%_11 = load i32, i32* %_10
	%_12 = add i32 0, 0

	%_13 = icmp slt i32 %_11, %_12

	br i1 %_13, label %if_then_0, label %if_else_0

	if_then_0:
	%_14 = getelementptr i8, i8* %this, i32 12
	%_15 = bitcast i8* %_14 to i32*
	%_16 = load i32, i32* %_15
	%_17 = add i32 0, 0
	
	store i32 %_17, i32* %_15
	br label %if_end_0

	if_else_0:
	%_18 = getelementptr i8, i8* %this, i32 12
	%_19 = bitcast i8* %_18 to i32*
	%_20 = load i32, i32* %_19
	call void (i32) @print_int(i32 %_20)
	%_21 = getelementptr i8, i8* %this, i32 12
	%_22 = bitcast i8* %_21 to i32*
	%_23 = load i32, i32* %_22
	%_24 = add i32 0, 1
	
	store i32 %_24, i32* %_22
	%_25 = load i32, i32* %_0

	%_26 = bitcast i8* %this to i8***
	%_27 = load i8**, i8*** %_26
	%_28 = getelementptr i8*, i8** %_27, i32 2
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i32 (i8*)*
	%_31 = call i32 %_30(i8* %this)
	
	store i32 %_31, i32* %_0

	br label %if_end_0

	if_end_0:
	%_32 = getelementptr i8, i8* %this, i32 12
	%_33 = bitcast i8* %_32 to i32*
	%_34 = load i32, i32* %_33
	ret i32 %_34
}

define i32 @Test.mutual2(i8* %this) {

	%_0 = alloca i32
	store i32 0, i32* %_0
	%_1 = getelementptr i8, i8* %this, i32 8
	%_2 = bitcast i8* %_1 to i32*
	%_3 = load i32, i32* %_2
	%_4 = getelementptr i8, i8* %this, i32 8
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = add i32 0, 1

	%_8 = sub i32 %_6, %_7
	
	store i32 %_8, i32* %_2
	%_9 = getelementptr i8, i8* %this, i32 8
	%_10 = bitcast i8* %_9 to i32*
	%_11 = load i32, i32* %_10
	%_12 = add i32 0, 0

	%_13 = icmp slt i32 %_11, %_12

	br i1 %_13, label %if_then_0, label %if_else_0

	if_then_0:
	%_14 = getelementptr i8, i8* %this, i32 12
	%_15 = bitcast i8* %_14 to i32*
	%_16 = load i32, i32* %_15
	%_17 = add i32 0, 0
	
	store i32 %_17, i32* %_15
	br label %if_end_0

	if_else_0:
	%_18 = getelementptr i8, i8* %this, i32 12
	%_19 = bitcast i8* %_18 to i32*
	%_20 = load i32, i32* %_19
	call void (i32) @print_int(i32 %_20)
	%_21 = getelementptr i8, i8* %this, i32 12
	%_22 = bitcast i8* %_21 to i32*
	%_23 = load i32, i32* %_22
	%_24 = add i32 0, 0
	
	store i32 %_24, i32* %_22
	%_25 = load i32, i32* %_0

	%_26 = bitcast i8* %this to i8***
	%_27 = load i8**, i8*** %_26
	%_28 = getelementptr i8*, i8** %_27, i32 1
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i32 (i8*)*
	%_31 = call i32 %_30(i8* %this)
	
	store i32 %_31, i32* %_0

	br label %if_end_0

	if_end_0:
	%_32 = getelementptr i8, i8* %this, i32 12
	%_33 = bitcast i8* %_32 to i32*
	%_34 = load i32, i32* %_33
	ret i32 %_34
}
