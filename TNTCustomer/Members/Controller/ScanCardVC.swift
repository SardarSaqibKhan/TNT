//
//  ExistingMemberScaningVc.swift
//  TNT Event Check In
//
//  Created by MacBook Pro on 07/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import AVFoundation

class ExistingMemberScaningVc: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var scanIDButton: UIButton!
    var video = AVCaptureVideoPreviewLayer()
    var memberID = String()
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCustomize()
        CreatSession()
        settingTapGesturesOnBackImage()
    }
    
    @IBAction func scanID(_ sender: Any) {
        self.performSegue(withIdentifier: "ExistingMemberProfileSegue", sender: nil)
    }
}
/////////// MAKING CUSTOMIZE CONTROLE //////////////
extension ExistingMemberScaningVc{
    func makeCustomize(){
         scanIDButton.loginCustomizeButton()
         scanIDButton.isEnabled = false
    }
}
/////////// SETTING GESTUES ON MEMBER TYPE VIEWS  //////////////
extension ExistingMemberScaningVc{
    func settingTapGesturesOnBackImage(){
        let tapbackImage = UITapGestureRecognizer(target: self, action: #selector(ExistingMemberScaningVc.handleTapOnBackImage(_:)))
        backImageView.addGestureRecognizer(tapbackImage)
        
    }
    @objc func handleTapOnBackImage(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}
//////////////////// SCANING BAR CODE ///////////////////
extension ExistingMemberScaningVc:AVCaptureMetadataOutputObjectsDelegate{
    func CreatSession(){
        //Creating session
       
        
        //Define capture devcie
        //let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if  let captureDevice = AVCaptureDevice.default(for: AVMediaType.video){
            do
            {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                session.addInput(input)
                
            }
            catch
            {
                print ("ERROR")
            }
           
            let output = AVCaptureMetadataOutput()
            session.addOutput(output)

            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

            output.metadataObjectTypes =  [AVMetadataObject.ObjectType.aztec]
            video = AVCaptureVideoPreviewLayer(session: session)
            video.frame = view.layer.bounds
            view.layer.addSublayer(video)
            
            self.view.bringSubviewToFront(topView)
           
            
            
            session.startRunning()
        }
        else{
            print("no device Found...!!!")
        }
        
        
    }

    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let barCodeTypes = [AVMetadataObject.ObjectType.upce,AVMetadataObject.ObjectType.code39,AVMetadataObject.ObjectType.code39Mod43, AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.ean8,AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.code128,AVMetadataObject.ObjectType.pdf417,AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.aztec]
        
     

        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if barCodeTypes.contains(object.type)
                {
                    
                    print("bar code is equal to \(object.stringValue ?? "")")
                    let id  = object.stringValue ?? ""
                    self.memberID = String(id.dropFirst(3))
                    print(self.memberID)
                    self.alertMessage(message: "\(object.stringValue ?? "")")
                    session.stopRunning()
                    self.view.bringSubviewToFront(bottomView)
                    scanIDButton.isEnabled = true
                    
                }
                else{
                    print("This is not Bar Code..!!!")
                    self.alertMessage(message: "This is not Bar Code..!!!")
                }
            }
            else{
                print("The Code in not Machine Readable..!!!")
                 self.alertMessage(message: "The Code in not Machine Readable..!!")
            }
        }
        else {
            print("There is no data in Bar Code..!!!")
             self.alertMessage(message: "There is no data in Bar Code..!!!")
            
        }
    }
    
    func alertMessage(message:String){
        let alertController = UIAlertController(title: "Bar Code Scan Succussfully..", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
