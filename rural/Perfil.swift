//
//  Perfil.swift
//  rural
//
//  Created by DAVID ANGULO CORCUERA on 12/4/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit
// esta clase representa el perfil del usuario actual descargandolo de la base de datos
class Perfil: NSObject {
    
    //hay que poner todos los datos del registro
    var sNombre:String?
    var sDescripcion:String?
    var sPoblacion:String?
    var sProvincia:String?
    var sImagen:String?
    var sLongitud:Double?
    var sLatitud:Double?
    var sID:String?
    var sEmail:String?
    // pasamos el hashmap descargado de la base de datos a las variables
    
    func setMap(valores:[String:Any]){
        sNombre = valores["Nombre"] as? String
         sEmail = valores["e-mail"] as? String
        sDescripcion = valores["Descripcion"] as? String
        sPoblacion = valores["Poblacion"] as? String
        sProvincia = valores["Provincia"] as? String
        sImagen = valores["Imagen"] as? String
        sLongitud = valores["Longitud"] as? Double
        sLatitud = valores["Latitud"] as? Double
    }
    // este metodo convierte a hashmap los datos para guardarlos en la base de datos
    func getMap() -> [String:Any] {
        
        return [
            "Nombre": sNombre as Any,
            "sDescripcion": sDescripcion as Any,
            "Poblacion": sPoblacion as Any,
            "Provincia": sProvincia as Any,
            "Imagen": sImagen as Any,
            "Longitud": sLongitud as Any,
            "Latitud": sLatitud as Any,
            "e-mail": sEmail as Any
        ]
    }

}

