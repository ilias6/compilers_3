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


@.test99 = global [0 x i8*] []

@.Test = global [2 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i32 (i8*, i8*)* @Test.next to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 12
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
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1

	%_3 = add i32 8, 12
	%_4 = call i8* @calloc(i32 %_3, i32 1)
	%_5 = bitcast i8* %_4 to i8***
	%_6 = getelementptr [2 x i8*], [2 x i8*]* @.Test, i32 0, i32 0
	store i8** %_6, i8*** %_5
	
	store i8* %_4, i8** %_1
	%_7 = getelementptr i8, i8* %this, i32 16
	%_8 = bitcast i8* %_7 to i32*
	%_9 = load i32, i32* %_8

	%_10 = load i8*, i8** %_1
	%_11 = bitcast i8* %_10 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 1
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i32 (i8*, i8*)*
	%_16 = call i32 %_15(i8* %_10, i8* %this)
	
	store i32 %_16, i32* %_8
	%_17 = add i32 0, 0
	ret i32 %_17
}

define i32 @Test.next(i8* %this, i8* %t) {
	%__t = alloca i8*
	store i8* %t, i8** %__t
	%_0 = add i32 0, 0
	ret i32 %_0
}
