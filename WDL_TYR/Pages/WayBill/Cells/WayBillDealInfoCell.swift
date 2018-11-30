//
//  WayBillDealInfoCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/17.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillDealInfoCell: BaseCell {
    
    typealias WaybillHandleClosure = () -> ()
    
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var cyNameLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var truckInfoLabel: UILabel!
    @IBOutlet weak var dealTimeLabel: UILabel!
    @IBOutlet weak var changeCarrierButton: UIButton!
    
    public var changeClosure:WaybillHandleClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func changeHandle(_ sender: Any) {
        if let closure = changeClosure {
            closure()
        }
    }
}

extension WayBillDealInfoCell {
    
    func showDealInfo(unit:CGFloat? ,
                      amount:CGFloat? ,
                      cyName:String? ,
                      cyPhone:String?,
                      driverPhone:String?,
                      driver:String? ,
                      truckInfo:String? ,
                      dealTime:TimeInterval?,
                      showChange:Bool? = false) -> Void {
        self.unitLabel.text = Util.showMoney(money: unit ?? 0, after: 0)+"元/吨"
        self.amountLabel.text = Util.showMoney(money: amount ?? 0, after: 0)+"元"
        self.cyNameLabel.text = (cyName ?? "") + " " + (cyPhone ?? "")
        self.driverLabel.text = (driver ?? "") + " " + (driverPhone ?? "")
        self.truckInfoLabel.text = truckInfo
        self.dealTimeLabel.text = Util.dateFormatter(date: dealTime ?? 0, formatter: "MM-dd HH:mm")
//        self.changeCarrierButton.isHidden = !(showChange ?? false)
    }
}
