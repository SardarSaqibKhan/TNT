//
//  MemberManager.swift
//  TNTChat
//
//  Created by MacBook Pro on 28/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import Firebase

class MemberManager {
    
    static var shared = MemberManager()
    
    
    weak var delegate: MemberManagerDelegate?
    var observer: UInt?
    var currentUser: MemberUser? {
        didSet {
            delegate?.memberManager(self, didChangeUser: currentUser)
            if observer != nil && currentUser == nil {
                Database.database().reference().removeObserver(withHandle: observer!)
            }
        }
    }
    
    
    
    
    private init() { setupAuthListener() }
    
    private func setupAuthListener() {
        Auth.auth().addStateDidChangeListener { [weak self] (Auth, user) in
            self?.currentUser = nil
            if let user = user {
                self?.currentUser = MemberUser(id: user.uid, name: "", email: "")
                self?.observeDataChange(user.uid)
            }
        }
    }
    
    private func observeDataChange(_ id: String) {
        observer = Database.database().reference().child("Users/Members/\(id)").observe(.value, with: { (snapshot) in
            
            guard let json = snapshot.value as? [String:Any] else {
                return
            }
            let user = MemberUser(json: json)
            if user.id == "" {
                user.id = snapshot.key
            }
            self.currentUser = user
        }) { (error) in
            print("***UserManager.getDate Error: \(error.localizedDescription)")
        }
    }
    
    func updateUserData() {
        guard let user = currentUser else {
            return
        }
        Database.database().reference().child("Users/Members/\(String(describing: user.id))").setValue(user.jsonData())
    }
    
}


extension MemberManager {
    
    func updateUsers(_ users: [MemberUser]) {
        
        var updates: [String:Any] = [:]
        for user in users {
            updates["Users/Members/\(user.id!)"] = user.jsonData()
        }
        
        Database.database().reference().updateChildValues(updates) { (error, _) in
            
            if let error = error {
                print("***UserManager.updateUsers Error: \(error.localizedDescription)")
            }
        }
    }
}




protocol MemberManagerDelegate: class {
    func memberManager(_ userManager: MemberManager, didChangeUser user: MemberUser?)
}
