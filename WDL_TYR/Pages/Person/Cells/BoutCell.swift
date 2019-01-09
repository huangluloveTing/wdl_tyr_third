//
//  BoutCell.swift
//  WDL_CYR
//
//  Created by Apple on 2019/1/9.
//  Copyright © 2019 yinli. All rights reserved.
//

import UIKit

class BoutCell: BaseCell {
    

    @IBOutlet weak var exTitleLabel: UILabel!
   
    @IBOutlet weak var exSubTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
