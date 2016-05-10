//
//  seleccionaConjuntoViewController.swift
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

class seleccionaConjuntoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    
    @IBOutlet weak var conjuntoPicker: UIPickerView!
    var pickerData: [String] = [String]()
    var dataFilePath: String?
    @IBOutlet weak var imagen: UIImageView!
    var universos : [Conjunto] = [] // Variable para guardar todos los universos posibles
    
    var universoSeleccionado : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagen.image = UIImage(named:"Num")
              // Do any additional setup after loading the view.
        
        // Conectar a pickerview
        conjuntoPicker.delegate = self
        conjuntoPicker.dataSource = self
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        let conjuntosPersonalizados = defaults.integerForKey("cantidadConjuntos")
   
        
        // Datos que se van a introducir al picker view por default
        pickerData = ["Números", "Alfabeto", "Animales", "Meses"]
        
        
        
        // Crea el universo de numeros
        let conjuntoNumeros : Conjunto = Conjunto()
        
        for i in 1..<16 {
            let elemento : Elemento = Elemento()
            elemento.setNombre(String(i))
            conjuntoNumeros.agregarElemento(elemento)
        }
        
        // Crea el universo del alfabeto
        var alfabeto : [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        
        let conjuntoAlfabeto : Conjunto = Conjunto()
        for i in 0..<alfabeto.count {
            let elemento : Elemento = Elemento()
            elemento.setNombre(alfabeto[i])
            conjuntoAlfabeto.agregarElemento(elemento)
        }
        
        // Crea el universo de animales
        var animales : [String] = ["perro","gato","caballo","perico","ballena","halcón","cocodrilo","pez","serpiente","conejo","oso","ratón","liebre","araña"]
        
        let conjuntoAnimales : Conjunto = Conjunto()
        for i in 0..<animales.count {
            let elemento : Elemento = Elemento()
            elemento.setNombre(animales[i])
            conjuntoAnimales.agregarElemento(elemento)
        }
        
        // Crea el universo de dias de la semana
        var meses : [String] = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
        
        let conjuntoMeses : Conjunto = Conjunto()
        for i in 0..<meses.count {
            let elemento : Elemento = Elemento()
            elemento.setNombre(meses[i])
            conjuntoMeses.agregarElemento(elemento)
        }
        
        // Agrega conjuntos al arreglo de universos
        universos.append(conjuntoNumeros)
        universos.append(conjuntoAlfabeto)
        universos.append(conjuntoAnimales)
        universos.append(conjuntoMeses)
        
        // Crea los conjuntos personalizados y los agrega el conjunto de universos
        for i in 0..<conjuntosPersonalizados {
            if (defaults.objectForKey("item\(i+1)") != nil){
                var data : [NSData] = defaults.objectForKey("item\(i+1)") as! [NSData]
                pickerData.append(NSKeyedUnarchiver.unarchiveObjectWithData(data[0] ) as! String)
                let nuevoConjunto : Conjunto = Conjunto()
                for j in 1..<data.count{
                   
                    let elemento : Elemento = Elemento()
                    elemento.setNombre(NSKeyedUnarchiver.unarchiveObjectWithData(data[j] ) as! String)
                    nuevoConjunto.agregarElemento(elemento)
                    
                }
                universos.append(nuevoConjunto)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        universoSeleccionado = row
        switch row {
        case 0:
            imagen.image = UIImage(named:"Num")
        case 1:
            imagen.image = UIImage(named:"Alfabeto")
        case 2:
            imagen.image = UIImage(named:"Animales")
        case 3:
            imagen.image = UIImage(named:"Calendario")
        default:
            imagen.image = UIImage(named:"Personalizado-1")
        }
        self.view.endEditing(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "continuar" {
 
            Globales.conUniverso = universos[universoSeleccionado]
            
        }
    }
   

}
