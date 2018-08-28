//
//  BaseBean.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/28.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

import RxDataSources
import HandyJSON

class BaseSectionBean: NSObject , IdentifiableType  , HandyJSON {
    
    var identity: String{
        return ""
    }
    
    typealias Identity = String
    
    override required init() {
        
    }
    
    
}
