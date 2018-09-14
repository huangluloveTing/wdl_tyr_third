//
//  GoodsOfferDetailBean.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/14.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import HandyJSON


struct SupplyOfferBean {
    var carrierId:String? //承运人ID ,
    var carrierName:String? // 承运人姓名
    var carrierType:String? // 承运人类型 ,
    var dealCount : Int?  //历史成交笔数 ,
    var dealStatus : Int? // 成交状态 0=驳回 1=竞价中 2=成交 ,
    var driverName : String? // 司机姓名 ,
    var driverPhone : String? // 司机联系方式 ,
    var endTime : String?   // 结束时间 ,
    var hallId : String? //货源ID
    var id : String?
    var loadWeight : CGFloat? // 承运数量 ,
    var offerPossibility : String? // 可能性 高中低 ,
    var offerTime : String?// 报价时间 ,
    var payee : String // 收款人 ,
    var quotedPrice : CGFloat? //单价 ,
    var startTime : String? //开始时间
    var stowageNo: String? // 配载单号 ,
    var totalPrice : CGFloat? // 总价 ,
    var vehicleNo : String? //车牌号
}

struct SupplyOfferDetailBean : HandyJSON {
    var list : [SupplyOfferBean]?
    var pageNum : Int?
    var pageSize : Int?
    var total : Int?
}

enum QueryDetailOrderBy : Int {
    case OrderBy_Price_reverse = 0  //金额倒序
    case OrderBy_Price_ascend = 1   // 金额升序
    case OrderBy_Time_reverse = 2  // 时间倒序
    case OrderBy_Time_ascend  = 3  // 时间升序
}

struct QuerySupplyDetailBean : HandyJSON {
    var hallId:String?
    var pageNum:Int = 1
    var pageSize:Int = 20
    var orderBy:QueryDetailOrderBy?
}
