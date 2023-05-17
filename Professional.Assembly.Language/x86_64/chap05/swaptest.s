# swaptest.s – An example of using the BSWAP instruction
.section .text
.globl _start
_start:
   nop

   movq $0x1122334455667788, %rbx
   bswap %rbx

   movl $1, %eax
   int $0x80
