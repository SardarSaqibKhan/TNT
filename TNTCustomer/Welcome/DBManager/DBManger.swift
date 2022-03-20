//
//  DBManger.swift
//  user guest TNT
//
//  Created by abdul on 09/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import Foundation
import Alamofire


var url_string = "http://192.168.100.20/TNTServices/Service1.svc"
let ftpUrlString = "ftp://192.168.100.20:9099/Images/"
//let ftpUrl = "ftp://192.168.100.30:19002/images/CustomerProfileImages/"

class DBManger {
    static var manager = DBManger();
    
    
    
    
    //Getevent by Eventdate
    func geteventbydate(date : String , completionHandler:@escaping (_ result: Bool , _ event:[Event]? )-> Void )
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
                    var events = [Event]()
                    // let u2 = User()
                    if let response = res["GetEventByDateResult"]
                    {
                        for a in response
                        {
                            var eventdata = Event(json: a)
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
    
    //get up coming event by Eventdate
    func getupcomingevents(date : String , completionHandler:@escaping (_ result: Bool , _ event:[Event]? )-> Void )
    {
        let url = "\(url_string)/GetUpcommingEvent" // This will be your link
        let param:[String:Any] = ["Date":date ]
        
        let headers = ["Content-Type":"application/json"]
        //        Alamofire.request("\(url_string)/EmployeeSignin", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers:headers).response { request in
        //
        //        }
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let res = response.result.value as? [String : [[String:Any]]]
                {
                    var events = [Event]()
                    // let u2 = User()
                    if let response = res["GetUpcommingEventResult"]
                    {
                        for a in response
                        {
                            var eventdata = Event(json: a)
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
    
    //adding rsvp of event
    func addRSVP(Hostid : String , eventId : String, name : String ,email : String , Status : String , completionHandler:@escaping (_ result: String  )-> Void )
    {
        let url = "\(url_string)/AddToRSVP" // This will be your link
        let param:[String:Any] = ["HostID":Hostid,
                                  "EventID":eventId ,
                                  "Name": name,
                                  "Email": email,
                                  "Status": Status
        ]
        
        let headers = ["Content-Type":"application/json"]
        //        Alamofire.request("\(url_string)/EmployeeSignin", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers:headers).response { request in
        //
        //        }
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let res = response.result.value as? [String : String]
                {
                    
                    // let u2 = User()
                    if let response = res["AddToRSVPResult"]
                    {
                        
                        completionHandler(response)
                    }
                    else
                    {
                        completionHandler("Error");
                    }
                }
                else
                {
                    completionHandler("Error");
                    
                }
        }
        
        
        
    }

    
    //getsurveyfeebacks
    
    func getsurveyfeedback(eventid : String ,Question : String, completionHandler:@escaping (_ result: Bool , _ Survey:[survey]? )-> Void)
    {
        
        let str = "\(url_string)/getsurveyfeedback/\(eventid)/\(Question)"
        let escapedstr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.request(escapedstr!).responseJSON { res in
            
            if let value = (res.result.value as? [String:[[String:Any]]])
            {
                var surveys = [survey]()
                let dataArray = value["GetSurveyFeedbackResult"]
                
                for a in dataArray!
                {
                    let temp = survey(json: a)
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
    //get up coming event month count  by Eventdate
    func getupcomingeventmonthcount(date : String , completionHandler:@escaping (_ result: Bool , _ count : String )-> Void )
    {
        let url = "\(url_string)/GetUpcommingMonthCount" // This will be your link
        let param:[String:Any] = ["Date":date ]
        
        let headers = ["Content-Type":"application/json"]
        //        Alamofire.request("\(url_string)/EmployeeSignin", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers:headers).response { request in
        //
        //        }
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let res = response.result.value as? [String : Int]
                {
                    
                  
                    if let response = res["GetUpcommingMonthCountResult"]
                    {
                       
                        completionHandler(true,String(response))
                    }
                    else
                    {
                        completionHandler(false,"0");
                    }
                }
                else
                {
                    completionHandler(false,"0");
                    
                }
        }
        
        
        
    }
}
