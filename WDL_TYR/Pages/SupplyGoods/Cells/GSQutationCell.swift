//
//  GSQutationCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

/**
 *详情报价
 */
class GSQutationCell: BaseCell {
    
    @IBOutlet weak var nameLabel: UILabel!      // 姓名
    @IBOutlet weak var phoneLabel: UILabel!     // 电话号码
    @IBOutlet weak var sumLabel: UILabel!       // 总价
    @IBOutlet weak var unitLabel: UILabel!      // 单位
    @IBOutlet weak var rateView: UIView!        // 星级
    @IBOutlet weak var rateLabel: UILabel!      // 分数
    @IBOutlet weak var reportLabel: UILabel!    // 报价时间
    @IBOutlet weak var commitButton: UIButton!  // 成交按钮
    
    private var starView:XHStarRateView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.starView = XHStarRateView(frame: self.rateView.bounds)
        self.rateView.addSubview(self.starView)
        self.starView.score = 5
        self.starView.onlyShow = true
        self.commitButton.shadowBorder(radius: 15, bgColor: UIColor(hex: COLOR_BUTTON) ,width: self.commitButton.zt_width)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
