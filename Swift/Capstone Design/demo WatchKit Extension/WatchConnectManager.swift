import WatchConnectivity

protocol DataSourceChangedDelegate {
    func dataSourceDidUpdate(dataSource: DataSource)
}

class WatchConnectManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchConnectManager()
    private override init() {
        super.init()
    }
    
    private let session: WCSession = WCSession.defaultSession()
    private var validSession: WCSession? {
        
        // paired - the user has to have their device paired to the watch
        // watchAppInstalled - the user must have your watch app installed
        
        // Note: if the device is paired, but your watch app is not installed
        // consider prompting the user to install it for a better experience
        
        return session
    }
    private var dataSource = DataSource()
    private var dataSourceChangedDelegates = [DataSourceChangedDelegate]()
//    
//    func setTransTotalEnergy(temp:Double){
//        dataSource.transTotalEnergy=temp
//    }
//    func setTransActivateHeartRate(temp:Double){
//        dataSource.transActivateHeartRate=temp
//    }
//    func setTransTotalHeartRate(temp:Double){
//        dataSource.transTotalHeartRate=temp
//    }
//    func setTransTotalTimes(temp:Double){
//        dataSource.transTotalTimes=temp
//    }
//    func setTransSamples(temp:[Double]){
//        dataSource.transHeartRateSamples=temp
//    }
    
    func startSession() {
        session.delegate = self
        session.activateSession()
    }
    
    func getDataSource()->DataSource{
        return self.dataSource
    }
    
    func addDataSourceChangedDelegate<T where T: DataSourceChangedDelegate, T: Equatable>(delegate: T) {
        dataSourceChangedDelegates.append(delegate)
    }
    
    func removeDataSourceChangedDelegate<T where T: DataSourceChangedDelegate, T: Equatable>(delegate: T) {
        for (index, dataSourceDelegate) in dataSourceChangedDelegates.enumerate() {
            if let dataSourceDelegate = dataSourceDelegate as? T where dataSourceDelegate == delegate {
                dataSourceChangedDelegates.removeAtIndex(index)
                break
            }
        }
    }
}

// MARK: User Info
// use when your app needs all the data
// FIFO queue
extension WatchConnectManager {
    func transferUserInfo(userInfo: [String : AnyObject]) -> WCSessionUserInfoTransfer? {
        return validSession?.transferUserInfo(userInfo)
    }
    
    // Receiver
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        // handle receiving user info
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            if let dataSource = self?.dataSource.insertItemFromData(userInfo) {
                self?.dataSource = dataSource
                self?.dataSourceChangedDelegates.forEach {
                    $0.dataSourceDidUpdate(dataSource)
                }
            }
        }
    }
}