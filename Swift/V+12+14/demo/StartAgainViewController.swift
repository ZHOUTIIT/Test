//
//  StartAgainViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/18/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import WatchConnectivity

class StartAgainViewController: UIViewController,WCSessionDelegate{

    @IBOutlet var pageindex: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)

        let healthManager:HealthManager = HealthManager()

        healthManager.authorizeHealthKit{(authorized,error) -> Void in
            if authorized{
                print("HealthKitauthorizationreceived.")
            }
            else
            {
                print("HealthKitauthorizationdenied!")
                if (error != nil) {
                    print("(error)")
                }
            }
        }
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "index")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("printout:"), name: "changepageindex", object: nil)
    }
   
    func printout(notification: NSNotification){
        //print("\(notification.userInfo!["key"]!)")
        let ind = notification.userInfo!["key"]! as! String
        let indint = Int(ind)
        pageindex.currentPage = indint!
    }


    func viewDidDisappear() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "changepageindex", object: nil)
    }

}
