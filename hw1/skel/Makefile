CC = gcc
C_FLAGS =  -m32 -O2 -g 
NASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld  -melf_i386

all : tema1 

tema1: tema1.o 
	$(CC) $(C_FLAGS) -o tema1 tema1.o

%.o : %.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS))
	$(CC) -c $(C_FLAGS) -o $@ $<

%.o : %.asm
	$(warning NASM=$(NASM) FLAGS=$(ASM_FLAGS))
	$(NASM) $(ASM_FLAGS) -o $@ $<
run :
	./tema1
clean: 
	rm -f *.o tema1 

