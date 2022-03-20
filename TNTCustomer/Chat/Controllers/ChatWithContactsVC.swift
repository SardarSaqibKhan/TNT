//
//  ChatWithContactsVC.swift
//  TNTChat
//
//  Created by MacBook Pro on 21/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase




class ChatWithContactsVC: UIViewController {

    @IBOutlet weak var contactTableView: UITableView!
    
    var members  = [Member]()
    var chats: [Chat] = []
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.rowHeight = 76
        setTapGestures()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAllMembers()
    }
}
extension ChatWithContactsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatWithContactsTableCell", for: indexPath) as! ChatWithContactsTableCell
        
//        let path="\(ftpIP)/images/maxresdefault.JPG"
//        print(path)
//        let imgUrl = URL(string: path)
//        cell.dpImage.pin_updateWithProgress = true
//        cell.dpImage.pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "hataba-avatar"))
        
        cell.nameLabel.text = "\(members[indexPath.row].FirstName ?? "") \(members[indexPath.row].LastName ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }

}
extension ChatWithContactsVC{
    func setTapGestures() {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(ChatWithContactsVC.handleTap(_:)))
        self.view.addGestureRecognizer(tap1)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
}
//////////////////////// GET ALL MEMBERS ////////////
extension ChatWithContactsVC{
    func getAllMembers(){
        DBManagerChat.manager.GetAllMembers { (members) in
            if members?.count != 0 {
                self.members = members!
                DispatchQueue.main.async(execute: {
                  self.contactTableView.reloadData()
                })
            }
        }
    }
}
class ChatWithContactsTableCell: UITableViewCell {
    
    @IBOutlet weak var dpImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundview: UIView!
    
    
    override func awakeFromNib() {
        backgroundview.corveAllAdminView()
        dpImage.ProfileImageRoundImage()
        
    }
}
