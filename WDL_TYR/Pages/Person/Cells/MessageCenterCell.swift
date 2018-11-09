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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MessageCenterCell {
    func showInfo(icon:UIImage , title:String , content:String?) -> Void {
        self.iconImageView.image = icon
        self.titleLabel.text = title
        self.subTitleLabel.text = content ?? " "
    }
}
