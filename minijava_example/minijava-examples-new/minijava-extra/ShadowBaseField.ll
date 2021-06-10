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


@.ShadowBaseField = global [0 x i8*] []

@.A = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.getX to i8*)]

@.B = global [1 x i8*] [i8* bitcast (i32 (i8*)* @B.getX to i8*)]


define i32 @main (i8** %args) {

	%_0 = alloca i8*
	%_1 = load i8*, i8** %_0

	%_2 = add i32 8, 4
	%_3 = call i8* @calloc(i32 %_2, i32 1)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [1 x i8*], [1 x i8*]* @.A, i32 0, i32 0
	store i8** %_5, i8*** %_4
	
	store i8* %_3, i8** %_0

	%_6 = load i8*, i8** %_0
	%_7 = bitcast i8* %_6 to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 0
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %_6)
	call void (i32) @print_int(i32 %_12)
	%_13 = load i8*, i8** %_0

	%_14 = add i32 8, 8
	%_15 = call i8* @calloc(i32 %_14, i32 1)
	%_16 = bitcast i8* %_15 to i8***
	%_17 = getelementptr [1 x i8*], [1 x i8*]* @.B, i32 0, i32 0
	store i8** %_17, i8*** %_16
	
	store i8* %_15, i8** %_0

	%_18 = load i8*, i8** %_0
	%_19 = bitcast i8* %_18 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 0
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*)*
	%_24 = call i32 %_23(i8* %_18)
	call void (i32) @print_int(i32 %_24)

	ret i32 0
}


define i32 @A.getX(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i32 @B.getX(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 12
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = add i32 0, 1
	
	store i32 %_3, i32* %_1
	%_4 = getelementptr i8, i8* %this, i32 12
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	ret i32 %_6
}
