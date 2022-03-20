//
//  UpdateSuccessPopUp.swift
//  TNTUpdateProfile
//
//  Created by MacBook Pro on 18/06/2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class UpdateSuccessPopUp: UIViewController {

    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message = String()
    var emoji = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let seconds = 1.5
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundview.carveANDShadow()
        showAnimate()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            //popVC.view.removeFromSuperview()
            self.removeAnimate()
        }
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        //self.dismiss(animated: true, completion: nil)
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    self.view.alpha = 0.0;
                }, completion:{(finished : Bool)  in
                    if (finished)
                    {
                        self.view.removeFromSuperview()
                        //self.dismiss(animated: true, completion: nil)
                    }
                });
    }
}
