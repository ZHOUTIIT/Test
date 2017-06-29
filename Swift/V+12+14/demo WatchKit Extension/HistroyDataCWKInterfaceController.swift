//
//  HistroyDataWKInterfaceController.swift
//  demo
//
//  Created by Zhou Ti on 11/17/15.
//  Copyright © 2015 Zhou Ti. All rights reserved.
//

import WatchKit
import Foundation

class HistroyDataCWKInterfaceController: WKInterfaceController,DataSourceChangedDelegate {
    
    @IBOutlet var DataLabel: WKInterfaceLabel!
    @IBOutlet var timeLabel: WKInterfaceLabel!
    @IBOutlet var averageHRLabel: WKInterfaceLabel!
    @IBOutlet var totalECLabel: WKInterfaceLabel!
    @IBOutlet var commentLabel: WKInterfaceLabel!
    
    override func willActivate() {
        super.willActivate()
    }
    
    func dataSourceDidUpdate(dataSource: DataSource) {
        loadTableData(dataSource)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WatchConnectManager.sharedManager.addDataSourceChangedDelegate(self)
        loadTableData(WatchConnectManager.sharedManager.getDataSource())
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        WatchConnectManager.sharedManager.removeDataSourceChangedDelegate(self)
        super.didDeactivate()
    }
}

private extension HistroyDataCWKInterfaceController {
    private func loadTableData(dataSource: DataSource) {
        let tempAverageString: String=String(format:"%.2f bpm",dataSource.HistoryAverageHeartRateC)
        let tempTotalEnergy: String=String(format:"%0.2f cal",dataSource.HistoryTotalEnergyC)
        let tempCommentValue: String=String(dataSource.HistoryCommentValueC)
        DataLabel.setText(dataSource.HistoryDateC)
        timeLabel.setText(dataSource.HistoryTimeC)
        averageHRLabel.setText(tempAverageString)
        totalECLabel.setText(tempTotalEnergy)
        commentLabel.setText(tempCommentValue)
    }
}
