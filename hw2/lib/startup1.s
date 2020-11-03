# asm startup file
# very first module in load

   movl $0x3ffff0, %esp   # set user program stack
   call _clr_bss	  # clear BSS area (uninitialized data)
   call _init_devio       # set up C lib i/o, enabling getc, putc, etc
   call _start            # call _start of user assembler program
   int $3                 # return to Tutor


