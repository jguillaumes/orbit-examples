        program orbits

        implicit none

        integer*4 i,n
        integer j
        integer ilun,olun
        real*8  r0(3),r1(3)
        real*8  f0(3),f1(3),a0(3),a1(3)
        real*8  v0(3),v1(3)
        real*8  m0,m1
        real*8  dt
        real*8  g
        real*8  neg
        integer n3,incx
        
        data g  / 6.67384E-11 /
        data n3,neg,incx /3,-1.0,1/
        data ilun,olun /5,6/
        common /consts/ G

800     format(a5,f10.0,a5,f10.0,a5,f10.0)
801     format(i6,2(3(X,D18.9)))
802     format(a6,2(3(X,A18)))

900     format(3(F11.0))
901     format(X,E11.5)
902     format(X,F11.0,X,I6)

        read(ilun,900) (R0(I),I=1,3)
        read(ilun,900) (V0(I),I=1,3)
        read(ilun,901) m0

        read(ilun,900) (R1(I),I=1,3)
        read(ilun,900) (V1(I),I=1,3)
        read(ilun,901) m1

        read(ilun,902) dt,n

        write(olun,802) ' NUM ','X0','Y0','Z0','X1','Y1','Z1'

        do I=1,n
           call gravf(r0,m0,r1,m1,f0)
           
*          f1 = -f0
           call DCOPY(n3,f0,incx,f1,incx)
           call DSCAL(n3,neg,f1,incx)
           
*          a0 = f0 / m0
           call DCOPY(n3,f0,incx,a0,incx)
           call DSCAL(n3,1/m0,a0,incx)
*          a1 = f1 / m1
           call DCOPY(n3,f1,incx,a1,incx)
           call DSCAL(n3,1/m1,a1,incx)

           call DAXPY(n3,dt,a0,incx,v0,incx)
           call DAXPY(n3,dt,a1,incx,v1,incx)
           call DAXPY(n3,dt,v0,incx,r0,incx)
           call DAXPY(n3,dt,v1,incx,r1,incx)

           write(olun,801) I,(R0(J),J=1,3),(R1(J),J=1,3)
        enddo
        end
      
      subroutine gravf(a,am,b,bm,f)
      implicit none
      
      DOUBLE PRECISION DNRM2
*     real*8  vecmod
      
      real*8  a(3),b(3),am,bm,f(3)
      real*8  r,coef
      real*8  v(3)
      real*8  g
      integer n3,incx
      real*8  neg
      
      data n3,neg,incx /3,-1.0,1/
      common /consts/ g
      
*     v = a - b
      call DCOPY(n3,a,incx,v,incx)
      call DAXPY(n3,neg,b,incx,v,incx)
*      print *,v
      
*     r = mod(v)
      r = DNRM2(n3,v,incx)
      coef = (-g*am*bm) / r**3
*      print *,coef
      
*     f = coef * v
      call DCOPY(n3,v,incx,f,incx)
      call DSCAL(n3,coef,f,incx)
*      print *,f

      return
      end
