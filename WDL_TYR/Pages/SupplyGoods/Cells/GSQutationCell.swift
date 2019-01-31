//
//  GSQutationCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 *详情报价
 */
class GSQutationCell: BaseCell {
    
    let dispose = DisposeBag()
    
    typealias GSQutationDealClosure = (SupplyOfferBean?) -> ()
    
    @IBOutlet weak var nameLabel: UILabel!      // 姓名
    @IBOutlet weak var phoneLabel: UILabel!     // 电话号码
    @IBOutlet weak var sumLabel: UILabel!       // 总价
    @IBOutlet weak var unitLabel: UILabel!      // 单位
    @IBOutlet weak var rateView: UIView!        // 星级
    @IBOutlet weak var rateLabel: UILabel!      // 分数
    @IBOutlet weak var reportLabel: UILabel!    // 报价时间
    @IBOutlet weak var commitButton: UIButton!  // 成交按钮
    
    private var starView:XHStarRateView! //星星
    private var qutationItem:SupplyOfferBean?
    
    public var dealClosure:GSQutationDealClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.starView = XHStarRateView(frame: self.rateView.bounds)
        self.rateView.addSubview(self.starView)
        self.starView.score = 0
        self.starView.rateStyle = RateStyle.IncompleteStar
        self.starView.onlyShow = true
        self.commitButton.addBorder(color: nil, width: 0, radius: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func commitAction(_ sender: Any) {
        print("hahaha")
    }
    
}

extension GSQutationCell {
    //报价信息
    func contentInfo(item:SupplyOfferBean?) -> Void {
        self.qutationItem = item
        if let item = item {
            self.nameLabel.text = item.carrierName
            self.phoneLabel.text = Util.formatterPhone(phone: item.carrierPhone ?? " ")
            self.sumLabel.text = Util.concatSeperateStr(seperete: "", strs: "总价:", Util.showMoney(money: item.totalPrice ?? 0) , "元")
            //评分星星
            self.starView.score = CGFloat(item.carrierScore ?? 0.0)
            self.rateLabel.text = String(format: "%.1f", CGFloat(item.carrierScore ?? 0.0))
            self.unitLabel.text = Util.concatSeperateStr(seperete: "/", strs: Util.showMoney(money: item.quotedPrice ?? 0 , after: 2)+"元" , "吨")
            self.reportLabel.text = "报价时间:" + Util.dateFormatter(date: Double(item.offerTime ?? "0")! / 1000, formatter: "yyyy-MM-dd HH:mm:ss")
        }
    }
    
    
}

