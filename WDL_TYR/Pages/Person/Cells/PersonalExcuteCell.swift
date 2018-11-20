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
    
    func showAuthStatus(status:AutherizStatus?) -> Void {
        guard let stat = status  else {
            self.subTitle(title: "", to: self.exSubTitleLabel)
            return
        }
        var title = ""
        switch stat {
        case .not_start:
            title = "未认证"
            break
        case .autherizing:
            title = "认证中"
            break
        case .autherizedFail:
            title = "认证失败"
            break
        case .autherized:
            title = "已认证"
            break
        }
        self.subTitle(title: title, to: self.exSubTitleLabel)
    }
}
