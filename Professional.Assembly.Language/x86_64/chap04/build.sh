# build cpuid.s
as -g -o cpuid.o cpuid.s
ld -o cpuid cpuid.o

# build cpuid2.s
as -g -o cpuid2.o cpuid2.s
ld -o cpuid2 cpuid2.o -e main -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc 

