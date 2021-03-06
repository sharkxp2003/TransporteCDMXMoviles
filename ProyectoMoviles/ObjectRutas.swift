//
//  Rutas.swift
//  ProyectoMoviles
//
//  Created by Alex on 30/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import Foundation


class ObjectRutas {
    
    var id:Int
    var ruta:String
    var nombre:String
    var paradas:[ObjectParada]
    
    init(ruta: DetalleRutasViewController.Ruta, paradas: [ObjectParada]) {
        id = ruta.id
        self.ruta = ruta.ruta
        nombre = ruta.nombre
        self.paradas = paradas
    }
    
    init(ruta: SeleccionRutaViewController.Ruta, paradas: [ObjectParada]) {
        id = ruta.id
        self.ruta = ruta.ruta
        nombre = ruta.nombre
        self.paradas = paradas
    }
    
    func getRuta() -> String {
        return ruta
    }
    
    func getNombreRuta() -> String {
        return nombre
    }
    
    func getIdRuta() -> Int {
        return id
    }
    
    func getParadasDeRuta() -> [ObjectParada] {
        return paradas
    }
    
    
}



