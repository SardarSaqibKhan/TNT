//
//  InformpageVC.swift
//  UserGuestTNT
//
//  Created by abdul on 27/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit

class InformpageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        showAnimate()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        showAnimate()
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
extension InformpageVC
{
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        self.view.alpha = 1;
        UIView.animate(withDuration: 1.5, animations: {
            
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 1;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.dismiss(animated: false, completion: nil)
            }
        });
    }
}
