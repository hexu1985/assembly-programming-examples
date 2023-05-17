	.file	"globaltest.c"

	.globl	a
	.data
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.long	10

	.globl	b
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	20

	.comm	result,4,4

	.section	.rodata
.LC0:
	.string	"the answer is %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 10 "globaltest.c" 1
	pusha
	movl a, %eax
	movl b, %ebx
	imull %ebx, %eax
	movl %eax, result
	popa
# 0 "" 2
#NO_APP
	movl	result(%rip), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.1-19) 4.9.1"
	.section	.note.GNU-stack,"",@progbits
