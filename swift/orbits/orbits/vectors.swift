//
//  vectors.swift
//  orbits
//
// Classe per representar vectors tridimensionals
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
    public let x : [Double]     // Matriu amb les coordenades del vector
    
    
    // Inicialització a partir de les coordenades
    public init(x: Double, y: Double, z: Double) {
        self.x = [x,y,z]
    }
    
    // Inicialització a partir d'una matriu amb les coordenades
    // Si la matriu no té tres elements, es retorna (0,0,0)
    // FIXME - Caldria afegir control d'errors
    init(v: [Double]) {
        if (v.count == 3) {
            self.x = v
        } else {
            self.x = [0,0,0]
        }
    }
    
    // Retorna una matriu amb les tres coordenades
    // La matriu retornada és una còpia
    public func asArray() -> [Double] {
        let res: [Double] = self.x
        return res
    }

    // Impressió directa d'un vector amb format [x,y,z]
    public func writeTo<Target : OutputStreamType>(inout target: Target) {
        let str = "[" +
            x.reduce("") { (a: String, b:Double) -> String in
                a + (String(format: "%3.5e", b))
                + (b==x.last ? "" : ",")
        } + "]"
        
        target.write(str);
    }
    
    // Negació (inversió) de les coordenades d'un vector
    public func negate() -> Vec3 {
        return self * (-1.0)
    }
    
    // Mòdul (norma euclidiana) d'un vector
    public func modul() -> Double {
        return cblas_dnrm2(3, self.x, 1)
    }
    
    // Conversió a coordenades polars
    // (Radi, etha, phi)
    public func polar() -> (Double, Double, Double) {
        let r = self.modul()
        let eta = acos(self.x[2]/r)
        let phi = atan(self.x[1]/self.x[0])
        return (r,eta,phi)
    }
}

// Suma de dos vectors (operador '+')
public func +(v1 : Vec3, v2: Vec3) -> Vec3 {
    let v1x : [Double] = v1.asArray()
    var v2x : [Double] = v2.asArray()
    
    cblas_daxpy(3, 1, v1x, 1, &v2x, 1)

    return Vec3(v: v2x);
}

// Resta de dos vectors (operador '-')
public func -(v1 : Vec3, v2: Vec3) -> Vec3 {
    var v1x : [Double] = v1.asArray()
    let v2x : [Double] = v2.asArray()
    
    cblas_daxpy(3, -1, v2x, 1, &v1x, 1)
    
    return Vec3(v: v1x);
}

// Producte d'un vector per un escalar (operador '*')
public func *(v:Vec3, s:Double) -> Vec3 {
    let v1x : [Double] = v.asArray()
    var second: [Double] = [0,0,0]
    
    cblas_daxpy(3, s, v1x, 1, &second, 1)
    
    return Vec3(v: second);
}

// Producte escalar (dot-product) de dos vectors
// S'implementa com a operador '*%'
infix operator *% { associativity left precedence 150 }
public func *% (v1: Vec3, v2: Vec3) -> Double {
    var c: Double = 0.0
    
    c = cblas_ddot(3, v1.asArray(), 1, v2.asArray(), 1)
    return c
}
