//
//  vectors.swift
//  orbits
//
//  Created by Jordi Guillaumes Pons on 13/9/15.
//  Copyright (c) 2015 Jordi Guillaumes Pons. All rights reserved.
//

import Foundation
import Accelerate

enum VecErrors: ErrorType {
    case InvalidParam
    case InvalidAction
}



public class Vec3 : Streamable {
    public let x : [Double]
    
    public init(x: Double, y: Double, z: Double) {
        self.x = [x,y,z]
    }
    
    init(v: [Double]) {
        if (v.count == 3) {
            self.x = v
        } else {
            self.x = [0,0,0]
        }
    }
    
    public func asArray() -> [Double] {
        let res: [Double] = self.x
        return res
    }

    public func writeTo<Target : OutputStreamType>(inout target: Target) {
        let str = "[" +
            x.reduce("") { (a: String, b:Double) -> String in
                a + (String(format: "%3.5e", b))
                + (b==x.last ? "" : ",")
        } + "]"
        
        target.write(str);
    }
    
    public func negate() -> Vec3 {
        return self * (-1.0)
    }
    
    public func modul() -> Double {
        let m: Double = self *% self
        
        return sqrt(m)
    }
    
    public func polar() -> (Double, Double, Double) {
        let r = self.modul()
        let eta = acos(self.x[2]/r)
        let phi = atan(self.x[1]/self.x[0])
        return (r,eta,phi)
    }
}

public func +(v1 : Vec3, v2: Vec3) -> Vec3 {
    let v1x : [Double] = v1.asArray()
    var v2x : [Double] = v2.asArray()
    
    cblas_daxpy(3, 1, v1x, 1, &v2x, 1)

    return Vec3(v: v2x);
}

public func -(v1 : Vec3, v2: Vec3) -> Vec3 {
    var v1x : [Double] = v1.asArray()
    let v2x : [Double] = v2.asArray()
    
    cblas_daxpy(3, -1, v2x, 1, &v1x, 1)
    
    return Vec3(v: v1x);
}

public func *(v:Vec3, s:Double) -> Vec3 {
    let v1x : [Double] = v.asArray()
    var second: [Double] = [0,0,0]
    
    cblas_daxpy(3, s, v1x, 1, &second, 1)
    
    return Vec3(v: second);
}

infix operator *% { associativity left precedence 150 }
public func *% (v1: Vec3, v2: Vec3) -> Double {
    var c: Double = 0.0
    
    c = cblas_ddot(3, v1.asArray(), 1, v2.asArray(), 1)
    return c
}
