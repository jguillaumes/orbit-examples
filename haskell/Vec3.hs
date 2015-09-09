module Vec3
( Vec3(..)
, vecAdd
, vecSub
, vecMuls
, vecInv
, vecMod
, vecDot
) where

import Text.Printf

data Vec3 = Vec3{x :: Double, y :: Double, z :: Double} deriving(Eq)

instance Show Vec3 where
  show v = printf "%12.5E, %12.5E, %12.5E" (x v) (y v) (z v)

vecAdd :: Vec3 -> Vec3 -> Vec3
vecAdd v1 v2 = Vec3 (x v1 + x v2) (y v1 + y v2) (z v1 + z v2)

vecSub :: Vec3 -> Vec3 -> Vec3
vecSub v1 v2 = Vec3 (x v1 - x v2) (y v1 - y v2) (z v1 - z v2)

vecMuls ::  Double -> Vec3 -> Vec3
vecMuls n v = Vec3 (n * x v) (n * y v) (n * z v)

vecInv :: Vec3 -> Vec3
vecInv v = vecMuls (-1.0) v

vecMod :: Vec3 -> Double
vecMod v = sqrt $ (x v)^2 + (y v)^2 + (z v)^2

vecDot :: Vec3 -> Vec3 -> Double
vecDot v1 v2 = (x v1) * (x v2) + (y v1) * (y v2) + (z v1) * (z v2)
