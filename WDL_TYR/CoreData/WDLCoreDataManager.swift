//
//  wdlCoreDataManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/7.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import HandyJSON

struct LoginInfo {
    var userCode:String?
    var returnToken : String?
}

class WDLCoreManager: NSObject {
    
    public var userInfo: LoginInfo?
    
    private static let instance = WDLCoreManager()
    private override init() {}
    
    public static func shared() -> WDLCoreManager {
        return instance
    }
    
    
}
