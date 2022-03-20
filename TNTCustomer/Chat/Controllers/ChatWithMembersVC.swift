//
//  ChatWithMembersVC.swift
//  TNTChat
//
//  Created by MacBook Pro on 21/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class ChatWithMembersVC: UIViewController {

    @IBOutlet weak var searchMessageSearchBar: UISearchBar!
    @IBOutlet weak var membersTableView: UITableView!
    
    var chats: [Chat] = []
    var members = [MemberUser]()
    var adminName = String()
    var adminEmail = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adminName = UserDefaults.standard.value(forKey: "CurrentAdminName") as? String ?? ""
        adminEmail = UserDefaults.standard.value(forKey: "CurrentAdminEmail") as? String ?? ""
        
        membersTableView.rowHeight = 76
        setTapGestures()
        setupAccount()
        //loadAllUsers()

    }
    
    func setupAccount()
    {
        try? Auth.auth().signOut()
        Auth.auth().createUser(withEmail: adminEmail, password: "123456", completion: { (result, error) -> Void in
            if (error == nil) {
                print("Account created :)")
                self.siging()
            }
                
            else{
                self.siging()
            }
        })
        
        
    }
    func siging()
    {
        Auth.auth().signIn(withEmail: adminEmail, password: "123456") { (result, error) in
            if result != nil {
                
                print(Auth.auth().currentUser!.uid)
                var cr: [AnyHashable:Any]
                {
                    return ["id" : Auth.auth().currentUser!.uid]
                }
                
                Database.database().reference().child("Users/Members/\(Auth.auth().currentUser!.uid)").updateChildValues(cr)
                self.loadAllUsers()
                print("User Has Sign In")
            }
            if error != nil {
                print(":(",error)
            }
        }
    }

   
}
extension ChatWithMembersVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatWithMembersTableCell", for: indexPath) as! ChatWithMembersTableCell
        cell.nameLabel.text = members[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = members[indexPath.row].id ?? ""
        let currentUserId = Auth.auth().currentUser!.uid
        
        let path = "Users/Members/\(currentUserId)/chatIds/\(userId)/"
        Database.database().reference().child(path).observe(.value) { (snapshot) in
            let chatID = snapshot.value as? String
            if let CID = chatID{
                Database.database().reference().child("Chats/\(CID)/").observe(.value) { (snapshot) in
                    let json = snapshot.value as! [String:Any]
                    let chat = Chat(json: json)
                    chat.id = CID;
                    self.performSegue(withIdentifier: "MemberChat", sender: (chat, self.members[indexPath.row]))
                }
            }
            else
            {
                let newId = Database.database().reference().child("Chats").childByAutoId().key!
                var chat = Chat(id: newId, user1Id: currentUserId, user2Id: userId, lastMessageId: "", timeStamp: 0)
                
                self.performSegue(withIdentifier: "MemberChat", sender: (chat, self.members[indexPath.row]))
            }
            
            
        }
        
    }
}
extension ChatWithMembersVC{
    func setTapGestures() {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(ChatWithAdminsVC.handleTap(_:)))
        self.view.addGestureRecognizer(tap1)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
}
////////////////    Loading the Recents Chat /////////////
extension ChatWithMembersVC{
    func myUser(id:String)
    {
        Database.database().reference(withPath: "Users/Members").child("\(id)").observe(.value) { (snapshot) in
            let json = snapshot.value as! [String: Any]
            MemberManager.shared.currentUser = MemberUser(json: json)
            
        }
    }
    private func loadAllUsers() {
        if let uid = Auth.auth().currentUser?.uid
        {
            myUser(id: uid)
            print(uid)
        }
        else{
            myUser(id: "943289348dkfjd")
        }
        
        Database.database().reference().child("Users/Members").observeSingleEvent(of: DataEventType.value, with: { [weak self] (snapshot) in
            
            guard let usersData = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }

            for snap in usersData {
                if snap.value != nil{

                    let user = MemberUser(json: snap.value as! [String:Any] )
                    if user.id == "" {
                        user.id = snap.key
                    }
                    if user.id != MemberManager.shared.currentUser!.id {
                        self?.members += [ user ]
                    }
                }
                DispatchQueue.main.async {
                    self?.membersTableView.reloadData()
                }
            }
            
        }) { (error) in
            print(("***AllContactsTableViewController.loadAllUsers Error: \(error.localizedDescription)"))
        }
    }
    
}

///// segue preparing
extension ChatWithMembersVC{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
            
        case "MemberChat":
            // self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
            let Nav = segue.destination as! UINavigationController
            let dastination = Nav.viewControllers.first as! MemberChat
            let data = sender as! (Chat, MemberUser)
            
            dastination.partnerMember = data.1
            dastination.chat = data.0
            dastination.type = "Member"
            
        default:
            break
        }
    }
}


class ChatWithMembersTableCell: UITableViewCell {
   
    @IBOutlet weak var dpImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var noOfUnseenMessageLabel: UILabel!
    @IBOutlet weak var backgroundview: UIView!
    
    override func awakeFromNib() {
        backgroundview.corveAllAdminView()
        noOfUnseenMessageLabel.roundLabel()
        dpImage.ProfileImageRoundImage()
    }
}
