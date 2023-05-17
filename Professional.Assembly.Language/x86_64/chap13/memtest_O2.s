	.file	"memtest.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"The result is %d\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.section	.text.startup,"ax",@progbits
.LHOTB1:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB11:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$20, %eax
	movl	$.LC0, %edi
	movl	$5, 8(%rsp)
#APP
# 10 "memtest.c" 1
	divb 8(%rsp)
	movl %eax, 12(%rsp)
# 0 "" 2
#NO_APP
	movl	12(%rsp), %esi
	xorl	%eax, %eax
	call	printf
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE1:
	.section	.text.startup
.LHOTE1:
	.ident	"GCC: (Debian 4.9.1-19) 4.9.1"
	.section	.note.GNU-stack,"",@progbits
