//
//  ARLocationViewController.swift
//  ProyectoMoviles
//
//  Created by Alex on 26/11/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation
import ARKit

class ARLocationViewController: UIViewController {
    var sceneLocationView = SceneLocationView()
    var ruta:ObjectRutas!
    var auxRuta:ObjectRutas!
    
    
    
    let url = "http://199.233.252.86/201713/printf/rutasPrueba.json"
    var jsonParser:JsonParser!
    
    @IBOutlet weak var viewAR: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sceneLocationView.run()
        
        jsonParser = JsonParser(serverData:url)
        ruta = jsonParser.rutaJsonToObject()
        
        for parada in ruta.getParadasDeRuta() {
            var latitud = parada.direccion.latitud
            var longitud = parada.direccion.longitud
            var location = CLLocation(latitude:latitud,longitude:longitud)
            let image = UIImage(named:"pin")!
           // var annotationNode = LocationAnnotationNode(
            var annotationNode = LocationAnnotationNode(location: location, image:image)
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        }
        
        viewAR.addSubview(sceneLocationView)
    }
    

    @IBAction func screenshot(_ sender: UIButton) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
    }
    
 
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    
    
    func setRuta(ruta : ObjectRutas) {
        self.auxRuta = ruta
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        //let sigVista=segue.destination as! DetalleRutasViewController
        if (segue.identifier == "backAR") {
            let sigVistaAux = segue.destination as! UITabBarController
            let nav = sigVistaAux.viewControllers![0] as! DetalleRutasViewController
            
            nav.setRuta(objectRuta: auxRuta)
        }
        
        
    }
    
}

