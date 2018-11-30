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
    var exSubTitle:String? //右侧文字
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
    func contentInfo(info:PersonExcuteInfo, messageNum: String) -> Void {
        self.headerImageView.image = info.image
        self.exTitleLabel.text = info.exTitle
        self.indicatorView.isHidden = !(info.showIndicator ?? true)
        self.exSubTitleLabel.isHidden = false
        if info.exTitle == "消息中心" {
            self.exSubTitleLabel.text = messageNum  //右侧的文字
            if messageNum != "0" {
                self.exSubTitleLabel.backgroundColor = UIColor.red
                self.exSubTitleLabel.textColor = UIColor.white
                self.exSubTitleLabel.font = UIFont.systemFont(ofSize: 11)
                self.exSubTitleLabel.addBorder(color: nil, radius: 10)
                self.exSubTitleLabel.isHidden = false
            }else {
                self.exSubTitleLabel.isHidden = true
            }

        }

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
