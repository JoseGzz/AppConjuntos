//
//  agregarConjuntoViewController.swift
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

class agregarConjuntoViewController: UIViewController, UITextFieldDelegate {

    
    // outlets
    @IBOutlet weak var nombreElemento: UITextField!
    var sNombre : String = ""
    var sConjunto : String = ""
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbConjunto: UILabel!
    @IBOutlet weak var tfNombreElemento: UITextField!
    var conjunto = Conjunto()
    var contador : Int = 0
    
    @IBOutlet weak var bAgregar: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbNombre.text = sNombre
        sConjunto = sNombre + " = " + conjunto.getTextoElementos()
        lbConjunto.text = sConjunto
        conjunto.setNombre(sNombre)
        tfNombreElemento.delegate = self
        // Do any additional setup after loading the view.
    }
 

    @IBAction func quitaTeclado(sender: AnyObject) {
        self.view.endEditing(true)
    }
    @IBAction func crearConjunto(sender: AnyObject) {
        if contador > 9 {
            performSegueWithIdentifier("crear", sender: nil)
        }
        else {
            let alerta = UIAlertController(title: "Error", message: "Introduce mínimo 10 elementos", preferredStyle: UIAlertControllerStyle.Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        bAgregar.sendActionsForControlEvents(.TouchUpInside)
        textField.resignFirstResponder()
        return true;
    }
    // accion para agregar elementos a un personalizado
    @IBAction func presionaAgregar(sender: AnyObject) {
        
        
        if tfNombreElemento.text == ""{
            let alerta = UIAlertController(title: "Nombre incorrecto", message: "Introduce el nombre del elemento para continuar", preferredStyle: UIAlertControllerStyle.Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }
        else {
            let elemento = Elemento()
            elemento.setNombre(tfNombreElemento.text!)
            if(conjunto.existe(elemento)){
                let alerta = UIAlertController(title: "El elemento ya existe", message: "No se pueden repetir elementos", preferredStyle: UIAlertControllerStyle.Alert)
                alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alerta, animated: true, completion: nil)
            }
            else {
                conjunto.agregarElemento(elemento)
                sConjunto = sNombre + " = " + conjunto.getTextoElementos()
                lbConjunto.text = sConjunto
                contador+=1
                tfNombreElemento.text=""
            }
        }
        
    }

    
    // Implementa persistencia de datos y guarda el conjunto creado
    func guardaConjunto() -> Void {
        var conjuntos : Int = 1
        
        // obtiene variables default
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Checa si existen conjuntos creados anteriormente
        if NSUserDefaults.standardUserDefaults().objectForKey("cantidadConjuntos") != nil {
            conjuntos = defaults.integerForKey("cantidadConjuntos")
            conjuntos += 1
            defaults.setInteger(conjuntos, forKey: "cantidadConjuntos")
            defaults.synchronize()
            
        }
        else {
            conjuntos = 1
            defaults.setInteger(conjuntos, forKey: "cantidadConjuntos")
            defaults.synchronize()
        }
        
        let encodedName = NSKeyedArchiver.archivedDataWithRootObject(conjunto.getNombre())
        
        var encodedarray = [encodedName]
        
        for i in 0..<conjunto.getElementos().count {
            let encodedElement = NSKeyedArchiver.archivedDataWithRootObject(conjunto.getElemento(i).getNombre())
            encodedarray.append(encodedElement)
        }
        
        defaults.setObject(encodedarray, forKey: "item\(conjuntos)")
        defaults.synchronize()
        
        var data : [NSData] = defaults.objectForKey("item\(conjuntos)") as! [NSData]
        
        for i in 0..<data.count {
            print(NSKeyedUnarchiver.unarchiveObjectWithData(data[i] ) as! String)
        }
        

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "crear" {
            guardaConjunto()
        }
    }
    

}
