/* printf.c */

#include <stdio.h>
#include <stdarg.h>
#include <cpu.h>

extern void _fdoprnt(char *, va_list, int (*)(int, char), int);

int kprintf(const char *fmt, ...)
{
    va_list ap;
    extern int putc(int, char);
    int saved_eflags;

    saved_eflags = get_eflags();
    cli();
    va_start(ap, fmt);
    _fdoprnt((char *)fmt, ap, putc, CONSOLE);
    va_end(ap);
    set_eflags(saved_eflags);

    return 0;
}
