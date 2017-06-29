//
//  relgin.swift
//  demo
//
//  Created by l on 15/12/8.
//  Copyright © 2015年 Zhou Ti. All rights reserved.
//

import UIKit

class RelinViewController: UIViewController {
    
    
    @IBOutlet weak var relogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      @IBAction func save(sender: UIButton) {
        let myStoryBoard = self.storyboard
        let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("login")
        self.presentViewController(anotherView, animated: true, completion: nil)
        
    }
    
}