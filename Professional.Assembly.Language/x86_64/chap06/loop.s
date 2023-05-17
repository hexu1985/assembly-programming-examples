# loop.s - An example of the loop instruction

.section .data
output:
   .asciz "The value is: %d\n"

.section .text
.globl _start
_start:

   mov $100, %rcx
   mov $0, %rax

loop1:
   add %rcx, %rax

   loop loop1

   mov $output, %rdi
   mov %rax, %rsi
   call printf

   mov $1, %rax
   mov $0, %rbx
   int $0x80
