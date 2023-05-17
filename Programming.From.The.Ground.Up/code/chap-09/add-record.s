# PURPOSE: Write a program that will add a single 
#          record to the file by reading the data from
#          the keyboard. Remember, you will have to make 
#          sure that the data has at least one null
#          character at the end, and you need to
#          have a way for the user to indicate
#          they are done typing. Because we have not
#          gotten into characters to numbers conversion,
#          you will not be able to read the age in from
#          the keyboard, so you’ll have to have a default age

.include "linux.s"
.include "record-def.s"
#.include "error-handler.s"

.section .data

input_file_name:	.ascii	"test.dat\0"

enter_name:		.asciz	"Enter your firstname: "
enter_surname:		.asciz	"Enter your lastname: "
enter_your_address:	.asciz	"Enter your address: "


.section .bss

.lcomm	chunk,	320	# chunk of a record, without age


# Stack offsets of local variables

.equ	ST_INPUT_DESCRIPTOR,	-4

.section .text

.globl	_start
	_start:
		
		movl %esp, %ebp		# Copy stack pointer and make room for local variables
		subl $8, %esp

                movl     ST_ARGC(%ebp), %eax     # put number of arguments in eax
                movl     ST_ARGV_1(%ebp), %ebx   # define filename
                cmpl     $2, %eax                # we always have at least one argument
                jge     open_fd_read_and_write  # if we have arguments then open a file

                movl     $input_file_name, %ebx  # if we do not have arguments, put
                                                # defined filename in ebx

        open_fd_read_and_write:

                # Open file for reading and writening

                movl     $SYS_OPEN, %eax         # open file
                movl     $2, %ecx                # This says to open read and write
                movl     $0666, %edx             # file permissions
                int     $LINUX_SYSCALL
		test    %eax, %eax              # check if eax is zero
                jl      error

                movl     %eax, ST_INPUT_DESCRIPTOR(%ebp)
                xorl     %eax, %eax

		xorl %eax, %eax		# end-of-string symbol
		pushl %eax			
		movl $enter_name, %ecx	# "counter"
		pushl %ecx			

		call	string_size	
		addl $8, %esp

		call	show_message
		test    %eax, %eax              # check if eax is zero
                jl      error

		xorl %eax, %eax		
		movl $chunk, %edi		# our buffer where we store information
		movl $RECORD_AGE, %ecx	# size our chunk without age
		repnz	stosw			# fill our chunk with zeroes
	
		movl $RECORD_LASTNAME, %edx	# put size of our first field in %edx
		decl %edx			# because we always have to end our record with 0x00
		movl $chunk, %ecx		# put address of our chunk into %eax
		
		call	read_kbd
                test    %eax, %eax              # check if eax is zero
                jl      error

		xorl %eax, %eax
		pushl %eax
		movl $enter_surname, %ecx
		pushl %ecx

		call	string_size
		addl $8, %esp

		call	show_message
                test    %eax, %eax              # check if eax is zero
                jl      error


		movl $RECORD_LASTNAME, %ebx	# put size of our first field in %ebx
		pushl %ebx			# save it 
		leal	chunk(,%ebx,1),	%ecx	# save address of our second record in %ecx
		popl %edx			# restore size
		decl %edx			# because we always have to end our record with 0x00

		call    read_kbd
                test    %eax, %eax              # check if eax is zero
                jl      error

                xorl     %eax, %eax
                pushl    %eax
                movl     $enter_your_address, %ecx
                pushl    %ecx

                call    string_size
                addl     $8, %esp

                call    show_message
                test    %eax, %eax              # check if eax is zero
                jl      error

		movl $RECORD_AGE, %edx	# take record age position
		subl $RECORD_ADDRESS, %edx	# substract it from record address position
		decl %edx			# we have 320-80-1 = 239 byte record field
		movl $RECORD_ADDRESS, %ebx	# skip 80 bytes
		leal	chunk(,%ebx,1), %ecx

		call	read_kbd
		test    %eax, %eax              # check if eax is zero
                jl      error

		
	last_field:				# this marker for debugging only

                movl     $RECORD_AGE, %ebx	# our last field
                leal    chunk(,%ebx,1), %ecx	# skip 320 bytes
                movl    $33, (%ecx)		# put our age to the last field

		xorl %ecx, %ecx		# offset
		incl %ecx			# 1
		call	lseek			# move pointer
                addl     $8, %esp

		test    %eax, %eax              # check if eax is zero
                jl      error


	append_to_file:

		movl $SYS_WRITE, %eax
		movl ST_INPUT_DESCRIPTOR(%ebp), %ebx # in a file
		movl $chunk, %ecx			# buffer with our information
		movl $RECORD_SIZE, %edx		# buffer size
		int	$LINUX_SYSCALL

                test    %eax, %eax              # check if eax is zero
                jl      error

		movl $SYS_CLOSE, %eax		# close file
		movl ST_INPUT_DESCRIPTOR(%ebp), %ebx
		int	$LINUX_SYSCALL

	exit:

		movl $SYS_EXIT, %eax
		movl $0, %ebx
		int	$LINUX_SYSCALL

	lseek:

                movl     $0x13, %eax                     # set position of a record
                movl     ST_INPUT_DESCRIPTOR(%ebp), %ebx # in a file
                movl     $0x02, %edx                     # at the end of a file
                int     $LINUX_SYSCALL
		ret


	show_message:

		movl $0x04, %eax		# write to
		movl $0x01, %ebx		# stdout
		int	$0x80
		ret
	
	read_kbd:

		movl $0x03, %eax		# read
		xorl %ebx, %ebx		# from stdin
		int	$0x80		
		ret

        error:

                call    error_handler
                jmp     exit

