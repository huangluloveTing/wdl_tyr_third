//
//  UIView+Extension.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import SnapKit
import RxSwift


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
        self.updateConstraintsIfNeeded()
        return self
    }
    
    func hiddenByUpdateHeight() {
        self.updateHeight(height: 0).isHidden = true
    }
    
    func showByUpdateHeight(height:CGFloat) {
        self.updateHeight(height: height).isHidden = false
    }
}

// frame
extension UIView {
    
    public var zt_x:CGFloat {
        get {
           return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var zt_y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var zt_width:CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    public var zt_height:CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    public var zt_origin:CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        
        get {
            return self.frame.origin
        }
    }
    
    public var zt_size:CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        
        get {
            return self.frame.size
        }
    }
    
    public var endX : CGFloat {
        get {
            return self.zt_x+self.zt_width
        }
    }
    
    public var endY : CGFloat {
        get {
            return self.zt_y+self.zt_height
        }
    }
}

extension UIView {
    
    //删除 指定的视图类型的所有视图
    func removeSubTypeView(viewType:AnyClass) {
        let subViews = self.subviews
        for subView in subViews {
            if subView.isKind(of: viewType) {
                subView.removeFromSuperview()
            }
        }
    }
}


// 添加点击事件
var storeTapClosureKey = "storeTapClosureKey"
extension UIView {
    
    typealias SingleTapAction = (UIView) -> ()
    
    private var singleTapClosure:SingleTapAction? {
        set {
            objc_setAssociatedObject(self, &storeTapClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &storeTapClosureKey) as? UIView.SingleTapAction)
        }
    }
    
    func singleTap(closure:SingleTapAction?) -> Void {
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTapViewAction(sender:)))
        self.isUserInteractionEnabled = true
        self.singleTapClosure = closure
        self.addGestureRecognizer(tap)
    }
    
    
    @objc private func singleTapViewAction(sender:UIView) {
        if self.singleTapClosure != nil {
            self.singleTapClosure!(sender)
        }
    }
}


