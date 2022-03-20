//
//  Member.swift
//  TNTChat
//
//  Created by MacBook Pro on 28/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
class MemberUser {
    
    var id: String?
    var name: String?
    var email: String?
    var photoUrl: String?
    
    var chatIds: [String:String] = [String:String]()
    
    init(id: String, name: String, email: String, photoUrl: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.photoUrl = photoUrl
        //self.chatIds = [][]();
    }
    
    init(json: [String:Any]) {
        id = json["id"] as? String ?? ""
        name = json["name"] as? String ?? "SomeName"
        email = json["email"] as? String ?? "SomeEmail@gmail.com"
        photoUrl = json["photoUrl"] as? String
        if let js = json["chatIds"] as? [String:String]
        {
            chatIds = (json["chatIds"] as? [String:String])!
        }
        
    }
    func addChatID(key:String,value:String)
    {
        chatIds[key] = value;
    }
}


extension MemberUser {
    
    func jsonData() -> [AnyHashable:Any] {
        return [ "id" : id ?? "",
                 "name" : name ?? "",
                 "email" : email ?? "",
                 "chatIds" : chatIds ?? "",
                 "photoUrl" : photoUrl as Any]
    }
}
