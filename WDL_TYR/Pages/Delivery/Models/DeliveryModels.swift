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
    var MaterialCategory:[HallItem]?//货品分类
//    var MaterialType:[HallItem]?
    var PACKAGE_TYPE:[HallItem]?
    var HYYXQ:[HallItem]?
    var auto_deal_space:[HallItem]?
}

struct HallItem : HandyJSON {
    var id:String?
    var dictionaryName:String?
    var dictionaryType:String?
    var value:String?
    var dictionaryCode:String?
}

struct ReleaseDeliverySourceModel : HandyJSON { // 发布货源的对象
    var autoTimeInterval:String?    // 自动成交时间
    var dealTotalPrice:Float?  //总价
    var dealUnitPrice:Float?   // 单价
    var dealWay:Int?         // 提交方式
    var endCity:String?
    var endAddress:String?  //收货详情地址
    var consigneeName:String?  // 收货联系人
    var consigneePhone:String? // 收货联系人电话
    var id: String? //重新上架需要传入的id（修改货源时，货源的id）
    var loadingPersonAddress:String? //装货详情地址
    var loadingPersonName:String?//装货联系人
    var loadingPersonPhone:String?//装货联系人电话
    var endDistrict:String?
    var endProvince:String?
    var goodsName:String?
    var goodsType:String?
    var goodsWeight:Float?
    var loadingTime:String?
    var orderAvailabilityPeriod:String?
    var startAddress:String? //发货详情地址
    var startProvince:String?
    var vehicleLength:String?
    var vehicleType:String?
    var vehicleWidth:String?
    var packageType:String?
    var publishTime:String? //发布时间
    var startCity:String?
    var startDistrict:String?
    var remark:String?
}

