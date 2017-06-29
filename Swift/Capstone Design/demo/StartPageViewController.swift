//
//  StartPageViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/18/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class StartPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    var heading = ["Get fit in meeting", "Know your meeting, Know yourself", "View your workout charts"]
    var imagefile = ["launch.jpg","b.jpg","c.jpg"]
    override func viewDidLoad() {
        NSUserDefaults.standardUserDefaults().setObject(1, forKey: "first")
        // Set the data source to itself
        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = self.viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        }
     
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! StartContentViewController).index
        NSNotificationCenter.defaultCenter().postNotificationName("changepageindex", object: nil, userInfo: ["key":"\(index)"])
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "changepageindex", object: nil)
        index++
        
        NSUserDefaults.standardUserDefaults().setObject(index, forKey: "index")
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! StartContentViewController).index
        NSNotificationCenter.defaultCenter().postNotificationName("changepageindex", object: nil, userInfo: ["key":"\(index)"])
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "changepageindex", object: nil)
        index--
        
        NSUserDefaults.standardUserDefaults().setObject(index, forKey: "index")
        return self.viewControllerAtIndex(index)
    }
    func viewControllerAtIndex(index: Int) -> StartContentViewController? {
        
        if index == NSNotFound || index < 0 || index >= self.heading.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("startcontent") as? StartContentViewController {
            
            pageContentViewController.image = imagefile[index]
            pageContentViewController.heading = heading[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }

    

//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return heading.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("startcontent") as? StartContentViewController {
//            
//            return pageContentViewController.index
//        }
//        
//        return 0  
//    }
    
}
