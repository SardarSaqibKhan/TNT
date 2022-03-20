//
//  ForgetpasswordVC.swift
//  HatabaEmployee
//
//  Created by Abdul on 17/07/2019.
//  Copyright © 2019 Saim Ali. All rights reserved.
//

import UIKit

class ForgetpasswordVC: UIViewController {

    
    @IBOutlet weak var sentbtn: UIButton!
    @IBOutlet weak var numbertext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbertext.carveTextfield()
        sentbtn.carveButton()

        // Do any additional setup after loading the view.
    }
    @IBAction func sentbtnaction(_ sender: Any) {
        
        if numbertext.text == nil {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertpopupVC") as! AlertpopupVC
                            vc.msgtxt = "Please Fill all fields"
                            vc.Titletxt = "Attention"
                            vc.modalPresentationStyle = .overCurrentContext
                            vc.modalTransitionStyle = .crossDissolve
                            self.present(vc, animated: true, completion: nil)
                            //GetStartedVC.AlertMessage(title: "Attention", message: "Please Fill all fields")
                        }
                        else
                        {
                            self.showAndicator()
                            DBManager.manager.employeeforgetpassword(PhoneNumber: numbertext.text!) { (res) in
                                self.removeAndicator()
                                if res
                                {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertpopupVC") as! AlertpopupVC
                                    vc.msgtxt = "New password has been sent to your email"
                                    vc.Titletxt = "Success"
                                    vc.modalPresentationStyle = .overCurrentContext
                                    vc.modalTransitionStyle = .crossDissolve
                                    self.present(vc, animated: true, completion: nil)
                                    
                                }
                                else
                                {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertpopupVC") as! AlertpopupVC
                                    vc.msgtxt = "Wrong Phone No \n Try again"
                                    vc.Titletxt = "Attention"
                                    vc.modalPresentationStyle = .overCurrentContext
                                    vc.modalTransitionStyle = .crossDissolve
                                    self.present(vc, animated: true, completion: nil)
                                }
             }
        }
  }



func showAndicator(){
    
    self.addChild(popVC)
    popVC.view.frame = self.view.frame
    self.view.addSubview(popVC.view)
    popVC.didMove(toParent: self)
}
func removeAndicator(){
    // popVC.removeFromParentViewController()
    popVC.view.removeFromSuperview()
}

    
    //        let alertController = UIAlertController(title: "Enter your number", message: "", preferredStyle: .alert)
    //        alertController.hideKeyboardWhenTappedAround()
    //        alertController.view.carveView()
    //
    //
    //        alertController.addTextField { (textField : UITextField!) -> Void in
    //            textField.placeholder = "Number"
    //
    //            //textField.isSecureTextEntry = true
    //            // textField.carveANDShadowTextField()
    //            textField.minimumFontSize = CGFloat(bitPattern: 20)
    //            textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 35))
    //
    //
    //
    //
    //        }
    //
    //        let saveAction = UIAlertAction(title: "Okay", style: .default, handler: { alert -> Void in
    //            let phonenumber = alertController.textFields![0] as UITextField
    //
    //            if phonenumber.text == nil {
    //                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertpopupVC") as! AlertpopupVC
    //                vc.msgtxt = "Please Fill all fields"
    //                vc.Titletxt = "Attention"
    //                vc.modalPresentationStyle = .overCurrentContext
    //                vc.modalTransitionStyle = .crossDissolve
    //                self.present(vc, animated: true, completion: nil)
    //                //GetStartedVC.AlertMessage(title: "Attention", message: "Please Fill all fields")
    //            }
    //            else
    //            {
    //                self.showAndicator()
    //                DBManager.manager.employeeforgetpassword(PhoneNumber: phonenumber.text!) { (res) in
    //                    self.removeAndicator()
    //                    if res
    //                    {
    //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertpopupVC") as! AlertpopupVC
    //                        vc.msgtxt = "New password has been sent to your email"
    //                        vc.Titletxt = "Success"
    //                        vc.modalPresentationStyle = .overCurrentContext
    //                        vc.modalTransitionStyle = .crossDissolve
    //                        self.present(vc, animated: true, completion: nil)
    //                    }
    //                    else
    //                    {
    //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertpopupVC") as! AlertpopupVC
    //                        vc.msgtxt = "Wrong Phone No \n Try again"
    //                        vc.Titletxt = "Attention"
    //                        vc.modalPresentationStyle = .overCurrentContext
    //                        vc.modalTransitionStyle = .crossDissolve
    //                        self.present(vc, animated: true, completion: nil)
    //                    }
    //
    //                }
    //
    //
    //            }
    //
    //        })
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
    //            (action : UIAlertAction!) -> Void in
    //            alertController.dismiss(animated: true, completion: nil)
    //        })
    //
    //
    //
    //        alertController.addAction(saveAction)
    //        alertController.addAction(cancelAction)
    //
    //
    //
    //
    //
    //
    //        self.present(alertController, animated: true, completion: nil)
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
