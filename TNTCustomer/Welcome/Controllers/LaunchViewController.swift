//
//  LaunchViewController.swift
//  UserGuestTNT
//
//  Created by Abdul on 24/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(2)
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if let startup = UserDefaults.standard.value(forKey: "AppsFirstLaunch")
        {
            if let loginvalue = UserDefaults.standard.value(forKey: "Login")
            {
            
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GuestStartVC")
            self.present(vc, animated: true, completion: nil)
            }
            else{
                UserDefaults.standard.set(true, forKey: "Login")
                let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemberTypeVC")
                self.present(vc, animated: true, completion: nil)
            }
            
            
        }
        else {
            UserDefaults.standard.set(true, forKey: "AppsFirstLaunch")
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartPageVC")
            self.present(vc, animated: true, completion: nil)
        }
        
        
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
