//
//  TNTChatDesgning.swift
//  TNTChat
//
//  Created by MacBook Pro on 21/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func corveAllAdminView(){
        self.layer.cornerRadius = 10
    }
    
}
extension UIButton{
    func corveSelectedButton(){
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.init(red: 210/255, green: 136/255, blue: 51/255, alpha: 1.0).cgColor
    }
    func corveUnselectedButton(){
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.init(red: 237/255, green: 242/255, blue: 245/255, alpha: 1.0).cgColor
    }
    func corveBroadcastButton(){
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.init(red: 210/255, green: 136/255, blue: 51/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.5
    }
    
}
extension UILabel{
    func roundLabel(){
        self.layer.cornerRadius = self.layer.frame.width / 2
        self.layer.masksToBounds = true
    }
}
extension UIImageView{
    func ProfileImageRoundImage(){
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
}

extension UIViewController{
    func dismissKeyBoard(){
        self.view.endEditing(true)
    }
  
}
