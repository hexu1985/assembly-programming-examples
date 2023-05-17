# first:  as --32 -o write-newline.o write-newline.s
# second: ld -melf_i386 -o write-newline write-newline.o

.include	"linux.s"

.globl	write_newline
.type	write_newline, @function

.section .data

newline:	.ascii	"\n"

.section .text

.equ	ST_FILEDES,	8

	write_newline:

		pushl %ebp
		movl %esp, %ebp

		movl $SYS_WRITE, %eax
		movl ST_FILEDES(%ebp), %ebx
		movl $newline, %ecx
		movl $1, %edx
		int	$LINUX_SYSCALL
		
		movl %ebp, %esp
		popl %ebp
		ret

