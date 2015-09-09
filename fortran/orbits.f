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
        real*8  g,q

        data g  / 6.67384E-11 /
        data q  / 1E06 /
        data ilun,olun /5,6/
        common /consts/ G

800     format(a5,f10.0,a5,f10.0,a5,f10.0)
801     format(i6,2(3(X,F18.8)))
802     format(a6,2(3(X,A18)))

900     format(3(X,F10.0))
901     format(X,F10.0)
902     format(X,F10.0,X,I6)

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
          call vecinv(f0,f1)
          call vecmul(f0,1/m0,a0)
          call vecmul(f1,1/m1,a1)
          do j=1,3
            v0(j) = v0(j) + a0(j) * dt
            v1(j) = v1(j) + a1(j) * dt
            r0(j) = r0(j) + v0(j) * dt
            r1(j) = r1(j) + v1(j) * dt
          enddo
          write(olun,801) I,(R0(J)/Q,J=1,3),(R1(J)/Q,J=1,3)
        enddo
      end

      subroutine gravf(a,am,b,bm,f)
        implicit none

        real*8  a(3),b(3),am,bm,f(3)
        real*8  r,coef
        real*8  v(3)
        real*8  g
        real*8  modul

        common /consts/ g

        call vecsub(a,b,v)
        r = modul(v)
        coef = -1*g*am / r**3
        coef = coef * bm
        call vecmul(v,coef,f)
        return
      end
