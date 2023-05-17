# area.s - The areacircumference function

.section .text
.type area, @function
.globl area
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
