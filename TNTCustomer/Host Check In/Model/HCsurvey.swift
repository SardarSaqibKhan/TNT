//
//  HCsurvey.swift
//  UserGuestTNT
//
//  Created by Abdul on 14/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import Foundation
class HCsurvey
{
    var Memberfeedback : String
    var MemberName : String
    
    init(feedback : String , name : String)
    {
        self.Memberfeedback = feedback
        self.MemberName = name
    }
    init()
    {
        self.Memberfeedback = ""
        self.MemberName  = ""
        
    }
    
    init(json: [String:Any])
    {
        Memberfeedback = json["Feedback"] as? String ?? ""  // Confirm from ServerEnd Dev
        MemberName = json["Name"] as? String ?? ""
        
    }
    
}
