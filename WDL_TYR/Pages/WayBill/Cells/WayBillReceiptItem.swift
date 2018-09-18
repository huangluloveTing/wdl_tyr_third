//
//  WayBillReceiptItem.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/18.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillReceiptItem: UICollectionViewCell {
    
    @IBOutlet weak var receiptImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension WayBillReceiptItem {
    
    func showReceipt(imageUrl:String? , time:TimeInterval?) -> Void {
        Util.showImage(imageView: self.receiptImageView, imageUrl: imageUrl ?? "")
        self.timeLabel.text = Util.dateFormatter(date: time ?? 0, formatter: "yyyy-MM-dd HH:mm")
    }
}
