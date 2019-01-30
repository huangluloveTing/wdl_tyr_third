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
    @IBOutlet weak var codeLabel: UILabel!//货源编码
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var loadManLabel: UILabel!
    @IBOutlet weak var loadAddressLabel: UILabel!
    @IBOutlet weak var reManLabel: UILabel!
    @IBOutlet weak var reAddressLabel: UILabel!
    
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
        self.codeLabel.text = Util.concatSeperateStr(seperete: "", strs: "货源编号(" , info?.supplyCode , ")")
        self.goodsStauts(to: self.statusLabel, status: info?.isDeal ?? 0)
        self.startLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.startProvince , info?.startCity , info?.startDistrict)
        self.endLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.endProvince,info?.endCity,info?.endDistrict)
        self.loadTimeLabel.text = Util.dateFormatter(date: (Double(info?.loadingTime ?? "0") ?? 0) / 1000, formatter: "yyyy-MM-dd")
        self.goodsNameLabel.text = info?.goodsName
        self.goodsTypeLabel.text = info?.goodsType
        self.goodsSummerLabel.text = Util.concatSeperateStr(seperete: " | ", strs: (info?.goodsWeight ?? "") + "吨" , info?.vehicleLength , info?.vehicleWidth  ,info?.vehicleType , info?.packageType)
        
        self.unitLabel.text = Util.showMoney(money: info?.refercneceUnitPrice ?? 0, after: 2) + "元/吨"
        self.totalLabel.text = Util.showMoney(money: info?.refercneceTotalPrice ?? 0, after: 2) + "元"
        self.remarkLabel.text = info?.remark
        self.loadManLabel.text = (info?.loadingPersonName ?? "") + " " +  (info?.loadingPersonPhone ?? "")
        self.loadAddressLabel.text = info?.startAddress
        self.reManLabel.text = (info?.consigneeName ?? "") + " " + (info?.consigneePhone ?? "")
        self.reAddressLabel.text = info?.endAddress
    }
}
