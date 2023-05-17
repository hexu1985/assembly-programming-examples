# paramtest1.s - Listing command line parameters

.section .data
output1:
   .asciz "There are %d parameters:\n"
output2:
   .asciz "%s\n"

.section .text
.globl _start
_start:

   mov (%rsp), %rcx

   push %rcx
   sub $8, %rsp  # align stack to 16

   mov $output1, %rdi
   mov %rcx, %rsi
   call printf
   add $8, %rsp

   pop %rcx

   mov %rsp, %rbp
   add $8, %rbp  # from argc to argv

loop1:
   push %rcx
   sub $8, %rsp  # align stack to 16

   mov $output2, %rdi
   mov (%rbp), %rsi
   call printf
   add $8, %rsp

   pop %rcx

   add $8, %rbp  # next param

   loop loop1

   mov $0, %rdi
   call exit
