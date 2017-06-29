//
//  AuthorizeViewController.swift
//  tab
//
//  Created by Zhou Ti on 11/14/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class AuthorizeViewController: UIViewController {
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var backgroundimage: UIImageView!
    override func viewDidLoad() {
        backgroundimage.image = UIImage(named: "a.jpg")
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        button.backgroundColor = UIColor(red: 0x40/255, green: 0x40/255, blue: 0xb0/255, alpha: 1)
        button.setTitle("Skip", forState: UIControlState.Normal)
    }
    
    let healthManager:HealthManager = HealthManager()
    @IBAction func authorize(sender: UIButton) {
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
        button.backgroundColor = UIColor(red: 0x40/255, green: 0xb0/255, blue: 0x40/255, alpha: 1)
        button.setTitle("Done", forState: UIControlState.Normal)
        }
    
    
    
    }