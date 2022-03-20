//
//  OpeningCameraVC.swift
//  TNTPostPicture
//
//  Created by MacBook Pro on 11/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import CameraBackground

class OpeningCameraVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var permissionView: UIView!
    @IBOutlet weak var captureimgview: UIImageView!
    
     let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var cencalbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addCameraBackground(
           showButtons: false
//            buttonMargins: UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10),
//            buttonsLocation: .bottom
        )
        //cencalbtn.isEnabled = false
         cencalbtn.isHidden = true
        captureimgview.isHidden = true
        showPermissionPopUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func cancelbtnaction(_ sender: Any) {
        self.view.freeCameraSnapshot()
       // showPermissionPopUp()
        // unfreeze image
        showRemovingPicToFBPopUp()
        captureimgview.isHidden = true
        captureimgview.image = nil
        cencalbtn.isHidden = true
    }
    @IBAction func btn(_ sender: Any) {
        
       
       cencalbtn.isHidden = false
         captureimgview.isHidden = false
       
        view.takeCameraSnapshot( {
            // animate snapshot capture
            self.view.alpha = 0
            UIView.animate(withDuration: 1) { self.view.alpha = 1 }
        },
                                 completion: { (capturedImage, error) -> () in
                                    self.captureimgview.image = capturedImage
                                    self.showPermissionPopUp()
                                    // self.view.freeCameraSnapshot() // unfreeze image
                                    // ... handle capturedImage and error
        }
        )
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        if UIImagePickerController.isCameraDeviceAvailable( UIImagePickerController.CameraDevice.front) {
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerController.SourceType.camera
//            present(imagePicker, animated: true, completion: nil)
//
//        }
//        DispatchQueue.main.async {
//            self.view.bringSubviewToFront(self.permissionView)
//        }
//
//    }
    func showPermissionPopUp(){
        let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GettingPermissionVC") as! GettingPermissionVC
        self.addChild(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
    }

    func showRemovingPicToFBPopUp(){
        let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RemovingPictureFBVC") as! RemovingPictureFBVC
        self.addChild(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
    }

}
