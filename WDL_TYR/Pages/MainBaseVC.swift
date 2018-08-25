//
//  MainBaseVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class MainBaseVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setStatusBarStyle(UIStatusBarStyle.lightContent)
        self.wr_setNavBarBarTintColor(UIColor(hex: "06C06F"))
        self.wr_setNavBarTintColor(UIColor.white)
        self.wr_setNavBarTitleColor(UIColor.white)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

