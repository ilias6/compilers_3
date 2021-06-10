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


@.DerivedCall = global [0 x i8*] []

@.A = global [0 x i8*] []

@.B = global [0 x i8*] []

@.F = global [1 x i8*] [i8* bitcast (i32 (i8*, i8*)* @F.foo to i8*)]


define i32 @main (i8** %x) {

	%_0 = alloca i32
	store i32 0, i32* %_0

	%_1 = alloca i8*

	%_2 = alloca i8*
	%_3 = load i8*, i8** %_2

	%_4 = add i32 8, 0
	%_5 = call i8* @calloc(i32 %_4, i32 1)
	%_6 = bitcast i8* %_5 to i8***
	%_7 = getelementptr [1 x i8*], [1 x i8*]* @.F, i32 0, i32 0
	store i8** %_7, i8*** %_6
	
	store i8* %_5, i8** %_2
	%_8 = load i8*, i8** %_1

	%_9 = add i32 8, 8
	%_10 = call i8* @calloc(i32 %_9, i32 1)
	%_11 = bitcast i8* %_10 to i8***
	%_12 = getelementptr [0 x i8*], [0 x i8*]* @.B, i32 0, i32 0
	store i8** %_12, i8*** %_11
	
	store i8* %_10, i8** %_1
	%_13 = load i32, i32* %_0

	%_14 = load i8*, i8** %_2
	%_15 = bitcast i8* %_14 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 0
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i32 (i8*, i8*)*
	%_21 = load i8*, i8** %_1
	%_20 = call i32 %_19(i8* %_14, i8* %_21)
	
	store i32 %_20, i32* %_0
	%_22 = load i32, i32* %_0
	call void (i32) @print_int(i32 %_22)

	ret i32 0
}


define i32 @F.foo(i8* %this, i8* %a) {
	%__a = alloca i8*
	store i8* %a, i8** %__a
	%_0 = add i32 0, 0
	ret i32 %_0
}
