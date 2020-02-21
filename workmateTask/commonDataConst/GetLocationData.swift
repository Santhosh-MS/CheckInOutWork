//
//  GetLocationData.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftLocation


protocol gpsDataDelegate   {
    func returnGPsDatas() -> Void
}
class GetLocationData : NSObject {
    var CurrentCordinates : CLLocation?
    var currentLocation : [String : String]? = [:]
    func getLoctionCoordinates() -> [String : String]? {
    LocationManager.shared.requireUserAuthorization()
    let req =   LocationManager.shared.locateFromGPS(.continous, accuracy: .any) { result in
        switch result {
        case .failure(let error) :
            print("Error : \(error)")
        case .success(let location) :
                print("location : \(location)")
                let locVal : CLLocationCoordinate2D = location.coordinate
                self.currentLocation?.updateValue("\(locVal.latitude)", forKey: "latitude")
                self.currentLocation?.updateValue("\(locVal.longitude)", forKey: "longitude")
        }
        }
        req.stop()
        req.pause()
        return currentLocation
    }

}
    

       


