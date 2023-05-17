# PURPOSE: Research the lseek system call.
#          Rewrite the addl-year program to
#          open the source file for both
#          reading and writing (use $2 for
#          the read/write mode), and write
#          the modified records back to the
#          same file they were read from.

.include "linux.s"
.include "record-def.s"
#.include "error-handler.s"

.section .data

input_file_name:	.ascii "test.dat\0"

.section .bss

.lcomm	record_buffer,	RECORD_SIZE
.lcomm	seek_position,	4

# Stack offsets of local variables

.equ	ST_INPUT_DESCRIPTOR,	-4

.section .text

.globl	_start
	_start:
		
		movl %esp, %ebp	# Copy stack pointer and make room for local variables
		subl $8, %esp

		movl ST_ARGC(%ebp), %eax	# put number of arguments in eax
		movl ST_ARGV_1(%ebp), %ebx	# define filename
		cmpl $2, %eax		# we always have at least one argument
		jge	open_fd_read_and_write	# if we have arguments then open a file
	
		movl $input_file_name, %ebx	# if we do not have arguments, put
						# defined filename in ebx
		

		# Open file for reading and writening
	open_fd_read_and_write:

		movl $SYS_OPEN, %eax		# open file
		movl $2, %ecx		# This says to open read and write
		movl $0666, %edx		# file permissions
		int	$LINUX_SYSCALL
		
		test	%eax, %eax		# check if eax is zero
		jge	no_error

		addl $8, %esp
		call	error_handler
		jmp	exit
	
	no_error:

		movl %eax, ST_INPUT_DESCRIPTOR(%ebp)
		xorl %eax, %eax
		

	first_record:

		pushl ST_INPUT_DESCRIPTOR(%ebp)
		pushl $record_buffer
		call	read_record
		addl $8, %esp

		# Returns the number of bytes read.
		# If it isn’t the same number we
		# requested, then it’s either an
		# end-of-file, or an error, so we’re
		# quitting
		
		cmpl $RECORD_SIZE, %eax
		jne	exit

		# Increment the age

		incl	record_buffer + RECORD_AGE

		# Write the record out

		movl     seek_position, %ecx             # offset
		call	lseek

		pushl ST_INPUT_DESCRIPTOR(%ebp)
		pushl $record_buffer
		call	write_record
		addl $8, %esp
		
		movl $RECORD_SIZE, %eax
                addl     %eax, seek_position

                movl     seek_position, %ecx             # offset
		call    lseek

                test    %eax, %eax                      # check if eax is zero
                jge     first_record

                addl     $8, %esp
                call    error_handler
                jmp     exit

		movl     $0x13, %eax                     # seek position of a record
		movl     ST_INPUT_DESCRIPTOR(%ebp), %ebx # in a file
		movl     $1, %edx			# since beginning of a file
		int     $LINUX_SYSCALL

		test    %eax, %eax                     # check if eax is zero
		jge     first_record

		addl     $8, %esp
		call    error_handler
		jmp     exit


		jmp	first_record

	exit:

		movl $SYS_EXIT, %eax
		movl $0, %ebx
		int	$LINUX_SYSCALL

	lseek:

                movl     $0x13, %eax                     # seek position of a record
                movl     ST_INPUT_DESCRIPTOR(%ebp), %ebx # in a file
                xorl     %edx, %edx                      # since beginning of a file
                int     $LINUX_SYSCALL
		ret


		
