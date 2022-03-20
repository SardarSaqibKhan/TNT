//
//  GettingPermissionVC.swift
//  TNTPostPicture
//
//  Created by MacBook Pro on 11/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class GettingPermissionVC: UIViewController {

    
    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var gotitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundview.corveViewCorner()
        gotitButton.corveButtonCorner()
        
    }
   
    @IBAction func gotIt(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    

}
