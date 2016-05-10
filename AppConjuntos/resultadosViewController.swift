//
//  resultadosViewController.swift
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

class resultadosViewController: UIViewController {

    @IBOutlet weak var lbScore: UILabel!
    var sScore : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbScore.text = sScore
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
