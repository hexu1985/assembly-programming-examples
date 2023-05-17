# functest1.s - An example of using functions

.section .data
precision:
   .byte 0x7f, 0x00

.section .bss
   .lcomm value, 4
   .lcomm result, 4

.section .text
.globl _start
_start:
   nop

   finit
   fldcw precision

   mov $10, %rdi
   call area

   mov $2, %rdi
   call area

   mov $120, %rdi
   call area

   mov $1, %rax
   mov $0, %rbx
   int $0x80

.type area, @function
area:

   fldpi

   imul %rdi, %rdi
   mov %rdi, value
   filds value
   fmulp %st(0), %st(1)
   fstp result

   ret
