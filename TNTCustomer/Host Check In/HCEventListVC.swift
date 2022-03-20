//
//  HCEventListVC.swift
//  UserGuestTNT
//
//  Created by abdul on 12/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit

class HCEventListVC: UIViewController {

    @IBOutlet weak var membersTV: UITableView!
    //var members = [Member]()
    var event = [HCEvent]()
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
extension HCEventListVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return event.count
        return 10
    }
    
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell") as! EventListCell
        //cell.nameLabel.text = event[indexPath.row].EventTitle
        
            return cell
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HCEventviewVC") as! HCEventviewVC
        self.present(vc, animated: true, completion: nil)
    }
    
    
   
}
class EventListCell: UITableViewCell
{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberPhoto: UIImageView!
    @IBOutlet weak var bgView: UIView!
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
    HCDBManger.manager.geteventattendenceofmember(MemberID: 1) { (res, eventresult) in
        if res
        {
            self.event = eventresult!
            self.membersTV.reloadData()
        }
    }
    }
}
