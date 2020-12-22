#include <cpu.h>
#include "sched.h"
#include "proc.h"

extern void asmswtch(PEntry *oldproc, PEntry *newproc);

void schedule(void) {
	int saved_eflags;
	saved_eflags = get_eflags();
	cli();
	PEntry * pp = curproc;
	
	// Gets the process index;	
	int index_proc;
	for (int i = 0; i < NPROC; i++) {
    		if (curproc == &proctab[i]) {
        	index_proc = i;
        	break;
    		}
	}
	// Gets the next proc, skips process 0 and goes from 1 to 3 and loops back to 1
	int next_proc = loopydoopy(index_proc);
	int i;
	// loop 3 times and check to find the next one to run, or they're all blocked
	for (i = 0; i < NPROC - 1; i++) {
    		if (proctab[next_proc].p_status == RUN) {
        	curproc = &proctab[next_proc];
        	break;
   	 }
    
    		next_proc = loopydoopy(next_proc);
	}

	if (i==NPROC-1) {
		curproc = &proctab[0];
	}	
	
//	if (pp != curproc)
		//debugthingyoutputkaka

	asmswtch(pp, curproc);
	set_eflags(saved_eflags);
}

void sleep(WaitCode event) {
	curproc->p_status = BLOCKED;
	curproc->p_waitcode = event;
	schedule();
}

void wakeup(WaitCode event) {
	
	for (int i = 1; i < NPROC; i++) {
		if(proctab[i].p_status==BLOCKED && proctab[i].p_waitcode==event)
			proctab[i].p_status=RUN;
	}
}

int loopydoopy(int index) {
    if (index == NPROC - 1) {
        return 1;
    } else {
        return index + 1;
    }
}
