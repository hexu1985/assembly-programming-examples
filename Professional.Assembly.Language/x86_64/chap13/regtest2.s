	.file	"regtest2.c"
	.section	.rodata
.LC0:
	.string	"The result is %d\n"
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
	movl	$10, -4(%rbp)
	movl	$20, -8(%rbp)
	movl	-4(%rbp), %eax
	movl	-8(%rbp), %edx
#APP
# 10 "regtest2.c" 1
	imul %eax, %edx
	mov %edx, %eax
# 0 "" 2
#NO_APP
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.1-19) 4.9.1"
	.section	.note.GNU-stack,"",@progbits
