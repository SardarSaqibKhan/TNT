//
//  RSVPpopupVC.swift
//  UserGuestTNT
//
//  Created by abdul on 03/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit

class RSVPpopupVC: UIViewController {

    @IBOutlet weak var popupview: UIView!
    
    @IBOutlet weak var proceedbtn: UIButton!
    @IBOutlet weak var emailtxtfield: UITextField!
    @IBOutlet weak var nametxtfield: UITextField!
    
    var delagate :rsvpdelagate?
    var status = String()
    var Eventid = String()
    var hostid = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        popupview.layer.cornerRadius = 8
        proceedbtn.layer.cornerRadius = 5
        proceedbtn.layer.shadowRadius = 3
        proceedbtn.layer.shadowOpacity = 0.2
        proceedbtn.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(CGFloat(0.7))
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func crossbtn(_ sender: Any) {
        self.view.removeFromSuperview()
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func proceedbtnaction(_ sender: Any) {
        
        addtorsvp()
        
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

extension RSVPpopupVC
{
    func addtorsvp()
    {
        if nametxtfield.text == "" || emailtxtfield.text == ""
        {
            let alert = UIAlertController(title: "Attention", message: "Please Fill All Fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            DBManger.manager.addRSVP(Hostid: hostid, eventId: Eventid, name: nametxtfield.text!, email: emailtxtfield.text!, Status: status) { (res) in
            print(res)
                
                self.view.removeFromSuperview()
                self.delagate?.getrsvpresult(rsvpstatus: res, flag: true)
           // self.dismiss(animated: true, completion:  nil)
        }
        }
    }
}
