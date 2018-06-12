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
    static let sharedInstance:DataHolder = DataHolder()
    
    var numeroCeldas:UInt=6;
    var firDataBasRef: DatabaseReference!
    //var arpueblos
    
    
    var firestoreDB:Firestore?
    var firStorage:Storage?
    var firStorageRef:StorageReference?
    var arCiudades:[Perfil] = []
    //var arPueblos:[pueblos] = [] 
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
    func registrarse(user: String, password:String, password2:String,Nombre:String , delegate: DataHolderDelegate){
        var blFinRegistro:Bool = false
        print(user)
        print(Nombre)
        if ( !user.isEmpty && !password.isEmpty && !password2.isEmpty && !password.isEmpty)  {
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
        } else
        {
            
        }
        
    }

    func savePerfil() {
        self.firestoreDB?.collection("perfiles").document((firUser?.uid)!).setData(self.miPerfil.getMap()) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID:")
            }
        }
    }
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

@objc protocol DataHolderDelegate{
    
    @objc optional func DHDdescargaCiudades(blFin:Bool)
    @objc optional func DHDregistro(blFinRegistro:Bool)
    @objc optional func DHDlogin(blFinLogin:Bool)
}

