//
//  celdaPrototiopo.swift
//  rural
//
//  Created by DAVID ANGULO CORCUERA on 5/4/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit
import FirebaseStorage

class celdaPrototiopo: UITableViewCell {
    @IBOutlet var imagen:UIImageView?
    @IBOutlet var lblNombre:UILabel?
    @IBOutlet var Label:UILabel?
    
    var imagenDescargada:UIImage?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func mostrarImagen(url:String) {
        let imgdes = DataHolder.sharedInstance.hmImagenes[url]
        if(imgdes == nil){
            self.imagen?.image = nil
            let gsReference = DataHolder.sharedInstance.firStorage?.reference(forURL: url)
            gsReference?.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    print("DESCARGADO")
                    self.imagenDescargada = UIImage(data: data!)
                    self.imagen?.image = self.imagenDescargada
                    DataHolder.sharedInstance.hmImagenes[url] = self.imagenDescargada
                }
            }
            
        }
        else{
            imagen?.image = imgdes
        }
        
    }
}
