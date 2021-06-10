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


@.CallFromSuper = global [0 x i8*] []

@.A = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*)]

@.B = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.foo to i8*)]


define i32 @main (i8** %args) {

	%_0 = alloca i8*

	%_1 = alloca i32
	store i32 0, i32* %_1
	%_2 = load i8*, i8** %_0

	%_3 = add i32 8, 0
	%_4 = call i8* @calloc(i32 %_3, i32 1)
	%_5 = bitcast i8* %_4 to i8***
	%_6 = getelementptr [1 x i8*], [1 x i8*]* @.B, i32 0, i32 0
	store i8** %_6, i8*** %_5
	
	store i8* %_4, i8** %_0
	%_7 = load i32, i32* %_1

	%_8 = load i8*, i8** %_0
	%_9 = bitcast i8* %_8 to i8***
	%_10 = load i8**, i8*** %_9
	%_11 = getelementptr i8*, i8** %_10, i32 0
	%_12 = load i8*, i8** %_11
	%_13 = bitcast i8* %_12 to i32 (i8*)*
	%_14 = call i32 %_13(i8* %_8)
	
	store i32 %_14, i32* %_1
	%_15 = load i32, i32* %_1
	call void (i32) @print_int(i32 %_15)

	ret i32 0
}


define i32 @A.foo(i8* %this) {
	%_0 = add i32 0, 1
	ret i32 %_0
}
