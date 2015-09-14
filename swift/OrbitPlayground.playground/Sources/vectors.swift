//
//  vectors.swift
//  orbits
//
//  Created by Jordi Guillaumes Pons on 13/9/15.
//  Copyright (c) 2015 Jordi Guillaumes Pons. All rights reserved.
//

import Foundation

public class Vec3 : Streamable {

    public let x : [Double]
    
    public init(x: Double, y: Double, z: Double) {
        self.x = [x,y,z]
    }
    
    public init(v: [Double]) {
        if v.count == 3 {
            self.x = v
        } else {
            self.x = [0,0,0]
        }
    }
    
    public func writeTo<Target : OutputStreamType>(inout target: Target) {
        let str = "[" + self.x[0].description + ","
                      + self.x[1].description + ","
                      + self.x[2].description + "]";
        target.write(str);
    }
    
    public func negate() -> Vec3 {
        return self * (-1.0)
    }
    
    public func modul() -> Double {
        let m: Double = self.x.reduce(0) { $0 + $1*$1 }
        
        return sqrt(m)
    }
}

public func +(v1 : Vec3, v2: Vec3) -> Vec3 {
    var ret = [Double](count: 3, repeatedValue: 0)
    
    for i in 0...2 {
        ret[i] = v1.x[i] + v2.x[i]
    }

    return Vec3(v: ret);
}

public func -(v1 : Vec3, v2: Vec3) -> Vec3 {
    var ret = [Double](count: 3, repeatedValue: 0)
    for i in 0...2 {
        ret[i] = v1.x[i] - v2.x[i]
    }
    return Vec3(v: ret);
}

public func *(v:Vec3, s:Double) -> Vec3 {
    let a = v.x
    let ret = a.map({ $0 * s })
    return Vec3(v:ret);
}

infix operator *% { associativity left precedence 150 }
public func *% (v1: Vec3, v2: Vec3) -> Double {
    var c: Double = 0.0
    
    for i in 0...2 {
        c += v1.x[i] * v2.x[i]
    }
    return c
}
