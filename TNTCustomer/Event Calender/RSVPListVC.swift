//
//  RSVPListVC.swift
//  UserGuestTNT
//
//  Created by abdul on 11/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit

class RSVPListVC: UIViewController {

    @IBOutlet weak var membersTV: UITableView!
    //var members = [Member]()
    
    override func viewDidLoad() {
        getrsvplist()
    }
    var eventid = String()
    var rsvps = [Rsvp]()
    var attendingarray = [Rsvp]()
    var intersetedarray = [Rsvp]()
    var titlearray = ["",""]
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
extension RSVPListVC:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return attendingarray.count
        }
        else{
            return intersetedarray.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titlearray[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RSVPListCell") as! RSVPListCell
            cell.nameLabel.text = attendingarray[indexPath.row].Name
            
            
            CEDBManger.manager.GetExistingMemberByID(memberID: (attendingarray[indexPath.row].memberid)) { (res, member) in
                if res
                {
                    let path = "\(ftpIP)\(member?.profileImage)"
                    print(path)
                    let imgUrl = URL(string: path)
                    cell.memberPhoto.pin_updateWithProgress = true
                    cell.memberPhoto
                        .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "avatar"))
                    
                }
                else
                {
                    cell.memberPhoto.image = UIImage(named: "avatar")
                    
                }
            }
            
            
//            let path="ftp://192.168.100.23:9099/Images/maxresdefault.jpg"
//            print(path)
//            let imgUrl = URL(string: path)
//            cell.memberPhoto.pin_updateWithProgress = true
//            cell.memberPhoto
//                .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RSVPListCell") as! RSVPListCell
            cell.nameLabel.text = intersetedarray[indexPath.row].Name
           
            CEDBManger.manager.GetExistingMemberByID(memberID: (intersetedarray[indexPath.row].memberid)) { (res, member) in
                if res
                {
                    let path = "\(ftpIP)\(member?.profileImage)"
                    print(path)
                    let imgUrl = URL(string: path)
                    cell.memberPhoto.pin_updateWithProgress = true
                    cell.memberPhoto
                        .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "avatar"))
                    
                }
                else
                {
                    cell.memberPhoto.image = UIImage(named: "avatar")
                    
                }
            }
            
//            let path="ftp://192.168.100.23:9099/Images/maxresdefault.jpg"
//            print(path)
//            let imgUrl = URL(string: path)
//            cell.memberPhoto.pin_updateWithProgress = true
//            cell.memberPhoto
//                .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
            //        cell.nameLabel.text = "\(String(describing: members[indexPath.row].FirstName!)) \(String(describing: members[indexPath.row].LastName!))"
            return cell
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
 func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        header.textLabel?.textColor = .black
    
    
    
    
       // header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
            let headerView = UITableViewHeaderFooterView()
            headerView.backgroundView?.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.9607843137, alpha: 1)
            let label = createHeaderLabel(section)
            label.autoresizingMask = [.flexibleHeight]
            headerView.addSubview(label)
            
            return headerView
        
    }
    
    func createHeaderLabel(_ section: Int)->UILabel {
        
        let widthPadding: CGFloat = 20.0
        let label: UILabel = UILabel(frame: CGRect(x: widthPadding, y: 0, width: self.view.frame.width - widthPadding, height: 0))
        if section == 0
        {
            label.text = "Attending"
        }
        else{
            label.text = "Interested"
        }
        
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignment.left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        //UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) //use your own font here - this font is for accessibility
        return label
    }
}
class RSVPListCell: UITableViewCell
{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberPhoto: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.ECcurveView()
        bgView.ECborderformembercell()
        memberPhoto.ECcircleImage()
    }
}

extension RSVPListVC
{
    func getrsvplist()
    {
        ECDBManger.manager.getrsvplist(eventid: eventid) { (res, rsvplist) in
            if res
            {
            self.rsvps = rsvplist!
            for a in self.rsvps
            {
                if a.Status == "Going" || a.Status == "going"
                {
                    self.attendingarray.append(a)
                }
                else  if a.Status == "Interseted" || a.Status == "interseted"
                {
                    self.intersetedarray.append(a)
                }
                
            }
            self.membersTV.reloadData()
        }
        }
    }
    
}
