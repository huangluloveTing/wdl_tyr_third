//
//  MyCarrierInfoCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/20.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

enum CarrierInfoStyle {
    case add
    case delete
}

class MyCarrierInfoCell: BaseCell {
    
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var tomeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteAction(_ sender: Any) {
    }
    
}

extension MyCarrierInfoCell {
    func showInfo(avatorImage:String? ,
                  title:String? ,
                  phone:String? ,
                  rate:Float? ,
                  tomeNum:Int? ,
                  total:Int? ,
                  style:CarrierInfoStyle? = .delete) -> Void {
        Util.showImage(imageView: avatorImageView, imageUrl: avatorImage)
        self.titleLabel.text = title
        self.phoneLabel.text = phone
        self.rateLabel.text = Util.showMoney(money: CGFloat(rate ?? 0), after: 1)
        self.tomeLabel.text = String(tomeNum ?? 0)
        self.totalLabel.text = String(total ?? 0)
        showStyle(style: style)
    }
    
    fileprivate func showStyle(style:CarrierInfoStyle?) -> Void {
        switch style ?? .delete {
        case .delete:
            self.editButton.setTitle(" 添加", for: .normal)
            self.editButton.setImage(UIImage.init(named: "add_carrier"), for: .normal)
            break
        default:
            self.editButton.setTitle(" 删除", for: .normal)
            self.editButton.setImage(UIImage.init(named: "delete_icon"), for: .normal)
        }
    }
}
