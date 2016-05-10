//
//  agregarViewController.swift
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

class agregarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var btnRojo: UIButton!
    @IBOutlet weak var btnNaranja: UIButton!
    @IBOutlet weak var btnAmarillo: UIButton!
    @IBOutlet weak var btnCafe: UIButton!
    @IBOutlet weak var btnMorado: UIButton!
    @IBOutlet weak var btnVerde: UIButton!
    @IBOutlet weak var btnAzul: UIButton!
    
    @IBOutlet weak var imgConjunto: UIImageView!
    @IBOutlet weak var pickerElemento: UIPickerView!
    
    var pickerData: [String] = [String]()

    var conjuntos : [Conjunto] = []

    var conjunto1 : String = ""
    var conjunto2 : String = ""
    var conjunto3 : String = ""
    var nombreElemento : String = ""
    var cantelementos : Int = 0
    var bSelecciona : Bool = false
    var bExiste : Bool = false
    var bSuma : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        bSuma = true
        // Do any additional setup after loading the view.
        bExiste = false
        // Conectar a pickerview
        pickerElemento.delegate = self
        pickerElemento.dataSource = self
        
        // Datos que se van a introducir al picker view
        for i in 0..<Globales.conUniverso.cantidadElementos(){
            pickerData.append(Globales.conUniverso.getElemento(i).getNombre())
        }
        
        nombreElemento = pickerData[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // identificar region de los diagramas
    @IBAction func oprimeFigura(sender: UIButton) {
     
        switch (sender) {
        case btnRojo:
            conjunto1 = "C2"
            imgConjunto.image = UIImage(named: "rojo")
            break;
        case btnNaranja:
            conjunto1 = "C2"
            conjunto2 = "C3"
            imgConjunto.image = UIImage(named: "naranja")
            break;
        case btnAmarillo:
            conjunto1 = "C3"
            imgConjunto.image = UIImage(named: "amarillo")
            break;
        case btnVerde:
            conjunto1 = "C1"
            conjunto2 = "C3"
            imgConjunto.image = UIImage(named: "verde-1")
            break;
        case btnAzul:
            conjunto1 = "C1"
            imgConjunto.image = UIImage(named: "azul")
            break;
        case btnMorado:
            conjunto1 = "C1"
            conjunto2 = "C2"
            imgConjunto.image = UIImage(named: "morado")
            break;
        case btnCafe:
            conjunto1 = "C1"
            conjunto2 = "C2"
            conjunto3 = "C3"
            imgConjunto.image = UIImage(named: "cafe")
            break;
        default:
            imgConjunto.image = UIImage(named: "completo")
            break;
        }
        bSelecciona = true
    }
    
    // Regresa el numero de columnas del picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    @IBAction func presionaAgregar(sender: AnyObject) {
        if bSelecciona{
            performSegueWithIdentifier("anadir", sender: nil)
        }
        else {
            let alerta = UIAlertController(title: "Error", message: "Selecciona el conjunto", preferredStyle: UIAlertControllerStyle.Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "anadir" {
            for i in 0..<conjuntos.count {
                if conjuntos[i].getNombre() == conjunto1 || conjuntos[i].getNombre() == conjunto2 || conjuntos[i].getNombre() == conjunto3 {
                    let elemento : Elemento = Elemento(x : 1)
                    elemento.setNombre(nombreElemento)
                    if !(conjuntos[i].existe(elemento)){
                        if bSuma {
                            cantelementos+=1
                            bSuma = false
                        }
                        conjuntos[i].agregarElemento(elemento)
                    }else {
                        bExiste = true
                    }
                    
                    
                }
            }
            let view = segue.destinationViewController as! modificaConjuntoViewController
            view.conjuntos = conjuntos
            view.cantelementos = cantelementos
        }
        else if segue.identifier == "regresar"{
            let view = segue.destinationViewController as! modificaConjuntoViewController
            view.conjuntos = conjuntos
            view.cantelementos = cantelementos
        }
    }
}
