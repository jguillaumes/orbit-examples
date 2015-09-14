//
//  main.swift
//  orbits
//
//  Created by Jordi Guillaumes Pons on 13/9/15.
//  Copyright (c) 2015 Jordi Guillaumes Pons. All rights reserved.
//

import Foundation

let G = 6.67384E-11

func grav(r1 r1: Vec3, r2: Vec3, m1: Double, m2: Double) -> Vec3 {
    let dist = (r1 - r2).modul()
    let coef = -G * m1 * m2 / (dist*dist*dist)
    return r1 * coef
}

func accel(f: Vec3, m: Double) -> Vec3 {
    let invm : Double = 1.0/m
    let a: Vec3 = f * invm
    return a
}

func applydt(v: Vec3, c: Vec3, dt: Double) -> Vec3 {
    let dv: Vec3 = c * dt
    return v + dv
}

var r1 = Vec3(x:150e09, y:0.0, z:0.0)
var r2 = Vec3(x:0.0,y:0.0,z:0.0)
var v1 = Vec3(x:0.0,y:29.658e03, z:0.0)
var v2 = Vec3(x:0.0,y:0.0,z:0.0)

let m1 = 5.98e24
let m2 = 1.98855e30

let nincr = 730
let dt: Double = (365.0*24.0*3600.0) / Double(nincr)

for i in 1...nincr {
    var f1: Vec3 = grav(r1: r1, r2: r2, m1: m1, m2: m2)
    var f2: Vec3 = f1.negate()
    
    var a1: Vec3 = accel(f1, m: m1)
    var a2: Vec3 = accel(f2, m: m2)
   
    v1 = applydt(v1, c: a1, dt: dt)
    v2 = applydt(v2, c: a2, dt: dt)
    
    r1 = applydt(r1,c: v1,dt: dt)
    r2 = applydt(r2,c: v2,dt: dt)
    
    print(r1)
}

