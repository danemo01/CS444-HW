.globl main, ustart, exit

ustart:
    movl $0x3ffff0, %esp   # set user program stack
    call main
    pushl %eax
    call exit