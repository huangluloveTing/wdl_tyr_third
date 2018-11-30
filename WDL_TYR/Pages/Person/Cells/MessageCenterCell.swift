//
//  MessageCenterCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/3.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class MessageCenterCell: BaseCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    //时间
    @IBOutlet weak var dateTimeLab: UILabel!
    //提示红点
    @IBOutlet weak var indicView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.indicView.addBorder(color: nil, radius: 6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MessageCenterCell {
    func showInfo(icon:UIImage , title:String , content:String?, time: TimeInterval?) -> Void {
        self.iconImageView.image = icon
        self.titleLabel.text = title
        self.subTitleLabel.text = content ?? " "
         self.dateTimeLab.text = Util.dateFormatter(date: (time ?? 0 ) / 1000, formatter: "yyyy-MM-dd HH:mm")
    }
}
