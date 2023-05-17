# PURPOSE: Count the characters until a null byte is reached.
#
# INPUT: The address of the character string
#
# OUTPUT: Returns the count in %eax
#
# PROCESS:
#   Registers used:
#     %ecx - character count
#     %al - current character
#     %edx - current character address

.include "linux.s"

.type count_chars, @function

.globl count_chars

.equ	ST_STRING_START_ADDRESS,	8

count_chars:
	
		enter
	
		xorl %ecx, %ecx	# Counter starts at zero
		movl ST_STRING_START_ADDRESS(%ebp), %edx	# put begin address of our string in edx	

	count_loop_begin:

		movb	(%edx), %al	# Grab the current character
		test	%al, %al	# Is it null?
		jz	count_loop_end	# If yes, we’re done
		incl %ecx		# Otherwise, increment the counter and the pointer
		incl %edx
		jmp	count_loop_begin	# Go back to the beginning of the loop

	count_loop_end:

		movl %ecx, %eax	# We’re done. Move the count into %eax
					# and return.

		leave

		ret

