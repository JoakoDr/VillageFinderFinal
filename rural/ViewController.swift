//
//  ViewController.swift
//  rural
//
//  Created by DAVID ANGULO CORCUERA on 22/3/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController, DataHolderDelegate {
     @IBOutlet var txtUser:NuevoTextField?
     @IBOutlet var txtPassword:NuevoTextField?
     @IBOutlet var btnLogin:UIButton?
     @IBOutlet var btnregistro:UIButton?
    let alert5:UIAlertController = UIAlertController(title: "Error en tu e-mail o contraseña", message:  "¡Vuelve a intentarlo otra vez!", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    
    let alert7:UIAlertController = UIAlertController(title: "¡Se logeo correctamente!", message:  "¡Bienvenido a VillageFinder!", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    
    
   @IBAction func eventoClickLogin()  {
    DataHolder.sharedInstance.login(user: (txtUser?.text)!, password: (txtPassword?.text)!, delegate: self )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            Auth.auth().addStateDidChangeListener { (auth, user) in
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func DHDlogin(blFinLogin: Bool) {
        alert5.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert7.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if blFinLogin {
            
            
            self.performSegue(withIdentifier: "transicionlogin", sender: self)
            self.present(self.alert7, animated: true)
        }
        else
        {
            
             self.present(self.alert5, animated: true)
        }
        
    }


}

