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
    func carveNotificationView(){
        self.layer.cornerRadius = 15
    }
    func roundView(){
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
}

