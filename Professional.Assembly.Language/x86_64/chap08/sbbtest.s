# sbbtest.s - An example of using the SBB instruction

.section .data
data1:
   .octa 0x7FFFFFFFFFFFFFFF7FFFFFFFFFFFFFFF
data2:
   .octa 0x711111111111111111111111111111
output:
   .asciz "The result is %lli_%lli\n"

.section .text
.globl _start
_start:
   nop

   mov data1, %rbx
   mov data1+8, %rax
   mov data2, %rdx
   mov data2+8, %rcx

   sub %rbx, %rdx
   sbb %rax, %rcx

   mov $output, %rdi
   mov %rcx, %rsi
   /* mov %rdx, %rsi */
   call printf

   addq  $4, %rsp
   pushq $0
   call exit
