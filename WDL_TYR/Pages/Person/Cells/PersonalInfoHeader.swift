//
//  PersonalInfoHeader.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/2.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class PersonalInfoHeader: BaseCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension PersonalInfoHeader {
    func showInfo(name:String? , phone:String? , logo:String?) -> Void {
        self.companyNameLabel.text = name ?? " "
        self.linkLabel.text = phone ?? " "
        Util.showImage(imageView: self.logoImageView, imageUrl: logo ?? "")
    }
}

