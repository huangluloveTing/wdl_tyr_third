//
//  wdlCoreDataManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/7.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import HandyJSON

class WDLCoreManager: NSObject {
    
    private var _regions:[RegionModel]?
    
    public var regionAreas:[RegionModel]? {
        set {
            _regions = newValue
            UserStore.storeRegionsInfo(regions: newValue)
        }
        get {
            if _regions == nil {
                _regions = UserStore.loadRegisonInfo()
            }
            return _regions
        }
    }
    
    public var userInfo: ZbnConsignor? {
        set {
            cacheUserInfo(userInfo: newValue)
        }
        get {
            return loadUserInfo()
        }
    }
    
    private static let instance = WDLCoreManager()
    private override init() {}
    
    public static func shared() -> WDLCoreManager {
        return instance
    }
    
    // 当前用户的身份
    public var consignorType:ConsignorType?  {
        return userInfo?.consignorType
    }
    
    private func cacheUserInfo(userInfo:ZbnConsignor?) -> Void {
        UserStore.storeUserInfo(info: userInfo)
    }
    
    private func loadUserInfo() -> ZbnConsignor? {
        return UserStore.loadUserInfo()
    }
}
