//
//  Elemento.swift
//  ClasesPrueba
//
//   Created by
//   Jose Gzz
//   Israel Hernandez
//   Martha Benavides
//   on 4/5/16.
//  Copyright © 2016 Jose Gzz. All rights reserved.
//

import UIKit

class Elemento: NSObject {
    
    // nombre del elemento
    private var sNombre : String = ""
    
    private var fPosX : Float = 0.0
    private var fPosY : Float = 0.0
    
    private var conConjunto = Conjunto()
    // conjunto donde se guardan los elementos eliminados
    private var conConjuntoBasura = Conjunto()
    
    // todo elemento, al ser creado, forma inmediatamente parte del universo
    override init() {
        super.init()
        Globales.conUniverso.agregarElemento(self)
    }
    
    // constructor usado como bandera para identificar a los elementos que seran
    // agregados al universo posteriormente
    init(x : Int) {
        super.init()
        
    }
    
    // regresa una booleana que depende de si el elemento dado
    // pertenece a un conjunto o no,
    // puede pertenecer a mas de un conjunto a la vez
    internal func perteneceA(conConjunto : Conjunto) -> Bool {
        
        for i in 0..<conConjunto.getElementos().count {
            if self.getNombre() == conConjunto.getElementos()[i].getNombre() {
                return true
            }
        }
        
        return false
    }
    
    // cuando un elemento es eliminado por si mismo
    // se dirige al conjunto de basura
    internal func remover() -> Void {
        conConjunto = conConjuntoBasura
    }
    
    // --- getters
    
    internal func getNombre() -> String {
        return sNombre
    }
    
    internal func getPosX() -> Float {
        return fPosX
    }
    
    internal func getPosY() -> Float {
        return fPosY
    }
    
    // --- setters
    
    internal func setConjunto(conConjunto : Conjunto) -> Void {
        self.conConjunto = conConjunto
    }
    
    internal func setNombre(sNombre : String) -> Void {
        self.sNombre = sNombre
    }
    
    internal func setPosX(fPosX : Float) -> Void {
        self.fPosX = fPosX
    }
    
    internal func setPosY(fPosY : Float) -> Void {
        self.fPosY = fPosY
    }
    
    
}
