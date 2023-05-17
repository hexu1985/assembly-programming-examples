# cmovtest.s - An example of the CMOV instructions

.section .data
output:
   .asciz "The largest value is %d\n"
values:
   .int 105, 235, 61, 315, 134, 221, 53, 145, 117, 5

.section .text
.globl _start
_start:
   nop

   movl values, %esi

   movq $1, %rbp
loop:

   movl values(, %ebp, 4), %ebx
   cmp %esi, %ebx
   cmova %ebx, %esi

   inc %rbp
   cmp $10, %rbp
   jne loop

   movq $output, %rdi
   # rsi alredy here
   call printf

   movq $0, %rdi
   call exit
