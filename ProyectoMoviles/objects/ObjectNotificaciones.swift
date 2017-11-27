//
//  ObjectNotificaciones.swift
//  ProyectoMoviles
//
//  Created by Alex on 27/11/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import Foundation

class ObjectNotificaciones {
    
    var id:Int
    var hora:String
    var descripcion:String
    
    init(id:Int, hora:String, descripcion:String) {
        self.id = id
        self.hora = hora
        self.descripcion = descripcion
        
    }
}
