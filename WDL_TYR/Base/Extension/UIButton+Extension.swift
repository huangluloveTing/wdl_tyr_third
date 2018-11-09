//
//  UIButton+Extension.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

var button_extenson_key = ""
extension UIButton {
    
    typealias TapButtonClosure = (UIButton) -> ()
    private var tapButtonClosure:TapButtonClosure? {
        set {
            objc_setAssociatedObject(self, &button_extenson_key, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, &button_extenson_key) as? UIButton.TapButtonClosure
        }
    }
    
    func tapAction(closure:TapButtonClosure?) {
        self.addTarget(self, action: #selector(tapButtonAction(sender:)), for: .touchUpInside)
        self.tapButtonClosure = closure
    }
    
    @objc private func tapButtonAction(sender:UIButton) {
        if let closure = self.tapButtonClosure {
            closure(sender)
        }
    }
}

