//
//  SearchVC.swift
//  TNTDatabaseManagement
//
//  Created by Moheed Zafar Hashmi on 14/05/2019.
//  Copyright © 2019 abc company. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var goalTF: UITextField!
    @IBOutlet weak var organizationTF: UITextField!
    @IBOutlet weak var committeesTF: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    var delegate: MembersDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.dropShadow()
    }
    @IBAction func search(_ sender: Any) {
        DBManagerMember.manager.searchMember(firstName: firstNameTF.text!, lastName: lastNameTF.text!, company: companyTF.text!, goal: goalTF.text!, organization: organizationTF.text!, committees: committeesTF.text!) { (isDataFound, members) in
            if isDataFound
            {
                self.dismiss(animated: true, completion: nil)
                self.delegate?.sendBackMembers(members: members as! [Member])
            }
            else
            {
                let alert = UIAlertController(title: "No Data Found", message: "", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelSearch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "members"
        {
            let members = sender as! [Member]
            let viewController = segue.destination as! MembersVC
            viewController.members = members
        }
    }
}

