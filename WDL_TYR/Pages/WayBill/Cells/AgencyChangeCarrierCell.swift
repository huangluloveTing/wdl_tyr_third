//
//  AgencyChangeCarrierCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class AgencyChangeCarrierCell: BaseCell {
    
    typealias WaybillHandleClosure = () -> ()

    @IBOutlet weak var carrierNameLabel: UILabel!
    @IBOutlet weak var dealTimeLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    public var changeClosure:WaybillHandleClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func changeCarrierAction(_ sender: Any) {
        if let closure = self.changeClosure {
            closure()
        }
    }
}


extension AgencyChangeCarrierCell {
    func showCarrierInfo(name:String? , phone:String? , time:TimeInterval? ,canChange:Bool = true) -> Void {
        self.carrierNameLabel.text = Util.concatSeperateStr(seperete: " ", strs: name , phone)
        self.dealTimeLabel.text = (time == nil || (time ?? 0 <= 0)) ? "" : Util.dateFormatter(date: (time ?? 0)/1000 , formatter: "yyyy-MM-dd HH:mm")
        self.changeButton.isHidden = !canChange
    }
}
