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
