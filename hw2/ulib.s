# file :	ulib.s
# description:	assembler routines for read, write, exit
# hw2:	 add read, exit				

.globl write,read,exit	
.text
# following Linux system call linkage
# user stack when execution reaches _write:	
# esp-> return addr
#       first arg  (to be put in ebx for syscall)
#       second arg (to be put in ecx)
#       third arg  (to be put in edx)

# user stack after pushl %ebx, needed to preserve %ebx (not a C scratch reg)
# esp->  saved-ebx
# 4(esp) return addr
# 8(esp) first arg  (to be put in ebx for syscall)
# 12(esp) second arg (to be put in ecx)
# 16(esp) third arg  (to be put in edx)
			
write:	pushl %ebx                    # save the value of ebx
	movl 8(%esp),%ebx             # first arg in ebx
	movl 12(%esp),%ecx            # second arg in ecx
	movl 16(%esp),%edx            # third arg in edx
	movl $4,%eax                  # syscall # in eax
        int $0x80                     # trap to kernel
	# movl %eax,%ebx
	popl  %ebx                    # restore the value of ebx
	ret


read:	pushl %ebx                    # save the value of ebx
	movl 8(%esp),%ebx             # first arg in ebx
	movl 12(%esp),%ecx            # second arg in ecx
	movl 16(%esp),%edx            # third arg in edx
	movl $3,%eax                  # syscall # in eax
        int $0x80                     # trap to kernel
	# movl %eax,%ebx
	popl  %ebx                    # restore the value of ebx
	ret


exit:	pushl %ebx                    # save the value of ebx
	movl 8(%esp),%ebx             # first arg in ebx
	# movl 12(%esp),%ecx            # second arg in ecx
	# movl 16(%esp),%edx            # third arg in edx
	movl $1,%eax                  # syscall # in eax
        int $0x80                     # trap to kernel
	popl  %ebx                    # restore the value of ebx
	ret

