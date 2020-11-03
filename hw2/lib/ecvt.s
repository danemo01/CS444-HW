	.file	"ecvt.c"
gcc2_compiled.:
___gnu_compiled_c:
.stabs "/groups/ulab/devhost/libc/",100,0,0,Ltext0
.stabs "ecvt.c",100,0,0,Ltext0
.text
Ltext0:
.stabs "int:t1=r1;-2147483648;2147483647;",128,0,0,0
.stabs "char:t2=r2;0;127;",128,0,0,0
.stabs "long int:t3=r1;-2147483648;2147483647;",128,0,0,0
.stabs "unsigned int:t4=r1;0;-1;",128,0,0,0
.stabs "long unsigned int:t5=r1;0;-1;",128,0,0,0
.stabs "long long int:t6=r1;01000000000000000000000;0777777777777777777777;",128,0,0,0
.stabs "long long unsigned int:t7=r1;0000000000000;01777777777777777777777;",128,0,0,0
.stabs "short int:t8=r1;-32768;32767;",128,0,0,0
.stabs "short unsigned int:t9=r1;0;65535;",128,0,0,0
.stabs "signed char:t10=r1;-128;127;",128,0,0,0
.stabs "unsigned char:t11=r1;0;255;",128,0,0,0
.stabs "float:t12=r1;4;0;",128,0,0,0
.stabs "double:t13=r1;8;0;",128,0,0,0
.stabs "long double:t14=r1;12;0;",128,0,0,0
.stabs "complex int:t15=s8real:1,0,32;imag:1,32,32;;",128,0,0,0
.stabs "complex float:t16=r16;4;0;",128,0,0,0
.stabs "complex double:t17=r17;8;0;",128,0,0,0
.stabs "complex long double:t18=r18;12;0;",128,0,0,0
.stabs "void:t19=19",128,0,0,0
	.align 2
.globl _ecvt
_ecvt:
	.stabd 68,0,15
	pushl %ebp
	movl %esp,%ebp
	.stabd 68,0,16
	pushl $1
	movl 24(%ebp),%eax
	pushl %eax
	movl 20(%ebp),%eax
	pushl %eax
	movl 16(%ebp),%eax
	pushl %eax
	pushl 12(%ebp)
	pushl 8(%ebp)
	call _cvt
	addl $24,%esp
	movl %eax,%edx
	movl %edx,%eax
	jmp L1
	.align 2,0x90
	.stabd 68,0,17
L1:
	leave
	ret
.stabs "ecvt:F20=*2",36,0,13,_ecvt
.stabs "arg:p13",160,0,13,8
.stabs "ndigits:p1",160,0,14,16
.stabs "decpt:p21=*1",160,0,14,20
.stabs "sign:p21",160,0,14,24
	.align 2
.globl _fcvt
_fcvt:
	.stabd 68,0,23
	pushl %ebp
	movl %esp,%ebp
	.stabd 68,0,24
	pushl $0
	movl 24(%ebp),%eax
	pushl %eax
	movl 20(%ebp),%eax
	pushl %eax
	movl 16(%ebp),%eax
	pushl %eax
	pushl 12(%ebp)
	pushl 8(%ebp)
	call _cvt
	addl $24,%esp
	movl %eax,%edx
	movl %edx,%eax
	jmp L2
	.align 2,0x90
	.stabd 68,0,25
L2:
	leave
	ret
.stabs "fcvt:F20",36,0,21,_fcvt
.stabs "arg:p13",160,0,21,8
.stabs "ndigits:p1",160,0,22,16
.stabs "decpt:p21",160,0,22,20
.stabs "sign:p21",160,0,22,24
.lcomm _buf.6,80
	.align 2
LC0:
	.long 0x0,0x40240000
	.align 2
LC1:
	.long 0xeb851eb8,0x3f9eb851
	.align 2
_cvt:
	.stabd 68,0,31
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	.stabd 68,0,32
LBB2:
	.stabd 68,0,38
	cmpl $0,16(%ebp)
	jge L4
	.stabd 68,0,39
	movl $0,16(%ebp)
L4:
	.stabd 68,0,40
	cmpl $78,16(%ebp)
	jle L5
	.stabd 68,0,41
	movl $78,16(%ebp)
L5:
	.stabd 68,0,42
	xorl %ebx,%ebx
	.stabd 68,0,43
	movl 24(%ebp),%eax
	movl %eax,-28(%ebp)
	movl -28(%ebp),%eax
	movl $0,(%eax)
	.stabd 68,0,44
	movl $_buf.6,%esi
	.stabd 68,0,45
	fldl 8(%ebp)
	fldz
	fcompp
	fnstsw %ax
	andb $69,%ah
	jne L6
	.stabd 68,0,46
	movl 24(%ebp),%eax
	movl %eax,-28(%ebp)
	movl -28(%ebp),%eax
	movl $1,(%eax)
	.stabd 68,0,47
	fldl 8(%ebp)
	fchs
	fstpl 8(%ebp)
L6:
	.stabd 68,0,49
	leal -8(%ebp),%eax
	movl %eax,-28(%ebp)
	pushl -28(%ebp)
	pushl 12(%ebp)
	pushl 8(%ebp)
	call _modf
	addl $12,%esp
	fstpl 8(%ebp)
	.stabd 68,0,50
	movl $_buf.6+80,%edi
	.stabd 68,0,54
	fldl -8(%ebp)
	fldz
	fucompp
	fnstsw %ax
	andb $69,%ah
	cmpb $64,%ah
	je L7
	.stabd 68,0,55
	movl $_buf.6+80,%edi
	.stabd 68,0,56
L8:
	fldl -8(%ebp)
	fldz
	fucompp
	fnstsw %ax
	andb $68,%ah
	xorb $64,%ah
	jne L10
	jmp L9
	.align 2,0x90
L10:
	.stabd 68,0,57
	leal -8(%ebp),%eax
	movl %eax,-28(%ebp)
	pushl -28(%ebp)
	fldl LC0
	fldl -8(%ebp)
	fdivp %st,%st(1)
	subl $8,%esp
	fstpl (%esp)
	call _modf
	addl $12,%esp
	fstpl -16(%ebp)
	.stabd 68,0,58
	decl %edi
	fldl LC1
	fldl -16(%ebp)
	faddp %st,%st(1)
	fldl LC0
	fmulp %st,%st(1)
	fnstcw -20(%ebp)
	movl -20(%ebp),%eax
	movb $12,%ah
	movl %eax,-24(%ebp)
	fldcw -24(%ebp)
	fistpl -28(%ebp)
	fldcw -20(%ebp)
	movb -28(%ebp),%al
	addb $48,%al
	movb %al,(%edi)
	.stabd 68,0,59
	incl %ebx
	.stabd 68,0,60
	jmp L8
	.align 2,0x90
L9:
	.stabd 68,0,61
L11:
	cmpl $_buf.6+80,%edi
	jb L13
	jmp L12
	.align 2,0x90
L13:
	.stabd 68,0,62
	movb (%edi),%al
	movb %al,-28(%ebp)
	movb -28(%ebp),%al
	movb %al,(%esi)
	incl %edi
	incl %esi
	jmp L11
	.align 2,0x90
L12:
	.stabd 68,0,63
	jmp L14
	.align 2,0x90
L7:
	fldl 8(%ebp)
	fldz
	fcompp
	fnstsw %ax
	andb $69,%ah
	cmpb $1,%ah
	jne L15
	.stabd 68,0,64
L16:
	fldl LC0
	fldl 8(%ebp)
	fmulp %st,%st(1)
	fstl -16(%ebp)
	fld1
	fcompp
	fnstsw %ax
	andb $69,%ah
	je L18
	jmp L17
	.align 2,0x90
L18:
	.stabd 68,0,65
	movl -16(%ebp),%eax
	movl %eax,8(%ebp)
	movl -12(%ebp),%eax
	movl %eax,12(%ebp)
	.stabd 68,0,66
	decl %ebx
	.stabd 68,0,67
	jmp L16
	.align 2,0x90
L17:
L15:
L14:
	.stabd 68,0,69
	movl 16(%ebp),%edi
	addl $_buf.6,%edi
	.stabd 68,0,70
	cmpl $0,28(%ebp)
	jne L19
	.stabd 68,0,71
	addl %ebx,%edi
L19:
	.stabd 68,0,72
	movl 20(%ebp),%eax
	movl %eax,-28(%ebp)
	movl -28(%ebp),%eax
	movl %ebx,(%eax)
	.stabd 68,0,73
	cmpl $_buf.6,%edi
	jae L20
	.stabd 68,0,74
	movb $0,_buf.6
	.stabd 68,0,75
	movl $_buf.6,%eax
	jmp L3
	.align 2,0x90
L20:
	.stabd 68,0,77
L21:
	cmpl %edi,%esi
	ja L24
	cmpl $_buf.6+80,%esi
	jb L23
	jmp L24
	.align 2,0x90
L24:
	jmp L22
	.align 2,0x90
L23:
	.stabd 68,0,78
	fldl LC0
	fldl 8(%ebp)
	fmulp %st,%st(1)
	fstpl 8(%ebp)
	.stabd 68,0,79
	leal -16(%ebp),%eax
	movl %eax,-28(%ebp)
	pushl -28(%ebp)
	pushl 12(%ebp)
	pushl 8(%ebp)
	call _modf
	addl $12,%esp
	fstpl 8(%ebp)
	.stabd 68,0,80
	fldl -16(%ebp)
	fnstcw -20(%ebp)
	movl -20(%ebp),%eax
	movb $12,%ah
	movl %eax,-24(%ebp)
	fldcw -24(%ebp)
	subl $4,%esp
	fistpl (%esp)
	popl %edx
	fldcw -20(%ebp)
	movb %dl,-28(%ebp)
	addb $48,-28(%ebp)
	movb -28(%ebp),%al
	movb %al,(%esi)
	incl %esi
	.stabd 68,0,81
	jmp L21
	.align 2,0x90
L22:
	.stabd 68,0,82
	cmpl $_buf.6+80,%edi
	jb L25
	.stabd 68,0,83
	movb $0,_buf.6+79
	.stabd 68,0,84
	movl $_buf.6,%eax
	jmp L3
	.align 2,0x90
L25:
	.stabd 68,0,86
	movl %edi,%esi
	.stabd 68,0,87
	addb $5,(%edi)
	.stabd 68,0,88
L26:
	cmpb $57,(%edi)
	jg L28
	jmp L27
	.align 2,0x90
L28:
	.stabd 68,0,89
	movb $48,(%edi)
	.stabd 68,0,90
	cmpl $_buf.6,%edi
	jbe L29
	.stabd 68,0,91
	decl %edi
	movl %edi,-28(%ebp)
	movl -28(%ebp),%eax
	incb (%eax)
	jmp L30
	.align 2,0x90
L29:
	.stabd 68,0,93
	movb $49,(%edi)
	.stabd 68,0,94
	movl 20(%ebp),%eax
	movl %eax,-28(%ebp)
	movl -28(%ebp),%eax
	incl (%eax)
	.stabd 68,0,95
	cmpl $0,28(%ebp)
	jne L31
	.stabd 68,0,96
	cmpl $_buf.6,%esi
	jbe L32
	.stabd 68,0,97
	movb $48,(%esi)
L32:
	.stabd 68,0,98
	incl %esi
L31:
L30:
	.stabd 68,0,101
	jmp L26
	.align 2,0x90
L27:
	.stabd 68,0,102
	movb $0,(%esi)
	.stabd 68,0,103
	movl $_buf.6,%eax
	jmp L3
	.align 2,0x90
	.stabd 68,0,104
LBE2:
	.stabd 68,0,104
L3:
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	leave
	ret
.stabs "cvt:f20",36,0,29,_cvt
.stabs "arg:p13",160,0,29,8
.stabs "ndigits:p1",160,0,30,16
.stabs "decpt:p21",160,0,30,20
.stabs "sign:p21",160,0,30,24
.stabs "eflag:p1",160,0,29,28
.stabs "r2:r1",64,0,32,3
.stabs "fi:13",128,0,33,-8
.stabs "fj:13",128,0,33,-16
.stabs "p:r20",64,0,34,6
.stabs "p1:r20",64,0,34,7
.stabs "buf:V22=ar1;0;79;2",40,0,35,_buf.6
.stabn 192,0,0,LBB2
.stabn 224,0,0,LBE2
