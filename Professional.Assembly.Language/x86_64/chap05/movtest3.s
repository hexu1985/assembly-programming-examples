# movtest3.s – Another example of using indexed memory locations

.section .data
output:
   .asciz "The value is %d\n"
values:
   .int 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60

.section .text
.globl _start
_start:
   nop
   movq $0, %rbp

loop:
   movq $output, %rdi
   movq values(, %rbp, 4), %rsi
   xor  %rax, %rax
   call printf

   inc %rbp
   cmpq $11, %rbp
   jne loop

   movq $0, %rbx
   movq $1, %rax
   int $0x80
