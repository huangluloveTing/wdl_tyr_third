//
//  WaybillProtocolCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/20.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

let WAYBILL_CONFIRM_EVENT = "WAYBILL_CONFIRM_EVENT"
let WAYBILL_CONFIRM_READ = "WAYBILL_CONFIRM_READ"

class WaybillProtocolCell: BaseCell {
    
    typealias WayBillProtocolConfirmClosure = (Bool) -> ()
    typealias WayBillProtocolReadClosure = () -> ()

    @IBOutlet weak var protocolButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    public var confirmClosure:WayBillProtocolConfirmClosure?
    public var readClosure:WayBillProtocolReadClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let colsoure = self.confirmClosure {
            colsoure(sender.isSelected)
        }
    }
    
    @IBAction func readProtocolAction(_ sender: Any) {
        if let closure = self.readClosure {
            closure()
        }
    }
    
    func currentConfirm(confirm:Bool?) -> Void {
        self.confirmButton.isSelected = confirm ?? false
    }
}
