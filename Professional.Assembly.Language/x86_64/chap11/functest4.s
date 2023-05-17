# functest4.s - An example of using external functions

.section .data
precision:
   .byte 0x7f, 0x00

.section .bss
   .lcomm result, 4

.section .text
.globl _start
_start:
   nop

   finit
   fldcw precision

   push $10
   call area
   add $8, %rsp
   mov %rax, result

   push $2
   call area
   add $8, %rsp
   mov %rax, result

   push $120
   call area
   add $8, %rsp
   mov %rax, result

   mov $1, %rax
   mov $0, %rbx
   int $0x80
