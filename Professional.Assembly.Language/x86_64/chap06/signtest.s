# signtest.s - An example of using the sign flag

.section .data
value:
   .int 21, 15, 34, 11, 6, 50, 32, 80, 10, 2
output:
   .asciz "The value is: %d\n"

.section .text
.globl _start
_start:

   mov $9, %rbx

loop:
   mov $output, %rdi
   mov value(, %rbx, 4), %rsi
   call printf

   dec %rbx
   jns loop

   mov $1, %rax
   mov $10, %rbx
   int $0x80
