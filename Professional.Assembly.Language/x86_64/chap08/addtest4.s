# addtest4.s - An example of detecting an overflow condition

.section .data
output:
   .asciz "The result is %ld\n"

.section .text
.globl _start
_start:

   mov $-12908769340, %rbx
   mov $-12592301430, %rax
   add %rax, %rbx
   jo over

   mov %rbx, %rsi
   mov $output, %rdi
   movq $0, %rax
   call printf

   movl $0, %edi
   call exit

over:
   movl $0, %esi
   movl $output, %edi
   call printf

   movl $0, %edi
   call exit
