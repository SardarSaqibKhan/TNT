//
//  UpdateCommitteesVC.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 10/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class UpdateCommitteesVC: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var committeesTableView: UITableView!
    @IBOutlet weak var updateButton: UIButton!
    
    let committeesArray = ["Events","Membership","Sponsorship","Community Engagment","Communication","Finance"]
    var commitees = [Commitee]()
    var selectedCommitteesArray = [String]()
    var committees = String()
    var totalCommittees = Int()
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commitees = Commitee.commitees()
        settingCustomDesgning()
    }
    
    @IBAction func update(_ sender: Any) {
        updateCommittees()
    }
}
/////////////////////////       SETTING ALL DESGNING STUFF      //////////////////////////
extension UpdateCommitteesVC{
    func settingCustomDesgning(){
        
        committeesTableView.rowHeight = 65
        settingTapGesturesOnBackImage()
        updateButton.updationButtons()
        
    }
}

extension UpdateCommitteesVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  commitees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UpdateCommitteesTableCell
        cell.orgnameLabel.text = commitees[indexPath.row].text
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UpdateCommitteesTableCell
        if commitees[indexPath.row].status
        {
            cell.checkORuncheckImage.image = UIImage(named: "uncheckmark")
            commitees[indexPath.row].status = false
        }
        else
        {
            cell.checkORuncheckImage.image = UIImage(named: "checkmark")
            commitees[indexPath.row].status = true
        }
    }
    
}
/////////// UPDATE Committees   //////////////
extension UpdateCommitteesVC{
    func updateCommittees(){
        
        
        selectedCommitteesArray.removeAll()
        for item in commitees{
            if item.status{
                self.selectedCommitteesArray.append(item.text)
            }
        }
        
        committees.removeAll()
        index = 0
        totalCommittees = self.selectedCommitteesArray.count - 1
        for item in self.selectedCommitteesArray{
            if self.selectedCommitteesArray.count == 1 {
                committees.append(item)
            }
            else{
                if index == totalCommittees{
                    committees.append(item)
                }
                else{
                    committees.append("\(item),")
                }
            }
            index += 1
        }
        
        DBManagerUp.manager.UpdateTNTCommittees(memberID: 1, TNTCommittees: committees) { (result) in
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
/////////// SETTING GESTUES ON MEMBER TYPE VIEWS  //////////////
extension UpdateCommitteesVC{
    func settingTapGesturesOnBackImage(){
        let tapbackImage = UITapGestureRecognizer(target: self, action: #selector(UpdateCommitteesVC.handleTapOnBackImage(_:)))
        backImage.addGestureRecognizer(tapbackImage)
        
    }
    @objc func handleTapOnBackImage(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}
///////////////////////////// SHOWING SUCCESS MESSAGE  //////////////////////////////
extension UpdateCommitteesVC{
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
class UpdateCommitteesTableCell: UITableViewCell {
    
    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var orgnameLabel: UILabel!
    @IBOutlet weak var checkORuncheckImage: UIImageView!
    
    
    override func awakeFromNib() {
        backgroundview.corveCorner()
        checkORuncheckImage.roundProfileImage()
    }
}
