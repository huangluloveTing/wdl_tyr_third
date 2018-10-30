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
            // 解决 alert view 显示后，toast 不显示的bug
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                if let closure = closure {
                    closure(index)
                }
            })
        }
    }
    
    public func showAlert(items:[String], title:String? = "提示" , message:String? = nil , showCancel:Bool = true , closure:((Int)->())? = nil) {
        let alertVC = UIAlertController(title:title , message: message, preferredStyle: .alert)
        items.enumerated().forEach { (index ,item) in
            let action = UIAlertAction(title: item, style: .default, handler: { (action) in
                if let closure = closure {
                    closure(index)
                }
            })
            alertVC.addAction(action)
        }
        
        if showCancel == true {
            let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
                let index = items.count
                if let closure = closure {
                    closure(index)
                }
            }
            alertVC.addAction(cancelAction)
        }
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
