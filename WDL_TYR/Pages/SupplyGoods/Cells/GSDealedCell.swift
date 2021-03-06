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
        if let info = info {
            self.priceLabel.text = Util.concatSeperateStr(seperete: "/", strs: String(Float(info.dealUnitPrice ?? 0)) , "吨")
            self.amountLabel.text = Util.concatSeperateStr(seperete: "", strs: String(Float(info.dealTotalPrice ?? 0)) , "元")
            self.truckInfoLabel.text = Util.concatSeperateStr(seperete: " | ", strs: info.vehicleWidth , info.vehicleLength , info.vehicleType)
            self.offerTimeLabel.text = Util.dateFormatter(date: Double(info.publishTime ?? "0")!, formatter: "MM-dd  HH:mm")
            self.dealTimeLabel.text = Util.dateFormatter(date: Double(info.dealTime ?? "0")!, formatter: "MM-dd  HH:mm")
        }
        if let offer = offer {
            self.cyLabel.text = Util.concatSeperateStr(seperete: " ", strs: offer.carrierName , "")
            self.driverLabel.text = Util.concatSeperateStr(seperete: " ", strs: offer.driverName , offer.driverPhone)
        }
    }
}
