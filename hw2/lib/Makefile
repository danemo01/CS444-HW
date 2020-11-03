#
#  Make the SAPC version of the C run-time support library
#  Compile this on a 32-bit Linux system to avoid
#  "Dwarf error: wrong version in compilation unit header
#  (is 4, should be 2)"
#
COMPILER_ROOT = /usr/bin/

CC 	=	${COMPILER_ROOT}gcc
cPP	=	${COMPILER_ROOT}gcc -E
AS  	=	${COMPILER_ROOT}as --32
LD	=	${COMPILER_ROOT}ld
OBJCOPY	=	${COMPILER_ROOT}objcopy

INCLUDE	= -I. -I../include
#CFLAGS_EXTRA = -D_GNU_SOURCE
CFLAGS	= -gdwarf-2 -gstrict-dwarf -march=i586 -m32 -fno-builtin -fno-stack-protector -nostdlib -c -Wall ${INCLUDE}

# Loader flags
LDFLAGS = -m elf_i386		  

LIBNAME = libc

# wipe out default suffixes list--
.SUFFIXES:
.SUFFIXES: .o .c .s

.s.o:
		${AS} -o $@ ${AFLAGS} $<

.c.o:
		${CC} -o $@ ${CFLAGS} $<

CFILES_XINU = abs.c atoi.c atol.c bzero.c ctype_.c doprnt.c doscan.c	\
		fgetc.c	fdoprnt.c fgets.c fprintf.c fputc.c fputs.c	\
		fscanf.c getchar.c labs.c memchr.c memcmp.c memcpy.c	\
		memset.c printf.c putchar.c qsort.c rand.c sprintf.c	\
		sscanf.c strchr.c strrchr.c strstr.c strncat.c		\
		strncmp.c strncpy.c strnlen.c strcmp.c strcpy.c		\
		strlen.c strcat.c                                       \
                gets.c puts.c cpu.c pic.c mmu.c kprintf.c

CFILES	=	$(CFILES_XINU) scanf.c devio.c 

AFILES =       irq0.s irq1.s irq3.s irq4.s irq5.s irq6.s \
               irq7.s irq8.s irq9.s irq10.s irq11.s irq12.s \
               irq13.s irq14.s irq15.s                      \
               bootparams.s cpureg.s portio.s ecvt.s support.s

OFILE1 = ${AFILES:%.s=%.o}
OFILE2 = ${CFILES:%.c=%.o}

OFILES = $(OFILE1) $(OFILE2)

all:		${LIBNAME}.a startup0.o startup.o startup1.o

${LIBNAME}.a:	${OFILES}
		rm -f ${LIBNAME}.a
		${AR} cr ${LIBNAME}.a ${OFILES}

startup0.o:  startup0.s
startup1.o:  startup1.s
startup.o:   startup.c

clean:
		rm -f *.o ${LIBNAME}.a
