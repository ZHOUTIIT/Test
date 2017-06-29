//
//  InterfaceController.swift
//  demo WatchKit Extension
//
//  Created by Zhou Ti on 11/2/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit


class InterfaceController: WKInterfaceController,DataSourceChangedDelegate {
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WatchConnectManager.sharedManager.addDataSourceChangedDelegate(self)
        loadTableData(WatchConnectManager.sharedManager.getDataSource())
    }
    let healthStore = HKHealthStore()
    
    func dataSourceDidUpdate(dataSource: DataSource){
        loadTableData(dataSource)
    }
    @IBOutlet var displayLabel: WKInterfaceLabel!
    @IBOutlet var startButton: WKInterfaceButton!
    
    override func willActivate() {
        loadTableData(WatchConnectManager.sharedManager.getDataSource())
        super.willActivate()
        //        guard HKHealthStore.isHealthDataAvailable() else { return }
        //        let typesToShare = Set([
        //            HKObjectType.workoutType(),
        //            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!,
        //            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!])
        //
        //        let typesToRead = Set([
        //            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!,HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!])
        //        healthStore.requestAuthorizationToShareTypes(typesToShare, readTypes: typesToRead) { success, error in
        //            }
    }
    
    override func didDeactivate() {
        loadTableData(WatchConnectManager.sharedManager.getDataSource())
        WatchConnectManager.sharedManager.removeDataSourceChangedDelegate(self)
        super.didDeactivate()
    }
}
private extension InterfaceController {
    private func loadTableData(dataSource: DataSource) {
        let tempFlag=dataSource.haveLogin
        let tempUserName=dataSource.userName
        if(tempFlag==false){
            displayLabel.setText("Please login on your phone")
            self.startButton.setHidden(true)
        }
        else{
            displayLabel.setText("Welcome!"+tempUserName)
            self.startButton.setHidden(false)
        }
    }
}
