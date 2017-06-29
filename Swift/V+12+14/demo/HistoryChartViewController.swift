//
//  HistoryChartViewController.swift
//  demo
//
//  Created by Zhou Ti on 12/7/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import UIKit
import Charts

class HistoryChartViewController: UIViewController {
    var months: [String]!
    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var meeting:NSDictionary
        var splitedarray:[String]
        var temp:Int?
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var unitsSold:[Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        var list=NSUserDefaults.standardUserDefaults().objectForKey("list") as! [Int]
        let timeFormatter = NSDateFormatter()
        let dates = NSDate()
        timeFormatter.dateFormat = "yyy-MM-dd"
        let year=(timeFormatter.stringFromDate(dates) as String!).componentsSeparatedByString("-")
        if (list.count>1){
        for i in 1...list.count-1 {
            meeting=NSUserDefaults.standardUserDefaults().objectForKey("meeting\(list[i])")as! NSDictionary
            splitedarray = ( meeting["Date"]as! String).componentsSeparatedByString("-")
            if (splitedarray[0]==year[0]){
                    temp=Int(splitedarray[1])
                    unitsSold[temp!-1]+=meeting["calories"]as!Double
                
            }
            
            
        }
        }
        
        
        
        setChart(months, values: unitsSold)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Calories Consume")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.descriptionText = "Calories(kcal)"
        barChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .EaseInBounce)
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
