/* puts.c - puts */
#include <stdio.h>
/*------------------------------------------------------------------------
 *  puts  --  write a null-terminated string to the console
 *------------------------------------------------------------------------
 */
/*
puts(s)
const char *s;
{
	register char c;
	int	putc();

	while (c = *s++)
                putc(CONSOLE,c);
        return(putc(CONSOLE,'\n'));
}
*/

extern int putc(int, char);

int puts(char *s)
{
  register char c;
  while ((c = *s++))
    putc(CONSOLE,c);
  return(putc(CONSOLE,'\n'));
}
