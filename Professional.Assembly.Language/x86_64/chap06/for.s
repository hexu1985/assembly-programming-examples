	.file	"for.c"

	.section	.rodata
.LC0:
	.string	"The answer is %d\n"

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
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %edx
	movl	%edx, %eax

	sall	$2, %eax
	addl	%edx, %eax # multiplied by 5 (tricky)

	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax

	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf

	addl	$1, -4(%rbp)
.L2:
	cmpl	$999, -4(%rbp)
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
