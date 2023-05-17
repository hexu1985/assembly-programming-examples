# PURPOSE: This function finds size of a string
#
# INPUT: %ax - should have "end of a string" symbol
#	 %edi - should have address of a string
#
# OUTPUT: %edx size of a string in bytes

# first:  as --32 -o string_size.o string_size.s
# second: ld -melf_i386 -o string_size string_size.o

# Essential errors 
# https://github.com/torvalds/linux/blob/master/include/uapi/asm-generic/errno-base.h

# create stack frame macro
.macro  enter

        pushl    %ebp
        movl     %esp, %ebp

.endm

.section .text
.globl string_size

.type string_size, @function

	string_size:

		enter

		movl 8(%ebp), %edi	# address of our string
		movl 12(%ebp), %eax	# end of a string symbol

		pushl %edi
		pushl %edi
		popl %esi		# begin of our string in %esi
		repne	scasb		# scaning a string for 0x00 byte
		subl %esi, %edi	# substract start address from end address
		movl %edi, %edx	# put lenght of a string 
		popl %ecx
		
		leave

		ret
