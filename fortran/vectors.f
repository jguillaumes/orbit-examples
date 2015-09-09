      real*8 function modul(v)
        implicit none
        real*8  v(3)

        modul = sqrt(v(1)**2 + v(2)**2 + v(3)**2)
      end

      subroutine vecadd(a,b,r)
        implicit none
        real*8 a(3),b(3),r(3)
        integer i

        do i=1,3
          r(i) = a(i) + b(i)
        enddo
        return
      end

      subroutine vecsub(a,b,r)
        implicit none
        real*8 a(3),b(3),r(3)
        integer i

        do i=1,3
          r(i) = a(i) - b(i)
        enddo
        return
      end

      subroutine vecmul(o,s,d)
        implicit none
        real*8  o(3),s,d(3)
        integer i

        do i=1,3
          d(i) = s * o(i)
        enddo
        return
      end

      subroutine vecinv(o,d)
        implicit none
        real*8 o(3),d(3)

        call vecmul(o,-1.0D0,d)
        return
      end
