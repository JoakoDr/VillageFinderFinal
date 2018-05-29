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
    @IBOutlet var txtNombre:NuevoTextField?
    @IBOutlet var txtLocalizacion:NuevoTextField?
    @IBOutlet var txtProvincia:NuevoTextField?
    @IBOutlet var txtPoblacion:NuevoTextField?
    @IBOutlet var btnAñadirUbicacion:UIButton?
    

    var downloadURL = ""
    
    let imagePicker = UIImagePickerController()
    let alert:UIAlertController = UIAlertController(title: "Subir foto de perfil", message:  "¡Has subido tu imagen!", preferredStyle: UIAlertControllerStyle.actionSheet)
    let alert1:UIAlertController = UIAlertController(title: "Perfil Subido", message:  "¡Has subido tu perfil!", preferredStyle: UIAlertControllerStyle.actionSheet)
    let alert2:UIAlertController = UIAlertController(title: "Error", message:  "¡Completa todos los campos!", preferredStyle: UIAlertControllerStyle.actionSheet)
    var imgData:Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(DataHolder.sharedInstance.miPerfil.sLongitud != nil && (DataHolder.sharedInstance.miPerfil.sLatitud != nil) ){
            self.btnAñadirUbicacion?.setTitle("Modificar Ubicacion", for: .normal) //"Modificar Ubicacion")
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        imagePicker.delegate = self
        btnSalir?.layer.cornerRadius = 15
        self.imgSub?.layer.cornerRadius = (self.imgSub?.frame.size.width)! / 2
        self.imgSub?.clipsToBounds = true
        self.imgSub?.layer.borderWidth = 1.0
        self.imgSub?.layer.borderColor = UIColor.blue.cgColor
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func accionBotonGaleria()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func accionBotonCamara()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func accionBotonConfirmar()
    {
        if imgData != nil {
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
                let downloadURL = metadata.downloadURL()
                self.downloadURL = (downloadURL?.absoluteString)!//.path!
                DataHolder.sharedInstance.savePerfil()
                print("----->"+self.downloadURL)
                DataHolder.sharedInstance.miPerfil.sNombre=self.txtNombre?.text
                DataHolder.sharedInstance.miPerfil.sLocalizacion=self.txtLocalizacion?.text
                DataHolder.sharedInstance.miPerfil.sProvincia=self.txtProvincia?.text
                DataHolder.sharedInstance.miPerfil.sPoblacion=self.txtPoblacion?.text
                DataHolder.sharedInstance.miPerfil.sImagen = self.downloadURL
                print("----IMAGEN-->",self.downloadURL)
                DataHolder.sharedInstance.savePerfil()
                self.present(self.alert1, animated: true)
                
            }
        
        }
    }
    
    @IBAction func accionBotonSubir()
    {
        
        }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        imgData = UIImageJPEGRepresentation(img!, 1)!
        imgSub?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


