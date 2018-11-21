//
//  MessageDetailCell.swift
//  WDL_TYR
//
//  Created by Apple on 2018/11/21.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class MessageDetailCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var detailInfoLab: UILabel!
    
    @IBOutlet weak var dateLab: UILabel!
    
    @IBOutlet weak var rightBtn: UIButton!
    
    //货源或运单id
    var hallId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK:按钮
    @IBAction func buttonClick(_ sender: UIButton) {
        if sender.titleLabel?.text == "查看货源" {
            //跳转货源详情
        }
        else if sender.titleLabel?.text == "查看运单" {
            //跳转运单详情
//            let wayBillDetail = WayBillDetailVC()
//            wayBillDetail.wayBillInfo?.id = self.hallId
//            push(vc: wayBillDetail, title: "运单详情")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MessageDetailCell {
    func showDetalMessageInfo(title:String, content:String?, time: TimeInterval?, buttonTitle: String, hallId: String) -> Void {
        self.titleLab.text = title
        self.detailInfoLab.text = content ?? " "
        self.dateLab.text = Util.dateFormatter(date: (time ?? 0 ) / 1000, formatter: "yyyy-MM-dd HH:mm")
        self.rightBtn.setTitle(buttonTitle, for: UIControlState.normal)
        self.hallId = hallId
    }
}
