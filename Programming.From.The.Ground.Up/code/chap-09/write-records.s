.include	"linux.s"
.include	"record-def.s"

.section .data

# Constant data of the records we want to write
# Each text data item is padded to the proper
# length with null (i.e. 0) bytes.
# .rept is used to pad each item. .rept tells
# the assembler to repeat the section between
# .rept and .endr the number of times specified.
# This is used in this program to addl extra null
# characters at the end of each field to fill
# it up

# first:  as --32 -o write-records.o write-records.s
# second: ld -melf_i386 -o write-records write-records.o


record1:

	.ascii	"Fredrick\0"
	.rept	31		# Padding to 40 bytes
	.byte	0
	.endr

	.ascii	"Bartlett\0"
	.rept	31		# Padding to 40 bytes
	.byte	0
	.endr

	.ascii	"4242 S Prairie\nTulsa, OK 55555\0"
	.rept	209		# Padding to 240 bytes
	.byte	0
	.endr
	.long	45


record2:

	.ascii	"Marilyn\0"
	.rept	32		# Padding to 40 bytes
	.byte	0
	.endr

	.ascii	"Taylor\0"
	.rept	33		# Padding to 40 bytes
	.byte	0
	.endr

	.ascii	"2224 S Johannan St\nChicago, IL 12345\0"
	.rept	203		# Padding to 240 bytes
	.byte	0
	.endr
	.long	29


record3:

	.ascii	"Derrick\0"
	.rept	32		# Padding to 40 bytes
	.byte	0
	.endr

	.ascii	"McIntire\0"
	.rept	31 		# Padding to 40 bytes
	.byte	0
	.endr

	.ascii	"500 W Oakland\nSan Diego, CA 54321\0"
	.rept	206		# Padding to 240 bytes
	.byte	0
	.endr
	.long	36

record4:
	
	.ascii	"Andrew\0"
	.rept	33		# Padding to 40 bytes
	.byte	0
	.endr

	.ascii	"Vedischev\0"	
	.rept	30		# Padding to 40 bytes
	.byte	0
	.endr

	.ascii	"8010 Arrowhead Lane\nHouston, TX 77075\0"
	.rept	202		# Padding to 240 bytes
	.byte	0	
	.endr
	.long	38


file_name:	.ascii	"test.dat\0"	#This is the name of the file we will write to

	.equ	ST_FILE_DESCRIPTOR,	-4

.globl _start
	
	_start:

		movl %esp, %ebp	# Copy the stack pointer to %ebp
		subl $4, %esp	# Allocate space to hold the file descriptor

		movl ST_ARGC(%ebp), %eax	# put number of arguments in eax
		movl ST_ARGV_1(%ebp), %ebx	# define filename
		cmpl $2, %eax		# we always have at least one argument
		jge	open_fd_read		# if we have arguments then open a file
	
		movl $file_name, %ebx	# if we do not have arguments, put
						# defined filename in ebx
	open_fd_read:

		movl $SYS_OPEN, %eax	# open the file
		movl $0101, %ecx	# This says to create if it
					# doesn’t exist, and open for
					# writing
		movl $0666, %edx
		int	$LINUX_SYSCALL

                test    %eax, %eax              # check if eax is zero
                jge     no_error

                call    error_handler
                jmp     exit

        no_error:

		movl %eax, ST_FILE_DESCRIPTOR(%ebp)	# Store the file descriptor away

		# Write the first record
		pushl ST_FILE_DESCRIPTOR(%ebp)
		pushl $record1
		call	write_record
		addl $8, %esp
		
		# Write the second record
		pushl    ST_FILE_DESCRIPTOR(%ebp)
                pushl    $record2
                call    write_record
                addl     $8, %esp

                # Write the third record
                pushl    ST_FILE_DESCRIPTOR(%ebp)
                pushl    $record3
                call    write_record
                addl     $8, %esp

		# Write the forth record
		pushl    ST_FILE_DESCRIPTOR(%ebp)
                pushl    $record4
                call    write_record
                addl     $8, %esp


		# Close the file descriptor
		movl $SYS_CLOSE, %eax
		movl ST_FILE_DESCRIPTOR(%ebp), %ebx
		int	$LINUX_SYSCALL

		xorl %ebx, %ebx

	exit:
		# Exit the program
		movl $SYS_EXIT, %eax
		int     $LINUX_SYSCALL
