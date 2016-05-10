//
//  preguntaViewController.swift
//  AppConjuntos
//
//  Created by
//   Jose Gzz
//   Israel Hernandez
//   Martha Benavides
//   on 4/5/16.
//  Copyright © 2016 Israel . All rights reserved.
//

import UIKit

class preguntaViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    
    var ejercicio = Ejercicio()
    
    @IBOutlet weak var btnRojo: UIButton!
    @IBOutlet weak var btnNaranja: UIButton!
    @IBOutlet weak var btnAmarillo: UIButton!
    @IBOutlet weak var btnVerde: UIButton!
    @IBOutlet weak var btnAzul: UIButton!
    @IBOutlet weak var btnMorado: UIButton!
    @IBOutlet weak var btnCafe: UIButton!
    @IBOutlet weak var imgConjunto: UIImageView!

    @IBOutlet weak var bFinalizar: UIButton!
    @IBOutlet weak var bCalificar: UIButton!
    @IBOutlet weak var bRespuesta1: UIButton!
    @IBOutlet weak var bRespuesta2: UIButton!
    @IBOutlet weak var bRespuesta3: UIButton!
    @IBOutlet weak var bRespuesta4: UIButton!
 
    @IBOutlet weak var lbPregunta: UILabel!
    
    var sTema : String = "todos"
    var posY: CGFloat = 0
    
    var bAlerta : Bool = false
    
    var iCorrectas : Int = 0 // Respuestas correctas
    var iTotal : Int = 0 // Total de preguntas
    var iPregunta : Int = 0 // Numero de pregunta (hasta 3 en este caso por que solo hay 3 preguntas)
    var sRespuestaSeleccionada : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ejercicio.setTema(sTema)
        nuevaPregunta() // Inicia cargando la pregunta
        posY = CGFloat(Float(bRespuesta1.frame.maxY)/2)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Funcion que despliega una nueva pregunta en pantalla
    func nuevaPregunta(){
        
        iPregunta += 1
        
        if iPregunta == 3 {
            iPregunta = 0
        }
    
        resetRespuestas()
        
        ejercicio.comenzar()
        
        lbPregunta.text = ejercicio.getPreguntas()
        
        // Obtiene numero aleatorio para asignarle al boton la respuesta correcta
        
        let randomCorrecta = arc4random_uniform(4)   // Obtiene del 0-3
        
        
        if randomCorrecta == 0 {
            bRespuesta1.setTitle(ejercicio.getRespuestaCorrecta(), forState: .Normal)
        }
        
        if randomCorrecta == 1 {
            bRespuesta2.setTitle(ejercicio.getRespuestaCorrecta(), forState: .Normal)
        }
        
        if randomCorrecta == 2 {
            bRespuesta3.setTitle(ejercicio.getRespuestaCorrecta(), forState: .Normal)
        }
        if randomCorrecta == 3 {
            bRespuesta4.setTitle(ejercicio.getRespuestaCorrecta(), forState: .Normal)
        }
        
        //Incorrecta1
        var randomInc1 = arc4random_uniform(4)  // Obtiene 0-3
        
        while randomInc1 == randomCorrecta {
            randomInc1 = arc4random_uniform(4)
        }
        
        if randomInc1 == 0{
            bRespuesta1.setTitle(ejercicio.getRespuestaIncorrecta1(), forState: .Normal)
        }
        if randomInc1 == 1{
            bRespuesta2.setTitle(ejercicio.getRespuestaIncorrecta1(), forState: .Normal)
            
        }
        if randomInc1 == 2{
            bRespuesta3.setTitle(ejercicio.getRespuestaIncorrecta1(), forState: .Normal)
        }
        if randomInc1 == 3{
            bRespuesta4.setTitle(ejercicio.getRespuestaIncorrecta1(), forState: .Normal)
        }
        
        
        
        
        //Incorrecta2
        var randomInc2 = arc4random_uniform(4)  // Obtiene 0-3
        
        while randomInc2 == randomCorrecta || randomInc2 == randomInc1   {
            randomInc2 = arc4random_uniform(4)
        }
        
        if randomInc2 == 0{
            bRespuesta1.setTitle(ejercicio.getRespuestaIncorrecta2(), forState: .Normal)
        }
        if randomInc2 == 1{
            bRespuesta2.setTitle(ejercicio.getRespuestaIncorrecta2(), forState: .Normal)
            
        }
        if randomInc2 == 2{
            bRespuesta3.setTitle(ejercicio.getRespuestaIncorrecta2(), forState: .Normal)
        }
        if randomInc2 == 3{
            bRespuesta4.setTitle(ejercicio.getRespuestaIncorrecta2(), forState: .Normal)
        }
        
        
        //Incorrecta3
        var randomInc3 = arc4random_uniform(4)  // Obtiene 0-3
        
        while randomInc3 == randomCorrecta || randomInc3 == randomInc1 || randomInc3 == randomInc2   {
            randomInc3 = arc4random_uniform(4)
        }
        
        if randomInc3 == 0{
            bRespuesta1.setTitle(ejercicio.getRespuestaIncorrecta3(), forState: .Normal)
        }
        if randomInc3 == 1{
            bRespuesta2.setTitle(ejercicio.getRespuestaIncorrecta3(), forState: .Normal)
            
        }
        if randomInc3 == 2{
            bRespuesta3.setTitle(ejercicio.getRespuestaIncorrecta3(), forState: .Normal)
        }
        if randomInc3 == 3{
            bRespuesta4.setTitle(ejercicio.getRespuestaIncorrecta3(), forState: .Normal)
        }
        
        
    }
    
    func calificar(){
        
        
        iTotal += 1 // Aumenta total de preguntas contestadas
        
        // Checa si la pregunta esta correcta y despliega una pequena explicacion de la pregunta
        if (sRespuestaSeleccionada == ejercicio.getRespuestaCorrecta()){
            iCorrectas += 1
            let alerta = UIAlertController(title: "¡Respuesta correcta! :)", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
            alerta.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.Default,handler: {
                action ->Void in
                self.nuevaPregunta()
                }))
            
            self.presentViewController(alerta, animated: true, completion: nil)
            
            
        }else {
            let alerta = UIAlertController(title: "Respuesta incorrecta :( ", message:"Respuesta correcta: " + ejercicio.getRespuestaCorrecta(), preferredStyle: UIAlertControllerStyle.Alert)
            
            alerta.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.Default, handler: {
                action ->Void in
                self.nuevaPregunta()
            }))
            
            self.presentViewController(alerta, animated: true, completion: nil)
            
            
        }
        
         sRespuestaSeleccionada = ""
        
     
        
        
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
    
    @IBAction func presionaCalifica(sender: AnyObject) {
        if sRespuestaSeleccionada == ""
        {
            let alerta = UIAlertController(title: "Selecciona una Respuesta", message: "Para poder calificar necesitas seleccionar una respuesta", preferredStyle: UIAlertControllerStyle.Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }
        else
        {
            calificar()
        }
    }

    
    @IBAction func seleccionaRespuesta(sender: UIButton) {
        
        // Pone en blanco las otras respuestas, en caso de que haya seleccionado una anteriormente
        resetRespuestas()
        
        // Pone en color rojo la respuesta seleccionada
        sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        
        // Copia el texto del boton a la variable respuesta seleccionada
        sRespuestaSeleccionada = (sender.titleLabel?.text)!
        
        if sender.titleLabel!.willBeTruncated() {
            performSegueWithIdentifier("respuesta", sender: nil)
        }
        
    }
    
    @IBAction func verUniverso(sender: AnyObject) {
        performSegueWithIdentifier("verUniverso", sender: nil)
    }
    // Deselecciona todas las respuestas
    func resetRespuestas(){
        bRespuesta1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        bRespuesta2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        bRespuesta3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        bRespuesta4.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let id : String = segue.identifier!
        if id == "fin" {
            let view = segue.destinationViewController as! resultadosViewController
            view.sScore = "\(iCorrectas) / \(iTotal)"
        }
        else if id == "respuesta"{
            
            
            
            let vc = segue.destinationViewController as! popOverViewController
            let controller = vc.popoverPresentationController
            
            if let _controller = controller {
                //set anchor and remove arrow
            
                _controller.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds), 0, posY)
                
                _controller.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
            }
            
            
            if controller != nil
            {
                controller?.delegate = self
            }
            
            vc.texto = sRespuestaSeleccionada
        }
        else if segue.identifier == "verUniverso"{
            let vc = segue.destinationViewController as! popOverViewController
            let controller = vc.popoverPresentationController
            
            if let _controller = controller {
                //set anchor and remove arrow
                
                _controller.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds), 0, posY)
                
                _controller.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
            }
            
            
            if controller != nil
            {
                controller?.delegate = self
            }
            
            vc.texto = "U = " + Globales.conUniverso.getTextoElementos()
        }
        else {
            let vc = segue.destinationViewController as! popOverViewController
            let controller = vc.popoverPresentationController
            
            if controller != nil
            {
                controller?.delegate = self
            }
            vc.texto = ejercicio.getConjuntoTexto(id)
        }
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }

}

// Funcion para saber si el label esta truncado
// obtenida de http://stackoverflow.com/questions/28920717/check-for-truncation-in-uilabel-ios-swift
extension UILabel {
    func willBeTruncated() -> Bool {
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.bounds.width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        if label.frame.height > self.frame.height {
            return true
        }
        return false
    }
}
