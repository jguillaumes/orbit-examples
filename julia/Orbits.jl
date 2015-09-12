#
# Basic two-body orbit simularion written in julia
#
using PyPlot


# Universal gravitation constant
const G = 6.67e-11

#
# Read speed, position and mass of first body
#
linia = readline()
pos = split(strip(linia), " ")
linia = readline()
spd = split(strip(linia), " ")
mass = strip(readline())

# Initialize and load position and velocity vectors
r1 = zeros(3,1)
v1 = zeros(3,1)
for i in 1:3
  r1[i] = float64(pos[i])
  v1[i] = float64(spd[i])
end
# Initialize mass
m1 = float64(mass)

#
# Read speed, position and mass of second body
#
linia = readline()
pos = split(strip(linia), " ")
linia = readline()
spd = split(strip(linia), " ")
mass = strip(readline())

# Initialize and load position and velocity vectors
r2 = zeros(3,1)
v2 = zeros(3,1)
for i in 1:3
  r2[i] = float64(pos[i])
  v2[i] = float64(spd[i])
end
# Initialize mass
m2 = float64(mass)

# Time increment (in seconds) and number of steps
# will be a day.
linia = readline()
times = split(strip(linia), " ")
nintv = int32(times[2])
dt = float64(times[1])

# Newton's formula for gravitational force
function grav(r1,r2,m1,m2)
  r = norm(r1-r2)
  f1 = G * m1 * m2 * (r2 - r1) / r^3
  f2 = G * m1 * m2 * (r1 - r2) / r^3
  return f1,f2
end

# Newton's formula for acceleration
function accel(f,m)
  return f/m
end

# Apply a change (accel or velocity) to a vector for an interval (dt)
function applydt(vector, change, dt)
  return vector + change * dt
end

# Matrices to contain the (x,y) coordinates computed for each iteration
# for bodies 1 and 2
C1 = zeros(nintv ,2)
C2 = zeros(nintv ,2)

# Compute the orbit position for each step
for i in 1:nintv
  C1[i,1] = r1[1]
  C1[i,2] = r1[2]
  C2[i,1] = r2[1]
  C2[i,2] = r2[2]

  f1,f2 = grav(r1,r2,m1,m2)
  a1 = accel(f1,m1)
  a2 = accel(f2,m2)
  v1 = applydt(v1,a1,dt)
  v2 = applydt(v2,a2,dt)
  r1 = applydt(r1,v1,dt)
  r2 = applydt(r2,v2,dt)
  println(i," r1=",r1,",r2=",r2)
end

# Plot both orbits
scatter(C1[1:nintv,1],C1[1:nintv,2],marker=".")
scatter(C2[1:nintv,1],C2[1:nintv,2],marker=",")
