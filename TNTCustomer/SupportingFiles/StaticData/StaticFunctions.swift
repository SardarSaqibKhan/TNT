//
//  StaticFunctions.swift
//  TNTAdmin
//
//  Created by MacBook Pro on 26/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
func showToasts(message:String,senderView:UIViewController){
    let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateSuccessPopUp") as! UpdateSuccessPopUp
    popVC.message = message
    senderView.addChild(popVC)
    popVC.view.frame = senderView.view.frame
    senderView.view.addSubview(popVC.view)
    popVC.didMove(toParent: senderView)
}
