//
//  ChatWithAdminsVC.swift
//  TNTChat
//
//  Created by MacBook Pro on 21/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ChatWithAdminsVC: UIViewController {

    @IBOutlet weak var searchMessageSearchBar: UISearchBar!
    @IBOutlet weak var allAdminView: UIView!
    @IBOutlet weak var noOfAdminLabel: UILabel!
    @IBOutlet weak var adminTableView: UITableView!
    
    
    var chats: [Chat] = []
    var users = [User]()
    var adminName = String()
    var adminEmail = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adminName = UserDefaults.standard.value(forKey: "CurrentAdminName") as? String ?? ""
        adminEmail = UserDefaults.standard.value(forKey: "CurrentAdminEmail") as? String ?? ""
        
        setAllDesgning()
        adminTableView.rowHeight = 76
        setupAccount()

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
                    return ["id" : Auth.auth().currentUser!.uid,
                            "name" :self.adminName,
                            "email" :self.adminEmail,
                            "photoUrl": "",
                            "chatIds" :"",
                    
                    ]
                }
                Database.database().reference().child("Users/Admins/\(Auth.auth().currentUser!.uid)").updateChildValues(cr)
                self.loadAllUsers()
                print("User Has Sign In")
            }
            if error != nil {
                print(":(",error)
            }
        }
    }

    
}
////////////////    SETTING ALL DESNGING STUFF /////////////
extension ChatWithAdminsVC{
    func setAllDesgning(){
       
       allAdminView.corveAllAdminView()
       noOfAdminLabel.roundLabel()
       setTapGestures()
    }
    
}
////////////////    Loading the Recents Chat /////////////
extension ChatWithAdminsVC{
    func myUser(id:String)
    {
        
        Database.database().reference(withPath: "Users/Admins").child("\(id)").observe(.value) { (snapshot) in
            if let snapvalue = snapshot.value{
                let json = snapshot.value as! [String: Any]
                UserManager.shared.currentUser = User(json: json)
            }
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
        
        Database.database().reference().child("Users/Admins").observeSingleEvent(of: DataEventType.value, with: { [weak self] (snapshot) in
            
            guard let usersData = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            self?.noOfAdminLabel.text = "\(usersData.count )"
            for snap in usersData {
                
                let user = User(json: snap.value as! [String:Any])
                if user.id == "" {
                    user.id = snap.key
                }
                if user.id != UserManager.shared.currentUser!.id {
                    self?.users += [ user ]
                }
                
            }
            self?.adminTableView.reloadData()
            
        }) { (error) in
            print(("***AllContactsTableViewController.loadAllUsers Error: \(error.localizedDescription)"))
        }
    }
    
}

extension ChatWithAdminsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatWithAdminsTableCell", for: indexPath) as! ChatWithAdminsTableCell
        cell.adminNameLabel.text = users[indexPath.row].name ?? ""
        //cell.adminNameLabel.text = chats[indexPath.row].lastMessage
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = users[indexPath.row].id ?? ""
        let currentUserId = Auth.auth().currentUser!.uid
        
        let path = "Users/\(currentUserId)/chatIds/\(userId)/"
        Database.database().reference().child(path).observe(.value) { (snapshot) in
            let chatID = snapshot.value as? String
            if let CID = chatID{
                Database.database().reference().child("Chats/\(CID)/").observe(.value) { (snapshot) in
                    let json = snapshot.value as! [String:Any]
                    let chat = Chat(json: json)
                    chat.id = CID;
                    self.performSegue(withIdentifier: "MyChatVC", sender: (chat, self.users[indexPath.row]))
                }
            }
            else
            {
                let newId = Database.database().reference().child("Chats").childByAutoId().key!
                var chat = Chat(id: newId, user1Id: currentUserId, user2Id: userId, lastMessageId: "", timeStamp: 0)
    
                 self.performSegue(withIdentifier: "MyChatVC", sender: (chat, self.users[indexPath.row]))
            }
            
            
        }
       
    }
    
}
///// segue preparing
extension ChatWithAdminsVC{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
            
        case "MyChatVC":
            // self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
            let Nav = segue.destination as! UINavigationController
            let dastination = Nav.viewControllers.first as! MyChatVC
            let data = sender as! (Chat, User)
            
            dastination.partnerUser = data.1
            dastination.chat = data.0
            dastination.type = "Admin"
            
        default:
            break
        }
    }
}
extension ChatWithAdminsVC{
    func setTapGestures() {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(ChatWithAdminsVC.handleTap(_:)))
        self.view.addGestureRecognizer(tap1)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
  
}
class ChatWithAdminsTableCell: UITableViewCell {
    
    
    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var adminNameLabel: UILabel!
    
    override func awakeFromNib() {
        backgroundview.corveAllAdminView()
    }
}
