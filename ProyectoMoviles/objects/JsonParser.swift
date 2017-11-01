//
//  JsonParser.swift
//  ProyectoMoviles
//
//  Created by Alex on 01/11/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import Foundation
import UIKit

class JsonParser {
    
    let decoder = JSONDecoder()
    let serverData:String
    
    
    
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
    
    
    init(serverData: String) {
        self.serverData = serverData
    }
    
     func rutasJsonToObject () -> [ObjectRutas] {
        let url = URL(string: serverData)
        let datosJSON = try! Data(contentsOf: url!, options : [])
        let rutas = try! decoder.decode(Rutas.self, from:datosJSON)
        var coleccionRutas:[ObjectRutas] = [ObjectRutas]()
        for ruta in rutas.rutas {
            var objRuta:ObjectRutas
            var objParada:ObjectParada
            var coleccionParadas:[ObjectParada] = [ObjectParada]()
            for parada in ruta.paradas {
                var objDireccion:ObjectDireccion
                objDireccion = ObjectDireccion(direccion:parada.direccion)
                objParada = ObjectParada(parada: parada, direccion:objDireccion)
                coleccionParadas.append(objParada)
            }
            objRuta = ObjectRutas(ruta: ruta, paradas: coleccionParadas)
            coleccionRutas.append(objRuta)
        }
        return coleccionRutas
    }
    
    func rutaJsonToObject() -> ObjectRutas {
        let url = URL(string: serverData)
        let datosJSON = try! Data(contentsOf: url!, options : [])
        let ruta = try! decoder.decode(Ruta.self, from:datosJSON)
        var objRuta:ObjectRutas
        var objParada:ObjectParada
        var coleccionParadas:[ObjectParada] = [ObjectParada]()
        for parada in ruta.paradas {
            var objDireccion:ObjectDireccion
            objDireccion = ObjectDireccion(direccion:parada.direccion)
            objParada = ObjectParada(parada: parada, direccion:objDireccion)
            coleccionParadas.append(objParada)
        }
        objRuta = ObjectRutas(ruta: ruta, paradas: coleccionParadas)
        return objRuta
    }
    
    func direccionJsonToObject() -> ObjectDireccion {
        let url = URL(string: serverData)
        let datosJSON = try! Data(contentsOf: url!, options : [])
        let direccion = try! decoder.decode(Direccion.self, from:datosJSON)
        var objDireccion:ObjectDireccion
        objDireccion = ObjectDireccion(direccion: direccion)
        return objDireccion
    }
    
}
