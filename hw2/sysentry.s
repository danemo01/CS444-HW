.text
.global syscall, syscallc

syscall: pushl %edx
         pushl %ecx
         pushl %ebx
         push  %eax
         call syscallc
         popl %eax
         popl %ebx
         popl %ecx
         popl %edx
         iret