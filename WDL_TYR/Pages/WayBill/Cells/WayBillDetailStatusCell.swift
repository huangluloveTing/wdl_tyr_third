//
//  WayBillDetailStatusCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/1.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillDetailStatusCell: BaseCell {
    
    private var wayBillStatusView:WayBillStatusView?

    @IBOutlet weak var wayBillNoLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wayBillStatusView = WayBillStatusView(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH - 80, height: 64))
        self.statusView.addSubview(self.wayBillStatusView!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension WayBillDetailStatusCell {
    
    func showInfo(status:WayBillTransportStatus , transportNo:String?) -> Void {
        self.wayBillNoLabel.text = transportNo
        switch status {
        case .willToTransport , .noStart:
            self.wayBillStatusView?.status = WayBillStatus.Start
            break
        case .transporting:
            self.wayBillStatusView?.status = WayBillStatus.Transporting
            break
        case .willToPickup:
            self.wayBillStatusView?.status = WayBillStatus.ToReceive
            break
        case .done:
            self.wayBillStatusView?.status = WayBillStatus.Done
            break
        }
    }
}
