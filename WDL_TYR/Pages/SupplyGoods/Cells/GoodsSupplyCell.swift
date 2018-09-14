//
//  GoodsSupplyCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/26.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GoodsSupplyCell: BaseCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var goodsSpecLabel: UILabel!
    @IBOutlet weak var cartSpecLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.containerView.backgroundColor = UIColor(hex: "EEEEEE")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension GoodsSupplyCell {
    func showContent(item:GoodsSupplyListItem)  {
        self.configStatusLabel(status: item.isDeal ?? GoodsSupplyListStatus.status_soldout)
        let num = item.offer?.offerNumber ?? 0
        if num == 0 {
            self.numLabel.text = ""
            self.reportLabel.text = "暂无报价"
        }
        else {
            self.numLabel.text = String(num)
            self.reportLabel.text = "报价"
        }
        
        self.startLabel.text = (item.startCity ?? " ") + (item.startDistrict ?? " ")
        self.endLabel.text = (item.endCity ?? " ") + (item.endDistrict ?? " ")
        self.goodsNameLabel.text = item.goodsName ?? " "
        self.cartSpecLabel.text = self.getCartSpecText(item: item)
        self.goodsSpecLabel.text = self.getGoodsSpec(item: item)
    }
    
    func configStatusLabel(status:GoodsSupplyListStatus) {
        /**
         case InBidding // 竞标中
         case OffShelve // 已下架
         case InShelveOnTime // 定时上架
         case Deal       // 已成交
         */
        switch status {
        case .status_deal:
            self.statusLabel.text = "已成交"
            self.statusLabel.textColor = UIColor(hex: COLOR_BUTTON)
            break
        case .status_bidding:
            self.statusLabel.text = "竞标中"
            self.statusLabel.textColor = UIColor(hex: COLOR_BUTTON)
            break
        case .status_putway:
            self.statusLabel.text = "竞标中"
            self.statusLabel.textColor = UIColor(hex: "7876CF")
            break
        default:
            self.statusLabel.text = "已下架"
            self.statusLabel.textColor = UIColor(hex: TEXTCOLOR_EMPTY)
            break
        }
    }
    
    func getCartSpecText(item:GoodsSupplyListItem) -> String? {
        let weight = item.goodsWeight
        let type = item.vehicleType
        let package = item.packageType
        
        let weightContent:String = (weight == nil) ? " " : (String(Float(weight!)) + "吨|")
        let typeContent:String = (type == nil) ? " " : type! + "|"
        let packageContent : String = (package == nil) ? " " : package!
        return weightContent + typeContent + packageContent
    }
    
    func getGoodsSpec(item:GoodsSupplyListItem) -> String? {
        let time = item.loadingTime ?? Date().timeIntervalSince1970 * 1000
        let type = item.goodsType
        let timeStr = Util.dateFormatter(date: time / 1000, formatter: "MM-dd")
        return timeStr + "|" + (type ?? "")
    }
}
