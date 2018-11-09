//
//  UIViewController+Location.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

extension UIViewController {
    
    private var aMapLocationManager:AMapHandleManager {
        get {
            return AMapHandleManager.shared()
        }
    }
    
    func startSingleLocation(result closure:AMapHandleManager.LocationResultClosure?) -> Void {
        self.aMapLocationManager.startSingleLocation(result: closure)
    }
    
}
