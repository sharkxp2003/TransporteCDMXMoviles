//
//  RoutesViewController.swift
//  ProyectoMoviles
//
//  Created by Daniela Martín on 29/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit

class RoutesViewController: UITableViewController {
    
    let serverData="http://199.233.252.86/201713/printf/ruta.json"
    
    var dataArray:[Any]?
    
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
        // #warning Incomplete implementation, return the number of rows
        //return datos.count
        
        //paso 5 remplazar el uso de datos por nuevoArray
        return (dataArray?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntradaRuta", for: indexPath)
        
        // Configure the cell...
        //cell.textLabel?.text = datos[indexPath.row]
        //paso 6 remplazar el uso de datos por nuevoArray
        //objeto marca es un diccionario que contiene marca y agencias
        let nombreRuta = dataArray?[indexPath.row] as! [String: Any]
        let s:String = nombreRuta["nombre"] as! String
        
        cell.textLabel?.text=s
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let siguienteVista = segue.destination as! DetalleRutasViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
        //paso 7 remplazar el uso de datos por nuevoArray
        //objeto marca es un diccionario que contiene marca y agencias
        let objetoRuta = dataArray?[indice!] as! [String: Any]
        let s:String = objetoRuta["nombre"] as! String
        
        siguienteVista.nombre = s
    }
    
    
    
}


