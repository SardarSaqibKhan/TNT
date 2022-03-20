//
//  Profile2CVC.swift
//  HatabaAdmin
//
//  Created by Moheed Zafar on 18/07/2019.
//  Copyright © 2019 abc company. All rights reserved.
//

import UIKit

class Profile2CVC: UIViewController {
    
    @IBOutlet weak var categoryTV: UICollectionView!
    var categoriesImages = ["AC Repair","Car Wash","Electrician","Laundry","Makeup","Mechanic","Painter","Photographer","Plumber","Shifter","Tailor Master","Teacher"]
    
    func services(servicesArray:[String])
    {
        categoriesImages.removeAll()
        
        for imageName in servicesArray
        {
            var properName = imageName.replacingOccurrences(of: " ", with: "-")
            categoriesImages.append(properName)
        }
        
        DispatchQueue.main.async {
            self.categoryTV.reloadData()
        }
    }
    


}
class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriesImage: UIImageView!
    override func awakeFromNib() {
        
        
    }
    
}
extension Profile2CVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categoriesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriescell", for: indexPath) as! CategoriesCollectionViewCell
        
       
        cell.categoriesImage.image = UIImage(named:  categoriesImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.width / 3 - 3
        return CGSize(width: width, height: width)
        
    }
  
    
}
