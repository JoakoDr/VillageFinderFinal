//
//  VCanimado.swift
//  rural
//
//  Created by MacMini on 21/5/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit

class VCanimado: UIViewController {
    @IBOutlet var vistaMenu:UIView?
    var FrmAnimacionMenuAppear:CGRect?
    var FrmAnimacionMenuClosed:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FrmAnimacionMenuClosed = vistaMenu?.frame
        FrmAnimacionMenuAppear = vistaMenu?.frame
        FrmAnimacionMenuClosed?.origin.x = -150
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func accionBotonMenu(){
        print("!!!!!!!!!!!!!")
        UIView.animate(withDuration: 0.5, delay: 0.1, options:
            UIViewAnimationOptions.curveEaseInOut, animations:{ () -> Void in
                self.vistaMenu?.frame = self.FrmAnimacionMenuAppear!
        }, completion: {(finished) -> Void in })
        
    }
    
    @IBAction func accionBotoncerrarMenu(){
        UIView.animate(withDuration: 0.5, delay: 0.1, options:
            UIViewAnimationOptions.curveEaseInOut, animations:{ () -> Void in
                self.vistaMenu?.frame = self.FrmAnimacionMenuClosed!
        }, completion: {(finished) -> Void in })
        
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
