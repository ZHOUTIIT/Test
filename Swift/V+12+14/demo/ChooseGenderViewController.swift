//
//  ChooseGenderViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/19/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class ChooseGenderViewController: UIViewController {
    @IBOutlet var backgroundimage: UIImageView!
    @IBOutlet var male: UIButton!
    @IBOutlet var female: UIButton!
    @IBOutlet var confirm: UIButton!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundimage.image = UIImage(named: "a.jpg")
        confirm.backgroundColor = UIColor.grayColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func highlightmale(sender: UIButton) {
        male.backgroundColor = UIColor(red: 0x0f/255, green: 0x83/255, blue: 0xff/255, alpha: 1)
        female.backgroundColor = UIColor.grayColor()
        confirm.backgroundColor = UIColor(red: 0x10/255, green: 0xdd/255, blue: 0x94/255, alpha: 1)
        NSUserDefaults.standardUserDefaults().setObject("male", forKey: "gender")
        
    }
    
    @IBAction func highlightfemal(sender: UIButton) {
        female.backgroundColor = UIColor(red: 0xf3/255, green: 0x10/255, blue: 0x80/255, alpha: 1)
        male.backgroundColor = UIColor.grayColor()
        confirm.backgroundColor = UIColor(red: 0x10/255, green: 0xdd/255, blue: 0x94/255, alpha: 1)
        NSUserDefaults.standardUserDefaults().setObject("female", forKey: "gender")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
