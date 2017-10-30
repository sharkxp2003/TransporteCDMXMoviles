//
//  SeleccionRutaViewController.swift
//  ProyectoMoviles
//
//  Created by Alex on 30/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit

class SeleccionRutaViewController: UITableViewController, UISearchResultsUpdating  {

    

    let serverData="http://199.233.252.86/201713/printf/rutas.json"
    var datosFiltrados = [Any]()
    let searchController = UISearchController(searchResultsController: nil)
    var indice = 0
    //var objetoRuta = [String:Any]()
    var nombreRuta = String()
    let decoder = JSONDecoder()
    var rutas:Rutas!
    var coleccionRutasObject:[ObjectRutas] = [ObjectRutas]()
    var algo:String = "AAA"
    
    
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
    
    func jsonToObject (rutas: Rutas) -> [ObjectRutas] {
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: serverData)
        let datosJSON = try! Data(contentsOf: url!, options : [])
        rutas = try! decoder.decode(Rutas.self, from:datosJSON)
        
        coleccionRutasObject = jsonToObject(rutas: rutas)
        
        
        //usar la vista actual para presentar los resultados de la búsqueda
        searchController.searchResultsUpdater = self
        
        //controlar el background de los datos al momento de hacer la búsqueda
        searchController.dimsBackgroundDuringPresentation = false
        
        //manejar la barra de navegación durante la busuqeda
        searchController.hidesNavigationBarDuringPresentation = false
        
        //Definir el contexto de la búsqueda
        definesPresentationContext = true
        
        //Instalar la barra de búsqueda en la cabecera de la tabla
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            datosFiltrados = rutas.rutas;
        } else {
            datosFiltrados = rutas.rutas.filter {
                let nombreRuta=$0.nombre;
                return(nombreRuta.lowercased().contains(searchController.searchBar.text!.lowercased()))
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // remplazar el uso de nuevoArray por datosFiltrados
        return (rutas.rutas.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntradaRuta", for: indexPath)
        let ruta = rutas.rutas[indexPath.row]
        cell.textLabel?.text = "     "+ruta.ruta+" "+ruta.nombre
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Verificar si la vista actual es la de búsqueda
        if (self.searchController.isActive) {
            indice = indexPath.row

        }
            //sino utilizar la vista sin filtro
        else {
            indice = indexPath.row
            //objetoRuta = datosFiltrados[indice]
        }
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        let sigVista=segue.destination as! DetalleRutasViewController
        //let nombre:String = rutas.rutas[tableView.indexPathForSelectedRow!.row].nombre
        
        print(coleccionRutasObject[tableView.indexPathForSelectedRow!.row].getNombreRuta());
        print(indice)
        sigVista.setRuta(objectRuta: coleccionRutasObject[tableView.indexPathForSelectedRow!.row])
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    



}
