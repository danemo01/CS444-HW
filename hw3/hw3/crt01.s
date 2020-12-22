# file:	 crt01.s
# name:	 Danley Nemo, Jeff Gracis, Suncharn Pipin
# description:	 user startup module	
# date:	 11/15/20

.globl ustart1, main1 , exit
.text
			
ustart1:
		call main1                   #call main in the uprog.c
                pushl %eax                   #push the retval=exit_code on stack
                call exit                   # call sysycall exit
               

