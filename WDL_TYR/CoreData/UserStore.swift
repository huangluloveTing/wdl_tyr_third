//
//  UserStore.swift
//  SCM
//
//  Created by 黄露 on 2018/8/6.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

fileprivate let token_store_key = "token_store_key"
fileprivate let userInfo_store_key = "userInfo_store_key"                       // 保存用户信息的key
fileprivate let stockCommodityAlert_store_key = "stockCommodityAlert_store_key" // 商品预警保存当前用户的筛选品类的key
fileprivate let stockProductAlert_store_key = "stockProductAlert_store_key"     // 产品预警保存当前用户的筛选品类的key

fileprivate let stockProductAlert_regions_key = "stockProductAlert_regions_key"     // 产品预警保存当前用户的筛选品类的key

class UserStore: NSObject {
    
    // 保存的token
    static func storeToken(token:String?) -> Void {
        UserDefault.storeInfo(key: token_store_key, info: token)
    }
    
    // 保存用户基本信息
    static func storeUserInfo(info:ZbnConsignor?) {
        UserDefault.storeInfo(key: userInfo_store_key, info: info?.toJSON())
    }

    static func loadToken() ->String? {
        return UserDefault.loadInfo(key: token_store_key) as? String
    }

    static func loadUserInfo() -> ZbnConsignor? {
        let info = UserDefault.loadInfo(key: userInfo_store_key)
        return ZbnConsignor.deserialize(from: info as? [String:Any])
    }
    
    // 保存地址相关信息
    static func storeRegionsInfo(regions:[RegionModel]?) {
        let info = regions?.toJSONString()
        UserDefault.storeInfo(key: stockProductAlert_regions_key, info: info)
    }
    
    static func loadRegisonInfo() -> [RegionModel]? {
        let info = UserDefault.loadInfo(key: stockProductAlert_regions_key) as? String
        let regions = [RegionModel].deserialize(from: info)
        return regions as? [RegionModel]
    }
    
    // 清楚所有的数据
    static func clearAllCache() {
        UserDefault.clearInfo(key: userInfo_store_key)
        UserDefault.clearInfo(key: stockProductAlert_store_key)
        UserDefault.clearInfo(key: stockCommodityAlert_store_key)
    }
}
