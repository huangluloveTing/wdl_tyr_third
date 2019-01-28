//
//  GSConfirmDealView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/15.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift

struct GSConfirmAlertItem {
    var name:String?
    var phone:String?
    var unit:CGFloat?
    var total:CGFloat?
    var time:TimeInterval?
    var score:CGFloat?
}

//MARK: 确认成交
class GSConfirmDealView: UIView {
    
    typealias ConfirmDealClosure = (Int) -> ()
    
    @IBOutlet weak var rateView: XHStarRateView!//星星视图
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var sureButton: UIButton!

    private var starView:XHStarRateView! //星星
    private var dispose = DisposeBag()
    
    private var confirm:GSConfirmAlertItem?
    
    public var confirmClosure : ConfirmDealClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "292B2A").withAlphaComponent(0.6)
        self.contentView.addBorder(color: nil, width: 0, radius: 10)
        self.starView = XHStarRateView(frame: self.rateView.bounds)
        self.rateView.addSubview(self.starView)
        self.starView.score = 0
        self.starView.rateStyle = RateStyle.IncompleteStar
        self.starView.onlyShow = true
        
        
        self.cancelButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                if let closure = self.confirmClosure {
                    closure(0)
                }
                self.hidden()
            })
            .disposed(by: dispose)
        
        self.sureButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                if let closure = self.confirmClosure {
                    closure(1)
                }
                self.hidden()
            })
            .disposed(by: dispose)
    }
    
    static func showConfirmDealView(confirm:GSConfirmAlertItem , dealClosure:ConfirmDealClosure?) {
        let confirmView = Bundle.main.loadNibNamed("\(GSConfirmDealView.self)", owner: nil, options: nil)?.first as! GSConfirmDealView
        confirmView.confirm = confirm
        confirmView.confirmClosure = dealClosure
        confirmView.configView()
        confirmView.showOnWindow()
    }
    
    private func configView() {
        if let confirm = self.confirm {
            self.nameLabel.text = confirm.name
            
            self.phoneLabel.text = Util.formatterPhone(phone: confirm.phone ?? "")
            self.unitPriceLabel.text = Util.concatSeperateStr(seperete: "", strs: "单价：" ,String(Float(confirm.unit ?? 0))+"元/" , "吨")
            self.amountLabel.text = Util.concatSeperateStr(seperete: "", strs: "总价：" ,String(Float(confirm.total ?? 0)) + "元") 
//            self.timeLabel.text = Util.dateFormatter(date: confirm.time ?? 0, formatter: "MM-dd HH:mm:ss")
            self.timeLabel.text = Util.dateFormatter(date: (confirm.time ?? 0) / 1000, formatter: "yyyy-MM-dd HH:mm")
            //评分星星
            self.starView.score = CGFloat(confirm.score ?? 0.0)
           
            
            self.scoreLabel.text = Util.showMoney(money: confirm.score ?? 0, after: 2)
        }
    }
    
    private func showOnWindow() {
        let window = UIApplication.shared.keyWindow
        self.frame = (window?.bounds)!
        window?.addSubview(self)
    }
    
    private func hidden() {
        self.removeFromSuperview()
    }
}
