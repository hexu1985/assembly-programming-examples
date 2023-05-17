# subtest2.s - An example of a subtraction carry

.section .text
.globl _start
_start:
   nop

   movl $2, %eax
   movl $5, %ebx
   subl %eax, %ebx
   jc under
   movl $1, %eax
   int $0x80

under:
   movl $1, %eax
   movl $0, %ebx
   int $0x80
