# cpuidtest.s - An example of using the TEST instruction
.section .data

output_cpuid:
   .asciz "This processor supports the CPUID instruction\n"
output_nocpuid:
   .asciz "This processor does not support the CPUID instruction\n"

.section .text
.globl _start
_start:
   nop

   pushf
   pop %rax
   mov %rax, %rdx
   xor $0x00200000, %rax
   push %rax
   popf
   pushf
   pop %rax
   xor %rdx, %rax
   test $0x00200000, %rax
   jnz cpuid

   mov $output_nocpuid, %edi
   call printf

   push $0
   call exit

cpuid:

   mov $output_cpuid, %edi
   call printf

   push $0
   call exit
