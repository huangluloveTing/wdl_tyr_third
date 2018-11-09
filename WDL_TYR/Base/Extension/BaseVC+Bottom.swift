//
//  BaseVC+Bottom.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/31.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

var bottom_base_hanle_view_key = ""
extension BaseVC {
    
    private var bottomHandleView : BottomHandleView? {
        set {
            objc_setAssociatedObject(self, &bottom_base_hanle_view_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &bottom_base_hanle_view_key) as? BottomHandleView
        }
    }
    
    typealias BottomActionClosure = (Int) -> ()
    
    /**
     * 底部有多个按钮的情况
     */
    func bottomButtom(titles:[String] , targetView:UIView , tapClosure:((Int) ->())? = nil) -> Void {
        self.bottomHandleView?.removeFromSuperview()
        if titles.count == 1 {
            let bottomItem = BottomHandleViewItem(bgColor: UIColor(hex: COLOR_BUTTON), conerRadius: 4, titleColor: UIColor(hex: "FFFFFF"), title: titles[0], titleFont:BUTTON_FONT, borderWidth: 0 , borderColor:nil)
            self.bottomHandleView = BottomHandleView(frame: CGRect(x: 0, y: 0, width: targetView.zt_width, height: 60), bottomItems: [bottomItem])
            self.bottomHandleView?.zt_y = targetView.zt_height-60
            self.bottomHandleView?.shadow(color: UIColor(hex: COLOR_SHADOW), offset: CGSize(width: 0, height: -2), opacity: 0.5, radius: 2)
            self.bottomHandleView?.handleClosure = { (index) in
                if let closure = tapClosure {
                    closure(index)
                }
            }
            targetView.superview?.insertSubview(self.bottomHandleView!, aboveSubview: targetView)
        }
        if titles.count >= 2 {
            let bottomItem_1 = BottomHandleViewItem(bgColor: UIColor.white, conerRadius: 4, titleColor: UIColor(hex: COLOR_BUTTON) , title: titles[0], titleFont:BUTTON_FONT, borderWidth: 1 ,borderColor:UIColor(hex: COLOR_BUTTON))
            let bottomItem_2 = BottomHandleViewItem(bgColor: UIColor(hex: COLOR_BUTTON), conerRadius: 4, titleColor: UIColor(hex: "FFFFFF"), title: titles[1], titleFont:BUTTON_FONT, borderWidth: 0, borderColor:UIColor(hex: COLOR_BUTTON))
            self.bottomHandleView = BottomHandleView(frame: CGRect(x: 0, y: 0, width: targetView.zt_width, height: 60), bottomItems: [bottomItem_1, bottomItem_2])
            self.bottomHandleView?.shadow(color: UIColor(hex: COLOR_SHADOW), offset: CGSize(width: 0, height: -2), opacity: 0.5, radius: 2)
            self.bottomHandleView?.zt_y = targetView.zt_height-60
            self.bottomHandleView?.handleClosure = { (index) in
                if let closure = tapClosure {
                    closure(index)
                }
            }
            targetView.superview?.insertSubview(self.bottomHandleView!, aboveSubview: targetView)
        }
    }
}


// 底部 按钮视图
class BottomHandleView: UIView {
    
    typealias BottomHandleTapClosure = (Int) -> ()
    
    private var bottomViews:[UIButton]?
    private var bottomItems:[BottomHandleViewItem]?
    private var contentInsets:UIEdgeInsets! = UIEdgeInsetsMake(8, 10, 8, 10)
    private var hori_padding:CGFloat = 10
    
    public var handleClosure:BottomHandleTapClosure?
    
    init(frame:CGRect , bottomItems:[BottomHandleViewItem]) {
        self.bottomItems = bottomItems
        super.init(frame: frame)
        self.toConfigBottomView()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toConfigBottomView() {
        self.bottomViews = []
        if let bottomItems = self.bottomItems {
            for (index,item) in bottomItems.enumerated() {
                self.bottomViews?.append(self.bottomButton(item: item , tag: index+100))
            }
        }
    }
    
    func bottomButton(item:BottomHandleViewItem , tag:Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(item.title, for: .normal)
        button.setTitleColor(item.titleColor, for: .normal)
        button.titleLabel?.font = item.titleFont ?? UIFont.systemFont(ofSize: 16)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = item.conerRadius ?? 4
        button.layer.borderWidth = item.borderWidth ?? 0
        button.backgroundColor = item.bgColor
        button.tag = tag
        button.layer.borderColor = item.borderColor?.cgColor
        self.addSubview(button)
        return button
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutViews()
    }
    
    func layoutViews() {
        if let bottomButtons = self.bottomViews {
            let count = bottomButtons.count
            let width = (self.zt_width - self.contentInsets.left - self.contentInsets.right - CGFloat(count - 1) * hori_padding) / CGFloat(count)
            let height = self.zt_height - self.contentInsets.top - self.contentInsets.bottom
            let start_x = self.contentInsets.left
            for (index, button) in bottomButtons.enumerated() {
                let frame = CGRect(x: start_x + width * CGFloat(index) + self.hori_padding * CGFloat(index), y: self.contentInsets.top, width: width, height: height)
                button.frame = frame
                button.tapAction {[weak self] (sender) in
                    if let closure = self?.handleClosure {
                        closure(sender.tag - 100)
                    }
                }
            }
        }
    }
}

struct BottomHandleViewItem {
    var bgColor:UIColor?
    var conerRadius:CGFloat?
    var titleColor:UIColor?
    var title:String?
    var titleFont:UIFont?
    var borderWidth:CGFloat?
    var borderColor:UIColor?
}


