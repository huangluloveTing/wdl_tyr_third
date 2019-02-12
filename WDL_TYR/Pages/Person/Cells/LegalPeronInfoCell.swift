//
//  LegalPeronInfoCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/2.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class LegalPeronInfoCell: BaseCell {
    
    @IBOutlet weak var legalNameLabel: UILabel!
    @IBOutlet weak var legalIDCardNoLabel: UILabel!
    @IBOutlet weak var idCardMainImageView: UIImageView!
    @IBOutlet weak var idCardOppositeImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension LegalPeronInfoCell {
    func showLegalPersonInfo(legalName:String? ,
                             id:String? ,
                             idMainImage:String? ,
                             idOppositeImage:String?) -> Void {
        self.legalNameLabel.text = legalName
        self.legalIDCardNoLabel.text = id
        Util.showImage(imageView: self.idCardMainImageView, imageUrl: idMainImage ,placeholder: (UIImage.init(named: "我的认证-身份证"))!)
        Util.showImage(imageView: self.idCardOppositeImageVIew, imageUrl: idOppositeImage ,placeholder: (UIImage.init(named: "我的认证-身份证人像页"))!)
    }
}
