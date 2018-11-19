
//
//  WayBillPageBean.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/17.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import HandyJSON
import RxDataSources


struct WayBillPageBean : HandyJSON {
    var list : [WayBillInfoBean]? //
    var pageNum : Int?
    var pageSize : Int?
    var total : Int = 0
}

// (integer): 运单状态 -1不限 1=待起运 0=待办单 2=运输中 3=待签收 10=已签收
enum WayBillTransportStatus : Int , HandyJSONEnum { // 运单状态
    case noStart = 0           // 未开始
    case willToTransport = 1   // 待起运
    case transporting = 2      // 运输中
    case willToPickup = 3      // 待签收
    case done = 10            // 完成（已签收）
}

struct WayBillInfoBean : HandyJSON {
    var autoTimeInterval : Int? // (integer): 自动成交时间间隔 ,
    var bidPriceWay : Int?      // (integer, optional),
    var carrierName : String?   // (string): 承运人姓名 ,
    var carrierType :String?    // (string, optional),
    var cellPhone :String?      // (string): 承运人手机号 ,
    var consigneeName : String? // (string, optional),
    var consigneePhone :String? // (string, optional),
    var consignorName :String?  // (string): 拖运人名称 ,
    var consignorNo : String?   // (string): 托运人ID ,
    var createTime : String?    // (string, optional),
    var dealTime : TimeInterval? // (string): 成交时间 ,
    var dealOfferTime: TimeInterval? // (string): 成交货源的报价时间 ,
    var dealTotalPrice : CGFloat? // (number): 成交总价 ,
    var dealUnitPrice : CGFloat? // (number): 成交单价 ,
    var dealWay : Int?          // (integer): 成交方式 1=自动 2=手动 ,
    var driverName : String?    // (string): 司机姓名 ,
    var driverPhone : String?   // (string): 司机手机号 ,
    var endAddress : String?    // (string, optional),
    var endCity : String?       // (string): 收货地市 ,
    var endDistrict :String?    // (string): 收货区 ,
    var endProvince : String?   // (string): 收货地省 ,
    var endTime : TimeInterval? // (string): 结束时间 ,
    var freightunit : String?   // (string, optional),
    var goodsName : String?     // (string): 货品名称 ,
    var goodsType : String?     // (string): 货品分类 ,
    var goodsWeight : String?   // (number): 货源总重 ,
    var id : String?            // (string, optional),
    var infoFee : String?       // (number): 服务费 ,
    var isDeal : String?        // (integer): 订单状态0=竞价中 1=成交 2=未上架 3=已下架 ,
    var isEnable : String?      // (integer, optional),
    var isVisable : String?     // (integer): 是否可见 ,
    var loadingTime : TimeInterval? // (string): 装货时间 ,
    var loadingPersonName : String? // (string): 装货联系人 ,
    var loadingPersonPhone : String? // (string): 装货联系人电话 ,
    var locationList : [ZbnLocation]? // (Array[ZbnLocation]): 定位信息 ,
    var offerType : String? // (integer, optional),
    var offerHasVehicle : Int = 1 // (string): 报价类型（0-无车报价 1-有车报价） ,
    var offerWay :Int? // (integer): 报价方式[1：有车报价 2：无车报价] ,
    var orderAvailabilityPeriod : String? // (string): 货源有效期 ,
    var packageType : String? // (string): 包装类型 ,
    var payType :String? // (string, optional),
    var publishTime : TimeInterval? // (string): 发布时间 ,
    var refercnecePriceIsVisable : String? // (string, optional),
    var refercneceTotalPrice : CGFloat? // (number): 参考总价 ,
    var refercneceUnitPrice : CGFloat? // (number): 参考单价 ,
    var remark : String? // (string, optional),
    var returnList : [ZbnTransportReturn]? // (Array[ZbnTransportReturn]): 回单信息 ,
    var startAddress : String? // (string, optional),
    var startCity : String? // (string): 发货地市 ,
    var startDistrict : String? // (string): 发货区 ,
    var startProvince : String? // (string): 发货地省 ,
    var startTime : TimeInterval? // (string): 开始时间 ,
    var stowageCode : String? // (string): 运单编码 ,
    var stowageNo : String? // (string): 配载单号 ,
    var supplyCode : String? // (string, optional): 货源编码 ,
    var transportStatus : WayBillTransportStatus? // (integer): 运单状态 -1不限 1=待起运 0=待办单 2=运输中 3=待签收 10=已签收
    var transportNo:String? // 运单号
    var transportWay : String? // (string, optional),
    var unableReason : String? // (string): 下架原因 ,
    var vehicleLength : String? // (string): 车长 ,
    var vehicleNo :String? // (string): 车牌号 ,
    var vehicleType : String? // (string): 车型 ,
    var vehicleWidth : String? // (string): 车宽
    var evaluateList : [ZbnEvaluate]? // 评价信息
    
    var vehicleLengthDriver : String? // (string): 司机车长 ,
    var vehicleTypeDriver : String?//(string): 司机车型 ,
    var vehicleWeightDriver : String?//(string): 司机车重 
    
    
    
}

extension WayBillInfoBean : IdentifiableType , Equatable {
    var identity: String {
        return self.id ?? ""
    }
    
    typealias Identity = String
    
    static func == (lhs: WayBillInfoBean, rhs: WayBillInfoBean) -> Bool {
        if lhs.toJSONString() == rhs.toJSONString() {
            return true
        }
        return false
    }
}

struct ZbnLocation : HandyJSON { // 定位信息
    var endTime : TimeInterval? // (string): 结束时间 ,
    var id : String? // (string, optional),
    var latitude : CGFloat? //(number, optional),
    var location : String? // (string, optional),
    var longitude : CGFloat? // (number, optional),
    var startTime : TimeInterval? // (string): 开始时间 ,
    var transportNo : String? // (string, optional),
    var vehicleNo : String? // (string, optional)
}

struct ZbnTransportReturn : HandyJSON { // 回单信息 ,
    var endTime : TimeInterval? // (string): 结束时间 ,
    var id : String? // (string, optional),
    var returnBillUrl : String? // (string): 回单存储路径 ,
    var startTime : TimeInterval? // (string): 开始时间 ,
    var createTime : TimeInterval? // (string): 回单时间 ,
    var transportNo : String? // (string, optional)
}

struct ZbnEvaluate  : HandyJSON {
    var driverName : String? // (string, optional), 司机姓名
    var endTime : TimeInterval? // (string): 结束时间 ,
    var evaluateScore : CGFloat? // (integer, optional), 评分
    var evaluateTo : Int? // (integer, optional),EVALUATE_TO 谁的评价 1=托运人评价无车承运人 2=托运人评价有车承运人 3=无车承运人平均价有车承运人 4=司机评价托运人
    var id : String? // (string, optional),
    var ordCount : String? // (integer, optional), 竞价次数
    var score : Int? // (integer, optional), 得分
    var startTime : TimeInterval? // (string): 开始时间 ,
    var transportNo : String? // (string, optional) 运单号
    var transportLine : String? // (string): 线路 ,
    var transportCount : Int = 0 // (integer): 承运次数 ,
    var logisticsServicesScore : Int = 0 // (integer): 物流服务得分 ,
    var serviceAttitudeScore : Int = 0 // (integer): 服务态度 ,
    var activity : Int = 0  //(integer): 活跃度 ,
    var bidPriceCount : Int = 0 // (integer): 竞价次数 ,
    var breachCount : Int = 0 // (integer): 违约次数 ,
    var commonts : String?
    var createTime : TimeInterval = 0 // (string): 时间 ,
}
