	.file	"movtest3.c"

	.globl	output
	.data
	.align 16
	.type	output, @object
	.size	output, 17
output:
	.string	"The value is %d\n"

	.globl	values
	.align 32
	.type	values, @object
	.size	values, 44
values:
	.long	10
	.long	15
	.long	20
	.long	25
	.long	30
	.long	35
	.long	40
	.long	45
	.long	50
	.long	55
	.long	60

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
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	cltq
	salq	$2, %rax
	addq	$values, %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	movl	$output, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -4(%rbp)
.L2:
	cmpl	$10, -4(%rbp)
	jle	.L3
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.1-19) 4.9.1"
	.section	.note.GNU-stack,"",@progbits
