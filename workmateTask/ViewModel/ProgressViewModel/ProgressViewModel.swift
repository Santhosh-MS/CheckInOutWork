//
//  ProgressViewModel.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation
import UIKit

protocol TimeReturnDelegate {
    func timeRetunsChekin(times : [String : Any]?) -> Void
    func timeRerurnsCheckOut(times : [String : Any]?) -> Void
    func errorMessage(msg : String) -> Void
}
class ProgressViewModel {
    var httpClient : HttpClient!
    var loc = GetLocationData()
    var CheckInOutDeleget : TimeReturnDelegate?
   

    
    init(client : HttpClient? = nil ){
        self.httpClient = client ?? HttpClient.shared
    }
    
    func sendCheckInCheckOutStatus(status:Bool) -> Void {
        if status {         //CheckOut
            checkInAPIOutCall(statusInOut:status,URLPath : "staff-requests/26074/clock-out/")
        }else {             //CheckIn
            checkInAPIOutCall(statusInOut:status,URLPath : "staff-requests/26074/clock-in/")
        }
    }
}


//MARK: - API Call for CheckIn/OUT
extension ProgressViewModel{
    func checkInAPIOutCall(statusInOut : Bool,URLPath : String) -> Void {
        guard let currentLocation = loc.getLoctionCoordinates() else {
            return
        }
        httpClient.dataTask(ContactAPI.CheckInCheckOut(urlPath: URLPath, paraData: currentLocation)) { (result) in
//            guard self != nil else{
//                return
//            }
            switch result {
            case .success(let data):
                guard let data = data else{
                    return
                }
                print("data : \(data)")
                
                DispatchQueue.main.async(execute: {
            do{
                if statusInOut {
                    var timeDict : [String : String]? = [:]//CheckOut
                    let TimeSheetOut: [String : Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                    let timeOut : [String : Any] = TimeSheetOut["timesheet"] as! [String : Any]
                    timeDict?.updateValue(timeOut["clock_out_time"] as? String ?? "", forKey: "clockIn")
                    timeDict?.updateValue(timeOut["clock_out_time"] as? String ?? "", forKey: "clockOut")
                        self.sendDataCheckOut(timeOuts : timeDict)
                        }else {                //CheckIn
                    let TimeSheetIn : [String : Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                    var timeDict : [String : String]? = [:]
                    timeDict?.updateValue(TimeSheetIn["clock_in_time"] as? String ?? "", forKey: "clockIn")
                    timeDict?.updateValue(TimeSheetIn["clock_out_time"] as? String ?? "", forKey: "clockOut")
                    self.sendDataCheckIN(timeIns: timeDict)
                        }
                    }catch let err as NSError {
                        print("err : \(err.localizedDescription)")
                        
                        if CommonDatas.errcode == 400 {
                            self.CheckInOutDeleget?.errorMessage(msg: "400")
                        }
                    }
                })
            case .failure(let error):
                print("Error in fetching Constant : \(error) ")
            }
        }
    }
    
    func sendDataCheckIN( timeIns: [String : Any]?) -> Void {
        self.CheckInOutDeleget?.timeRetunsChekin(times: timeIns)
    }
    func sendDataCheckOut(timeOuts : [String : Any]?) -> Void {
        
        self.CheckInOutDeleget?.timeRerurnsCheckOut(times: timeOuts)
    }
}
