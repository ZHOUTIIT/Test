//
//  LoginViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/19/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    @IBOutlet var username: UITextField!
    @IBOutlet var login: UIButton!
    @IBOutlet var password: UITextField!
    @IBOutlet var rightorwrong: UILabel!
    var meetnum:Int=0
    var list:[Int]=[]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.login.enabled  = false
        self.login.backgroundColor = UIColor.darkGrayColor()
        self.topLayoutGuide
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        password.secureTextEntry = true
        // Do any additional setup after loading the view.
    }
    @IBAction func changecolor(sender: UITextField) {
        login.enabled = true
        login.backgroundColor = UIColor(red: 0x40/255, green: 0xb0/255, blue: 0x40/255, alpha: 1)
    }
    @IBAction func autopwd(sender: UITextField) {
        if (username.text == NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as? String){
            if (NSUserDefaults.standardUserDefaults().valueForKey("RmbPwdKey") as? Int == 1){
                password.text = NSUserDefaults.standardUserDefaults().valueForKey("PwdKey") as? String
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        password.resignFirstResponder()
    }
    
    
    @IBAction func checkrightorwrong() {
        //Firebase.defaultConfig().persistenceEnabled = true
        var ref = Firebase(url: "https://glowing-inferno-3788.firebaseio.com/");
        //ref.unauth()
        ref.authUser(self.username.text, password: self.password.text) {
            error, authData in
            if error != nil {
                print("no")
                self.rightorwrong.text = "Wrong username or password"
                // an error occured while attempting login
            } else {
                print("yes")
                
//                ref.childByAppendingPath("users")
//                    .childByAppendingPath(authData.uid).observeSingleEventOfType(.Value, withBlock: { snapshot in
//                        print(snapshot.value)
////                        var meeting=Ameeting()
////                        NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("StartTime"), forKey: "StartTime")
////                        NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("MeetingNum"), forKey: "MeetingNum")
////                        NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("list"), forKey: "list")
////                        var list=snapshot.value.objectForKey("list")
////                        for i in snapshot.value.objectForKey("list") as! [Int]!{
////                            meeting.Duration = snapshot.value.objectForKey("\(list![i])") as! String!
////                            meeting.Date =
////                            NSUserDefaults.standardUserDefaults().setObject(meeting, forKey: "meeting\(list![i])")
////                        }
////                        NSUserDefaults.standardUserDefaults().synchronize()
//                        }, withCancelBlock: { error in
//                            print(error.description)
//                    })
                ref.childByAppendingPath("users")
                    .childByAppendingPath(ref.authData.uid).removeAllObservers()
                ref.childByAppendingPath("users")
                    .childByAppendingPath(ref.authData.uid).observeSingleEventOfType(.Value, withBlock: { snapshot in
                        print(snapshot.value)
                        self.list=snapshot.value["list"] as! [Int]!
//                        var meeting=Ameeting()
                        self.meetnum=snapshot.value["MeetingNum"] as! Int!
                        print("The number \(self.meetnum)")
                        //            ref.childByAppendingPath("users")
                        //                .childByAppendingPath(ref.authData.uid).observeEventType(.Value, withBlock: { snapshot in
                        NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("height"), forKey: "height")
                        NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("weight"), forKey: "weight")
                        NSUserDefaults.standardUserDefaults().setObject(snapshot.value.objectForKey("whatup"), forKey: "whatup")
                        NSUserDefaults.standardUserDefaults().setObject(self.meetnum, forKey: "MeetingNum")
                        NSUserDefaults.standardUserDefaults().setObject(self.list, forKey: "list")
                        NSUserDefaults.standardUserDefaults().setObject("0", forKey: "currentmeeting")

                        if (self.list.count>1){
                            for i in 1...self.list.count-1{
                                NSUserDefaults.standardUserDefaults().setObject(snapshot.value["\(self.list[i])"], forKey: "meeting\(self.list[i])")
                            }
                        }
                        let userNameDic=["userNameDic":String(self.username.text!)]
                        PhoneConnectManager.sharedManager.transferUserInfo(userNameDic)
                        NSUserDefaults.standardUserDefaults().synchronize()
                        let myStoryBoard = self.storyboard
                        let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("main")
                        self.presentViewController(anotherView, animated: true, completion: nil)
                        }, withCancelBlock: { error in
                            print(error.description)
                    })
                

                // user is logged in, check authData for data
            }
        }
        
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        let mystoryboard = self.storyboard
        let mainTabController = mystoryboard!.instantiateViewControllerWithIdentifier("startagain")
        self.presentViewController(mainTabController, animated: false, completion: nil)
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
