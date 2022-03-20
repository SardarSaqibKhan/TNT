//
//  MediaUpload.swift
//  ChatWithFireBase
//
//  Created by Moheed Zafar Hashmi on 01/02/2019.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit
import Alamofire
import LxFTPRequest
import JGProgressHUD

class MediaUpload {
    private let ftpUrlString = "ftp://192.168.100.30:19002/images/CustomerProfileImages"
    let progressHud = JGProgressHUD(style: .dark)
    var file = ""
    var imageurl:URL!
    var video = false;
    
    
    var chatId: String?
    var user1Id: String?
    var user2Id: String?
    var filename:String?
    var type = "Image";
    //-----------------------------------Image Upload with FTP----------------------------------//
 
    
    func uploadThumbnail(EmpDir:String, completionHandler:@escaping (_ result: String) -> Void)->String
    {
        
        file = ""
        let uploadRequest = LxFTPRequest.upload()
        print("==================")
        print("FileName:\(filename!)")
        print("==================")
        let localURL = imageurl!
        let uploadPath = "\(ftpUrlString)/\(EmpDir).jpg"
        uploadRequest?.serverURL = URL.init(string: uploadPath)
        uploadRequest?.localFileURL = (localURL)
        uploadRequest?.username = "anonymous"
        uploadRequest?.password = ""
        
        uploadRequest?.progressAction = uploadProgress1
        uploadRequest?.successAction = {
            (a,b) in
            print("success")
            completionHandler("Success")
            self.progressHud.textLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.progressHud.textLabel.text = "Registered successfully!"
            self.progressHud.detailTextLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.progressHud.indicatorView = JGProgressHUDSuccessIndicatorView()
            self.progressHud.dismiss(afterDelay: 3.0, animated: true)
        }
        uploadRequest?.failAction =
            {
//                if Connectivity.isConnectedToInternet {
//                    print("Yes! internet is available.")
//                    // do some tasks..
//                }
                
                (errorDomain, error, errorDescription) in
                print("FailedActionError:\(errorDomain)")
                print("FailedActionError:\(error)")
                print("FailedActionError:\(errorDescription)")
              
                self.progressHud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.progressHud.textLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.progressHud.textLabel.text = "Error Occured....!"
                self.progressHud.dismiss(afterDelay: 3.0, animated: true)
                completionHandler("FailedAction")
        }
      //  progressHud.show(in: bubbleView, animated: true)
        if Connectivity.isConnectedToInternet{
            uploadRequest?.start()
        }
       
        return filename!
    }
    
    
    func uploadProgress1(totalSize : NSInteger , finishedSize : NSInteger ,finishedPercent : CGFloat )
    {
        if Connectivity.isConnectedToInternet {
           // print("Yes! internet is available.")
            print(finishedPercent)
            progressHud.progress = Float(finishedSize) / Float(totalSize)
            self.progressHud.detailTextLabel.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            progressHud.detailTextLabel.text =  "\(Int(finishedPercent)) %"
        }
        else{
              print("OH NO! internet is not available.")
        }
       
    }
    
    func successAction1(class :AnyClass? , object : Any?)
    {
        
        
    }
    
    func imagesuccessAction1(class :AnyClass? , object : Any?)
    {
        print("success")
        self.progressHud.textLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        progressHud.textLabel.text = "Registered successfully!"
        self.progressHud.detailTextLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        progressHud.indicatorView = JGProgressHUDSuccessIndicatorView()
        self.progressHud.dismiss(afterDelay: 3.0, animated: true)
        
      
    }
    
    
    
    func initializeLoader1()
    {
        progressHud.indicatorView = JGProgressHUDRingIndicatorView()
        progressHud.progress = 0.0
        progressHud.textLabel.text = "Uploading"
        self.progressHud.textLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    //-----------------------------------------end----------------------------------------------//
}

