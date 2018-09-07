//
//  BaseVC+Toast.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/7.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation


extension BaseVC {
    
    typealias ToastCompleteClosure = () -> ()
    
    func showLoading(title:String = "" , complete:ToastCompleteClosure = {}) {
    }
    
    
    func showSuccess(success:String = "" , complete:ToastCompleteClosure = {}) {
        
    }
    
    func showFail(fail:String = "" , complete:ToastCompleteClosure = {}) {
        
    }
    
    func showWarn(warn:String = "" , complete:ToastCompleteClosure = {}) {
        
    }
}
