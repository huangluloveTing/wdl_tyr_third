//
//  RootTabBarVCTableViewController.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RootTabBarVC: UITabBarController {

    lazy private var authAlert:ConsignorAuthAlertView = {
       let alert = ConsignorAuthAlertView.authAlertView()
        alert.authClosure = {[weak self] in
            self?.toAuthNow()
        }
        return alert
    }()
    
    private let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor(hex: "06C06F")
        self.delegate = self
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   
    func addControllers() {
        let deliverVC = DeliveryVC()
        let supplyVC = GoodsSupplyVC()
        let wayBillVC = WayBillVC()
        let personalVC = PersonalVC()
        let naviDeliverVC = self.childController(vc: deliverVC, normalImage: #imageLiteral(resourceName: "发货-灰"), selecteImage: #imageLiteral(resourceName: "发货-选中"), tabText: "发货")
        let naviSupplyVC = self.childController(vc: supplyVC, normalImage: #imageLiteral(resourceName: "货源-灰"), selecteImage: #imageLiteral(resourceName: "货源-选中"), tabText: "货源")
        let naviBillVC = self.childController(vc: wayBillVC, normalImage: #imageLiteral(resourceName: "运单-灰"), selecteImage: #imageLiteral(resourceName: "运单-选中"), tabText: "运单")
        let naviPersonalVC = self.childController(vc: personalVC, normalImage: #imageLiteral(resourceName: "我的-灰"), selecteImage: #imageLiteral(resourceName: "我的-选中"), tabText: "我的")
        if WDLCoreManager.shared().consignorType == .agency {
            self.viewControllers =  [naviSupplyVC , naviBillVC , naviPersonalVC]
        } else {
            self.viewControllers =  [naviDeliverVC , naviSupplyVC , naviBillVC , naviPersonalVC]
        }
    }
}

extension RootTabBarVC {
    func childController(vc:UIViewController ,
                         normalImage:UIImage ,
                         selecteImage:UIImage ,
                         tabText:String) -> UIViewController {
        
        let naviVC = UINavigationController(rootViewController: vc)
        let item = UITabBarItem(title: tabText, image: normalImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: selecteImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        naviVC.tabBarItem = item

        return naviVC
    }
}

extension RootTabBarVC : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = (viewControllers ?? []).firstIndex(of: viewController)
        return self.confirmAuthed(index: index ?? 0)
    }
    
    
    // 判断是否是 托运人 角色，并且是否认证
    func confirmAuthed(index:Int) -> Bool {
        if WDLCoreManager.shared().consignorType == .third {
            if WDLCoreManager.shared().userInfo?.status != .autherized {
                if index == 1 {
                    self.authAlert.showAlert(title: "您还没有认证，认证后可进行货源相关操作")
                    return false
                }
                if index == 2 {
                    self.authAlert.showAlert(title: "您还没有认证，认证后可进行运单相关操作")
                    return false
                }
            }
        }
        return true
    }
    
    // 立即认证
    func toAuthNow() -> Void {
        let vc = self.viewControllers![self.selectedIndex] as! UINavigationController
        let authVC = ConsignorAuthVC()
        authVC.authModel = AuthConsignorVo.deserialize(from: WDLCoreManager.shared().userInfo?.toJSON()) ?? AuthConsignorVo()
        authVC.title = "认证"
        vc.pushViewController(authVC, animated: true)
    }
}
