//
//  UpdateSocialMediaVC.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 10/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class UpdateSocialMediaVC: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var socialLinkCollectionView: UICollectionView!
    
    
    var socialimagearry = [String]()
    var selectedSocialLink = [String]()
    
    var fblink :String = ""
    var twitterlink :String = ""
    var instalink:String = ""
    var linkedinlink :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingCustomDesgning()
        
    }
    
    @IBAction func update(_ sender: Any) {
        updateSocialMediaLinks()
    }
    
    
    @IBAction func addAccount(_ sender: Any) {
        let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addaccountpopupvc") as! addaccountpopupvc
        
        //popVC.dateDelegate = self
        self.addChild(popVC)
        
        popVC.createeventgetlinkdelagate = self
        // self.navigationController?.setNavigationBarHidden(true, animated: false)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        
        popVC.didMove(toParent: self)
    }
}
/////////////////////////       SETTING ALL DESGNING STUFF      //////////////////////////
extension UpdateSocialMediaVC{
    func settingCustomDesgning(){
        
        settingTapGesturesOnBackImage()
        updateButton.updationButtons()
    }
}
/////////// SETTING GESTUES ON MEMBER TYPE VIEWS  //////////////
extension UpdateSocialMediaVC{
    func settingTapGesturesOnBackImage(){
        let tapbackImage = UITapGestureRecognizer(target: self, action: #selector(UpdateSocialMediaVC.handleTapOnBackImage(_:)))
        backImage.addGestureRecognizer(tapbackImage)
        
    }
    @objc func handleTapOnBackImage(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}
//////////  COLLECTION VIEW DATASOURSE AND DELETEGAE METHOD /////////
extension UpdateSocialMediaVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialimagearry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UpdateSocialMediaCollectionViewCell
        cell.socialimg.image = UIImage(named: socialimagearry[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if socialimagearry[indexPath.row] == "icon-facebook"
        {
            fblink = ""
        }
        else if socialimagearry[indexPath.row] == "icon_instagram"
        {
            instalink = ""
        }
        else if socialimagearry[indexPath.row] == "icon_linkedin"
        {
            linkedinlink = ""
        }
        else
        {
            twitterlink = ""
        }
        socialimagearry.remove(at: indexPath.row)
        socialLinkCollectionView.reloadData()
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.width / 2 - 3
        return CGSize(width: width, height: width * 0.75  )
        //self.view.frame.width * 0.75
        
    }
}
////////////////// SOCIAL LINK DELEGAT IMPLEMENTATION //////////////////////
extension UpdateSocialMediaVC:linksdelagateCreateEvent{
    func getlink(link: String, linkof: String) {
        print(link)
        if linkof == "fb"
        {
            fblink = link
            socialimagearry.append("icon-facebook")
            socialLinkCollectionView.reloadData()
        }
        else if linkof == "insta"
        {
            instalink = link
            socialimagearry.append("icon_instagram")
            socialLinkCollectionView.reloadData()
        }
        else if linkof == "linked"
        {
            linkedinlink = link
            socialimagearry.append("icon_linkedin")
            socialLinkCollectionView.reloadData()
        }
        else
        {
            twitterlink = link
            socialimagearry.append("icon-twitter")
            socialLinkCollectionView.reloadData()
        }
    }
}
/////////// UPDATE INTERESTS   //////////////
extension UpdateSocialMediaVC{
    
    func updateSocialMediaLinks(){
        DBManagerUp.manager.UpdateSocialMedia(memberID: 1, fb: fblink, instagram: instalink, twitter: twitterlink, linkedin: linkedinlink, website: "") { (result) in
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
extension UpdateSocialMediaVC{
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
class UpdateSocialMediaCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var socialimg:UIImageView!
    
    override func awakeFromNib() {
      minusButton.roundButton()
      backgroundview.corveCorner()
    }
}
