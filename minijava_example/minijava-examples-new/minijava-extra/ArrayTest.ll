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


@.ArrayTest = global [0 x i8*] []

@.Test = global [1 x i8*] [i8* bitcast (i1 (i8*, i32)* @Test.start to i8*)]


define i32 @main (i8** %a) {

	%_0 = alloca i1
	store i1 0, i1* %_0
	%_1 = load i1, i1* %_0

	%_2 = add i32 8, 0
	%_3 = call i8* @calloc(i32 %_2, i32 1)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [1 x i8*], [1 x i8*]* @.Test, i32 0, i32 0
	store i8** %_5, i8*** %_4

	%_6 = bitcast i8* %_3 to i8***
	%_7 = load i8**, i8*** %_6
	%_8 = getelementptr i8*, i8** %_7, i32 0
	%_9 = load i8*, i8** %_8
	%_10 = bitcast i8* %_9 to i1 (i8*, i32)*
	%_12 = add i32 0, 10
	%_11 = call i1 %_10(i8* %_3, i32 %_12)
	
	store i1 %_11, i1* %_0

	ret i32 0
}


define i1 @Test.start(i8* %this, i32 %sz) {
	%__sz = alloca i32
	store i32 %sz, i32* %__sz

	%_0 = alloca i32*

	%_1 = alloca i32
	store i32 0, i32* %_1

	%_2 = alloca i32
	store i32 0, i32* %_2
	%_3 = load i32*, i32** %_0
	%_4 = load i32, i32* %__sz

	%_5 = add i32 1, %_4
	%_6 = icmp sge i32 %_5, 1
	br i1 %_6, label %nsz_ok_0, label %nsz_err_0
	nsz_err_0:
	call void @throw_nsz()
	br label %nsz_ok_0
	nsz_ok_0:

	%_7 = call i8* @calloc(i32 %_5, i32 4)
	%_8 = bitcast i8* %_7 to i32*
	store i32 %_4, i32* %_8
	
	store i32* %_8, i32** %_0
	%_9 = load i32, i32* %_1
	%_10 = load i32*, i32** %_0

	%_11 = load i32, i32* %_10
	
	store i32 %_11, i32* %_1
	%_12 = load i32, i32* %_2
	%_13 = add i32 0, 0
	
	store i32 %_13, i32* %_2

	br label %while_1
	while_1:
	%_14 = load i32, i32* %_2
	%_15 = load i32, i32* %_1

	%_16 = icmp slt i32 %_14, %_15
	br i1 %_16, label %continue_1, label %while_end_1
	continue_1:
	%_17 = load i32*, i32** %_0
	%_18 = load i32, i32* %_2
	%_19 = load i32, i32* %_2
	%_20 = load i32, i32* %_17
	%_21 = icmp slt i32 %_18, %_20
	%_22 = icmp slt i32 -1, %_18
	%_23 = xor i1 %_21, %_22
	br i1 %_23, label %indexing_error_2, label %indexing_ok_2
	indexing_error_2:
	call void @throw_oob()
	br label %indexing_ok_2
	indexing_ok_2:
	%_24 = add i32 %_18, 1
	%_25 = getelementptr i32, i32* %_17, i32 %_24
	store i32 %_19, i32* %_25
	%_26 = load i32*, i32** %_0
	%_27 = load i32, i32* %_2

	%_28 = load i32, i32* %_26
	%_29 = icmp slt i32 %_27, %_28
	%_30 = icmp slt i32 -1, %_27
	%_31 = xor i1 %_29, %_30
	br i1 %_31, label %indexing_error_3, label %indexing_ok_3
	indexing_error_3:
	call void @throw_oob()
	br label %indexing_ok_3
	indexing_ok_3:
	%_32 = add i32 %_27, 1
	%_33 = getelementptr i32, i32* %_26, i32 %_32
	%_34 = load i32, i32* %_33
	call void (i32) @print_int(i32 %_34)
	%_35 = load i32, i32* %_2
	%_36 = load i32, i32* %_2
	%_37 = add i32 0, 1

	%_38 = add i32 %_36, %_37
	
	store i32 %_38, i32* %_2
	br label %while_1

	while_end_1:
	%_39 = add i1 0, 1
	ret i1 %_39
}
