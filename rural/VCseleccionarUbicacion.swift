//
//  VCseleccionarUbicacion.swift
//  rural
//
//  Created by DAVID ANGULO CORCUERA on 22/5/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import MapKit
import CoreLocation

class VCseleccionarUbicacion: UIViewController, UINavigationControllerDelegate,MKMapViewDelegate, CLLocationManagerDelegate,DataHolderDelegate,UIGestureRecognizerDelegate  {
@IBOutlet var mapa:MKMapView?
    var Latitud:Double?
    var Longitud:Double?
    var annotation:MKPointAnnotation = MKPointAnnotation()
    @IBOutlet var btnConfirmar:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(VCseleccionarUbicacion.revealRegionDetailsWithLongPressOnMap))
        lpgr.minimumPressDuration = 0.2
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.mapa?.addGestureRecognizer(lpgr)
        // Do any additional setup after loading the view.
    }
    @objc func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: mapa)
        let locationCoordinate = mapa?.convert(touchLocation, toCoordinateFrom: mapa)
        self.Latitud = Double((locationCoordinate?.latitude)!)
        self.Longitud = Double((locationCoordinate?.longitude)!)
        print("Tapped at lat: \(Latitud) long: \(Longitud)")
        var coordTemp:CLLocationCoordinate2D = CLLocationCoordinate2D()
        coordTemp.latitude = Latitud!
        coordTemp.longitude = Longitud!
        mapa?.removeAnnotation(annotation)
        agregarPin(coordenada: coordTemp, titulo:
            "Añadir Ubicacion")
    }
    func agregarPin(coordenada:CLLocationCoordinate2D, titulo tpin:String) -> MKPointAnnotation
    {
        
        self.annotation.coordinate = coordenada
        annotation.title = tpin
        mapa?.addAnnotation(annotation)
        
        return annotation
    }
    @IBAction func accionBotonConfirmar()
    {
        DataHolder.sharedInstance.miPerfil.sLatitud=self.Latitud
        DataHolder.sharedInstance.miPerfil.sLongitud=self.Longitud
        DataHolder.sharedInstance.savePerfil()
        print("Has guardado las coordenadas!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
