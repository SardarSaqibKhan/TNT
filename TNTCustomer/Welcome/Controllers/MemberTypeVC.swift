//
//  MemberTypeVC.swift
//  UserGuestTNT
//
//  Created by abdul on 27/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class MemberTypeVC: UIViewController {

    @IBOutlet weak var mycollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = AnimatedCollectionViewLayout()
        // layout.animator = LinearCardAttributesAnimator()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        mycollectionview.collectionViewLayout = layout
        
    }
    
    
}

extension MemberTypeVC : UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell", for: indexPath) as! collectionviewcell
            cell.welcomebtn.tag = indexPath.row
            cell.welcomebtn.addTarget(self, action: #selector(welcomebtnaction(_:)), for: .touchUpInside)
            if indexPath.row == 1
            {
                cell.sideconstraint.constant = cell.sideconstraint.constant - 5
                cell.rightsideconstraint.constant = cell.rightsideconstraint.constant + 10
                cell.memberlabel.text = "Member"
            }
            return cell
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width - 25, height: collectionView.frame.height)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    }
    class collectionviewcell :UICollectionViewCell
    {
        
        @IBOutlet weak var memberimg: UIImageView!
        @IBOutlet weak var memberlabel: UILabel!
        @IBOutlet weak var upperview: UIView!
        @IBOutlet weak var view: UIView!
        
        @IBOutlet weak var rightsideconstraint: NSLayoutConstraint!
        @IBOutlet weak var sideconstraint: NSLayoutConstraint!
        
        @IBOutlet weak var welcomebtn: UIButton!
        override func awakeFromNib() {
          //  welcomebtn.addTarget(self, action: #selector(), for: .touchUpInside)
            memberimg.roundimage()
            // upperview.carveandshadowview()
            view.carveANDShadow()
            welcomebtn.carveNextButton()
            self.backgroundView?.alpha = 0.5
            upperview.carveTopleftRightView(size: view.frame.height / 8)
            //self.carveANDShadow()
        }
    }

extension MemberTypeVC
{
    @objc func  welcomebtnaction ( _ sender: UIButton)
    {
        if sender.tag == 0
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "GuestStartVC")
            self.present(view, animated: true, completion: nil)
        }
        else
        {
            print("Member")
        }
    }
}


