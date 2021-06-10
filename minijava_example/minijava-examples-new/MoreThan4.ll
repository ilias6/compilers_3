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


@.MoreThan4 = global [0 x i8*] []

@.MT4 = global [2 x i8*] [i8* bitcast (i32 (i8*, i32, i32, i32, i32, i32, i32)* @MT4.Start to i8*),
	i8* bitcast (i32 (i8*, i32, i32, i32, i32, i32, i32)* @MT4.Change to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 0
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [2 x i8*], [2 x i8*]* @.MT4, i32 0, i32 0
	store i8** %_3, i8*** %_2

	%_4 = bitcast i8* %_1 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*, i32, i32, i32, i32, i32, i32)*
	%_10 = add i32 0, 1
	%_11 = add i32 0, 2
	%_12 = add i32 0, 3
	%_13 = add i32 0, 4
	%_14 = add i32 0, 5
	%_15 = add i32 0, 6
	%_9 = call i32 %_8(i8* %_1, i32 %_10, i32 %_11, i32 %_12, i32 %_13, i32 %_14, i32 %_15)
	call void (i32) @print_int(i32 %_9)

	ret i32 0
}


define i32 @MT4.Start(i8* %this, i32 %p1, i32 %p2, i32 %p3, i32 %p4, i32 %p5, i32 %p6) {
	%__p1 = alloca i32
	store i32 %p1, i32* %__p1
	%__p2 = alloca i32
	store i32 %p2, i32* %__p2
	%__p3 = alloca i32
	store i32 %p3, i32* %__p3
	%__p4 = alloca i32
	store i32 %p4, i32* %__p4
	%__p5 = alloca i32
	store i32 %p5, i32* %__p5
	%__p6 = alloca i32
	store i32 %p6, i32* %__p6

	%_0 = alloca i32
	store i32 0, i32* %_0
	%_1 = load i32, i32* %__p1
	call void (i32) @print_int(i32 %_1)
	%_2 = load i32, i32* %__p2
	call void (i32) @print_int(i32 %_2)
	%_3 = load i32, i32* %__p3
	call void (i32) @print_int(i32 %_3)
	%_4 = load i32, i32* %__p4
	call void (i32) @print_int(i32 %_4)
	%_5 = load i32, i32* %__p5
	call void (i32) @print_int(i32 %_5)
	%_6 = load i32, i32* %__p6
	call void (i32) @print_int(i32 %_6)
	%_7 = load i32, i32* %_0

	%_8 = bitcast i8* %this to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 1
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i32 (i8*, i32, i32, i32, i32, i32, i32)*
	%_14 = load i32, i32* %__p6
	%_15 = load i32, i32* %__p5
	%_16 = load i32, i32* %__p4
	%_17 = load i32, i32* %__p3
	%_18 = load i32, i32* %__p2
	%_19 = load i32, i32* %__p1
	%_13 = call i32 %_12(i8* %this, i32 %_14, i32 %_15, i32 %_16, i32 %_17, i32 %_18, i32 %_19)
	
	store i32 %_13, i32* %_0
	%_20 = load i32, i32* %_0
	ret i32 %_20
}

define i32 @MT4.Change(i8* %this, i32 %p1, i32 %p2, i32 %p3, i32 %p4, i32 %p5, i32 %p6) {
	%__p1 = alloca i32
	store i32 %p1, i32* %__p1
	%__p2 = alloca i32
	store i32 %p2, i32* %__p2
	%__p3 = alloca i32
	store i32 %p3, i32* %__p3
	%__p4 = alloca i32
	store i32 %p4, i32* %__p4
	%__p5 = alloca i32
	store i32 %p5, i32* %__p5
	%__p6 = alloca i32
	store i32 %p6, i32* %__p6
	%_0 = load i32, i32* %__p1
	call void (i32) @print_int(i32 %_0)
	%_1 = load i32, i32* %__p2
	call void (i32) @print_int(i32 %_1)
	%_2 = load i32, i32* %__p3
	call void (i32) @print_int(i32 %_2)
	%_3 = load i32, i32* %__p4
	call void (i32) @print_int(i32 %_3)
	%_4 = load i32, i32* %__p5
	call void (i32) @print_int(i32 %_4)
	%_5 = load i32, i32* %__p6
	call void (i32) @print_int(i32 %_5)
	%_6 = add i32 0, 0
	ret i32 %_6
}
