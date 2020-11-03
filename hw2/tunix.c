#include "io_public.h"
#include "cpu.h"
#include <gates.h>
#include <stdio.h>

extern void locate_idt(unsigned int *limitp, char ** idtp);
extern void ustart();
extern void uexit();
extern IntHandler syscall;

// Function Prototypes
void set_trap_gate(int n, IntHandler *inthand_addr);
void debug_set_trap_gate(int n, IntHandler *inthand_addr, int debug);
void syscallc(int user_eax, int arg1, char * arg2, int arg3);
int sysexit(int exitcode);

void idkwtfimdoing(){
    ioinit();
    set_trap_gate(0x80, &syscall);
    ustart(); //?????
}

void set_trap_gate(int n, IntHandler *inthand_addr)
{
  debug_set_trap_gate(n, inthand_addr, 0);
}

/* write the nth idt descriptor as an interrupt gate to inthand_addr */
void debug_set_trap_gate(int n, IntHandler *inthand_addr, int debug)
{
  char *idt_LAaddr;		/* linear address of IDT */
  char *idt_VAaddr;		/* virtual address of IDT */
  Gate_descriptor *idt, *desc;
  unsigned int limit = 0;

  if (debug)
    printf("Calling locate_idt to do sidt instruction...\n");
  locate_idt(&limit,&idt_LAaddr);
  /* convert to virtual address, i.e., ordinary address */
  idt_VAaddr = idt_LAaddr - KERNEL_BASE_LA;  /* usable address of IDT */
  /* convert to a typed pointer, for an array of Gate_descriptor */
  idt = (Gate_descriptor *)idt_VAaddr;
  if (debug)
    printf("Found idt at %x, lim %x\n",idt, limit);
  desc = &idt[n];		/* select nth descriptor in idt table */
  /* fill in descriptor */
  if (debug)
    printf("Filling in desc at %x with addr %x\n",(unsigned int)desc,
	   (unsigned int)inthand_addr);
  desc->selector = KERNEL_CS;	/* CS seg selector for int. handler */
  desc->addr_hi = ((unsigned int)inthand_addr)>>16; /* CS seg offset of inthand  */
  desc->addr_lo = ((unsigned int)inthand_addr)&0xffff;
  desc->flags = GATE_P|GATE_DPL_KERNEL|GATE_TRAPGATE; /* valid, trap */
  desc->zero = 0;
}

void syscallc(int user_eax, int arg1, char * arg2, int arg3) {
    switch(user_eax) {
        case 1: // SYS_EXIT
            user_eax = sysexit(arg1);
            break;
        case 3: // SYS_READ
            user_eax = sysread(arg1,arg2,arg3);
            break;
        case 4: // SYS_WRITE
            user_eax = syswrite(arg1,arg2,arg3);
            break;
        default:
            break;
    }
}

