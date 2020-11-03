/* devtab.c  device-indep i/o table */

#include <devio.h>
#ifdef BOOTCODE
/* prototypes for functions in Tutor's devtab */
#include <sasys.h>
#endif

/* init, putc, getc, rready */
#ifdef BOOTCODE
struct dev_struct devtab[] = {
{ cons_kbd_init, console_putc, kbd_getc, kbd_ready },
{ com_init, com_putc, com_getc, com_ready },
{ null_init, com_putc, com_getc, com_ready },
{ null_init, com_putc, com_getc, com_ready },
{ null_init, com_putc, com_getc, com_ready }
};
#else
/* For downloaded code, entries of devtab are copied in from Tutor's devtab */
struct dev_struct devtab[5];
#endif
