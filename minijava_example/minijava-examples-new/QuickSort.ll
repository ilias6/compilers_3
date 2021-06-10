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


@.QuickSort = global [0 x i8*] []

@.QS = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @QS.Start to i8*),
	i8* bitcast (i32 (i8*, i32, i32)* @QS.Sort to i8*),
	i8* bitcast (i32 (i8*)* @QS.Print to i8*),
	i8* bitcast (i32 (i8*, i32)* @QS.Init to i8*)]


define i32 @main (i8** %a) {

	%_0 = add i32 8, 12
	%_1 = call i8* @calloc(i32 %_0, i32 1)
	%_2 = bitcast i8* %_1 to i8***
	%_3 = getelementptr [4 x i8*], [4 x i8*]* @.QS, i32 0, i32 0
	store i8** %_3, i8*** %_2

	%_4 = bitcast i8* %_1 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*, i32)*
	%_10 = add i32 0, 10
	%_9 = call i32 %_8(i8* %_1, i32 %_10)
	call void (i32) @print_int(i32 %_9)

	ret i32 0
}


define i32 @QS.Start(i8* %this, i32 %sz) {
	%__sz = alloca i32
	store i32 %sz, i32* %__sz

	%_0 = alloca i32
	store i32 0, i32* %_0
	%_1 = load i32, i32* %_0

	%_2 = bitcast i8* %this to i8***
	%_3 = load i8**, i8*** %_2
	%_4 = getelementptr i8*, i8** %_3, i32 3
	%_5 = load i8*, i8** %_4
	%_6 = bitcast i8* %_5 to i32 (i8*, i32)*
	%_8 = load i32, i32* %__sz
	%_7 = call i32 %_6(i8* %this, i32 %_8)
	
	store i32 %_7, i32* %_0
	%_9 = load i32, i32* %_0

	%_10 = bitcast i8* %this to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 2
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i32 (i8*)*
	%_15 = call i32 %_14(i8* %this)
	
	store i32 %_15, i32* %_0
	%_16 = add i32 0, 9999
	call void (i32) @print_int(i32 %_16)
	%_17 = load i32, i32* %_0
	%_18 = getelementptr i8, i8* %this, i32 16
	%_19 = bitcast i8* %_18 to i32*
	%_20 = load i32, i32* %_19
	%_21 = add i32 0, 1

	%_22 = sub i32 %_20, %_21
	
	store i32 %_22, i32* %_0
	%_23 = load i32, i32* %_0

	%_24 = bitcast i8* %this to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 1
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*, i32, i32)*
	%_30 = add i32 0, 0
	%_31 = load i32, i32* %_0
	%_29 = call i32 %_28(i8* %this, i32 %_30, i32 %_31)
	
	store i32 %_29, i32* %_0
	%_32 = load i32, i32* %_0

	%_33 = bitcast i8* %this to i8***
	%_34 = load i8**, i8*** %_33
	%_35 = getelementptr i8*, i8** %_34, i32 2
	%_36 = load i8*, i8** %_35
	%_37 = bitcast i8* %_36 to i32 (i8*)*
	%_38 = call i32 %_37(i8* %this)
	
	store i32 %_38, i32* %_0
	%_39 = add i32 0, 0
	ret i32 %_39
}

define i32 @QS.Sort(i8* %this, i32 %left, i32 %right) {
	%__left = alloca i32
	store i32 %left, i32* %__left
	%__right = alloca i32
	store i32 %right, i32* %__right

	%_0 = alloca i32
	store i32 0, i32* %_0

	%_1 = alloca i32
	store i32 0, i32* %_1

	%_2 = alloca i32
	store i32 0, i32* %_2

	%_3 = alloca i32
	store i32 0, i32* %_3

	%_4 = alloca i32
	store i32 0, i32* %_4

	%_5 = alloca i1
	store i1 0, i1* %_5

	%_6 = alloca i1
	store i1 0, i1* %_6

	%_7 = alloca i32
	store i32 0, i32* %_7
	%_8 = load i32, i32* %_4
	%_9 = add i32 0, 0
	
	store i32 %_9, i32* %_4
	%_10 = load i32, i32* %__left
	%_11 = load i32, i32* %__right

	%_12 = icmp slt i32 %_10, %_11

	br i1 %_12, label %if_then_0, label %if_else_0

	if_then_0:
	%_13 = load i32, i32* %_0
	%_14 = getelementptr i8, i8* %this, i32 8
	%_15 = bitcast i8* %_14 to i32**
	%_16 = load i32*, i32** %_15
	%_17 = load i32, i32* %__right

	%_18 = load i32, i32* %_16
	%_19 = icmp slt i32 %_17, %_18
	%_20 = icmp slt i32 -1, %_17
	%_21 = xor i1 %_19, %_20
	br i1 %_21, label %indexing_error_1, label %indexing_ok_1
	indexing_error_1:
	call void @throw_oob()
	br label %indexing_ok_1
	indexing_ok_1:
	%_22 = add i32 %_17, 1
	%_23 = getelementptr i32, i32* %_16, i32 %_22
	%_24 = load i32, i32* %_23
	
	store i32 %_24, i32* %_0
	%_25 = load i32, i32* %_1
	%_26 = load i32, i32* %__left
	%_27 = add i32 0, 1

	%_28 = sub i32 %_26, %_27
	
	store i32 %_28, i32* %_1
	%_29 = load i32, i32* %_2
	%_30 = load i32, i32* %__right
	
	store i32 %_30, i32* %_2
	%_31 = load i1, i1* %_5
	%_32 = add i1 0, 1
	
	store i1 %_32, i1* %_5

	br label %while_2
	while_2:
	%_33 = load i1, i1* %_5
	br i1 %_33, label %continue_2, label %while_end_2
	continue_2:
	%_34 = load i1, i1* %_6
	%_35 = add i1 0, 1
	
	store i1 %_35, i1* %_6

	br label %while_3
	while_3:
	%_36 = load i1, i1* %_6
	br i1 %_36, label %continue_3, label %while_end_3
	continue_3:
	%_37 = load i32, i32* %_1
	%_38 = load i32, i32* %_1
	%_39 = add i32 0, 1

	%_40 = add i32 %_38, %_39
	
	store i32 %_40, i32* %_1
	%_41 = load i32, i32* %_7
	%_42 = getelementptr i8, i8* %this, i32 8
	%_43 = bitcast i8* %_42 to i32**
	%_44 = load i32*, i32** %_43
	%_45 = load i32, i32* %_1

	%_46 = load i32, i32* %_44
	%_47 = icmp slt i32 %_45, %_46
	%_48 = icmp slt i32 -1, %_45
	%_49 = xor i1 %_47, %_48
	br i1 %_49, label %indexing_error_4, label %indexing_ok_4
	indexing_error_4:
	call void @throw_oob()
	br label %indexing_ok_4
	indexing_ok_4:
	%_50 = add i32 %_45, 1
	%_51 = getelementptr i32, i32* %_44, i32 %_50
	%_52 = load i32, i32* %_51
	
	store i32 %_52, i32* %_7
	%_53 = load i32, i32* %_7
	%_54 = load i32, i32* %_0

	%_55 = icmp slt i32 %_53, %_54

	%_56 = xor i1 1, %_55

	br i1 %_56, label %if_then_5, label %if_else_5

	if_then_5:
	%_57 = load i1, i1* %_6
	%_58 = add i1 0, 0
	
	store i1 %_58, i1* %_6
	br label %if_end_5

	if_else_5:
	%_59 = load i1, i1* %_6
	%_60 = add i1 0, 1
	
	store i1 %_60, i1* %_6

	br label %if_end_5

	if_end_5:
	br label %while_3

	while_end_3:
	%_61 = load i1, i1* %_6
	%_62 = add i1 0, 1
	
	store i1 %_62, i1* %_6

	br label %while_6
	while_6:
	%_63 = load i1, i1* %_6
	br i1 %_63, label %continue_6, label %while_end_6
	continue_6:
	%_64 = load i32, i32* %_2
	%_65 = load i32, i32* %_2
	%_66 = add i32 0, 1

	%_67 = sub i32 %_65, %_66
	
	store i32 %_67, i32* %_2
	%_68 = load i32, i32* %_7
	%_69 = getelementptr i8, i8* %this, i32 8
	%_70 = bitcast i8* %_69 to i32**
	%_71 = load i32*, i32** %_70
	%_72 = load i32, i32* %_2

	%_73 = load i32, i32* %_71
	%_74 = icmp slt i32 %_72, %_73
	%_75 = icmp slt i32 -1, %_72
	%_76 = xor i1 %_74, %_75
	br i1 %_76, label %indexing_error_7, label %indexing_ok_7
	indexing_error_7:
	call void @throw_oob()
	br label %indexing_ok_7
	indexing_ok_7:
	%_77 = add i32 %_72, 1
	%_78 = getelementptr i32, i32* %_71, i32 %_77
	%_79 = load i32, i32* %_78
	
	store i32 %_79, i32* %_7
	%_80 = load i32, i32* %_0
	%_81 = load i32, i32* %_7

	%_82 = icmp slt i32 %_80, %_81

	%_83 = xor i1 1, %_82

	br i1 %_83, label %if_then_8, label %if_else_8

	if_then_8:
	%_84 = load i1, i1* %_6
	%_85 = add i1 0, 0
	
	store i1 %_85, i1* %_6
	br label %if_end_8

	if_else_8:
	%_86 = load i1, i1* %_6
	%_87 = add i1 0, 1
	
	store i1 %_87, i1* %_6

	br label %if_end_8

	if_end_8:
	br label %while_6

	while_end_6:
	%_88 = load i32, i32* %_4
	%_89 = getelementptr i8, i8* %this, i32 8
	%_90 = bitcast i8* %_89 to i32**
	%_91 = load i32*, i32** %_90
	%_92 = load i32, i32* %_1

	%_93 = load i32, i32* %_91
	%_94 = icmp slt i32 %_92, %_93
	%_95 = icmp slt i32 -1, %_92
	%_96 = xor i1 %_94, %_95
	br i1 %_96, label %indexing_error_9, label %indexing_ok_9
	indexing_error_9:
	call void @throw_oob()
	br label %indexing_ok_9
	indexing_ok_9:
	%_97 = add i32 %_92, 1
	%_98 = getelementptr i32, i32* %_91, i32 %_97
	%_99 = load i32, i32* %_98
	
	store i32 %_99, i32* %_4
	%_100 = getelementptr i8, i8* %this, i32 8
	%_101 = bitcast i8* %_100 to i32**
	%_102 = load i32*, i32** %_101
	%_103 = load i32, i32* %_1
	%_104 = getelementptr i8, i8* %this, i32 8
	%_105 = bitcast i8* %_104 to i32**
	%_106 = load i32*, i32** %_105
	%_107 = load i32, i32* %_2

	%_108 = load i32, i32* %_106
	%_109 = icmp slt i32 %_107, %_108
	%_110 = icmp slt i32 -1, %_107
	%_111 = xor i1 %_109, %_110
	br i1 %_111, label %indexing_error_10, label %indexing_ok_10
	indexing_error_10:
	call void @throw_oob()
	br label %indexing_ok_10
	indexing_ok_10:
	%_112 = add i32 %_107, 1
	%_113 = getelementptr i32, i32* %_106, i32 %_112
	%_114 = load i32, i32* %_113
	%_115 = load i32, i32* %_102
	%_116 = icmp slt i32 %_103, %_115
	%_117 = icmp slt i32 -1, %_103
	%_118 = xor i1 %_116, %_117
	br i1 %_118, label %indexing_error_11, label %indexing_ok_11
	indexing_error_11:
	call void @throw_oob()
	br label %indexing_ok_11
	indexing_ok_11:
	%_119 = add i32 %_103, 1
	%_120 = getelementptr i32, i32* %_102, i32 %_119
	store i32 %_114, i32* %_120
	%_121 = getelementptr i8, i8* %this, i32 8
	%_122 = bitcast i8* %_121 to i32**
	%_123 = load i32*, i32** %_122
	%_124 = load i32, i32* %_2
	%_125 = load i32, i32* %_4
	%_126 = load i32, i32* %_123
	%_127 = icmp slt i32 %_124, %_126
	%_128 = icmp slt i32 -1, %_124
	%_129 = xor i1 %_127, %_128
	br i1 %_129, label %indexing_error_12, label %indexing_ok_12
	indexing_error_12:
	call void @throw_oob()
	br label %indexing_ok_12
	indexing_ok_12:
	%_130 = add i32 %_124, 1
	%_131 = getelementptr i32, i32* %_123, i32 %_130
	store i32 %_125, i32* %_131
	%_132 = load i32, i32* %_2
	%_133 = load i32, i32* %_1
	%_134 = add i32 0, 1

	%_135 = add i32 %_133, %_134

	%_136 = icmp slt i32 %_132, %_135

	br i1 %_136, label %if_then_13, label %if_else_13

	if_then_13:
	%_137 = load i1, i1* %_5
	%_138 = add i1 0, 0
	
	store i1 %_138, i1* %_5
	br label %if_end_13

	if_else_13:
	%_139 = load i1, i1* %_5
	%_140 = add i1 0, 1
	
	store i1 %_140, i1* %_5

	br label %if_end_13

	if_end_13:
	br label %while_2

	while_end_2:
	%_141 = getelementptr i8, i8* %this, i32 8
	%_142 = bitcast i8* %_141 to i32**
	%_143 = load i32*, i32** %_142
	%_144 = load i32, i32* %_2
	%_145 = getelementptr i8, i8* %this, i32 8
	%_146 = bitcast i8* %_145 to i32**
	%_147 = load i32*, i32** %_146
	%_148 = load i32, i32* %_1

	%_149 = load i32, i32* %_147
	%_150 = icmp slt i32 %_148, %_149
	%_151 = icmp slt i32 -1, %_148
	%_152 = xor i1 %_150, %_151
	br i1 %_152, label %indexing_error_14, label %indexing_ok_14
	indexing_error_14:
	call void @throw_oob()
	br label %indexing_ok_14
	indexing_ok_14:
	%_153 = add i32 %_148, 1
	%_154 = getelementptr i32, i32* %_147, i32 %_153
	%_155 = load i32, i32* %_154
	%_156 = load i32, i32* %_143
	%_157 = icmp slt i32 %_144, %_156
	%_158 = icmp slt i32 -1, %_144
	%_159 = xor i1 %_157, %_158
	br i1 %_159, label %indexing_error_15, label %indexing_ok_15
	indexing_error_15:
	call void @throw_oob()
	br label %indexing_ok_15
	indexing_ok_15:
	%_160 = add i32 %_144, 1
	%_161 = getelementptr i32, i32* %_143, i32 %_160
	store i32 %_155, i32* %_161
	%_162 = getelementptr i8, i8* %this, i32 8
	%_163 = bitcast i8* %_162 to i32**
	%_164 = load i32*, i32** %_163
	%_165 = load i32, i32* %_1
	%_166 = getelementptr i8, i8* %this, i32 8
	%_167 = bitcast i8* %_166 to i32**
	%_168 = load i32*, i32** %_167
	%_169 = load i32, i32* %__right

	%_170 = load i32, i32* %_168
	%_171 = icmp slt i32 %_169, %_170
	%_172 = icmp slt i32 -1, %_169
	%_173 = xor i1 %_171, %_172
	br i1 %_173, label %indexing_error_16, label %indexing_ok_16
	indexing_error_16:
	call void @throw_oob()
	br label %indexing_ok_16
	indexing_ok_16:
	%_174 = add i32 %_169, 1
	%_175 = getelementptr i32, i32* %_168, i32 %_174
	%_176 = load i32, i32* %_175
	%_177 = load i32, i32* %_164
	%_178 = icmp slt i32 %_165, %_177
	%_179 = icmp slt i32 -1, %_165
	%_180 = xor i1 %_178, %_179
	br i1 %_180, label %indexing_error_17, label %indexing_ok_17
	indexing_error_17:
	call void @throw_oob()
	br label %indexing_ok_17
	indexing_ok_17:
	%_181 = add i32 %_165, 1
	%_182 = getelementptr i32, i32* %_164, i32 %_181
	store i32 %_176, i32* %_182
	%_183 = getelementptr i8, i8* %this, i32 8
	%_184 = bitcast i8* %_183 to i32**
	%_185 = load i32*, i32** %_184
	%_186 = load i32, i32* %__right
	%_187 = load i32, i32* %_4
	%_188 = load i32, i32* %_185
	%_189 = icmp slt i32 %_186, %_188
	%_190 = icmp slt i32 -1, %_186
	%_191 = xor i1 %_189, %_190
	br i1 %_191, label %indexing_error_18, label %indexing_ok_18
	indexing_error_18:
	call void @throw_oob()
	br label %indexing_ok_18
	indexing_ok_18:
	%_192 = add i32 %_186, 1
	%_193 = getelementptr i32, i32* %_185, i32 %_192
	store i32 %_187, i32* %_193
	%_194 = load i32, i32* %_3

	%_195 = bitcast i8* %this to i8***
	%_196 = load i8**, i8*** %_195
	%_197 = getelementptr i8*, i8** %_196, i32 1
	%_198 = load i8*, i8** %_197
	%_199 = bitcast i8* %_198 to i32 (i8*, i32, i32)*
	%_201 = load i32, i32* %__left
	%_202 = load i32, i32* %_1
	%_203 = add i32 0, 1

	%_204 = sub i32 %_202, %_203
	%_200 = call i32 %_199(i8* %this, i32 %_201, i32 %_204)
	
	store i32 %_200, i32* %_3
	%_205 = load i32, i32* %_3

	%_206 = bitcast i8* %this to i8***
	%_207 = load i8**, i8*** %_206
	%_208 = getelementptr i8*, i8** %_207, i32 1
	%_209 = load i8*, i8** %_208
	%_210 = bitcast i8* %_209 to i32 (i8*, i32, i32)*
	%_212 = load i32, i32* %_1
	%_213 = add i32 0, 1

	%_214 = add i32 %_212, %_213
	%_215 = load i32, i32* %__right
	%_211 = call i32 %_210(i8* %this, i32 %_214, i32 %_215)
	
	store i32 %_211, i32* %_3
	br label %if_end_0

	if_else_0:
	%_216 = load i32, i32* %_3
	%_217 = add i32 0, 0
	
	store i32 %_217, i32* %_3

	br label %if_end_0

	if_end_0:
	%_218 = add i32 0, 0
	ret i32 %_218
}

define i32 @QS.Print(i8* %this) {

	%_0 = alloca i32
	store i32 0, i32* %_0
	%_1 = load i32, i32* %_0
	%_2 = add i32 0, 0
	
	store i32 %_2, i32* %_0

	br label %while_0
	while_0:
	%_3 = load i32, i32* %_0
	%_4 = getelementptr i8, i8* %this, i32 16
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5

	%_7 = icmp slt i32 %_3, %_6
	br i1 %_7, label %continue_0, label %while_end_0
	continue_0:
	%_8 = getelementptr i8, i8* %this, i32 8
	%_9 = bitcast i8* %_8 to i32**
	%_10 = load i32*, i32** %_9
	%_11 = load i32, i32* %_0

	%_12 = load i32, i32* %_10
	%_13 = icmp slt i32 %_11, %_12
	%_14 = icmp slt i32 -1, %_11
	%_15 = xor i1 %_13, %_14
	br i1 %_15, label %indexing_error_1, label %indexing_ok_1
	indexing_error_1:
	call void @throw_oob()
	br label %indexing_ok_1
	indexing_ok_1:
	%_16 = add i32 %_11, 1
	%_17 = getelementptr i32, i32* %_10, i32 %_16
	%_18 = load i32, i32* %_17
	call void (i32) @print_int(i32 %_18)
	%_19 = load i32, i32* %_0
	%_20 = load i32, i32* %_0
	%_21 = add i32 0, 1

	%_22 = add i32 %_20, %_21
	
	store i32 %_22, i32* %_0
	br label %while_0

	while_end_0:
	%_23 = add i32 0, 0
	ret i32 %_23
}

define i32 @QS.Init(i8* %this, i32 %sz) {
	%__sz = alloca i32
	store i32 %sz, i32* %__sz
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = load i32, i32* %__sz
	
	store i32 %_3, i32* %_1
	%_4 = getelementptr i8, i8* %this, i32 8
	%_5 = bitcast i8* %_4 to i32**
	%_6 = load i32*, i32** %_5
	%_7 = load i32, i32* %__sz

	%_8 = add i32 1, %_7
	%_9 = icmp sge i32 %_8, 1
	br i1 %_9, label %nsz_ok_0, label %nsz_err_0
	nsz_err_0:
	call void @throw_nsz()
	br label %nsz_ok_0
	nsz_ok_0:

	%_10 = call i8* @calloc(i32 %_8, i32 4)
	%_11 = bitcast i8* %_10 to i32*
	store i32 %_7, i32* %_11
	
	store i32* %_11, i32** %_5
	%_12 = getelementptr i8, i8* %this, i32 8
	%_13 = bitcast i8* %_12 to i32**
	%_14 = load i32*, i32** %_13
	%_15 = add i32 0, 0
	%_16 = add i32 0, 20
	%_17 = load i32, i32* %_14
	%_18 = icmp slt i32 %_15, %_17
	%_19 = icmp slt i32 -1, %_15
	%_20 = xor i1 %_18, %_19
	br i1 %_20, label %indexing_error_1, label %indexing_ok_1
	indexing_error_1:
	call void @throw_oob()
	br label %indexing_ok_1
	indexing_ok_1:
	%_21 = add i32 %_15, 1
	%_22 = getelementptr i32, i32* %_14, i32 %_21
	store i32 %_16, i32* %_22
	%_23 = getelementptr i8, i8* %this, i32 8
	%_24 = bitcast i8* %_23 to i32**
	%_25 = load i32*, i32** %_24
	%_26 = add i32 0, 1
	%_27 = add i32 0, 7
	%_28 = load i32, i32* %_25
	%_29 = icmp slt i32 %_26, %_28
	%_30 = icmp slt i32 -1, %_26
	%_31 = xor i1 %_29, %_30
	br i1 %_31, label %indexing_error_2, label %indexing_ok_2
	indexing_error_2:
	call void @throw_oob()
	br label %indexing_ok_2
	indexing_ok_2:
	%_32 = add i32 %_26, 1
	%_33 = getelementptr i32, i32* %_25, i32 %_32
	store i32 %_27, i32* %_33
	%_34 = getelementptr i8, i8* %this, i32 8
	%_35 = bitcast i8* %_34 to i32**
	%_36 = load i32*, i32** %_35
	%_37 = add i32 0, 2
	%_38 = add i32 0, 12
	%_39 = load i32, i32* %_36
	%_40 = icmp slt i32 %_37, %_39
	%_41 = icmp slt i32 -1, %_37
	%_42 = xor i1 %_40, %_41
	br i1 %_42, label %indexing_error_3, label %indexing_ok_3
	indexing_error_3:
	call void @throw_oob()
	br label %indexing_ok_3
	indexing_ok_3:
	%_43 = add i32 %_37, 1
	%_44 = getelementptr i32, i32* %_36, i32 %_43
	store i32 %_38, i32* %_44
	%_45 = getelementptr i8, i8* %this, i32 8
	%_46 = bitcast i8* %_45 to i32**
	%_47 = load i32*, i32** %_46
	%_48 = add i32 0, 3
	%_49 = add i32 0, 18
	%_50 = load i32, i32* %_47
	%_51 = icmp slt i32 %_48, %_50
	%_52 = icmp slt i32 -1, %_48
	%_53 = xor i1 %_51, %_52
	br i1 %_53, label %indexing_error_4, label %indexing_ok_4
	indexing_error_4:
	call void @throw_oob()
	br label %indexing_ok_4
	indexing_ok_4:
	%_54 = add i32 %_48, 1
	%_55 = getelementptr i32, i32* %_47, i32 %_54
	store i32 %_49, i32* %_55
	%_56 = getelementptr i8, i8* %this, i32 8
	%_57 = bitcast i8* %_56 to i32**
	%_58 = load i32*, i32** %_57
	%_59 = add i32 0, 4
	%_60 = add i32 0, 2
	%_61 = load i32, i32* %_58
	%_62 = icmp slt i32 %_59, %_61
	%_63 = icmp slt i32 -1, %_59
	%_64 = xor i1 %_62, %_63
	br i1 %_64, label %indexing_error_5, label %indexing_ok_5
	indexing_error_5:
	call void @throw_oob()
	br label %indexing_ok_5
	indexing_ok_5:
	%_65 = add i32 %_59, 1
	%_66 = getelementptr i32, i32* %_58, i32 %_65
	store i32 %_60, i32* %_66
	%_67 = getelementptr i8, i8* %this, i32 8
	%_68 = bitcast i8* %_67 to i32**
	%_69 = load i32*, i32** %_68
	%_70 = add i32 0, 5
	%_71 = add i32 0, 11
	%_72 = load i32, i32* %_69
	%_73 = icmp slt i32 %_70, %_72
	%_74 = icmp slt i32 -1, %_70
	%_75 = xor i1 %_73, %_74
	br i1 %_75, label %indexing_error_6, label %indexing_ok_6
	indexing_error_6:
	call void @throw_oob()
	br label %indexing_ok_6
	indexing_ok_6:
	%_76 = add i32 %_70, 1
	%_77 = getelementptr i32, i32* %_69, i32 %_76
	store i32 %_71, i32* %_77
	%_78 = getelementptr i8, i8* %this, i32 8
	%_79 = bitcast i8* %_78 to i32**
	%_80 = load i32*, i32** %_79
	%_81 = add i32 0, 6
	%_82 = add i32 0, 6
	%_83 = load i32, i32* %_80
	%_84 = icmp slt i32 %_81, %_83
	%_85 = icmp slt i32 -1, %_81
	%_86 = xor i1 %_84, %_85
	br i1 %_86, label %indexing_error_7, label %indexing_ok_7
	indexing_error_7:
	call void @throw_oob()
	br label %indexing_ok_7
	indexing_ok_7:
	%_87 = add i32 %_81, 1
	%_88 = getelementptr i32, i32* %_80, i32 %_87
	store i32 %_82, i32* %_88
	%_89 = getelementptr i8, i8* %this, i32 8
	%_90 = bitcast i8* %_89 to i32**
	%_91 = load i32*, i32** %_90
	%_92 = add i32 0, 7
	%_93 = add i32 0, 9
	%_94 = load i32, i32* %_91
	%_95 = icmp slt i32 %_92, %_94
	%_96 = icmp slt i32 -1, %_92
	%_97 = xor i1 %_95, %_96
	br i1 %_97, label %indexing_error_8, label %indexing_ok_8
	indexing_error_8:
	call void @throw_oob()
	br label %indexing_ok_8
	indexing_ok_8:
	%_98 = add i32 %_92, 1
	%_99 = getelementptr i32, i32* %_91, i32 %_98
	store i32 %_93, i32* %_99
	%_100 = getelementptr i8, i8* %this, i32 8
	%_101 = bitcast i8* %_100 to i32**
	%_102 = load i32*, i32** %_101
	%_103 = add i32 0, 8
	%_104 = add i32 0, 19
	%_105 = load i32, i32* %_102
	%_106 = icmp slt i32 %_103, %_105
	%_107 = icmp slt i32 -1, %_103
	%_108 = xor i1 %_106, %_107
	br i1 %_108, label %indexing_error_9, label %indexing_ok_9
	indexing_error_9:
	call void @throw_oob()
	br label %indexing_ok_9
	indexing_ok_9:
	%_109 = add i32 %_103, 1
	%_110 = getelementptr i32, i32* %_102, i32 %_109
	store i32 %_104, i32* %_110
	%_111 = getelementptr i8, i8* %this, i32 8
	%_112 = bitcast i8* %_111 to i32**
	%_113 = load i32*, i32** %_112
	%_114 = add i32 0, 9
	%_115 = add i32 0, 5
	%_116 = load i32, i32* %_113
	%_117 = icmp slt i32 %_114, %_116
	%_118 = icmp slt i32 -1, %_114
	%_119 = xor i1 %_117, %_118
	br i1 %_119, label %indexing_error_10, label %indexing_ok_10
	indexing_error_10:
	call void @throw_oob()
	br label %indexing_ok_10
	indexing_ok_10:
	%_120 = add i32 %_114, 1
	%_121 = getelementptr i32, i32* %_113, i32 %_120
	store i32 %_115, i32* %_121
	%_122 = add i32 0, 0
	ret i32 %_122
}
