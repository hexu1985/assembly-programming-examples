# PURPOSE: This program writes the message "hello world" and
#          exits

# first step:  as --32 -o helloworld-lib.o helloworld-lib.s
# second step: ld -melf_i386 -dynamic-linker /lib/ld-linux.so.2 -o helloworld-lib helloworld-lib.o -L /usr/x86_64-linux-gnu/lib32 -lc


.section .data

helloworld:	.ascii	"hello world\n\0"

.section .text

.globl	_start
	_start:
		pushl $helloworld
		call	printf
		pushl $0
		call	exit
	
