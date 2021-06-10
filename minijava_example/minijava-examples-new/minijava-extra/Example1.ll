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


@.Example1 = global [0 x i8*] []

@.Test1 = global [1 x i8*] [i8* bitcast (i32 (i8*, i32, i1)* @Test1.Start to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 4
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [1 x i8*], [1 x i8*]* @.Test1, i32 0, i32 0
	store i8** %_3, i8*** %_2

	%_4 = bitcast i8* %_1 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*, i32, i1)*
	%_10 = add i32 0, 5
	%_11 = add i1 0, 1
	%_9 = call i32 %_8(i8* %_1, i32 %_10, i1 %_11)
	call void (i32) @print_int(i32 %_9)

	ret i32 0
}


define i32 @Test1.Start(i8* %this, i32 %b, i1 %c) {
	%__b = alloca i32
	store i32 %b, i32* %__b
	%__c = alloca i1
	store i1 %c, i1* %__c

	%_0 = alloca i1
	store i1 0, i1* %_0

	%_1 = alloca i32*

	%_2 = alloca i32
	store i32 0, i32* %_2
	%_3 = load i32*, i32** %_1
	%_4 = load i32, i32* %__b

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
	
	store i32* %_8, i32** %_1
	%_9 = load i32, i32* %_2
	%_10 = load i32*, i32** %_1
	%_11 = add i32 0, 0

	%_12 = load i32, i32* %_10
	%_13 = icmp slt i32 %_11, %_12
	%_14 = icmp slt i32 -1, %_11
	%_15 = xor i1 %_13, %_14
	br i1 %_15, label %indexing_error_1, label %indexing_ok_1
	indexing_error_1:
	call void @throw_oob()
	br label %indexing_ok_1
	indexing_ok_1:
	%_16 = add i32 %_11, 1
	%_17 = getelementptr i32, i32* %_10, i32 %_16
	%_18 = load i32, i32* %_17
	
	store i32 %_18, i32* %_2
	%_19 = load i32, i32* %_2
	call void (i32) @print_int(i32 %_19)
	%_20 = load i32*, i32** %_1
	%_21 = add i32 0, 0

	%_22 = load i32, i32* %_20
	%_23 = icmp slt i32 %_21, %_22
	%_24 = icmp slt i32 -1, %_21
	%_25 = xor i1 %_23, %_24
	br i1 %_25, label %indexing_error_2, label %indexing_ok_2
	indexing_error_2:
	call void @throw_oob()
	br label %indexing_ok_2
	indexing_ok_2:
	%_26 = add i32 %_21, 1
	%_27 = getelementptr i32, i32* %_20, i32 %_26
	%_28 = load i32, i32* %_27
	ret i32 %_28
}
