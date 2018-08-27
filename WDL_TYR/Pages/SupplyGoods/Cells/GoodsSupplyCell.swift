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
