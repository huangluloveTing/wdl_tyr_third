//
//  BaseVC+Toast.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/7.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

let toastDuration = 1.5

extension BaseVC {
    
    typealias ToastCompleteClosure = () -> ()
    
    func showLoading(title:String? = nil , complete:ToastCompleteClosure? = {}) {
        self.showLoading(title: title, canInterface: false)
    }
    
    func showLoading(title:String? , canInterface:Bool = false) {
        self.svProgressCanInterface(interface: canInterface)
        SVProgressHUD.show(withStatus: title)
    }
    
    
    func showSuccess(success:String? = nil , complete:ToastCompleteClosure? = {}) {
        self.svProgressCanInterface()
        SVProgressHUD.showSuccess(withStatus: success)
        SVProgressHUD.dismiss(withDelay: 0.5) {
            if let complete = complete {
                complete()
            }
        }
    }
    
    func showFail(fail:String? = nil , complete:ToastCompleteClosure? = {}) {
        self.svProgressCanInterface()
        SVProgressHUD.showError(withStatus: fail)
        SVProgressHUD.dismiss(withDelay: 0.5) {
            if let complete = complete {
                complete()
            }
        }
    }
    
    func showWarn(warn:String? = nil , complete:ToastCompleteClosure? = {}) {
        self.svProgressCanInterface()
        SVProgressHUD.showInfo(withStatus: warn)
        SVProgressHUD.dismiss(withDelay: toastDuration) {
            if let complete = complete {
                complete()
            }
        }
    }
    
    func hiddenToast() {
        SVProgressHUD.dismiss()
    }
    
    private func svProgressCanInterface(interface:Bool = false) {
        if interface {
            SVProgressHUD.setDefaultMaskType(.none)
        }
        SVProgressHUD.setDefaultMaskType(.custom)
    }
}
