//
//  HCDBManger.swift
//  UserGuestTNT
//
//  Created by abdul on 12/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import Foundation
import Alamofire


// HCurl_string = "http://192.168.100.33/TNTServices/Service1.svc"
//let ftpUrlString = "ftp://192.168.100.30:19002/images/EmployeeDocuments/"
//let ftpUrl = "ftp://192.168.100.30:19002/images/CustomerProfileImages/"

class HCDBManger {
    static var manager = HCDBManger();
    
    
    
    
    //Getevent by Eventdate
    func geteventbydate(date : String , completionHandler:@escaping (_ result: Bool , _ event:[HCEvent]? )-> Void )
    {
        let url = "\(url_string)/GetEventByDate" // This will be your link
        let param:[String:Any] = ["Date":date ]
        
        let headers = ["Content-Type":"application/json"]
        //        Alamofire.request("\(url_string)/EmployeeSignin", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers:headers).response { request in
        //
        //        }
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let res = response.result.value as? [String : [[String:Any]]]
                {
                    var events = [HCEvent]()
                    // let u2 = User()
                    if let response = res["GetEventByDateResult"]
                    {
                        for a in response
                        {
                            var eventdata = HCEvent(json: a)
                            events.append(eventdata)
                        }
                        completionHandler(true,events)
                    }
                    else
                    {
                        completionHandler(false,nil);
                    }
                }
                else
                {
                    completionHandler(false,nil);
                    
                }
        }
        
        
        
    }
    
    //getsurveyfeebacks
    
    func getsurveyfeedback(eventid : String ,Question : String, completionHandler:@escaping (_ result: Bool , _ Survey:[HCsurvey]? )-> Void)
    {
        
        let str = "\(url_string)/getsurveyfeedback/\(eventid)/\(Question)"
        let escapedstr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.request(escapedstr!).responseJSON { res in
            
            if let value = (res.result.value as? [String:[[String:Any]]])
            {
                var surveys = [HCsurvey]()
                let dataArray = value["GetSurveyFeedbackResult"]
                
                for a in dataArray!
                {
                    let temp = HCsurvey(json: a)
                    surveys.append(temp)
                }
                // print(bookingrequests)
                completionHandler(true,surveys)
                
            }
            else{
                completionHandler(false,nil)
            }
            
            
        }
        
    }
    
    func addsurvey( EventID : Int, MemberID : Int,Q1 : String, Q2 : String, Q3 : String, Q4 : String,Q5 : String,Q6 : String,Q7: Bool , Rating : Int , completionHandler:@escaping (_ result: Bool) -> Void)
    {
        let url = "\(url_string)/AddSurvey" // This will be your link
        let param:[String:Any] = ["EventID":EventID,
                                  "MemberID":MemberID,
                                  "Q1":Q1,
                                  "Q2":Q2,
                                  "Q3" : Q3,
                                  "Q4":Q4,
                                  "Q5":Q5,
                                  "Q6":Q6,
                                  "Q7":Q7,
                                  "Rating":Rating]
        
        let headers = ["Content-Type":"application/json"]
        //        Alamofire.request("\(url_string)/EmployeeSignin", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers:headers).response { request in
        //
        //        }
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let res = response.result.value as? [String : Bool]
                {
                    
                    // let u2 = User()
                    if let response = res["AddSurveyResult"]
                    {
                        completionHandler(response)
                    }
                    else
                    {
                        completionHandler(false);
                    }
                }
                else
                {
                    completionHandler(false)
                    
                }
        }
        
        
    }
    
    
//    func geteventsattendedbymember(memberid :String,completionHandler:@escaping (_ result: Bool  )-> Void )
//    {
//
//    }
    
    //member checkin for event
    func membercheckin( EventID : Int, MemberID : Int, completionHandler:@escaping (_ result: Bool ) -> Void)
    {
        let url = "\(url_string)/MemberEventCheckin" // This will be your link
        let param:[String:Any] = ["EventID":EventID,
                                  "MemberID":MemberID
                                  ]
        
        let headers = ["Content-Type":"application/json"]
        //        Alamofire.request("\(url_string)/EmployeeSignin", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers:headers).response { request in
        //
        //        }
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let res = response.result.value as? [String : Int]
                {
                    
                    // let u2 = User()
                    if let response = res["MemberEventCheckinResult"]
                    {
                        completionHandler(true)
                    }
                    else
                    {
                        completionHandler(false);
                    }
                }
                else
                {
                    completionHandler(false)
                    
                }
        }
        
        
    }
    
    //get event attended by member
    
    func geteventattendenceofmember(  MemberID : Int, completionHandler:@escaping (_ result: Bool , _ event:[HCEvent]?) -> Void)
    {
        let url = "\(url_string)/GetEventsAttendedByMember" // This will be your link
        let param:[String:Any] = [
                                  "MemberID":MemberID
        ]
        
        let headers = ["Content-Type":"application/json"]
        //        Alamofire.request("\(url_string)/EmployeeSignin", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers:headers).response { request in
        //
        //        }
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let res = response.result.value as? [String : [[String:Any]]]
                {
                    
                    // let u2 = User()
                    var events = [HCEvent]()
                    // let u2 = User()
                    if let response = res["GetEventsAttendedByMemberResult"]
                    {
                        for a in response
                        {
                            var eventdata = HCEvent(json: a)
                            events.append(eventdata)
                        }
                        completionHandler(true,events)
                    }
                    else
                    {
                        completionHandler(false, nil);
                    }
                }
                else
                {
                    completionHandler(false, nil)
                    
                }
        }
        
        
    }
    
}
