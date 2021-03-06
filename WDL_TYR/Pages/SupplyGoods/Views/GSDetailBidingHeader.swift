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
    
    @IBOutlet weak var goodsCodeLabel: UILabel!
    @IBOutlet weak var goodsSummaryTitleLabel: UILabel!
    @IBOutlet weak var goodsSummaryLabel: UILabel!
    @IBOutlet weak var remarkTitleLabel: UILabel!
    @IBOutlet weak var cateTitleLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var goodsCategoryLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var transTimeLabel: UILabel!
    @IBOutlet weak var obtainPlaceLabel: UILabel!
    @IBOutlet weak var sendPlaceLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var minuLabel: UILabel!
    
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
    
    deinit {
        print("header de init")
    }
}

extension GSDetailBidingHeader {
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
    
    func headerContent(item:BidingContentItem?) -> Void {
        if let item = item {
            self.contentItem = item
            self.goodsNameLabel.text = item.goodsName
            self.transTimeLabel.text = Util.dateFormatter(date: Double(item.loadTime ?? "0")! / 1000, formatter: "yyyy-MM-dd")
            self.obtainPlaceLabel.text = item.startPlace
            self.sendPlaceLabel.text = item.endPlace
            self.goodsCodeLabel.text = Util.concatSeperateStr(seperete: "", strs: "货源编号(" , item.supplyCode , ")")
            self.timedown(time: fabs(item.autoDealTime ?? 0))
        }
    }
    
    private func timedown(time:TimeInterval) -> Void {
//        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
////            .takeUntil(self.rx.deallocated)
//            .take(Int(time))
//            .share(replay: 1)
//            .subscribe(onNext: { [weak self](timer) in
//                self?.showCountDownLablel(time: time - Double(timer))
//            })
//            .disposed(by: dispose)
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
