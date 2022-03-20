//
//  HCDesginingfile.swift
//  UserGuestTNT
//
//  Created by abdul on 12/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func HCcircleImage()
    {
        
        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    
}
extension UIView
{
    func HCcarveshadowradius( shadowRadius : Int){
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 0.1
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOpacity = 0.25
        
        
    }
    
    func HCcurveView(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func HCborderformembercell(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 0.2
    }
}

extension UITextField
{
    
}
extension UIButton
{
    func HCcarveNextButton(){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.2
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.1
    }
}

