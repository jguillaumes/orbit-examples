FC=gfortran

orbits:	orbits.o vectors.o
	$(FC) -o $@ $^

orbits.o:	orbits.f

vectors.o:	vectors.f

clean:
	-rm *.o
	-rm orbits

