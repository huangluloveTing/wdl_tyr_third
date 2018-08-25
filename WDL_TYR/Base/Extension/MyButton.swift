//
//  MyButton.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class MyButton: UIButton {

    open override func layoutSubviews() {
        super.layoutSubviews()
        // 还可增设间距
        let spacing:CGFloat = 3.0
        
        // 图片右移
        let imageSize = self.imageView?.frame.size ?? CGSize.zero
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -((imageSize.width) * 2 + spacing), 0.0, 0.0);
        
        // 文字左移
        let titleSize = self.titleLabel?.frame.size ?? CGSize.zero
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -(titleSize.width) * 2 - spacing);
    }
}
