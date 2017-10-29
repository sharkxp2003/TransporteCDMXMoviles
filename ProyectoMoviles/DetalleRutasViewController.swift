//
//  DetalleRutasViewController.swift
//  ProyectoMoviles
//
//  Created by Daniela Martín on 29/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit


class DetalleRutasViewController: UIViewController {
    
    var nombre:String="N1"
    @IBOutlet weak var rutaName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        rutaName.text = nombre
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
