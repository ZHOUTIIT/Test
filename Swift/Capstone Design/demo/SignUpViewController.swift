//
//  LoginViewController.swift
//  tab
//
//  Created by Zhou Ti on 11/14/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet var page: UIView!
    @IBOutlet var signupnavigation: UINavigationItem!
    @IBOutlet var signup: UIButton!
    override func viewDidLoad() {

        signup.enabled = false
        signup.backgroundColor = UIColor.darkGrayColor()
        //signup.backgroundColor = UIColor.()
        //let mainColor = UIColor.darkGrayColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String: AnyObject]

        pwd.secureTextEntry = true
        pwdagain.secureTextEntry = true



    }
    @IBOutlet var name: UITextField!

    @IBOutlet var equalornotinformation: UILabel!
    @IBOutlet var pwdagain: UITextField!
    @IBOutlet var pwd: UITextField!

    @IBOutlet var rmb: UISwitch!

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pwdagain.resignFirstResponder()
    }
    @IBAction func checkequalornot(sender: UITextField) {
        if (pwd.text == pwdagain.text) {
            equalornotinformation.text = "confirm"
            equalornotinformation.textColor = UIColor.greenColor()
            signup.backgroundColor = UIColor(red: 0x40 / 255, green: 0xb0 / 255, blue: 0x40 / 255, alpha: 1)
            signup.enabled = true

        }
            else {
                equalornotinformation.text = "the two passwords are not identical"
                equalornotinformation.textColor = UIColor.redColor()
                pwd.text = ""
                pwdagain.text = ""
        }
    }


    @IBAction func save(sender: UIButton) {
//        let array =  [String]()
//        NSUserDefaults.standardUserDefaults().setObject(array, forKey: "Duration")
//        let string = [String]()
//        NSUserDefaults.standardUserDefaults().setObject(string, forKey: "Date")
//        let no = [String]()

//    NSUserDefaults.standardUserDefaults().setObject(self.name.text, forKey: "UserNameKey")
//    NSUserDefaults.standardUserDefaults().setObject(self.pwd.text, forKey: "PwdKey")
//    NSUserDefaults.standardUserDefaults().setBool(self.rmb.on, forKey: "RmbPwdKey")
        //Firebase.defaultConfig().persistenceEnabled = true
        var ref = Firebase(url: "https://glowing-inferno-3788.firebaseio.com/")
        ref.createUser(self.name.text, password: self.pwd.text,
                       withValueCompletionBlock: { error, result in
                           if error != nil {
                               // There was an error creating the account
                               self.equalornotinformation.text = "Username registered!"
                               self.equalornotinformation.textColor = UIColor.redColor()
                               self.pwd.text = ""
                               self.pwdagain.text = ""
                           } else {
//                    NSUserDefaults.standardUserDefaults().setObject(0, forKey: "MeetingNum")
//                    NSUserDefaults.standardUserDefaults().setObject([], forKey: "list")
                               // let myStoryBoard = self.storyboard
                               //  let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("successsignup")
                               // self.presentViewController(anotherView, animated: true, completion: nil)
                               let uid = result["uid"]as! String
                               //let provider=result["provider"] as! String
                               // var ref = Firebase(url: "https://glowing-inferno-3788.firebaseio.com/");
                               NSUserDefaults.standardUserDefaults().setObject(0, forKey: "MeetingNum")
                               NSUserDefaults.standardUserDefaults().setObject([0], forKey: "list")
                               print("yes")
                               NSUserDefaults.standardUserDefaults().setObject("0", forKey: "currentmeeting")
                               NSUserDefaults.standardUserDefaults().setObject("Unknown", forKey: "height")
                               NSUserDefaults.standardUserDefaults().setObject("Unknown", forKey: "weight")
                               NSUserDefaults.standardUserDefaults().setObject("Unknown", forKey: "gender")
                               NSUserDefaults.standardUserDefaults().setObject("running", forKey: "UserExerciseType")
                               NSUserDefaults.standardUserDefaults().setObject("", forKey: "whatup")
                               let userNameDic = ["userNameDic": String(self.name.text!)]
                               PhoneConnectManager.sharedManager.transferUserInfo(userNameDic)
                               NSUserDefaults.standardUserDefaults().synchronize()
                               var list: [Int] = [0]
                               let newUser = [
                                   //"provider": provider,
                                   "MeetingNum": 0,
                                   "list": list,
                                   "height": "Unknown",
                                   "weight": "Unknown",
                                   "gender": "Unknown",
                                   "UserExerciseType": "running",
                                   "whatup": "",
                                   "test": "test"
                               ]
                               ref.childByAppendingPath("users")
                                   .childByAppendingPath(uid).setValue(newUser)
                               ref.authUser(self.name.text, password: self.pwd.text) {
                                   error, authData in
                                   if error != nil {
                                       print("no")
                                       // an error occured while attempting login
                                   } else {


                                       let myStoryBoard = self.storyboard
                                       let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("successsignup")
                                       self.presentViewController(anotherView, animated: true, completion: nil)
                                   }
                               }
                           }
                       })
    }
}
