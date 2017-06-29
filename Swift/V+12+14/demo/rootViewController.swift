//
//  rootViewController.swift
//  tab
//
//  Created by Zhou Ti on 11/14/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import Firebase
class rootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let mystoryboard = self.storyboard

        if((NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey")) == nil){
            let loginController = mystoryboard!.instantiateViewControllerWithIdentifier("startagain")
            self.navigationController?.pushViewController(loginController, animated: false)
        }
        else {
            let mystoryboard = self.storyboard
            
            
            let mainTabController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
            self.presentViewController(mainTabController, animated: false, completion: nil)
            
            
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

