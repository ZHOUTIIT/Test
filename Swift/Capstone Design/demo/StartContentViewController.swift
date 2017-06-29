//
//  StartContentViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/18/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit

class StartContentViewController: UIViewController {

 
  
    @IBOutlet var titlelabel: UILabel!

    @IBOutlet var backgroundimage: UIImageView!

    var index: Int = 0
    var heading: String = ""
    var image: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if (heading == "Get fit in meeting"){
            
        }
        else if (heading == ""){
            
        }
        else if (heading == ""){
            
        }
        else{
            
        }
        titlelabel.text = heading
        backgroundimage.image = UIImage(named: image)
    }
    
}
