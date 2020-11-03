/* getchar.c */

#include <stdio.h>
extern int fgetc(int);

int getchar(void)
{
    return fgetc(CONSOLE);
}
