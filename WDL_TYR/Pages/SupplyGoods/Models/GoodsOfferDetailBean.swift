//
//  GoodsOfferDetailBean.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/14.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import HandyJSON


struct SupplyOfferBean : HandyJSON {
    
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
    var payee : String? // 收款人 ,
    var quotedPrice : CGFloat? //单价 ,
    var startTime : String? //开始时间
    var stowageNo: String? // 配载单号 ,
    var totalPrice : CGFloat? // 总价 ,
    var vehicleNo : String? //车牌号
}

struct OrderAndOffer : HandyJSON {
    var offerPage: SupplyOfferDetailBean?
    var surplusTurnoverTime:TimeInterval? //交易剩余时间秒 ,
    
    var autoTimeInterval : TimeInterval? // 自动成交时间间隔 ,
    
    var zbnOrderHall : OderHallBean?
}

struct OderHallBean : HandyJSON {
    var autoTimeInterval : TimeInterval? // 自动成交时间间隔 ,
    var bidPriceWay: Int?
    var carrierType : String?
    var consigneeName : String?
    var consigneePhone :String?
    var consignorName :String?      // (string): 拖运人名称 ,
    var consignorNo :String?        // (string): 托运人ID ,
    var createTime :String?         // (string, optional),
    var dealTime : String?          // (string): 成交时间 ,
    var dealTotalPrice :CGFloat?    // (number): 成交总价 ,
    var dealUnitPrice : CGFloat?    // (number): 成交单价 ,
    var dealWay : Int?              // (integer): 成交方式 1=自动 2=手动 ,
    var endAddress : String?        // (string, optional),
    var endCity : String?           // (string): 收货地市 ,
    var endDistrict : String?       // (string): 收货区 ,
    var endProvince : String?       // (string): 收货地省 ,
    var endTime: String?            // (string): 结束时间 ,
    var freightunit : String?       // (string, optional),
    var goodsName : String?         // (string): 货品名称 ,
    var goodsType : String?         // (string): 货品分类 ,
    var goodsWeight : String?       // (number): 货源总重 ,
    var id : String?                // (string, optional),
    var infoFee : String?           // (number): 服务费 ,
    var isDeal : Int?               // (integer): 订单状态0=竞价中 1=成交 2=未上架 3=已下架 ,
    var isEnable : Int?             // (integer, optional),
    var isVisable : Int?            // (integer): 是否可见 ,
    var loadingTime : String?       // (string): 装货时间 ,
    var offerType : Int?            // (integer, optional),
    var offerWay : Int?             // (integer): 报价方式[1：有车报价 2：无车报价] ,
    var orderAvailabilityPeriod : String? // (string): 货源有效期 ,
    var packageType : String?       // (string): 包装类型 ,
    var pageNum : Int?              // (integer): 当前页数 ,
    var pageSize : Int?             // (integer): 页面大小 ,
    var payType : String?           // (string, optional),
    var publishTime : String?       // (string): 发布时间 ,
    var refercneceTotalPrice : CGFloat? // (number): 参考总价 ,
    var refercneceUnitPrice : CGFloat? // (number): 参考单价 ,
    var remark : String?            // (string, optional),
    var startAddress : String?      // (string, optional),
    var startCity : String?         // (string): 发货地市 ,
    var startDistrict : String?     // (string): 发货区 ,
    var startProvince : String?     // (string): 发货地省 ,
    var startTime : String?         // (string): 开始时间 ,
    var stowageCode : String?
    var stowageNo : String?         // (string): 配载单号 ,
    var supplyCode : String?         // (string): 货源编号 ,
    var unableReason : String?      // (string): 下架原因 ,
    var vehicleLength : String?     // (string): 车长 ,
    var vehicleType :String?        // (string): 车型 ,
    var vehicleWidth : String?      // (string): 车宽
}

struct SupplyOfferDetailBean : HandyJSON {
    var list : [SupplyOfferBean]?
    var pageNum : Int?
    var pageSize : Int?
    var total : Int?
}

enum QueryDetailOrderBy : String , HandyJSONEnum {
    
    case OrderBy_DESC   = "DESC"  // 倒序
    case OrderBy_ASC    = "ASC"  // 升序
}

struct QuerySupplyDetailBean : HandyJSON {
    var hallId:String?
    var pageNum:Int = 1
    var pageSize:Int = 20
    var amountSort:QueryDetailOrderBy? = QueryDetailOrderBy.OrderBy_ASC
    var timeSort:QueryDetailOrderBy? = QueryDetailOrderBy.OrderBy_ASC
}
