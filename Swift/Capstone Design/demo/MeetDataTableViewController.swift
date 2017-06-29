//
//  MeetDataTableViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/16/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import HealthKit
import Firebase

public class Ameeting:NSObject{
    var heartrate:String = ""
    var calories:String=""
    var Duration:String=""
    var Date:String=""
    var Starttime=""
    var comment=""
    var exercisetype:String?
}

public class MeetDataTableViewController: UITableViewController,DataSourceChangedDelegate {
    var ref=Firebase(url: "https://glowing-inferno-3788.firebaseio.com/")
    var tempAverageHeart: Double=0
    var tempTotalenergy: Double=0
    var tempComment:  Int=0
    var tempHeartTimes: Double=0
    var tempHeartSamples: [Double]=[0]
    var tempMeetTime: Double=0
    var tempEnergySamples: [Double]=[0]
    var list=NSUserDefaults.standardUserDefaults().valueForKey("list") as! [Int]!
    @IBOutlet var mainview: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let loginData=["HaveLoginFlag":Bool(true)]
        PhoneConnectManager.sharedManager.transferUserInfo(loginData)
        
        PhoneConnectManager.sharedManager.addDataSourceChangedDelegate(self)
        loadTableData(PhoneConnectManager.sharedManager.getDataSource())

        if (NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") == nil){
            mainview.backgroundColor = UIColor(patternImage: UIImage(named: "j.png")!)
        }
        else{
            mainview.backgroundColor = UIColor(patternImage: UIImage(data: NSUserDefaults.standardUserDefaults().valueForKey("backgroundimage") as! NSData)!)
        
    }
        
        mainview.separatorColor = UIColor.clearColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        list=NSUserDefaults.standardUserDefaults().valueForKey("list") as! [Int]
        if(list.count>1){
            var meeting=NSUserDefaults.standardUserDefaults().valueForKey("meeting\(self.list[self.list.count-1])") as! NSDictionary!
            
            let DataDateA = meeting["Date"] as! String // 会议日期
            let meetingTimeA=meeting["actual_t"]as! Int
            let DataTimeA = String(format: "%02d:%02d ", meetingTimeA/60,meetingTimeA%60)
            let DataAverageHRA : Double=meeting["heartrate"] as! Double//平均心率
            let DataTotalECA: Double=meeting["calories"]as! Double//能量消耗
            let DataCommentA: Int=meeting["comment"]as! Int//评论
            let DataDateDicA=["DataDateDicA":String(DataDateA)]
            let DataTimeDicA=["DataTimeDicA":String(DataTimeA)]
            let DataNameA=["DataNameA":String(meeting["Name"]!)]
            PhoneConnectManager.sharedManager.transferUserInfo(DataNameA)
            PhoneConnectManager.sharedManager.transferUserInfo(DataDateDicA)
            PhoneConnectManager.sharedManager.transferUserInfo(DataTimeDicA)
            
            
            //        let DataAverageHRDic=["DataAverageHRDic":Double(DataAverageHR)]
            let DataAverageHRDicA=["DataAverageHRDicA":Double(DataAverageHRA)]
            PhoneConnectManager.sharedManager.transferUserInfo(DataAverageHRDicA)
            
            let DataTotalECDicA=["DataTotalECDicA":Double(DataTotalECA)]
            //           let DataTotalECDic=["DataTotalECDic":[Double](self.tempHeartSamples)]
            
            PhoneConnectManager.sharedManager.transferUserInfo(DataTotalECDicA)
            
            let DataCommentDicA=["DataCommentDicA":Double(DataCommentA)]
            PhoneConnectManager.sharedManager.transferUserInfo(DataCommentDicA)
            
            
            if(list.count>2){
                meeting=NSUserDefaults.standardUserDefaults().valueForKey("meeting\(self.list[self.list.count-2])") as! NSDictionary!
                let DataDateB = meeting["Date"] as! String // 会议日期
                let meetingTimeB=meeting["actual_t"]as! Int
                let DataTimeB = String(format: "%02d:%02d ", meetingTimeB/60,meetingTimeB%60)
                let DataAverageHRB : Double=meeting["heartrate"] as! Double//平均心率
                let DataTotalECB: Double=meeting["calories"]as! Double//能量消耗
                let DataCommentB: Int=meeting["comment"]as! Int//评论
                let DataDateDicB=["DataDateDicB":String(DataDateB)]
                let DataTimeDicB=["DataTimeDicB":String(DataTimeB)]
                let DataNameB=["DataNameB":String(meeting["Name"]!)]
                PhoneConnectManager.sharedManager.transferUserInfo(DataNameB)

                
                PhoneConnectManager.sharedManager.transferUserInfo(DataDateDicB)
                PhoneConnectManager.sharedManager.transferUserInfo(DataTimeDicB)

                
                //        let DataAverageHRDic=["DataAverageHRDic":Double(DataAverageHR)]
                let DataAverageHRDicB=["DataAverageHRDicB":Double(DataAverageHRB)]
                PhoneConnectManager.sharedManager.transferUserInfo(DataAverageHRDicB)
                
                let DataTotalECDicB=["DataTotalECDicB":Double(DataTotalECB)]
                //           let DataTotalECDic=["DataTotalECDic":[Double](self.tempHeartSamples)]
                
                PhoneConnectManager.sharedManager.transferUserInfo(DataTotalECDicB)
                
                let DataCommentDicB=["DataCommentDicB":Double(DataCommentB)]
                PhoneConnectManager.sharedManager.transferUserInfo(DataCommentDicB)
            }
            
            
            if(list.count>3){
                meeting=NSUserDefaults.standardUserDefaults().valueForKey("meeting\(self.list[self.list.count-3])") as! NSDictionary!
                
                
                let DataDateC = meeting["Date"] as! String // 会议日期
                let meetingTimeC=meeting["actual_t"]as! Int
                let DataTimeC = String(format: "%02d:%02d ", meetingTimeC/60,meetingTimeC%60)
                let DataAverageHRC : Double=meeting["heartrate"] as! Double//平均心率
                let DataTotalECC: Double=meeting["calories"]as! Double//能量消耗
                let DataCommentC: Int=meeting["comment"]as! Int//评论
                let DataDateDicC=["DataDateDicC":String(DataDateC)]
                let DataTimeDicC=["DataTimeDicC":String(DataTimeC)]
                let DataNameC=["DataNameC":String(meeting["Name"]!)]
                PhoneConnectManager.sharedManager.transferUserInfo(DataNameC)

                
                PhoneConnectManager.sharedManager.transferUserInfo(DataDateDicC)
                PhoneConnectManager.sharedManager.transferUserInfo(DataTimeDicC)

                
                //        let DataAverageHRDic=["DataAverageHRDic":Double(DataAverageHR)]
                let DataAverageHRDicC=["DataAverageHRDicC":Double(DataAverageHRC)]
                PhoneConnectManager.sharedManager.transferUserInfo(DataAverageHRDicC)
                
                let DataTotalECDicC=["DataTotalECDicC":Double(DataTotalECC)]
                //           let DataTotalECDic=["DataTotalECDic":[Double](self.tempHeartSamples)]
                
                PhoneConnectManager.sharedManager.transferUserInfo(DataTotalECDicC)
                
                let DataCommentDicC=["DataCommentDicC":Double(DataCommentC)]
                PhoneConnectManager.sharedManager.transferUserInfo(DataCommentDicC)
                
                
            }
        }
        
    }
    
    func dataSourceDidUpdate(dataSource: DataSource) {
        loadTableData(dataSource)
    }
    //searchPointA
    
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  NSUserDefaults.standardUserDefaults().integerForKey("MeetingNum")
    }
    
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSUserDefaults.standardUserDefaults().setObject(indexPath.row, forKey: "row")
        
    }
    public override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            list=NSUserDefaults.standardUserDefaults().valueForKey("list") as! [Int]
            if ref.authData != nil {
            let newmn=(NSUserDefaults.standardUserDefaults().valueForKey("MeetingNum") as! Int)-1
            NSUserDefaults.standardUserDefaults().setValue(newmn, forKey: "MeetingNum")
            //执行删除数据的操作
            self.ref.childByAppendingPath("users")
                .childByAppendingPath(self.ref.authData.uid).childByAppendingPath("\(list[1+indexPath.row])").removeValue()
            NSUserDefaults.standardUserDefaults().removeObjectForKey("meeting\(list[indexPath.row+1])")
            list.removeAtIndex(indexPath.row+1)
            NSUserDefaults.standardUserDefaults().setValue(list, forKey: "list")
            NSUserDefaults.standardUserDefaults().synchronize()
            ref.childByAppendingPath("users")
                .childByAppendingPath(ref.authData.uid).updateChildValues(["list": list])
            ref.childByAppendingPath("users")
                .childByAppendingPath(ref.authData.uid).updateChildValues(["MeetingNum":newmn ])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
            else {
                // No user is signed in
                let myStoryBoard = self.storyboard
                let anotherView = myStoryBoard!.instantiateViewControllerWithIdentifier("relogin")
                self.presentViewController(anotherView, animated: true, completion: nil)
            }
        }
    }
    
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("meetcell", forIndexPath: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.whiteColor()
        if (NSUserDefaults.standardUserDefaults().valueForKey("alpha") != nil){
            cell.contentView.alpha = NSUserDefaults.standardUserDefaults().valueForKey("alpha") as! CGFloat
        }
        else {
            cell.contentView.alpha = 0.6
        }
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        print(NSUserDefaults.standardUserDefaults().integerForKey("MeetingNum"))
        // 1. Get workout for the row. Cell text: Workout Date
        if (NSUserDefaults.standardUserDefaults().integerForKey("MeetingNum") >= 1){
            
            let list = NSUserDefaults.standardUserDefaults().valueForKey("list") as! [Int]!
            print("ROW: \(list[indexPath.row+1])")
            let meeting = NSUserDefaults.standardUserDefaults().valueForKey("meeting\(list[indexPath.row+1])") as! NSDictionary
            cell.textLabel!.text = meeting["Date"] as! String + " " + (meeting["StartTime"]as! String)
            cell.detailTextLabel?.text = "Duration(min): " + (meeting["Duration"] as! String)
            
            
        }
        
        //2. Detail text: Duration - Distance Duration
        //        if (NSUserDefaults.standardUserDefaults().integerForKey("MeetingNum") >= 1){
        //            let array = NSUserDefaults.standardUserDefaults().valueForKey("Duration") as! [String]!
        //            let detailText = "Duration(min): " + array[indexPath.row]
        //            cell.detailTextLabel?.text = detailText;
        //        }
        //   Distance in Km or miles depending on user selection
        
        // 3. Detail text: Energy Burned
        return cell
    }


    //searchPointB
    public override func viewDidDisappear(animated: Bool) {
        //        let tempDic=["test": Double(self.tempAverageHeart)]
           PhoneConnectManager.sharedManager.removeDataSourceChangedDelegate(self)
        
        //在这里从数据库下载上次会议的数据,替代掉下面的预设值
        
            
            
        
    }
}

private extension MeetDataTableViewController {
    private func loadTableData(dataSource: DataSource) {
        self.tempAverageHeart=dataSource.AverageHeartRate
        self.tempTotalenergy=dataSource.TotalEnergyConsumption
        self.tempHeartTimes=dataSource.TotalTimesMeasured
        self.tempComment=dataSource.CommentValue
        self.tempHeartSamples=dataSource.HeartRateArray
        self.tempMeetTime=dataSource.MeetTime
        self.tempEnergySamples=dataSource.EnergyArray
        
        //        var meeting = NSUserDefaults.standardUserDefaults().valueForKey("meeting\(list[list.count-1])") as! NSMutableDictionary
        var meeting:NSDictionary
        var new: NSDictionary
        //modified
        var key=NSUserDefaults.standardUserDefaults().objectForKey("currentmeeting")as! String
        if (key != "0"){
            meeting=NSUserDefaults.standardUserDefaults().valueForKey("meeting"+key) as! NSDictionary!
            new  = [
                "Name":meeting["Name"]!,
                "Date":meeting["Date"]!,
                "Duration": meeting["Duration"]!,
                "heartrate": self.tempAverageHeart,
                "calories" :self.tempTotalenergy,
                "StartTime": meeting["StartTime"]!,
                "exercisetype": "riding",
                "comment":dataSource.CommentValue,
                "note":meeting["note"]!,
                "detail":self.tempHeartSamples,
                "d_ca":self.tempEnergySamples,
                "actual_t":self.tempMeetTime
            ]
            
            self.ref.childByAppendingPath("users")
                .childByAppendingPath(self.ref.authData.uid).childByAppendingPath(key).setValue(new)
            NSUserDefaults.standardUserDefaults().setObject(new, forKey:"meeting"+key )
            NSUserDefaults.standardUserDefaults().setObject("0", forKey: "currentmeeting")
            NSUserDefaults.standardUserDefaults().synchronize()
}


//                    //平均心率
//                        meeting=NSUserDefaults.standardUserDefaults().valueForKey("meeting\(self.list[self.list.count-1])") as! NSDictionary!
//                    new  = [
//                        "Date":meeting["Date"]!,
//                        "Duration": meeting["Duration"]!,
//                        "heartrate": meeting["heartrate"]!,
//                        "calories" :tempTotalenergy,
//                        "StartTime": meeting["StartTime"]!,
//                        "exercisetype": "riding",
//                        "comment":meeting["comment"]!,
//                        "note":meeting["note"]!
//                    ]
//                    NSUserDefaults.standardUserDefaults().setObject(new, forKey:"meeting\(self.list[self.list.count-1])" )
//                    self.ref.childByAppendingPath("users")
//                        .childByAppendingPath(self.ref.authData.uid).childByAppendingPath("\(self.list[self.list.count-1])").childByAppendingPath("calories").setValue(self.tempTotalenergy)
//                //这是总的能量的值
//                
//                //这是心率的样本数
//                
//                meeting=NSUserDefaults.standardUserDefaults().valueForKey("meeting\(self.list[self.list.count-1])") as! NSDictionary!
//                    new  = [
//                        "Date":meeting["Date"]!,
//                        "Duration": meeting["Duration"]!,
//                        "heartrate": meeting["heartrate"]!,
//                        "calories" :meeting["calories"]!,
//                        "StartTime": meeting["StartTime"]!,
//                        "exercisetype": "riding",
//                        "comment":tempComment,
//                        "note":meeting["note"]!
//                    ]
//                    NSUserDefaults.standardUserDefaults().setObject(new, forKey:"meeting\(self.list[self.list.count-1])" )
//                    self.ref.childByAppendingPath("users")
//                        .childByAppendingPath(self.ref.authData.uid).childByAppendingPath("\(self.list[self.list.count-1])").childByAppendingPath("comment").setValue(self.tempComment)
//                //这是评论的分数
//                
            }
        }
