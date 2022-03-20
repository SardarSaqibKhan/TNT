//
//  LoginVC.swift
//  TNTCustomer
//
//  Created by Abdul on 01/07/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
//import Firebase
//import FirebaseDatabase
//import IHProgressHUD


class LoginVC: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var transformingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeCustomize()
        //settingTapGesturesOnViews()
        //sendFCMToken()
        
        
    }
//    func sendFCMToken(){
//        if let fcmToken = UserDefaults.standard.value(forKey: "fcmToken"){
//            Database.database().reference().child("User").child("6").child("FCMToken").setValue(fcmToken as! String)
//
//        }
//        else{
//            print("fmc token not found...!!!")
//        }
//    }
    @IBAction func login(_ sender: Any) {
        //IHProgressHUD.show()
        if (userNameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!{
           // IHProgressHUD.dismiss()
            print("both are Required")
        }
        else{
            
            if Connectivity.isConnectedToInternet {
                let name = userNameTextField.text
                let password = passwordTextField.text
                DBMangerLogin.manager.AdminLogin(userName: name!, password:password!) { (result) in
                    if result {
                        
                       // IHProgressHUD.dismiss()
                       // self.performSegue(withIdentifier: "MemberTypeSegue", sender: nil)
                        print("login")
                    }
                    else{
                        print("No admin found")
                       // IHProgressHUD.dismiss()
                       // showToasts(message: "Admin Not Found.!", senderView: self)
                        
                    }
                }
            }else{
               // IHProgressHUD.dismiss()
                //showToasts(message: "Network Not Found.!\nPlease Try Again Later.!", senderView: self)
            }
        }
    }
    
    @IBAction func passwordTxtTouchDown(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionCurlUp, animations: {
            self.transformingView.transform = CGAffineTransform(translationX: 0, y: -50)
            //self.backgroundView.transform = CGAffineTransform.init(scaleX: 1   , y:   1)
        }, completion: nil)
    }
    
    @IBAction func passwordTxtEditingDidEnd(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionCurlUp, animations: {
            self.transformingView.transform = .identity
            //self.backgroundView.transform = CGAffineTransform.init(scaleX: 1   , y:   1)
        }, completion: nil)
    }
    
}
/////////// MAKING CUSTOMIZE CONTROLE //////////////
extension LoginVC{
    func makeCustomize(){
        textFieldAlignment()
        userNameTextField.loginCustomizeTextFields()
        passwordTextField.loginCustomizeTextFields()
        loginButton.loginCustomizeButton()
        
        //        IHProgressHUD.set(foregroundColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
        //        IHProgressHUD.set(borderColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
        //        IHProgressHUD.set(borderWidth: 1.0)
    }
    func textFieldAlignment()
    {
        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userNameTextField.frame.height))
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        userNameTextField.leftViewMode = .always
        passwordTextField.leftViewMode = .always
    }
}
/////////// SETTING GESTUES ON MEMBER TYPE VIEWS  //////////////
extension LoginVC{
//    func settingTapGesturesOnViews(){
//        let tapView1 = MemberTypeGestures(target: self, action: #selector(MemberTypeVC.handleTapOnViews(_:)))
//        self.view.addGestureRecognizer(tapView1)
//        tapView1.id = 1
//    }
//    @objc func handleTapOnViews(_ sender:MemberTypeGestures){
//        let id = sender.id
//        if id == 1 {
//            self.view.endEditing(true)
//        }
//    }
}
