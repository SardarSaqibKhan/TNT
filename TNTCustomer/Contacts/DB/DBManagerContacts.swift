//
//  File.swift
//  TNTUserSigning
//
//  Created by Moheed Zafar on 25/06/2019.
//  Copyright © 2019 Moheed Zafar. All rights reserved.
//
import Alamofire
import Foundation

class DBManagerContacts
{
    static var manager = DBManagerContacts()
    
    func getContacts(memberID:Int, firstName:String,lastName:String,industry:String,goal:String,organization:String,committees:String,completionHandler:@escaping ( _ result:Bool, _ _member:[Member?]) -> Void){
        //GetNewMemberResult
        let url = "\(url_string)/GetContacts" // This will be your link
        let header = ["Content-Type" : "application/json"]
        var members = [Member]()
        
        let parameters : [String : Any] = [
                                           "CreatedByID":memberID,
                                           "FirstName":firstName,
                                           "LastName":lastName,
                                           "Industry":industry,
                                           "Committees":committees,
                                           "Organization":organization,
                                           "Goal":goal]
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[[String:Any]]]
            {
                if let mems = res["GetContactsResult"]
                {
                    if mems.count != 0
                    {
                        for member in mems
                        {
                            let mem = Member(json: member)
                            members.append(mem)
                        }
                        completionHandler(true,members);
                    }
                    else {
                        completionHandler(false,members)
                    }
                }
                else{
                    completionHandler(false,members)
                }
            }
            else{
                completionHandler(false,members)
            }
        }
    }
    //bool AddContactWithDetails(int CreatedByID, string FirstName, string LastName, string EmailAddress, string CountryCode, string PhoneNo, string Address, string BussinessName, string Industry)
    func saveToContact(memberID:Int, createdByID:Int, firstName:String, lastName:String, emailAddress: String, countryCode:String, phoneNo:String ,address:String , businessName:String, industry:String, completionHandler:@escaping ( _ result:Bool) -> Void){
        //GetNewMemberResult
        let url = "\(url_string)/AddContactWithDetails" // This will be your link
        let header = ["Content-Type" : "application/json"]
        
        let parameters : [String : Any] = ["CreatedByID":memberID,
                                           "FirstName":firstName,
                                           "LastName":lastName,
                                           "EmailAddress":emailAddress,
                                           "CountryCode":countryCode,
                                           "PhoneNo":phoneNo,
                                           "Address":address,
                                           "BusinessName":businessName,
                                           "Industry":industry
                                          ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:Bool]
            {
                if let isSuccessful = res["AddContactWithDetailsResult"]
                {
                    if isSuccessful { completionHandler(true)  }
                    else            { completionHandler(false) }
                }
                else
                {
                    completionHandler(false)
                }
            }
            else
            {
                completionHandler(false)
            }
        }
    }
}
