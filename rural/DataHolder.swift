//
//  DataHolder.swift
//  rural
//
//  Created by MacMini on 9/4/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DataHolder: NSObject {
    //objeto dataholder para compartir la informacion desde todas las demas clases
    static let sharedInstance:DataHolder = DataHolder()
    var firDataBasRef: DatabaseReference!
    var firestoreDB:Firestore?
    var firStorage:Storage?
    var firStorageRef:StorageReference?
    var arCiudades:[Perfil] = []
    var miPerfil:Perfil = Perfil ()
    var hmImagenes:[String:UIImage] = [:]
    var firUser:User?
    var indicePueblo:Int = 0;
    var varFav:Bool = false;
    
    
    func initFirebase() {
        FirebaseApp.configure()
        firestoreDB=Firestore.firestore()
        firStorage = Storage.storage()
        firStorageRef = firStorage?.reference()
        
    }
    // metodo que descarga todos los datos del perfil y los mete en arrciudads.
    func descargarColeccion(delegate:DataHolderDelegate) {

        var blFin:Bool = false
        
        DataHolder.sharedInstance.firestoreDB?.collection("perfiles").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                delegate.DHDdescargaCiudades!(blFin: false)
                
            } else {
                self.arCiudades = []
                for document in querySnapshot!.documents {
                    let pueblo:Perfil = Perfil()
                    pueblo.sID=document.documentID
                    pueblo.setMap(valores: document.data())
                    self.arCiudades.append(pueblo)
                    print("\(document.documentID) => \(document.data())")
                }
                delegate.DHDdescargaCiudades!(blFin: true)
            }
            
        }
        
    }
    // metodo que sirve para registrarse 
    func registrarse(user: String, password:String ,delegate: DataHolderDelegate){
       // var blFinRegistro:Bool = false
       
            Auth.auth().createUser(withEmail:user, password:password){ (user, error) in
                    if (error == nil) {
                        self.firUser = user
                        print("Te Registraste !")
                        self.savePerfil()
                        
                        delegate.DHDregistro!(blFinRegistro: true)
                    }else
                    {
                        print(error!)
                        
                    }
            
        }
        
    }
    // guardamos los datos del objeto perfil en forma de hashmap en la coleccion perfiles.
    func savePerfil() {
        self.firestoreDB?.collection("perfiles").document((firUser?.uid)!).setData(self.miPerfil.getMap()) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID:")
            }
        }
    }
    // metodo de login
    func login(user: String, password: String, delegate: DataHolderDelegate){
        Auth.auth().signIn(withEmail: (user), password: (password)) { (user, error) in
            
        if (error == nil) {
            
            if(user != nil && password != nil){
            self.firUser = user
            let refperfiles = DataHolder.sharedInstance.firestoreDB?.collection("perfiles").document((user?.uid)!)
            refperfiles?.getDocument { (document, error) in
                if document != nil {
                    print(document?.documentID as Any)
                    DataHolder.sharedInstance.miPerfil.setMap(valores: (document?.data())!)
                    print(document?.data()! as Any)
                    delegate.DHDlogin!(blFinLogin: true)
                } else {
                    print("Document does not exist")
                    delegate.DHDlogin!(blFinLogin: false)
                }
            }
            print("Te Logeaste !")
                }
        }else
        {
            delegate.DHDlogin!(blFinLogin: false)
            //present(alert5, animated: true)
            print("error!")
            
        }
        }
    }
}
// creamos la interfaz dhd con los siguientes metodos.
@objc protocol DataHolderDelegate{
    
    @objc optional func DHDdescargaCiudades(blFin:Bool)
    @objc optional func DHDregistro(blFinRegistro:Bool)
    @objc optional func DHDlogin(blFinLogin:Bool)
}

