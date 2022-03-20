//
//  ProfileMainVC.swift
//  HatabaAdmin
//
//  Created by Moheed Zafar on 18/07/2019.
//  Copyright © 2019 abc company. All rights reserved.
//

import UIKit

class ProfileMainVC: UIViewController {

    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var documentCV: UIView!
    @IBOutlet weak var infoCV: UIView!
    @IBOutlet weak var serviceCV: UIView!
    @IBOutlet weak var firstBtnBar: UIView!
    @IBOutlet weak var tabSegmentControl: UISegmentedControl!
    
    let manager = DBManager();
    var serviceArray = [String]()
    var imageNameArray = [String]()
    var empId = Int()
    var employee = Employee()
    var Passdpimage = UIImage()
    var passeddpPath:String?
    var groupDownload = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileIV.circleImage()
        settingupsegmentcontrol()
        
        documentCV.isHidden = true
        infoCV.isHidden = false
        serviceCV.isHidden = true
        loadDate()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageClick(_ sender: Any) {
        let dynamicPath = "\(employee.contactNumber!)/thumbnail-\(employee.profileImage!).jpg"
        
        var pathListWithoutTN = dynamicPath.components(separatedBy: "thumbnail-")
        
        
        var vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageViewController") as! ImageViewController
        vc.image = profileIV.image;
        
        vc.path = "\(currentIP)/Images/EmployeeDocuments/\(pathListWithoutTN[0])\(pathListWithoutTN[1])";
        navigationController?.pushViewController(vc,animated: true)
    }
    @IBAction func confirm(_ sender: Any) {
        
           self.Alert_message(message: "Are you sure you want to accept?", isAcceptAction: true)
    }
    @IBAction func reject(_ sender: Any) {
           self.Alert_message(message: "Are you sure you want to reject?", isAcceptAction: false)
    }
    
    @IBAction func tabChange(_ sender: Any) {
        if tabSegmentControl.selectedSegmentIndex == 0 {
            documentCV.isHidden = true
            infoCV.isHidden = false
            serviceCV.isHidden = true
            //            firstbtnbar.isHidden = false
            //            secondbtnbar.isHidden = true
            
            UIView.animate(withDuration: 0.2) {
                self.firstBtnBar.frame.origin.x = (self.tabSegmentControl.frame.origin.x) + (self.tabSegmentControl.frame.width / CGFloat(self.tabSegmentControl.numberOfSegments)) * CGFloat(self.tabSegmentControl.selectedSegmentIndex)
            }
            
        }
        else if tabSegmentControl.selectedSegmentIndex == 1
        {
            documentCV.isHidden = true
            serviceCV.isHidden = false
            infoCV.isHidden = true
            
            //            firstbtnbar.isHidden = true
            //            secondbtnbar.isHidden = false
            
            UIView.animate(withDuration: 0.2) {
                self.firstBtnBar.frame.origin.x = (self.tabSegmentControl.frame.origin.x) + (self.tabSegmentControl.frame.width / CGFloat(self.tabSegmentControl.numberOfSegments)) * CGFloat(self.tabSegmentControl.selectedSegmentIndex)
            }
            
        }
        else
        {
            documentCV.isHidden = false
            serviceCV.isHidden = true
            infoCV.isHidden = true
            
            //            firstbtnbar.isHidden = true
            //            secondbtnbar.isHidden = false
            
            UIView.animate(withDuration: 0.2) {
                self.firstBtnBar.frame.origin.x = (self.tabSegmentControl.frame.origin.x) + (self.tabSegmentControl.frame.width / CGFloat(self.tabSegmentControl.numberOfSegments)) * CGFloat(self.tabSegmentControl.selectedSegmentIndex)
            }
            
        }
    }
    func Alert_message(message:String, isAcceptAction: Bool )
    {
        let userID = empId;
        let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: { action in
            print("Cancel")
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter reason"
        }

        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { action in
            if isAcceptAction {
                self.manager.verifyEmployee(UserId: "\(userID)", status: "Approved", completionHandler: {
                    res in
                    if res
                    {
                        UIAlertView(title: "Approved", message: "Thank you", delegate: self, cancelButtonTitle: "Okay").show()
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
            else{
                let firstTextField = alert.textFields![0] as UITextField
                self.manager.verifyEmployee(UserId: "\(userID)", status: "Rejected",objection: firstTextField.text!, completionHandler: {
                    res in
                    if res
                    {
                        
                        UIAlertView(title: "Rejected", message: "Thank you", delegate: self, cancelButtonTitle: "Okay").show()
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                })
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    func loadDate()
    {
        
        DBManager.manager.getEmployee(id: empId) { (emp) in
            
            DispatchQueue.main.async(execute: {
                
                if let employee = emp {
                    self.employee = employee
                    self.nameLabel.text = employee.userName!
                    
                    if let path = self.passeddpPath
                    {
                        self.groupDownload.enter()
                        self.profileIV.sd_setIndicatorStyle(.gray)
                        self.profileIV.sd_setShowActivityIndicatorView(true)
                        self.profileIV.sd_setImage(with: URL(string: path)) { (img, error, cacheType, url) in
                            
                            //self.groupDownload.leave()
                        };
                    }
                    else
                    {
                        self.profileIV.image = self.Passdpimage
                    }
                    self.imageNameArray.append("\(employee.contactNumber!)/thumbnail-\(employee.profileImage!).jpg")
                    self.imageNameArray.append("\(employee.contactNumber!)/thumbnail-\(employee.cNICFrontImage!).jpg")
                    self.imageNameArray.append("\(employee.contactNumber!)/thumbnail-\(employee.cNICBackImage!).jpg");
                    if let docs = employee.documentPath?.components(separatedBy: ",")
                    {
                        for doc in docs
                        {
                            
                            self.imageNameArray.append("\(employee.contactNumber!)/thumbnail-\(doc).jpg");
                        }
                    }
                    
                    self.serviceArray = employee.services!.components(separatedBy: ",")
                    
                  
                    
                    (self.children[1] as! Profile1CVC).info(details: [employee.email!,employee.city!,employee.gender!,employee.dOB!,employee.accountNumber!,employee.contactNumber!])
                    (self.children[2] as! Profile2CVC).services(servicesArray: self.serviceArray)
                    (self.children[0] as! Profile3CVC).documents(docs: self.imageNameArray)
                    
                    
                    
                    
                }
                else {
                    print("theere is not employee")
                }
                
            })
        }
    }

}
extension ProfileMainVC
    
{
    
    
    func settingupsegmentcontrol()
    {
        
        tabSegmentControl.backgroundColor = .clear
        tabSegmentControl.tintColor = .clear
        
        
        tabSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        tabSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1613828242, green: 0.705992043, blue: 0.5603404641, alpha: 1)
            ], for: .selected)
        
        
        
        
        
        
        
    }
}
