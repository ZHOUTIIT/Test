//
//  LoginagainViewController.swift
//  tab
//
//  Created by Zhou Ti on 11/14/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class LoginagainViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    
    
    @IBOutlet var pwd: UITextField!
    
    @IBOutlet var rmb: UISwitch!
   
    
    @IBAction func save(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setObject(self.name.text, forKey: "UserNameKey")
        NSUserDefaults.standardUserDefaults().setObject(self.pwd.text, forKey: "PwdKey")
        NSUserDefaults.standardUserDefaults().setBool(self.rmb.on, forKey: "RmbPwdKey")
        
        NSUserDefaults.standardUserDefaults().synchronize()
        name.text = ""
        pwd.text = ""
        rmb.on = false
        let mystoryboard = self.storyboard
        let mainTabController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
        self.presentViewController(mainTabController, animated: false, completion: nil)
    }

    
    
}
