//
//  UpdateOrganizationBoardsVC.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 10/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import iOSDropDown

class UpdateOrganizationBoardsVC: UIViewController {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var orgSelectionTxtField: DropDown!
    @IBOutlet weak var orgORboardCollectionView: UICollectionView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var transformingView: UIView!
    
    var selectedOrgArray = [String]()
    var organizations = String()
    var totalOrg = Int()
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingCustomDesgning()
    }
 
    @IBAction func update(_ sender: Any) {
        updateOrganizations()
    }
}
/////////////////////////       SETTING ALL DESGNING STUFF      //////////////////////////
extension UpdateOrganizationBoardsVC{
    func settingCustomDesgning(){
        settingDropDown()
        settingTapGesturesOnBackImage()
        updateButton.updationButtons()
        
    }
}
/////////////////// SETTING DROP DOWN //////////////////////
extension UpdateOrganizationBoardsVC{
    func settingDropDown(){
        // The list of array to display. Can be changed dynamically
        orgSelectionTxtField.optionArray = ["Unicef", "Microsoft", "Apple", "SignUp"]
        //Its Id Values and its optional
        //interestsSelectionTxtField.optionIds = [1,23,54,22]
        orgSelectionTxtField.placeholder = "Select Organization/Goals"
        // Image Array its optional
        // The the Closure returns Selected Index and String
        orgSelectionTxtField.selectedRowColor = UIColor.init(red: 207/255, green: 145/255, blue: 63/255, alpha: 1)
        
        orgSelectionTxtField.didSelect{(selectedText , index ,id) in
            // self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
            print("Selected String: \(selectedText) \n index: \(index)")
            if self.selectedOrgArray.contains(selectedText){
                
            }
            else{
                self.selectedOrgArray.append(selectedText)
                self.orgORboardCollectionView.reloadData()
            }
        }
       
        orgSelectionTxtField.listWillAppear() {
            //You can Do anything when iOS DropDown willAppear
            print("You can Do anything when iOS DropDown willAppear")
            
           
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCurlUp, animations: {
                self.transformingView.transform = CGAffineTransform(translationX: 0, y: 120)
                //self.backgroundView.transform = CGAffineTransform.init(scaleX: 1   , y:   1)
            }, completion: nil)
        }
        
        orgSelectionTxtField.listDidAppear() {
            //You can Do anything when iOS DropDown listDidAppear
            print("You can Do anything when iOS DropDown listDidAppear")
        }
        
        orgSelectionTxtField.listWillDisappear() {
            //You can Do anything when iOS DropDown listWillDisappear
            print("You can Do anything when iOS DropDown listWillDisappear")
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .transitionCurlUp, animations: {
                self.transformingView.transform = .identity
                //self.backgroundView.transform = CGAffineTransform.init(scaleX: 1   , y:   1)
            }, completion: nil)
        }
        
        orgSelectionTxtField.listDidDisappear() {
            //You can Do anything when iOS DropDown listDidDisappear
            print("You can Do anything when iOS DropDown listDidDisappear")
        }
    }
   
}
/////////////////////// COLLECTION VIEW DATASOURSE AND DELEGATES /////////////////////
extension UpdateOrganizationBoardsVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedOrgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UpdateOrganizationBoardsCollectionViewCell
        cell.orgLabel.text = selectedOrgArray[indexPath.row]
        cell.minusButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(UpdateOrganizationBoardsVC.minusInterest(_sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.width / 3 - 3
        return CGSize(width: width, height: width * 0.75  )
        //self.view.frame.width * 0.75
        
    }
}
////////////// MINUS THE INTERESTS ////////////////////
extension UpdateOrganizationBoardsVC{
    @objc func  minusInterest(_sender:UIButton){
        print(_sender.tag)
        let  selectedIndex = _sender.tag
        selectedOrgArray.remove(at: selectedIndex)
        DispatchQueue.main.async {
            self.orgORboardCollectionView.reloadData()
        }
        
    }
}
/////////// SETTING GESTUES ON MEMBER TYPE VIEWS  //////////////
extension UpdateOrganizationBoardsVC{
    func settingTapGesturesOnBackImage(){
        let tapbackImage = UITapGestureRecognizer(target: self, action: #selector(UpdateOrganizationBoardsVC.handleTapOnBackImage(_:)))
        backImage.addGestureRecognizer(tapbackImage)
        
    }
    @objc func handleTapOnBackImage(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}

/////////// UPDATE INTERESTS   //////////////
extension UpdateOrganizationBoardsVC{
    
    func updateOrganizations(){
        organizations.removeAll()
        index = 0
        totalOrg = self.selectedOrgArray.count - 1
        for item in self.selectedOrgArray{
            if self.selectedOrgArray.count == 1 {
                organizations.append(item)
            }
            else{
                if index == totalOrg{
                    organizations.append(item)
                }
                else{
                    organizations.append("\(item),")
                }
            }
            index += 1
        }
        DBManagerUp.manager.UpdateOrganizations(memberID: 1, organizations: organizations) { (result) in
            if result{
                print("updated successfully")
                self.showTooast(message: "Updated Successfully.!!", emoji:"🙂")
            }
            else{
                print("Not updated")
                self.showTooast(message: "Not Updated.!!", emoji:"😒")
            }
        }
    }
}
///////////////////////////// SHOWING SUCCESS MESSAGE  //////////////////////////////
extension UpdateOrganizationBoardsVC{
    func showTooast(message:String,emoji:String){
        
        let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateSuccessPopUp") as! UpdateSuccessPopUp
        
        
        popVC.message = message
        popVC.emoji = emoji
        self.addChild(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
        
        
    }
}
///////////////////////////// COLLECTION VIEW CELL CLASSS /////////////////////////////////////
class UpdateOrganizationBoardsCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var backgroundview: UIView!
    
    @IBOutlet weak var orgLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    
    
    override func awakeFromNib() {
        
        minusButton.roundButton()
        backgroundview.corveCorner()
    }
}
