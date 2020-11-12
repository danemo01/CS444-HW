#include <unistd.h>

int main(void)
{
	char buf[50];
	write(1, "Hello World on the stand output!\n",  40);
	write(3, "wut?\n", 5);
	
	read(1, buf, 10);
	write(1, buf, 10);
	return 0;
}
