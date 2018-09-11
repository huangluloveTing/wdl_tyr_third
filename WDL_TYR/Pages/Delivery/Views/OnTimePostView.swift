//
//  OnTimePostView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/11.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift

class OnTimePostView: UIView {
    
    static func instance() -> OnTimePostView {
        return Bundle.main.loadNibNamed("XIBViews", owner: nil, options: nil)![1] as! OnTimePostView
    }
    
    let dispose = DisposeBag()
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    typealias TimePostClosure = (TimeInterval? , Bool) -> ()
    
    public var timeClosure : TimePostClosure?
    
    private var chooseTime :TimeInterval?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.timeTextField.becomeFirstResponder()
        self.backgroundColor = UIColor(hex: TEXTFIELD_TEXTCOLOR).withAlphaComponent(0.5)
        self.contentView.addBorder(color: nil)
        self.timeTextField.datePickerInput(mode: .dateAndTime , skip:1)
            .subscribe(onNext: { (time) in
                self.chooseTime = time
            })
            .disposed(by: dispose)
        self.cancelButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self]() in
                if let closure = self?.timeClosure {
                    closure(self?.chooseTime, false)
                }
                self?.hiddenOnWindow()
            })
            .disposed(by: dispose)
        
        self.sureButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self]() in
                if let closure = self?.timeClosure {
                    closure(self?.chooseTime, true)
                }
                self?.hiddenOnWindow()
            })
            .disposed(by: dispose)
    }
    
    
    func showOnWindow() {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        self.frame = (window?.bounds)!
    }
    
    func hiddenOnWindow() {
        self.removeFromSuperview()
    }
}
