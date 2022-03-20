//
//  ECRsvpPopupVC.swift
//  UserGuestTNT
//
//  Created by abdul on 11/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit

class ECRsvpPopupVC: UIViewController {

    @IBOutlet weak var popview: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var okbtn: UIButton!
    var rsvpreturnvalue = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        if rsvpreturnvalue == "Added"
        {
          label.text = "You have Sucessfully RSVP for this event"
        }
        else
        {
            label.text = "Already RSVP for this Event"
        }
        popview.layer.cornerRadius = 8
        okbtn.layer.cornerRadius = 5
        okbtn.layer.shadowRadius = 3
        okbtn.layer.shadowOpacity = 0.2
        okbtn.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(CGFloat(0.7))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okbtnaction(_ sender: Any) {
       // self.view.removeFromSuperview()
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
