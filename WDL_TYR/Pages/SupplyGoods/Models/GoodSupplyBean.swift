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

enum GoodsSupplyListStatus : Int {
    case status_bidding = 0     //竞价中
    case status_deal = 1        // 成交
    case status_putway = 2      // 上架
    case status_soldout = 3     // 下架
}


struct GoodsSupplyQueryBean : HandyJSON {
    var endCity : String?
    var endProvince: String?
    var isDeal:Int?
    var startCity : String?
    var startProvince : String?
    var pageNum : Int = 1
    var pageSize : Int = 20
}


struct GoodsSupplyList :HandyJSON {
    var pageNum:Int?
    var pageSize:Int?
    var size:Int?
    var list:[GoodsSupplyListItem]?
}

struct GoodsSupplyListItem : HandyJSON{
    var id:String?
    var consignorNo:String?
    var startProvince:String?
    var startCity:String?
    var endProvince:String?
    var endCity:String?
    var goodsName:String?
    var goodsType:String?
    var packageType:String?
    var vehicleType:String?
    var vehicleLength:String?
    var vehicleWidth:String?
    var publishTime:TimeInterval?
    var loadingTime:TimeInterval?
    var orderAvailabilityPeriod:String?
    var dealWay:Int?
    var autoTimeInterval:CGFloat?
    var isDeal:GoodsSupplyListStatus?
    var isEnable:Int?
    var remark:String?
    var startDistrict:String?
    var endDistrict:String?
    var dealUnitPrice:CGFloat?
    var dealTotalPrice:CGFloat?
    var goodsWeight:CGFloat?
    var offer:GoodsSupplyOfferModel?
}

struct GoodsSupplyOfferModel : HandyJSON {
    var hallId:String?
    var offerNumber:Int?
    var quotedPrice:CGFloat?
}

extension GoodsSupplyListItem : IdentifiableType , Equatable {
    var identity: String {
        return self.id ?? ""
    }
    
    typealias Identity = String
}

func ==  (lhs: GoodsSupplyListItem, rhs: GoodsSupplyListItem) -> Bool {
    return lhs.toJSONString() == rhs.toJSONString()
}

