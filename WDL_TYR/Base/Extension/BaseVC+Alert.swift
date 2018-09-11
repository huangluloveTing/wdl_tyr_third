//
//  BaseVC+Alert.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/11.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

extension BaseVC {
    
    public func showAlert(title:String? = "" , message:String? = "", closure:((Int) -> ())? = { (index) in }) {
        let _ = UIAlertView.show(withTitle: title, message: message, cancelButtonTitle: "取消", otherButtonTitles: ["确定"]) { (alert, index) in
            if let closure = closure {
                closure(index)
            }
        }
    }
    
}
