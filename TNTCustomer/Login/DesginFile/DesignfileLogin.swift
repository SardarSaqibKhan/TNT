
//
//  EventCheckInDesgingFile.swift
//  TNT Event Check In
//
//  Created by MacBook Pro on 07/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func memberTypeCustomizeViews(){
        self.layer.cornerRadius = 15
    }
    func profileInfoViews(){
        self.layer.cornerRadius = 5
    }
}
extension UIButton{
    func loginCustomizeButton(){
        self.layer.cornerRadius = 5
        
    }
}
extension UITextField{
    func loginCustomizeTextFields(){
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
        
    }
    
}
extension UIImageView{
    
}
