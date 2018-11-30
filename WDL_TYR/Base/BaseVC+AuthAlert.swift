//
//  BaseVC+Alert.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit


extension BaseVC {
    
    private var authAlert:ConsignorAuthAlertView {
        let alert = ConsignorAuthAlertView.authAlertView()
        alert.authClosure = {[weak self] in
            self?.toAuthNow()
        }
        return alert
    }
    
    // 判断是否是 托运人 角色，并且是否认证
    func confirmAuthed() -> Bool {
        if WDLCoreManager.shared().consignorType == .third {
            if WDLCoreManager.shared().userInfo?.status != .autherized {
                self.authAlert.showAlert(title: "您还没有认证，认证后可进行货源相关操作")
                return false
            }
        }
        return true
    }
    
    // 立即认证
    func toAuthNow() -> Void {
        let authVC = ConsignorAuthVC()
        authVC.authModel = AuthConsignorVo.deserialize(from: WDLCoreManager.shared().userInfo?.toJSON()) ?? AuthConsignorVo()
        authVC.title = "认证"
        self.push(vc: authVC, title: "认证")
    }
}
