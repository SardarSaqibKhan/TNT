//
//  Rsvp.swift
//  TNTAdmin
//
//  Created by Abdul on 18/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
class Rsvp
{
    var Email : String
    var EventID: Int
    var HostID:Int
    var Name: String
    var RSVPID: Int
    var Status: String
    var memberid : String
    
    
    
    init(){
        self.Email = ""
        self.EventID = 0
        self.HostID = 0
        self.Name = ""
        self.RSVPID = 0
        self.Status = ""
        self.memberid = ""
        
    }
    init(email : String,
         eventid: Int ,
         hostid:Int ,
         name: String ,
         rsvpid: Int ,
         status: String,
         memberid : String) {
        
        self.Email = email
        self.EventID = eventid
        self.HostID = hostid
        self.RSVPID = rsvpid
        self.Status = status
        self.memberid = memberid
        self.Name = name
        
        
    }
    
    init(json: [String:Any]) {
       
        
        Email = json["Email"] as? String ?? ""
        EventID = json["EventID"] as? Int ?? 0
        HostID = json["HostID"] as? Int  ?? 0
        RSVPID = json["RSVPID"] as? Int  ?? 0
        Status = json["Status"] as? String ?? ""
        memberid = json["MemberID"] as? String ?? ""
        Name = json["Name"] as? String ?? ""
        
        
    }
    
}
