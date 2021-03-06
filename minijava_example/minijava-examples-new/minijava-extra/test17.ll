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


@.test17 = global [0 x i8*] []

@.Test = global [3 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i8* (i8*, i8*)* @Test.first to i8*),
	i8* bitcast (i32 (i8*)* @Test.second to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 4
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

	%_0 = alloca i8*
	%_1 = load i8*, i8** %_0

	%_2 = add i32 8, 4
	%_3 = call i8* @calloc(i32 %_2, i32 1)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [3 x i8*], [3 x i8*]* @.Test, i32 0, i32 0
	store i8** %_5, i8*** %_4
	
	store i8* %_3, i8** %_0
	%_6 = getelementptr i8, i8* %this, i32 8
	%_7 = bitcast i8* %_6 to i32*
	%_8 = load i32, i32* %_7
	%_9 = add i32 0, 10
	
	store i32 %_9, i32* %_7
	%_10 = getelementptr i8, i8* %this, i32 8
	%_11 = bitcast i8* %_10 to i32*
	%_12 = load i32, i32* %_11
	%_13 = getelementptr i8, i8* %this, i32 8
	%_14 = bitcast i8* %_13 to i32*
	%_15 = load i32, i32* %_14

	%_16 = load i8*, i8** %_0
	%_17 = bitcast i8* %_16 to i8***
	%_18 = load i8**, i8*** %_17
	%_19 = getelementptr i8*, i8** %_18, i32 1
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i8* (i8*, i8*)*
	%_22 = call i8* %_21(i8* %_16, i8* %this)

	%_23 = bitcast i8* %_22 to i8***
	%_24 = load i8**, i8*** %_23
	%_25 = getelementptr i8*, i8** %_24, i32 2
	%_26 = load i8*, i8** %_25
	%_27 = bitcast i8* %_26 to i32 (i8*)*
	%_28 = call i32 %_27(i8* %_22)

	%_29 = add i32 %_15, %_28
	
	store i32 %_29, i32* %_11
	%_30 = getelementptr i8, i8* %this, i32 8
	%_31 = bitcast i8* %_30 to i32*
	%_32 = load i32, i32* %_31
	ret i32 %_32
}

define i8* @Test.first(i8* %this, i8* %test2) {
	%__test2 = alloca i8*
	store i8* %test2, i8** %__test2

	%_0 = alloca i8*
	%_1 = load i8*, i8** %_0
	%_2 = load i8*, i8** %__test2
	
	store i8* %_2, i8** %_0
	%_3 = load i8*, i8** %_0
	ret i8* %_3
}

define i32 @Test.second(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = getelementptr i8, i8* %this, i32 8
	%_4 = bitcast i8* %_3 to i32*
	%_5 = load i32, i32* %_4
	%_6 = add i32 0, 10

	%_7 = add i32 %_5, %_6
	
	store i32 %_7, i32* %_1
	%_8 = getelementptr i8, i8* %this, i32 8
	%_9 = bitcast i8* %_8 to i32*
	%_10 = load i32, i32* %_9
	ret i32 %_10
}
