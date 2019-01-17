//
//  GoodsInBidingHeader.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/15.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GoodsInBidingHeader: UIView {
    
    typealias GoodsTapOrderClosure = (Bool? , Bool?, UIButton?) -> ()

    @IBOutlet weak var timeButton: MyButton!
    @IBOutlet weak var offerButton: MyButton!
    
    public var tapClosure:GoodsTapOrderClosure?
    private var offerAsc:Bool?  // 报价金额是否是升序
    private var timeAsc:Bool?   // 报价时间是否是升序
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func offerTapAction(_ sender: MyButton) {
        sender.isSelected = !sender.isSelected
        sender.tag = 154 //报价金额按钮
        self.offerAsc = sender.isSelected
        self.handleClosure(sender: sender)
    }
    @IBAction func timeTapAction(_ sender: MyButton) {
        sender.isSelected = !sender.isSelected
        sender.tag = 155//报价时间按钮
        self.timeAsc = sender.isSelected
        self.handleClosure(sender: sender)
    }
    
    
    func handleClosure(sender: UIButton?) {
        if let closure = self.tapClosure {
            closure(self.offerAsc  , self.timeAsc, sender)
        }
    }
}

extension GoodsInBidingHeader {
    
    func showStatus(offerSelected:Bool , timeSelected:Bool) -> Void {
        self.offerAsc = offerSelected
        self.timeAsc = timeSelected
        self.offerButton.isSelected = offerSelected
        self.timeButton.isSelected = timeSelected
    }
}
