//
//  LocationManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

class AMapHandleManager : NSObject , AMapLocationManagerDelegate  {
    
    typealias LocationResultClosure = (CLLocation? ,AMapLocationReGeocode? , Error?) -> ()
    
    private var resultClosure:LocationResultClosure?
    
    private lazy var locationManager:AMapLocationManager = {
        let amapManager = AMapLocationManager.init()
        amapManager.delegate = self
        return amapManager
    }()
    
    private override init() {}
    
    public func shared() -> AMapHandleManager {
        return AMapHandleManager.init()
    }
    
    
    //MARK: 高德定位回调
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        print("高德定位失败 \(error.localizedDescription)")
        if let closure = self.resultClosure {
            closure(nil , nil , error)
        }
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        self.stopLocation()
        if let closure = self.resultClosure {
            closure(location , nil , nil)
        }
    }
}

extension AMapHandleManager {
    
    func startLocation(result closure:LocationResultClosure?) {
        self.resultClosure = closure
        self.locationManager.startUpdatingLocation()
    }
    
    func stopLocation() {
        self.locationManager.stopUpdatingLocation()
    }
}

