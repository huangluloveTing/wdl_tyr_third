//
//  UIView+Border.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation


extension UIView {
    func addBorder(color:UIColor? ,width borderWidth:Float = 0 , radius borderRadius:Float = 4)  {
        self.layer.masksToBounds = true
        self.layer.borderColor = color?.cgColor
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.cornerRadius = CGFloat(borderRadius)
    }
}
