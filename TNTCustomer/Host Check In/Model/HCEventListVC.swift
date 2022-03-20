//
//  HCEventListVC.swift
//  UserGuestTNT
//
//  Created by abdul on 12/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit
import IHProgressHUD

class HCEventListVC: UIViewController {
    

    @IBOutlet weak var menubutton: UIBarButtonItem!
    @IBOutlet weak var membersTV: UITableView!
    //var members = [Member]()
    var event = [HCEvent]()
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        IHProgressHUD.show()
        if Connectivity.isConnectedToInternet {
            
             getattendence()
        }
        else{
            
            IHProgressHUD.dismiss()
            showToasts(message: "Network Not Found.!\nPlease Try Again Later.!", senderView: self)
        }
       
        sideout_menu()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.membersTV.reloadData()
    }
}
extension HCEventListVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return event.count
        return event.count
    }
    
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell") as! EventListCell
        cell.nameLabel.text = event[indexPath.row].EventTitle
        cell.datelabel.text = event[indexPath.row].EventDate
        cell.hostnamelabel.text = event[indexPath.row].EventHostName
        let path="\(ftpIP)\(event[indexPath.row].EventHostProfileImage)"
        print(path)
        let imgUrl = URL(string: path)
        cell.memberPhoto.pin_updateWithProgress = true
        cell.memberPhoto
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "avatar"))
        
            return cell
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HCEventviewVC") as! HCEventviewVC
        vc.event = event[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    
   
}

///////////////////////   SIDE OUT MENU /////////////////////////////////
extension HCEventListVC{
    func sideout_menu()
    {
        if revealViewController() != nil
        {
            menubutton.target = revealViewController()
            menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = self.view.frame.width * 0.75
            //275  160
            revealViewController()?.rightViewRevealWidth = self.view.frame.width * 0.25
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
        
    }
}


class EventListCell: UITableViewCell
{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberPhoto: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var hostnamelabel: UILabel!
    
    @IBOutlet weak var datelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       bgView.HCcurveView()
        bgView.HCborderformembercell()
       memberPhoto.HCcircleImage()
    }
}

extension HCEventListVC
{
  func getattendence()
  {
    
    HCDBManger.manager.geteventattendenceofmember(MemberID: 7) { (res, eventresult) in
        if res
        {
            IHProgressHUD.dismiss()
            self.event = eventresult!
            self.membersTV.reloadData()
        }
        else{
            IHProgressHUD.dismiss()
        }
      }
    }
}
