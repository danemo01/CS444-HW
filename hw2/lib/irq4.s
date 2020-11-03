# like linux SAVE_MOST and RESTORE_MOST macros in irq.h
.text
.globl irq4inthand, irq4inthandc
KERNEL_DS = 0x18

irq4inthand: cld		# D bit gets restored to old val by iret
	push %es        # in case user code changes data segments
	push %ds
	pushl %eax	# save C scratch regs
	pushl %edx
	pushl %ecx
	movl $KERNEL_DS, %edx
	mov %dx, %ds	# make sure our data segs are in use now
	mov %dx, %es
	call irq4inthandc  # call C interrupt handler
	popl %ecx
	popl %edx
	popl %eax
	pop %ds
	pop %es
	iret

