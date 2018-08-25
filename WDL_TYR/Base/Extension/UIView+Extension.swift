//
//  UIView+Extension.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import SnapKit


extension UIView {
    
    func updateTop(top:CGFloat) -> UIView {
        self.snp.updateConstraints { (maker) in
            maker.top.equalTo(top)
        }
        
        return self
    }
    
    func updateLeft(left:CGFloat) -> UIView {
        self.snp.updateConstraints { (maker) in
            maker.left.equalTo(left)
        }
        return self
    }
    
    func updateRight(right:CGFloat) -> UIView {
        self.snp.updateConstraints { (maker) in
            maker.right.equalTo(right)
        }
        return self
    }
    
    func updateBottom(bottom:CGFloat) -> UIView {
        self.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(bottom)
        }
        return self
    }
    
    func updateWidth(width:CGFloat) -> UIView {
        self.snp.updateConstraints { (maker) in
            maker.width.equalTo(width)
        }
        return self
    }
    
    func updateHeight(height:CGFloat) -> UIView {
        self.snp.updateConstraints { (maker) in
            maker.height.equalTo(height)
        }
        return self
    }
    
    func hiddenByUpdateHeight() {
        self.updateHeight(height: 0).isHidden = true
    }
    
    func showByUpdateHeight(height:CGFloat) {
        self.updateHeight(height: height).isHidden = false
    }
}


