//
//  CommentWKInterfaceController.swift
//  demo
//
//  Created by Zhou Ti on 11/17/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import WatchKit
import Foundation

class CommentWKInterfaceController: WKInterfaceController {
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    var CommentIntTemp: Int=50
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        
        let CommentValueDic=["CommentValueDic": Int(self.CommentIntTemp)]
        WatchConnectManager.sharedManager.transferUserInfo(CommentValueDic)
        super.didDeactivate()
    }
    
    @IBOutlet var comment: WKInterfaceLabel!
    
    @IBAction func changecomment(value: Float) {
        comment.setText("\(Int(value))")
        CommentIntTemp=Int(value)
    }
}
