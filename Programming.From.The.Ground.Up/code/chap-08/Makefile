
# This quick and dirty makefile for  
# Programming from ground up vol.1 book by
# Jonathan Bartlett written by hands

# I strongly adivise you against making 
# your own makefile by hand from scratch
# There are enormous amount of files 
# written by hand by authors who tought
# (and still thinks) that they are absolutely sure
# what they are doing! They are mistaken!

# Use CMake, or similar tools instead!

.POSIX:
.SUFFIXES:

AS = as
ASFLAGS += --32
LD = ld
LDFLAGS += -melf_i386

HELLOWORLDNOLIB = helloworld-nolib
HELLOWORLDNOLIBOBJ := helloworld-nolib.o

HELLOWORLDLIB = helloworld-lib
HELLOWORLDLIBOBJ := helloworld-lib.o

PRINTFEXAMPLE = printf-example
PRINTFEXAMPLEOBJ := printf-example.o

.PHONY: all

all: helloworld-nolib helloworld-lib printf-example

helloworld-nolib.o: helloworld-nolib.s
	$(AS) $(ASFLAGS) $^ -o $@

helloworld-nolib: helloworld-nolib.o
	$(LD) $(LDFLAGS) $^ -o $@

helloworld-lib.o: helloworld-lib.s
	$(AS) $(ASFLAGS) $^ -o $@

helloworld-lib: helloworld-lib.o
	$(LD) $(LDFLAGS) -dynamic-linker /lib/ld-linux.so.2 $^ -o $@ -L /usr/x86_64-linux-gnu/lib32 -lc

printf-example.o: printf-example.s
	$(AS) $(ASFLAGS) $^ -o $@

printf-example: printf-example.o
	$(LD) $(LDFLAGS) -dynamic-linker /lib/ld-linux.so.2 $^ -o $@ -L /usr/x86_64-linux-gnu/lib32 -lc

clean:
	rm -f $(HELLOWORLDNOLIB) $(HELLOWORLDNOLIBOBJ) $(HELLOWORLDLIB) $(HELLOWORLDLIBOBJ) $(PRINTFEXAMPLE) $(PRINTFEXAMPLEOBJ) 
