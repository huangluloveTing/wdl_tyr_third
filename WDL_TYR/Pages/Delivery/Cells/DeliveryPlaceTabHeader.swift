//
//  DeliveryPlaceTabHeader.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class DeliveryPlaceTabHeader: UICollectionReusableView {
    
    @IBOutlet weak var provinceTab: UIButton!
    
    @IBOutlet weak var cityTab: UIButton!
    
    @IBOutlet weak var strictTab: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configTab(button: self.provinceTab)
        self.configTab(button: self.cityTab)
        self.configTab(button: self.strictTab)
    }
    
    
    func configTab(button:UIButton) {
        let size = CGSize(width: IPHONE_WIDTH - CGFloat(12 * 2 - 20 * 2), height: 50)
        button.setBackgroundImage(UIColor.white.captureImage(size: size), for: .normal)
        button.setBackgroundImage(UIColor(hex: COLOR_BUTTON).captureImage(size:size ), for: .selected)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor(hex: "666666"), for: .normal)
    }
    
}
