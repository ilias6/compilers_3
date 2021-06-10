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


@.Main = global [0 x i8*] []

@.ArrayTest = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @ArrayTest.test to i8*)]

@.B = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @B.test to i8*)]


define i32 @main (i8** %a) {

	%_0 = alloca i8*
	%_1 = load i8*, i8** %_0

	%_2 = add i32 8, 12
	%_3 = call i8* @calloc(i32 %_2, i32 1)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [1 x i8*], [1 x i8*]* @.ArrayTest, i32 0, i32 0
	store i8** %_5, i8*** %_4
	
	store i8* %_3, i8** %_0

	%_6 = load i8*, i8** %_0
	%_7 = bitcast i8* %_6 to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 0
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*, i32)*
	%_13 = add i32 0, 3
	%_12 = call i32 %_11(i8* %_6, i32 %_13)
	call void (i32) @print_int(i32 %_12)

	ret i32 0
}


define i32 @ArrayTest.test(i8* %this, i32 %num) {
	%__num = alloca i32
	store i32 %num, i32* %__num

	%_0 = alloca i32
	store i32 0, i32* %_0

	%_1 = alloca i32*
	%_2 = load i32*, i32** %_1
	%_3 = load i32, i32* %__num

	%_4 = add i32 1, %_3
	%_5 = icmp sge i32 %_4, 1
	br i1 %_5, label %nsz_ok_0, label %nsz_err_0
	nsz_err_0:
	call void @throw_nsz()
	br label %nsz_ok_0
	nsz_ok_0:

	%_6 = call i8* @calloc(i32 %_4, i32 4)
	%_7 = bitcast i8* %_6 to i32*
	store i32 %_3, i32* %_7
	
	store i32* %_7, i32** %_1
	%_8 = getelementptr i8, i8* %this, i32 16
	%_9 = bitcast i8* %_8 to i32*
	%_10 = load i32, i32* %_9
	%_11 = add i32 0, 0
	
	store i32 %_11, i32* %_9
	%_12 = getelementptr i8, i8* %this, i32 16
	%_13 = bitcast i8* %_12 to i32*
	%_14 = load i32, i32* %_13
	call void (i32) @print_int(i32 %_14)
	%_15 = load i32*, i32** %_1

	%_16 = load i32, i32* %_15
	call void (i32) @print_int(i32 %_16)
	%_17 = load i32, i32* %_0
	%_18 = add i32 0, 0
	
	store i32 %_18, i32* %_0
	%_19 = add i32 0, 111
	call void (i32) @print_int(i32 %_19)

	br label %while_1
	while_1:
	%_20 = load i32, i32* %_0
	%_21 = load i32*, i32** %_1

	%_22 = load i32, i32* %_21

	%_23 = icmp slt i32 %_20, %_22
	br i1 %_23, label %continue_1, label %while_end_1
	continue_1:
	%_24 = load i32, i32* %_0
	%_25 = add i32 0, 1

	%_26 = add i32 %_24, %_25
	call void (i32) @print_int(i32 %_26)
	%_27 = load i32*, i32** %_1
	%_28 = load i32, i32* %_0
	%_29 = load i32, i32* %_0
	%_30 = add i32 0, 1

	%_31 = add i32 %_29, %_30
	%_32 = load i32, i32* %_27
	%_33 = icmp slt i32 %_28, %_32
	%_34 = icmp slt i32 -1, %_28
	%_35 = xor i1 %_33, %_34
	br i1 %_35, label %indexing_error_2, label %indexing_ok_2
	indexing_error_2:
	call void @throw_oob()
	br label %indexing_ok_2
	indexing_ok_2:
	%_36 = add i32 %_28, 1
	%_37 = getelementptr i32, i32* %_27, i32 %_36
	store i32 %_31, i32* %_37
	%_38 = load i32, i32* %_0
	%_39 = load i32, i32* %_0
	%_40 = add i32 0, 1

	%_41 = add i32 %_39, %_40
	
	store i32 %_41, i32* %_0
	br label %while_1

	while_end_1:
	%_42 = add i32 0, 222
	call void (i32) @print_int(i32 %_42)
	%_43 = load i32, i32* %_0
	%_44 = add i32 0, 0
	
	store i32 %_44, i32* %_0

	br label %while_3
	while_3:
	%_45 = load i32, i32* %_0
	%_46 = load i32*, i32** %_1

	%_47 = load i32, i32* %_46

	%_48 = icmp slt i32 %_45, %_47
	br i1 %_48, label %continue_3, label %while_end_3
	continue_3:
	%_49 = load i32*, i32** %_1
	%_50 = load i32, i32* %_0

	%_51 = load i32, i32* %_49
	%_52 = icmp slt i32 %_50, %_51
	%_53 = icmp slt i32 -1, %_50
	%_54 = xor i1 %_52, %_53
	br i1 %_54, label %indexing_error_4, label %indexing_ok_4
	indexing_error_4:
	call void @throw_oob()
	br label %indexing_ok_4
	indexing_ok_4:
	%_55 = add i32 %_50, 1
	%_56 = getelementptr i32, i32* %_49, i32 %_55
	%_57 = load i32, i32* %_56
	call void (i32) @print_int(i32 %_57)
	%_58 = load i32, i32* %_0
	%_59 = load i32, i32* %_0
	%_60 = add i32 0, 1

	%_61 = add i32 %_59, %_60
	
	store i32 %_61, i32* %_0
	br label %while_3

	while_end_3:
	%_62 = add i32 0, 333
	call void (i32) @print_int(i32 %_62)
	%_63 = load i32*, i32** %_1

	%_64 = load i32, i32* %_63
	ret i32 %_64
}

define i32 @B.test(i8* %this, i32 %num) {
	%__num = alloca i32
	store i32 %num, i32* %__num

	%_0 = alloca i32
	store i32 0, i32* %_0

	%_1 = alloca i32*
	%_2 = load i32*, i32** %_1
	%_3 = load i32, i32* %__num

	%_4 = add i32 1, %_3
	%_5 = icmp sge i32 %_4, 1
	br i1 %_5, label %nsz_ok_0, label %nsz_err_0
	nsz_err_0:
	call void @throw_nsz()
	br label %nsz_ok_0
	nsz_ok_0:

	%_6 = call i8* @calloc(i32 %_4, i32 4)
	%_7 = bitcast i8* %_6 to i32*
	store i32 %_3, i32* %_7
	
	store i32* %_7, i32** %_1
	%_8 = getelementptr i8, i8* %this, i32 20
	%_9 = bitcast i8* %_8 to i32*
	%_10 = load i32, i32* %_9
	%_11 = add i32 0, 12
	
	store i32 %_11, i32* %_9
	%_12 = getelementptr i8, i8* %this, i32 20
	%_13 = bitcast i8* %_12 to i32*
	%_14 = load i32, i32* %_13
	call void (i32) @print_int(i32 %_14)
	%_15 = load i32*, i32** %_1

	%_16 = load i32, i32* %_15
	call void (i32) @print_int(i32 %_16)
	%_17 = load i32, i32* %_0
	%_18 = add i32 0, 0
	
	store i32 %_18, i32* %_0
	%_19 = add i32 0, 111
	call void (i32) @print_int(i32 %_19)

	br label %while_1
	while_1:
	%_20 = load i32, i32* %_0
	%_21 = load i32*, i32** %_1

	%_22 = load i32, i32* %_21

	%_23 = icmp slt i32 %_20, %_22
	br i1 %_23, label %continue_1, label %while_end_1
	continue_1:
	%_24 = load i32, i32* %_0
	%_25 = add i32 0, 1

	%_26 = add i32 %_24, %_25
	call void (i32) @print_int(i32 %_26)
	%_27 = load i32*, i32** %_1
	%_28 = load i32, i32* %_0
	%_29 = load i32, i32* %_0
	%_30 = add i32 0, 1

	%_31 = add i32 %_29, %_30
	%_32 = load i32, i32* %_27
	%_33 = icmp slt i32 %_28, %_32
	%_34 = icmp slt i32 -1, %_28
	%_35 = xor i1 %_33, %_34
	br i1 %_35, label %indexing_error_2, label %indexing_ok_2
	indexing_error_2:
	call void @throw_oob()
	br label %indexing_ok_2
	indexing_ok_2:
	%_36 = add i32 %_28, 1
	%_37 = getelementptr i32, i32* %_27, i32 %_36
	store i32 %_31, i32* %_37
	%_38 = load i32, i32* %_0
	%_39 = load i32, i32* %_0
	%_40 = add i32 0, 1

	%_41 = add i32 %_39, %_40
	
	store i32 %_41, i32* %_0
	br label %while_1

	while_end_1:
	%_42 = add i32 0, 222
	call void (i32) @print_int(i32 %_42)
	%_43 = load i32, i32* %_0
	%_44 = add i32 0, 0
	
	store i32 %_44, i32* %_0

	br label %while_3
	while_3:
	%_45 = load i32, i32* %_0
	%_46 = load i32*, i32** %_1

	%_47 = load i32, i32* %_46

	%_48 = icmp slt i32 %_45, %_47
	br i1 %_48, label %continue_3, label %while_end_3
	continue_3:
	%_49 = load i32*, i32** %_1
	%_50 = load i32, i32* %_0

	%_51 = load i32, i32* %_49
	%_52 = icmp slt i32 %_50, %_51
	%_53 = icmp slt i32 -1, %_50
	%_54 = xor i1 %_52, %_53
	br i1 %_54, label %indexing_error_4, label %indexing_ok_4
	indexing_error_4:
	call void @throw_oob()
	br label %indexing_ok_4
	indexing_ok_4:
	%_55 = add i32 %_50, 1
	%_56 = getelementptr i32, i32* %_49, i32 %_55
	%_57 = load i32, i32* %_56
	call void (i32) @print_int(i32 %_57)
	%_58 = load i32, i32* %_0
	%_59 = load i32, i32* %_0
	%_60 = add i32 0, 1

	%_61 = add i32 %_59, %_60
	
	store i32 %_61, i32* %_0
	br label %while_3

	while_end_3:
	%_62 = add i32 0, 333
	call void (i32) @print_int(i32 %_62)
	%_63 = load i32*, i32** %_1

	%_64 = load i32, i32* %_63
	ret i32 %_64
}
