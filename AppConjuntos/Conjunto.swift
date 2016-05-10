//
//  Conjunto.swift
//  ClasesPrueba
//
//  Created by 
//   Jose Gzz
//   Israel Hernandez
//   Martha Benavides
//   on 4/5/16.
//
//

import UIKit

class Conjunto: NSObject {

    // nombre del conjunto
    private var sNombre : String = ""
    // lista de elementos del conjunto
    private var eleElementos : [Elemento] = []
    
     // constructor de conjunto
    override init() {
    }
    
    // agrega un elemento al conjunto
    internal func agregarElemento(e : Elemento) -> Void {
        e.setConjunto(self)
        eleElementos.append(e)
    }
    // elimina un elemento del conjunto
    internal func eliminarElemento(e : Elemento) -> Void {
        e.remover()
        eleElementos.removeObject(e)
    }
    // regresa un conjunto con los elementos resultantes de calcular
    // la interseccion entre el presente conjunto y otro dado
    internal func intersecta(c : Conjunto) -> Conjunto {
        let conResultado = Conjunto()
        for i in 0..<self.getElementos().count {
            if self.getElementos()[i].perteneceA(c) {
                conResultado.agregarElemento(self.getElemento(i))
            }
        }
        return conResultado
    }
    // regresa el conjunto resultante de unir el presente conjunto con otro dado

    internal func union(c : Conjunto) -> Conjunto {
        let conNuevo = Conjunto()
        
        
        for i in 0..<self.eleElementos.count {
            conNuevo.agregarElemento(eleElementos[i])
        }
        
        for i in 0..<c.getElementos().count {
            
            if !conNuevo.existe(c.getElemento(i)) {
            
                conNuevo.agregarElemento(c.getElemento(i))
            }
        }
        
        return conNuevo
    }
    
    internal func getElemento(iPos : Int) -> Elemento {
        if iPos > (self.cantidadElementos() - 1){
        }
        return self.eleElementos[iPos]
    }
    
    func cantidadElementos() -> Int {
        return self.getElementos().count
    }
    // recibe un conjunto y regresa un booleano que indica si el
    // conjunto enviado es o no es subconjunto del conjunto presente
    internal func esSubconjunto(c : Conjunto) -> Bool {
        for i in 0..<self.getElementos().count {
            if !self.getElementos()[i].perteneceA(c) {
                return false
            }
        }
        return true
    }
    // regresa un conjunto con los elementos pertenecientes
    // al conjunto presente sin los elementos del conjunto enviado
    internal func resta(c : Conjunto) -> Conjunto {
        let conResultado = Conjunto()
        for i in 0..<self.getElementos().count {
            if !self.getElementos()[i].perteneceA(c) {
                conResultado.agregarElemento(self.getElemento(i))
            }
        }
        return conResultado
    }
    // regresa un booleano dependiendo de si el elemento enviado
    // es parte o no es parte de este conjunto
    internal func existe(e : Elemento) -> Bool {
        for i in 0..<self.eleElementos.count {
            if self.eleElementos[i].getNombre() == e.getNombre() {
                return true
            }
        }
        return false
    }
    
    // regresa un conjunto con el complemento de este conjunto
    internal func complemento() -> Conjunto {
       return Globales.conUniverso.resta(self)
        
    }
 
     // --- getters
    
    internal func getElementos() -> [Elemento] {
        return eleElementos
    }
    
    internal func getNombre() -> String {
        return sNombre
    }
    
    internal func getTextoElementos() -> String {
        var respuesta : String = "{"
        
        for i in 0..<self.cantidadElementos() {
            
            if i == self.cantidadElementos() - 1 {
                respuesta += self.getElemento(i).getNombre()
            }
            else {
                respuesta += (self.getElemento(i).getNombre() + ", ")
            }
        }
        
        respuesta += "}"
        return respuesta
    }
    // --- setters
    
    internal func setNombre(sNombre : String) -> Void {
        self.sNombre = sNombre
    }
    
    internal func setElementos(eleElementos : [Elemento]) {
        self.eleElementos = eleElementos
    }
    
}

// extension de la funcionalidad de arreglos para remover objetos por referencia
/*
 * http://supereasyapps.com/blog/2015/9/22/how-to-remove-an-array-of-objects-from-a-swift-2-array-removeobjectsinarray
 */

extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}




















