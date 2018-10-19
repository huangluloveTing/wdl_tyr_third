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
    
    // 货源 货源详情中 状态的处理  0=竞价中 1=成交 2=未上架 3=已下
    func goodsStauts(to label:UILabel , status:Int) -> Void {
        label.addBorder(color: nil, width: 0, radius: 3)
        label.isHidden = false
        if status == 0 {
            label.backgroundColor = UIColor(hex: "DCF6E8").withAlphaComponent(0.3)
            label.textColor = UIColor(hex: "DCF6E8")
            label.text = " 竞价中 "
        }
        if status == 1 {
            label.isHidden = true
        }
        if status == 2 {
            label.backgroundColor = UIColor(hex: "7876CF").withAlphaComponent(0.3)
            label.textColor = UIColor(hex: "7876CF")
            label.text = " 未上架 "
        }
        if status == 3 {
            label.backgroundColor = UIColor(hex: "585060").withAlphaComponent(0.3)
            label.textColor = UIColor(hex: "585060")
            label.text = " 已下架 "
        }
    }
    
    // 运单状态 1=待起运 0=待办单 2=运输中 3=待签收 4=已签收  5=被拒绝
    func transportInfoStatusDisplay(status:Int , to label:UILabel) {
        if status == 1 || status == 0 {
            label.text = "待起运"
            label.textColor = UIColor(hex: "EDC977")
        }
        if status == 2 {
            label.textColor = UIColor(hex: "06C072")
            label.text = "运输中"
        }
        if status == 3 {
            label.textColor = UIColor(hex: "999999")
            label.text = "待签收"
        }
        if status == 4 {
            label.textColor = UIColor(hex: "999999")
            label.text = "已签收"
        }
        if status == 5 {
            label.text = "被拒绝"
        }
    }
}

// 处理ZTTagView 
extension BaseCell {
    
}
