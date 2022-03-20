//
//  HCEvent.swift
//  UserGuestTNT
//
//  Created by Abdul on 14/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import Foundation


class HCEvent
{
   
    var EventId : Int
    var EventTitle: String
    var EventDate:String
    var EventHostAddress: String
    var EventHostDescription: String
    var EventHostName: String
    var EventTime: String
    var HostId : Int
    var HostFB: String
    var HostInstagram: String
    var HostLinkedIn:String
    var HostTwitter:String
    var HostWebsiteLink:String
    var Latitude:String
    var Longitude:String
    var  EventHostProfileImage : String
    
    
    init(){
        self.EventId = 0
        self.EventTitle = ""
        self.EventDate = ""
        self.EventHostName = ""
        self.EventHostAddress = ""
        self.EventHostDescription = ""
        self.EventTime = ""
        self.HostInstagram = ""
        self.HostLinkedIn = ""
        self.HostFB = ""
        self.HostTwitter = ""
        self.HostWebsiteLink = ""
        self.Latitude = ""
        self.Longitude = ""
        self.EventHostProfileImage = ""
        self.HostId = 0
        
    }
    init(EventId : Int,
         EventTitle: String ,
         EventDate:String ,
         EventHostAddress: String ,
         EventHostDescription: String ,
         EventHostName: String ,
         EventTime: String ,
         HostFB: String ,
         HostInstagram: String ,
         HostLinkedIn:String ,
         HostTwitter:String ,
         HostWebsiteLink:String ,
         Latitude:String ,
         Longitude:String,
         HostId: Int,
         pic : String) {
        
        self.EventTitle = EventTitle
        self.EventDate = EventDate
        self.EventHostName = EventHostName
        self.EventHostAddress = EventHostAddress
        self.EventHostDescription = EventHostDescription
        self.EventTime = EventTime
        self.HostInstagram = HostInstagram
        self.HostLinkedIn = HostLinkedIn
        self.HostFB = HostFB
        self.HostTwitter = HostTwitter
        self.HostWebsiteLink = HostWebsiteLink
        self.Latitude = Latitude
        self.Longitude = Longitude
        self.EventId = EventId
        self.EventHostProfileImage = pic
        self.HostId  = HostId
        
    }
    
    init(json: [String:Any]) {
        EventTime = json["EventTime"] as? String ?? ""  // Confirm from ServerEnd Dev
        
        EventHostDescription = json["EventHostDescription"] as? String ?? ""
        EventHostAddress = json["EventHostAddress"] as? String ?? ""
        EventHostName = json["EventHostName"] as? String  ?? ""
        EventDate = json["EventDate"] as? String  ?? ""
        EventTitle = json["EventTitle"] as? String ?? ""
        HostFB = json["HostFB"]  as? String ?? ""
        HostLinkedIn = json["HostLinkedIn"]  as? String ?? ""
        HostWebsiteLink = json["HostWebsiteLink"]  as? String ?? ""
        HostTwitter = json["HostTwitter"]  as? String ?? ""
        HostInstagram = json["HostInstagram"]  as? String ?? ""
        Latitude = json["Latitude"]  as? String ?? ""
        Longitude = json["Longitude"]  as? String ?? ""
        EventId = json["EventID"] as? Int ?? 0
        EventHostProfileImage = json["EventHostProfileImage"]  as? String ?? ""
        HostId = json["HostID"] as? Int ?? 0
        
    }
    
    
}
