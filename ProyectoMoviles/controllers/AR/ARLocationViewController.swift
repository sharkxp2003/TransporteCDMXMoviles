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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    
    
    func setRuta(ruta : ObjectRutas) {
        self.ruta = ruta
    }
    
}

