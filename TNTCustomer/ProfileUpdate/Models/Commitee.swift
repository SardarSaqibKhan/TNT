//
//  Commitee.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 18/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
class Commitee
{
    var text:String
    var status:Bool
    init(text:String, status:Bool) {
        self.text = text
        self.status = status
    }
    class func commitees() -> [Commitee]
    {
        var comitees = [Commitee]()
        comitees.append(Commitee(text: "Events", status: false))
        comitees.append(Commitee(text: "Membership", status: false))
        comitees.append(Commitee(text: "Sponsorship", status: false))
        comitees.append(Commitee(text: "Community Engagment", status: false))
        comitees.append(Commitee(text: "Communication", status: false))
        comitees.append(Commitee(text: "Finance", status: false))
        return comitees
    }
}
