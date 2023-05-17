# cmptest.s - An example of using the CMP and JGE instructions

.section .text
.globl _start
_start:
   nop

   mov $15, %rax
   mov $10, %rbx
   cmp %rax, %rbx
   jge greater

   mov $1, %rax
   int $0x80

greater:
   mov $20, %rbx

   mov $1, %rax
   int $0x80
