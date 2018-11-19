//
//  WayBillCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/1.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillCell: BaseCell {
    
    @IBOutlet weak var tranportNoLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    //物料和装货时间
    @IBOutlet weak var goodsInfoLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dealTimeLabel: UILabel!
    @IBOutlet weak var cyLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension WayBillCell {
    //运单状态 1=待起运 0=待办单 2=运输中 3=已签收 4=被拒绝 ,
    func contentInfo(info:WayBillInfoBean?) {
            //运单号
        self.tranportNoLabel.text = Util.concatSeperateStr(seperete: "", strs: "运单号：" ,info?.transportNo )
        self.startLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.startProvince , info?.startCity)
        self.endLabel.text = Util.concatSeperateStr(seperete: "", strs: info?.endProvince , info?.endCity)
        self.transportInfoStatusDisplay(status: info?.transportStatus?.rawValue ?? 0, to: self.statusLabel)
       
        self.cyLabel.text = info?.carrierName
        self.dealTimeLabel.text = Util.dateFormatter(date: (info?.dealTime ?? 0) / 1000, formatter: "MM-dd HH:mm:ss")
        self.priceLabel.text = Util.showMoney(money: info?.dealUnitPrice ?? 0, after: 0)
        
        self.phoneLabel.text = info?.cellPhone ?? ""
        //物料和装货时间
        let goodsType = info?.goodsType
        let loadTimeStr = Util.dateFormatter(date: (info?.loadingTime ?? 0) / 1000, formatter: "MM-dd")
        self.goodsInfoLabel.text = loadTimeStr + " " + "装货   " + (goodsType ?? "")
    }
}
