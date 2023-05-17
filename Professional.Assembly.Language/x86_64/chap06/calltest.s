# calltest.s -– An example of using the CALL instruction

.section .data
output:
   .asciz "This is section %d\n"

.section .text
.globl _start
_start:

   movq $output, %rdi
   movq $1, %rsi
   call printf

   call overhere

   movq $output, %rdi
   movq $3, %rsi
   call printf

   movq $0, %rdi
   call exit

overhere:
   push %rbp
   mov %rsp, %rbp

   movq $output, %rdi
   movq $2, %rsi
   call printf

   mov %rbp, %rsp
   pop %rbp
   ret
