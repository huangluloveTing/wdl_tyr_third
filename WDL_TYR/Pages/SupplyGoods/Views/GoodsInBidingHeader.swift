//
//  GoodsInBidingHeader.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/15.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GoodsInBidingHeader: UIView {
    
    typealias GoodsTapOrderClosure = (Bool? , Bool?) -> ()

    @IBOutlet weak var timeButton: MyButton!
    @IBOutlet weak var offerButton: MyButton!
    
    public var tapClosure:GoodsTapOrderClosure?
    private var offerAsc:Bool?  // 报价金额是否是升序
    private var timeAsc:Bool? // 报价时间是否是升序
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func offerTapAction(_ sender: MyButton) {
        sender.isSelected = !sender.isSelected
        self.offerAsc = !sender.isSelected
    }
    @IBAction func timeTapAction(_ sender: MyButton) {
        sender.isSelected = !sender.isSelected
        self.timeAsc = !sender.isSelected
    }
    
    
    func handleClosure() {
        if let closure = self.tapClosure {
            closure(self.offerAsc!  , self.timeAsc!)
        }
    }
    
}
