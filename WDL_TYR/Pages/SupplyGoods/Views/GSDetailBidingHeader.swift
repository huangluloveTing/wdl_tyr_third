//
//  GoodsSupplyDetailHeader.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/28.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

enum GSTapActionState {
    case GSTapExpand(Bool)
    case GSTapOffShelve
}

class GSDetailBidingHeader: UIView {
    
    typealias BidingTapClosure = (GSTapActionState) -> ()
    
    public var bidingTapClosure:BidingTapClosure?
    
    @IBOutlet weak var goodsSummaryTitleLabel: UILabel!
    @IBOutlet weak var goodsSummaryLabel: UILabel!
    @IBOutlet weak var remarkTitleLabel: UILabel!
    @IBOutlet weak var cateTitleLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var goodsCategoryLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var transTimeLabel: UILabel!
    @IBOutlet weak var obtainPlaceLabel: UILabel!
    @IBOutlet weak var sendPlaceLabel: UILabel!

    @IBAction func enpandAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.foldHeader(isFolder: sender.isSelected)
        if let closure = self.bidingTapClosure {
            closure(.GSTapExpand(sender.isSelected))
        }
    }
}

extension GSDetailBidingHeader {
    // 折叠
    func foldHeader(isFolder:Bool) {
        if isFolder == false {
            self.goodsSummaryTitleLabel.text = nil
            self.goodsSummaryLabel.text = nil
            self.cateTitleLabel.text = nil
            self.goodsCategoryLabel.text = nil
            self.remarkLabel.text = nil
            self.remarkTitleLabel.text = nil
            self.goodsSummaryTitleLabel.hiddenByUpdateHeight()
            self.cateTitleLabel.hiddenByUpdateHeight()
        }
        else {
            self.goodsSummaryTitleLabel.text = "货品简介："
            self.goodsSummaryLabel.text = "发哈合法化"
            self.cateTitleLabel.text = "货品分类："
            self.goodsCategoryLabel.text = "卡发开发发放"
            self.remarkLabel.text = "af按了回复拉风half哈喽哈发卡号发来客户发了回复"
            self.remarkTitleLabel.text = "备      注："
            self.cateTitleLabel.isHidden = false
            self.goodsSummaryTitleLabel.isHidden = false
            let _ = self.goodsSummaryTitleLabel.updateHeight(height: 25)
            let _ = self.cateTitleLabel.updateHeight(height: 25)
        }
    }
    
    
}
