//
//  wdlCoreDataManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/7.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import HandyJSON
import RxSwift
import RxCocoa

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
    
    public var unreadMessageCount:Int = 0
    
    private static let instance = WDLCoreManager()
    private override init() {
        super.init()
    }
    
    public static func shared() -> WDLCoreManager {
        instance.messageLisnter()
        return instance
    }
    
    public var messageLisnterClosure:((Int) -> ())?
    
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
    
    public func loadUnReadMessage(closure:((Int)->())?) {
        let _ = BaseApi.request(target: API.getMessageNum(), type: BaseResponseModel<Int>.self)
            .retry()
            .subscribe(onNext: { (data) in
                self.unreadMessageCount = data.data ?? 0
                if let closure = closure {
                    closure(data.data ?? 0)
                }
            })
    }
    
    //MARK: - 监听 消息 变化
    func messageLisnter() -> Void {
       
    }
}
