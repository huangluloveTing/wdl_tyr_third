//
//  DeliveryPlaceChooiceView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift

class DeliveryPlaceChooiceView: UIView {
    
    typealias InputSureClosure = () -> ()

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    private weak var targetTextField:UITextField?
    
    public var closure: InputSureClosure?
    
    private var contentInputView:UIView?
    
    func insertContentView(inputView:UIView , targetTextField:UITextField) {
        self.contentInputView = inputView
        self.targetTextField = targetTextField
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let _ = self.cancelButton.rx.tap.asObservable()
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { () in
                self.resignTextFieldResponser()
            })
        
        let _ = self.sureButton.rx.tap.asObservable()
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { () in
                if let closure = self.closure {
                    closure()
                }
                self.resignTextFieldResponser()
            })
    }
    
    func resignTextFieldResponser() {
        if let target = self.targetTextField {
            target.resignFirstResponder()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentInputView?.frame = self.contentView.bounds
        self.contentView.addSubview(self.contentInputView!)
    }
}
