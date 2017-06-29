//
//  CommentViewController.swift
//  demo
//
//  Created by Zhou Ti on 12/7/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import Firebase
class CommentViewController: UIViewController {

    @IBOutlet weak var navigationbar: UINavigationItem!
    @IBOutlet weak var comment: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        navigationbar.title = "Add Comment"
        comment.layer.borderColor = UIColor(red: 60/255, green: 40/255, blue: 129/255, alpha: 1).CGColor
        comment.layer.borderWidth = 1
        comment.layer.cornerRadius = 8 


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savecomment(sender: UIBarButtonItem) {
        var ref=Firebase(url: "https://glowing-inferno-3788.firebaseio.com/")
        let rownum = NSUserDefaults.standardUserDefaults().valueForKey("row")! as! Int
        let list = NSUserDefaults.standardUserDefaults().valueForKey("list") as! [Int]!
        let meeting = NSUserDefaults.standardUserDefaults().valueForKey("meeting\(list[rownum+1])") as! NSDictionary
        var newone:NSDictionary
        print(comment.text)
        newone = [
            "Name":meeting["Name"]!,
            "Date":meeting["Date"]!,
            "Duration": meeting["Duration"]!,
            "heartrate": meeting["heartrate"]!,
            "calories" :meeting["calories"]!,
            "StartTime": meeting["StartTime"]!,
            "exercisetype": meeting["exercisetype"]!,
            "comment":meeting["comment"]!,
            "note": comment.text,
            "detail":meeting["detail"]!,
            "d_ca":meeting["d_ca"]!,
            "actual_t":meeting["actual_t"]!
        ]
        //modified
        NSUserDefaults.standardUserDefaults().setObject(newone, forKey: "meeting\(list[rownum+1])")
        NSUserDefaults.standardUserDefaults().synchronize()
        ref.childByAppendingPath("users")
            .childByAppendingPath(ref.authData.uid).childByAppendingPath("\(list[rownum+1])").setValue(newone)
        let myStoryBoard = self.storyboard
        let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("main")
        self.presentViewController(anotherView, animated: true, completion: nil)
        
        
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
