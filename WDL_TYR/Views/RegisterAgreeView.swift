//
//  RegisterAgreeView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class RegisterAgreeView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    static func showRegisterAgreementView() {
        let agreementView = Bundle.main.loadNibNamed("RegisterAgreeView", owner: nil, options: nil)?.first as? RegisterAgreeView
        agreementView?.backgroundColor = UIColor(hex: "292B2A").withAlphaComponent(0.4)
        agreementView?.contentView.addBorder(color: nil)
        agreementView?.showOnWindow()
    }
    
    
    @IBAction func dismissAction(_ sender: Any) {
        self.hidden()
    }
    
    private func showOnWindow() {
        let window = UIApplication.shared.keyWindow
        self.frame = (window?.bounds)!
        window?.addSubview(self)
    }
    
    private func hidden() {
        self.removeFromSuperview()
    }
}
