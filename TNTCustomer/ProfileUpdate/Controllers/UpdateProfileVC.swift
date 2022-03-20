//
//  UpdateProfileVC.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 03/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class UpdateProfileVC: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTxtFiled: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var bussinessNameTxtField: UITextField!
    @IBOutlet weak var industryTxtField: UITextField!
    @IBOutlet weak var birthdayTxtField: UITextField!
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var notNowButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingCustomDesgning()
    }
    
    @IBAction func update(_ sender: Any) {
        
        updateProfile()
    }
    
    
    
}

/////////////////////////       SETTING ALL DESGNING STUFF      //////////////////////////
extension UpdateProfileVC{
    func settingCustomDesgning(){
       profileImage.roundProfileImage()
       updateButton.updationButtons()
       sureButton.updationButtons()
       settingTapGesturesOnBackImage()
    }
}
/////////// SETTING GESTUES ON MEMBER TYPE VIEWS  //////////////
extension UpdateProfileVC{
    func settingTapGesturesOnBackImage(){
        let tapbackImage = UITapGestureRecognizer(target: self, action: #selector(UpdateProfileVC.handleTapOnBackImage(_:)))
        backImage.addGestureRecognizer(tapbackImage)
        
    }
    @objc func handleTapOnBackImage(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}
/////////////////////////       UPDATE PROFILE      //////////////////////////
extension UpdateProfileVC{
    func updateProfile(){
        DBManagerUp.manager.UpdateProfile(memberID: 1, prfileImg:"", firstName: nameTxtFiled.text ?? "", lastName: "", email: emailTxtField.text ?? "", phoneNumber: phoneNumberTxtField.text ?? "", address: addressTxtField.text ?? "", companyName: bussinessNameTxtField.text ?? "", industry: industryTxtField.text ?? "", birthday: birthdayTxtField.text ?? "") { (result) in
            if result{
                print("updated successfully")
                self.showTooast(message: "Updated Successfully.!!", emoji:"🙂")
            }
            else{
                print("Not updated")
                self.showTooast(message: "Not Updated.!!", emoji:"😒")
            }
        }
    }
}
///////////////////////////// SHOWING SUCCESS MESSAGE  //////////////////////////////
extension UpdateProfileVC{
    func showTooast(message:String,emoji:String){
        
        let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateSuccessPopUp") as! UpdateSuccessPopUp
        
        
        popVC.message = message
        popVC.emoji = emoji
        self.addChild(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
        
        
    }
}
