# movzxtest.s - An example of the MOVZX instruction

.section .text
.globl _start
_start:
   nop

   movl $279, %ecx
   movzx %cl, %ebx

   movq $1, %rax
   int $0x80
