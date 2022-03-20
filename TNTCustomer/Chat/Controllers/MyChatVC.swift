//
//  MyChatVC.swift
//  TNTChat
//
//  Created by MacBook Pro on 21/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import Firebase
import MessageKit
import MessageInputBar

class MyChatVC: MessagesViewController {

    var chat: Chat! { didSet { getChatHistory() } }
    var partnerUser: User!
    let currentUser = UserManager.shared.currentUser!
    
    
    
    var messages: [Message] = []
    var type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = partnerUser?.name ?? ""
     
            postToken()
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        (messagesCollectionView.inputAccessoryView as? MessageInputBar)?.delegate = self
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.attributedTextMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.attributedTextMessageSizeCalculator.incomingAvatarSize = .zero
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
            layout.photoMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.photoMessageSizeCalculator.incomingAvatarSize = .zero
            layout.videoMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.videoMessageSizeCalculator.incomingAvatarSize = .zero
            layout.locationMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.locationMessageSizeCalculator.incomingAvatarSize = .zero
            layout.emojiMessageSizeCalculator.incomingAvatarSize = .zero
            layout.emojiMessageSizeCalculator.outgoingAvatarSize = .zero
        }
        
        addKeyboardNotifications()
        fixNavStackOrder()
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
   
         private func addKeyboardNotifications() {
                        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppearanceChanged(notification:)),
                                                                                                                                                                     name:UIResponder.keyboardDidHideNotification, object: nil)
                        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppearanceChanged(notification:)),
                                                                                                                                                                     name: UIResponder.keyboardDidShowNotification, object: nil)
                }
    
    private func fixNavStackOrder() {
        if let index = navigationController?.viewControllers.firstIndex(where: {$0 is ChatWithAdminsVC}) {
            var vcs = navigationController!.viewControllers
            vcs.remove(at: index)
            navigationController?.viewControllers = vcs
        }
    }
    
    @objc func keyboardAppearanceChanged(notification: Notification) {
        self.messagesCollectionView.scrollToBottom(animated: true)
    }
    
    private func buttonSendTapped(_ text: String) {
        
       
           sendMessageToAdmin(message: text)
           saveChatToDB()
       
    }
    
    private func getChatHistory() {
        //  chat.id = "-LbYEe6elNOtLsX3wpy-"
        
        Database.database().reference().child("ChatMessages/\(chat.id)/").observe(.childAdded, with: { (snapshot) in
            
            guard let json = snapshot.value as? [String:Any] else {
                return
            }
            
            let message = Message(json: json)
            if message.id == "" {
                message.id = snapshot.key
            }
            
            self.messages += [ message ]
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom(animated: true)
            //            self.tableView.reloadRows(at: [IndexPath(row: self.messages.count-1, section: 0)], with: .fade)
        }) { (error) in
            print("***ChatTableViewController.getChatHistory Error: \(error.localizedDescription)")
        }
    }

    @IBAction func Done(_ sender: Any) {

        self.performSegue(withIdentifier: "animationsegue", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animationsegue"{
            
        }
    }
}

// MARK: - Message data source
extension MyChatVC: MessagesDataSource {
    
    func currentSender() -> Sender {
        return Sender(id: currentUser.id!, displayName: currentUser.name!)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}


// MARK: - Message Input Bar delegate
extension MyChatVC: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = text.trimmingCharacters(in: [" "])
        if message == "" {
            return
        }
        buttonSendTapped(message)
        inputBar.inputTextView.text = ""
    }
}

extension MyChatVC: MessagesDisplayDelegate, MessagesLayoutDelegate {
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
}
//////////////////////////////////////////////////////////////////////////////////
///////////////////////// POST TOKEN OF ADMIN & SENDING MESSAGES TO ADMIN////////
//////////////////////////////////////////////////////////////////////////////////
extension MyChatVC{
    
    private func postToken()
    {
        if let refreshedToken = InstanceID.instanceID().token() {//1Open
            print("==========================================================================Chat-InstanceID TokenExist===============: \(refreshedToken)")
            if let id = Auth.auth().currentUser?.uid{       //2Open
                print("current User Exist");
                if let user = UserDefaults.standard.string(forKey: "user") //3Open
                {
                    print("User in UD Exist");
                    print("User in UD:\(user)")
                    if(user == Auth.auth().currentUser!.uid) //4Open
                    {
                        print("user in UD and Current user matched");
                        UserDefaults.standard.set(refreshedToken as Any?, forKey: "token");
                        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["fcmToken":refreshedToken]);
                    }
                    else{ //4Closed
                        print("user in ud and current user not matched");
                        Database.database().reference().child("Users").child(user).updateChildValues(["fcmToken":""]);
                        Database.database().reference().child("Users").child(id).child("fcmToken").setValue(refreshedToken);
                        UserDefaults.standard.set(refreshedToken as Any?, forKey: "token");
                        UserDefaults.standard.set(id as Any?, forKey: "user");
                        
                    }
                }
                else{   //3Closed
                    print("user not exist in UD");
                    UserDefaults.standard.set(refreshedToken as Any?, forKey: "token");
                    UserDefaults.standard.set(id as Any?, forKey: "user");
                    Database.database().reference().child("Users").child(id).child("fcmToken").setValue(refreshedToken);
                }
            }
            else{
                print("Current User not Exist");
                UserDefaults.standard.set(refreshedToken as Any?, forKey: "token")
            }
        }
        else {//1C
            print("Token not Fount");
        }
        //  Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    func sendMessageToAdmin(message:String){
        let message = Message(id: "", toId: partnerUser.id!, fromId: currentUser.id!, message: message, timeStamp: Date().timeIntervalSince1970, chatId: chat.id)
        message.id = Database.database().reference().child("ChatMessages/\(chat.id)").childByAutoId().key!
        
        if chat.lastMessage == "" {
            // new chat. Add it to users chatIds
            currentUser.addChatID(key: partnerUser.id!,value: chat.id)
            partnerUser.addChatID(key: currentUser.id!,value: chat.id)
            
            UserManager.shared.updateUsers([currentUser, partnerUser])
        }
        chat.lastMessage = message.message
        chat.timeStamp = message.timeStamp
        Database.database().reference().child("Chats/\(chat.id)").setValue(chat.jsonData()) { (error, _) in
            
            if let error = error {
                print("***ChatTableViewController.buttonSendTapped Error: \(error.localizedDescription)")
            }
        }
        //        chat.lastMessage = message.id
        Database.database().reference().child("ChatMessages/\(chat.id)/\(message.id)").setValue(message.jsonData())
    }
    func saveChatToDB(){
        DBManagerChat.manager.AddChatMessage(senderID: 1, reciverID: 0, message: "hello first") { (result) in
            if result {
                print("saved")
            }
            else{
                print("not saved ")
            }
        }
    }
}


