//
//  StartPageVC.swift
//  UserGuestTNT
//
//  Created by abdul on 23/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit

class StartPageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageControl = UIPageControl() 
    var nextbtn = UIButton()
    var skipbtn = UIButton()
    
    //Page Dots Start
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
       pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 75,width: UIScreen.main.bounds.width,height: 50))
        nextbtn = UIButton(frame: CGRect(x: 260,y: UIScreen.main.bounds.maxY - 75,width: UIScreen.main.bounds.width - 275,height: 50))
        skipbtn = UIButton(frame: CGRect(x: 16,y: UIScreen.main.bounds.maxY - 75,width: UIScreen.main.bounds.width - 275,height: 50))
        
        //pagecontrol
        
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 0.8117647059, green: 0.568627451, blue: 0.2352941176, alpha: 1)
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.8117647059, green: 0.568627451, blue: 0.2352941176, alpha: 1)
        self.view.addSubview(pageControl)
        //nextbtn
        self.nextbtn.setTitle("Next", for: .normal)
        self.nextbtn.setTitleColor(#colorLiteral(red: 0.8117647059, green: 0.568627451, blue: 0.2352941176, alpha: 1), for: .normal)
        nextbtn.addTarget(self, action: #selector(btnNext(_:)), for: .touchUpInside)
        self.view.addSubview(nextbtn)
        //skipbtn
        self.skipbtn.setTitle("Skip", for: .normal)
        self.skipbtn.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        skipbtn.addTarget(self, action: #selector(btnskip(_:)), for: .touchUpInside)
        self.view.addSubview(skipbtn)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (finished)
        {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    // Finish
    
  
    
    
    //PageViewController Start
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    //OrderedViewController Usage
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "Page1"),
                self.newVc(viewController: "Page2"),
                self.newVc(viewController: "Page3"),
                self.newVc(viewController: "Page4")]
    }()
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            
            //return orderedViewControllers.last
            // Uncommment the line above, remove the line below for the page control to loop.
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            
            //return orderedViewControllers.first
            // Uncommment the line above, remove the line below for the page control to loop.
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    @objc func btnNext(_ sender: Any) {
        self.goToNextPage()
    }
    
    @objc func btnskip(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MemberTypeVC")
        self.present(view, animated: true, completion: nil)
    }
    
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        self.delegate = self
        configurePageControl()
        
        // Do any additional setup after loading the view.
    }
}
extension StartPageVC
{
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if self.pageControl.currentPage == 3
        {
            btnskip(UIButton())
        }
        else
        {
        if let currentViewController = viewControllers?[0] {
            self.pageControl.currentPage = self.pageControl.currentPage + 1
            print(self.pageControl.currentPage)
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
            }
        }
        }
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController){
                setViewControllers([previousPage], direction: .reverse, animated: true, completion: completion)
            }
        }
    }
}
