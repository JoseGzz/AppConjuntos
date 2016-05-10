//
//  Ejercicio.swift
//  ClasesPrueba
//
//  Created by
//   Jose Gzz
//   Israel Hernandez
//   Martha Benavides
//   on 4/5/16.
//  Copyright © 2016 Jose Gzz. All rights reserved.
//

import UIKit
import Darwin


class Ejercicio: NSObject {
    
    // TODO: falta generar respuestas equivocadas
    
    // identificador del ejercicio
    private var iId : Int = 0
     // pregunta para cada ejercicio
    private var cRespuesta = Conjunto()
    
    private var sPreguntas : String = ""
    // elementos para trabajar durtante el ejercicio
    private var eElementos : [Elemento] = []
    // conjuntos para trabajar durante el ejercicio
    private var cConjuntos : [Conjunto] = []
     // cantidad de preguntas del ejercicio
    private var iCantidadPreguntas = 0
    
    
    // conjuntos con respuestas incorrectas para el ejercicio
    var cRespuestaIncorrecta1 = Conjunto()
    var cRespuestaIncorrecta2 = Conjunto()
    var cRespuestaIncorrecta3 = Conjunto()
    
    private var iTema = 0
    private var bTodos : Bool = false
    
    private var sTema : String = ""
    
    /////////////////////////////
    private var bPersonalizado : Bool = false
    ///////////////////////////////
    
    
    override init() {
    }

    
    
    var iRand : UInt32 = 0
     // cantidad de elementos para el ejercicion
    private var iCantElementos : Int = 0
    // cantida de conjuntos para el ejercicio
    private var iCantConjuntos : Int = 0;
    // regiones para distribuir los elementos
    private var iRegiones : [Int] = []
    
    // generar conjuntos
    internal func generarConjuntos() -> Void {
        let lower : UInt32 = 2
        let upper : UInt32 = 3
        
        iRand = arc4random_uniform(upper - lower) + lower
        
        iCantConjuntos = Int(iRand);
        
        iCantConjuntos = 3
        
        for i in 0..<iCantConjuntos {
            
            let c = Conjunto()
            
            c.setNombre("C" + String(i+1))
            
            cConjuntos.append(c)
            
            
        }
        
        
    }
    
    
    
    // generar elementos
    internal func generarElementos() -> Void {
        
        let lower : UInt32 = 6
        let upper : UInt32 = 12
        
        iRand = arc4random_uniform(upper - lower) + lower
        
        
        iCantElementos = Int(iRand);
        
        
        for i in 0..<iCantElementos {
            let e = Elemento()
            e.setNombre("e" + String(i + 1))
            eElementos.append(e)
            

            
        }
    }
    
    
    // distribuir elementos en 7 regiones, los tres conjuntos e intersecciones
    internal func distribuirElementos() -> Void {
        
        // IMPORTANTE: Limpiar los conjuntos primero
        
        
        if iCantConjuntos == 2 {
            
            
            var iRegion : Int = 0
            
            let lower : UInt32 = 0
            let upper : UInt32 = 2
            
            
            for i in 0..<iCantElementos {
                
                iRegion = Int(arc4random_uniform(upper - lower) + lower)
                
                
                switch(iRegion) {
                case 0  :
                    cConjuntos[0].agregarElemento(eElementos[i])
                case 1  :
                    cConjuntos[0].agregarElemento(eElementos[i])
                    cConjuntos[1].agregarElemento(eElementos[i])
                case 2  :
                    cConjuntos[1].agregarElemento(eElementos[i])
                default :
                    break
                }
                
            }
  
        } else if iCantConjuntos == 3 {
            
            // lo siguiente se ejecuta por lo menos una vez
            repeat {
            
            
            var iRegion : Int = 0
            
            for i in 0..<iCantElementos {
                
                iRegion = Int(arc4random_uniform(6))
                
                switch(iRegion) {
                case 0  :
                    cConjuntos[0].agregarElemento(eElementos[i])
                    cConjuntos[1].agregarElemento(eElementos[i])
                    cConjuntos[2].agregarElemento(eElementos[i])
                case 1  :
                    cConjuntos[1].agregarElemento(eElementos[i])
                    cConjuntos[2].agregarElemento(eElementos[i])
                case 2  :
                    cConjuntos[2].agregarElemento(eElementos[i])
                    cConjuntos[0].agregarElemento(eElementos[i])
                case 3  :
                    cConjuntos[0].agregarElemento(eElementos[i])
                    cConjuntos[1].agregarElemento(eElementos[i])
                case 4  :
                    cConjuntos[2].agregarElemento(eElementos[i])
                case 5  :
                    cConjuntos[0].agregarElemento(eElementos[i])
                case 6  :
                    cConjuntos[1].agregarElemento(eElementos[i])
                default :
                    break
                }
            }
            
                // *************
                // si alguno esta vacio entonces hay que vaciar los otros y redistribuir
                if cConjuntos[0].cantidadElementos() == 0 || cConjuntos[1].cantidadElementos() == 0 || cConjuntos[2].cantidadElementos() == 0 {
                    
                    vaciarConjunto(0)
                    vaciarConjunto(1)
                    vaciarConjunto(2)
                }
                
            }   while (cConjuntos[0].cantidadElementos() == 0 || cConjuntos[1].cantidadElementos() == 0 || cConjuntos[2].cantidadElementos() == 0)
            // *************
        }
    }
    
    
    // *************
    // vacia los conjuntos
    internal func vaciarConjunto(indice : Int) -> Void {
        
        let cant = cConjuntos[indice].cantidadElementos()
        
        for i in 0..<cant {
            print("i: " + String(i))
            cConjuntos[indice].eliminarElemento(cConjuntos[indice].getElemento(0))
            
        }
    }
    // *************
    
    internal func mostrarAlarma() -> Void {
    }
    
    
    
    // se limpian las variables para usarse en cada nueva pregunta
    internal func limpiarVariables() -> Void {
        cRespuesta = Conjunto()
        sPreguntas = ""
        eElementos = []
        cConjuntos = []
        iCantidadPreguntas = 0
        Globales.conUniverso = Conjunto()
        
    }
    
    
    // COMENTARIO GENERAL:
    // se llevan a cabo todas las operaciones de generacion de preguntas
    // el sistema utiliza los elementos y conjuntos generados para
    // contestar las preguntas y establecer la respuesta correcta
    // tambien utiliza metodos de la clase para generar respuestas incorrectas
    
    internal func comenzar() -> Void {
        
        /////////////////////////////
        if !bPersonalizado{
            limpiarVariables()
            generarConjuntos()
            generarElementos()
            distribuirElementos()
        }
        
        //////////////////////////////
        
        
        var sTemas : [String] = ["interseccion", "subconjunto", "union", "resta", "complemento", "todos"]
        
        if getTema() == "todos" {
            
            bTodos = true
            
        }
        
        if bTodos {
            
            if (iTema + 1) > 4{
                iTema = 0
            }
            else {
                iTema += 1
            }
            
            setTema(sTemas[iTema])
        }
        
        switch(getTema()) {
            
        case  "interseccion":
            if iCantConjuntos == 2 {
                
                setPreguntas("¿Cuál es la intersección entre el conjunto: " + cConjuntos[0].getNombre() + " y el conjunto: " + cConjuntos[1].getNombre() + "?")
                
                setRespuesta(cConjuntos[1].intersecta(cConjuntos[0]))
                

                
            } else if iCantConjuntos == 3 {
                let iRegion = Int(arc4random_uniform(3))
                
                switch(iRegion) {
                case 0  :
                    setPreguntas("¿Cuál es la intersección entre el conjunto: " + cConjuntos[0].getNombre() + ", el conjunto: " + cConjuntos[1].getNombre() + " y el conjunto: " + cConjuntos[2].getNombre() + "?")
                    setRespuesta(cConjuntos[0].intersecta(cConjuntos[1].intersecta(cConjuntos[2])))
                    
                    break
                case 1  :
                    setPreguntas("¿Cuál es la intersección entre el conjunto: " + cConjuntos[1].getNombre() + " y el conjunto: " + cConjuntos[2].getNombre() + "?")
                    setRespuesta(cConjuntos[1].intersecta(cConjuntos[2]))
                    
                    break
                case 2  :
                    setPreguntas("¿Cuál es la intersección entre el conjunto: " + cConjuntos[0].getNombre() + " y el conjunto: " + cConjuntos[2].getNombre() + "?")
                    setRespuesta(cConjuntos[0].intersecta(cConjuntos[2]))
                    
                    break
                case 3  :
                    setPreguntas("¿Cuál es la intersección entre el conjunto: " + cConjuntos[1].getNombre() + " y el conjunto: " + cConjuntos[0].getNombre() + "?")
                    setRespuesta(cConjuntos[1].intersecta(cConjuntos[0]))
                    break
                default:
                    break;
                }
            }
            
    
            // se generan las respuestas incorrectas en base a la respuesta correcta
            generarRespuestasIncorrectas(getRespuesta())
            // se establece cada pregunta incorrecta
            
            
            
            
            
            break
        case "union" :
            if iCantConjuntos == 2 {
                let iIndice = Int(arc4random_uniform(1))
                let iIndice2 = iIndice == 1 ? 0 : 1
                setPreguntas("¿Cuál es la unión del conjunto: " + cConjuntos[iIndice].getNombre() + " con el conjunto: " + cConjuntos[iIndice2].getNombre() + "?")
                
                setRespuesta(cConjuntos[iIndice].union(cConjuntos[iIndice2]))
            
                
            } else if iCantConjuntos == 3 {
                let iRegion = Int(arc4random_uniform(3))
                
                switch(iRegion) {
                case 0  :
                    setPreguntas("¿Cuál es la union del conjunto: " + cConjuntos[0].getNombre() + " con el conjunto: " + cConjuntos[1].getNombre() + " y el conjunto: " + cConjuntos[2].getNombre() + "?")
                    setRespuesta(cConjuntos[0].union(cConjuntos[1].union(cConjuntos[2])))
                    
                    break
                case 1  :
                    setPreguntas("¿Cuál es la unión  del conjunto: " + cConjuntos[1].getNombre() + " con el conjunto: " + cConjuntos[2].getNombre() + "?")
                    setRespuesta(cConjuntos[1].union(cConjuntos[2]))
                    
                    break
                case 2  :
                    setPreguntas("¿Cuál es la unión del conjunto: " + cConjuntos[0].getNombre() + " con el conjunto: " + cConjuntos[2].getNombre() + "?")
                    setRespuesta(cConjuntos[0].union(cConjuntos[2]))
                    
                    break
                case 3  :
                    setPreguntas("¿Cuál es la unión del conjunto: " + cConjuntos[1].getNombre() + " con el conjunto: " + cConjuntos[0].getNombre() + "?")
                    setRespuesta(cConjuntos[1].union(cConjuntos[0]))
                    break
                    
                default:
                    break;
                }
            }
            
            // se generan las respuestas incorrectas en base a la respuesta correcta
            generarRespuestasIncorrectas(getRespuesta())
        
            break
        case "complemento" :
            
            let iRegion = iCantConjuntos == 2 ? Int(arc4random_uniform(1)) : Int(arc4random_uniform(2))
            
            switch(iRegion) {
            case 0  :
                setPreguntas("¿Cuál es el complemento del conjunto: " + cConjuntos[0].getNombre() + "?")
                
                setRespuesta(cConjuntos[0].complemento())
                
                break
            case 1  :
                setPreguntas("¿Cuál es el complemento del conjunto: " + cConjuntos[1].getNombre() + "?")
                
                setRespuesta(cConjuntos[1].complemento())
                
                break
                
            case 2  :
                setPreguntas("¿Cuál es el complemento del conjunto: " + cConjuntos[2].getNombre() + "?")
                
                setRespuesta(cConjuntos[2].complemento())
                
                
            default:
                break;
            }
            
            generarRespuestasIncorrectas(getRespuesta())
            
  
            
            break
            
        case "resta" :
            
            if iCantConjuntos == 2 {
                let iIndice = Int(arc4random_uniform(1))
                let iIndice2 = iIndice == 1 ? 0 : 1
                setPreguntas("¿Cuál es el resultado de : " + cConjuntos[iIndice].getNombre() + " - " + cConjuntos[iIndice2].getNombre() + "?")
                
                setRespuesta(cConjuntos[iIndice].resta(cConjuntos[iIndice2]))
                
              
                
            } else if iCantConjuntos == 3 {
                // se consideran todos los posbiles casos de restas
                let iRegion = Int(arc4random_uniform(5))
                
                switch(iRegion) {
                    
                case 0 :
                    setPreguntas("¿Cuál es el resultado de : " + cConjuntos[0].getNombre() + " - " + cConjuntos[1].getNombre() + "?")
                    
                    setRespuesta(cConjuntos[0].resta(cConjuntos[1]))
                    
                    break
                case 1 :
                    setPreguntas("¿Cuál es el resultado de : " + cConjuntos[1].getNombre() + " - " + cConjuntos[2].getNombre() + "?")
                    
                    setRespuesta(cConjuntos[1].resta(cConjuntos[2]))
                    
                    break
                    
                case 2 :
                    setPreguntas("¿Cuál es el resultado de : " + cConjuntos[0].getNombre() + " - " + cConjuntos[2].getNombre() + "?")
                    
                    setRespuesta(cConjuntos[0].resta(cConjuntos[2]))
                    
                    break
                case 3 :
                    setPreguntas("¿Cuál es el resultado de : " + cConjuntos[1].getNombre() + " - " + cConjuntos[0].getNombre() + "?")
                    
                    setRespuesta(cConjuntos[1].resta(cConjuntos[0]))
                    
                    break
                case 4 :
                    setPreguntas("¿Cuál es el resultado de : " + cConjuntos[2].getNombre() + " - " + cConjuntos[1].getNombre() + "?")
                    
                    setRespuesta(cConjuntos[2].resta(cConjuntos[1]))
                    
                    break
                    
                case 5 :
                    setPreguntas("¿Cuál es el resultado de : " + cConjuntos[2].getNombre() + " - " + cConjuntos[0].getNombre() + "?")
                    
                    setRespuesta(cConjuntos[2].resta(cConjuntos[0]))
                    
                    break
                    
                default :
                    break
                    
                }
                
             

            }
            
            
            
            // se generan las respuestas incorrectas
            generarRespuestasIncorrectas(getRespuesta())
            
            break
            
        case "subconjunto" :
            
            
            //***************
            // para los ejercicios de subconjunto se revisa si el conjunto seleccionado por el programa contiene
            // todos los elementos del universo, de ser el caso hay que limpiar todo y redistribuir los elementos
            // de lo contrario todas las respuestas serian subconjuntos
            while (cConjuntos[0].cantidadElementos() == Globales.conUniverso.cantidadElementos() ||
                cConjuntos[1].cantidadElementos() == Globales.conUniverso.cantidadElementos() ||
                cConjuntos[2].cantidadElementos() == Globales.conUniverso.cantidadElementos() ) {
                    
                    vaciarConjunto(0)
                    vaciarConjunto(1)
                    vaciarConjunto(2)
                    distribuirElementos()
                    
            }
            
            //***************
            
            var cIncorrecto = Conjunto()
            let iRegion = iCantConjuntos == 2 ? Int(arc4random_uniform(1)) : Int(arc4random_uniform(2))
            
            
            switch(iRegion) {
            case 0  :
                setPreguntas("¿Cuál es un subconjunto de : " + cConjuntos[0].getNombre() + "?")
                
                let nuevoConjunto = Conjunto()
       
                nuevoConjunto.setElementos(cConjuntos[0].getElementos())
                
                nuevoConjunto.eliminarElemento(cConjuntos[0].getElemento(0))
                
                setRespuesta(nuevoConjunto)
                cIncorrecto = cConjuntos[0].complemento()
                
                break
            case 1  :
                
                
                
                setPreguntas("¿Cuál es un subconjunto de : " + cConjuntos[1].getNombre() + "?")
                
                let nuevoConjunto = Conjunto()
                
                var iPos : Int = 0
                // si el conjunto tiene un elemento
                if cConjuntos[1].cantidadElementos() == 1 {
                    // se va a eliminar ese
                    iPos = 0
                } else {
                    // de lo contrario, el segundo
                    // siempre habra 1 elemento o mas
                    iPos = 1
                }
                
                nuevoConjunto.setElementos(cConjuntos[1].getElementos())
                
                nuevoConjunto.eliminarElemento(cConjuntos[1].getElemento(iPos))
                
                setRespuesta(nuevoConjunto)
                cIncorrecto = cConjuntos[1].complemento()
                break
            case 2  :
                
                
                var iPos : Int = 0
                
                // si el conjunto tiene un elemento
                if cConjuntos[1].cantidadElementos() == 1 {
                    // se va a eliminar ese
                    iPos = 0
                } else if cConjuntos[1].cantidadElementos() == 2 {
                    // si tiene dos, el segundo
                    iPos = 1
                } else {
                    // de lo contrario, el tercero
                    iPos = 2
                }
                
                
                
                setPreguntas("¿Cuál es un subconjunto de : " + cConjuntos[2].getNombre() + "?")
                
                let nuevoConjunto = Conjunto()
                
                nuevoConjunto.setElementos(cConjuntos[2].getElementos())
                
                nuevoConjunto.eliminarElemento(cConjuntos[2].getElemento(iPos))
                
                setRespuesta(nuevoConjunto)
                cIncorrecto = cConjuntos[2].complemento()
                break
            default:
                break
            }
            
    
            // se generan las respuestas incorrectas
            generarRespuestasIncorrectas(cIncorrecto)
            
            
            
            
            break
            
        default:
            break
            
            
        }
    }
    
    
    internal func finalizar() -> Void {
    }
    
    // -- getters
    
    internal func getID() -> Int {
        return iId
    }
    
    internal func getRespuesta() -> Conjunto {
        return cRespuesta
    }
    
    // se regresa un string con los nombres de los elementos
    // concatenados que pertenecen a la repsuesta correcta
    internal func getRespuestaCorrecta() -> String {
        var respuesta : String = "{"
        
        for i in 0..<cRespuesta.cantidadElementos() {
            
            if i == cRespuesta.cantidadElementos() - 1 {
                respuesta += cRespuesta.getElemento(i).getNombre()
            }
            else {
                respuesta += (cRespuesta.getElemento(i).getNombre() + ", ")
            }
        }
        
        respuesta += "}"
        return respuesta
    }
    // funcionalida similar al metodo getRespuestaCorrecta
    internal func getElementos(conjunto : Conjunto) -> String {
        var elementos : String = "{"
        
        for i in 0..<conjunto.cantidadElementos() {
            
            if i == conjunto.cantidadElementos() - 1 {
                elementos += conjunto.getElemento(i).getNombre()
            }
            else {
                elementos += (conjunto.getElemento(i).getNombre() + ", \n")
            }
        }
        
        elementos += "}"
        return elementos
    }
    
    
     // funcionalida similar al metodo getRespuestaCorrecta
    internal func getElementosIncorrectos(conjunto : Conjunto) -> String {
        var elementos : String = "{"
        
        for i in 0..<conjunto.cantidadElementos() {
            
            if i == conjunto.cantidadElementos() - 1 {
                elementos += conjunto.getElemento(i).getNombre()
            }
            else {
                elementos += (conjunto.getElemento(i).getNombre() + ", ")
            }
        }
        
        elementos += "}"
        return elementos
    }
    
    
    internal func getPreguntas() -> String {
        return sPreguntas
    }
    
    internal func getCantidadPreguntas() -> Int {
        return iCantidadPreguntas
    }
    
    internal func getTema() -> String {
        return sTema
    }
    
    
    // se regresan todos los elementos usados en el ejercicio concatenados dentro de un string
    internal func getConjuntoTexto(nombre : String) -> String {
        var elementos : String = nombre + "= \n"
        var conjunto1 = Conjunto()
        var conjunto2 = Conjunto()
        var conjunto3 = Conjunto()
        if (nombre == "C1" || nombre == "C2" || nombre == "C3") {
            for i in 0..<iCantConjuntos{
                if nombre == cConjuntos[i].getNombre() {
                    elementos += (getElementos(cConjuntos[i]) + "\n")
                    break
                }
            }
        }
        else if nombre == "C1∩C2"{
            for i in 0..<iCantConjuntos{
                if "C1" == cConjuntos[i].getNombre(){
                    conjunto1 = cConjuntos[i]
                }
                else if "C2" == cConjuntos[i].getNombre(){
                    conjunto2 = cConjuntos[i]
                }
            }
            elementos += (getElementos(conjunto1.intersecta(conjunto2)) + "\n")
        }
        else if nombre == "C1∩C3"{
            for i in 0..<iCantConjuntos{
                if "C1" == cConjuntos[i].getNombre(){
                    conjunto1 = cConjuntos[i]
                }
                else if "C3" == cConjuntos[i].getNombre(){
                    conjunto3 = cConjuntos[i]
                }
            }
            elementos += (getElementos(conjunto1.intersecta(conjunto3)) + "\n")
            
        }
        else if nombre == "C2∩C3"{
            for i in 0..<iCantConjuntos{
                if "C2" == cConjuntos[i].getNombre(){
                    conjunto2 = cConjuntos[i]
                }
                else if "C3" == cConjuntos[i].getNombre(){
                    conjunto3 = cConjuntos[i]
                }
            }
            elementos += (getElementos(conjunto2.intersecta(conjunto3)) + "\n")
        }
        else if nombre == "C1∩C2∩C3" {
            for i in 0..<iCantConjuntos{
                if "C1" == cConjuntos[i].getNombre(){
                    conjunto1 = cConjuntos[i]
                }
                else if "C2" == cConjuntos[i].getNombre(){
                    conjunto2 = cConjuntos[i]
                }
                else if "C3" == cConjuntos[i].getNombre(){
                    conjunto3 = cConjuntos[i]
                }
            }
            elementos += (getElementos(conjunto1.intersecta(conjunto2.intersecta(conjunto3))) + "\n")
            
        }
        
        return elementos
    }
    
    // -- setters
    
    internal func setID(iId : Int) -> Void {
        self.iId = iId;
    }
    
    let cRespuestaTemp = Conjunto()
    
    internal func setRespuesta(cRespuesta : Conjunto) -> Void {
        self.cRespuesta = cRespuesta
      
    }
    
    private var cRespuestasIncorrectas : [Conjunto] = []
    
    
    internal func setPreguntas(sPreguntas : String) -> Void {
        self.sPreguntas = sPreguntas
    }
    
    internal func setCantidadPreguntas() -> Int {
        return iCantidadPreguntas
    }
    
    internal func setTema(sTema : String) -> Void {
        self.sTema = sTema
    }
    
    
    // funcionalida similar al metodo getRespuestaCorrecta
    internal func getRespuestaIncorrecta1() -> String {
        
        var elementos : String = "{"
        
        for i in 0..<cRespuestaIncorrecta1.cantidadElementos() {
            
            if i == cRespuestaIncorrecta1.cantidadElementos() - 1 {
                elementos += cRespuestaIncorrecta1.getElemento(i).getNombre()
            }
            else {
                elementos += (cRespuestaIncorrecta1.getElemento(i).getNombre() + ", ")
            }
        }
        
        elementos += "}"
        
        
        
        
        
        return elementos
    }
    
    // funcionalida similar al metodo getRespuestaCorrecta
    internal func getRespuestaIncorrecta2() -> String {
        
        var elementos : String = "{"
        
        for i in 0..<cRespuestaIncorrecta2.cantidadElementos() {
            
            if i == cRespuestaIncorrecta2.cantidadElementos() - 1 {
                elementos += cRespuestaIncorrecta2.getElemento(i).getNombre()
            }
            else {
                elementos += (cRespuestaIncorrecta2.getElemento(i).getNombre() + ", ")
            }
        }
        
        
        elementos += "}"
        
        return elementos
    }
    
    
    // funcionalida similar al metodo getRespuestaCorrecta
    internal func getRespuestaIncorrecta3() -> String {
        
        
        
        var elementos : String = "{"
        
        for i in 0..<cRespuestaIncorrecta3.cantidadElementos() {
            
            if i == cRespuestaIncorrecta3.cantidadElementos() - 1 {
                elementos += cRespuestaIncorrecta3.getElemento(i).getNombre()
            }
            else {
                elementos += (cRespuestaIncorrecta3.getElemento(i).getNombre() + ", ")
            }
        }
        
        elementos += "}"
        
        
        return elementos
    }
    
    
    // se generan todas las respuestas incorrectas
    // se considera la cantidad de elementos de cada conjuntos
    // para determinar la tecnica de asignacion de elementos incorrectos
    internal func generarRespuestasIncorrectas(cConjunto : Conjunto) -> Void {
        
        var iOpcionesCantidad : Int = 0
        
        let cConjunto2 = Conjunto()
        let cConjunto3 = Conjunto()
        let cConjunto4 = Conjunto()
        
        for i in  0..<cConjunto.cantidadElementos() {
            
            cConjunto2.agregarElemento(cConjunto.getElemento(i))
        }
        
        for i in  0..<cConjunto.cantidadElementos() {
            
            cConjunto3.agregarElemento(cConjunto.getElemento(i))
        }
        
        
        for i in  0..<cConjunto.cantidadElementos() {
            
            cConjunto4.agregarElemento(cConjunto.getElemento(i))
        }
        
        
        if cConjunto.cantidadElementos() == 0 {
            iOpcionesCantidad = 0
            
        } else if cConjunto.cantidadElementos() == Globales.conUniverso.cantidadElementos() {
            iOpcionesCantidad = 2
            
        } else {
            iOpcionesCantidad = 1
        }
        
        cRespuestaIncorrecta2 = generarRespuestaIncorrecta2(cConjunto3, iCantidad: iOpcionesCantidad)
        
        cRespuestaIncorrecta1 = generarRespuestaIncorrecta1(cConjunto2, iCantidad: iOpcionesCantidad)
        
        cRespuestaIncorrecta3 = generarRespuestaIncorrecta3(cConjunto4, iCantidad: iOpcionesCantidad)
        
        
    }
    // primeras 3 tecnicas de establecimiento de elementos para la primera respuesta incorrecta
    internal func generarRespuestaIncorrecta1(cConjunto : Conjunto, iCantidad : Int) -> Conjunto {
        
        switch iCantidad {
        case 0 :
            cConjunto.agregarElemento(Globales.conUniverso.getElemento(0))
            break
        case 1:
            
            cConjunto.agregarElemento(cConjunto.complemento().getElemento(0))
            
            break
        case 2:
            cConjunto.eliminarElemento(cConjunto.getElemento(0))
            break
        default:
            break
        }
        
        
        return cConjunto
        
    }
    
    // siguientes 3 tecnicas de establecimiento de elementos para la segunda respuesta incorrecta
    internal func generarRespuestaIncorrecta2(cConjunto : Conjunto, iCantidad : Int) -> Conjunto {
        
        
        switch iCantidad {
        case 0 :
            cConjunto.agregarElemento(Globales.conUniverso.getElemento(0))
            cConjunto.agregarElemento(Globales.conUniverso.getElemento(1))
            break
        case 1:
            
            cConjunto.eliminarElemento(cConjunto.getElemento(cConjunto.cantidadElementos() - 1))
            
            
            break
        case 2:
            cConjunto.eliminarElemento(cConjunto.getElemento(0))
            cConjunto.eliminarElemento(cConjunto.getElemento(1))
            break
        default:
            break
        }
        
        
        return cConjunto
    }
    
    
    // ultimas 3 tecnicas de establecimiento de elementos para la tercera respuesta incorrecta
    internal func generarRespuestaIncorrecta3(cConjunto : Conjunto, iCantidad : Int) -> Conjunto {
        
        
        switch iCantidad {
        case 0 :
            cConjunto.agregarElemento(Globales.conUniverso.getElemento(0))
            cConjunto.agregarElemento(Globales.conUniverso.getElemento(1))
            cConjunto.agregarElemento(Globales.conUniverso.getElemento(1))
            break
        case 1:
            cConjunto.eliminarElemento(cConjunto.getElemento(cConjunto.cantidadElementos() - 1))
            cConjunto.agregarElemento(cConjunto.complemento().getElemento(0))
            
            
            break
        case 2:
            cConjunto.eliminarElemento(cConjunto.getElemento(0))
            cConjunto.eliminarElemento(cConjunto.getElemento(1))
            cConjunto.eliminarElemento(cConjunto.getElemento(2))
            break
        default:
            break
        }
        
        
        
        
        
        return cConjunto
    }
    
    ///////////////////////////////
    func activaPersonalizado(){
        bPersonalizado = true
    }
    func desactivaPersonalizado(){
        bPersonalizado = false
    }
    func setConjuntos(conjuntos: [Conjunto]){
        iCantConjuntos = conjuntos.count
        cConjuntos = conjuntos
    }
    ////////////////////////////////
    
   
    
}