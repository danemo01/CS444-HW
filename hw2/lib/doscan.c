/* doscan.c - doscan */
static int _innum(int **ptr, int type, int len, int size, 
		  int (*getch)(int, int *), int (*ungetch)(int, int *),
		  int arg1, int arg2, int *eofptr);
static int _instr(char *ptr, int type, int len, 
		  int (*getch)(int, int *), int (*ungetch)(int, int *),
		  int arg1, int arg2, int *eofptr);
static char * _getccl(char *s);

#include <stdio.h>
#include <ctype.h>

#define	SPC	01
#define	STP	02

#define	SHORT	0
#define	REGULAR	1
#define	LONG	2

char	_sctab[128] = {
	0,0,0,0,0,0,0,0,
	0,SPC,SPC,0,0,/* '\r' */ SPC,0,0,
	0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,
	SPC,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,
};

/*------------------------------------------------------------------------
 *  _doscan  --  scan and recognize input according to a format
 *------------------------------------------------------------------------
 */
int _doscan(char *fmt, int **argp, 
	    int (*getch)(int, int *), int (*ungetch)(int, int *),
	    int arg1, int arg2 )
#ifdef ORIG
        register char   *fmt;           /* Format string for the scanf  */
        register int    **argp;         /* Arguments to scanf           */
        int             (*getch)();     /* Function to get a character  */
        int             (*ungetch)();   /* Function to unget a character*/
        int             arg1;           /* 1st argument to getch/ungetch*/
        int             arg2;           /* 2nd argument to getch/ungetch*/
#endif
{
	register int ch;
	int nmatch, len, ch1;
	int **ptr, fileended, size;

	nmatch = 0;
	fileended = 0;
	for (;;) switch (ch = *fmt++) {
	case '\0': 
		return (nmatch);
	case '%': 
		if ((ch = *fmt++) == '%')
			goto def;
		ptr = 0;
		if (ch != '*')
			ptr = argp++;
		else
			ch = *fmt++;
		len = 0;
		size = REGULAR;
		while (isdigit(ch)) {
			len = len*10 + ch - '0';
			ch = *fmt++;
		}
		if (len == 0)
			len = 30000;
		if (ch=='l') {
			ch = *fmt++;
			size = LONG;
		} else if (ch=='h') {
			size = SHORT;
			ch = *fmt++;
		} else if (ch=='[')
                        fmt = _getccl(fmt);
		if (isupper(ch)) {
			ch = tolower(ch);
			size = LONG;
		}
		if (ch == '\0')
			return(-1);
                if (_innum(ptr, ch, len, size, getch, ungetch, 
                        arg1, arg2, &fileended) && ptr)
			nmatch++;
		if (fileended)
			return(nmatch? nmatch: -1);
		break;

	case ' ':
	case '\n':
	case '\t': 
                while ((ch1 = (*getch)(arg1, (int *)arg2))==' '
		       || ch1=='\t' || ch1=='\n' )
                        ;
		if (ch1 != EOF)
                        (*ungetch)(arg1, (int *)arg2);
		break;

	default: 
	def:
                ch1 = (*getch)(arg1, (int *)arg2);
		if (ch1 != ch) {
			if (ch1==EOF)
				return(-1);
                        (*ungetch)(arg1, (int *)arg2);
			return(nmatch);
		}
	}
}

static int _innum(int **ptr, int type, int len, int size,
		  int (*getch)(int, int *), int (*ungetch)(int, int *),
		  int arg1, int arg2, int *eofptr)
{
	register char *np;
	char numbuf[64];
	register int c, base;
        //int expseen, negflg, c1, ndigit;
        int negflg, c1, ndigit;
        long lcval;


	if (type=='c' || type=='s' || type=='[')
                return(_instr(ptr? *(char **)ptr: (char *)NULL, type, 
                        len, getch, ungetch, arg1, arg2, eofptr));
	lcval = 0;
	ndigit = 0;
	base = 10;
	if (type=='o')
		base = 8;
	else if (type=='x')
		base = 16;
	np = numbuf;
	//expseen = 0;
	negflg = 0;
/* ignore '\r' -- MECB returns '\r' for eol not '\n' (as in TS) -- joe */
        while ((c = (*getch)(arg1, (int *)arg2))==' ' ||
	       c=='\t' || c=='\n' || c=='\r') ;
	if (c=='-') {
		negflg++;
		*np++ = c;
                c = (*getch)(arg1, (int *)arg2);
		len--;
	} else if (c=='+') {
		len--;
                c = (*getch)(arg1, (int *)arg2);
	}
        for ( ; --len>=0; *np++ = c, c = (*getch)(arg1, (int *)arg2)) {
		if (isdigit(c)
		 || ((base==16) && (('a'<=c && c<='f') || ('A'<=c && c<='F')))) {
			ndigit++;
			if (base==8)
				lcval <<=3;
			else if (base==10)
				lcval = ((lcval<<2) + lcval)<<1;
			else
				lcval <<= 4;
			c1 = c;
			if ('0'<=c && c<='9')
				c -= '0';
			else if ('a'<=c && c<='f')
				c -= 'a'-10;
			else
				c -= 'A'-10;
			lcval += c;
                        c = c1;
			continue;
		} else
			break;
	}
	if (negflg)
		lcval = -lcval;
	if (c != EOF) {
                (*ungetch)(arg1, (int *)arg2);
		*eofptr = 0;
	} else
		*eofptr = 1;
	if (ptr==NULL || np==numbuf)
		return(0);
	*np++ = 0;
        switch(size) {

        case SHORT:
		**(short **)ptr = lcval;
		break;

        case REGULAR:
		**(int **)ptr = lcval;
		break;

        case LONG:
		**(long **)ptr = lcval;
		break;
	}
	return(1);
}

static int _instr(char *ptr, int type, int len,
		  int (*getch)(int, int *), int (*ungetch)(int, int *),
		  int arg1, int arg2, int *eofptr)
{
	register int ch;
	register char *optr;
	int ignstp;

	if (eofptr) *eofptr = 0;
	optr = ptr;
	if (type=='c' && len==30000)
		len = 1;
	ignstp = 0;
	if (type=='s')
		ignstp = SPC;
        while (_sctab[ch = (*getch)(arg1, (int *)arg2)] & ignstp)
		if (ch==EOF)
			break;
	ignstp = SPC;
	if (type=='c')
		ignstp = 0;
	else if (type=='[')
		ignstp = STP;
	while (ch!=EOF && (_sctab[ch]&ignstp)==0) {
		if (ptr)
			*ptr++ = ch;
		if (--len <= 0)
			break;
                ch = (*getch)(arg1, (int *)arg2);
	}
	if (ch != EOF) {
		if (len > 0)
                        (*ungetch)(arg1, (int *)arg2); 
		*eofptr = 0;
	} else
		*eofptr = 1;
	if (ptr && ptr!=optr) {
		if (type!='c')
			*ptr++ = '\0';
		return(1);
	}
	return(0);
}

static char * _getccl(char *s)
{
	register int c, t;

	t = 0;
	if (*s == '^') {
		t++;
		s++;
	}
	for (c = 0; c < 128; c++)
		if (t)
			_sctab[c] &= ~STP;
		else
			_sctab[c] |= STP;
	while (((c = *s++)&0177) != ']') {
		if (t)
			_sctab[c++] |= STP;
		else
			_sctab[c++] &= ~STP;
		if (c==0)
			return(--s);
	}
	return(s);
}
