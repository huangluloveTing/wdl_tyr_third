//
//  PersonalExcuteCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/2.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

struct PersonExcuteInfo {
    var image:UIImage?
    var exTitle:String?
    var exSubTitle:String?
    var showIndicator:Bool?
}

class PersonalExcuteCell: BaseCell {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var exTitleLabel: UILabel!
    @IBOutlet weak var indicatorView: UIImageView!
    @IBOutlet weak var exSubTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension PersonalExcuteCell {
    func contentInfo(info:PersonExcuteInfo) -> Void {
        self.headerImageView.image = info.image
        self.exTitleLabel.text = info.exTitle
        self.exSubTitleLabel.text = info.exSubTitle
        self.indicatorView.isHidden = !(info.showIndicator ?? true)
    }
}
