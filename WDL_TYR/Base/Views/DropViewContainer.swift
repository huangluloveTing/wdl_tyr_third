//
//  DropViewContainer.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class DropViewContainer: UIView {
    
    typealias ShowCompleteClosure = () -> ()
    typealias DismissCompleteClosure = () -> ()
    
    public var isShow:Bool = false
    
    private var dropView:UIView
    private var anchorView:UIView
    
    public var showCompleteClosure:ShowCompleteClosure!
    public var dismissCompleteClosure:DismissCompleteClosure!
    
    init(dropView:UIView ,
         anchorView:UIView) {
        self.dropView = dropView
        self.anchorView = anchorView
        super.init(frame:CGRect.zero)
        self.configViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViews() {
        self.isHidden = true
        self.configDropView()
    }
    
    // 根据锚点view 和 锚点view 的父视图 计算 当前下拉视图的位置
    func configDropView() {
        let anchorSuperView = self.anchorView.superview
        let x = self.anchorView.zt_x
        let y = self.anchorView.zt_y + self.anchorView.zt_height
        let width = self.anchorView.zt_width
        let height = (anchorSuperView?.zt_height)! - y
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        anchorSuperView?.addSubview(self)
        self.maskOpacityView.frame = self.bounds
        self.addSubview(self.maskOpacityView)
        self.maskOpacityView.addSubview(self.dropView)
        self.maskOpacityView.zt_height = 0
        self.maskOpacityView.addSubview(self.bottomHandleView)
        self.bottomHandleView.frame = CGRect(x: 0, y: self.dropView.zt_height, width: IPHONE_WIDTH, height: self.zt_height - self.dropView.zt_height)
    }
    
    private lazy var maskOpacityView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hex: "292B2A").withAlphaComponent(0.4)
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var bottomHandleView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.singleTap(closure: { (view) in
            self.hiddenDropView()
        })
        return view
    }()
}

extension DropViewContainer {
    
}

extension DropViewContainer {
    
    func showDropViewAnimation() {
        self.isHidden = false
        UIView.animate(withDuration: 0.25, animations: {
            self.maskOpacityView.zt_height = self.zt_height
        }) { (finish) in
            self.isShow = true
            if let closure = self.showCompleteClosure {
                closure()
            }
        }
    }
    
    func hiddenDropView() {
        UIView.animate(withDuration: 0.25, animations: {
            self.maskOpacityView.zt_height = 0
        }) { (finish) in
            if finish == true {
                self.isHidden = true
                self.isShow = false
                
                if  let closure = self.dismissCompleteClosure {
                    closure()
                }
            }
        }
    }
}
