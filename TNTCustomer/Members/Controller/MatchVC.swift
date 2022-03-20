//
//  MatchVC.swift
//  TNTUserSigning
//
//  Created by Moheed Zafar on 20/06/2019.
//  Copyright © 2019 Moheed Zafar. All rights reserved.
//

import UIKit

class MatchVC: UIViewController {
    var delegate:MembersDelegate?
    
    @IBOutlet weak var backIV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(backIVTap))
        backIV.addGestureRecognizer(tap)
    }
    
    @objc func backIVTap()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func interest(_ sender: Any) {
        DBManagerMember.manager.matchMember(interest: currentMember.interests!, goal: "", industry: "", commitees: "") { (response, members) in
            
             self.dismiss(animated: true, completion: nil)
            self.delegate?.sendBackMembers(members: members as! [Member])
        }
    }
    
    @IBAction func goal(_ sender: Any) {
        DBManagerMember.manager.matchMember(interest: "", goal: currentMember.goals!, industry: "", commitees: "") { (response, members) in
            
            self.dismiss(animated: true, completion: nil)
            self.delegate?.sendBackMembers(members: members as! [Member])
        }
    }
    
    
    @IBAction func commitee(_ sender: Any) {
        DBManagerMember.manager.matchMember(interest: "", goal: "", industry: "", commitees: currentMember.commitees!) { (response, members) in
            
            self.dismiss(animated: true, completion: nil)
            self.delegate?.sendBackMembers(members: members as! [Member])
        }
        
    }
    
    @IBAction func industry(_ sender: Any) {
        DBManagerMember.manager.matchMember(interest: "", goal: "", industry: currentMember.industry!, commitees: "") { (response, members) in
            
            self.dismiss(animated: true, completion: nil)
            self.delegate?.sendBackMembers(members: members as! [Member])
            
        }
    }
}
