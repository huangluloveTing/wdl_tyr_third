//
//  GSOffShelveCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GSOffShelveCell: BaseCell {
    //该货源已下架顶部标签
    @IBOutlet weak var topTitleLab: UILabel!
    
    @IBOutlet weak var reAddressLabel: UILabel!     // 收货地址
    @IBOutlet weak var reManLabel: UILabel!         // 收货人
    @IBOutlet weak var loadAddressLabel: UILabel!   // 装货地址
    @IBOutlet weak var loadManLabel: UILabel!       // 装货人
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var goodsSummerLabel: UILabel!
    @IBOutlet weak var goodsTypeLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var loadTimeLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var unableLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension GSOffShelveCell {
    func contentInfo(info:OderHallBean?) -> Void {
        let type = WDLCoreManager.shared().consignorType
        //第三方
        if type == .third {
            self.topTitleLab.text = "该货源已下架"
            //状态
            self.goodsStauts(to: self.statusLabel, status: info?.isDeal ?? 0)
        
        }else{
            //经销商
            self.statusLabel.text = "未成交"
            self.topTitleLab.text = "该货源未成交"
        }
        
        
        self.codeLabel.text = Util.concatSeperateStr(seperete: "", strs: "货源编号(" , info?.supplyCode , ")")
        
        self.startLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.startProvince , info?.startCity , info?.startDistrict)
        self.endLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.endProvince,info?.endCity,info?.endDistrict)
        self.loadTimeLabel.text = Util.dateFormatter(date: (Double(info?.loadingTime ?? "0") ?? 0) / 1000, formatter: "yyyy-MM-dd")
        self.goodsNameLabel.text = info?.goodsName
        self.goodsTypeLabel.text = info?.goodsType
        self.goodsSummerLabel.text = Util.concatSeperateStr(seperete: " | ", strs: info?.goodsWeight , info?.vehicleLength , info?.vehicleWidth  ,info?.vehicleType , info?.packageType)
        self.remarkLabel.text = info?.remark ?? " "
        self.unableLabel.text = info?.unableReason
        self.unitLabel.text = String(Float(info?.refercneceUnitPrice ?? 0)) + "元/吨"
        self.totalLabel.text = String(Float(info?.refercneceTotalPrice ?? 0)) + "元"
        self.reManLabel.text = info?.consigneeName
        self.reAddressLabel.text = info?.endAddress
        self.loadManLabel.text = info?.loadingPersonName
        self.loadAddressLabel.text = info?.startAddress
    }
}
