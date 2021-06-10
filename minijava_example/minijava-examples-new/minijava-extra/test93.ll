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


@.test93 = global [0 x i8*] []

@.Test = global [2 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i8* (i8*)* @Test.next to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 16
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [2 x i8*], [2 x i8*]* @.Test, i32 0, i32 0
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
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i32**
	%_2 = load i32*, i32** %_1
	%_3 = add i32 0, 10

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
	%_8 = getelementptr i8, i8* %this, i32 8
	%_9 = bitcast i8* %_8 to i8**
	%_10 = load i8*, i8** %_9

	%_11 = add i32 8, 16
	%_12 = call i8* @calloc(i32 %_11, i32 1)
	%_13 = bitcast i8* %_12 to i8***
	%_14 = getelementptr [2 x i8*], [2 x i8*]* @.Test, i32 0, i32 0
	store i8** %_14, i8*** %_13
	
	store i8* %_12, i8** %_9
	%_15 = getelementptr i8, i8* %this, i32 8
	%_16 = bitcast i8* %_15 to i8**
	%_17 = load i8*, i8** %_16

	%_18 = load i8*, i8** %_16
	%_19 = bitcast i8* %_18 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 1
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i8* (i8*)*
	%_24 = call i8* %_23(i8* %_18)

	%_25 = bitcast i8* %_24 to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 1
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i8* (i8*)*
	%_30 = call i8* %_29(i8* %_24)
	
	store i8* %_30, i8** %_16
	%_31 = add i32 0, 0
	ret i32 %_31
}

define i8* @Test.next(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1

	%_3 = add i32 8, 16
	%_4 = call i8* @calloc(i32 %_3, i32 1)
	%_5 = bitcast i8* %_4 to i8***
	%_6 = getelementptr [2 x i8*], [2 x i8*]* @.Test, i32 0, i32 0
	store i8** %_6, i8*** %_5
	
	store i8* %_4, i8** %_1
	%_7 = getelementptr i8, i8* %this, i32 8
	%_8 = bitcast i8* %_7 to i8**
	%_9 = load i8*, i8** %_8
	ret i8* %_9
}
