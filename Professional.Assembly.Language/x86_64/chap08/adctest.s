# adctest.s - An example of using the ADC instruction

.section .data
data1:
   .octa 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
data2:
   .octa 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
output:
   .asciz "The result is %llu_%llu\n"

.section .text
.globl _start
_start:

   mov data1, %rbx
   mov data1+8, %rax
   mov data2, %rdx
   mov data2+8, %rcx
   add %rbx, %rdx
   adc %rax, %rcx

   mov $output, %rdi
   mov %rcx, %rsi
   /* mov %rdx, %rsi */
   call printf

    addq $4, %rsp
    pushq $0
    call exit
