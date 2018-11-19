//
//  WayBillOneCommentCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/18.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillOneCommentCell: BaseCell {

    @IBOutlet weak var firstContentLabel: UILabel!
    @IBOutlet weak var commentTypeLabel: UILabel!
    @IBOutlet weak var commentTimeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var serviceRateView: UIView!
    
    private var scoreView:XHStarRateView?
    private var serviceScoreView:XHStarRateView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scoreView = XHStarRateView(frame: self.rateView.bounds)
        self.scoreView?.onlyShow = true
        self.rateView.addSubview(self.scoreView!)
        
        self.serviceScoreView = XHStarRateView(frame: self.serviceRateView.bounds)
        self.serviceScoreView?.onlyShow = true
        self.serviceRateView.addSubview(self.serviceScoreView!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension WayBillOneCommentCell {
    
    // toMe : 是否是对我的评价
    func showComment(info:WayBillDetailCommentInfo , toMe:Bool? = false) -> Void {
        self.commentTimeLabel.text = Util.dateFormatter(date: (info.commentTime ?? 0) / 1000, formatter: "yyyy-MM-dd HH:mm")
        self.commentLabel.text = info.comment
        self.scoreView?.score = info.logic ?? 0
        
        self.serviceScoreView?.score = info.rate ?? 0
        if toMe == true {
            self.commentTypeLabel.text = "对我的评价"
            self.firstContentLabel.text = "等待我的评价"
        } else {
            self.commentTypeLabel.text = "我的评价"
            self.firstContentLabel.text = "等待对方评价"
        }
    }
}
