//
//  CrearConjuntoViewController.swift
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

class CrearConjuntoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfNombre: UITextField!
    var bNombre : Bool = false
    var conjunto = Conjunto()
    @IBOutlet weak var bSiguiente: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNombre.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        bSiguiente.sendActionsForControlEvents(.TouchUpInside)
        textField.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func quitaTeclado(sender: AnyObject) {
        self.view.endEditing(true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "siguiente"{
            if tfNombre.text == ""{
                let alerta = UIAlertController(title: "Nombre incorrecto", message: "Introduce el nombre del universo para continuar", preferredStyle: UIAlertControllerStyle.Alert)
                alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alerta, animated: true, completion: nil)
            }
            else {
                let view = segue.destinationViewController as! agregarConjuntoViewController
                view.sNombre = tfNombre.text!
            }
            
        }
        
    }

}
