//
//  MeViewController.swift
//  tab
//
//  Created by Zhou Ti on 11/14/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import HealthKit
import Firebase
class MeViewController: UITableViewController {
    
    @IBOutlet var me: UITableView!
    @IBOutlet var age: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var gender: UILabel!

    @IBOutlet var username: UITableViewCell!
    @IBOutlet var settingbutton: UIBarButtonItem!
    @IBOutlet var bar: UINavigationItem!
    @IBOutlet var preference: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    var height,weight,heartrates:HKQuantitySample?
    func changenickname(){
        
    }
    func changegender(){
       
    }
    func changeexercisetype(){

    }
    func changeweight(){
      
    }
    func changeheight(){
        
    }
    
    let kUnknownString   = "Unknown"

    @IBOutlet var gendercell: UITableViewCell!

    @IBOutlet var logoutcell: UITableViewCell!
    @IBOutlet var preferencecell: UITableViewCell!
    @IBOutlet var weightcell: UITableViewCell!
    @IBOutlet var heightcell: UITableViewCell!
    @IBOutlet var agecell: UITableViewCell!
    let healthManager = HealthManager()
    let healthKitStore: HKHealthStore = HKHealthStore()
    override func viewDidLoad() {
        let profile = healthManager.readProfile()
        age.text = profile.age == nil ? kUnknownString : String(profile.age!)
        if ((NSUserDefaults.standardUserDefaults().valueForKey("alpha") ) != nil){
        let value = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
        
            preferencecell.contentView.alpha = value
            logoutcell.contentView.alpha = value
            heightcell.contentView.alpha = value
            weightcell.contentView.alpha = value
            username.contentView.alpha = value
            gendercell.contentView.alpha = value
            agecell.contentView.alpha = value
        }

        me.separatorColor = UIColor.clearColor()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        var ref = Firebase(url: "https://glowing-inferno-3788.firebaseio.com/");

        gendercell.backgroundColor = UIColor.clearColor()
        //gendercell.contentView.backgroundColor = UIColor.clearColor()
        agecell.backgroundColor = UIColor.clearColor()
        //agecell.contentView.backgroundColor = UIColor.clearColor()
        heightcell.backgroundColor = UIColor.clearColor()
        //heightcell.contentView.backgroundColor = UIColor.clearColor()
        weightcell.backgroundColor = UIColor.clearColor()
        //weightcell.contentView.backgroundColor = UIColor.clearColor()
        preferencecell.backgroundColor = UIColor.clearColor()
        //preferencecell.contentView.backgroundColor = UIColor.clearColor()
        logoutcell.backgroundColor = UIColor.clearColor()
        //logoutcell.contentView.backgroundColor = UIColor.clearColor()
       username.backgroundColor = UIColor.clearColor()
        //username.contentView.backgroundColor = UIColor.clearColor()
        //username.contentView.layer.opacity = 0.5
        me.backgroundColor = UIColor.clearColor()
        me.alpha = 0.9
//        me.backgroundView?.layer.opacity = 1

            
            
        heightLabel.text = (NSUserDefaults.standardUserDefaults().valueForKey("height") as? String)! + "cm"
          weightLabel.text = (NSUserDefaults.standardUserDefaults().valueForKey("weight") as? String)! + "kg"
            gender.text = NSUserDefaults.standardUserDefaults().valueForKey("gender") as? String
        preference.text = NSUserDefaults.standardUserDefaults().valueForKey("UserExerciseType") as? String
        
        bar.title = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as! String!
        name.text = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as? String
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changenickname"), name: "changenickname", object: nil)
//         NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changegender"), name: "changegender", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeheight"), name: "changeheight", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeweight"), name: "changeweight", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeexercisetype"), name: "changeexercisetype", object: nil)
        name.text = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as! String!
     
        
//        //updateheartrate()
//        updateHeight()
//        updateWeight()
        
        
    }
    override func tableView (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath , animated: true)
        
        switch (indexPath.section, indexPath.row)
        {
        case (2,0):
            // 添加功能
            var ref=Firebase(url: "https://glowing-inferno-3788.firebaseio.com/")
            ref.unauth()
            break
        default:
            break
        }
        
        
    }
    func updateProfileInfo(){
        let profile = healthManager.readProfile()
        age.text = profile.age == nil ? kUnknownString : String(profile.age!)
        gender.text = biologicalSexLiteral(profile.biologicalsex?.biologicalSex)
    }
    
    func biologicalSexLiteral(biologicalSex:HKBiologicalSex?)->String
    {
        var biologicalSexText = kUnknownString;
        
        if  biologicalSex != nil {
            
            switch( biologicalSex! )
            {
            case .Female:
                biologicalSexText = "Female"
            case .Male:
                biologicalSexText = "Male"
            default:
                break;
            }
            
        }
        return biologicalSexText;
    }
//
//    func updateHeartRate() {
//        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
//        let nowDate: NSDate = NSDate()
//        let calendar: NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
//        
//        let yearMonthDay: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
//        
//        let components: NSDateComponents = calendar.components(yearMonthDay , fromDate: nowDate)
//        let beginOfDay : NSDate = calendar.dateFromComponents(components)!
//        let predicate : NSPredicate = HKQuery.predicateForSamplesWithStartDate(beginOfDay, endDate: nowDate, options: HKQueryOptions.StrictStartDate)
//        
//        let squery = HKStatisticsQuery(quantityType: sampleType!, quantitySamplePredicate: predicate, options: HKStatisticsOptions.None, completionHandler: { (qurt, result, errval) -> Void in
//            
//            dispatch_async( dispatch_get_main_queue(), { () -> Void in
//                
//                let quantity: HKQuantity = result!.averageQuantity()!
//                let beats : Double = quantity.doubleValueForUnit(HKUnit.atmosphereUnit())
//                // [quantity doubleValueForUnit:[HKUnit heartBeatsPerMinuteUnit]]
//                self.heartrate.text = "\(beats)"
//            })
//        })
//        healthManager.healthKitStore.executeQuery(squery)
//    }

    
    
//    func updateheartrate()
//    {
//        // 1. Construct an HKSampleType for Height
//        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
//        
//        // 2. Call the method to read the most recent Height sample
//        self.healthManager.readMostRecentSample(sampleType!, completion: { (mostRecentheartrate, error) -> Void in
//            
//            if( error != nil )
//            {
//                print("Error reading height from HealthKit Store: \(error.localizedDescription)")
//                return;
//            }
//            
//            var heightLocalizedString = self.kUnknownString
//            self.height = mostRecentheartrate as? HKQuantitySample
//            // 3. Format the height to display it on the screen
//            if let meters = self.height?.quantity.doubleValueForUnit(HKUnit.countUnit()) {
//                let heightFormatter = NSNumberFormatter()
//                //heightFormatter.forPersonHeightUse = true
//                heightLocalizedString = heightFormatter.stringFromNumber(meters)!;
//            }
//            
//            
//            // 4. Update UI. HealthKit use an internal queue. We make sure that we interact with the UI in the main thread
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.heartrate.text = heightLocalizedString
//            });
//        })
//    }

    
    
    
    
    
    
    
    
    
    func updateHeight()
    {
        // 1. Construct an HKSampleType for Height
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
        // 2. Call the method to read the most recent Height sample
        self.healthManager.readMostRecentSample(sampleType!, completion: { (mostRecentHeight, error) -> Void in
            
            if( error != nil )
            {
                print("Error reading height from HealthKit Store: \(error.localizedDescription)")
                return;
            }
            
            var heightLocalizedString = self.kUnknownString
            self.height = mostRecentHeight as? HKQuantitySample
            // 3. Format the height to display it on the screen
            if let meters = self.height?.quantity.doubleValueForUnit(HKUnit.meterUnit()) {
                let heightFormatter = NSLengthFormatter()
                heightFormatter.forPersonHeightUse = true
                heightLocalizedString = heightFormatter.stringFromMeters(meters);
            }
            
            
            // 4. Update UI. HealthKit use an internal queue. We make sure that we interact with the UI in the main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.heightLabel.text = heightLocalizedString
            });
        })
    }
    
    
    
    func updateWeight()
    {
        // 1. Construct an HKSampleType for weight
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        
        // 2. Call the method to read the most recent weight sample
        self.healthManager.readMostRecentSample(sampleType!, completion: { (mostRecentWeight, error) -> Void in
            
            if( error != nil )
            {
                print("Error reading weight from HealthKit Store: \(error.localizedDescription)")
                return;
            }
            
            var weightLocalizedString = self.kUnknownString
            // 3. Format the weight to display it on the screen
            self.weight = mostRecentWeight as? HKQuantitySample
            if let kilograms = self.weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo)) {
                let weightFormatter = NSMassFormatter()
                weightFormatter.forPersonMassUse = true
                weightLocalizedString = weightFormatter.stringFromKilograms(kilograms)
            }
            
            // 4. Update UI in the main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.weightLabel.text = weightLocalizedString
            });
        });
    }

}
