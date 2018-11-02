//
//  QuerytTransportListBean.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/16.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import HandyJSON

struct QuerytTransportListBean: HandyJSON {
    var endCity : String? // (string): 收货地市 ,
    var endDistrict : String? // (string): 收货区 ,
    var endProvince : String? // (string): 收货地省 ,
    var pageNum : Int = 1 // (integer): 当前页数 ,
    var pageSize : Int = 20 // (integer): 页面大小 ,
    var startCity : String? // (string): 发货地市 ,
    var startDistrict : String? // (string): 发货区 ,
    var startProvince : String? // (string): 发货地省 ,
    var searchWord : String?    // 搜索值
    var transportStatus : Int? // (integer): 运单状态 1=待起运 0=待办单 2=运输中 3=已签收 4=被拒绝
}

struct WayBillDetailCommentInfo : HandyJSON {
    var rate:CGFloat?
    var comment:String?
    var commentTime:TimeInterval?
}


struct ZbnEvaluateVo : HandyJSON {
    var commonts : String = "" // (string): 评价 ,
    var evaluateTo : Int? // (integer): 谁的评价 1=托运人评价无车承运人 2=托运人评价有车承运人
    var logisticsServicesScore : Int = 5 // (integer): 物流服务得分 ,
    var serviceAttitudeScore : Int = 5 // (integer): 服务态度 ,
    var transportNo : String = "" // (string): 运单号
}
