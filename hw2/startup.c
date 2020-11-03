/* C startup file, called from startup0.s-- */

extern void clr_bss(void);
extern void init_devio(void);
extern void main(void);
extern void idkwtfimdoing(void);

void _startupc()
{
  // NEED TO SETUP STUFF HERE!! KMS
  // Instead of calling main, this is our bootup
  clr_bss();			/* clear BSS area (uninitialized data) */
  init_devio();			/* latch onto Tutor-supplied info, code */
  (void)idkwtfimdoing();			/* execute user-supplied main */
}
