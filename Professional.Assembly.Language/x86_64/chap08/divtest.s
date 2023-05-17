# divtest.s - An example of the DIV instruction

.section .data
dividend:
   .quad 8335
divisor:
   .int 25
quotient:
   .int 0
remainder:
   .int 0
output:
   .asciz "The quotient is %d, and the remainder is %d\n"

.section .text
.globl _start
_start:
   nop

   movl dividend, %eax
   movl dividend+4, %edx
   divw divisor                      # WRONG prefix!

   movl %eax, quotient
   movl %edx, remainder

   mov $output, %rdi
   mov quotient, %rsi
   mov remainder, %rdx
   call printf

   push $0
   call exit
