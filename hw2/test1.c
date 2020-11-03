#include "tunistd.h"
#include "io_public.h"

int main(void)
{
    write(TTY1, "hi!\n", 4);
    //exit(0);
    return 0;
}
