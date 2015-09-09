import Text.Printf
import Vec3

main :: IO ()
main = do
  let r0 = Vec3 150e09 0.0 0.0
  let r1 = Vec3 0.0 0.0 0.0
  let v0 = Vec3 0.0 29.658e03 0.0
  let v1 = Vec3 0.0 0.0 0.0
  let m0 = 5.98e24
  let m1 = 1.98855e30
  let n = 720 :: Int
  let dt = (365.0*24.0*60.0*60.0) / fromIntegral n :: Double
  printf "%12s, %12s, %12s\n" "x" "y" "z"
  print r0
  printOrbit $ orbit n dt r0 v0 m0 r1 v1 m1

g = 6.67e-11

grav :: Vec3 -> Vec3 -> Double -> Double -> Vec3
grav r1 r2 m1 m2 =
  let r = vecSub r1 r2;
      rm = vecMod r;
      c = ((-1) * g * m1 * m2) / rm^3
  in vecMuls c r

accel :: Double -> Vec3 -> Vec3
accel m f = vecMuls (1/m) f

applydt :: Double -> Vec3 -> Vec3 -> Vec3
applydt dt v c =
  let dv = vecMuls dt c :: Vec3
  in vecAdd v dv

orbit :: (Integral i) => i -> Double -> Vec3 -> Vec3 -> Double -> Vec3 -> Vec3 -> Double -> [(Vec3,Vec3)]
orbit n dt r0 v0 m0 r1 v1 m1
  | n == 0 = []
  | otherwise =
    let f0 = grav r0 r1 m0 m1;
        f1 = vecInv(f0);
        a0 = accel m0 f0;
        a1 = accel m1 f1;
        nv0 = applydt dt v0 a0;
        nv1 = applydt dt v1 a1;
        nr0 = applydt dt r0 nv0;
        nr1 = applydt dt r1 nv1
    in (nr0, nr1) : orbit (n-1) dt nr0 nv0 m0 nr1 nv1 m1

printOrbit :: [(Vec3,Vec3)] -> IO ()
printOrbit [] = putStr ""
printOrbit l = do
  print $ fst $ head l;
  printOrbit $ tail l
