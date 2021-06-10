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


@.LinkedList = global [0 x i8*] []

@.Element = global [6 x i8*] [i8* bitcast (i1 (i8*, i32, i32, i1)* @Element.Init to i8*),
	i8* bitcast (i32 (i8*)* @Element.GetAge to i8*),
	i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*),
	i8* bitcast (i1 (i8*)* @Element.GetMarried to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Element.Equal to i8*),
	i8* bitcast (i1 (i8*, i32, i32)* @Element.Compare to i8*)]

@.List = global [10 x i8*] [i8* bitcast (i1 (i8*)* @List.Init to i8*),
	i8* bitcast (i1 (i8*, i8*, i8*, i1)* @List.InitNew to i8*),
	i8* bitcast (i8* (i8*, i8*)* @List.Insert to i8*),
	i8* bitcast (i1 (i8*, i8*)* @List.SetNext to i8*),
	i8* bitcast (i8* (i8*, i8*)* @List.Delete to i8*),
	i8* bitcast (i32 (i8*, i8*)* @List.Search to i8*),
	i8* bitcast (i1 (i8*)* @List.GetEnd to i8*),
	i8* bitcast (i8* (i8*)* @List.GetElem to i8*),
	i8* bitcast (i8* (i8*)* @List.GetNext to i8*),
	i8* bitcast (i1 (i8*)* @List.Print to i8*)]

@.LL = global [1 x i8*] [i8* bitcast (i32 (i8*)* @LL.Start to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 0
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [1 x i8*], [1 x i8*]* @.LL, i32 0, i32 0
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


define i1 @Element.Init(i8* %this, i32 %v_Age, i32 %v_Salary, i1 %v_Married) {
	%__v_Age = alloca i32
	store i32 %v_Age, i32* %__v_Age
	%__v_Salary = alloca i32
	store i32 %v_Salary, i32* %__v_Salary
	%__v_Married = alloca i1
	store i1 %v_Married, i1* %__v_Married
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = load i32, i32* %__v_Age
	
	store i32 %_3, i32* %_1
	%_4 = getelementptr i8, i8* %this, i32 12
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = load i32, i32* %__v_Salary
	
	store i32 %_7, i32* %_5
	%_8 = getelementptr i8, i8* %this, i32 16
	%_9 = bitcast i8* %_8 to i1*
	%_10 = load i1, i1* %_9
	%_11 = load i1, i1* %__v_Married
	
	store i1 %_11, i1* %_9
	%_12 = add i1 0, 1
	ret i1 %_12
}

define i32 @Element.GetAge(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i32 @Element.GetSalary(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 12
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i1 @Element.GetMarried(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	ret i1 %_2
}

define i1 @Element.Equal(i8* %this, i8* %other) {
	%__other = alloca i8*
	store i8* %other, i8** %__other

	%_0 = alloca i1
	store i1 0, i1* %_0

	%_1 = alloca i32
	store i32 0, i32* %_1

	%_2 = alloca i32
	store i32 0, i32* %_2

	%_3 = alloca i32
	store i32 0, i32* %_3
	%_4 = load i1, i1* %_0
	%_5 = add i1 0, 1
	
	store i1 %_5, i1* %_0
	%_6 = load i32, i32* %_1

	%_7 = load i8*, i8** %__other
	%_8 = bitcast i8* %_7 to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 1
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i32 (i8*)*
	%_13 = call i32 %_12(i8* %_7)
	
	store i32 %_13, i32* %_1

	%_14 = bitcast i8* %this to i8***
	%_15 = load i8**, i8*** %_14
	%_16 = getelementptr i8*, i8** %_15, i32 5
	%_17 = load i8*, i8** %_16
	%_18 = bitcast i8* %_17 to i1 (i8*, i32, i32)*
	%_20 = load i32, i32* %_1
	%_21 = getelementptr i8, i8* %this, i32 8
	%_22 = bitcast i8* %_21 to i32*
	%_23 = load i32, i32* %_22
	%_19 = call i1 %_18(i8* %this, i32 %_20, i32 %_23)

	%_24 = xor i1 1, %_19

	br i1 %_24, label %if_then_0, label %if_else_0

	if_then_0:
	%_25 = load i1, i1* %_0
	%_26 = add i1 0, 0
	
	store i1 %_26, i1* %_0
	br label %if_end_0

	if_else_0:
	%_27 = load i32, i32* %_2

	%_28 = load i8*, i8** %__other
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 2
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i32 (i8*)*
	%_34 = call i32 %_33(i8* %_28)
	
	store i32 %_34, i32* %_2

	%_35 = bitcast i8* %this to i8***
	%_36 = load i8**, i8*** %_35
	%_37 = getelementptr i8*, i8** %_36, i32 5
	%_38 = load i8*, i8** %_37
	%_39 = bitcast i8* %_38 to i1 (i8*, i32, i32)*
	%_41 = load i32, i32* %_2
	%_42 = getelementptr i8, i8* %this, i32 12
	%_43 = bitcast i8* %_42 to i32*
	%_44 = load i32, i32* %_43
	%_40 = call i1 %_39(i8* %this, i32 %_41, i32 %_44)

	%_45 = xor i1 1, %_40

	br i1 %_45, label %if_then_1, label %if_else_1

	if_then_1:
	%_46 = load i1, i1* %_0
	%_47 = add i1 0, 0
	
	store i1 %_47, i1* %_0
	br label %if_end_1

	if_else_1:
	%_48 = getelementptr i8, i8* %this, i32 16
	%_49 = bitcast i8* %_48 to i1*
	%_50 = load i1, i1* %_49

	br i1 %_50, label %if_then_2, label %if_else_2

	if_then_2:

	%_51 = load i8*, i8** %__other
	%_52 = bitcast i8* %_51 to i8***
	%_53 = load i8**, i8*** %_52
	%_54 = getelementptr i8*, i8** %_53, i32 3
	%_55 = load i8*, i8** %_54
	%_56 = bitcast i8* %_55 to i1 (i8*)*
	%_57 = call i1 %_56(i8* %_51)

	%_58 = xor i1 1, %_57

	br i1 %_58, label %if_then_3, label %if_else_3

	if_then_3:
	%_59 = load i1, i1* %_0
	%_60 = add i1 0, 0
	
	store i1 %_60, i1* %_0
	br label %if_end_3

	if_else_3:
	%_61 = load i32, i32* %_3
	%_62 = add i32 0, 0
	
	store i32 %_62, i32* %_3

	br label %if_end_3

	if_end_3:
	br label %if_end_2

	if_else_2:

	%_63 = load i8*, i8** %__other
	%_64 = bitcast i8* %_63 to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 3
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i1 (i8*)*
	%_69 = call i1 %_68(i8* %_63)

	br i1 %_69, label %if_then_4, label %if_else_4

	if_then_4:
	%_70 = load i1, i1* %_0
	%_71 = add i1 0, 0
	
	store i1 %_71, i1* %_0
	br label %if_end_4

	if_else_4:
	%_72 = load i32, i32* %_3
	%_73 = add i32 0, 0
	
	store i32 %_73, i32* %_3

	br label %if_end_4

	if_end_4:

	br label %if_end_2

	if_end_2:

	br label %if_end_1

	if_end_1:

	br label %if_end_0

	if_end_0:
	%_74 = load i1, i1* %_0
	ret i1 %_74
}

define i1 @Element.Compare(i8* %this, i32 %num1, i32 %num2) {
	%__num1 = alloca i32
	store i32 %num1, i32* %__num1
	%__num2 = alloca i32
	store i32 %num2, i32* %__num2

	%_0 = alloca i1
	store i1 0, i1* %_0

	%_1 = alloca i32
	store i32 0, i32* %_1
	%_2 = load i1, i1* %_0
	%_3 = add i1 0, 0
	
	store i1 %_3, i1* %_0
	%_4 = load i32, i32* %_1
	%_5 = load i32, i32* %__num2
	%_6 = add i32 0, 1

	%_7 = add i32 %_5, %_6
	
	store i32 %_7, i32* %_1
	%_8 = load i32, i32* %__num1
	%_9 = load i32, i32* %__num2

	%_10 = icmp slt i32 %_8, %_9

	br i1 %_10, label %if_then_0, label %if_else_0

	if_then_0:
	%_11 = load i1, i1* %_0
	%_12 = add i1 0, 0
	
	store i1 %_12, i1* %_0
	br label %if_end_0

	if_else_0:
	%_13 = load i32, i32* %__num1
	%_14 = load i32, i32* %_1

	%_15 = icmp slt i32 %_13, %_14

	%_16 = xor i1 1, %_15

	br i1 %_16, label %if_then_1, label %if_else_1

	if_then_1:
	%_17 = load i1, i1* %_0
	%_18 = add i1 0, 0
	
	store i1 %_18, i1* %_0
	br label %if_end_1

	if_else_1:
	%_19 = load i1, i1* %_0
	%_20 = add i1 0, 1
	
	store i1 %_20, i1* %_0

	br label %if_end_1

	if_end_1:

	br label %if_end_0

	if_end_0:
	%_21 = load i1, i1* %_0
	ret i1 %_21
}

define i1 @List.Init(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	%_3 = add i1 0, 1
	
	store i1 %_3, i1* %_1
	%_4 = add i1 0, 1
	ret i1 %_4
}

define i1 @List.InitNew(i8* %this, i8* %v_elem, i8* %v_next, i1 %v_end) {
	%__v_elem = alloca i8*
	store i8* %v_elem, i8** %__v_elem
	%__v_next = alloca i8*
	store i8* %v_next, i8** %__v_next
	%__v_end = alloca i1
	store i1 %v_end, i1* %__v_end
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	%_3 = load i1, i1* %__v_end
	
	store i1 %_3, i1* %_1
	%_4 = getelementptr i8, i8* %this, i32 8
	%_5 = bitcast i8* %_4 to i8**
	%_6 = load i8*, i8** %_5
	%_7 = load i8*, i8** %__v_elem
	
	store i8* %_7, i8** %_5
	%_8 = getelementptr i8, i8* %this, i32 16
	%_9 = bitcast i8* %_8 to i8**
	%_10 = load i8*, i8** %_9
	%_11 = load i8*, i8** %__v_next
	
	store i8* %_11, i8** %_9
	%_12 = add i1 0, 1
	ret i1 %_12
}

define i8* @List.Insert(i8* %this, i8* %new_elem) {
	%__new_elem = alloca i8*
	store i8* %new_elem, i8** %__new_elem

	%_0 = alloca i1
	store i1 0, i1* %_0

	%_1 = alloca i8*

	%_2 = alloca i8*
	%_3 = load i8*, i8** %_1
	
	store i8* %this, i8** %_1
	%_4 = load i8*, i8** %_2

	%_5 = add i32 8, 17
	%_6 = call i8* @calloc(i32 %_5, i32 1)
	%_7 = bitcast i8* %_6 to i8***
	%_8 = getelementptr [10 x i8*], [10 x i8*]* @.List, i32 0, i32 0
	store i8** %_8, i8*** %_7
	
	store i8* %_6, i8** %_2
	%_9 = load i1, i1* %_0

	%_10 = load i8*, i8** %_2
	%_11 = bitcast i8* %_10 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 1
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*, i8*, i8*, i1)*
	%_17 = load i8*, i8** %__new_elem
	%_18 = load i8*, i8** %_1
	%_19 = add i1 0, 0
	%_16 = call i1 %_15(i8* %_10, i8* %_17, i8* %_18, i1 %_19)
	
	store i1 %_16, i1* %_0
	%_20 = load i8*, i8** %_2
	ret i8* %_20
}

define i1 @List.SetNext(i8* %this, i8* %v_next) {
	%__v_next = alloca i8*
	store i8* %v_next, i8** %__v_next
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	%_3 = load i8*, i8** %__v_next
	
	store i8* %_3, i8** %_1
	%_4 = add i1 0, 1
	ret i1 %_4
}

define i8* @List.Delete(i8* %this, i8* %e) {
	%__e = alloca i8*
	store i8* %e, i8** %__e

	%_0 = alloca i8*

	%_1 = alloca i1
	store i1 0, i1* %_1

	%_2 = alloca i1
	store i1 0, i1* %_2

	%_3 = alloca i8*

	%_4 = alloca i8*

	%_5 = alloca i1
	store i1 0, i1* %_5

	%_6 = alloca i8*

	%_7 = alloca i32
	store i32 0, i32* %_7

	%_8 = alloca i32
	store i32 0, i32* %_8
	%_9 = load i8*, i8** %_0
	
	store i8* %this, i8** %_0
	%_10 = load i1, i1* %_1
	%_11 = add i1 0, 0
	
	store i1 %_11, i1* %_1
	%_12 = load i32, i32* %_7
	%_13 = add i32 0, 0
	%_14 = add i32 0, 1

	%_15 = sub i32 %_13, %_14
	
	store i32 %_15, i32* %_7
	%_16 = load i8*, i8** %_3
	
	store i8* %this, i8** %_3
	%_17 = load i8*, i8** %_4
	
	store i8* %this, i8** %_4
	%_18 = load i1, i1* %_5
	%_19 = getelementptr i8, i8* %this, i32 24
	%_20 = bitcast i8* %_19 to i1*
	%_21 = load i1, i1* %_20
	
	store i1 %_21, i1* %_5
	%_22 = load i8*, i8** %_6
	%_23 = getelementptr i8, i8* %this, i32 8
	%_24 = bitcast i8* %_23 to i8**
	%_25 = load i8*, i8** %_24
	
	store i8* %_25, i8** %_6

	br label %while_0
	while_0:
	%_26 = load i1, i1* %_5

	%_27 = xor i1 1, %_26

	br i1 %_27, label %exp_and_2, label %exp_and_1

	exp_and_1:
	br label %exp_and_4

	exp_and_2:
	%_28 = load i1, i1* %_1

	%_29 = xor i1 1, %_28
	br label %exp_and_3

	exp_and_3:
	br label %exp_and_4
	exp_and_4:
	%_30 = phi i1 [ %_27, %exp_and_1 ], [ %_29, %exp_and_3 ]

	br i1 %_30, label %continue_0, label %while_end_0
	continue_0:

	%_31 = load i8*, i8** %__e
	%_32 = bitcast i8* %_31 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 4
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i1 (i8*, i8*)*
	%_38 = load i8*, i8** %_6
	%_37 = call i1 %_36(i8* %_31, i8* %_38)

	br i1 %_37, label %if_then_5, label %if_else_5

	if_then_5:
	%_39 = load i1, i1* %_1
	%_40 = add i1 0, 1
	
	store i1 %_40, i1* %_1
	%_41 = load i32, i32* %_7
	%_42 = add i32 0, 0

	%_43 = icmp slt i32 %_41, %_42

	br i1 %_43, label %if_then_6, label %if_else_6

	if_then_6:
	%_44 = load i8*, i8** %_0

	%_45 = load i8*, i8** %_3
	%_46 = bitcast i8* %_45 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 8
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i8* (i8*)*
	%_51 = call i8* %_50(i8* %_45)
	
	store i8* %_51, i8** %_0
	br label %if_end_6

	if_else_6:
	%_52 = add i32 0, 0
	%_53 = add i32 0, 555

	%_54 = sub i32 %_52, %_53
	call void (i32) @print_int(i32 %_54)
	%_55 = load i1, i1* %_2

	%_56 = load i8*, i8** %_4
	%_57 = bitcast i8* %_56 to i8***
	%_58 = load i8**, i8*** %_57
	%_59 = getelementptr i8*, i8** %_58, i32 3
	%_60 = load i8*, i8** %_59
	%_61 = bitcast i8* %_60 to i1 (i8*, i8*)*

	%_63 = load i8*, i8** %_3
	%_64 = bitcast i8* %_63 to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 8
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i8* (i8*)*
	%_69 = call i8* %_68(i8* %_63)
	%_62 = call i1 %_61(i8* %_56, i8* %_69)
	
	store i1 %_62, i1* %_2
	%_70 = add i32 0, 0
	%_71 = add i32 0, 555

	%_72 = sub i32 %_70, %_71
	call void (i32) @print_int(i32 %_72)

	br label %if_end_6

	if_end_6:
	br label %if_end_5

	if_else_5:
	%_73 = load i32, i32* %_8
	%_74 = add i32 0, 0
	
	store i32 %_74, i32* %_8

	br label %if_end_5

	if_end_5:
	%_75 = load i1, i1* %_1

	%_76 = xor i1 1, %_75

	br i1 %_76, label %if_then_7, label %if_else_7

	if_then_7:
	%_77 = load i8*, i8** %_4
	%_78 = load i8*, i8** %_3
	
	store i8* %_78, i8** %_4
	%_79 = load i8*, i8** %_3

	%_80 = load i8*, i8** %_3
	%_81 = bitcast i8* %_80 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 8
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i8* (i8*)*
	%_86 = call i8* %_85(i8* %_80)
	
	store i8* %_86, i8** %_3
	%_87 = load i1, i1* %_5

	%_88 = load i8*, i8** %_3
	%_89 = bitcast i8* %_88 to i8***
	%_90 = load i8**, i8*** %_89
	%_91 = getelementptr i8*, i8** %_90, i32 6
	%_92 = load i8*, i8** %_91
	%_93 = bitcast i8* %_92 to i1 (i8*)*
	%_94 = call i1 %_93(i8* %_88)
	
	store i1 %_94, i1* %_5
	%_95 = load i8*, i8** %_6

	%_96 = load i8*, i8** %_3
	%_97 = bitcast i8* %_96 to i8***
	%_98 = load i8**, i8*** %_97
	%_99 = getelementptr i8*, i8** %_98, i32 7
	%_100 = load i8*, i8** %_99
	%_101 = bitcast i8* %_100 to i8* (i8*)*
	%_102 = call i8* %_101(i8* %_96)
	
	store i8* %_102, i8** %_6
	%_103 = load i32, i32* %_7
	%_104 = add i32 0, 1
	
	store i32 %_104, i32* %_7
	br label %if_end_7

	if_else_7:
	%_105 = load i32, i32* %_8
	%_106 = add i32 0, 0
	
	store i32 %_106, i32* %_8

	br label %if_end_7

	if_end_7:
	br label %while_0

	while_end_0:
	%_107 = load i8*, i8** %_0
	ret i8* %_107
}

define i32 @List.Search(i8* %this, i8* %e) {
	%__e = alloca i8*
	store i8* %e, i8** %__e

	%_0 = alloca i32
	store i32 0, i32* %_0

	%_1 = alloca i8*

	%_2 = alloca i8*

	%_3 = alloca i1
	store i1 0, i1* %_3

	%_4 = alloca i32
	store i32 0, i32* %_4
	%_5 = load i32, i32* %_0
	%_6 = add i32 0, 0
	
	store i32 %_6, i32* %_0
	%_7 = load i8*, i8** %_1
	
	store i8* %this, i8** %_1
	%_8 = load i1, i1* %_3
	%_9 = getelementptr i8, i8* %this, i32 24
	%_10 = bitcast i8* %_9 to i1*
	%_11 = load i1, i1* %_10
	
	store i1 %_11, i1* %_3
	%_12 = load i8*, i8** %_2
	%_13 = getelementptr i8, i8* %this, i32 8
	%_14 = bitcast i8* %_13 to i8**
	%_15 = load i8*, i8** %_14
	
	store i8* %_15, i8** %_2

	br label %while_0
	while_0:
	%_16 = load i1, i1* %_3

	%_17 = xor i1 1, %_16
	br i1 %_17, label %continue_0, label %while_end_0
	continue_0:

	%_18 = load i8*, i8** %__e
	%_19 = bitcast i8* %_18 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 4
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i1 (i8*, i8*)*
	%_25 = load i8*, i8** %_2
	%_24 = call i1 %_23(i8* %_18, i8* %_25)

	br i1 %_24, label %if_then_1, label %if_else_1

	if_then_1:
	%_26 = load i32, i32* %_0
	%_27 = add i32 0, 1
	
	store i32 %_27, i32* %_0
	br label %if_end_1

	if_else_1:
	%_28 = load i32, i32* %_4
	%_29 = add i32 0, 0
	
	store i32 %_29, i32* %_4

	br label %if_end_1

	if_end_1:
	%_30 = load i8*, i8** %_1

	%_31 = load i8*, i8** %_1
	%_32 = bitcast i8* %_31 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 8
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i8* (i8*)*
	%_37 = call i8* %_36(i8* %_31)
	
	store i8* %_37, i8** %_1
	%_38 = load i1, i1* %_3

	%_39 = load i8*, i8** %_1
	%_40 = bitcast i8* %_39 to i8***
	%_41 = load i8**, i8*** %_40
	%_42 = getelementptr i8*, i8** %_41, i32 6
	%_43 = load i8*, i8** %_42
	%_44 = bitcast i8* %_43 to i1 (i8*)*
	%_45 = call i1 %_44(i8* %_39)
	
	store i1 %_45, i1* %_3
	%_46 = load i8*, i8** %_2

	%_47 = load i8*, i8** %_1
	%_48 = bitcast i8* %_47 to i8***
	%_49 = load i8**, i8*** %_48
	%_50 = getelementptr i8*, i8** %_49, i32 7
	%_51 = load i8*, i8** %_50
	%_52 = bitcast i8* %_51 to i8* (i8*)*
	%_53 = call i8* %_52(i8* %_47)
	
	store i8* %_53, i8** %_2
	br label %while_0

	while_end_0:
	%_54 = load i32, i32* %_0
	ret i32 %_54
}

define i1 @List.GetEnd(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	ret i1 %_2
}

define i8* @List.GetElem(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	ret i8* %_2
}

define i8* @List.GetNext(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	ret i8* %_2
}

define i1 @List.Print(i8* %this) {

	%_0 = alloca i8*

	%_1 = alloca i1
	store i1 0, i1* %_1

	%_2 = alloca i8*
	%_3 = load i8*, i8** %_0
	
	store i8* %this, i8** %_0
	%_4 = load i1, i1* %_1
	%_5 = getelementptr i8, i8* %this, i32 24
	%_6 = bitcast i8* %_5 to i1*
	%_7 = load i1, i1* %_6
	
	store i1 %_7, i1* %_1
	%_8 = load i8*, i8** %_2
	%_9 = getelementptr i8, i8* %this, i32 8
	%_10 = bitcast i8* %_9 to i8**
	%_11 = load i8*, i8** %_10
	
	store i8* %_11, i8** %_2

	br label %while_0
	while_0:
	%_12 = load i1, i1* %_1

	%_13 = xor i1 1, %_12
	br i1 %_13, label %continue_0, label %while_end_0
	continue_0:

	%_14 = load i8*, i8** %_2
	%_15 = bitcast i8* %_14 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 1
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i32 (i8*)*
	%_20 = call i32 %_19(i8* %_14)
	call void (i32) @print_int(i32 %_20)
	%_21 = load i8*, i8** %_0

	%_22 = load i8*, i8** %_0
	%_23 = bitcast i8* %_22 to i8***
	%_24 = load i8**, i8*** %_23
	%_25 = getelementptr i8*, i8** %_24, i32 8
	%_26 = load i8*, i8** %_25
	%_27 = bitcast i8* %_26 to i8* (i8*)*
	%_28 = call i8* %_27(i8* %_22)
	
	store i8* %_28, i8** %_0
	%_29 = load i1, i1* %_1

	%_30 = load i8*, i8** %_0
	%_31 = bitcast i8* %_30 to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 6
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i1 (i8*)*
	%_36 = call i1 %_35(i8* %_30)
	
	store i1 %_36, i1* %_1
	%_37 = load i8*, i8** %_2

	%_38 = load i8*, i8** %_0
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 7
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i8* (i8*)*
	%_44 = call i8* %_43(i8* %_38)
	
	store i8* %_44, i8** %_2
	br label %while_0

	while_end_0:
	%_45 = add i1 0, 1
	ret i1 %_45
}

define i32 @LL.Start(i8* %this) {

	%_0 = alloca i8*

	%_1 = alloca i8*

	%_2 = alloca i1
	store i1 0, i1* %_2

	%_3 = alloca i8*

	%_4 = alloca i8*

	%_5 = alloca i8*
	%_6 = load i8*, i8** %_1

	%_7 = add i32 8, 17
	%_8 = call i8* @calloc(i32 %_7, i32 1)
	%_9 = bitcast i8* %_8 to i8***
	%_10 = getelementptr [10 x i8*], [10 x i8*]* @.List, i32 0, i32 0
	store i8** %_10, i8*** %_9
	
	store i8* %_8, i8** %_1
	%_11 = load i1, i1* %_2

	%_12 = load i8*, i8** %_1
	%_13 = bitcast i8* %_12 to i8***
	%_14 = load i8**, i8*** %_13
	%_15 = getelementptr i8*, i8** %_14, i32 0
	%_16 = load i8*, i8** %_15
	%_17 = bitcast i8* %_16 to i1 (i8*)*
	%_18 = call i1 %_17(i8* %_12)
	
	store i1 %_18, i1* %_2
	%_19 = load i8*, i8** %_0
	%_20 = load i8*, i8** %_1
	
	store i8* %_20, i8** %_0
	%_21 = load i1, i1* %_2

	%_22 = load i8*, i8** %_0
	%_23 = bitcast i8* %_22 to i8***
	%_24 = load i8**, i8*** %_23
	%_25 = getelementptr i8*, i8** %_24, i32 0
	%_26 = load i8*, i8** %_25
	%_27 = bitcast i8* %_26 to i1 (i8*)*
	%_28 = call i1 %_27(i8* %_22)
	
	store i1 %_28, i1* %_2
	%_29 = load i1, i1* %_2

	%_30 = load i8*, i8** %_0
	%_31 = bitcast i8* %_30 to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 9
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i1 (i8*)*
	%_36 = call i1 %_35(i8* %_30)
	
	store i1 %_36, i1* %_2
	%_37 = load i8*, i8** %_3

	%_38 = add i32 8, 9
	%_39 = call i8* @calloc(i32 %_38, i32 1)
	%_40 = bitcast i8* %_39 to i8***
	%_41 = getelementptr [6 x i8*], [6 x i8*]* @.Element, i32 0, i32 0
	store i8** %_41, i8*** %_40
	
	store i8* %_39, i8** %_3
	%_42 = load i1, i1* %_2

	%_43 = load i8*, i8** %_3
	%_44 = bitcast i8* %_43 to i8***
	%_45 = load i8**, i8*** %_44
	%_46 = getelementptr i8*, i8** %_45, i32 0
	%_47 = load i8*, i8** %_46
	%_48 = bitcast i8* %_47 to i1 (i8*, i32, i32, i1)*
	%_50 = add i32 0, 25
	%_51 = add i32 0, 37000
	%_52 = add i1 0, 0
	%_49 = call i1 %_48(i8* %_43, i32 %_50, i32 %_51, i1 %_52)
	
	store i1 %_49, i1* %_2
	%_53 = load i8*, i8** %_0

	%_54 = load i8*, i8** %_0
	%_55 = bitcast i8* %_54 to i8***
	%_56 = load i8**, i8*** %_55
	%_57 = getelementptr i8*, i8** %_56, i32 2
	%_58 = load i8*, i8** %_57
	%_59 = bitcast i8* %_58 to i8* (i8*, i8*)*
	%_61 = load i8*, i8** %_3
	%_60 = call i8* %_59(i8* %_54, i8* %_61)
	
	store i8* %_60, i8** %_0
	%_62 = add i32 0, 10000000
	call void (i32) @print_int(i32 %_62)
	%_63 = load i8*, i8** %_3

	%_64 = add i32 8, 9
	%_65 = call i8* @calloc(i32 %_64, i32 1)
	%_66 = bitcast i8* %_65 to i8***
	%_67 = getelementptr [6 x i8*], [6 x i8*]* @.Element, i32 0, i32 0
	store i8** %_67, i8*** %_66
	
	store i8* %_65, i8** %_3
	%_68 = load i1, i1* %_2

	%_69 = load i8*, i8** %_3
	%_70 = bitcast i8* %_69 to i8***
	%_71 = load i8**, i8*** %_70
	%_72 = getelementptr i8*, i8** %_71, i32 0
	%_73 = load i8*, i8** %_72
	%_74 = bitcast i8* %_73 to i1 (i8*, i32, i32, i1)*
	%_76 = add i32 0, 39
	%_77 = add i32 0, 42000
	%_78 = add i1 0, 1
	%_75 = call i1 %_74(i8* %_69, i32 %_76, i32 %_77, i1 %_78)
	
	store i1 %_75, i1* %_2
	%_79 = load i8*, i8** %_4
	%_80 = load i8*, i8** %_3
	
	store i8* %_80, i8** %_4
	%_81 = load i8*, i8** %_0

	%_82 = load i8*, i8** %_0
	%_83 = bitcast i8* %_82 to i8***
	%_84 = load i8**, i8*** %_83
	%_85 = getelementptr i8*, i8** %_84, i32 2
	%_86 = load i8*, i8** %_85
	%_87 = bitcast i8* %_86 to i8* (i8*, i8*)*
	%_89 = load i8*, i8** %_3
	%_88 = call i8* %_87(i8* %_82, i8* %_89)
	
	store i8* %_88, i8** %_0
	%_90 = load i1, i1* %_2

	%_91 = load i8*, i8** %_0
	%_92 = bitcast i8* %_91 to i8***
	%_93 = load i8**, i8*** %_92
	%_94 = getelementptr i8*, i8** %_93, i32 9
	%_95 = load i8*, i8** %_94
	%_96 = bitcast i8* %_95 to i1 (i8*)*
	%_97 = call i1 %_96(i8* %_91)
	
	store i1 %_97, i1* %_2
	%_98 = add i32 0, 10000000
	call void (i32) @print_int(i32 %_98)
	%_99 = load i8*, i8** %_3

	%_100 = add i32 8, 9
	%_101 = call i8* @calloc(i32 %_100, i32 1)
	%_102 = bitcast i8* %_101 to i8***
	%_103 = getelementptr [6 x i8*], [6 x i8*]* @.Element, i32 0, i32 0
	store i8** %_103, i8*** %_102
	
	store i8* %_101, i8** %_3
	%_104 = load i1, i1* %_2

	%_105 = load i8*, i8** %_3
	%_106 = bitcast i8* %_105 to i8***
	%_107 = load i8**, i8*** %_106
	%_108 = getelementptr i8*, i8** %_107, i32 0
	%_109 = load i8*, i8** %_108
	%_110 = bitcast i8* %_109 to i1 (i8*, i32, i32, i1)*
	%_112 = add i32 0, 22
	%_113 = add i32 0, 34000
	%_114 = add i1 0, 0
	%_111 = call i1 %_110(i8* %_105, i32 %_112, i32 %_113, i1 %_114)
	
	store i1 %_111, i1* %_2
	%_115 = load i8*, i8** %_0

	%_116 = load i8*, i8** %_0
	%_117 = bitcast i8* %_116 to i8***
	%_118 = load i8**, i8*** %_117
	%_119 = getelementptr i8*, i8** %_118, i32 2
	%_120 = load i8*, i8** %_119
	%_121 = bitcast i8* %_120 to i8* (i8*, i8*)*
	%_123 = load i8*, i8** %_3
	%_122 = call i8* %_121(i8* %_116, i8* %_123)
	
	store i8* %_122, i8** %_0
	%_124 = load i1, i1* %_2

	%_125 = load i8*, i8** %_0
	%_126 = bitcast i8* %_125 to i8***
	%_127 = load i8**, i8*** %_126
	%_128 = getelementptr i8*, i8** %_127, i32 9
	%_129 = load i8*, i8** %_128
	%_130 = bitcast i8* %_129 to i1 (i8*)*
	%_131 = call i1 %_130(i8* %_125)
	
	store i1 %_131, i1* %_2
	%_132 = load i8*, i8** %_5

	%_133 = add i32 8, 9
	%_134 = call i8* @calloc(i32 %_133, i32 1)
	%_135 = bitcast i8* %_134 to i8***
	%_136 = getelementptr [6 x i8*], [6 x i8*]* @.Element, i32 0, i32 0
	store i8** %_136, i8*** %_135
	
	store i8* %_134, i8** %_5
	%_137 = load i1, i1* %_2

	%_138 = load i8*, i8** %_5
	%_139 = bitcast i8* %_138 to i8***
	%_140 = load i8**, i8*** %_139
	%_141 = getelementptr i8*, i8** %_140, i32 0
	%_142 = load i8*, i8** %_141
	%_143 = bitcast i8* %_142 to i1 (i8*, i32, i32, i1)*
	%_145 = add i32 0, 27
	%_146 = add i32 0, 34000
	%_147 = add i1 0, 0
	%_144 = call i1 %_143(i8* %_138, i32 %_145, i32 %_146, i1 %_147)
	
	store i1 %_144, i1* %_2

	%_148 = load i8*, i8** %_0
	%_149 = bitcast i8* %_148 to i8***
	%_150 = load i8**, i8*** %_149
	%_151 = getelementptr i8*, i8** %_150, i32 5
	%_152 = load i8*, i8** %_151
	%_153 = bitcast i8* %_152 to i32 (i8*, i8*)*
	%_155 = load i8*, i8** %_4
	%_154 = call i32 %_153(i8* %_148, i8* %_155)
	call void (i32) @print_int(i32 %_154)

	%_156 = load i8*, i8** %_0
	%_157 = bitcast i8* %_156 to i8***
	%_158 = load i8**, i8*** %_157
	%_159 = getelementptr i8*, i8** %_158, i32 5
	%_160 = load i8*, i8** %_159
	%_161 = bitcast i8* %_160 to i32 (i8*, i8*)*
	%_163 = load i8*, i8** %_5
	%_162 = call i32 %_161(i8* %_156, i8* %_163)
	call void (i32) @print_int(i32 %_162)
	%_164 = add i32 0, 10000000
	call void (i32) @print_int(i32 %_164)
	%_165 = load i8*, i8** %_3

	%_166 = add i32 8, 9
	%_167 = call i8* @calloc(i32 %_166, i32 1)
	%_168 = bitcast i8* %_167 to i8***
	%_169 = getelementptr [6 x i8*], [6 x i8*]* @.Element, i32 0, i32 0
	store i8** %_169, i8*** %_168
	
	store i8* %_167, i8** %_3
	%_170 = load i1, i1* %_2

	%_171 = load i8*, i8** %_3
	%_172 = bitcast i8* %_171 to i8***
	%_173 = load i8**, i8*** %_172
	%_174 = getelementptr i8*, i8** %_173, i32 0
	%_175 = load i8*, i8** %_174
	%_176 = bitcast i8* %_175 to i1 (i8*, i32, i32, i1)*
	%_178 = add i32 0, 28
	%_179 = add i32 0, 35000
	%_180 = add i1 0, 0
	%_177 = call i1 %_176(i8* %_171, i32 %_178, i32 %_179, i1 %_180)
	
	store i1 %_177, i1* %_2
	%_181 = load i8*, i8** %_0

	%_182 = load i8*, i8** %_0
	%_183 = bitcast i8* %_182 to i8***
	%_184 = load i8**, i8*** %_183
	%_185 = getelementptr i8*, i8** %_184, i32 2
	%_186 = load i8*, i8** %_185
	%_187 = bitcast i8* %_186 to i8* (i8*, i8*)*
	%_189 = load i8*, i8** %_3
	%_188 = call i8* %_187(i8* %_182, i8* %_189)
	
	store i8* %_188, i8** %_0
	%_190 = load i1, i1* %_2

	%_191 = load i8*, i8** %_0
	%_192 = bitcast i8* %_191 to i8***
	%_193 = load i8**, i8*** %_192
	%_194 = getelementptr i8*, i8** %_193, i32 9
	%_195 = load i8*, i8** %_194
	%_196 = bitcast i8* %_195 to i1 (i8*)*
	%_197 = call i1 %_196(i8* %_191)
	
	store i1 %_197, i1* %_2
	%_198 = add i32 0, 2220000
	call void (i32) @print_int(i32 %_198)
	%_199 = load i8*, i8** %_0

	%_200 = load i8*, i8** %_0
	%_201 = bitcast i8* %_200 to i8***
	%_202 = load i8**, i8*** %_201
	%_203 = getelementptr i8*, i8** %_202, i32 4
	%_204 = load i8*, i8** %_203
	%_205 = bitcast i8* %_204 to i8* (i8*, i8*)*
	%_207 = load i8*, i8** %_4
	%_206 = call i8* %_205(i8* %_200, i8* %_207)
	
	store i8* %_206, i8** %_0
	%_208 = load i1, i1* %_2

	%_209 = load i8*, i8** %_0
	%_210 = bitcast i8* %_209 to i8***
	%_211 = load i8**, i8*** %_210
	%_212 = getelementptr i8*, i8** %_211, i32 9
	%_213 = load i8*, i8** %_212
	%_214 = bitcast i8* %_213 to i1 (i8*)*
	%_215 = call i1 %_214(i8* %_209)
	
	store i1 %_215, i1* %_2
	%_216 = add i32 0, 33300000
	call void (i32) @print_int(i32 %_216)
	%_217 = load i8*, i8** %_0

	%_218 = load i8*, i8** %_0
	%_219 = bitcast i8* %_218 to i8***
	%_220 = load i8**, i8*** %_219
	%_221 = getelementptr i8*, i8** %_220, i32 4
	%_222 = load i8*, i8** %_221
	%_223 = bitcast i8* %_222 to i8* (i8*, i8*)*
	%_225 = load i8*, i8** %_3
	%_224 = call i8* %_223(i8* %_218, i8* %_225)
	
	store i8* %_224, i8** %_0
	%_226 = load i1, i1* %_2

	%_227 = load i8*, i8** %_0
	%_228 = bitcast i8* %_227 to i8***
	%_229 = load i8**, i8*** %_228
	%_230 = getelementptr i8*, i8** %_229, i32 9
	%_231 = load i8*, i8** %_230
	%_232 = bitcast i8* %_231 to i1 (i8*)*
	%_233 = call i1 %_232(i8* %_227)
	
	store i1 %_233, i1* %_2
	%_234 = add i32 0, 44440000
	call void (i32) @print_int(i32 %_234)
	%_235 = add i32 0, 0
	ret i32 %_235
}
