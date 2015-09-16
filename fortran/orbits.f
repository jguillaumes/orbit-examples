C	*****************************************************************
C	*	Compute a 2-body orbit                                  *
C	*****************************************************************
	
        PROGRAM ORBITS
	IMPLICIT NONE

	INTEGER*4 I
	INTEGER J
	INTEGER ILUN,OLUN
	REAL*8  R0(3),R1(3)
	REAL*8	F0(3),F1(3),A0(3),A1(3)
	REAL*8	V0(3),V1(3)
	INTEGER*4  N
	REAL*8  M0,M1
	REAL*8  DT
	REAL*8	G,Q

	DATA G /6.67384E-11/
	DATA Q /1E06/
	DATA ILUN,OLUN /5,6/
	COMMON /CONSTS/ G

 800    FORMAT (A5,F10.0,A5,F10.0,A5,F10.0)
 801    FORMAT (i6,2(3(X,F18.8)))
 802	FORMAT (A6,2(3(X,A18)))

 900	FORMAT (3(X,F10.0))
 901	FORMAT (X,F10.0)
 902	FORMAT (X,F10.0,X,I10)

C	Read first body position
	READ (ILUN,900) (R0(I),I=1,3)

C	Read first body velocity
	READ (ILUN,900) (V0(I),I=1,3)

C	Read first body mass
	READ (ILUN,901) M0

C	Read second body position
	READ (ILUN,900) (R1(I),I=1,3)

C	Read second body velocity
	READ (ILUN,900) (V1(I),I=1,3)

C	Read second body mass
	READ (ILUN,901) M1

C	Read time interval and number of steps
	READ (ILUN,902) DT,N 

	WRITE(OLUN,802) ' NUM ','X0','Y0','Z0','X1','Y1','Z1'

	DO I=1,N
	    CALL GRAVF(R0,M0,R1,M1,F0)
	    CALL VECINV(F0,F1)
	    CALL VECMUL(F0,1/M0,A0)
	    CALL VECMUL(F1,1/M1,A1)
	    DO J=1,3
	        V0(J) = V0(J) + A0(J) * DT
	        V1(J) = V1(J) + A1(J) * DT
		R0(J) = R0(J) + V0(J) * DT
		R1(J) = R1(J) + V1(J) * DT
	    ENDDO
	    WRITE(OLUN,801) I,(R0(J)/Q,J=1,3),(R1(J)/Q,J=1,3)
	ENDDO
	END

C	*****************************************************************
C	* Compute the gravitational force vector between to objects     *
C	*****************************************************************
	SUBROUTINE GRAVF(A, AM, B, BM, F)
	IMPLICIT NONE

	REAL*8	A(3),B(3),AM,BM,F(3)
	REAL*8	R,COEF
	REAL*8	V(3)
	REAL*8	G
	REAL*8 	MODUL

	COMMON /CONSTS/ G

	CALL VECSUB(A,B,V)

	R = MODUL(V)
	COEF = -1*G*AM / R**3
	COEF = COEF * BM
	CALL VECMUL(V,COEF,F)
	RETURN
	END
