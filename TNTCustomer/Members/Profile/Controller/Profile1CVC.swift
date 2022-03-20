//
//  Profile1CVC.swift
//  HatabaAdmin
//
//  Created by Moheed Zafar on 18/07/2019.
//  Copyright © 2019 abc company. All rights reserved.
//

import UIKit

class Profile1CVC: UIViewController {

    @IBOutlet weak var personalInfoTV: UITableView!
    var labels = [ "EMAIL ADDRESS", "CITY", "GENDER" , "DOB", "ACCOUNT NO", "CONTACT NO" ]
    var detailsLabel = [ "Paul.cover@gmail.com", "Rawalpindi", "Male" , "12-12-2002", "1234 7834 2345 2354", "+92 3410909234" ]

    func info(details:[String])
    {
        self.detailsLabel = details
        
        DispatchQueue.main.async {
           self.personalInfoTV.reloadData()
        }
    }

}
extension Profile1CVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.detailTextLabel?.text = detailsLabel[indexPath.row]
        cell?.textLabel?.text = labels[indexPath.row]
        return cell!
    }
}
