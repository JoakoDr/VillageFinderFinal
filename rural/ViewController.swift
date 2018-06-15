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
//implementamos dataholderdelegate
class ViewController: UIViewController, DataHolderDelegate {
     @IBOutlet var txtUser:NuevoTextField?
     @IBOutlet var txtPassword:NuevoTextField?
     @IBOutlet var btnLogin:UIButton?
     @IBOutlet var btnregistro:UIButton?
    //creamos una alerta para verificar que los datos del login son correctos, y otra para dar la bienvenida al usuario
     let alert5:UIAlertController = UIAlertController(title: "Error en tu e-mail o contraseña", message:  "¡Vuelve a intentarlo otra vez!", preferredStyle: UIAlertControllerStyle.actionSheet)
     let alert7:UIAlertController = UIAlertController(title: "¡Se logeo correctamente!", message:  "¡Bienvenido a VillageFinder!", preferredStyle: UIAlertControllerStyle.actionSheet)
    //este evento se activa cuando pulsas en el boton inicar sesion, llamamos al metodo login del dataholder para que compruebe los datos del usuario con la bbdd
   @IBAction func eventoClickLogin()  {
    DataHolder.sharedInstance.login(user: (txtUser?.text)!, password: (txtPassword?.text)!, delegate: self )
    }
    override func viewDidLoad() {
        btnLogin?.layer.cornerRadius = 15
        btnregistro?.layer.cornerRadius = 15
        super.viewDidLoad()
            Auth.auth().addStateDidChangeListener { (auth, user) in
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //implementamos la funcion dhdLogin, para que si el dato recibido es true realice la transicion y mostramos las alertas correspondientes.
    func DHDlogin(blFinLogin: Bool) {
        alert5.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert7.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "transicionlogin", sender: nil)
        }))
        if blFinLogin {
    
            self.present(self.alert7, animated: true)
        }
        else
        {
            
             self.present(self.alert5, animated: true)
        }
        
    }


}

