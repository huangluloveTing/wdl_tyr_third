//
//  UIViewController+navigation.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/3.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation


extension UIViewController {
    func backBarButtonItem() {
        if self.navigationController != nil && (self.navigationController?.viewControllers.count)! > 0 &&
            self.navigationController?.viewControllers.first != self
        {
            self.addLeftBarbuttonItem(with: #imageLiteral(resourceName: "back"))
        }
    }
}
