//
//  InformationViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/17/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet var type: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var speed: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet var riding: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        type.text = NSUserDefaults.standardUserDefaults().valueForKey("UserExerciseType") as? String
        time.text = (NSUserDefaults.standardUserDefaults().valueForKey("temduration") as? String)! + "min"
        if (type.text == "riding"){
            speed.text = "10km/h"
            riding.text = "Drag force:                  5kg"
        }
        else{
            speed.text = "5km/h"
        }
        
        detail.text="The suggested heart rate is 120 bpm"
        
    }
}
