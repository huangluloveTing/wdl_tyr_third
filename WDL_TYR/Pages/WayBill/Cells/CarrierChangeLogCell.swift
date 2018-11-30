//
//  CarrierChangeLogCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class CarrierChangeLogCell: BaseCell {

    @IBOutlet weak var changeTimeLabel: UILabel!
    @IBOutlet weak var carrierNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CarrierChangeLogCell {
    func showCarrierInfo(name:String? , phone:String? , time:TimeInterval?) -> Void {
        self.carrierNameLabel.text = Util.concatSeperateStr(seperete: " ", strs: name , phone)
        self.changeTimeLabel.text = Util.dateFormatter(date: time ?? 0, formatter: "MM-dd HH:mm")
    }
}
