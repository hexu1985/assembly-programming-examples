# subtest3.s - An example of an overflow condition in a SUB instruction

.section .data
output:
   .asciz "The result is %li\n"

.section .text
.globl _start
_start:

   mov $-9223372036854775807, %rbx

   /* mov $-9223372036854775807, %rax */
   /* mov $-9223372036854775806, %rax */
   mov $2, %rax

   subq %rax, %rbx
   jo over

   mov $output, %rdi
   mov %rbx, %rsi
   call printf

   add  $8, %rsp
   push $0
   call exit

over:
   mov $output, %rdi
   mov $0, %rsi
   call printf

   add  $8, %rsp
   push $0
   call exit
