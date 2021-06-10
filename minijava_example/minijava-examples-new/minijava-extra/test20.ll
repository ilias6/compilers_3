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


@.test20 = global [0 x i8*] []

@.A23 = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @A23.init to i8*),
	i8* bitcast (i32 (i8*)* @A23.getI1 to i8*),
	i8* bitcast (i32 (i8*, i32)* @A23.setI1 to i8*)]

@.B23 = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @B23.init to i8*),
	i8* bitcast (i32 (i8*)* @B23.getI1 to i8*),
	i8* bitcast (i32 (i8*, i32)* @B23.setI1 to i8*)]

@.C23 = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @C23.init to i8*),
	i8* bitcast (i32 (i8*)* @C23.getI1 to i8*),
	i8* bitcast (i32 (i8*, i32)* @C23.setI1 to i8*)]


define i32 @main (i8** %args) {

	%_0 = add i32 8, 28
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [3 x i8*], [3 x i8*]* @.C23, i32 0, i32 0
	store i8** %_3, i8*** %_2

	%_4 = bitcast i8* %_1 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*, i8*)*

	%_10 = add i32 8, 20
	%_11 = call i8* @calloc(i32 %_10, i32 1)
	%_12 = bitcast i8* %_11 to i8***
	%_13 = getelementptr [3 x i8*], [3 x i8*]* @.B23, i32 0, i32 0
	store i8** %_13, i8*** %_12
	%_9 = call i32 %_8(i8* %_1, i8* %_11)
	call void (i32) @print_int(i32 %_9)

	ret i32 0
}


define i32 @A23.init(i8* %this, i8* %a) {
	%__a = alloca i8*
	store i8* %a, i8** %__a
	%_0 = getelementptr i8, i8* %this, i32 12
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1

	%_3 = load i8*, i8** %__a
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 1
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*)*
	%_9 = call i32 %_8(i8* %_3)
	
	store i32 %_9, i32* %_1
	%_10 = getelementptr i8, i8* %this, i32 16
	%_11 = bitcast i8* %_10 to i32*
	%_12 = load i32, i32* %_11
	%_13 = add i32 0, 222
	
	store i32 %_13, i32* %_11
	%_14 = getelementptr i8, i8* %this, i32 8
	%_15 = bitcast i8* %_14 to i32*
	%_16 = load i32, i32* %_15

	%_17 = bitcast i8* %this to i8***
	%_18 = load i8**, i8*** %_17
	%_19 = getelementptr i8*, i8** %_18, i32 2
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i32 (i8*, i32)*
	%_23 = getelementptr i8, i8* %this, i32 12
	%_24 = bitcast i8* %_23 to i32*
	%_25 = load i32, i32* %_24
	%_26 = getelementptr i8, i8* %this, i32 16
	%_27 = bitcast i8* %_26 to i32*
	%_28 = load i32, i32* %_27

	%_29 = add i32 %_25, %_28
	%_22 = call i32 %_21(i8* %this, i32 %_29)
	
	store i32 %_22, i32* %_15
	%_30 = getelementptr i8, i8* %this, i32 8
	%_31 = bitcast i8* %_30 to i32*
	%_32 = load i32, i32* %_31
	ret i32 %_32
}

define i32 @A23.getI1(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i32 @A23.setI1(i8* %this, i32 %i) {
	%__i = alloca i32
	store i32 %i, i32* %__i
	%_0 = load i32, i32* %__i
	ret i32 %_0
}

define i32 @B23.init(i8* %this, i8* %a) {
	%__a = alloca i8*
	store i8* %a, i8** %__a

	%_0 = alloca i8*
	%_1 = load i8*, i8** %_0

	%_2 = add i32 8, 12
	%_3 = call i8* @calloc(i32 %_2, i32 1)
	%_4 = bitcast i8* %_3 to i8***
	%_5 = getelementptr [3 x i8*], [3 x i8*]* @.A23, i32 0, i32 0
	store i8** %_5, i8*** %_4
	
	store i8* %_3, i8** %_0
	%_6 = getelementptr i8, i8* %this, i32 24
	%_7 = bitcast i8* %_6 to i32*
	%_8 = load i32, i32* %_7

	%_9 = load i8*, i8** %__a
	%_10 = bitcast i8* %_9 to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 1
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i32 (i8*)*
	%_15 = call i32 %_14(i8* %_9)
	
	store i32 %_15, i32* %_7
	%_16 = getelementptr i8, i8* %this, i32 20
	%_17 = bitcast i8* %_16 to i32*
	%_18 = load i32, i32* %_17

	%_19 = bitcast i8* %this to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 2
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*, i32)*
	%_25 = getelementptr i8, i8* %this, i32 24
	%_26 = bitcast i8* %_25 to i32*
	%_27 = load i32, i32* %_26
	%_24 = call i32 %_23(i8* %this, i32 %_27)
	
	store i32 %_24, i32* %_17

	%_28 = load i8*, i8** %_0
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 0
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i32 (i8*, i8*)*
	%_34 = call i32 %_33(i8* %_28, i8* %this)
	ret i32 %_34
}

define i32 @B23.getI1(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 20
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i32 @B23.setI1(i8* %this, i32 %i) {
	%__i = alloca i32
	store i32 %i, i32* %__i
	%_0 = load i32, i32* %__i
	%_1 = add i32 0, 111

	%_2 = add i32 %_0, %_1
	ret i32 %_2
}

define i32 @C23.init(i8* %this, i8* %a) {
	%__a = alloca i8*
	store i8* %a, i8** %__a
	%_0 = getelementptr i8, i8* %this, i32 32
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = add i32 0, 333
	
	store i32 %_3, i32* %_1
	%_4 = getelementptr i8, i8* %this, i32 28
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5

	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 2
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*, i32)*
	%_13 = getelementptr i8, i8* %this, i32 32
	%_14 = bitcast i8* %_13 to i32*
	%_15 = load i32, i32* %_14
	%_12 = call i32 %_11(i8* %this, i32 %_15)
	
	store i32 %_12, i32* %_5

	%_16 = load i8*, i8** %__a
	%_17 = bitcast i8* %_16 to i8***
	%_18 = load i8**, i8*** %_17
	%_19 = getelementptr i8*, i8** %_18, i32 0
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i32 (i8*, i8*)*
	%_22 = call i32 %_21(i8* %_16, i8* %this)
	ret i32 %_22
}

define i32 @C23.getI1(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 28
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i32 @C23.setI1(i8* %this, i32 %i) {
	%__i = alloca i32
	store i32 %i, i32* %__i
	%_0 = load i32, i32* %__i
	%_1 = add i32 0, 2

	%_2 = mul i32 %_0, %_1
	ret i32 %_2
}
