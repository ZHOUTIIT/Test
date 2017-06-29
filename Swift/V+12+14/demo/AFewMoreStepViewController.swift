//
//  AFewMoreStepViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/19/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class AFewMoreStepViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var backgroundimage: UIImageView!
    @IBOutlet var background: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        background.insertSubview(backgroundimage, atIndex: 0)
        backgroundimage.image = UIImage(named: "a.jpg")
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
            // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
