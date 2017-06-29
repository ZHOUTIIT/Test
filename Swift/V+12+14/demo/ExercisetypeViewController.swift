//
//  ExercisetypeViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/15/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class ExercisetypeViewController: UIViewController {
    @IBOutlet var backgroundimage: UIImageView!
    @IBOutlet var confirm: UIButton!
    @IBOutlet var running: UIButton!
    @IBOutlet var riding: UIButton!
    override func viewDidLoad() {
        backgroundimage.image = UIImage(named: "a.jpg")
        confirm.backgroundColor = UIColor.grayColor()
    }
    
    
    @IBAction func setrun(sender: UIButton) {
        running.backgroundColor = UIColor(red: 0xa7/255, green: 0x17/255, blue: 0xff/255, alpha: 1)
        riding.backgroundColor = UIColor.grayColor()
        confirm.backgroundColor = UIColor(red: 0x10/255, green: 0xdd/255, blue: 0x94/255, alpha: 1)
        NSUserDefaults.standardUserDefaults().setObject("Running", forKey: "UserExerciseType")
        NSUserDefaults.standardUserDefaults().synchronize()

    }

    @IBAction func setride(sender: UIButton) {
        riding.backgroundColor = UIColor(red: 0xf9/255, green: 0x68/255, blue: 0x08/255, alpha: 1)

        running.backgroundColor = UIColor.grayColor()
        confirm.backgroundColor = UIColor(red: 0x10/255, green: 0xdd/255, blue: 0x94/255, alpha: 1)
        NSUserDefaults.standardUserDefaults().setObject("Riding", forKey: "UserExerciseType")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
