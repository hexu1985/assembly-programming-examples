# betterloop.s - An example of the loop and jcxz instructions

.section .data
output:
   .asciz "The value is: %d\n"

.section .text
.globl _start
_start:

   mov $0, %rcx
   # mov $10, %rcx
   mov $0, %rax
   jrcxz done

loop1:
   add %rcx, %rax
   loop loop1

done:
   mov $output, %rdi
   mov %rax, %rsi
   call printf

   mov $1, %rax
   mov $0, %rbx
   int $0x80
