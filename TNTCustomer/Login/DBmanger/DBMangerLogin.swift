//
//  DBMangerLogin.swift
//  TNTCustomer
//
//  Created by Abdul on 01/07/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import Alamofire


class DBMangerLogin {
    static var manager = DBMangerLogin();
    ////////////////////////// ADMIN LOGIN ////////////////////////////////
    func AdminLogin(userName:String,password:String,completionHandler:@escaping (_ result:Bool) -> Void){
        let url = "\(url_string)/Signin" // This will be your link
        let header = ["Content-Type" : "application/json"]
        
        
        let parameters : [String : Any] = ["Email":userName,
                                           "Password":password]
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["SigninResult"]
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
    
    //////////////////////////  Search New Member   ////////////////////////////////
    func SearchNewMember(name:String,email:String,completionHandler:@escaping (_ result:Bool,_ _member:MemberLogin) -> Void){
        //GetNewMemberResult
        let url = "\(url_string)/GetNewMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        
        
        let parameters : [String : Any] = ["Name":name,
                                           "Email":email]
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["GetNewMemberResult"]
                {
                    if response.count != 0{
                        
                        let member = MemberLogin(json: response)
                        completionHandler(true,member);
                    }
                    else {
                        completionHandler(false,MemberLogin())
                    }
                }
                else{
                    completionHandler(false,MemberLogin())
                }
            }
            else{
                completionHandler(false,MemberLogin())
            }
        }
    }
}
