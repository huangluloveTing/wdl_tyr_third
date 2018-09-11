//
//  GoodSupplyBean.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/28.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import RxDataSources
import HandyJSON

struct GoodsSupplyQueryBean : HandyJSON {
    var endCity : String?
    var endProvince: String?
    var isDeal:Int?
    var startCity : String?
    var startProvince : String?
}

struct GoodsSupplyItemBean  : HandyJSON {
    public var start:String?
    public var end:String?
    public var status:String?
    public var content:String?
    public var goodsSpec:String?
    public var cartSpec:String?
    public var pageNum : Int = 0
    public var pageSize : Int = 20

}

extension GoodsSupplyItemBean : IdentifiableType , Equatable {
    var identity: String {
        return self.end!
    }
    
    typealias Identity = String
}

func ==  (lhs: GoodsSupplyItemBean, rhs: GoodsSupplyItemBean) -> Bool {
    return lhs.toJSONString() == rhs.toJSONString()
}

