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

var shadowBorderKey = "shadowBorderKey-shadow"
// 添加 圆角 和 阴影
extension UIView {
    
    private var shadowAdded : Bool {
        set {
            objc_setAssociatedObject(self, &shadowBorderKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &shadowBorderKey)
            guard let cValue = value else {
                return false
            }
            return cValue as! Bool
        }
    }
    
    func shadowBorder(radius:CGFloat ,
                      bgColor:UIColor ,
                      width:CGFloat = UIScreen.main.bounds.size.width ,
                      shadowColor:UIColor = UIColor(hex: "C9C9C9") ,
                      shadowOffset:CGSize = CGSize(width: 1, height: 2) ,
                      shadowOpacity:CGFloat = 0.6) {
        if self.shadowAdded {
            return;
        }
        let shadowBorderLayer = CALayer()
        let size = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        shadowBorderLayer.frame = CGRect(origin: .zero, size: CGSize(width: width, height: size.height))
        shadowBorderLayer.cornerRadius = radius
        shadowBorderLayer.backgroundColor = bgColor.cgColor
        shadowBorderLayer.masksToBounds = false
        shadowBorderLayer.shadowColor = shadowColor.cgColor
        shadowBorderLayer.shadowOffset = shadowOffset
        shadowBorderLayer.shadowOpacity = Float(shadowOpacity)
        shadowBorderLayer.shadowRadius = radius
        self.layer.insertSublayer(shadowBorderLayer, at: 0)
        self.shadowAdded = true
    }
    
}
