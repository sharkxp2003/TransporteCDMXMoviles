//
//  MapViewController.swift
//  ProyectoMoviles
//
//  Created by Daniela Martín on 25/11/17.
//  Copyright © 2017 alejandroCortizoFranza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000.0
        locationManager.requestWhenInUseAuthorization()
        
        
        map.mapType=MKMapType.standard
        let cl=CLLocationCoordinate2DMake(19.283996, -99.136006)
        map.region=MKCoordinateRegionMakeWithDistance(cl, 2000, 2000)
        /* //esta es otra forma de definir la región de un mapa
         let origen=CLLocationCoordinate2DMake(0.0, 0.0)
         let delta=CLLocationDegrees(0.01)
         let span=MKCoordinateSpanMake(delta, delta)
         let region=MKCoordinateRegionMake(cl, span)
         mapa.setRegion(region, animated: true)
         */
        var point = CLLocationCoordinate2D()
        point.latitude = 19.283996
        point.longitude = -99.136006
        let pin = MKPointAnnotation()
        pin.coordinate = point
        pin.title = "ITESM CCM"
        pin.subtitle = "Sur CDMX"
        map.addAnnotation(pin)
        
        
        map.showsCompass=true
        map.showsScale=true
        map.showsTraffic=true
        map.isZoomEnabled=true
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        } else {
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
