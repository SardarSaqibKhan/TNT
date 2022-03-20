//
//  RenewMembershipPopUpVC.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 18/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class RenewMembershipPopUpVC: UIViewController {

    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var purchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingCustomDesgning()
    }
    


}
/////////////////////////       SETTING ALL DESGNING STUFF      //////////////////////////
extension RenewMembershipPopUpVC{
    func settingCustomDesgning(){
        backgroundview.carvePopUpView()
        purchaseButton.corvePurchaseButtons()
    }
}
