	.file	"paramtest3.c"
	.section	.rodata
.LC1:
	.string	"value %f"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp

	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi

	movl	%eax, -4(%rbp)
	cvtsi2sd	-4(%rbp), %xmm0
	movsd	.LC0(%rip), %xmm1

	mulsd	%xmm1, %xmm0
	movl	$.LC1, %edi
	movl	$1, %eax
	call	printf

	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	1374389535
	.long	1074339512
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
