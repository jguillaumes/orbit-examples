FC=gfortran

orbits:	orbits.o
	$(FC) -o $@ $^ -lblas

orbits.o:	orbits.f

clean:
	-rm *.o
	-rm orbits

