FC=gfortran

orbits:		orbits.o vector.o
	$(FC) -o $@ $^

orbits.o:	orbits.f

vector.o:	vector.f

clean:
	-rm *.o
	-rm orbits
