

struct DataSource {
    
    var AverageHeartRate:Double
    var TotalEnergyConsumption:Double
    var TotalTimesMeasured:Double
    var HeartRateArray:[Double]
    var CommentValue: Int
    var CountDownvalue: Double
    var HistoryDateA:String
    var HistoryTimeA:String
    var HistoryAverageHeartRateA:Double
    var HistoryTotalEnergyA:Double
    var HistoryCommentValueA:Int
    var HistoryDateB:String
    var HistoryTimeB:String
    var HistoryAverageHeartRateB:Double
    var HistoryTotalEnergyB:Double
    var HistoryCommentValueB:Int
    var HistoryDateC:String
    var HistoryTimeC:String
    var HistoryAverageHeartRateC:Double
    var HistoryTotalEnergyC:Double
    var HistoryCommentValueC:Int
    var EnergyArray:[Double]
    var shouldSetCount:Int
    var haveLogin:Bool
    var userName:String
    var MeetTime:Double
    var MeetNameA:String
    var MeetNameB:String
    var MeetNameC:String
    
    //    var transTotalEnergy:Double
    //    var transActivateHeartRate:Double
    //    var transTotalHeartRate:Double
    //    var transTotalTimes:Double
    //    var transHeartRateSamples:[Double]
    
    init() {
        self.AverageHeartRate=0
        self.TotalEnergyConsumption=0
        self.TotalTimesMeasured=0
        self.HeartRateArray=[0]
        self.CommentValue=0
        self.CountDownvalue=0
        self.HistoryTimeA="Inital time"
        self.HistoryDateA="Initial Date"
        self.HistoryAverageHeartRateA=0
        self.HistoryTotalEnergyA=0
        self.HistoryCommentValueA=0
        self.HistoryTimeB="Inital time"
        self.HistoryDateB="Initial Date"
        self.HistoryAverageHeartRateB=0
        self.HistoryTotalEnergyB=0
        self.HistoryCommentValueB=0
        self.HistoryTimeC="Inital time"
        self.HistoryDateC="Initial Date"
        self.HistoryAverageHeartRateC=0
        self.HistoryTotalEnergyC=0
        self.HistoryCommentValueC=0
        self.MeetTime=0
        self.EnergyArray=[0]
        self.shouldSetCount=0
        self.haveLogin=false
        self.userName="666@qq.com"
        self.MeetNameA="No record"
        self.MeetNameB="No record"
        self.MeetNameC="No record"
        //        self.transTotalEnergy=0
        //        self.transActivateHeartRate=0
        //        self.transTotalHeartRate=0
        //        self.transTotalTimes=0
        //        self.transHeartRateSamples=[0]
    }
    
    func insertItemFromData(data: [String : AnyObject]) -> DataSource {
        var tempDataSource=WatchConnectManager.sharedManager.getDataSource()
        
        if let temp1 = data["AverageHeartDic"] as? Double{
            tempDataSource.AverageHeartRate=temp1
        }
        if let temp2 = data["TotalEnergyDic"] as? Double{
            tempDataSource.TotalEnergyConsumption=temp2
        }
        if let temp3 = data["HeartTimeDic"] as? Double{
            tempDataSource.TotalTimesMeasured=temp3
        }
        if let temp4 = data["HeartSamplesDic"] as? [Double]{
            tempDataSource.HeartRateArray=temp4
        }
        if let temp5 = data["CommentValueDic"] as? Int{
            tempDataSource.CommentValue=temp5
        }
        if let temp6 = data["exerciseDuration"] as? Double{
            tempDataSource.CountDownvalue=temp6
        }
        if let temp7 = data["DataDateDicA"] as? String{
            tempDataSource.HistoryDateA=temp7
        }
        if let temp8 = data["DataTimeDicA"]as? String{
            tempDataSource.HistoryTimeA=temp8
        }
        if let temp9 = data["DataAverageHRDicA"] as? Double{
            tempDataSource.HistoryAverageHeartRateA=temp9
        }
        if let temp10 = data["DataTotalECDicA"] as? Double{
            tempDataSource.HistoryTotalEnergyA=temp10
        }
        if let temp11 = data["DataCommentDicA"] as? Int{
            tempDataSource.HistoryCommentValueA=temp11
        }
        if let temp12 = data["MeetTimeDic"] as? Double{
            tempDataSource.MeetTime=temp12
        }
        if let temp13 = data["DataDateDicB"] as? String{
            tempDataSource.HistoryDateB=temp13
        }
        if let temp14 = data["DataTimeDicB"]as? String{
            tempDataSource.HistoryTimeB=temp14
        }
        if let temp15 = data["DataAverageHRDicB"] as? Double{
            tempDataSource.HistoryAverageHeartRateB=temp15
        }
        if let temp16 = data["DataTotalECDicB"] as? Double{
            tempDataSource.HistoryTotalEnergyB=temp16
        }
        if let temp17 = data["DataCommentDicB"] as? Int{
            tempDataSource.HistoryCommentValueB=temp17
        }
        if let temp18 = data["DataDateDicC"] as? String{
            tempDataSource.HistoryDateC=temp18
        }
        if let temp19 = data["DataTimeDicC"]as? String{
            tempDataSource.HistoryTimeC=temp19
        }
        if let temp20 = data["DataAverageHRDicC"] as? Double{
            tempDataSource.HistoryAverageHeartRateC=temp20
        }
        if let temp21 = data["DataTotalECDicC"] as? Double{
            tempDataSource.HistoryTotalEnergyC=temp21
        }
        if let temp22 = data["DataCommentDicC"] as? Int{
            tempDataSource.HistoryCommentValueC=temp22
        }
        if let temp23 = data["EnergyArrayDic"] as? [Double]{
            tempDataSource.EnergyArray=temp23
        }
        if let temp24 = data["shouldCountFlag"] as? Int{
            tempDataSource.shouldSetCount=temp24
        }
        if let temp25 = data["HaveLoginFlag"] as? Bool{
            tempDataSource.haveLogin=temp25
        }
        if let temp26 = data["userNameDic"] as? String{
            tempDataSource.userName=temp26
        }
        if let temp27 = data["DataNameA"] as? String{
            tempDataSource.MeetNameA=temp27
        }
        if let temp28 = data["DataNameB"] as? String{
            tempDataSource.MeetNameB=temp28
        }
        if let temp29 = data["DataNameC"] as? String{
            tempDataSource.MeetNameC=temp29
        }
        
        return tempDataSource
    }
}