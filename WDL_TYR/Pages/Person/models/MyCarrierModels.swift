//
//  MyCarrierModels.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/21.
//  Copyright © 2018 yinli. All rights reserved.
//

import Foundation
import HandyJSON

struct ZbnFollowCarrierVo : HandyJSON {
    var carrierId : String? // (string, optional): 承运人id ,
    var carrierName : String? // (string, optional): 承运人姓名 ,
    var cellPhone : String? // (string, optional): 承运人联系方式 ,
    var dealNum : Int? // (integer, optional): 成交笔数 ,
    var dealSum : Int? // (number, optional): 成交金额 ,
    var isFollow : Int? //(integer, optional): 是否已添加 0=未添加 1=已添加 ,
    var overallScore : Float? // (number, optional): 综合评分 ,
    var photoUrl : String? // (string, optional): 承运人头像
}
