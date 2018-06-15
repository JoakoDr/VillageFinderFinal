//
//  VCPulsaTabla.swift
//  rural
//
//  Created by JOAQUIN DIAZ RAMIREZ on 22/5/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit

class VCPulsaTabla: UIViewController {
    @IBOutlet var imgRepresentada:UIImageView?
    @IBOutlet var btnVolver:UIButton?
    @IBOutlet var lblTitle:UILabel?
    @IBOutlet var lblProvincia:UILabel?
    @IBOutlet var rightBarButton: UIButton!
      @IBOutlet var vistaRedonda:UIView?
      // favoritos.
    @IBAction func buttonTapped(sender : UIButton!) {
        
        
        if( sender.isSelected==true)
        {
           sender.isSelected=false;
            
        } else
        {
            sender.isSelected=true;
            if (sender.isSelected){
            DataHolder.sharedInstance.varFav=true;
            print(DataHolder.sharedInstance.varFav)
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EL INDICE DEL ELEMENTO SELCCIONADO ES!!!! :",DataHolder.sharedInstance.indicePueblo)
        let nombre = DataHolder.sharedInstance.arCiudades[DataHolder.sharedInstance.indicePueblo].sNombre
        vistaRedonda?.layer.cornerRadius = 15
        let provincia = DataHolder.sharedInstance.arCiudades[DataHolder.sharedInstance.indicePueblo].sDescripcion
        let url = DataHolder.sharedInstance.arCiudades[DataHolder.sharedInstance.indicePueblo].sImagen
        lblTitle?.text = nombre
        lblProvincia?.text = DataHolder.sharedInstance.arCiudades[DataHolder.sharedInstance.indicePueblo].sDescripcion
        imgRepresentada?.image = DataHolder.sharedInstance.hmImagenes[url!]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
