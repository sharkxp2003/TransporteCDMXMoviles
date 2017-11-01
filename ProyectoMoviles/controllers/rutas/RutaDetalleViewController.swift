//
//  RutaDetalleViewController.swift
//  ProyectoMoviles
//
//  Created by Daniela Martín on 29/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit

class RutaDetalleViewController: UIViewController {

    @IBOutlet weak var nombre: UILabel!
    var name:String = "Balderas"
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nombre.text = name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func compartir(_ sender: Any) {
        
        let texto="¡Estoy en la parada Miranda!. Sigue mi ruta en:"
        let liga="http://199.233.252.86/201713/printf/rutas.json"
        if let imagen2:UIImage=UIImage(named:"shareImage")!
        {
            let objetos:[AnyObject]=[texto as AnyObject,liga as AnyObject,imagen2]
            
            let actividad=UIActivityViewController(activityItems: objetos,applicationActivities: nil)
            
            actividad.excludedActivityTypes=[UIActivityType.mail]
            self.present(actividad,animated:true, completion:nil)
        }
        
    }

}
