# Universal gravitation constant
const G = 6.67e-11

# Earth and sun mass
const Earth = 5.97e24
const Sun  = 1.98855E30

# Earth-sun distace and orbital (tangent) speed
const dist = 150.E09
const ospeed = 029.658E03

# Build position and velocity vectors for Earth and Sun
# Sun is at (0,0,0), its speed is zero (for the sake of this example)
# For generalization r1,v1 refer to first body, r2,v2 to second one
r1 = [dist,0.,0.]
v1 = [0.,ospeed,0.]
r2 = [0.,0.,0.]
v2 = [0.,0.,0.]

# Time increment (in seconds) and number of increments
# The total time will be a Year. Hence, if nintv = 365 our time increment
# will be a day.
nintv = 720
dt = (365.0 * 24.0 * 3600.0) / convert(Float64,nintv)

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

  f1,f2 = grav(r1,r2,Earth,Sun)
  a1 = accel(f1,Earth)
  a2 = accel(f2,Sun)
  v1 = applydt(v1,a1,dt)
  v2 = applydt(v2,a2,dt)
  r1 = applydt(r1,v1,dt)
  r2 = applydt(r2,v2,dt)
  println(i," r1=",r1,",r2=",r2)
end

# Plot both orbits
using PyPlot
scatter(C1[1:nintv,1],C1[1:nintv,2],marker=".")
scatter(C2[1:nintv,1],C2[1:nintv,2],marker=",")
