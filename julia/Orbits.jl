const G = 6.67e-11

const Earth = 5.97e24
const Sun  = 1.98855E30
const dist = 150.E09

x1 = [dist,0.,0.]
v1 = [0.,029.658E03,0.]
x2 = [0.,0.,0.]
v2 = [0.,0.,0.]

dt = 3600
nintv = (365*24+6)

function grav(x1,x2,m1,m2)
  r = norm(x1-x2)
  f1 = G * m1 * m2 * (x2 - x1) / r^3
  f2 = G * m1 * m2 * (x1 - x2) / r^3
  return f1,f2
end

function accel(f,m)
  return f/m
end

function newspeed(v,a,t)
  nv = v + a * t
end

function newpos(x,v,t)
  nx = x + v * t
end

E = zeros(nintv ,2)
S = zeros(nintv ,2)

for i in 1:nintv
  E[i,1] = x1[1]
  E[i,2] = x1[2]
  S[i,1] = x2[1]
  S[i,2] = x2[2]
   #E[i,3] = x1[3]
  f1,f2 = grav(x1,x2,Earth,Sun)
  a1 = accel(f1,Earth)
  a2 = accel(f2,Sun)
  x1 = newpos(x1,v1,dt)
  x2 = newpos(x2,v2,dt)
  v1 = newspeed(v1,a1,dt)
  v2 = newspeed(v2,a2,dt)
  println(i," x1=",x1,",x2=",x2)
end

using PyPlot
scatter(E[1:nintv,1],E[1:nintv,2],marker=".")
scatter(S[1:nintv,1],S[1:nintv,2],marker=",")
