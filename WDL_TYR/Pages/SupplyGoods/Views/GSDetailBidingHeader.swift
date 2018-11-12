//
//  GoodsSupplyDetailHeader.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/28.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum GSTapActionState {
    case GSTapExpand(Bool)
    case GSTapOffShelve
}

struct BidingContentItem {
    var autoDealTime:TimeInterval? // 自动成交时间
    var supplyCode:String?  //货源编码
    var startPlace:String?  //发货地
    var endPlace:String?    //收货地
    var loadTime:String?    //装货时间
    var goodsName:String?   //货品名称
    var goodsType:String?   //货品分类
    var goodsSummer:String? // 货品简介
    var remark:String?      //备注
}

class GSDetailBidingHeader: UIView {
    
    private var dispose = DisposeBag()
    typealias BidingTapClosure = (GSTapActionState) -> ()
    public var bidingTapClosure:BidingTapClosure?
    private var timeObservable:Observable<Int>?
    
    private var timeViewHeight:Float = 0
    
    @IBOutlet weak var goodsCodeLabel: UILabel!
    @IBOutlet weak var goodsSummaryTitleLabel: UILabel!
    @IBOutlet weak var goodsSummaryLabel: UILabel!
    @IBOutlet weak var remarkTitleLabel: UILabel!
    @IBOutlet weak var cateTitleLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var goodsCategoryLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var transTimeLabel: UILabel!
    //收货地
    @IBOutlet weak var obtainPlaceLabel: UILabel!
    //发货地
    @IBOutlet weak var sendPlaceLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var minuLabel: UILabel!
    @IBOutlet weak var timeDownView: UIView!
    
    
    private var downTime : TimeInterval = 0
    private var contentItem:BidingContentItem?
    private var timer : Timer?

    @IBAction func offShelveAction(_ sender: Any) {
        if let closure = self.bidingTapClosure {
            closure(.GSTapOffShelve)
        }
    }
    
    @IBAction func enpandAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.foldHeader(isFolder: sender.isSelected)
        if let closure = self.bidingTapClosure {
            closure(.GSTapExpand(sender.isSelected))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timeViewHeight = Float(timeDownView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)
    }
    
    deinit {
        print("header de init")
    }
}

extension GSDetailBidingHeader {
    
    func showTimeDown(show:Bool) -> Void {
        if show == false {
            self.timeDownView.isHidden = true
            self.timeDownView.hiddenByUpdateHeight()
        }
        else {
            self.timeDownView.isHidden = false
            self.timeDownView.updateHeight(height: CGFloat(self.timeViewHeight))
        }
//        if show == false {
//            self.timeDownView.removeFromSuperview()
//         }
    }
    
    // 折叠
    func foldHeader(isFolder:Bool) {
        if isFolder == false {
            self.goodsSummaryTitleLabel.text = nil
            self.goodsSummaryLabel.text = nil
            self.cateTitleLabel.text = nil
            self.goodsCategoryLabel.text = nil
            self.remarkLabel.text = nil
            self.remarkTitleLabel.text = nil
            self.goodsSummaryTitleLabel.hiddenByUpdateHeight()
            self.cateTitleLabel.hiddenByUpdateHeight()
        }
        else {
            self.goodsSummaryTitleLabel.text = "货品简介："
            self.goodsSummaryLabel.text = self.contentItem?.goodsSummer
            self.cateTitleLabel.text = "货品分类："
            self.goodsCategoryLabel.text = self.contentItem?.goodsType
            self.remarkLabel.text = self.contentItem?.remark
            self.remarkTitleLabel.text = "备      注："
            self.cateTitleLabel.isHidden = false
            self.goodsSummaryTitleLabel.isHidden = false
            let _ = self.goodsSummaryTitleLabel.updateHeight(height: 25)
            let _ = self.cateTitleLabel.updateHeight(height: 25)
        }
    }
    //MARK:头部试图界面赋值
    func headerContent(item:BidingContentItem?) -> Void {
        if let item = item {
            self.contentItem = item
            self.goodsNameLabel.text = item.goodsName
            self.transTimeLabel.text = Util.dateFormatter(date: Double(item.loadTime ?? "0")! / 1000, formatter: "yyyy-MM-dd")
           
            self.obtainPlaceLabel.text = item.endPlace
            self.sendPlaceLabel.text = item.startPlace
            self.goodsCodeLabel.text = Util.concatSeperateStr(seperete: "", strs: "货源编号(" , item.supplyCode , ")")
            self.timedown(time: fabs(item.autoDealTime ?? 0))
        }
    }
    
    private func timedown(time:TimeInterval) -> Void {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
        self.downTime = time
        if #available(iOS 10.0, *) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](mtime) in
                self?.showCountDownLablel(mtime: 0)
            })
        } else {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
        }
    }
    
   @objc private func timerCountDown() -> Void {
        self.showCountDownLablel(mtime: 0)
    }
    
    private func showCountDownLablel(mtime:TimeInterval) -> Void {
        if self.downTime == 0 {
            return;
        }
        self.downTime = self.downTime - 1;
        let time = self.downTime
        let hour = Int(time / 3600)
        let minu = Int((time - Double(hour * 3600)) / 60)
        let second = Int(time - Double(hour * 3600) - Double(minu * 60))
        self.hourLabel.text = String(format: "%d", hour)
        self.secLabel.text = String(format: "%02d", minu)
        self.minuLabel.text = String(format: "%02d", second)
    }
}
