//
//  GSDetailInfoCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GSDetailInfoCell: BaseCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var goodsSummerLabel: UILabel!
    @IBOutlet weak var goodsTypeLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var loadTimeLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension GSDetailInfoCell {
    func contentInfo(info:OderHallBean?) -> Void {
        if let info = info {
            self.codeLabel.text = Util.concatSeperateStr(seperete: "", strs: "货源编号(" , info.stowageCode , ")")
            self.goodsStauts(to: self.startLabel, status: info.isDeal ?? 0)
            self.startLabel.text = Util.concatSeperateStr(seperete: "", strs: info.startProvince , info.startCity , info.startDistrict)
            self.endLabel.text = Util.concatSeperateStr(seperete: "", strs: info.endProvince,info.endCity,info.endDistrict)
            self.loadTimeLabel.text = Util.dateFormatter(date: Double(info.loadingTime ?? "0")!, formatter: "MM-dd  HH:mm")
            self.goodsNameLabel.text = info.goodsName
            self.goodsTypeLabel.text = info.goodsType
            self.goodsSummerLabel.text = Util.concatSeperateStr(seperete: " | ", strs: info.goodsWeight , info.vehicleLength , info.vehicleWidth  ,info.vehicleType , info.packageType)
            self.remarkLabel.text = info.remark
        }
    }
}
