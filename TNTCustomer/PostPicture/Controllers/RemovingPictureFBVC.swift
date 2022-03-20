//
//  RemovingPictureFBVC.swift
//  TNTPostPicture
//
//  Created by MacBook Pro on 11/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class RemovingPictureFBVC: UIViewController {

    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var thatsfineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundview.corveViewCorner()
        thatsfineButton.corveButtonCorner()
       
    }
    
    @IBAction func thatsFine(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
   

}
