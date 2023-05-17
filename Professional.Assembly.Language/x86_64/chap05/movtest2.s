# movtest2.s – An example of moving register data to memory

.section .data
   value:
      .int 1

.section .text
.globl _start
   _start:
      nop

      movl $100, %eax
      movl %eax, value
      movq $1, %rax

      movq $0, %rbx
      int $0x80
