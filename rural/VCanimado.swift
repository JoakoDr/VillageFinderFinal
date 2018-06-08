//
//  VCanimado.swift
//  rural
//
//  Created by MacMini on 21/5/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit

class VCanimado: UIViewController,UIScrollViewDelegate {
    @IBOutlet var vistaMenu:UIView?
    var FrmAnimacionMenuAppear:CGRect?
    var FrmAnimacionMenuClosed:CGRect?
    @IBOutlet var scrollView:UIScrollView?
    @IBOutlet var PageControl:UIPageControl?
    var contentWidth:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FrmAnimacionMenuClosed = vistaMenu?.frame
        FrmAnimacionMenuAppear = vistaMenu?.frame
        FrmAnimacionMenuAppear?.origin.x = 0
        FrmAnimacionMenuClosed?.origin.x = -150
        scrollView?.delegate = self
        for image in 0...2
        {
           let imageT = UIImage(named: "\(image).png")
            let imageView = UIImageView(image: imageT)
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
            contentWidth += view.frame.width
            scrollView?.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate-170, y:(0) + 25 , width: 300 , height: 300 )
        }
        // Do any additional setup after loading the view.
        scrollView?.contentSize = CGSize(width: contentWidth+50, height: 200)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Tienes que modificar estos valores para que el scroll salga correcto.
        PageControl?.currentPage = Int(scrollView.contentOffset.x+150 / CGFloat(375))
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
