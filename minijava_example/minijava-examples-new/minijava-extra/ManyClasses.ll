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


@.ManyClasses = global [0 x i8*] []

@.A = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.get to i8*)]

@.B = global [2 x i8*] [i8* bitcast (i32 (i8*)* @A.get to i8*),
	i8* bitcast (i1 (i8*)* @B.set to i8*)]

@.C = global [3 x i8*] [i8* bitcast (i32 (i8*)* @A.get to i8*),
	i8* bitcast (i1 (i8*)* @B.set to i8*),
	i8* bitcast (i1 (i8*)* @C.reset to i8*)]


define i32 @main (i8** %x) {

	%_0 = alloca i1
	store i1 0, i1* %_0

	%_1 = alloca i8*

	%_2 = alloca i8*

	%_3 = alloca i8*
	%_4 = load i8*, i8** %_2

	%_5 = add i32 8, 1
	%_6 = call i8* @calloc(i32 %_5, i32 1)
	%_7 = bitcast i8* %_6 to i8***
	%_8 = getelementptr [2 x i8*], [2 x i8*]* @.B, i32 0, i32 0
	store i8** %_8, i8*** %_7
	
	store i8* %_6, i8** %_2
	%_9 = load i8*, i8** %_3

	%_10 = add i32 8, 1
	%_11 = call i8* @calloc(i32 %_10, i32 1)
	%_12 = bitcast i8* %_11 to i8***
	%_13 = getelementptr [3 x i8*], [3 x i8*]* @.C, i32 0, i32 0
	store i8** %_13, i8*** %_12
	
	store i8* %_11, i8** %_3
	%_14 = load i1, i1* %_0

	%_15 = load i8*, i8** %_2
	%_16 = bitcast i8* %_15 to i8***
	%_17 = load i8**, i8*** %_16
	%_18 = getelementptr i8*, i8** %_17, i32 1
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i1 (i8*)*
	%_21 = call i1 %_20(i8* %_15)
	
	store i1 %_21, i1* %_0
	%_22 = load i1, i1* %_0

	%_23 = load i8*, i8** %_3
	%_24 = bitcast i8* %_23 to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 2
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i1 (i8*)*
	%_29 = call i1 %_28(i8* %_23)
	
	store i1 %_29, i1* %_0

	%_30 = load i8*, i8** %_2
	%_31 = bitcast i8* %_30 to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 0
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i32 (i8*)*
	%_36 = call i32 %_35(i8* %_30)
	call void (i32) @print_int(i32 %_36)

	%_37 = load i8*, i8** %_3
	%_38 = bitcast i8* %_37 to i8***
	%_39 = load i8**, i8*** %_38
	%_40 = getelementptr i8*, i8** %_39, i32 0
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i32 (i8*)*
	%_43 = call i32 %_42(i8* %_37)
	call void (i32) @print_int(i32 %_43)

	ret i32 0
}


define i32 @A.get(i8* %this) {

	%_0 = alloca i32
	store i32 0, i32* %_0
	%_1 = getelementptr i8, i8* %this, i32 8
	%_2 = bitcast i8* %_1 to i1*
	%_3 = load i1, i1* %_2

	br i1 %_3, label %if_then_0, label %if_else_0

	if_then_0:
	%_4 = load i32, i32* %_0
	%_5 = add i32 0, 1
	
	store i32 %_5, i32* %_0
	br label %if_end_0

	if_else_0:
	%_6 = load i32, i32* %_0
	%_7 = add i32 0, 0
	
	store i32 %_7, i32* %_0

	br label %if_end_0

	if_end_0:
	%_8 = load i32, i32* %_0
	ret i32 %_8
}

define i1 @B.set(i8* %this) {

	%_0 = alloca i1
	store i1 0, i1* %_0
	%_1 = load i1, i1* %_0
	%_2 = getelementptr i8, i8* %this, i32 8
	%_3 = bitcast i8* %_2 to i1*
	%_4 = load i1, i1* %_3
	
	store i1 %_4, i1* %_0
	%_5 = getelementptr i8, i8* %this, i32 8
	%_6 = bitcast i8* %_5 to i1*
	%_7 = load i1, i1* %_6
	%_8 = add i1 0, 1
	
	store i1 %_8, i1* %_6
	%_9 = getelementptr i8, i8* %this, i32 8
	%_10 = bitcast i8* %_9 to i1*
	%_11 = load i1, i1* %_10
	ret i1 %_11
}

define i1 @C.reset(i8* %this) {

	%_0 = alloca i1
	store i1 0, i1* %_0
	%_1 = load i1, i1* %_0
	%_2 = getelementptr i8, i8* %this, i32 8
	%_3 = bitcast i8* %_2 to i1*
	%_4 = load i1, i1* %_3
	
	store i1 %_4, i1* %_0
	%_5 = getelementptr i8, i8* %this, i32 8
	%_6 = bitcast i8* %_5 to i1*
	%_7 = load i1, i1* %_6
	%_8 = add i1 0, 0
	
	store i1 %_8, i1* %_6
	%_9 = getelementptr i8, i8* %this, i32 8
	%_10 = bitcast i8* %_9 to i1*
	%_11 = load i1, i1* %_10
	ret i1 %_11
}
