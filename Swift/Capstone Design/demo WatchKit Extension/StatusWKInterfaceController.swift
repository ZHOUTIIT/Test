

//import WatchKit
//import Foundation
//import HealthKit
//
//
//class StatusWKInterfaceController: WKInterfaceController, HKWorkoutSessionDelegate  {
//    override func awakeWithContext(context: AnyObject?) {
//        super.awakeWithContext(context)
//    }
//    let healthStore = HKHealthStore()
//    
//    // Used to track the current `HKWorkoutSession`.
//    var currentWorkoutSession: HKWorkoutSession?
//    var workoutBeginDate: NSDate?
//    var workoutEndDate: NSDate?
//    
//    var isWorkoutRunning = false
//    var currentHeartRateQuery: HKQuery?
//    var currentActiveEnergyQuery: HKQuery?
//    
//    
//    var activeHeartRateSamples = [HKQuantitySample]()
//    var activeEnergySamples = [HKQuantitySample]()
//    
//    
//    // Start with a zero quantity.
//    var currentHeartRate = HKQuantity(unit: HKUnit.countUnit().unitDividedByUnit(HKUnit.minuteUnit()), doubleValue: 0.0)
//    var currentActiveEnergyQuantity = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: 0.0)
//    var totalEnergy: Double=0
//    var totalHeartRate: Double=0
//    var totalTimes: Double=0
//    var HeartRateSamples: [Double]=[0]
//    var activateDouble:Double=0
//    
//    
//    override func willActivate() {
//        // This method is called when watch view controller is about to be visible to user
//        super.willActivate()
//            if isWorkoutRunning {
//            guard let workoutSession = currentWorkoutSession else { return }
//            
//            healthStore.endWorkoutSession(workoutSession)
//            isWorkoutRunning = false
//        } else {
//            // Begin workout.
//            isWorkoutRunning = true
//            
//            // Clear the local Active Energy Burned quantity when beginning a workout session.
//            currentHeartRate = HKQuantity(unit: HKUnit.countUnit().unitDividedByUnit(HKUnit.minuteUnit()), doubleValue: 0.0)
//            currentActiveEnergyQuantity = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: 0.0)
//            
//            currentHeartRateQuery = nil
//            activeHeartRateSamples = []
//            activeEnergySamples = []
//            
//            
//            // An indoor walk workout session. There are other activity and location types available to you.
//            let workoutSession = HKWorkoutSession(activityType: .Walking, locationType: .Indoor)
//            workoutSession.delegate = self
//            
//            currentWorkoutSession = workoutSession
//            
//            healthStore.startWorkoutSession(workoutSession)
//        }
//    }
//    
//    override func didDeactivate() {
//    
//        // This method is called when watch view controller is no longer visible
//        super.didDeactivate()
//        let AverageHeartDic = ["AverageHeartDic":Double(self.totalHeartRate/(self.totalTimes))]
//        let TotalEnergyDic=["TotalEnergyDic": Double(self.totalEnergy)]
//        let HeartTimeDic=["HeartTimeDic": Double(self.totalTimes)]
//        let HeartSamplesDic=["HeartSamplesDic": [Double](self.HeartRateSamples)]
//        WatchConnectManager.sharedManager.transferUserInfo(AverageHeartDic)
//        WatchConnectManager.sharedManager.transferUserInfo(TotalEnergyDic)
//        WatchConnectManager.sharedManager.transferUserInfo(HeartTimeDic)
//        WatchConnectManager.sharedManager.transferUserInfo(HeartSamplesDic)
//    }
//    
//    
//    @IBOutlet var activeEnergyBurnedLabel: WKInterfaceLabel!
//    @IBOutlet var activeHeartRateLabel: WKInterfaceLabel!
//    
//    @IBAction func EndStatusAction() {
//           }
//    
//    
//    // This will toggle beginning and ending a workout session.
//
//    
//    // MARK: Convenience
//    
//    /*
//    Create and save an HKWorkout with the amount of Active Energy Burned we accumulated during the HKWorkoutSession.
//    
//    Additionally, associate the Active Energy Burned samples to our workout to facilitate showing our app as credited for these samples in the Move graph in the Activity app on iPhone.
//    */
//    func saveWorkout() {
//        // Obtain the `HKObjectType` for active energy burned.
//        guard let HeartRateType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else { return }
//        guard let activeEnergyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) else { return }
//        
//        
//        // Only proceed if both `beginDate` and `endDate` are non-nil.
//        guard let beginDate = workoutBeginDate, endDate = workoutEndDate else { return }
//        
//        /*
//        NOTE: There is a known bug where activityType property of HKWorkoutSession returns 0, as of iOS 9.1 and watchOS 2.0.1. So, rather than set it using the value from the `HKWorkoutSession`, set it explicitly for the HKWorkout object.
//        */
//        let workout = HKWorkout(activityType: HKWorkoutActivityType.Walking, startDate: beginDate, endDate: endDate, duration: endDate.timeIntervalSinceDate(beginDate), totalEnergyBurned: currentActiveEnergyQuantity, totalDistance: HKQuantity(unit: HKUnit.meterUnit(), doubleValue: 0.0), metadata: nil)
//        
//        // Save the array of samples that produces the energy burned total
//        let finalHeartRateSamples = activeHeartRateSamples
//        let finalActiveEnergySamples = activeEnergySamples
//        
//        
//        guard healthStore.authorizationStatusForType(HeartRateType) == .SharingAuthorized && healthStore.authorizationStatusForType(HKObjectType.workoutType()) == .SharingAuthorized else { return }
//        guard healthStore.authorizationStatusForType(activeEnergyType) == .SharingAuthorized && healthStore.authorizationStatusForType(HKObjectType.workoutType()) == .SharingAuthorized else { return }
//        
//        
//        healthStore.saveObject(workout) { [unowned self] success, error in
//            if let error = error where !success {
//                print("An error occurred saving the workout. The error was: \(error.localizedDescription)")
//                return
//            }
//            
//            // Since HealthKit completion blocks may come back on a background queue, please dispatch back to the main queue.
//            if success && finalHeartRateSamples.count > 0 {
//                // Associate the accumulated samples with the workout.
//                self.healthStore.addSamples(finalHeartRateSamples, toWorkout: workout) { success, error in
//                    if let error = error where !success {
//                        print("An error occurred adding samples to the workout. The error was: \(error.localizedDescription)")
//                    }
//                }
//                
//            }
//            if success && finalActiveEnergySamples.count > 0 {
//                self.healthStore.addSamples(finalActiveEnergySamples, toWorkout: workout) { success, error in
//                    if let error = error where !success {
//                        print("An error occurred adding samples to the workout. The error was: \(error.localizedDescription)")
//                    }
//                }
//            }
//        }
//    }
//    
//    func beginWorkoutOnDate(beginDate: NSDate) {
//        // Obtain the `HKObjectType` for active energy burned and the `HKUnit` for kilocalories.
//        guard let activeHeartRateType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else { return }
//        let HeartRateUnit = HKUnit.countUnit().unitDividedByUnit(HKUnit.minuteUnit());
//        guard let activeEnergyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) else { return }
//        let energyUnit = HKUnit.kilocalorieUnit()
//        
//        // Update properties.
//        self.HeartRateSamples.removeAll()
//
//        workoutBeginDate = beginDate
//        
//        // Set up a predicate to obtain only samples from the local device starting from `beginDate`.
//        let datePredicate = HKQuery.predicateForSamplesWithStartDate(beginDate, endDate: nil, options: .None)
//        let devicePredicate = HKQuery.predicateForObjectsFromDevices([HKDevice.localDevice()])
//        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[datePredicate, devicePredicate])
//        
//        /*
//        Create a results handler to recreate the samples generated by a query of active energy samples so that they can be associated with this app in the move graph. It should be noted that if your app has different heuristics for active energy burned you can generate your own quantities rather than rely on those from the watch. The sum of your sample's quantity values should equal the energy burned value provided for the workout.
//        */
//        let heartRateSampleHandler = { [unowned self] (samples: [HKQuantitySample]) -> Void in
//            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
//                
//                let HeartValue = self.currentHeartRate.doubleValueForUnit(HeartRateUnit)
//                let processedResultsHeartRate: (Double, [HKQuantitySample]) = samples.reduce((HeartValue, [])) { current, HeartSamples in
//                    let HeartRateValue = HeartSamples.quantity.doubleValueForUnit(HeartRateUnit)
//                    
//                    let HeartRate = HKQuantitySample(type: activeHeartRateType, quantity: HeartSamples.quantity, startDate: HeartSamples.startDate, endDate: HeartSamples.endDate)
//                    
//                    return (HeartRateValue,  [HeartRate])
//                }
//                
//                // Update the UI.
//                self.currentHeartRate = HKQuantity(unit: HeartRateUnit, doubleValue: processedResultsHeartRate.0)
//                self.activeHeartRateLabel.setText(String(format:"Heart rate:    %.0f",processedResultsHeartRate.0))
//                
//                // Update our samples.
//                self.activeHeartRateSamples = processedResultsHeartRate.1
//                self.totalHeartRate+=processedResultsHeartRate.0
//                self.activateDouble=processedResultsHeartRate.0
//                if(self.totalHeartRate<40){
//                    self.activeHeartRateLabel.setText("Heart rate: measuring")
//                    self.HeartRateSamples.removeAll()
//                    self.totalTimes=0
//                }
//                else{
//                    self.HeartRateSamples.append(self.activateDouble)
//                    self.totalTimes+=1
//                }
//            }
//        }
//        
//        let energySampleHandler = { [unowned self] (samples: [HKQuantitySample]) -> Void in
//            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
//                
//                let initialActiveEnergy = self.currentActiveEnergyQuantity.doubleValueForUnit(energyUnit)
//                let processedResults: (Double, [HKQuantitySample]) = samples.reduce((initialActiveEnergy, [])) { current, sample in
//                    let accumulatedValue = current.0 + sample.quantity.doubleValueForUnit(energyUnit)
//                    
//                    let ourSample = HKQuantitySample(type: activeEnergyType, quantity: sample.quantity, startDate: sample.startDate, endDate: sample.endDate)
//                    
//                    return (accumulatedValue, current.1 + [ourSample])
//                }
//                
//                
//                // Update our samples.
//                self.currentActiveEnergyQuantity = HKQuantity(unit: energyUnit, doubleValue: processedResults.0)
//                self.activeEnergyBurnedLabel.setText(String(format:"Total energy burned: %.2f",processedResults.0))
//                
//                // Update our samples.
//                if(self.totalEnergy==0){
//                    self.activeEnergyBurnedLabel.setText("Total energy burned: measuring")
//                }
//                self.activeEnergySamples += processedResults.1
//                self.totalEnergy=processedResults.0
//            }
//        }
//        
//        // Create a query to report new Active Energy Burned samples to our app.
//        let activeHeartQuery = HKAnchoredObjectQuery(type: activeHeartRateType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { query, samples, deletedObjects, anchor, error in
//            if let error = error {
//                print("An error occurred with the `activeHeartRateQuery`. The error was: \(error.localizedDescription)")
//                return
//            }
//            // NOTE: `deletedObjects` are not considered in the handler as there is no way to delete samples from the watch during a workout.
//            guard let activeHeartRateSamples = samples as? [HKQuantitySample] else { return }
//            heartRateSampleHandler(activeHeartRateSamples)
//        }
//        
//        let activeEnergyQuery = HKAnchoredObjectQuery(type: activeEnergyType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { query, samples, deletedObjects, anchor, error in
//            if let error = error {
//                print("An error occurred with the `activeEnergyQuery`. The error was: \(error.localizedDescription)")
//                return
//            }
//            // NOTE: `deletedObjects` are not considered in the handler as there is no way to delete samples from the watch during a workout.
//            guard let activeEnergySamples = samples as? [HKQuantitySample] else { return }
//            energySampleHandler(activeEnergySamples)
//        }
//        
//        // Assign the same handler to process future samples generated while the query is still active.
//        activeHeartQuery.updateHandler = { query, samples, deletedObjects, anchor, error in
//            if let error = error {
//                print("An error occurred with the `activeHeartRateQuery`. The error was: \(error.localizedDescription)")
//                return
//            }
//            // NOTE: `deletedObjects` are not considered in the handler as there is no way to delete samples from the watch during a workout.
//            guard let activeHeartRateSamples = samples as? [HKQuantitySample] else { return }
//            heartRateSampleHandler(activeHeartRateSamples)
//        }
//        activeEnergyQuery.updateHandler = { query, samples, deletedObjects, anchor, error in
//            if let error = error {
//                print("An error occurred with the `activeEnergyQuery`. The error was: \(error.localizedDescription)")
//                return
//            }
//            // NOTE: `deletedObjects` are not considered in the handler as there is no way to delete samples from the watch during a workout.
//            guard let activeEnergySamples = samples as? [HKQuantitySample] else { return }
//            energySampleHandler(activeEnergySamples)
//        }
//        
//        currentHeartRateQuery = activeHeartQuery
//        currentActiveEnergyQuery = activeEnergyQuery
//        healthStore.executeQuery(activeHeartQuery)
//        healthStore.executeQuery(activeEnergyQuery)
//        
//    }
//    
//    func endWorkoutOnDate(endDate: NSDate) {
//        workoutEndDate = endDate
//        
//       /* activeHeartRateLabel.setText("0")
//        activeEnergyBurnedLabel.setText("0")*/
//        
//        if let Heartquery = currentHeartRateQuery {
//            healthStore.stopQuery(Heartquery)
//        }
//        if let Energyquery = currentActiveEnergyQuery {
//            healthStore.stopQuery(Energyquery)
//        }
//        
//        saveWorkout()
//    }
//    
//    func workoutSession(workoutSession: HKWorkoutSession, didChangeToState toState: HKWorkoutSessionState, fromState: HKWorkoutSessionState, date: NSDate) {
//        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
//            switch toState {
//            case .Running:
//                self.beginWorkoutOnDate(date)
//                
//            case .Ended:
//                self.endWorkoutOnDate(date)
//                
//            default:
//                print("Unexpected workout session state: \(toState)")
//            }
//        }
//    }
//    
//    func workoutSession(workoutSession: HKWorkoutSession, didFailWithError error: NSError) {
//        print("The workout session failed. The error was: \(error.localizedDescription)")
//    }
//}


import WatchKit
import Foundation

class StatusWKInterfaceController: WKInterfaceController,TransDelegate{
    var obj = CountDownWKInterfaceController()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
//        obj.transDelegate = self
//        obj.updateHealthData()
        //        self.activateHeartRate=WatchConnectManager.sharedManager.getDataSource().AverageHeartRate
//        
//        self.activeEnergyBurnedLabel.setText(String(format:"Total energy burned: %.2f",self.totalEnergy))
//        self.activeHeartRateLabel.setText(String(format:"Heart rate:    %.0f",self.activateHeartRate))
}

    func transTotalEnergy(energyData: Double) {
        self.totalEnergy=energyData
        self.activeEnergyBurnedLabel.setText(String(format:"Total energy burned: %.2f", self.totalEnergy))
//        self.activeHeartRateLabel.setText(String(format:"Total energy burned: %.2f", energyData))
    }
//    func transAverageHeartRate(heartRateData: Double) {
//        self.averageHeartRate=heartRateData
//        self.activeHeartRateLabel.setText(String(format:"Heart rate:    %.0f",self.averageHeartRate))
//
//    }
//    func transTotalTimes(timesData: Double) {
//        self.totalTimes=timesData
//    }
//    func transSamples(samplesData: [Double]) {
//        self.HeartRateSamples=samplesData
//    }
    
    override func willActivate() {
        super.willActivate()
        obj.transDelegate = self
        obj.updateHealthData()

    }
    
    
    var watchTimer: NSTimer?
    var averageHeartRate:Double=0
    var totalEnergy: Double=0
    var totalTimes: Double=0
    var HeartRateSamples: [Double]=[0]
   
    @IBOutlet var activeEnergyBurnedLabel: WKInterfaceLabel!
    @IBOutlet var activeHeartRateLabel: WKInterfaceLabel!
    
    
    override func didDeactivate() {
        
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        let AverageHeartDic = ["AverageHeartDic":Double(self.averageHeartRate)]
        let TotalEnergyDic=["TotalEnergyDic": Double(self.totalEnergy)]
        let HeartTimeDic=["HeartTimeDic": Double(self.totalTimes)]
        let HeartSamplesDic=["HeartSamplesDic": [Double](self.HeartRateSamples)]
        WatchConnectManager.sharedManager.transferUserInfo(AverageHeartDic)
        WatchConnectManager.sharedManager.transferUserInfo(TotalEnergyDic)
        WatchConnectManager.sharedManager.transferUserInfo(HeartTimeDic)
        WatchConnectManager.sharedManager.transferUserInfo(HeartSamplesDic)
    }

}
