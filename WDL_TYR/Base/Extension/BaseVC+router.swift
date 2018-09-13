//
//  BaseVC+router.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

extension BaseVC {
    
    func toRegisterVC(title:String?) { // 去注册页面
        let registerVC = RegisterVC()
        self.push(vc: registerVC , title:title)
    }
    
    func toLinkKF() { // 联系客服
        Util.toCallPhone(num: KF_PHONE_NUM)
    }
    
    func toForgetPwdVC() {
        let forgetPwdVC = ForgetPwdVC()
        self.push(vc: forgetPwdVC, title: "忘记密码")
    }
    
    // 跳转到主模块
    func toMainVC() {
        UIApplication.shared.keyWindow?.rootViewController = RootTabBarVC()
    }
    
    // 去 货物供应详情
    func toGoodsSupplyDetail() {
        let detailSupplu = GoodsSupplyDetailVC()
        self.push(vc: detailSupplu, title: "详情")
    }
    
    // 去运单详情
    func toWayBillDetail() {
        let wayBillDetail = WayBillDetailVC()
        self.push(vc: wayBillDetail, title: "运单详情")
    }
    
    //TODO: todo
    func toDelivery() {
//        let deliveryVC = DeliveryVC()
        
    }
}

extension BaseVC {
    func push(vc:UIViewController , animated:Bool = true , title:String?) {
        if self.navigationController != nil {
            if let title = title {
                vc.title = title
            }
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: animated)
        }
        else {
            self.present(vc, animated: animated, completion: nil)
        }
    }
    
    func pop(animated:Bool = true) {
        if self.navigationController != nil && (self.navigationController?.viewControllers.count)! > 1 && (self.navigationController?.viewControllers .index(of: self))! > 0 {
            self.navigationController?.popViewController(animated: animated)
        }
    }
}

fileprivate var key = "keyforheight"

extension BaseVC : UIViewControllerTransitioningDelegate {
    
    private var _topHeight:CGFloat {
        set {
            objc_setAssociatedObject(self, &key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &key) as! CGFloat
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZTTransitionManager.halfTransparentTransition(duration: 0.5, topHeight: self._topHeight)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZTTransitionManager.halfDissmissTransition(duration: 0.5)
    }
    
    func smallSheetPresent(vc:UIViewController) {
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        self._topHeight = IPHONE_HEIGHT*0.5
        self.present(vc, animated: true, completion: nil)
    }
    
    func bigSheetPresent(vc:UIViewController) {
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        self._topHeight = IPHONE_HEIGHT*0.3
        self.present(vc, animated: true, completion: nil)
    }
}
