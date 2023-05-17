# sizetest1.s – A sample program to view the executable size
.section .text

.globl _start
_start:
   movq $1, %rax

   movq $0, %rbx
   int $0x80
