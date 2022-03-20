//
//  EventcalenderDesigningFile.swift
//  UserGuestTNT
//
//  Created by abdul on 11/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//



import Foundation
import UIKit
extension UITextField{
    
    
    func ECcarveANDShadowTextField() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.init(displayP3Red: 185/255, green: 185/255, blue: 185/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
    }
}
extension UIButton{
    func ECcarveNextButton(){
        self.layer.cornerRadius = self.frame.height / 2
        
    }
}
extension UIImageView{
    
    func ECcircleImage()
    {
        
        self.layer.masksToBounds = false
        
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    func ECroundProfileImage(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 1.5
        
    }
    func ECviewlightborder(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 1.5
    }
    func ECroundimage()
    {
        self.layer.cornerRadius = self.frame.height / 2
    }
    func ECRoundProfileImage(){
        //self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        //self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        
    }
    
}
extension UIView{
    
    func ECcurveView(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
    }
    
    func ECborderformembercell(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 0.2
    }
    
    func ECroundProfileimageBackgroundView(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 0.5
    }
    func ECroundBuiltView( size : CGFloat){
        
        self.layer.cornerRadius = size
    }
    func ECcarveandshadowview()
    {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.1
        self.layer.borderColor = UIColor.black.cgColor
    }
    func ECDesignRequestView()
    {
        self.layer.cornerRadius = 0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        
    }
    func ECcarveANDShadow(){
        self.layer.cornerRadius = self.frame.size.height / 8
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.3
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.25
        
    }
    func ECcarveshadowradius( shadowRadius : Int){
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOpacity = 0.2
        
    }
    func ECcarveTopleftRightView(size : CGFloat){
        self.layer.cornerRadius = size
        self.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    func ECborderHightLight(){
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 0.5
    }
    func ECborderHightLightwithshadow(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        self.layer.borderWidth = 1.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.001
        
    }
    func ECbordershadow(){
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.1
    }
}
extension UITableView{
    func ECheightlightBorderofTableView(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.init(displayP3Red: 1/255, green: 168/255, blue: 124/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = 5
    }
}
extension UICollectionView{
    
    func ECheightlightBorderofCollectionView(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.init(displayP3Red: 1/255, green: 168/255, blue: 124/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = 5
    }
}
extension UILabel{
    func ECCarveLabbel(){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
    }
}

