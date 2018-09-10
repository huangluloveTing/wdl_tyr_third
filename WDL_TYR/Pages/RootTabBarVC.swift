//
//  RootTabBarVCTableViewController.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class RootTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor(hex: "06C06F")
        self.addControllers()
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
        self.viewControllers = [naviDeliverVC , naviSupplyVC , naviBillVC , naviPersonalVC]
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
