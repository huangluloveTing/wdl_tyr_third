//
//  LocationLineCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class LocationLineCell: BaseCell {
    
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var centerPointView: UIView!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.centerPointView.addBorder(color: nil, width: 0, radius: 2.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension LocationLineCell {
    func showLineInfo(address:String , time:TimeInterval , top:Bool? = false , bottom:Bool? = false) -> Void {
        self.topLineView.isHidden  = false
        self.centerPointView.backgroundColor = UIColor(hex: "DDDDDD")
        self.bottomLineView.isHidden = false
        if top == true {
            self.centerPointView.backgroundColor = UIColor(hex: "15BC83")
            self.topLineView.isHidden  = true
        }
        if bottom == true {
            self.bottomLineView.isHidden  = true
        }
        self.addressLabel.text = address
        self.timeLabel.text = Util.dateFormatter(date: time, formatter: "MM-dd HH:mm")
    }
}
