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
    static func showTitleAndContentAlert(context:UIViewController, title:String? , content:String? , closure:((Int) -> ())?) {
        let alertVC = UIAlertController(title: title, message: content, preferredStyle: .alert)
        //起运提示内容左对齐
        if title == "起运前，请确认配载信息？"{
            let subView1 : UIView = alertVC.view.subviews[0]
            
            let subView2 : UIView = subView1.subviews[0]
            
            let subView3 : UIView = subView2.subviews[0]
            
            let subView4 : UIView = subView3.subviews[0]
            
            let subView5 : UIView = subView4.subviews[0]
            
            let titleLab:UILabel = subView5.subviews[2] as! UILabel
            
            let messageLab = subView5.subviews[1] as! UILabel
            
            messageLab.textAlignment = .left
            titleLab.textAlignment = .left
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            if let closure = closure {
                closure(0)
            }
        }
        let sureAction = UIAlertAction(title: "确定", style: .default) { (_) in
            if let closure = closure {
                closure(1)
            }
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(sureAction)
        context.present(alertVC, animated: true, completion: nil)
//        _ =  UIAlertView.show(withTitle: title, message: content, cancelButtonTitle: nil, otherButtonTitles: ["取消" , "确认"]) { (alert, index) in
//            alert?.dismiss(withClickedButtonIndex: index, animated: false)
//            if let closure = closure {
//                closure(index)
//            }
//        }
    }
    
    // 自定义的有 title 和 content 的alert （eg：货源确认下架）
    static func showCustomTitleAndContentAlert(context:UIViewController , actionTitles:[String], title:String? , content:String? , closure:((Int) -> ())?) {
        let alertVC = UIAlertController(title: title, message: content, preferredStyle: .alert)
        
        actionTitles.enumerated().forEach { ( index,title) in
            let action = UIAlertAction(title: title, style: .default) { (_) in
                if let closure = closure {
                    closure(index)
                }
            }
            alertVC.addAction(action)
        }
        
        context.present(alertVC, animated: true, completion: nil)
    }
    
}
