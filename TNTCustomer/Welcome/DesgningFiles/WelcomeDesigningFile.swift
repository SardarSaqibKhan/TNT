//
//  DesigningFile.swift
//  HatabaEmployee
//
//  Created by MacBook Pro on 11/04/2019.
//  Copyright © 2019 Saim Ali. All rights reserved.
//

import Foundation
import UIKit
extension UITextField{
    
    
    func carveANDShadowTextField() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.init(displayP3Red: 185/255, green: 185/255, blue: 185/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
    }
}
extension UIButton{
    func carveNextButton(){
        self.layer.cornerRadius = self.frame.height / 2
        
    }
}
extension UIImageView{
   func roundProfileImage(){
    self.layer.masksToBounds = false
      self.layer.cornerRadius = self.frame.height / 2
      self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
      self.layer.borderWidth = 1.5
    
    }
    func viewlightborder(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 1.5
    }
    func roundimage()
    {
        self.layer.cornerRadius = self.frame.height / 2
    }
    func RoundProfileImage(){
        //self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        //self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        
    }
   
}
extension UIView{
    func roundProfileimageBackgroundView(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 0.5
    }
    func roundBuiltView( size : CGFloat){
        
         self.layer.cornerRadius = size
    }
    func carveandshadowview()
    {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
       self.layer.shadowOpacity = 0.1
        self.layer.borderColor = UIColor.black.cgColor
    }
    func DesignRequestView()
    {
        self.layer.cornerRadius = 0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        
    }
    func carveANDShadow(){
        self.layer.cornerRadius = self.frame.size.height / 8
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.3
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.25
        
    }
    func carveshadowradius( shadowRadius : Int){
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOpacity = 0.2
        
    }
    func carveTopleftRightView(size : CGFloat){
        self.layer.cornerRadius = size
        self.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    func borderHightLight(){
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 0.5
    }
    func borderHightLightwithshadow(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        self.layer.borderWidth = 1.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.001
        
    }
    func bordershadow(){
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.1
    }
}
extension UITableView{
    func heightlightBorderofTableView(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.init(displayP3Red: 1/255, green: 168/255, blue: 124/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = 5
    }
}
extension UICollectionView{
    
    func heightlightBorderofCollectionView(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.init(displayP3Red: 1/255, green: 168/255, blue: 124/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = 5
    }
}
extension UILabel{
    func CarveLabbel(){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
    }
}

