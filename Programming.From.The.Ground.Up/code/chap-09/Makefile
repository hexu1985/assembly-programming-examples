
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
ASFLAGS += --32 -g
LD = ld
LDFLAGS += -melf_i386

WRITERECORDS = write-records
WRITERECORDSOBJ := write-record.o write-records.o error-handler.o

READRECORDS = read-records
READRECORDSOBJ := read-record.o count-chars.o write-newline.o read-records.o error-handler.o

ADDYEAR = add-year
ADDYEAROBJ := add-year.o error-exit.o

ERRORHANDLEROBJ := errorhandler.o

STRINGSIZEOBJ := string-size.o

ADDRECORD = add-record
ADDRECORDOBJ := add-record.o

ALLOC = alloc
ALLOCOBJ := alloc.o

.PHONY: all

all: write-records read-records add-year add-record

error-handler.o: error-handler.s
	$(AS) $(ASFLAGS) $^ -o $@

string-size.o: string-size.s
	$(AS) $(ASFLAGS) $^ -o $@

write-record.o: write-record.s
	$(AS) $(ASFLAGS) $^ -o $@

write-records.o: write-records.s
	$(AS) $(ASFLAGS) $^ -o $@

write-records: write-record.o write-records.o \
	       error-handler.o string-size.o
	$(LD) $(LDFLAGS) $^ -o $@

read-record.o: read-record.s
	$(AS) $(ASFLAGS) $^ -o $@

count-chars.o: count-chars.s
	$(AS) $(ASFLAGS) $^ -o $@

write-newline.o: write-newline.s
	$(AS) $(ASFLAGS) $^ -o $@

read-records.o: read-records.s
	$(AS) $(ASFLAGS) $^ -o $@

alloc.o: alloc.s
	$(AS) $(ASFLAGS) $^ -o $@

read-records: read-record.o count-chars.o \
	      write-newline.o read-records.o \
	      error-handler.o string-size.o \
	      alloc.o
	$(LD) $(LDFLAGS) $^ -o $@

error-exit.o: error-exit.s
	$(AS) $(ASFLAGS) $^ -o $@

add-year.o: add-year.s
	$(AS) $(ASFLAGS) $^ -o $@

add-year: add-year.o read-record.o write-record.o \
	  error-handler.o string-size.o
	$(LD) $(LDFLAGS) $^ -o $@

add-record.o: add-record.s
	$(AS) $(ASFLAGS) $^ -o $@

add-record: add-record.o read-record.o write-record.o \
	    error-handler.o string-size.o
	$(LD) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(WRITERECORDS) $(WRITERECORDSOBJ) $(READRECORDS) $(READRECORDSOBJ) $(ADDYEAR) $(ADDYEAROBJ) $(ERRORHANDLEROBJ) $(STRINGSIZEOBJ) $(ADDRECORD) $(ADDRECORDOBJ) \
	      $(ALLOC) $(ALLOCOBJ)

