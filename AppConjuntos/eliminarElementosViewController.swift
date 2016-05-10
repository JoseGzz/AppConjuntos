//
//  eliminarElementosViewController.swift
//  AppConjuntos
//
//   Created by
//   Jose Gzz
//   Israel Hernandez
//   Martha Benavides
//   on 4/5/16.
//  Copyright © 2016 Israel . All rights reserved.
//

import UIKit

class eliminarElementosViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    // outlets
    @IBOutlet weak var btnRojo: UIButton!
    @IBOutlet weak var btnNaranja: UIButton!
    @IBOutlet weak var btnAmarillo: UIButton!
    @IBOutlet weak var btnVerde: UIButton!
    @IBOutlet weak var btnAzul: UIButton!
    @IBOutlet weak var btnMorado: UIButton!
    @IBOutlet weak var btnCafe: UIButton!
    @IBOutlet weak var imgConjunto: UIImageView!
    @IBOutlet weak var pickerElemento: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    var conjuntos : [Conjunto] = []
    
    var conjunto1 : String = ""
    var conjunto2 : String = ""
    var conjunto3 : String = ""
    var nombreElemento : String = ""
    
    var intersecta : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Conectar a pickerview
        pickerElemento.delegate = self
        pickerElemento.dataSource = self
        
        if pickerData.count == 0{
            pickerData.append("Selecciona un conjunto")
        }
        
        
        /* Datos que se van a introducir al picker view
        for i in 0..<Globales.conUniverso.cantidadElementos(){
            pickerData.append(Globales.conUniverso.getElemento(i).getNombre())
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // identifica rla region que fue presionada
    @IBAction func oprimeFigura(sender: UIButton) {
        
        switch (sender) {
        case btnRojo:
            conjunto2 = "C2"
            imgConjunto.image = UIImage(named: "rojo")
            break;
        case btnNaranja:
            conjunto2 = "C2"
            conjunto3 = "C3"
            intersecta = "23"
            imgConjunto.image = UIImage(named: "naranja")
            break;
        case btnAmarillo:
            conjunto3 = "C3"
            imgConjunto.image = UIImage(named: "amarillo")
            break;
        case btnVerde:
            conjunto1 = "C1"
            conjunto3 = "C3"
            intersecta = "13"
            imgConjunto.image = UIImage(named: "verde-1")
            break;
        case btnAzul:
            conjunto1 = "C1"
            imgConjunto.image = UIImage(named: "azul")
            break;
        case btnMorado:
            conjunto1 = "C1"
            conjunto2 = "C2"
            intersecta = "12"
            imgConjunto.image = UIImage(named: "morado")
            break;
        case btnCafe:
            conjunto1 = "C1"
            conjunto2 = "C2"
            conjunto3 = "C3"
            intersecta = "123"
            imgConjunto.image = UIImage(named: "cafe")
            break;
        default:
            imgConjunto.image = UIImage(named: "completo")
            break;
        }
        mostrarelementos()
    }
    
    //mostrar lista en picker view
    func mostrarelementos() -> Void {
        pickerData.removeAll()
        
        let auxconjunto1 : Conjunto = Conjunto()
        let auxconjunto2 : Conjunto = Conjunto()
        let auxconjunto3 : Conjunto = Conjunto()
        
        for i in 0..<conjuntos.count{
            if conjuntos[i].getNombre() == conjunto1{
                auxconjunto1.setElementos(conjuntos[i].getElementos())
            }
            else if conjuntos[i].getNombre() == conjunto2 {
                auxconjunto2.setElementos(conjuntos[i].getElementos())
            }
            else if conjuntos[i].getNombre() == conjunto3{
                auxconjunto3.setElementos(conjuntos[i].getElementos())
            }
        }
        
        let nuevoConjunto : Conjunto = Conjunto()
        
        if intersecta == "12" {
            nuevoConjunto.setElementos(auxconjunto1.intersecta(auxconjunto2).getElementos())
        }
        else if intersecta == "13" {
            nuevoConjunto.setElementos(auxconjunto1.intersecta(auxconjunto3).getElementos())
        }
        else if intersecta == "23" {
            nuevoConjunto.setElementos(auxconjunto2.intersecta(auxconjunto3).getElementos())
        }
        else if intersecta == "123"{
            nuevoConjunto.setElementos(auxconjunto1.intersecta(auxconjunto2.intersecta(auxconjunto3)).getElementos())
        }
        
        if intersecta == "" {
            for i in 0..<conjuntos.count {
                if conjuntos[i].getNombre() == conjunto1 || conjuntos[i].getNombre() == conjunto2 || conjuntos[i].getNombre() == conjunto3 {
                    for j in 0..<conjuntos[i].getElementos().count{
                        if !(pickerData.contains(conjuntos[i].getElemento(j).getNombre())){
                            pickerData.append(conjuntos[i].getElemento(j).getNombre())
                        }
                    }
                }
            }
        }
        else {
            for j in 0..<nuevoConjunto.getElementos().count{
                if !(pickerData.contains(nuevoConjunto.getElemento(j).getNombre())){
                    pickerData.append(nuevoConjunto.getElemento(j).getNombre())
                }
            }
        }
        
        intersecta = ""
        conjunto1 = ""
        conjunto2 = ""
        conjunto3 = ""
        pickerElemento.reloadAllComponents()
    }
    
    // Regresa el numero de columnas del picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // Regresa la cantidad de renglones (en este caso la cantidad de elementos en el arreglo)
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    
    // Regresa cada renglon del arreglo
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        nombreElemento = pickerData[row]
        self.view.endEditing(true)
    }

    
    
    // MARK: - Navigation
    
    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eliminar" {
            for i in 0..<conjuntos.count {
                let elemento : Elemento = Elemento()
                elemento.setNombre(nombreElemento)
                if (conjuntos[i].existe(elemento) && (conjuntos[i].getNombre() == conjunto1 || conjuntos[i].getNombre() == conjunto2 || conjuntos[i].getNombre() == conjunto3)){
                    conjuntos[i].eliminarElemento(elemento)
                }
            }
            let view = segue.destinationViewController as! modificaConjuntoViewController
            view.conjuntos = conjuntos
        }
    }
}
