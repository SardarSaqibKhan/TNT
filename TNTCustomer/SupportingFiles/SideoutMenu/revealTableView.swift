//
//  revealTableView.swift
//  TNTAdmin
//
//  Created by MacBook Pro on 31/05/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class revealTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        var controller: UIViewController?
        switch (indexPath as NSIndexPath).row {
        case 0:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "MemberTypeVC")
        case 1:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "EventMangementVC")
        case 2:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "DatabaseManagementVC")
        case 3:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC")
        case 4:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "OpeningCameraVC")
        case 5:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "PostEventMangementVC")
        case 6:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "EventMangementVC")
        case 7:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "EventMangementVC")
        case 8:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "UpdateOptionsVC")
        case 9:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "EventMangementVC")
        case 10:
            controller = self.storyboard?.instantiateViewController(withIdentifier: "EventMangementVC")
            
        
        default: break
        }
        
        if (controller != nil) {
            let cell = tableView.cellForRow(at: indexPath)
            controller!.title = cell?.textLabel?.text
            //let navController = UINavigationController(rootViewController: controller!)
            revealViewController().pushFrontViewController(controller, animated:true)
        }
    }

}
