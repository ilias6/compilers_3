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


@.OutOfBounds1 = global [0 x i8*] []

@.A = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.run to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 0
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [1 x i8*], [1 x i8*]* @.A, i32 0, i32 0
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


define i32 @A.run(i8* %this) {

	%_0 = alloca i32*
	%_1 = load i32*, i32** %_0
	%_2 = add i32 0, 20

	%_3 = add i32 1, %_2
	%_4 = icmp sge i32 %_3, 1
	br i1 %_4, label %nsz_ok_0, label %nsz_err_0
	nsz_err_0:
	call void @throw_nsz()
	br label %nsz_ok_0
	nsz_ok_0:

	%_5 = call i8* @calloc(i32 %_3, i32 4)
	%_6 = bitcast i8* %_5 to i32*
	store i32 %_2, i32* %_6
	
	store i32* %_6, i32** %_0
	%_7 = load i32*, i32** %_0
	%_8 = add i32 0, 10

	%_9 = load i32, i32* %_7
	%_10 = icmp slt i32 %_8, %_9
	%_11 = icmp slt i32 -1, %_8
	%_12 = xor i1 %_10, %_11
	br i1 %_12, label %indexing_error_1, label %indexing_ok_1
	indexing_error_1:
	call void @throw_oob()
	br label %indexing_ok_1
	indexing_ok_1:
	%_13 = add i32 %_8, 1
	%_14 = getelementptr i32, i32* %_7, i32 %_13
	%_15 = load i32, i32* %_14
	call void (i32) @print_int(i32 %_15)
	%_16 = load i32*, i32** %_0
	%_17 = add i32 0, 40

	%_18 = load i32, i32* %_16
	%_19 = icmp slt i32 %_17, %_18
	%_20 = icmp slt i32 -1, %_17
	%_21 = xor i1 %_19, %_20
	br i1 %_21, label %indexing_error_2, label %indexing_ok_2
	indexing_error_2:
	call void @throw_oob()
	br label %indexing_ok_2
	indexing_ok_2:
	%_22 = add i32 %_17, 1
	%_23 = getelementptr i32, i32* %_16, i32 %_22
	%_24 = load i32, i32* %_23
	ret i32 %_24
}
