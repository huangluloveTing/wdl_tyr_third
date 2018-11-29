//
//  SearchCarrierCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/29.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class SearchCarrierCell: BaseCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectButton.isSelected = selected
    }
    
}

extension SearchCarrierCell {
    func showInfo(name:String? , phone:String?) -> Void {
        self.nameLabel.text = name
        self.phoneLabel.text = phone
    }
}
