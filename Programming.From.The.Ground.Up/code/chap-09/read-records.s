.include "linux.s"
.include "record-def.s"

.section .data

file_name:	.ascii	"test.dat\0"

record_buffer_ptr:	.long	0

.section .bss

.section .text

# Main program
.globl	_start

	_start:

		call	allocate_init

# These are the locations on the stack where
# we will store the input and output descriptors
# (FYI - we could have used memory addresses in
# a .data section instead)

.equ	ST_INPUT_DESCRIPTOR,	-4
.equ	ST_OUTPUT_DESCRIPTOR,	-8

		movl %esp, %ebp	# Copy the stack pointer to %ebp
		subl $8, %esp	# Allocate space to hold the file descriptors

		movl ST_ARGC(%ebp), %eax	# put number of arguments in eax
		movl ST_ARGV_1(%ebp), %ebx	# define filename
		cmpl $2, %eax		# we always have at least one argument
		jge	open_fd_read		# if we have arguments then open a file
	
		movl $file_name, %ebx	# if we do not have arguments, put
						# defined filename in ebx

	open_fd_read:

		movl $SYS_OPEN, %eax		# open file
		movl $0, %ecx		# This says to open read-only
		movl $0666, %edx		# file permissions
		int	$LINUX_SYSCALL
		
		test	%eax, %eax		# check if eax is zero
		jge	no_error

		addl $8, %esp
		call	error_handler
		jmp	exit


	no_error:

		movl %eax, ST_INPUT_DESCRIPTOR(%ebp)	# Save file descriptor
		
		# Even though it’s a constant, we are
		# saving the output file descriptor in
		# a local variable so that if we later
		# decide that it isn’t always going to
		# be STDOUT, we can change it easily.

		movl	$STDOUT, ST_OUTPUT_DESCRIPTOR(%ebp)

	record_read_loop:

		pushl $RECORD_SIZE
		call	allocate
		movl %eax, record_buffer_ptr

		pushl ST_INPUT_DESCRIPTOR(%ebp)
		pushl record_buffer_ptr
		call	read_record
		addl $8, %esp

		# Returns the number of bytes read.
		# If it isn’t the same number we
		# requested, then it’s either an
		# end-of-file, or an error, so we’re
		# quitting

		cmpl $RECORD_SIZE, %eax
		jne	finished_reading
		
		# Otherwise, print out the first name
		# but first, we must know it’s size
		
		movl record_buffer_ptr, %eax
		addl $RECORD_FIRSTNAME, %eax
		pushl %eax
		call	count_chars
		addl $4, %esp

		movl %eax, %edx
		movl ST_OUTPUT_DESCRIPTOR(%ebp), %ebx
		movl $SYS_WRITE, %eax

		movl record_buffer_ptr, %ecx
		addl $RECORD_FIRSTNAME, %ecx
		int	$LINUX_SYSCALL
		
		pushl ST_OUTPUT_DESCRIPTOR(%ebp)
		call	write_newline
		addl $4, %esp
		
		jmp	record_read_loop
		
	finished_reading:

		movl ST_INPUT_DESCRIPTOR(%ebp), %ebx		# Close file
		movl $SYS_CLOSE, %eax
		int	$LINUX_SYSCALL	

		xorl %ebx, %ebx				# our exit code
	
		pushl record_buffer_ptr
		call	deallocate

	exit:
	
		movl $SYS_EXIT, %eax				# exit to OS
		int	$LINUX_SYSCALL

