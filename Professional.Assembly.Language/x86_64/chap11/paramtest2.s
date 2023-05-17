# paramtest2.s - Listing system environment variables

.section .data
output:
   .asciz "%s\n"

.section .text
.globl _start
_start:

   mov %rsp, %rbp
   add $24, %rbp  # +8 params num; +8 command; +8 padding
loop1:
   cmp $0, (%rbp)
   je endit

   mov $output, %rdi
   mov (%rbp), %rsi
   call printf

   add $8, %rbp  # next env var on stack
   loop loop1

endit:
   mov $0, %rdi
   call exit
