//
//  NotificationViewController.swift
//  ProyectoMoviles
//
//  Created by Daniela Martín on 29/10/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
        
    let serverData="http://199.233.252.86/201713/printf/notificacion.json"
    let textCellIdentifier = "textCell"
        
    var dataArray:[Any]?
    var jsonParser:JsonParser!
    var coleccionNotificaciones:[ObjectNotificaciones] = [ObjectNotificaciones]()
    var prevSeg : String?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            tableView.delegate = self
            tableView.dataSource = self
        
            jsonParser = JsonParser(serverData: serverData)
            coleccionNotificaciones = jsonParser.notificacionesJsonToObject()
            print(coleccionNotificaciones[0].descripcion)

        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return coleccionNotificaciones.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! NotificationCellController
            let notificacion = coleccionNotificaciones[indexPath.row]
            
            cell.labelHora.text = notificacion.hora
            cell.labelDescripcion.text = notificacion.descripcion
            
            return cell
        }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        
        if (prevSeg == "mapController") {
            var sigVista=segue.destination as! MapViewController
        }
        
        
    }
}

