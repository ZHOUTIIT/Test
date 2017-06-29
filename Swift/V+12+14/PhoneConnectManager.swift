import WatchConnectivity

protocol DataSourceChangedDelegate {
    func dataSourceDidUpdate(dataSource: DataSource)
}

class PhoneConnectManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = PhoneConnectManager()
    private override init() {
        super.init()
    }
    
    private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    private var dataSource = DataSource()
    private var dataSourceChangedDelegates = [DataSourceChangedDelegate]()
    private var validSession: WCSession? {
        
        if let session = session where session.paired && session.watchAppInstalled {
            return session
        }
        return nil
    }
    func getDataSource()->DataSource{
        return self.dataSource
    }
    func startSession() {
        session?.delegate = self
        session?.activateSession()
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

extension PhoneConnectManager {

    func transferUserInfo(userInfo: [String : AnyObject]) -> WCSessionUserInfoTransfer? {
        return validSession?.transferUserInfo(userInfo)
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
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
