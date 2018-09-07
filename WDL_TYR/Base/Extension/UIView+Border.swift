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
    
    func shadow(color:UIColor , offset:CGSize , opacity:CGFloat , radius:CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Float(opacity)
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
                      shadowOpacity:CGFloat = 0.6 ,
                      insets:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)) {
        if self.shadowAdded {
            return;
        }
        let shadowBorderLayer = CALayer()
        let size = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        self.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        let shadowBunds = CGRect(x: insets.left, y: insets.top, width: width - insets.left - insets.right, height: size.height - insets.top - insets.bottom)
        shadowBorderLayer.frame = shadowBunds
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
    
    
    func topBroader(rect:CGRect , radius:CGFloat) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.topRight.rawValue)))] , cornerRadii: CGSize(width: radius, height: radius))
        let boarderLayer = CAShapeLayer()
        boarderLayer.path = path.cgPath
        self.layer.mask = boarderLayer
    }
}
