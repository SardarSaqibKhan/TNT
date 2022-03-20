//
//  addaccountpopupvc.swift
//  Event Mangment
//
//  Created by abdul on 08/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit
protocol linkdelagate : class {
    func link(link : String )
}

class addaccountpopupvc: UIViewController {

    //flagforlink
    var fb = false , insta = false , twitter = false , linkedin = false
    
    var createeventgetlinkdelagate : linksdelagateCreateEvent?
    
    //views
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var fbview: UIView!
    @IBOutlet weak var twitterview: UIView!
    @IBOutlet weak var linkview: UIView!
    @IBOutlet weak var instaview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         fbview.roundBuiltView()
         twitterview.roundBuiltView()
         linkview.roundBuiltView()
         instaview.roundBuiltView()
        settingtap()
         self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        mainview.carveANDShadow()
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
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
extension addaccountpopupvc
{
    func settingtap(){
        let tapfb = UITapGestureRecognizer(target: self, action: #selector(self.fbtap(_:)))
        let taptwitter = UITapGestureRecognizer(target: self, action: #selector(self.twittertab(_:)))
        let tapinsta = UITapGestureRecognizer(target: self, action: #selector(self.instatab(_:)))
        let taplinkedin = UITapGestureRecognizer(target: self, action: #selector(self.linkedintab(_:)))
        
        fbview.addGestureRecognizer(tapfb)
        instaview.addGestureRecognizer(tapinsta)
        twitterview.addGestureRecognizer(taptwitter)
        linkview.addGestureRecognizer(taplinkedin)
        
    }
    
    @objc func fbtap(_ sender: UITapGestureRecognizer) {
         fb = true
        insta = false
        twitter = false
        linkedin = false
        movetogetlinkpopup()
        
    }
    @objc func instatab(_ sender : UITapGestureRecognizer)
    {
        fb = false
        insta = true
        twitter = false
        linkedin = false
        movetogetlinkpopup()
    }
    @objc func twittertab(_ sender : UITapGestureRecognizer)
    {
        fb = false
        insta = false
        twitter = true
        linkedin = false
        movetogetlinkpopup()
        
    }
    @objc func linkedintab(_ sender : UITapGestureRecognizer)
    {
        fb = false
        insta = false
        twitter = false
        linkedin = true
        movetogetlinkpopup()
        
    }
    
}
extension addaccountpopupvc
{
    func movetogetlinkpopup()
    {
        let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "getlinkpopupVC") as! getlinkpopupVC
        //popVC.dateDelegate = self
        self.addChild(popVC)
        
        popVC.delagategetlink = self
        // self.navigationController?.setNavigationBarHidden(true, animated: false)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        
        popVC.didMove(toParent: self)
    }
}
extension addaccountpopupvc: linkdelagate
{
    func link(link: String) {
        self.view.removeFromSuperview()
        if fb
        {
            createeventgetlinkdelagate?.getlink(link: link, linkof: "fb")
        }
        else if twitter
        {
            createeventgetlinkdelagate?.getlink(link: link, linkof: "twitter")
        }
        else if insta
        {
            createeventgetlinkdelagate?.getlink(link: link, linkof: "insta")
        }
        else
        {
            createeventgetlinkdelagate?.getlink(link: link, linkof: "linked")
        }
        
    }

}

