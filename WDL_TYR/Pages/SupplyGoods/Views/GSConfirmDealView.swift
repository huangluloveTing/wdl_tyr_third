//
//  GSConfirmDealView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/15.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

//MARK: 确认成交
class GSConfirmDealView: UIView {
    
    typealias ConfirmDealClosure = (Int) -> ()
    
    @IBOutlet weak var rateView: XHStarRateView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    public var confirmClosure : ConfirmDealClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "292B2A").withAlphaComponent(0.6)
        self.contentView.addBorder(color: nil, width: 0, radius: 10)
        self.rateView.onlyShow = true
        self.rateView.score = 5
    }
    
    static func showConfirmDealView() {
        let confirmView = Bundle.main.loadNibNamed("\(GSConfirmDealView.self)", owner: nil, options: nil)?.first as! GSConfirmDealView
        confirmView.showOnWindow()
    }
    
    
    private func showOnWindow() {
        
    }
    
    private func hidden() {
        
    }
}
