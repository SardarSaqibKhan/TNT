
//
//  SaveContactVC.swift
//  TNTUserSigning
//
//  Created by Moheed Zafar on 26/06/2019.
//  Copyright © 2019 Moheed Zafar. All rights reserved.
//

import UIKit

class SaveContactVC: UIViewController {
    

    @IBOutlet weak var firstName: SetupProfileTF!
    @IBOutlet weak var lastName: SetupProfileTF!
    @IBOutlet weak var emailTF: SetupProfileTF!
    @IBOutlet weak var phoneNumberTF: SetupProfileTF!
    @IBOutlet weak var countryCodeTF: SetupProfileTF!
    @IBOutlet weak var addressTF: SetupProfileTF!
    @IBOutlet weak var businessNameTF: SetupProfileTF!
    @IBOutlet weak var industryTF: SetupProfileTF!
    @IBOutlet weak var scanBusinessCardLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var currentMember:Member?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    @IBAction func save(_ sender: Any) {
        if firstName.isEmpty() || lastName.isEmpty() || emailTF.isEmpty() || phoneNumberTF.isEmpty() || countryCodeTF.isEmpty() || addressTF.isEmpty()
        || businessNameTF.isEmpty() || industryTF.isEmpty()
        {
            return
        }
        DBManagerContacts.manager.saveToContact(memberID: currentMember!.ID!, createdByID: currentMember!.ID!, firstName: firstName.text!, lastName: lastName.text!, emailAddress: emailTF.text!, countryCode: countryCodeTF.text!, phoneNo: phoneNumberTF.text!, address: addressTF.text!, businessName: businessNameTF.text!, industry: industryTF.text!) { (isSuccess) in
            if isSuccess
            { print("The Contact has beem Saved") }
            else
            { print("The Contact Save Failed") }
        }
    }
    
}
