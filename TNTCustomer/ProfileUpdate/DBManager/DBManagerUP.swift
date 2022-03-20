//
//  DBManagerUP.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 18/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import Alamofire

class DBManagerUp {
    
    static var manager = DBManagerUp();
    var url_string = "http://192.168.100.32/TNTServices/Service1.svc"
    var ftpIP = "ftp://192.168.100.32:19002"
    
    //////////////////////////  Search New Member   ////////////////////////////////
    func SearchNewMember(name:String,email:String,completionHandler:@escaping (_ result:Bool) -> Void){
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

    //////////////////////////// UPDATE MEMBER PROFILE //////////////////////////////////////////////
    func UpdateProfile(memberID:Int,prfileImg:String,firstName:String,lastName:String,email:String,phoneNumber:String
        ,address:String,companyName:String,industry:String,birthday:String,completionHandler:@escaping (_ result:Bool) -> Void){
        let url = "\(url_string)/UpdateMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        let parameters : [String : Any] =
            
        [                                  "MemberID":memberID,
                                           "FirstName":firstName,
                                           "LastName":lastName,
                                           "Email":email,
                                           "ContactNumber":phoneNumber,
                                           "Password":"",
                                           "Type":"",
                                           "ExpiryDate":birthday,
                                           "Industry":industry,
                                           "Company":companyName,
                                           "Address":address,
                                           "CountryCode":"",
                                           "Interests":"",
                                           "Goals":"",
                                           "Commitees":"",
                                           "Board":"",
                                           "FB":"",
                                           "Instagram":"",
                                           "Twitter":"",
                                           "LinkedIn":"",
                                           "Website":""
                                         
        ]
        
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["UpdateMemberResult"]
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
    //////////////////////////// UPDATE MEMBER INTERESTS ////////////////////////////////////////////
    func UpdateInterests(memberID:Int,interests:String,completionHandler:@escaping (_ result:Bool) -> Void){
        let url = "\(url_string)/UpdateMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        let parameters : [String : Any] =
            
            [                                  "MemberID":memberID,
                                               "FirstName":"",
                                               "LastName":"",
                                               "Email":"",
                                               "ContactNumber":"",
                                               "Password":"",
                                               "Type":"",
                                               "ExpiryDate":"",
                                               "Industry":"",
                                               "Company":"",
                                               "Address":"",
                                               "CountryCode":"",
                                               "Interests":interests,
                                               "Goals":"",
                                               "Commitees":"",
                                               "Board":"",
                                               "FB":"",
                                               "Instagram":"",
                                               "Twitter":"",
                                               "LinkedIn":"",
                                               "Website":""
                
        ]
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["UpdateMemberResult"]
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
    //////////////////////////// UPDATE MEMBER GOALS ////////////////////////////////////////////////
    func UpdateGoals(memberID:Int,goals:String,completionHandler:@escaping (_ result:Bool) -> Void){
        let url = "\(url_string)/UpdateMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        let parameters : [String : Any] =
            
            [                                  "MemberID":memberID,
                                               "FirstName":"",
                                               "LastName":"",
                                               "Email":"",
                                               "ContactNumber":"",
                                               "Password":"",
                                               "Type":"",
                                               "ExpiryDate":"",
                                               "Industry":"",
                                               "Company":"",
                                               "Address":"",
                                               "CountryCode":"",
                                               "Interests":"",
                                               "Goals":goals,
                                               "Commitees":"",
                                               "Board":"",
                                               "FB":"",
                                               "Instagram":"",
                                               "Twitter":"",
                                               "LinkedIn":"",
                                               "Website":""
                
        ]
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["UpdateMemberResult"]
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
    //////////////////////////// UPDATE MEMBER ORGANIZATIONS ////////////////////////////////////////
    func UpdateOrganizations(memberID:Int,organizations:String,completionHandler:@escaping (_ result:Bool) -> Void){
        let url = "\(url_string)/UpdateMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        let parameters : [String : Any] =
            
            [                                  "MemberID":memberID,
                                               "FirstName":"",
                                               "LastName":"",
                                               "Email":"",
                                               "ContactNumber":"",
                                               "Password":"",
                                               "Type":"",
                                               "ExpiryDate":"",
                                               "Industry":"",
                                               "Company":"",
                                               "Address":"",
                                               "CountryCode":"",
                                               "Interests":"",
                                               "Goals":"",
                                               "Commitees":"",
                                               "Board":organizations,
                                               "FB":"",
                                               "Instagram":"",
                                               "Twitter":"",
                                               "LinkedIn":"",
                                               "Website":""
                
        ]
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["UpdateMemberResult"]
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
    //////////////////////////// UPDATE MEMBER SOCIAL MEDIA /////////////////////////////////////////
    func UpdateSocialMedia(memberID:Int,fb:String,instagram:String,twitter:String,linkedin:String,website:String,completionHandler:@escaping (_ result:Bool) -> Void){
        let url = "\(url_string)/UpdateMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        let parameters : [String : Any] =
            
            [                                  "MemberID":memberID,
                                               "FirstName":"",
                                               "LastName":"",
                                               "Email":"",
                                               "ContactNumber":"",
                                               "Password":"",
                                               "Type":"",
                                               "ExpiryDate":"",
                                               "Industry":"",
                                               "Company":"",
                                               "Address":"",
                                               "CountryCode":"",
                                               "Interests":"",
                                               "Goals":"",
                                               "Commitees":"",
                                               "Board":"",
                                               "FB":"",
                                               "Instagram":"",
                                               "Twitter":"",
                                               "LinkedIn":"",
                                               "Website":""
                
        ]
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["UpdateMemberResult"]
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
    //////////////////////////// UPDATE MEMBER TNT COMMITTEES ///////////////////////////////////////
    func UpdateTNTCommittees(memberID:Int,TNTCommittees:String,completionHandler:@escaping (_ result:Bool) -> Void){
        let url = "\(url_string)/UpdateMember" // This will be your link
        let header = ["Content-Type" : "application/json"]
        let parameters : [String : Any] =
            
            [                                  "MemberID":memberID,
                                               "FirstName":"",
                                               "LastName":"",
                                               "Email":"",
                                               "ContactNumber":"",
                                               "Password":"",
                                               "Type":"",
                                               "ExpiryDate":"",
                                               "Industry":"",
                                               "Company":"",
                                               "Address":"",
                                               "CountryCode":"",
                                               "Interests":"",
                                               "Goals":"",
                                               "Commitees":TNTCommittees,
                                               "Board":"",
                                               "FB":"",
                                               "Instagram":"",
                                               "Twitter":"",
                                               "LinkedIn":"",
                                               "Website":""
                
        ]
        print(url)
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
            if let res = response.result.value as? [String:[String:Any]]
            {
                if let response = res["UpdateMemberResult"]
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
}
