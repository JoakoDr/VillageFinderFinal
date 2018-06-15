//
//  VCMapa.swift
//  rural
//
//  Created by JOAQUIN DIAZ RAMIREZ on 17/4/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class VCMapa: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate,DataHolderDelegate,UIGestureRecognizerDelegate {
    @IBOutlet var btnSalir:UIButton?
    @IBOutlet var mapa:MKMapView?
    var locationManager:CLLocationManager?
    var booleano = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //creamos el objeto
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        mapa?.showsUserLocation = true
        //llamamos al metodo descargarColeccion para descargarnos los datos del pueblo
        DataHolder.sharedInstance.descargarColeccion(delegate: self)
    }
    //añadimos la longitud y la latitud del pueblo por parametro.
    func agregarPin(latitude lat:Double, longitude lon:Double, titulo tpin:String)
    {
        let annotation:MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate.latitude = lat
        annotation.coordinate.longitude = lon
        annotation.title = tpin
        mapa?.addAnnotation(annotation)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //el booleano siempre que entras es falso para que establezca en tu localización.
        if(booleano == false){
            let miSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let tempRegion:MKCoordinateRegion = MKCoordinateRegion(center: locations[0].coordinate, span: miSpan)
                mapa?.setRegion(tempRegion, animated: false)
                booleano = true
        }
        
    }
    //agregamos un pin en cada pueblo haciendo uso del protocolo dhd
    func DHDdescargaCiudades(blFin: Bool) {
        
        if(blFin)
        {
            for pueblo in DataHolder.sharedInstance.arCiudades {
                agregarPin(latitude: pueblo.sLatitud!, longitude: pueblo.sLongitud!, titulo: pueblo.sNombre!)
            }
            print("me he descargado mapa")
        }else {
            print("error")
        }
    }
    
}
