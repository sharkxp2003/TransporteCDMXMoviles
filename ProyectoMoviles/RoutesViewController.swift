//
//  RoutesViewController.swift
//  ProyectoMoviles
//
//  Created by Daniela Martín on 29/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit

class RoutesViewController: UITableViewController, UISearchResultsUpdating {
    
    let serverData="http://199.233.252.86/201713/printf/ruta.json"
    
    var dataArray:[Any]?
    var datosFiltrados = [Any]()
    let searchController = UISearchController(searchResultsController: nil)
    
    //UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        // si la caja de búsuqeda es vacía, entonces mostrar todos los resultados
        if searchController.searchBar.text! == "" {
            datosFiltrados = dataArray!
        } else {
            // Filtrar los resultados de acuerdo al texto escrito en la caja que es obtenido a través del parámetro $0
            datosFiltrados = dataArray!.filter {
                let objetoRuta=$0 as! [String:Any];
                let s:String = objetoRuta["nombre"] as! String;
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }
    // funcion que convierte de JSON a Array
    func JSONParseArray(_ string: String) -> [AnyObject]{
        if let data = string.data(using: String.Encoding.utf8){
            
            do{
                
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                
                print("error")
                //handle errors here
                
            }
        }
        return [AnyObject]()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: serverData)
        let datosJSON = try? Data(contentsOf: url!)
        dataArray = try! JSONSerialization.jsonObject(with: datosJSON!) as? [Any]
        datosFiltrados = dataArray!
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // remplazar el uso de nuevoArray por datosFiltrados
        return (datosFiltrados.count)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntradaRuta", for: indexPath)
        
        let ruta = datosFiltrados[indexPath.row] as! [String: AnyObject]
      
        let sN:String = ruta["ruta"] as! String
        let s:String = ruta["nombre"] as! String
        
        cell.textLabel?.text = "     "+sN+" "+s
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let siguienteVista = segue.destination as! DetalleRutasViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
        //paso 7 remplazar el uso de datos por nuevoArray
        //objeto marca es un diccionario que contiene marca y agencias
        let objetoRuta = dataArray?[indice!] as! [String: Any]
        let s:String = objetoRuta["nombre"] as! String
        
        siguienteVista.nombre = s
    }*/
    
    //crear la funcion disSelectRow
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indice = 0
        var objetoRuta = [String:Any]()
        //crear un identificador para el controlador de vista a nivel detalle
        let siguienteVista = self.storyboard?.instantiateViewController(withIdentifier: "Detalle") as! DetalleRutasViewController
        //Verificar si la vista actual es la de búsqueda
        if (self.searchController.isActive)
        {
            indice = indexPath.row
            objetoRuta = datosFiltrados[indice] as! [String: Any]
            
        }
            //sino utilizar la vista sin filtro
        else
        {
            indice = indexPath.row
            objetoRuta = dataArray![indice] as! [String: Any]
        }
        let s:String = objetoRuta["nombre"] as! String
        
        siguienteVista.nombre = s
        self.navigationController?.pushViewController(siguienteVista, animated: true)
        
    }
    
    
    
}


