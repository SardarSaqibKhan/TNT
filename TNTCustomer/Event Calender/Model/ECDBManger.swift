//
//  ECDBManger.swift
//  UserGuestTNT
//
//  Created by abdul on 11/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import Foundation
import Alamofire


//var ECurl_string = "http://192.168.100.36/TNTServices/Service1.svc"
//let ftpUrlString = "ftp://192.168.100.30:19002/images/EmployeeDocuments/"
//let ftpUrl = "ftp://192.168.100.30:19002/images/CustomerProfileImages/"

class ECDBManger {
    static var manager = ECDBManger();
    
    
    
    
    //Getevent by Eventdate
    func geteventbydate(date : String , completionHandler:@escaping (_ result: Bool , _ event:[ECEvent]? )-> Void )
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
                    var events = [ECEvent]()
                    // let u2 = User()
                    if let response = res["GetEventByDateResult"]
                    {
                        for a in response
                        {
                            var eventdata = ECEvent(json: a)
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
    func getupcomingevents(date : String , completionHandler:@escaping (_ result: Bool , _ event:[ECEvent]? )-> Void )
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
                    var events = [ECEvent]()
                    // let u2 = User()
                    if let response = res["GetUpcommingEventResult"]
                    {
                        for a in response
                        {
                            var eventdata = ECEvent(json: a)
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
    
    func getsurveyfeedback(eventid : String ,Question : String, completionHandler:@escaping (_ result: Bool , _ Survey:[ECsurvey]? )-> Void)
    {
        
        let str = "\(url_string)/getsurveyfeedback/\(eventid)/\(Question)"
        let escapedstr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.request(escapedstr!).responseJSON { res in
            
            if let value = (res.result.value as? [String:[[String:Any]]])
            {
                var surveys = [ECsurvey]()
                let dataArray = value["GetSurveyFeedbackResult"]
                
                for a in dataArray!
                {
                    let temp = ECsurvey(json: a)
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
    //get rsvp list
    func getrsvplist(eventid : String , completionHandler:@escaping (_ result: Bool , _ event:[Rsvp]? )-> Void )
    {
        let url = "\(url_string)/GetRSVPs" // This will be your link
        let param:[String:Any] = ["EventID":eventid ]
        
        let headers = ["Content-Type":"application/json"]
        //        Alamofire.request("\(url_string)/EmployeeSignin", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers:headers).response { request in
        //
        //        }
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let res = response.result.value as? [String:[[String:Any]]]
                {
                    var rsvps = [Rsvp]()
                    // let u2 = User()
                    if let response = res["GetRSVPsResult"]
                    {
                        for a in response
                        {
                            var temprsvp = Rsvp(json: a)
                            rsvps.append(temprsvp)
                        }
                        completionHandler(true,rsvps)
                    }
                    else
                    {
                        print(response.error.debugDescription)
                        completionHandler(false,nil);
                    }
                }
                else
                {
                    completionHandler(false,nil);
                    
                }
        }
        
        
        
    }
    //add to rsvp
    func addRSVP(Hostid : String , eventId : String, name : String ,email : String , Status : String ,memberid : Int , completionHandler:@escaping (_ result: String  )-> Void )
    {
        let url = "\(url_string)/AddToRSVP" // This will be your link
        let param:[String:Any] = ["HostID":Hostid,
                                  "EventID":eventId ,
                                  "Name": name,
                                  "Email": email,
                                  "Status": Status,
                                  "MemberID" :memberid
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

}
