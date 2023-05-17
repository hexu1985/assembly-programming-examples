# PURPOSE: Program will create a file called heynow.txt and write the words
#          "Hey diddle diddle!" into it
#
#
# INPUT:

# first:  as --32 -o heynow.o heynow.s
# second: ld -melf_i386 -o heynow heynow.o

.section .data

filename:		.asciz	"heynow.txt"


success_message:	.ascii	"Hey diddle diddle!\n"
			.set	success_message_size, . - success_message

.section .text

.globl _start

	_start:


		movl $0x05, %eax		# open file, and create it if it does not exist
		movl $filename, %ebx		# filename
		movl $0x642, %ecx		# open for read and write (also we can create, truncate and append)
		movl $0666, %edx		# read write permission
		int	$0x80

		xchgl %eax, %ebx		# put file descriptor in ebx

		movl $0x04, %eax		# write to file
		movl $success_message, %ecx	# bytes which should be written in file
		movl $success_message_size, %edx	# how mant bytes should be written
		int	$0x80

		movl $0x06, %eax		# close file
		int	$0x80

		movl $0x1, %eax		# exit to linux
		xorl %ebx, %ebx		# exit code
		int	$0x80

