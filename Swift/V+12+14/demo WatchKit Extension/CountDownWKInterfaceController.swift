//
//  CountDownWKInterfaceController.swift
//  demo
//
//  Created by Zhou Ti on 11/17/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

protocol TransDelegate{
    func transTotalEnergy(energyData:Double)
    //    func transAverageHeartRate(heartRateData:Double)
    //    func transTotalTimes(timesData:Double)
    //    func transSamples(samplesData:[Double])
}


class CountDownWKInterfaceController: WKInterfaceController,DataSourceChangedDelegate,HKWorkoutSessionDelegate{
    override func willActivate() {
        super.willActivate()
        loadTableData(WatchConnectManager.sharedManager.getDataSource())
        if(isCounting){
            if(isStop){
                StartDate=NSDate.init()
                timeInteval=(StartDate?.timeIntervalSinceDate(EndDate!))!
                let tempIntInteval: Double = Double(timeInteval)
                if tempIntInteval>(self.Total){
                    self.Total=0
                }
                else{
                    self.Total-=(tempIntInteval-1)
                }
            }
        }
    }
    
    let healthStore = HKHealthStore()
    var currentWorkoutSession: HKWorkoutSession?
    var workoutBeginDate: NSDate?
    var workoutEndDate: NSDate?
    var isWorkoutRunning = false
    var isStop:Bool=false
    var currentHeartRateQuery: HKQuery?
    var currentActiveEnergyQuery: HKQuery?
    var activeHeartRateSamples = [HKQuantitySample]()
    var activeEnergySamples = [HKQuantitySample]()
    var currentHeartRate = HKQuantity(unit: HKUnit.countUnit().unitDividedByUnit(HKUnit.minuteUnit()), doubleValue: 0.0)
    var currentActiveEnergyQuantity = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: 0.0)
    var StartDate:NSDate?
    var EndDate:NSDate?
    var timeInteval: Double=0
    var totalEnergy: Double=0
    var totalHeartRate: Double=0
    var totalTimes: Double=0
    var HeartRateSamples: [Double]=[0]
    var activeRate:Double=0
    var meetingTime:Double=0
    var energySamples:[Double]=[0]
    var countFlag:Int=1
    var InitialMeetTime: Double=0
    func dataSourceDidUpdate(dataSource: DataSource) {
        loadTableData(dataSource)
    }
    
    
    @IBOutlet var displayLabel: WKInterfaceLabel!
    
    @IBOutlet var display: WKInterfaceLabel!
    
    @IBOutlet var StartButton: WKInterfaceButton!
    var IntTemp:Int=0
    var firstFlag:Int=1
    var Total: Double = 0 {
        willSet(Total){
            let tempIntTotal:Int=Int(Total)
            let watchHour=(tempIntTotal/3600);
            let watchMinute=(tempIntTotal-3600*watchHour)/60;
            let watchSecond=tempIntTotal%60;
            let stringTmp=NSString(format:"%02d:%02d:%02d",watchHour, watchMinute,watchSecond) as String
            display!.setText(stringTmp)
        }
    }
    
    var watchTimer: NSTimer?
    var isCounting: Bool=false
    
    @IBAction func pushAction() {
        WatchConnectManager.sharedManager.removeDataSourceChangedDelegate(self)
        var AverageHeartDic = ["AverageHeartDic":Double(0)]
        if self.totalTimes != 0 {
            AverageHeartDic = ["AverageHeartDic":Double(self.totalHeartRate/self.totalTimes)]
        }
        let TotalEnergyDic=["TotalEnergyDic": Double(self.totalEnergy)]
        let HeartTimeDic=["HeartTimeDic": Double(self.totalTimes)]
        let HeartSamplesDic=["HeartSamplesDic": [Double](self.HeartRateSamples)]
        self.meetingTime=self.InitialMeetTime-self.Total
        let MeetTimeDic=["MeetTimeDic": Double(self.meetingTime)]
        let EnergyArrayDic=["EnergyArrayDic":[Double](self.energySamples)]
        WatchConnectManager.sharedManager.transferUserInfo(AverageHeartDic)
        WatchConnectManager.sharedManager.transferUserInfo(TotalEnergyDic)
        WatchConnectManager.sharedManager.transferUserInfo(HeartTimeDic)
        WatchConnectManager.sharedManager.transferUserInfo(HeartSamplesDic)
        WatchConnectManager.sharedManager.transferUserInfo(MeetTimeDic)
        WatchConnectManager.sharedManager.transferUserInfo(EnergyArrayDic)
        if(isWorkoutRunning){
            healthStore.endWorkoutSession(self.currentWorkoutSession!)
            isWorkoutRunning=false
        }
        self.pushControllerWithName("CommentWKInterfaceController", context: nil)
    }
    
    @IBAction func EndAction() {
        if(firstFlag==1){
            if isWorkoutRunning {
                guard let workoutSession = currentWorkoutSession else { return }
                healthStore.endWorkoutSession(workoutSession)
                isWorkoutRunning = false
            }
            else {
                // Begin workout.
                isWorkoutRunning = true
            }
            currentHeartRate = HKQuantity(unit: HKUnit.countUnit().unitDividedByUnit(HKUnit.minuteUnit()), doubleValue: 0.0)
            currentActiveEnergyQuantity = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: 0.0)
            currentHeartRateQuery = nil
            activeHeartRateSamples = []
            activeEnergySamples = []
            // An indoor walk workout session. There are other activity and location types available to you.
            let workoutSession = HKWorkoutSession(activityType: .Walking, locationType: .Indoor)
            workoutSession.delegate = self
            currentWorkoutSession = workoutSession
            healthStore.startWorkoutSession(workoutSession)
            firstFlag=0
        }
        
        if(self.Total>0){
            countFlag=0
            if(!isCounting){
                watchTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
                updateTimer(watchTimer!);
                isCounting=true;
                StartButton!.setTitle("Pause");
            }
            else{
                watchTimer?.invalidate()
                watchTimer = nil
                isCounting=false
                StartButton!.setTitle("Start");
            }
        }
        else{
            self.Total=0;
        }
    }
    
    @IBOutlet var testTable: WKInterfaceTable!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WatchConnectManager.sharedManager.addDataSourceChangedDelegate(self)
        self.countFlag=1
        loadTableData(WatchConnectManager.sharedManager.getDataSource())
        loadHealthTable()
        self.countFlag=1
    }
    var tempDouble:Double=0
    func updateTimer(timer: NSTimer) {
        Total -= 1
        if (Total==0){
            watchTimer?.invalidate()
            watchTimer = nil
            isCounting=false
            StartButton!.setTitle("Times up")
            if(isWorkoutRunning){
                healthStore.endWorkoutSession(self.currentWorkoutSession!)
                isWorkoutRunning=false
            }
        }
        loadHealthTable()
        tempDouble=self.totalEnergy
    }
    
    var transDelegate: TransDelegate?
    func updateHealthData(){
        self.transDelegate?.transTotalEnergy(self.tempDouble)
        //        self.transDelegate?.transAverageHeartRate(self.totalHeartRate/self.totalTimes)
        //        self.transDelegate?.transTotalTimes(self.totalTimes)
        //        self.transDelegate?.transSamples(self.HeartRateSamples)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        WatchConnectManager.sharedManager.removeDataSourceChangedDelegate(self)
        var AverageHeartDic = ["AverageHeartDic":Double(0)]
        if self.totalTimes != 0 {
            AverageHeartDic = ["AverageHeartDic":Double(self.totalHeartRate/self.totalTimes)]
        }
        let TotalEnergyDic=["TotalEnergyDic": Double(self.totalEnergy)]
        let HeartTimeDic=["HeartTimeDic": Double(self.totalTimes)]
        let HeartSamplesDic=["HeartSamplesDic": [Double](self.HeartRateSamples)]
        let MeetTimeDic=["MeetTimeDic": Double(self.meetingTime)]
        let EnergyArrayDic=["EnergyArrayDic":[Double](self.energySamples)]
        WatchConnectManager.sharedManager.transferUserInfo(AverageHeartDic)
        WatchConnectManager.sharedManager.transferUserInfo(TotalEnergyDic)
        WatchConnectManager.sharedManager.transferUserInfo(HeartTimeDic)
        WatchConnectManager.sharedManager.transferUserInfo(HeartSamplesDic)
        WatchConnectManager.sharedManager.transferUserInfo(MeetTimeDic)
        WatchConnectManager.sharedManager.transferUserInfo(EnergyArrayDic)
        //        if(isWorkoutRunning){
        //            healthStore.endWorkoutSession(self.currentWorkoutSession!)
        //            isWorkoutRunning=false
        //        }
        EndDate=NSDate.init()
        self.isStop=true
        super.didDeactivate()
    }
    
    func saveWorkout() {
        // Obtain the `HKObjectType` for active energy burned.
        guard let HeartRateType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else { return }
        guard let activeEnergyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) else { return }
        
        
        // Only proceed if both `beginDate` and `endDate` are non-nil.
        guard let beginDate = workoutBeginDate, endDate = workoutEndDate else { return }
        
        /*
        NOTE: There is a known bug where activityType property of HKWorkoutSession returns 0, as of iOS 9.1 and watchOS 2.0.1. So, rather than set it using the value from the `HKWorkoutSession`, set it explicitly for the HKWorkout object.
        */
        let workout = HKWorkout(activityType: HKWorkoutActivityType.Walking, startDate: beginDate, endDate: endDate, duration: endDate.timeIntervalSinceDate(beginDate), totalEnergyBurned: currentActiveEnergyQuantity, totalDistance: HKQuantity(unit: HKUnit.meterUnit(), doubleValue: 0.0), metadata: nil)
        
        // Save the array of samples that produces the energy burned total
        let finalHeartRateSamples = activeHeartRateSamples
        let finalActiveEnergySamples = activeEnergySamples
        
        
        guard healthStore.authorizationStatusForType(HeartRateType) == .SharingAuthorized && healthStore.authorizationStatusForType(HKObjectType.workoutType()) == .SharingAuthorized else { return }
        guard healthStore.authorizationStatusForType(activeEnergyType) == .SharingAuthorized && healthStore.authorizationStatusForType(HKObjectType.workoutType()) == .SharingAuthorized else { return }
        
        
        healthStore.saveObject(workout) { [unowned self] success, error in
            if let error = error where !success {
                print("An error occurred saving the workout. The error was: \(error.localizedDescription)")
                return
            }
            
            // Since HealthKit completion blocks may come back on a background queue, please dispatch back to the main queue.
            
            if success && finalHeartRateSamples.count > 0 {
                // Associate the accumulated samples with the workout.
                self.healthStore.addSamples(finalHeartRateSamples, toWorkout: workout) { success, error in
                    if let error = error where !success {
                        print("An error occurred adding samples to the workout. The error was: \(error.localizedDescription)")
                    }
                }
                
            }
            if success && finalActiveEnergySamples.count > 0 {
                self.healthStore.addSamples(finalActiveEnergySamples, toWorkout: workout) { success, error in
                    if let error = error where !success {
                        print("An error occurred adding samples to the workout. The error was: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func beginWorkoutOnDate(beginDate: NSDate) {
        // Obtain the `HKObjectType` for active energy burned and the `HKUnit` for kilocalories.
        guard let activeHeartRateType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else { return }
        let HeartRateUnit = HKUnit.countUnit().unitDividedByUnit(HKUnit.minuteUnit());
        guard let activeEnergyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) else { return }
        let energyUnit = HKUnit.kilocalorieUnit()
        
        // Update properties.
        self.HeartRateSamples.removeAll()
        self.energySamples.removeAll()
        
        workoutBeginDate = beginDate
        
        // Set up a predicate to obtain only samples from the local device starting from `beginDate`.
        let datePredicate = HKQuery.predicateForSamplesWithStartDate(beginDate, endDate: nil, options: .None)
        let devicePredicate = HKQuery.predicateForObjectsFromDevices([HKDevice.localDevice()])
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[datePredicate, devicePredicate])
        
        /*
        Create a results handler to recreate the samples generated by a query of active energy samples so that they can be associated with this app in the move graph. It should be noted that if your app has different heuristics for active energy burned you can generate your own quantities rather than rely on those from the watch. The sum of your sample's quantity values should equal the energy burned value provided for the workout.
        */
        
        let heartRateSampleHandler = { [unowned self] (samples: [HKQuantitySample]) -> Void in
            if(self.isCounting){
                dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                    let HeartValue = self.currentHeartRate.doubleValueForUnit(HeartRateUnit)
                    let processedResultsHeartRate: (Double, [HKQuantitySample]) = samples.reduce((HeartValue, [])) { current, HeartSamples in
                        let HeartRateValue = HeartSamples.quantity.doubleValueForUnit(HeartRateUnit)
                        
                        let HeartRate = HKQuantitySample(type: activeHeartRateType, quantity: HeartSamples.quantity, startDate: HeartSamples.startDate, endDate: HeartSamples.endDate)
                        
                        return (HeartRateValue,  [HeartRate])
                    }
                    
                    // Update the UI.
                    self.currentHeartRate = HKQuantity(unit: HeartRateUnit, doubleValue: processedResultsHeartRate.0)
                    self.activeRate=processedResultsHeartRate.0
                    self.activeHeartRateSamples = processedResultsHeartRate.1
                    self.totalHeartRate+=processedResultsHeartRate.0
                    if(self.totalHeartRate<40){
                    }
                    else{
                        self.HeartRateSamples.append(processedResultsHeartRate.0)
                        self.totalTimes+=1
                    }
                }
            }
        }
        
        let energySampleHandler = { [unowned self] (samples: [HKQuantitySample]) -> Void in
            if(self.isCounting){
                dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                    
                    let initialActiveEnergy = self.currentActiveEnergyQuantity.doubleValueForUnit(energyUnit)
                    let processedResults: (Double, [HKQuantitySample]) = samples.reduce((initialActiveEnergy, [])) { current, sample in
                        let accumulatedValue = current.0 + sample.quantity.doubleValueForUnit(energyUnit)
                        
                        let ourSample = HKQuantitySample(type: activeEnergyType, quantity: sample.quantity, startDate: sample.startDate, endDate: sample.endDate)
                        
                        return (accumulatedValue, current.1 + [ourSample])
                    }
                    
                    
                    // Update our samples.
                    self.currentActiveEnergyQuantity = HKQuantity(unit: energyUnit, doubleValue: processedResults.0)
                    
                    // Update our samples.
                    self.activeEnergySamples += processedResults.1
                    self.energySamples.append(processedResults.0)
                    self.totalEnergy=processedResults.0
                }
            }
        }
        
        // Create a query to report new Active Energy Burned samples to our app.
        let activeHeartQuery = HKAnchoredObjectQuery(type: activeHeartRateType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { query, samples, deletedObjects, anchor, error in
            if let error = error {
                print("An error occurred with the `activeHeartRateQuery`. The error was: \(error.localizedDescription)")
                return
            }
            // NOTE: `deletedObjects` are not considered in the handler as there is no way to delete samples from the watch during a workout.
            guard let activeHeartRateSamples = samples as? [HKQuantitySample] else { return }
            heartRateSampleHandler(activeHeartRateSamples)
        }
        
        let activeEnergyQuery = HKAnchoredObjectQuery(type: activeEnergyType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { query, samples, deletedObjects, anchor, error in
            if let error = error {
                print("An error occurred with the `activeEnergyQuery`. The error was: \(error.localizedDescription)")
                return
            }
            // NOTE: `deletedObjects` are not considered in the handler as there is no way to delete samples from the watch during a workout.
            guard let activeEnergySamples = samples as? [HKQuantitySample] else { return }
            energySampleHandler(activeEnergySamples)
        }
        
        // Assign the same handler to process future samples generated while the query is still active.
        activeHeartQuery.updateHandler = { query, samples, deletedObjects, anchor, error in
            if let error = error {
                print("An error occurred with the `activeHeartRateQuery`. The error was: \(error.localizedDescription)")
                return
            }
            // NOTE: `deletedObjects` are not considered in the handler as there is no way to delete samples from the watch during a workout.
            guard let activeHeartRateSamples = samples as? [HKQuantitySample] else { return }
            heartRateSampleHandler(activeHeartRateSamples)
        }
        activeEnergyQuery.updateHandler = { query, samples, deletedObjects, anchor, error in
            if let error = error {
                print("An error occurred with the `activeEnergyQuery`. The error was: \(error.localizedDescription)")
                return
            }
            // NOTE: `deletedObjects` are not considered in the handler as there is no way to delete samples from the watch during a workout.
            guard let activeEnergySamples = samples as? [HKQuantitySample] else { return }
            energySampleHandler(activeEnergySamples)
        }
        
        currentHeartRateQuery = activeHeartQuery
        currentActiveEnergyQuery = activeEnergyQuery
        healthStore.executeQuery(activeHeartQuery)
        healthStore.executeQuery(activeEnergyQuery)
        
    }
    
    func endWorkoutOnDate(endDate: NSDate) {
        workoutEndDate = endDate
        
        
        if let Heartquery = currentHeartRateQuery {
            healthStore.stopQuery(Heartquery)
        }
        if let Energyquery = currentActiveEnergyQuery {
            healthStore.stopQuery(Energyquery)
        }
        
        saveWorkout()
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didChangeToState toState: HKWorkoutSessionState, fromState: HKWorkoutSessionState, date: NSDate) {
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            switch toState {
            case .Running:
                self.beginWorkoutOnDate(date)
                
            case .Ended:
                self.endWorkoutOnDate(date)
                
            default:
                print("Unexpected workout session state: \(toState)")
            }
        }
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didFailWithError error: NSError) {
        print("The workout session failed. The error was: \(error.localizedDescription)")
    }
}

private extension CountDownWKInterfaceController {
    private func loadTableData(dataSource: DataSource) {
        if(countFlag==1){
            self.Total=dataSource.CountDownvalue*60
            InitialMeetTime=self.Total
        }
        //       self.Total=180
    }
    
    private func loadHealthTable(){
        self.testTable.setNumberOfRows(2, withRowType: "HealthDataTable")
        let rowA=testTable.rowControllerAtIndex(0) as! HealthDataTable
        let rowB=testTable.rowControllerAtIndex(1) as! HealthDataTable
        if(self.firstFlag==0){
            if(self.totalHeartRate>0){
                rowA.DisplayResult.setText(String(format:"%.2f  bpm",
                    self.HeartRateSamples.last!))
                rowA.TypeImage.setImageNamed("HeartRate.png")
                rowA.TypeImage.setWidth(48)
                rowA.TypeImage.setHeight(44.5)
            }
            else
            {
                rowA.DisplayResult.setText("measuring")
                rowA.TypeImage.setImageNamed("HeartRate.png")
                rowA.TypeImage.setWidth(48)
                rowA.TypeImage.setHeight(44.5)
            }
            if(self.totalEnergy>0){
                let tempDouble = self.totalEnergy*1000
                rowB.DisplayResult.setText(String(format: "%.2f  cal", self.tempDouble))
                rowB.TypeImage.setImageNamed("EnergyBurned.png")
                rowB.TypeImage.setWidth(48)
                rowB.TypeImage.setHeight(44.5)
            }
            else{
                rowB.DisplayResult.setText("measuring")
                rowB.TypeImage.setImageNamed("EnergyBurned.png")
                rowB.TypeImage.setWidth(48)
                rowB.TypeImage.setHeight(44.5)
            }
        }
        else{
            rowA.DisplayResult.setText("wait")
            rowA.TypeImage.setImageNamed("HeartRate.png")
            rowA.TypeImage.setWidth(48)
            rowA.TypeImage.setHeight(44.5)
            rowB.DisplayResult.setText("wait")
            rowB.TypeImage.setImageNamed("EnergyBurned.png")
            rowB.TypeImage.setWidth(48)
            rowB.TypeImage.setHeight(44.5)
        }
    }
}

