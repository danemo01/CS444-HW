# portio.s: IN and OUT to any byte-wide port
# like S&S, p. 169, for outpt, except using 32-bit args/stack
# and with 32-bit memory operands, can use %esp directly to 
#  access stack with displacement addressing
.globl outpt, inpt
.text
# output byte to port
# call from C: outpt(int port, unsigned char byte)
outpt:	movw 4(%esp), %dx   # port into dx
	movb 8(%esp), %al   # byte into al
	outb %al, %dx       # OUT instruction
	ret			

# input byte from port
# call from C: byte = inpt(int port)
inpt:	xorl %eax, %eax	   # clear eax
	movw 4(%esp), %dx  # port into dx
	inb %dx, %al	   # IN instruction: byte into al
	ret		   # return with byte in al


