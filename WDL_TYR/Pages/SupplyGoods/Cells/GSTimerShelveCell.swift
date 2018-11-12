//
//  GSTimerShelveCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GSTimerShelveCell: BaseCell {
    
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var goodsSummerLabel: UILabel!
    @IBOutlet weak var goodsTypeLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var loadTimeLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var shelveTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension GSTimerShelveCell {
    func contentInfo(info:OderHallBean?) -> Void {
        self.codeLabel.text = Util.concatSeperateStr(seperete: "", strs: "货源编号(" , info?.supplyCode , ")")
        self.goodsStauts(to: self.statusLabel, status: info?.isDeal ?? 0)
        self.startLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.startProvince , info?.startCity , info?.startDistrict)
        self.endLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.endProvince,info?.endCity,info?.endDistrict)
        self.loadTimeLabel.text = Util.dateFormatter(date: (Double(info?.loadingTime ?? "0") ?? 0)/1000, formatter: "MM-dd  HH:mm")
        self.goodsNameLabel.text = info?.goodsName
        self.goodsTypeLabel.text = info?.goodsType
        self.goodsSummerLabel.text = Util.concatSeperateStr(seperete: " | ", strs: (info?.goodsWeight ?? "")+"吨" , info?.vehicleLength , info?.vehicleWidth  ,info?.vehicleType , info?.packageType)
        self.remarkLabel.text = info?.remark ?? " "
        self.priceLabel.text = Util.concatSeperateStr(seperete: "/", strs: String(Float(info?.refercneceUnitPrice ?? 0)) + "元" , "吨")
        self.amountLabel.text = String(Float(info?.refercneceTotalPrice ?? 0)) + "/元"
        self.shelveTimeLabel.text = Util.concatSeperateStr(seperete: "", strs: "定时上架 ", Util.dateFormatter(date: Double(info?.publishTime ?? "0")! / 1000, formatter: "MM-dd HH:mm"))
    }
}
