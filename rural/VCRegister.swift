//
//  VCRegister.swift
//  rural
//
//  Created by DAVID ANGULO CORCUERA on 3/4/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class VCRegister: UIViewController, DataHolderDelegate{
    // e-mail
    @IBOutlet var txtEmail:NuevoTextField?
    @IBOutlet var txtPassword2:NuevoTextField?
    @IBOutlet var txtUser:NuevoTextField?
    @IBOutlet var txtPassword:NuevoTextField?
    @IBOutlet var btnRegistro:UIButton?
    @IBOutlet var btnVolver:UIButton?
    @IBOutlet var testPassword:UILabel?
   
    
    @IBAction func eventoClickLogin()  {
        
       DataHolder.sharedInstance.miPerfil.sEmail=txtEmail?.text
        DataHolder.sharedInstance.miPerfil.sNombre=txtUser?.text
        DataHolder.sharedInstance.registrarse(user: (txtEmail?.text)!, password: (txtPassword?.text)!, delegate: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func DHDregistro(blFinRegistro: Bool) {
        if blFinRegistro {
             self.performSegue(withIdentifier: "transicionregistro", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}
