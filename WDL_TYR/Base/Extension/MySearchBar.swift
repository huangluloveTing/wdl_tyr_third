//
//  MySearchBar.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class MySearchBar: UISearchBar {
    
    private var _contentInsets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    private var _changeFrame = false
    
    public var contentInsets:UIEdgeInsets {
        set {
            _changeFrame = true
            _contentInsets = newValue
        }
        
        get {
            return _contentInsets
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subView in self.subviews[0].subviews {
            if subView.isKind(of: UIImageView.self) {
                subView.removeFromSuperview()
            }
            if subView.isKind(of: UITextField.self) {
                let textField = subView as! UITextField
                textField.textColor = UIColor(hex: "333333")
                textField.font = UIFont.systemFont(ofSize: 12)
                let width = self.frame.size.width
                let height:CGFloat = 44
                if _changeFrame {
                    
                    //说明contentInset已经被赋值
                    // 根据contentInset改变UISearchBarTextField的布局
                    subView.frame = CGRect(x: self.contentInsets.right, y: self.contentInsets.top, width: width - self.contentInsets.right - self.contentInsets.left, height: height - self.contentInsets.top - self.contentInsets.bottom)
                } else {
                    // contentSet未被赋值
                    // 设置UISearchBar中UISearchBarTextField的默认边距
                    let top = (height - 28.0) / 2.0
                    let bottom = top
                    let left:CGFloat = 8.0
                    let right = left
                    _contentInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
                }
            }
        }
    }

}
