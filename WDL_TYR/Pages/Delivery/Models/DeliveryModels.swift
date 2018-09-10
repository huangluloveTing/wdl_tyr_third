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
 VEHICLE_TYPE("VehicleType", "车型"),
 VEHICLE_LENGTH("VehicleLength", "车长"),
 VEHICLE_WIDTH("VehicleWidth", "车宽"),
 MATERIAL_TYPE("MaterialType", "物料分类"),
 PACKAGE_TYPE("PACKAGE_TYPE", "包装类型"),
 HALL_PERIOD("HYYXQ", "货源有效期"),
 AUTO_DEAL_SPACE("auto_deal_space", "货源自动成交时间间隔");
 */
