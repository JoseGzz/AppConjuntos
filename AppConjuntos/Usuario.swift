//
//  Usuario.swift
//  ClasesPrueba
//
//  Created by Jose Gzz on 4/2/16.
//  Copyright © 2016 Jose Gzz. All rights reserved.
//

import UIKit

class Usuario: NSObject {

    private var iCorrectas : Int = 0
    private var iIncorrectas : Int = 0
    
    // --- getters
    
    internal func getCorrectas() -> Int {
        return iCorrectas
    }
    
    internal func getIncorrectas() -> Int {
        return iIncorrectas
    }
    
    // --- setters
    
    internal func setCorrectas(iCorrectas : Int) -> Void {
        self.iCorrectas = iCorrectas
    }
    
    internal func setInconrrectas(iIncorrectas : Int) -> Void {
        self.iIncorrectas = iIncorrectas
    }
}
