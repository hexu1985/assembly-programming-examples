# paritytest.s - An example of testing the parity flag

.section .text
.globl _start
_start:

   mov $1, %rax

   mov $4, %rbx
   sub $3, %rbx
   jp overhere
   int $0x80

overhere:
   mov $100, %rbx
   int $0x80
