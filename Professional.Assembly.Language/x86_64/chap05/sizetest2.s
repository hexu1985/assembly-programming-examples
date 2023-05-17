# sizetest2.s - A sample program to view the executable size

.section .bss
   .lcomm buffer, 10000

.section .text
.globl _start
_start:
   movq $1, %rax

   movq $0, %rbx
   int $0x80
