//
//  TemasViewController.swift
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

class TemasViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var imagen: UIImageView!
    

    @IBOutlet weak var pickerTemas: UIPickerView!
    var pickerData: [String] = [String]()
    var temaSeleccionado : String = "todos"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.=
        
        // Conectar a pickerview
        pickerTemas.delegate = self
        pickerTemas.dataSource = self
        
        // Datos que se van a introducir al picker view
        pickerData = ["Todos los temas", "Intersección de conjuntos", "Unión de conjuntos", "Diferencia de conjuntos", "Complemento de conjuntos", "Subconjuntos"]
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
        self.view.endEditing(true)
        
        switch row {
        case 0:
            imagen.image = UIImage(named:"Logo2-1")
            temaSeleccionado = "todos"
        case 1:
            imagen.image = UIImage(named:"Inters")
            temaSeleccionado = "interseccion"
        case 2:
            imagen.image = UIImage(named:"Union")
            temaSeleccionado = "union"
        case 3:
            imagen.image = UIImage(named:"Dif")
            temaSeleccionado = "resta"
        case 4:
            imagen.image = UIImage(named:"Com")
            temaSeleccionado = "complemento"
        case 5:
            imagen.image = UIImage(named:"subconjunto")
            temaSeleccionado = "subconjunto"
        default:
            imagen.image = UIImage(named:"Logo2-1")
            temaSeleccionado = "todos"
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "comenzar"{
            let view = segue.destinationViewController as! preguntaViewController
            view.sTema = temaSeleccionado
        }
        
    }

}
