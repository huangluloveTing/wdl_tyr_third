//
//  BaseCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


// 右边的 气泡数量 / 副标题 / 主标题
extension BaseCell {
    
    // cell上 气泡的设置
    func rightBadgeValue(value:String? , to label:UILabel) {
        if Int(value ?? "") != nil {
            label.text = value
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 11)
            label.sizeToFit()
            let height = label.zt_height
            label.addBorder(color: UIColor(hex: BADGE_VALUE_COLOR) , radius:Float(height / 2.0))
        }
    }
    
    // cell 上 副标题
    func subTitle(title:String? , to label:UILabel) {
        label.text = title
        label.textColor = UIColor(hex: SUB_TITLE_VALUE_COLOR)
        label.font = UIFont.systemFont(ofSize: 12)
    }
    
    // cell 上 主标题
    func mainTitle(title:String? , to label:UILabel) {
        label.text = title
        label.textColor = UIColor(hex: TITLE_VALUE_COLOR)
        label.font = UIFont.systemFont(ofSize: 15)
    }
}

// 处理ZTTagView 
extension BaseCell {
    
}
