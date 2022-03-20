//
//  survey.swift
//  user Guest TNT
//
//  Created by abdul on 13/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import Foundation
class survey
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
