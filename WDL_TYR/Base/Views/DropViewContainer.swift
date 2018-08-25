//
//  DropViewContainer.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class DropViewContainer: UIView {
    
    private var dropView:UIView
    private var anchorView:UIView
    init(frame:CGRect , dropView:UIView , anchorView:UIView) {
        self.dropView = dropView
        self.anchorView = anchorView
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViews() {
        self.maskOpacityView.frame = self.bounds
        self.addSubview(self.maskOpacityView)
    }
    
    private lazy var maskOpacityView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hex: "292B2A").withAlphaComponent(0.4)
        view.clipsToBounds = true
        return view
    }()
}

extension DropViewContainer {
    
    func showDropView() {
        
    }
    
    func hiddenDropView() {
        
    }
}
