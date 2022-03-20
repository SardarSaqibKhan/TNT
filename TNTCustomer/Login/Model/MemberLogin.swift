//
//  MemberLogin\.swift
//  TNTCustomer
//
//  Created by Abdul on 01/07/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
class MemberLogin {
    var MemberID:Int?
    var FirstName:String?
    var LastName:String?
    var Email:String?
    var ContactNumber:String?
    var Address:String
    var Industry:String?
    var Company:String?
    var CreatedDate:String?
    var ExpiryDate:String?
    var NoOfPasses:Int?
    var type:String?
    var Password:String?
    
    var TNTID:Int?
    var countryCode:String?
    var isPaid:String?
    
    
    
    init() {
        self.MemberID = 0
        self.FirstName = ""
        self.LastName = ""
        self.Email = ""
        self.ContactNumber = ""
        self.Address = ""
        self.Industry = ""
        self.Company = ""
        self.CreatedDate = ""
        self.ExpiryDate = ""
        self.NoOfPasses = 0
        self.type = ""
        self.Password = ""
        
        self.TNTID = 0
        self.countryCode  = ""
        self.isPaid = ""
        
        
    }
    init(memberID:Int,firstname:String,lastname:String,email:String,contactnumber:String,address:String,industry:String,company:String,createddate:String,expirydate:String,noofpasses:Int,type:String,password:String,TNTID:Int,countryCode:String,isPaid:String) {
        self.MemberID = memberID
        self.FirstName = firstname
        self.LastName = lastname
        self.Email = email
        self.ContactNumber = contactnumber
        self.Address = address
        self.Industry = industry
        self.Company = company
        self.CreatedDate = createddate
        self.ExpiryDate = expirydate
        self.NoOfPasses = noofpasses
        self.type = type
        self.Password = password
        
        self.TNTID = TNTID
        self.countryCode = countryCode
        self.isPaid = isPaid
    }
    init(json: [String:Any]) {
        self.MemberID = json["MemberID"] as? Int ?? 0
        self.FirstName = json["FirstName"] as? String ?? ""
        self.LastName = json["LastName"] as? String ?? ""
        self.Email = json["Email"] as? String ?? ""
        self.ContactNumber = json["ContactNumber"] as? String ?? ""
        self.Address = json["Address"] as? String ?? ""
        self.Industry = json["Industry"] as? String ?? ""
        self.Company = json["Company"] as? String ?? ""
        self.CreatedDate = json["CreatedDate"] as? String ?? ""
        self.ExpiryDate = json["ExpiryDate"] as? String ?? ""
        self.NoOfPasses = json["NoOfPasses"] as? Int ?? 0
        self.type = json["type"] as? String ?? ""
        self.Password = json["Password"] as? String ?? ""
        
        self.TNTID = json["TNTID"] as? Int ?? 0
        self.countryCode = json["CountryCode"] as? String ?? ""
        self.type = json["type"] as? String ?? ""
        
    }
    
}

