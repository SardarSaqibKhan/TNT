//
//  DBManager.swift
//  TNTChat
//
//  Created by MacBook Pro on 29/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import Alamofire

class DBManagerChat{
   static var manager = DBManagerChat();
    ////////////////////////// Add Chat ////////////////////////////////
    func AddChatMessage(senderID:Int,reciverID:Int,message:String,completionHandler:@escaping (_ result:Bool) -> Void){
        let url = "\(url_string)/AddChatMessage" // This will be your link
        let header = ["Content-Type" : "application/json"]
        
        
        let parameters : [String : Any] = ["SenderID":senderID,
                                           "ReceiverID":reciverID,
                                           "ChatContent":message,
                                           "ChatType":"AA"]
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["AddChatMessageResult"]
                {
                    if response.count != 0{
                        completionHandler(true);
                    }
                    else {
                        completionHandler(false)
                    }
                }
                else{
                    completionHandler(false)
                }
            }
            else{
                completionHandler(false)
            }
        }
    }
    //////////////////////////// GET ALL MEMBERS /////////////////
    func GetAllMembers(completionHandler:@escaping (_ member:[Member]?) -> Void){
        let path = "\(url_string)/getallmembers/All"
        Alamofire.request(path).responseJSON{
            response in
            
            if let value = response.result.value as? [String:[[String:Any]]] {
                if let res = value["GetAllMembersResult"]{
                    var Members = [Member]()
                    for mem in res{
                         let member = Member(json: mem)
                         Members.append(member)
                    }
                    
                    completionHandler(Members);
                }
                else{
                    completionHandler(nil)
                }
            }
        }
    }
}

