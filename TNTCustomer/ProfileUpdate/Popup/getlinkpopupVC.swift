//
//  getlinkpopupVC.swift
//  Event Mangment
//
//  Created by abdul on 14/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit



class getlinkpopupVC: UIViewController {

    var delagategetlink : linkdelagate?
    
    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var linktxt: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundview.carveANDShadow()
        linktxt.borderHightLight()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func donebtn(_ sender: UIBarButtonItem)
    {
        delagategetlink?.link(link: linktxt.text)
        self.view.removeFromSuperview()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem)
    {
       self.view.removeFromSuperview()
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

