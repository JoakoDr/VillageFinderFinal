//
//  VCSelectImg.swift
//  rural
//
//  Created by JOAQUIN DIAZ RAMIREZ on 24/4/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import MapKit
import CoreLocation

class VCSelectImg: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,MKMapViewDelegate, CLLocationManagerDelegate,DataHolderDelegate,UIGestureRecognizerDelegate {
    @IBOutlet var imgSub:UIImageView?
    @IBOutlet var btnSalir:UIButton?
    @IBOutlet var txtDescripcion:UITextView?
    @IBOutlet var txtProvincia:NuevoTextField?
    @IBOutlet var txtPoblacion:NuevoTextField?
    @IBOutlet var btnAñadirUbicacion:UIButton?
     @IBOutlet var btnGaleria:UIButton?
     @IBOutlet var btnCamara:UIButton?
    @IBOutlet var vistaRedonda:UIView?
    @IBOutlet var lblError:UILabel?
    

    var downloadURL = ""
    
    let imagePicker = UIImagePickerController()
    let alert:UIAlertController = UIAlertController(title: "Subir foto de perfil", message:  "¡Has subido tu imagen!", preferredStyle: UIAlertControllerStyle.actionSheet)
    let alert1:UIAlertController = UIAlertController(title: "Perfil Subido", message:  "¡Has subido tu perfil!", preferredStyle: UIAlertControllerStyle.actionSheet)
    let alert2:UIAlertController = UIAlertController(title: "Error", message:  "¡Completa todos los campos!", preferredStyle: UIAlertControllerStyle.actionSheet)
    var imgData:Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //comprobamos si se ha añadido alguna ubicacion, y si es asi cambiamos el texto del boton.
        if(DataHolder.sharedInstance.miPerfil.sLongitud != nil && (DataHolder.sharedInstance.miPerfil.sLatitud != nil) ){
            self.btnAñadirUbicacion?.setTitle("Modificar Ubicacion", for: .normal)
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        btnAñadirUbicacion?.layer.cornerRadius = 15
        btnGaleria?.layer.cornerRadius = 15
        btnCamara?.layer.cornerRadius = 15
        txtDescripcion?.layer.cornerRadius = 15
        imagePicker.delegate = self
        self.imgSub?.layer.cornerRadius = (self.imgSub?.frame.size.width)! / 2
        self.imgSub?.clipsToBounds = true
        self.imgSub?.layer.borderWidth = 1.0
        self.imgSub?.layer.borderColor = UIColor.white.cgColor
         self.vistaRedonda?.layer.cornerRadius = 15
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // el boton que abre la galeria para seleccionar una foto
    @IBAction func accionBotonGaleria()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
 // el boton que abre la camara para subir una foto.
    @IBAction func accionBotonCamara()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    //creamos un perfil
    @IBAction func accionBotonConfirmar()
    {
        // comprobamos que esten rellenos todos los datos que no haya nulls
        if imgData != nil && !(DataHolder.sharedInstance.miPerfil.sLongitud != nil && (self.txtDescripcion?.text?.isEmpty)! && (self.txtPoblacion?.text?.isEmpty)! && (self.txtProvincia?.text?.isEmpty)!) {
            // creamos un codigo para el nombre de la imagen y asi  asegurar que no se repita ninguna.
            let tiempoMilis:Int = Int((Date().timeIntervalSince1970 * 1000.0).rounded())
            let ruta:String = String(format: "imagenes/imagen%d.jpg", tiempoMilis)
            let imagenRef = DataHolder.sharedInstance.firStorageRef?.child(ruta)
            let metadata =  StorageMetadata()
            metadata.contentType = "image/jpeg"
            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = imagenRef?.putData(imgData!, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata
        else {
            
                return
             }
                //convertimos la url a string
                let downloadURL = metadata.downloadURL()
                self.downloadURL = (downloadURL?.absoluteString)!
              
             //  pasamos todos los datos a mi perfil.
                DataHolder.sharedInstance.miPerfil.sDescripcion=self.txtDescripcion?.text
                DataHolder.sharedInstance.miPerfil.sProvincia=self.txtProvincia?.text
                DataHolder.sharedInstance.miPerfil.sPoblacion=self.txtPoblacion?.text
                DataHolder.sharedInstance.miPerfil.sImagen = self.downloadURL
                DataHolder.sharedInstance.savePerfil()
                self.performSegue(withIdentifier: "tregistro", sender: self)
                self.present(self.alert1, animated: true)
                
            }
        
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        // convertimos la imagen a jpg
        imgData = UIImageJPEGRepresentation(img!, 1)!
        imgSub?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)

    }
   

}


