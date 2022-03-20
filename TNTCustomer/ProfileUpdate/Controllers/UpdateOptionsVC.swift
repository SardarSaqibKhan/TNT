//
//  UpdateOptionsVC.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 03/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class UpdateOptionsVC: UIViewController {

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var interestButton: UIButton!
    @IBOutlet weak var goalsButton: UIButton!
    @IBOutlet weak var organizationButton: UIButton!
    @IBOutlet weak var socialMediaButton: UIButton!
    @IBOutlet weak var tntCommitteButton: UIButton!
    @IBOutlet weak var menubutton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        settingCustomDesgning()
    }
    
    @IBAction func sideMenu(_ sender: Any) {
    }
    
    @IBAction func profile(_ sender: Any) {
    }
    
    @IBAction func interest(_ sender: Any) {
    }
    
    @IBAction func goals(_ sender: Any) {
    }
    
    @IBAction func organization(_ sender: Any) {
    }
    
    @IBAction func socialMedia(_ sender: Any) {
    }

    @IBAction func tntCommittees(_ sender: Any) {
    }
    
    
}

/////////////////////////       SETTING ALL DESGNING STUFF      //////////////////////////
extension UpdateOptionsVC{
    func settingCustomDesgning(){
        profileButton.updationButtons()
        interestButton.updationButtons()
        goalsButton.updationButtons()
        organizationButton.updationButtons()
        socialMediaButton.updationButtons()
        tntCommitteButton.updationButtons()
        sideout_menu()
    }
}
///////////////////////   SIDE OUT MENU /////////////////////////////////
extension UpdateOptionsVC{
    func sideout_menu()
    {
        if revealViewController() != nil
        {
            menubutton.target = revealViewController()
            menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = self.view.frame.width * 0.75
            //275  160
            revealViewController()?.rightViewRevealWidth = self.view.frame.width * 0.25
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
        
    }
}
