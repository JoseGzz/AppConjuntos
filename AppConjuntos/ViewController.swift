//
//  ViewController.swift
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

class ViewController: UIViewController {
    @IBOutlet weak var imaLogo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var gif = ["logo","Logo1-1", "Logo2-1", "Logo3-1"]
        
        var images = [UIImage]()
        
        for i in 0..<gif.count{
            images.append(UIImage(named: gif[i])!)
        }
        imaLogo.animationImages = images
        imaLogo.animationDuration = 1
        imaLogo.startAnimating()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

