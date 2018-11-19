//
//  WayBillCommentAllCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/18.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillCommentAllCell: BaseCell {
    
    @IBOutlet weak var toOtherRateView: UIView!
    @IBOutlet weak var toMeRateView: UIView!
    @IBOutlet weak var tomeCommentTimeLabel: UILabel!
    @IBOutlet weak var toMeCommentLabel: UILabel!
    @IBOutlet weak var toOtherCommentLabel: UILabel!
    @IBOutlet weak var myCommentTimeLabel: UILabel!
    @IBOutlet weak var myLogicRateView: UIView!
    @IBOutlet weak var toMeLogicRateView: UIView!
    
    private var toMeStarView:XHStarRateView?
    private var myCommentStarView:XHStarRateView?
    private var toMeLogicStarView:XHStarRateView?
    private var myCommentLogicStarView:XHStarRateView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.toMeStarView = XHStarRateView(frame: self.toMeRateView.bounds)
        self.toMeStarView?.onlyShow = true
        self.myCommentStarView = XHStarRateView(frame: (self.toOtherRateView.bounds))
        self.myCommentStarView?.onlyShow = true
        
        self.toMeRateView.addSubview(self.toMeStarView!)
        self.toOtherRateView.addSubview(self.myCommentStarView!)
        
        self.toMeLogicStarView = XHStarRateView(frame: self.toMeLogicRateView.bounds)
        self.toMeLogicStarView?.onlyShow = true
        
        self.myCommentLogicStarView = XHStarRateView(frame: (self.myLogicRateView.bounds))
        self.myCommentLogicStarView?.onlyShow = true
        self.toMeLogicRateView.addSubview(self.toMeLogicStarView!)
        self.myLogicRateView.addSubview(self.myCommentLogicStarView!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension WayBillCommentAllCell {
    
    func showCommentInfo(toMeinfo:WayBillDetailCommentInfo?, myCommentInfo:WayBillDetailCommentInfo?) -> Void {
        self.toMeStarView?.score = toMeinfo?.logic ?? 0
        self.myCommentLogicStarView?.score = CGFloat(toMeinfo?.rate ?? 0)
        self.tomeCommentTimeLabel.text = Util.dateFormatter(date: (toMeinfo?.commentTime ?? 0) / 1000, formatter: "yyyy-MM-dd HH:mm");
        self.toMeCommentLabel.text = toMeinfo?.comment
        
        self.myCommentStarView?.score = myCommentInfo?.logic ?? 0
        self.toMeLogicStarView?.score = CGFloat(myCommentInfo?.rate ?? 0)
        self.myCommentTimeLabel.text = Util.dateFormatter(date: (myCommentInfo?.commentTime ?? 0) / 1000, formatter: "yyyy-MM-dd HH:mm");
        self.toOtherCommentLabel.text = myCommentInfo?.comment
    }
}
