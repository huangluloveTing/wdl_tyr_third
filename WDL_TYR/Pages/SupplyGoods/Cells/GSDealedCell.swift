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
        self.truckInfoLabel.text = Util.concatSeperateStr(seperete: " | ", strs: info?.vehicleLengthDriver , info?.vehicleTypeDriver , info?.vehicleNo)
        self.dealTimeLabel.text = Util.dateFormatter(date: (Double(info?.dealTime ?? "0") ?? 0) / 1000, formatter: "MM-dd  HH:mm")
        self.cyLabel.text = Util.concatSeperateStr(seperete: " ", strs: offer?.carrierName , "")
        self.driverLabel.text = Util.concatSeperateStr(seperete: " ", strs: offer?.driverName , offer?.driverPhone)
        self.offerTimeLabel.text = Util.dateFormatter(date: (Double(offer?.offerTime ?? "0") ?? 0) / 1000, formatter: "MM-dd  HH:mm")
        self.priceLabel.text = Util.concatSeperateStr(seperete: "/", strs: String(Float(offer?.quotedPrice ?? 0)) , "吨")
        self.amountLabel.text = Util.concatSeperateStr(seperete: "", strs: String(Float(offer?.totalPrice ?? 0)) , "元")
    }
}
