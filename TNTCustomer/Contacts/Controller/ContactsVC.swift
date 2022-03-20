//
//  ContactsVC.swift
//  TNTUserSigning
//
//  Created by Moheed Zafar on 25/06/2019.
//  Copyright © 2019 Moheed Zafar. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {

    @IBOutlet weak var contactsTV: UITableView!
    @IBOutlet weak var searchView: UILabel!
    
    var members = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DBManagerMember.manager.searchMember(firstName: "", lastName: "", company: "", goal: "", organization: "", committees: "") { (response, members) in
//            if response
//            {
//                self.members = members as! [Member]
//                DispatchQueue.main.async(execute: {
//                    self.contactsTV.reloadData()
//                })
//            }
//            else
//            { print("Member Module- No member Fetched ") }
//        }
        DBManagerContacts.manager.getContacts(memberID:7, firstName: "", lastName: "", industry: "", goal: "", organization: "", committees: "") { (response, members) in
            if response
            {
                self.members = members as! [Member]
                DispatchQueue.main.async(execute: {
                    self.contactsTV.reloadData()
                })
            }
            else
            { print("Member Module- No member Fetched ") }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToSearch))
        searchView.addGestureRecognizer(tapGesture)
        searchView.curveCorner(color: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1) )
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
        else if segue.identifier! == "SaveContact"
        {
            var saveContactVC = segue.destination as! SaveContactVC
            saveContactVC.currentMember = currentMember
        }
      
        
    }
}
extension ContactsVC:MembersDelegate
{
    func sendBackMembers(members: [Member]) {
        self.members = members
        DispatchQueue.main.async{  self.contactsTV.reloadData() }
    }
    
    
}

extension ContactsVC:UITableViewDelegate,UITableViewDataSource
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
        
        return 80
        
    }
    
}

