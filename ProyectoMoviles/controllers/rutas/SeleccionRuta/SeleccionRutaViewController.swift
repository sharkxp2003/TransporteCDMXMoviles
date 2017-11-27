//
//  SeleccionRutaViewController.swift
//  ProyectoMoviles
//
//  Created by Alex on 30/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit

class SeleccionRutaViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    

    let serverData="http://199.233.252.86/201713/printf/rutas.json"
    let textCellIdentifier = "textCell"
    var datosFiltrados = [ObjectRutas]()
    let searchController = UISearchController(searchResultsController: nil)
    var indice = 0
    var nombreRuta = String()
    var coleccionRutasObject:[ObjectRutas] = [ObjectRutas]()
    var algo:String = "AAA"
    var jsonParser:JsonParser!
    
    @IBOutlet weak var tableView: UITableView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParser = JsonParser(serverData: serverData)
        
        tableView.delegate = self
        tableView.dataSource = self

        coleccionRutasObject = jsonParser.rutasJsonToObject()
        
        datosFiltrados = coleccionRutasObject
        
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
        tableView.scrollToRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, at: UITableViewScrollPosition.top, animated: false)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if (searchController.searchBar.text?.count == 0)  {
            datosFiltrados = coleccionRutasObject
            self.tableView.reloadData()
        } else {
            print(searchController.searchBar.text)
            datosFiltrados = coleccionRutasObject.filter {
                let nombreRuta=$0.nombre;
                print(nombreRuta.lowercased().contains(searchController.searchBar.text!.lowercased()))
                return(nombreRuta.lowercased().contains(searchController.searchBar.text!.lowercased()))
            }
            
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // remplazar el uso de nuevoArray por datosFiltrados
        return (datosFiltrados.count)
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! SeleccionRutaCellViewController
        let ruta = datosFiltrados[indexPath.row]
        
        
        cell.nombreRuta.text = ruta.getNombreRuta()
        cell.numeroRuta.text = ruta.ruta
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indice = indexPath.row
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        //let sigVista=segue.destination as! DetalleRutasViewController
        let sigVistaAux = segue.destination as! UITabBarController
        let nav = sigVistaAux.viewControllers![0] as! DetalleRutasViewController
        nav.setRuta(objectRuta: datosFiltrados[tableView.indexPathForSelectedRow!.row])
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    



}
