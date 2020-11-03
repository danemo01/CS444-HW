.globl breakpoint, clr_bss

# break to Tutor--
breakpoint:	int $3
	ret


# clear BSS segment, uninit'd data--from head.S of Linux sources
# with added line comments
	
# Clear BSS first so that there are no surprises...
clr_bss:	
	xorl %eax,%eax		# clear eax
	movl $_edata,%edi	# end of initialized data, start of BSS
	movl $_end,%ecx	# end of all data, i.e., end of BSS
	subl %edi,%ecx		# difference gives count of bytes to clear
	cld			# clear D bit to spec. forward rep
	rep			# repeat using count in ecx
	stosb			# store byte from eax, i.e, 0
	ret

