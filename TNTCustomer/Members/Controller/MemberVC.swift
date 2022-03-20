//
//  MembersVC.swift
//  TNTDatabaseManagement
//
//  Created by Moheed Zafar Hashmi on 14/05/2019.
//  Copyright © 2019 abc company. All rights reserved.
//

import UIKit
var currentMember = Member(ID: 333, firstName: "saqib Khan", lastName: "Khan", email: "ali@gmail.com", profileImage: "img.jpg", contactNumber: "090078601", password: "123456", type: "Existing", expiryDate: "1/1/2020 12:00:00 AM", industry: "Dell", company: "signup", address: "Islamabad", countryCode: "+111", interests: "wish", goals: "", commitees: "", boards: "", fb: "", instagram: "", twitter: "", linkedIn: "", website:"")

class MembersVC: UIViewController {
    
    @IBOutlet weak var searchBG: UIView!
    @IBOutlet weak var membersTV: UITableView!
    var members = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBManagerMember.manager.searchMember(firstName: "", lastName: "", company: "", goal: "", organization: "", committees: "") { (response, members) in
            if response
            {
                self.members = members as! [Member]
                DispatchQueue.main.async(execute: {
                    self.membersTV.reloadData()
                })
            }
            else
            { print("Member Module- No member Fetched ") }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToSearch))
        searchBG.addGestureRecognizer(tapGesture)
        searchBG.curveCorner(color: #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.9607843137, alpha: 1) )
    }
    
    @objc func goToSearch()
    {
          performSegue(withIdentifier: "search", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search"
        {
            var searchVC = segue.destination as! SearchVC
            searchVC.delegate = self
        }
        else if segue.identifier! == "MatchBy"
        {
            var matchVC = segue.destination as! MatchVC
            matchVC.delegate = self
        }
        if segue.identifier == "memberProfile"
        {
            (segue.destination as! MemberProfileVC).member = (sender as! Member)
        }
        
    }
}
extension MembersVC:MembersDelegate
{
    func sendBackMembers(members: [Member]) {
        self.members = members
        DispatchQueue.main.async{  self.membersTV.reloadData() }
    }
    
    
}

extension MembersVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membersCell") as! MembersCell
        cell.nameLabel.text = "\(String(describing: members[indexPath.row].firstName!)) \(String(describing: members[indexPath.row].lastName!))"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "memberProfile", sender: members[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
}
class MembersCell: UITableViewCell
{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberPhoto: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.curveView()
        memberPhoto.circleImage()
    }
}



