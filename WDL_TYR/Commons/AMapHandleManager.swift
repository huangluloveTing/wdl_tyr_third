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
    
    private lazy var locationManager:AMapLocationManager = AMapLocationManager()
    
    private static let manager = AMapHandleManager.init()
    
    private override init() {
        super.init()
        self.configLocationManager()
    }
    
    public static func shared() -> AMapHandleManager {
        return manager
    }
    
    
    //MARK: 高德定位回调
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        print("高德定位失败 \(error.localizedDescription)")
        if let closure = self.resultClosure {
            closure(nil , nil , error)
        }
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didChange status: CLAuthorizationStatus) {
        print("auto:\(status)")
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        if reGeocode == nil {
            self.locationManager.requestLocation(withReGeocode: true) { [weak self](loca, rege, error) in
                if let closure = self?.resultClosure {
                    closure(location , reGeocode , error)
                }
            }
        }
    }
}

extension AMapHandleManager {
    
    func startSerialLocation(result closure:LocationResultClosure?) {
        self.resultClosure = closure
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func stopSerialLocation() {
        self.locationManager.delegate = nil
        self.locationManager.stopUpdatingLocation()
    }
    
    func startSingleLocation(result closure:LocationResultClosure?) -> Void {
        self.locationManager.requestLocation(withReGeocode: true) {(location, reGeo, error) in
            if let closure = closure {
                closure(location , reGeo , error)
            }
        }
    }
    
    func configLocationManager() {
        self.locationManager.locatingWithReGeocode = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.reGeocodeTimeout = 5
        self.locationManager.locationTimeout = 5
        self.locationManager.allowsBackgroundLocationUpdates = true
    }
}

