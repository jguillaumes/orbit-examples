CC=gcc

orbits:	orbits.cob
	cobc --free -x -C orbits.cob
	$(CC) $(shell cob-config --cflags --libs | sed "s/-R/-L/") -std=gnu11 -o orbits orbits.c

clean:
	-rm *.o
	-rm *.c
	-rm *.h
	-rm *.dylib
	-rm orbits

