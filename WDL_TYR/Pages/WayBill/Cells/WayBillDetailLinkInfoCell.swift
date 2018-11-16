//
//  WayBillDetailLinkInfoCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/1.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class WayBillDetailLinkInfoCell: BaseCell {

    @IBOutlet weak var loadLinkNameLabel: UILabel!
    @IBOutlet weak var loadAddressLabel: UILabel!
    @IBOutlet weak var endNameLabel: UILabel!
    @IBOutlet weak var endAddressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension WayBillDetailLinkInfoCell {
    func showLinkInfo(loadLinkName:String? ,
                      loadAddress:String?,
                      loadProvince:String?,
                      loadCity:String?,
                      loadLinkPhone:String?,
                      endName:String? ,
                      endAddress:String?,
                      endProvince:String?,
                      endCity:String?,
                      endPhone:String?
                      ) -> Void {
//        self.loadAddressLabel.text = Util.concatSeperateStr(seperete: "", strs: loadCity ,loadAddress)
         self.loadAddressLabel.text = Util.concatSeperateStr(seperete: "", strs: loadAddress)
        self.loadLinkNameLabel.text = Util.concatSeperateStr(seperete: "  ", strs: loadLinkName , loadLinkPhone)
        self.endNameLabel.text = Util.concatSeperateStr(seperete: " ", strs: endName , endPhone)
         self.endAddressLabel.text = Util.concatSeperateStr(seperete: "", strs: endAddress)
//        self.endAddressLabel.text = Util.concatSeperateStr(seperete: "", strs: endCity , endAddress)
    }
}
