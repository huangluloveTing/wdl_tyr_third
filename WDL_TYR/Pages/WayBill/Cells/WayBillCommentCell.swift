//
//  WayBillCommentCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/20.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillCommentCell: BaseCell {

    @IBOutlet weak var orderNoLabel: UILabel!
    @IBOutlet weak var offerTimeLabel: UILabel! // 报价时间
    @IBOutlet weak var timeLabel: UILabel! // 成交时间
    @IBOutlet weak var truckInfoLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var cyNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var wayBIllStatusView: UIView!
    
    private var wayBillStatus:WayBillStatusView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wayBillStatus = WayBillStatusView(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH - 80, height: 64))
        self.wayBIllStatusView.addSubview(self.wayBillStatus!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension WayBillCommentCell {
    
    func showDealInfo(unit:CGFloat? ,
                      amount:CGFloat? ,
                      cyName:String? ,
                      driver:String? ,
                      truckInfo:String? ,
                      dealTime:TimeInterval? ,
                      offerTime:TimeInterval? ,
                      orderNo:String?) -> Void {
        self.unitLabel.text = Util.showMoney(money: unit ?? 0, after: 0)+"元/吨"
        self.amountLabel.text = Util.showMoney(money: amount ?? 0, after: 0)+"元"
        self.cyNameLabel.text = cyName
        self.driverNameLabel.text = driver
        self.truckInfoLabel.text = truckInfo

         self.timeLabel.text = Util.dateFormatter(date: (dealTime ?? 0) / 1000, formatter: "MM-dd HH:mm")
         self.offerTimeLabel.text = Util.dateFormatter(date: (offerTime ?? 0) / 1000, formatter: "MM-dd HH:mm")
        self.orderNoLabel.text = Util.concatSeperateStr(seperete: "", strs: "运单号：" , orderNo)
        self.wayBillStatus?.status = .Done

    }
}
