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

//0=竞价中 1=成交 2=未上架 3=已下架 ,
enum GoodsSupplyListStatus : Int , HandyJSONEnum {
    case status_bidding = 0     //竞价中
    case status_deal = 1        // 成交
    case status_putway = 2      // 未上架
    case status_soldout = 3     // 下架
}
//软件更新
struct UpdateSoftWareModel : HandyJSON {
    
    var content:String = ""
    var downloadUrl:String = ""
    var must:Int = 2 //(integer): 是否强制更新 1=是 2=否 ,
    var softwareType:Int = 1 // (integer): 软件类型：1=托运人 2=承运人 ,
    var terminalType:Int = 1 // (integer): 终端类型：1=ios 2=Android ,
    var versionCode:Int = 1
}


struct GoodsSupplyQueryBean : HandyJSON {
    var endCity : String?
    var endProvince: String?
    var isDeal:Int?
    var startCity : String?
    var startProvince : String?
    var pageNum : Int = 1
    var pageSize : Int = 20
    var searchWord:String?
}

struct GoodsSupplyList :HandyJSON {
    var pageNum:Int?
    var pageSize:Int?
    var size:Int?
    var list:[GoodsSupplyListItem]?
}

struct GoodsSupplyListItem : HandyJSON{
    //货源订单id
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
    //车长
    var vehicleLength:String?
    var vehicleWidth:String?
    var publishTime:TimeInterval?//发布时间
    var loadingTime:TimeInterval?
    var orderAvailabilityPeriod:String?
    var dealWay:Int? ////成交方式 1=自动 2=手动 ,
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

