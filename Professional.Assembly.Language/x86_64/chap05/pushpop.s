# pushpop.s - An example of using the PUSH and POP instructions
.section .data
data:
   .int 125

.section .text
.globl _start
_start:
   nop

   movl $24420, %ecx
   movw $350, %bx
   movb $100, %al

   push %rcx
   push %bx
   push %rax
   push data
   push $data

   pop %rax
   pop %rax
   pop %rax
   pop %ax
   pop %rax

   movl $0, %ebx
   movl $1, %eax
   int $0x80
