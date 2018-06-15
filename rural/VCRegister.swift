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
    @IBOutlet var txtEmail:NuevoTextField?
    @IBOutlet var txtPassword2:NuevoTextField?
    @IBOutlet var txtUser:NuevoTextField?
    @IBOutlet var txtPassword:NuevoTextField?
    @IBOutlet var btnRegistro:UIButton?
    @IBOutlet var btnVolver:UIButton?
    @IBOutlet var testPassword:UILabel?
    @IBOutlet var vistaOpaca:UIView?
    @IBOutlet var lblError:UILabel?
    
    
    //implementamos la funcion dhdRegistro, para que si el dato recibido es true realice la transicion.
    func DHDregistro(blFinRegistro: Bool) {
        if blFinRegistro {
            self.performSegue(withIdentifier: "transicionregistro", sender: self)
        }
        
    }
    //al pulsar el boton continuar realizamos esta funcion.
    @IBAction func eventoClickLogin()  {
        
         DataHolder.sharedInstance.miPerfil.sEmail=txtEmail?.text
         DataHolder.sharedInstance.miPerfil.sNombre=txtUser?.text
        //comprobamos que las dos contraseñas coinciden y si es así realizamos el metodo registrarse.
        if(txtPassword?.text==txtPassword2?.text && !((txtUser?.text?.isEmpty)!) ){
             DataHolder.sharedInstance.registrarse(user: (txtEmail?.text)!, password: (txtPassword?.text)!, delegate: self)
            
            
        }
       
        else{
            lblError?.text = "Las contraseñas no coinciden"
        }
        if(txtEmail?.text?.isEmpty )! || (txtUser?.text?.isEmpty)! || (txtPassword?.text?.isEmpty)!{
            lblError?.text = "Completa todos los campos"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblError?.text = "Campos obligatorios"
        vistaOpaca?.layer.cornerRadius = 15

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}
