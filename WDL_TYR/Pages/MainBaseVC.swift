//
//  MainBaseVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
//第三方货源下拉筛选
let GoodsStatus = ["不限","竞价中","已成交","未上架","已下架"]
//经销商货源下拉筛选
let AgentGoodsStatus = ["不限","竞价中","已成交","未成交"]

class MainBaseVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setStatusBarStyle(UIStatusBarStyle.lightContent)
        self.wr_setNavBarBarTintColor(UIColor(hex: "06C06F"))
        self.wr_setNavBarTintColor(UIColor.white)
        self.wr_setNavBarTitleColor(UIColor.white)
        self.view.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
    }
    
  
}

