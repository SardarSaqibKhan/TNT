//
//  UpdationDesgningFile.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 03/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func updationButtons(){
        self.layer.cornerRadius = 5
    }
    func roundButton(){
        self.layer.cornerRadius = self.frame.height / 2
        
    }
}
extension UIImageView{
    func roundProfileImage(){
        self.layer.cornerRadius = self.frame.height / 2
        
    }
}
extension UIView{
    func corveCorner(){
        self.layer.cornerRadius = 5
    }
    func roundBuiltView(){
        self.layer.cornerRadius = 5
    }
    func carveANDShadow(){
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.1
        
    }
    func borderHightLight(){
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 0.5
    }
}
