# cpureg.s:	Get Special Regs for C
.text
.global locate_idt, get_cr0, get_cr2,  get_cr3, set_cr3, cli, sti
.globl get_eflags, set_eflags, set_cr0, invd
# get address and limit for current IDT
# C call:	 locate_idt(&limit,&addr)
	
locate_idt:
	sidt idt_info		# SIDT instruction: store-IDT
	movl 4(%esp), %ecx	# pointer to place for limit
	movw idt_limit, %dx     # return limit to caller
	movw %dx,(%ecx)		# ...
	movl 8(%esp), %ecx      # pointer to place for addr
	movl idt_addr, %edx     # return addr to caller
	movl %edx,(%ecx)	# ...
	ret

locate_gdt:
	sgdt gdt_info		# SGDT instruction: store-GDT
	movl 4(%esp), %ecx	# pointer to place for limit
	movw gdt_limit, %dx     # return limit to caller
	movw %dx,(%ecx)		# ...
	movl 8(%esp), %ecx      # pointer to place for addr
	movl gdt_addr, %edx     # return addr to caller
	movl %edx,(%ecx)	# ...
	ret

# CPU control bits
get_cr0:	
	movl %cr0, %eax
	ret

set_cr0:	
	movl 4(%esp),%eax	# get argued new-cr0-val into eax
	movl %eax,%cr0		# then into cr0
	ret
		
# PF linear addr
get_cr2:	
	movl %cr2, %eax
	ret
	
# page dir linear addr, flags
get_cr3:	
	movl %cr3, %eax
	ret
	
set_cr3:	
	movl 4(%esp), %eax
	movl %eax, %cr3
	ret
	
	
#get_eflags
# C call:	 eflags = get_eflags()
		
get_eflags:	
	pushfl			# push eflags on stack
	popl %eax		# pop back into eax
	ret

#set_eflags
# C call:	set_eflags(int eflags)
	
set_eflags:
	pushl 4(%esp)
	popfl
	ret

# special instructions--
cli:	cli
	ret

sti:	sti
	ret
#invalidate cache
invd:
	pushl $0                # push something on stack
	wbinvd			# clobbers top of stack
	addl $4,%esp		# pop junk off
	ret
		
.data
idt_info:     # SIDT stores info into argued memory location--
idt_limit:	.word 1
idt_addr:	.long 1  # linear address
gdt_info:     # SGDT stores info into argued memory location--
gdt_limit:	.word 1
gdt_addr:	.long 1  # linear address
