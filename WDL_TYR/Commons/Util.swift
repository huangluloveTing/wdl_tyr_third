//
//  Util.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class Util {
    
    static func toCallPhone(num:String?) {
        guard let phone = num else {
            print("电话号码不存在")
            return
        }
        let url = URL(string:  "telprompt:"+phone)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func dateFormatter(date:TimeInterval,formatter:String = "yyyy-MM-dd") -> String {
        let toDate = Date(timeIntervalSince1970: date)
        return self.dateFormatter(date: toDate, formatter: formatter)
    }
    
    static func dateFormatter(date:Date , formatter:String = "yyyy-MM-dd") -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = formatter
        return dateFormater.string(from: date)
    }

}
