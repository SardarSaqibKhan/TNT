//
//  Profile3CVC.swift
//  HatabaAdmin
//
//  Created by Moheed Zafar on 18/07/2019.
//  Copyright © 2019 abc company. All rights reserved.
//

import UIKit
import SDWebImage
class Profile3CVC: UIViewController {

    @IBOutlet weak var docsTV: UICollectionView!
    var groupDownload = DispatchGroup()
    var imageNameArray = [String]()
    
    func documents(docs:[String])
    {
        imageNameArray = docs
        DispatchQueue.main.async {
            self.docsTV.reloadData()
        }
        
    }
}
extension Profile3CVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DocCell
        self.groupDownload.enter()
        var path="\(currentIP)/Images/EmployeeDocuments/\(imageNameArray[indexPath.row])";
        
        var pathListWithoutTN = imageNameArray[indexPath.row].components(separatedBy: "thumbnail-")
        path = "\(currentIP)/Images/EmployeeDocuments/\(pathListWithoutTN[0])\(pathListWithoutTN[1])"
        
        print("Path:\(path)")
        cell.imageView.sd_setIndicatorStyle(.gray)
        cell.imageView.sd_setShowActivityIndicatorView(true)
        cell.imageView.carvyShadow()
        
        cell.imageView.sd_setImage(with: URL(string: path)) { (img, error, cacheType, url) in
            if cacheType == SDImageCacheType.none
            {
                SDImageCache.shared().removeImage(forKey: (path), withCompletion: nil)
            }
            
        };
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DocCell
        let imageView = cell.imageView
        var vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageViewController") as! ImageViewController
        vc.image = imageView?.image;
        var pathListWithoutTN = imageNameArray[indexPath.row].components(separatedBy: "thumbnail-")
        
        vc.path = "\(currentIP)/Images/EmployeeDocuments/\(pathListWithoutTN[0])\(pathListWithoutTN[1])";
        navigationController?.pushViewController(vc,animated: true)
    }

}
class DocCell:UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    
}
