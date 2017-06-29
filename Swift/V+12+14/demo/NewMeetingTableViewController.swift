//
//  NewMeetingTableViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/15/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import Firebase

class NewMeetingTableViewController: UITableViewController {

    @IBOutlet weak var Namecell: UITableViewCell!
    @IBOutlet var datecell: UITableViewCell!
    @IBOutlet var suggestioncell: UITableViewCell!
    @IBOutlet var startcell: UITableViewCell!
    @IBOutlet weak var meetingname: UITextField!
    @IBOutlet var meetdurationcell: UITableViewCell!
    @IBOutlet var typecell: UITableViewCell!
    @IBOutlet var durationcell: UITableViewCell!
    @IBOutlet var date: UILabel!
    @IBOutlet var mainview: UITableView!
    
    @IBOutlet var starttime: UITextField!
    
    @IBOutlet var exercisetype: UILabel!
    
    @IBOutlet var meetduration: UITextField!
    
    @IBOutlet var duration: UITextField!
   
    @IBOutlet var recommand: UILabel!
   
//    var IntTotal: Int=0

   
    @IBAction func checkduration1(sender: UITextField) {
        
        updateOKButtonStatus()
        NSUserDefaults.standardUserDefaults().setObject(meetduration.text, forKey: "temduration")
        if (exercisetype.text == "riding"){
            recommand.text = "drag force: 5kg " + "speed: 10km/h"
        }
        if (exercisetype.text == "running"){
            recommand.text = "speed: 5km/h"
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let mystoryboard = self.storyboard
        let mainTabController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
        mainTabController.selectedIndex = 0
        self.presentViewController(mainTabController, animated: false, completion: nil)
    }
    
    @IBAction func checkduration2(sender: UITextField) {
        updateOKButtonStatus()
        NSUserDefaults.standardUserDefaults().setObject(duration.text, forKey: "temduration")
//        IntTotal=Int(duration.text!)!
//        let applicationData = ["exerciseDuration":Int(IntTotal)]
//        PhoneConnectManager.sharedManager.transferUserInfo(applicationData)
    }
    @IBAction func starttimeset(sender: UITextField) {
        //Create the view
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Time
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.
    }
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        starttime.text = dateFormatter.stringFromDate(sender.date)
        updateOKButtonStatus()
    }
    @IBAction func done(sender: UIBarButtonItem) {
        guard let settings = UIApplication.sharedApplication().currentUserNotificationSettings() else { return }
        if settings.types == .None {
            let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
        let localNotification:UILocalNotification =
        UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        localNotification.alertBody = "You meeting has been successfully set!"
        localNotification.alertAction = "Meeting set!"
        localNotification.category="team12Custom"
        localNotification.soundName =
        UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(
            localNotification)
        //Firebase.defaultConfig().persistenceEnabled = true
        var ref=Firebase(url: "https://glowing-inferno-3788.firebaseio.com/")
var meetnum=NSUserDefaults.standardUserDefaults().valueForKey("MeetingNum") as! Int!
        var list=NSUserDefaults.standardUserDefaults().valueForKey("list") as! [Int]!
        if ref.authData != nil {
        meetnum=meetnum+1
                    list.append(list[list.count-1]+1)
                    var localmeeting=Ameeting()
                    localmeeting.Date=self.date.text!
                    localmeeting.Duration=self.duration.text!
                    localmeeting.Starttime=self.starttime.text!
                    localmeeting.exercisetype="riding"//exercisetype.text!
                    var newmeeting = [
                        "Name" : self.meetingname.text!,
                        "Date":self.date.text!,
                        "Duration": self.duration.text!,
                        "heartrate": 0.0,
                        "calories" :0.0,
                        "StartTime": self.starttime.text!,
                        "exercisetype": "riding",
                        "comment":0,
                        "note":"",
                        "detail":[0.0],
                        "d_ca":[0.0],
                        "actual_t":0.0
                        
                    ]
                    let smeet="\(list[list.count-1])"
                    NSUserDefaults.standardUserDefaults().setObject(list, forKey: "list")
                    NSUserDefaults.standardUserDefaults().setObject(meetnum, forKey: "MeetingNum")
                    NSUserDefaults.standardUserDefaults().setObject(newmeeting, forKey: "meeting"+smeet)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    ref.childByAppendingPath("users")
                        .childByAppendingPath(ref.authData.uid).childByAppendingPath(smeet).setValue(newmeeting)
                    ref.childByAppendingPath("users")
                        .childByAppendingPath(ref.authData.uid).updateChildValues(["MeetingNum": meetnum])
                    ref.childByAppendingPath("users")
                        .childByAppendingPath(ref.authData.uid).updateChildValues(["list": list])


//            var meetnum = NSUserDefaults.standardUserDefaults().integerForKey("MeetingNum")
//            meetnum = meetnum+1
//            var list = NSUserDefaults.standardUserDefaults().valueForKey("list") as! [Int]!
//
//                            NSUserDefaults.standardUserDefaults().setObject(localmeeting, forKey: "meeting\(list[list.count-1])")
//            NSUserDefaults.standardUserDefaults().synchronize()

//
//        ref.childByAppendingPath("users")
//            .childByAppendingPath(ref.authData.uid).childByAppendingPath("test").updateChildValues(["test":"="])

        let mystoryboard = self.storyboard
        let mainTabController = mystoryboard!.instantiateViewControllerWithIdentifier("main") as! UITabBarController
        mainTabController.selectedIndex = 0
        self.presentViewController(mainTabController, animated: false, completion: nil)
        }
        else {
            // No user is signed in
            let myStoryBoard = self.storyboard
            let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("relogin")
            self.presentViewController(anotherView, animated: true, completion: nil)
            
        }
        
        
        
    }
    func doneButton(sender:UIButton)
    {
        starttime.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    @IBOutlet var exercise: UILabel!
    
    func updateOKButtonStatus() {
        
        
        self.navigationItem.rightBarButtonItem?.enabled = ( starttime.text != nil && duration.text != nil && meetduration.text != nil);
    }
    
//    override func tableView (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath , animated: true)
//        
//        switch (indexPath.section, indexPath.row)
//        {
//        case (1,2):
//            let storyBoard = self.storyboard
//                            let loginController = storyBoard!.instantiateViewControllerWithIdentifier("information")
//                self.navigationController?.pushViewController(loginController, animated: false)
//            
//        default:
//            break;
//        }
//        
//        
//    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        Namecell.backgroundColor = UIColor.clearColor()
        datecell.backgroundColor = UIColor.clearColor()
        startcell.backgroundColor = UIColor.clearColor()
        durationcell.backgroundColor = UIColor.clearColor()
        meetdurationcell.backgroundColor = UIColor.clearColor()
        typecell.backgroundColor = UIColor.clearColor()
        suggestioncell.backgroundColor = UIColor.clearColor()
        if (NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") == nil){
            mainview.backgroundColor = UIColor(patternImage: UIImage(named: "j.png")!)
        }
        else{
            mainview.backgroundColor = UIColor(patternImage: UIImage(data: NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") as! NSData)!)
        }
        Namecell.contentView.backgroundColor = UIColor.whiteColor()
        datecell.contentView.backgroundColor = UIColor.whiteColor()
        startcell.contentView.backgroundColor = UIColor.whiteColor()
        durationcell.contentView.backgroundColor = UIColor.whiteColor()
        meetdurationcell.contentView.backgroundColor = UIColor.whiteColor()
        typecell.contentView.backgroundColor = UIColor.whiteColor()
        suggestioncell.contentView.backgroundColor = UIColor.whiteColor()
        if (NSUserDefaults.standardUserDefaults().valueForKey("alpha") != nil){
            datecell.contentView.alpha = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
            startcell.contentView.alpha = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
            durationcell.contentView.alpha = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
            meetdurationcell.contentView.alpha = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
            typecell.contentView.alpha = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
            suggestioncell.contentView.alpha = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
            Namecell.contentView.alpha = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
        }
        else {
            datecell.contentView.alpha = 0.6
            startcell.contentView.alpha = 0.6
            durationcell.contentView.alpha = 0.6
            meetdurationcell.contentView.alpha = 0.6
            typecell.contentView.alpha = 0.6
            suggestioncell.contentView.alpha = 0.6
            Namecell.contentView.alpha = 0.6
        }
        let dates = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd"
        date.text = timeFormatter.stringFromDate(dates) as String!
        exercisetype.text = NSUserDefaults.standardUserDefaults().valueForKey("UserExerciseType") as! String!
        self.navigationItem.rightBarButtonItem?.enabled  = false        
    }
}