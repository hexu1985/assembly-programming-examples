
# PURPOSE: This function print error code to STDOUT
#
# INPUT: error code in %eax register
#
# OUTPUT: This function returns a error code as a status code.

# first:  as --32 -o error-handler.o error-handler.s
# second: ld -melf_i386 -o error-handler error-handler.o

# Essential errors 
# https://github.com/torvalds/linux/blob/master/include/uapi/asm-generic/errno-base.h

.equ	EPERM,		-1	# Operation not permitted 
.equ	ENOENT,		-2	# No such file or directory 
.equ	ESRCH,		-3	# No such process 
.equ	EINTR,		-4	# Interrupted system call 
.equ	EIO,		-5	# I/O error 
.equ	ENXIO,		-6	# No such device or address 
.equ	E2BIG,		-7	# Argument list too long 
.equ	ENOEXEC,	-8	# Exec format error 
.equ	EBADF,		-9	# Bad file number 
.equ	ECHILD,		-10	# No child processes 
.equ	EAGAIN,		-11	# Try again 
.equ	ENOMEM,		-12	# Out of memory 
.equ	EACCES,		-13	# Permission denied 
.equ	EFAULT,		-14	# Bad address 
.equ	ENOTBLK,	-15	# Block device required 
.equ	EBUSY,		-16	# Device or resource busy 
.equ	EEXIST,		-17	# File exists 
.equ	EXDEV,		-18	# Cross-device link 
.equ	ENODEV,		-19	# No such device 
.equ	ENOTDIR,	-20	# Not a directory 
.equ	EISDIR,		-21	# Is a directory 
.equ	EINVAL,		-22	# Invalid argument 
.equ	ENFILE,		-23	# File table overflow 
.equ	EMFILE,		-24	# Too many open files 
.equ	ENOTTY,		-25	# Not a typewriter 
.equ	ETXTBSY,	-26	# Text file busy 
.equ	EFBIG,		-27	# File too large 
.equ	ENOSPC,		-28	# No space left on device 
.equ	ESPIPE,		-29	# Illegal seek 
.equ	EROFS,		-30	# Read-only file system 
.equ	EMLINK,		-31	# Too many links 
.equ	EPIPE,		-32	# Broken pipe 
.equ	EDOM,		-33	# Math argument out of domain of func 
.equ	ERANGE,		-34	# Math result not representable 

.section .data

eperm_message:		.asciz "Operation not permitted\n"

enoent_message:		.asciz "No such file or directory\n"

esrch_message:		.asciz "No such process\n"

eintr_message:		.asciz "Interrupted system call\n"

eio_message:		.asciz "I/O error\n"

enxio_message:		.asciz "No such device or address\n"

e2big_message:		.asciz "Argument list too long\n"

enoexec_message:	.asciz "Exec format error\n"

ebadf_message:		.asciz "Bad file number\n"

echild_message:		.asciz "No child processes\n"

eagain_message:		.asciz "Try again\n"

enomem_message:		.asciz "Out of memory\n"

eacces_message:		.asciz "Permission denied\n"

efault_message:		.asciz "Bad address\n"

enotblk_message:	.asciz "Block device required\n"

ebusy_message:		.asciz "Device or resource busy\n"

eexist_message:		.asciz "File exists\n"

exdev_message:		.asciz "Cross-device link \n"

enodev_message:		.asciz "No such device\n"

enotdir_message:	.asciz "Not a directory\n"

eisdir_message:		.asciz "Is a directory\n"

einval_message:		.asciz "Invalid argument\n"

enfile_message:		.asciz "File table overflow\n"

emfile_message:		.asciz "Too many open files\n"

enotty_message:		.asciz "Not a typewriter\n"

etxtbsy_message:	.asciz "Text file busy\n"

efbig_message:		.asciz "File too large\n"

enospc_message:		.asciz "No space left on device\n"

espipe_message:		.asciz "Illegal seek\n"

erofs_message:		.asciz "Read-only file system\n"

emlink_message:		.asciz "Too many links\n"

epipe_message:		.asciz "Broken pipe\n"

edom_message:		.asciz "Math argument out of domain of func\n"

erange_message:		.asciz "Math result not representable\n"

unknown_message:        .asciz "I do not know about this error!\n"

error_list:
		.long	_eperm
		.long	_enoent
		.long	_esrch
		.long	_eintr
		.long	_eio
		.long	_enxio
		.long	_e2big
		.long	_enoexec
		.long	_ebadf
		.long	_echild
		.long	_eagain
		.long	_enomem
		.long	_eacces
		.long	_efault
		.long	_enotblk
		.long	_ebusy
		.long	_eexist
		.long	_exdev
		.long	_enodev
		.long	_enotdir
		.long	_eisdir
		.long	_einval
		.long	_enfile
		.long	_emfile
		.long	_enotty
		.long	_etxtbsy
		.long	_efbig
		.long	_enospc
		.long	_espipe
		.long	_erofs
		.long	_emlink
		.long	_epipe
		.long	_edom
		.long	_erange

error_number:	.int	34

.section .text
.globl error_handler
.type error_handler, @function

error_handler:
		neg	%eax				# change sign of error code
		decl %eax				# because arrays starts from 0
		cmpl error_number, %eax
		jg	unknown_error			# is this an error code we know about?
		movl error_list(,%eax,4), %eax	# load error message
		jmp	%eax

	_eperm:
		movl     $eperm_message, %ecx      	# display string
		jmp	show_error

	_enoent:
		movl $enoent_message, %ecx
		jmp	show_error

	_esrch:
		movl $esrch_message, %ecx
		jmp	show_error

	_eintr:
		movl $eintr_message, %ecx
		jmp	show_error

	_eio:
		movl $eio_message, %ecx
		jmp	show_error

	_enxio:
		movl $enxio_message, %ecx
		jmp	show_error

	_e2big:
		movl $e2big_message, %ecx
		jmp	show_error

	_enoexec:
		movl $enoexec_message, %ecx
		jmp	show_error

	_ebadf:
		movl $ebadf_message, %ecx
		jmp	show_error

	_echild:
		movl $echild_message, %ecx
		jmp	show_error

	_eagain:
		movl $eagain_message, %ecx
		jmp	show_error

	_enomem:
		movl $enomem_message, %ecx
		jmp	show_error

	_eacces:
		movl $eacces_message, %ecx
		jmp	show_error

	_efault:
		movl $efault_message, %ecx
		jmp	show_error
	
	_enotblk:
		movl     $enotblk_message, %ecx
                jmp     show_error

	_ebusy:
		movl $ebusy_message, %ecx
		jmp	show_error

	_eexist:
		movl $eexist_message, %ecx
		jmp	show_error

	_exdev:
		movl $exdev_message, %ecx
		jmp	show_error

	_enodev:
		movl $enodev_message, %ecx
		jmp	show_error

	_enotdir:
		movl $enotdir_message, %ecx
		jmp	show_error

	_eisdir:
		movl $eisdir_message, %ecx
		jmp	show_error

	_einval:
		movl $einval_message, %ecx
		jmp	show_error

	_enfile:
		movl $enfile_message, %ecx
		jmp	show_error

	_emfile:
		movl $emfile_message, %ecx
		jmp	show_error

	_enotty:
		movl $enotty_message, %ecx
		jmp	show_error

	_etxtbsy:
		movl $etxtbsy_message, %ecx
		jmp	show_error

	_efbig:
		movl $efbig_message, %ecx
		jmp	show_error

	_enospc:
		movl $enospc_message, %ecx
		jmp	show_error

	_espipe:
		movl $espipe_message, %ecx
		jmp	show_error

	_erofs:
		movl $erofs_message, %ecx
		jmp	show_error

	_emlink:
		movl $emlink_message, %ecx
		jmp	show_error

	_epipe:
		movl $epipe_message, %ecx
		jmp	show_error

	_edom:
		movl $edom_message, %ecx
		jmp	show_error

	_erange:
		movl $erange_message, %ecx
		jmp	show_error

	unknown_error:

		movl $unknown_message, %ecx

	show_error:
		
		pushl %eax

                xorl     %eax, %eax		# end of a string symbol in %al 
                pushl    %eax			# pushl end of a string symbol
                pushl    %ecx			# pushl string
                call    string_size		# calculate string size
		addl $8, %esp

		movl     $0x04, %eax             # write to
                movl     $0x01, %ebx             # stdout
                int     $0x80

# NOTE - %ebx has the return value, which we will
#        give back to our calling program

		popl %ebx

		ret

