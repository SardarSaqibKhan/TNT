//
//  HCsurveyVC.swift
//  UserGuestTNT
//
//  Created by abdul on 12/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit

class HCsurveyVC: UIViewController {

    //outlets according to layout

    
    @IBOutlet weak var Hostimg: UIImageView!
    
    @IBOutlet weak var Hostname: UILabel!
    @IBOutlet weak var hostexpdate: UILabel!
    
    @IBOutlet weak var guestpassesBtn: UIButton!
    
    
    @IBOutlet weak var Star1Btn: UIButton!
    
    @IBOutlet weak var Star2Btn: UIButton!
    @IBOutlet weak var Star3btn: UIButton!
    @IBOutlet weak var Star4btn: UIButton!
    @IBOutlet weak var Star5Btn: UIButton!
    
    
    @IBOutlet weak var Q1txt: UITextField!
    @IBOutlet weak var Q2txt: UITextField!
    @IBOutlet weak var Q3txt: UITextField!
    @IBOutlet weak var Q4txt: UITextField!
    @IBOutlet weak var Q5txt: UITextField!
    @IBOutlet weak var Q6txt: UITextField!
    
    
    
    @IBOutlet weak var yeahBtn: UIButton!
    @IBOutlet weak var SorryBtn: UIButton!
    
    
    
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    
    
    var Q7 = Bool()
    var rating = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        setdesign()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBTnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Star1BtnAction(_ sender: Any) {
        Star1Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star2Btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
        Star3btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
        Star4btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
        Star5Btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
        
        rating = 1
    }
    
    @IBAction func Star2BtnAction(_ sender: Any) {
        Star1Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star2Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star3btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
        Star4btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
        Star5Btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
         rating = 2
    }
    
    @IBAction func Star3BtnACtion(_ sender: Any) {
        Star1Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star2Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star3btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star4btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
        Star5Btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
         rating = 3
    }
    @IBAction func Star4BtnAction(_ sender: Any) {
        Star1Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star2Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star3btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star4btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star5Btn.setImage(UIImage(named: "btn-star-unfilled"), for: .normal)
         rating = 4
    }
    @IBAction func Star5BtnAction(_ sender: Any) {
        Star1Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star2Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star3btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star4btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
        Star5Btn.setImage(UIImage(named: "btn-star-filled"), for: .normal)
         rating = 5
    }
    
    
    @IBAction func sorryBtnAction(_ sender: Any) {
        Q7 = false
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        if Q1txt.text != nil && Q2txt.text != nil && Q3txt.text != nil &&
         Q4txt.text != nil && Q5txt.text != nil && Q6txt.text != nil &&
         Q7 != nil && rating != nil
        {
            addingsurvey()
        }
        
    }
    
    @IBAction func yeahBtnAction(_ sender: Any) {
        Q7 = true
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
extension HCsurveyVC
{
  func setdesign()
  {
   submitBtn.HCcarveNextButton()
    yeahBtn.HCcarveNextButton()
    SorryBtn.HCcarveNextButton()
    guestpassesBtn.HCcarveNextButton()
    Hostimg.HCcircleImage()
    submitView.HCcarveshadowradius(shadowRadius: 4)
    
    
  }
    
    func addingsurvey()
    {
        HCDBManger.manager.addsurvey(EventID: 3, MemberID: 7, Q1: Q1txt.text!, Q2: Q2txt.text!, Q3: Q3txt.text!, Q4: Q4txt.text!, Q5: Q5txt.text!, Q6: Q6txt.text!, Q7: Q7 , Rating: rating) { (res) in
            if res
            {
                print("Submited")
            }
            else
            {
                print("error")
            }
        }
    }
}
