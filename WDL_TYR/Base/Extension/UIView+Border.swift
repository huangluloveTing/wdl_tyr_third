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
var shadowLayerKey = "shadowLayerKey"
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
    
    private var shadowLayer : CAShapeLayer? {
        set {
            objc_setAssociatedObject(self, &shadowLayerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &shadowLayerKey) as? CAShapeLayer
        }
    }
    
    func shadowBorder(radius:CGFloat ,
                      bgColor:UIColor ,
                      width:CGFloat = UIScreen.main.bounds.size.width ,
                      shadowColor:UIColor = UIColor(hex: "C9C9C9") ,
                      shadowOffset:CGSize = CGSize(width: 1, height: 2) ,
                      shadowOpacity:CGFloat = 0.6 ,
                      insets:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0) ,
                      slfBgColor:UIColor = UIColor(hex: COLOR_BACKGROUND)) {
        if self.shadowLayer == nil {
            self.shadowLayer = CAShapeLayer()
            self.layer.insertSublayer(self.shadowLayer!, at: 0)
        }
        let size = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        self.backgroundColor = slfBgColor
        let shadowBunds = CGRect(x: insets.left, y: insets.top, width: width - insets.left - insets.right, height: size.height - insets.top - insets.bottom)
        self.shadowLayer?.frame = shadowBunds
        self.shadowLayer?.cornerRadius = radius
        self.shadowLayer?.backgroundColor = bgColor.cgColor
        self.shadowLayer?.masksToBounds = false
        self.shadowLayer?.shadowColor = shadowColor.cgColor
        self.shadowLayer?.shadowOffset = shadowOffset
        self.shadowLayer?.shadowOpacity = Float(shadowOpacity)
        self.shadowLayer?.shadowRadius = radius
//        self.shadowAdded = true
    }
    
    
    func topBroader(rect:CGRect , radius:CGFloat) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.topRight.rawValue)))] , cornerRadii: CGSize(width: radius, height: radius))
        let boarderLayer = CAShapeLayer()
        boarderLayer.path = path.cgPath
        self.layer.mask = boarderLayer
    }
}
