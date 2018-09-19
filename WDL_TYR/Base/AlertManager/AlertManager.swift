//
//  AlertManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/19.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

class AlertManager: NSObject {
    
    // 货源 报价 确认成交的 alert
    static func showDealConfrimAlert(confirm:GSConfirmAlertItem? , closure:((Int) -> ())?) {
        GSConfirmDealView.showConfirmDealView(confirm: confirm!) { (index) in
            if let closure = closure {
                closure(index)
            }
        }
    }
    
    // 自定义的有 title 和 content 的alert （eg：货源确认下架）
    static func showTitleAndContentAlert(title:String? , content:String? , closure:((Int) -> ())?) {
       let _ =  UIAlertView.show(withTitle: title, message: content, cancelButtonTitle: nil, otherButtonTitles: ["取消" , "确认"]) { (alert, index) in
            if let closure = closure {
                closure(index)
            }
        }
    }
    
}
