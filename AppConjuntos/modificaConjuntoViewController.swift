//
//  modificaConjuntoViewController.swift
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

class modificaConjuntoViewController: UIViewController,UIPopoverPresentationControllerDelegate  {

    @IBOutlet weak var btnRojo: UIButton!
    @IBOutlet weak var btnNaranja: UIButton!
    @IBOutlet weak var btnAmarillo: UIButton!
    @IBOutlet weak var btnVerde: UIButton!
    @IBOutlet weak var btnAzul: UIButton!
    @IBOutlet weak var btnMorado: UIButton!
    @IBOutlet weak var btnCafe: UIButton!
    @IBOutlet weak var imgConjunto: UIImageView!
    
    var conjuntos : [Conjunto] = []
    
    @IBOutlet weak var lbCantElementos: UILabel!
    
    var cantelementos : Int = 0

    var ejercicio : Ejercicio = Ejercicio()
    
    var existenConjuntos : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        lbCantElementos.text = String(cantelementos)
        for i in 0..<conjuntos.count {
            if (conjuntos[i].getNombre() == "C1" || conjuntos[i].getNombre() == "C2" || conjuntos[i].getNombre() == "C3"){
                existenConjuntos = true
            }
        }
        
        if !existenConjuntos {
            ejercicio.activaPersonalizado()
            let conjunto1 : Conjunto = Conjunto()
            let conjunto2 : Conjunto = Conjunto()
            let conjunto3 : Conjunto = Conjunto()
            conjunto1.setNombre("C1")
            conjunto2.setNombre("C2")
            conjunto3.setNombre("C3")
            conjuntos.append(conjunto1)
            conjuntos.append(conjunto2)
            conjuntos.append(conjunto3)
        }
        
        ejercicio.setConjuntos(conjuntos)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func oprimeFigura(sender: UIButton) {
        switch (sender) {
        case btnRojo:
            imgConjunto.image = UIImage(named: "rojo")
            break;
        case btnNaranja:
            imgConjunto.image = UIImage(named: "naranja")
            break;
        case btnAmarillo:
            imgConjunto.image = UIImage(named: "amarillo")
            break;
        case btnVerde:
            imgConjunto.image = UIImage(named: "verde-1")
            break;
        case btnAzul:
            imgConjunto.image = UIImage(named: "azul")
            break;
        case btnMorado:
            imgConjunto.image = UIImage(named: "morado")
            break;
        case btnCafe:
            imgConjunto.image = UIImage(named: "cafe")
            break;
        default:
            imgConjunto.image = UIImage(named: "completo")
            break;
        }
        
    }
    // no permite que un usuario agregue menos de ocho elementos y cada conjunto minimo un elemento
    @IBAction func continuar(sender: AnyObject) {
        if cantelementos > 7 {
            
            var bAvanzar : Bool = true
            for i in 0..<conjuntos.count{
                if conjuntos[i].cantidadElementos() == 0{
                    bAvanzar = false
                }
            }
            
            if bAvanzar {
                performSegueWithIdentifier("continuar", sender: nil)
            }
            else {
                let alerta = UIAlertController(title: "Error", message: "Introduce al menos 1 elemento en cada conjunto", preferredStyle: UIAlertControllerStyle.Alert)
                alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alerta, animated: true, completion: nil)
            }
            
            
        }
        else {
            let alerta = UIAlertController(title: "Error", message: "Introduce mínimo 8 elementos", preferredStyle: UIAlertControllerStyle.Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "eliminar" {
            print("aaaa")
            let view = segue.destinationViewController as! eliminarElementosViewController
            view.conjuntos = conjuntos
        }
        else if segue.identifier == "anadir" {
            let view = segue.destinationViewController as! agregarViewController
            view.conjuntos = conjuntos
            view.cantelementos = cantelementos
        }
        else if segue.identifier == "regresar"{
  
        }else if segue.identifier == "continuar"{
                let view = segue.destinationViewController as! preguntaViewController
                let ejercicio : Ejercicio = Ejercicio()
                ejercicio.setConjuntos(conjuntos)
                ejercicio.activaPersonalizado()
                view.ejercicio = ejercicio

        
        }
        else {
            let vc = segue.destinationViewController as! popOver2ViewController
            let controller = vc.popoverPresentationController
            
            if controller != nil
            {
                controller?.delegate = self
            }
            
            vc.texto = ejercicio.getConjuntoTexto(segue.identifier!)
        }
        
    }
    
    
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }

}
