//
//  WayBillToCommentCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/20.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WayBillToCommentCell: BaseCell , XHStarRateViewDelegate {
    
    typealias WaybillCommentClosure = (Float , Float , String?) -> ()
    typealias WaybillTapCommitClosure = () -> ()
    
    let dispose = DisposeBag()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var logicView: UIView!
    @IBOutlet weak var serviceView: UIView!
    
    private var logicScoreView: XHStarRateView!
    private var serviceScoreView: XHStarRateView!
    
    public var commentClosure:WaybillCommentClosure?
    public var commitClosure:WaybillTapCommitClosure?
    
    private var logicScore:Float = 5
    private var serviceScore:Float = 5
    private var currentComment:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.placeholder = "请输入您的文字评价"
        self.textView.placeholdColor = UIColor(hex: TEXTCOLOR_EMPTY)
        self.textView.placeholdFont = UIFont.systemFont(ofSize: 14)
        self.textView.backgroundColor = UIColor(hex: "F6F6F6")
        self.textView.limitLength = 50
        
        self.logicScoreView = XHStarRateView(frame: CGRect(x: 0, y: 0, width: 200, height: 26))
        self.serviceScoreView = XHStarRateView(frame: CGRect(x: 0, y: 0, width: 200, height: 26))
        
        self.logicScoreView.rateStyle =  .WholeStar
        self.logicScoreView.delegate = self
        self.serviceScoreView.rateStyle =  .WholeStar
        self.serviceScoreView.delegate = self
        self.textView.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.currentComment = text
                self?.handleCurrent()
            })
            .disposed(by: dispose)
        self.logicView.addSubview(self.logicScoreView)
        self.serviceView.addSubview(self.serviceScoreView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func toCommentAction(_ sender: Any) {
        if let closure = self.commitClosure {
            closure()
        }
    }
    
    func starRateView(_ starRateView: XHStarRateView!, currentScore: CGFloat) {
        if starRateView == self.logicScoreView {
            self.logicScore = Float(currentScore)
        }
        
        if starRateView == self.serviceScoreView {
            self.serviceScore = Float(currentScore)
        }
        self.handleCurrent()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension WayBillToCommentCell {
    func showInfo(logicScore:Float , serviceScore:Float , comment:String?) -> Void {
        self.logicScoreView.score = CGFloat(logicScore)
        self.serviceScoreView.score = CGFloat(serviceScore)
        self.textView.text = comment
        self.logicScore = logicScore
        self.serviceScore = serviceScore
        self.currentComment = comment
    }
    
    func handleCurrent() -> Void {
        if let closure = self.commentClosure {
            closure(self.logicScore , self.serviceScore , self.currentComment)
        }
    }
}
