//
//  GuestStartVC.swift
//  UserGuestTNT
//
//  Created by abdul on 24/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit
import PINRemoteImage
import PINCache

class GuestStartVC: UIViewController {

    @IBOutlet weak var currenteventView: UIView!
    
    @IBOutlet weak var attendingimg1: UIImageView!
    @IBOutlet weak var attendingimg2: UIImageView!
    @IBOutlet weak var attendingimg3: UIImageView!
    @IBOutlet weak var attedingcountlabel: UILabel!
    
    
    
    @IBOutlet weak var eventcalenderview: UIView!
    @IBOutlet weak var interestedimg1: UIImageView!
    @IBOutlet weak var interestedimg2: UIImageView!
    @IBOutlet weak var interestedimg3: UIImageView!
    @IBOutlet weak var interestedcountlabel: UILabel!
    
    @IBOutlet weak var upcomingeventcountLabel: UILabel!
    
    
    var date = String()
    @IBOutlet weak var jointntview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let date1 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        date = formatter.string(from: date1)
        
        setdesign()
        setGestures()
        currenteventView.carveandshadowview()
        eventcalenderview.carveandshadowview()
        jointntview.carveandshadowview()
        loaddata()
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
extension GuestStartVC
{
    func setdesign()
    {
        currenteventView.carveandshadowview()
        eventcalenderview.carveandshadowview()
        jointntview.carveandshadowview()
        
        attendingimg1.HCcircleImage()
        attendingimg2.HCcircleImage()
        attendingimg3.HCcircleImage()
        
        interestedimg1.HCcircleImage()
        interestedimg2.HCcircleImage()
        interestedimg3.HCcircleImage()
        
        getupcomingeventcount()
    }
    func loaddata()
    {
        let path="\(ftpUrlString)maxresdefault.jpg"
        print(path)
        let imgUrl = URL(string: path)
        self.attendingimg1.pin_updateWithProgress = true
        self.attendingimg1
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
        
        self.attendingimg2.pin_updateWithProgress = true
        self.attendingimg2
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
        
        self.attendingimg3.pin_updateWithProgress = true
        self.attendingimg3
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
        
        self.interestedimg1.pin_updateWithProgress = true
        self.interestedimg1
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
        
        self.interestedimg2.pin_updateWithProgress = true
        self.interestedimg2
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
        
        self.interestedimg3.pin_updateWithProgress = true
        self.interestedimg3
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
        
    }
    func setGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(GuestStartVC.handleTap(_:)))
        currenteventView.addGestureRecognizer(tap)
        
        let Eventtap = UITapGestureRecognizer(target: self, action: #selector(GuestStartVC.handleTap1(_:)))
        eventcalenderview.addGestureRecognizer(Eventtap)
        
        let jointnttap = UITapGestureRecognizer(target: self, action: #selector(GuestStartVC.handleTap2(_:)))
        jointntview.addGestureRecognizer(jointnttap)
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CurrentEventVC")
        self.present(view, animated: true, completion: nil)
        
    }
    @objc func handleTap1(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "EventMangementVC") 
        self.present(view, animated: true, completion: nil)
        print("Event Calender")
    }
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
        print("Join TNT")
    }
    
}
extension GuestStartVC
{
    func getupcomingeventcount()
    {
        DBManger.manager.getupcomingeventmonthcount(date: date) { (res, count) in
            if res
            {
                self.upcomingeventcountLabel.text = count + " Events Upcoming"
            }
        }
    }
}



