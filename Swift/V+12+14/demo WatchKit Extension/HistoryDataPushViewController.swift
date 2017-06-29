import WatchKit
import Foundation

class HistoryDataPushViewController: WKInterfaceController,DataSourceChangedDelegate {
    
    override func willActivate() {
        super.willActivate()
    }
    
    func dataSourceDidUpdate(dataSource: DataSource) {
        loadTableData(dataSource)
    }
    @IBOutlet var recordAbutton: WKInterfaceButton!
    @IBOutlet var recordBbutton: WKInterfaceButton!
    @IBOutlet var recordCbutton: WKInterfaceButton!
    
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
private extension HistoryDataPushViewController {
    private func loadTableData(dataSource: DataSource) {
        recordAbutton.setTitle(dataSource.MeetNameA)
        recordBbutton.setTitle(dataSource.MeetNameB)
        recordCbutton.setTitle(dataSource.MeetNameC)
    }
}
