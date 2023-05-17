# functest3.s - An example of using C style functions

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

.type area, @function
area:

   push %rbp
   mov %rsp, %rbp
   sub $8, %rsp

   fldpi
   filds 16(%rbp)
   fmul %st(0), %st(0)
   fmulp %st(0), %st(1)
   fstps -8(%rbp)
   mov -8(%rbp), %rax

   mov %rbp, %rsp
   pop %rbp
   ret
