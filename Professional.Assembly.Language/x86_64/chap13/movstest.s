	.file	"movstest.c"
	.section	.rodata
.LC0:
	.string	"%s"
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
	subq	$80, %rsp
	movabsq	$2338328219631577172, %rax
	movq	%rax, -48(%rbp)
	movabsq	$7863412988361056353, %rax
	movq	%rax, -40(%rbp)
	movabsq	$733635283998962533, %rax
	movq	%rax, -32(%rbp)
	movl	$0, -24(%rbp)
	movw	$0, -20(%rbp)
	movl	$25, -4(%rbp)
	leaq	-48(%rbp), %rax
	leaq	-80(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movq	%rax, %rsi
	movq	%rdx, %rdi
#APP
# 10 "movstest.c" 1
	cld
	rep movsb
# 0 "" 2
#NO_APP
	leaq	-80(%rbp), %rax
	movq	%rax, %rsi
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
