//
//  TextViewController.swift
//  TNTAdmin
//
//  Created by MacBook Pro on 31/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var menubutton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        sideout_menu()
    }
    
    func sideout_menu()
    {
        if revealViewController() != nil
        {
            menubutton.target = revealViewController()
            menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = self.view.frame.width * 0.75
                //275  160
            //
            revealViewController()?.rightViewRevealWidth = self.view.frame.width * 0.25
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
        
    }
   

}
