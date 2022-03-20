//
//  NotificationsVC.swift
//  TNTNotification
//
//  Created by MacBook Pro on 15/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {

    @IBOutlet weak var notficationsTableView: UITableView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        notficationsTableView.rowHeight = 100
        sideout_menu()
        
    }

}
/////////////// TABLEVIEW DATASOURSE ///////////
extension NotificationsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationsTableCell
        cell.nameLabel.text = "Saqib sent a message"
        return cell
    }
   
}
extension NotificationsVC{
    func sideout_menu()
    {
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = self.view.frame.width * 0.75
            //275  160
            revealViewController()?.rightViewRevealWidth = self.view.frame.width * 0.25
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
        
    }
}

class NotificationsTableCell:UITableViewCell{
    
   
    @IBOutlet weak var cellbackgroundview: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    
    
    override func awakeFromNib() {
        cellbackgroundview.carveNotificationView()
        whiteView.roundView()
    }
    
}
