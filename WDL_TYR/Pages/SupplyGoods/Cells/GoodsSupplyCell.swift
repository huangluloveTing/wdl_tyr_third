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
        
    }
    
    func configStatusLabel(status:GoodsSupplyStatus) {
        /**
         case InBidding // 竞标中
         case OffShelve // 已下架
         case InShelveOnTime // 定时上架
         case Deal       // 已成交
         */
        switch status {
        case .Deal:
            self.statusLabel.text = ""
            self.statusLabel.textColor = UIColor(hex: "")
            break
        case .InBidding:
            self.statusLabel.text = ""
            self.statusLabel.textColor = UIColor(hex: "")
            break
        case .InShelveOnTime:
            self.statusLabel.text = ""
            self.statusLabel.textColor = UIColor(hex: "")
            break
        default:
            self.statusLabel.text = ""
            self.statusLabel.textColor = UIColor(hex: "")
            break
        }
    }
}
