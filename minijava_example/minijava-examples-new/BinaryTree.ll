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


@.BinaryTree = global [0 x i8*] []

@.BT = global [1 x i8*] [i8* bitcast (i32 (i8*)* @BT.Start to i8*)]

@.Tree = global [20 x i8*] [i8* bitcast (i1 (i8*, i32)* @Tree.Init to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Tree.SetRight to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Tree.SetLeft to i8*),
	i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*),
	i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*),
	i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*),
	i8* bitcast (i1 (i8*, i32)* @Tree.SetKey to i8*),
	i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*),
	i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*),
	i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Left to i8*),
	i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Right to i8*),
	i8* bitcast (i1 (i8*, i32, i32)* @Tree.Compare to i8*),
	i8* bitcast (i1 (i8*, i32)* @Tree.Insert to i8*),
	i8* bitcast (i1 (i8*, i32)* @Tree.Delete to i8*),
	i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.Remove to i8*),
	i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveRight to i8*),
	i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveLeft to i8*),
	i8* bitcast (i32 (i8*, i32)* @Tree.Search to i8*),
	i8* bitcast (i1 (i8*)* @Tree.Print to i8*),
	i8* bitcast (i1 (i8*, i8*)* @Tree.RecPrint to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 0
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [1 x i8*], [1 x i8*]* @.BT, i32 0, i32 0
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


define i32 @BT.Start(i8* %this) {

	%_0 = alloca i8*

	%_1 = alloca i1
	store i1 0, i1* %_1

	%_2 = alloca i32
	store i32 0, i32* %_2
	%_3 = load i8*, i8** %_0

	%_4 = add i32 8, 30
	%_5 = call i8* @calloc(i32 %_4, i32 1)
	%_6 = bitcast i8* %_5 to i8***
	%_7 = getelementptr [20 x i8*], [20 x i8*]* @.Tree, i32 0, i32 0
	store i8** %_7, i8*** %_6
	
	store i8* %_5, i8** %_0
	%_8 = load i1, i1* %_1

	%_9 = load i8*, i8** %_0
	%_10 = bitcast i8* %_9 to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 0
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i1 (i8*, i32)*
	%_16 = add i32 0, 16
	%_15 = call i1 %_14(i8* %_9, i32 %_16)
	
	store i1 %_15, i1* %_1
	%_17 = load i1, i1* %_1

	%_18 = load i8*, i8** %_0
	%_19 = bitcast i8* %_18 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 18
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i1 (i8*)*
	%_24 = call i1 %_23(i8* %_18)
	
	store i1 %_24, i1* %_1
	%_25 = add i32 0, 100000000
	call void (i32) @print_int(i32 %_25)
	%_26 = load i1, i1* %_1

	%_27 = load i8*, i8** %_0
	%_28 = bitcast i8* %_27 to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 12
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i1 (i8*, i32)*
	%_34 = add i32 0, 8
	%_33 = call i1 %_32(i8* %_27, i32 %_34)
	
	store i1 %_33, i1* %_1
	%_35 = load i1, i1* %_1

	%_36 = load i8*, i8** %_0
	%_37 = bitcast i8* %_36 to i8***
	%_38 = load i8**, i8*** %_37
	%_39 = getelementptr i8*, i8** %_38, i32 18
	%_40 = load i8*, i8** %_39
	%_41 = bitcast i8* %_40 to i1 (i8*)*
	%_42 = call i1 %_41(i8* %_36)
	
	store i1 %_42, i1* %_1
	%_43 = load i1, i1* %_1

	%_44 = load i8*, i8** %_0
	%_45 = bitcast i8* %_44 to i8***
	%_46 = load i8**, i8*** %_45
	%_47 = getelementptr i8*, i8** %_46, i32 12
	%_48 = load i8*, i8** %_47
	%_49 = bitcast i8* %_48 to i1 (i8*, i32)*
	%_51 = add i32 0, 24
	%_50 = call i1 %_49(i8* %_44, i32 %_51)
	
	store i1 %_50, i1* %_1
	%_52 = load i1, i1* %_1

	%_53 = load i8*, i8** %_0
	%_54 = bitcast i8* %_53 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 12
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i1 (i8*, i32)*
	%_60 = add i32 0, 4
	%_59 = call i1 %_58(i8* %_53, i32 %_60)
	
	store i1 %_59, i1* %_1
	%_61 = load i1, i1* %_1

	%_62 = load i8*, i8** %_0
	%_63 = bitcast i8* %_62 to i8***
	%_64 = load i8**, i8*** %_63
	%_65 = getelementptr i8*, i8** %_64, i32 12
	%_66 = load i8*, i8** %_65
	%_67 = bitcast i8* %_66 to i1 (i8*, i32)*
	%_69 = add i32 0, 12
	%_68 = call i1 %_67(i8* %_62, i32 %_69)
	
	store i1 %_68, i1* %_1
	%_70 = load i1, i1* %_1

	%_71 = load i8*, i8** %_0
	%_72 = bitcast i8* %_71 to i8***
	%_73 = load i8**, i8*** %_72
	%_74 = getelementptr i8*, i8** %_73, i32 12
	%_75 = load i8*, i8** %_74
	%_76 = bitcast i8* %_75 to i1 (i8*, i32)*
	%_78 = add i32 0, 20
	%_77 = call i1 %_76(i8* %_71, i32 %_78)
	
	store i1 %_77, i1* %_1
	%_79 = load i1, i1* %_1

	%_80 = load i8*, i8** %_0
	%_81 = bitcast i8* %_80 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 12
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i1 (i8*, i32)*
	%_87 = add i32 0, 28
	%_86 = call i1 %_85(i8* %_80, i32 %_87)
	
	store i1 %_86, i1* %_1
	%_88 = load i1, i1* %_1

	%_89 = load i8*, i8** %_0
	%_90 = bitcast i8* %_89 to i8***
	%_91 = load i8**, i8*** %_90
	%_92 = getelementptr i8*, i8** %_91, i32 12
	%_93 = load i8*, i8** %_92
	%_94 = bitcast i8* %_93 to i1 (i8*, i32)*
	%_96 = add i32 0, 14
	%_95 = call i1 %_94(i8* %_89, i32 %_96)
	
	store i1 %_95, i1* %_1
	%_97 = load i1, i1* %_1

	%_98 = load i8*, i8** %_0
	%_99 = bitcast i8* %_98 to i8***
	%_100 = load i8**, i8*** %_99
	%_101 = getelementptr i8*, i8** %_100, i32 18
	%_102 = load i8*, i8** %_101
	%_103 = bitcast i8* %_102 to i1 (i8*)*
	%_104 = call i1 %_103(i8* %_98)
	
	store i1 %_104, i1* %_1

	%_105 = load i8*, i8** %_0
	%_106 = bitcast i8* %_105 to i8***
	%_107 = load i8**, i8*** %_106
	%_108 = getelementptr i8*, i8** %_107, i32 17
	%_109 = load i8*, i8** %_108
	%_110 = bitcast i8* %_109 to i32 (i8*, i32)*
	%_112 = add i32 0, 24
	%_111 = call i32 %_110(i8* %_105, i32 %_112)
	call void (i32) @print_int(i32 %_111)

	%_113 = load i8*, i8** %_0
	%_114 = bitcast i8* %_113 to i8***
	%_115 = load i8**, i8*** %_114
	%_116 = getelementptr i8*, i8** %_115, i32 17
	%_117 = load i8*, i8** %_116
	%_118 = bitcast i8* %_117 to i32 (i8*, i32)*
	%_120 = add i32 0, 12
	%_119 = call i32 %_118(i8* %_113, i32 %_120)
	call void (i32) @print_int(i32 %_119)

	%_121 = load i8*, i8** %_0
	%_122 = bitcast i8* %_121 to i8***
	%_123 = load i8**, i8*** %_122
	%_124 = getelementptr i8*, i8** %_123, i32 17
	%_125 = load i8*, i8** %_124
	%_126 = bitcast i8* %_125 to i32 (i8*, i32)*
	%_128 = add i32 0, 16
	%_127 = call i32 %_126(i8* %_121, i32 %_128)
	call void (i32) @print_int(i32 %_127)

	%_129 = load i8*, i8** %_0
	%_130 = bitcast i8* %_129 to i8***
	%_131 = load i8**, i8*** %_130
	%_132 = getelementptr i8*, i8** %_131, i32 17
	%_133 = load i8*, i8** %_132
	%_134 = bitcast i8* %_133 to i32 (i8*, i32)*
	%_136 = add i32 0, 50
	%_135 = call i32 %_134(i8* %_129, i32 %_136)
	call void (i32) @print_int(i32 %_135)

	%_137 = load i8*, i8** %_0
	%_138 = bitcast i8* %_137 to i8***
	%_139 = load i8**, i8*** %_138
	%_140 = getelementptr i8*, i8** %_139, i32 17
	%_141 = load i8*, i8** %_140
	%_142 = bitcast i8* %_141 to i32 (i8*, i32)*
	%_144 = add i32 0, 12
	%_143 = call i32 %_142(i8* %_137, i32 %_144)
	call void (i32) @print_int(i32 %_143)
	%_145 = load i1, i1* %_1

	%_146 = load i8*, i8** %_0
	%_147 = bitcast i8* %_146 to i8***
	%_148 = load i8**, i8*** %_147
	%_149 = getelementptr i8*, i8** %_148, i32 13
	%_150 = load i8*, i8** %_149
	%_151 = bitcast i8* %_150 to i1 (i8*, i32)*
	%_153 = add i32 0, 12
	%_152 = call i1 %_151(i8* %_146, i32 %_153)
	
	store i1 %_152, i1* %_1
	%_154 = load i1, i1* %_1

	%_155 = load i8*, i8** %_0
	%_156 = bitcast i8* %_155 to i8***
	%_157 = load i8**, i8*** %_156
	%_158 = getelementptr i8*, i8** %_157, i32 18
	%_159 = load i8*, i8** %_158
	%_160 = bitcast i8* %_159 to i1 (i8*)*
	%_161 = call i1 %_160(i8* %_155)
	
	store i1 %_161, i1* %_1

	%_162 = load i8*, i8** %_0
	%_163 = bitcast i8* %_162 to i8***
	%_164 = load i8**, i8*** %_163
	%_165 = getelementptr i8*, i8** %_164, i32 17
	%_166 = load i8*, i8** %_165
	%_167 = bitcast i8* %_166 to i32 (i8*, i32)*
	%_169 = add i32 0, 12
	%_168 = call i32 %_167(i8* %_162, i32 %_169)
	call void (i32) @print_int(i32 %_168)
	%_170 = add i32 0, 0
	ret i32 %_170
}

define i1 @Tree.Init(i8* %this, i32 %v_key) {
	%__v_key = alloca i32
	store i32 %v_key, i32* %__v_key
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = load i32, i32* %__v_key
	
	store i32 %_3, i32* %_1
	%_4 = getelementptr i8, i8* %this, i32 28
	%_5 = bitcast i8* %_4 to i1*
	%_6 = load i1, i1* %_5
	%_7 = add i1 0, 0
	
	store i1 %_7, i1* %_5
	%_8 = getelementptr i8, i8* %this, i32 29
	%_9 = bitcast i8* %_8 to i1*
	%_10 = load i1, i1* %_9
	%_11 = add i1 0, 0
	
	store i1 %_11, i1* %_9
	%_12 = add i1 0, 1
	ret i1 %_12
}

define i1 @Tree.SetRight(i8* %this, i8* %rn) {
	%__rn = alloca i8*
	store i8* %rn, i8** %__rn
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	%_3 = load i8*, i8** %__rn
	
	store i8* %_3, i8** %_1
	%_4 = add i1 0, 1
	ret i1 %_4
}

define i1 @Tree.SetLeft(i8* %this, i8* %ln) {
	%__ln = alloca i8*
	store i8* %ln, i8** %__ln
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	%_3 = load i8*, i8** %__ln
	
	store i8* %_3, i8** %_1
	%_4 = add i1 0, 1
	ret i1 %_4
}

define i8* @Tree.GetRight(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	ret i8* %_2
}

define i8* @Tree.GetLeft(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	ret i8* %_2
}

define i32 @Tree.GetKey(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i1 @Tree.SetKey(i8* %this, i32 %v_key) {
	%__v_key = alloca i32
	store i32 %v_key, i32* %__v_key
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = load i32, i32* %__v_key
	
	store i32 %_3, i32* %_1
	%_4 = add i1 0, 1
	ret i1 %_4
}

define i1 @Tree.GetHas_Right(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 29
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	ret i1 %_2
}

define i1 @Tree.GetHas_Left(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 28
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	ret i1 %_2
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %val) {
	%__val = alloca i1
	store i1 %val, i1* %__val
	%_0 = getelementptr i8, i8* %this, i32 28
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	%_3 = load i1, i1* %__val
	
	store i1 %_3, i1* %_1
	%_4 = add i1 0, 1
	ret i1 %_4
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %val) {
	%__val = alloca i1
	store i1 %val, i1* %__val
	%_0 = getelementptr i8, i8* %this, i32 29
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	%_3 = load i1, i1* %__val
	
	store i1 %_3, i1* %_1
	%_4 = add i1 0, 1
	ret i1 %_4
}

define i1 @Tree.Compare(i8* %this, i32 %num1, i32 %num2) {
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

define i1 @Tree.Insert(i8* %this, i32 %v_key) {
	%__v_key = alloca i32
	store i32 %v_key, i32* %__v_key

	%_0 = alloca i8*

	%_1 = alloca i1
	store i1 0, i1* %_1

	%_2 = alloca i1
	store i1 0, i1* %_2

	%_3 = alloca i32
	store i32 0, i32* %_3

	%_4 = alloca i8*
	%_5 = load i8*, i8** %_0

	%_6 = add i32 8, 30
	%_7 = call i8* @calloc(i32 %_6, i32 1)
	%_8 = bitcast i8* %_7 to i8***
	%_9 = getelementptr [20 x i8*], [20 x i8*]* @.Tree, i32 0, i32 0
	store i8** %_9, i8*** %_8
	
	store i8* %_7, i8** %_0
	%_10 = load i1, i1* %_1

	%_11 = load i8*, i8** %_0
	%_12 = bitcast i8* %_11 to i8***
	%_13 = load i8**, i8*** %_12
	%_14 = getelementptr i8*, i8** %_13, i32 0
	%_15 = load i8*, i8** %_14
	%_16 = bitcast i8* %_15 to i1 (i8*, i32)*
	%_18 = load i32, i32* %__v_key
	%_17 = call i1 %_16(i8* %_11, i32 %_18)
	
	store i1 %_17, i1* %_1
	%_19 = load i8*, i8** %_4
	
	store i8* %this, i8** %_4
	%_20 = load i1, i1* %_2
	%_21 = add i1 0, 1
	
	store i1 %_21, i1* %_2

	br label %while_0
	while_0:
	%_22 = load i1, i1* %_2
	br i1 %_22, label %continue_0, label %while_end_0
	continue_0:
	%_23 = load i32, i32* %_3

	%_24 = load i8*, i8** %_4
	%_25 = bitcast i8* %_24 to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 5
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i32 (i8*)*
	%_30 = call i32 %_29(i8* %_24)
	
	store i32 %_30, i32* %_3
	%_31 = load i32, i32* %__v_key
	%_32 = load i32, i32* %_3

	%_33 = icmp slt i32 %_31, %_32

	br i1 %_33, label %if_then_1, label %if_else_1

	if_then_1:

	%_34 = load i8*, i8** %_4
	%_35 = bitcast i8* %_34 to i8***
	%_36 = load i8**, i8*** %_35
	%_37 = getelementptr i8*, i8** %_36, i32 8
	%_38 = load i8*, i8** %_37
	%_39 = bitcast i8* %_38 to i1 (i8*)*
	%_40 = call i1 %_39(i8* %_34)

	br i1 %_40, label %if_then_2, label %if_else_2

	if_then_2:
	%_41 = load i8*, i8** %_4

	%_42 = load i8*, i8** %_4
	%_43 = bitcast i8* %_42 to i8***
	%_44 = load i8**, i8*** %_43
	%_45 = getelementptr i8*, i8** %_44, i32 4
	%_46 = load i8*, i8** %_45
	%_47 = bitcast i8* %_46 to i8* (i8*)*
	%_48 = call i8* %_47(i8* %_42)
	
	store i8* %_48, i8** %_4
	br label %if_end_2

	if_else_2:
	%_49 = load i1, i1* %_2
	%_50 = add i1 0, 0
	
	store i1 %_50, i1* %_2
	%_51 = load i1, i1* %_1

	%_52 = load i8*, i8** %_4
	%_53 = bitcast i8* %_52 to i8***
	%_54 = load i8**, i8*** %_53
	%_55 = getelementptr i8*, i8** %_54, i32 9
	%_56 = load i8*, i8** %_55
	%_57 = bitcast i8* %_56 to i1 (i8*, i1)*
	%_59 = add i1 0, 1
	%_58 = call i1 %_57(i8* %_52, i1 %_59)
	
	store i1 %_58, i1* %_1
	%_60 = load i1, i1* %_1

	%_61 = load i8*, i8** %_4
	%_62 = bitcast i8* %_61 to i8***
	%_63 = load i8**, i8*** %_62
	%_64 = getelementptr i8*, i8** %_63, i32 2
	%_65 = load i8*, i8** %_64
	%_66 = bitcast i8* %_65 to i1 (i8*, i8*)*
	%_68 = load i8*, i8** %_0
	%_67 = call i1 %_66(i8* %_61, i8* %_68)
	
	store i1 %_67, i1* %_1

	br label %if_end_2

	if_end_2:
	br label %if_end_1

	if_else_1:

	%_69 = load i8*, i8** %_4
	%_70 = bitcast i8* %_69 to i8***
	%_71 = load i8**, i8*** %_70
	%_72 = getelementptr i8*, i8** %_71, i32 7
	%_73 = load i8*, i8** %_72
	%_74 = bitcast i8* %_73 to i1 (i8*)*
	%_75 = call i1 %_74(i8* %_69)

	br i1 %_75, label %if_then_3, label %if_else_3

	if_then_3:
	%_76 = load i8*, i8** %_4

	%_77 = load i8*, i8** %_4
	%_78 = bitcast i8* %_77 to i8***
	%_79 = load i8**, i8*** %_78
	%_80 = getelementptr i8*, i8** %_79, i32 3
	%_81 = load i8*, i8** %_80
	%_82 = bitcast i8* %_81 to i8* (i8*)*
	%_83 = call i8* %_82(i8* %_77)
	
	store i8* %_83, i8** %_4
	br label %if_end_3

	if_else_3:
	%_84 = load i1, i1* %_2
	%_85 = add i1 0, 0
	
	store i1 %_85, i1* %_2
	%_86 = load i1, i1* %_1

	%_87 = load i8*, i8** %_4
	%_88 = bitcast i8* %_87 to i8***
	%_89 = load i8**, i8*** %_88
	%_90 = getelementptr i8*, i8** %_89, i32 10
	%_91 = load i8*, i8** %_90
	%_92 = bitcast i8* %_91 to i1 (i8*, i1)*
	%_94 = add i1 0, 1
	%_93 = call i1 %_92(i8* %_87, i1 %_94)
	
	store i1 %_93, i1* %_1
	%_95 = load i1, i1* %_1

	%_96 = load i8*, i8** %_4
	%_97 = bitcast i8* %_96 to i8***
	%_98 = load i8**, i8*** %_97
	%_99 = getelementptr i8*, i8** %_98, i32 1
	%_100 = load i8*, i8** %_99
	%_101 = bitcast i8* %_100 to i1 (i8*, i8*)*
	%_103 = load i8*, i8** %_0
	%_102 = call i1 %_101(i8* %_96, i8* %_103)
	
	store i1 %_102, i1* %_1

	br label %if_end_3

	if_end_3:

	br label %if_end_1

	if_end_1:
	br label %while_0

	while_end_0:
	%_104 = add i1 0, 1
	ret i1 %_104
}

define i1 @Tree.Delete(i8* %this, i32 %v_key) {
	%__v_key = alloca i32
	store i32 %v_key, i32* %__v_key

	%_0 = alloca i8*

	%_1 = alloca i8*

	%_2 = alloca i1
	store i1 0, i1* %_2

	%_3 = alloca i1
	store i1 0, i1* %_3

	%_4 = alloca i1
	store i1 0, i1* %_4

	%_5 = alloca i32
	store i32 0, i32* %_5

	%_6 = alloca i1
	store i1 0, i1* %_6
	%_7 = load i8*, i8** %_0
	
	store i8* %this, i8** %_0
	%_8 = load i8*, i8** %_1
	
	store i8* %this, i8** %_1
	%_9 = load i1, i1* %_2
	%_10 = add i1 0, 1
	
	store i1 %_10, i1* %_2
	%_11 = load i1, i1* %_3
	%_12 = add i1 0, 0
	
	store i1 %_12, i1* %_3
	%_13 = load i1, i1* %_4
	%_14 = add i1 0, 1
	
	store i1 %_14, i1* %_4

	br label %while_0
	while_0:
	%_15 = load i1, i1* %_2
	br i1 %_15, label %continue_0, label %while_end_0
	continue_0:
	%_16 = load i32, i32* %_5

	%_17 = load i8*, i8** %_0
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 5
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i32 (i8*)*
	%_23 = call i32 %_22(i8* %_17)
	
	store i32 %_23, i32* %_5
	%_24 = load i32, i32* %__v_key
	%_25 = load i32, i32* %_5

	%_26 = icmp slt i32 %_24, %_25

	br i1 %_26, label %if_then_1, label %if_else_1

	if_then_1:

	%_27 = load i8*, i8** %_0
	%_28 = bitcast i8* %_27 to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 8
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i1 (i8*)*
	%_33 = call i1 %_32(i8* %_27)

	br i1 %_33, label %if_then_2, label %if_else_2

	if_then_2:
	%_34 = load i8*, i8** %_1
	%_35 = load i8*, i8** %_0
	
	store i8* %_35, i8** %_1
	%_36 = load i8*, i8** %_0

	%_37 = load i8*, i8** %_0
	%_38 = bitcast i8* %_37 to i8***
	%_39 = load i8**, i8*** %_38
	%_40 = getelementptr i8*, i8** %_39, i32 4
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i8* (i8*)*
	%_43 = call i8* %_42(i8* %_37)
	
	store i8* %_43, i8** %_0
	br label %if_end_2

	if_else_2:
	%_44 = load i1, i1* %_2
	%_45 = add i1 0, 0
	
	store i1 %_45, i1* %_2

	br label %if_end_2

	if_end_2:
	br label %if_end_1

	if_else_1:
	%_46 = load i32, i32* %_5
	%_47 = load i32, i32* %__v_key

	%_48 = icmp slt i32 %_46, %_47

	br i1 %_48, label %if_then_3, label %if_else_3

	if_then_3:

	%_49 = load i8*, i8** %_0
	%_50 = bitcast i8* %_49 to i8***
	%_51 = load i8**, i8*** %_50
	%_52 = getelementptr i8*, i8** %_51, i32 7
	%_53 = load i8*, i8** %_52
	%_54 = bitcast i8* %_53 to i1 (i8*)*
	%_55 = call i1 %_54(i8* %_49)

	br i1 %_55, label %if_then_4, label %if_else_4

	if_then_4:
	%_56 = load i8*, i8** %_1
	%_57 = load i8*, i8** %_0
	
	store i8* %_57, i8** %_1
	%_58 = load i8*, i8** %_0

	%_59 = load i8*, i8** %_0
	%_60 = bitcast i8* %_59 to i8***
	%_61 = load i8**, i8*** %_60
	%_62 = getelementptr i8*, i8** %_61, i32 3
	%_63 = load i8*, i8** %_62
	%_64 = bitcast i8* %_63 to i8* (i8*)*
	%_65 = call i8* %_64(i8* %_59)
	
	store i8* %_65, i8** %_0
	br label %if_end_4

	if_else_4:
	%_66 = load i1, i1* %_2
	%_67 = add i1 0, 0
	
	store i1 %_67, i1* %_2

	br label %if_end_4

	if_end_4:
	br label %if_end_3

	if_else_3:
	%_68 = load i1, i1* %_4

	br i1 %_68, label %if_then_5, label %if_else_5

	if_then_5:

	%_69 = load i8*, i8** %_0
	%_70 = bitcast i8* %_69 to i8***
	%_71 = load i8**, i8*** %_70
	%_72 = getelementptr i8*, i8** %_71, i32 7
	%_73 = load i8*, i8** %_72
	%_74 = bitcast i8* %_73 to i1 (i8*)*
	%_75 = call i1 %_74(i8* %_69)

	%_76 = xor i1 1, %_75

	br i1 %_76, label %exp_and_7, label %exp_and_6

	exp_and_6:
	br label %exp_and_9

	exp_and_7:

	%_77 = load i8*, i8** %_0
	%_78 = bitcast i8* %_77 to i8***
	%_79 = load i8**, i8*** %_78
	%_80 = getelementptr i8*, i8** %_79, i32 8
	%_81 = load i8*, i8** %_80
	%_82 = bitcast i8* %_81 to i1 (i8*)*
	%_83 = call i1 %_82(i8* %_77)

	%_84 = xor i1 1, %_83
	br label %exp_and_8

	exp_and_8:
	br label %exp_and_9
	exp_and_9:
	%_85 = phi i1 [ %_76, %exp_and_6 ], [ %_84, %exp_and_8 ]


	br i1 %_85, label %if_then_10, label %if_else_10

	if_then_10:
	%_86 = load i1, i1* %_6
	%_87 = add i1 0, 1
	
	store i1 %_87, i1* %_6
	br label %if_end_10

	if_else_10:
	%_88 = load i1, i1* %_6

	%_89 = bitcast i8* %this to i8***
	%_90 = load i8**, i8*** %_89
	%_91 = getelementptr i8*, i8** %_90, i32 14
	%_92 = load i8*, i8** %_91
	%_93 = bitcast i8* %_92 to i1 (i8*, i8*, i8*)*
	%_95 = load i8*, i8** %_1
	%_96 = load i8*, i8** %_0
	%_94 = call i1 %_93(i8* %this, i8* %_95, i8* %_96)
	
	store i1 %_94, i1* %_6

	br label %if_end_10

	if_end_10:
	br label %if_end_5

	if_else_5:
	%_97 = load i1, i1* %_6

	%_98 = bitcast i8* %this to i8***
	%_99 = load i8**, i8*** %_98
	%_100 = getelementptr i8*, i8** %_99, i32 14
	%_101 = load i8*, i8** %_100
	%_102 = bitcast i8* %_101 to i1 (i8*, i8*, i8*)*
	%_104 = load i8*, i8** %_1
	%_105 = load i8*, i8** %_0
	%_103 = call i1 %_102(i8* %this, i8* %_104, i8* %_105)
	
	store i1 %_103, i1* %_6

	br label %if_end_5

	if_end_5:
	%_106 = load i1, i1* %_3
	%_107 = add i1 0, 1
	
	store i1 %_107, i1* %_3
	%_108 = load i1, i1* %_2
	%_109 = add i1 0, 0
	
	store i1 %_109, i1* %_2

	br label %if_end_3

	if_end_3:

	br label %if_end_1

	if_end_1:
	%_110 = load i1, i1* %_4
	%_111 = add i1 0, 0
	
	store i1 %_111, i1* %_4
	br label %while_0

	while_end_0:
	%_112 = load i1, i1* %_3
	ret i1 %_112
}

define i1 @Tree.Remove(i8* %this, i8* %p_node, i8* %c_node) {
	%__p_node = alloca i8*
	store i8* %p_node, i8** %__p_node
	%__c_node = alloca i8*
	store i8* %c_node, i8** %__c_node

	%_0 = alloca i1
	store i1 0, i1* %_0

	%_1 = alloca i32
	store i32 0, i32* %_1

	%_2 = alloca i32
	store i32 0, i32* %_2

	%_3 = load i8*, i8** %__c_node
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 8
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)

	br i1 %_9, label %if_then_0, label %if_else_0

	if_then_0:
	%_10 = load i1, i1* %_0

	%_11 = bitcast i8* %this to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 16
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*, i8*, i8*)*
	%_17 = load i8*, i8** %__p_node
	%_18 = load i8*, i8** %__c_node
	%_16 = call i1 %_15(i8* %this, i8* %_17, i8* %_18)
	
	store i1 %_16, i1* %_0
	br label %if_end_0

	if_else_0:

	%_19 = load i8*, i8** %__c_node
	%_20 = bitcast i8* %_19 to i8***
	%_21 = load i8**, i8*** %_20
	%_22 = getelementptr i8*, i8** %_21, i32 7
	%_23 = load i8*, i8** %_22
	%_24 = bitcast i8* %_23 to i1 (i8*)*
	%_25 = call i1 %_24(i8* %_19)

	br i1 %_25, label %if_then_1, label %if_else_1

	if_then_1:
	%_26 = load i1, i1* %_0

	%_27 = bitcast i8* %this to i8***
	%_28 = load i8**, i8*** %_27
	%_29 = getelementptr i8*, i8** %_28, i32 15
	%_30 = load i8*, i8** %_29
	%_31 = bitcast i8* %_30 to i1 (i8*, i8*, i8*)*
	%_33 = load i8*, i8** %__p_node
	%_34 = load i8*, i8** %__c_node
	%_32 = call i1 %_31(i8* %this, i8* %_33, i8* %_34)
	
	store i1 %_32, i1* %_0
	br label %if_end_1

	if_else_1:
	%_35 = load i32, i32* %_1

	%_36 = load i8*, i8** %__c_node
	%_37 = bitcast i8* %_36 to i8***
	%_38 = load i8**, i8*** %_37
	%_39 = getelementptr i8*, i8** %_38, i32 5
	%_40 = load i8*, i8** %_39
	%_41 = bitcast i8* %_40 to i32 (i8*)*
	%_42 = call i32 %_41(i8* %_36)
	
	store i32 %_42, i32* %_1
	%_43 = load i32, i32* %_2

	%_44 = load i8*, i8** %__p_node
	%_45 = bitcast i8* %_44 to i8***
	%_46 = load i8**, i8*** %_45
	%_47 = getelementptr i8*, i8** %_46, i32 4
	%_48 = load i8*, i8** %_47
	%_49 = bitcast i8* %_48 to i8* (i8*)*
	%_50 = call i8* %_49(i8* %_44)

	%_51 = bitcast i8* %_50 to i8***
	%_52 = load i8**, i8*** %_51
	%_53 = getelementptr i8*, i8** %_52, i32 5
	%_54 = load i8*, i8** %_53
	%_55 = bitcast i8* %_54 to i32 (i8*)*
	%_56 = call i32 %_55(i8* %_50)
	
	store i32 %_56, i32* %_2

	%_57 = bitcast i8* %this to i8***
	%_58 = load i8**, i8*** %_57
	%_59 = getelementptr i8*, i8** %_58, i32 11
	%_60 = load i8*, i8** %_59
	%_61 = bitcast i8* %_60 to i1 (i8*, i32, i32)*
	%_63 = load i32, i32* %_1
	%_64 = load i32, i32* %_2
	%_62 = call i1 %_61(i8* %this, i32 %_63, i32 %_64)

	br i1 %_62, label %if_then_2, label %if_else_2

	if_then_2:
	%_65 = load i1, i1* %_0

	%_66 = load i8*, i8** %__p_node
	%_67 = bitcast i8* %_66 to i8***
	%_68 = load i8**, i8*** %_67
	%_69 = getelementptr i8*, i8** %_68, i32 2
	%_70 = load i8*, i8** %_69
	%_71 = bitcast i8* %_70 to i1 (i8*, i8*)*
	%_73 = getelementptr i8, i8* %this, i32 30
	%_74 = bitcast i8* %_73 to i8**
	%_75 = load i8*, i8** %_74
	%_72 = call i1 %_71(i8* %_66, i8* %_75)
	
	store i1 %_72, i1* %_0
	%_76 = load i1, i1* %_0

	%_77 = load i8*, i8** %__p_node
	%_78 = bitcast i8* %_77 to i8***
	%_79 = load i8**, i8*** %_78
	%_80 = getelementptr i8*, i8** %_79, i32 9
	%_81 = load i8*, i8** %_80
	%_82 = bitcast i8* %_81 to i1 (i8*, i1)*
	%_84 = add i1 0, 0
	%_83 = call i1 %_82(i8* %_77, i1 %_84)
	
	store i1 %_83, i1* %_0
	br label %if_end_2

	if_else_2:
	%_85 = load i1, i1* %_0

	%_86 = load i8*, i8** %__p_node
	%_87 = bitcast i8* %_86 to i8***
	%_88 = load i8**, i8*** %_87
	%_89 = getelementptr i8*, i8** %_88, i32 1
	%_90 = load i8*, i8** %_89
	%_91 = bitcast i8* %_90 to i1 (i8*, i8*)*
	%_93 = getelementptr i8, i8* %this, i32 30
	%_94 = bitcast i8* %_93 to i8**
	%_95 = load i8*, i8** %_94
	%_92 = call i1 %_91(i8* %_86, i8* %_95)
	
	store i1 %_92, i1* %_0
	%_96 = load i1, i1* %_0

	%_97 = load i8*, i8** %__p_node
	%_98 = bitcast i8* %_97 to i8***
	%_99 = load i8**, i8*** %_98
	%_100 = getelementptr i8*, i8** %_99, i32 10
	%_101 = load i8*, i8** %_100
	%_102 = bitcast i8* %_101 to i1 (i8*, i1)*
	%_104 = add i1 0, 0
	%_103 = call i1 %_102(i8* %_97, i1 %_104)
	
	store i1 %_103, i1* %_0

	br label %if_end_2

	if_end_2:

	br label %if_end_1

	if_end_1:

	br label %if_end_0

	if_end_0:
	%_105 = add i1 0, 1
	ret i1 %_105
}

define i1 @Tree.RemoveRight(i8* %this, i8* %p_node, i8* %c_node) {
	%__p_node = alloca i8*
	store i8* %p_node, i8** %__p_node
	%__c_node = alloca i8*
	store i8* %c_node, i8** %__c_node

	%_0 = alloca i1
	store i1 0, i1* %_0

	br label %while_0
	while_0:

	%_1 = load i8*, i8** %__c_node
	%_2 = bitcast i8* %_1 to i8***
	%_3 = load i8**, i8*** %_2
	%_4 = getelementptr i8*, i8** %_3, i32 7
	%_5 = load i8*, i8** %_4
	%_6 = bitcast i8* %_5 to i1 (i8*)*
	%_7 = call i1 %_6(i8* %_1)
	br i1 %_7, label %continue_0, label %while_end_0
	continue_0:
	%_8 = load i1, i1* %_0

	%_9 = load i8*, i8** %__c_node
	%_10 = bitcast i8* %_9 to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 6
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i1 (i8*, i32)*

	%_16 = load i8*, i8** %__c_node
	%_17 = bitcast i8* %_16 to i8***
	%_18 = load i8**, i8*** %_17
	%_19 = getelementptr i8*, i8** %_18, i32 3
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i8* (i8*)*
	%_22 = call i8* %_21(i8* %_16)

	%_23 = bitcast i8* %_22 to i8***
	%_24 = load i8**, i8*** %_23
	%_25 = getelementptr i8*, i8** %_24, i32 5
	%_26 = load i8*, i8** %_25
	%_27 = bitcast i8* %_26 to i32 (i8*)*
	%_28 = call i32 %_27(i8* %_22)
	%_15 = call i1 %_14(i8* %_9, i32 %_28)
	
	store i1 %_15, i1* %_0
	%_29 = load i8*, i8** %__p_node
	%_30 = load i8*, i8** %__c_node
	
	store i8* %_30, i8** %__p_node
	%_31 = load i8*, i8** %__c_node

	%_32 = load i8*, i8** %__c_node
	%_33 = bitcast i8* %_32 to i8***
	%_34 = load i8**, i8*** %_33
	%_35 = getelementptr i8*, i8** %_34, i32 3
	%_36 = load i8*, i8** %_35
	%_37 = bitcast i8* %_36 to i8* (i8*)*
	%_38 = call i8* %_37(i8* %_32)
	
	store i8* %_38, i8** %__c_node
	br label %while_0

	while_end_0:
	%_39 = load i1, i1* %_0

	%_40 = load i8*, i8** %__p_node
	%_41 = bitcast i8* %_40 to i8***
	%_42 = load i8**, i8*** %_41
	%_43 = getelementptr i8*, i8** %_42, i32 1
	%_44 = load i8*, i8** %_43
	%_45 = bitcast i8* %_44 to i1 (i8*, i8*)*
	%_47 = getelementptr i8, i8* %this, i32 30
	%_48 = bitcast i8* %_47 to i8**
	%_49 = load i8*, i8** %_48
	%_46 = call i1 %_45(i8* %_40, i8* %_49)
	
	store i1 %_46, i1* %_0
	%_50 = load i1, i1* %_0

	%_51 = load i8*, i8** %__p_node
	%_52 = bitcast i8* %_51 to i8***
	%_53 = load i8**, i8*** %_52
	%_54 = getelementptr i8*, i8** %_53, i32 10
	%_55 = load i8*, i8** %_54
	%_56 = bitcast i8* %_55 to i1 (i8*, i1)*
	%_58 = add i1 0, 0
	%_57 = call i1 %_56(i8* %_51, i1 %_58)
	
	store i1 %_57, i1* %_0
	%_59 = add i1 0, 1
	ret i1 %_59
}

define i1 @Tree.RemoveLeft(i8* %this, i8* %p_node, i8* %c_node) {
	%__p_node = alloca i8*
	store i8* %p_node, i8** %__p_node
	%__c_node = alloca i8*
	store i8* %c_node, i8** %__c_node

	%_0 = alloca i1
	store i1 0, i1* %_0

	br label %while_0
	while_0:

	%_1 = load i8*, i8** %__c_node
	%_2 = bitcast i8* %_1 to i8***
	%_3 = load i8**, i8*** %_2
	%_4 = getelementptr i8*, i8** %_3, i32 8
	%_5 = load i8*, i8** %_4
	%_6 = bitcast i8* %_5 to i1 (i8*)*
	%_7 = call i1 %_6(i8* %_1)
	br i1 %_7, label %continue_0, label %while_end_0
	continue_0:
	%_8 = load i1, i1* %_0

	%_9 = load i8*, i8** %__c_node
	%_10 = bitcast i8* %_9 to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 6
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i1 (i8*, i32)*

	%_16 = load i8*, i8** %__c_node
	%_17 = bitcast i8* %_16 to i8***
	%_18 = load i8**, i8*** %_17
	%_19 = getelementptr i8*, i8** %_18, i32 4
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i8* (i8*)*
	%_22 = call i8* %_21(i8* %_16)

	%_23 = bitcast i8* %_22 to i8***
	%_24 = load i8**, i8*** %_23
	%_25 = getelementptr i8*, i8** %_24, i32 5
	%_26 = load i8*, i8** %_25
	%_27 = bitcast i8* %_26 to i32 (i8*)*
	%_28 = call i32 %_27(i8* %_22)
	%_15 = call i1 %_14(i8* %_9, i32 %_28)
	
	store i1 %_15, i1* %_0
	%_29 = load i8*, i8** %__p_node
	%_30 = load i8*, i8** %__c_node
	
	store i8* %_30, i8** %__p_node
	%_31 = load i8*, i8** %__c_node

	%_32 = load i8*, i8** %__c_node
	%_33 = bitcast i8* %_32 to i8***
	%_34 = load i8**, i8*** %_33
	%_35 = getelementptr i8*, i8** %_34, i32 4
	%_36 = load i8*, i8** %_35
	%_37 = bitcast i8* %_36 to i8* (i8*)*
	%_38 = call i8* %_37(i8* %_32)
	
	store i8* %_38, i8** %__c_node
	br label %while_0

	while_end_0:
	%_39 = load i1, i1* %_0

	%_40 = load i8*, i8** %__p_node
	%_41 = bitcast i8* %_40 to i8***
	%_42 = load i8**, i8*** %_41
	%_43 = getelementptr i8*, i8** %_42, i32 2
	%_44 = load i8*, i8** %_43
	%_45 = bitcast i8* %_44 to i1 (i8*, i8*)*
	%_47 = getelementptr i8, i8* %this, i32 30
	%_48 = bitcast i8* %_47 to i8**
	%_49 = load i8*, i8** %_48
	%_46 = call i1 %_45(i8* %_40, i8* %_49)
	
	store i1 %_46, i1* %_0
	%_50 = load i1, i1* %_0

	%_51 = load i8*, i8** %__p_node
	%_52 = bitcast i8* %_51 to i8***
	%_53 = load i8**, i8*** %_52
	%_54 = getelementptr i8*, i8** %_53, i32 9
	%_55 = load i8*, i8** %_54
	%_56 = bitcast i8* %_55 to i1 (i8*, i1)*
	%_58 = add i1 0, 0
	%_57 = call i1 %_56(i8* %_51, i1 %_58)
	
	store i1 %_57, i1* %_0
	%_59 = add i1 0, 1
	ret i1 %_59
}

define i32 @Tree.Search(i8* %this, i32 %v_key) {
	%__v_key = alloca i32
	store i32 %v_key, i32* %__v_key

	%_0 = alloca i1
	store i1 0, i1* %_0

	%_1 = alloca i32
	store i32 0, i32* %_1

	%_2 = alloca i8*

	%_3 = alloca i32
	store i32 0, i32* %_3
	%_4 = load i8*, i8** %_2
	
	store i8* %this, i8** %_2
	%_5 = load i1, i1* %_0
	%_6 = add i1 0, 1
	
	store i1 %_6, i1* %_0
	%_7 = load i32, i32* %_1
	%_8 = add i32 0, 0
	
	store i32 %_8, i32* %_1

	br label %while_0
	while_0:
	%_9 = load i1, i1* %_0
	br i1 %_9, label %continue_0, label %while_end_0
	continue_0:
	%_10 = load i32, i32* %_3

	%_11 = load i8*, i8** %_2
	%_12 = bitcast i8* %_11 to i8***
	%_13 = load i8**, i8*** %_12
	%_14 = getelementptr i8*, i8** %_13, i32 5
	%_15 = load i8*, i8** %_14
	%_16 = bitcast i8* %_15 to i32 (i8*)*
	%_17 = call i32 %_16(i8* %_11)
	
	store i32 %_17, i32* %_3
	%_18 = load i32, i32* %__v_key
	%_19 = load i32, i32* %_3

	%_20 = icmp slt i32 %_18, %_19

	br i1 %_20, label %if_then_1, label %if_else_1

	if_then_1:

	%_21 = load i8*, i8** %_2
	%_22 = bitcast i8* %_21 to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 8
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i1 (i8*)*
	%_27 = call i1 %_26(i8* %_21)

	br i1 %_27, label %if_then_2, label %if_else_2

	if_then_2:
	%_28 = load i8*, i8** %_2

	%_29 = load i8*, i8** %_2
	%_30 = bitcast i8* %_29 to i8***
	%_31 = load i8**, i8*** %_30
	%_32 = getelementptr i8*, i8** %_31, i32 4
	%_33 = load i8*, i8** %_32
	%_34 = bitcast i8* %_33 to i8* (i8*)*
	%_35 = call i8* %_34(i8* %_29)
	
	store i8* %_35, i8** %_2
	br label %if_end_2

	if_else_2:
	%_36 = load i1, i1* %_0
	%_37 = add i1 0, 0
	
	store i1 %_37, i1* %_0

	br label %if_end_2

	if_end_2:
	br label %if_end_1

	if_else_1:
	%_38 = load i32, i32* %_3
	%_39 = load i32, i32* %__v_key

	%_40 = icmp slt i32 %_38, %_39

	br i1 %_40, label %if_then_3, label %if_else_3

	if_then_3:

	%_41 = load i8*, i8** %_2
	%_42 = bitcast i8* %_41 to i8***
	%_43 = load i8**, i8*** %_42
	%_44 = getelementptr i8*, i8** %_43, i32 7
	%_45 = load i8*, i8** %_44
	%_46 = bitcast i8* %_45 to i1 (i8*)*
	%_47 = call i1 %_46(i8* %_41)

	br i1 %_47, label %if_then_4, label %if_else_4

	if_then_4:
	%_48 = load i8*, i8** %_2

	%_49 = load i8*, i8** %_2
	%_50 = bitcast i8* %_49 to i8***
	%_51 = load i8**, i8*** %_50
	%_52 = getelementptr i8*, i8** %_51, i32 3
	%_53 = load i8*, i8** %_52
	%_54 = bitcast i8* %_53 to i8* (i8*)*
	%_55 = call i8* %_54(i8* %_49)
	
	store i8* %_55, i8** %_2
	br label %if_end_4

	if_else_4:
	%_56 = load i1, i1* %_0
	%_57 = add i1 0, 0
	
	store i1 %_57, i1* %_0

	br label %if_end_4

	if_end_4:
	br label %if_end_3

	if_else_3:
	%_58 = load i32, i32* %_1
	%_59 = add i32 0, 1
	
	store i32 %_59, i32* %_1
	%_60 = load i1, i1* %_0
	%_61 = add i1 0, 0
	
	store i1 %_61, i1* %_0

	br label %if_end_3

	if_end_3:

	br label %if_end_1

	if_end_1:
	br label %while_0

	while_end_0:
	%_62 = load i32, i32* %_1
	ret i32 %_62
}

define i1 @Tree.Print(i8* %this) {

	%_0 = alloca i8*

	%_1 = alloca i1
	store i1 0, i1* %_1
	%_2 = load i8*, i8** %_0
	
	store i8* %this, i8** %_0
	%_3 = load i1, i1* %_1

	%_4 = bitcast i8* %this to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 19
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*, i8*)*
	%_10 = load i8*, i8** %_0
	%_9 = call i1 %_8(i8* %this, i8* %_10)
	
	store i1 %_9, i1* %_1
	%_11 = add i1 0, 1
	ret i1 %_11
}

define i1 @Tree.RecPrint(i8* %this, i8* %node) {
	%__node = alloca i8*
	store i8* %node, i8** %__node

	%_0 = alloca i1
	store i1 0, i1* %_0

	%_1 = load i8*, i8** %__node
	%_2 = bitcast i8* %_1 to i8***
	%_3 = load i8**, i8*** %_2
	%_4 = getelementptr i8*, i8** %_3, i32 8
	%_5 = load i8*, i8** %_4
	%_6 = bitcast i8* %_5 to i1 (i8*)*
	%_7 = call i1 %_6(i8* %_1)

	br i1 %_7, label %if_then_0, label %if_else_0

	if_then_0:
	%_8 = load i1, i1* %_0

	%_9 = bitcast i8* %this to i8***
	%_10 = load i8**, i8*** %_9
	%_11 = getelementptr i8*, i8** %_10, i32 19
	%_12 = load i8*, i8** %_11
	%_13 = bitcast i8* %_12 to i1 (i8*, i8*)*

	%_15 = load i8*, i8** %__node
	%_16 = bitcast i8* %_15 to i8***
	%_17 = load i8**, i8*** %_16
	%_18 = getelementptr i8*, i8** %_17, i32 4
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i8* (i8*)*
	%_21 = call i8* %_20(i8* %_15)
	%_14 = call i1 %_13(i8* %this, i8* %_21)
	
	store i1 %_14, i1* %_0
	br label %if_end_0

	if_else_0:
	%_22 = load i1, i1* %_0
	%_23 = add i1 0, 1
	
	store i1 %_23, i1* %_0

	br label %if_end_0

	if_end_0:

	%_24 = load i8*, i8** %__node
	%_25 = bitcast i8* %_24 to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 5
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i32 (i8*)*
	%_30 = call i32 %_29(i8* %_24)
	call void (i32) @print_int(i32 %_30)

	%_31 = load i8*, i8** %__node
	%_32 = bitcast i8* %_31 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 7
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i1 (i8*)*
	%_37 = call i1 %_36(i8* %_31)

	br i1 %_37, label %if_then_1, label %if_else_1

	if_then_1:
	%_38 = load i1, i1* %_0

	%_39 = bitcast i8* %this to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 19
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*, i8*)*

	%_45 = load i8*, i8** %__node
	%_46 = bitcast i8* %_45 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 3
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i8* (i8*)*
	%_51 = call i8* %_50(i8* %_45)
	%_44 = call i1 %_43(i8* %this, i8* %_51)
	
	store i1 %_44, i1* %_0
	br label %if_end_1

	if_else_1:
	%_52 = load i1, i1* %_0
	%_53 = add i1 0, 1
	
	store i1 %_53, i1* %_0

	br label %if_end_1

	if_end_1:
	%_54 = add i1 0, 1
	ret i1 %_54
}
