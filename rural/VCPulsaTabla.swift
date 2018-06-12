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
        var nombre = DataHolder.sharedInstance.arCiudades[DataHolder.sharedInstance.indicePueblo].sNombre
        //var lon = DataHolder.sharedInstance.arCiudades[DataHolder.sharedInstance.indicePueblo].sLongitud
        var provincia = DataHolder.sharedInstance.arCiudades[DataHolder.sharedInstance.indicePueblo].sProvincia
        var url = DataHolder.sharedInstance.arCiudades[DataHolder.sharedInstance.indicePueblo].sImagen
        lblTitle?.text = nombre
        lblProvincia?.text = provincia
        //lblLat?.text = (lat)
        //lblLong?.text = (lon)
        imgRepresentada?.image = DataHolder.sharedInstance.hmImagenes[url!]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
