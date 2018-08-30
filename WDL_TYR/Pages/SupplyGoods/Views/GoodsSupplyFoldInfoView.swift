//
//  GoodsSupplyFoldInfoView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GoodsSupplyFoldInfoView: UIView {

}


class NormalInfoView: UIView {
    
    private lazy var titleLabel:UILabel = {
       let label = UILabel(frame: CGRect.zero)
        return label
    }()
    
    private lazy var contentLabel:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func normalInfo(item:NormalInfoItem) {
        self.contentLabel.text = item.conten
        self.titleLabel.text = item.title
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    struct NormalInfoItem {
        var title:String
        var conten:String
        
    }
}
