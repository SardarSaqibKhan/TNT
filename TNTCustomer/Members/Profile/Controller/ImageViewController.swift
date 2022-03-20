//
//  ImageViewController.swift
//  HatabaAdmin
//
//  Created by Moheed Zafar Hashmi on 01/05/2019.
//  Copyright © 2019 abc company. All rights reserved.
//

import UIKit
import SDWebImage
class ImageViewController: UIViewController,UIScrollViewDelegate {
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage?
    var path:String?
    
    var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupGestureRecognizer()
        
        if let unWrapImage = image
        {
            imageView.image = unWrapImage
        }
        imageView.sd_setIndicatorStyle(.gray)
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setImage(with: URL(string: path!)) { (img, error, cacheType, url) in
            if cacheType == SDImageCacheType.none
            {
                  SDImageCache.shared().removeImage(forKey: (self.path!), withCompletion: nil)
            }
            self.imageView.sd_setShowActivityIndicatorView(false)
        }
        
    }
    
    func setupScrollView() {
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
    }
    
    func setupGestureRecognizer() {
        
        gestureRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleDoubleTap() {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scrollView.maximumZoomScale, center: gestureRecognizer.location(in: gestureRecognizer.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        let newCenter = scrollView.convert(center, from: imageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }


}

