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
    
    static func timeIntervalFromDateStr(date:String , formatter:String = "yyyy-MM-dd") -> TimeInterval {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = formatter
        let dateTime = dateFomatter.date(from: date)
        return (dateTime?.timeIntervalSince1970 ?? 0) * 1000
    }
    
    static func configServerRegions(regions:[RegionModel]) -> [PlaceChooiceItem] {
        var items:[PlaceChooiceItem] = []
        for model_1 in regions {
            var item_1 = PlaceChooiceItem(title: model_1.label ?? "", id: model_1.value ?? "", selected: false, subItems: nil, level: 0)
            if let children = model_1.children {
                let sub_items_1 = self.configServerRegions(regions: children)
                item_1.subItems = sub_items_1
            }
            items.append(item_1)
        }
        return items
    }
    
    static func isEmptyString(str:String?) -> Bool {
        guard let newStr = str else {
            return true
        }
        if newStr.count == 0 {
            return true
        }
        return false
    }
}

// 富文本 YYText
extension Util {

}
