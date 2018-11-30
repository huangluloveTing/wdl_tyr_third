//
//  ConsignorAuthAlertView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class ConsignorAuthAlertView:  UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    typealias AuthClosure = () -> ()
    
    public var authClosure:AuthClosure?
    
    static func authAlertView() -> ConsignorAuthAlertView {
        let authAlert = Bundle.main.loadNibNamed("\(ConsignorAuthAlertView.self)", owner: nil, options: nil)?.first as! ConsignorAuthAlertView
        return authAlert
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addBorder(color: nil, width: 0, radius: 5)
        self.backgroundColor = UIColor(hex: "000000").withAlphaComponent(0.3)
        self.cancelButton.addBorder(color: UIColor(hex: "555555"), width: 0.5, radius: 2)
        self.sureButton.addBorder(color:nil, width: 0.5, radius: 2)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.remove()
    }
    
    @IBAction func sureAction(_ sender: Any) {
        if let closure = self.authClosure {
            closure()
        }
        self.remove()
    }
}

//MARK: - public
extension ConsignorAuthAlertView {
    func showAlert(title:String) -> Void {
        let window = UIApplication.shared.keyWindow!
        self.frame = window.bounds
        self.contentLabel.text = title
        window.addSubview(self)
        self.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.transform  = CGAffineTransform.identity
        })
    }
    
    func remove() -> Void {
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
