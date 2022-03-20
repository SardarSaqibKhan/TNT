//
//  JoinTNTDBManager.swift
//  TNTUserSigning
//
//  Created by Moheed Zafar on 19/06/2019.
//  Copyright © 2019 Moheed Zafar. All rights reserved.
//

//
//  DBManager.swift
//  Hataba
//
//  Created by Moheed Zafar Hashmi on 28/02/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import Alamofire


class  DBManagerMember {
    
    static var manager = DBManagerMember();
    
    func searchMember(firstName:String,lastName:String,company:String,goal:String,organization:String,committees:String,completionHandler:@escaping ( _ result:Bool, _ _member:[Member?]) -> Void){
        //GetNewMemberResult
        let url = "\(url_string)/SearchMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        var members = [Member]()
        
        let parameters : [String : Any] = ["FirstName":firstName,
                                           "LastName":lastName,
                                           "Company":company,
                                           "Committees":committees,
                                           "Organization":organization,
                                           "Goal":goal]
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[[String:Any]]]
            {
                if let mems = res["SearchMemberResult"]
                {
                    if mems.count != 0{
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
    //
    //MatchMember(string Interest, string Goal, string Indusrty, string Commitees)
    func matchMember(interest:String, goal:String,industry:String,commitees:String,completionHandler:@escaping ( _ result:Bool, _ _member:[Member?]) -> Void){
        //GetNewMemberResult
        let url = "\(url_string)/MatchMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        var members = [Member]()
        
        let parameters : [String : Any] = ["Interest":interest,
                                           "Goal":goal,
                                           "Industry":industry,
                                           "commitees":commitees
                                            ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[[String:Any]]]
            {
                if let mems = res["MatchMemberResult"]
                {
                    if mems.count != 0{
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
    func addToContact(memberID:Int, contactID:Int,completionHandler:@escaping ( _ result:Bool) -> Void){
        //GetNewMemberResult
        let url = "\(url_string)/AddToContact" // This will be your link
        let header = ["Content-Type" : "application/json"]
        
        let parameters : [String : Any] = ["MemberID":memberID,
                                           "ContactID":contactID,
                                          ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:Bool]
            {
                if let isSuccessful = res["AddToContactResult"]
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
