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

struct BidingContentItem {
    var autoDealTime:TimeInterval? // 自动成交时间
    var supplyCode:String?  //货源编码
    var startPlace:String?  //发货地
    var endPlace:String?    //收货地
    var loadTime:String?    //装货时间
    var goodsName:String?   //货品名称
    var goodsType:String?   //货品分类
    var goodsSummer:String? // 货品简介
    var remark:String?      //备注
}

class GSDetailBidingHeader: UIView {
    
    typealias BidingTapClosure = (GSTapActionState) -> ()
    
    public var bidingTapClosure:BidingTapClosure?
    
    @IBOutlet weak var goodsCodeLabel: UILabel!
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
    
    private var contentItem:BidingContentItem?

    @IBAction func offShelveAction(_ sender: Any) {
        if let closure = self.bidingTapClosure {
            closure(.GSTapOffShelve)
        }
    }
    
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
            self.goodsSummaryLabel.text = self.contentItem?.goodsSummer
            self.cateTitleLabel.text = "货品分类："
            self.goodsCategoryLabel.text = self.contentItem?.goodsType
            self.remarkLabel.text = self.contentItem?.remark
            self.remarkTitleLabel.text = "备      注："
            self.cateTitleLabel.isHidden = false
            self.goodsSummaryTitleLabel.isHidden = false
            let _ = self.goodsSummaryTitleLabel.updateHeight(height: 25)
            let _ = self.cateTitleLabel.updateHeight(height: 25)
        }
    }
    
    func headerContent(item:BidingContentItem?) -> Void {
        if let item = item {
            self.contentItem = item
            self.goodsNameLabel.text = item.goodsName
            self.transTimeLabel.text = Util.dateFormatter(date: Double(item.loadTime ?? "0")! / 1000, formatter: "yyyy-MM-dd")
            self.obtainPlaceLabel.text = item.startPlace
            self.sendPlaceLabel.text = item.endPlace
            self.goodsCodeLabel.text = Util.concatSeperateStr(seperete: "", strs: "货源编号(" , item.supplyCode , ")")
        }
    }
}
