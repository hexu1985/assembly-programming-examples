# sysinfo.s - Retrieving system information via kernel system calls
.section .data
format:
    .asciz "uptime %ld\nfreeram %ld\nmem_unit %d\n"
result:
uptime:
   .long 0
load1:
   .long 0
load5:
   .long 0
load15:
   .long 0
totalram:
   .long 0
freeram:
   .long 0
sharedram:
   .long 0
bufferram:
   .long 0
totalswap:
   .long 0
freeswap:
   .long 0
procs:
   .byte 0x00, 0x00
totalhigh:
   .long 0
freehigh:
   .long 0
memunit:
   .int 0

.section .text
.globl _start
_start:
   nop

   movl $result, %ebx
   movl $116, %eax
   int $0x80

   mov $format, %rdi
   mov uptime, %rsi
   mov freeram, %rdx
   mov memunit, %rcx
   mov $3, %rax
   call printf

   movl $0, %ebx
   movl $1, %eax
   int $0x80
