
//
//  EnterpriseInfoCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/2.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class EnterpriseInfoCell: BaseCell {
    
    @IBOutlet weak var enterNameLabel: UILabel!
    @IBOutlet weak var enterIntroLabel: UILabel!
    @IBOutlet weak var linkNameLabel: UILabel!
    @IBOutlet weak var linkAddressLabel: UILabel!
    @IBOutlet weak var lienseceCodeLabel: UILabel!
    @IBOutlet weak var licenseImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension EnterpriseInfoCell {
    
    func showEnterpriceInfo(name:String? ,
                            intro:String? ,
                            linkName:String? ,
                            address:String? ,
                            lienceCode:String? ,
                            lienceImage:String?) -> Void {
        self.enterNameLabel.text = name
        self.enterIntroLabel.text = intro
        self.linkNameLabel.text = linkName
        self.linkAddressLabel.text = address
        self.lienseceCodeLabel.text = lienceCode
        Util.showImage(imageView: self.licenseImageView, imageUrl: lienceImage ,placeholder: (UIImage.init(named: "认证-营业执照"))!)
    }
}
