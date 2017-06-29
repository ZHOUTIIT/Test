//
//  ExerciseResultViewController.swift
//  demo
//
//  Created by Zhou Ti on 11/22/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import Charts

class ExerciseResultViewController: UIViewController {
    @IBOutlet weak var comment: UILabel!
    @IBOutlet var result: UILabel!
    @IBOutlet var navigationbar: UINavigationItem!
    var time: [String]! = []
    var c_time:[String]! = []
    var heartratedata: [Double]! = []
    var caloriedata: [Double]! = []
  
    @IBOutlet var heartrate: LineChartView!
    @IBOutlet weak var Start: UIButton!

    @IBOutlet var calorie: LineChartView!
    let hmax: UInt32 = 120
    let hmin: UInt32 = 80
    let cmax: UInt32 = 20
    let cmin: UInt32 = 5
    var list:[Int] = []
    var rownum:Int = 0
    var duration:Int=0
    override func viewDidLoad() {
        
        super.viewDidLoad()

        comment.layer.borderColor = UIColor(red: 60/255, green: 40/255, blue: 129/255, alpha: 1).CGColor
        comment.layer.borderWidth = 1
        comment.layer.cornerRadius = 8
        navigationbar.title = "Meeting Data"
        var sum: Double = 0
        var heartratedata:[Double]=[]
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        rownum = NSUserDefaults.standardUserDefaults().valueForKey("row")! as! Int
        list = NSUserDefaults.standardUserDefaults().valueForKey("list") as! [Int]!
        let meeting = NSUserDefaults.standardUserDefaults().valueForKey("meeting\(list[rownum+1])") as! NSDictionary
        let temp:Int?=Int(meeting["actual_t"]as! Double)/60
        duration = temp!
        let detail_h = meeting["detail"]as! [Double]
        let detail_c = meeting["d_ca"] as! [Double]
        if ((meeting["note"]) != nil) {
            comment.text = meeting["note"] as! String
        }
   
        result.text = (meeting["Date"] as! String) + "   " + (meeting["StartTime"] as! String)
        // Do any additional setup after loading the view.
        print("\(detail_h[detail_h.count-1])")
        if (detail_h.count<=30){
            for (var index = 0; index < detail_h.count; index++){
                time.append("\(index*5)s")
                
                //heartratedata.append(Double(arc4random_uniform(hmax - hmin) + hmin))
            }
            setheartrateChart(time, values:detail_h )
            //setcalorieChart(time, values: caloriedata)
        }else{
            
            for (var index = 0; index <= duration; index++){
                time.append("\(index)min")
                heartratedata.append(detail_h[index*Int(detail_h.count/20)])
                //heartratedata.append(Double(arc4random_uniform(hmax - hmin) + hmin))
//                sum = sum + Double(arc4random_uniform(cmax - cmin) + cmin)
//                caloriedata.append(sum)
            }
            setheartrateChart(time, values:heartratedata )
            //setcalorieChart(time, values: caloriedata)
            
        }
        if (detail_c.count<=30){
            for (var index = 0; index < detail_c.count; index++){
                c_time.append("\(index*5)s")
                
                //heartratedata.append(Double(arc4random_uniform(hmax - hmin) + hmin))
            }
            //setheartrateChart(c_time, values:detail_h )
            setcalorieChart(c_time, values: detail_c)
        }else{
            
            for (var index = 0; index <= duration; index++){
                c_time.append("\(index)min")
                caloriedata.append(detail_c[index*Int(detail_c.count/20)])
                //heartratedata.append(Double(arc4random_uniform(hmax - hmin) + hmin))
                //                sum = sum + Double(arc4random_uniform(cmax - cmin) + cmin)
                //                caloriedata.append(sum)
            }
            //setheartrateChart(time, values:heartratedata )
            setcalorieChart(c_time, values: caloriedata)
            
        }
        // 这里更新heartrate和calorie的数值 目前先以预设值代替
        
        
    }
    
    func setheartrateChart(dataPoints: [String], values: [Double]) {
        heartrate.noDataText = "You need to provide data for the chart."
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let linechartDataSet = LineChartDataSet(yVals: dataEntries, label: "Heartrate")
        let linechartData = LineChartData(xVals: dataPoints, dataSet: linechartDataSet)
        heartrate.data = linechartData
        heartrate.doubleTapToZoomEnabled = false
        heartrate.descriptionText = "Heartrate(bpm)"
        print("\(heartrate.chartYMin)")
        heartrate.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
    }
    func setcalorieChart(dataPoints: [String], values: [Double]) {
        calorie.noDataText = "You need to provide data for the chart."
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let linechartDataSet = LineChartDataSet(yVals: dataEntries, label: "Calorie")
        let linechartData = LineChartData(xVals: dataPoints, dataSet: linechartDataSet)
        calorie.data = linechartData
        calorie.doubleTapToZoomEnabled = false
        calorie.descriptionText = "Calories(cal)"
        calorie.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func setascurrentmeeting(sender:UIButton?){
        let meeting = NSUserDefaults.standardUserDefaults().valueForKey("meeting\(list[rownum+1])") as! NSDictionary

        let tempduration: Double?=Double(meeting["Duration"]as! String)
        NSUserDefaults.standardUserDefaults().setObject("\(self.list[self.rownum+1])", forKey: "currentmeeting")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let applicationData = ["exerciseDuration":Double(tempduration!)]
        let countData=["shouldCountFlag":Int(1)]
        PhoneConnectManager.sharedManager.transferUserInfo(applicationData)
        PhoneConnectManager.sharedManager.transferUserInfo(countData)
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
