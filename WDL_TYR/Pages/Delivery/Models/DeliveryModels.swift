//
//  RegionModel.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/10.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import HandyJSON

struct RegionModel: HandyJSON {
    var label:String?
    var value:String?
    var children:[RegionModel]?
}

struct HallModels : HandyJSON {
    var VehicleType:[HallItem]?
    var VehicleLength:[HallItem]?
    var VehicleWidth:[HallItem]?
    var MaterialType:[HallItem]?
    var PACKAGE_TYPE:[HallItem]?
    var HYYXQ:[HallItem]?
    var auto_deal_space:[HallItem]?
}

struct HallItem : HandyJSON {
    var id:String?
    var dictionaryName:String?
    var dictionaryType:String?
}

/**
 {
 "dealTotalPrice": 0,
 "dealUnitPrice": 0,
 "dealWay": 0,
 "endCity": "string",
 "endProvince": "string",
 "goodsName": "string",
 "goodsType": "string",
 "goodsWeight": 0,
 "loadingTime": "2018-09-11T01:03:19.593Z",
 "orderAvailabilityPeriod": "string",
 "packageType": "string",
 "publishTime": "2018-09-11T01:03:19.593Z",
 "startCity": "string",
 "startProvince": "string",
 "vehicleLength": "string",
 "vehicleType": "string",
 "vehicleWidth": "string"
 }
 */
struct ReleaseDeliverySourceModel : HandyJSON { // 发布货源的对象
    var dealTotalPrice:String?  //总价
    var dealUnitPrice:String?   // 单价
    var dealWay:String?         // 提交方式
    var endCity:String?
    var endProvince:String?
    var goodsName:String?
    var goodsType:String?
    var goodsWeight:String?
    var loadingTime:String?
    var orderAvailabilityPeriod:String?
    var startProvince:String?
    var vehicleLength:String?
    var vehicleType:String?
    var vehicleWidth:String?
    var packageType:String?
    var publishTime:String?
    var startCity:String?
}

/**
 VEHICLE_TYPE("VehicleType", "车型"),
 VEHICLE_LENGTH("VehicleLength", "车长"),
 VEHICLE_WIDTH("VehicleWidth", "车宽"),
 MATERIAL_TYPE("MaterialType", "物料分类"),
 PACKAGE_TYPE("PACKAGE_TYPE", "包装类型"),
 HALL_PERIOD("HYYXQ", "货源有效期"),
 AUTO_DEAL_SPACE("auto_deal_space", "货源自动成交时间间隔");
 */
