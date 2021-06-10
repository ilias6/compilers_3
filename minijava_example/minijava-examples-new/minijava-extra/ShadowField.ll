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


@.ShadowField = global [0 x i8*] []

@.A = global [2 x i8*] [i8* bitcast (i8* (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*)* @A.get to i8*)]


define i32 @main (i8** %args) {

	%_0 = alloca i8*
	%_1 = load i8*, i8** %_0

	%_2 = add i32 8, 4
	%_3 = call i8* @calloc(i32 %_2, i32 1)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [2 x i8*], [2 x i8*]* @.A, i32 0, i32 0
	store i8** %_5, i8*** %_4
	
	store i8* %_3, i8** %_0
	%_6 = load i8*, i8** %_0

	%_7 = load i8*, i8** %_0
	%_8 = bitcast i8* %_7 to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 0
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i8* (i8*)*
	%_13 = call i8* %_12(i8* %_7)
	
	store i8* %_13, i8** %_0

	%_14 = load i8*, i8** %_0
	%_15 = bitcast i8* %_14 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 1
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i32 (i8*)*
	%_20 = call i32 %_19(i8* %_14)
	call void (i32) @print_int(i32 %_20)

	ret i32 0
}


define i8* @A.foo(i8* %this) {

	%_0 = alloca i8*
	%_1 = load i8*, i8** %_0

	%_2 = add i32 8, 4
	%_3 = call i8* @calloc(i32 %_2, i32 1)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [2 x i8*], [2 x i8*]* @.A, i32 0, i32 0
	store i8** %_5, i8*** %_4
	
	store i8* %_3, i8** %_0
	%_6 = load i8*, i8** %_0
	ret i8* %_6
}

define i32 @A.get(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}
