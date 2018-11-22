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
    var carrierPhone:String? // 承运人电话,
    var carrierScore:CGFloat? //评分
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
    var autoTimeInterval : TimeInterval? // (integer): 自动成交时间间隔（小时） ,
    var bidPriceWay : Int? // (integer): 竞价方式 1=自由 2=指派 ,
    var carrierId : String? // (string): 承运商id ,
    var carrierName : String? // (string): 姓名 ,
    var carrierType : String? // (string): 承运方式 (1-单车运输) ,
    var cellPhone : String? // (string): 手机号 ,
    var consigneeName : String? //(string): 收货人 ,
    var consigneePhone : String? // (string): 收货人联系电话 ,
    var consignorName : String? // (string): 拖运人名称 ,
    var consignorNo : String? // (string): 托运人ID ,
    var createTime : String? // (string),
    var dealOfferTime : String? // (string): 成交货源的报价时间 ,
    var dealTime : String? // (string): 成交时间 ,
    var dealTotalPrice : CGFloat? // (number): 成交总价 ,
    var dealUnitPrice : CGFloat? // (number): 成交单价 ,
    var dealWay : Int? // (integer): 成交方式 1=自动 2=手动 ,
    var driverName : String? // (string): 司机姓名 ,
    var driverPhone : String? //(string): 司机联系方式 ,
    var endAddress : String? // (string): 收货详细地址 ,
    var endCity : String? // (string): 收货地市 ,
    var endDistrict : String? // (string): 收货区 ,
    var endProvince : String? // (string): 收货地省 ,
    var endTime : String? // (string): 结束时间 ,
    var freightunit : String? // (string): 结算单位 ,
    var goodsName : String? // (string): 货品名称 ,
    var goodsType : String? // (string): 货品分类 ,
    var goodsWeight : String? // (number): 货源总重 ,
    var id : String? // (string), 货源id
    var infoFee : CGFloat? // (number): 服务费 ,
    var isDeal : Int? // (integer): 是否成交 0=竞价中 1=成交 2=未上架 3=已下架 ,
    var isEnable : Int? // (integer): 上下架 0=下架 1=上架 ,
    var isVisable : Int? // (integer): 是否可见 1=全部可见 2=部分可见 ,
    var loadingPersonAddress : String? // (string): 装货联系人地址 ,
    var loadingPersonName : String? // (string): 装货联系人 ,
    var loadingPersonPhone : String? // (string): 装货联系人电话 ,
    var loadingTime : String? // (string): 装货时间 ,
    var offerType : Int? // (integer): 报价类型[1：明报，2：暗报] ,
    var offerWay : Int? // (integer): 报价方式[1：有车报价 2：无车报价] ,
    var ordNo : String? // (string): 订单号 ,
    var orderAvailabilityPeriod : String? // (string): 货源有效期 ,
    var packageType : String? // (string): 包装类型 ,
    var payType : String? // (string): 支付类型（0-现金） ,
    var publishTime : String? // (string): 发布时间 ,
    var refercnecePriceIsVisable : String? // (string): 参考价是否可见 1=可见 2=不可见 ,
    var refercneceTotalPrice : CGFloat? // (number): 参考总价 ,
    var refercneceUnitPrice : CGFloat? // (number): 参考单价 ,
    var remark : String? // (string),
    var sourceType : Int? // (integer): 货源来源 1:来至ZBN，2:来至TMS , 3:来自SAP ,
    var startAddress : String? // (string): 发货详细地址 ,
    var startCity : String? // (string): 发货地市 ,
    var startDistrict : String? // (string): 发货区 ,
    var startProvince : String? // (string): 发货地省 ,
    var startTime : String? // (string): 开始时间 ,
    var stowageNo : String? // (string): 配载单号 ,
    var supplyCode : String? // (string): 货源编号 ,
    var transportWay : String? // (string): 运输方式 ,
    var unableReason : String? // (string): 下架原因 ,
    var vehicleLength : String? // (string): 车长 ,
    var vehicleLengthDriver : String? // (string): 司机车长 ,
    var vehicleNo : String? // (string): 车牌号码 ,
    var vehicleStatuc : String? // (integer): TMS货源订单配载情况 1： 未配载 2，已配载 ,
    var vehicleType : String? // (string): 车型 ,
    var vehicleTypeDriver : String? // (string): 司机车型 ,
    var vehicleWeightDriver : String? // (string): 司机车重 ,
    var vehicleWidth : String? // (string): 车宽 ,
    var orderAvailabilityPeriodCode:String? // 货源有效期 code
    var vehicleWidthDriver : String? // (string): 司机车宽
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
//    var amountSort:QueryDetailOrderBy? = QueryDetailOrderBy.OrderBy_ASC
//    var timeSort:QueryDetailOrderBy? = QueryDetailOrderBy.OrderBy_ASC
    var amountSort:QueryDetailOrderBy?
    var timeSort:QueryDetailOrderBy?
}
