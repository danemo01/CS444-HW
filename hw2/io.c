/*********************************************************************
*
*       file:           io.c
*       author:         betty o'neil
*
*       device-independent i/o package for SAPC
*
*/
/* hw2: delete include of io_public.h here, */
/*  put kernel-fn proto's, ioinit, sysread, etc., in tsystm.h */
#include <cpu.h>
#include "io_public.h"
#include "ioconf.h"

/*====================================================================
*
* i/o initialization loop for SAPC devices
*
*/

void ioinit()
{
  int i;

  cli();
  for (i = 0; i < NDEVS; i++)
    devtab[i].dvinit(i);	/* call device-specific init routine */
  sti();
}

/*====================================================================
*
*       read function calling routine for SAPC devices
*       (hw2: rename to "sysread" for the kernel)
*/

int sysread(int dev, char *buf, int nchar)
{
  if (dev < 0 || dev >= NDEVS) return -1;      /* fail */
  return devtab[dev].dvread(dev, buf, nchar); /* call dev-specific routine */
}

/*====================================================================
*
*       write function calling routine for SAPC devices
*       (rename to "syswrite" for the kernel)
*/
int syswrite(int dev, char *buf, int nchar)
{
  if (dev < 0 || dev >= NDEVS) return -1;       /* fail */
  return devtab[dev].dvwrite(dev, buf, nchar); /* call dev-specific routine */
}

/*====================================================================
*
*       exit function calling routine for SAPC devices
*       
*/
int sysexit(int exitcode) {
  kprintf("\nEXIT CODE is %d\n", exitcode);
  uexit();
  return exitcode;
}

/*====================================================================
*
*       control function calling routine for SAPC devices
*       (you can drop this one for hw2)
*/
int control(int dev, int fncode, int val)  /* note: val could be pointer */
{
  if (dev < 0 || dev >= NDEVS) return -1;          /* fail */
  return devtab[dev].dvcontrol(dev, fncode, val); /* dev-specific routine */
}

