//
//  WayBillToCommentCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/20.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillToCommentCell: BaseCell , XHStarRateViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scoreView: XHStarRateView!
    
    private var currentScore:CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.placeholder = "请输入您的文字评价"
        self.textView.placeholdColor = UIColor(hex: TEXTCOLOR_EMPTY)
        self.textView.placeholdFont = UIFont.systemFont(ofSize: 14)
        self.textView.limitLength = 50
        self.scoreView.rateStyle =  .WholeStar
        self.scoreView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func toCommentAction(_ sender: Any) {
    }
    
    func starRateView(_ starRateView: XHStarRateView!, currentScore: CGFloat) {
        self.currentScore = currentScore
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
