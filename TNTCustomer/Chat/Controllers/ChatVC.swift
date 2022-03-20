//
//  ChatVC.swift
//  TNTChat
//
//  Created by MacBook Pro on 21/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import Firebase
import IHProgressHUD


class ChatVC: UIViewController {

    
    @IBOutlet weak var broadcastButton: UIButton!
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var membersButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var adminContainerView: UIView!
    @IBOutlet weak var memberContainerView: UIView!
    @IBOutlet weak var contactContainerView: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let seconds = 1.8
        setAllDesgning()
        adminContainerView.alpha = 1.0
        memberContainerView.alpha = 0
        contactContainerView.alpha = 0
        sendFCMToken()
        sideout_menu()
        IHProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            
            IHProgressHUD.dismiss()
        }
       
        //setupAccount();
    }
    
    func sendFCMToken(){
        if let fcmToken = UserDefaults.standard.value(forKey: "fcmToken"){
            Database.database().reference().child("User").child("3").child("FCMToken").setValue(fcmToken as! String)
        }
        else{
            print("fmc token not found...!!!")
        }
    }
    
    @IBAction func sideoutMenu(_ sender: Any) {
      
    }
    @IBAction func admin(_ sender: Any) {
        adminButton.corveSelectedButton()
        membersButton.corveUnselectedButton()
        contactButton.corveUnselectedButton()
        
        adminContainerView.alpha = 1.0
        memberContainerView.alpha = 0
        contactContainerView.alpha = 0
    }
    @IBAction func member(_ sender: Any) {
        adminButton.corveUnselectedButton()
        membersButton.corveSelectedButton()
        contactButton.corveUnselectedButton()
        
        adminContainerView.alpha = 0
        memberContainerView.alpha = 1.0
        contactContainerView.alpha = 0
    }
    @IBAction func contact(_ sender: Any) {
        adminButton.corveUnselectedButton()
        membersButton.corveUnselectedButton()
        contactButton.corveSelectedButton()
        
        adminContainerView.alpha = 0
        memberContainerView.alpha = 0
        contactContainerView.alpha = 1.0
    }
}
////////////////    SETTING ALL DESNGING STUFF /////////////
extension ChatVC{
    func setAllDesgning(){
        broadcastButton.corveBroadcastButton()
        adminButton.corveSelectedButton()
        membersButton.corveUnselectedButton()
        contactButton.corveUnselectedButton()
        
    }
}
extension ChatVC{
    func sideout_menu()
    {
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = self.view.frame.width * 0.75
            //275  160
            revealViewController()?.rightViewRevealWidth = self.view.frame.width * 0.25
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
        
    }
}
