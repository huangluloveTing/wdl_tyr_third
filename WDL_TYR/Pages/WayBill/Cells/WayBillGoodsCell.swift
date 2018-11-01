//
//  WayBillGoodsCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/17.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillGoodsCell: BaseCell {
    
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
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

extension WayBillGoodsCell {
    
    func contentInfo(info:WayBillInfoBean?) -> Void {
        self.remarkLabel.text = info?.remark ?? " "
        self.unitLabel.text = Util.concatSeperateStr(seperete: "/", strs: String(Float(info?.refercneceUnitPrice ?? 0)) , "吨")
        self.totalLabel.text = Util.concatSeperateStr(seperete: "", strs: String(Float(info?.refercneceTotalPrice ?? 0)) , "元")
        self.goodsSummerLabel.text = Util.concatSeperateStr(seperete: " | ", strs: Util.concatSeperateStr(seperete: "", strs: info?.goodsWeight ?? "" + "吨") , info?.vehicleLength , info?.vehicleType , info?.packageType)
        self.goodsTypeLabel.text = info?.goodsType
        self.goodsNameLabel.text = info?.goodsName
        self.loadTimeLabel.text = Util.dateFormatter(date: (info?.loadingTime ?? 0) / 1000, formatter: "yyyy-MM-dd")
        self.endLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.endProvince,info?.endCity,info?.endDistrict)
        self.startLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.startProvince , info?.startCity , info?.startDistrict)
        self.codeLabel.text = Util.concatSeperateStr(seperete: "", strs: "货源编码(" , info?.supplyCode , ")")
    }
}
