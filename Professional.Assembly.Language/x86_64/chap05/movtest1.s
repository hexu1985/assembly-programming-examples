# movtest1.s – An example of moving data from memory to a register
.section .data
   valueq:
      .quad 1
   value:
      .long 1


.section .text
.globl _start
   _start:
      nop

      movl value, %ecx
      movq valueq, %rsi
      movq $1, %rax

      movq $0, %rbx
      int $0x80
