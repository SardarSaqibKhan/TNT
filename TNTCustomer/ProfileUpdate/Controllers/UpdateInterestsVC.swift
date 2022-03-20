//
//  UpdateInterestsVC.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 03/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import iOSDropDown

class UpdateInterestsVC: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var interestsSelectionTxtField: DropDown!
    @IBOutlet weak var interestsCollectionView: UICollectionView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var transformingView: UIView!
    
    
    var selectedInterestArray = [String]()
    var interests = String()
    var totalInterests = Int()
    var index = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingCustomDesgning()
    }
    
    @IBAction func update(_ sender: Any) {
        updateInterests()
    }
    
}
/////////////////////////       SETTING ALL DESGNING STUFF      //////////////////////////
extension UpdateInterestsVC{
    func settingCustomDesgning(){
        settingDropDown()
        settingTapGesturesOnBackImage()
        updateButton.updationButtons()
        
    }
}
/////////////////// SETTING DROP DOWN //////////////////////
extension UpdateInterestsVC{
    func settingDropDown(){
        // The list of array to display. Can be changed dynamically
        interestsSelectionTxtField.optionArray = ["Health", "Game", "Movies", "Music", "Reading Books"]
        //Its Id Values and its optional
        //interestsSelectionTxtField.optionIds = [1,23,54,22]
        
        // Image Array its optional
        // The the Closure returns Selected Index and String
        interestsSelectionTxtField.selectedRowColor = UIColor.init(red: 207/255, green: 145/255, blue: 63/255, alpha: 1)
        
        interestsSelectionTxtField.didSelect{(selectedText , index ,id) in
            // self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
            print("Selected String: \(selectedText) \n index: \(index)")
            if self.selectedInterestArray.contains(selectedText){
                
            }
            else{
                self.selectedInterestArray.append(selectedText)
                self.interestsCollectionView.reloadData()
            }     
        }
        
        interestsSelectionTxtField.listWillAppear() {
            //You can Do anything when iOS DropDown willAppear
            print("You can Do anything when iOS DropDown willAppear")
            
            
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCurlUp, animations: {
                self.transformingView.transform = CGAffineTransform(translationX: 0, y: 150)
                //self.backgroundView.transform = CGAffineTransform.init(scaleX: 1   , y:   1)
            }, completion: nil)
        }
        
        interestsSelectionTxtField.listDidAppear() {
            //You can Do anything when iOS DropDown listDidAppear
            print("You can Do anything when iOS DropDown listDidAppear")
        }
        
        interestsSelectionTxtField.listWillDisappear() {
            //You can Do anything when iOS DropDown listWillDisappear
            print("You can Do anything when iOS DropDown listWillDisappear")
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .transitionCurlUp, animations: {
                self.transformingView.transform = .identity
                //self.backgroundView.transform = CGAffineTransform.init(scaleX: 1   , y:   1)
            }, completion: nil)
        }
        
        interestsSelectionTxtField.listDidDisappear() {
            //You can Do anything when iOS DropDown listDidDisappear
            print("You can Do anything when iOS DropDown listDidDisappear")
        }
    }
}
/////////////////////// COLLECTION VIEW DATASOURSE AND DELEGATES /////////////////////
extension UpdateInterestsVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedInterestArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UpdateInterestsCollectionViewCell
        cell.interstLabel.text = selectedInterestArray[indexPath.row]
        cell.minusButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(UpdateInterestsVC.minusInterest(_sender:)), for: .touchUpInside)
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
extension UpdateInterestsVC{
    @objc func  minusInterest(_sender:UIButton){
        print(_sender.tag)
       let  selectedIndex = _sender.tag
        selectedInterestArray.remove(at: selectedIndex)
        DispatchQueue.main.async {
            self.interestsCollectionView.reloadData()
        }
    }
}
/////////// SETTING GESTUES ON MEMBER TYPE VIEWS  //////////////
extension UpdateInterestsVC{
    func settingTapGesturesOnBackImage(){
        let tapbackImage = UITapGestureRecognizer(target: self, action: #selector(UpdateInterestsVC.handleTapOnBackImage(_:)))
        backImage.addGestureRecognizer(tapbackImage)
        
    }
    @objc func handleTapOnBackImage(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}
/////////// UPDATE INTERESTS   //////////////
extension UpdateInterestsVC{
    
    func updateInterests(){
        interests.removeAll()
        index = 0
        totalInterests = self.selectedInterestArray.count - 1
        for item in self.selectedInterestArray{
            if self.selectedInterestArray.count == 1 {
               interests.append(item)
            }
            else{
                if index == totalInterests{
                   interests.append(item)
                }
                else{
                  interests.append("\(item),")
                }
            }
            index += 1
        }
        
        DBManagerUp.manager.UpdateInterests(memberID: 1, interests: interests) { (result) in
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
extension UpdateInterestsVC{
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
class UpdateInterestsCollectionViewCell:UICollectionViewCell{
 
    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var interstLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    
    override func awakeFromNib() {
        
        minusButton.roundButton()
        backgroundview.corveCorner()
    }
}
