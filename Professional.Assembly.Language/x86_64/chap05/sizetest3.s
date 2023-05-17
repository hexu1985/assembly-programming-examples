# sizetest3.s - A sample program to view the executable size
.section .data
buffer:
   .fill 10000

.section .text
.globl _start
_start:
   movq $1, %rax

   movq $0, %rbx
   int $0x80
