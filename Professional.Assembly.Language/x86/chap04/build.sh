# build cpuid.s
as -g --32 -o cpuid.o cpuid.s
ld -o cpuid cpuid.o -m elf_i386 

# build cpuid2.s
as -g --32 -o cpuid2.o cpuid2.s
ld -m elf_i386 -o cpuid2 cpuid2.o -dynamic-linker /lib/ld-linux.so.2 -L/lib32 -lc 
#ld -e main -m elf_i386 -o cpuid2 cpuid2.o -dynamic-linker /lib/ld-linux.so.2 -L/lib32 -lc 

