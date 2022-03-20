//
//  MemberProfileVC.swift
//  TNTUserSigning
//
//  Created by Moheed Zafar on 25/06/2019.
//  Copyright © 2019 Moheed Zafar. All rights reserved.
//

import UIKit

class MemberProfileVC: UIViewController {

    @IBOutlet weak var backIV: UIImageView!
    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var callIV: UIImageView!
    @IBOutlet weak var messageIV: UIImageView!
    @IBOutlet weak var mailIV: UIImageView!
    @IBOutlet weak var scanCardView: UIView!
    @IBOutlet weak var addContactsView: UIView!
    
    var member:Member?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styling()
        settingTapGestures()
        memberNameLabel.text = "\(member!.firstName!) \( member!.lastName!)"
    }
    
   func styling()
   {
    profileIV.circleImage()
    }
   func settingTapGestures()
   {
    
    let backTap = UITapGestureRecognizer(target: self, action: #selector(backIVTap))
    let callTap = UITapGestureRecognizer(target: self, action: #selector(callIVTap))
    let messageTap = UITapGestureRecognizer(target: self, action: #selector(messageIVTap))
    let mailTap = UITapGestureRecognizer(target: self, action: #selector(mailIVTap))
    let scanCardTap = UITapGestureRecognizer(target: self, action: #selector(scanCardViewTap))
    let addContactsTap = UITapGestureRecognizer(target: self, action: #selector(addContactsViewTap))
    
    backIV.addGestureRecognizer(backTap)
    callIV.addGestureRecognizer(callTap)
    messageIV.addGestureRecognizer(messageTap)
    mailIV.addGestureRecognizer(mailTap)
    scanCardView.addGestureRecognizer(scanCardTap)
    addContactsView.addGestureRecognizer(addContactsTap)
    
    }
    
    
   @objc func backIVTap()
   {
    self.dismiss(animated: true, completion: nil)
    }
    @objc func callIVTap()
    {
        let url:URL = URL(string: "tel://03409622094")!
        
        if (UIApplication.shared.canOpenURL(url))
        {
            UIApplication.shared.openURL(url)
        }
    }
    @objc func messageIVTap()
    {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func mailIVTap()
    {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func scanCardViewTap()
    {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func addContactsViewTap()
    {   
        DBManagerMember.manager.addToContact(memberID: 7, contactID: member!.ID!) { (isSuccessful) in
            if isSuccessful
            {
                print("ADD to Contact- Saved")
            }
            else
            {
                print("ADD to Contact- Failed")
            }
        }
    }
    
}
