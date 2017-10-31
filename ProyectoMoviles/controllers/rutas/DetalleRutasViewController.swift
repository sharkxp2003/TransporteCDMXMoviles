//
//  DetalleRutasViewController.swift
//  ProyectoMoviles
//
//  Created by Daniela Martín on 29/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit



class DetalleRutasViewController: UIViewController {
    
    let serverData="http://199.233.252.86/201713/printf/rutaDetalle.json"
    let decoder = JSONDecoder()
    
    struct Direccion:Codable {
        let calle:String
        let colonia:String
        let delegacion:String
        let ciudad:String
        let cp:String
        let latitud:Double
        let longitud:Double
    }
    
    struct Parada:Codable {
        let id:Int
        let linea:String
        let inicio:String
        let nombreParada:String
        let noAutobus:String
        let direccion:Direccion
        let capacidadMax:Int
        
    }
    
    struct Ruta:Codable {
        let id:Int
        let ruta:String
        let nombre:String
        let paradas:[Parada]
    }
    
    struct Rutas:Codable {
        let rutas:[Ruta]
    }
    
    
    
    var nombre:String = "placeholder"
    var ruta:ObjectRutas!
    var paradas:[ObjectParada] = [ObjectParada]()
    var auxRuta:Ruta!
    
   // var arrayParadas:[String] = [String](repeating: "", count: 3)
    var arrayParadas : [String] = []
    
    @IBOutlet weak var rutaName: UILabel!
 
    @IBOutlet weak var parada1: UILabel!
    
    @IBOutlet weak var parada2: UILabel!
    
    @IBOutlet weak var parada3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      print(paradas.count)
        let url = URL(string: serverData)
        let datosJSON = try! Data(contentsOf: url!, options : [])

       auxRuta = try! decoder.decode(Ruta.self, from:datosJSON)
        
        rutaName.text = ruta == nil ? auxRuta.nombre : ruta.getNombreRuta()
        
    //    parada1.text = paradas[0]
        
            for parada in paradas{
                arrayParadas = [parada.nombreParada]
             
           }

        for (index, parada) in paradas.enumerated() {
            let label : UILabel = self.view.viewWithTag(index) as! UILabel
            label.text = parada.getNombreParada()
          
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setNombre(name:String) {
        nombre = name
    }
    
    func setRuta(objectRuta:ObjectRutas) {
        self.ruta = objectRuta
        
    }
    
    func setParada(objectParada:ObjectParada){
    
        self.paradas = [objectParada]
    }

}
