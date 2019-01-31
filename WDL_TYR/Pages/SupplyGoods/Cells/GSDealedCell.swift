//
//  GSDealedCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GSDealedCell: BaseCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dealTimeLabel: UILabel!
    @IBOutlet weak var offerTimeLabel: UILabel!
    @IBOutlet weak var truckInfoLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var cyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension GSDealedCell {
    func contentInfo(info:OderHallBean? , offer:SupplyOfferBean?) -> Void {
        self.truckInfoLabel.text = Util.concatSeperateStr(seperete: " | ", strs:info?.vehicleLengthDriver ?? "", info?.vehicleTypeDriver , info?.vehicleNo)
        self.dealTimeLabel.text = Util.dateFormatter(date: (Double(info?.dealTime ?? "0") ?? 0) / 1000, formatter: "yyyy-MM-dd  HH:mm")
//        self.cyLabel.text = Util.concatSeperateStr(seperete: " ", strs: offer?.carrierName , offer?.carrierPhone)
//        self.driverLabel.text = Util.concatSeperateStr(seperete: " ", strs: offer?.driverName , offer?.driverPhone)
        
        self.cyLabel.text = Util.concatSeperateStr(seperete: " ", strs: info?.carrierName , info?.cellPhone)
        self.driverLabel.text = Util.concatSeperateStr(seperete: " ", strs: info?.driverName , info?.driverPhone)
        
        
        self.offerTimeLabel.text = Util.dateFormatter(date: (info?.dealOfferTime ?? 0) / 1000, formatter: "yyyy-MM-dd  HH:mm")//报价时间
        self.priceLabel.text = Util.concatSeperateStr(seperete: "/", strs: String(Float(info?.dealUnitPrice ?? 0)) , "吨")//单价
        self.amountLabel.text = Util.concatSeperateStr(seperete: "", strs: String(Float(info?.dealTotalPrice ?? 0)) , "元")//总价
    }
}
