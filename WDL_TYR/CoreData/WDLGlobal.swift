//
//  WDLGlobal.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/16.
//  Copyright © 2018 yinli. All rights reserved.
//

import Foundation


class WDLGlobal {
    
    // 重新上架的货源信息
    private var reShelveGoods:OderHallBean? = nil
    
    private static let instance = WDLGlobal()
    
    static public func shard() -> WDLGlobal {
        return instance
    }
    
    // 保存即将重新上架的货源信息
    func reShelveGoodsSupply(goods:OderHallBean?) -> Void {
        reShelveGoods = goods
    }
    
    // 获取保存的重新上架的货源信息
    func loadReShelveGoods() -> OderHallBean? {
        return reShelveGoods
    }
    
    // 清楚当前即将重新上架的货源信息
    func clearReShelveGoods() -> Void {
        reShelveGoods = nil
    }
}
